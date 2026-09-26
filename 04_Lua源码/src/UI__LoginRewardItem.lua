module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
require("SceneHelper")
function prototype:onEnter()
  self.ttfReward:setStyle(kCCLabelTTFStyleOutline)
end
function prototype:onExit()
end
function prototype:RefreshReward(data)
  self.data = data
  self:createImg(data)
  self.ttfReward:setString(data.amount)
  self.sprHasDraw:setVisible(data.hasDraw or false)
end
function prototype:createImg(giftInfo)
  local spr = Logic:Get("Gift"):createImg(giftInfo)
  if spr ~= nil then
    self.sprBg:setDisplayFrame(spr:displayFrame())
    local strGoods = Logic:Get("Gift"):createGoodsImg(giftInfo)
    if strGoods ~= nil then
      local texture, textureRect = Logic:Get("HeroCardInfo"):GetCardTexture(strGoods)
      self.sprIcon:setTexture(texture)
      self.sprIcon:setTextureRect(textureRect)
    end
  end
  Logic:Get("HeroCardInfo"):AddShanCardSmall(self.sprBg, giftInfo.showId)
end
function prototype:onBtnIcon()
  if SceneHelper:isExistPrompt("HeroInfo") then
    return
  end
  if self.data.showType == "HERO" then
    Logic:Get("HeroCardInfo"):OpenHeroInfoById(self.data.showId)
    return
  end
  if self.data.showType == "FRAGMENT" then
    local fraConfig = Logic:Get("Compose"):kdbItemConfig(self.data.showId)
    if fraConfig ~= nil then
      Logic:Get("HeroCardInfo"):OpenHeroInfoById(fraConfig.baseId)
    end
    return
  end
end
