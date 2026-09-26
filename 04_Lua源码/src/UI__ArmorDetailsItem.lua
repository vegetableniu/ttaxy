module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
local BG_ON_IMG = "images/Equip/contentOn.png"
local BG_OFF_IMG = "images/Equip/contentOff.png"
function prototype:onEnter()
  self.ttfProp1:setStyle(kCCLabelTTFStyleOutline)
  self.ttfProp2:setStyle(kCCLabelTTFStyleOutline)
  self.ttfProp3:setStyle(kCCLabelTTFStyleOutline)
end
function prototype:refresh(index, weaponId, armorId)
  self:clear()
  self.index = index
  local weaponInfo = Logic:Get("Armor"):getArmorInfoByBaseId(weaponId)
  local armorInfo = Logic:Get("Armor"):getArmorInfoByBaseId(armorId)
  local str = ""
  local nameNum = 111410
  local otherNum = 111409
  if weaponInfo and armorInfo then
    if self:isCombosActivities() or self:isCurHeroEquip(weaponId) then
      if weaponInfo.rank == 3 then
        nameNum = 111431
      elseif weaponInfo.rank == 4 then
        nameNum = 111432
      elseif weaponInfo.rank == 6 then
        nameNum = 111433
      elseif weaponInfo.rank == 7 then
        nameNum = 111434
      end
    else
      nameNum = 111435
    end
    str = str .. TwGetStr(nameNum, weaponId, weaponInfo.name)
    str = str .. TwGetStr(otherNum, "&nbsp;+&nbsp;")
    if self:isCombosActivities() or self:isCurHeroEquip(armorId) then
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
    str = str .. TwGetStr(nameNum, armorId, armorInfo.name)
    self:setpropTipInfo(weaponInfo.rank, weaponInfo.star)
  end
  self.nodeInfo:setTouchedDelegate(bind(self.OnArmorName, self))
  self.nodeInfo:setString(str)
  self:setPropInfo(weaponId)
end
function prototype:setpropTipInfo(rank, star)
  local str = ""
  if rank == 3 then
    str = TwGetStr(111425, TwGetStr(111444))
  elseif rank == 4 and star == 0 then
    str = TwGetStr(111426, TwGetStr(111445))
  elseif rank == 4 and star == 1 then
    str = TwGetStr(111426, TwGetStr(111446))
  elseif rank == 4 and star == 2 then
    str = TwGetStr(111426, TwGetStr(111447))
  elseif rank == 6 and star == 0 then
    str = TwGetStr(111427, TwGetStr(111448))
  elseif rank == 6 and star == 1 then
    str = TwGetStr(111427, TwGetStr(111449))
  elseif rank == 6 and star == 2 then
    str = TwGetStr(111427, TwGetStr(111450))
  elseif rank == 7 and star == 0 then
    str = TwGetStr(111428, TwGetStr(111451))
  elseif rank == 7 and star == 1 then
    str = TwGetStr(111428, TwGetStr(111452))
  elseif rank == 7 and star == 2 then
    str = TwGetStr(111428, TwGetStr(111453))
  end
  self.propInfo:setString(str)
end
function prototype:clear()
  self.spr1:setVisible(false)
  self.spr2:setVisible(false)
  self.spr3:setVisible(false)
  self.ttfProp1:setString("")
  self.ttfProp2:setString("")
  self.ttfProp3:setString("")
end
function prototype:setPropInfo(id)
  local chooseHeroId = Logic:Get("Armor"):getChooseHeroId()
  local heroInfo = Logic:Get("Hero"):GetHeroInfoById(chooseHeroId)
  if not heroInfo or not heroInfo.baseId or not id then
    return
  end
  local comboId = tostring(heroInfo.baseId) .. "_" .. tostring(id)
  local info = Logic:Get("Armor"):getSingleComboInfo(comboId)
  if not info or not info.alters then
    return
  end
  local imgBg = self:isCombosActivities() and BG_ON_IMG or BG_OFF_IMG
  local bgSpr = CCSprite:create(imgBg)
  if bgSpr then
    self.imgBg:setDisplayFrame(bgSpr:displayFrame())
  end
  local altersArr = Logic:Get("Armor"):sortPropInfo(info.alters)
  for i, v in ipairs(altersArr) do
    local spr = Logic:Get("Armor"):getPropertySpr(v.propName, not self:isCombosActivities())
    local strSpr = string.format("spr%d", i)
    local strProp = string.format("ttfProp%d", i)
    if spr and self[strSpr] and self[strProp] then
      self[strSpr]:setVisible(true)
      self[strSpr]:setDisplayFrame(spr:displayFrame())
      local str = TwGetStr(111411, tostring(100 * v.value))
      self[strProp]:setString(str)
      if self:isCombosActivities() then
        self[strProp]:setColor(ccColor3B(37, 239, 11))
      else
        self[strProp]:setColor(ccColor3B(144, 144, 144))
      end
    end
  end
end
function prototype:isCombosActivities()
  local chooseHeroId = Logic:Get("Armor"):getChooseHeroId()
  local heroInfo = Logic:Get("Hero"):GetHeroInfoById(chooseHeroId)
  if not heroInfo or not heroInfo.baseId then
    return false
  end
  local heroEquipArmors = Logic:Get("Armor"):getHeroEquipArmors(chooseHeroId)
  local counts = Logic:Get("Armor"):getActivateCounts(heroInfo.baseId, heroEquipArmors)
  return counts >= self.index
end
function prototype:isCurHeroEquip(baseId)
  local chooseHeroId = Logic:Get("Armor"):getChooseHeroId()
  local heroEquipArmors = Logic:Get("Armor"):getHeroEquipArmors(chooseHeroId)
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
function prototype:onBtnItem(sender, event)
  if Logic:Get("Guide"):isActive("EquipFetterTwo", "Start") then
  end
end
function prototype:updateGuide()
end
function prototype:OnArmorName(armorBaseId)
  if not armorBaseId then
    return
  end
  Logic:Get("Armor"):openArmorDetails(armorBaseId)
end
