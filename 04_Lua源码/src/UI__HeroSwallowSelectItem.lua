require("SceneHelper")
require("Guide.LevelUp")
module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
function prototype:RefreshHeros(hero)
  if not hero then
    return
  end
  self.hero = hero
  self.staExpTip:setString(TwGetStr(104272))
  self.staExpTip:setStyle(kCCLabelTTFStyleOutline)
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
  self.staLevel:create(0, "YELLOW_E_NUM")
  self.staLevel:setAlign("CENTER", "CENTER")
  self.staLevel:setValue(hero.level or 1)
  local info = Logic:Get("Hero"):GetHeroInfoByBaseId(hero.baseId)
  if info then
    self.staName:setString(info.name)
  end
  local cardType = Logic:Get("Hero"):GetCardTypeById(hero.id)
  self:ShowByIsHero(cardType == "HERO")
  if cardType ~= "HERO" then
    local strType = Logic:Get("Hero"):GetImageByType(cardType)
    local frame = CCSprite:create(strType)
    if frame then
      self.imgType:setDisplayFrame(frame:displayFrame())
    end
  end
  local nLife, nAttack = Logic:Get("Hero"):GetHeroLifeAndAttack(hero.baseId, hero.level)
  if nLife and nAttack then
    self.staLife:setStyle(kCCLabelTTFStyleOutline)
    self.staAttack:setStyle(kCCLabelTTFStyleOutline)
    self.staLife:setString(tostring(nLife))
    self.staAttack:setString(tostring(nAttack))
  end
  local exp = Logic:Get("Hero"):GetHeroSwallowExp(self.hero.baseId, self.hero.level)
  if exp then
    self.staExp:setStyle(kCCLabelTTFStyleOutline)
    self.staExp:setString(tostring(exp))
  end
  local upgradeHeroId = Logic:Get("Hero"):GetUpgradeHero()
  local upgradeHero = Logic:Get("Hero"):GetHeroInfoById(upgradeHeroId)
  if upgradeHero and upgradeHero.id == self.hero.id then
    self.btnSelect:setEnabled(false)
    local frame = CCSprite:create("images/public/selcet3.png")
    if frame then
      self.imgSelect:setDisplayFrame(frame:displayFrame())
    end
    return
  end
  local swallowHero = Logic:Get("Hero"):GetTempHero()
  if not swallowHero then
    return
  end
  self.bSwallow = false
  if swallowHero[hero.id] then
    self.bSwallow = true
    local frame = CCSprite:create("images/public/selcet2.png")
    if frame then
      self.imgSelect:setDisplayFrame(frame:displayFrame())
    end
    self.btnSelect:setEnabled(true)
  else
    self.bSwallow = false
    local frame = CCSprite:create("images/public/selcet1.png")
    if frame then
      self.imgSelect:setDisplayFrame(frame:displayFrame())
    end
    self.btnSelect:setEnabled(table.size(swallowHero) < 6)
  end
end
function prototype:ShowByIsHero(bHero)
  self.imgLvTip:setVisible(bHero)
  self.imgType:setVisible(not bHero)
  self.staLevel:setVisible(bHero)
  self.imgHeart:setVisible(bHero)
  self.imgSword:setVisible(bHero)
  self.staAttack:setVisible(bHero)
  self.staLife:setVisible(bHero)
end
function prototype:onHeroImage()
  Logic:Get("HeroCardInfo"):OpenHeroInfo(self.hero)
end
function prototype:onBtnSelect()
  self.btnHero:setEnabled(true)
  if Logic:Get("Guide"):isActive("LevelUp", "SelectMaterial") then
    Logic:Get("Main"):CuMengMainGuide("LevelUp", "SelectMaterial")
    Logic:Get("Guide"):done("LevelUp", "SelectMaterial")
  elseif Logic:Get("Guide"):isActive("LevelUp", "SelectMaterial2") then
    Logic:Get("Main"):CuMengMainGuide("LevelUp", "SelectMaterial2")
    Logic:Get("Guide"):done("LevelUp", "SelectMaterial2")
  elseif Logic:Get("Guide"):isActive("LevelUp", "SelectMaterial3") then
    Logic:Get("Main"):CuMengMainGuide("LevelUp", "SelectMaterial3")
    Logic:Get("Guide"):done("LevelUp", "SelectMaterial3")
  elseif Logic:Get("Guide"):isActive("LevelUp", "SelectMaterial4") then
    Logic:Get("Main"):CuMengMainGuide("LevelUp", "SelectMaterial4")
    Logic:Get("Guide"):done("LevelUp", "SelectMaterial4")
  elseif Logic:Get("Guide"):isActive("LevelUp", "SelectMaterial5") then
    Logic:Get("Main"):CuMengMainGuide("LevelUp", "SelectMaterial5")
    Logic:Get("Guide"):done("LevelUp", "SelectMaterial5")
  end
  Logic:Get("Guide"):done("FightLevelUp", "SelectMaterial")
  if not self.hero then
    return
  end
  if self.bSwallow then
    local frame = CCSprite:create("images/public/selcet1.png")
    if frame then
      self.imgSelect:setDisplayFrame(frame:displayFrame())
    end
    self.bSwallow = false
    Logic:Get("Hero"):RemoveSwallowHero(self.hero.id)
  else
    local frame = CCSprite:create("images/public/selcet2.png")
    if frame then
      self.imgSelect:setDisplayFrame(frame:displayFrame())
    end
    self.bSwallow = true
    Logic:Get("Hero"):AddSwallowHero(self.hero.id)
  end
end
function prototype:updateGuide()
  if Logic:Get("Guide"):isActive("LevelUp", "SelectMaterial") then
    self.btnHero:setEnabled(false)
    Logic:Get("Guide"):lockTouch(self.btnSelect)
  end
  if Logic:Get("Guide"):isActive("LevelUp", "SelectMaterial2") then
    self.btnHero:setEnabled(false)
    Logic:Get("Guide"):lockTouch(self.btnSelect)
  end
  if Logic:Get("Guide"):isActive("LevelUp", "SelectMaterial3") then
    self.btnHero:setEnabled(false)
    Logic:Get("Guide"):lockTouch(self.btnSelect)
  end
  if Logic:Get("Guide"):isActive("LevelUp", "SelectMaterial4") then
    self.btnHero:setEnabled(false)
    Logic:Get("Guide"):lockTouch(self.btnSelect)
  end
  if Logic:Get("Guide"):isActive("LevelUp", "SelectMaterial5") then
    self.btnHero:setEnabled(false)
    Logic:Get("Guide"):lockTouch(self.btnSelect)
  end
  if Logic:Get("Guide"):isActive("FightLevelUp", "SelectMaterial") then
    self.btnHero:setEnabled(false)
    Logic:Get("Guide"):lockTouch(self.btnSelect)
  end
end
