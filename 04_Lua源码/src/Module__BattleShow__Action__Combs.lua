local Base = require("BattleShow.Action.Base")
local Define = require("BattleShow.BattleDefine")
module((...), package.seeall)
class = Base.class:subclass()
function class:initialize(...)
  super.initialize(self, ...)
end
function class:PlayAction()
  local srcPos = ccp(self.owner:getPosition())
  self.actTime = 0
  local hitFunc = bind(self.HitTarget, self)
  self:ForeachTarget(hitFunc, nil, "HIT")
  Logic:Get("AniMgr"):MoveToAndRotateSync(self.owner, self.actTime, srcPos, 0)
  local passFunc = bind(self.PassiveTarget, self)
  self:ForeachTarget(passFunc, nil, "PASSIVE")
  local buffFunc = bind(self.BuffTarget, self)
  self:ForeachTarget(buffFunc, nil, "BUFF")
end
function class:HitTarget(target, hp, status, shield, info)
  self.targetInfo = info
  local oneAttack = bind(self.RunOneAttack, self)
  self:ForeachShieldAndHp(hp, target, shield, self.info.combs, status, oneAttack)
  self.sync:Sync()
end
function class:RunOneAttack(target, hp, shield, status, times, bLastTime)
  local info = self.targetInfo
  local cz = target:getContentSize()
  local scale = target:getScale()
  local offsetY = cz.height * scale / 2 + 50
  self.actTime = self:GetMovingTimeByUnits(self.owner, target, self.info)
  local angle = self:GetMovingAngle(self.owner, target)
  Logic:Get("AniMgr"):MoveToAndRotateSync(self.owner, self.actTime, self:CalcPosition(target, offsetY, angle), angle)
  local bThreeFourCombs = self.info.combs == 3 or self.info.combs == 4
  local condition1 = times < 2
  local condition2 = times == 2
  local condition3 = times == 5
  local condition4 = times >= 2 and times < 5
  local condition5 = times < 2 or times == 4 or times == 5
  local delayVal = 0.03 * (times - 2)
  if bThreeFourCombs then
    condition1 = false
    condition2 = times == 0
    condition3 = times == 3
    condition4 = true
    condition5 = times == 2 or times == 3
    delayVal = 0.03 * times
  end
  local waitSign = function()
  end
  if condition1 then
    waitSign = self.sync:Join()
    local curState = string.format("stage%d", times + 1)
    local stageAni = self:RunHero(self.owner, self.info[curState])
    stageAni:RunAnimationAutoRemove(self.sync:Join())
  elseif condition2 then
    local multiAttack = self.info.stage5
    local stageAniMulti = self:RunHero(self.owner, multiAttack)
    stageAniMulti:RunAnimationAutoRemove(self.sync:Join())
  elseif condition3 then
    local lastAttack = self.info.feedback
    local stageAniLast = self:RunHero(self.owner, lastAttack)
    stageAniLast:RunAnimationAutoRemove(self.sync:Join())
    self:DelayTime(0.06)
  end
  self:DelayTime(0.06)
  if condition4 then
    self:DelayTime(delayVal)
  end
  local stageAni3 = self:RunHero(target, self.info.stage3, true)
  local stageAni4 = self:RunEffect(target, self.info.stage4, hp == 0, true, nil)
  if stageAni4 and stageAni4:GetChild("rootNode") then
    stageAni4:GetChild("rootNode"):setRotation(2 / math.pi + angle)
  end
  self:RunPassiveAndBuff(target, hp, status, shield, info)
  if bLastTime then
  end
  stageAni3:RunAnimationByWaitSign(nil, function()
    stageAni3:RemoveAnimation()
    waitSign()
    target:CheckDead(angle)
  end, Define.ANI_TIMEOUT)
  stageAni4:RunAnimationAutoRemove()
  if condition5 then
    self.sync:Sync()
  end
end
