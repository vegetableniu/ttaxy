module((...), package.seeall)
require("Logic")
class = Logic.class:subclass()
EVT = Enum({"GET_INFO"})
local ERROR_CODE = TypeDef("com.eyu.mt.module.sweethouse.facade.SweetHouseResult")
local MSG_RESULT = Enum(TypeDef("com.eyu.mt.module.sweethouse.facade.SweetHouseResult"))
local MSG_RESULT_STR = {
  COST_NOT_ENOUGH = 108255,
  ITEM_HAS_EXCHENGED = 108254,
  ITEM_NOT_FOUND = 108253,
  ON_LINE_IS_EXPIRE = 108252,
  SWEET_NOT_ENOUGH = 108251,
  SWEET_INVALID_TYPE = 108250,
  ACTIVITY_NOT_OPEN = 108200
}
function class:initialize()
  super.initialize(self)
  self.sweetShopInfo = {}
  self.sweetInfo = {}
  Logic:Get("MsgAssist"):RecordErrorMsg("MsgSweethouse", MSG_RESULT, MSG_RESULT_STR)
  MsgSweethouse:On("GET_INFO", self:Event("OnGetInfo"))
  MsgSweethouse:On("COST_REFRESH", self:Event("OnCostRefresh"))
  MsgSweethouse:On("SWEET_EXCHANGE", self:Event("OnSweetExchange"))
end
function class:dispose()
  super.dispose(self)
end
function class:GetRefreshTime()
  return self.sweetShopInfo.authoRefreshDate
end
function class:IsExchanged(position)
  return self.sweetShopInfo.gotGood[position]
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
    }
  }
  local rec = json.decode(currencyStr or "[]") or {}
  if tab[rec[1]] then
    info = tab[rec[1]]
  end
  return info
end
function class:GetRefreshCost()
  if table.empty(self.sweetShopInfo or {}) then
    return 0
  end
  local rec = KFDBGetRecord("ConfigValue", "SWEETHOUSE:BUY_REFRESH_COSTS")
  local cost = json.decode(rec.content or "") or {}
  local idx = self.sweetShopInfo.costRefreshTimes or 0
  if idx < 1 then
    idx = 1 or idx
  end
  if idx > #cost then
    idx = #cost or idx
  end
  return cost[idx]
end
function class:GetSweetPath(sweetStr)
  local path = "images/public/clarity05.png"
  if sweetStr and "" == sweetStr then
    path = "images/Hallowmas/icon_sweet_1.png"
  end
  local tab = {
    ["0"] = "images/Hallowmas/icon_sweet_1.png",
    ["1"] = "images/Hallowmas/icon_sweet_2.png",
    ["2"] = "images/Hallowmas/icon_sweet_3.png"
  }
  local rec = sweetStr
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
  for k, v in pairs(self.sweetShopInfo.onItems) do
    local rec = KFDBGetRecord("SweetHouseItemSetting", v)
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
function class:GetSweetAmountByCode(code)
  return self.sweetInfo and self.sweetInfo[code] or 0
end
function class:addSweet(reward)
  self.sweetInfo[reward.code] = self.sweetInfo[reward.code] or {}
  self.sweetInfo[reward.code] = reward.amount
end
function class:costSweet(costReward)
  self.sweetInfo[costReward.code] = self.sweetInfo[costReward.code] or {}
  self.sweetInfo[costReward.code] = self.sweetInfo[costReward.code] + costReward.amount
end
function class:setSweet(sweet)
  self.sweetInfo = sweet
end
function class:PostGetInfo()
  MsgSweethouse:Post("GET_INFO")
end
function class:PostCostRefresh()
  MsgSweethouse:Post("COST_REFRESH")
end
function class:PostSweetExchange(goodsId, position)
  if nil == position then
    return
  end
  MsgSweethouse:Post("SWEET_EXCHANGE", {itemId = goodsId, position = position})
end
function class:OnGetInfo(code, data)
  if code ~= 0 then
    return
  end
  self.sweetShopInfo = data
  self.sweetShopInfo.gotGood = self:InitGotGood(data.exchange)
  self.sweetInfo = data.sweets
  self:FireEvent(EVT.GET_INFO)
end
function class:OnCostRefresh(code, data)
  if code ~= 0 then
    return
  end
  Logic:Get("Cost"):AddCosts(data.costResults)
  self.sweetShopInfo.costRefreshTimes = data.costRefreshTimes
  self.sweetShopInfo.onItems = data.onItems
  self.sweetShopInfo.gotGood = {}
  self.sweetShopInfo.authoRefreshDate = data.authoRefreshDate
  self:FireEvent(EVT.GET_INFO)
end
function class:OnSweetExchange(code, data)
  if code ~= 0 then
    return
  end
  Logic:Get("Cost"):AddCosts(data.costResults)
  Logic:Get("Reward"):AddRewards(data.rewardResults)
  local str = Logic:Get("Reward"):AddDupiCardTip(data.rewardResults)
  Prompt:Msg(str)
  self.sweetShopInfo.gotGood = self:InitGotGood(data.exchange)
  self.sweetShopInfo.onItems = data.onItems
  self.sweetInfo = data.sweets
  self:FireEvent(EVT.GET_INFO)
end
