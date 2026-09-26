require("SceneHelper")
module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
function prototype:onEnter()
  self.ttfText:setStyle(kCCLabelTTFStyleOutline)
end
function prototype:bindAnimationMgr()
  return true
end
function prototype:onBtnArrow(sender, event)
  self.animationMgr:runAnimations("hide")
  self.rootNode:getParent().bshowTips = false
end
function prototype:show()
  self.animationMgr:runAnimations("show")
end
function prototype:refreshDesr(text)
  local actText = ReplaceStringTab(text)
  self.ttfText:setString(actText or "")
  self.ttfText:setDimensions(CCSize(270, 150))
end
