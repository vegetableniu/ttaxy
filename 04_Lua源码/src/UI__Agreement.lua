require("SceneHelper")
module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
function prototype:onEnter()
  local x, y = self.lstAgree:getPosition()
  local sizeNode = self.lstAgree:getContentSize()
  local website = TwGetStr(106009)
  Logic:Get("EnvLogic"):OpenUrlInRect(website, {
    x,
    y,
    sizeNode.width,
    sizeNode.height
  })
end
function prototype:onExit()
  Logic:Get("EnvLogic"):CloseWebPage()
end
function prototype:onBtnCancel()
  Logic:Get("EnvLogic"):ExitGame()
end
function prototype:onBtnConfirm()
  Logic:Get("System"):SetSysVariableMisc("AGREEMENT", 1)
  SceneHelper:removePrompt(self.rootNode)
end
