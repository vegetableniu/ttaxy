require("Guide.Modules")
require("Logic.Fight")
module((...), package.seeall)
trigger = Guide.Modules.trigger:subclass()
function trigger:isDone()
  return false
end
function trigger:check()
  if Logic:Get("Fight"):isGuideFightDraw() then
    return false
  end
  return true
end
function trigger:steps()
  local steps = {
    "Start",
    "ClickReward",
    "Draw"
  }
  return steps
end
