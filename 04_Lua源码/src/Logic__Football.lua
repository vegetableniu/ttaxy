module((...), package.seeall)
require("utf8")
require("Logic")
class = Logic.class:subclass()
local MSG_RESULT = Enum(TypeDef("com.eyu.mt.module.football.facade.FootballResult"))
local MSG_RESULT_STR = {
  CURRENCY_IS_NOT_ENOUGH = 111701,
  FREE_BALL_IS_USED_UP = 111702,
  ACTIVITY_IS_NOT_OPEN = 111703,
  NO_RELATIVE_POSITION = 111704
}
EVT = Enum({
  "REFRESH_INFO",
  "SHOOT_OVER"
})
function class:initialize()
  super.initialize(self)
  self.counts = nil
  self.hits = 0
  self.level = 0
  self.buyBalls = 0
  self.progress = 1
  self.usedFreeBalls = 0
  self.pos = 0
  self.shootInfo = {}
  Logic:Get("MsgAssist"):RecordErrorMsg("MsgFootball", MSG_RESULT, MSG_RESULT_STR)
  MsgFootball:On("LOAD_PITCH", self:Event("OnLoadPitch"))
  MsgFootball:On("SHOOT", self:Event("OnFreeShoot"))
  MsgFootball:On("SHOOT_BY_CURRENCY", self:Event("OnShoot"))
end
function class:OnLoadPitch(code, data)
  self.level = data.level or Logic:Get("PlayerInfo"):GetPlayerLevel()
  self.buyBalls = data.buyBalls or 0
  self.progress = data.point or 1
  self.usedFreeBalls = data.usedFreeBalls or 0
  self.resetTimes = data.resetTimes or 0
  self.shootInfo = data.shootData or {}
  self.hits = 0
  for _, v in pairs(self.shootInfo) do
    self.hits = self.hits + (v.hits or 0)
  end
  self:FireEvent(EVT.REFRESH_INFO)
end
function class:OnFreeShoot(code, data)
  local progInfo = self:getProgressInfo()
  if progInfo and not table.empty(progInfo) and progInfo.freeBalls and progInfo.freeBalls > self.usedFreeBalls then
    self.usedFreeBalls = self.usedFreeBalls + 1
  else
    self.buyBalls = self.buyBalls - 1
  end
  if not data or table.empty(data) then
    self:setBaseInfo(false)
    self:FireEvent(EVT.SHOOT_OVER, false)
  else
    self:setBaseInfo(true)
    Logic:Get("Reward"):AddRewards(data)
    self:FireEvent(EVT.SHOOT_OVER, true, data)
  end
end
function class:OnShoot(code, data)
  Logic:Get("Cost"):AddCosts(data.costResults)
  if not data.rewardResults or table.empty(data.rewardResults) then
    self:setBaseInfo(false)
    self:FireEvent(EVT.SHOOT_OVER, false)
  else
    self:setBaseInfo(true)
    Logic:Get("Reward"):AddRewards(data.rewardResults)
    self:FireEvent(EVT.SHOOT_OVER, true, data.rewardResults)
  end
end
function class:PostLoadPitch()
  MsgFootball:Post("LOAD_PITCH")
end
function class:PostFreeShoot(pos)
  self.pos = pos
  MsgFootball:Post("SHOOT", {position = pos})
end
function class:PostShoot(pos)
  self.pos = pos
  MsgFootball:Post("SHOOT_BY_CURRENCY", {position = pos})
end
function class:setBaseInfo(shootState)
  if not self.pos or self.pos <= 0 then
    return
  end
  self.shootInfo[self.pos] = self.shootInfo[self.pos] or {}
  if shootState then
    self.hits = self.hits + 1
    self.shootInfo[self.pos].hits = self.shootInfo[self.pos].hits or 0
    self.shootInfo[self.pos].hits = self.shootInfo[self.pos].hits + 1
    self.shootInfo[self.pos].times = 0
    local progInfo = self:getProgressInfo()
    if progInfo.hits and progInfo.hits <= self.hits then
      self.shootInfo = {}
      self.progress = self.progress + 1
      self.usedFreeBalls = 0
      self.hits = 0
      self.level = Logic:Get("PlayerInfo"):GetPlayerLevel()
      if self:getProgCounts() < self.progress then
        local resetCount = KFDBGetRecord("ConfigValue", "FOOTBALL:RESET_TIMES_LIMIT")
        resetCount = resetCount and tonumber(resetCount.content) or 0
        if resetCount > 0 and resetCount == self.resetTimes then
          self.progress = self:getProgCounts()
        else
          self.progress = 1
          self.resetTimes = self.resetTimes + 1
        end
      end
    end
    return
  end
  self.shootInfo[self.pos].times = self.shootInfo[self.pos].times or 0
  self.shootInfo[self.pos].times = self.shootInfo[self.pos].times + 1
end
function class:getProgressInfo(progId)
  progId = progId or self.progress
  return KFDBGetRecord("FootballPoints", progId) or {}
end
function class:isFree()
  local progInfo = self:getProgressInfo()
  if not progInfo or table.empty(progInfo) or not progInfo.freeBalls then
    return false
  end
  return progInfo.freeBalls > self.usedFreeBalls or self.buyBalls > 0
end
function class:getUsedFreeBalls()
  return self.usedFreeBalls
end
function class:getBuyBalls()
  return self.buyBalls
end
function class:getProgress()
  return self.progress
end
function class:getProgCounts()
  if self.counts then
    return self.counts
  end
  self.counts = KFDBGetRecordAmt("FootballPoints")
  return self.counts
end
function class:getHits()
  return self.hits
end
function class:getRewardsInfo()
  local rewardsInfo = {}
  for i = 1, 2 do
    local rewardId = string.format("%d_%d", self.progress, i)
    local rec = KFDBGetRecord("BallReward", rewardId) or {}
    local oneInfo = {}
    if not table.empty(rec) then
      local levelSeg = 0
      rec.levels = json.decode(rec.levels or "[]") or {}
      for i, v in ipairs(rec.levels) do
        if v >= self.level then
          levelSeg = i
          break
        end
      end
      rec.showTypeId = json.decode(rec.showTypeId or "[]") or {}
      rec.showIds = json.decode(rec.showIds or "[]") or {}
      rec.counts = json.decode(rec.counts or "[]") or {}
      oneInfo.showType = rec.showTypeId[levelSeg]
      oneInfo.showIds = rec.showIds[levelSeg]
      oneInfo.counts = rec.counts[levelSeg]
    end
    rewardsInfo[i] = oneInfo
  end
  return rewardsInfo
end
function class:getFinalReward()
  local rec = KFDBGetRecord("BallReward", "FINAL_REWARD") or {}
  local finalReward = 0
  if not table.empty(rec) then
    local levelSeg = 0
    rec.levels = json.decode(rec.levels or "[]") or {}
    for i, v in ipairs(rec.levels) do
      if v >= self.level then
        levelSeg = i
        break
      end
    end
    rec.showIds = json.decode(rec.showIds or "[]") or {}
    finalReward = rec.showIds[levelSeg]
  end
  return finalReward
end
function class:getAbsHitCounts(pos, progId)
  progId = progId or self.progress
  pos = pos or self.pos
  local posId = string.format("%d_%d", progId, pos)
  local rec = KFDBGetRecord("PointPosition", posId)
  if rec == nil or table.empty(rec) then
    return 0
  end
  local hasTryHitTimes = 0
  if self.shootInfo[pos] and self.shootInfo[pos].times then
    hasTryHitTimes = self.shootInfo[pos].times
  end
  return rec.mustHitTimes - hasTryHitTimes
end
