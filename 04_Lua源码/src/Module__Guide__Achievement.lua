require("Guide.Modules")
require("Logic.Achievement")
module((...), package.seeall)
ID = ""
trigger = Guide.Modules.trigger:subclass()
function trigger:initialize(...)
  super.initialize(self, ...)
  _M.ID = self.data.achievement
end
function trigger:isDone()
  if not Logic:Get("Battle"):IsBattleFinish(self.data.battle) then
    return false
  end
  if not Logic:Get("Battle"):IsLastPassBattle(self.data.battle) then
    return true
  end
  local state = Logic:Get("Achievement"):GetAchievementStateByKey(self.data.achievement)
  if state == Logic.Achievement.DRAW_TYPE.COMPLETED then
    return true
  end
  return false
end
function trigger:check()
  if not Logic:Get("Battle"):IsBattleFinish(self.data.battle) then
    return false
  end
  local state = Logic:Get("Achievement"):GetAchievementStateByKey(self.data.achievement)
  if state ~= Logic.Achievement.DRAW_TYPE.CAN_DRAW then
    return false
  end
  return true
end
function trigger:steps()
  local steps = {"Start", "Draw"}
  return steps
end
function trigger:DramaTalk()
  return 22
end
