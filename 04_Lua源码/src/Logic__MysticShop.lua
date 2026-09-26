module((...), package.seeall)
require("Logic")
class = Logic.class:subclass()
EVT = Enum({
  "ON_LOAD_SHOP",
  "ON_REFRESH",
  "ON_EXCHANGED",
  "MSG_REFRESH_TIME",
  "MSG_CAN_REFRESH",
  "ON_CURRENCY"
})
local ERROR_CODE = TypeDef("com.eyu.mt.module.secretshop.facade.SecretshopResult")
local MSG_RESULT = Enum(ERROR_CODE)
local MSG_RESULT_STR = {
  CURRENCY_IS_NOT_ENOUGH = 111251,
  ACTIVITY_NOT_OPEN = 111252,
  NO_RELATIVE_POSITION_TREASURE = 111253,
  POSITION_TREASURE_HAD_BEEN_GOT = 111254,
  COST_REFRESH_TIMES_LIMIT = 111255,
  GOOD_IS_EXPIRE = 111256
}
function class:initialize(...)
  super.initialize(self, ...)
  self:initParam()
  self:initXlsValue()
  self:registerEvent()
  Logic:Get("MsgAssist"):RecordErrorMsg("MsgSecretshop", MSG_RESULT, MSG_RESULT_STR)
end
function class:dispose()
  super.dispose(self)
end
function class:initParam()
  self.treasures = {}
  self.gotTreasures = {}
  self.currency = 0
  self.refreshTimes = 0
  self.nextTime = 0
  self.canRefresh = true
end
function class:initXlsValue()
end
function class:registerEvent()
  MsgSecretshop:On("LOAD_SECRETSHOP", self:Event("OnLoadShop"))
  MsgSecretshop:On("REFRESH", self:Event("OnRefresh"))
  MsgSecretshop:On("EXCHANGE", self:Event("OnExchanged"))
end
function class:PostLoadShop()
  MsgSecretshop:Post("LOAD_SECRETSHOP")
end
function class:OnLoadShop(code, data)
  if data then
    self.treasures = data.treasures or {}
    self.gotTreasures = data.gotTreasures or {}
    self.currency = data.currency or 0
    self.refreshTimes = data.refreshTimes or 0
    self.nextTime = data.time
    self.isOld = nil
    if self.canRefresh then
      self.canRefresh = false
      self:DecRefreshTime()
    end
  end
  self:FireEvent(EVT.ON_LOAD_SHOP)
end
function class:PostRefresh()
  MsgSecretshop:Post("REFRESH")
end
function class:OnRefresh(code, data)
  if data then
    self.treasures = data.treasures or {}
    self.currency = data.currency or 0
    self.nextTime = data.nextTime
    self.refreshTimes = data.times or 0
    self.gotTreasures = {}
    Logic:Get("Cost"):AddCosts(data.costResults)
  end
  if self.canRefresh then
    self.canRefresh = false
    self:DecRefreshTime()
  end
  self:FireEvent(EVT.ON_REFRESH)
end
function class:PostExchange(position)
  if not position then
    return
  end
  MsgSecretshop:Post("EXCHANGE", {position = position})
end
function class:OnExchanged(code, data)
  if data then
    self.treasures = data.treasures or {}
    self.gotTreasures = data.gotTreasures or {}
    if data.roomCurrency ~= -1 then
      self.currency = data.roomCurrency or 0
    end
    Logic:Get("Cost"):AddCosts(data.costResults)
    Logic:Get("Reward"):AddRewards(data.rewardResults)
    local strTip = Logic:Get("Reward"):AddRewardsTip(data.rewardResults)
    Prompt:Tip(strTip)
  end
  self:FireEvent(EVT.ON_EXCHANGED, #self.gotTreasures ~= 0)
end
function class:GetTreasures()
  return self.treasures
end
function class:GetExchangedResult()
  return self.gotTreasures
end
function class:GetCurrency()
  return self.currency or 0
end
function class:GetRefreshTime()
  return self.nextTime, self.refreshTimes
end
function class:CheckCanRefresh()
  return self.canRefresh
end
function class:GetRewardFromXls(id)
  if not id then
    return
  end
  return KFDBGetRecord("RewardCost", id) or {}
end
function class:GetRefreshCost()
  local rec = KFDBGetRecord("SecretRefCost", self.refreshTimes + 1)
  if not rec then
    local maxTimes = KFDBGetRecordAmt("SecretRefCost")
    rec = KFDBGetRecord("SecretRefCost", 0)
  end
  return rec and rec.cost
end
function class:CanRefreshByTimes()
  local rec = KFDBGetRecord("ConfigValue", "SECRETSHOP:REFRESH_TIMES_LIMIT")
  if rec and rec.content then
    return self.refreshTimes < tonumber(rec.content)
  end
  return true
end
function class:GetCurrencyPath()
  return "images/Mall/currency.png"
end
function class:AddCurrency(reward)
  if not reward then
    return
  end
  self.currency = self.currency + reward.amount or 0
  self:FireEvent(EVT.ON_CURRENCY, self.currency)
end
function class:GetIsOld()
  return self.isOld
end
function class:ClearOld()
  self.isOld = nil
end
function class:DecRefreshTime()
  local diffTime = Logic:Get("System"):DiffTime(self.nextTime / 1000)
  if diffTime <= 0 then
    self.isOld = true
    self.canRefresh = true
    self:FireEvent(EVT.MSG_CAN_REFRESH)
  else
    local time = Logic:Get("System"):SecToDay(diffTime)
    local strTime = string.format("%02d:%02d:%02d", time.hour or 0, time.min or 0, time.sec or 0)
    self:FireEvent(EVT.MSG_REFRESH_TIME, strTime)
    Singleton(Timer):After(1000, self:Event("DecRefreshTime"))
  end
end
