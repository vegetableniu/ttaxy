module((...), package.seeall)
require("SceneHelper")
require("BtnPosition")
prototype = BtnPosition.prototype:extend()
function prototype:onEnter()
end
function prototype:setHero(baseId, level)
  self.baseId = baseId
  self.level = level
  local node = Logic:Get("HeroCardInfo"):createHeroCard(baseId, 200)
  self.rootNode:addChild(node, 0, 2)
  node:setPosition(self.heroSpr:getPosition())
  local fdb_baseHero = Logic:Get("HeroCardInfo"):kdbBaseHero(baseId)
  if fdb_baseHero ~= nil then
    self.ttfName:setString(fdb_baseHero.name)
  end
  local color = Logic:Get("Hero"):getColorByBaseId(baseId)
  self.ttfName:setStyle(kCCLabelTTFStyleOutline)
  self.ttfName:setColor(color)
end
function prototype:onBtnHeroInfo()
  local heroInfo = {
    exp = 0,
    id = 68719480211,
    level = self.level or 1,
    baseId = self.baseId or 1,
    powerSkill = 0
  }
  Logic:Get("HeroCardInfo"):OpenHeroInfoByNparma(heroInfo)
end
function prototype:setCardData(cardData)
  self.cardData = cardData or {}
  if cardData.showType == "HERO" then
    self:setHero(cardData.showId, cardData.level)
    return
  end
  if cardData.showType == "TALISMAN" then
    local rec = KFDBGetRecord("TalismanSetting", cardData.showId)
    self:setHero(rec.baseId, cardData.level)
    return
  end
  if cardData.showType == "EQUIPMENT" then
    self:setArmor(cardData.showId, cardData.level)
  end
end
function prototype:setArmor(baseId, level)
  self.baseId = baseId
  self.level = level
  local rec = Logic:Get("Armor"):getArmorInfoByBaseId(baseId)
  if rec then
    local color = Logic:Get("Armor"):getColorByBaseId(baseId)
    self.ttfName:setColor(color)
    self.ttfName:setStyle(kCCLabelTTFStyleOutline)
    self.ttfName:setString(rec.name)
    local sprArmor = Logic:Get("Armor"):createArmorCard(baseId)
    local texture, textureRect = Logic:Get("HeroCardInfo"):GetCardTexture(sprArmor, sprArmor:getContentSize())
    if texture and textureRect then
      self.heroSpr:setTexture(texture)
      self.heroSpr:setTextureRect(textureRect)
      Logic:Get("Armor"):addStarLv(self.sprArmor, baseId)
    end
  end
end
function prototype:onBtnConsume()
  if table.empty(self.cardData) then
    return
  end
  if self.cardData.showType == "HERO" then
    local heroInfo = {
      exp = 0,
      id = 68719480211,
      level = self.cardData.level,
      baseId = self.cardData.showId or 1,
      powerSkill = 0
    }
    Logic:Get("HeroCardInfo"):OpenHeroInfoByNparma(heroInfo)
    return
  end
  if self.cardData.showType == "TALISMAN" then
    local level = self.cardData.level and 0 < self.cardData.level and self.cardData.level or 1
    local talisman = {
      id = "2.816455e+014",
      level = level,
      baseId = self.cardData.showId,
      exp = 0
    }
    Logic:Get("HeroCardInfo"):OpenTailsman(talisman)
    return
  end
  if self.cardData.showType == "EQUIPMENT" then
    Logic:Get("Armor"):openArmorDetails(self.cardData.showId)
  end
end
