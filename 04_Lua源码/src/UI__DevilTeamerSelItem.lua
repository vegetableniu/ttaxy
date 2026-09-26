module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
require("SceneHelper")
local MAX_MEMBER = 4
function prototype:RefreshHeros(type, hero)
  if not hero then
    return
  end
  self.type = type
  self.hero = hero
  local group = Logic:Get("Devil"):GetChangeGroup()
  self.leaderId = group.heros.leaderId
  self:HeroInfo(hero)
  if type == Logic.Hero.EVT.LEADER_CHANGE then
    self.imgCanSelect:setVisible(true)
    self.staBattle:setVisible(false)
    self.staSkillName:setVisible(false)
    self.staCanSelect:setVisible(false)
    local skillInfo = Logic:Get("Hero"):GetSkillInfoById(hero.baseId)
    if not skillInfo then
      self.staSkillName:setString("")
    else
      self.staSkillName:setString(skillInfo.skillname or "")
    end
    self.staSkillName:setColor(ccColor3B(255, 255, 255))
    self.btnSelect:setBackgroundSpriteForState(CCScale9Sprite:create("images/public/btnHeroFrameNormal.png"), CCControlStateNormal)
    self.btnSelect:setBackgroundSpriteForState(CCScale9Sprite:create("images/public/btnHeroFrameSelect.png"), CCControlStateHighlighted)
    self.btnSelect:setBackgroundSpriteForState(CCScale9Sprite:create("images/public/btnHeroFrameDisable.png"), CCControlStateDisabled)
    self.btnSelect:setEnabled(true)
    if hero.id == self.leaderId then
      self.btnSelect:setEnabled(false)
      self.btnSelect:setBackgroundSpriteForState(CCScale9Sprite:create("images/public/btnLeaderFrameSelect.png"), CCControlStateNormal)
      self.btnSelect:setBackgroundSpriteForState(CCScale9Sprite:create("images/public/btnLeaderFrameSelect.png"), CCControlStateHighlighted)
      self.btnSelect:setBackgroundSpriteForState(CCScale9Sprite:create("images/public/btnLeaderFrameSelect.png"), CCControlStateDisabled)
      local frame = CCSprite:create("images/public/selcet2.png")
      if frame then
        self.imgCanSelect:setDisplayFrame(frame:displayFrame())
      end
      return
    end
    local frame = CCSprite:create("images/public/selcet1.png")
    if frame then
      self.imgCanSelect:setDisplayFrame(frame:displayFrame())
    end
    local bTeamer = Logic:Get("Devil"):CheckGroupHeroState(hero.id)
    if bTeamer then
      self.btnSelect:setEnabled(true)
      self.staSkillName:setVisible(false)
    else
      local totalship = Logic:Get("Hero"):GetLeadership()
      local currentship = Logic:Get("Devil"):GetGroupLeadership()
      local validship = 0
      if currentship > 0 then
        local leader = Logic:Get("Hero"):GetHeroInfoById(self.leaderId)
        if not leader or not leader.baseId then
          return
        end
        local leaderInfo = Logic:Get("Hero"):GetHeroInfoByBaseId(leader.baseId)
        if not leaderInfo then
          return
        end
        validship = leaderInfo.leadership
      end
      local itemInfo = Logic:Get("Hero"):GetHeroInfoByBaseId(hero.baseId)
      if not itemInfo then
        return
      end
      local itemship = itemInfo.leadership
      if itemship > totalship - currentship + validship then
        self.btnSelect:setEnabled(false)
        self.staSkillName:setVisible(true)
        self.staSkillName:setString(TwGetStr(104170))
        self.staSkillName:setColor(ccColor3B(255, 0, 0))
      end
      local teamer = Logic:Get("Hero"):GetAllFightHero()
      local result = false
      local mutexCnt = 0
      for _, id in pairs(teamer) do
        if id ~= self.leaderId then
          result = Logic:Get("Hero"):checkLuckyHeroById(id, self.hero.baseId)
          if result then
            mutexCnt = mutexCnt + 1
          end
        end
      end
      if mutexCnt > 0 then
        local rec = Logic:Get("Hero"):GetHeroInfoByBaseId(self.hero.baseId)
        if rec and mutexCnt >= rec.limits then
          self:LuckyHeroDesc()
          return
        end
      end
    end
  elseif type == Logic.Hero.EVT.HERO_CURRENT then
    self.staSkillName:setVisible(true)
    self.staCanSelect:setVisible(false)
    self.staBattle:setVisible(Logic:Get("Devil"):CheckGroupHeroState(hero.id))
    self.staBattle:setStyle(kCCLabelTTFStyleOutline)
    self.staBattle:setString(TwGetStr(104171))
    self.btnSelect:setBackgroundSpriteForState(CCScale9Sprite:create("images/public/btnHeroFrameNormal.png"), CCControlStateNormal)
    self.btnSelect:setBackgroundSpriteForState(CCScale9Sprite:create("images/public/btnHeroFrameSelect.png"), CCControlStateHighlighted)
    self.btnSelect:setBackgroundSpriteForState(CCScale9Sprite:create("images/public/btnHeroFrameDisable.png"), CCControlStateDisabled)
    local allHeros = Logic:Get("Hero"):GetAllHeroInfo()
    if self.hero.id == self.leaderId then
      self.staSkillName:setVisible(false)
      self.btnSelect:setEnabled(false)
      local frame = CCSprite:create("images/public/selcet3.png")
      if frame then
        self.imgCanSelect:setDisplayFrame(frame:displayFrame())
      end
      self.btnSelect:setBackgroundSpriteForState(CCScale9Sprite:create("images/public/btnLeaderFrameSelect.png"), CCControlStateNormal)
      self.btnSelect:setBackgroundSpriteForState(CCScale9Sprite:create("images/public/btnLeaderFrameSelect.png"), CCControlStateHighlighted)
      self.btnSelect:setBackgroundSpriteForState(CCScale9Sprite:create("images/public/btnLeaderFrameSelect.png"), CCControlStateDisabled)
      return
    end
    local teamer = Logic:Get("Devil"):GetGroupTeamerHero()
    if teamer[hero.id] then
      self.bTeamer = true
      self.btnSelect:setEnabled(true)
      local frame = CCSprite:create("images/public/selcet2.png")
      if frame then
        self.imgCanSelect:setDisplayFrame(frame:displayFrame())
      end
      self.staSkillName:setVisible(false)
      return
    end
    self.bTeamer = false
    local totalship = Logic:Get("Hero"):GetLeadership()
    local nCurrentPoints = Logic:Get("Devil"):GetGroupLeadership()
    local itemInfo = Logic:Get("Hero"):GetHeroInfoByBaseId(hero.baseId)
    if itemInfo then
      local itemship = itemInfo.leadership
      if itemship and itemship > totalship - nCurrentPoints then
        self.btnSelect:setEnabled(false)
        self.staSkillName:setVisible(true)
        self.staSkillName:setString(TwGetStr(104170))
        self.staSkillName:setColor(ccColor3B(255, 0, 0))
        self.staBattle:setVisible(false)
        local frame = CCSprite:create("images/public/selcet3.png")
        if frame then
          self.imgCanSelect:setDisplayFrame(frame:displayFrame())
        end
        return
      end
    end
    if Logic:Get("Hero"):checkCurrGroupMutex(hero.baseId, false) then
      self:LuckyHeroDesc()
      return
    end
    self.staSkillName:setVisible(false)
    local teamer = Logic:Get("Devil"):GetGroupTeamerHero()
    if not teamer then
      return
    end
    local num = 0
    for _, _ in pairs(teamer) do
      num = num + 1
    end
    self.fourthStatus = Logic:Get("Lock"):GetStatusByLockId(Logic.Lock.LOCK_ID.FOURTH_HERO)
    self.fifthStatus = Logic:Get("Lock"):GetStatusByLockId(Logic.Lock.LOCK_ID.FIFTH_HERO)
    if self.fourthStatus then
      MAX_MEMBER = 2
    elseif self.fifthStatus then
      MAX_MEMBER = 3
    else
      MAX_MEMBER = 4
    end
    if num < MAX_MEMBER then
      self.btnSelect:setEnabled(true)
      local frame = CCSprite:create("images/public/selcet1.png")
      if frame then
        self.imgCanSelect:setDisplayFrame(frame:displayFrame())
      end
    else
      self.btnSelect:setEnabled(false)
      local frame = CCSprite:create("images/public/selcet3.png")
      if frame then
        self.imgCanSelect:setDisplayFrame(frame:displayFrame())
      end
    end
  end
