module((...), package.seeall)
require("utf8")
require("Logic")
class = Logic.class:subclass()
local MATERIAL_TYPE = TypeDef("com.eyu.mt.module.equip.model.MaterialType")
local ARMOR_TYPE = Enum({
  "BLUE",
  "PURPLE",
  "ORANGE"
})
local ARMOR_POS_TYPE = {NECKLACE = 1, RING = 2}
local ARMOR_RANK = {
  [3] = ARMOR_TYPE.BLUE,
  [4] = ARMOR_TYPE.PURPLE,
  [5] = ARMOR_TYPE.PURPLE,
  [6] = ARMOR_TYPE.ORANGE,
  [7] = ARMOR_TYPE.ORANGE
}
local PROP_SORT = {
  PCT_ATTACK = 0,
  ATTACK = 1,
  PCT_LIFE = 2,
  LIFE = 3,
  RATE_DODGY = 4,
  RATE_HIT = 5,
  RATE_CRIT = 6,
  RATE_HURT_CRIT = 7,
  RATE_HARM_P = 8,
  RATE_HARM_M = 9,
  RATE_UNHARM_P = 10,
  RATE_UNHARM_M = 11,
  RATE_UNCRIT = 12,
  RATE_UNHURT_CRIT = 13
}
local ERROR_CODE = TypeDef("com.eyu.mt.module.equip.facade.EquipResult")
local MSG_RESULT = Enum(TypeDef("com.eyu.mt.module.equip.facade.EquipResult"))
local MSG_RESULT_STR = {
  PACK_EXTEND_COUNT_LIMIT = 111571,
  FRAGMENTS_IS_NOT_ENOUGH = 111572,
  PLAYER_LEVEL_LIMIT = 111573,
  EQUIP_PACK_IS_FULL = 111574,
  BASE_EQUIP_IS_NOT_EXSIT = 111575,
  CURRENCY_IS_NOT_ENOUGH = 111576,
  MATERIAL_IS_NOT_ENOUGH = 111577,
  CAN_NOT_UPGRADE = 111578,
  UNIT_TYPE_LIMIT = 111579,
  EQUIPED_POSITION_LIMIT = 111580,
  MAX_EQUIPED = 111581,
  EQUIP_OTHER_POSITION = 111582,
  OTHER_EQUIPED = 111583,
  NONE_EQUIPED = 111584,
  ALREADY_EQUIPED = 111585,
  NO_RELATIVE_HERO = 111586,
  NO_RELATIVE_EQUIP = 111587,
  CAN_NOT_MELT_MATERIAL = 111588,
  NO_EQUIP_RELATIVE_EQUIP_OR_POSITION = 111589,
  CAN_BE_COMPOSE = 111590
}
ARMOR_SIZE = Enum({"BIG", "MIDDLE"})
EVT = Enum({
  "CHANGE_HERO_INFO",
  "CHANGE_ARMOR_OK",
  "RANK_UP_OK",
  "ON_COMPOSE",
  "ON_MELT",
  "REFRESH_CELL",
  "REFRESH_SMELT_LIST",
  "ON_EQUIP_PACK",
  "ON_ARMORS_CHANGED",
  "REMOVE_EQUIP",
  "REFRESH_TABLE",
  "SET_TOUCH_ENABLED"
})
local DEFAULT_IMG = "images/public/clarity05.png"
local DEFAULT_BG = "images/public/herobg.png"
local createArray = function(map)
  if not map then
    return
  end
  local array = {}
  for k, v in pairs(map) do
    table.insert(array, {k, v})
  end
  return array
end
function class:initialize()
  super.initialize(self)
  self.unEquipArmors = {}
  self.fragments = {}
  self.materials = {}
  self.smeltIds = {}
  self.tempSmeltIds = {}
  self.smeltMat = {}
  self.smeltMat[MATERIAL_TYPE.PURPLE] = 0
  self.smeltMat[MATERIAL_TYPE.ORANGE] = 0
  self.bDisabled = false
  self.armorMap = {}
  self.heroId = nil
  self.pos = nil
  self.curRankArmor = nil
  self.rankSeleFormRank = false
  self.packInfo = {}
  self.materialsMap = {}
  self.fragmentsMap = {}
  self.cardInfo = {}
  self:initXlsValue()
  Logic:Get("MsgAssist"):RecordErrorMsg("MsgEquip", MSG_RESULT, MSG_RESULT_STR)
  MsgEquip:On("EQUIP", self:Event("OnEquip"))
  MsgEquip:On("COMPOSE", self:Event("OnCompose"))
  MsgEquip:On("MELT", self:Event("OnMelt"))
  MsgEquip:On("BUY_EQUIP_PACK_SPACE", self:Event("OnBuyEquipPack"))
  MsgEquip:On("LOAD_EQUIP_PACK", self:Event("OnGetEquipPackInfo"))
  MsgEquip:On("UNEQUIP_POSITION", self:Event("OnUnEquip"))
  MsgEquip:On("UPGRADE", self:Event("OnUpgrade"))
  MsgEquip:On("BUY_EQUIP_PACK_SPACE_BY_COUPON", self:Event("OnBuyEquipPackSpaceByCoupon"))
