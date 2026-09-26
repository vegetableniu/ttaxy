module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
require("SceneHelper")
function prototype:onEnter()
  self.nodInput:setFontSize(30)
  self.nodInput:setMaxLens(12)
  self.nodInput:setTouchPriority(-255)
end
function prototype:onExit()
end
function prototype:onMenuClose()
end
function prototype:onBtnCancel()
  SceneHelper:removePrompt(self.rootNode)
end
function prototype:onBtnEnter()
  self:resetPlayerName()
end
function prototype:resetPlayerName()
  local name = self.nodInput:getString()
  if not name or "" == name then
    Prompt:Fail(TwGetStr(10054))
    return
  end
  local length = self:getStrLength(name)
  if length > 6 then
    Prompt:Fail(TwGetStr(10074, 6))
    return
  end
  local flag = Logic:Get("CreateHero"):checkName(name)
  if not flag then
    return
  end
  Logic:Get("Lineup"):postUpdateTeamName(name)
  SceneHelper:removePrompt(self.rootNode)
end
function prototype:getStrLength(s)
  local amount = 0
  local i = 1
  local byteAmount = 1
  while i <= #s do
    byteAmount = getCodePointByteAmount(string.byte(s, i))
    amount = amount + 1
    i = i + byteAmount
  end
  return amount
end
function prototype:onRenameSuccessed()
  SceneHelper:removePrompt(self.rootNode)
end
