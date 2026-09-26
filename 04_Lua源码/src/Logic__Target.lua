module((...), package.seeall)
require("Logic")
class = Logic.class:subclass()
EVT = Enum({
  "RE_EXCHANGE",
  "RE_GET_PROGRESS"
})
local MSG_RESULT = Enum(TypeDef("com.eyu.mt.module.target.facade.TargetResult"))
local MSG_RESULT_STR = {
  CURRENCY_CONSUME_NOT_ENOUGH = 105704,
  EXCHANGE_LEVEL_LIMIT = 105703,
  TARGET_NOT_OPEN = 105702,
  ARGUMENT_ILLEGAL = 105701
}
function class:initialize()
  super.initialize(self)
  self.progress = {}
  Logic:Get("MsgAssist"):RecordErrorMsg("MsgTarget", MSG_RESULT, MSG_RESULT_STR)
  MsgTarget:On("EXCHANGE", self:Event("OnExchange"), true)
  MsgTarget:On("GET_PROGRESS", self:Event("OnGetProgress"), true)
end
function class:dispose()
  super.dispose(self)
end
function class:SetProgress(progress)
  self.progress = progress
end
function class:GetProgress()
  return self.progress
end
function class:PostExchange(id)
  if id == nil then
    return
  end
  MsgTarget:Post("EXCHANGE", {id = id})
end
function class:PostGetProgress(type)
  MsgTarget:Post("GET_PROGRESS", {type = type})
end
function class:OnExchange(code, data)
  if code ~= 0 or data == nil then
    return
  end
  Logic:Get("Cost"):AddCosts(data.costs)
  Logic:Get("Reward"):AddRewards(data.rewards)
  self:FireEvent(EVT.RE_EXCHANGE)
end
function class:OnGetProgress(code, data)
  if code ~= 0 or data == nil then
    return
  end
  self.progress = data
  self:FireEvent(EVT.RE_GET_PROGRESS)
end
function class:IsActivityOpen()
  local bool = false
  local wallet = Logic:Get("PlayerInfo"):GetPlayerMoney()
  local chargeAm = KFDBGetRecord("ConfigValue", "TARGET:OPEN_CHARGE_AMOUNT")
  if wallet.totalCharge >= tonumber(chargeAm.content) then
    bool = true
  end
  return bool
end
