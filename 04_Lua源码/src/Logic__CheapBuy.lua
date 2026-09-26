module((...), package.seeall)
require("Logic")
class = Logic.class:subclass()
EVT = Enum({"GOODS_LIST"})
local ERROR_CODE = TypeDef("com.eyu.mt.module.cheapbuy.facade.CheapBuyResult")
local MSG_RESULT = Enum(TypeDef("com.eyu.mt.module.cheapbuy.facade.CheapBuyResult"))
local MSG_RESULT_STR = {
  CHARGE_NOT_ENOUGH = 108505,
  GOODS_NOT_EXIST = 108504,
  LEVEL_ERROR = 108503,
  GIFT_ERROR = 108502,
  MALL_IS_NOT_OPEN = 108501,
  CURRENCY_IS_NOT_ENOUGH = 108500
}
function class:initialize()
  super.initialize(self)
  self.goodsList = {}
  self.goodsId = 0
  self.charge = 0
  Logic:Get("MsgAssist"):RecordErrorMsg("MsgCheapbuy", MSG_RESULT, MSG_RESULT_STR)
  MsgCheapbuy:On("INFO", self:Event("OnGoodsInfo"))
  MsgCheapbuy:On("BUY", self:Event("OnBuyGood"))
end
function class:dispose()
  super.dispose(self)
end
function class:PostInfo(mallId)
  if mallId then
    MsgCheapbuy:Post("INFO", {mallId = mallId})
  end
end
function class:PostBuyGoods(id)
  if id then
    MsgCheapbuy:Post("BUY", {id = id})
  end
end
function class:OnGoodsInfo(code, data)
  if code == 0 then
    self.goodsId = data.id
    self:initGoodsList(data.buyIds)
    self.charge = data.charge
    self:FireEvent(EVT.GOODS_LIST)
  end
end
function class:OnBuyGood(code, data)
  if code == 0 then
    Logic:Get("Cost"):CostAndReward(data.costAndReward)
    local str = Logic:Get("Reward"):AddDupiCardTip(data.costAndReward.rewards)
    Prompt:Fail(str)
    self.goodsId = data.info.id
    self:initGoodsList(data.info.buyIds)
    self:FireEvent(EVT.GOODS_LIST)
  end
end
function class:getCurId()
  return self.goodsId
end
function class:initGoodsList(goodsList)
  self.goodsList = {}
  if table.empty(goodsList or {}) then
    return
  end
  for k, v in ipairs(goodsList) do
    self.goodsList[v] = true
  end
end
function class:getGoodsList()
  return self.goodsList
end
function class:lastGiftName(giftId)
  local data = Logic:Get("Mall"):getCheapBuyInfo()
  for i = 1, KFDBGetRecordAmt("CheapBuySetting") do
    local rec = KFDBGetRecordByIdx("CheapBuySetting", i)
    if rec and rec.mallId == data.id and rec.next and rec.next == giftId then
      return rec.name
    end
  end
  return ""
end
function class:getCharge()
  return self.charge
end
