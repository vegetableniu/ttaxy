module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
local EDIT_SIZE = 25
function prototype:initialize()
  super.initialize(self)
  Logic:Get("Sect"):On(Logic.Sect.EVT.CHANGE_POST_OK, self:Event("updateLogic"))
end
function prototype:onEnter()
  self.callMax = KFDBGetRecord("ConfigValue", "MENPAI:POST_WORD_LIMIT")
  self.callMax = self.callMax and tonumber(self.callMax.content) or 0
  self.edtContent:setMaxLens(self.callMax)
  self.edtContent:setFontSize(EDIT_SIZE)
  self.edtContent:setMulLine(true)
  local sectInfo = Logic:Get("Sect"):getSectInfo()
  if sectInfo == nil or sectInfo.post == nil or sectInfo == "" then
    self.edtContent:setPlaceHolder(TwGetStr(110134))
  else
    self.edtContent:setString(sectInfo.post)
  end
  self.edtContent.textField:setColor(ccColor3B(0, 0, 0))
  self.labTip:setStyle(kCCLabelTTFStyleOutline)
  self.labTip:setString(TwGetStr(110169, self.callMax / 2))
  self.contentStr = ""
end
function prototype:onBtnOk(sender, event)
  local contentStr = self.edtContent:getString()
  contentStr = Logic:Get("Sect"):checkString(contentStr)
  self.edtContent:setString(contentStr)
  if getCodePointAmount(contentStr) > self.callMax then
    Prompt:Fail(TwGetStr(110130, self.callMax / 2))
    return
  end
  self.contentStr = contentStr
  Logic:Get("Sect"):PostChangePost(self.contentStr)
end
function prototype:onBtnCancel(sender, event)
  SceneHelper:removePrompt(self.rootNode)
end
function prototype:updateLogic()
  Logic:Get("Sect"):setSectCall(self.contentStr)
  SceneHelper:removePrompt(self.rootNode)
end
