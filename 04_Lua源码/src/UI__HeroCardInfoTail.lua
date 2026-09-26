module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
local HERO_LOCK_PATH = "images/Main/heroLock.png"
local CARD_SIZE_WIDTH = 128
function prototype:onEnter()
  self.levelTTF:setString(TwGetStr(103102))
  self.tongyuliTTF:setString(TwGetStr(103103))
end
function prototype:onExit()
  Logic:Get("HeroCardInfo"):SetHeroTalismanVo()
  Logic:Get("HeroCardInfo"):SetHeroArmorsVo()
  Logic:Get("HeroCardInfo"):SetHeroCultiVo(nil)
end
function prototype:ReFrashHeroInfo(heroInfo)
  if heroInfo == nil or next(heroInfo) == nil then
    return
  end
  self.heroInfo = heroInfo
  local fdb_baseHero = Logic:Get("HeroCardInfo"):kdbBaseHero(heroInfo.baseId)
  self:refreshCombination(fdb_baseHero)
  self:refreshArmor()
  self:refreshBridle(heroInfo.baseId)
  if fdb_baseHero == nil then
    return
  end
  if fdb_baseHero.card ~= "HERO" then
    self:createHeroCard(heroInfo.baseId)
    return
  end
  if fdb_baseHero == nil then
    return
  end
  self:createStar(fdb_baseHero.star)
  self:createHeroCard(heroInfo.baseId, heroInfo.fra)
  self:createPro(heroInfo.baseId)
  self:createPhyle(heroInfo.baseId)
  self:createSex(heroInfo.baseId)
  if heroInfo.fra ~= nil then
    local fraName = TwGetStr(103134)
  else
  end
  self.level:setString(heroInfo.level .. "/" .. fdb_baseHero.level or "")
  self.leader:setString(fdb_baseHero.leadership or "")
  local hp, attack = Logic:Get("Hero"):GetHeroLifeAndAttack(heroInfo.baseId, heroInfo.level)
  local buff = {}
  if heroInfo.otherPlayer then
    local artRec = Logic:Get("Artifact"):GetBuffByLevelAndStar(heroInfo.artifactLevel, fdb_baseHero.star)
    buff = Logic:Get("HeroCardInfo"):AllBuffEffect(fdb_baseHero.type, heroInfo.userBuffs or {}, artRec or {}, heroInfo.id)
  else
    buff = Logic:Get("HeroCardInfo"):GetMyBUffEffect(fdb_baseHero.type, fdb_baseHero.star, heroInfo.id)
  end
  local strBuff = {}
  strBuff.ATTACK = ""
  strBuff.LIFE = ""
  if buff.ATTACK ~= 0 then
    strBuff.ATTACK = "(+" .. buff.ATTACK .. ")"
  end
  if buff.LIFE ~= 0 then
    strBuff.LIFE = "(+" .. buff.LIFE .. ")"
  end
  self.attack:setString(attack or "")
  self.life:setString(hp or "")
  self.attAdd:setString(strBuff.ATTACK)
  self.lifeAdd:setString(strBuff.LIFE)
  self.evo:setStyle(kCCLabelTTFStyleOutline)
  self.evo:setString(fdb_baseHero.nextDesc)
  self.getCard:setColor(ccColor3B(255, 0, 0))
  self.getCard:setString(fdb_baseHero.gain or "")
  self.heroDes:setDimensions(CCSize(550, 0))
  self.heroDes:setHorizontalAlignment(kCCTextAlignmentLeft)
  self.heroDes:setFontSize(20)
  self.heroDes:setString(fdb_baseHero.description or "")
  local ini_skillConfig = Logic:Get("HeroCardInfo"):kdbSkillConfig(heroInfo.powerSkill)
  if ini_skillConfig == nil then
    return
  end
  self.iniSkillName:setString(ini_skillConfig.skillname)
  local init = ini_skillConfig.state.cd
  if init == nil or init <= 0 then
    init = 1
  else
    init = init + 1
  end
  local round = ini_skillConfig.state.round
  if round == nil or round <= 0 then
    round = 1
  end
  local skillInfoStr = TwGetStr(103081, round) .. TwGetStr(103046, init)
  self.iniSkillInfo:setString(skillInfoStr)
  self.iniSkillLvl:setString(ini_skillConfig.level .. "/" .. ini_skillConfig.maxlev)
  self.iniSkillDes:setDimensions(CCSize(500, 0))
  self.iniSkillDes:setHorizontalAlignment(kCCTextAlignmentLeft)
  local text = ini_skillConfig.skilldesc or ""
  text = ReplaceStringTab(text)
  self.iniSkillDes:setString(text)
  self.pasSkillDes:setDimensions(CCSize(500, 0))
  self.pasSkillDes:setHorizontalAlignment(kCCTextAlignmentLeft)
  self.pasSkillName:setString(fdb_baseHero.skillname_3 or "")
  local text2 = fdb_baseHero.skilldesc_3 or ""
  text2 = ReplaceStringTab(text2)
  self.pasSkillDes:setString(text2 or "")
  self:SetEquItem(heroInfo)
