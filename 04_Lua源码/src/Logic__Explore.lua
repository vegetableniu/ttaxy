require("Logic")
require("protocol")
module((...), package.seeall)
class = Logic.class:subclass()
EVT = Enum({
  "LOAD_EXPLORE_INFO",
  "EXECUTE_TASK",
  "COST_REFRESH_RELEASE",
  "IMMEDIATE_FINISH",
  "OWNER_FIGHT_SCORE",
  "GET_FRIEND_CARDS",
  "UP_NPC_LEVEL",
  "BUY_NPC_EXP",
  "CARD_CHANGED"
})
local ERROR_CODE = TypeDef("com.eyu.mt.module.explore.facade.ExploreResult")
local MSG_RESULT = Enum(ERROR_CODE)
local MSG_RESULT_STR = {
  EXECUTING_HERO_NOT_FIGHTER = 115245,
  EXECUTE_SELECT_LIMIT = 115241,
  TASK_REFRESH_FAILED = 115237,
  EXECUTING_SMAE_NAME_HERO = 115226,
  BUY_EXP_INVAILD = 115218,
  BUY_EXP_LIMIT = 115219,
  NPC_EXP_ENOUGH = 115220,
  EXECUTING_OTHER_TASK = 115221,
  OWNER_HERO_NOT_FOUND = 115222,
  INVAILD_HIRE_FRIEND = 115223,
  NPC_LIMIT_LIMIT = 115224,
  NPC_EXP_NOT_ENOUGH = 115225,
  EXECUTING_REPEAT_HERO = 115201,
  EXECUTING_HERO_STAR_LIMIT = 115202,
  COST_FINISH_TIMES_LIMIT = 115203,
  TASK_EXECUTE_CD = 115204,
  TASK_HAS_NOT_EXECUTE = 115205,
  INVAILD_HIRE_VIRTUAL = 115206,
  TASK_HIRE_VIRTUAL_LIMIT = 115207,
  TASK_HIRE_FRIEND_LIMIT = 115208,
  HIRE_VIRTUAL_LIMIT = 115209,
  HIRE_FRIEND_LIMIT = 115210,
  INVAILD_EXECUTE_CARD_COUNT = 115211,
  EXECUTE_CON_COUNT_LIMIT = 115212,
  INVAILD_RATE = 115213,
  HIRE_CARD_OVERDUE = 115214,
  TASK_NOT_FOUND = 115215,
  TASK_HAS_EXECUTING = 115216,
  INVAILD_RELEASE_TASK = 115217,
  COST_NOT_ENOUGH = 10040,
  ACTIVITY_NOT_OPEN = 100071
}
function class:initialize()
  super.initialize(self)
  self.exploreVo = {}
  self.currTask = {}
  self.selectedSelf = {}
  self.selectedFriends = {}
  self.selectedSystem = {}
  self.friendCards = {}
  self.currExecuteTask = {}
  self.bSuccessed = false
  self.bComExplore = false
  self.exploreExecuteTasks = {}
  Logic:Get("MsgAssist"):RecordErrorMsg("MsgExplore", MSG_RESULT, MSG_RESULT_STR)
  MsgExplore:On("LOAD_EXPLORE_INFO", self:Event("onLoadExploreInfo"))
  MsgExplore:On("COST_REFRESH_RELEASE", self:Event("onCostRefreshRelease"))
  MsgExplore:On("EXECUTE_TASK", self:Event("onExecuteTask"))
  MsgExplore:On("IMMEDIATE_FINISH", self:Event("onImmediateFinish"))
  MsgExplore:On("GET_FRIEND_CARDS", self:Event("onGetFriendCards"))
  MsgExplore:On("DRAW_TASK_REWARD", self:Event("onDrawTaskReward"))
  MsgExplore:On("UP_NPC_LEVEL", self:Event("onUpNpcLevel"))
  MsgExplore:On("OWNER_FIGHT_SCORE", self:Event("onOwnerFightScore"))
  MsgExplore:On("BUY_NPC_EXP", self:Event("onBuyNpcExp"))
end
function class:dispose()
  super.dispose(self)
end
function class:GetExploreVo()
  return self.exploreVo or {}
end
function class:setCurrTask(task)
  self.currTask = task or {}
end
function class:getCurrTask()
  return self.currTask