end
function class:initXlsValue()
  local rec = KFDBGetRecord("ConfigValue", "ELITE:CAN_MELT_MATERIAL")
  if rec and rec.content then
    self.canSmeltMateiral = rec.content == "TRUE"
  end
end
function class:OnEquip(code, data)
  if not data then
    return
  end
  self:changeArmor(data)
  self:FireEvent(EVT.CHANGE_ARMOR_OK)
end
function class:OnCompose(code, data)
  local armorInfo = {}
  armorInfo.id = data.id
  armorInfo.baseId = data.baseid
  self:addOneArmor(armorInfo)
  self:CostFragments(data.fragments)
  self:FireEvent(EVT.ON_COMPOSE, data.fragments, data.baseid)
end
function class:OnMelt(code, data)
  for _, v in ipairs(self.smeltIds) do
    self:removeOneArmor(v)
  end
  self:ClearSmeltList()
  Logic:Get("Reward"):AddRewards(data)
  self:FireEvent(EVT.ON_MELT, data)
  self:FireEvent(EVT.ON_ARMORS_CHANGED)
end
function class:OnBuyEquipPack(code, data)
  self.packInfo.buyPackCounts = self.packInfo.buyPackCounts + 1
  local size = KFDBGetRecord("ConfigValue", "EQUIP:PACK_EXTEND_SPACE")
  size = size and tonumber(size.content) or 0
  self.packInfo.buyPackCells = self.packInfo.buyPackCells + size
  Logic:Get("Cost"):AddCosts(data)
  Prompt:Tip(TwGetStr(111407))
end
function class:OnGetEquipPackInfo(code, data)
  self.packInfo.buyPackCounts = data.extendCount
  self.packInfo.buyPackCells = data.extendLimit
  self.packInfo.usedCells = data.usedSpace
  self.materialsMap = data.materials
  self.fragments = data.fragments
  self:FireEvent(EVT.ON_EQUIP_PACK)
end
function class:OnUnEquip(code, data)
  if not self.heroId or not self.pos or not data then
    return
  end
  for i, v in pairs(self.armorMap) do
    if v.equipHero == self.heroId and v.position == self.pos then
      self.armorMap[i].equipHero = nil
      self.armorMap[i].position = nil
      break
    end
  end
  if self.unEquipType == nil then
    self:FireEvent(EVT.CHANGE_ARMOR_OK)
    return
  end
  self:FireEvent(EVT.REMOVE_EQUIP)
end
function class:OnUpgrade(code, data)
  for i, v in pairs(data.materials) do
    self.materialsMap[i] = self.materialsMap[i] - v
  end
  self.armorMap[data.equipVo.id] = data.equipVo
  Logic:Get("Cost"):AddCosts(data.costResults)
  self:FireEvent(EVT.RANK_UP_OK)
end
function class:PostEquip(equipId)
  MsgEquip:Post("EQUIP", {
    hero = self.heroId,
    id = equipId,
    position = self.pos
  })
end
function class:PostCompose(armorBaseId)
  if not armorBaseId then
    return
  end
  self.fragmentBaseId = armorBaseId
  MsgEquip:Post("COMPOSE", {baseId = armorBaseId})
end
function class:PostMelt(ids, materials)
  if not ids then
    return
  end
  if table.empty(ids) then
    Prompt:Confirm(self, "", 111136)
    return
  end
  local smeltData = {ids = ids}
  if not self.canSmeltMateiral then
    smeltData.materials = {}
  elseif not table.empty(materials) then
    smeltData.materials = materials
  end
  MsgEquip:Post("MELT", smeltData)
end
function class:PostBuyEquipPack()
  MsgEquip:Post("BUY_EQUIP_PACK_SPACE")
end
function class:PostEquipPackInfo()
  MsgEquip:Post("LOAD_EQUIP_PACK")
end
function class:PostUnEquip()
  local armorId
  for i, v in pairs(self.armorMap) do
    if v.equipHero == self.heroId and v.position == self.pos then
      armorId = v.id
      break
    end
  end
  if armorId == nil then
    return
  end
  MsgEquip:Post("UNEQUIP_POSITION", {
    equipId = armorId,
    hero = self.heroId,
    position = self.pos
  })
end
function class:PostUpgrade(equipId)
  MsgEquip:Post("UPGRADE", {id = equipId})
end
function class:PostBuyEquipPackSpaceByCounpon()
  MsgEquip:Post("BUY_EQUIP_PACK_SPACE_BY_COUPON")
end
function class:GetFragments()
  local array = createArray(self.fragments)
  local function sort(a, b)
    local compose_a = self:CheckCanCompose(a[1])
    local compose_b = self:CheckCanCompose(b[1])
    if compose_a ~= compose_b then
      return compose_a
    end
    local rec_a = self:getArmorInfoByBaseId(a[1])
    local rec_b = self:getArmorInfoByBaseId(b[1])
    if rec_a and rec_a.rank and rec_b and rec_b.rank then
      return rec_a.rank > rec_b.rank
    end
    return false
  end
  table.sort(array, sort)
  return array