end
function prototype:refreshArmor()
  local armors = Logic:Get("HeroCardInfo"):GetHeroArmorsVo() or {}
  for i = 1, #armors do
    if armors[i].position == 1 then
      self.ccbArmor1:refresh(armors[i].baseId)
    elseif armors[i].position == 2 then
      self.ccbArmor2:refresh(armors[i].baseId)
    end
  end
end
function prototype:refreshBridle(baseId)
  if not baseId then
    return
  end
  local infoSet = Logic:Get("Armor"):GetHeroBridles(baseId) or {}
  local num = infoSet.count < 4 and infoSet.count or 4
  for i = 1, num do
    local strccb = string.format("bridle%d", i)
    if self[strccb] then
      local info = {}
      info.armorBaseId1 = infoSet.baseIds1[i]
      info.armorBaseId2 = infoSet.baseIds2[i]
      info.bridle = infoSet.bridles[i]
      info.index = i
      self[strccb]:refresh(info)
    end
  end
  for i = num + 1, 4 do
    local strccb = string.format("bridle%d", i)
    if self[strccb] then
      self[strccb]:setVisible(false)
    end
  end
  local ITEM_HEIGHT = 118
  local decY = (4 - num) * ITEM_HEIGHT
  if num == 0 then
    self.nodeMid:setVisible(false)
    decY = decY + 60
  end
  self:DecNodePosition(decY)
end
function prototype:DecNodePosition(decY)
  if not decY then
    return
  end
  decY = decY - self.comboHeight
  local poxY = self.nodeUp:getPositionY()
  self.nodeUp:setPositionY(poxY - decY)
  poxY = self.nodeMid:getPositionY()
  self.nodeMid:setPositionY(poxY - decY - self.comboHeight)
  self.sprBridleBg:setAnchorPoint(ccp(0.5, 1))
  local size = self.sprBridleBg:getContentSize()
  self.sprBridleBg:setContentSize(CCSizeMake(size.width, size.height - decY - self.comboHeight))
  size = self.layer:getContentSize()
  self.layer:setContentSize(CCSizeMake(size.width, size.height - decY))
end
function prototype:refreshCombination(fdb_baseHero)
  if not fdb_baseHero then
    return
  end
  local comDesc = fdb_baseHero.comDesc
  self.comboHeight = 0
  if not comDesc or comDesc == "" then
    return
  end
  self.ttfComboDesc:setDimensions(CCSizeMake(550, 0))
  self.ttfComboDesc:setString(ReplaceStringTab(comDesc))
  self.ritComName:setString(fdb_baseHero.comName, kCCLabelTTFStyleSimple)
  self.nodeCombo:setVisible(true)
  local height = 140
  self.comboHeight = height
end
function prototype:createPro(baseId)
  local card = self.layer:getChildByTag(96)
  if card ~= nil then
    self.layer:removeChildByTag(96, true)
  end
  local str = Logic:Get("Hero"):GetHeroProfessionImage(baseId)
  local ccSprite = CCSprite:create(str)
  self.nodeUp:addChild(ccSprite, 0, 96)
  ccSprite:setPosition(self.sprDepartment:getPosition())
end
function prototype:createPhyle(baseId)
  local card = self.layer:getChildByTag(98)
  if card ~= nil then
    self.layer:removeChildByTag(98, true)
  end
  local card = self.layer:getChildByTag(80)
  if card ~= nil then
    self.layer:removeChildByTag(80, true)
  end
  local str = Logic:Get("HeroCardInfo"):GetHeroPhyleStr(baseId)
  local ccSprite = CCSprite:create(str)
  self.nodeUp:addChild(ccSprite, 0, 98)
  ccSprite:setAnchorPoint(CCPoint(0.5, 0.5))
  ccSprite:setPosition(self.phyle:getPosition())