end
function prototype:LuckyHeroDesc()
  self.btnSelect:setEnabled(false)
  self.staSkillName:setStyle(kCCLabelTTFStyleOutline)
  self.staSkillName:setVisible(true)
  self.staSkillName:setString(TwGetStr(105571))
  self.staSkillName:setColor(ccColor3B(255, 0, 0))
  self.staBattle:setVisible(false)
  local frame = CCSprite:create("images/public/selcet3.png")
  if frame then
    self.imgCanSelect:setDisplayFrame(frame:displayFrame())
  end
end
function prototype:LuckyHeroInfo()
  local mutexCnt = 0
  local teamer = Logic:Get("Hero"):GetAllFightHero()
  for _, id in pairs(teamer) do
    local result = Logic:Get("Hero"):checkLuckyHeroById(id, self.hero.baseId)
    if result then
      mutexCnt = mutexCnt + 1
    end
  end
  if mutexCnt > 0 then
    local rec = Logic:Get("Hero"):GetHeroInfoByBaseId(self.hero.baseId)
    if rec then
      return mutexCnt >= rec.limits
    end
  end
  return false
end
function prototype:HeroInfo(hero)
  self.staLeaderTip:setString(TwGetStr(104268))
  self.staCanSelect:setString(TwGetStr(104269))
  local strPath = Logic:Get("Hero"):GetHeroImage(hero.baseId)
  if strPath then
    self.btnHero:setBackgroundSpriteForState(CCScale9Sprite:create(strPath), CCControlStateNormal)
    self.btnHero:setBackgroundSpriteForState(CCScale9Sprite:create(strPath), CCControlStateHighlighted)
    self.btnHero:setBackgroundSpriteForState(CCScale9Sprite:create(strPath), CCControlStateDisabled)
  end
  local strBg = Logic:Get("Hero"):GetHeroBgImage(hero.baseId)
  if strBg then
    self.btnBg:setBackgroundSpriteForState(CCScale9Sprite:create(strBg), CCControlStateNormal)
    self.btnBg:setBackgroundSpriteForState(CCScale9Sprite:create(strBg), CCControlStateHighlighted)
    self.btnBg:setBackgroundSpriteForState(CCScale9Sprite:create(strBg), CCControlStateDisabled)
  end
  Logic:Get("HeroCardInfo"):AddShanCardSmall(self.btnHero, hero.baseId)
  local strTypeBg = Logic:Get("HeroCardInfo"):GetRaceBg(hero.baseId, true)
  if strTypeBg then
    local spriteTypeBg = CCSprite:create(strTypeBg)
    if spriteTypeBg then
      self.imgTypeBg:setDisplayFrame(spriteTypeBg:displayFrame())
    end
  end
  local strType = Logic:Get("HeroCardInfo"):GetHeroPhyleStr(hero.baseId, Logic.HeroCardInfo.HERO_RACE.BIG)
  if strType then
    local spriteType = CCSprite:create(strType)
    if spriteType then
      self.imgType:setDisplayFrame(spriteType:displayFrame())
    end
  end
  if hero.level then
    self.staLevel:create(0, "YELLOW_E_NUM")
    self.staLevel:setAlign("CENTER", "CENTER")
    self.staLevel:setValue(hero.level)
  end
  local info = Logic:Get("Hero"):GetHeroInfoByBaseId(hero.baseId)
  if info then
    self.staName:setString(info.name or "")
    self.staNeedPoint:setStyle(kCCLabelTTFStyleOutline)
    self.staNeedPoint:setString(info.leadership or 0)
  end
  if hero.id ~= self.leaderId then
    self.staLife:setColor(ccColor3B(255, 255, 255))
    self.staAttack:setColor(ccColor3B(255, 255, 255))
    local nLife, nAttack = Logic:Get("Hero"):GetHeroLifeAndAttack(hero.baseId, hero.level)
    if nLife and nAttack then
      self.staLife:setStyle(kCCLabelTTFStyleOutline)
      self.staAttack:setStyle(kCCLabelTTFStyleOutline)
      self.staLife:setString(tostring(nLife))
      self.staAttack:setString(tostring(nAttack))
    end
  else
    self.staLife:setColor(ccColor3B(66, 255, 0))
    self.staAttack:setColor(ccColor3B(66, 255, 0))
    local nLife, nAttack = Logic:Get("Hero"):GetHeroLifeAndAttack(hero.baseId, hero.level)
    if nLife and nAttack then
      nLife = math.modf(nLife + nLife * 0.1)
      nAttack = math.modf(nAttack + nAttack * 0.1)
      self.staLife:setStyle(kCCLabelTTFStyleOutline)
      self.staAttack:setStyle(kCCLabelTTFStyleOutline)
      self.staLife:setString(tostring(nLife))
      self.staAttack:setString(tostring(nAttack))
    end
  end
  self.staLeaderTip:setStyle(kCCLabelTTFStyleOutline)
