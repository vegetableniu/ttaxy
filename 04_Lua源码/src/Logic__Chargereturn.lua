module((...), package.seeall)
require("Logic")
class = Logic.class:subclass()
EVT = Enum({
  "LOAD_CHARGERETURN",
  "DRAW_REWARD"
})
local ERROR_CODE = TypeDef("com.eyu.mt.module.chargereturn.facade.ChargereturnResult")
local MSG_RESULT = Enum(ERROR_CODE)
local MSG_RESULT_STR = {
  CHARGE_NOT_ENOUGH = 108805,
  NEED_TO_BEEN_VIP = 108804,
  NEED_TO_BEEN_WEEK = 108803,
  HAD_BEEN_DRAWN = 108802,
  PLEASE_SHOW_DATERETURN_ID = 108801,
  DATE_RETURN_NOT_EXIST = 108800,
  ACTIVITY_IS_NOT_OPEN = 108753
}
function class:initialize()
  super.initialize(self)
  self.chargereturn = {}
  self.hasDrawList = {}
  Logic:Get("MsgAssist"):RecordErrorMsg("MsgChargereturn", MSG_RESULT, MSG_RESULT_STR)
  MsgChargereturn:On("LOAD_CHARGERETURN", self:Event("OnLoadChargereturn"))
  MsgChargereturn:On("DRAW_REWARD", self:Event("OnDrawReward"))
end
function class:dispose()
  super.dispose(self)
end
function class:PostLoadChargereturn()
  MsgChargereturn:Post("LOAD_CHARGERETURN")
end
function class:PostDrawReward(id)
  self.drawId = id
  MsgChargereturn:Post("DRAW_REWARD", {
    ids = {id}
  })
end
function class:OnLoadChargereturn(code, data)
  if code ~= 0 then
    return
  end
  self.chargereturn = data
  self:setHasDrawList(data.drawRecord)
  self:FireEvent(EVT.LOAD_CHARGERETURN)
end
function class:OnDrawReward(code, data)
  if code ~= 0 then
    return
  end
  Logic:Get("Reward"):AddRewards(data)
  self:addDrawList()
  local str = Logic:Get("Reward"):AddDupiCardTip(data)
  Prompt:Tip(str)
  self:FireEvent(EVT.DRAW_REWARD)
end
function class:getChargereturn()
  return self.chargereturn
end
function class:setHasDrawList(info)
  for k, v in pairs(info or {}) do
    self.hasDrawList[v] = true
  end
end
function class:isDraw(id)
  return self.hasDrawList[id] or false
end
function class:addDrawList()
  if self.drawId then
    self.hasDrawList[self.drawId] = true
  end
end
