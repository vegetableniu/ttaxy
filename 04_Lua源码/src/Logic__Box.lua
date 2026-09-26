module((...), package.seeall)
require("Logic")
class = Logic.class:subclass()
EVT = Enum({
  "LOAD_BOX_INFO",
  "OPEN_BOX_BY_KEY"
})
local STR = {
  TwGetStr(110613),
  TwGetStr(110614),
  TwGetStr(110615)
}
local ERROR_CODE = TypeDef("com.eyu.mt.module.box.facade.BoxResult")
local MSG_RESULT = Enum(TypeDef("com.eyu.mt.module.box.facade.BoxResult"))
local MSG_RESULT_STR = {
  COST_OPEN_TIMES_LIMIT = 110607,
  NOT_ENOUGH_CURRENCY = 10036,
  NOT_ENOUGH_KEY = 110605,
  BOX_NOT_EXIST = 110606,
  ACTIVITY_NOT_OPEN = 111106
}
function class:initialize()
  super.initialize(self)
  self.boxInfo = {}
  self.boxId = 0
  Logic:Get("MsgAssist"):RecordErrorMsg("MsgBox", MSG_RESULT, MSG_RESULT_STR)
  MsgBox:On("LOAD_BOX_INFO", self:Event("OnLoadBoxInfo"))
  MsgBox:On("OPEN_BOX_BY_KEY", self:Event("OnOpenBoxByKey"))
  MsgBox:On("OPEN_BOX_BY_CURRENCY", self:Event("OnOpenBoxByCurrency"))
end
function class:dispose()
  super.dispose(self)
end
function class:AddKeyByType(code, amount)
  if table.empty(self.boxInfo) then
    return
  end
  self.boxInfo.keys[code] = self.boxInfo.keys[code] and self.boxInfo.keys[code] + amount or amount
end
function class:GetKeyNumById(id)
  if table.empty(self.boxInfo) or not id then
    return 0, 0
  end
  local keyId = id .. "_" .. 0
  local rec = KFDBGetRecord("BoxSetting", keyId)
  if rec then
    local KEY_TYPE = TypeDef("com.eyu.mt.module.box.model.KeyType")
    if KEY_TYPE[rec.keyType] then
      return self.boxInfo.keys[KEY_TYPE[rec.keyType]] or 0, KEY_TYPE[rec.keyType] + 1
    end
  end
  return 0, 0
end
function class:GetCostByType(keyType)
  if table.empty(self.boxInfo) or not keyType then
    return 0
  end
  local openTime = self.boxInfo.costOpenTimes[keyType] or 0
  local id = keyType .. "_" .. openTime + 1
  local rec = KFDBGetRecord("BoxCostSetting", id)
  if rec then
    return rec.cost
  end
  id = keyType .. "_" .. 0
  rec = KFDBGetRecord("BoxCostSetting", id)
  if rec then
    return rec.cost
  end
  return 0
end
function class:IsOverOpenTime(key)
  local rec = KFDBGetRecord("OpenTimesSetting", key)
  if rec then
    local maxTime = self:GetMaxOpenTime(rec.chargeAddType)
    local currTime = self.boxInfo.costOpenTimes[key] or 0
    return maxTime <= currTime
  end
  return false
end
function class:GetMaxOpenTime(chargeAddType)
  local data = {}
  for i = 1, KFDBGetRecordAmt("Charge2Times") do
    local rec = KFDBGetRecordByIdx("Charge2Times", i)
    if rec and rec.type == chargeAddType then
      table.insert(data, rec)
    end
  end
  local sort = function(a, b)
    return a.chargeAmount < b.chargeAmount
  end
  table.sort(data, sort)
  local wallet = Logic:Get("PlayerInfo"):GetPlayerMoney()
  local maxOpenTime = 0
  for k, v in pairs(data) do
    if wallet.totalCharge >= v.chargeAmount and maxOpenTime < v.addTimes then
      maxOpenTime = v.addTimes
    end
  end
  return maxOpenTime
end
function class:PostLoadBoxInfo()
  MsgBox:Post("LOAD_BOX_INFO")
end
function class:PostOpenBoxByKey(boxId)
  if nil == boxId then
    return
  end
  self.boxId = boxId
  MsgBox:Post("OPEN_BOX_BY_KEY", {boxId = boxId})
end
function class:PostOpenBoxByCurrency(boxId)
  if nil == boxId then
    return
  end
  self.boxId = boxId
  MsgBox:Post("OPEN_BOX_BY_CURRENCY", {boxId = boxId})
end
function class:OnLoadBoxInfo(code, data)
  if code ~= 0 then
    return
  end
  self.boxInfo = data
  Logic:Get("PlayerInfo"):SetTokenCoin(data.coinNum)
  self:FireEvent(EVT.LOAD_BOX_INFO)
end
function class:OnOpenBoxByKey(code, data)
  if code ~= 0 then
    return
  end
  self.boxInfo.keys = data.keys
  Logic:Get("Reward"):AddRewards(data.rewardResults)
  local str = Logic:Get("Reward"):AddDupiCardTip(data.rewardResults)
  str = TwGetStr(110616, STR[self.boxId] or STR[1]) .. [[

 
]] .. str
  Prompt:Msg(str)
  self:FireEvent(EVT.OPEN_BOX_BY_KEY)
end
function class:OnOpenBoxByCurrency(code, data)
  if code ~= 0 then
    return
  end
  self.boxInfo.costOpenTimes = data.costOpenTimes
  Logic:Get("Cost"):AddCosts(data.costResults)
  Logic:Get("Reward"):AddRewards(data.rewardResults)
  local str = Logic:Get("Reward"):AddDupiCardTip(data.rewardResults)
  str = TwGetStr(110616, STR[self.boxId] or STR[1]) .. [[

 
]] .. str
  Prompt:Msg(str)
  self:FireEvent(EVT.LOAD_BOX_INFO)
end
