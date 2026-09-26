module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
local GRAY_PATH = {
  [1] = "data/MiddleCard/10719.png",
  [2] = "data/MiddleCard/10720.png"
}
function prototype:onEnter()
  self.ttfName:setStyle(kCCLabelTTFStyleOutline)
  Logic:Get("Armor"):FireEvent(Logic.Armor.EVT.SET_TOUCH_ENABLED, false)
  self.info = Logic:Get("Armor"):getSelectEquipHero()
  self.heroId = self.info.equipHero
  self.heroInfo = Logic:Get("Hero"):GetHeroInfoById(self.heroId)
  if not self.heroInfo then
    return
  end
  self:setHeroInfo(self.heroInfo)
  Logic:Get("Armor"):setUnEquipType("remove")
  self.oldPosNum = Logic:Get("Armor"):getPosNum()
  self.oldSeleltHero = Logic:Get("Armor"):getChooseHeroId()
  Logic:Get("Armor"):On(Logic.Armor.EVT.REMOVE_EQUIP, self:Event("onRemoveEquip"))
end
function prototype:onExit()
  Logic:Get("Armor"):setChooseHeroId(self.oldSeleltHero)
  Logic:Get("Armor"):setPosNum(self.oldPosNum)
  Logic:Get("Armor"):setUnEquipType(nil)
  Logic:Get("HeroCardInfo"):SetPromptHeroInfo(false)
  Logic:Get("Armor"):FireEvent(Logic.Armor.EVT.REFRESH_TABLE)
  Logic:Get("Armor"):FireEvent(Logic.Armor.EVT.SET_TOUCH_ENABLED, true)
end
function prototype:onRemoveEquip()
  self:setArmorInfo()
end
function prototype:setHeroInfo(info)
  self.chooseInfo = info
  if info and info.baseId then
    Logic:Get("HeroCardInfo"):ClearShanCard(self.sprHero, info.baseId)
    local card = Logic:Get("HeroCardInfo"):createHeroCardForByFight(info.baseId)
    local texture, textureRect = Logic:Get("HeroCardInfo"):GetCardTexture(card, card:getContentSize())
    Logic:Get("HeroCardInfo"):AddShanCard(self.sprHero, info.baseId, card:getContentSize().width)
    self.sprHero:setTexture(texture)
    self.sprHero:setTextureRect(textureRect)
    local rec = Logic:Get("Hero"):GetHeroInfoByBaseId(info.baseId)
    local color = Logic:Get("Hero"):getColorByBaseId(info.baseId)
    if rec then
      self.ttfName:setColor(color)
      self.ttfName:setString(rec.name)
    end
  end
  self:setArmorInfo()
end
function prototype:setArmorInfo()
  self:initImg()
  local equipArmors = Logic:Get("Armor"):getHeroEquipArmors(self.heroId)
  local bLock = Logic:Get("Lock"):checkStatusById("EQUIP_LVUP")
  for _, v in ipairs(equipArmors) do
    local imgBg = string.format("imgBg%d", v.position)
    local imgIcon = string.format("imgIcon%d", v.position)
    local sprLv = string.format("sprLv%d", v.position)
    local btnRemove = string.format("btnRemove%d", v.position)
    self:createImg(v.baseId, imgBg, imgIcon)
    self:setStarLv(v.baseId, sprLv)
    self[btnRemove]:setEnabled(true)
  end
end
function prototype:createImg(baseId, imgBg, imgIcon)
  local iconPath = Logic:Get("Armor"):getArmorImg(baseId)
  local bgPath = Logic:Get("Armor"):getArmorImgBg(baseId)
  local spr = CCSprite:create(iconPath)
  local bgSpr = CCSprite:create(bgPath)
  if spr and bgSpr then
    self[imgBg]:setDisplayFrame(bgSpr:displayFrame())
    self[imgIcon]:setDisplayFrame(spr:displayFrame())
  end
end
function prototype:initImg()
  for i = 1, 2 do
    local imgBg = string.format("imgBg%d", i)
    local imgIcon = string.format("imgIcon%d", i)
    local sprLv = string.format("sprLv%d", i)
    local btnRemove = string.format("btnRemove%d", i)
    local graySpr = CCSprite:create(GRAY_PATH[i])
    local imgBgPath = CCSprite:create("images/public/herobg.png")
    local strSpr = CCSprite:create("images/public/clarity05.png")
    if graySpr then
      self[imgIcon]:setDisplayFrame(graySpr:displayFrame())
    end
    self[imgBg]:setDisplayFrame(imgBgPath:displayFrame())
    self[sprLv]:setDisplayFrame(strSpr:displayFrame())
    self[btnRemove]:setEnabled(false)
  end
end
function prototype:setStarLv(baseId, spr)
  local rec = Logic:Get("Armor"):getArmorInfoByBaseId(baseId)
  if rec and rec.star and rec.star > 0 then
    local strSpr = string.format("images/Equip/%d.png", rec.star)
    local lvSpr = CCSprite:create(strSpr)
    if lvSpr then
      self[spr]:setDisplayFrame(lvSpr:displayFrame())
    end
  else
    local strSpr = "images/public/clarity05.png"
    local lvSpr = CCSprite:create(strSpr)
    if lvSpr then
      self[spr]:setDisplayFrame(lvSpr:displayFrame())
    end
  end
end
function prototype:onBtnReturn(sender, event)
  SceneHelper:removePrompt(nil, "ArmorRemoveEquip")
end
function prototype:onBtnArmor(sender, event)
  local equipArmors = Logic:Get("Armor"):getHeroEquipArmors(self.heroId)
  local baseId
  for _, v in ipairs(equipArmors) do
    local str = string.format("btnArmor%d", v.position)
    if sender == self[str] then
      Logic:Get("HeroCardInfo"):SetPromptHeroInfo(true)
      Logic:Get("Armor"):openArmorDetails(v.baseId)
      break
    end
  end
end
function prototype:onBtnHero(sender, event)
  if self.chooseInfo and self.chooseInfo.baseId then
    local heroInfo = {
      id = self.chooseInfo.id,
      level = self.chooseInfo.level or 1,
      baseId = self.chooseInfo.baseId or 1,
      powerSkill = tonumber(self.chooseInfo.powerSkill) or 1
    }
    Logic:Get("HeroCardInfo"):PromptHeroInfoByNparma(heroInfo)
  end
end
function prototype:onBtnRemove(sender, event)
  local equipArmors = Logic:Get("Armor"):getHeroEquipArmors(self.heroId)
  for _, v in ipairs(equipArmors) do
    local str = string.format("btnRemove%d", v.position)
    if sender == self[str] then
      Logic:Get("Armor"):setPosNum(v.position)
      break
    end
  end
  Logic:Get("Armor"):setChooseHeroId(self.heroId)
  Logic:Get("Armor"):PostUnEquip()
end
