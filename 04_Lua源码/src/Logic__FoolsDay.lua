module((...), package.seeall)
require("utf8")
require("Logic")
class = Logic.class:subclass()
local ERROR_CODE = TypeDef("com.eyu.mt.module.foolsday.facade.FoolsDayResult")
local MSG_RESULT = Enum(TypeDef("com.eyu.mt.module.foolsday.facade.FoolsDayResult"))
local MSG_RESULT_STR = {
  ACTIVITY_IS_NOT_OPEN = 111361,
  NOT_FOUNT_PLAYER_LEVEL_SECTION = 111362,
  CURRENCY_IS_NOT_ENOUGH = 111363,
  TODAY_RESET_TIMES_IS_MAX = 111364,
  FLOP_REPEAT = 111365
}
EVT = Enum({
  "GET_INFO_OK",
  "FLOP_OK"
})
function class:initialize()
  super.initialize(self)
  self.cardsMap = {}
  self.resetTimes = 0
  self.curPos = 0
  self.flopTimes = 0
  self.flopOver = false
  self.cardId = 0
  self.lvSeg = 1
  self.resetCostInfo = {}
  self.flopCostInfo = {}
  self.cardsCombos = {}
  Logic:Get("MsgAssist"):RecordErrorMsg("MsgFoolsday", MSG_RESULT, MSG_RESULT_STR)
  MsgFoolsday:On("INFO", self:Event("OnGetInfo"))
  MsgFoolsday:On("FLOP", self:Event("OnFlop"))
  MsgFoolsday:On("RESET", self:Event("OnReset"))
end
function class:OnGetInfo(code, data)
  self.cardsMap = data.cards
  self.resetTimes = data.resetTimes
  self.lvSeg = data.levelSegment
  self:calculateFlopTimes()
  self:FireEvent(EVT.GET_INFO_OK)
end
function class:OnFlop(code, data)
  if self.curPos ~= 0 then
    self.cardId = data.card
    self.cardsMap[self.curPos] = data.card
  end
  self.flopTimes = self.flopTimes + 1
  self.lvSeg = data.levelSegment
  if self.resetTimes < data.resetTimes then
    self.flopTimes = 0
    self.flopOver = true
  end
  self.resetTimes = data.resetTimes
  Logic:Get("Cost"):AddCosts(data.costAndReward.costs)
  local strTip
  if data.costAndReward.rewards and not table.empty(data.costAndReward.rewards) then
    Logic:Get("Reward"):AddRewards(data.costAndReward.rewards)
    strTip = Logic:Get("Reward"):AddDupiTreaTip(data.costAndReward.rewards)
  end
  self:FireEvent(EVT.FLOP_OK, self.curPos, data.card, strTip)
end
function class:OnReset(code, data)
  self.cardsMap = {}
  self.resetTimes = data.resetTimes
  self.flopTimes = 0
  self.lvSeg = data.levelSegment
  Logic:Get("Cost"):AddCosts(data.costs)
  self:FireEvent(EVT.GET_INFO_OK)
end
function class:PostGetInfo()
  MsgFoolsday:Post("INFO")
end
function class:PostFlop(pos)
  self.curPos = pos
  MsgFoolsday:Post("FLOP", {position = pos})
end
function class:PostReset()
  MsgFoolsday:Post("RESET")
end
function class:calculateFlopTimes()
  if not self.cardsMap or table.empty(self.cardsMap) then
    self.flopTimes = 0
  end
  self.flopTimes = #table.values(self.cardsMap)
end
function class:getCardsMap()
  if self.flopOver then
    self.cardsMap = {}
    self.flopOver = false
  end
  return self.cardsMap
end
function class:getSelfLevelSeg()
  return self.lvSeg
end
function class:getFlopCostInfo()
  for i = 1, KFDBGetRecordAmt("FlopCostSetting") do
    local info = KFDBGetRecordByIdx("FlopCostSetting", i)
    if info and info.levelSegment == self:getSelfLevelSeg() then
      table.insert(self.flopCostInfo, info)
    end
  end
