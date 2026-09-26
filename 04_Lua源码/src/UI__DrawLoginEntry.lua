module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
require("SceneHelper")
function prototype:onEnter()
  self.btnEntry:setVisible(false)
  if Logic:Get("System"):IsOperator("myapp") then
    self:login()
    return
  end
  if Logic:Get("System"):IsOperator("appstore") and not Logic:Get("PhoneFee"):IsActiveOver() then
    local spr = CCSprite:create("images/Draw/welcome.png")
    if spr then
      self.imgBg:setDisplayFrame(spr:displayFrame())
    end
    self.imgBg:setScale(1.25)
    Singleton(Timer):Repeat(3000, self:Event("setBtnVisible"))
    return
  end
  local spr = CCSprite:create("images/Draw/welcome.png")
  if spr then
    self.imgBg:setDisplayFrame(spr:displayFrame())
  end
  self.imgBg:setScale(1.25)
  local imgSpr
  if Logic:Get("System"):IsOperator("appstore") then
    imgSpr = CCSprite:create("images/Draw/rewardXian.png")
  else
    imgSpr = CCSprite:create("images/Draw/rewardXian.png")
  end
  if imgSpr then
    self.imgRewardIpad:setDisplayFrame(imgSpr:displayFrame())
  end
  Singleton(Timer):Repeat(3000, self:Event("setBtnVisible"))
end
function prototype:onBtnStartGame()
  self:login()
end
function prototype:onBtnEntry()
  self:login()
end
function prototype:login()
  Logic:Get("Login"):SetIsCreateRole(false)
  SceneHelper:removeScene("DrawLoginEntry")
  Logic:Get("Guide"):check()
end
function prototype:setBtnVisible()
  self.btnEntry:setVisible(true)
end
