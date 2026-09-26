module((...), package.seeall)
require("Logic")
class = Logic.class:subclass()
EVT = Enum({
  "GET_PVP_INFO",
  "DEFY_MATCH",
  "SKIP_PVP",
  "UPDATE_RANK_LIST",
  "RELOAD_MATCH_LIST",
  "CLEAR_COOL_DOWN"
})
RANK_TYPE = Enum({
  "ALL_RANK",
  "MY_RANK",
  "RANK_REWARD"
})
local ERROR_CODE = TypeDef("com.eyu.mt.module.pvp.facade.PvpResult")
local MSG_RESULT = Enum(TypeDef("com.eyu.mt.module.pvp.facade.PvpResult"))
local MSG_RESULT_STR = {
  MATCH_PLAYER_NOT_EXIST = 105317,
  HERO_LEADER_LIMIT = 103070,
  EMBATTLE_ERROR = 105342,
  HERO_GROUP_LEADER_LIMIT = 105570,
  ARGUMENT_ILLEGAL = 104101,
  ACTION_POINT_NOT_ENOUGH = 105557,
  RANK_CHANGED = 105871,
  DEFY_COOL_DOWN = 105870,
  CAN_NOT_DEFY_SELF = 105872,
  COOL_DOWN_END = 105873
}
function class:initialize()
  super.initialize(self)
  self.matchList = {}
  self.coldTime = 0
  self.target = {}
  self.player = {}
  self.bPvp = false
  self.bSkipFight = false
  self.rankType = nil
  self.allRankList = {}
  self.myRankList = {}
  self.rewardGold = 0
  self.beforeRank = 0
  self.bAttacked = false
  self.attackedRecord = {}
  Logic:Get("MsgAssist"):RecordErrorMsg("MsgPvp", MSG_RESULT, MSG_RESULT_STR)
  MsgPvp:On("GET_PVP_INFO", self:Event("OnGetPvpInfo"))
  MsgPvp:On("DEFY_MATCH", self:Event("OnDefyMatch"), false)
  MsgPvp:On("GET_RANK_LIST", self:Event("OnGetRankList"))
  MsgPvp:On("LINEUP_COMPARE", self:Event("OnLineupCompare"))
  MsgPvp:On("CLEAR_COOL_DOWN", self:Event("OnClearCoolDown"))
end
function class:dispose()
  super.dispose(self)
end
function class:OnReset()
end
function class:GetMatchList()
  return self.matchList
end
function class:GetColdTime()
  return self.coldTime
end
function class:GetPlayer()
  return self.player
end
function class:SetTarget(target)
  self.target = target
end
function class:GetTarget()
  return self.target
end
function class:SetIsPvp(bPvp)
  self.bPvp = bPvp
end
function class:IsPvp()
  return self.bPvp
end
function class:SetSkipPvp(bSkipPvp)
  self.bSkipPvp = bSkipPvp
end
function class:GetRankType()
  return self.rankType
end
function class:SetRankType(rankType)
  if rankType == nil then
    return
  end
  self.rankType = rankType
end
function class:GetAllRankList()
  return self.allRankList
end
function class:GetMyRankList()
  return self.myRankList
end
function class:GetSuccess()
  return self.success
end
function class:GetRewardGold()
  return self.rewardGold
end
function class:GetBeforeRank()
  return self.beforeRank
end
function class:SetAttacked(bAttacked)
  self.bAttacked = bAttacked
end
function class:IsAttacked()
  return self.bAttacked
end
function class:GetAttackedRecord()
  return self.attackedRecord
end
function class:InitMatchListData(data)
  self.coldTime = Logic:Get("System"):GetTime() + data.coolDown
  self.matchList = data.matchList
  local rec = KFDBGetRecord("ConfigValue", "PVP:RANK_SIZE")
  local lastRank = rec and tonumber(rec.content) + 1 or 0
  local id = Logic:Get("PlayerInfo"):GetPlayerId()
  for _, v in pairs(self.matchList) do
    if v.id == id then
      self.player = v
    end
    v.sort = 1 > v.rank and lastRank or v.rank
  end
  local sort = function(a, b)
    return a.sort < b.sort
  end
  table.sort(self.matchList, sort)
end
function class:IsRankUp()
  if self.player == nil or table.empty(self.player) then
    return false
  end
  if not self.success then
    return false
  end
  if self.beforeRank < 1 then
    return true
  end
  return self.player.rank < self.beforeRank
end
function class:GetTitleDataByRank(rank)
  if rank == nil then
    return
  end
  for i = 1, KFDBGetRecordAmt("RankRewardConfig") do
    local rec = KFDBGetRecordByIdx("RankRewardConfig", i)
    if rec and rank >= rec.topRank and rank <= rec.lowRank then
      return rec
    end
  end
end
function class:IsNeedChallegeFade(rank)
  if id == nil or rank == nil then
    return false
  end
  local rec = KFDBGetRecord("ConfigValue", "PVP:VIRTUAL_PLAYER_NUM")
  local maxVirtualPlayer = rec and tonumber(rec.content) or 0
  if rank > maxVirtualPlayer then
    return false
  end
  for _, v in pairs(self.winRanks or {}) do
    if v == rank then
      return false
    end
  end
  return true