end
function prototype:createSex(baseId)
  local card = self.layer:getChildByTag(97)
  if card ~= nil then
    self.layer:removeChildByTag(97, true)
  end
  local str = Logic:Get("HeroCardInfo"):GetHeroSexStr(baseId)
  local ccSprite = CCSprite:create(str)
  self.nodeUp:addChild(ccSprite, 0, 97)
  ccSprite:setAnchorPoint(CCPoint(0, 0.5))
  ccSprite:setPosition(self.sex:getPosition())
end
function prototype:createHeroCard(baseId, fra)
  local card = self.layer:getChildByTag(2)
  if card ~= nil then
    self.layer:removeChildByTag(2, true)
  end
  if baseId == nil then
    return
  end
  local node = Logic:Get("HeroCardInfo"):createHeroCard(baseId, CARD_SIZE_WIDTH, fra, nil, nil, true)
  if node == nil then
    return
  end
  local cardSz = node:getContentSize()
  node:setScale(1 * (CARD_SIZE_WIDTH / cardSz.width))
  node:setAnchorPoint(CCPoint(0.5, 0.5))
  self.nodeUp:addChild(node, 0, 2)
  node:setPosition(self.herohead:getPosition())
end
function prototype:createCompose()
  local compose = Logic:Get("HeroCardInfo"):GetCompose(CARD_SIZE_WIDTH)
  local cardSz = compose:getContentSize()
  compose:setScale(1 * (CARD_SIZE_WIDTH / cardSz.width))
  compose:setAnchorPoint(CCPoint(0.5, 0.5))
  self.nodeUp:addChild(compose)
  compose:setPosition(self.herohead:getPosition())
end
function prototype:createSkill(init, round)
  if init == nil or round == nil then
    return
  end
  local lvl = CCSpriteBatchNode:create("data/HeroCardInfo/90.png")
  if lvl == nil then
    return
  end
  self.nodeUp:addChild(lvl, 0, 0)
  for i = 1, round do
    if i == init then
      local initSkill = CCSprite:create("data/HeroCardInfo/91.png")
      self.nodeUp:addChild(initSkill)
      initSkill:setAnchorPoint(CCPoint(0.5, 0.8))
      initSkill:setPosition(CCPoint(self.sprSkillLVl:getPositionX() + (initSkill:getContentSize().width + 5) * (i - 1), self.sprSkillLVl:getPositionY()))
    else
      local skillD = CCSprite:createWithTexture(lvl:getTexture())
      lvl:addChild(skillD)
      skillD:setAnchorPoint(CCPoint(0.5, 0.8))
      skillD:setPosition(CCPoint(self.sprSkillLVl:getPositionX() + (skillD:getContentSize().width + 5) * (i - 1), self.sprSkillLVl:getPositionY()))
    end
  end
end
function prototype:createStar(num)
  local strUp, strDown = "*", ""
  if num ~= 0 then
    for i = 2, num do
      if i <= 6 then
        strUp = strUp .. "*"
      else
        strDown = strDown .. "*"
      end
    end
  end
  self.starIbm1:setString(strUp)
  self.starIbm2:setString(strDown)
end
function prototype:SetEquItem(heroInfo)
  if heroInfo == nil or heroInfo.id == nil then
    return
  end
  local Talismans = Logic:Get("HeroCardInfo"):GetHeroTalismanVo()
  if Talismans == nil or Talismans[1] == nil then
    return
  end
  for i = 1, 2 do
    local updateFabao = Talismans[i]
    if updateFabao and updateFabao.baseId then
      local rec = KFDBGetRecord("TalismanSetting", updateFabao.baseId)
      if rec ~= nil and rec.baseId ~= nil then
        local pathIcon = Logic:Get("Hero"):GetHeroImage(rec.baseId)
        if pathIcon then
          local spriteIcon = CCSprite:create(pathIcon)
          if spriteIcon then
            local str = string.format("euq_img_%d", rec.position)
            self[str]:setDisplayFrame(spriteIcon:displayFrame())
          end
        end
      end
      local rec = KFDBGetRecord("TalismanSetting", updateFabao.baseId)
      local fdb_baseHero = Logic:Get("HeroCardInfo"):kdbBaseHero(rec.baseId)
      if tonumber(fdb_baseHero.rank) == 0 then
        fdb_baseHero.rank = 1
      end
      local spr = Logic:Get("Compose"):GetItemsFrame(tonumber(fdb_baseHero.rank))
      local strbg = string.format("eup_bg_%d", rec.position)
      self[strbg]:setDisplayFrame(spr:displayFrame())
    end
  end
