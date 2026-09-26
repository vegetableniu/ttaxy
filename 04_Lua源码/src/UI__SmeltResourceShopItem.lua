module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
require("SceneHelper")
local CURRENCY_TYPE = Enum(TypeDef("com.eyu.mt.module.currency.model.CurrencyType"))
function prototype:onEnter()
  self.ttfCoin1:setStyle(kCCLabelTTFStyleOutline)
  self.ttfCoin2:setStyle(kCCLabelTTFStyleOutline)
  self.ttfLimit:setStyle(kCCLabelTTFStyleOutline)
end
function prototype:setVisible(bool)
  self.ttfCoin1:setVisible(bool)
  self.ttfCoin2:setVisible(bool)
  self.sprIcon1:setVisible(bool)
  self.sprIcon2:setVisible(bool)
  self.ccbIcon:setVisible(bool)
  self.nodBtn:setVisible(bool)
  self.sprBg1:setVisible(bool)
  self.btnHero:setVisible(bool)
  self.isExchanged:setVisible(bool)
end
function prototype:onBtnHero()
  if self.data.showType == "BOX_1" or self.data.showType == "BOX_2" then
    Logic:Get("SmeltResourceShop"):setGoodsId(self.data.id)
    SceneHelper:pushScene("SmeltResourceShowGood", self.rootNode, nil, nil, true)
    return
  end
  self.ccbIcon:onBtnHero()
end
function prototype:Refresh(data)
  if table.empty(data or {}) then
    return
  end
  self.data = data
  self.ccbIcon:ReFreshByGift(data)
  self:showRare(data.rare == "true")
  local exchangeCount = Logic:Get("SmeltResourceShop"):getHasExchangeCount(data.id)
  local isOver = exchangeCount >= self.data.limit or false
  self.isExchanged:setVisible(isOver)
  self.ttfLimit:setString(self.data.limit - exchangeCount)
  self.otherCost = json.decode(data.otherCost or "[]") or {}
  local index = 0
  for k, v in pairs(self.otherCost) do
    local path = Logic:Get("SmeltResourceShop"):GetCoinPath(CURRENCY_TYPE[v.code])
    self:setCoinImgAndCount(path, v.amount, k)
    index = index + 1
  end
  if index == 2 then
    return
  end
  if index == 1 and self.data.cost == 0 then
    local path = Logic:Get("SmeltResourceShop"):GetCoinPath("")
    self:setCoinImgAndCount(path, 0, 2)
    return
  end
  local path = Logic:Get("SmeltResourceShop"):GetCurrencyPath(data.costTypes)
  self:setCoinImgAndCount(path, self.data.costStr, 2)
end
function prototype:setCoinImgAndCount(imgPath, count, index)
  local sprIcon = string.format("sprIcon%d", index)
  local ttfCoin = string.format("ttfCoin%d", index)
  local spr = CCSprite:create(imgPath)
  if spr then
    self[sprIcon]:setDisplayFrame(spr:displayFrame())
  end
  self[ttfCoin]:setString(count)
end
function prototype:showRare(bool)
  self.sprRare:setVisible(bool)
end
function prototype:onBtnExchange(sender, event)
  local refreshTime = Logic:Get("SmeltResourceShop"):GetRefreshTime()
  if refreshTime then
    local diffTime = Logic:Get("System"):DiffTime(refreshTime / 1000)
    if diffTime < 0 then
      Prompt:Confirm(self, "", TwGetStr(110620), self.PostGetShopInfo, Prompt.PROMPT_TYPE.CONFIRM)
      return
    end
  end
  self.hasExchangeCount = Logic:Get("SmeltResourceShop"):getHasExchangeCount(self.data.id)
  if self.hasExchangeCount >= self.data.limit then
    Prompt:Fail(108835)
    return
  end
  self:costCurrency()
end
function prototype:costCurrency()
  local info1, info2, info3
  local costJad = json.decode(self.data.costTypes or "[]") or {}
  if not table.empty(costJad) then
    info1 = Logic:Get("SmeltResourceShop"):GetCurrencyInfo(self.data.costTypes)
    if info1.amount < self.data.cost then
      self:promptFailTip(info1)
      return
    end
  end
  if self.otherCost[1] then
    info2 = Logic:Get("SmeltResourceShop"):GetCurrencyInfo(CURRENCY_TYPE[self.otherCost[1].code])
    if info2.amount < self.otherCost[1].amount then
      self:promptFailTip(info2)
      return
    end
  end
  if self.otherCost[2] then
    info3 = Logic:Get("SmeltResourceShop"):GetCurrencyInfo(CURRENCY_TYPE[self.otherCost[2].code])
    if info3.amount < self.otherCost[2].amount then
      self:promptFailTip(info3)
      return
    end
  end
  local str = ""
  if info1 and self.data.cost > 0 then
    str = self.data.cost .. info1.name
  end
  if info2 and self.otherCost[1].amount > 0 then
    if str ~= "" then
      str = TwGetStr(108815, str, self.otherCost[1].amount .. info2.name)
    else
      str = self.otherCost[1].amount .. info2.name
    end
  end
  if info3 and self.otherCost[2].amount > 0 then
    if str ~= "" then
      str = TwGetStr(108815, str, self.otherCost[2].amount .. info3.name)
    else
      str = self.otherCost[1].amount .. info2.name
    end
  end
  local surplusCount = self.data.limit - self.hasExchangeCount
  Prompt:Confirm(self, "", TwGetStr(108816, str, self.data.name .. "*" .. self.data.amount, surplusCount), self.PostExchange, Prompt.PROMPT_TYPE.SELECT)
end
function prototype:promptFailTip(info)
  if info.type == "GOLD" then
    Logic:Get("Main"):PromptCharge()
  elseif info.type == "COPPER" then
    Prompt:Fail(103031)
  else
    Prompt:Fail(TwGetStr(105762, info.name or ""))
  end
end
function prototype:PostExchange()
  Logic:Get("SmeltResourceShop"):PostExchange(self.data.position, self.data.id)
end
function prototype:PostGetShopInfo()
  Logic:Get("SmeltResourceShop"):PostLoadShop()
end
