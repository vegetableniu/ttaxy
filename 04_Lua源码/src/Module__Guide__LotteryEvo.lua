require("Guide.Modules")
require("Logic.Battle")
require("SceneHelper")
module((...), package.seeall)
trigger = Guide.Modules.trigger:subclass()
function trigger:initialize(...)
  super.initialize(self, ...)
end
function trigger:isDone()
  if not Logic:Get("Lottery"):isGuideLotterEvo() then
    return true
  end
  return false
end
function trigger:check()
  if Logic:Get("Lottery"):isGuideLottery() then
    return false
  end
  return true
end
function trigger:steps()
  local steps = {"Start"}
  return steps
end
function trigger:DramaTalk()
  return 74
end