end
function class:GetArmorsAuto(armorType)
  armorType = armorType or ARMOR_TYPE.BLUE
  local checkedList = self:GetCheckedSmelt() or {}
  local count = 5 - #checkedList
  local unEquipArmors = self:getUnEquipArmors()
  for k, v in pairs(unEquipArmors) do
    if count == 0 then
      break
    end
    local rec = self:getArmorInfoByBaseId(v.baseId)
    if rec and ARMOR_RANK[rec.rank] == armorType then
      local autoSelect = self:CheckAutoSelect(v.baseId)
      if autoSelect and not self:isInSmeltIds(v.id) then
        table.insert(self.smeltIds, v.id)
        count = count - 1
      end
    end
  end
  local baseIds = self:GetCheckedSmeltBaseId()
  return self.smeltIds, baseIds
end
function class:CheckAutoSelect(baseId)
  if not baseId then
    return
  end
  local rec = self:getArmorInfoByBaseId(baseId) or {}
  return rec and rec.autoSelect == 1
end
function class:CheckCanCompose(baseId)
  if not baseId then
    return
  end
  local rec = self:getArmorInfoByBaseId(baseId)
  local composeBaseId = rec and rec.fragmentCode
  local count = rec and rec.fragments
  if not composeBaseId or not count then
    return
  end
  if self.fragments and self.fragments[composeBaseId] and count <= self.fragments[composeBaseId] then
    return true, count
  end
  return false, count
end
function class:isInSmeltIds(armorId)
  for _, v in pairs(self.smeltIds) do
    if v == armorId then
      return true
    end
  end
  return false
end
function class:AddToSmeltList(id, isMat)
  if not id then
    return
  end
  if isMat then
    self.smeltMat[id] = self.smeltMat[id] + 1
  else
    table.insert(self.tempSmeltIds, id)
  end
end
function class:DelFromSmeltList(id, isMat)
  if not id then
    return
  end
  if isMat then
    self.smeltMat[id] = self.smeltMat[id] - 1
  else
    for k, v in ipairs(self.tempSmeltIds) do
      if v == id then
        table.remove(self.tempSmeltIds, k)
      end
    end
  end
end
function class:IsSmeltFull()
  return #self.tempSmeltIds >= 5
end
function class:GetCheckedSmelt()
  return self.smeltIds, self.smeltMat
end
function class:GetCheckedSmeltBaseId()
  local baseIds = {}
  for i = 1, 5 do
    local armor = self.armorMap[self.smeltIds[i]]
    if armor then
      table.insert(baseIds, armor.baseId)
    end
  end
  return baseIds
end
function class:ClearSmeltList()
  self.smeltIds = {}
  self.smeltMat[MATERIAL_TYPE.PURPLE] = 0
  self.smeltMat[MATERIAL_TYPE.ORANGE] = 0
end
function class:GetCheckedTempSmelt()
  return self.tempSmeltIds
end
function class:initTempSmeltList()
  self.tempSmeltIds = table.values(self.smeltIds) or {}
end
function class:finalySmeltList()
  self.smeltIds = table.values(self.tempSmeltIds) or {}
end
function class:IsCheckSmelt(id)
  if not id then
    return false
  end
  for _, v in ipairs(self.tempSmeltIds) do
    if id == v then
      return true
    end
  end
  return false
end
function class:CheckRareArmor()
  if not self.smeltIds or table.empty(self.smeltIds) then
    return false
  end
  for i = 1, #self.smeltIds do
    local baseId = self.armorMap[self.smeltIds[i]].baseId
    local rec = self:getArmorInfoByBaseId(baseId) or {}
    if rec.rank and rec.rank >= 4 then
      return true
    end
  end
end
function class:CostFragments(amount)
  if not amount then
    return
  end
  self.fragments[self.fragmentBaseId] = self.fragments[self.fragmentBaseId] - amount
  if self.fragments[self.fragmentBaseId] <= 0 then
    self.fragments[self.fragmentBaseId] = nil
  end
end
function class:GetSmeltList()
  local smeltList = {}
  local unEquipArmors = self:getUnEquipArmors()
  local function getListByType(Type, isArmor)
    if not Type then
      return
    end
    if isArmor then
      for k, v in pairs(unEquipArmors) do
        local rec = self:getArmorInfoByBaseId(v.baseId)
        if rec and ARMOR_RANK[rec.rank] == Type then
          table.insert(smeltList, v)
        end
      end
    else
      for k, v in ipairs(self.materials) do
        if k == Type then
          v.isMat = true
          table.insert(smeltList, v)
        end
      end
    end
  end
  getListByType(ARMOR_TYPE.BLUE, true)
  getListByType(ARMOR_TYPE.PURPLE, true)
  if self.canSmeltMateiral then
    getListByType(MATERIAL_TYPE.PURPLE, false)
  end
  getListByType(ARMOR_TYPE.ORANGE, true)
  if self.canSmeltMateiral then
    getListByType(MATERIAL_TYPE.ORANGE, false)
  end
  return smeltList
