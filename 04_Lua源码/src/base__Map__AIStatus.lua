module((...), package.seeall)
DEFT_ATTACK_DIS = 100
AI_STATUS = Enum({
  "IDLE",
  "PATROL",
  "TRACE",
  "BATTLE",
  "BATTLE_FINISH"
})
AIStatus = objectlua.Object:subclass()
function AIStatus:initialize(statusMgr)
  super.initialize(self)
  assert(statusMgr)
  self.statusMgr = statusMgr
end
function AIStatus:dispose()
  self.statusMgr = nil
end
function AIStatus:Enter()
end
function AIStatus:Leave()
end
function AIStatus:Process()
end
function AIStatus:OnMoveFinish()
end
function AIStatus:GetOwner()
  return self.statusMgr:GetOwner()
end
function AIStatus:GetAIMgr()
  return self.statusMgr:GetAIMgr()
end
function AIStatus:GetAttackTarget()
  return self.statusMgr:GetAttackTarget()
end
function AIStatus:ChangeStatus(typeStatus)
  self.statusMgr:ChangeStatus(typeStatus)
end
function AIStatus:CheckAttackDis()
  local owner = self:GetOwner()
  local target = self:GetAttackTarget()
  if nil == owner or nil == target then
    return false
  end
  local posWorld = owner:GetWorldPos()
  local disToTarget = posWorld:Dist(target:GetWorldPos())
  return disToTarget <= DEFT_ATTACK_DIS
end
IdleStatus = AIStatus:subclass()
function IdleStatus:initialize(statusMgr)
  super.initialize(self, statusMgr)
end
function IdleStatus:dispose()
  super.dispose(self)
end
function IdleStatus:Enter()
  super.Enter(self)
  local owner = self:GetOwner()
  owner:StopMove()
end
function IdleStatus:Leave()
  super.Leave(self)
end
function IdleStatus:Process()
  super.Process(self)
end
DEFAULT_GUARD_DIS = 280
DEFAULT_PATRAL_INTERVAL_TIME = 2600
PATRAL_MOVE_TYPE = {
  EACH = 1,
  ROUND = 2,
  RANDOM = 3
}
PatralStatus = AIStatus:subclass()
function PatralStatus:initialize(statusMgr)
  super.initialize(self, statusMgr)
  self.beginTime = TimeGetTime()
  self.bindPoints = {}
  self.moveType = PATRAL_MOVE_TYPE.EACH
  self.targetBindIndex = 1
  self.origionPos = nil
  self:InitPoints()
end
function PatralStatus:InitPoints()
  local owner = self:GetOwner()
  local aiMgr = self:GetAIMgr()
  self.origionPos = aiMgr:GetPlayerOrigionPos(owner:GetId())
  if nil == self.origionPos then
    self.origionPos = owner:GetWorldPos()
  end
  self.bindPoints, self.moveType = aiMgr:GetPlayerBindPos(owner:GetId(), Map.Define.MAP_CELL_TYPE.CELL_TYPE_ROAD)
  if nil == self.bindPoints then
    self.bindPoints = {}
  end
end
function PatralStatus:dispose()
  super.dispose(self)
end
function PatralStatus:Enter()
  super.Enter(self)
  local owner = self:GetOwner()
  local bOrigionPos = owner:GetWorldPos().x == self.origionPos.x and owner:GetWorldPos().y == self.origionPos.y
  if not bOrigionPos then
    owner:MoveToWorld(self.origionPos)
  end
  self.beginTime = TimeGetTime() + math.random(DEFAULT_PATRAL_INTERVAL_TIME)
end
function PatralStatus:Leave()
  super.Leave(self)
end
function PatralStatus:Process()
  super.Process(self)
  local owner = self:GetOwner()
  local target = self:GetAttackTarget()
  local aiMgr = self:GetAIMgr()
  if nil ~= target and self:CheckAttackDis() and aiMgr:IsTargetCanAttack(target:GetId()) then
    aiMgr:OnTracedTarget(owner:GetId(), target:GetId())
    self:ChangeStatus(AI_STATUS.BATTLE)
    return
  end
  if nil ~= target and owner:CanTrack() and aiMgr:IsTracedAble(target:GetId()) then
    local posWorld = owner:GetWorldPos()
    local disToTarget = posWorld:Dist(target:GetWorldPos())
    if disToTarget <= DEFAULT_GUARD_DIS then
      owner:MoveToWorld(target:GetWorldPos())
      self:ChangeStatus(AI_STATUS.TRACE)
      return
    end
  end
  if owner:CanPatrol() and not owner:IsMoving() then
    self:MoveToNextPoint()
  end
end
function PatralStatus:OnMoveFinish()
  self:MoveToNextPoint()
