require("Guide.Modules")
require("Logic.Treasure")
module((...), package.seeall)
trigger = Guide.Modules.trigger:subclass()
function trigger:isDone()
  if not Logic:Get("Battle"):IsBattleFinish(self.data.battle) then
    return false
  end
  if not Logic:Get("Battle"):IsLastPassBattle(self.data.battle) then
    return true
  end
  if Logic:Get("Treasure"):isHunting() then
    return false
  end
  local treasurePack = Logic:Get("Treasure"):GetTreasurePackVo()
  if table.empty(treasurePack) then
    return true
  end
  return false
end
function trigger:check()
  if not Logic:Get("Battle"):IsBattleFinish(self.data.battle) then
    return false
  end
  if Logic:Get("Treasure"):isHunting() then
    return false
  end
  return true
end
function trigger:steps()
  local steps = {"Start", "Draw"}
  return steps
end
