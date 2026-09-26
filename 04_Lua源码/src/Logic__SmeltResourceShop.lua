module((...), package.seeall)
require("Logic")
class = Logic.class:subclass()
EVT = Enum({
  "GET_INFO",
  "SET_TABLEVIEW_TOUCH"
})
local ERROR_CODE = TypeDef("com.eyu.mt.module.exchangeshop.facade.ExchangeshopResult")
local MSG_RESULT = Enum(TypeDef("com.eyu.mt.module.exchangeshop.facade.ExchangeshopResult"))
local MSG_RESULT_STR = {
  EXCHANGE_TIMES_LIMIT = 108835,
  ACTIVITY_IS_NOT_OPEN = 108200,
  CANNOT_USE_COST_ITEM_REFRESH = 108836,
  CANNOT_USE_CURRENCY_REFRESH = 108837,
  GOOD_IS_EXPIRE = 108838,
  COST_REFRESH_TIMES_LIMIT = 108839,
  POSITION_TREASURE_HAD_BEEN_GOT = 108840,
  NO_RELATIVE_POSITION_TREASURE = 108841,
  ACTIVITY_NOT_OPEN = 108842,
  CURRENCY_IS_NOT_ENOUGH = 108755
}
function class:initialize()
  super.initialize(self)
  self.hasExchangeGood = {}
  self.hasExchangeCount = {}
  self.refreshCount = 0
  self.refreshTime = nil
  self.treasures = {}
  Logic:Get("MsgAssist"):RecordErrorMsg("MsgExchangeshop", MSG_RESULT, MSG_RESULT_STR)
  MsgExchangeshop:On("LOAD_SHOP", self:Event("OnLoadShop"))
  MsgExchangeshop:On("REFRESH", self:Event("OnRefresh"))
  MsgExchangeshop:On("EXCHANGE", self:Event("OnExchange"))
end
function class:dispose()
  super.dispose(self)
end
function class:GetRefreshTime()
  return self.refreshTime
end
function class:IsExchanged(position)
  return self.hasExchangeGood[position]
end
function class:getHasExchangeCount(id)
  return self.hasExchangeCount[id] or 0
end
function class:GetCurrencyInfo(currencyStr)
  local info = {}
  local jade = Logic:Get("PlayerInfo"):GetPlayerAllJade()
  local wallet = Logic:Get("PlayerInfo"):GetPlayerMoney()
  local tab = {
    GOLD = {
      type = "GOLD",
      amount = jade,
      name = TwGetStr(103009)
    },
    INTER = {
      type = "GOLD",
      amount = jade,
      name = TwGetStr(103009)
    },
    GIFT = {
      type = "GOLD",
      amount = jade,
      name = TwGetStr(103009)
    },
    COPPER = {
      type = "COPPER",
      amount = wallet[string.lower("COPPER")],
      name = TwGetStr(103008)
    },
    PURPLE = {
      type = "PURPLE",
      amount = wallet[string.lower("PURPLE")],
      name = TwGetStr(108813)
    },
    ORANGE = {
      type = "ORANGE",
      amount = wallet[string.lower("ORANGE")],
      name = TwGetStr(108814)
    }
  }
  if tab[currencyStr] then
    info = tab[currencyStr]
    return info
  end
  local rec = json.decode(currencyStr or "[]") or {}
  if tab[rec[1]] then
    info = tab[rec[1]]
  end
  return info
end
function class:GetRefreshCost()
  local rec = KFDBGetRecord("ExchangeRefCost", self.refreshCount)
  local info = self:GetCurrencyInfo(rec.currencyTypes)
  if not table.empty(info) then
    info.cost = rec.cost
    local img = self:GetCurrencyPath(rec.currencyTypes)
    return info, true, img
  end
  local costItem = json.decode(rec.costItems or "[]") or {}
  local CURRENCY_TYPE = Enum(TypeDef("com.eyu.mt.module.currency.model.CurrencyType"))
  info = self:GetCurrencyInfo(CURRENCY_TYPE[costItem[1].code])
  info.cost = costItem[1].amount
  if not table.empty(info) then
    local img = self:GetCoinPath(CURRENCY_TYPE[costItem[1].code])
    return info, false, img
  end
