require("Guide.Modules")
require("Logic.Achievement")
module((...), package.seeall)
trigger = Guide.Modules.trigger:subclass()
function trigger:isDone()
  return Logic:Get("Battle"):IsBattleFinish("CN13BN02")
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
    "SelectCampaign",
    "SelectBattle"
  }
  return steps
end
function trigger:DramaTalk()
  return 76
end
