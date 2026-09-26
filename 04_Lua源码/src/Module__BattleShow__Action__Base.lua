module((...), package.seeall)
local Define = require("BattleShow.BattleDefine")
local Action = require("BattleShow.Helper.Action")
local Block = require("BattleShow.Helper.Block")
local Combs = require("BattleShow.Helper.Combs")
local Trigono = require("BattleShow.Helper.Trigono")
class = objectlua.Object:subclass()
class:include(Action.class)
class:include(Block.class)
class:include(Combs.class)
class:include(Trigono.class)
function class:initialize(mgr)
  super.initialize(self)
  Action.class.initialize(self, mgr)
  Trigono.class.initialize(self, mgr)
  self.parentLayer = mgr.parentLayer
  self.action = mgr.action
  self.nextAction = mgr.nextAction
  self.beforeAction = mgr.beforeAction
  self.endsConduct = mgr.endsConduct
  self.owner = mgr.owner
  self.isMultiHit = mgr.isMultiHit
  self.info = mgr.info
  self.showUI = mgr.mgr
  self:Init()
  self.sync = Utils.Synchroniser:new()
  self:PlayBeforeAction()
  self.sync:Sync()
  if not table.empty(self.action.targets) then
    self:PlayAction()
    self.sync:Sync()
  end
  self:PlayEnd()
  self.sync:Sync()
end
function class:PlayAction()
  assert(false, "[PlayAction] not overwrite!")
end
function class:HitTarget()
  assert(false, "[HitTarget] not overwrite!")
end
function class:Init()
  self.owner:SetSkillHighLightStatus(false)
  self.owner:ShowSkillHighLight()
  self.owner:ShowLastHitHeightLight(false)
end
function class:PlayBeforeAction()
  local info = self.beforeAction
  if not info then
    return
  end
  for _, passive in ipairs(info.passives) do
    do
      local target = Logic:Get("RoleView"):Find(info.target)
      local status = Define.CStatus:new(info.state)
      self:RunPassiveAndBuff(target, 0, status, 0, info)
      local stageAni3 = self:RunHero(target, self.info.stage3)
      local heroWaitSign = self.sync:Join()
      stageAni3:RunAnimationByWaitSign(nil, function()
        stageAni3:RemoveAnimation()
        target:CheckShieldRemove()
        target:CheckDead()
        heroWaitSign()
      end, Define.ANI_TIMEOUT)
    end
  end
end
function class:PlayEnd()
  if self.endsConduct == nil or #self.endsConduct == 0 then
    return
  end
  local isReborn = false
  for _, info in ipairs(self.endsConduct) do
    local target = Logic:Get("RoleView"):Find(info.target)
    local status = Define.CStatus:new(info.state)
    if target then
      isReborn = isReborn or target:IsDead()
      self:RunPassiveAndBuff(target, 0, status, 0, info)
      target:CheckDead()
    end
  end
  if isReborn then
    self:DelayTime(0.6)
  end
end
function class:PassiveTarget(target, hp, status, shield, info)
  self:RunPassiveAndBuff(target, hp, status, shield, info)
  local stageAni3 = self:RunHero(target, self.info.stage3)
  local heroWaitSign = self:CheckHeroNextEffect(target, self.sync)
  stageAni3:RunAnimationByWaitSign(nil, function()
    stageAni3:RemoveAnimation()
    target:CheckShieldRemove()
    target:CheckDead()
    heroWaitSign()
  end, Define.ANI_TIMEOUT)
end
function class:NeedToFightBack()
end
function class:BuffTarget(target, hp, status, shield, info)
  self:RunPassiveAndBuff(target, hp, status, shield, info)
  target:CheckDead()
end
