local Base = require("BattleShow.Action.Base")
local Define = require("BattleShow.BattleDefine")
module((...), package.seeall)
class = Base.class:subclass()
function class:initialize(...)
  super.initialize(self, ...)
end
function class:PlayAction()
  local stageAni1, stageAni2
  local fadeTime = tonumber(self.info.param)
  if fadeTime > 0 then
    local fadeWait1 = self.sync:Join()
    self.owner:RunOpacity(fadeTime, false, fadeWait1)
  else
    stageAni1 = self:RunHero(self.owner, self.info.stage1)
    stageAni1:RunAnimationAutoRemove(self.sync:Join())
  end
  stageAni2 = self:RunEffect(self.owner, self.info.stage2)
  stageAni2:RunAnimationAutoRemove(self.sync:Join())
  self.sync:Sync()
  if not (fadeTime > 0) then
    stageAni1:RemoveAnimation()
  end
  self.hasHit = false
  local hitFunc = bind(self.HitTarget, self)
  self:ForeachTarget(hitFunc, nil, "HIT")
  self.sync:Sync()
  self:RunFeedBackEffect(self.info.feedback, self.hasHit, self.sync)
  self.sync:Sync()
  local passFunc = bind(self.PassiveTarget, self)
  self:ForeachTarget(passFunc, nil, "PASSIVE")
  local buffFunc = bind(self.BuffTarget, self)
  self:ForeachTarget(buffFunc, nil, "BUFF")
  if fadeTime > 0 then
    self.owner:RunOpacity(fadeTime, true)
  end
end
function class:HitTarget(target, hp, status, shield, info)
  self.hasHit = self.hasHit or hp ~= 0 or shield ~= 0
  local stageAni3 = self:RunHero(target, self.info.stage3)
  local stageAni4 = self:RunEffect(target, self.info.stage4, hp == 0)
  self:RunPassiveAndBuff(target, hp, status, shield, info)
  local heroWaitSign = self:CheckHeroNextEffect(target, self.sync)
  stageAni3:RunAnimationByWaitSign(nil, function()
    stageAni3:RemoveAnimation()
    target:CheckShieldRemove()
    target:CheckDead()
    heroWaitSign()
  end, Define.ANI_TIMEOUT)
  stageAni4:RunAnimationAutoRemove()
end
