module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
function prototype:onEnter()
  self.ttfName:setStyle(kCCLabelTTFStyleOutline)
  self.ttfProp1:setStyle(kCCLabelTTFStyleOutline)
  self.ttfProp2:setStyle(kCCLabelTTFStyleOutline)
  self.ttfProp3:setStyle(kCCLabelTTFStyleOutline)
  self.ttfEquipTip:setStyle(kCCLabelTTFStyleOutline)
end
function prototype:refresh(info)
  self:clear()
  if not info or table.empty(info) then
    return
  end
  self.info = info
  self.item:refreshIcon(info)
  self:setPropInfo()
  local armorInfo = Logic:Get("Armor"):getArmorInfoByBaseId(info.baseId)
  self.ttfName:setString(armorInfo and armorInfo.name or "")
  if info.equipHero then
    local heroInfo = Logic:Get("Hero"):GetHeroInfoById(info.equipHero)
    if not heroInfo then
      return
    end
    local hInfo = Logic:Get("Hero"):GetHeroInfoByBaseId(heroInfo.baseId)
    if not hInfo then
      return
    end
    local color = Logic:Get("Hero"):getColorByBaseId(heroInfo.baseId)
    if color then
      self.ttfEquipTip:setColor(color)
    end
    self.ttfEquipTip:setString(hInfo.name)
  else
    self.ttfEquipTip:setString("")
  end
end
function prototype:clear()
  self.spr1:setVisible(false)
  self.spr2:setVisible(false)
  self.spr3:setVisible(false)
  self.ttfProp1:setString("")
  self.ttfProp2:setString("")
  self.ttfProp3:setString("")
end
function prototype:setPropInfo()
  local alters = Logic:Get("Armor"):getAltersByBaseId(self.info.baseId)
  local altersArr = Logic:Get("Armor"):sortPropInfo(alters)
  for i, v in ipairs(altersArr) do
    local spr = Logic:Get("Armor"):getPropertySpr(v.propName)
    local strSpr = string.format("spr%d", i)
    local strProp = string.format("ttfProp%d", i)
    if spr and self[strSpr] and self[strProp] then
      self[strSpr]:setVisible(true)
      self[strSpr]:setDisplayFrame(spr:displayFrame())
      local str = math.ceil(v.value) == v.value and TwGetStr(111412, v.value) or TwGetStr(111411, tostring(100 * v.value))
      self[strProp]:setString(str)
    end
  end
end