end
function class:GetHeroBridles(heroBaseId)
  if not heroBaseId then
    return
  end
  local rec = KFDBGetRecord("BaseHero", heroBaseId)
  if rec and rec.weaponSet and rec.armorSet then
    local weaponSet = json.decode(rec.weaponSet)
    local armorSet = json.decode(rec.armorSet)
    if not weaponSet and not armorSet then
      return
    end
    local set = weaponSet or armorSet
    local bridleSet = {}
    for i = 1, #set do
      local strKey = string.format("%d_%d", heroBaseId, set[i])
      local item = KFDBGetRecord("EquipBuff", strKey)
      if item and item.alters then
        local bridle = json.decode(item.alters) or {}
        table.insert(bridleSet, bridle)
      end
    end
    local infoSet = {}
    infoSet.bridles = bridleSet
    infoSet.baseIds1 = armorSet
    infoSet.baseIds2 = weaponSet
    infoSet.count = #set
    return infoSet
  end
end
function class:PostRefreshCell()
  self:FireEvent(EVT.REFRESH_CELL)
end
function class:PostRefreshSmeltList()
  self:FireEvent(EVT.REFRESH_SMELT_LIST)
end
function class:changeHeroInfo(info)
  self:FireEvent(EVT.CHANGE_HERO_INFO, info)
end
function class:setEquipInfos(equipInfos)
  if not equipInfos or table.empty(equipInfos) then
    self.packInfo.usedCells = 0
    return
  end
  for i, v in ipairs(equipInfos) do
    self.armorMap[v.id] = v
  end
  self.packInfo.usedCells = #equipInfos
end
function class:checkArmorEquipState()
  if table.empty(self.armorMap) then
    return self.armorMap
  end
  local armorsMap = {}
  for k, v in pairs(self.armorMap) do
    if v.equipHero ~= nil then
      local hero = Logic:Get("Hero"):GetHeroInfoById(v.equipHero)
      if hero == nil then
        v.equipHero = nil
      end
    end
    armorsMap[v.id] = v
  end
  self.armorMap = armorsMap
  return armorsMap
end
function class:addOneArmor(armorInfo)
  if armorInfo == nil or table.empty(armorInfo) then
    return
  end
  self.armorMap[armorInfo.id] = armorInfo
  if self.packInfo and self.packInfo.usedCells then
    self.packInfo.usedCells = self.packInfo.usedCells + 1
  end
end
function class:removeOneArmor(armorId)
  if armorId == nil then
    return
  end
  self.armorMap[armorId] = nil
  if self.packInfo and self.packInfo.usedCells and self.packInfo.usedCells > 0 then
    self.packInfo.usedCells = self.packInfo.usedCells - 1
  end
end
function class:changeArmor(armorInfo)
  if not armorInfo or table.empty(armorInfo) then
    return
  end
  for i, v in pairs(self.armorMap) do
    if v.equipHero == armorInfo.equipHero and v.position == armorInfo.position then
      self.armorMap[i].equipHero = nil
      self.armorMap[i].position = nil
      break
    end
  end
  self.armorMap[armorInfo.id] = armorInfo
end
function class:getAltersByBaseId(armorBaseId)
  local info = self:getArmorInfoByBaseId(armorBaseId)
  local alters = {}
  if info and info.alters then
    alters = json.decode(info.alters or "[]") or {}
  end
  return alters
end
function class:getChooseArmors()
  if not self.heroId or table.empty(self.armorMap) then
    return {}, {}
  end
  local heroInfo = Logic:Get("Hero"):GetHeroInfoById(self.heroId)
  local info = Logic:Get("Hero"):GetHeroInfoByBaseId(heroInfo.baseId)
  if not self.pos or not info then
    return {}, {}
  end
  local canEquipArmors = {}
  local otherEquipArmors = {}
  for _, v in pairs(self.armorMap) do
    local armorInfo = self:getArmorInfoByBaseId(v.baseId)
    armorInfo.equipTypes = json.decode(armorInfo.equipTypes or "[]") or {}
    armorInfo.positions = json.decode(armorInfo.positions or "[]") or {}
    local chooseFlag = false
    v.isFitEquipType = false
    for i = 1, #armorInfo.equipTypes do
      if info.type == armorInfo.equipTypes[i] then
        v.isFitEquipType = true
      end
      if info.type == armorInfo.equipTypes[i] and (self.pos == armorInfo.positions[1] or self.pos == armorInfo.positions[2]) and (self.heroId == v.equipHero and v.position == self.pos or v.equipHero == nil) then
        v.unEquipState = false
        table.insert(canEquipArmors, v)
        chooseFlag = true
        break
      end
    end
    if not chooseFlag and self.pos == armorInfo.positions[1] or self.pos == armorInfo.positions[2] then
      v.unEquipState = true
      table.insert(otherEquipArmors, v)
    end
  end
  return canEquipArmors, otherEquipArmors
