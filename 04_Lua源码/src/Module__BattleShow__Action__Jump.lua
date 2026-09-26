local Base = require("BattleShow.Action.Base")
local Define = require("BattleShow.BattleDefine")
module((...), package.seeall)
class = Base.class:subclass()
function class:initialize(...)
  super.initialize(self, ...)
end
function class:PlayAction()
  local srcPos = ccp(self.owner:getPosition())
  local orginScale = self.owner:getScale()
  self.parentLayer:reorderChild(self.owner, 0)
  local hitFunc = bind(self.HitTarget, self)
  self:ForeachTarget(hitFunc, nil, "HIT")
  local move = CCMoveTo:create(0.1, srcPos)
  local scale = CCScaleTo:create(0.1, orginScale)
  local spawn = Logic:Get("AniMgr"):CreateSpawn({move, scale})
  local sequence = Logic:Get("AniMgr"):CreateSequence({
    spawn,
    self.sync:Join()
  })
  self.owner:runAction(sequence)
  self.sync:Sync()
  self.owner:stopAllActions()
  self.owner:setRotation(0)
  self.owner:setScale(orginScale)
  local passFunc = bind(self.PassiveTarget, self)
  self:ForeachTarget(passFunc, nil, "PASSIVE")
  local buffFunc = bind(self.BuffTarget, self)
  self:ForeachTarget(buffFunc, nil, "BUFF")
end
function class:HitTarget(target, hp, status, shield, info)
  local srcPos = ccp(self.owner:getPosition())
  local tx, ty = target:getPosition()
  local cz = target:getContentSize()
  local scale = target:getScale()
  local offsetY = cz.height * scale
  local actTime = self:GetMovingTimeByUnits(self.owner, target, self.info)
  local angle = self:GetMovingAngle(self.owner, target)
  local stageAni1 = self:RunHero(self.owner, self.info.stage1)
  stageAni1:RunAnimationAutoRemove(self.sync:Join())
  self:RunUpSideDown(srcPos, self:CalcPosition(target, offsetY, angle), actTime, angle)
  local stageAni3 = self:RunHero(target, self.info.stage3, true)
  local stageAni4 = self:RunEffect(target, self.info.stage4, hp == 0, true, nil)
  if stageAni4 and stageAni4:GetChild("rootNode") then
    stageAni4:GetChild("rootNode"):setRotation(2 / math.pi + angle)
  end
  self:RunPassiveAndBuff(target, hp, status, shield, info)
  local waitSign = self.sync:Join()
  stageAni3:RunAnimationByWaitSign(nil, function()
    stageAni3:RemoveAnimation()
    waitSign()
    target:CheckDead(angle)
  end, Define.ANI_TIMEOUT)
  stageAni4:RunAnimationAutoRemove()
  self.sync:Sync()
  if self.info.feedback then
    local feedbackAni = self:RunEffect(self.owner, self.info.feedback)
    feedbackAni:RunAnimationSync(true, self.sync)
  end
end
function class:RunUpSideDown(srcPos, dstPos, time, angle)
  local minPosDetal = ccp((dstPos.x - srcPos.x) * 0.6666666666666666, (dstPos.y - srcPos.y) * 0.6666666666666666)
  local waitSign = self.sync:Join()
  local jumpMove = CCEaseExponentialOut:create(CCMoveBy:create(0.3, minPosDetal))
  local jumpRotate = CCEaseExponentialOut:create(CCRotateTo:create(0.3, angle))
  local jumpAction = Logic:Get("AniMgr"):CreateSpawn({jumpMove, jumpRotate})
  local downMove = CCEaseExponentialIn:create(CCMoveTo:create(0.05, dstPos))
  local actions = {
    jumpAction,
    CCDelayTime:create(0.1),
    downMove,
    waitSign
  }
  self.owner:runAction(Logic:Get("AniMgr"):CreateSequence(actions))
  self.sync:Sync()
end
