module((...), package.seeall)
local Define = require("BattleShow.BattleDefine")
local CCBAni = require("BattleShow.CCBAnimation")
local BuffMgr = require("BattleShow.BuffMgr")
local OutPutMgr = require("BattleShow.OutPutMgr")
local STATUS = Define.STATUS
local ANI = Define.ANI
local IMG_PATH = Define.IMG_PATH
local IMG_SRC = Define.IMG_SRC
local EFF_PATH = Define.EFF_PATH
local HERO_TAG = Define.HERO_TAG
local LAYER_LEVEL = Define.LAYER_LEVEL
local ANI_NAME = "Default Timeline"
local Prog = {HP = "mPrgHp", SP = "mPrgSp"}
prototype = Tw.Controller.prototype:extend()
local DOWNLOAD_PRO_BG = Define.DOWNLOAD_PRO_BG
local DOWNLOAD_PRO_FRONT = Define.DOWNLOAD_PRO_FRONT
local TRANSITION_BG = Define.TRANSITION_BG
local SHILED_PRO_BG = Define.SHILED_PRO_BG
local SHILED_PRO_FRONT = Define.SHILED_PRO_FRONT
local SHILED_TRANSITION_BG = Define.SHILED_TRANSITION_BG
function prototype:onNodeLoaded(node, loader)
  self.info = {}
  self.doneFun = {}
  self.buffMgr = BuffMgr.class:new(self)
  self.outputMgr = OutPutMgr.class:new(self)
  self:SetVisible(false)
end
function prototype:SetPosId(id)
  self.id = id
end
function prototype:GetPosId()
  return self.id
end
function prototype:IsFrontArmy()
  if self.id == nil then
    return
  end
  local id = self:GetPosIdByNum()
  return id < 3 or id >= 6 and id < 9
end
function prototype:GetPosIdByNum()
  assert(self.id ~= nil)
  return tonumber(string.match(self.id, "(%d+)"))
end
function prototype:GetAnotherInRow()
  if self.id == nil then
    return
  end
  local id = self:GetPosIdByNum()
  return self:IsFrontArmy() and id + 3 or id - 3
end
function prototype:RunProgAnimat(type, hpValue, bReduce)
  local prgValue = self[type]:getValue(bReduce)
  local allTime = 800
  local valTime = 50
  local hpStep = (prgValue - hpValue) / (allTime / valTime)
  local moveAction
  local function processMovie()
    prgValue = prgValue - hpStep
    prgValue = hpStep > 0 and (prgValue < hpValue and hpValue or prgValue) or prgValue > hpValue and hpValue or prgValue
    self[type]:setValue(prgValue, bReduce)
    if prgValue == hpValue then
      self[type]:stopAction(moveAction)
    end
  end
  local arrAction = CCArray:create()
  arrAction:addObject(CCDelayTime:create(valTime / 1000))
  arrAction:addObject(CCCallFuncN:create(processMovie))
  local seq = CCSequence:create(arrAction)
  moveAction = CCRepeatForever:create(seq)
  self[type]:setValue(hpValue, not bReduce)
  self[type]:stopAllActions()
  self[type]:runAction(bReduce, moveAction)
end
function prototype:SetProgValueAnimat(type, hpValue, bReduce)
  self:RunProgAnimat(type, hpValue, bReduce)
  self:SetAttachProgValue(type, hpValue)
end
function prototype:SetProgValue(type, hpValue)
  self[type]:setValue(hpValue, false)
  self[type]:setValue(hpValue, true)
  self:SetAttachProgValue(type, hpValue)
end
function prototype:SetAttachProgVisible(type, visible)
  local attachPrg = self:GetAttachProg(type)
  if attachPrg then
    attachPrg:setVisible(visible)
  end
end
function prototype:GetAttachProg(type)
  local actionNode = self:getChildByTag(HERO_TAG)
  return actionNode and actionNode[type]
end
function prototype:SetAttachProgValue(type, hpValue)
  local attachPrg = self:GetAttachProg(type)
  if attachPrg then
    attachPrg:setValue(hpValue)
  end
end
function prototype:HideAttachProg(type, value, time)
  local attachPrg = self:GetAttachProg(type)
  if attachPrg then
    attachPrg:setOpacity(value, time)
  end
end
function prototype:SetName(name)
  self.info.name = name
end
function prototype:GetName()
  return self.info.name
end
function prototype:GetUnitInfo()
  return self.info
