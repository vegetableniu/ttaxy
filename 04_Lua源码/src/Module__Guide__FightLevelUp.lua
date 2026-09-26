require("Guide.Modules")
require("Logic.Battle")
module((...), package.seeall)
ID_HERO = 0
ID_MATERIAL = 0
trigger = Guide.Modules.trigger:subclass()
function trigger:initialize(...)
  super.initialize(self, ...)
  _M.ID_HERO = self.data.hero
  _M.ID_MATERIAL = self.data.material
end
function trigger:isDone()
  if Logic:Get("Gift"):isDrawing() then
    return false
  end
  if not Logic:Get("Battle"):IsBattleFinish(self.data.battle) then
    return false
  end
  if not Logic:Get("Battle"):IsLastPassBattle(self.data.battle) then
    return true
  end
  if table.empty(Logic:Get("Hero"):GetTotalCardByBaseId(self.data.material)) then
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
  local steps = {
    "Start",
    "SelectHeroWait",
    "SelectHero",
    "SelectMaterialWait",
    "SelectMaterial",
    "SelectMaterialConfirm",
    "LevelUp"
  }
  return steps
end
