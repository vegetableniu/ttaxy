module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
require("SceneHelper")
function prototype:onEnter()
  self.str = ""
  self.str = Logic:Get("Facebook"):GetShareFriendContent()
  self.contentTTF:setDimensions(CCSize(260, 0))
  self.contentTTF:setString(self.str)
  Logic:Get("Facebook"):SetShareFriendContent("")
  self.contentEnd:setString(TwGetStr(103313))
  self.contentEnd:setStyle(kCCLabelTTFStyleOutline)
  local ccSprite = CCSprite:create("images/Effect/UIMS/x.png")
  if ccSprite ~= nil then
    self.sprClose:setDisplayFrame(ccSprite:displayFrame())
  end
end
function prototype:onBtnSure(node, loader)
  Logic:Get("WeChat"):PostShare()
  SceneHelper:removePrompt(self.rootNode)
end
function prototype:onMenuClose(node, loader)
end
function prototype:onBtnTTF()
  Logic:Get("WeChat"):PostShare()
  SceneHelper:removePrompt(self.rootNode)
end
function prototype:onBtnClose()
  SceneHelper:removePrompt(self.rootNode)
end
