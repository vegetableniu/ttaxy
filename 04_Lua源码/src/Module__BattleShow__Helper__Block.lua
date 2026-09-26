module((...), package.seeall)
class = objectlua.Mixin:new()
function class:initialize()
end
function class:InitList(targetsList, foreachFun)
  self.target = nil
  if nil == targetsList or #targetsList < 2 then
    return
  end
  local blockPassvieType = 0
  foreachFun(function(target, _, _, _, buffs, passives)
    if nil ~= self.target then
      return true
    end
    self.target = target
    for _, pass in ipairs(passives) do
      if pass.id == blockPassvieType then
        self.target = target
      end
    end
  end, targetsList)
  if nil ~= self.target then
    log4battle:debug("target here!")
    self.targetPos = ccp(self.target:getPosition())
  end
end
function class:GetTarget(target)
  return self:CheckValid() and self.target or target
end
function class:CheckValid()
  return self.target ~= nil
end
function class:GetOffsetY()
  return self:CheckValid() and 50 or 0
end
function class:Block(dstPos, time, waitSign)
  if not self:CheckValid() then
    return
  end
  Logic:Get("AniMgr"):MoveTo(self.target, time, dstPos, waitSign)
end
function class:Back(waitSign)
  if not self:CheckValid() then
    waitSign = waitSign and waitSign()
    return
  end
  Logic:Get("AniMgr"):MoveTo(self.target, 0.1, self.targetPos, waitSign)
end
