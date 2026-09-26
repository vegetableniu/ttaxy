require("Logic")
module((...), package.seeall)
local ERROR_CODE = TypeDef("com.eyu.mt.module.slot.facade.SlotResult")
local MSG_RESULT = Enum(ERROR_CODE)
local MSG_RESULT_STR = {
  PLEASE_LOAD_INFO_FIRST = 115101,
  FREE_LOTTERY_TIMES_LIMIT = 115102,
  COST_LOTTERY_TIMES_LIMIT = 115103,
  ACTIVITY_IS_NOT_OPEN = 100071,
  CROSS_DATE = 115104
}
EVT = Enum({"LOAD_INFO", "LOTTERY"})
class = Logic.class:subclass()
function class:initialize()
  super.initialize(self)
  self.slotInfo = {}
  self.appearPosition = 0
  self.isJadeLottery = false
  Logic:Get("MsgAssist"):RecordErrorMsg("MsgSlot", MSG_RESULT, MSG_RESULT_STR)
  MsgSlot:On("LOAD_INFO", self:Event("OnLoadInfo"))
  MsgSlot:On("LOTTERY", self:Event("OnLottery"))
end
function class:GetSlotInfo()
  return self.slotInfo or {}
end
function class:GetAppearPosition()
  return self.appearPosition
end
function class:AddLotteryTimes(reward)
  self.slotInfo.buyTimes = self.slotInfo.buyTimes + reward.amount
end
function class:PostLoadInfo()
  MsgSlot:Post("LOAD_INFO")
end
function class:PostLottery(currency)
  self.isJadeLottery = currency
  MsgSlot:Post("LOTTERY", {currency = currency})
end
function class:OnLoadInfo(code, data)
  if code ~= 0 then
    return
  end
  self.slotInfo = data
  self:FireEvent(EVT.LOAD_INFO)
end
function class:OnLottery(code, data)
  if code ~= 0 then
    return
  end
  Logic:Get("Cost"):AddCosts(data.costResults)
  Logic:Get("Reward"):AddRewards(data.rewardResults)
  self.reward = data.rewardResults
  self.appearPosition = data.appearPosition
  self.slotInfo.positionRewards = data.positionRewards
  self.slotInfo.records = data.records
  self:FireEvent(EVT.LOTTERY)
  if self.isJadeLottery then
    self.slotInfo.costtimes = self.slotInfo.costtimes + 1
    self.isJadeLottery = false
    return
  end
  self.slotInfo.freetimes = self.slotInfo.freetimes + 1
end
function class:PromptReward()
  if table.empty(self.reward) then
    return
  end
  local str = Logic:Get("Reward"):AddDupiCardTip(self.reward)
  Prompt:Msg(str)
end
