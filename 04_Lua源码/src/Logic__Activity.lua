module((...), package.seeall)
require("Logic")
require("SceneHelper")
class = Logic.class:subclass()
local ACTIVE_COMPUTE_TIME = 1000
EVT = Enum({
  "REFRESH_ACTIVE_COPY",
  "OPEN_BATTLE_FRIEND",
  "GETED_MSG_RETURN",
  "CLICK_ACTIVITY_COPY_ITEM"
})
ACTIVE_STATE = Enum({
  "END",
  "BEFORE",
  "IN"
})
function class:initialize()
  super.initialize(self)
  self.currentActivity = ""
  self.currentBattleId = ""
  self.activeInfoGrp = {}
  self.grpBattles = {}
  self.actives = {}
  self.activesDailyCount = {}
  MsgBattle:On("ACTIVES", self:Event("OnActives"), true)
end
function class:OnActives(code, data)
  self.actives = data.actives
  self.activesDailyCount = data.activeCounts
  self:ComputeActiveTime()
  self:ParseActiveData()
  if not self.eventTracer:Exist("ComputeActiveTime") then
    Singleton(Timer):Repeat(ACTIVE_COMPUTE_TIME, self:Event("ComputeActiveTime"))
  end
  if not SceneHelper:isExistScene("Activity") and not SceneHelper:isExistScene("HeroUpgrade") then
    SceneHelper:runWithScene("Activity", self.rootNode)
  end
  if not SceneHelper:isExistScene("HeroUpgrade") then
    self:FireEvent(EVT.GETED_MSG_RETURN)
  end
end
function class:getCampaignInfo(id)
  local info = KFDBGetRecord("CampaignConfig", id)
  if nil == info then
    log4battle:debug("get BattleInfoConfig failed:" .. (id and id or "id is nil"))
  end
  return info
end
function class:getEachGrpNameAndAward(id)
  local resultName = ""
  local resultAward = ""
  local camInfo = self:getCampaignInfo(id)
  if nil ~= camInfo then
    resultName = camInfo.name
    resultAward = camInfo.chapterDesc
  end
  return resultName, resultAward
end
function class:isOpenForLimit(actId)
  local actInfo = Logic:Get("Activity"):getCampaignInfo(actId)
  if actInfo == nil then
    return false
  end
  if actInfo.level <= Logic:Get("PlayerInfo"):GetPlayerLevel() then
    if actInfo.prevId ~= "" then
      local limitCam = json.decode(actInfo.prevId)
      if not Logic:Get("Battle"):IsCampainFinish(limitCam[1]) then
        return false
      end
    end
    return true
  end
  return false
end
function class:ComputeActiveTime()
  local serverTime = Logic:Get("System"):GetTime()
  serverTime = serverTime * 1000
  local timeGrp = {}
  for _, data in ipairs(self.actives or {}) do
    local info = {}
    if data.startTime and data.stopTime then
      if serverTime < data.startTime then
        info.state = ACTIVE_STATE.BEFORE
      elseif serverTime >= data.startTime and serverTime < data.stopTime then
        if self:isOpenForLimit(data.id) then
          info.state = ACTIVE_STATE.IN
        else
          info.state = ACTIVE_STATE.BEFORE
        end
      else
        info.state = ACTIVE_STATE.END
      end
      info.name, info.award = self:getEachGrpNameAndAward(data.id)
      info.activeId = data.id
      info.startTime = Logic:Get("System"):SecToDay(math.abs(data.startTime - serverTime) / 1000)
      info.stopTime = Logic:Get("System"):SecToDay(math.abs(data.stopTime - serverTime) / 1000)
      info.endTime = data.stopTime
      info.beginTime = data.startTime
      local activityInfo = self:getCampaignInfo(data.id)
      if info.state == ACTIVE_STATE.IN and Logic:Get("PlayerInfo"):GetPlayerLevel() < tonumber(activityInfo.level) then
        info.state = ACTIVE_STATE.BEFORE
      end
      if info.state ~= ACTIVE_STATE.END then
        timeGrp[data.id] = info
      end
    else
      if self:isOpenForLimit(data.id) then
        info.state = ACTIVE_STATE.IN
      else
        info.state = ACTIVE_STATE.BEFORE
      end
      local activityInfo = self:getCampaignInfo(data.id)
      if Logic:Get("PlayerInfo"):GetPlayerLevel() < tonumber(activityInfo.level) then
        info.state = ACTIVE_STATE.BEFORE
      end
      info.name, info.award = self:getEachGrpNameAndAward(data.id)
      info.activeId = data.id
      timeGrp[data.id] = info
    end
  end
  self.activeInfoGrp = timeGrp
  self:FireEvent(EVT.REFRESH_ACTIVE_COPY)