end
function prototype:SetVisible(bVisible, isDead)
  bVisible = bVisible and self.info.model ~= nil and not self:IsDead()
  self:GetBindChild():setVisible(bVisible)
  self.mPrgHp:setVisible(bVisible)
  if self.info.shield and self.info.shieldMax then
    self.mPrgSp:setVisible(bVisible)
  end
  self:GetBuffLayer():setVisible(isDead or bVisible)
end
function prototype:PlayReborn()
  local ani = CCBAni.class:new(ANI.MEM_REBORN, self, nil, LAYER_LEVEL.HERO)
  ani:RunAnimationAutoRemove(function()
    self:SetVisible(true)
  end)
end
function prototype:SetUnitInfoAndRetain(info)
  info = info or {}
  info = table.merge(self.info, info)
  self:SetUnitInfo(info)
end
function prototype:GetHp()
  return self.info and self.info.hp or 0
end
function prototype:SetOrginPosition(pos)
  self.orginPos = pos
end
function prototype:GetOrginPosition()
  return self.orginPos
end
function prototype:SetUnitInfo(info, bShow)
  self:RemoveDeadAni()
  self:stopAllActions()
  self:setRotation(0)
  local shield = self.info.shield
  local shieldMax = self.info.shieldMax
  self.info = info or {}
  self.info.shield = shield
  self.info.shieldMax = shieldMax
  self.mPrgHp:removeAllChildrenWithCleanup(true)
  self.mPrgHp:createProgress(DOWNLOAD_PRO_BG, DOWNLOAD_PRO_FRONT, TRANSITION_BG)
  self:ShowHpPrg(false)
  if self.info.model ~= nil then
    local texture, textureRect = Logic:Get("BattleShow"):GetTextureCache(self.info.model)
    if texture == nil then
      local cardNode = Logic:Get("HeroCardInfo"):createHeroCardForByFight(self.info.model)
      texture, textureRect = Logic:Get("HeroCardInfo"):GetCardTexture(cardNode)
      texture:setAntiAliasTexParameters()
      Logic:Get("BattleShow"):RestoreTextureCache(self.info.model, {texture = texture, textureRect = textureRect})
    end
    self:GetBindChild():setTexture(texture)
    self:GetBindChild():setTextureRect(textureRect)
    Define.SetCardScale(self:GetBindChild())
    local bossScale = self:IsBoss() and Define.BOSS_POS.SCALE or 1
    self:setScale(bossScale)
    local hpValue = math.floor(self.info.hp / self.info.hpMax * 100)
    self:SetProgValue(Prog.HP, hpValue)
  end
  self.dropInfo = {}
  self:SetVisible(bShow)
  self:ShowSkillHighLight(true)
  self:ShowLastHitHeightLight(false)
  self:SetCardName()
end
function prototype:SetCardName()
  if self.info.model == nil then
    return
  end
  self:GetBindChild():removeChildByTag(Define.HERO_NAME_TAG, true)
  local heroInfo = Logic:Get("Hero"):GetHeroInfoByBaseId(self.info.model)
  local name = heroInfo and heroInfo.name or ""
  local rank = heroInfo and heroInfo.rank or 1
  rank = Define.RANK_COLOR[rank]
  rank = rank or Define.RANK_COLOR[1]
  local nameLabel = CCLabelTTF:create()
  nameLabel:setAnchorPoint(ccp(0, 0.5))
  nameLabel:setString(name)
  nameLabel:setVerticalAlignment(kCCVerticalTextAlignmentCenter)
  local csz = self.rootNode:getContentSize()
  nameLabel:setPosition(ccp(-12, csz.height / 2))
  nameLabel:setStyle(kCCLabelTTFStyleOutline)
  nameLabel:setFontSize(24)
  nameLabel:setColor(ccc3(unpack(rank)))
  nameLabel:setDimensions(CCSize(24, 250))
  self:GetBindChild():addChild(nameLabel, 99, Define.HERO_NAME_TAG)
end
function prototype:GetTexture()
  return self:GetBindChild():getTexture()
end
function prototype:bindAnimationMgr()
  return true
end
function prototype:PlayDodgeAnimat(angle)
  local aniLogic = Logic:Get("AniMgr")
  local dodgePosOffset = self:IsEnemy() and 50 or -50
  local moveBy = CCMoveBy:create(0.15, ccp(0, dodgePosOffset))
  local reverse = moveBy:reverse()
  self:runAction(aniLogic:CreateSequence({moveBy, reverse}))
end
function prototype:CheckShieldRemove(bRmv)
  if not self.info.shield then
    return
  end
  if bRmv or self.info.shield <= 0 then
    self:SetProgValue(Prog.SP, 0)
    self.mPrgSp:removeAllChildrenWithCleanup(true)
    self.info.shield = nil
  end