end
function prototype:onHeroImage()
  Logic:Get("HeroCardInfo"):OpenHeroInfo(self.hero)
end
function prototype:onBtnSelect()
  self.btnHero:setEnabled(true)
  if self.type == Logic.Hero.EVT.LEADER_CHANGE then
    local data = Logic:Get("Devil"):GetChangeGroup()
    if data.heros.groupId == 1 then
      Logic:Get("Hero"):SetCurrentLeaderTag(true)
    else
      Logic:Get("Hero"):SetCurrentLeaderTag(false)
    end
    Logic:Get("Hero"):SetSelectIndex(data.heros.groupId)
    Logic:Get("Hero"):PostChangeLeader(data.heros.groupId, self.hero.id)
  elseif self.type == Logic.Hero.EVT.HERO_CURRENT then
    if self.bTeamer then
      local frame = CCSprite:create("images/public/selcet1.png")
      if frame then
        self.imgCanSelect:setDisplayFrame(frame:displayFrame())
      end
      self.bTeamer = false
      Logic:Get("Hero"):RemoveHeroFromCopy(self.hero.id)
      Logic:Get("Devil"):RemoveGroupTeamerHero(self.hero.id)
    else
      local frame = CCSprite:create("images/public/selcet2.png")
      if frame then
        self.imgCanSelect:setDisplayFrame(frame:displayFrame())
      end
      self.bTeamer = true
      Logic:Get("Hero"):AddHeroToCopy(self.hero.id)
      Logic:Get("Devil"):AddGroupTeamerHero(self.hero.id)
    end
    Logic:Get("Hero"):FireEvent(Logic.Hero.EVT.OPT_TEAMER_SELECT)
  end
end
