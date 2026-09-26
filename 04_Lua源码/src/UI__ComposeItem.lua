module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
require("SceneHelper")
CURRENCY_TYPE = TypeDef("com.eyu.mt.module.currency.model.CurrencyType")
CURRENCY_CODE = Enum(CURRENCY_TYPE)
CURRENCY_TYPE_NAME = {}
CURRENCY_TYPE_NAME[CURRENCY_TYPE.COPPER] = "103008"
CURRENCY_TYPE_NAME[CURRENCY_TYPE.GOLD] = "103009"
CURRENCY_TYPE_NAME[CURRENCY_TYPE.GIFT] = "103010"
CURRENCY_TYPE_NAME[CURRENCY_TYPE.INTER] = "103011"
CURRENCY_TYPE_NAME[CURRENCY_TYPE.EXCHANGE] = "103012"
CURRENCY_TYPE_NAME[CURRENCY_TYPE.FRIENDSHIP] = "103013"
local ITEM_BG_IMG = {}
ITEM_BG_IMG.Nor = {
  normal = "images/public/btn_com_nor.png",
  select = "images/public/btn_com_nor.png",
  disable = "images/public/btn_com_dis.png"
}
ITEM_BG_IMG.Red = {
  normal = "images/public/red_com_nor.png",
  select = "images/public/red_com_nor.png",
  disable = "images/public/red_com_dis.png"
}
function prototype:onEnter()
end
function prototype:ReFrashReward(giftInfo)
  self:refreshImgBg(giftInfo)
  if giftInfo.redType then
    self:RefreshRedCom(giftInfo)
  else
    self:RefreshNorCom(giftInfo)
  end
end
function prototype:RefreshRedCom(giftInfo)
  self.btnGain:setEnabled(false)
  if giftInfo == nil then
    return
  end
  local wallet = Logic:Get("PlayerInfo"):GetPlayerMoney()
  self.ttfProgress:setStyle(kCCLabelTTFStyleOutline)
  self.ttfGiftInfo:setStyle(kCCLabelTTFStyleOutline)
  self.ttfGain:setStyle(kCCLabelTTFStyleOutline)
  self.giftInfo = giftInfo
  local hero = Logic:Get("Hero"):GetHeroInfoByBaseId(giftInfo.baseId)
  self:setQualityImg(hero.rank)
  self:setRedGoodsImg(hero)
  self.ttfGiftInfo:setString(hero.name)
  self.ttfGain:setString(TwGetStr(103200))
  self.ttfGain:setFontSize(24)
  self.ttfProgress:setColor(ccColor3B(0, 255, 0))
  self.ttfProgress:setString(TwGetStr(103201, giftInfo.fragment))
  self:createProgress(wallet[string.lower("FRAGMENT")] >= tonumber(giftInfo.fragment))
  self:setRedBtnStage(wallet[string.lower("FRAGMENT")] >= tonumber(giftInfo.fragment))
