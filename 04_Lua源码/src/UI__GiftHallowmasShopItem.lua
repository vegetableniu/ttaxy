module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
require("SceneHelper")
function prototype:onEnter()
  self.ttfCoin:setStyle(kCCLabelTTFStyleOutline)
end
function prototype:setVisible(bool)
  self.ttfCoin:setVisible(bool)
  self.sprIcon:setVisible(bool)
  self.ccbIcon:setVisible(bool)
  self.nodBtn:setVisible(bool)
end
function prototype:Refresh(data)
  if table.empty(data or {}) then
    return
  end
  self.data = data
  self.ccbIcon:ReFreshByGift(data)
  self.ttfCoin:setString(data.costStr or "")
  local path = Logic:Get("HallowmasShop"):GetSweetPath(tostring(data.sweetType))
  if data.sweetType == -1 then
    path = Logic:Get("HallowmasShop"):GetCurrencyPath(data.costTypes)
    self.sprIcon:setScale(0.8)
  else
    self.sprIcon:setScale(0.5)
  end
  local spr = CCSprite:create(path)
  if spr then
    self.sprIcon:setDisplayFrame(spr:displayFrame())
  end
  self:showRare(data.rare == "true")
  local bExchange = Logic:Get("HallowmasShop"):IsExchanged(data.position)
  self.isExchanged:setVisible(bExchange and true)
end
function prototype:showRare(bool)
  self.sprRare:setVisible(bool)
end
function prototype:onBtnExchange(sender, event)
  local refreshTime = Logic:Get("HallowmasShop"):GetRefreshTime()
  if refreshTime then
    local diffTime = Logic:Get("System"):DiffTime(refreshTime / 1000)
    if diffTime < 0 then
      Prompt:Confirm(self, "", TwGetStr(110620), self.PostGetSweetShopInfo, Prompt.PROMPT_TYPE.CONFIRM)
      return
    end
  end
  local bExchange = Logic:Get("HallowmasShop"):IsExchanged(self.data.position)
  if bExchange then
    Prompt:Fail(110618)
    return
  end
  if self.data.sweetType == -1 then
    self:costCurrency()
    return
  end
  self:costSweet()
end
function prototype:costCurrency()
  local info = Logic:Get("HallowmasShop"):GetCurrencyInfo(self.data.costTypes)
  if info.amount < self.data.cost then
    if info.type == "GOLD" then
      Logic:Get("Main"):PromptCharge()
    elseif info.type == "COPPER" then
      Prompt:Fail(103031)
    else
      Prompt:Fail(TwGetStr(105762, info.name or ""))
    end
    return
  end
  Prompt:Confirm(self, "", TwGetStr(110622, self.data.cost, info.name or "", self.data.name or ""), self.PostExchange, Prompt.PROMPT_TYPE.SELECT)
end
function prototype:costSweet()
  local sweetCount = Logic:Get("HallowmasShop"):GetSweetAmountByCode(self.data.sweetType)
  if sweetCount < self.data.cost then
    local info = Logic:Get("HallowmasShop"):GetCurrencyInfo(self.data.costTypes)
    local cost = self.data.cost - sweetCount
    if cost > info.amount * 2 then
      Prompt:Fail(108255)
      return
    end
    local str = ""
    if sweetCount == 0 then
      local costOther = math.ceil(self.data.cost / 2)
      str = TwGetStr(110622, costOther, info.name or "", self.data.name or "")
    else
      local costOther = math.ceil(cost / 2)
      str = TwGetStr(108256, sweetCount, costOther, info.name or "", self.data.name or "")
    end
    Prompt:Confirm(self, "", str, self.PostExchange, Prompt.PROMPT_TYPE.SELECT)
    return
  end
  Prompt:Confirm(self, "", TwGetStr(108257, self.data.cost, self.data.name), self.PostExchange, Prompt.PROMPT_TYPE.SELECT)
end
function prototype:PostExchange()
  Logic:Get("HallowmasShop"):PostSweetExchange(self.data.id, self.data.position)
end
function prototype:PostGetSweetShopInfo()
  Logic:Get("HallowmasShop"):PostGetInfo()
end
