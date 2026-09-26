local Base = require("BattleShow.Action.Base")
local Define = require("BattleShow.BattleDefine")
module((...), package.seeall)
class = Base.class:subclass()
function class:initialize(...)
  super.initialize(self, ...)
end
function class:PlayAction()
  local srcPos = ccp(self.owner:getPosition())
  local stageAni2 = self:RunEffect(self.owner, self.info.stage2)
  stageAni2:RunAnimationSync(true)
  local stageAni1 = self:RunHero(self.owner, self.info.stage1)
  stageAni1:RunAnimation()
  self.actTime = 0
  local hitFunc = bind(self.HitTarget, self)
  self:ForeachTarget(hitFunc, nil, "HIT")
  Logic:Get("AniMgr"):MoveToSync(self.owner, self.actTime, srcPos)
  local passFunc = bind(self.PassiveTarget, self)
  self:ForeachTarget(passFunc, nil, "PASSIVE")
  local buffFunc = bind(self.BuffTarget, self)
  self:ForeachTarget(buffFunc, nil, "BUFF")
  stageAni1:RemoveAnimation()
  Logic:Get("AniMgr"):RotateToSync(self.owner, 0.3, 0)
end
function class:HitTarget(target, hp, status, shield, info)
  local angle, dstPos
  self.actTime, angle, dstPos = self:GetUnitAngleInfo(self.owner, target, self.info, 0.5, self:GetOffsetY())
  Logic:Get("AniMgr"):RotateToSync(self.owner, 0.3, angle)
  Logic:Get("AniMgr"):AccMoveToSync(self.owner, self.actTime, dstPos)
  self:RunTargetHitted(target, hp, status, shield, info, angle, self.sync:Join())
  self.sync:Sync()
  if self.info.feedback then
    local feedbackAni = self:RunEffect(self.owner, self.info.feedback)
    feedbackAni:RunAnimationSync(true, self.sync)
  end
  self.sync:Sync()
end
function class:RunTargetHitted(target, hp, status, shield, info, angle, waitSign)
  self:RunPassiveAndBuff(target, hp, status, shield, info)
  local stageAni4 = self:RunEffect(target, self.info.stage4, hp == 0, true)
  if stageAni4 and stageAni4:GetChild("rootNode") and angle then
    stageAni4:GetChild("rootNode"):setRotation(2 / math.pi + angle)
  end
  local stageAni3 = self:RunHero(target, self.info.stage3, true)
  local heroWaitSign = self:CheckHeroNextEffect(target, self.sync)
  stageAni3:RunAnimationByWaitSign(nil, function()
    stageAni3:RemoveAnimation()
    target:CheckShieldRemove()
    target:CheckDead(angle)
    heroWaitSign()
    waitSign = waitSign and waitSign()
  end, Define.ANI_TIMEOUT)
  stageAni4:RunAnimationAutoRemove()
end
