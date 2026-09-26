module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
function prototype:initialize(...)
  super.initialize(self, ...)
end
function prototype:dispose(...)
  super.dispose(self)
end
function prototype:onEnter()
  self.ttfStageTip:setStyle(kCCLabelTTFStyleOutline)
end
function prototype:refreshInfo(index, dayCounts, curDays)
  self.ttfStageTip:setString(TwGetStr(111092, dayCounts))
  local isFinished = dayCounts <= curDays
  self.sprHalo:setVisible(isFinished)
  local strIcon = isFinished and string.format("images/Deposit/stage%dOn.png", index) or string.format("images/Deposit/stage%dOff.png", index)
  local spr = CCSprite:create(strIcon)
  if spr then
    self.sprJadeReward:setDisplayFrame(spr:displayFrame())
  end
end