end
function class:PostActivesMsg()
  MsgBattle:Post("ACTIVES")
end
function class:getActiveInfoForUI()
  self.activeInfoGrpForUI = table.values(self.activeInfoGrp)
  local function sortActives(activesA, activesB)
    if table.empty(activesA) or table.empty(activesB) then
      return false
    end
    local recA = self:getCampaignInfo(activesA.activeId)
    local recB = self:getCampaignInfo(activesB.activeId)
    if recA == nil or recB == nil then
      return false
    end
    return recA.sort < recB.sort
  end
  table.sort(self.activeInfoGrpForUI, function(lhs, rhs)
    if lhs.state ~= rhs.state then
      return lhs.state > rhs.state
    else
      return sortActives(lhs, rhs)
    end
  end)
  return self.activeInfoGrpForUI
end
function class:getBattleCopyInfoForUI()
  local result = {}
  if #self.currentActivity == 0 or #self.grpBattles[self.currentActivity] == 0 then
    return
  end
  for i, v in ipairs(self.grpBattles[self.currentActivity]) do
    local info = KFDBGetRecord("BattleInfoConfig", v)
    if #info.prevId == 0 or self:IsBattled(info) then
      table.insert(result, 1, info)
    end
  end
  local comp = function(curItem, nextItem)
    return curItem.sort < nextItem.sort
  end
  table.sort(result, comp)
  return result
end
function class:IsBattled(battleInfo)
  for k, v in pairs(self.activesDailyCount[self.currentActivity] or {}) do
    if battleInfo.id == k or k == battleInfo.prevId then
      return true
    end
  end
  return false
end
function class:GetCampainBattles(idCamp)
  local lst = {}
  for i = 1, KFDBGetRecordAmt("BattleInfoConfig") do
    local info = KFDBGetRecordByIdx("BattleInfoConfig", i)
    if info.campaignId == idCamp then
      table.insert(lst, info.id)
    end
  end
  return lst
end
function class:ParseActiveData()
  local idLst = {}
  for _, info in ipairs(self.actives or {}) do
    table.insert(idLst, info.id)
  end
  for _, idCamp in pairs(idLst) do
    local allBattles = self:GetCampainBattles(idCamp)
    self.grpBattles[idCamp] = allBattles
  end
end
function class:getcurActiveId(idx)
  local result = ""
  for i, v in ipairs(self.activeInfoGrpForUI) do
    if idx == i then
      result = self.activeInfoGrpForUI[i].activeId
      return result
    end
  end
  return result
end
function class:setCurrentActivity(str)
  self.currentActivity = str
  Logic:Get("Battle"):SetCurSelCampaign(str)
end
function class:getCurrentActivity()
  return self.currentActivity
end
function class:setCurrBattleId(id)
  self.currentBattleId = id
end
function class:getCurrBattleId()
  return self.currentBattleId
end
function class:getBattleTimes(Id)
  local result = 0
  for k1, v1 in pairs(self.activesDailyCount) do
    if k1 == self.currentActivity then
      for k2, v2 in pairs(self.activesDailyCount[self.currentActivity]) do
        if k2 == Id then
          result = self.activesDailyCount[self.currentActivity][Id]
        end
      end
    end
  end
  return result
end
