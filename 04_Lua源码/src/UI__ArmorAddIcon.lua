module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
local CLARITY_PATH = "images/public/clarity05.png"
local DEFAULT_BG_PATH = "images/public/herobg.png"
local GRAY_PATH = {
  [1] = "data/MiddleCard/10719.png",
  [2] = "data/MiddleCard/10720.png"
}
function prototype:onEnter()
  self:clear()
end
function prototype:onBtnIconClicked(sender, event)
  Logic:Get("Armor"):setPosNum(self.posNum)
  Logic:Get("Guide"):done("EquipEquip", "SelectEquip")
  if Logic:Get("Guide"):isActive("EquipFetterOne", "Start") then
    Logic:Get("Armor"):setGuideCheckArmor(true)
    Logic:Get("Guide"):done("EquipFetterOne", "Start")
    Logic:Get("DramaTalk"):OnGuideTrigger(86, bind(function()
      SceneHelper:pushPrompt("EquipFetter", nil)
    end, self))
    return
  end
  SceneHelper:runWithScene("ArmorSelect", self.rootNode)
end
function prototype:setMetaGodImage(info)
  if not info then
    return
  end
  self.imgAdd:setVisible(false)
  self.imgGraySpr:setVisible(false)
  self.sprLv:setVisible(true)
  local armorInfo = Logic:Get("Armor"):getArmorInfoByBaseId(info.baseId)
  if not armorInfo then
    return
  end
  if armorInfo.star and armorInfo.star > 0 then
    local strSpr = string.format("images/Equip/%d.png", armorInfo.star)
    local lvSpr = CCSprite:create(strSpr)
    if lvSpr then
      self.sprLv:setDisplayFrame(lvSpr:displayFrame())
    end
  end
  local iconPath = Logic:Get("Armor"):getArmorImg(info.baseId)
  local bgPath = Logic:Get("Armor"):getArmorImgBg(info.baseId)
  local spr = CCSprite:create(iconPath)
  local bgSpr = CCSprite:create(bgPath)
  if spr and bgSpr then
    self.imgBg:setDisplayFrame(bgSpr:displayFrame())
    self.imgIcon:setDisplayFrame(spr:displayFrame())
  end
end
function prototype:setEquipType(pos)
  self.posNum = pos
  local str = GRAY_PATH[pos]
  local graySpr = CCSprite:create(str)
  if graySpr then
    self.imgGraySpr:setDisplayFrame(graySpr:displayFrame())
  end
end
function prototype:clear()
  self.imgAdd:setVisible(true)
  self.imgGraySpr:setVisible(true)
  self.sprLv:setVisible(false)
  local spr = CCSprite:create(CLARITY_PATH)
  if spr then
    self.imgIcon:setDisplayFrame(spr:displayFrame())
    self.sprLv:setDisplayFrame(spr:displayFrame())
  end
  local bgSpr = CCSprite:create(DEFAULT_BG_PATH)
  if bgSpr then
    self.imgBg:setDisplayFrame(bgSpr:displayFrame())
  end
end
