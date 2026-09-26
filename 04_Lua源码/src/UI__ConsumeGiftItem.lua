module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
require("SceneHelper")
local FIN_PATH = "images/HeroCardInfo/gift_fin.png"
local PROCESS_PATH = "images/HeroCardInfo/gift_ing.png"
function prototype:onEnter()
end
function prototype:ReFrashReward(rewardInfo, index)
  if rewardInfo == nil then
    return
  end
  Logic:Get("HeroCardInfo"):ClearShanCardSmall(self.goodsImg)
  self.rewardInfo = rewardInfo
  self:createImg(rewardInfo)
  self.ttfGain:setStyle(kCCLabelTTFStyleOutline)
  self.ttfGain:setString(rewardInfo.descCondition or "")
  local curScore = Logic:Get("Consume"):GetCurScore()
  local str = TwGetStr(108055) .. curScore .. "/" .. rewardInfo.needScore
  self.ttfProgress:setStyle(kCCLabelTTFStyleOutline)
  self.ttfProgress:setString(str)
  self:createProgress(rewardInfo)
end
function prototype:createImg(rewardInfo)
  local spr = Logic:Get("Gift"):createImg(rewardInfo)
  if spr ~= nil then
    self.sprHeroHead:setDisplayFrame(spr:displayFrame())
    local strGoods = Logic:Get("Gift"):createGoodsImg(rewardInfo)
    if strGoods ~= nil then
      local texture, textureRect = Logic:Get("HeroCardInfo"):GetCardTexture(strGoods)
      self.goodsImg:setTexture(texture)
      self.goodsImg:setTextureRect(textureRect)
    end
  end
  Logic:Get("HeroCardInfo"):AddShanCardSmall(self.sprHeroHead, self.rewardInfo.showId, nil, self.rewardInfo.showType == "FRAGMENT")
end
function prototype:createProgress(rewardInfo)
  local curScore = Logic:Get("Consume"):GetCurScore()
  local spr
  if curScore >= rewardInfo.needScore then
    self.btnGain:setEnabled(true)
    spr = CCSprite:create(FIN_PATH)
  else
    self.btnGain:setEnabled(false)
    spr = CCSprite:create(PROCESS_PATH)
  end
  if spr == nil then
    return
  end
  self.sprFinish:setDisplayFrame(spr:displayFrame())
  self.sprFinish:setAnchorPoint(CCPoint(0.5, 0.5))
end
function prototype:onBtnGain()
  local curScore = Logic:Get("Consume"):GetCurScore()
  if curScore >= self.rewardInfo.needScore then
    Logic:Get("Consume"):setDrawRewardId(self.rewardInfo.id)
    MsgConsumerank:Post("DRAW_SCORE_REWARD", self.rewardInfo.id)
  end
end
function prototype:onBtnInfo()
  if self.rewardInfo.showType == "HERO" then
    Logic:Get("HeroCardInfo"):OpenHeroInfoById(self.rewardInfo.showId)
  elseif self.rewardInfo.showType == "FRAGMENT" then
    local fraConfig = Logic:Get("Compose"):kdbItemConfig(self.rewardInfo.showId)
    if fraConfig ~= nil then
      Logic:Get("HeroCardInfo"):OpenHeroInfoById(fraConfig.baseId)
    end
  end
end