end
function class:getSelectCards()
  return self.selectedSelf or {}
end
function class:getFriendCards()
  return self.friendCards or {}
end
function class:getSystemCards()
  return self.selectedSystem or {}
end
function class:getSelectFriends()
  return self.selectedFriends or {}
end
function class:setCurrExecuteTask(task)
  self.currExecuteTask = task
end
function class:getCurrExecuteTask()
  return self.currExecuteTask
end
function class:setExploreExecuteTask(task)
  self.exploreExecuteTasks = task or {}
  self:initTimer()
end
function class:AddExp(reward)
  self.exploreVo.exp = self.exploreVo.exp and self.exploreVo.exp or 0
  self.exploreVo.exp = self.exploreVo.exp + reward.amount
end
function class:IsTaskSuccessed()
  return self.bSuccessed
end
function class:IsCompleteExplore()
  return self.bComExplore
end
function class:initExploreExecuteTask()
  local map = {}
  for i, v in ipairs(self.exploreVo.executes or {}) do
    map[v.id] = v.endAt
  end
  self.exploreExecuteTasks = map
  self:initTimer()
end
function class:getTotalFight()
  local fight = 0
  for k, v in pairs(self.selectedSelf) do
    fight = fight + (v.fight or 0)
  end
  for k, v in pairs(self.selectedFriends) do
    fight = fight + (v.score or 0)
  end
  for k, v in pairs(self.selectedSystem) do
    fight = fight + (v.fightScore or 0)
  end
  return fight
end
function class:selectedCard(id, data, selectType)
  if selectType == "SELF" then
    if not self.selectedSelf[id] then
    else
    end
    self.selectedSelf[id] = data or nil
    return
  end
  if selectType == "FRIEND" then
    if not self.selectedFriends[id] then
    else
    end
    self.selectedFriends[id] = data or nil
    return
  end
  if selectType == "SYSTEM" then
    if not self.selectedSystem[id] then
    else
    end
    self.selectedSystem[id] = data or nil
  end
end
function class:clearSelect(selectType)
  if selectType == "SELF" then
    self.selectedSelf = {}
    return
  end
  if selectType == "FRIEND" then
    self.selectedFriends = {}
    return
  end
  if selectType == "SYSTEM" then
    self.selectedSystem = {}
    return
  end
  if selectType == "ALL" then
    self.selectedSelf = {}
    self.selectedFriends = {}
    self.selectedSystem = {}
    return
  end
end
function class:IsSelected(id)
  if self.selectedSelf[id] then
    return true
  end
  if self.selectedFriends[id] then
    return true
  end
  if self.selectedSystem[id] then
    return true
  end
  return false
end
function class:selectedSize()
  local selfCards = table.size(self.selectedSelf)
  local friendCards = table.size(self.selectedFriends)
  local systemCards = table.size(self.selectedSystem)
  local totalSize = selfCards + friendCards + systemCards
  return totalSize
end
function class:IsCardFull()
  return self:selectedSize() >= self.currTask.cardCount
end
function class:IsSystemCardFull()
  if table.empty(self.currTask or {}) then
    return false
  end
  local rec = KFDBGetRecord("TaskStarConfig", self.currTask.star)
  if not rec then
    return false
  end
  return table.size(self.selectedSystem) >= rec.hireVirtualLimit
end
function class:IsFriendCardFull()
  if table.empty(self.currTask or {}) then
    return false
  end
  local rec = KFDBGetRecord("TaskStarConfig", self.currTask.star)
  if not rec then
    return false
  end
  return table.size(self.selectedFriends) >= rec.hireFriendLimit
end
function class:IsTaskFull()
  local rec = KFDBGetRecord("NPCLevelConfig", self.exploreVo.level) or {}
  return #self.exploreVo.executes >= (rec.conExecLimit or 0)
end
function class:HasSameCard(baseId)
  local map = {}
  for k, v in pairs(self.selectedSelf) do
    local info = Logic:Get("Hero"):GetHeroInfoByBaseId(v.baseId)
    map[info.sameNameId] = true
  end
  for k, v in pairs(self.selectedFriends) do
    local info = Logic:Get("Hero"):GetHeroInfoByBaseId(v.baseId)
    map[info.sameNameId] = true
  end
  local info = Logic:Get("Hero"):GetHeroInfoByBaseId(baseId)
  return map[info.sameNameId] or false
