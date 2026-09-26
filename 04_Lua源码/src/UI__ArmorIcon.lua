module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
function prototype:onEnter()
  self.ttfNum:setStyle(kCCLabelTTFStyleOutline)
end
function prototype:onBtnArmor(sender, event)
  if not self.info then
    return
  end
  if Logic:Get("Guide"):isGuiding() then
    return
  end
  if Logic:Get("Guide"):isActive("EquipElite", "SelectBattle") then
    return
  end
  if self.info.baseId then
    Logic:Get("Armor"):openArmorDetails(self.info.baseId)
    return
  end
  if self.info.showType == "HERO" then
    Logic:Get("HeroCardInfo"):OpenHeroInfoById(self.info.showId)
    return
  end
  if self.info.showType == "FRAGMENT" then
    local fraConfig = Logic:Get("Compose"):kdbItemConfig(self.info.showId)
    if fraConfig then
      Logic:Get("HeroCardInfo"):OpenHeroInfoById(fraConfig.baseId)
    end
    return
  end
  if self.info.showType == "TALISMAN" then
    Logic:Get("HeroCardInfo"):OpenTailsmanByID(self.info.showId)
    return
  end
  if self.info.showType == "EQUIPMENT" or self.info.showType == "EQUIPMENT_FRAGMENT" then
    Logic:Get("Armor"):openArmorDetails(self.info.showId, self.info.showType == "EQUIPMENT_FRAGMENT")
    return
  end
  if self.info.showType == "PURPLE" then
    Logic:Get("HeroCardInfo"):OpenHeroInfoById(802)
    return
  end
  if self.info.showType == "ORANGE" then
    Logic:Get("HeroCardInfo"):OpenHeroInfoById(803)
    return
  end
  if self.info.showType == "RED" then
    Logic:Get("HeroCardInfo"):OpenHeroInfoById(804)
    return
  end
end
function prototype:refreshIcon(info)
  if not info then
    return
  end
  self.info = info
  self:createStar(info.baseId)
  local iconPath = Logic:Get("Armor"):getArmorImg(info.baseId)
  local bgPath = Logic:Get("Armor"):getArmorImgBg(info.baseId)
  local spr = CCSprite:create(iconPath)
  local bgSpr = CCSprite:create(bgPath)
  if spr and bgSpr then
    self.imgBg:setDisplayFrame(bgSpr:displayFrame())
    self.imgIcon:setDisplayFrame(spr:displayFrame())
  end
end
function prototype:createStar(baseId, showType)
  if not baseId then
    return
  end
  local rec
  if not showType or showType == "EQUIPMENT" or showType == "EQUIPMENT_FRAGMENT" then
    rec = Logic:Get("Armor"):getArmorInfoByBaseId(baseId)
  end
  if rec and rec.star and rec.star > 0 then
    local strSpr = string.format("images/Equip/%d.png", rec.star)
    local lvSpr = CCSprite:create(strSpr)
    if lvSpr then
      self.sprLv:setDisplayFrame(lvSpr:displayFrame())
    end
  else
    local strSpr = "images/public/clarity05.png"
    local lvSpr = CCSprite:create(strSpr)
    if lvSpr then
      self.sprLv:setDisplayFrame(lvSpr:displayFrame())
    end
  end
end
function prototype:ReFreshByGift(gift)
  if not gift then
    return
  end
  self.info = gift
  self:createCardImg(gift.showType, gift.showId)
  local info = {}
  self.ttfNum:setString(gift.amount)
end
function prototype:createCardImg(showType, showId)
  local data = {}
  data.showId = showId or 1
  data.showType = showType or "OTHER"
  self:createImg(data, self.imgBg, self.imgIcon)
end
function prototype:createImg(giftInfo, bgNode, IconNode)
  local spr = Logic:Get("Gift"):createImg(giftInfo)
  if spr ~= nil then
    bgNode:setDisplayFrame(spr:displayFrame())
    local strGoods = Logic:Get("Gift"):createGoodsImg(giftInfo)
    if strGoods ~= nil then
      local texture, textureRect = Logic:Get("HeroCardInfo"):GetCardTexture(strGoods)
      IconNode:setTexture(texture)
      IconNode:setTextureRect(textureRect)
    end
  end
  Logic:Get("HeroCardInfo"):AddShanCardSmall(bgNode, giftInfo.showId)
end
