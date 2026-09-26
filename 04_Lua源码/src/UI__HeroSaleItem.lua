module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
require("SceneHelper")
function prototype:RefreshHeros(hero)
  if not hero then
    return
  end
  self.hero = hero
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
  local cardType = Logic:Get("Hero"):GetCardTypeById(hero.id)
  self:ShowByIsHero(cardType == "HERO")
  if cardType == "HERO" then
    self.imgLvTip:setVisible(true)
    if hero and hero.level then
      self.staLevel:create(0, "YELLOW_E_NUM")
      self.staLevel:setAlign("CENTER", "CENTER")
      self.staLevel:setValue(hero.level or 1)
    end
    local nLife, nAttack = Logic:Get("Hero"):GetHeroLifeAndAttack(hero.baseId, hero.level)
    if nLife and nAttack then
      self.staLife:setStyle(kCCLabelTTFStyleOutline)
      self.staAttack:setStyle(kCCLabelTTFStyleOutline)
      self.staLife:setString(tostring(nLife))
      self.staAttack:setString(tostring(nAttack))
    end
  else
    self.imgLvTip:setVisible(false)
    local strType = Logic:Get("Hero"):GetImageByType(cardType)
    local frame = CCSprite:create(strType)
    if frame then
      self.imgType:setDisplayFrame(frame:displayFrame())
    end
  end
  local info = Logic:Get("Hero"):GetHeroInfoByBaseId(hero.baseId)
  if info then
    self.staName:setString(info.name)
  end
  local nPrice = Logic:Get("Hero"):GetHeroPrice(hero.baseId, hero.level)
  self.staPrice:setStyle(kCCLabelTTFStyleOutline)
  self.staPrice:setString(nPrice or "0")
  local saleHero = Logic:Get("Hero"):GetSaleHero()
  if not saleHero or not self.hero.id then
    return
  end
  local strImage = "images/public/selcet1.png"
  if saleHero[self.hero.id] then
    strImage = "images/public/selcet2.png"
    self.bSelect = true
  else
    strImage = "images/public/selcet1.png"
    self.bSelect = false
  end
  local frame = CCSprite:create(strImage)
  if frame then
    self.imgCanSelect:setDisplayFrame(frame:displayFrame())
  end
end
function prototype:ShowByIsHero(bHero)
  self.imgType:setVisible(not bHero)
  self.staLevel:setVisible(bHero)
  self.imgHeart:setVisible(bHero)
  self.imgSword:setVisible(bHero)
  self.staAttack:setVisible(bHero)
  self.staLife:setVisible(bHero)
end
function prototype:onBtnSelect()
  if self.bSelect then
    local frame = CCSprite:create("images/public/selcet1.png")
    self.imgCanSelect:setDisplayFrame(frame:displayFrame())
    self.bSelect = false
    if self.hero.id then
      Logic:Get("Hero"):RemoveSaleHero(self.hero.id)
    end
  else
    local frame = CCSprite:create("images/public/selcet2.png")
    self.imgCanSelect:setDisplayFrame(frame:displayFrame())
    self.bSelect = true
    if self.hero.id then
      Logic:Get("Hero"):AddSaleHero(self.hero.id)
    end
  end
end
function prototype:onHeroImage()
  Logic:Get("HeroCardInfo"):OpenHeroInfo(self.hero)
end
