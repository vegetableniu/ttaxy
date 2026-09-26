module((...), package.seeall)
require("SceneHelper")
class = Logic.class:subclass()
EVO_TYPE = Enum({
  "MATERIAL_EVO",
  "PAY_MONEY_EVO",
  "CLOSE_PROMPT"
})
CARD_TYPE = {EXP_CARD = 1, HERO = 2}
function class:initialize()
  super.initialize(self)
  self.suitInfo = nil
  self.noEnoughCondition = {}
  self.evolutionType = nil
  self.page = 1
end
function class:OpenStuffInfo(baseId)
  Logic:Get("HeroCardInfo"):OpenHeroInfoById(baseId)
end
function class:GetSuitInfo()
  return self.suitInfo
end
function class:removeSelf(totalHerosId)
  local result = {}
  for i = 1, #totalHerosId do
    if self.hero.id == totalHerosId[i] then
      table.remove(totalHerosId, i)
      break
    end
  end
  result = totalHerosId
  return result
end
function class:IsStuffEnough(info)
  if info == nil then
    return false
  end
  if #info.costHeros == 0 then
    return true
  end
  local equipTable = json.decode(info.costHeros)
  for key, value in pairs(equipTable) do
    local countNum = 0
    local heroNum = Logic:Get("Hero"):GetTotalCardByBaseId(tonumber(key))
    heroNum = self:removeSelf(heroNum)
    local totalHeros = Logic:Get("Hero"):GetHeroInfosByIds(heroNum)
    for i = 1, #heroNum do
      if Logic:Get("Hero"):CheckHeroBattleOrGroup(heroNum[i]) or totalHeros[i].locked then
        countNum = countNum + 1
      end
    end
    if #heroNum < value + countNum then
      return false
    end
  end
  return true
end
function class:AnalyseCondition(hero, info)
  local result = 106011
  self.hero = hero
  if Logic:Get("ExplainEquip"):getEvolutionType() == EVO_TYPE.PAY_MONEY_EVO then
    if hero.level < info.level then
      result = 106012
    end
  else
    local money = Logic:Get("PlayerInfo"):GetPlayerMoney()
    if hero.level < info.level then
      result = 106012
    elseif not self:IsStuffEnough(info) then
      result = 106013
    elseif money.copper < info.costCoins then
      result = 106014
    end
  end
  return result
end
function class:EvolutionSortCondition(currHero, currHeroInfo, nextHero, nextHeroInfo)
  if 106011 == currHero.evolutionType and 106011 ~= nextHero.evolutionType then
    return true
  elseif 106011 == nextHero.evolutionType and 106011 ~= currHero.evolutionType then
    return false
  else
    if self.evolutionType == EVO_TYPE.PAY_MONEY_EVO then
      if 106013 == currHero.evolutionType and 106013 ~= nextHero.evolutionType then
        return true
      elseif 106013 == nextHero.evolutionType and 106013 ~= currHero.evolutionType then
        return false
      end
    end
    if CARD_TYPE[currHeroInfo.card] and CARD_TYPE[nextHeroInfo.card] and CARD_TYPE[currHeroInfo.card] ~= CARD_TYPE[nextHeroInfo.card] then
      return CARD_TYPE[currHeroInfo.card] > CARD_TYPE[nextHeroInfo.card]
    else
      return currHeroInfo.star == nextHeroInfo.star and currHeroInfo.id > nextHeroInfo.id or currHeroInfo.star > nextHeroInfo.star
    end
  end
end
function class:IsAbilityEvolutionById(id)
  local hero = Logic:Get("Hero"):GetHeroInfoById(id)
  local heroInfo = Logic:Get("Hero"):GetHeroInfoByBaseId(hero.baseId)
  local result = 106011 == self:AnalyseCondition(hero, heroInfo)
  return result
end
function class:setNoEnoughCondition(str)
  table.insert(self.noEnoughCondition, str)
end
function class:getNoEnoughCondition()
  local temp = self.noEnoughCondition
  self:initNoEnoughCondition()
  return temp
end
function class:initNoEnoughCondition()
  self.noEnoughCondition = {}
end
function class:setEvolutionType(evoType)
  self.evolutionType = evoType
end
function class:getEvolutionType()
  return self.evolutionType
end
function class:InitEvolutionType()
  self.evolutionType = nil
end
function class:getCurPage()
  return self.page
end
function class:setCurPage(page)
  self.page = page
end
