module((...), package.seeall)
require("Logic")
class = Logic.class:subclass()
function class:initialize()
  super.initialize(self)
  self.openVision = true
end
function class:dispose()
  super.dispose(self)
end
function class:IsOpenVision(...)
  return self.openVision
end
function class:SetOpenVision(state)
  self.openVision = state == true and true or false
end
function class:GetLayerPriority(name)
  if "cover" == name then
    return 10
  elseif "prompt" == name then
    return 9
  elseif "scene" == name then
    return 1
  elseif "main" == name then
    return 1
  else
    return 0
  end
end
