module((...), package.seeall)
class = Logic.class:subclass()
REWARDS_TYPE = TypeDef("com.eyu.mt.module.reward.model.RewardType")
function class:initialize()
  super.initialize(self)
end
function class:GetEquipStr(baseId)
  if baseId == nil then
    return
  end
  local item = KFDBGetRecord("ItemConfig", baseId)
  if item == nil then
    log4misc:warn("item:baseId:" .. baseId)
    return "images/public/clarity80.png"
  else
    return item.MiddleCard
  end
end
function class:GetEquipAmount(baseId)
  local amount = 0
  local arrItem = Logic:Get("Compose"):GetArrItem()
  for i = 1, #arrItem do
    if tonumber(baseId) == arrItem[i].baseId then
      amount = amount + arrItem[i].amount
    end
  end
  return amount
end
function class:GetGoodsSpr(baseId, reType)
  if nil == baseId or nil == reType then
    return
  end
  if reType == REWARDS_TYPE.ITEM then
    return self:GetEquipSpr(baseId)
  elseif reType == REWARDS_TYPE.EQUIP then
    return self:GetEquipSpr(baseId)
  elseif reType == REWARDS_TYPE.FRAGMENT then
    return self:GetComposeImg(baseId)
  elseif reType == REWARDS_TYPE.HERO then
    return self:GetHeroImg(baseId)
  elseif reType == REWARDS_TYPE.EXP_CARD then
    return self:GetHeroImg(baseId)
  elseif reType == REWARDS_TYPE.COIN_CARD then
    return self:GetHeroImg(baseId)
  elseif reType == REWARDS_TYPE.TREASURE then
    return self:GetHeroImg(baseId)
  elseif reType == REWARDS_TYPE.EQUIPMENT then
    return self:GetEquipment(baseId)
  elseif reType == REWARDS_TYPE.EQUIPMENT_FRAGMENT then
    return self:GetEquipmentFra(baseId)
  elseif reType == REWARDS_TYPE.EQUIPMENT_MATERIAL then
    return self:GetEquipMaterial(baseId)
  elseif reType == REWARDS_TYPE.CULTIVATE_MATERIAL then
    return self:GetPillMaterial(baseId)
  end
end
function class:GetEquipSpr(baseId, reType)
  local ccSprite = CCSprite:create("data/MiddleBg/1.png")
  local str = self:GetEquipStr(baseId)
  local euqipSpr = CCSprite:create(str)
  if euqipSpr == nil or str == nil then
    return ccSprite
  end
  ccSprite:setAnchorPoint(CCPoint(0.5, 0.5))
  ccSprite:addChild(euqipSpr, 0, 0)
  euqipSpr:setAnchorPoint(CCPoint(0, 0))
  return ccSprite
end
function class:GetComposeImg(baseId)
  local fraConfig = Logic:Get("Compose"):kdbItemConfig(baseId)
  local comSpr = CCSprite:create("images/HeroCardInfo/composeItem.png")
  if fraConfig == nil then
    return comSpr
  end
  local sprFram = Logic:Get("Compose"):GetItemsFrame(tonumber(fraConfig.quality))
  local sprGoods = Logic:Get("Compose"):GetFraImg(baseId)
  if sprFram == nil or sprGoods == nil then
    return comSpr
  end
  sprFram:setAnchorPoint(CCPoint(0.5, 0.5))
  sprFram:addChild(sprGoods, 0, 0)
  sprGoods:setAnchorPoint(CCPoint(0, 0))
  sprFram:addChild(comSpr, 0, 0)
  comSpr:setAnchorPoint(CCPoint(0, 0))
  return sprFram
end
function class:GetHeroImg(baseId)
  local ccSprite = CCSprite:create("data/MiddleBg/1.png")
  local str = Logic:Get("Hero"):GetHeroBgImage(baseId, Logic.Hero.HEROIMG_SIZE.MIDDLE)
  local heroStr = Logic:Get("Hero"):GetHeroImage(baseId, Logic.Hero.HEROIMG_SIZE.MIDDLE)
  if str == nil or heroStr == nil then
    log4misc:warn("Hero.baseId:" .. baseId)
    str = "images/public/herobg.png"
    local sprBg = CCSprite:create(str)
    return sprBg
  end
  local heroBg = CCSprite:create(str)
  local heroSpr = CCSprite:create(heroStr)
  if heroBg == nil or heroSpr == nil then
    return ccSprite
  end
  ccSprite:setAnchorPoint(CCPoint(0.5, 0.5))
  ccSprite:addChild(heroBg, 0, 0)
  heroBg:setAnchorPoint(CCPoint(0, 0))
  ccSprite:addChild(heroSpr, 0, 0)
  heroSpr:setAnchorPoint(CCPoint(0, 0))
  return ccSprite
end
function class:GetEquipName(equipId)
  return KFDBGetRecord("ItemConfig", equipId).name or ""
end
function class:GetEquipmentFra(baseId)
  local rec = Logic:Get("Armor"):getArmorInfoByBaseId(baseId)
  local comSpr = CCSprite:create("images/HeroCardInfo/composeItem.png")
  if not rec then
    return comSpr
  end
  local spr = self:GetEquipment(baseId)
  if not spr then
    return comSpr
  end
  spr:addChild(comSpr, 0, 0)
  comSpr:setAnchorPoint(CCPoint(0, 0))
  return spr
end
function class:GetEquipment(baseId)
  local rec = Logic:Get("Armor"):getArmorInfoByBaseId(baseId)
  local comSpr = CCSprite:create("images/HeroCardInfo/composeItem.png")
  if not rec then
    return comSpr
  end
  local bgPath = Logic:Get("Armor"):getArmorImgBg(baseId)
  local iconPath = Logic:Get("Armor"):getArmorImg(baseId)
  local sprBg = CCSprite:create(bgPath)
  local sprIcon = CCSprite:create(iconPath)
  if not sprBg or not sprIcon then
    return comSpr
  end
  sprBg:setAnchorPoint(CCPoint(0.5, 0.5))
  sprBg:addChild(sprIcon, 0, 0)
  sprIcon:setAnchorPoint(CCPoint(0, 0))
  return sprBg
end
function class:GetEquipMaterial(code)
  local spr = CCSprite:create("images/public/clarity05.png")
  local DATA = {
    [0] = {showId = 4, showType = "PURPLE"},
    [1] = {showId = 6, showType = "ORANGE"},
    [2] = {showId = 7, showType = "RED"}
  }
  if not DATA[code] then
    return spr
  end
  local sprBg = Logic:Get("Gift"):createImg(DATA[code])
  local sprIcon = Logic:Get("Gift"):createGoodsImg(DATA[code])
  if not sprBg or not sprIcon then
    return spr
  end
  sprBg:setAnchorPoint(CCPoint(0.5, 0.5))
  sprBg:addChild(sprIcon, 0, 0)
  sprIcon:setAnchorPoint(CCPoint(0, 0))
  return sprBg
end
function class:GetPillMaterial(code)
  local comSpr = CCSprite:create("images/HeroCardInfo/composeItem.png")
  local bgPath = Logic:Get("Cultivate"):getStuffImgBg(code)
  local iconPath = Logic:Get("Cultivate"):getStuffImg(code)
  local sprBg = CCSprite:create(bgPath)
  local sprIcon = CCSprite:create(iconPath)
  if not sprBg or not sprIcon then
    return comSpr
  end
  sprBg:setAnchorPoint(CCPoint(0.5, 0.5))
  sprBg:addChild(sprIcon, 0, 0)
  sprIcon:setAnchorPoint(CCPoint(0, 0))
  return sprBg
end
