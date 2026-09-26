local Base = require("BattleShow.Action.Base")
local Define = require("BattleShow.BattleDefine")
module((...), package.seeall)
class = Base.class:subclass()
function class:initialize(...)
  super.initialize(self, ...)
end
function class:PlayAction()
  local hitFunc = bind(self.HitTarget, self)
  self:ForeachTarget(hitFunc, nil, "HIT")
  local passFunc = bind(self.PassiveTarget, self)
  self:ForeachTarget(passFunc, nil, "PASSIVE")
  local buffFunc = bind(self.BuffTarget, self)
  self:ForeachTarget(buffFunc, nil, "BUFF")
end
function class:HitTarget(target, hp, status, shield, info)
  local object = self:GetObject(self.owner, target)
  self:SwitchTarget(self.owner, object, self.sync)
  local stageAni1 = self:RunHero(self.owner, self.info.stage1)
  stageAni1:RunAnimationAutoRemove(self.sync:Join())
  local stageAni2 = self:RunEffect(self.owner, self.info.stage2)
  stageAni2:RunAnimationAutoRemove(self.sync:Join())
  self:DelayTime(self.info.param)
  local stageAni3 = self:RunHero(target, self.info.stage3)
  local stageAni4 = self:RunEffect(target, self.info.stage4, hp == 0)
  self:RunPassiveAndBuff(target, hp, status, shield, info)
  stageAni3:RunAnimationByWaitSign(nil, function()
    stageAni3:RemoveAnimation()
    target:CheckShieldRemove()
    target:CheckDead()
  end, Define.ANI_TIMEOUT)
  stageAni4:RunAnimationAutoRemove(self.sync:Join())
  self.sync:Sync()
  self:SwitchTarget(object, self.owner, self.sync)
end
function class:GetObject(owner, target)
  local Contain = function(m, e)
    for _, t in ipairs(m) do
      if t == e then
        return true
      end
    end
    return false
  end
  local corres = {
    {
      o = {
        "A0",
        "A1",
        "A2"
      },
      t = {"D6", "D9"},
      s = "A0"
    },
    {
      o = {
        "A0",
        "A1",
        "A2"
      },
      t = {"D7", "D10"},
      s = "A1"
    },
    {
      o = {
        "A0",
        "A1",
        "A2"
      },
      t = {"D8", "D11"},
      s = "A2"
    },
    {
      o = {
        "A3",
        "A4",
        "A5"
      },
      t = {"D6", "D9"},
      s = "A3"
    },
    {
      o = {
        "A3",
        "A4",
        "A5"
      },
      t = {"D7", "D10"},
      s = "A4"
    },
    {
      o = {
        "A3",
        "A4",
        "A5"
      },
      t = {"D8", "D11"},
      s = "A5"
    },
    {
      o = {
        "D6",
        "D7",
        "D8"
      },
      t = {"A0", "A3"},
      s = "D6"
    },
    {
      o = {
        "D6",
        "D7",
        "D8"
      },
      t = {"A1", "A4"},
      s = "D7"
    },
    {
      o = {
        "D6",
        "D7",
        "D8"
      },
      t = {"A2", "A5"},
      s = "D8"
    },
    {
      o = {
        "D9",
        "D10",
        "D11"
      },
      t = {"A0", "A3"},
      s = "D9"
    },
    {
      o = {
        "D9",
        "D10",
        "D11"
      },
      t = {"A1", "A4"},
      s = "D10"
    },
    {
      o = {
        "D9",
        "D10",
        "D11"
      },
      t = {"A2", "A5"},
      s = "D11"
    }
  }
  for _, map in ipairs(corres) do
    if Contain(map.o, owner:GetPosId()) and Contain(map.t, target:GetPosId()) then
      local unit = self.showUI[map.s]
      if unit then
        return unit
      end
    end
  end
  return owner
end