end
function prototype:RefreshNorCom(giftInfo)
  self.btnGain:setEnabled(false)
  if giftInfo == nil then
    return
  end
  local fraConfig = Logic:Get("Compose"):kdbItemConfig(giftInfo.baseId)
  self.ttfProgress:setStyle(kCCLabelTTFStyleOutline)
  self.ttfGiftInfo:setStyle(kCCLabelTTFStyleOutline)
  self.giftInfo = giftInfo
  self:createImg(giftInfo, fraConfig)
  self.ttfGiftInfo:setString(fraConfig.name)
  local composeConfig = Logic:Get("Compose"):kdbComposeConfig(giftInfo.baseId)
  if composeConfig == nil then
    log4misc:warn("Compose:" .. giftInfo.baseId)
    return
  end
  local strPro = TwGetStr(103016) .. giftInfo.amount .. "/" .. composeConfig.amount
  self.ttfGain:setStyle(kCCLabelTTFStyleOutline)
  self.ttfGain:setString(strPro)
  self.ttfGain:setFontSize(28)
  if composeConfig.extendMax == 0 then
    self.ttfProgress:setString(TwGetStr(111071))
    self.ttfProgress:setColor(ccColor3B(211, 146, 86))
    self:createProgress(giftInfo.amount >= tonumber(composeConfig.amount))
    self:setBtnStage(giftInfo.amount >= tonumber(composeConfig.amount))
    return
  end
  local wallet = Logic:Get("PlayerInfo"):GetPlayerMoney()
  local fraNum = wallet[string.lower("FRAGMENT")] >= tonumber(composeConfig.extendMax) and tonumber(composeConfig.extendMax) or wallet[string.lower("FRAGMENT")]
  self.fraNum = fraNum
  local bool = Logic:Get("Compose"):GetEtend()
  if bool and giftInfo.amount >= composeConfig.amount then
    self.ttfProgress:setString(TwGetStr(103037) .. fraNum)
  elseif bool == false and giftInfo.amount >= composeConfig.amount then
    self.ttfProgress:setString("")
  elseif giftInfo.amount < composeConfig.amount then
    self.ttfProgress:setString(TwGetStr(103037) .. fraNum)
  end
  self.ttfProgress:setColor(ccColor3B(211, 146, 86))
  self:createProgress(giftInfo.amount + fraNum >= tonumber(composeConfig.amount))
  self:setBtnStage(giftInfo.amount + fraNum >= tonumber(composeConfig.amount))
end
function prototype:createImg(giftInfo, fraConfig)
  local spr = Logic:Get("Compose"):GetItemsFrame(tonumber(fraConfig.quality))
  self.sprHeroHead:setDisplayFrame(spr:displayFrame())
  local sprGoods = Logic:Get("Compose"):GetFraImg(giftInfo.baseId)
  if sprGoods ~= nil then
    self.goodsImg:setDisplayFrame(sprGoods:displayFrame())
  end
  local sprFra = Logic:Get("Compose"):GetJigsawImg()
  if sprFra ~= nil then
    self.sprCompose:setDisplayFrame(sprFra:displayFrame())
  end
end
function prototype:createProgress(boolean)
  local spr = Logic:Get("Compose"):createProgress(boolean)
  self.sprFinish:setDisplayFrame(spr:displayFrame())
  self.sprFinish:setAnchorPoint(CCPoint(0.5, 0.5))
end
function prototype:setBtnStage(boolean)
  local str = ""
  self.btnGain:setEnabled(boolean)
  if boolean then
    str = "images/public/btn_com_nor.png"
  else
    str = "images/public/btn_com_dis.png"
  end
  self.btnGain:setBackgroundSpriteForState(CCScale9Sprite:create(str), CCControlStateDisabled)
end
function prototype:setRedBtnStage(boolean)
  local str = ""
  self.btnGain:setEnabled(boolean)
  if boolean then
    str = "images/public/red_com_nor.png"
  else
    str = "images/public/red_com_dis.png"
  end
  self.btnGain:setBackgroundSpriteForState(CCScale9Sprite:create(str), CCControlStateDisabled)
end
function prototype:onBtnGain()
  if self.giftInfo.redType then
    self:onBtnGainRed()
  else
    self:onBtnGainCom()
  end
end
function prototype:onBtnGainRed()
  local str = ""
  local hero = Logic:Get("Hero"):GetHeroInfoByBaseId(self.giftInfo.baseId)
  str = TwGetStr(103018, hero.name)
  local moneyType = json.decode(self.giftInfo.costType)
  if tonumber(self.giftInfo.cost) > 0 then
    local strType = TwGetStr(103202, TwGetStr(CURRENCY_TYPE_NAME[CURRENCY_TYPE[moneyType[1]]]))
    str = str .. "\n" .. strType .. self.giftInfo.cost
  end
  str = str .. "\n" .. TwGetStr(103020, self.giftInfo.fragment)
  Prompt:Confirm(self, 103017, str, self.GetRedCard, Prompt.PROMPT_TYPE.SELECT)
end
function prototype:GetRedCard()
  Logic:Get("BGSound"):PlayEffect("audio/compose.mp3")
  Logic:Get("Devil"):PoseRedCardCompose(self.giftInfo.id)
