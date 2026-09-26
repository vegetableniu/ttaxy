module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
function prototype:onEnter(...)
  self.ttfName:setStyle(kCCLabelTTFStyleOutline)
  self.ttfState:setStyle(kCCLabelTTFStyleOutline)
end
function prototype:refresh(hero, state)
  if not hero then
    return
  end
  self.hero = hero
  self:refreshHero(hero)
  self:refreshState(state)
end
function prototype:refreshHero(hero)
  local gift = {}
  gift.showType = "HERO"
  gift.showId = hero.baseId
  self.ccbIcon:ReFreshByGift(gift)
  local rec = Logic:Get("Hero"):GetHeroInfoByBaseId(hero.baseId) or {}
  self.ttfName:setString(rec.name or "")
end
function prototype:refreshState(state)
  local name = Logic:Get("Cultivate"):GetStateName(state)
  self.ttfState:setString(name or "")
end
function prototype:onBtnIcon(...)
  if not self.hero then
    return
  end
  Logic:Get("HeroCardInfo"):OpenHeroInfoByNparma(self.hero)
end
function prototype:onBtnItem(...)
  if not self.hero then
    return
  end
  if SceneHelper:isExistScene("CultivateComposeMedicine") then
    SceneHelper:removeScene("CultivateComposeMedicine")
  end
  if SceneHelper:isExistScene("CultivatePillInfo") then
    SceneHelper:removeScene("CultivatePillInfo")
  end
  if SceneHelper:isExistScene("Cultivate") then
    SceneHelper:removeScene("Cultivate")
  end
  Logic:Get("Cultivate"):setSelectHero(self.hero)
  SceneHelper:pushScene("Cultivate")
end
