local Base = require("BattleShow.Action.Base")
local Define = require("BattleShow.BattleDefine")
module((...), package.seeall)
class = Base.class:subclass()
function class:initialize(...)
  super.initialize(self, ...)
end
function class:PlayAction()
  local actTime = 0.3
  local orginX, orginY = self.owner:getPosition()
  local wz = CCDirector:sharedDirector():getWinSize()
  local width = wz.width / 2
  local height = self.owner:IsEnemy() and wz.height / 2 + 20 or wz.height / 2 - 50
  Logic:Get("AniMgr"):MoveToSync(self.owner, actTime, ccp(width, height), true)
  local stageAni1 = self:RunHero(self.owner, self.info.stage1)
  stageAni1:RunAnimationAutoRemove(self.sync:Join())
  self:DelayTime(self.info.param)
  self:RunScene(self.info.stage5, self.info.delay)
  local stageAni4 = self:RunGroupEffect(not self.owner:IsEnemy(), self.info.stage4, 0, self.sync, self.info.adjust)
  local hitFunc = bind(self.HitTarget, self)
  self:ForeachTarget(hitFunc, nil, "HIT")
  self.sync:Sync()
  Logic:Get("AniMgr"):MoveToSync(self.owner, actTime, ccp(orginX, orginY), true)
  local passFunc = bind(self.PassiveTarget, self)
  self:ForeachTarget(passFunc, nil, "PASSIVE")
  local buffFunc = bind(self.BuffTarget, self)
  self:ForeachTarget(buffFunc, nil, "BUFF")
  stageAni4:RemoveAnimation()
end
function class:HitTarget(target, hp, status, shield, info)
  self.targetInfo = info
  local oneAttack = bind(self.RunOneGroupAttack, self)
  self:ForeachShieldAndHp(hp, target, shield, self.info.combs, status, oneAttack)
end
function class:RunOneGroupAttack(target, hp, shield, status, times, bLastTime)
  local info = self.targetInfo
  local waitSign3 = self.sync:Join()
  self:RunPassiveAndBuff(target, hp, status, shield, info)
  if bLastTime then
  end
  local stageAni3 = self:RunHero(target, self.info.stage3, true)
  stageAni3:RunAnimationByWaitSign(nil, function()
    waitSign3()
    stageAni3:RemoveAnimation()
    target:CheckShieldRemove()
    target:CheckDead()
  end, Define.ANI_TIMEOUT)
end
