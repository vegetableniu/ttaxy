require("Guide.Modules")
require("Logic.Battle")
require("Logic.Gift")
require("Logic.ExplainEquip")
module((...), package.seeall)
HERO = 0
trigger = Guide.Modules.trigger:subclass()
function trigger:initialize(...)
  super.initialize(self, ...)
  _M.HERO = self.data.hero
end
function trigger:isDone()
  if Logic:Get("Hero"):isGuideLevel() then
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
  local heroes = Logic:Get("Hero"):GetTotalCardByBaseId(self.data.hero)
  if table.empty(heroes) then
    return true
  end
  if not Logic:Get("ExplainEquip"):IsAbilityEvolutionById(heroes[1]) then
    return true
  end
  return false
end
function trigger:check()
  if Logic:Get("Hero"):isGuideLevel() then
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
    "Evolution"
  }
  return steps
end
function trigger:DramaTalk()
  return 21
end
