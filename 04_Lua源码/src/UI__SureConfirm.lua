module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
require("SceneHelper")
RET = Logic.SureConfirm.RET
function prototype:onEnter()
end
function prototype:onExit()
  Logic:Get("SureConfirm"):SetBtnText({
    ok = TwGetStr(103002),
    cancel = TwGetStr(103003)
  })
  Logic:Get("SureConfirm"):SetAni(false)
  if Logic:Get("Gift"):isDrawing() then
    Logic:Get("Gift"):setDrawing(false)
    Logic:Get("Guide"):check()
    return
  end
  Logic:Get("Facebook"):OpenFaceBook()
  Logic:Get("WeChat"):OpenWeChat()
end
function prototype:onNodeLoaded(node, loader)
  local params = Logic:Get("SureConfirm"):GetConfirm()
  local btnText = Logic:Get("SureConfirm"):GetBtnText()
  self.eType = 8
  self.ani = Logic:Get("SureConfirm"):GetAniBool()
  self:setConfirm(params)
  self:setBtnText(btnText)
  local fontsize = Logic:Get("SureConfirm"):getFontSize() or 25
  self.content:setFontSize(fontsize)
  Logic:Get("SureConfirm"):SetConfirmNil()
end
function prototype:setConfirm(params)
  self.title:setStyle(kCCLabelTTFStyleOutline)
  self.title:setColor(ccColor3B(187, 255, 0))
  if params.title then
    local str = params.title == 0 and TwGetStr(103001) or type(params.title) == "string" and params.title or TwGetStr(params.title)
    self.title:setString(str)
  else
    self.title:setString(TwGetStr(103001))
  end
  self.title:setHorizontalAlignment(kCCTextAlignmentCenter)
  if params.content then
    self.content:setDimensions(CCSize(500, 0))
    if params.textType ~= nil then
    else
      self.content:setHorizontalAlignment(kCCVerticalTextAlignmentCenter)
    end
    if type(params.content) ~= "string" or not params.content then
    end
    self.content:setString((TwGetStr(params.content)))
  end
  if params.func then
    self.func = params.func
    self.params = params.param
  end
  local eType = params.eType ~= nil and params.eType or Prompt.PROMPT_TYPE.CONFIRM
  self.eType = eType
  self.btnSureOne:setVisible(Prompt.PROMPT_TYPE.SELECT == eType)
  self.btnCancel:setVisible(Prompt.PROMPT_TYPE.SELECT == eType)
  self.btnSureTwo:setVisible(Prompt.PROMPT_TYPE.CONFIRM == eType)
  self.btnSureOneMenu:setVisible(Prompt.PROMPT_TYPE.SELECT == eType)
  self.btnCancelMenu:setVisible(Prompt.PROMPT_TYPE.SELECT == eType)
  self.btnSureTwoMenu:setVisible(Prompt.PROMPT_TYPE.CONFIRM == eType)
end
function prototype:setBtnText(btnText)
  local strOk = nil ~= btnText.ok and btnText.ok or TwGetStr(103002)
  self.btnSureOne:setString(strOk)
  local strCancel = nil ~= btnText.cancel and btnText.cancel or TwGetStr(103003)
  self.btnCancel:setString(strCancel)
  local strYes = nil ~= btnText.ok and btnText.ok or TwGetStr(103002)
  self.btnSureTwo:setString(strYes)
end
function prototype:onBtnSure(node, loader)
  local actionScaleTo = CCScaleTo:create(0.1, 0.3)
  local arr1 = CCArray:create()
  if not self.ani then
    arr1:addObject(actionScaleTo)
  end
  arr1:addObject(CCCallFuncN:create(function()
    if self.func and self.params == nil then
      self.func()
    elseif self.func and self.params ~= nil then
      self.func(RET.OK)
    end
    Logic:Get("SureConfirm"):SetAni(false)
    SceneHelper:removePrompt(self.rootNode)
  end))
  self.layer:runAction(CCSequence:create(arr1))
end
function prototype:onBtnCancel(node, loader)
  if self.params ~= nil then
    self.func(RET.CANCEL)
    SceneHelper:removePrompt(self.rootNode)
  else
    SceneHelper:removePrompt(self.rootNode)
  end
end
function prototype:onMenuClose(node, loader)
  if self.eType == Prompt.PROMPT_TYPE.CONFIRM then
    self:onBtnSure()
  end
end
