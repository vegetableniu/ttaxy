module((...), package.seeall)
class = objectlua.Mixin:new()
local Define = require("BattleShow.BattleDefine")
local CCBAni = require("BattleShow.CCBAnimation")
local LAYER_LEVEL = Define.LAYER_LEVEL
local VALUE = Define.REPROT_VALUE
local BUFF = Define.REPROT_BUFF
local ATK_EREA = {
  FORWARD = 1,
  BEHIND = 2,
  ALL = 0
}
function class:initialize(mgr)
  self.mgr = mgr
  self.parentLayer = mgr.parentLayer
  self.action = mgr.action
  self.nextAction = mgr.nextAction
  self.owner = mgr.owner
  self.schedMgr = mgr.schedMgr
  self.bCombs = mgr.info.combs >= 2
end
function class:PlaySound(sound)
  if sound == nil or sound == "" then
    return
  end
  sound = "audio/effect/" .. sound .. ".mp3"
  Logic:Get("BGSound"):PlayEffect(sound)
end
function class:RunPassiveAndBuff(target, hp, status, shield, info)
  self:RunPassive(target, info.passives, hp, shield, status)
  self:RunBuff(target, info.buffs)
  target:CheckRemainHp()
end
function class:RunBuff(target, buffs)
  for i, buff in ipairs(buffs) do
    log4battle:debug("buff id = %d", buff.id)
    do
      local hpBuff, shieldBuff = 0, 0
      self:ForeachValue(buff.value, function(hp, shield)
        hpBuff = (hp or 0) + hpBuff
        shieldBuff = (shield or 0) + shieldBuff
      end)
      target:OpratorBuff(buff.id, buff.type, hpBuff, shieldBuff)
      if hpBuff ~= 0 then
        target:AddHpValue(hpBuff, nil, nil, "BUFF")
      end
      if shieldBuff ~= 0 then
        if buff.type == BUFF.ADD then
          target:CreateShield(shieldBuff)
        elseif buff.type == BUFF.REMOVE then
          target:CheckShieldRemove(true)
        else
          target:AddShieldValue(shieldBuff)
        end
      end
    end
  end
end
function class:RunPassive(target, passives, hpValue, shieldValue, status, times)
  local passiveType
  for _, pass in ipairs(passives) do
    log4battle:debug("pass id = %d", pass.id)
    passiveType = self:GetPassiveType(pass.id)
    self:ForeachValue(pass.value, function(hp, shield)
      if shield ~= 0 and shield ~= nil then
        target:AddShieldValue(shield)
        passiveType = nil
      end
      if hp ~= 0 and hp ~= nil then
        target:AddHpValue(hp, status, passiveType, "PASSIVE")
        passiveType = nil
      end
    end)
  end
  if shieldValue ~= 0 then
    target:AddShieldValue(shieldValue)
  end
  if hpValue ~= 0 or table.empty(passives) then
    local combs = {bCombs = false, times = 0}
    target:AddHpValue(hpValue, status, passiveType, combs)
  end
end
function class:RunHero(target, stage, bNotTop)
  self:PlaySound(stage.sound)
  stage = stage.effect
  if not bNotTop then
    self.parentLayer:reorderChild(target, 0)
  end
  local flipXY = stage and stage.flip and target:IsEnemy()
  local ani = CCBAni.class:new(stage and stage.name, target, nil, LAYER_LEVEL.HERO, flipXY)
  ani:AttachCard(target:GetUnitInfo())
  if target == self.owner and target:GetHighLightStatus() then
    ani:AttachHighLight()
  end
  return ani
end
function class:RunScene(stage, delay)
  local stage = stage.effect
  if stage and stage.name then
    local winSz = CCDirector:sharedDirector():getWinSize()
    local scene = CCBAni.class:new(stage.name, self.parentLayer, ccp(winSz.width / 2, winSz.height / 2), LAYER_LEVEL.EFF)
    scene:RunAnimationAutoRemove()
  end
  local BG_BTL_TAG = 128
  local bkgLayer = self.parentLayer:getChildByTag(BG_BTL_TAG)
  if bkgLayer then
    do
      local x, y = bkgLayer:getPosition()
      local array = CCArray:create()
      array:addObject(CCDelayTime:create(delay))
      local count = 8
      for i = 1, count do
        array:addObject(CCMoveTo:create(0.05, ccp(x, y - 6)))
        array:addObject(CCMoveTo:create(0.05, ccp(x - 3, y)))
        array:addObject(CCMoveTo:create(0.05, ccp(x, y + 6)))
        array:addObject(CCMoveTo:create(0.05, ccp(x + 3, y)))
      end
      array:addObject(CCCallFuncN:create(function()
        bkgLayer:setPosition(ccp(x, y))
      end))
      bkgLayer:runAction(CCSequence:create(array))
    end
  end
