module((...), package.seeall)
require("SceneHelper")
require("TableViewEx")
require("Logic.Compose")
require("BtnPosition")
prototype = BtnPosition.prototype:extend()
local EVO_TYPE = Enum({
  "MATERIAL_EVO",
  "PAY_MONEY_EVO"
})
function prototype:onBtnReturn()
  SceneHelper:runWithScene("GiftActivityList", self.rootNode)
end
function prototype:onBtnRecharge(sender, event)
  Logic:Get("Main"):GotoRecharge()
end
function prototype:onEnter()
  super.onEnter(self)
  self.ani = Logic:Get("AniMgr"):NewCCB("UI/UIcz", self.sprRight, ccp(35, 19), 0, nil, nil)
  if self.ani then
    self.ani:RunAni()
  end
  self:RefreInfo()
end
function prototype:RefreInfo(...)
  local giftInfo = Logic:Get("Gift"):GetActivityGift()
  self.title_ttf:setColor(ccc3(255, 183, 18))
  self.title_ttf:setString(giftInfo.name)
  self.title_ttf:setStyle(kCCLabelTTFStyleOutline)
  self.titleTTF:setString(TwGetStr(103203))
  self.contentTTF:setString(TwGetStr(103204))
  self.ttfRed:setString(TwGetStr(103205))
end
function prototype:onBtnPayMoneyEvolution(sender, event)
  Logic:Get("ExplainEquip"):setEvolutionType(Logic.ExplainEquip.EVO_TYPE.PAY_MONEY_EVO)
  SceneHelper:runWithScene("HeroEvolution", self.rootNode)
end
