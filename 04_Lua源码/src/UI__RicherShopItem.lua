require("SceneHelper")
module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
function prototype:onEnter()
end
function prototype:onBtnExchange(sender, event)
  local info = Logic:Get("Monopoly"):GetMonoInfo()
  self.bUseJade = false
  if info.currency >= self.goodInfo.cost then
    Prompt:Confirm(self, "", TwGetStr(115075, self.goodInfo.cost, self.goodInfo.name), self.onComfirmBuy, Prompt.PROMPT_TYPE.SELECT)
    return
  end
  self.bUseJade = true
  local needTokenCoin = self.goodInfo.cost - info.currency
  self.jadeCost = needTokenCoin * self.goodInfo.tokenToCurrency
  Prompt:Confirm(self, "", TwGetStr(115076, needTokenCoin, self.jadeCost, self.goodInfo.name), self.onComfirmBuy, Prompt.PROMPT_TYPE.SELECT)
end
function prototype:onComfirmBuy()
  if not self.bUseJade then
    Logic:Get("Monopoly"):PostBuyGoods(self.goodInfo.id, false)
    return
  end
  if not Logic:Get("PlayerInfo"):IsMoneyEnough(self.jadeCost) then
    Logic:Get("Main"):PromptCharge()
    return
  end
  Logic:Get("Monopoly"):PostBuyGoods(self.goodInfo.id, true)
end
function prototype:refreshGood(owner, goodInfo)
  self.owner = owner
  self.goodInfo = goodInfo
  self.ttfGoodName:setStyle(kCCLabelTTFStyleOutline)
  self.ttfCostGold:setStyle(kCCLabelTTFStyleOutline)
  self.ttfGoodName:setString(self.goodInfo.name)
  self.ttfCostGold:setString(self.goodInfo.cost)
  self.ccbGood:ReFreshByGift(self.goodInfo)
  local bExchanged = self.owner:IsExchagedGood(self.goodInfo.id)
  self.nodExchange:setVisible(not bExchanged)
  self.sprExchanged:setVisible(bExchanged)
end
