module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
local attr_path = {
  "images/public/hero_sword.png",
  "images/public/hero_heart.png"
}
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
  local baseId = data.id
  self.data = data
  local info = {}
  info.showType = data.type
  info.showId = baseId
  self.item:ReFreshByGift(info)
  local isFull = Logic:Get("SmeltResource"):IsSmeltFull()
  local checked = Logic:Get("SmeltResource"):IsCheckSmelt(data.cardId)
  self:showChecked(checked)
  if isFull and not checked then
    self.btnItem:setEnabled(false)
  else
    self.btnItem:setEnabled(true)
  end
  self.staLevel:create(0, "YELLOW_E_NUM")
  self.staLevel:setAlign("LEFT", "TOP")
  self.staLevel:setValue(data.cardInfo.level or 1)
  self.ttfName:setString(data.name or "name")
  if data.card == "TALISMAN" then
    self.nodeLevel:setVisible(true)
    self:setFabaoAttr()
    return
  end
  if data.card == "HERO" then
    self.nodeLevel:setVisible(true)
    self.imgStar:setVisible(true)
    self:setHeroAttr()
    return
  end
  if self.data.type == "EQUIPMENT" then
    self:setPropInfo()
    return
  end
  local strType = Logic:Get("Hero"):GetImageByType(self.data.card)
  if strType then
    local frame = CCSprite:create(strType)
    if frame then
      self.sprType:setVisible(true)
      self.sprType:setDisplayFrame(frame:displayFrame())
    end
  end
end
function prototype:clear()
  self.spr1:setVisible(false)
  self.spr2:setVisible(false)
  self.spr3:setVisible(false)
  self.nodeLevel:setVisible(false)
  self.imgStar:setVisible(false)
  self.sprType:setVisible(false)
  self.ttf1:setString("")
  self.ttf2:setString("")
  self.ttf3:setString("")
end
function prototype:setHeroAttr()
  local nLife, nAttack = Logic:Get("Hero"):GetHeroLifeAndAttack(self.data.id, self.data.cardInfo.level)
  local sprite1 = CCSprite:create(attr_path[1])
  if sprite1 then
    self.spr1:setDisplayFrame(sprite1:displayFrame())
    self.spr1:setVisible(true)
    self.ttf1:setString(nAttack)
  end
  local sprite2 = CCSprite:create(attr_path[2])
  if sprite2 then
    self.spr2:setDisplayFrame(sprite2:displayFrame())
    self.spr2:setVisible(true)
    self.ttf2:setString(nLife)
  end
  local _, strStar = Logic:Get("Hero"):GetHeroBgImage(self.data.id)
  if strStar then
    local sprite = CCSprite:create(strStar)
    if sprite then
      self.imgStar:setVisible(true)
      self.imgStar:setDisplayFrame(sprite:displayFrame())
    end
  end
end
function prototype:setFabaoAttr()
  local baseId = self.data.id .. "_" .. self.data.cardInfo.level
  local attack = Logic:Get("Talisman"):GetTaIlsmanAttack(baseId)
  local life = Logic:Get("Talisman"):GetTaIlsmanLife(baseId)
  local sprite1 = CCSprite:create(attr_path[1])
  if sprite1 then
    self.spr1:setDisplayFrame(sprite1:displayFrame())
    self.spr1:setVisible(true)
    self.ttf1:setString(attack)
  end
  local sprite2 = CCSprite:create(attr_path[2])
  if sprite2 then
    self.spr2:setDisplayFrame(sprite2:displayFrame())
    self.spr2:setVisible(true)
    self.ttf2:setString(life)
  end
end
function prototype:setPropInfo()
  local alters = Logic:Get("Armor"):getAltersByBaseId(self.data.id)
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
function prototype:onBtnHero(sender, event)
  if not self.data then
    return
  end
  if self.data.type == "HERO" then
    Logic:Get("HeroCardInfo"):OpenHeroInfo(self.data.cardInfo, Logic.HeroCardInfo.eType.PROTECT)
    return
  end
  if self.data.type == "TALISMAN" then
    Logic:Get("HeroCardInfo"):OpenTailsman(self.data.cardInfo)
    return
  end
  if self.data.type == "EQUIPMENT" or self.data.type == "EQUIPMENT_FRAGMENT" then
    Logic:Get("Armor"):openArmorDetails(self.data.id, self.data.type == "EQUIPMENT_FRAGMENT")
    return
  end
end
function prototype:onBtnItem(sender, event)
  if not self.data then
    return
  end
  local checked = Logic:Get("SmeltResource"):IsCheckSmelt(self.data.cardId)
  if not checked then
    Logic:Get("SmeltResource"):AddToSmeltList(self.data.cardId)
  else
    Logic:Get("SmeltResource"):DelFromSmeltList(self.data.cardId)
  end
  Logic:Get("SmeltResource"):PostRefreshSmeltList()
end
