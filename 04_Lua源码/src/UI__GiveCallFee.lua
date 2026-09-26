module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
require("SceneHelper")
function prototype:onEnter()
  Logic:Get("PhoneFee"):On(Logic.PhoneFee.EVT.SUCCESSED, self:Event("remove"))
  self.nodInput:setPlaceHolder(TwGetStr(110401))
  self.nodInput:setFontSize(24)
  self.nodInput:setMaxLens(11)
  self.nodInput:setTouchPriority(-255)
  self.ttfTip:setStyle(kCCLabelTTFStyleOutline)
  self.ttfTip:setString(TwGetStr(110402))
  local active = Logic:Get("PhoneFee"):GetActive()
  local str = ""
  local data = {}
  if active == Logic.PhoneFee.ACTIVE_TYPE.CHARGE then
    local dataFree = {}
    local rec = KFDBGetRecord("ConfigValue", "KINGSOFT:CHARGE_CALLS_FEE") or {}
    local rec2 = KFDBGetRecord("ConfigValue", "KINGSOFT:FREE_CALLS_FEE") or {}
    data = json.decode(rec.content or "[]") or {}
    dataFree = json.decode(rec2.content or "[]") or {}
    str = TwGetStr(110411, dataFree.level or 0)
    self.nodDesr:setString(TwGetStr(110412, data.level or 0, data.amount or 0, ""), kCCLabelTTFStyleSimple)
    return
  end
  if active == Logic.PhoneFee.ACTIVE_TYPE.FREE then
    local rec = KFDBGetRecord("ConfigValue", "KINGSOFT:FREE_CALLS_FEE") or {}
    data = json.decode(rec.content or "[]") or {}
    self.nodDesr:setString(TwGetStr(110403, data.level or 0, str, data.amount or 0), kCCLabelTTFStyleSimple)
  end
end
function prototype:onExit()
end
function prototype:onBtnBg()
end
function prototype:onBtnConfirm()
  local phoneNum = self.nodInput:getString()
  local length = getStrShowWidth(phoneNum)
  if length < 11 then
    Prompt:Fail(TwGetStr(110405, 11))
    self.nodInput:setString("")
    return
  end
  if string.find(phoneNum, "[^%d]") then
    Prompt:Fail(110406)
    self.nodInput:setString("")
    return
  end
  Logic:Get("PhoneFee"):PostGetPhoneFee(phoneNum)
end
function prototype:onBtnCancel()
  Logic:Get("SureConfirm").btnText.ok = TwGetStr(110413)
  Logic:Get("SureConfirm").btnText.cancel = TwGetStr(110414)
  Prompt:Confirm(self, "", 110407, self.remove, Prompt.PROMPT_TYPE.SELECT)
end
function prototype:remove()
  SceneHelper:removePrompt(self.rootNode)
end