end
function class:GetCoinPath(coinType)
  local path = "images/public/clarity05.png"
  if coinType and "" == coinType then
    path = "images/smelt/icon2.png"
  end
  local tab = {
    PURPLE = "images/smelt/icon1.png",
    ORANGE = "images/smelt/icon2.png",
    GOLD = "images/public/jade.png",
    INTER = "images/public/jade.png",
    GIFT = "images/public/jade.png",
    COPPER = "images/public/gold.png"
  }
  local rec = coinType
  if tab[rec] then
    path = tab[rec]
  end
  return path
end
function class:GetCurrencyPath(currencyStr)
  local path = "images/public/clarity05.png"
  if currencyStr and "" == currencyStr then
    path = "images/public/gold.png"
  end
  local tab = {
    GOLD = "images/public/jade.png",
    INTER = "images/public/jade.png",
    GIFT = "images/public/jade.png",
    COPPER = "images/public/gold.png"
  }
  local rec = json.decode(currencyStr or "[]") or {}
  if tab[rec[1]] then
    path = tab[rec[1]]
  end
  return path
end
function class:GetGoodsList()
  local list = {}
  for k, v in pairs(self.treasures) do
    local rec = KFDBGetRecord("ExchRewardCost", v)
    if rec then
      rec.position = k
      table.insert(list, rec)
    end
  end
  return list
end
function class:InitGotGood(data)
  local result = {}
  for k, v in pairs(data or {}) do
    if type(v) == "number" or type(v) == "string" then
      result[v] = k
    end
  end
  return result
end
function class:setGoodsId(id)
  self.goodsId = id
end
function class:getGoodsId()
  return self.goodsId
end
function class:PostLoadShop()
  MsgExchangeshop:Post("LOAD_SHOP")
end
function class:PostRefresh(iscurrency)
  MsgExchangeshop:Post("REFRESH", {currency = iscurrency})
end
function class:PostExchange(position, id)
  self.exchangeId = id
  if nil == position then
    return
  end
  MsgExchangeshop:Post("EXCHANGE", {position = position})
end
function class:OnLoadShop(code, data)
  if code ~= 0 then
    return
  end
  self.hasExchangeGood = self.InitGotGood(data.gotTreasures)
  self.treasures = data.treasures
  self.hasExchangeCount = data.exhangeTimes
  self.refreshCount = data.refreshTimes
  self.refreshTime = data.time
  self:FireEvent(EVT.GET_INFO)
end
function class:OnRefresh(code, data)
  if code ~= 0 then
    return
  end
  Logic:Get("Cost"):AddCosts(data.costResults)
  self.refreshTime = data.nextTime
  self.refreshCount = data.times
  self.treasures = data.treasures
  self:FireEvent(EVT.GET_INFO)
end
function class:OnExchange(code, data)
  if code ~= 0 then
    return
  end
  Logic:Get("Cost"):AddCosts(data.costResults)
  Logic:Get("Reward"):AddRewards(data.rewardResults)
  local str = Logic:Get("Reward"):AddDupiCardTip(data.rewardResults)
  Prompt:Msg(str)
  self.hasExchangeGood = self:InitGotGood(data.gotTreasures)
  if data.treasures then
    self.treasures = data.treasures
  end
  self:addExchangeCount()
  self:FireEvent(EVT.GET_INFO)
end
function class:addExchangeCount()
  self.hasExchangeCount = self.hasExchangeCount or {}
  if self.hasExchangeCount[self.exchangeId] then
    self.hasExchangeCount[self.exchangeId] = self.hasExchangeCount[self.exchangeId] + 1
  else
    self.hasExchangeCount[self.exchangeId] = 1
  end
end
