module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
require("SceneHelper")
function prototype:onEnter()
  self.nodInput:setPlaceHolder(TwGetStr(110701))
  self.nodInput:setFontSize(24)
  self.nodInput:setMaxLens(999)
  self.nodInput:setMulLine(true)
  self.nodInput:setClear(true)
  self.nodInput:setTouchPriority(-255)
  local str = Logic:Get("WeChat"):GetContentStr()
  self.nodInput:setString(str)
  if Logic:Get("System"):IsOpenFaceBook() then
    local path = "images/WeChat/share2facebook.png"
    local spr = CCSprite:create(path)
    if spr then
      self.sprShare:setDisplayFrame(spr:displayFrame())
    end
  end
  Logic:Get("WeChat"):ResetTimes()
end
function prototype:onExit()
end
function prototype:onBtnBg()
end
function prototype:onBtnClose()
  SceneHelper:removePrompt(self.rootNode)
end
function prototype:onBtnShare()
  if Logic:Get("WeChat"):IsOverLimit() then
    SceneHelper:removePrompt(self.rootNode)
    Prompt:Fail(TwGetStr(110706))
    return
  end
  local title = self.nodInput:getString()
  local link = Logic:Get("WeChat"):GetWeChatUrl() or ""
  if Logic:Get("System"):IsOpenFaceBook() then
    Logic:Get("System"):ShareFaceBook(title)
    SceneHelper:removePrompt(self.rootNode)
    return
  end
  if Logic:Get("System"):IsOperator("appstore") then
    Logic:Get("Sdk"):WeixinShareText(title)
  else
    Logic:Get("Sdk"):WeixinShareLink(title, nil, link)
  end
  SceneHelper:removePrompt(self.rootNode)
end
