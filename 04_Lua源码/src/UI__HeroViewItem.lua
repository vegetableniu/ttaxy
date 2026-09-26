module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
require("SceneHelper")
function prototype:RefreshHeros(hero)
  if not hero then
    return
  end
  self.hero = hero
  local cardType = Logic:Get("Hero"):GetCardTypeById(hero.id)
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
  local info = Logic:Get("Hero"):GetHeroInfoByBaseId(hero.baseId)
  if info then
    self.staName:setString(info.name)
  end
  self.imgLock:setVisible(hero.locked or false)
  self:ShowByIsHero(cardType == "HERO")
  if cardType == "HERO" then
    self.imgLvTip:setVisible(true)
    self.staLevel:create(0, "YELLOW_E_NUM")
    self.staLevel:setAlign("CENTER", "CENTER")
    self.staLevel:setValue(hero.level or 1)
    local nLife, nAttack = Logic:Get("Hero"):GetHeroLifeAndAttack(hero.baseId, hero.level)
    if nLife and nAttack then
      self.staLife:setStyle(kCCLabelTTFStyleOutline)
      self.staAttack:setStyle(kCCLabelTTFStyleOutline)
      self.staLife:setString(tostring(nLife))
      self.staAttack:setString(tostring(nAttack))
    end
    local _, strStar = Logic:Get("Hero"):GetHeroBgImage(hero.baseId)
    if strStar then
      local sprite = CCSprite:create(strStar)
      if sprite then
        self.imgStar:setDisplayFrame(sprite:displayFrame())
      end
    end
    local strTypeBg = Logic:Get("HeroCardInfo"):GetRaceBg(hero.baseId, true)
    if strTypeBg then
      local spriteTypeBg = CCSprite:create(strTypeBg)
      if spriteTypeBg then
        self.imgHeroTypeBg:setDisplayFrame(spriteTypeBg:displayFrame())
      end
    end
    local strType = Logic:Get("HeroCardInfo"):GetHeroPhyleStr(hero.baseId, Logic.HeroCardInfo.HERO_RACE.BIG)
    if strType then
      local spriteType = CCSprite:create(strType)
      if spriteType then
        self.imgHeroType:setDisplayFrame(spriteType:displayFrame())
      end
    end
    if Logic:Get("Cultivate"):canCultivateByBaseId(hero.baseId) then
      local bundary = Logic:Get("Cultivate"):getCutivateStateById(hero.id)
      local bundaryName = Logic:Get("Cultivate"):GetStateName(bundary) or ""
      self.sprBundary:setVisible(true)
      self.ttfBundary:setStyle(kCCLabelTTFStyleOutline)
      self.ttfBundary:setString(bundaryName)
    else
      self.sprBundary:setVisible(false)
      self.ttfBundary:setString("")
    end
  else
    self.imgLvTip:setVisible(false)
    local strType = Logic:Get("Hero"):GetImageByType(cardType)
    if strType then
      local frame = CCSprite:create(strType)
      if frame then
        self.imgType:setDisplayFrame(frame:displayFrame())
      end
    end
    self.sprBundary:setVisible(false)
    self.ttfBundary:setString("")
  end
end
function prototype:ShowByIsHero(bHero)
  self.staLevel:setVisible(bHero)
  self.imgHeart:setVisible(bHero)
  self.imgSword:setVisible(bHero)
  self.imgStar:setVisible(bHero)
  self.staAttack:setVisible(bHero)
  self.staLife:setVisible(bHero)
  self.imgType:setVisible(not bHero)
  self.imgHeroType:setVisible(bHero)
  self.imgHeroTypeBg:setVisible(bHero)
end
function prototype:onHeroImage()
  Logic:Get("HeroCardInfo"):OpenHeroInfo(self.hero, Logic.HeroCardInfo.eType.PROTECT)
end