end
function PatralStatus:MoveToNextPoint()
  local curTime = TimeGetTime()
  if curTime < self.beginTime + DEFAULT_PATRAL_INTERVAL_TIME then
    return
  end
  self.beginTime = curTime
  local owner = self:GetOwner()
  local curPos = owner:GetWorldPos()
  local maxDisOffset = 32
  local bOrigionPos = maxDisOffset >= curPos:Dist(self.origionPos)
  if 0 == #self.bindPoints then
    if not bOrigionPos then
      owner:MoveTo(self.origionPos)
    end
    return
  end
  if self.moveType == PATRAL_MOVE_TYPE.EACH then
    if not bOrigionPos then
      owner:MoveTo(self.origionPos)
      return
    else
      if self.targetBindIndex > #self.bindPoints then
        self.targetBindIndex = 1
      end
      owner:MoveTo(self.bindPoints[self.targetBindIndex])
      self.targetBindIndex = self.targetBindIndex + 1
      return
    end
  elseif self.moveType == PATRAL_MOVE_TYPE.ROUND then
    if self.targetBindIndex > #self.bindPoints then
      self.targetBindIndex = 1
      owner:MoveTo(self.origionPos)
      return
    else
      owner:MoveTo(self.bindPoints[self.targetBindIndex])
      self.targetBindIndex = self.targetBindIndex + 1
      return
    end
  elseif self.moveType == PATRAL_MOVE_TYPE.RANDOM then
    math.randomseed(os.time() + math.random(1, 32767))
    math.random()
    local num = math.random(0, #self.bindPoints)
    while self.lastNum == num do
      num = math.random(0, #self.bindPoints)
    end
    self.lastNum = num
    if 0 == num then
      owner:MoveTo(self.origionPos)
    else
      owner:MoveTo(self.bindPoints[num])
    end
  end
end
TraceStatus = AIStatus:subclass()
DEFAULT_TRACE_DIS = 280
function TraceStatus:initialize(statusMgr)
  super.initialize(self, statusMgr)
  self.beginPos = nil
end
function TraceStatus:dispose()
  super.dispose(self)
end
function TraceStatus:Enter()
  super.Enter(self)
  local owner = self:GetOwner()
  self.beginPos = TwPoint(owner:GetWorldPos().x, owner:GetWorldPos().y)
end
function TraceStatus:Leave()
  super.Leave(self)
end
function TraceStatus:Process()
  super.Process(self)
  local owner = self:GetOwner()
  self:CheckTrace()
end
function TraceStatus:OnMoveFinish()
  local owner = self:GetOwner()
  if not self:CheckTrace() then
    local target = self:GetAttackTarget()
    owner:MoveToWorld(target:GetWorldPos())
  end
end
function TraceStatus:CheckTrace()
  local aiMgr = self:GetAIMgr()
  local target = self:GetAttackTarget()
  if not self:CheckTraceDis() or not aiMgr:IsTracedAble(target:GetId()) then
    self:ChangeStatus(AI_STATUS.PATROL)
    return true
  end
  local owner = self:GetOwner()
  if self:CheckAttackDis() then
    aiMgr:OnTracedTarget(owner:GetId(), target:GetId())
    self:ChangeStatus(AI_STATUS.BATTLE)
    return true
  end
  return false
end
function TraceStatus:CheckTraceDis()
  local owner = self:GetOwner()
  local posWorld = owner:GetWorldPos()
  local disToOrigion = posWorld:Dist(self.beginPos)
  return disToOrigion <= DEFAULT_TRACE_DIS
end
BattleStatus = AIStatus:subclass()
function BattleStatus:initialize(statusMgr)
  super.initialize(self, statusMgr)
end
function BattleStatus:dispose()
  super.dispose(self)
end
function BattleStatus:Enter()
  super.Enter(self)
  local owner = self:GetOwner()
  owner:StopMove()
end
function BattleStatus:Leave()
  super.Leave(self)
end
function BattleStatus:Process()
  super.Process(self)
end
BattleFinishStatus = AIStatus:subclass()
DEFAULT_BATTLE_FINISH_WAIT_TIME = 5000
function BattleFinishStatus:initialize(statusMgr)
  super.initialize(self, statusMgr)
  self.beginTime = 0
end
function BattleFinishStatus:dispose()
  super.dispose(self)
end
function BattleFinishStatus:Enter()
  super.Enter(self)
  self.beginTime = TimeGetTime()
end
function BattleFinishStatus:Leave()
  super.Leave(self)
end
function BattleFinishStatus:Process()
  super.Process(self)
  local curTime = TimeGetTime()
  if curTime < self.beginTime + DEFAULT_BATTLE_FINISH_WAIT_TIME then
    return
  end
  self.beginTime = curTime
  self:ChangeStatus(AI_STATUS.PATROL)
end
StatusMgr = objectlua.Object:subclass()
function StatusMgr:initialize(ai)
  self.ai = ai
  self.mapStatus = {}
  self.curStatusType = nil
end
function StatusMgr:dispose()
  self.mapStatus = nil
  self.owner = nil
end
function StatusMgr:GetOwner()
  return self.ai:GetOwner()
end
function StatusMgr:GetAIMgr()
  return self.ai:GetAIMgr()
end
function StatusMgr:GetAttackTarget()
  return self.ai:GetAttackTarget()
end
function StatusMgr:Process()
  local curStatus = self:GetCurStatus()
  if nil == curStatus then
    return
  end
  curStatus:Process()
end
function StatusMgr:CreateStatus(type)
  local status
  if AI_STATUS.IDLE == type then
    status = IdleStatus:new(self)
  elseif AI_STATUS.PATROL == type then
    status = PatralStatus:new(self)
  elseif AI_STATUS.TRACE == type then
    status = TraceStatus:new(self)
  elseif AI_STATUS.BATTLE == type then
    status = BattleStatus:new(self)
  elseif AI_STATUS.BATTLE_FINISH == type then
    status = BattleFinishStatus:new(self)
  end
  return status
end
function StatusMgr:GetCurStatus()
  if nil == self.curStatusType then
    return nil
  end
  return self:GetStatus(self.curStatusType)
end
function StatusMgr:GetStatus(type)
  if self.mapStatus[type] == nil then
    local status = self:CreateStatus(type)
    self.mapStatus[type] = status
  end
  return self.mapStatus[type]
end
function StatusMgr:ChangeStatus(type)
  local curStatus = self:GetCurStatus()
  if nil ~= curStatus then
    curStatus:Leave()
  end
  self.curStatusType = type
  local newStatus = self:GetStatus(type)
  if nil ~= newStatus then
    newStatus:Enter()
  end
end
function StatusMgr:OnMoveFinish()
  local curStatus = self:GetCurStatus()
  if nil == curStatus then
    return
  end
  curStatus:OnMoveFinish()
end
