require("Logic")
module((...), package.seeall)
EVT = Enum({"GET_INFO"})
local ERROR_CODE = TypeDef("com.eyu.mt.module.cultivateshop.facade.CultivateShopResult")
local MSG_RESULT = Enum(ERROR_CODE)
local MSG_RESULT_STR = {
  BUY_REFRESH_TIMES_LIMIT = 110901,
  COST_NOT_ENOUGH = 10036,
  ITEM_HAS_EXCHENGED = 115162,
  ITEM_NOT_FOUND = 115163,
  ON_LINE_IS_EXPIRE = 115164,
  SWEET_NOT_ENOUGH = 104119,
  SWEET_INVALID_TYPE = 115165,
  ACTIVITY_NOT_OPEN = 100071
}
class = Logic.class:subclass()
function class:initialize()
  super.initialize(self)
  self.curLvData = {}
  self.shopInfo = {}
  Logic:Get("MsgAssist"):RecordErrorMsg("MsgCultivateshop", MSG_RESULT, MSG_RESULT_STR)
  MsgCultivateshop:On("GET_INFO", self:Event("onGetInfo"))
  MsgCultivateshop:On("COST_REFRESH", self:Event("onCostRefresh"))
  MsgCultivateshop:On("SHOP_EXCHANGE", self:Event("onShopExchange"))
end
function class:dispose()
  super.dispose(self)
end
function class:GetShopInfo()
  return self.shopInfo or {}
end
function class:setCurLevelData(data)
  self.curLvData = data or self.curLvData
end
function class:GetTitlePath()
  local clarity = "images/public/clarity05.png"
  return self.curLvData.titlePath or clarity
end
function class:IsLockShop()
  local rec = KFDBGetRecordByIdx("ShopSetting", 1) or {}
  return Logic:Get("Lock"):checkStatusById(rec.lock)
end
function class:PostGetInfo()
  MsgCultivateshop:Post("GET_INFO", self.curLvData.id)
end
function class:PostCostRefresh()
  if not self.curLvData.id then
    return
  end
  MsgCultivateshop:Post("COST_REFRESH", self.curLvData.id)
end
function class:PostShopExchange(itemId, position)
  MsgCultivateshop:Post("SHOP_EXCHANGE", {
    floor = self.curLvData.id,
    itemId = itemId,
    position = position
  })
end
function class:onGetInfo(code, data)
  if code ~= 0 then
    return
  end
  self.shopInfo = data
  self:FireEvent(EVT.GET_INFO)
end
function class:onCostRefresh(code, data)
  if code ~= 0 then
    return
  end
  self.shopInfo.costRefreshTimes = data.costRefreshTimes
  self:refreshShopInfo(data)
end
function class:onShopExchange(code, data)
  if code ~= 0 then
    return
  end
  Logic:Get("Reward"):AddRewards(data.rewardResults)
  local tips = Logic:Get("Reward"):AddDupiCardTip(data.rewardResults)
  Prompt:Msg(tips)
  self.shopInfo.autoRefreshDate = data.autoRefreshDate
  self:refreshShopInfo(data)
end
function class:refreshShopInfo(data)
  Logic:Get("Cost"):AddCosts(data.costResults)
  self.shopInfo.exchanges = data.exchanges
  self.shopInfo.onItems = data.onItems
  self:FireEvent(EVT.GET_INFO)
end
