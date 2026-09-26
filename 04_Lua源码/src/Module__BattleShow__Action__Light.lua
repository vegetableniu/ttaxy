local Base = require("BattleShow.Action.Base")
local Define = require("BattleShow.BattleDefine")
module((...), package.seeall)
class = Base.class:subclass()
function class:initialize(...)
  super.initialize(self, ...)
end
function class:PlayAction()
  self.actTime = 0.3
  local heroOrginPosX, heroOrginPosY = self.owner:getPosition()
  local hitFunc = bind(self.HitTarget, self)
  self:ForeachTarget(hitFunc, nil, "HIT")
  Logic:Get("AniMgr"):MoveToSync(self.owner, self.actTime, ccp(heroOrginPosX, heroOrginPosY), true)
  local passFunc = bind(self.PassiveTarget, self)
  self:ForeachTarget(passFunc, nil, "PASSIVE")
  local buffFunc = bind(self.BuffTarget, self)
  self:ForeachTarget(buffFunc, nil, "BUFF")
end
function class:HitTarget(target, hp, status, shield, info)
  self.targetInfo = info
  self.info.combs = 3
  local tx = target:getPositionX()
  local ty = self.owner:getPositionY()
  local offsetY = 0
  Logic:Get("AniMgr"):AccMoveToSync(self.owner, self.actTime, ccp(tx, ty + offsetY), true)
  local stageAni1 = self:RunHero(self.owner, self.info.stage1)
  stageAni1:RunAnimationAutoRemove(self.sync:Join())
  self:DelayTime(self.info.param)
  local stageAni4 = self:RunEffect(target, self.info.stage4, hp == 0, true)
  stageAni4:RunAnimationAutoRemove(self.sync:Join())
  local oneAttack = bind(self.RunOneAttack, self)
  self:ForeachShieldAndHp(hp, target, shield, self.info.combs, status, oneAttack)
  self.sync:Sync()
end
function class:RunOneAttack(target, hp, shield, status, times, bLastTime)
  local info = self.targetInfo
  self:RunPassiveAndBuff(target, hp, status, shield, info)
  if bLastTime then
  end
  local stageAni3 = self:RunHero(target, self.info.stage3, true)
  stageAni3:RunAnimationByWaitSign(nil, function()
    stageAni3:RemoveAnimation()
    target:CheckDead()
  end, Define.ANI_TIMEOUT)
  self:DelayTime(0.2)
end