end
function class:getUnEquipArmors()
  local unEquipArmors = {}
  for _, v in pairs(self.armorMap) do
    if v.equipHero == nil then
      table.insert(unEquipArmors, v)
    end
  end
  return unEquipArmors
end
function class:getHeroEquipArmors(heroId)
  if not heroId or table.empty(self.armorMap) then
    return {}
  end
  local heroEquipArmors = {}
  for _, v in pairs(self.armorMap) do
    if v.equipHero == heroId then
      table.insert(heroEquipArmors, v)
    end
  end
  return heroEquipArmors
end
function class:getAllArmors()
  return table.values(self.armorMap)
end
function class:setChooseHeroId(heroId)
  self.heroId = heroId
end
function class:getChooseHeroId()
  return self.heroId
end
function class:setPosNum(pos)
  self.pos = pos
end
function class:getPosNum()
  return self.pos
end
function class:GetRoleSkin(armorBaseId, disabledFlag)
  local info = KFDBGetRecord("BaseEquip", armorBaseId)
  if info and info.modelId and not disabledFlag then
    return KFDBGetRecord("RoleSkin", info.modelId)
  end
  if info and info.disabledModelId and disabledFlag then
    return KFDBGetRecord("RoleSkin", info.disabledModelId)
  end
end
function class:canLvUp(armorBaseId)
  local info = self:getArmorInfoByBaseId(armorBaseId)
  if info and info.nextId and info.nextId > 0 then
    return true
  end
  return false
end
function class:canAdvanced(armorBaseId)
  local info = self:getArmorInfoByBaseId(armorBaseId)
  if info and info.nextId and info.nextId > 0 then
    local nextInfo = self:getArmorInfoByBaseId(info.nextId)
    if nextInfo and nextInfo.rank > info.rank then
      return true
    end
  end
  return false
end
function class:isMaterialEnough(armorBaseId)
  local info = self:getArmorInfoByBaseId(armorBaseId)
  if info and info.materials then
    info.materials = json.decode(info.materials or "[]") or {}
    local flag = true
    for k, v in pairs(info.materials) do
      if not self.materialsMap[MATERIAL_TYPE[k]] then
        flag = false
      elseif MATERIAL_TYPE[k] and self.materialsMap[MATERIAL_TYPE[k]] and self.materialsMap[MATERIAL_TYPE[k]] < tonumber(v) then
        flag = false
      end
    end
    return flag
  end
  return false
end
function class:setCurRankArmor(armor)
  self.curRankArmor = armor
end
function class:getCurRankArmor()
  return self.curRankArmor
end
function class:GetSprCard(baseId, fra, bool)
  local strBg = self:getArmorImgBg(baseId, Logic.Armor.ARMOR_SIZE.BIG)
  local strStar
  local info = self:getArmorInfoByBaseId(baseId)
  if info and info.star and info.star > 0 then
    strStar = string.format("images/Equip/%d.png", info.star)
  end
  if strBg == nil then
    if baseId ~= nil then
      log4misc:warn("strBg:Armor.baseId:" .. baseId)
    else
      log4misc:warn(nil)
    end
    return self:getDefaultCard()
  end
  local sprBg = CCSprite:create(strBg)
  local strHead = self:getArmorImg(baseId, Logic.Hero.HEROIMG_SIZE.BIG)
  if strHead == nil then
    if baseId ~= nil then
      log4misc:warn("strHead:Armor.baseId:" .. baseId)
    else
      log4misc:warn(nil)
    end
    return self:getDefaultCard()
  end
  if fra then
    local comSpr = CCSprite:create("images/HeroCardInfo/compose.png")
    if comSpr ~= nil then
      sprBg:addChild(comSpr, 3, 2)
      comSpr:setAnchorPoint(CCPoint(0, 0))
    end
  end
  local sprHead = CCSprite:create(strHead)
  if sprHead == nil then
    if baseId ~= nil then
      log4misc:warn("sprHead:Armor.baseId:" .. baseId)
    else
      log4misc:warn(nil)
    end
    return self:getDefaultCard()
  end
  if sprHead ~= nil then
    sprBg:addChild(sprHead, 1, 3)
    sprHead:setAnchorPoint(CCPoint(0, 0))
  end
  if not bool then
    return sprBg
  end
  if strStar == nil then
    return sprBg
  end
  local sprStar = CCSprite:create(strStar)
  if sprStar ~= nil then
    sprBg:setAnchorPoint(CCPoint(0.5, 0.5))
    sprBg:addChild(sprStar, 4, 20)
    sprStar:setAnchorPoint(CCPoint(0, 0))
    local x = sprBg:getContentSize().width * 0.088
    local y = 0
    sprStar:setScale(0.8)
    sprStar:setPosition(CCPoint(x + 0, y + 2))
  end
  return sprBg
