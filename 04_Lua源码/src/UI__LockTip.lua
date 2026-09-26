module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
require("SceneHelper")
function prototype:onEnter()
  Logic:Get("SureConfirm"):On(Logic.SureConfirm.EVT.CLOSE_POPTIP, self:Event("onBtnClose"))
  local text = Logic:Get("SureConfirm"):GetPopTip()
  self:setContent(text)
end
function prototype:onExit()
end
function prototype:onBtnClose()
  local actionScaleTo = CCScaleTo:create(0.1, 0.3)
  local arr1 = CCArray:create()
  arr1:addObject(actionScaleTo)
  arr1:addObject(CCCallFuncN:create(function()
    SceneHelper:removePrompt(self.rootNode)
  end))
  self.layer:runAction(CCSequence:create(arr1))
end
function prototype:setContent(text)
  self.content:setDimensions(CCSize(400, 0))
  self.content:setHorizontalAlignment(kCCVerticalTextAlignmentCenter)
  self.content:setString(text)
end
