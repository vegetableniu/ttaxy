module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
function prototype:onEnter()
  self.ttfNum:setStyle(kCCLabelTTFStyleOutline)
  self.sprCover:setVisible(false)
  self.cardRotateAni = Logic:Get("AniMgr"):NewCCB("UI/UIfanpai", self.aniNode, ccp(60, 60), 0, nil, nil)
  self.aniNode:setVisible(false)
end
function prototype:setCoverVisible(bool)
  self.sprCover:setVisible(bool)
  self.imgBg:setVisible(not bool)
  self.sprAniPoint:setVisible(not bool)
  self.ttfNum:setVisible(not bool)
end
function prototype:setItemTouchEnable(bool)
  self.btnIcon:setEnabled(bool)
end
function prototype:refreshItem(index, rewardId)
  self.index = index
  local rewardInfo = Logic:Get("Raffle"):getOneRewardShow(rewardId)
  if not rewardInfo then
    return
  end
  if rewardInfo.rare == "true" then
    self.aniButton = Logic:Get("AniMgr"):NewCCB("UI/UIczG", self.sprAniPoint, ccp(38, 36), 0, nil, nil)
  end
  self:ReFreshByGift(rewardInfo)
end
function prototype:ReFreshByGift(gift)
  self.data = gift
  self:createCardImg(gift.showType, gift.showId, self.imgBg, self.imgIcon)
  self.ttfNum:setString(gift.amount)
end
function prototype:createCardImg(showType, showId, imgBg, imgIcon)
  local data = {}
  data.showId = showId or 1
  data.showType = showType or "OTHER"
  self:createImg(data, imgBg, imgIcon)
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
function prototype:rotateCards(bReversed)
  self.itemLayer:setVisible(false)
  if bReversed then
    self.cardRotateAni:GetChild("imgBottom"):setDisplayFrame(self.sprCover:displayFrame())
    self:createCardImg(self.data.showType, self.data.showId, self.cardRotateAni:GetChild("imgMiddle"), self.cardRotateAni:GetChild("imgTop"))
  else
    self.cardRotateAni:GetChild("imgTop"):setDisplayFrame(self.sprCover:displayFrame())
    self:createCardImg(self.data.showType, self.data.showId, self.cardRotateAni:GetChild("imgMiddle"), self.cardRotateAni:GetChild("imgBottom"))
  end
  self.cardRotateAni:GetChild("imgBottom"):setScale(0.9)
  self.cardRotateAni:GetChild("imgMiddle"):setScale(0.9)
  self.cardRotateAni:GetChild("imgTop"):setScale(0.9)
  self.aniNode:setVisible(true)
  self.cardRotateAni:RunAni(nil, nil, bind(self.aniEnd, self))
end
function prototype:aniEnd()
  self.aniNode:setVisible(false)
  self.itemLayer:setVisible(true)
end
function prototype:showHeroInfo()
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
  if self.data.showType == "TALISMAN" then
    Logic:Get("HeroCardInfo"):OpenTailsmanByID(self.data.showId)
  end
end
function prototype:onIconClicked(sender, event)
  if self.sprCover:isVisible() then
    local jade = Logic:Get("PlayerInfo"):GetPlayerAllJade()
    local raffleCost = Logic:Get("Raffle"):getCurRaffleCost()
    if jade < raffleCost then
      Logic:Get("Main"):PromptCharge()
      return
    end
    Prompt:ConfirmRecord(self, "", TwGetStr(111302, raffleCost), self.raffle, Prompt.PROMPT_TYPE.SELECT, nil, Logic.SureConfirm.RECORD_TYPE.RAFFLE)
  else
    self:showHeroInfo()
  end
end
function prototype:raffle()
  if Logic:Get("Raffle"):getRequestState() then
    Prompt:Confirm(self, "", TwGetStr(111304), self.loadRaffles, Prompt.PROMPT_TYPE.CONFIRM)
    return
  end
  Logic:Get("Raffle"):setChooseItemIndex(self.index)
  Logic:Get("Raffle"):PostRaffle()
end
function prototype:loadRaffles()
  Logic:Get("Raffle"):PostLoadRaffle()
end