end
function prototype:CreateShield(shield)
  self.info.shieldMax = shield
  self.info.shield = shield
  self.mPrgSp:removeAllChildrenWithCleanup(true)
  self.mPrgSp:createProgress(SHILED_PRO_BG, SHILED_PRO_FRONT, SHILED_TRANSITION_BG)
  self.mPrgSp:setVisible(true)
  self:SetProgValueAnimat(Prog.SP, 100, false)
end
function prototype:AddShieldValue(shield)
  if self:IsDead() then
    log4battle:warn("target have dead !")
    return
  end
  if not self.info.shield then
    log4battle:warn("shield have been remove!!")
    return
  end
  if shield ~= nil and shield ~= 0 then
    self.info.shield = self.info.shield + shield
    self.info.shield = self.info.shield > self.info.shieldMax and self.info.shieldMax or self.info.shield
    self.info.shield = self.info.shield < 0 and 0 or self.info.shield
    self:SetProgValueAnimat(Prog.SP, math.floor(self.info.shield / self.info.shieldMax * 100), shield <= 0)
  end
end
function prototype:GetShieldValue()
  return self.info.shieldMax, self.info.shield
end
function prototype:OpratorBuff(id, op, hp, shield)
  self.buffMgr:Oprator(id, op, hp, shield)
end
function prototype:CleanupBuff(isEnd)
  if isEnd then
    self.buffMgr:CleanUp()
  else
    self.buffMgr:DeadClean()
  end
  self:CheckShieldRemove(true)
end
function prototype:GetBuffLayer()
  return self.buffMgr:GetLayer()
end
function prototype:MoveBuffsTo(node, level)
  self.buffMgr:AddBuffsTo(node, level)
end
function prototype:Cleanup()
  self.outputMgr:dispose()
end
function prototype:AddHpValue(hp, status, pType, combsInfo)
  if self:IsDead() then
    if hp == nil or hp <= 0 then
      return
    end
    self:DeadToReborn()
  end
  status = status or Define.CStatus:new(0)
  if hp ~= nil and hp ~= 0 then
    self.info.hp = self.info.hp + hp
    self:SetProgValueAnimat(Prog.HP, math.floor(self.info.hp / self.info.hpMax * 100), hp <= 0)
  elseif status:IsStatus("DODGE") then
    self:PlayDodgeAnimat()
  end
  self.outputMgr:export(hp, status, pType, combsInfo)
end
function prototype:CheckRemainHp()
  self.info.hp = self.info.hp > self.info.hpMax and self.info.hpMax or self.info.hp
  self.info.hp = self.info.hp < 0 and 0 or self.info.hp
end
function prototype:CheckDead(angle)
  if self:IsDead() then
    return
  end
  if self.info.hp <= 0 then
    self.info.status = STATUS.DEAD
    self:CleanupBuff()
    self:RemoveDeadAni()
    if self:IsEnemy() then
      self:PlayEnemyDeadAndDrop(angle)
    else
      self:PlayMemberDead(angle)
    end
  end
end
function prototype:IsEnemy()
  return self.id[1] == "D"
end
function prototype:PlayMemberDead(angle)
  RunInCoroutine(function()
    self:PlayDeadAni(angle)
  end)
end
function prototype:PlayDeadAni(angle)
  Logic:Get("AniMgr"):DelayTimeSync(self.rootNode, 0.5, true)
  local sync = Utils.Synchroniser:new()
  local ani = CCBAni.class:new(ANI.ENEMY_DEAD, self, nil, LAYER_LEVEL.HERO)
  ani:AttachCard(self:GetUnitInfo())
  self:ShowSkillHighLight(true)
  self:ShowLastHitHeightLight(false)
  Logic:Get("BGSound"):PlayEffect("audio/dead.mp3")
  ani:RunAnimationByWaitSign(nil, sync:Join(), Define.ANI_TIMEOUT)
  self:HideAttachProg(Prog.HP, 0, 300)
  sync:Sync()
  self:CleanUpOtherChild(true)
