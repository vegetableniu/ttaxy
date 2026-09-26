require("utf8")
module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
require("SceneHelper")
local EMAIL_MAX_FONT = 150
function prototype:onEnter()
  self.sendTTF:setString(TwGetStr(103128))
  self.cancelTTF:setString(TwGetStr(103129))
  self.edtEmailContent:setMaxLens(EMAIL_MAX_FONT)
  self.edtEmailContent:setFontSize(25)
  self.edtEmailContent:setMulLine(true)
  self:RefrashSendEmail()
end
function prototype:onBtnToSend(sender, event)
  if self.reply == nil or self.reply == "" then
    Prompt:Confirm(self, "", 101014)
  end
  local contentStr = self.edtEmailContent:getString()
  contentStr = utf8.bmpOnly(contentStr)
  self.edtEmailContent:setString(contentStr)
  for i = 1, KFDBGetRecordAmt("RegisterForbidden") do
    local rec = KFDBGetRecordByIdx("RegisterForbidden", i)
    local result, _ = string.find(contentStr, rec.name)
    contentStr = string.gsub(contentStr, rec.name, function(s)
      local len = getStrShowWidth(s)
      return string.rep("*", len)
    end)
  end
  if contentStr == nil or contentStr == "" then
    Prompt:Confirm(self, "", 101101)
  else
    local mailTab = {}
    mailTab.title = ""
    mailTab.target = self.reply
    mailTab.content = contentStr
    Logic:Get("Email"):SendeMailToOther(mailTab)
    SceneHelper:removePrompt(self.rootNode)
  end
end
function prototype:onBtnCancel(sender, event)
  SceneHelper:removePrompt(self.rootNode)
end
function prototype:RefrashSendEmail()
  self.reply = Logic:Get("Email"):GetReply()
  self.staToPlayerName:setString(TwGetStr(101100, self.reply or ""))
end
