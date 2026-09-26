require("SceneHelper")
module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
function prototype:onEnter()
end
function prototype:bindAnimationMgr()
  return true
end
function prototype:onBtnHero(sender, event)
  if self.callBack == nil then
    return
  end
  self.callBack()
end
function prototype:setCallBack(callBack)
  self.callBack = callBack
end
function prototype:setSpriteAdd(isShow)
  self.sprAdd:setVisible(isShow)
  self.nodLv:setVisible(not isShow)
  self.animationMgr:runAnimations(isShow and "shining" or "normal")
end
function prototype:Refresh(data)
  self:clear()
  if table.empty(data or {}) then
    return
  end
  self:setSpriteAdd(false)
  self:refreshHeroIcon(data.baseId)
  self.labLv:create(data.level or 1, "YELLOW_E_NUM")
  self.labLv:setAlign("LEFT", "CENTER")
  Logic:Get("HeroCardInfo"):AddShanCardSmall(self.sprIcon, data.baseId)
end
function prototype:clear()
  self:setSpriteAdd(true)
  Logic:Get("HeroCardInfo"):ClearShanCardSmall(self.sprIcon)
  self:refreshHeroIcon(nil)
end
function prototype:refreshIcon(data)
  if table.empty(data or {}) then
    return
  end
  self:setSpriteAdd(false)
  local strBg = string.format("data/MiddleBg/%d.png", data.iconRank)
  local strPath = data.iconPath
  self.labLv:create(data.level or 1, "YELLOW_E_NUM")
  self.labLv:setAlign("LEFT", "CENTER")
  self:refreshIconByPath(strBg, strPath)
end
function prototype:refreshHeroIcon(baseId)
  local clarity = "images/public/clarity05.png"
  local heroBg = "images/public/card_bkg.png"
  local strPath = baseId and Logic:Get("Hero"):GetHeroImage(baseId) or clarity
  local strBg = baseId and Logic:Get("Hero"):GetHeroBgImage(baseId) or heroBg
  self:refreshIconByPath(strBg, strPath)
end
function prototype:refreshIconByPath(bgPath, iconPath)
  local spr = CCSprite:create(bgPath)
  if spr then
    self.sprBg:setDisplayFrame(spr:displayFrame())
  end
  local spr = CCSprite:create(iconPath)
  if spr then
    self.sprIcon:setDisplayFrame(spr:displayFrame())
  end
end