end
function class:isOnExecute(longId)
  if not table.empty(self.exploreVo or {}) then
  elseif table.empty(self.exploreVo.executes or {}) then
    return false
  end
  local tasks = self.exploreVo.executes or {}
  for _, task in ipairs(tasks) do
    for i, card in ipairs(task.selfCards) do
      if card.id == longId then
        return true
      end
    end
  end
  return false
end
function class:HasReduceColdDown()
  if table.empty(self.currTask or {}) then
    return false
  end
  return self.currTask.decreaseCD ~= 0
end
function class:getFitIdx()
  if self:selectedSize() == 0 then
    return {}
  end
  local result = {}
  for k, v in pairs(self.selectedSelf) do
    local resultTab = self:getFitSuccessTable(v.baseId)
    for _, idx in ipairs(resultTab) do
      result[idx] = true
    end
  end
  for k, v in pairs(self.selectedFriends) do
    local resultTab = self:getFitSuccessTable(v.baseId)
    for _, idx in ipairs(resultTab) do
      result[idx] = true
    end
  end
  local bool, idx = self:IsFitFightScore()
  if bool then
    result[idx] = true
  end
  if self:isFitReduceTask() then
    result[1] = true
  end
  return result
end
function class:getFitSuccessTable(baseId)
  if table.empty(self.currTask or {}) then
    return {}
  end
  local items = self.currTask.successItems
  local results = {}
  local reduceIdx = self:HasReduceColdDown() and 1 or 0
  if self:IsBaseIdFitReduceTask(baseId) then
    table.insert(results, reduceIdx)
  end
  for idx, v in ipairs(items) do
    if self:IsFitConditions(baseId, v) then
      table.insert(results, idx + reduceIdx)
    end
  end
  return results
end
function class:IsBaseIdFitReduceTask(baseId)
  if not self:HasReduceColdDown() then
    return false
  end
  local id = self.currTask.star .. "_" .. self.currTask.point
  local rec = KFDBGetRecord("TaskPointCDConfig", id) or {}
  local cards = json.decode(rec.cards or "[]") or {}
  local cardInfo = Logic:Get("Hero"):GetHeroInfoByBaseId(baseId)
  if not cards[tostring(cardInfo.sameNameId)] then
    return false
  end
  return cardInfo.star >= cards[tostring(cardInfo.sameNameId)]
end
function class:isFitReduceTask()
  if not self:HasReduceColdDown() then
    return false
  end
  local id = self.currTask.star .. "_" .. self.currTask.point
  local rec = KFDBGetRecord("TaskPointCDConfig", id) or {}
  local cards = json.decode(rec.cards or "[]") or {}
  if table.empty(cards) then
    return false
  end
  local result = {}
  for sameNameId, star in pairs(cards) do
    result[sameNameId] = false
  end
  for k, v in pairs(self.selectedSelf) do
    local cardInfo = Logic:Get("Hero"):GetHeroInfoByBaseId(v.baseId)
    local star = cards[tostring(cardInfo.sameNameId)]
    if star and star <= cardInfo.star then
      result[cardInfo.sameNameId] = true
    end
  end
  for k, v in pairs(self.selectedFriends) do
    local cardInfo = Logic:Get("Hero"):GetHeroInfoByBaseId(v.baseId)
    local star = cards[tostring(cardInfo.sameNameId)]
    if star and star <= cardInfo.star then
      result[cardInfo.sameNameId] = true
    end
  end
  for _, value in pairs(result) do
    if not value then
      return false
    end
  end
  return true
end
function class:IsFitFightScore()
  if table.empty(self.currTask or {}) then
    return false, 0
  end
  local reduceIdx = self:HasReduceColdDown() and 1 or 0
  for idx, v in ipairs(self.currTask.successItems) do
    local id = v.items[1]
    local rec = KFDBGetRecord("TaskSuccessItemConfig", id) or {}
    local cons = json.decode(rec.content or "[]") or {}
    for k, fight in pairs(cons or {}) do
      if k == "FIGHTSOCRE" then
        return fight <= self:getTotalFight(), idx + reduceIdx
      end
    end
  end
  return false, 0