end
function prototype:onBtnGainCom()
  local str = ""
  local fraConfig = Logic:Get("Compose"):kdbComposeConfig(self.giftInfo.baseId)
  if fraConfig == nil then
    log4misc:warn("composeItem:onBtnGain:fraConfig == nil")
    return
  end
  local reward = Logic:Get("Reward"):kdbRewardConfig(fraConfig.rewardId)
  if reward == nil then
    log4misc:warn("composeItem:onBtnGain:reward == nil")
    log4misc:warn(fraConfig.rewardId)
  end
  if reward and (reward.fixed[1].type == "HERO" or reward.fixed[1].type == "TREASURE") then
    local baseHero = KFDBGetRecord("BaseHero", tonumber(reward.fixed[1].code))
    str = TwGetStr(103018, baseHero.name) .. "\n" .. TwGetStr(103019, fraConfig.cost)
  end
  local bool = Logic:Get("Compose"):GetEtend()
  local composeConfig = Logic:Get("Compose"):kdbComposeConfig(self.giftInfo.baseId)
  if bool and self.giftInfo.amount >= composeConfig.amount then
    str = str .. "\n" .. TwGetStr(103038) .. self.fraNum
  elseif bool == false and self.giftInfo.amount >= composeConfig.amount then
  elseif self.giftInfo.amount < composeConfig.amount then
    if bool == false and self.fraNum > composeConfig.amount - self.giftInfo.amount then
      self.fraNum = composeConfig.amount - self.giftInfo.amount
    end
    str = str .. "\n" .. TwGetStr(103038) .. self.fraNum
  end
  Prompt:Confirm(self, 103017, str, self.GainGoods, Prompt.PROMPT_TYPE.SELECT)
end
function prototype:GainGoods()
  local fraConfig = Logic:Get("Compose"):kdbComposeConfig(self.giftInfo.baseId)
  local wallet = Logic:Get("PlayerInfo"):GetPlayerMoney()
  fraConfig.cost = fraConfig.cost or 0
  if wallet.copper and tonumber(wallet.copper) < tonumber(fraConfig.cost) then
    Prompt:Fail(TwGetStr(10035))
    return
  end
  Logic:Get("BGSound"):PlayEffect("audio/compose.mp3")
  Logic:Get("Compose"):PostComPoseItem(self.giftInfo.id)
end
function prototype:onBtnInfo()
  if self.giftInfo.redType then
    self:onBtnInfoRed()
  else
    self:onBtnInfoCom()
  end
end
function prototype:onBtnInfoRed()
  Logic:Get("HeroCardInfo"):OpenHeroInfoById(self.giftInfo.baseId)
end
function prototype:onBtnInfoCom()
  local info = Logic:Get("Compose"):kdbItemConfig(self.giftInfo.baseId)
  if info ~= nil or info.baseId ~= 0 then
    Logic:Get("HeroCardInfo"):OpenHeroInfoById(info.baseId, true, info.name)
  end
end
function prototype:setQualityImg(quality)
  local spr = Logic:Get("Compose"):GetItemsFrame(tonumber(quality))
  if spr then
    self.sprHeroHead:setDisplayFrame(spr:displayFrame())
  end
end
function prototype:setRedGoodsImg(hero)
  local strPath = Logic:Get("Hero"):GetHeroImage(hero.id)
  local ccSprite = CCSprite:create(strPath)
  if ccSprite then
    self.goodsImg:setDisplayFrame(ccSprite:displayFrame())
  end
  local fraSprite = CCSprite:create("images/public/clarity80.png")
  if fraSprite then
    self.sprCompose:setDisplayFrame(fraSprite:displayFrame())
  end
end
function prototype:refreshImgBg(giftInfo)
  local imgs = ITEM_BG_IMG.Nor
  if giftInfo.redType then
    imgs = ITEM_BG_IMG.Red
  end
  self.btnGain:setBackgroundSpriteForState(CCScale9Sprite:create(imgs.normal), CCControlStateNormal)
  self.btnGain:setBackgroundSpriteForState(CCScale9Sprite:create(imgs.select), CCControlStateHighlighted)
  self.btnGain:setBackgroundSpriteForState(CCScale9Sprite:create(imgs.disable), CCControlStateDisabled)
end
