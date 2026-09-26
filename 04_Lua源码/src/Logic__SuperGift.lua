module((...), package.seeall)
require("Logic")
class = Logic.class:subclass()
EVT = Enum({"GOOD_INFO"})
local ERROR_CODE = TypeDef("com.eyu.mt.module.supergift.facade.SuperGiftResult")
local MSG_RESULT = Enum(TypeDef("com.eyu.mt.module.supergift.facade.SuperGiftResult"))
local MSG_RESULT_STR = {
  USER_LEVEL_ERROR = 108633,
  CURRENCY_NOT_ENOUGH = 10036,
  SELL_OUT = 108632,
  BUY_LIMIT = 108631,
  NOT_ON_SELL = 108630,
  GOODS_CONFIGE_WRONG = 108629,
  MALL_CLOSED = 108628
}
local TIME_STR = {
  "year",
  "month",
  "day",
  "hour",
  "min",
  "sec"
}
function class:initialize()
  super.initialize(self)
  self.goodsInfo = {}
  self.mallId = nil
  self.sendGoodId = nil
  Logic:Get("MsgAssist"):RecordErrorMsg("MsgSupergift", MSG_RESULT, MSG_RESULT_STR)
  MsgSupergift:On("GET_INFO", self:Event("OnGetInfo"))
  MsgSupergift:On("BUY_GOODS", self:Event("OnBuyGoods"), false)
end
function class:dispose()
  super.dispose(self)
end
function class:PostGetInfo(mallId)
  MsgSupergift:Post("GET_INFO", mallId)
end
function class:PostBuyGoods(mallId)
  self.mallId = mallId
  if self.sendGoodId then
    MsgSupergift:Post("BUY_GOODS", {
      goodsId = self.sendGoodId,
      mallId = mallId
    })
  end
end
function class:OnGetInfo(code, data)
  if code == 0 then
    self.goodsInfo = data
    self:FireEvent(EVT.GOOD_INFO)
  end
end
function class:OnBuyGoods(code, data)
  if code == 0 then
    Logic:Get("Cost"):CostAndReward(data.costAndReward)
    self.goodsInfo = data.showList
    self:FireEvent(EVT.GOOD_INFO)
    local rec = KFDBGetRecord("SuperGoods", self.sendGoodId)
    if rec and rec.showType == "LOTTERY" then
      Logic:Get("Lottery"):ShowDrawResult(data.costAndReward.rewards)
      return
    end
    local str = Logic:Get("Reward"):AddDupiCardTip(data.costAndReward.rewards)
    Prompt:Fail(str)
  else
    if code == ERROR_CODE.NOT_ON_SELL then
      Prompt:Confirm(self, "", TwGetStr(108630), self.getGoodsInfoAgain, Prompt.PROMPT_TYPE.CONFIRM)
      return
    elseif code == ERROR_CODE.SELL_OUT then
      Prompt:Confirm(self, "", TwGetStr(108632), self.getGoodsInfoAgain, Prompt.PROMPT_TYPE.CONFIRM)
      return
    elseif code == ERROR_CODE.BUY_LIMIT then
      Prompt:Confirm(self, "", TwGetStr(108631), self.getGoodsInfoAgain, Prompt.PROMPT_TYPE.CONFIRM)
      return
    end
    Logic:Get("MsgAssist"):OnMsgResult("MsgSupergift", code)
  end
end
function class:setSendGoodId(goodId)
  self.sendGoodId = goodId
end
function class:getGoodsInfoAgain()
  if self.mallId then
    self:PostGetInfo(self.mallId)
  end
end
function class:getGoodsInfo()
  return self.goodsInfo
end
function class:compareTime(startTime, endTime)
  if startTime == nil or endTime == nil then
    return
  end
  local startTime = Logic:Get("System"):DiffTime(startTime)
  local endTime = Logic:Get("System"):DiffTime(endTime)
  if startTime <= 0 and endTime >= 0 then
    return true
  end
  return false
end
function class:GetItemTime(timeStr)
  if timeStr == nil or "" == timeStr then
    return {}
  end
  local timeTab = {}
  local startIdx = 1
  local endIdx = 1
  for _, key in pairs(TIME_STR) do
    startIdx, endIdx = string.find(timeStr, "%d+", startIdx)
    if startIdx and endIdx then
      timeTab[key] = tonumber(string.match(timeStr, "%d+", startIdx))
      startIdx = endIdx + 1
    end
  end
  return os.time(timeTab)
end
