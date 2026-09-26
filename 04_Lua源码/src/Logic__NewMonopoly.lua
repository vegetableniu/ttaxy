require("Logic")
module((...), package.seeall)
EVT = Enum({
  "LOAD_NEWMONOPOLY",
  "CAST_DICE",
  "PICKUP_TASK",
  "COMPLETE_TASK",
  "GIVEUP_TASK",
  "DRAW_TASK_REWARD",
  "BUY_GOODS",
  "DRAW_BOX_REWARD",
  "PUSH_SCENE",
  "CURRENCY_CHANGED",
  "ACROSS_DATE",
  "SELECT_SUBSTITUE",
  "SELECT_ROUTE",
  "SWITCH_DRAG"
})
local ERROR_CODE = TypeDef("com.eyu.mt.module.newmonopoly.facade.NewMonopolyResult")
local MSG_RESULT = Enum(ERROR_CODE)
local MSG_RESULT_STR = {
  CAST_SPEICAL_DICE_VAIN = 115371,
  MONOPOLY_SUBSTITUE_NOT_ENOUGH = 115372,
  FLOOR_ON_FORK = 115373,
  COST_CAST_NOT_NEED = 115367,
  BUFF_NOT_EXIST = 115366,
  DAILY_RESET = 115082,
  RINGS_BOX_CAN_NOT_DRAW = 115351,
  RINGS_BOX_NOT_FOUND = 115056,
  RINGS_BOX_HAD_DRAW = 115352,
  POSITION_NOT_FORK_START = 115353,
  FLOOR_IS_NOT_FORK = 115354,
  MONOPOLY_CURRENCY_NOT_ENOUGH = 115355,
  BUY_GOODS_TIME_LIMIT = 10078,
  GOODS_NOT_FOUND = 115356,
  TASK_NOT_COMPLETED = 115357,
  TASK_NOT_ACCEPTED = 115358,
  TASK_HAS_COMPLETED = 115359,
  TASK_HAS_GOT_REWARDED = 115360,
  TASK_HAS_ACCEPTED = 115361,
  TASK_ACCEPT_AMOUNT_LIMIT = 115362,
  TASK_NOT_FOUND = 115363,
  COST_NOT_ENOUGH = 10036,
  CAST_DICE_LIMIT = 115364,
  CAST_DICE_TIME_LIMIT = 115365,
  ACTIVITY_NOT_OPEN = 100071
}
class = Logic.class:subclass()
function class:initialize()
  super.initialize(self)
  self.monoInfo = {}
  self.steps = {}
  self.actStep = 0
  self.bChooseA = false
  self.bMoveOnFork = false
  self.forkSnares = {}
  self.snares = {}
  self.reward = {}
  self.boxData = {}
  self.showRewardType = ""
  self.bComplete = false
  self.costCurrency = 0
  Logic:Get("MsgAssist"):RecordErrorMsg("MsgNewmonopoly", MSG_RESULT, MSG_RESULT_STR)
  MsgNewmonopoly:On("LOAD_NEWMONOPOLY", self:Event("OnLoadNewMonopoly"))
  MsgNewmonopoly:On("CAST_DICE", self:Event("OnCastDice"), false)
  MsgNewmonopoly:On("COST_CAST_DICE", self:Event("OnCostCastDice"), false)
  MsgNewmonopoly:On("CAST_SPEICAL_DICE", self:Event("OnCastSpeicalDice"), false)
  MsgNewmonopoly:On("COST_CAST_SPEICAL_DICE", self:Event("OnCostCastSpeicalDice"), false)
  MsgNewmonopoly:On("ACCEPT_TASK", self:Event("OnAcceptTask"), false)
  MsgNewmonopoly:On("GIVE_UP_TASK", self:Event("OnGiveUpTask"), false)
  MsgNewmonopoly:On("COMPLETE_TASK", self:Event("OnCompleteTask"), false)
  MsgNewmonopoly:On("DRAW_TASK_REWARD", self:Event("OnDrawTaskReward"), false)
  MsgNewmonopoly:On("BUG_GOODS", self:Event("OnBuyGoods"), false)
  MsgNewmonopoly:On("SELECT_ROUTE", self:Event("OnSelectRoute"), false)
  MsgNewmonopoly:On("SELECT_SUBSTITUE", self:Event("OnSelectSubstitue"), false)
  MsgNewmonopoly:On("DRAW_BOX_REWARD", self:Event("OnDrawBoxReward"), false)
  Singleton(NetMgr):On(NetMgr.EVT.NEW_MONOPOLY_TASK_COMPLETE, self:Event("OnMonoTaskComplete"))
