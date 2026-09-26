require("Guide.Modules")
require("Logic.Battle")
module((...), package.seeall)
trigger = Guide.Modules.trigger:subclass()
HERO1 = 0
HERO2 = 0
HERO3 = 0
function trigger:initialize(...)
  super.initialize(self, ...)
  _M.HERO1 = self.data.hero1
  _M.HERO2 = self.data.hero2
  _M.HERO3 = self.data.hero3
end
function trigger:isDone()
  if Logic:Get("Lottery"):isGuideLottery() then
    return false
  end
  if not Logic:Get("Battle"):IsBattleFinish("CN03BN03") then
    return false
  end
  local heros1 = Logic:Get("Hero"):GetTotalCardByBaseId(self.data.hero1)
  local heros2 = Logic:Get("Hero"):GetTotalCardByBaseId(self.data.hero2)
  local heros3 = Logic:Get("Hero"):GetTotalCardByBaseId(self.data.hero3)
  if table.empty(heros1) and table.empty(heros2) and table.empty(heros3) then
    return true
  end
  local teams = Logic:Get("Hero"):GetTeamerHero()
  local num = table.size(teams)
  if num >= 4 then
    return true
  end
  local leadership = Logic:Get("Hero"):GetLeadership()
  local battlingLeadership = Logic:Get("Hero"):GetBattlingLeadership()
  local hero = Logic:Get("Hero"):GetHeroInfoByBaseId(self.data.hero1)
  if leadership < hero.leadership + battlingLeadership then
    return true
  end
  return false
end
function trigger:check()
  if Logic:Get("Lottery"):isGuideLottery() then
    return false
  end
  if not Logic:Get("Battle"):IsBattleFinish("CN03BN03") then
    return false
  end
  return true
end
function trigger:steps()
  local steps = {
    "Start",
    "SelectHero",
    "Confirm"
  }
  return steps
end
function trigger:DramaTalk()
  return 24
end
