module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
local NORMAL_STATE = "images/public/selcet1.png"
local SELECT_STATE = "images/public/selcet2.png"
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
  self.selectFlag = false
  local imgPath = NORMAL_STATE
  local chooseHeroId = Logic:Get("Armor"):getChooseHeroId()
  if info.equipHero and chooseHeroId and chooseHeroId == info.equipHero then
    self.selectFlag = true
    imgPath = SELECT_STATE
  end
  local spr = CCSprite:create(imgPath)
  if spr then
    self.sprSelect:setDisplayFrame(spr:displayFrame())
  end
  self:setPropInfo()
  self.btnItem:setEnabled(true)
  self:setBtnItemImg(4, 4, 3)
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
    if info.unEquipState then
      self.ttfEquipTip:setColor(ccColor3B(255, 0, 0))
      self.ttfEquipTip:setString(TwGetStr(111439))
    else
      self.ttfEquipTip:setString("")
    end
    if self.selectFlag then
      if color then
        self.ttfEquipTip:setColor(color)
      end
      self.ttfEquipTip:setString(hInfo.name)
      return
    end
    if info.isFitEquipType then
      self:setBtnItemImg(1, 2, 3)
      if color then
        self.ttfEquipTip:setColor(color)
      end
      self.ttfEquipTip:setString(hInfo.name)
      return
    end
    self.btnItem:setEnabled(false)
  elseif info.unEquipState then
    self.ttfEquipTip:setColor(ccColor3B(255, 0, 0))
    self.ttfEquipTip:setString(TwGetStr(111439))
    self.btnItem:setEnabled(false)
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
function prototype:setBtnItemImg(norState, selState, disState)
  local imgPath = {
    "images/public/btnHeroFrameNormal.png",
    "images/public/btnHeroFrameSelect.png",
    "images/public/btnHeroFrameDisable.png",
    "images/Equip/btnEquipNor.png"
  }
  self.btnItem:setBackgroundSpriteForState(CCScale9Sprite:create(imgPath[norState]), CCControlStateNormal)
  self.btnItem:setBackgroundSpriteForState(CCScale9Sprite:create(imgPath[selState]), CCControlStateHighlighted)
  self.btnItem:setBackgroundSpriteForState(CCScale9Sprite:create(imgPath[disState]), CCControlStateDisabled)
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
  Logic:Get("Guide"):done("EquipEquip", "SelectEquipDone")
  local selectFlag = not self.selectFlag
  if self.info.unEquipState then
    Logic:Get("Armor"):setSelectEquipHero(self.info)
    SceneHelper:pushPrompt("ArmorRemoveEquip")
    return
  end
  if selectFlag then
    Logic:Get("Armor"):PostEquip(self.info.id)
    return
  end
  Logic:Get("Armor"):PostUnEquip()
end
function prototype:updateGuide()
  local logicGuide = Logic:Get("Guide")
  if logicGuide:isActive("EquipEquip", "SelectEquipDone") then
    logicGuide:lockTouch(self.btnItem)
  end
end
