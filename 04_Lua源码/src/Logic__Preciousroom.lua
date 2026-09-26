module((...), package.seeall)
require("Logic")
class = Logic.class:subclass()
EVT = Enum({"LOAD_SHOP"})
local ERROR_CODE = TypeDef("com.eyu.mt.module.preciousroom.facade.PreciousroomResult")
local MSG_RESULT = Enum(TypeDef("com.eyu.mt.module.preciousroom.facade.PreciousroomResult"))
local MSG_RESULT_STR = {
  PLEASE_LOAD_ENTITY_FIRST = 110620,
  GOOD_IS_EXPIRE = 110620,
  COST_REFRESH_TIMES_LIMIT = 110619,
  POSITION_TREASURE_HAD_BEEN_GOT = 110618,
  NO_RELATIVE_POSITION_TREASURE = 110617,
  ACTIVITY_NOT_OPEN = 111106,
  CURRENCY_IS_NOT_ENOUGH = 10040,
  CAN_REFRESH = 112056
}
function class:initialize()
  super.initialize(self)
  self.mallData = {}
  self.preciousInfo = {}
  Logic:Get("MsgAssist"):RecordErrorMsg("MsgPreciousroom", MSG_RESULT, MSG_RESULT_STR)
  MsgPreciousroom:On("LOAD_SHOP", self:Event("OnLoadShop"))
  MsgPreciousroom:On("EXCHANGE", self:Event("OnExchange"))
  MsgPreciousroom:On("REFRESH", self:Event("OnRefresh"))
end
function class:dispose()
  super.dispose(self)
end
function class:SetMallData(mallData)
  self.mallData = mallData
end
function class:GetMallData()
  return self.mallData
end
function class:GetPreciousInfo()
  return self.preciousInfo
end
function class:IsExchanged(position)
  local tab = table.invert(self.preciousInfo.gotTreasures)
  return tab[position] or false
end
function class:PostLoadShop()
  MsgPreciousroom:Post("LOAD_SHOP", {
    mallId = self.mallData.id
  })
end
function class:PostExchange(position)
  if nil == position then
    return
  end
  MsgPreciousroom:Post("EXCHANGE", {
    mallId = self.mallData.id,
    position = position
  })
end
function class:PostRefresh()
  MsgPreciousroom:Post("REFRESH", {
    mallId = self.mallData.id
  })
end
function class:OnRefresh(code, data)
  if code ~= 0 then
    return
  end
  Logic:Get("Cost"):AddCosts(data.costResults)
  self.preciousInfo.time = data.nextTime
  self.preciousInfo.refreshTimes = data.times
  self.preciousInfo.treasures = data.treasures
  self.preciousInfo.gotTreasures = {}
  self:FireEvent(EVT.LOAD_SHOP)
end
function class:OnLoadShop(code, data)
  if code ~= 0 then
    return
  end
  self.preciousInfo = data
  self:FireEvent(EVT.LOAD_SHOP)
end
function class:OnExchange(code, data)
  if code ~= 0 then
    return
  end
  Logic:Get("Cost"):AddCosts(data.costResults)
  Logic:Get("Reward"):AddRewards(data.rewardResults)
  local str = Logic:Get("Reward"):AddDupiCardTip(data.rewardResults)
  Prompt:Msg(str)
  if data.roomCurrency and 0 < data.roomCurrency then
    self.preciousInfo.roomCurrency = data.roomCurrency
  end
  self.preciousInfo.gotTreasures = data.gotTreasures
  self.preciousInfo.treasures = data.treasures
  self:FireEvent(EVT.LOAD_SHOP)
end
function class:GetRefreshCost()
  if not table.empty(self.mallData or {}) then
  elseif table.empty(self.preciousInfo or {}) then
    return 0
  end
  if self.preciousInfo.refreshTimes then
    local costId = string.format("%d_%d", self.mallData.id, self.preciousInfo.refreshTimes + 1)
    local rec = KFDBGetRecord("PrRefCost", costId)
    if rec then
      return rec.cost or 0
    end
  end
  local costId = string.format("%d_default", self.mallData.id)
  local rec = KFDBGetRecord("PrRefCost", costId) or {}
  return rec.cost or 0
end
