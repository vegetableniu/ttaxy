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
  local strType = Logic:Get("Artifact"):GetStrByType(info.costStoneType)
  local str = TwGetStr(103202, strType) .. info.costNum
  self.staTip:setString(str)
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
  local path = Logic:Get("Artifact"):GetIconByType(giftInfo.costStoneType)
  spr = CCSprite:create(path)
  if spr then
    self.sprStoneIcon:setDisplayFrame(spr:displayFrame())
  end
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
  local cost = Logic:Get("Artifact"):GetStoneByType(self.data.costStoneType)
  if cost >= self.data.costNum then
    local param = {}
    param.title = 105550
    param.func = self.onPostExchange
    param.cost = self.data.costNum
    param.amount = cost
    param.currencyName = Logic:Get("Artifact"):GetStrByType(self.data.costStoneType)
    param.currencyPath = Logic:Get("Artifact"):GetIconByType(self.data.costStoneType)
    param.max = Logic:Get("Egg"):GetCongifValueByKey("BEEEFFGEE:SOUL_STONE_EXCHANGE_LIMIT")
    param.max = param.max > 0 and param.max or nil
    Prompt:BuyConfirm(self, param)
  else
    Prompt:Fail(TwGetStr(105972))
  end
end
function prototype:onPostExchange(clickType, count)
  Logic:Get("Artifact"):PostSoulStoneExchangeByType(self.data.id, count)
end
