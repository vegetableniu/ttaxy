module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
function prototype:initialize(...)
  super.initialize(self, ...)
end
function prototype:dispose(...)
  super.dispose(self)
  Logic:Get("EnvLogic"):CloseCallboard()
end
function prototype:onEnter(node, loader)
  local spr = CCSprite:create("particles/CallBoard/imgCallBoardBg.png")
  if not Logic:Get("Login"):isNeedCallBoardImg() then
    self.imgBg:setVisible(false)
  end
  self.imgBackground:setSpriteFrame(spr:displayFrame())
  self.imgBackground:setAnchorPoint(ccp(0, 0))
  self.imgBackground:setPreferredSize(CCSizeMake(550, 530))
  self.webview:setPreferredSize(CCSizeMake(508, 425))
  local envLogic = Logic:Get("EnvLogic")
  local needOpenCallboard = Logic:Get("System"):GetSysVariableMisc("NeedOpenCallboard")
  if not envLogic.isOpenCallBoard and needOpenCallboard == 1 then
    local rect = {}
    local width = self.webview:getContentSize().width * self.webview:getScaleX()
    local height = self.webview:getContentSize().height * self.webview:getScaleY()
    local parent = self.webview:getParent()
    local pos = {
      x = self.webview:getPositionX(),
      y = self.webview:getPositionY()
    }
    local eglView = CCDirector:sharedDirector():getOpenGLView()
    local designSize = eglView:getDesignResolutionSize()
    local frameSize = eglView:getFrameSize()
    local scaleWidth = frameSize.width / designSize.width
    local scaleHeight = frameSize.height / designSize.height
    local scale = math.min(scaleWidth, scaleHeight)
    repeat
      if parent then
        pos.x = pos.x + parent:getPositionX() - (parent:getPositionX() ~= 0 and parent:getAnchorPoint().x * width or 0)
        pos.y = pos.y + parent:getPositionY() - (parent:getPositionY() ~= 0 and parent:getAnchorPoint().y * height or 0)
        parent = parent:getParent()
      end
    until parent == nil
    rect.x = pos.x * scale + math.abs(designSize.width * scale - frameSize.width) * 0.5
    rect.y = pos.y * scale + math.abs(designSize.height * scale - frameSize.height) * 0.5
    rect.width = self.webview:getContentSize().width * scale
    rect.height = self.webview:getContentSize().height * scale
    envLogic:OpenCallBoard(Logic:Get("System"):GetCallBoardURL(), rect)
    envLogic.isOpenCallBoard = true
  end
end
function prototype:onBtnConfirmClicked()
  SceneHelper:removePrompt(self.rootNode)
  Logic:Get("EnvLogic"):CloseCallboard()
end
function prototype:onBgClicked(sender, event)
  self:onBtnConfirmClicked()
end
