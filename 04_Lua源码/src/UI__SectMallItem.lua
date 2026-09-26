module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
require("SceneHelper")
function prototype:onEnter()
  self.ttfExchangeCount:setStyle(kCCLabelTTFStyleOutline)
  self.ttfLevelLimite:setStyle(kCCLabelTTFStyleOutline)
end
function prototype:RefreshGoodsInfo(goodsInfo)
  if goodsInfo == nil or next(goodsInfo) == nil then
    return
  end
  self.goodsInfo = goodsInfo
  self.ttfFeatCount:setString(TwGetStr(108119, goodsInfo.need))
  self.ttfRewardDesc:setString(goodsInfo.desc)
  self.ttfExchangeCount:setString(TwGetStr(108120, goodsInfo.exchange))
  if goodsInfo.exchange <= 0 then
    self.nodeBtn:setVisible(false)
    self.sprExchange:setVisible(true)
  else
    self.nodeBtn:setVisible(true)
    self.sprExchange:setVisible(false)
  end
  self.ccbCardIcon:ReFreshByGift(goodsInfo)
  local level = Logic:Get("PlayerInfo"):GetPlayerLevel()
  if goodsInfo.playerLevel and level < goodsInfo.playerLevel then
    self.ttfLevelLimite:setString(TwGetStr(108147, goodsInfo.playerLevel))
    self.nodeBtn:setVisible(false)
    self.sprExchange:setVisible(false)
  else
    self.ttfLevelLimite:setString("")
  end
end
function prototype:onBtnExchange()
  local myFeat = Logic:Get("Sect"):getFeat() or 0
  if myFeat >= self.goodsInfo.need then
    if self.goodsInfo.showType == "HERO" then
      local isBagFull = Logic:Get("Hero"):IsBagEnough()
      if isBagFull then
        SceneHelper:pushPrompt("BattleTip")
        return
      end
    end
    Logic:Get("Sect"):PostExchangeGoods(self.goodsInfo.id)
  else
    Prompt:Fail(TwGetStr(108121))
  end
end
function prototype:onBtnExchange(sender, event)
  local myFeat = Logic:Get("Sect"):getFeat() or 0
  if myFeat < self.goodsInfo.need then
    Prompt:Fail(TwGetStr(108121))
    return
  end
  local isBagFull = Logic:Get("Hero"):IsBagEnough()
  if self.goodsInfo.showType == "HERO" and isBagFull then
    SceneHelper:pushPrompt("BattleTip")
    return
  end
  if 0 >= self.goodsInfo.exchange then
    return
  end
  local featName = TwGetStr(108132)
  local path = "images/Corps/bz_feat.png"
  local param = {}
  param.title = 105550
  param.func = self.onPostExchange
  param.cost = self.goodsInfo.need
  param.amount = myFeat
  param.currencyName = featName
  param.currencyPath = path
  param.max = self.goodsInfo.exchange
  Prompt:BuyConfirm(self, param)
end
function prototype:onPostExchange(clickType, count)
  Logic:Get("Sect"):PostExchangeGoods(self.goodsInfo.id, count)
end
