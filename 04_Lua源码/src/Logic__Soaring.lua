require("Logic")
module((...), package.seeall)
EVT = Enum({
  "SELECTED_CARD",
  "SOARING_SUCCESSED"
})
METRIAL_RESULT = Enum({
  "ENOUGH",
  "LEVEL_NOT_ENOUGH",
  "METRIAL_NOT_ENOUGH"
})
class = Logic.class:subclass()
function class:initialize()
  super.initialize(self)
  self.selectedCard = {}
  self.sameNameIdMap = {}
  self.costMetrials = {}
  MsgHero:On("COST_RANK_UP", self:Event("OnCostRankUp"))
end
function class:dispose()
  super.dispose(self)
end
function class:setSelectedCard(cardInfo)
  self.selectedCard = cardInfo
end
function class:getSelectedCard()
  return self.selectedCard
end
function class:getCostMetrials()
  return self.costMetrials
end
function class:createSameIdMap()
  local allCards = Logic:Get("Hero"):GetAllHeroInfo()
  self.sameNameIdMap = {}
  for i, hero in pairs(allCards.heros or {}) do
    local heroInfo = Logic:Get("Hero"):GetHeroInfoByBaseId(hero.baseId)
    self.sameNameIdMap[heroInfo.sameNameId] = self.sameNameIdMap[heroInfo.sameNameId] or {}
    table.insert(self.sameNameIdMap[heroInfo.sameNameId], hero)
  end
end
function class:getSoaringList()
  local heros = Logic:Get("Hero"):GetUnbattlingHero(true)
  heros = Logic:Get("Hero"):GetHeroInfosByIds(heros)
  local cardList = {}
  for i, card in ipairs(heros) do
    local rec = KFDBGetRecord("HeroCostRankUp", card.baseId)
    if rec ~= nil then
      table.insert(cardList, card)
    end
  end
  table.sort(cardList, function(param1, param2)
    local result1 = self:canSoaring(param1)
    local result2 = self:canSoaring(param2)
    if result1 ~= result2 then
      return result1 < result2
    end
    local costInfo1 = KFDBGetRecord("HeroCostRankUp", param1.baseId)
    local costInfo2 = KFDBGetRecord("HeroCostRankUp", param2.baseId)
    if costInfo1.sort ~= costInfo2.sort then
      return costInfo1.sort > costInfo2.sort
    end
    local info1 = Logic:Get("Hero"):GetHeroInfoByBaseId(param1.baseId)
    local info2 = Logic:Get("Hero"):GetHeroInfoByBaseId(param2.baseId)
    if not info1 or not info2 then
      return false
    end
    if info1.star ~= info2.star then
      return info1.star < info2.star
    end
    if param1.level ~= param2.level then
      return param1.level < param2.level
    end
    return param1.baseId > param2.baseId
  end)
  return cardList
end
function class:canSoaring(cardInfo)
  local metrials = self:getMetrialById(cardInfo.baseId, true)
  if table.empty(metrials or {}) then
    return METRIAL_RESULT.METRIAL_NOT_ENOUGH
  end
  local heroInfo = Logic:Get("Hero"):GetHeroInfoByBaseId(cardInfo.baseId)
  if cardInfo.level < metrials[heroInfo.sameNameId].minLevel then
    return METRIAL_RESULT.LEVEL_NOT_ENOUGH
  end
  for sameNameId, data in pairs(metrials) do
    if table.size(data.list) < data.amount then
      return METRIAL_RESULT.METRIAL_NOT_ENOUGH
    end
  end
  return METRIAL_RESULT.ENOUGH
end
function class:getMetrialById(costRankId, noSort)
  local rec = KFDBGetRecord("HeroCostRankUp", costRankId or 0)
  if table.empty(rec or {}) then
    return {}
  end
  local metrials = {}
  local sameNameIds = json.decode(rec.costSameNameId or "[]")
  local minLevels = json.decode(rec.costMinLevel or "[]")
  local minStars = json.decode(rec.costMinStar or "[]")
  local function isFitCard(cardInfo, heroinfo)
    local metrialData = metrials[heroinfo.sameNameId]
    if metrialData == nil then
      return false
    end
    if cardInfo.locked then
      return false
    end
    local battleHero = Logic:Get("Hero"):GetAllFightHero()
    for i, id in ipairs(battleHero) do
      if id == cardInfo.id then
        return false
      end
    end
    if heroinfo.star < metrialData.minStar then
      return false
    end
    if cardInfo.level < metrialData.minLevel then
      return false
    end
    return true
  end
  local getBaseId = function(sameNameId, star)
    local maxStar = 20
    for i = 0, maxStar do
      local rec = Logic:Get("Hero"):GetHeroInfoByBaseId(sameNameId + i) or {}
      if rec.star == star then
        return rec.id
      end
    end
    return nil
  end
  for i, sameNameId in ipairs(sameNameIds) do
    metrials[sameNameId] = metrials[sameNameId] or {}
    metrials[sameNameId].amount = metrials[sameNameId].amount or 0
    metrials[sameNameId].amount = metrials[sameNameId].amount + 1
    metrials[sameNameId].minLevel = minLevels[i]
    metrials[sameNameId].minStar = minStars[i]
    metrials[sameNameId].baseId = getBaseId(sameNameId, minStars[i])
    metrials[sameNameId].list = {}
    for id, v in pairs(self.sameNameIdMap[sameNameId] or {}) do
      local heroinfo = Logic:Get("Hero"):GetHeroInfoByBaseId(v.baseId)
      if isFitCard(v, heroinfo) then
        table.insert(metrials[heroinfo.sameNameId].list, v)
        if not noSort then
          table.sort(metrials[heroinfo.sameNameId].list, function(a, b)
            local heroinfoA = Logic:Get("Hero"):GetHeroInfoByBaseId(a.baseId)
            local heroinfoB = Logic:Get("Hero"):GetHeroInfoByBaseId(b.baseId)
            if heroinfoA.star ~= heroinfoB.star then
              return heroinfoA.star < heroinfoB.star
            end
            return a.level < b.level
          end)
        end
      end
    end
  end
  return metrials
end
function class:PostCostRankUp()
  local rec = KFDBGetRecord("HeroCostRankUp", self.selectedCard.baseId) or {}
  local costSameNameId = json.decode(rec.costSameNameId or "[]")
  local heroInfo = Logic:Get("Hero"):GetHeroInfoByBaseId(self.selectedCard.baseId)
  local metrials = self:getMetrialById(self.selectedCard.baseId)
  self.costMetrials = {}
  local heroIds = {}
  for i, sameNameId in ipairs(costSameNameId) do
    if sameNameId == heroInfo.sameNameId then
      table.insert(heroIds, self.selectedCard.id)
    else
      table.insert(heroIds, metrials[sameNameId].list[1].id)
      table.insert(self.costMetrials, metrials[sameNameId].list[1].baseId)
      table.remove(metrials[sameNameId], 1)
    end
  end
  MsgHero:Post("COST_RANK_UP", {
    heroIds = heroIds,
    configId = self.selectedCard.baseId
  })
end
function class:OnCostRankUp(code, data)
  if code ~= 0 then
    return
  end
  Logic:Get("Cost"):AddCosts(data.costs)
  Logic:Get("Reward"):AddRewards(data.rewards)
  self:createSameIdMap()
  self:FireEvent(EVT.SOARING_SUCCESSED)
end
