module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
function prototype:onEnter()
  Logic:Get("Hero"):On(Logic.Hero.EVT.HERO_LOCK, self:Event("RefreshCard"))
  self.HeroInfo = Logic:Get("HeroCardInfo"):GetTailInfo()
  self.btnClose:setVisible(false)
  self.btnProTect:setVisible(false)
  self.ttfProtect:setVisible(false)
  self.ttfClose:setVisible(false)
  self:setBtnProTitle()
  self:ReFrashHeroInfo(self.HeroInfo)
end
function prototype:onExit()
end
function prototype:ReFrashHeroInfo(TailsmanInfo)
  self.ccbInfo:ReFrashHeroInfo(TailsmanInfo)
end
function prototype:onBtnClose()
  SceneHelper:removePrompt(self.rootNode)
end
function prototype:onBtnCloseTwo()
  SceneHelper:removePrompt(self.rootNode)
end
function prototype:onBtnProTect()
  if self.HeroInfo.locked then
    Logic:Get("Hero"):PostLock(false, self.HeroInfo.id)
  else
    Logic:Get("Hero"):PostLock(true, self.HeroInfo.id)
  end
end
function prototype:RefreshCard()
  self:setBtnProTitle()
end
function prototype:setBtnProTitle()
  local str = ""
  if self.HeroInfo.locked then
    str = "images/font/quxiao.png"
  else
    str = "images/font/baohu.png"
  end
  local ccspr = CCSprite:create(str)
  self.ttfProtect:setDisplayFrame(ccspr:displayFrame())
end
