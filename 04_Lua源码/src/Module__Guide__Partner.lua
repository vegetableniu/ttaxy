require("Guide.Modules")
require("Logic.Battle")
module((...), package.seeall)
BATTLE = ""
trigger = Guide.Modules.trigger:subclass()
function trigger:initialize(...)
  super.initialize(self, ...)
  _M.BATTLE = self.data.battle
end
function trigger:isDone()
  if Logic:Get("Battle"):IsBattleFinish(self.data.battle) then
    return true
  end
  if Logic:Get("Battle"):GetCurSelBattleId() == self.data.battle and Logic:Get("Friend"):GetCommendFriendNum() == 0 then
    return true
  end
  return false
end
function trigger:check()
  if Logic:Get("Battle"):GetCurSelBattleId() ~= self.data.battle then
    return false
  end
  return true
end
function trigger:steps()
  local steps = {"Select", "Fight"}
  return steps
end
function trigger:DramaTalk()
  return 20
end
