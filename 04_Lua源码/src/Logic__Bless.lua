module((...), package.seeall)
require("Logic")
class = Logic.class:subclass()
EVT = Enum({
  "INFO",
  "LOTTERY",
  "RESET"
})
local MSG_RESULT = Enum(TypeDef("com.eyu.mt.module.blessing.facade.BlessingResult"))
local MSG_RESULT_STR = {
  CURRENCY_IS_NOT_ENOUGH = 10036,
  TIMES_LIMIT = 110851,
  CHARGE_NOT_ENOUGH = 110852,
  ACTIVITY_IS_NOT_OPEN = 111106
}
function class:initialize()
  super.initialize(self)
  self.info = {}
  self.jade = 0
  self.rewards = {}
  Logic:Get("MsgAssist"):RecordErrorMsg("MsgBlessing", MSG_RESULT, MSG_RESULT_STR)
  MsgBlessing:On("INFO", self:Event("OnInfo"))
  MsgBlessing:On("LOTTERY", self:Event("OnLottery"))
end
function class:dispose()
  super.dispose(self)
end
function class:GetInfo()
  return self.info
end
function class:GetJade()
  return self.jade
end
function class:GetRewards()
  return self.rewards
end
function class:IsLockJade(pos)
  return self:IsLock(pos, "BLESSING:LOCK_JADE")
end
function class:IsLockReward(pos)
  return self:IsLock(pos, "BLESSING:LOCK_REWARD")
end
function class:IsLock(pos, id)
  local rec = KFDBGetRecord("ConfigValue", id)
  if not rec then
    return false
  end
  local data = json.decode(rec.content or "[]") or {}
  return data[pos] and self.info.totalTimes < data[pos], data[pos] and data[pos] or 0
end
function class:GetRewardList()
  local rewardLst = {}
  local rec = KFDBGetRecord("RewardRank", self.info.rank or 0)
  if not rec then
    return rewardLst
  end
  local level = Logic:Get("PlayerInfo"):GetPlayerLevel()
  local idx = 0
  local prevLv = 0
  local tabLevels = json.decode(rec.levels) or {}
  for i, v in ipairs(tabLevels) do
    if level > prevLv and v >= level then
      idx = i
      break
    end
    prevLv = v
  end
  local showTypes = json.decode(rec.showTypes) or {}
  local showIds = json.decode(rec.showIds) or {}
  local amounts = json.decode(rec.amounts) or {}
  for i = 1, 5 do
    if showTypes[idx][i] and showIds[idx][i] then
      local data = {}
      data.showType = showTypes[idx][i]
      data.showId = showIds[idx][i]
      data.amount = amounts[idx][i]
      table.insert(rewardLst, data)
    end
  end
  return rewardLst
end
function class:GetNeedCharge()
  local charge = 0
  local rec = KFDBGetRecord("RewardRank", self.info.rank or 0)
  if not rec or not self.info.charge then
    return 0
  end
  charge = rec.money - self.info.charge
  if not (charge > 0) or not charge then
    charge = 0
  end
  return charge
end
function class:GetTotalDrawTimes()
  local times = 0
  for i = 1, KFDBGetRecordAmt("RewardRank") do
    local rec = KFDBGetRecordByIdx("RewardRank", i)
    if rec then
      times = times + rec.times
    end
  end
  return times
end
function class:GetLeftTimes()
  local totalTimes = self:GetTotalDrawTimes()
  if self.info.totalTimes then
    return totalTimes - self.info.totalTimes
  end
  return 0
end
function class:GetCost()
  local rec = KFDBGetRecord("RewardRank", self.info.rank or 0)
  if not rec then
    return 0
  end
  return rec.cost
end
function class:PostInfo()
  MsgBlessing:Post("INFO")
end
function class:PostLottery()
  MsgBlessing:Post("LOTTERY")
end
function class:OnInfo(code, data)
  if code ~= 0 then
    return
  end
  self.info = data
  self:FireEvent(EVT.INFO)
end
function class:OnLottery(code, data)
  if code ~= 0 then
    return
  end
  self.info.rank = data.rank or self.info.rank
  self.info.totalTimes = self.info.totalTimes + 1
  Logic:Get("Cost"):AddCosts(data.costResults)
  for _, rewards in pairs(data.rewardResults) do
    Logic:Get("Reward"):AddRewards(rewards)
  end
  local rewardType = Logic.Reward.REWARDS_TYPE
  local currencyType = Logic.Reward.CURRENCY_TYPE
  local getAmount = function(rewards, rewardType, code)
    local amount = 0
    for _, singleRewards in pairs(rewards) do
      local items = Logic:Get("Reward"):GetItemsByType(singleRewards, rewardType, code)
      amount = amount + Logic:Get("Reward"):CalcTotleNum(items)
    end
    return amount
  end
  local gold = getAmount(data.rewardResults, rewardType.CURRENCY, currencyType.GOLD)
  local gift = getAmount(data.rewardResults, rewardType.CURRENCY, currencyType.GIFT)
  local inter = getAmount(data.rewardResults, rewardType.CURRENCY, currencyType.INTER)
  self.jade = gold + gift + inter
  self:filterReward(data.rewardResults)
  self:FireEvent(EVT.LOTTERY)
end
function class:filterReward(rewards)
  local rewardType = Logic.Reward.REWARDS_TYPE
  local currencyType = Logic.Reward.CURRENCY_TYPE
  local function isJadeType(code)
    if code == currencyType.GOLD then
      return true
    end
    if code == currencyType.GIFT then
      return true
    end
    if code == currencyType.INTER then
      return true
    end
    return false
  end
  self.rewards = {}
  for _, singleRewards in pairs(rewards or {}) do
    local mergeRewards = {}
    for _, reward in pairs(singleRewards) do
      if reward.type ~= rewardType.CURRENCY or not isJadeType(reward.code) then
        table.insert(mergeRewards, reward)
      end
    end
    if not table.empty(mergeRewards) then
      mergeRewards = Logic:Get("Reward"):mergeRewards(mergeRewards)
      table.insert(self.rewards, mergeRewards[1])
    end
  end
end
function class:PromptReward(node)
  local lastNode = "nodReward5"
  for i = 1, 5 do
    if self:IsLockReward(i) then
      lastNode = "nodReward" .. i - 1
      break
    end
  end
  if node ~= lastNode then
    return
  end
  local param = {}
  param.titlePath = "images/Bless/titleBless.png"
  param.rewards = self.rewards
  param.content = {}
  param.content.str = TwGetStr(110854)
  param.content.color = ccc3(48, 255, 0)
  param.content.style = kCCLabelTTFStyleOutline
  param.blessJade = self.jade
  Prompt:IconConfirm(self, param)
  self:FireEvent(EVT.RESET)
end
