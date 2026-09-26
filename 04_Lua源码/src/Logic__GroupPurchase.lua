module((...), package.seeall)
require("utf8")
require("Logic")
class = Logic.class:subclass()
local ERROR_CODE = TypeDef("com.eyu.mt.module.fakegroupbuy.facade.GroupActivityResult")
local MSG_RESULT = Enum(TypeDef("com.eyu.mt.module.fakegroupbuy.facade.GroupActivityResult"))
local MSG_RESULT_STR = {
  PARAM_ERROR = 111061,
  REWARD_SEG_DRAWED = 111062,
  REWARD_SEG_NOT_FOUND = 111063,
  GOODS_NOT_BUY = 111064,
  GOODS_HAS_BUY = 111065,
  GOODS_NOT_VALID = 111066,
  GOODS_NOT_FOUND = 111067,
  ACTIVITY_NOT_INPROCESS = 111068
}
EVT = Enum({
  "GET_BUY_INFO_OK",
  "BUY_GOOD_OK"
})
REWARD_TYPE = Enum({
  "NONE",
  "CAN_GET",
  "HAS_GET",
  "GOODS_TYPE"
})
function class:initialize()
  super.initialize(self)
  self.groupPurchasesInfo = {}
  self.openGroupPurchasesInfo = {}
  self.buyInfo = {}
  self.chooseGoodDetails = {}
  self.goodId = nil
  Logic:Get("MsgAssist"):RecordErrorMsg("MsgFakegroupbuy", MSG_RESULT, MSG_RESULT_STR)
  MsgFakegroupbuy:On("PLAYER_BUY_INFO", self:Event("OnGetPlayerBuyInfo"), false)
  MsgFakegroupbuy:On("BUY_GOODS", self:Event("OnBuyGoods"), false)
  MsgFakegroupbuy:On("DRAW_REWARD", self:Event("OnDrawReward"), false)
end
function class:dispose()
  super.dispose(self)
end
function class:OnReset()
end
function class:OnGetPlayerBuyInfo(code, data)
  if code ~= 0 then
    Logic:Get("MsgAssist"):OnMsgResult("MsgFakegroupbuy", code)
    return
  end
  self.buyInfo = data
  self:FireEvent(EVT.GET_BUY_INFO_OK, self.goodId)
  self.goodId = nil
end
function class:OnBuyGoods(code, data)
  if code ~= 0 then
    Logic:Get("MsgAssist"):OnMsgResult("MsgFakegroupbuy", code)
    return
  end
  Logic:Get("Cost"):AddCosts(data.costs)
  Logic:Get("Reward"):AddRewards(data.rewards)
  local str = Logic:Get("Reward"):AddDupiCardTip(data.rewards)
  Prompt:Tip(str)
  self:PostPlayerBuyInfo()
  self:FireEvent(EVT.BUY_GOOD_OK)
end
function class:OnDrawReward(code, data)
  if code ~= 0 then
    Logic:Get("MsgAssist"):OnMsgResult("MsgFakegroupbuy", code)
    return
  end
  Logic:Get("Reward"):AddRewards(data)
  local str = Logic:Get("Reward"):AddDupiCardTip(data)
  Prompt:Tip(str)
  self:PostPlayerBuyInfo()
end
function class:PostPlayerBuyInfo()
  MsgFakegroupbuy:Post("PLAYER_BUY_INFO")
end
function class:PostBuyGoods(id)
  self.goodId = id
  MsgFakegroupbuy:Post("BUY_GOODS", {id = id})
end
function class:PostDrawReward(id, types)
  self.goodId = id
  MsgFakegroupbuy:Post("DRAW_REWARD", {id = id, types = types})
end
function class:getGroupPurchasesInfo()
  for i = 1, KFDBGetRecordAmt("GroupSetting") do
    local rec = KFDBGetRecordByIdx("GroupSetting", i)
    if rec then
      rec.showTypes = json.decode(rec.showTypeId or "[]")
      rec.showIds = json.decode(rec.showIds or "[]")
      rec.counts = json.decode(rec.counts or "[]")
      rec.buyCounts = json.decode(rec.buyCounts or "[]")
      rec.region = json.decode(rec.rewards or "[]")
      rec.goodsShowTypeId = json.decode(rec.goodsShowTypeId or "[]")
      rec.goodsShowIds = json.decode(rec.goodsShowIds or "[]")
      rec.goodsShowCounts = json.decode(rec.goodsShowCounts or "[]")
      local tempRegion = {}
      for key, value in pairs(rec.region) do
        table.insert(tempRegion, tonumber(key))
      end
      table.sort(tempRegion)
      rec.region = tempRegion
      rec.startTime = os.time(Logic:Get("Mall"):GetItemTime(rec.startTime))
      rec.endTime = os.time(Logic:Get("Mall"):GetItemTime(rec.endTime))
      self.groupPurchasesInfo[i] = rec
    end
  end
