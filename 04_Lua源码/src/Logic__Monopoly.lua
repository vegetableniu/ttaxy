require("Logic")
module((...), package.seeall)
EVT = Enum({
  "LOAD_MONOPOLY",
  "DICE",
  "PICKUP_TASK",
  "COMPLETE_TASK",
  "GIVEUP_TASK",
  "DRAW_TASK_REWARD",
  "BUY_GOODS",
  "DRAW_BOX_REWARD",
  "PUSH_SCENE",
  "CURRENCY_CHANGED",
  "ACROSS_DATE"
})
local ERROR_CODE = TypeDef("com.eyu.mt.module.monopoly.facade.MonopolyResult")
local MSG_RESULT = Enum(ERROR_CODE)
local MSG_RESULT_STR = {
  ACROSS_DATE = 115082,
  CAN_DRAW_TASK_RRWARD = 115078,
  TASK_ALREADY_COMPLET = 115051,
  TASK_PROGRESS_IS_NOT_ENOUGH = 115052,
  HAD_DREW_TASK_REWARD = 115053,
  CAN_DRAW_BOX = 115054,
  HAD_DREW_BOX = 115055,
  RING_BOX_IS_NOT_EXISIT = 115056,
  TASK_PROGRESS_IS_ENOUGH = 115057,
  TOKEN_NOT_ENOUGH = 104119,
  IS_BOUGHT = 115058,
  GOODS_NOT_EXISIT = 111634,
  TASK_NOT_EXISIT = 115059,
  HAD_PICK_UP_TASK = 115060,
  HAD_NOT_PICK_UP_TASK = 115061,
  MUST_GIVE_UP_TASK = 115062,
  ADVANCE_DICE_STEP_NOT_AVAILABLE = 115063,
  DICE_IS_NOT_ENOUGH = 115064,
  SPECIAL_DICE_IS_NOT_ENOUGH = 115065,
  CURRENCY_IS_NOT_ENOUGH = 115066,
  ADVANCE_DICE_STEP_MUST_GREATER_ZERO = 115067,
  ACTIVITY_IS_NOT_OPEN = 111703
}
class = Logic.class:subclass()
function class:initialize()
  super.initialize(self)
  self.monoInfo = {}
  self.taskId = 0
  self.buyId = 0
  self.reward = {}
  self.boxData = {}
  self.drawBoxId = 0
  self.showRewardType = ""
  self.bComplete = false
  Logic:Get("MsgAssist"):RecordErrorMsg("MsgMonopoly", MSG_RESULT, MSG_RESULT_STR)
  MsgMonopoly:On("LOAD_MONOPOLY", self:Event("OnLoadMonopoly"))
  MsgMonopoly:On("DICE", self:Event("OnDice"), false)
  MsgMonopoly:On("ADVANCE_DICE", self:Event("OnAdvanceDice"), false)
  MsgMonopoly:On("DRAW_TASK_REWARD", self:Event("OnDrawTaskReward"), false)
  MsgMonopoly:On("GIVEUP_TASK", self:Event("OnGiveUpTask"), false)
  MsgMonopoly:On("BUY_GOODS", self:Event("OnBuyGoods"), false)
  MsgMonopoly:On("DRAW_BOX_REWARD", self:Event("OnDrawBoxReward"), false)
  MsgMonopoly:On("COST_DICE", self:Event("OnCostDice"), false)
  MsgMonopoly:On("COST_ADVANCE_DICE", self:Event("OnCostAdvanceDice"), false)
  MsgMonopoly:On("PICKUP_TASK", self:Event("OnPickUpTask"), false)
  MsgMonopoly:On("COMPLET_TASK", self:Event("OnCompleteTask"), false)
  Singleton(NetMgr):On(NetMgr.EVT.MONOPOLY_TASK_COMPLETE, self:Event("OnMonoTaskComplete"))
end
function class:dispose()
  super.dispose(self)
end
function class:IsCompleteMonoTask()
  return self.bComplete
end
function class:SetShowRewardType(showRewardType)
  self.showRewardType = showRewardType
end
function class:GetShowRewardType()
  return self.showRewardType
end
function class:SetBoxData(boxData)
  self.boxData = boxData
end
function class:GetBoxData()
  return self.boxData
end
function class:GetMonoInfo()
  return self.monoInfo
end
function class:AddDice(reward)
  local currencyMap = {
    [0] = "currency",
    [1] = "dice",
    [2] = "specialDice"
  }
  local currencyType = currencyMap[reward.code]
  if currencyType then
    self.monoInfo[currencyType] = self.monoInfo[currencyType] or 0
    self.monoInfo[currencyType] = self.monoInfo[currencyType] + reward.amount
  end
end
function class:PostLoadMonopoly()
  MsgMonopoly:Post("LOAD_MONOPOLY")
end
function class:PostDice()
  MsgMonopoly:Post("DICE")
end
function class:PostAdvanceDice(step)
  if not step then
    return
  end
  MsgMonopoly:Post("ADVANCE_DICE", {step = step})
end
function class:PostDrawTaskReward()
  MsgMonopoly:Post("DRAW_TASK_REWARD")
end
function class:PostGiveUpTask()
  MsgMonopoly:Post("GIVEUP_TASK")
end
function class:PostBuyGoods(id, useCurrency)
  if not id then
    return
  end
  self.buyId = id
  MsgMonopoly:Post("BUY_GOODS", {id = id, useCurrency = useCurrency})
