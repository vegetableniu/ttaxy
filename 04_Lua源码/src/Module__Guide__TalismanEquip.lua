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
  if Logic:Get("FabaoLookFor"):isDrawing() then
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
  if Logic:Get("FabaoLookFor"):isDrawing() then
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
    "SelectFabao",
    "SelectFabaoDone"
  }
  return steps
end
