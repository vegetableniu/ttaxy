require("Guide.Modules")
require("Logic.Battle")
module((...), package.seeall)
MATERIAL = 0
trigger = Guide.Modules.trigger:subclass()
function trigger:initialize(...)
  super.initialize(self, ...)
  _M.MATERIAL = self.data.material
end
function trigger:isDone()
  if not Logic:Get("Battle"):IsBattleFinish(self.data.battle) then
    return false
  end
  if not Logic:Get("Battle"):IsLastPassBattle(self.data.battle) then
    return true
  end
  if not table.empty(Logic:Get("Hero"):GetTotalCardByBaseId(self.data.material)) then
    return true
  end
  if not Logic:Get("Gift"):IsDrawable("HERO", self.data.material) then
    return true
  end
  local ids = Logic:Get("Hero"):GetTotalCardByBaseId(self.data.hero)
  if table.empty(ids) then
    return true
  end
  local hero = Logic:Get("Hero"):GetHeroInfoById(ids[1])
  if 15 <= hero.level then
    return true
  end
  return false
end
function trigger:check()
  if Logic:Get("Gift"):isDrawing() then
    return false
  end
  if not Logic:Get("Battle"):IsBattleFinish(self.data.battle) then
    return false
  end
  return true
end
function trigger:steps()
  local steps = {"Start", "Draw"}
  return steps
end
