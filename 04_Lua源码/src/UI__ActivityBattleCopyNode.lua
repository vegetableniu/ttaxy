module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
require("SceneHelper")
require("Logic.Activity")
local ALL_TITLE = {
  "battleCopyName",
  "needPowerNum",
  "surplusTimes",
  "needRankNum",
  "times",
  "titleActivity"
}
function prototype:initialize(...)
  super.initialize(self, ...)
  Logic:Get("BattleShow"):On(Logic.BattleShow.EVT.INEND, self:Event("onInBattleEnd"))
  Logic:Get("Battle"):SetEmBattleType(Logic.Battle.BATTLE_TYPE.ACTIVE)
end
function prototype:onEnter()
  self:InitTitle()
end
function prototype:InitTitle()
  for i = 1, #ALL_TITLE do
    self[ALL_TITLE[i]]:setStyle(kCCLabelTTFStyleOutline, ccc3(0, 0, 0))
  end
end
function prototype:onInBattleEnd()
  SceneHelper:removeScene("Embattle")
  SceneHelper:removeScene("BattleCopyFriend")
end
function prototype:IsAbitilyFight()
  local enoughLevel = Logic:Get("PlayerInfo"):GetPlayerLevel() >= tonumber(self.titleInfo.level)
  local times = self.titleInfo.dailyCount
  local enoughTimes = times == 0 or times > Logic:Get("Activity"):getBattleTimes(self.titleInfo.id)
  return enoughLevel and enoughTimes
end
function prototype:reFrashInfo(titleInfo)
  if titleInfo == nil or next(titleInfo) == nil then
    return
  end
  self.titleInfo = titleInfo
  local surplusTimesStr = ""
  local timesStr = ""
  if self.titleInfo.dailyCount == 0 then
    surplusTimesStr = ""
  else
    local surplusTimes = titleInfo.dailyCount - Logic:Get("Activity"):getBattleTimes(titleInfo.id)
    timesStr = TwGetStr(106026, surplusTimes)
    surplusTimesStr = TwGetStr(106019)
  end
  local costPower = TwGetStr(106018, tonumber(titleInfo.cost))
  local rankNeed = TwGetStr(106020, tonumber(titleInfo.level))
  self:setStrInfo(titleInfo.name, costPower, surplusTimesStr, rankNeed, timesStr, titleInfo.buffDesc)
  self.btnBattleCopy:setEnabled(self:IsAbitilyFight())
end
function prototype:setStrInfo(strname, strpowernum, strsurtimes, strneedrank, timesstr, strActivity)
  self.titleActivity:setString(strActivity)
  self.battleCopyName:setString(strname)
  self.needPowerNum:setString(strpowernum)
  self.surplusTimes:setString(strsurtimes)
  self.needRankNum:setString(strneedrank)
  self.times:setString(timesstr)
  if Logic:Get("PlayerInfo"):GetPlayerLevel() < tonumber(self.titleInfo.level) then
    self.imgFight:setVisible(false)
  else
    self.needRankNum:setVisible(false)
  end
end
function prototype:getBattleId()
  return self.titleInfo.id
end
function prototype:onBtnBattleCopy(sender, event)
  Logic:Get("Guide"):done("Activity", "SelectBattle")
  Logic:Get("Battle"):SetCurSelBattleId(self:getBattleId())
  local physicalInfo = Logic:Get("PlayerInfo"):GetPlayerPhysical()
  if table.empty(physicalInfo) or nil == physicalInfo then
    return
  end
  local playersLeadership = Logic:Get("Hero"):GetLeadership()
  local battlingLeadership = Logic:Get("Hero"):GetBattlingLeadership()
  if playersLeadership < battlingLeadership then
    Prompt:Confirm(self, 103071, 103070)
    return
  end
  local physical = physicalInfo.point
  local enoughPhysical = physical >= tonumber(self.titleInfo.cost)
  if not enoughPhysical then
    Logic:Get("Mall"):BuyPoints()
    return
  end
  local bagBool = Logic:Get("Hero"):IsBagEnough()
  if bagBool then
    SceneHelper:pushPrompt("BattleTip")
    return
  end
  if Logic:Get("Friend"):IsNeedGetNewCommendFriend() then
    return
  end
  Logic:Get("Activity"):FireEvent(Logic.Activity.EVT.CLICK_ACTIVITY_COPY_ITEM)
end
function prototype:updateGuide()
  local logicGuide = Logic:Get("Guide")
  if not logicGuide:isGuiding() then
    return false
  end
  if Logic:Get("Guide"):isActive("Activity", "SelectBattle") then
    Logic:Get("Guide"):lockTouch(self.btnBattleCopy)
  end
end