end
function class:dispose()
  super.dispose(self)
end
function class:GetDicePoints()
  return self.steps or 0
end
function class:GetActStep()
  return self.actStep
end
function class:isMoveOnFork()
  return self.bMoveOnFork
end
function class:GetSnares()
  return self.snares or {}
end
function class:GetForkSnares()
  return self.forkSnares
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
    [1] = "cast",
    [2] = "specialCast"
  }
  local currencyType = currencyMap[reward.code]
  if currencyType then
    self.monoInfo[currencyType] = self.monoInfo[currencyType] or 0
    self.monoInfo[currencyType] = self.monoInfo[currencyType] + reward.amount
  end
end
function class:PostLoadNewMonopoly()
  MsgNewmonopoly:Post("LOAD_NEWMONOPOLY")
end
function class:PostCastDice()
  MsgNewmonopoly:Post("CAST_DICE")
end
function class:PostCostCastDice()
  MsgNewmonopoly:Post("COST_CAST_DICE")
end
function class:PostCastSpeicalDice(step)
  if not step then
    return
  end
  MsgNewmonopoly:Post("CAST_SPEICAL_DICE", step)
end
function class:PostCostCastSpeicalDice(step)
  if not step then
    return
  end
  MsgNewmonopoly:Post("COST_CAST_SPEICAL_DICE", step)
end
function class:PostAcceptTask(id)
  if not id then
    return
  end
  MsgNewmonopoly:Post("ACCEPT_TASK", id)
end
function class:PostGiveUpTask(id)
  MsgNewmonopoly:Post("GIVE_UP_TASK", id)
end
function class:PostCompleteTask(id)
  MsgNewmonopoly:Post("COMPLETE_TASK", id)
end
function class:PostDrawTaskReward(id)
  MsgNewmonopoly:Post("DRAW_TASK_REWARD", id)
end
function class:PostBuyGoods(goodsId, cost, costCurrency)
  self.costCurrency = costCurrency
  if not goodsId then
    return
  end
  MsgNewmonopoly:Post("BUG_GOODS", {goodsId = goodsId, cost = cost})
end
function class:PostSelectRoute(bChooseA)
  self.bChooseA = bChooseA
  MsgNewmonopoly:Post("SELECT_ROUTE", bChooseA)
end
function class:PostSelectSubstitue(cost, substitute)
  MsgNewmonopoly:Post("SELECT_SUBSTITUE", {cost = cost, substitute = substitute})
end
function class:PostDrawBoxReward(id)
  if not id then
    return
  end
  MsgNewmonopoly:Post("DRAW_BOX_REWARD", id)
end
function class:OnLoadNewMonopoly(code, data)
  if code ~= 0 then
    return
  end
  self.monoInfo = data
  self:FireEvent(EVT.LOAD_NEWMONOPOLY)
end
function class:OnCastDice(code, data)
  self:dealWithDiceData(code, data, false)
end
function class:OnCostCastDice(code, data)
  self:dealWithDiceData(code, data, false)
end
function class:OnCastSpeicalDice(code, data)
  self:dealWithDiceData(code, data, true)
end
function class:OnCostCastSpeicalDice(code, data)
  self:dealWithDiceData(code, data, true)
end
function class:dealWithDiceData(code, data, bAdvDice)
  if code ~= 0 then
    self:OnError(code, data)
    return
  end
  Logic:Get("Cost"):AddCosts(data.costResults)
  Logic:Get("Reward"):AddRewards(data.rewardResults)
  self.reward = data.rewardResults or {}
  local currFloor = self.monoInfo.currFloor
  self.bMoveOnFork = self.monoInfo.floors[currFloor].fork
  local tempInfo = self.monoInfo
  self.monoInfo = data.newMonopolyVo
  for floor, data in pairs(tempInfo.floors) do
    if not self.monoInfo.floors[floor] then
      self.monoInfo.floors[floor] = data
    end
  end
  self.steps = data.steps
  self.actStep = data.actStep
  self.snares = data.snares
  self.forkSnares = data.forkSnares
  self:FireEvent(EVT.CAST_DICE, bAdvDice)
