local Base = require("BattleShow.Action.Base")
local Define = require("BattleShow.BattleDefine")
module((...), package.seeall)
class = Base.class:subclass()
function class:initialize(...)
  super.initialize(self, ...)
end
function class:PlayAction()
  local heroOrginPosX, heroOrginPosY = self.owner:getPosition()
  self.actTime = 0.3
  local hitFunc = bind(self.HitTarget, self)
  self:ForeachTarget(hitFunc, nil, "HIT")
  Logic:Get("AniMgr"):MoveToSync(self.owner, self.actTime, ccp(heroOrginPosX, heroOrginPosY))
  local passFunc = bind(self.PassiveTarget, self)
  self:ForeachTarget(passFunc, nil, "PASSIVE")
  local buffFunc = bind(self.BuffTarget, self)
  self:ForeachTarget(buffFunc, nil, "BUFF")
end
function class:HitTarget(target, hp, status, shield, info)
  self.targetInfo = info
  local tx, ty = target:getPosition()
  local cz = target:getContentSize()
  local scale = target:getScale()
  local offsetY = target:IsEnemy() and -cz.height * scale - 80 or cz.height * scale + 80
  self.actTime = self:GetMovingTimeByUnits(self.owner, target, self.info)
  Logic:Get("AniMgr"):AccMoveToSync(self.owner, self.actTime, ccp(tx, ty + offsetY), true)
  local oneAttack = bind(self.RunOneAttack, self)
  self:ForeachShieldAndHp(hp, target, shield, self.info.combs, status, oneAttack)
  self.sync:Sync()
end
function class:RunOneAttack(target, hp, shield, status, times, bLastTime)
  local info = self.targetInfo
  local atkState = self.info.stage1.effect[times + 1]
  local stageAni = self:RunHero(self.owner, atkState or {})
  stageAni:RunAnimationAutoRemove(self.sync:Join())
  self:RunPassiveAndBuff(target, hp, status, shield, info)
  if bLastTime then
  end
  local stageAni3 = self:RunHero(target, self.info.stage3, true)
  local defState = self.info.stage4.effect[times + 1]
  local stageAni4 = self:RunEffect(target, defState or {}, hp == 0, true, nil)
  local waitSign = self.sync:Join()
  stageAni3:RunAnimationByWaitSign(nil, function()
    stageAni3:RemoveAnimation()
    waitSign()
    if bLastTime then
      target:CheckDead()
    end
  end, Define.ANI_TIMEOUT)
  stageAni4:RunAnimationAutoRemove(self.sync:Join())
  self.sync:Sync()
end
