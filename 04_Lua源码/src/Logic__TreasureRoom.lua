module((...), package.seeall)
require("Logic")
class = Logic.class:subclass()
EVT = Enum({
  "LOAD_TREASUREROOM"
})
local ERROR_CODE = TypeDef("com.eyu.mt.module.treasureroom.facade.TreasureroomResult")
local MSG_RESULT = Enum(TypeDef("com.eyu.mt.module.treasureroom.facade.TreasureroomResult"))
local MSG_RESULT_STR = {
  GOOD_IS_EXPIRE = 110620,
  COST_REFRESH_TIMES_LIMIT = 110619,
  POSITION_TREASURE_HAD_BEEN_GOT = 110618,
  NO_RELATIVE_POSITION_TREASURE = 110617,
  ACTIVITY_NOT_OPEN = 111106,
  CURRENCY_IS_NOT_ENOUGH = 10040
}
local GEM_RESULT = Enum(TypeDef("com.eyu.mt.module.gemroom.facade.GemroomResult"))
local GEM_RESULT_STR = {
  NOT_IN_COOL_TIME = 105320,
  IS_IN_COOL_TIME = 105319,
  ACTIVITY_IS_NOT_OPEN = 111106,
  GOOD_IS_EXPIRE = 110620,
  COST_REFRESH_TIMES_LIMIT = 110619,
  POSITION_TREASURE_HAD_BEEN_GOT = 110618,
  NO_RELATIVE_POSITION_TREASURE = 110617,
  CURRENCY_IS_NOT_ENOUGH = 10040
}
function class:initialize()
  super.initialize(self)
  self.TreasureInfo = {}
  self.bGemScene = false
  Logic:Get("MsgAssist"):RecordErrorMsg("MsgTreasureroom", MSG_RESULT, MSG_RESULT_STR)
  MsgTreasureroom:On("LOAD_TREASUREROOM", self:Event("OnLoadTreasureRoom"))
  MsgTreasureroom:On("REFRESH", self:Event("OnRefresh"))
  MsgTreasureroom:On("EXCHANGE", self:Event("OnExchange"))
  Logic:Get("MsgAssist"):RecordErrorMsg("MsgGemroom", GEM_RESULT, GEM_RESULT_STR)
  MsgGemroom:On("LOAD_GEM_ROOM", self:Event("OnLoadGemRoom"))
  MsgGemroom:On("REFRESH", self:Event("OnGemRefresh"))
  MsgGemroom:On("EXCHANGE", self:Event("OnGemExchange"))
  MsgGemroom:On("CLEAR_COOL_TIME", self:Event("OnClearCoolTime"))
end
function class:dispose()
  super.dispose(self)
end
function class:GetTreasureInfo()
  return self.TreasureInfo or {}
end
function class:GetRefreshTime()
  return self.TreasureInfo.time
end
function class:IsExchanged(position)
  return self.TreasureInfo.gotTreasures[position]
end
function class:AddRoomCurrency(amount)
  self.TreasureInfo.roomCurrency = self.TreasureInfo.roomCurrency and self.TreasureInfo.roomCurrency + amount or amount
end
function class:SetGemScene(isGemScene)
  self.bGemScene = isGemScene
end
function class:IsSetGemScene()
  return self.bGemScene
end
function class:GetCoolTime()
  return self.TreasureInfo.coolTime
end
function class:IsColdDown()
  return self.TreasureInfo.coolState
end
function class:GetCurrencyInfo(currencyStr)
  local info = {}
  info.amount = self.TreasureInfo.roomCurrency
  info.type = "TREASURE_ROOM_CURRENCY"
  info.name = TwGetStr(110602)
  local jade = Logic:Get("PlayerInfo"):GetPlayerAllJade()
  local wallet = Logic:Get("PlayerInfo"):GetPlayerMoney()
  local tab = {
    GOLD = {
      type = "GOLD",
      amount = jade,
      name = TwGetStr(103009)
    },
    INTER = {
      type = "GOLD",
      amount = jade,
      name = TwGetStr(103009)
    },
    GIFT = {
      type = "GOLD",
      amount = jade,
      name = TwGetStr(103009)
    },
    COPPER = {
      type = "COPPER",
      amount = wallet[string.lower("COPPER")],
      name = TwGetStr(103008)
    }
  }
  local rec = json.decode(currencyStr or "[]") or {}
  if tab[rec[1]] then
    info = tab[rec[1]]
  end
  return info
