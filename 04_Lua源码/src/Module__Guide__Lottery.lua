require("Guide.Modules")
require("Logic.Battle")
require("Logic.Lottery")
module((...), package.seeall)
trigger = Guide.Modules.trigger:subclass()
function trigger:isDone()
  if not Logic:Get("Battle"):IsBattleFinish(self.data.battle) then
    return false
  end
  if not Logic:Get("Battle"):IsLastPassBattle(self.data.battle) then
    return true
  end
  local cost, gold = Logic:Get("Lottery"):GetGoldCostAndGolds()
  if gold < cost then
    return true
  end
  return false
end
function trigger:check()
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
  return 23
end
