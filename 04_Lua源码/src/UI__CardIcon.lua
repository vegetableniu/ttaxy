module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
local CLARITY_PATH = "images/public/clarity05.png"
local DEFAULT_BG_PATH = "images/public/herobg.png"
function prototype:onEnter()
  self.ttfNum:setStyle(kCCLabelTTFStyleOutline)
end
function prototype:onBtnHero(sender, event)
  if not self.data then
    return
  end
  if self.data.showType == "HERO" then
    Logic:Get("HeroCardInfo"):OpenHeroInfoById(self.data.showId)
    return
  end
  if self.data.showType == "FRAGMENT" then
    local fraConfig = Logic:Get("Compose"):kdbItemConfig(self.data.showId)
    if fraConfig ~= nil then
      Logic:Get("HeroCardInfo"):OpenHeroInfoById(fraConfig.baseId, true)
    end
    return
  end
  if self.data.showType == "TALISMAN" then
    Logic:Get("HeroCardInfo"):OpenTailsmanByID(self.data.showId)
    return
  end
  if self.data.showType == "EQUIPMENT" or self.data.showType == "EQUIPMENT_FRAGMENT" then
    Logic:Get("Armor"):openArmorDetails(self.data.showId, self.data.showType == "EQUIPMENT_FRAGMENT")
    return
  end
  if self.data.showType == "PURPLE" then
    Logic:Get("HeroCardInfo"):OpenHeroInfoById(802)
    return
  end
  if self.data.showType == "ORANGE" then
    Logic:Get("HeroCardInfo"):OpenHeroInfoById(803)
    return
  end
  if self.data.showType == "RED" then
    Logic:Get("HeroCardInfo"):OpenHeroInfoById(804)
    return
  end
  if self.data.showType == "TALISMAN_LIEBI" then
    Logic:Get("HeroCardInfo"):OpenHeroInfoById(805)
  end
  if self.data.showType == "CULTIVATE_ELIXIR" then
    Logic:Get("Cultivate"):OpenPillDetail(self.data.showId, self.bPrompt)
  end
  if self.data.showType == "CULTIVATE_MATERIAL" then
    Logic:Get("Cultivate"):OpenStuffDetail(self.data.showId, self.bPrompt)
  end
end
function prototype:setVisible(bool)
  self.sprCard:setVisible(bool)
  self.sprBg:setVisible(bool)
  self.ttfNum:setVisible(bool)
  self.btnHero:setVisible(bool)
end
function prototype:setRotation(rol)
  self.nodLayer:setRotation(rol)
end
function prototype:ReFreshByReward(reward, bPrompt)
  local map = Logic:Get("Reward"):createMap(reward)
  local data = {}
  if map[reward.type] then
    data.showType = map[reward.type].showType[reward.code + 1] or ""
    data.showId = map[reward.type].showId[reward.code + 1] or 1
  end
  data.amount = reward.amount
  self:ReFreshByGift(data, bPrompt)
end
function prototype:ReFreshByGift(gift, bPrompt)
  self.bPrompt = bPrompt
  self.data = gift
  self:createCardImg(gift.showType, gift.showId)
  self.ttfNum:setString(gift.amount or "")
end
function prototype:createCardImg(showType, showId)
  local data = {}
  data.showId = showId or 1
  data.showType = showType or "OTHER"
  self:createImg(data, self.sprBg, self.sprCard)
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
function prototype:setInitInfo()
  local spr = CCSprite:create(CLARITY_PATH)
  if spr then
    self.sprCard:setDisplayFrame(spr:displayFrame())
  end
  local bgSpr = CCSprite:create(DEFAULT_BG_PATH)
  if bgSpr then
    self.sprBg:setDisplayFrame(bgSpr:displayFrame())
  end
  self.ttfNum:setString("")
end
function prototype:setTtfSize(fontSize)
  self.ttfNum:setFontSize(fontSize)
end
function prototype:setTtfColor(color)
  self.ttfNum:setColor(color)
end
