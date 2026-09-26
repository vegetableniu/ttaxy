require("SceneHelper")
module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
function prototype:onEnter()
end
function prototype:onBtnExchange(sender, event)
  local shopInfo = Logic:Get("CultivateShop"):GetShopInfo()
  local refreshTime = shopInfo.autoRefreshDate
  local diffTime = Logic:Get("System"):DiffTime(refreshTime / 1000)
  if diffTime < 0 then
    Prompt:Confirm(self, "", TwGetStr(110620), self.PostGetInfo, Prompt.PROMPT_TYPE.CONFIRM)
    return
  end
  local info = Logic:Get("TreasureRoom"):GetCurrencyInfo(self.goodInfo.costTypes)
  if info.amount < self.goodInfo.cost then
    if info.type == "GOLD" then
      Logic:Get("Main"):PromptCharge()
    elseif info.type == "COPPER" then
      Prompt:Fail(103031)
    else
      Prompt:Fail(TwGetStr(105762, info.name or ""))
    end
    return
  end
  Prompt:ConfirmRecord(self, "", TwGetStr(115166, self.goodInfo.cost, info.name, self.goodInfo.name), self.onComfirmBuy, Prompt.PROMPT_TYPE.SELECT, nil, "CULT_EXCHANGE")
end
function prototype:onComfirmBuy()
  Logic:Get("CultivateShop"):PostShopExchange(self.goodInfo.id, self.idx)
end
function prototype:PostGetInfo()
  Logic:Get("CultivateShop"):PostGetInfo()
end
function prototype:refreshGood(goodInfo, idx)
  if table.empty(goodInfo or {}) then
    return
  end
  self.goodInfo = goodInfo
  self.idx = idx
  self.ttfGoodName:setStyle(kCCLabelTTFStyleOutline)
  self.ttfCostGold:setStyle(kCCLabelTTFStyleOutline)
  self.ttfGoodName:setString(self.goodInfo.name)
  self.ttfCostGold:setString(self.goodInfo.costStr)
  self.ccbGood:ReFreshByGift(self.goodInfo)
  local color = Logic:Get("Gift"):GetColorByGift(self.goodInfo)
  self.ttfGoodName:setColor(color)
  local path = Logic:Get("TreasureRoom"):GetCurrencyPath(goodInfo.costTypes)
  local spr = CCSprite:create(path)
  if spr then
    self.sprIcon:setDisplayFrame(spr:displayFrame())
  end
  local bExchanged = goodInfo.isExchanged
  self.nodExchange:setVisible(not bExchanged)
  self.sprExchanged:setVisible(bExchanged)
end
