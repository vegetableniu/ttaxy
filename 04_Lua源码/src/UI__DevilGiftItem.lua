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
  self.ttfGiftInfo:setString(TwGetStr(105531, giftInfo.feat) or "")
  self.ttfGain:setStyle(kCCLabelTTFStyleOutline)
  local str = TwGetStr(103080) .. giftInfo.name
  self.ttfGain:setString(str)
  self.ttfProgress:setStyle(kCCLabelTTFStyleOutline)
  local curInt = Logic:Get("Devil"):getFeat() or 0
  str = TwGetStr(103016) .. curInt .. "/" .. giftInfo.feat
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
  Logic:Get("HeroCardInfo"):AddShanCardSmall(self.sprHeroHead, self.giftInfo.showId, nil, self.giftInfo.showType == "FRAGMENT")
end
function prototype:createProgress(giftInfo)
  local curInt = Logic:Get("Devil"):getFeat() or 0
  local spr
  if curInt >= giftInfo.feat then
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
  local feat = Logic:Get("Devil"):getFeat()
  if feat < self.giftInfo.feat then
    return
  end
  if self.giftInfo.showType == "ACTION" and Logic:Get("PlayerInfo"):IsPhysicalPointFull() then
    Prompt:Fail(115154)
    return
  end
  Logic:Get("Devil"):postDrawFeatReward({
    self.giftInfo.id
  })
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