end
function class:PostDrawBoxReward(id)
  if not id then
    return
  end
  self.drawBoxId = id
  MsgMonopoly:Post("DRAW_BOX_REWARD", {id = id})
end
function class:PostCostDice()
  MsgMonopoly:Post("COST_DICE")
end
function class:PostCostAdvanceDice(step)
  if not step then
    return
  end
  MsgMonopoly:Post("COST_ADVANCE_DICE", {step = step})
end
function class:PostPickUpTask(id)
  if not id then
    return
  end
  self.taskId = id
  MsgMonopoly:Post("PICKUP_TASK", {id = id})
end
function class:PostCompleteTask()
  MsgMonopoly:Post("COMPLET_TASK")
end
function class:OnLoadMonopoly(code, data)
  if code ~= 0 then
    return
  end
  self.monoInfo = data
  self:FireEvent(EVT.LOAD_MONOPOLY)
end
function class:OnDice(code, data)
  self:dealWithDiceData(code, data, false)
end
function class:dealWithDiceData(code, data, bAdvDice)
  if code ~= 0 then
    self:OnError(code, data)
    return
  end
  Logic:Get("Cost"):AddCosts(data.costResults)
  Logic:Get("Reward"):AddRewards(data.rewardResults)
  self.reward = data.rewardResults or {}
  self.monoInfo = data.monopolyVo
  self:FireEvent(EVT.DICE, bAdvDice)
end
function class:OnAdvanceDice(code, data)
  self:dealWithDiceData(code, data, true)
end
function class:OnDrawTaskReward(code, data)
  if code ~= 0 then
    self:OnError(code, data)
    return
  end
  self.monoInfo.task = 0
  self.monoInfo.tasks = {}
  Logic:Get("Reward"):AddRewards(data)
  self:FireEvent(EVT.CURRENCY_CHANGED)
  local str = Logic:Get("Reward"):AddDupiCardTip(data)
  Prompt:Msg(str)
  self.bComplete = false
  Logic:Get("Gift"):FireEvent(Logic.Gift.EVT.REFRESH_GIFT)
  self:FireEvent(EVT.DRAW_TASK_REWARD)
end
function class:PromptReward()
  if table.empty(self.reward) then
    self:FireEvent(EVT.PUSH_SCENE)
    return
  end
  local str = Logic:Get("Reward"):AddDupiCardTip(self.reward)
  Prompt:Confirm(self, "", str, self.closePrompt, Prompt.PROMPT_TYPE.COMFIRM)
end
function class:closePrompt()
  self:FireEvent(EVT.PUSH_SCENE)
end
function class:OnGiveUpTask(code, data)
  if code ~= 0 then
    self:OnError(code, data)
    return
  end
  self.monoInfo.task = 0
  self.monoInfo.tasks = {}
  self:FireEvent(EVT.GIVEUP_TASK)
end
function class:OnBuyGoods(code, data)
  if code ~= 0 then
    self:OnError(code, data)
    return
  end
  self.monoInfo.currency = self.monoInfo.currency - data.currency
  table.insert(self.monoInfo.boughts, self.buyId)
  Logic:Get("Cost"):AddCosts(data.costResults)
  Logic:Get("Reward"):AddRewards(data.rewardResults)
  local str = Logic:Get("Reward"):AddDupiCardTip(data.rewardResults)
  Prompt:Msg(str)
  self:FireEvent(EVT.BUY_GOODS)
  self:FireEvent(EVT.CURRENCY_CHANGED)
end
function class:OnDrawBoxReward(code, data)
  if code ~= 0 then
    self:OnError(code, data)
    return
  end
  table.insert(self.monoInfo.drewBox, self.drawBoxId)
  Logic:Get("Reward"):AddRewards(data)
  local str = Logic:Get("Reward"):AddDupiCardTip(data)
  Prompt:Msg(str)
  self:FireEvent(EVT.DRAW_BOX_REWARD)
  self:FireEvent(EVT.CURRENCY_CHANGED)
end
function class:OnCostDice(code, data)
  self:dealWithDiceData(code, data, false)
end
function class:OnCostAdvanceDice(code, data)
  self:dealWithDiceData(code, data, true)
end
function class:OnPickUpTask(code, data)
  if code ~= 0 then
    self:OnError(code, data)
    return
  end
  self.monoInfo.task = self.taskId
  self:FireEvent(EVT.PICKUP_TASK)
end
function class:OnCompleteTask(code, data)
  if code ~= 0 then
    self:OnError(code, data)
    return
  end
  Logic:Get("Cost"):AddCosts(data)
  self.monoInfo.tasks = {}
  self.monoInfo.completTask = true
  self:FireEvent(EVT.COMPLETE_TASK)
end
function class:OnMonoTaskComplete()
  self.bComplete = true
  Logic:Get("Gift"):FireEvent(Logic.Gift.EVT.REFRESH_GIFT)
end
function class:OnError(code, data)
  if code == ERROR_CODE.ACROSS_DATE then
    Prompt:Confirm(self, "", TwGetStr(115082), self.acrossDate, Prompt.PROMPT_TYPE.CONFIRM)
    return
  end
  Logic:Get("MsgAssist"):OnMsgResult("MsgMonopoly", code)
end
function class:acrossDate()
  self:FireEvent(EVT.ACROSS_DATE)
end
