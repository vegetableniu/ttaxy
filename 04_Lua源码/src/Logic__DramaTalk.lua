module((...), package.seeall)
class = Logic.class:subclass()
require("Logic.BattleShow")
require("Logic.Battle")
local BattleShow = Logic.BattleShow
local Battle = Logic.Battle
local bBattleOnlyIsNew = true
DRAMA_TYPE = {BATTLE = "BATTLE", GUIDE = "GUIDE"}
DRAMA_BATTLE_PROGRESS = {
  SELECT = "SELECT",
  ENTER = "ENTER",
  FINISH = "FINISH"
}
function class:initialize()
  super.initialize(self)
  Logic:Get("BattleShow"):On(BattleShow.EVT.FIGHT_BEFORE, self:Event("OnBattleFightBefore"))
  Logic:Get("BattleShow"):On(BattleShow.EVT.BATTLE_END, self:Event("OnBattleFightEnd"))
  Logic:Get("Battle"):On(Battle.EVT.SELECT_ONE_BATTLE, self:Event("OnSelectOneBattle"))
end
function class:dispose()
  super.dispose(self)
end
function class:OnEnterWorld()
end
function class:OnGuideTrigger(idDrama, continueFun, cover)
  local function Continue()
    if continueFun ~= nil then
      continueFun()
    end
  end
  if nil == idDrama then
    Continue()
    return
  end
  local info = {
    id = idDrama,
    type = DRAMA_TYPE.GUIDE
  }
  self:Trigger(info, continueFun, cover)
end
function class:OnSelectOneBattle(idBattle, continueFun)
  local function Continue()
    if continueFun ~= nil then
      continueFun()
    end
  end
  if bBattleOnlyIsNew and Logic:Get("Battle"):IsBattleFinish(idBattle) then
    Continue()
    return
  end
  if nil == idBattle then
    Continue()
    return
  end
  local info = {
    id = idBattle,
    type = DRAMA_TYPE.BATTLE,
    process = DRAMA_BATTLE_PROGRESS.SELECT
  }
  self:Trigger(info, continueFun)
end
function class:OnBattleFightBefore(continueFun)
  if not Logic:Get("BattleShow"):IsEnterBattle() then
    return
  end
  local function Continue()
    if continueFun ~= nil then
      continueFun()
    end
  end
  local idBattle = Logic:Get("Battle"):GetBattleId()
  if nil == idBattle then
    Continue()
    return
  end
  if bBattleOnlyIsNew and Logic:Get("Battle"):IsBattleFinish(idBattle) then
    Continue()
    return
  end
  local info = {
    id = idBattle,
    type = DRAMA_TYPE.BATTLE,
    process = DRAMA_BATTLE_PROGRESS.ENTER
  }
  self:Trigger(info, continueFun)
end
function class:OnBattleFightEnd(bSuc, continueFun)
  if not Logic:Get("BattleShow"):IsEnterBattle() then
    return
  end
  local function Continue()
    if continueFun ~= nil then
      continueFun()
    end
  end
  if not bSuc then
    Continue()
    return
  end
  local idBattle = Logic:Get("Battle"):GetBattleId()
  if nil == idBattle then
    Continue()
    return
  end
  if bBattleOnlyIsNew and Logic:Get("Battle"):IsBattleFinish(idBattle) then
    Continue()
    return
  end
  local info = {
    id = idBattle,
    type = DRAMA_TYPE.BATTLE,
    process = DRAMA_BATTLE_PROGRESS.FINISH
  }
  self:Trigger(info, continueFun)
end
function class:Trigger(info, continueFun, cover)
  local function Continue()
    if continueFun ~= nil then
      continueFun()
    end
  end
  if nil == info or nil == info.type or nil == info.id then
    return false
  end
  local bSuc = false
  if info.type == DRAMA_TYPE.BATTLE and info.process then
    local infoDrama = self:GetDramaConfigByBattleId(info.id, info.process)
    if infoDrama and infoDrama.file ~= "" then
      bSuc = Logic:Get("DramaControl"):Run(infoDrama.file, continueFun, cover)
    end
  elseif info.type == DRAMA_TYPE.GUIDE and info.id then
    local infoDrama = self:GetDramaConfig(info.id)
    if infoDrama and infoDrama.file ~= "" then
      bSuc = Logic:Get("DramaControl"):Run(infoDrama.file, continueFun, cover)
    end
  end
  if not bSuc then
    Continue()
  end
  return false
end
function class:GetDramaConfigByBattleId(idBattle, process)
  local function ParseData()
    self.battleMapId = {}
    for i = 1, KFDBGetRecordAmt("DramaConfig") do
      local info = KFDBGetRecordByIdx("DramaConfig", i)
      self.battleMapId[info.battleId .. info.process] = info.id
    end
  end
  if nil == self.battleMapId then
    ParseData()
  end
  local idFdb = self.battleMapId[idBattle .. process]
  return self:GetDramaConfig(idFdb)
end
function class:GetDramaConfig(id)
  if nil == id then
    return nil
  end
  local info = KFDBGetRecord("DramaConfig", id)
  if nil == info then
    log4drama:debug("GetDramaConfig failed " .. id)
  end
  return info
end
function class:GetDramaContent(id)
  if nil == id then
    return nil
  end
  local info = KFDBGetRecord("DramaContent", id)
  if nil == info then
    log4drama:debug("GetDramaContent failed " .. id)
  end
  return info
end
function class:GetDramaTalk(id)
  local info = self:GetDramaContent(id)
  if nil == info then
    return ""
  end
  return info.content
end
