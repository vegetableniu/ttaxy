module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
require("SceneHelper")
function prototype:onEnter()
  self.maxTimes = {}
end
function prototype:setMaxTimes(node, times)
  self.maxTimes[node] = times
end
function prototype:setNodeVisible(node, bool)
  if not self[node] then
    return
  end
  self[node]:setVisible(bool)
end
function prototype:runAni(node, times, target)
  if not self[node] then
    return
  end
  local range = times == 0 and 0.1 or times * 0.1
  if times >= self.maxTimes[node] then
    range = 2.4 or range
  end
  local x = self[node]:getPositionX()
  local y = self[node]:getPositionY()
  y = times < self.maxTimes[node] and -648 or 52 - target * 70
  local arr = CCArray:create()
  local moveTo = CCMoveTo:create(range, ccp(x, y))
  local func = CCCallFuncN:create(function()
    if times < self.maxTimes[node] then
      self[node]:setPositionY(52)
      self:runAni(node, times + 1, target)
    end
  end)
  arr:addObject(moveTo)
  arr:addObject(func)
  self[node]:runAction(CCSequence:create(arr))
end
function prototype:resetPos()
  for i = 1, 4 do
    local node = "nodNum" .. i
    if self[node] then
      self[node]:setPositionY(52)
    end
  end
end