end
function prototype:PlayDeadAni2(angle)
  self:SetProgValue(Prog.HP, 0)
  self:CleanUpOtherChild(true)
  self:GetBindChild():setVisible(true)
  self:getParent():reorderChild(self, 0)
  local winSz = CCDirector:sharedDirector():getWinSize()
  angle = angle or 0
  angle = angle * math.pi / 180
  local OFFSET = 900
  local aniLogic = Logic:Get("AniMgr")
  local pos = ccp(self:getPosition())
  local orginScale = self:getScale()
  local function GetRotateAction()
    local rotateBy = CCRotateBy:create(0.3, 180)
    local seq = aniLogic:CreateSequence({rotateBy})
    local rotateAction = CCRepeatForever:create(seq)
    return rotateAction
  end
  local rotateAction = GetRotateAction()
  self:runAction(rotateAction)
  local actions = {}
  local bHasCrash = false
  local function RunCrashMoveAction(crashPos, endPos, bFlip)
    if crashPos.y < winSz.height and crashPos.y > 0 then
      local move = CCMoveTo:create(0.3, crashPos)
      table.insert(actions, move)
      table.insert(actions, function()
        self:stopAction(rotateAction)
        self:setRotation(0)
        local crashAni = CCBAni.class:new("Actuation/yan", self, nil, LAYER_LEVEL.FORE, bFlip)
        crashAni:RunAnimationAutoRemove()
      end)
      table.insert(actions, CCScaleTo:create(0.2, orginScale * 0.5, orginScale * 1.2))
      table.insert(actions, CCScaleTo:create(0.2, orginScale))
      table.insert(actions, function()
        self:runAction(GetRotateAction())
      end)
      local moveOut = CCMoveTo:create(1, endPos)
      table.insert(actions, moveOut)
      self:runAction(aniLogic:CreateSequence(actions))
      return true
    end
  end
  if angle > 0 and self:IsEnemy() then
    local crashY = pos.y + (winSz.width - pos.x) / math.tan(angle)
    local crashPos = ccp(winSz.width, crashY)
    local ex = winSz.width - OFFSET * math.sin(angle)
    local ey = crashY + OFFSET * math.cos(angle)
    local endPos = ccp(ex, ey)
    bHasCrash = RunCrashMoveAction(crashPos, endPos, true)
  elseif angle > 0 and not self:IsEnemy() then
    local crashY = pos.y - pos.x / math.tan(angle)
    local crashPos = ccp(0, crashY)
    local ex = OFFSET * math.sin(angle)
    local ey = crashY - OFFSET * math.cos(angle)
    local endPos = ccp(ex, ey)
    bHasCrash = RunCrashMoveAction(crashPos, endPos, false)
  elseif angle < 0 and self:IsEnemy() then
    local angle = -angle
    local crashY = pos.y + pos.x / math.tan(angle)
    local crashPos = ccp(0, crashY)
    local ex = OFFSET * math.sin(angle)
    local ey = crashY + OFFSET * math.cos(angle)
    local endPos = ccp(ex, ey)
    bHasCrash = RunCrashMoveAction(crashPos, endPos, false)
  elseif angle < 0 and not self:IsEnemy() then
    local angle = -angle
    local crashY = pos.y - (winSz.width - pos.x) / math.tan(angle)
    local crashPos = ccp(winSz.width, crashY)
    local ex = winSz.width - OFFSET * math.sin(angle)
    local ey = crashY - OFFSET * math.cos(angle)
    local endPos = ccp(ex, ey)
    bHasCrash = RunCrashMoveAction(crashPos, endPos, true)
  end
  if not bHasCrash then
    local offset = self:IsEnemy() and OFFSET or -OFFSET
    local dstX = math.sin(angle) * offset
    local dstY = math.cos(angle) * offset
    local moveBy = CCMoveBy:create(1, ccp(dstX, dstY))
    table.insert(actions, moveBy)
    self:runAction(aniLogic:CreateSequence(actions))
  end
end
function prototype:PlayEnemyDeadAndDrop(angle)
  local function Play()
    self:PlayDeadAni(angle)
    self:RunDropAnimat()
  end
  RunInCoroutine(Play)
end
function prototype:RemoveDeadAni()
  if self.info.deadBehindAni then
    self.info.deadBehindAni:RemoveAnimation()
    self.info.deadBehindAni = nil
  end
end
function prototype:DeadToReborn()
  if self:IsDead() then
    self.info.status = STATUS.REBORN
    self:RemoveDeadAni()
    self:PlayReborn()
  end
end
function prototype:SetDropAnimat(dropAnimat)
  self.dropAnimat = dropAnimat
end
function prototype:RunDropAnimat()
  if nil ~= self.dropAnimat then
    self.dropAnimat(self:getParent(), ccp(self:getPosition()))
    self.dropAnimat = nil
  end
end
function prototype:IsDead()
  return self.info.status == STATUS.DEAD
end
function prototype:IsReborn()
  return self.info.status == STATUS.REBORN
end
function prototype:IsLive()
  return self.info.status == STATUS.LIVE
end
function prototype:MoveForward()
  self.animationMgr:runAnimations(ACTIONS.MOVE.ani)
end
function prototype:RunAnimations(ani)
  self.animationMgr:runAnimations(ani)
