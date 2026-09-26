local Base = require("BattleShow.Action.Base")
local Define = require("BattleShow.BattleDefine")
module((...), package.seeall)
class = Base.class:subclass()
function class:initialize(...)
  super.initialize(self, ...)
end
function class:PlayAction()
  local stageAni1 = self:RunHero(self.owner, self.info.stage1)
  stageAni1:RunAnimation(nil, self.sync)
  local stageAni2 = self:RunEffect(self.owner, self.info.stage2)
  stageAni2:RunAnimation(nil, self.sync)
  self.sync:Sync()
  local hitFunc = bind(self.HitTarget, self)
  self:ForeachTarget(hitFunc, nil, "HIT")
  self.sync:Sync()
  local passFunc = bind(self.PassiveTarget, self)
  self:ForeachTarget(passFunc, nil, "PASSIVE")
  local buffFunc = bind(self.BuffTarget, self)
  self:ForeachTarget(buffFunc, nil, "BUFF")
  stageAni1:RemoveAnimation()
  stageAni2:RemoveAnimation()
  if self.info.feedback then
    local feedbackAni = self:RunEffect(self.owner, self.info.feedback)
    feedbackAni:RunAnimationSync(true, self.sync)
  end
  self.sync:Sync()
end
function class:HitTarget(target, hp, status, shield, info)
  self.targetInfo = info
  local oneAttack = bind(self.RunOneDistanceAttack, self)
  self:ForeachShieldAndHp(hp, target, shield, self.info.combs, status, oneAttack)
end
function class:RunOneDistanceAttack(target, hp, shield, status, times, bLastTime)
  local info = self.targetInfo
  local tx, ty = target:getPosition()
  local angle = self:GetMovingAngle(self.owner, target)
  local moveTime = self:GetMovingTimeByUnits(self.owner, target, self.info)
  local waitSign3 = self.sync:Join()
  local particles, runner = self:RunParticles(self.owner, self.info.stage5, angle)
  runner:setVisible(false)
  local function RunPartiEff()
    runner:setVisible(true)
    particles:GetEffect():RunAnimation()
  end
  local function RunHarmEff()
    local stageAni3 = self:RunHero(target, self.info.stage3)
    local stageAni4 = self:RunEffect(target, self.info.stage4, hp == 0)
    self:RunPassiveAndBuff(target, hp, status, shield, info)
    if bLastTime then
    end
    local heroWaitSign = self:CheckHeroNextEffect(target, self.sync)
    stageAni3:RunAnimationByWaitSign(nil, function()
      stageAni3:RemoveAnimation()
      target:CheckShieldRemove()
      target:CheckDead(angle)
      heroWaitSign()
    end, Define.ANI_TIMEOUT)
    stageAni4:RunAnimationAutoRemove()
    self:SetParticalAliveTime(particles, runner, 0.5)
    waitSign3()
  end
  local delay = CCDelayTime:create(times * 0.5)
  local move = CCMoveTo:create(moveTime, ccp(tx, ty))
  local squence = Logic:Get("AniMgr"):CreateSequence({
    delay,
    RunPartiEff,
    move,
    RunHarmEff
  })
  runner:runAction(squence)
end
function class:SetParticalAliveTime(particles, runner, time)
  local bFind = false
  local tagIdx = Define.EFFECT_TAG_BG.PARTICAL_ALIVE
  local function SetChildDisVisible(child, type, owner, tagIdx)
    bFind = true
    child:setVisible(false)
  end
  Define.ForeachChildByTag(particles:GetEffect(), tagIdx, "CCNode", SetChildDisVisible)
  if not bFind then
    self.parentLayer:removeChild(runner, true)
    return
  end
  local targetAct = {}
  table.insert(targetAct, CCDelayTime:create(time))
  table.insert(targetAct, function()
    self.parentLayer:removeChild(runner, true)
  end)
  self.parentLayer:runAction(Logic:Get("AniMgr"):CreateSequence(targetAct))
end
