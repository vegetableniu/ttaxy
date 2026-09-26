module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
local RULE_DESC = 1033
function prototype:onEnter()
  self.ttfName:setStyle(kCCLabelTTFStyleOutline)
  self.ttfLife:setStyle(kCCLabelTTFStyleOutline)
  self.ttfAtk:setStyle(kCCLabelTTFStyleOutline)
  local rec = KFDBGetRecord("LanguageSetting", RULE_DESC)
  if rec and rec.content then
    self.ttfRule:setString(ReplaceStringTab(rec.content or ""))
  end
  self:refreshReward()
end
function prototype:refreshReward()
  local rewardId = Logic:Get("Football"):getFinalReward()
  if rewardId == 0 then
    return
  end
  local heroInfo = Logic:Get("Hero"):GetHeroInfoByBaseId(rewardId)
  if not heroInfo or table.empty(heroInfo) then
    return
  end
  self.heroInfo = {
    baseId = heroInfo.id,
    level = heroInfo.level,
    powerSkill = tonumber(heroInfo.powerSkill)
  }
  local heroName = Logic:Get("Hero"):GetHeroName(rewardId)
  if heroName then
    local color = Logic:Get("Hero"):getColorByBaseId(rewardId)
    self.ttfName:setColor(color)
    self.ttfName:setString(heroName)
  end
  local nLife, nAttack = Logic:Get("Hero"):GetHeroLifeAndAttack(rewardId, heroInfo.level)
  if nLife and nAttack then
    self.ttfLife:setString(tostring(nLife))
    self.ttfAtk:setString(tostring(nAttack))
  end
  local cardNode
  cardNode = Logic:Get("HeroCardInfo"):GetSprCard(rewardId, nil, true)
  if cardNode then
    local texture = Logic:Get("HeroCardInfo"):GetCardTexture(cardNode)
    self.sprHero:setTexture(texture)
    self.sprHero:setTextureRect(cardNode:getTextureRect())
  end
  Logic:Get("HeroCardInfo"):AddShanCard(self.sprHero, rewardId, nil, nil, true)
  self.ttfDesc:setDimensions(CCSize(450, 0))
  self.ttfDesc:setString(heroInfo.description)
end
function prototype:onBtnReturn(sender, event)
  SceneHelper:popScene()
end
function prototype:onBtnHero(sender, event)
  if not self.heroInfo or table.empty(self.heroInfo) then
    return
  end
  Logic:Get("HeroCardInfo"):OpenHeroInfoByNparma(self.heroInfo)
end
