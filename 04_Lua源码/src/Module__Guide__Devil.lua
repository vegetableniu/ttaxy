require("Guide.Modules")
require("Logic.Battle")
module((...), package.seeall)
trigger = Guide.Modules.trigger:subclass()
function trigger:isDone()
  if Logic:Get("Devil"):isGuideDevil() then
    return false
  end
  if Logic:Get("Battle"):IsBattleFinish("CN05BN01") then
    return true
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
  if not Logic:Get("Devil"):isGuideDevil() then
    return false
  end
  if not Logic:Get("Battle"):IsBattleFinish(self.data.battle) then
    return false
  end
  return true
end
function trigger:steps()
  local steps = {"SelectItem"}
  return steps
end
function trigger:DramaTalk()
  return 72
end
