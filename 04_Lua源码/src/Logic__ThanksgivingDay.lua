module((...), package.seeall)
require("Logic")
class = Logic.class:subclass()
EVT = Enum({
  "LOAD_TURKEY",
  "REFRESH_INFO"
})
local ERROR_CODE = TypeDef("com.eyu.mt.module.turkey.facade.TurkeyResult")
local MSG_RESULT = Enum(ERROR_CODE)
local MSG_RESULT_STR = {
  ERROR_COUNT = 108756,
  CURRENCY_IS_NOT_ENOUGH = 108755,
  TURKEY_MATERIAL_NOT_EXIST = 108754,
  ACTIVITY_IS_NOT_OOPEN = 108753,
  MATERIALS_NOT_ENOUGH = 108752,
  TURKEY_NOT_ENOUGH = 108751,
  TURKEY_OR_MATERIALS_NOT_ENOUGH = 108750
}
function class:initialize()
  super.initialize(self)
  self.turkeyInfo = {}
  self.chat = {}
  Logic:Get("MsgAssist"):RecordErrorMsg("MsgTurkey", MSG_RESULT, MSG_RESULT_STR)
  MsgTurkey:On("LOAD_TURKEY", self:Event("OnLoadTurkey"))
  MsgTurkey:On("BUY_MATERIAL", self:Event("OnBuyMaterial"))
  MsgTurkey:On("MAKE_TURKEY", self:Event("OnMakeTurkey"))
  MsgTurkey:On("MAKE_TURKEY_BY_CURRENCY", self:Event("OnMakeTurkeyByCurrency"))
  MsgTurkey:On("EAT_TURKEY", self:Event("OnEatTurkey"))
end
function class:dispose()
  super.dispose(self)
end
function class:PostLoadTurkey()
  MsgTurkey:Post("LOAD_TURKEY")
end
function class:PostBuyMaterial(count, materialType)
  MsgTurkey:Post("BUY_MATERIAL", {count = count, materialType = materialType})
end
function class:PostMakeTurkey(count)
  MsgTurkey:Post("MAKE_TURKEY", {count = count})
end
function class:PostMakeTurkeyByCurrency(count)
  MsgTurkey:Post("MAKE_TURKEY_BY_CURRENCY", {count = count})
end
function class:PostEatTurkey(count)
  MsgTurkey:Post("EAT_TURKEY", {count = count})
end
function class:OnLoadTurkey(code, data)
  if code ~= 0 then
    return
  end
  self.turkeyInfo = data
  self.chat = data.records
  self:FireEvent(EVT.LOAD_TURKEY)
end
function class:OnBuyMaterial(code, data)
  if code ~= 0 then
    return
  end
  Logic:Get("Cost"):CostAndReward(data)
  local str = Logic:Get("Reward"):AddDupiCardTip(data.rewards)
  Prompt:Tip(str)
  self:FireEvent(EVT.REFRESH_INFO)
end
function class:OnMakeTurkey(code, data)
  if code ~= 0 then
    return
  end
  Logic:Get("Cost"):CostAndReward(data)
  local str = Logic:Get("Reward"):AddDupiCardTip(data.rewards)
  Prompt:Tip(str)
  self:FireEvent(EVT.REFRESH_INFO)
end
function class:OnMakeTurkeyByCurrency(code, data)
  if code ~= 0 then
    return
  end
  Logic:Get("Cost"):CostAndReward(data)
  local str = Logic:Get("Reward"):AddDupiCardTip(data.rewards)
  Prompt:Tip(str)
  self:FireEvent(EVT.REFRESH_INFO)
end
function class:OnEatTurkey(code, data)
  if code ~= 0 then
    return
  end
  Logic:Get("Cost"):CostAndReward(data.costAndReward)
  self.chat = data.chat
  local _, strTab = Logic:Get("Reward"):AddDupiCardTip(data.costAndReward.rewards)
  local params = {}
  params.list = strTab
  Prompt:TableViewConfirm(self, params)
  self:FireEvent(EVT.REFRESH_INFO)
end
function class:getTurkeyInfo()
  return self.turkeyInfo
end
function class:setTurkey(reward)
  if reward.code == 0 then
    if self.turkeyInfo.turkeys == nil then
      self.turkeyInfo.turkeys = 0
    end
    self.turkeyInfo.turkeys = self.turkeyInfo.turkeys + reward.amount
  else
    if self.turkeyInfo.materials == nil then
      self.turkeyInfo.materials = {}
    end
    if self.turkeyInfo.materials[reward.code] then
      self.turkeyInfo.materials[reward.code] = self.turkeyInfo.materials[reward.code] + reward.amount
    else
      self.turkeyInfo.materials[reward.code] = reward.amount
    end
  end
end
function class:getChat()
  return self.chat or {}
end
