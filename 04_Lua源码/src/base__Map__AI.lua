module((...), package.seeall)
local AIStatus = require("Map.AIStatus")
AI_TYPE = Enum({"MONSTER"})
AI = objectlua.Object:subclass()
function AI:initialize(owner, mgr)
  super.initialize(self)
  self.owner = owner
  self.mgr = mgr
  self.attTargetId = nil
  self.statusMgr = AIStatus.StatusMgr:new(self)
end
function AI:dispose()
  super.dispose(self)
end
function AI:SetStatus(statusType)
  self.statusMgr:ChangeStatus(statusType)
end
function AI:GetOwner()
  return self.owner
end
function AI:GetAIMgr()
  return self.mgr
end
function AI:SetAttackTarget(id)
  self.attTargetId = id
end
function AI:GetAttackTarget()
  return self.mgr:GetPlayer(self.attTargetId)
end
function AI:OnMoveFinish()
  self.statusMgr:OnMoveFinish()
end
function AI:Process()
  self.statusMgr:Process()
end
MonsterAI = AI:subclass()
function MonsterAI:initialize(owner, mgr)
  super.initialize(self, owner, mgr)
end
function MonsterAI:dispose()
  super.dispose()
end
function CreateAI(owner, mgr, aiType, aiStatus)
  local ai
  if aiType == AI_TYPE.MONSTER then
    ai = MonsterAI:new(owner, mgr)
  end
  if nil ~= aiStatus and nil ~= ai then
    ai:SetStatus(aiStatus)
  end
  return ai
end
