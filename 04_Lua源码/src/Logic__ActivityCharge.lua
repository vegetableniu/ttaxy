require("Logic")
module((...), package.seeall)
class = Logic.class:subclass()
EVT = Enum({"LOAD_INFO", "DRAW"})
local ERROR_CODE = TypeDef("com.eyu.mt.module.activitycharge.facade.ActivitychargeResult")
local MSG_RESULT = Enum(ERROR_CODE)
local MSG_RESULT_STR = {
  ALREADY_DRAW = 115401,
  CHARGE_REWARD_NOT_EXIST = 115402,
  CHARGE_NOT_ENOUGH = 115403,
  ACTIVITY_IS_NOT_OPEN = 100071
}
function class:initialize()
  super.initialize(self)
  self.chargeInfo = {}
  self.drawId = 0
  Logic:Get("MsgAssist"):RecordErrorMsg("MsgActivitycharge", MSG_RESULT, MSG_RESULT_STR)
  MsgActivitycharge:On("LOAD_INFO", self:Event("onLoadInfo"))
  MsgActivitycharge:On("DRAW", self:Event("onDraw"))
end
function class:dispose()
  super.dispose(self)
end
function class:GetChargeInfo()
  return self.chargeInfo
end
function class:HasDrawReward(id)
  local drawIds = table.invert(self.chargeInfo.draw or {})
  return drawIds[id] and true or false
end
function class:hasNewReward()
  local activitys = Logic:Get("Gift"):GetActivityByType("ACTIVITY_CHARGE")
  if table.empty(activitys) then
    return false
  end
  local function canDraw(rec, activityId)
    if rec.activityId ~= activityId then
      return false
    end
    if (self.chargeInfo.charge or 0) < rec.charge then
      return false
    end
    if self:HasDrawReward(rec.id) then
      return false
    end
    return true
  end
  for i, actiData in ipairs(activitys) do
    for i = 1, KFDBGetRecordAmt("ChargeReward") do
      local rec = KFDBGetRecordByIdx("ChargeReward", i)
      if canDraw(rec, actiData.id) then
        return true
      end
    end
  end
  return false
end
function class:postLoadInfo()
  MsgActivitycharge:Post("LOAD_INFO")
end
function class:postDraw(id)
  self.drawId = id
  MsgActivitycharge:Post("DRAW", {id = id})
end
function class:onLoadInfo(code, data)
  self.chargeInfo = data
  self:FireEvent(EVT.LOAD_INFO)
end
function class:onDraw(code, data)
  self.chargeInfo.draw = self.chargeInfo.draw or {}
  table.insert(self.chargeInfo.draw, self.drawId)
  Logic:Get("Reward"):AddRewards(data)
  local str = Logic:Get("Reward"):AddDupiCardTip(data)
  Prompt:Msg(str)
  self:FireEvent(EVT.DRAW)
  Logic:Get("Gift"):FireEvent(Logic.Gift.EVT.REFRESH_GIFT)
end
