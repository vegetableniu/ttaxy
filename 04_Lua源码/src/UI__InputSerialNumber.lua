require("SceneHelper")
module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
local MAX_LENS = 9
function prototype:onEnter()
  self.serialNumber = nil
  self.setSerialNumberTitle:setStyle(kCCLabelTTFStyleOutline)
  self.setSerialNumberTitle:setColor(ccColor3B(187, 255, 0))
  self.setSerialNumberTitle:setString(TwGetStr(108001))
  self.staString:setString(TwGetStr(108002))
  self.inputSerialNumber:setFontSize(30)
  self.inputSerialNumber:setMaxLens(MAX_LENS)
end
function prototype:checkInput()
  self.serialNumber = self.inputSerialNumber:getString()
  if self.serialNumber == nil or self.serialNumber == "" then
    Prompt:Fail(108003)
    return false
  elseif string.find(self.serialNumber, "[^%w]") then
    Prompt:Fail(108004)
    return false
  end
  return true
end
function prototype:onBtnSubmit()
  if not self:checkInput() then
    return
  end
  Logic:Get("Gift"):PostSerialNumber(self.serialNumber)
end
function prototype:onBtnReturn()
  SceneHelper:runWithScene("Strage", self.rootNode)
end