end
function class:RunEffectFolow(target, stage, bNotTop)
  self:PlaySound(stage.sound)
  stage = stage.effect
  if not bNotTop then
    self.parentLayer:reorderChild(target, 0)
  end
  local flipXY = stage and stage.flip and target:IsEnemy()
  local ani = CCBAni.class:new(stage and stage.name, target, nil, LAYER_LEVEL.EFF, flipXY, target:getScale())
  return ani
end
function class:RunEffect(target, stage, bNotEffect, bNotTop, bFlipXY)
  self:PlaySound(stage.sound)
  stage = stage.effect
  if not bNotTop then
    self.parentLayer:reorderChild(target, 0)
  end
  local x, y = target:getPosition()
  local flipXY = stage and stage.flip and target:IsEnemy()
  if bFlipXY then
    flipXY = not flipXY
  end
  local ani = CCBAni.class:new(not bNotEffect and stage and stage.name, self.parentLayer, ccp(x, y), LAYER_LEVEL.EFF, flipXY, target:getScale())
  return ani
end
function class:RunParticles(owner, stage, angle, waitSign)
  self:PlaySound(stage.sound)
  stage = stage.effect
  local x, y = owner:getPosition()
  local flipXY = stage and stage.flip
  local runner = CCNode:create()
  runner:setContentSize(CCSize(2, 2))
  runner:setPosition(ccp(x, y))
  self.parentLayer:addChild(runner, LAYER_LEVEL.EFF)
  local ani = CCBAni.class:new(stage and stage.name, runner, ccp(0, 0), LAYER_LEVEL.EFF)
  ani:AddToParent()
  ani:FlipXY(owner:getScale(), flipXY and owner:IsEnemy())
  local actor = ani:GetActor()
  if flipXY and angle and actor then
    actor:setRotation(angle)
  end
  return ani, runner
end
function class:RunGroupEffect(bIsEnemy, stage, pos, sync, adjust)
  self:PlaySound(stage.sound)
  adjust = adjust or {}
  stage = stage.effect
  local winSz = CCDirector:sharedDirector():getWinSize()
  local groupHeight = winSz.height * 5 / 8
  local groupWidth = 0
  local x = groupWidth / 2
  local y = 0
  if pos == nil or pos == ATK_EREA.ALL then
    y = bIsEnemy and groupHeight - 100 or 0
  else
    y = bIsEnemy and (pos == ATK_EREA.BEHIND and groupHeight + winSz.height * 1 / 8 or groupHeight - winSz.height * 1 / 8 - 150) or pos == ATK_EREA.FORWARD and winSz.height * 1 / 8 or -winSz.height * 1 / 8 + 50
  end
  if bIsEnemy then
  else
    y = y + (adjust.up or 0) or y + (adjust.down or 0)
  end
  local ani = CCBAni.class:new(stage and stage.name, self.parentLayer, ccp(x, y), LAYER_LEVEL.EFF)
  ani:RunAnimationAutoRemove(sync:Join())
  return ani
end
function class:RunFeedBackEffect(info, hasHit, sync)
  if info.effect and hasHit then
    local winSz = CCDirector:sharedDirector():getWinSize()
    local point = ccp(winSz.width / 2, winSz.height / 2 - 50)
    local feedbackAni = CCBAni.class:new(info.effect.name, self.parentLayer, point, LAYER_LEVEL.EFF)
    feedbackAni:RunAnimationSync(true, sync)
  end
end
function class:RunParticlesAni(particles, sync)
  for _, ani in ipairs(particles) do
    ani:RunAnimation(nil, sync)
  end
end
function class:RemoveParticlesAni(particles)
  for _, ani in ipairs(particles) do
    ani:RemoveAnimation()
  end
