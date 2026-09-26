"""Patch entry points while retaining the game's original Lua closures."""
import struct

OVERRIDES = {
    'Logic/Account': '''
function class:CheckUser()
  self.userId = self.account or _G.__LocalServer.ACCOUNT
  self.sign = "localsign"
  self.time = os.time()
  self.bVisitor = false
  self:LoginFinish(self.userId)
end
function class:inquireServerInfo() end
function class:HasFreshTicketForServer() return true end
''',
    'Logic/Login': '''
function class:Login()
  self:EventTracer():Cancel("CHECK_VERSION")
  -- A clean install has no previously selected server in the preferences.
  -- Set the native TCP endpoint at the last possible point before the first
  -- CHECK_ACCOUNT request so NetMgr.Connect always receives a numeric port.
  Singleton(NetMgr):SetUrlAndPort("127.0.0.1", 9001)
  self:OnDescription(0)
end
''',
    'Logic/EnvLogic': '''
local function offlineLogin(self)
  local server = _G.__LocalServer
  if not server.loginScheduled then
    server.loginScheduled = true
    Singleton(Timer):After(800, self:Event("ENVLOGIN_LOCAL", function() server.autoLogin() end))
  end
end
class.Login = offlineLogin
class.Regist = offlineLogin
class.AnonymityLogin = offlineLogin
function class:LoginComplete() end
''',
    'Logic/Friend': '''
function class:IsNeedGetNewCommendFriend() return false end
''',
    'Module/Guide/FightDrawGift': '''
function trigger:check()
  -- The stock module relies on the CN02BN04 arena-introduction scene to set
  -- fightDraw temporarily.  On a fast local login that scene has never run,
  -- so nil was mistaken for "ready" immediately after CN01BN02 and the guide
  -- covered the battle-result screen.  The shipped Guide record already names
  -- the authoritative progression gate; honour it before the original flag.
  if not Logic:Get("Battle"):IsBattleFinish(self.data.battle) then
    return false
  end
  if Logic:Get("Fight"):isGuideFightDraw() then
    return false
  end
  return true
end
''',
    'Module/Guide/DrawGift': '''
local originalIsDone = trigger.isDone
function trigger:isDone()
  local done = originalIsDone(self)
  local gift = Logic:Get("Gift")
  local count = 0
  for _ in pairs(gift.users or {}) do count = count + 1 end
  log4misc:warn("[GUIDE] DrawGift done=" .. tostring(done) ..
    " users=" .. tostring(count) ..
    " drawable=" .. tostring(gift:IsDrawable("HERO", self.data.material)))
  return done
end
''',
    'Logic/Guide': '''
function class:setup()
  self:save(self:getAllModules())
  self:reload()
  -- The local TCP reply can finish the complete login sequence before the
  -- create-role callback returns. Run the first check after Normal/Main has
  -- installed its Guide event listeners.
  Singleton(Timer):After(2500, self:Event("OFFLINE_GUIDE_CHECK", function()
    self:check()
  end))
end
function class:getAllModules()
  -- The release bytecode no longer contains the original module list. Guide
  -- checks are strictly sequential, so the list must follow campaign
  -- progression; an alphabetical list blocks FirstBattle behind chapter 7.
  return {
    "FirstBattle", "DrawGift", "EvolutionPrepare", "Evolution", "LevelUp",
    "EvolutionBattle", "LevelUpBattle", "FightDrawGift",
    "FightDrawGiftLevelUp", "FightEvolution", "FightLevelUp", "FightPVP",
    "FightBattle", "Lottery", "Team", "LotteryBattle", "LotteryEvo",
    "Partner", "Devil", "Achievement", "AchievementBattle", "EquipElite",
    "EquipEquip", "EquipFetterOne", "EquipFetterTwo", "EquipLottery",
    "Activity", "Reinforc", "SkillUpgrade", "Treasure", "TreasureDraw"
  }
end
''',
    'Logic/GroupPurchase': '''
function class:isGroupPurchardOpen(activityInfo)
  return true
end
''',
    'Logic/Battle': '''
local originalOnExit = class.OnExit
function class:OnExit(code, data)
  originalOnExit(self, code, data)
  if code == 0 and self.current and self.current.battleId == "CN01BN01" then
    -- A live server announces newly unlocked gifts after the first clear.
    -- Refresh the original Gift logic before FirstBattle releases its guide.
    Logic:Get("Gift"):PostAllGift()
  end
end
function class:OnMultiAction(code, data)
  -- MULTI_ACTION 回 array<TriggerVo>；取第一波的成功标记，否则 data.success 是 nil 导致不推进下一关
  local trigger = type(data) == "table" and data[1]
  if Logic:Get("MsgAssist"):OnMsgResult("MsgBattle", code) then
    return
  end
  self:DeleteCommendFriend()
  self.current = self.current or {}
  self.current.success = trigger and trigger.success
  Logic:Get("BattleShow"):CleanUp()
  local logic = Logic:Get("BattleShow")
  logic:DeleteReport()
  logic:SaveReport(data)
  Logic:Get("Hero"):setEmbattleArry()
  logic:StartByStoredReport()
end
function class:BattleFinished(success)
  self.current = self.current or {}
  if success ~= nil then self.current.success = success end
  local battleId = self.current.battleId
  if battleId == nil then return end
  self.lastBattleCampInfo = {
    battleId = battleId,
    success = self.current.success,
    bBattleFinish = false,
    bCampFinish = false,
  }
  if self.current.success then
    pcall(function() self:AddDailyCounts(battleId) end)
    local ok, battleFinish, campFinish = pcall(function()
      return self:OpenNewBattle(battleId)
    end)
    if ok then
      self.lastBattleCampInfo.bBattleFinish = battleFinish or false
      self.lastBattleCampInfo.bCampFinish = campFinish or false
    end
  end
  -- BATTLE_FINISHED has only BattleShow as a listener in 1.0.8.0.  Calling
  -- it directly avoids the release build's broken Synchroniser callback and
  -- still follows the stock result-screen/EXIT flow.
  Logic:Get("BattleShow"):OnBattleFinished()
end
''',
}


def apply(patches, data, keys):
    count, end = struct.unpack_from('<II', data, 4)
    entries = {k: data[offset:offset + size] for k, offset, size, _ in
               (struct.unpack_from('<IIII', data, end + i * 16) for i in range(count))}
    for name, code in OVERRIDES.items():
        literal = ''.join('\\%03d' % byte for byte in entries[keys[name]])
        patches[name] = ('assert(loadstring("' + literal + '"))(... )\n'
                         'module((...), package.seeall)\n' + code)
    # These original modules need no offline changes; their closures must survive.
    # StrictCheck remains as the small text patch from 18_build_offline.py.
    # Its warnings call the crash reporter while Logic.Login is still loading,
    # causing a recursive require and aborting startup.  Disabling only those
    # diagnostics does not alter game state or user-visible behavior.
    for name in ('Logic/BattleShow', 'Logic/AutoPatch'):
        patches.pop(name, None)
