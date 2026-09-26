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
  if Logic:Get("Armor"):canAdvanced(info.baseId) then
    if Logic:Get("Armor"):isMaterialEnough(info.baseId) then
      self.ttfEquipTip:setString(TwGetStr(111403))
      self.ttfEquipTip:setColor(ccc3(0, 255, 0))
    else
      self.ttfEquipTip:setString(TwGetStr(111404))
      self.ttfEquipTip:setColor(ccc3(255, 0, 0))
    end
  elseif Logic:Get("Armor"):canLvUp(info.baseId) then
    if Logic:Get("Armor"):isMaterialEnough(info.baseId) then
      self.ttfEquipTip:setString(TwGetStr(111402))
      self.ttfEquipTip:setColor(ccc3(0, 255, 0))
    else
      self.ttfEquipTip:setString(TwGetStr(111404))
      self.ttfEquipTip:setColor(ccc3(255, 0, 0))
    end
  else
    self.ttfEquipTip:setString(TwGetStr(111405))
    self.ttfEquipTip:setColor(ccc3(255, 0, 0))
    self.btnItem:setEnabled(false)
  end
  local armorInfo = Logic:Get("Armor"):getArmorInfoByBaseId(info.baseId)
  self.ttfName:setString(armorInfo and armorInfo.name or "")
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
function prototype:onBtnItem(sender, event)
  Logic:Get("Armor"):setCurRankArmor(self.info)
  SceneHelper:runWithScene("ArmorRank", self.rootNode)
end
