module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
require("SceneHelper")
function prototype:onEnter()
end
function prototype:onBtnSure(node, loader)
end
function prototype:onBtnEnterGame(node, loader)
  SceneHelper:removePrompt(self.rootNode)
end
function prototype:onExit()
end
function prototype:onBtnVote()
  local url = TwGetStr(103350)
  Logic:Get("EnvLogic"):OpenUrl(url)
  Logic:Get("Platform"):PostDrawPraiseReward()
  SceneHelper:removePrompt(self.rootNode)
end
