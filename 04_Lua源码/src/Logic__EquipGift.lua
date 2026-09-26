module((...), package.seeall)
require("utf8")
require("Logic")
class = Logic.class:subclass()
local MSG_RESULT = Enum(TypeDef("com.eyu.mt.module.equipgift.facade.EquipgiftResult"))
local MSG_RESULT_STR = {
  ACTIVITY_IS_NOT_OPEN = 111631,
  CURRENCY_NOT_ENOUGH = 111632,
  BUY_TIMES_LIMIT = 111633,
  NO_RELATIVE_GOODS_ID = 111634
}
EVT = Enum({
  "BUY_GIFT_OVER",
  "BUY_GIFT_OK"
})
function class:initialize()
  super.initialize(self)
  self.goodId = 0
  self.timesMap = {}
  self.activityInfo = {}
  self.fromMall = false
  Logic:Get("MsgAssist"):RecordErrorMsg("MsgEquipgift", MSG_RESULT, MSG_RESULT_STR)
  MsgEquipgift:On("LOAD_EQUIP_GIFT", self:Event("OnLoadEquipGift"))
  MsgEquipgift:On("BUY_EQUIP_GIFT", self:Event("OnBuyEquipGift"))
end
function class:OnLoadEquipGift(code, data)
  self.timesMap = data or {}
  self:FireEvent(EVT.BUY_GIFT_OK)
end
function class:OnBuyEquipGift(code, data)
  Logic:Get("Cost"):AddCosts(data.costResults)
  Logic:Get("Reward"):AddRewards(data.randomRewardResults)
  Logic:Get("Reward"):AddRewards(data.rewardResults)
  local str = Logic:Get("Reward"):AddDupiCardTip(data.randomRewardResults)
  str = (str or "") .. Logic:Get("Reward"):AddDupiCardTip(data.rewardResults)
  self.timesMap[self.goodId] = self.timesMap[self.goodId] or {}
  self.timesMap[self.goodId].times = self.timesMap[self.goodId].times or 0
  self.timesMap[self.goodId].todayTimes = self.timesMap[self.goodId].todayTimes or 0
  self.timesMap[self.goodId].times = self.timesMap[self.goodId].times + 1
  self.timesMap[self.goodId].todayTimes = self.timesMap[self.goodId].todayTimes + 1
  self:FireEvent(EVT.BUY_GIFT_OK)
  Prompt:Confirm(self, "", str, self.onConfirm, Prompt.PROMPT_TYPE.CONFIRM)
end
function class:PostLoadEquipGift(id)
  MsgEquipgift:Post("LOAD_EQUIP_GIFT", {activityId = id})
end
function class:PostBuyEquipGift(id, gId)
  self.goodId = gId
  MsgEquipgift:Post("BUY_EQUIP_GIFT", {activityId = id, goodsId = gId})
end
function class:getGiftArray(giftArrayId)
  local rec = KFDBGetRecord("ActivityGoods", giftArrayId)
  if rec == nil or table.empty(rec) then
    return {}, ""
  end
  local giftArray = json.decode(rec.goods or "[]") or {}
  return giftArray, rec.condition
end
function class:getGiftInfo(goodId)
  local rec = KFDBGetRecord("GiftGoods", goodId)
  if rec == nil or table.empty(rec) then
    return {}
  end
  rec.showType = json.decode(rec.showTypeId or "[]") or {}
  rec.showIds = json.decode(rec.showIds or "[]") or {}
  rec.counts = json.decode(rec.counts or "[]") or {}
  rec.rare = json.decode(rec.rare or "[]") or {}
  return rec
end
function class:setActivityInfo(id, name, endTime)
  self.activityInfo = {}
  self.activityInfo.id = id
  self.activityInfo.name = name
  self.activityInfo.endTime = endTime
end
function class:getActivityInfo()
  return self.activityInfo
end
function class:getTimesInfo(goodId)
  if self.timesMap[goodId] == nil then
    return 0, 0
  end
  return self.timesMap[goodId].todayTimes or 0, self.timesMap[goodId].times or 0
end
function class:setFromMallFlag(flag)
  self.fromMall = flag
end
function class:isFromMallFlag()
  return self.fromMall
end
function class:jumpToPrevUI()
  self:FireEvent(EVT.BUY_GIFT_OVER)
end
function class:onConfirm()
  local rec = self:getGiftInfo(self.goodId)
  if rec.totalbuyLimit and rec.totalbuyLimit > 0 and rec.totalbuyLimit <= self.timesMap[self.goodId].times then
    if not self.fromMall then
      Logic:Get("Gift"):PostGetActivitys()
    else
      self:FireEvent(EVT.BUY_GIFT_OVER)
    end
  end
end