end
function class:IsFitConditions(baseId, condition)
  local info = Logic:Get("Hero"):GetHeroInfoByBaseId(baseId)
  for i, id in ipairs(condition.items or {}) do
    local rec = KFDBGetRecord("TaskSuccessItemConfig", id)
    if rec then
      local cons = json.decode(rec.content or "[]") or {}
      if not self:IsFitSingle(info, cons) then
        return false
      end
    end
  end
  return true
end
function class:IsFitSingle(info, cons)
  if table.empty(cons or {}) then
    return false
  end
  local isFit = function(info, key, value)
    if key == "CARDRANK" then
      return value <= info.rank
    end
    if key == "CARDSTAR" then
      return value <= info.star
    end
    if key == "CARDTYPE" then
      return info.type == value
    end
    if key == "CARDRACE" then
      return info.race == value
    end
    if key == "CARDSEX" then
      return info.sex == value
    end
    return false
  end
  for k, v in pairs(cons or {}) do
    if not isFit(info, k, v) then
      return false
    end
  end
  return true
end
function class:caluRate()
  if table.empty(self.currTask or {}) then
    return 0
  end
  local reduceIdx = self:HasReduceColdDown() and 1 or 0
  local baseRate = self.currTask.rate
  local selfRate = 0
  local fitMap = {}
  for k, v in pairs(self.selectedSelf) do
    if not table.empty(v.fit or {}) then
      for i, idx in ipairs(v.fit) do
        fitMap[idx] = true
      end
    end
  end
  for k, v in pairs(self.selectedFriends) do
    if not table.empty(v.fit or {}) then
      for i, idx in ipairs(v.fit) do
        fitMap[idx] = true
      end
    end
  end
  for idx in pairs(fitMap) do
    if self.currTask.successItems[idx - reduceIdx] then
      selfRate = selfRate + (self.currTask.successItems[idx - reduceIdx].rate or 0)
    end
  end
  local fightRate = 0
  local hasFightTask, idx = self:IsFitFightScore()
  if hasFightTask then
    fightRate = fightRate + (self.currTask.successItems[idx - reduceIdx].rate or 0)
  end
  local systemRate = 0
  for k, v in pairs(self.selectedSystem) do
    systemRate = systemRate + v.rate
  end
  local all = baseRate + selfRate + fightRate + systemRate
  return all
end
function class:postLoadExploreInfo()
  MsgExplore:Post("LOAD_EXPLORE_INFO")
end
function class:postCostRefreshRelease()
  MsgExplore:Post("COST_REFRESH_RELEASE")
end
function class:postExecuteTask(taskId)
  local sendData = {}
  sendData.friends = self:createSendFriends()
  sendData.virtuals = self:createSendVirtuals()
  sendData.selfs = self:createSendSelfs()
  sendData.rate = self:caluRate()
  sendData.taskId = taskId
  MsgExplore:Post("EXECUTE_TASK", sendData)
end
function class:createSendSelfs()
  if table.empty(self.selectedSelf) then
    return {}
  end
  local result = {}
  local playerId = Logic:Get("PlayerInfo"):GetPlayerId()
  for id, card in pairs(self.selectedSelf) do
    local cardInfo = Logic:Get("Hero"):GetHeroInfoById(id)
    local data = {}
    data.baseId = cardInfo.baseId
    data.id = id
    data.owner = playerId
    data.score = card.fight
    table.insert(result, data)
  end
  return result
end
function class:createSendVirtuals()
  local result = {}
  for id in pairs(self.selectedSystem) do
    table.insert(result, id)
  end
  return result
end
function class:createSendFriends()
  if table.empty(self.selectedFriends) then
    return {}
  end
  local result = {}
  for _, friend in pairs(self.selectedFriends) do
    local data = {}
    data.baseId = friend.baseId
    data.id = friend.heroId
    data.owner = friend.id
    data.score = friend.score
    table.insert(result, data)
  end
  return result
end
function class:postImmediateFinish()
  MsgExplore:Post("IMMEDIATE_FINISH", self.currExecuteTask.id)
end
function class:postGetFriendCards()
  MsgExplore:Post("GET_FRIEND_CARDS")
end
function class:postDrawTaskReward()
  MsgExplore:Post("DRAW_TASK_REWARD", self.currExecuteTask.id)
end
function class:postUpNpcLevel()
  MsgExplore:Post("UP_NPC_LEVEL")
