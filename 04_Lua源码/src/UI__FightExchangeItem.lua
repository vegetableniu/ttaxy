module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
function prototype:initialize(...)
  super.initialize(self, ...)
  self.data = {}
end
function prototype:dispose(...)
  super.dispose(self)
end
function prototype:onEnter()
  self.staName:setStyle(kCCLabelTTFStyleOutline)
  self.staTip:setStyle(kCCLabelTTFStyleOutline)
  self.ttfLimit:setStyle(kCCLabelTTFStyleOutline)
end
function prototype:onNodeLoaded(node, loader)
end
function prototype:RefreshExchangeInfo(info)
  if info == nil or table.empty(info) then
    return
  end
  self.data = info
  self.btnExchange:setVisible(true)
  self:createImg(info)
  self.staName:setString(info.name)
  self.ttfLimit:setString("")
  self.sprExchange:setVisible(true)
  self.staTip:setString(TwGetStr(105333, info.integral))
end
function prototype:createImg(giftInfo)
  local spr = Logic:Get("Gift"):createImg(giftInfo)
  if spr ~= nil then
    self.iconBg:setDisplayFrame(spr:displayFrame())
    local strGoods = Logic:Get("Gift"):createGoodsImg(giftInfo)
    if strGoods ~= nil then
      local texture, textureRect = Logic:Get("HeroCardInfo"):GetCardTexture(strGoods)
      self.iconImage:setTexture(texture)
      self.iconImage:setTextureRect(textureRect)
    end
  end
  Logic:Get("HeroCardInfo"):AddShanCardSmall(self.iconBg, self.data.showId)
end
function prototype:onBtnImage(sender, event)
  if self.data.showType == "HERO" then
    Logic:Get("HeroCardInfo"):OpenHeroInfoById(self.data.showId)
  elseif self.data.showType == "FRAGMENT" then
    local fraConfig = Logic:Get("Compose"):kdbItemConfig(self.data.showId)
    if fraConfig ~= nil then
      Logic:Get("HeroCardInfo"):OpenHeroInfoById(fraConfig.baseId)
    end
  end
end
function prototype:onBtnExchange(sender, event)
  Logic:Get("Guide"):done("FightDrawGift", "Draw")
  local fightPoints = Logic:Get("Fight"):GetTotalIntegral()
  if fightPoints >= self.data.integral then
    MsgArena:Post("INTEGRAL_EXCHANGE", {
      id = self.data.id
    })
  else
    Prompt:Fail(TwGetStr(105338))
  end
end
function prototype:updateGuide()
  if Logic:Get("Guide"):isActive("FightDrawGift", "Draw") then
    Logic:Get("Gift"):setDrawing(true)
    Logic:Get("Guide"):lockTouch(self.btnExchange)
  end
end