end
function prototype:onBtnFabaoL(sender, event)
  local talisman = self:getTalismanInfoByPosition(2)
  if talisman == nil then
    return
  end
  Logic:Get("HeroCardInfo"):OpenTailsman(talisman)
end
function prototype:onBtnFabaoR(sender, event)
  local talisman = self:getTalismanInfoByPosition(1)
  if talisman == nil then
    return
  end
  Logic:Get("HeroCardInfo"):OpenTailsman(talisman)
end
function prototype:getTalismanInfoByPosition(position)
  local Talismans = Logic:Get("HeroCardInfo"):GetHeroTalismanVo()
  local talisman
  for i, v in ipairs(Talismans or {}) do
    local rec = KFDBGetRecord("TalismanSetting", v.baseId)
    if rec and rec.position == position then
      talisman = v
    end
  end
  return talisman
end
function prototype:addLock(btnNode, tag, sprPath)
  if btnNode and tag then
    local lockChild = btnNode:getChildByTag(tag)
    if lockChild ~= nil then
      return
    end
    local sprLock = sprPath and CCSprite:create(sprPath) or CCSprite:create(HERO_LOCK_PATH)
    if nil == sprLock then
      return
    end
    sprLock:setAnchorPoint(CCPoint(0.5, 0.5))
    local x = btnNode:getContentSize().width / 2
    local y = btnNode:getContentSize().height / 2
    sprLock:setPosition(ccp(x, y))
    btnNode:addChild(sprLock, 10, tag)
  end
end
function prototype:StaLock()
  self.fabaoStatus_open = Logic:Get("Lock"):GetStatusByLockId(Logic.Lock.LOCK_ID.TALISMAN)
  self:onFabaoLock_Open(self.fabaoStatus_open)
  self.fabaoStatus = Logic:Get("Lock"):GetStatusByLockId(Logic.Lock.LOCK_ID.TALISMAN_EQUIP_2_LOCK)
  self:onFabaoLock(self.fabaoStatus)
end
function prototype:onFabaoLock_Open(isLock)
  if isLock then
    self:addLock(self.btnFabaoR, 90, HERO_LOCK_PATH)
  else
    self:removeLock(self.btnFabaoR, 90)
  end
end
function prototype:onFabaoLock(isLock)
  if isLock then
    self:addLock(self.btnFabaoL, 90, HERO_LOCK_PATH)
  else
    self:removeLock(self.btnFabaoL, 90)
  end
end
function prototype:removeLock(btnNode, tag)
  if btnNode and tag then
    local lockChild = btnNode:getChildByTag(tag)
    if lockChild ~= nil then
      btnNode:removeChildByTag(tag, true)
    end
  end
end
function prototype:showTip(isLock, event)
  if isLock then
    if event == CCControlEventTouchDown then
      local level, copyName = Logic:Get("Lock"):GetOpenLevelAndBattle(Logic.Lock.LOCK_ID.TALISMAN_EQUIP_2_LOCK)
      self:showLockTip(level, copyName)
    end
    self:closeLockTip(event)
    return
  end
end
function prototype:showTip_Open(isLock, event)
  if isLock then
    if event == CCControlEventTouchDown then
      local level, copyName = Logic:Get("Lock"):GetOpenLevelAndBattle(Logic.Lock.LOCK_ID.TALISMAN)
      self:showLockTip(level, copyName)
    end
    self:closeLockTip(event)
    return
  end
end
function prototype:showLockTip(level, copyName)
  if nil ~= copyName and "" ~= copyName then
    local str = TwGetStr(105403, level) .. "\n" .. TwGetStr(105401, copyName)
    Prompt:PopTip(str)
  else
    Prompt:PopTip(TwGetStr(105402, level))
  end
end
function prototype:closeLockTip(event)
  if event == CCControlEventTouchUpOutside or event == CCControlEventTouchUpInside or event == CCControlEventTouchCancel then
    Logic:Get("SureConfirm"):FireEvent(Logic.SureConfirm.EVT.CLOSE_POPTIP)
  end
end
