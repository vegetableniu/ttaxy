module((...), package.seeall)
require("utf8")
require("Logic")
class = Logic.class:subclass()
local ERROR_CODE = TypeDef("com.eyu.mt.module.deposit.facade.DepositResult")
local MSG_RESULT = Enum(TypeDef("com.eyu.mt.module.deposit.facade.DepositResult"))
local MSG_RESULT_STR = {
  WITHDRAW_TIME_LIMIT = 111101,
  DEPOSIT_AMOUNT_NOT_ENOUGH = 111102,
  ACTIVE_CHARGE_LIMIT = 111103,
  HAS_DEPOSITED = 111104,
  DEPOSIT_TIME_END = 111105,
  ACTIVE_NOT_OPEN = 111106,
  ARGUMENT_ILLEGA = 111107,
  ACTIVE_CONSUME_LIMIT = 111108,
  ACTIVE_START_NOT_OPEN = 111109,
  ACTIVE_DRAW_NOT_OPEN = 111110
}
EVT = Enum({
  "GET_DEPOSIT_INFO_OK",
  "SAVE_JADES_OK",
  "GET_JADES_OK"
})
function class:initialize()
  super.initialize(self)
  self.depositInfo = {}
  self.kindsofLevelInfos = {}
  self.kindsofRates = {}
  self.saveEndTime = Logic:Get("System"):GetTime()
  Logic:Get("MsgAssist"):RecordErrorMsg("MsgDeposit", MSG_RESULT, MSG_RESULT_STR)
  MsgDeposit:On("GET_DEPOSIT_INFO", self:Event("OnGetDepositInfo"))
  MsgDeposit:On("DEPOSIT", self:Event("OnDeposit"))
  MsgDeposit:On("WITHDRAW", self:Event("OnWithDraw"))
end
function class:dispose()
  super.dispose(self)
end
function class:OnReset()
end
function class:OnGetDepositInfo(code, data)
  if code ~= 0 then
    Logic:Get("MsgAssist"):OnMsgResult("MsgDeposit", code)
    return
  end
  self.depositInfo = data
  self.saveEndTime = Logic:Get("System"):GetTime() + data.depositEndSeconds
  self:FireEvent(EVT.GET_DEPOSIT_INFO_OK, data)
end
function class:OnDeposit(code, data)
  if code ~= 0 then
    Logic:Get("MsgAssist"):OnMsgResult("MsgDeposit", code)
    return
  end
  self.depositInfo = data.depositVO
  self.saveEndTime = Logic:Get("System"):GetTime() + data.depositVO.depositEndSeconds
  Logic:Get("Cost"):AddCosts(data.costResults)
  self:FireEvent(EVT.SAVE_JADES_OK)
  Logic:Get("Gift"):PostGetActivitys()
end
function class:OnWithDraw(code, data)
  if code ~= 0 then
    Logic:Get("MsgAssist"):OnMsgResult("MsgDeposit", code)
    return
  end
  self.depositInfo = data.depositVO
  self.saveEndTime = Logic:Get("System"):GetTime() + data.depositVO.depositEndSeconds
  Logic:Get("Reward"):AddRewards(data.rewardResults)
  local str = TwGetStr(111090, data.baseMoney + data.income, data.baseMoney, data.income)
  Prompt:Confirm(self, "", str, self.onConfirm, Prompt.PROMPT_TYPE.CONFIRM)
  Logic:Get("Gift"):PostGetActivitys()
end
function class:PostGetDepositInfo()
  MsgDeposit:Post("GET_DEPOSIT_INFO")
end
function class:PostDeposit(typeId)
  MsgDeposit:Post("DEPOSIT", {id = typeId})
end
function class:PostWithDraw()
  MsgDeposit:Post("WITHDRAW")
end
function class:onConfirm()
  self:FireEvent(EVT.GET_JADES_OK)
end
function class:getDepositInfo()
  return self.depositInfo
end
function class:getSaveEndTime()
  return self.saveEndTime
end
function class:getKindsOfLevels()
  if self.kindsofLevelInfos and not table.empty(self.kindsofLevelInfos) then
    return self.kindsofLevelInfos
  end
  self.kindsofLevelInfos = {}
  for i = 1, KFDBGetRecordAmt("CapitalConfig") do
    local rec = KFDBGetRecordByIdx("CapitalConfig", i)
    if rec then
      table.insert(self.kindsofLevelInfos, rec)
    end
  end
  return self.kindsofLevelInfos
end
function class:getKindsofRates()
  if self.kindsofRates and not table.empty(self.kindsofRates) then
    return self.kindsofRates
  end
  self.kindsofRates = {}
  for i = 1, KFDBGetRecordAmt("DepositRateConfig") do
    local rec = KFDBGetRecordByIdx("DepositRateConfig", i)
    if rec then
      table.insert(self.kindsofRates, rec)
    end
  end
  return self.kindsofRates
end
function class:getNextRateInfoByDays(dayCount)
  self:getKindsofRates()
  local nextRate, nextLevelDays = 100, 1
  local lastCmpRateInfo
  for i, v in ipairs(self.kindsofRates) do
    lastCmpRateInfo = v
    if dayCount < v.id then
      nextRate = v.rate
      nextLevelDays = v.id
      break
    end
  end
  if dayCount >= lastCmpRateInfo.id then
    nextRate = lastCmpRateInfo.rate
    nextLevelDays = lastCmpRateInfo.id
  end
  return nextRate, nextLevelDays
end
function class:getIndexByCurDay(dayCount)
  self:getKindsofRates()
  local index = 0
  for i, v in ipairs(self.kindsofRates) do
    if dayCount >= v.id then
      index = i
    else
      break
    end
  end
  return index
end
function class:isSpecialDay(dayCount)
  self:getKindsofRates()
  for i, v in ipairs(self.kindsofRates) do
    if v.id == dayCount then
      return true
    end
  end
  return false
end
function class:getBothInfosByCurDay(dayCount)
  self:getKindsofRates()
  local prevInfo, nextInfo = {}, {}
  for i, v in ipairs(self.kindsofRates) do
    if dayCount >= v.id then
      prevInfo.index = i
      prevInfo.count = v.id
      prevInfo.rate = v.rate
    else
      nextInfo.index = i
      nextInfo.count = v.id
      nextInfo.rate = v.rate
      break
    end
  end
  return prevInfo, nextInfo
end
