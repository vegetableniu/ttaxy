require("Guide.Modules")
require("Logic.Hero")
require("Logic.Armor")
module((...), package.seeall)
trigger = Guide.Modules.trigger:subclass()
ID_HERO = 0
ID_EQUIP = 0
function trigger:initialize(...)
  super.initialize(self, ...)
  _M.ID_EQUIP = self.data.equipID
end
function trigger:isDone()
  if Logic:Get("Elite"):isEliteBattle() then
    return false
  end
  if Logic:Get("Lottery"):isGuideLottery() then
    return false
  end
  if not Logic:Get("Battle"):IsBattleFinish(self.data.battle) then
    return false
  end
  if not Logic:Get("Battle"):IsLastPassBattle(self.data.battle) then
    return true
  end
  local heroInfo = Logic:Get("Hero"):GetAllHeroInfo()
  local leaderId = Logic:Get("Hero"):GetLeaderId()
  local leader = heroInfo.heros[leaderId]
  if not Logic:Get("Armor"):haveArmorsForHero(leader.baseId, 1) then
    return true
  end
  return false
end
function trigger:check()
  if Logic:Get("Elite"):isEliteBattle() then
    return false
  end
  if Logic:Get("Lottery"):isGuideLottery() then
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
    "SelectEquip",
    "SelectEquipDone"
  }
  return steps
end
