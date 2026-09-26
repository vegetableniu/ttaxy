module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
function prototype:onEnter()
  self.ttfName:setStyle(kCCLabelTTFStyleOutline)
  for i = 1, 3 do
    local str = string.format("ttf%d", i)
    if self[str] then
      self[str]:setStyle(kCCLabelTTFStyleOutline)
    end
  end
end
function prototype:refresh(data)
  self:clear()
  if not data then
    return
  end
  local baseId = data.baseId
  self.data = data
  self.item:refreshIcon(data)
  self.isMat = data.isMat
  local isFull = Logic:Get("Armor"):IsSmeltFull()
  local checked = Logic:Get("Armor"):IsCheckSmelt(data.id)
  self:showChecked(checked)
  if isFull and not checked then
    self.btnItem:setEnabled(false)
  else
    self.btnItem:setEnabled(true)
  end
  self:setPropInfo()
  baseId = data.baseId
  local rec = Logic:Get("Armor"):getArmorInfoByBaseId(baseId) or {}
  self.ttfName:setString(rec.name or "name")
end
function prototype:clear()
  self.spr1:setVisible(false)
  self.spr2:setVisible(false)
  self.spr3:setVisible(false)
  self.ttf1:setString("")
  self.ttf2:setString("")
  self.ttf3:setString("")
end
function prototype:setPropInfo()
  local alters = Logic:Get("Armor"):getAltersByBaseId(self.data.baseId)
  local altersArr = Logic:Get("Armor"):sortPropInfo(alters)
  for i, v in ipairs(altersArr) do
    local spr = Logic:Get("Armor"):getPropertySpr(v.propName)
    local strSpr = string.format("spr%d", i)
    local strProp = string.format("ttf%d", i)
    if spr and self[strSpr] and self[strProp] then
      self[strSpr]:setVisible(true)
      self[strSpr]:setDisplayFrame(spr:displayFrame())
      local str = math.ceil(v.value) == v.value and TwGetStr(111412, v.value) or TwGetStr(111411, tostring(100 * v.value))
      self[strProp]:setString(str)
    end
  end
end
function prototype:showChecked(checked)
  checked = checked or false
  self.sprCheck:setVisible(checked)
  self.sprUnCheck:setVisible(not checked)
end
function prototype:onBtnIcon(sender, event)
  Logic:Get("Armor"):openArmorDetails(self.data.baseId)
end
function prototype:onBtnItem(sender, event)
  if not self.data then
    return
  end
  local checked = Logic:Get("Armor"):IsCheckSmelt(self.data.id)
  if not checked then
    Logic:Get("Armor"):AddToSmeltList(self.data.id, self.isMat)
  else
    Logic:Get("Armor"):DelFromSmeltList(self.data.id, self.isMat)
  end
  Logic:Get("Armor"):PostRefreshSmeltList()
end
