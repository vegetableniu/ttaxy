module((...), package.seeall)
require("SceneHelper")
require("TableViewEx")
require("Logic.Compose")
require("BtnPosition")
prototype = BtnPosition.prototype:extend()
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
  local ttf = {
    {"ttf1", "1"},
    {"ttf2", "2"},
    {"ttf3", "3"},
    {"ttf4", "4"}
  }
  for i = 1, #ttf do
    local str = KFDBGetRecord("HeroRankUpActivity", ttf[i][2])
    if str.desc then
      self[ttf[i][1]]:setString(str.desc)
    end
  end
  self.ttfExempli:setString(TwGetStr(103137))
  self.ttfTip:setString(TwGetStr(103138))
  self.ttfTip:setHorizontalAlignment(kCCVerticalTextAlignmentCenter)
  self.ttfExempli:setHorizontalAlignment(kCCVerticalTextAlignmentCenter)
end
