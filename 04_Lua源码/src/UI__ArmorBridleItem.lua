module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
function prototype:onEnter()
  for i = 1, 3 do
    local str = string.format("ttf%d", i)
    if self[str] then
      self[str]:setStyle(kCCLabelTTFStyleOutline)
    end
  end
end
function prototype:refresh(info)
  if not info then
    return
  end
  self.info = info
  self:showEquipText()
  self:showAddedValue()
end
function prototype:showEquipText()
  local weaponInfo = Logic:Get("Armor"):getArmorInfoByBaseId(self.info.armorBaseId1) or {}
  local armorInfo = Logic:Get("Armor"):getArmorInfoByBaseId(self.info.armorBaseId2) or {}
  local str = ""
  local nameNum = 111410
  local otherNum = 111409
  local function getArmorRichText(armorInfo, armorBaseId)
    local strName = ""
    if self:isCombosActivities() or self:isCurHeroEquip(armorBaseId) then
      if armorInfo.rank == 3 then
        nameNum = 111431
      elseif armorInfo.rank == 4 then
        nameNum = 111432
      elseif armorInfo.rank == 6 then
        nameNum = 111433
      elseif armorInfo.rank == 7 then
        nameNum = 111434
      end
    else
      nameNum = 111435
    end
    strName = TwGetStr(nameNum, armorBaseId, armorInfo.name)
    return strName
  end
  str = str .. getArmorRichText(weaponInfo, self.info.armorBaseId1)
  str = str .. TwGetStr(111424, "&nbsp;+&nbsp;")
  str = str .. getArmorRichText(armorInfo, self.info.armorBaseId2)
  str = str .. TwGetStr(111424, "&nbsp;=")
  self.rtBridle:setTouchedDelegate(bind(self.OnArmorName, self))
  self.rtBridle:setString(str)
end
function prototype:showAddedValue()
  local bridle = self.info.bridle or {}
  local function showBridleValue(idx, strType)
    if not idx or not strType then
      return
    end
    local value = bridle[strType]
    local str = string.format("spr%d", idx)
    local lighted = self:isCombosActivities()
    local sprProp = Logic:Get("Armor"):getPropertySpr(strType, not lighted)
    if self[str] and sprProp then
      self[str]:setDisplayFrame(sprProp:displayFrame())
    end
    local str = string.format("ttf%d", idx)
    if self[str] then
      self[str]:setString(TwGetStr(111142, tostring(value * 100)))
      local color = lighted and ccc3(0, 210, 30) or ccc3(144, 144, 144)
      self[str]:setColor(color)
    end
  end
  local index = 1
  for k, v in pairs(bridle) do
    showBridleValue(index, k)
    index = index + 1
  end
end
function prototype:isCombosActivities()
  local heroInfo = Logic:Get("HeroCardInfo"):GetHeroInfo()
  if not heroInfo or not heroInfo.baseId then
    return false
  end
  local heroEquipArmors = Logic:Get("HeroCardInfo"):GetHeroArmorsVo()
  local counts = Logic:Get("Armor"):getActivateCounts(heroInfo.baseId, heroEquipArmors)
  return counts >= self.info.index
end
function prototype:isCurHeroEquip(baseId)
  local heroEquipArmors = Logic:Get("HeroCardInfo"):GetHeroArmorsVo()
  if heroEquipArmors == nil or table.empty(heroEquipArmors) then
    return false
  end
  for i, v in ipairs(heroEquipArmors) do
    if v.baseId == baseId then
      return true
    end
    local info = Logic:Get("Armor"):getArmorInfoByBaseId(baseId)
    local tempInfo = Logic:Get("Armor"):getArmorInfoByBaseId(v.baseId)
    if info.positions == tempInfo.positions and (info.rank < tempInfo.rank or info.rank == tempInfo.rank and info.star <= tempInfo.star) then
      return true
    end
  end
  return false
end
function prototype:OnArmorName(armorBaseId)
  if not armorBaseId then
    return
  end
  Logic:Get("Armor"):openArmorDetails(armorBaseId)
end
