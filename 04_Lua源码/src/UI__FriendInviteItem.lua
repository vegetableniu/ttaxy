module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
function prototype:onEnter()
end
function prototype:Refrash(tab)
  self.rewardRule:setDimensions(CCSize(335, 0))
  self.rewardRule:setHorizontalAlignment(kCCTextAlignmentLeft)
  self.rewardRule:setString(tab.rules)
  if tab.completed == 1 then
    local texture = CCSprite:create("images/public/complete.png")
    if texture then
      self.imgCompleted:setDisplayFrame(texture:displayFrame())
      self.imgCompleted:setScale(0.93)
    end
    self.imgCompleted:setVisible(true)
  else
    self.imgCompleted:setVisible(false)
  end
end
