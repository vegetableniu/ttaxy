module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
require("SceneHelper")
function prototype:onEnter()
end
function prototype:onbtnBuy(node, loader)
  SceneHelper:removePrompt(self.rootNode)
  Logic:Get("Main"):GotoRecharge()
end
function prototype:onBtnCancel(node, loader)
  SceneHelper:removePrompt(self.rootNode)
end
function prototype:onMenuClose(node, loader)
  SceneHelper:removePrompt(self.rootNode)
end