end
function class:getDefaultCard()
  local strBg = "images/public/BigCardBg.png"
  local strQu = "images/public/hero.png"
  local sprBg = CCSprite:create(strBg)
  local sprQu = CCSprite:create(strQu)
  if sprQu ~= nil or sprBg ~= nil then
    sprBg:setAnchorPoint(CCPoint(0.5, 0.5))
    sprQu:setAnchorPoint(CCPoint(0.5, 0.5))
    sprBg:addChild(sprQu, 2, 2)
    sprQu:setPosition(CCPoint(sprBg:getContentSize().width * 0.5, sprBg:getContentSize().height * 0.5))
  end
  return sprBg
end
function class:getBuyPackCost()
  self.packInfo.buyPackCounts = self.packInfo.buyPackCounts or 0
  local counts = self.packInfo.buyPackCounts + 1
  local rec = KFDBGetRecord("PackExtendCost", counts)
  rec = rec or KFDBGetRecord("PackExtendCost", 0)
  return rec.cost or 0
end
function class:getBuyPackTimes()
  return self.packInfo.buyPackCounts or 0
end
function class:initPackInfo(buyCells, buyTimes)
  self.packInfo.buyPackCells = buyCells
  self.packInfo.buyPackCounts = buyTimes
end
function class:getLowLvArmorInfo(heroEquipArmors)
  if not heroEquipArmors or table.empty(heroEquipArmors) or #heroEquipArmors == 1 then
    return nil
  end
  local info = self:getArmorInfoByBaseId(heroEquipArmors[1].baseId)
  local otherInfo = self:getArmorInfoByBaseId(heroEquipArmors[2].baseId)
  if not info or not info.level or not otherInfo or not otherInfo.level then
    return nil
  end
  local lowLvArmorBaseId
  local pos = 0
  if info.rank == otherInfo.rank then
    lowLvArmorBaseId = info.level < otherInfo.level and info.id or otherInfo.id
    pos = info.level < otherInfo.level and heroEquipArmors[1].position or heroEquipArmors[2].position
  else
    lowLvArmorBaseId = info.rank < otherInfo.rank and info.id or otherInfo.id
    pos = info.rank < otherInfo.rank and heroEquipArmors[1].position or heroEquipArmors[2].position
  end
  return lowLvArmorBaseId, pos
