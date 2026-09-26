require("Guide.Modules")
require("Logic.Battle")
module((...), package.seeall)
trigger = Guide.Modules.trigger:subclass()
function trigger:initialize(...)
  super.initialize(self, ...)
end
function trigger:isDone()
  if Logic:Get("Armor"):isGuideCheckArmor() then
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
  if Logic:Get("Armor"):isGuideCheckArmor() then
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
    "SelectElite"
  }
  return steps
end
