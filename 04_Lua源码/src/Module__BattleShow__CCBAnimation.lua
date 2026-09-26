module((...), package.seeall)
class = objectlua.Object:subclass()
local Define = require("BattleShow.BattleDefine")
local MotionStreak = require("BattleShow.MotionStreak")
local Progress = require("Progress")
local DOWNLOAD_PRO_BG = Define.DOWNLOAD_PRO_BG
local DOWNLOAD_PRO_FRONT = Define.DOWNLOAD_PRO_FRONT
local SHILED_PRO_BG = Define.SHILED_PRO_BG
local SHILED_PRO_FRONT = Define.SHILED_PRO_FRONT
local HERO_TAG = Define.HERO_TAG
local HIGHLIGHT_TAG = Define.HIGHLIGHT_TAG
function class:initialize(ccb, owner, pos, level, bFilp, scale)
  super.initialize(self)
  if not ccb then
    return
  end
  local rootNode
  rootNode = owner and (owner.rootNode or owner)
  local layer = Tw.Controller:load(ccb, rootNode)
  if layer == nil then
    log4battle:debug(ccb .. "-- created fail")
    return
  end
  if pos == nil and rootNode ~= nil then
    local winSz = rootNode:getContentSize()
    pos = ccp(winSz.width / 2, winSz.height / 2)
  else
    pos = pos or ccp(0, 0)
  end
  layer:setPosition(pos)
  layer:setAnchorPoint(ccp(0.5, 0.5))
  if bFilp then
    scale = scale or 1
    layer:setScaleX(-scale)
    layer:setScaleY(-scale)
  elseif scale then
    layer:setScale(scale)
  end
  self.aniLayer = layer
  self.rootNode = rootNode
  self.level = level
  self.bFilp = bFilp
  self.ccbName = ccb
  self.aniLayer:SetCCBName(ccb)
end
function class:AddChild(node, layer, level, tag)
  if node == nil or self.hasAdded then
    return
  end
  self.hasAdded = true
  if tag == nil and self.attached then
    tag = HERO_TAG
  end
  if tag then
    local preHero = node:getChildByTag(HERO_TAG)
    if preHero then
      preHero:FinishAni()
      node:removeChild(preHero, true)
    end
    node:addChild(layer, level or 0, tag)
  elseif level then
    node:addChild(layer, level)
  else
    node:addChild(layer)
  end
end
function class:AddToParent(hasTag)
  self.attached = hasTag
  self:AddChild(self.rootNode, self.aniLayer, self.level)
end
function class:AttachHighLight()
  if not self:CheckValid() then
    return
  end
  local owner = self:GetActor()
  if owner then
    local ani = Tw.Controller:load(Define.ANI.HIGHLIGHT, owner)
    if ani then
      local winSz = owner:getContentSize()
      local pos = ccp(winSz.width / 2, winSz.height / 2)
      ani:setPosition(pos)
      self:AddChild(owner, ani, -1, HIGHLIGHT_TAG)
    end
  end
end
function class:AttachCard(info)
  if not self:CheckValid() then
    return
  end
  local owner = self:GetActor()
  assert(owner ~= nil, "need var mActor")
  local rootNode = self.rootNode
  if info.model ~= nil then
    local texture, textureRect = Logic:Get("BattleShow"):GetTextureCache(info.model)
    if texture == nil then
      local cardNode = Logic:Get("HeroCardInfo"):createHeroCardForByFight(info.model)
      texture, textureRect = Logic:Get("HeroCardInfo"):GetCardTexture(cardNode)
      texture:setAntiAliasTexParameters()
      Logic:Get("BattleShow"):RestoreTextureCache(info.model, {texture = texture, textureRect = textureRect})
    end
    owner:setTexture(texture)
    owner:setTextureRect(textureRect)
    Define.SetCardScale(owner)
    local hpValue = math.floor(info.hp / info.hpMax * 100)
    if self.aniLayer.mPrgHp then
      self.aniLayer.mPrgHp:createProgress(DOWNLOAD_PRO_BG, DOWNLOAD_PRO_FRONT)
      self.aniLayer.mPrgHp:setValue(hpValue)
    end
    if self.rootNode.mPrgHp then
      self.rootNode.mPrgHp:setValue(hpValue)
      self.rootNode.mPrgHp:setValue(hpValue, true)
    end
    if self.bFilp then
      local scale = owner:getScale()
      owner:setScale(-scale)
      local hp = self.aniLayer.mPrgHp
      if hp then
        local _, ownerY = owner:getPosition()
        local _, hpY = hp:getPosition()
        local orginY = 2 * ownerY - hpY
        hp:setPositionY(orginY)
        local scale = hp:getScale()
        hp:setScale(-scale)
      end
    end
    local unit = Logic:Get("RoleView"):Find(info.id)
    self:MoveAttr(unit, owner)
    self.attached = true
  end
end
function class:MoveAttr(unit, owner)
  unit:MoveBuffsTo(self.aniLayer, 999)
  local max, value = unit:GetShieldValue()
  if max and value then
    local node = CCNode:create()
    owner:getParent():addChild(node)
    node:setAnchorPoint(ccp(0.5, 0.5))
    local size = owner:getContentSize()
    node:setPosition(ccp(70, -14))
    node:setContentSize(CCSizeMake(100, 8))
    local mPrgSp = Progress.prototype:new()
    mPrgSp:createProgress(SHILED_PRO_BG, SHILED_PRO_FRONT, node)
    local shield = math.floor(value / max * 100)
    mPrgSp:setValue(shield)
  end
end
function class:SetParams(...)
  if not self:CheckValid() then
    return
  end
  self.aniLayer:SetParams(...)
