module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
local FIN_PATH = "images/HeroCardInfo/gift_fin.png"
local PROCESS_PATH = "images/HeroCardInfo/gift_ing.png"
function prototype:onEnter()
end
function prototype:RefrashGiftInfo(giftInfo)
  if giftInfo == nil then
    return
  end
  self.giftInfo = giftInfo
  self.ttfGiftInfo:setString(giftInfo.name or "")
  self.ttfGain:setStyle(kCCLabelTTFStyleOutline)
  self.ttfGain:setString(TwGetStr(105326, giftInfo.integral) or "")
  self.ttfProgress:setStyle(kCCLabelTTFStyleOutline)
  local curInt = Logic:Get("Fight"):GetIntegral() or 0
  local str = TwGetStr(103016) .. curInt .. "/" .. giftInfo.integral
  self.ttfProgress:setString(str)
  self:createImg(giftInfo)
  self:createProgress(giftInfo)
end
function prototype:createImg(giftInfo)
  local spr = Logic:Get("Gift"):createImg(giftInfo)
  if spr ~= nil then
    self.sprHeroHead:setDisplayFrame(spr:displayFrame())
    local strGoods = Logic:Get("Gift"):createGoodsImg(giftInfo)
    if strGoods ~= nil then
      local texture, textureRect = Logic:Get("HeroCardInfo"):GetCardTexture(strGoods)
      self.goodsImg:setTexture(texture)
      self.goodsImg:setTextureRect(textureRect)
    end
  end
end
function prototype:createProgress(giftInfo)
  local curInt = Logic:Get("Fight"):GetIntegral() or 0
  local spr
  if curInt >= giftInfo.integral then
    spr = CCSprite:create(FIN_PATH)
  else
    spr = CCSprite:create(PROCESS_PATH)
  end
  if spr == nil then
    return
  end
  self.sprFinish:setDisplayFrame(spr:displayFrame())
  self.sprFinish:setAnchorPoint(CCPoint(0.5, 0.5))
end
function prototype:onBtnGain()
  local list = Logic:Get("Fight"):GetRewardList()
  if not table.empty(list) then
    for _, v in pairs(list) do
      if v == self.giftInfo.id then
        Logic:Get("Fight"):SetSendId(self.giftInfo.id)
        MsgArena:Post("DRAW_INTEGRAL_REWARD", {
          id = self.giftInfo.id
        })
      end
    end
  end
end
function prototype:onBtnInfo()
  if self.giftInfo.showType == "HERO" then
    Logic:Get("HeroCardInfo"):OpenHeroInfoById(self.giftInfo.showId)
  elseif self.giftInfo.showType == "FRAGMENT" then
    local fraConfig = Logic:Get("Compose"):kdbItemConfig(self.giftInfo.showId)
    if fraConfig ~= nil then
      Logic:Get("HeroCardInfo"):OpenHeroInfoById(fraConfig.baseId)
    end
  end
end