end
function class:GetRecordByDesId(desId)
  local errorResult = {}
  errorResult.icoPath = "images/public/clarity05.png"
  errorResult.logoPath = "images/public/clarity05.png"
  if desId == nil or desId <= 0 then
    return errorResult
  end
  for i = 1, KFDBGetRecordAmt("RankRewardConfig") do
    local rec = KFDBGetRecordByIdx("RankRewardConfig", i)
    if rec and rec.desId == desId then
      if rec.icoPath == "" or rec.logoPath == "" then
        rec.icoPath = "images/public/clarity05.png"
        rec.logoPath = "images/public/clarity05.png"
      end
      return rec
    end
  end
  return errorResult
end
function class:GetResetCost()
  local coldTime = self:GetColdTime()
  local diffTime = Logic:Get("System"):DiffTime(coldTime)
  local min = math.ceil(diffTime / 60)
  local rec = KFDBGetRecord("ConfigValue", "PVP:COOL_DOWN_COST")
  local costPerMin = rec and tonumber(rec.content) or 1
  local totalCost = costPerMin * min
  return totalCost
end
function class:reloadMatchList()
  self:FireEvent(EVT.RELOAD_MATCH_LIST)
end
function class:PostGetPvpInfo()
  MsgPvp:Post("GET_PVP_INFO")
end
function class:PostDefyMatch()
  if self.target then
    self.beforeRank = self.player.rank
    local embattle = Logic:Get("Hero"):GetSendGroupHeros()
    MsgPvp:Post("DEFY_MATCH", {
      rank = self.player.rank,
      embattle = embattle,
      targetId = self.target.id,
      targetRank = self.target.rank
    })
  end
end
function class:PostLineupCompare()
  if self.target then
    MsgPvp:Post("LINEUP_COMPARE", {
      id = self.target.id
    })
  end
end
function class:OnGetPvpInfo(code, data)
  if code ~= 0 or data == nil then
    return
  end
  self.bAttacked = data.attacked
  self.attackedRecord = data.attackedRecord or {}
  self:InitMatchListData(data)
  self.winRanks = data.winRanks
  self:FireEvent(EVT.GET_PVP_INFO)
end
function class:OnDefyMatch(code, data)
  if code ~= 0 then
    if code ~= ERROR_CODE.RANK_CHANGED then
      Logic:Get("MsgAssist"):OnMsgResult("MsgPvp", code)
      return
    end
    Prompt:Confirm(self, "", TwGetStr(105871), self.reloadMatchList, Prompt.PROMPT_TYPE.CONFIRM)
    return
  end
  if data.virtualName then
    self.target.id = data.virtualId
    self.target.name = data.virtualName
    self.target.leaderBaseId = data.leaderBaseId
    self.target.desId = 0
    if data.win then
      table.insert(self.winRanks, self.target.rank)
    end
  end
  if data.oldRank and 0 < data.oldRank then
    self.beforeRank = data.oldRank
  end
  self:InitMatchListData(data)
  Logic:Get("Devil"):AddEnergy(data.costAndReward.costs[1].contents)
  Logic:Get("Reward"):AddRewards(data.costAndReward.rewards)
  self.rewardGold = data.costAndReward.rewards[1].amount
  self.success = data.win
  self.reports = data.reports
  if self.bSkipPvp then
    self.bSkipPvp = false
    self:FireEvent(EVT.SKIP_PVP)
    return
  end
  log4battle:debug("groupNum:" .. data.groupNum)
  log4battle:debug("targetGroupNum:" .. data.targetGroupNum)
  local logic = Logic:Get("BattleShow")
  logic:CleanUp()
  logic:SetEnemyCount(1, 3)
  logic:SetEnterBattle(true)
  logic:SetDefenderArtifactLevel(data.targetArtifactLevel)
  logic:SetTotleMultiFightWaves(data.groupNum * data.targetGroupNum)
  logic:SetMultiFightWaves(data.groupNum, data.targetGroupNum)
  logic:SaveMultiFightReport(data.reports)
  logic:StartMultiFightReport()
end
function class:OnGetRankList(code, data)
  if code ~= 0 and data == nil then
    return
  end
  local sort = function(a, b)
    return a.rank < b.rank
  end
  table.sort(data, sort)
  self.allRankList = {}
  self.myRankList = {}
  local playerName = Logic:Get("PlayerInfo"):GetPlayerName()
  for i, v in ipairs(data) do
    if i <= 5 then
      table.insert(self.allRankList, v)
    end
    if v.name == playerName then
      for j = i - 2, i + 2 do
        if j >= 1 and j <= #data then
          table.insert(self.myRankList, data[j])
        end
      end
    end
  end
  self:FireEvent(EVT.UPDATE_RANK_LIST)
end
function class:OnLineupCompare(code, data)
  if code ~= 0 and data == nil then
    return
  end
  Logic:Get("Fight"):SetCompareData(data)
  Logic:Get("Fight"):FireEvent(Logic.Fight.EVT.SHOW_COMPARE)
end
function class:OnClearCoolDown(code, data)
  if code ~= 0 and data == nil then
    return
  end
  Logic:Get("Cost"):AddCosts(data)
  self.coldTime = Logic:Get("System"):GetTime()
  self:FireEvent(EVT.CLEAR_COOL_DOWN)
end