end
function class:setVisible(bv)
  if not self:CheckValid() then
    return
  end
  self.aniLayer:setVisible(bv)
end
function class:RunAnimationByWaitSign(ani, waitSign, timeout, retain)
  if not self:CheckValid() then
    return waitSign()
  end
  self:AddChild(self.rootNode, self.aniLayer, self.level)
  if waitSign then
    self.aniLayer:SetWaitSign(waitSign, ani, timeout, retain)
  end
  if self.rootNode.mImg and self.attached then
    self.rootNode:SetVisible(false)
  end
  self.aniLayer:RunAnimation(ani)
end
function class:Run(ani, waitSign, timeout)
  self:RunAnimationByWaitSign(ani, waitSign, timeout)
end
function class:RemoveAnimation(bShow)
  if not self:CheckValid() then
    return
  end
  self.rootNode:removeChild(self.aniLayer, true)
  if self.rootNode.mImg and self.attached then
    self.rootNode:SetVisible(true)
  end
end
function class:GetChild(name)
  if not self:CheckValid() then
    return
  end
  return self.aniLayer[name]
end
function class:GetLayer()
  if not self:CheckValid() then
    return
  end
  return self.aniLayer
end
function class:GetEffect()
  if not self:CheckValid() then
    return
  end
  return self.aniLayer
end
function class:RunAction(actions)
  if not self:CheckValid() then
    return
  end
  return self.aniLayer:runAction(actions)
end
function class:CheckValid()
  return self.aniLayer ~= nil
end
function class:GetActor()
  if not self:CheckValid() then
    return
  end
  return self.aniLayer.mActor
end
function class:FlipXY(scale, flip)
  if not self:CheckValid() then
    return
  end
  local actor = self:GetActor()
  if actor == nil or not flip then
    return
  end
  local ascX = actor:getScaleX()
  local ascY = actor:getScaleY()
  ascX = -scale * ascX
  ascY = -scale * ascY
  actor:setScaleX(ascX)
  actor:setScaleY(ascY)
end
function class:SetChildrenPositionType(positionType)
  if not self:CheckValid() then
    return
  end
  local tag_idx = 200
  while true do
    local child = self.aniLayer:getChildByTag(tag_idx)
    if nil == child then
      break
    end
    log4battle:debug("SetChildrenPositionTypeRelative")
    child = tolua.cast(child, "CCParticleSystemQuad")
    child:setPositionType(positionType)
    tag_idx = tag_idx + 1
  end
end
function class:SetImage(imgPath)
  if not self:CheckValid() then
    return
  end
  local actor = self:GetActor()
  if actor == nil then
    return
  end
  local sprite = CCSprite:create(imgPath)
  if sprite then
    actor:setDisplayFrame(sprite:displayFrame())
  end
end
function class:SetChildVisibleByName(childName, bVisible)
  if not self:CheckValid() then
    return
  end
  if nil ~= self.aniLayer[childName] then
    self.aniLayer[childName]:setVisible(bVisible)
  end
end
function class:SetCloseCallback(owner, callback)
  if not self:CheckValid() then
    return
  end
  self.aniLayer:SetCloseCallback(owner, callback)
end
function class:SetCascadeOpacityEnabled(cascadeOpacityEnabled)
  if not self:CheckValid() then
    return
  end
  if nil ~= self.aniLayer.setCascadeOpacityEnabled then
    self.aniLayer:setCascadeOpacityEnabled(cascadeOpacityEnabled)
  end
end
function class:RunAnimationAutoRemove(waitSign)
  self:RunAnimationByWaitSign(nil, function()
    self:RemoveAnimation()
    if waitSign then
      waitSign()
    end
  end, Define.ANI_TIMEOUT)
end
function class:RunAnimation(ani, sync, timeout)
  if not self:CheckValid() then
    return
  end
  self:AddChild(self.rootNode, self.aniLayer, self.level)
  if sync then
    timeout = timeout or Define.ANI_TIMEOUT
    self.aniLayer:SetWaitSign(sync:Join(), ani, timeout)
  end
  if self.rootNode.mImg and self.attached then
    self.rootNode:SetVisible(false)
  end
  self.aniLayer:RunAnimation(ani)
end
function class:RunAnimationWithoutWait()
  if not self:CheckValid() then
    return
  end
  self.aniLayer:RunAnimation()
end
function class:RunAnimationSync(bAutoRemove, sync, bShow)
  if not self:CheckValid() then
    return
  end
  local synchroniser = sync or Utils.Synchroniser:new()
  local waitSign = synchroniser:Join()
  self.aniLayer:SetWaitSignByDefaultAniName(waitSign, Define.ANI_TIMEOUT)
  self:RunAnimation()
  if bAutoRemove then
    synchroniser:Sync()
    self:RemoveAnimation(bShow)
    return
  end
  return synchroniser
end
function class:RunAni(ani, autoRemove, waitSign, timeout)
  if not self:CheckValid() then
    return
  end
  if autoRemove or waitSign then
    self.aniLayer:SetWaitSign(function()
      if autoRemove then
        self:RemoveAnimation()
      end
      if waitSign then
        waitSign()
      end
    end, ani, timeout)
  end
  self.aniLayer:RunAnimation(ani)
end
function class:SetWaitSignByDefaultAniName(waitSign, timeout)
  if not self:CheckValid() then
    return waitSign()
  end
  self.aniLayer:SetWaitSignByDefaultAniName(waitSign, timeout)
end
function class:SetMotionStreak(child, owner)
  if not self:CheckValid() then
    return
  end
  local c = self:GetChild(child)
  local M = MotionStreak.class:new(c, owner)
  self.aniLayer:AddMotionStreak(M)
end
