require("Guide.Modules")
require("Logic.Hero")
require("Logic.Battle")
module((...), package.seeall)
trigger = Guide.Modules.trigger:subclass()
function trigger:isDone()
  if Logic:Get("Hero"):isChangingTeam() then
    return false
  end
  local heros1 = Logic:Get("Hero"):GetTotalCardByBaseId(1123)
  local heros2 = Logic:Get("Hero"):GetTotalCardByBaseId(3303)
  local heros3 = Logic:Get("Hero"):GetTotalCardByBaseId(3343)
  if table.empty(heros1) and table.empty(heros2) and table.empty(heros3) then
    return true
  end
  return Logic:Get("Battle"):IsBattleFinish(self.data.battle)
end
function trigger:check()
  if Logic:Get("Hero"):isChangingTeam() then
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