end
function class:postOwnerFightScore()
  local ids = table.indices(self.selectedSelf)
  MsgExplore:Post("OWNER_FIGHT_SCORE", ids)
end
function class:onLoadExploreInfo(code, data)
  if code ~= 0 then
    return
  end
  self.exploreVo = data
  self:FireEvent(EVT.LOAD_EXPLORE_INFO)
end
function class:onCostRefreshRelease(code, data)
  if code ~= 0 then
    return
  end
  Logic:Get("Cost"):AddCosts(data.costResults)
  self.exploreVo.releases = data.releases
  self.exploreVo.costRefreshTimes = data.costRefreshTimes
  self:FireEvent(EVT.COST_REFRESH_RELEASE)
end
function class:onExecuteTask(code, data)
  if code ~= 0 then
    return
  end
  Logic:Get("Cost"):AddCosts(data.costResults)
  self.exploreVo.releases = data.releases
  self.exploreVo.executes = data.executes
  self.exploreVo.hireFriendTimes = data.hireFriendTimes
  self.exploreVo.hireVirtualTimes = data.hireVirtualTimes
  self:initExploreExecuteTask()
  self:clearSelect("ALL")
  self:FireEvent(EVT.EXECUTE_TASK)
end
function class:onImmediateFinish(code, data)
  self.exploreVo.costFinishTimes = self.exploreVo.costFinishTimes + 1
  self:onDrawTaskReward(code, data)
end
function class:onGetFriendCards(code, data)
  if code ~= 0 then
    return
  end
  self.friendCards = data
  self:FireEvent(EVT.GET_FRIEND_CARDS)
end
function class:onDrawTaskReward(code, data)
  if code ~= 0 then
    return
  end
  Logic:Get("Cost"):AddCosts(data.costResults)
  Logic:Get("Reward"):AddRewards(data.rewardResults)
  self.tips = Logic:Get("Reward"):AddDupiCardTip(data.rewardResults)
  self.exploreVo.executes = data.executes
  self:initExploreExecuteTask()
  self.bSuccessed = data.success
  self:FireEvent(EVT.IMMEDIATE_FINISH)
  self.bComExplore = false
  Logic:Get("Gift"):FireEvent(Logic.Gift.EVT.REFRESH_GIFT)
end
function class:promptReward()
  Prompt:Msg(self.tips)
end
function class:onUpNpcLevel(code, data)
  if code ~= 0 then
    return
  end
  self.exploreVo.releases = data.releases
  self:onExpChange(data.npcCurrentInfo)
  Prompt:Msg(TwGetStr(115233))
  self:FireEvent(EVT.UP_NPC_LEVEL)
end
function class:onOwnerFightScore(code, data)
  if code ~= 0 then
    return
  end
  for key, fight in pairs(data) do
    self.selectedSelf[key].fight = fight
  end
  self:FireEvent(EVT.OWNER_FIGHT_SCORE)
end
function class:onBuyNpcExp(code, data)
  if code ~= 0 then
    return
  end
  Logic:Get("Cost"):AddCosts(data.costResults)
  self:onExpChange(data.npcCurrentInfo)
  Prompt:Msg(TwGetStr(115238))
  self:FireEvent(EVT.BUY_NPC_EXP)
end
function class:onExpChange(data)
  self.exploreVo.exp = data.exp
  self.exploreVo.level = data.level
end
function class:initTimer()
  if table.empty(self.exploreExecuteTasks or {}) then
    if self.eventTracer:Exist("endTimeCheck") then
      self.eventTracer:Cancel("endTimeCheck")
    end
    return
  end
  self.hasMarkTask = {}
  local checkTime = 60000
  if not self.eventTracer:Exist("endTimeCheck") then
    Singleton(Timer):Repeat(checkTime, self:Event("endTimeCheck"))
  end
  self:endTimeCheck()
end
function class:endTimeCheck()
  for k, v in pairs(self.exploreExecuteTasks) do
    local diffTime = Logic:Get("System"):DiffTime(v / 1000)
    if diffTime < 0 and not self.hasMarkTask[v] then
      self.hasMarkTask[v] = true
      self.bComExplore = true
      Logic:Get("Gift"):FireEvent(Logic.Gift.EVT.REFRESH_GIFT)
      return
    end
  end
end
