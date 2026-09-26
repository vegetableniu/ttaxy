module((...), package.seeall)
require("SceneHelper")
require("TableViewEx")
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
  if giftInfo == nil or next(giftInfo) == nil then
    return
  end
  if giftInfo.desc then
    local desc = json.decode(giftInfo.desc)
    for i = 1, 3 do
      local str = string.format("labNum%d", i)
      local cost = string.format("sale%d", i)
      self[str]:create(0, "BIG_BLUE_NUM")
      self[str]:setValue(desc[cost])
    end
    self.tip_ttf:setString(desc.title)
    self.tip_ttf:setStyle(kCCLabelTTFStyleOutline)
  end
  self.title_ttf:setColor(ccc3(255, 183, 18))
  self.title_ttf:setString(giftInfo.name)
  self.title_ttf:setStyle(kCCLabelTTFStyleOutline)
  local strTime = Logic:Get("Gift"):GetTimeStrByType(giftInfo.activityType)
  if not table.empty(strTime) then
    self.ttfTime:setString(TwGetStr(103362, strTime[1]))
    self.ttfTime:setStyle(kCCLabelTTFStyleOutline)
  end
end
function prototype:onBtnGotoMall(sender, event)
  SceneHelper:runWithScene("Mall", self.rootNode)
end
