module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
function prototype:onEnter()
  Logic:Get("Hero"):On(Logic.Hero.EVT.HERO_LOCK, self:Event("RefreshCard"))
  self.HeroInfo = Logic:Get("HeroCardInfo"):GetTreasureInfo()
  self.btnClose:setVisible(false)
  self.btnProTect:setVisible(false)
  self.ttfProtect:setVisible(false)
  self.ttfClose:setVisible(false)
  self:setBtnProTitle()
  self:ReFrashHeroInfo(self.HeroInfo)
end
function prototype:onExit()
  Logic:Get("HeroCardInfo"):SetPromptHeroInfo(false)
end
function prototype:ReFrashHeroInfo(heroInfo)
  self.ccbInfo:ReFrashHeroInfo(heroInfo)
end
function prototype:onBtnClose()
  local bool = Logic:Get("HeroCardInfo"):GetPromptHeroInfo()
  if bool then
    SceneHelper:removePrompt(self.rootNode)
  else
    SceneHelper:popScene()
  end
end
function prototype:onBtnCloseTwo()
  local bool = Logic:Get("HeroCardInfo"):GetPromptHeroInfo()
  if bool then
    SceneHelper:removePrompt(self.rootNode)
  else
    SceneHelper:popScene()
  end
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
