module((...), package.seeall)
require("utf8")
require("Logic")
class = Logic.class:subclass()
local ERROR_CODE = TypeDef("com.eyu.mt.module.raffle.facade.RaffleResult")
local MSG_RESULT = Enum(TypeDef("com.eyu.mt.module.raffle.facade.RaffleResult"))
local MSG_RESULT_STR = {
  CURRENCY_IS_NOT_ENOUGH = 111331,
  ACTIVITY_NOT_OPEN = 111332,
  RESET_TIMES_LIMIT = 111334,
  HAD_RAFFLE_ALL = 111333,
  REWARD_ID_IS_NULL = 111335,
  IS_EXPIRE = 111336
}
EVT = Enum({
  "GET_RAFFLE_OK",
  "RAFFLE_OK"
})
function class:initialize()
  super.initialize(self)
  self.rewards = {}
  self.resetCount = 0
  self.raffleCount = 0
  self.resetTime = 0
  self.itemIndex = 0
  self.requestState = false
  self.treasureShowStr = nil
  Logic:Get("MsgAssist"):RecordErrorMsg("MsgRaffle", MSG_RESULT, MSG_RESULT_STR)
  MsgRaffle:On("LOAD_RAFFLE", self:Event("OnLoadRaffle"))
  MsgRaffle:On("REFRESH", self:Event("OnRefresh"))
  MsgRaffle:On("RAFFLE", self:Event("OnRaffle"))
end
function class:OnLoadRaffle(code, data)
  self.rewards = data.awards
  self.resetCount = data.count
  self.raffleCount = data.raffleCount
  self.resetTime = data.resetTime
  self:FireEvent(EVT.GET_RAFFLE_OK, data.awards)
end
function class:OnRefresh(code, data)
  self.rewards = data.awards
  self.resetCount = data.count
  self.resetTime = data.resetTime
  self.raffleCount = 0
  Logic:Get("Cost"):AddCosts(data.costResults)
  self:FireEvent(EVT.GET_RAFFLE_OK, data.awards)
end
function class:OnRaffle(code, data)
  self.raffleCount = self.raffleCount + 1
  if data.awards then
    self.rewards = data.awards
    self.resetTime = data.resetTime
    self.raffleCount = 0
  else
    self:removeOneReward(data.reward)
  end
  Logic:Get("Cost"):AddCosts(data.costResults)
  Logic:Get("Reward"):AddRewards(data.rewardResults)
  local strTip = Logic:Get("Reward"):AddDupiCardTip(data.rewardResults)
  self:FireEvent(EVT.RAFFLE_OK, strTip, data.reward, self.itemIndex)
end
function class:PostLoadRaffle()
  MsgRaffle:Post("LOAD_RAFFLE")
end
function class:PostRefresh()
  MsgRaffle:Post("REFRESH")
end
function class:PostRaffle()
  MsgRaffle:Post("RAFFLE")
end
function class:removeOneReward(rewardId)
  if not self.rewards or not next(self.rewards) or not rewardId then
    return
  end
  local rewards = self.rewards
  self.rewards = table.values(rewards)
  for i, v in ipairs(self.rewards) do
    if v == rewardId then
      table.remove(self.rewards, i)
      break
    end
  end
end
function class:setChooseItemIndex(itemIndex)
  self.itemIndex = itemIndex
end
function class:getResetTime()
  return self.resetTime
end
function class:getRewards()
  return self.rewards
end
function class:setTreasureShowStr(bFlag)
  self.treasureShowStr = bFlag
end
function class:getTreasureShowStr()
  return self.treasureShowStr
end
function class:getRequestState()
  return self.requestState
end
function class:setRequestState(bState)
  self.requestState = bState
end
function class:getOneRewardShow(rewardId)
  return KFDBGetRecord("RaffleRewards", rewardId)
end
function class:getCurRaffleCost()
  local rec = KFDBGetRecord("RaffleCost", self.raffleCount + 1)
  if rec == nil then
    rec = KFDBGetRecord("RaffleCost", 0)
  end
  local cost = 0
  if rec then
    rec.costs = json.decode(rec.costs or "[]")
    rec.levels = json.decode(rec.levels or "[]")
    if not rec.costs or not rec.levels then
      return 0
    end
    local lv = Logic:Get("PlayerInfo"):GetPlayerLevel()
    for i, v in ipairs(rec.levels) do
      if lv <= tonumber(v) then
        cost = rec.costs[i] and tonumber(rec.costs[i]) or 0
        break
      end
    end
  end
  return cost
end
function class:getCurResetCost()
  local rec = KFDBGetRecord("ResetSetting", self.resetCount + 1)
  if rec == nil then
    rec = KFDBGetRecord("ResetSetting", 0)
  end
  local cost = 0
  if rec then
    rec.costs = json.decode(rec.costs or "[]")
    rec.levels = json.decode(rec.levels or "[]")
    if not rec.costs or not rec.levels then
      return 0
    end
    local lv = Logic:Get("PlayerInfo"):GetPlayerLevel()
    for i, v in ipairs(rec.levels) do
      if lv <= tonumber(v) then
        cost = rec.costs[i] and tonumber(rec.costs[i]) or 0
        break
      end
    end
  end
  return cost
end