end
function class:getActivateCounts(heroBaseId, heroEquipArmors)
  local lowLvArmorBaseId, pos = self:getLowLvArmorInfo(heroEquipArmors)
  if lowLvArmorBaseId == nil or pos == 0 then
    return 0
  end
  local heroInfo = Logic:Get("Hero"):GetHeroInfoByBaseId(heroBaseId)
  local tempArr = pos == 2 and heroInfo.weaponSet or heroInfo.armorSet
  tempArr = json.decode(tempArr or "[]") or {}
  if table.empty(tempArr) then
    return 0
  end
  for i, v in ipairs(tempArr) do
    if v == lowLvArmorBaseId then
      return i
    end
  end
  local lowLvArmorInfo = self:getArmorInfoByBaseId(lowLvArmorBaseId)
  local minArmorInfo = self:getArmorInfoByBaseId(tempArr[1])
  local maxArmorInfo = self:getArmorInfoByBaseId(tempArr[#tempArr])
  if lowLvArmorInfo and minArmorInfo and (lowLvArmorInfo.rank == minArmorInfo.rank and lowLvArmorInfo.level < minArmorInfo.level or lowLvArmorInfo.rank < minArmorInfo.rank) then
    return 0
  end
  if lowLvArmorInfo and maxArmorInfo and (lowLvArmorInfo.rank == maxArmorInfo.rank and lowLvArmorInfo.level > maxArmorInfo.level or lowLvArmorInfo.rank > maxArmorInfo.rank) then
    return #tempArr
  end
  return 0
end
function class:getTotalComboAlters(buffId)
  local info = self:getSingleComboInfo(buffId)
  if not info then
    return {}
  end
  local totalAlters = {}
  repeat
    for i, v in pairs(info.alters) do
      totalAlters[i] = totalAlters[i] and totalAlters[i] + tonumber(v) or tonumber(v)
    end
    if info.beforeId and info.beforeId ~= "" then
      info = self:getSingleComboInfo(info.beforeId)
    else
      info = nil
    end
  until not info
  return totalAlters
end
function class:getSingleComboInfo(buffId)
  local info = KFDBGetRecord("EquipBuff", buffId)
  if info and info.alters then
    info.alters = json.decode(info.alters or "[]") or {}
  end
  return info
end
function class:getPropertySpr(strProp, disabledFlag)
  if strProp == "PCT_ATTACK" then
    strProp = "ATTACK"
  elseif strProp == "PCT_LIFE" then
    strProp = "LIFE"
  end
  local imgStr = string.format("images/Equip/%s.png", strProp)
  if disabledFlag then
    imgStr = string.format("images/Equip/%s_OFF.png", strProp)
  end
  local spr = CCSprite:create(imgStr)
  return spr
end
function class:getGoldPropertySpr(strProp)
  if strProp == "PCT_ATTACK" then
    strProp = "ATTACK"
  elseif strProp == "PCT_LIFE" then
    strProp = "LIFE"
  end
  local imgStr = string.format("images/Equip/Gold%s.png", strProp)
  local spr = CCSprite:create(imgStr)
  return spr
end
function class:curArmorPackCapacity()
  local capacity = KFDBGetRecord("ConfigValue", "EQUIP:INIT_PACK_CAPACITY")
  capacity = capacity and tonumber(capacity.content) or 0
  if self.packInfo and self.packInfo.buyPackCells then
    capacity = capacity + self.packInfo.buyPackCells
  end
  return capacity
end
function class:IsFromRank()
  return self.rankSeleFormRank
end
function class:setFromRank(fromRankFlag)
  self.rankSeleFormRank = fromRankFlag
end
function class:getMaterialsByType(strType)
  return self.materialsMap[MATERIAL_TYPE[strType]] or 0
end
function class:getArmorCardInfo()
  return self.cardInfo
end
function class:IsShanCard(baseId)
  local info = self:getArmorInfoByBaseId(baseId)
  if info and info.flashFlag and info.flashFlag > 0 then
    return true
  end
  return false
end
function class:sortPropInfo(propMap)
  if propMap == nil or table.empty(propMap) then
    return {}
  end
  local infos = {}
  for i, v in pairs(propMap) do
    local oneInfo = {}
    oneInfo.sort = PROP_SORT[i] or 14
    oneInfo.propName = i
    oneInfo.value = v
    table.insert(infos, oneInfo)
  end
  table.sort(infos, function(param1, param2)
    return param1.sort < param2.sort
  end)
  return infos
end
function class:setSmeltUIBtnNodeDisabled(bDisabled)
  self.bDisabled = bDisabled
end
function class:isSmeltUIBtnNodeDisabled()
  return self.bDisabled
end
function class:getArmorInfoById(armorId)
  return self.armorMap[armorId]
end
function class:getArmorInfoByBaseId(armorBaseId)
  return KFDBGetRecord("BaseEquip", armorBaseId)
end
function class:getArmorImg(armorBaseId, size, disabledFlag)
  local sz = size or ARMOR_SIZE.MIDDLE
  local info = self:GetRoleSkin(armorBaseId, disabledFlag)
  if not info then
    return DEFAULT_IMG
  end
  if sz == ARMOR_SIZE.MIDDLE then
    return info.MiddleCard
  elseif sz == ARMOR_SIZE.BIG then
    return info.BigCard
  end
end
function class:getArmorImgBg(armorBaseId, size, disabledFlag)
  local sz = size or ARMOR_SIZE.MIDDLE
  local info = self:getArmorInfoByBaseId(armorBaseId)
  if not info or not info.rank then
    return DEFAULT_BG
  end
  local rank = info.rank
  if rank <= 0 then
    rank = 1
  elseif rank > 7 then
    log4misc:warn("Logic.Armor.getArmorImgBg,baseId:" .. armorBaseId .. ":,Rank:" .. rank)
    rank = 7
  end
  if disabledFlag then
    rank = 1
  end
  if sz == ARMOR_SIZE.MIDDLE then
    return string.format("data/MiddleBg/%d.png", rank)
  elseif sz == ARMOR_SIZE.BIG then
    return string.format("data/BigBg/%d.png", rank)
  end
end
function class:openArmorDetails(baseId, fra)
  self.cardInfo.baseId = baseId
  self.cardInfo.fra = fra
  local bPrompt = Logic:Get("HeroCardInfo"):GetPromptHeroInfo()
  if bPrompt then
    SceneHelper:pushPrompt("ArmorInfo", self.rootNode)
    return
  end
  SceneHelper:pushScene("ArmorInfo", nil)
end
function class:createArmorCard(baseId, fra, bool)
  local ccSprite = self:GetSprCard(baseId, fra, bool)
  return ccSprite
end
function class:addStarLv(node, baseId)
  if baseId == nil then
    return
  end
  local info = self:getArmorInfoByBaseId(baseId)
  if info and info.star and info.star > 0 then
    local strStar = string.format("images/Effect/UIshuzi/%d.png", info.star)
    local sprStar = CCSprite:create(strStar)
    if sprStar ~= nil then
      local ani = Logic:Get("AniMgr"):NewCCB("UI/UIshuzi02", node, ccp(95, 102), 0, nil, 1)
      ani:GetChild("spr"):setDisplayFrame(sprStar:displayFrame())
    end
  end
end
function class:GetArmorTexture(baseId)
  if not baseId then
    return
  end
  local path = Logic:Get("Armor"):getArmorImgBg(baseId)
  local sprBg = CCSprite:create(path)
  local size = sprBg:getContentSize()
  path = Logic:Get("Armor"):getArmorImg(baseId)
  local sprIcon = CCSprite:create(path)
  if sprBg and sprIcon then
    sprIcon:setAnchorPoint(ccp(0, 0))
    sprBg:addChild(sprIcon)
  end
  local rec = self:getArmorInfoByBaseId(baseId) or {}
  if rec and rec.star and 0 < rec.star then
    local strStar = string.format("images/Equip/%d.png", rec.star)
    local sprStar = CCSprite:create(strStar)
    if sprBg and sprStar then
      sprStar:setAnchorPoint(ccp(0, 0.5))
      sprStar:setScale(0.6)
      sprStar:setPosition(CCPoint(56, 80))
      sprBg:addChild(sprStar)
    end
  end
  local texture, textureRect = Logic:Get("HeroCardInfo"):GetCardTexture(sprBg, sprBg:getContentSize())
  return texture, textureRect
end
function class:isEquipPackEnough()
  local capacity = self:curArmorPackCapacity()
  if self.packInfo and self.packInfo.usedCells and capacity <= self.packInfo.usedCells then
    return true
  end
  return false
end
function class:addShanCardSmall(node, baseId)
  if not self:IsShanCard(baseId) or node == nil then
    if node then
      self:clearShanCardSmall(node)
    end
    return
  end
  local cardImg = node:getChildByTag(baseId)
  if cardImg then
    node:reorderChild(cardImg, 999)
    return
  end
  self:clearShanCardSmall(node)
  local aniCard = Logic:Get("AniMgr"):NewCCB("UI/UIshipintubiao", node, nil, 999, nil, nil, true)
  cardImg = aniCard:GetLayer()
  cardImg:setTag(baseId)
  node.armorCardInfo_baseId = baseId
  return cardImg
end
function class:clearShanCardSmall(node)
  local tag = node.armorCardInfo_baseId
  if tag then
    node:removeChildByTag(tag, true)
  end
  node.armorCardInfo_baseId = nil
end
function class:hadTheArmorByBaseId(armorBaseId)
  if not armorBaseId then
    return false
  end
  for _, v in pairs(self.armorMap) do
    if v.baseId == armorBaseId then
      return true
    end
  end
  return false
end
function class:canEquipTheArmorByBaseId(heroBaseId, armorBaseId, armorPosType)
  local info = Logic:Get("Hero"):GetHeroInfoByBaseId(heroBaseId)
  local armorInfo = self:getArmorInfoByBaseId(armorBaseId)
  if not info or table.empty(info) or not armorInfo or table.empty(info) then
    return false
  end
  if armorPosType then
    armorInfo.positions = json.decode(armorInfo.positions or "[]") or {}
    local flag = false
    for i, v in ipairs(armorInfo.positions) do
      if v == armorPosType then
        flag = true
      end
    end
    if not flag then
      return false
    end
  end
  armorInfo.equipTypes = json.decode(armorInfo.equipTypes or "[]") or {}
  for i, v in ipairs(armorInfo.equipTypes) do
    if info.type == v then
      return true
    end
  end
  return false
end
function class:haveArmorsForHero(heroBaseId, armorPosType)
  local unEquipArmors = self:getUnEquipArmors()
  for i, v in pairs(unEquipArmors) do
    if self:canEquipTheArmorByBaseId(heroBaseId, v.baseId, armorPosType) then
      return true
    end
  end
  return false
end
function class:isDoneEquip()
  local logicGuide = Logic:Get("Guide")
  if not self:hadTheArmorByBaseId(31101) then
    return true
  end
  local heroInfo = Logic:Get("Hero"):GetAllHeroInfo()
  local leaderId = Logic:Get("Hero"):GetLeaderId()
  if heroInfo.heros[leaderId] == nil then
    return true
  end
  if not self:canEquipTheArmorByBaseId(heroInfo.heros[leaderId].baseId, 31101) then
    return true
  end
  return false
end
function class:isGuideCheckArmor()
  return self.bGuideCheckArmor or false
end
function class:setGuideCheckArmor(bln)
  self.bGuideCheckArmor = bln
end
function class:getColorByBaseId(armorBaseId)
  if armorBaseId == nil then
    return ccc3(unpack(Logic.Hero.RANK_COLOR[1]))
  end
  local rec = self:getArmorInfoByBaseId(armorBaseId)
  if rec then
    if 1 > rec.rank then
      rec.rank = 1
    end
    if rec.rank > #Logic.Hero.RANK_COLOR then
      rec.rank = #Logic.Hero.RANK_COLOR
    end
    local color = Logic.Hero.RANK_COLOR[rec.rank]
    color = color or Logic.Hero.RANK_COLOR[1]
    return ccc3(unpack(color))
  end
  return ccc3(unpack(Logic.Hero.RANK_COLOR[1]))
end
function class:OnBuyEquipPackSpaceByCoupon(code, data)
  if code == 0 then
    self:OnBuyEquipPack(code, data)
  end
end
function class:setSelectEquipHero(info)
  self.selectEquipHero = info
end
function class:getSelectEquipHero()
  return self.selectEquipHero
end
function class:setUnEquipType(unEquipType)
  self.unEquipType = unEquipType
end
