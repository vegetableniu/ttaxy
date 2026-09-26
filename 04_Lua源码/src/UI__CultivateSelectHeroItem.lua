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
    self.staName:setStyle(kCCLabelTTFStyleOutline)
    self.staName:setString(info.name)
  end
  self.imgLvTip:setVisible(true)
  self.staLevel:create(0, "YELLOW_E_NUM")
  self.staLevel:setAlign("LEFT", "TOP")
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
  local bundaryInfo = KFDBGetRecord("CultivateState", hero.bundary)
  self.ttfBoundary:setString(bundaryInfo.name)
  self.ttfBoundary:setStyle(kCCLabelTTFStyleOutline)
  local selectHero = Logic:Get("Cultivate"):getSelectHero()
  if selectHero and selectHero.id == hero.id then
    local frame = CCSprite:create("images/public/selcet2.png")
    if frame then
      self.imgSelect:setDisplayFrame(frame:displayFrame())
    end
  else
    local frame = CCSprite:create("images/public/selcet1.png")
    if frame then
      self.imgSelect:setDisplayFrame(frame:displayFrame())
    end
  end
  for i = 1, 5 do
    local ccb = string.format("ccb%d", i)
    if self[ccb] then
      self[ccb]:refreshMedicineInfo(nil)
    end
  end
  if hero.isRebuild then
    self.sprTip:setVisible(false)
    self.nodeAttr:setVisible(true)
    return
  end
  self.sprTip:setVisible(true)
  self.nodeAttr:setVisible(false)
  if hero.isMax then
    self.sprTip:setVisible(false)
    return
  end
  for k, v in pairs(hero.elixirs) do
    local ccb = string.format("ccb%d", v.position)
    if self[ccb] then
      self[ccb]:refreshMedicineInfo(v)
    end
  end
  local frame
  if hero.canCross then
    frame = CCSprite:create("images/Cultivate/font_cross.png")
    if frame then
      self.sprTip:setDisplayFrame(frame:displayFrame())
    end
    return
  end
  if hero.canSwallow then
    frame = CCSprite:create("images/Cultivate/font_swallow.png")
    if frame then
      self.sprTip:setDisplayFrame(frame:displayFrame())
    end
    return
  end
  if hero.canCompose then
    frame = CCSprite:create("images/Cultivate/font_compose.png")
    if frame then
      self.sprTip:setDisplayFrame(frame:displayFrame())
    end
    return
  end
  self.sprTip:setVisible(false)
end
function prototype:onHeroImage()
  Logic:Get("HeroCardInfo"):OpenHeroInfo(self.hero, Logic.HeroCardInfo.eType.PROTECT)
end
function prototype:onBtnSelectHero()
  Logic:Get("Cultivate"):setSelectHero(self.hero)
  Logic:Get("Cultivate"):FireEvent(Logic.Cultivate.EVT.SELECT_HERO)
end
