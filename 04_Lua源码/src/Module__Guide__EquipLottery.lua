require("Guide.Modules")
require("Logic.Battle")
require("Logic.Lottery")
module((...), package.seeall)
trigger = Guide.Modules.trigger:subclass()
function trigger:initialize(...)
  super.initialize(self, ...)
end
function trigger:isDone()
  if Logic:Get("Elite"):isEliteBattle() then
    return false
  end
  if not Logic:Get("Battle"):IsBattleFinish(self.data.battle) then
    return false
  end
  if not Logic:Get("Battle"):IsLastPassBattle(self.data.battle) then
    return true
  end
  return false
end
function trigger:check()
  if Logic:Get("Elite"):isEliteBattle() then
    return false
  end
  if not Logic:Get("Battle"):IsBattleFinish(self.data.battle) then
    return false
  end
  return true
end
function trigger:steps()
  local steps = {
    "Start",
    "SelectItem",
    "SelectTimes"
  }
  return steps
end
function trigger:DramaTalk()
  return 85
end
