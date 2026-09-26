module((...), package.seeall)
trigger = objectlua.Object:subclass()
function trigger:initialize(...)
  local rec = KFDBGetRecord("Guide", ...)
  if rec ~= nil then
    self.data = json.decode(rec.GuideCondition)
  end
end
function trigger:isDone()
  return false
end
function trigger:check()
  return false
end
function trigger:steps()
  return {}
end
function trigger:DramaTalk()
  return nil
end
function trigger:isCoverOrNot()
  return false
end
