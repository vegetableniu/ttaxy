module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
require("SceneHelper")
function prototype:initialize()
  super.initialize(self)
end
function prototype:onEnter()
  self.ttfCurrLv:setStyle(kCCLabelTTFStyleOutline)
  self.ttfNextLv:setStyle(kCCLabelTTFStyleOutline)
end
function prototype:ReFrashInfo(data)
  if data == nil then
    return
  end
  self.data = data
  local path = string.format("data/star/%d.png", data.star)
  local spr = CCSprite:create(path)
  if spr then
    self.sprStar:setDisplayFrame(spr:displayFrame())
  end
  self.ttfCurrLv:setString(ReplaceStringTab(data.currDesr))
  self.ttfNextLv:setString(ReplaceStringTab(data.nextDesr))
  self.ttfTip:setString(data.tip or "")
  local posY = self.ttfNextLv:getPositionY() - self.ttfCurrLv:getContentSize().height - 10
  self.ttfTip:setPositionY(posY)
end