end
function prototype:completedAnimationSequenceNamed(name)
  if self.doneFun[name] then
    local doneFun = self.doneFun[name]
    self.doneFun[name] = nil
    doneFun()
  end
end
function prototype:SetWaitSign(doneFun, aniName)
  if doneFun and aniName then
    self.doneFun[aniName] = doneFun
  end
end
function prototype:SetPositionRelative(relativePos)
  local x, y = self:getPosition()
  x = x + relativePos.x
  y = y + relativePos.y
  self:setPosition(ccp(x, y))
end
function prototype:SetWaitSignByDefaultAniName(doneFun)
  local aniName = ACTIONS.MOVE.ani
  self:SetWaitSign(doneFun, aniName)
end
function prototype:RunAmination(ani)
  self:MoveForward()
end
function prototype:IsVisible()
  return self:GetBindChild():isVisible() and self:IsExist()
end
function prototype:ShowHpPrg(bShow)
  if self.mPrgHp then
    self.mPrgHp:setVisible(self:IsVisible() and bShow)
  end
end
function prototype:GetModelId()
  return self.info.model
end
function prototype:Owner()
  return self:GetBindChild()
end
function prototype:IsBoss()
  return self.info.class == Define.Role.BOSS
end
function prototype:IsExist()
  return self.info.model ~= nil
end
function prototype:FinishAni()
  self:completedAnimationSequenceNamed(ANI_NAME)
end
function prototype:SetSkillHighLightStatus(bVisible)
  bVisible = bVisible and self.info.model ~= nil and not self:IsDead()
  self.highLightStatus = bVisible and self:GetSkillRound() ~= 1
end
function prototype:GetHighLightStatus()
  return self.highLightStatus
end
function prototype:ShowSkillHighLight(bNotVis)
  if self.mAniAtlAtk then
    self.mAniAtlAtk:setVisible(not bNotVis and self.highLightStatus)
  end
end
function prototype:ShowLastHitHeightLight(bVisible)
  if self.mAniLastHit then
    self.mAniLastHit:setVisible(bVisible)
  end
end
function prototype:CleanUpOtherChild(isDead)
  local preHero = self.rootNode:getChildByTag(HERO_TAG)
  if preHero then
    self.rootNode:removeChild(preHero, true)
    self:SetVisible(not self:IsEnemy(), true)
  end
end
function prototype:RunOpacity(time, bShow, callBack)
  if not self:IsVisible() and not bShow then
    if callBack then
      callBack()
    end
    return
  end
  self:GetBuffLayer():setVisible(bShow)
  if self.info.shield and self.info.shieldMax then
    self.mPrgSp:setVisible(bShow)
  end
  local opacity = bShow and 255 or 0
  if self:GetBindChild() then
    local acitons = CCArray:create()
    acitons:addObject(CCFadeTo:create(time, opacity))
    if callBack then
      acitons:addObject(CCCallFuncN:create(callBack))
    end
    self:GetBindChild():setOpacity(255 - opacity)
    self:GetBindChild():runAction(CCSequence:create(acitons))
  end
  if self.mPrgHp then
    self.mPrgHp:setOpacity(255 - opacity, 0)
    self.mPrgHp:setOpacity(opacity, time * 1000)
  end
end
function prototype:GetSkillBegin()
  return self.info and self.info.skillBegin or -1
end
function prototype:GetSkillRound()
  return self.info and self.info.skillRound or -1
end
function prototype:ShowLastHitHeightLightByState(state)
  local status = Define.CStatus:new(state)
  if status:IsStatus("LAST") and not self:IsDead() then
    self:ShowLastHitHeightLight(true)
  end
end
function prototype:ShowSkillHeightLightByCD(cds)
  local IsMaster = function(skill)
    local skillInfo = KFDBGetRecord("SkillConfig", skill)
    if skillInfo then
      local str = skillInfo.isMasterSkill
      return str and (string.lower(str) == "true" or str == "1")
    end
  end
  for _, info in ipairs(cds) do
    if IsMaster(info.skill) and info.cd == 0 then
      self:SetSkillHighLightStatus(true)
      self:ShowSkillHighLight()
    end
  end
end
function prototype:ShowSkillHeightLightByRounds(roudCnt)
  local skillRound = self:GetSkillRound()
  local skillBegin = skillRound - self:GetSkillBegin()
  if roudCnt >= skillBegin and (roudCnt - skillBegin) % skillRound == 0 then
    self:SetSkillHighLightStatus(true)
    self:ShowSkillHighLight()
  end
end
function prototype:GetBindChild()
  return self.mImg
end
