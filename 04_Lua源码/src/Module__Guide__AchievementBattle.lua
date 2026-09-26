require("Guide.Modules")
require("Logic.Battle")
module((...), package.seeall)
ID = ""
trigger = Guide.Modules.trigger:subclass()
function trigger:initialize(...)
  super.initialize(self, ...)
  _M.ID = self.data.achievement
end
function trigger:isDone()
  if Logic:Get("Achievement"):isGuideAchieve() then
    return false
  end
  return Logic:Get("Battle"):IsBattleFinish(self.data.battle)
end
function trigger:check()
  if Logic:Get("Achievement"):isGuideAchieve() then
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
function trigger:DramaTalk()
  return 75
end
function trigger:isCoverOrNot()
  return false
end
