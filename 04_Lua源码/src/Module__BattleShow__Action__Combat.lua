local Base = require("BattleShow.Action.Base")
local Define = require("BattleShow.BattleDefine")
module((...), package.seeall)
class = Base.class:subclass()
function class:initialize(...)
  super.initialize(self, ...)
end
function class:PlayAction()
  local heroOrginPosX, heroOrginPosY = self.owner:getPosition()
  local stageAni1 = self:RunHero(self.owner, self.info.stage1)
  stageAni1:RunAnimation()
  self.actTime = 0.3
  if self.isMultiHit then
    local wz = CCDirector:sharedDirector():getWinSize()
    Logic:Get("AniMgr"):MoveToSync(self.owner, self.actTime, ccp(wz.width / 2, wz.height / 2))
    local stageAni2 = self:RunEffect(self.owner, self.info.stage2)
    stageAni2:RunAnimationSync(true)
  end
  local hitFunc = bind(self.HitTarget, self)
  self:ForeachTarget(hitFunc, nil, "HIT")
  Logic:Get("AniMgr"):MoveToSync(self.owner, self.actTime, ccp(heroOrginPosX, heroOrginPosY))
  local passFunc = bind(self.PassiveTarget, self)
  self:ForeachTarget(passFunc, nil, "PASSIVE")
  local buffFunc = bind(self.BuffTarget, self)
  self:ForeachTarget(buffFunc, nil, "BUFF")
  stageAni1:RemoveAnimation()
end
function class:HitTarget(target, hp, status, shield, info)
  if not self.isMultiHit then
    local tx, ty = target:getPosition()
    local cz = target:getContentSize()
    local scale = target:getScale()
    local offsetY = target:IsEnemy() and -cz.height * scale + 50 or cz.height * scale - 50
    self.actTime = self:GetMovingTimeByUnits(self.owner, target, self.info)
    Logic:Get("AniMgr"):AccMoveToSync(self.owner, self.actTime, ccp(tx, ty + offsetY))
    local stageAni2 = self:RunEffect(self.owner, self.info.stage2)
    stageAni2:RunAnimationSync(true)
  end
  local stageAni3 = self:RunHero(target, self.info.stage3)
  local stageAni4 = self:RunEffect(target, self.info.stage4, hp == 0)
  self:RunPassiveAndBuff(target, hp, status, shield, info)
  stageAni3:RunAnimationByWaitSign(nil, function()
    stageAni3:RemoveAnimation()
    target:CheckShieldRemove()
    target:CheckDead()
  end, Define.ANI_TIMEOUT)
  stageAni4:RunAnimationAutoRemove()
end
