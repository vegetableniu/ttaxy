module((...), package.seeall)
class = objectlua.Mixin:new()
function class:initialize(mgr)
  self.mgr = mgr
end
function class:GetMovingTimeByUnits(owner, target, skillInfo)
  local srcPosX, srcPosY = owner:getPosition()
  local dstPosX, dstPosY = target:getPosition()
  return self:GetMovingTime({x = srcPosX, y = srcPosY}, {x = dstPosX, y = dstPosY}, skillInfo)
end
function class:GetMovingTime(srcPos, dstPos, skillInfo)
  local sx, sy = srcPos.x, srcPos.y
  local dx, dy = dstPos.x, dstPos.y
  local dis = math.sqrt(math.pow(sy - dy, 2) + math.pow(sx - dx, 2))
  local param = tonumber(skillInfo.param)
  local time = 0.05
  if param and param < 0.8 and param > 0 then
    time = param
  elseif param and param > 0.8 then
    time = dis / (param * 1000)
  end
  return time - time % 0.01
end
function class:GetMovingAngle(owner, target)
  local sx, sy = owner:getPosition()
  local dx, dy = target:getPosition()
  if dy == sy then
    local angle = sx < dx and 90 or dx == sx and 0 or -90
    return angle
  end
  local angle = math.atan((dx - sx) / (dy - sy))
  angle = 180 * angle / math.pi
  return angle - angle % 0.1
end
function class:CalcPosition(owner, offset, angle)
  local sx, sy = owner:getPosition()
  angle = (90 - angle) * math.pi / 180
  local x = math.cos(angle) * offset
  local y = math.sin(angle) * offset
  if not owner:IsEnemy() or not y then
    y = -y
  end
  if not owner:IsEnemy() or not x then
    x = -x
  end
  return ccp(sx - x, sy - y)
end
function class:GetUnitAngleInfo(owner, target, skillInfo, scaleRate, offset)
  local cz = target:getContentSize()
  local scale = target:getScale()
  local offsetY = cz.height * scale * scaleRate + offset
  local actTime = self:GetMovingTimeByUnits(owner, target, skillInfo)
  local angle = self:GetMovingAngle(owner, target)
  local dstPos = self:CalcPosition(target, offsetY, angle)
  return actTime, angle, dstPos
end