end
function class:CheckHeroNextEffect(owner, sync)
  local nilFun = function()
  end
  if self.nextAction == nil then
    return nilFun
  end
  if owner == Logic:Get("RoleView"):Find(self.nextAction.owner) then
    return sync:Join()
  end
  local function AddHpForDead()
    for _, target in ipairs(self.nextAction.targets) do
      do
        local unit = Logic:Get("RoleView"):Find(target.target)
        local hpValue, shieldValue = 0, 0
        self:ForeachValue(target.value, function(hp, shield)
          hpValue = (hp or 0) + hpValue
          shieldValue = (shield or 0) + shieldValue
        end)
        if unit == owner and hpValue > 0 then
          return true
        end
      end
    end
    return false
  end
  if owner:GetHp() <= 0 and AddHpForDead() then
    return sync:Join()
  end
  local nextWait = nilFun
  self:ForeachTarget(function(target)
    if nextWait ~= nilFun then
      return true
    end
    if target == owner then
      nextWait = sync:Join()
    end
  end, self.nextAction)
  return nilFun
end
function class:ForeachTarget(callback, targetsList, hType)
  targetsList = targetsList or self.action.targets
  hType = hType or "ALL"
  for _, target in ipairs(targetsList) do
    do
      local targetUnit = Logic:Get("RoleView"):Find(target.target)
      local hpValue, shieldValue = 0, 0
      self:ForeachValue(target.value, function(hp, shield)
        hpValue = (hp or 0) + hpValue
        shieldValue = (shield or 0) + shieldValue
      end)
      local nohit = "ALL"
      if not table.empty(target.passives) and self.owner == targetUnit then
        nohit = "PASSIVE"
      elseif not table.empty(target.buffs) and table.empty(target.value) and table.empty(target.passives) then
        nohit = "BUFF"
      else
        nohit = "HIT"
      end
      local pass = hType == "ALL" or hType == nohit
      if pass and targetUnit then
        callback(targetUnit, hpValue, Define.CStatus:new(target.state), shieldValue, target)
      end
    end
  end
end
function class:GetPassiveType(id)
  local passInfo = KFDBGetRecord("PassiveConfig", id)
  if passInfo ~= nil then
    return passInfo.type
  end
end
function class:ForeachValue(value, callback)
  for idx, v in ipairs(value) do
    if VALUE.HP == v.type then
      callback(v.content, nil)
    elseif VALUE.SHIELD == v.type then
      callback(nil, v.content, idx)
    end
  end
end
function class:DelayTime(time)
  Logic:Get("AniMgr"):DelayTimeSync(self.parentLayer, time, true)
end
function class:GetBezierAction(srcPos, dstPos, duartion, controlPointOffset)
  if not (dstPos.y > srcPos.y) or not controlPointOffset then
    controlPointOffset = -controlPointOffset
  end
  local bezier = ccBezierConfig()
  bezier.controlPoint_1 = ccp(srcPos.x + controlPointOffset, srcPos.y)
  bezier.controlPoint_2 = ccp(dstPos.x + controlPointOffset, dstPos.y)
  bezier.endPosition = dstPos
  local bezierTo = CCBezierTo:create(duartion, bezier)
  return bezierTo
end
function class:GetOrbitAction()
  local arrAction = CCArray:create()
  local orbit1 = CCOrbitCamera:create(1, 1, 0, 0, 180, 0, 0)
  return orbit1
end
function class:RepeatAction(action)
  local arrAction = CCArray:create()
  arrAction:addObject(action)
  local seq = CCSequence:create(arrAction)
  return CCRepeatForever:create(seq)
end
function class:SwitchTarget(owner, target, sync)
  if owner == target then
    return
  end
  local function createActinos(pos)
    local rotate1 = CCRotateBy:create(0.2, 60)
    local moveTo = CCMoveTo:create(0.4, pos)
    local rotate2 = rotate1:reverse()
    local func = sync:Join()
    local array = {
      rotate1,
      moveTo,
      rotate2,
      func
    }
    return Logic:Get("AniMgr"):CreateSequence(array)
  end
  owner:runAction(createActinos(ccp(target:getPosition())))
  target:runAction(createActinos(ccp(owner:getPosition())))
  sync:Sync()
end
function class:RunFadeTo(target, time, opacity)
  local children = target:getChildren()
  if children ~= nil then
    for i = 1, children:count() do
      local child = children:objectAtIndex(i - 1)
      local node = tolua.cast(child, "CCNode")
      node:runAction(CCFadeTo:create(time, opacity))
      self:RunFadeTo(child)
    end
  end
end
