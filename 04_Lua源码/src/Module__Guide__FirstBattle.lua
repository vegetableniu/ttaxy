require("Guide.Modules")
require("Logic.Battle")
module((...), package.seeall)
trigger = Guide.Modules.trigger:subclass()
function trigger:isDone()
  return Logic:Get("Battle"):IsBattleFinish(self.data.battle)
end
function trigger:check()
  return true
end
function trigger:steps()
  local steps = {
    "SelectCampaign",
    "SelectBattle",
    "Fight"
  }
  return steps
end
function trigger:DramaTalk()
  return 17
end
