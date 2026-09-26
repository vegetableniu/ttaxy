module((...), package.seeall)
require("Logic")
class = Logic.class:subclass()
EVT = Enum({"GET_INFO"})
local MSG_RESULT = Enum(TypeDef("com.eyu.mt.module.juhuasuan.facade.JuhuasuanResult"))
local MSG_RESULT_STR = {
  GOODS_VERSION_WRONG = 110810,
  GOODS_QUALIFICATION = 110803,
  GOODS_ALREADY_BUY = 110802,
  CURRENCY_NOT_ENCOUGH = 10036,
  ACTIVITY_CLOSED = 110801
}
function class:initialize()
  super.initialize(self)
  self.buyedRecords = {}
  self.canBuy = {}
  self.showlist = {}
  self.sendId = nil
  Logic:Get("MsgAssist"):RecordErrorMsg("MsgJuhuasuan", MSG_RESULT, MSG_RESULT_STR)
  MsgJuhuasuan:On("GET_INFO", self:Event("OnGetInfo"))
  MsgJuhuasuan:On("BUY_GOODS", self:Event("OnBuyGoods"))
end
function class:OnReset()
end
function class:GetShowList()
  return self.showlist
end
function class:HasBuyed(id)
  if not id then
    return false
  end
  if self.buyedRecords[id] then
    return true
  end
  return false
end
function class:CanBuy(id)
  if not id then
    return false
  end
  if self.canBuy[id] then
    return true
  end
  return false
end
function class:PostGetInfo()
  MsgJuhuasuan:Post("GET_INFO")
end
function class:PostBuyGoods(id)
  if not id then
    return
  end
  self.sendId = id
  MsgJuhuasuan:Post("BUY_GOODS", {goodsId = id})
end
function class:OnGetInfo(code, data)
  if code ~= 0 then
    return
  end
  self.buyedRecords = table.invert(data.buyedRecords or {})
  self.canBuy = table.invert(data.canBuy or {})
  self.showlist = {}
  for k, id in pairs(data.canShow or {}) do
    local rec = KFDBGetRecord("JuGoods", id)
    if rec then
      table.insert(self.showlist, rec)
    end
  end
  local sort = function(a, b)
    return a.sort > b.sort
  end
  table.sort(self.showlist, sort)
  self:FireEvent(EVT.GET_INFO)
end
function class:OnBuyGoods(code, data)
  if code ~= 0 then
    return
  end
  self.buyedRecords[self.sendId] = true
  Logic:Get("Cost"):CostAndReward(data)
  local str = Logic:Get("Reward"):AddDupiCardTip(data.rewards)
  Prompt:Msg(str)
  self:FireEvent(EVT.GET_INFO)
end