end
function class:GetRefreshCost()
  if table.empty(self.TreasureInfo or {}) then
    return 0
  end
  local rec = KFDBGetRecord("CostSetting", self.TreasureInfo.refreshTimes + 1)
  if rec then
    return rec.cost
  end
  rec = KFDBGetRecord("CostSetting", 0)
  if rec then
    return rec.cost
  end
  return 0
end
function class:GetCurrencyPath(currencyStr)
  local path = "images/public/clarity05.png"
  if currencyStr and "" == currencyStr then
    path = "images/Mall/iconSpar.png"
  end
  local tab = {
    GOLD = "images/public/jade.png",
    INTER = "images/public/jade.png",
    GIFT = "images/public/jade.png",
    COPPER = "images/public/gold.png"
  }
  local rec = json.decode(currencyStr or "[]") or {}
  if tab[rec[1]] then
    path = tab[rec[1]]
  end
  return path
end
function class:GetTreasureList()
  local list = {}
  local kfdb = self.bGemScene and "GemRewardCost" or "RewCostSetting"
  for k, v in pairs(self.TreasureInfo.treasures) do
    local rec = KFDBGetRecord(kfdb, v)
    if rec then
      rec.position = k
      table.insert(list, rec)
    end
  end
  return list
end
function class:InitGotTreasures(data)
  local result = {}
  for k, v in pairs(data or {}) do
    if type(v) == "number" or type(v) == "string" then
      result[v] = k
    end
  end
  return result
end
function class:PostLoadTreasureRoom()
  MsgTreasureroom:Post("LOAD_TREASUREROOM")
end
function class:PostRefresh()
  MsgTreasureroom:Post("REFRESH")
end
function class:PostOpenBoxByCurrency(position)
  if nil == position then
    return
  end
  MsgTreasureroom:Post("EXCHANGE", {position = position})
end
function class:PostLoadGemRoom()
  MsgGemroom:Post("LOAD_GEM_ROOM")
end
function class:PostGemRefresh()
  MsgGemroom:Post("REFRESH")
end
function class:PostGemExchange(position)
  if nil == position then
    return
  end
  MsgGemroom:Post("EXCHANGE", {position = position})
end
function class:PostClearCoolTime()
  MsgGemroom:Post("CLEAR_COOL_TIME")
end
function class:OnLoadTreasureRoom(code, data)
  if code ~= 0 then
    return
  end
  self.TreasureInfo = data or {}
  self.TreasureInfo.gotTreasures = self:InitGotTreasures(data.gotTreasures)
  self:FireEvent(EVT.LOAD_TREASUREROOM)
end
function class:OnRefresh(code, data)
  if code ~= 0 then
    return
  end
  Logic:Get("Cost"):AddCosts(data.costResults)
  self.TreasureInfo.refreshTimes = data.times
  self.TreasureInfo.treasures = data.treasures
  self.TreasureInfo.time = data.nextTime
  self.TreasureInfo.gotTreasures = {}
  self:FireEvent(EVT.LOAD_TREASUREROOM)
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
    self.TreasureInfo.roomCurrency = data.roomCurrency
  end
  self.TreasureInfo.gotTreasures = self:InitGotTreasures(data.gotTreasures)
  self.TreasureInfo.treasures = data.treasures
  self:FireEvent(EVT.LOAD_TREASUREROOM)
end
function class:OnLoadGemRoom(code, data)
  self:OnLoadTreasureRoom(code, data)
end
function class:OnGemRefresh(code, data)
  if code ~= 0 then
    return
  end
  self.TreasureInfo.treasures = data.treasures
  self.TreasureInfo.coolTime = data.coolTime
  self.TreasureInfo.coolState = data.coolState
  self.TreasureInfo.gotTreasures = {}
  self:FireEvent(EVT.LOAD_TREASUREROOM)
end
function class:OnGemExchange(code, data)
  self:OnExchange(code, data)
end
function class:OnClearCoolTime(code, data)
  if code ~= 0 then
    return
  end
  self.TreasureInfo.coolTime = 0
  self.TreasureInfo.coolState = false
  Logic:Get("Cost"):AddCosts(data.costResults)
  self:FireEvent(EVT.LOAD_TREASUREROOM)
end
