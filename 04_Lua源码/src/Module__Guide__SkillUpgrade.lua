require("Guide.Modules")
require("Logic.Hero")
module((...), package.seeall)
trigger = Guide.Modules.trigger:subclass()
ID_HERO = 0
function trigger:initialize(...)
  super.initialize(self, ...)
  _M.ID_HERO = self.data.hero
end
function trigger:isDone()
  if Logic:Get("Treasure"):isDrawing() then
    return false
  end
  if not Logic:Get("Battle"):IsBattleFinish(self.data.battle) then
    return false
  end
  if not Logic:Get("Battle"):IsLastPassBattle(self.data.battle) then
    return true
  end
  if not Logic:Get("Hero"):IsHeroSkilUp() then
    return true
  end
  return false
end
function trigger:check()
  if Logic:Get("Treasure"):isDrawing() then
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
    "SelectUpgrade",
    "SelectHeroWait",
    "SelectHero",
    "SelectTreasureWait",
    "SelectTreasure",
    "SelectTreasureDone",
    "Upgrade"
  }
  return steps
end
function trigger:DramaTalk()
  return 26
end