end
function class:getResetCostInfo()
  for i = 1, KFDBGetRecordAmt("FlopResetSetting") do
    local info = KFDBGetRecordByIdx("FlopResetSetting", i)
    if info and info.levelSegment == self:getSelfLevelSeg() then
      table.insert(self.resetCostInfo, info)
    end
  end
end
function class:getCurResetCost()
  if table.empty(self.resetCostInfo) then
    self:getResetCostInfo()
  end
  for i, v in ipairs(self.resetCostInfo) do
    if v.times == self.resetTimes + 1 then
      return v.cost or 0
    end
  end
  for i, v in ipairs(self.resetCostInfo) do
    if v.times == -1 then
      return v.cost or 0
    end
  end
  return 0
end
function class:getCurFlopCost()
  if table.empty(self.flopCostInfo) then
    self:getFlopCostInfo()
  end
  for i, v in ipairs(self.flopCostInfo) do
    if v.times == self.flopTimes + 1 then
      return v.cost or 0
    end
  end
  for i, v in ipairs(self.flopCostInfo) do
    if v.times == -1 then
      return v.cost or 0
    end
  end
  return 0
end
function class:getComboInfo()
  self.cardsCombos = {}
  for i = 1, KFDBGetRecordAmt("FlopRewardSetting") do
    local info = KFDBGetRecordByIdx("FlopRewardSetting", i)
    if info and info.levelSegment == self:getSelfLevelSeg() then
      info.cards = json.decode(info.cards or "[]")
      table.insert(self.cardsCombos, info)
    end
  end
  return self.cardsCombos
end
function class:getResetTimes()
  return self.resetTimes
end
function class:getFlopTimes()
  return self.flopTimes
end
function class:getFinishCombos()
  if not self.cardsMap or table.empty(self.cardsMap) or not self.cardsCombos or table.empty(self.cardsCombos) then
    return {}
  end
  local finishCombos = {}
  local tempMap = {}
  for i, v in pairs(self.cardsMap) do
    tempMap[v] = i
  end
  for s, u in ipairs(self.cardsCombos) do
    local flag = true
    for j = 1, #u.cards do
      if tempMap[u.cards[j]] == nil then
        flag = false
        break
      end
    end
    if flag then
      table.insert(finishCombos, u)
    end
  end
  local tempCombos = self:getLastFinishCombos(finishCombos)
  local lastFinishCards = {}
  for _, oneCombos in pairs(tempCombos) do
    for _, cardId in pairs(oneCombos.cards) do
      lastFinishCards[cardId] = tempMap[cardId]
    end
  end
  return lastFinishCards, finishCombos
end
function class:isCheck(baseId)
  if table.empty(self.cardsMap) then
    return false
  end
  for _, v in pairs(self.cardsMap) do
    if v == baseId then
      return true
    end
  end
  return false
end
function class:getLastFinishCombos(combos)
  if table.empty(combos) or self.cardId == nil then
    return {}
  end
  local tempCombos = {}
  for _, v in ipairs(combos) do
    local flag = false
    for _, oneCardId in ipairs(v.cards) do
      if tonumber(oneCardId) == self.cardId then
        flag = true
      end
    end
    if flag then
      table.insert(tempCombos, v)
    end
  end
  return tempCombos
end
function class:getLastFinishCombosTip()
  local _, finishCombos = self:getFinishCombos()
  local tempCombos = self:getLastFinishCombos(finishCombos)
  if table.empty(tempCombos) then
    return ""
  end
  local combosTip = ""
  for _, v in ipairs(tempCombos) do
    combosTip = combosTip .. TwGetStr("111355")
    for i = 1, #v.cards do
      local name = Logic:Get("Hero"):GetHeroInfoByBaseId(tonumber(v.cards[i])).name
      combosTip = combosTip .. name
      if i < #v.cards then
        combosTip = combosTip .. " + "
      else
        combosTip = combosTip .. "\n"
      end
    end
  end
  return combosTip
end
function class:getAutoResetFlag()
  return self.flopOver
end
function class:getCurTime()
  self.enterTime = Logic:Get("System"):GetTime()
end
function class:isNextDay()
  local enterDate = Logic:Get("System"):GetTimeDate(self.enterTime)
  local curDate = Logic:Get("System"):GetTimeDate()
  return enterDate.day < curDate.day
end
