module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
local VIP_AFFECT_FRIST = {
  "vipAffectA1",
  "vipAffectB1",
  "vipAffectC1"
}
local VIP_AFFECT_LAST = {
  "vipAffectA3",
  "vipAffectB3",
  "vipAffectC3"
}
local VIP_AFFECT_MIDDLE = {
  "vipAffectA2",
  "vipAffectB2",
  "vipAffectC2"
}
local AFFECT_INI = {
  102013,
  102014,
  102015
}
function prototype:onEnter(...)
  self.vipFun:setString(TwGetStr(103127))
  self:SetPrompt()
end
function prototype:SetPrompt()
  self.playerInfo = Logic:Get("PlayerInfo"):GetPlayerAllInfo()
  if self.playerInfo == nil or next(self.playerInfo) == nil then
    return
  end
  local logic = Logic:Get("PlayerInfo")
  self.staCurLevel:setString(TwGetStr(102005, logic:GetPlayerLevel() or 0))
  local needExp = 0
  if logic:GetUpgradeNeedByLevel(logic:GetPlayerLevel()) then
    needExp = logic:GetUpgradeNeedByLevel(logic:GetPlayerLevel()) - logic:GetPalyerExp()
  end
  self.staUpgradeNeed:setString(TwGetStr(102007, needExp))
  self.staCurExp:setString(TwGetStr(102006, logic:GetPalyerExp() or 0))
  self.curTime = Logic:Get("System"):GetTime()
  if self.timeRun == nil or self.timeRun == false then
    self.timeRun = true
    Singleton(Timer):Repeat(1000, self:Event("TimeRun"))
    local convertionTime = Logic:Get("System"):GetTimeStr("%X", self.curTime or 0)
    convertionTime = TwGetStr(102018, convertionTime)
    self.staCurTime:setString(convertionTime)
  end
  local vipInfo = self.playerInfo.vip
  local str = ""
  local weekStr = ""
  local monStr = ""
  if vipInfo.week then
    local haveTime = Logic:Get("System"):SecToDay(Logic:Get("System"):DiffTime(vipInfo.weekTime / 1000))
    local day = 0
    if haveTime.day < 1 then
      if 0 <= haveTime.min or 0 <= haveTime.hour then
        day = TwGetStr(103096)
      end
    else
      day = haveTime.day
    end
    weekStr = TwGetStr(102019, day)
  end
  if vipInfo.vip then
    local haveTime = Logic:Get("System"):SecToDay(Logic:Get("System"):DiffTime(vipInfo.vipTime / 1000))
    local day = 0
    if haveTime.day < 1 then
      if 0 <= haveTime.min or 0 <= haveTime.hour then
        day = TwGetStr(103096)
      end
    else
      day = haveTime.day
    end
    monStr = TwGetStr(102010, day)
  end
  if weekStr == "" then
    str = monStr
  elseif monStr == "" then
    str = weekStr
  else
    str = weekStr .. "\n" .. monStr
    str = ReplaceStringTab(str)
  end
  self.vipSurplusDay:setString(str)
  local vipGeftTitle = TwGetStr(102009)
  self.vipGeftTitle:setString(vipGeftTitle)
  self:getVipAffectStr(self.vipGeftTitle, self.vipGeftNUm, 102012)
  local getVipAffectStrFrist = TwGetStr(102016)
  local getVipAffectStrLast = TwGetStr(102017)
  for i = 1, #VIP_AFFECT_FRIST do
    self[VIP_AFFECT_FRIST[i]]:setString(getVipAffectStrFrist)
    self:getVipAffectStr(self[VIP_AFFECT_FRIST[i]], self[VIP_AFFECT_MIDDLE[i]], AFFECT_INI[i])
    self:getVipAffectStr(self[VIP_AFFECT_MIDDLE[i]], self[VIP_AFFECT_LAST[i]], 102017)
  end
end
function prototype:getVipAffectStr(prevLable, curLable, strini)
  local x, y = prevLable:getPosition()
  local posX = x + prevLable:getContentSize().width
  local posY = y
  curLable:setPosition(CCPointMake(posX, posY))
  curLable:setAnchorPoint(CCPointMake(0, 0.5))
  curLable:setString(TwGetStr(strini))
end
function prototype:TimeRun()
  self.timeRun = true
  self.curTime = self.curTime + 1
  if self.curTime and self.curTime > 0 then
    local convertionTime = Logic:Get("System"):GetTimeStr("%X", self.curTime or 0)
    convertionTime = TwGetStr(102018, convertionTime)
    self.staCurTime:setString(convertionTime)
  end
end
function prototype:TimeStop()
  self:EventTracer():Cancel("TimeRun")
  self.timeRun = false
end
