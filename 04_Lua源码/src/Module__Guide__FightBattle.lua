require("Guide.Modules")
require("Logic.Battle")
module((...), package.seeall)
trigger = Guide.Modules.trigger:subclass()
function trigger:isDone()
  if Logic:Get("Hero"):isEvoHunting() then
    return false
  end
  return Logic:Get("Battle"):IsBattleFinish(self.data.battle)
end
function trigger:check()
  if Logic:Get("Hero"):isEvoHunting() then
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
