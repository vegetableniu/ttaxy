module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
local EDIT_SIZE = 25
function prototype:initialize()
  super.initialize(self)
  Logic:Get("Sect"):On(Logic.Sect.EVT.UPDATE_DECLARATION_OK, self:Event("updateLogic"))
end
function prototype:onEnter()
  self.decMax = KFDBGetRecord("ConfigValue", "MENPAI:MENPAI_DECLARATION_COUNT_LIMIT")
  self.decMax = self.decMax and tonumber(self.decMax.content) or 0
  self.edtContent:setMaxLens(self.decMax)
  self.edtContent:setFontSize(EDIT_SIZE)
  self.edtContent:setMulLine(true)
  local sectInfo = Logic:Get("Sect"):getSectInfo()
  if sectInfo == nil or sectInfo.declaration == nil or sectInfo == "" then
    self.edtContent:setPlaceHolder(TwGetStr(110135))
  else
    self.edtContent:setString(sectInfo.declaration)
  end
  self.edtContent.textField:setColor(ccColor3B(0, 0, 0))
  self.labTip:setStyle(kCCLabelTTFStyleOutline)
  self.labTip:setString(TwGetStr(110169, self.decMax / 2))
  self.contentStr = ""
end
function prototype:onBtnOk(sender, event)
  local contentStr = self.edtContent:getString()
  if getCodePointAmount(contentStr) > 2 * self.decMax then
    Prompt:Fail(TwGetStr(110129, self.decMax / 2))
    return
  end
  contentStr = Logic:Get("Sect"):checkString(contentStr)
  self.edtContent:setString(contentStr)
  self.contentStr = contentStr
  Logic:Get("Sect"):PostUpdataDeclaration(self.contentStr)
end
function prototype:onBtnCancel(sender, event)
  SceneHelper:removePrompt(self.rootNode)
end
function prototype:updateLogic()
  Logic:Get("Sect"):setSectDecl(self.contentStr)
  SceneHelper:removePrompt(self.rootNode)
end