end
function class:getOpenGroupPurchasesInfo()
  if not self.groupPurchasesInfo or table.empty(self.groupPurchasesInfo) then
    self:getGroupPurchasesInfo()
  end
  self.openGroupPurchasesInfo = {}
  for i, v in ipairs(self.groupPurchasesInfo) do
    if self:isGroupPurchardOpen(v) then
      table.insert(self.openGroupPurchasesInfo, v)
    end
  end
  return self.openGroupPurchasesInfo
end
function class:isGroupPurchardOpen(activityInfo)
  if not activityInfo or table.empty(activityInfo) or not activityInfo.startTime or not activityInfo.endTime then
    return false
  end
  local curTime = Logic:Get("System"):GetTime()
  if curTime > activityInfo.startTime and curTime < activityInfo.endTime then
    return true
  end
  return false
end
function class:hasBuy(id)
  if not self.buyInfo or table.empty(self.buyInfo) then
    return false
  end
  for _, v in pairs(self.buyInfo) do
    if v.id == id then
      return true
    end
  end
  return false
end
function class:getRewardType(id)
  if not self.buyInfo or table.empty(self.buyInfo) then
    return 0
  end
  for _, v in pairs(self.buyInfo) do
    if v.id == id then
      if not v.drawed or table.empty(v.drawed) then
        return 0
      end
      table.sort(v.drawed)
      return v.drawed[#v.drawed]
    end
  end
  return 0
end
function class:getCanGetRewardInfo(id)
  if not self.openGroupPurchasesInfo or table.empty(self.openGroupPurchasesInfo) then
    return {}, nil
  end
  local region = self:getRewardType(id)
  local canGetArr = {}
  local index
  for _, v in pairs(self.openGroupPurchasesInfo) do
    if v.id == id then
      local curTime = Logic:Get("System"):GetTime()
      local regNum = math.floor((curTime - v.startTime) / 3600)
      for i = 1, #v.region do
        if region == v.region[#v.region] then
          index = #v.region + 1
          break
        end
        if region >= v.region[i] then
          index = i + 1
        end
        if region < v.region[i] then
          if v.region[i] <= (v.buyCounts[regNum + 1] or 0) then
            table.insert(canGetArr, v.region[i])
          end
        end
      end
      break
    end
  end
  return canGetArr, index
end
function class:getRewardState(id, num, counts)
  if num == 0 or counts == nil then
    return REWARD_TYPE.GOODS_TYPE
  end
  if not self.openGroupPurchasesInfo or table.empty(self.openGroupPurchasesInfo) then
    return REWARD_TYPE.NONE
  end
  local region = self:getRewardType(id)
  local canGetArr, rewardNum = self:getCanGetRewardInfo(id)
  if region and counts <= region then
    return REWARD_TYPE.HAS_GET
  end
  for i, v in pairs(canGetArr or {}) do
    if v == counts then
      return REWARD_TYPE.CAN_GET
    end
  end
  return REWARD_TYPE.NONE
end
function class:setChooseDetails(goodsDetails)
  self.chooseGoodDetails = goodsDetails or {}
end
function class:getChooseDetails()
  return self.chooseGoodDetails
end
function class:isNoReward(id)
  if not self.openGroupPurchasesInfo or table.empty(self.openGroupPurchasesInfo) then
    return true
  end
  local region = {}
  for i, v in pairs(self.openGroupPurchasesInfo) do
    if v.id == id then
      region = v.region or {}
    end
  end
  if table.empty(region) then
    return true
  end
  for _, v in pairs(self.buyInfo) do
    if v.id == id then
      if not v.drawed or table.empty(v.drawed) then
        return false
      end
      if #region == #v.drawed then
        return true
      end
      break
    end
  end
  return false
end
