require("SceneHelper")
module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
function prototype:onEnter()
  self.substituteCost = 0
  self.info = Logic:Get("NewMonopoly"):GetMonoInfo()
  local costRec = KFDBGetRecord("ConfigValue", "NEWMONOPOLY:SUBSTITUE_EXCHANGE_COSTS") or {}
  local costs = json.decode(costRec.content or "[]") or {}
  local idx = self.info.costSubstitute + 1
  if idx > #costs then
    idx = #costs or idx
  end
  self.substituteCost = costs[idx]
  self.ttfBuffTips:setStyle(kCCLabelTTFStyleOutline)
  self.ttfSubsitute:setString(TwGetStr(115369, self.substituteCost))
  local rec = KFDBGetRecord("PositionBuffSetting", self.info.currBuff)
  self.ttfBuffTips:setString(ReplaceStringTab(rec.desr))
  self.ttfBuffTips:setDimensions(CCSize(450, 0))
  if self.info.currBuff and 0 >= self.info.buffTimes then
    local buffInfo = KFDBGetRecord("PositionBuffSetting", self.info.currBuff)
    local isGoodBuff = buffInfo.isGoodBuff == "true"
    local color = isGoodBuff and ccc3(48, 255, 0) or ccc3(255, 0, 0)
    self.ttfBuffTips:setColor(color)
  end
  Logic:Get("NewMonopoly"):On(Logic.NewMonopoly.EVT.SELECT_SUBSTITUE, self:Event("onSelectSubstitue"))
end
function prototype:onSelectSubstitue()
  SceneHelper:removeScene("RicherValeBuffTip")
end
function prototype:onBtnBg()
end
function prototype:onUseSubstitute()
  if not Logic:Get("PlayerInfo"):IsMoneyEnough(self.substituteCost) then
    Logic:Get("Main"):PromptCharge()
    return
  end
  Logic:Get("NewMonopoly"):PostSelectSubstitue(true, true)
end
function prototype:confirmUse()
  Logic:Get("NewMonopoly"):PostSelectSubstitue(false, true)
end
function prototype:onBtnAccept()
  Logic:Get("NewMonopoly"):PostSelectSubstitue(false, false)
end