end
function class:OnAcceptTask(code, data)
  if code ~= 0 then
    self:OnError(code, data)
    return
  end
  self:dealWithTaskData(data)
  self:FireEvent(EVT.PICKUP_TASK)
end
function class:OnGiveUpTask(code, data)
  if code ~= 0 then
    self:OnError(code, data)
    return
  end
  self:dealWithTaskData(data)
  self:FireEvent(EVT.GIVEUP_TASK)
end
function class:OnCompleteTask(code, data)
  if code ~= 0 then
    self:OnError(code, data)
    return
  end
  self:dealWithTaskData(data)
  self:FireEvent(EVT.COMPLETE_TASK)
end
function class:OnDrawTaskReward(code, data)
  if code ~= 0 then
    self:OnError(code, data)
    return
  end
  self:dealWithTaskData(data)
  self.bComplete = false
  Logic:Get("Gift"):FireEvent(Logic.Gift.EVT.REFRESH_GIFT)
  self:FireEvent(EVT.DRAW_TASK_REWARD)
end
function class:dealWithTaskData(data)
  Logic:Get("Cost"):AddCosts(data.costResults)
  Logic:Get("Reward"):AddRewards(data.rewardResults)
  if not table.empty(data.rewardResults or {}) then
    local str = Logic:Get("Reward"):AddDupiCardTip(data.rewardResults)
    Prompt:Msg(str)
  end
  self.monoInfo.stepCompleted = data.stepCompleted
  self.monoInfo.taskProgress = data.taskProgress
  self.monoInfo.tasks = data.tasks
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
function class:OnBuyGoods(code, data)
  if code ~= 0 then
    self:OnError(code, data)
    return
  end
  self.monoInfo.currency = self.monoInfo.currency - self.costCurrency
  self.monoInfo.boughtGoods = data.boughtGoods
  Logic:Get("Cost"):AddCosts(data.costResults)
  Logic:Get("Reward"):AddRewards(data.rewardResults)
  local str = Logic:Get("Reward"):AddDupiCardTip(data.rewardResults)
  Prompt:Msg(str)
  self:FireEvent(EVT.BUY_GOODS)
  self:FireEvent(EVT.CURRENCY_CHANGED)
end
function class:OnSelectRoute(code, data)
  if code ~= 0 then
    self:OnError(code, data)
    return
  end
  self.monoInfo.floors.valentine.fork = self.bChooseA
  self.bMoveOnFork = self.bChooseA
  self.monoInfo.stepCompleted = true
  self:FireEvent(EVT.SELECT_ROUTE)
end
function class:OnSelectSubstitue(code, data)
  if code ~= 0 then
    self:OnError(code, data)
    return
  end
  Logic:Get("Cost"):AddCosts(data.costResults)
  self.monoInfo.buffTimes = data.buffTimes
  self.monoInfo.currBuff = data.currBuff
  self.monoInfo.stepCompleted = data.stepCompleted
  self.monoInfo.substitute = data.substitute
  self:FireEvent(EVT.CURRENCY_CHANGED)
  self:FireEvent(EVT.SELECT_SUBSTITUE)
end
function class:OnDrawBoxReward(code, data)
  if code ~= 0 then
    self:OnError(code, data)
    return
  end
  local currFloor = self.monoInfo.currFloor
  self.monoInfo.floors[currFloor].drewBoxs = data.drewBoxs
  Logic:Get("Reward"):AddRewards(data.rewardResults)
  local str = Logic:Get("Reward"):AddDupiCardTip(data.rewardResults)
  Prompt:Msg(str)
  self:FireEvent(EVT.DRAW_BOX_REWARD)
  self:FireEvent(EVT.CURRENCY_CHANGED)
end
function class:OnMonoTaskComplete()
  self.bComplete = true
  Logic:Get("Gift"):FireEvent(Logic.Gift.EVT.REFRESH_GIFT)
end
function class:OnError(code, data)
  if code == ERROR_CODE.DAILY_RESET then
    Prompt:Confirm(self, "", TwGetStr(115082), self.acrossDate, Prompt.PROMPT_TYPE.CONFIRM)
    return
  end
  Logic:Get("MsgAssist"):OnMsgResult("MsgNewmonopoly", code)
end
function class:acrossDate()
  self:FireEvent(EVT.ACROSS_DATE)
end
