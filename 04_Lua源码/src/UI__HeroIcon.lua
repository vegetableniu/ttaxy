module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
local QUALITY_MIN = 1
function prototype:onEnter()
end
local moneyImg = {
  "images/Other/goldBig.png",
  "images/Other/xianyu.png",
  "images/Other/xianyu.png",
  "images/Other/xianyu.png",
  "images/Other/xianyu.png"
}
function prototype:ReFrashHeroInfo(heroBaseId, bClick, itemType, level, other)
  local heroImg = CCSprite:create("images/public/hero.png")
  local heroBgImg = CCSprite:create("images/public/herobg.png")
  local fra = CCSprite:create("images/public/clarity80.png")
  local rewardType = TypeDef("com.eyu.mt.module.reward.model.RewardType")
  if itemType == "HERO" or itemType == "TREASURE" or itemType == "SKILL_CARD" or itemType == "COIN_CARD" or itemType == "EXP_CARD" or itemType == rewardType.HERO or itemType == rewardType.TREASURE or itemType == rewardType.SKILL_CARD or itemType == rewardType.COIN_CARD or itemType == rewardType.EXP_CARD then
    local path = Logic:Get("Hero"):GetHeroImage(heroBaseId, Logic.Hero.HEROIMG_SIZE.MIDDLE)
    local bgPath = Logic:Get("Hero"):GetHeroBgImage(heroBaseId, Logic.Hero.HEROIMG_SIZE.MIDDLE)
    if path then
      heroImg = CCSprite:create(path)
    end
    if bgPath then
      heroBgImg = CCSprite:create(bgPath)
    end
  elseif itemType == "FRAGMENT" or itemType == rewardType.FRAGMENT then
    local itemInfo = KFDBGetRecord("ItemConfig", heroBaseId)
    if itemInfo ~= nil then
      heroBgImg = Logic:Get("Compose"):GetItemsFrame(tonumber(itemInfo.quality))
      heroImg = Logic:Get("Compose"):GetFraImg(heroBaseId)
      fra = Logic:Get("Compose"):GetJigsawImg()
    end
  elseif itemType == "CURRENCY" or itemType == rewardType.CURRENCY then
    if heroBaseId + 1 < #moneyImg then
      heroImg = CCSprite:create(moneyImg[heroBaseId + 1])
    end
  elseif itemType == "EXP" or itemType == rewardType.EXP then
    heroImg = CCSprite:create("images/Other/action.png")
  elseif itemType == "DEMOG_FEAT" or itemType == rewardType.DEMOG_FEAT then
    heroImg = CCSprite:create("images/Other/gift.png")
    heroBgImg = Logic:Get("Compose"):GetItemsFrame(3)
  elseif itemType == "DEMOG_FRAGMENT" or itemType == rewardType.DEMOG_FRAGMENT then
    heroImg = CCSprite:create("images/Other/devilFrag.png")
    heroBgImg = Logic:Get("Compose"):GetItemsFrame(4)
  elseif itemType == "DEMOG_ENERGY" or itemType == rewardType.DEMOG_ENERGY then
    heroImg = CCSprite:create("images/Other/gift.png")
    heroBgImg = Logic:Get("Compose"):GetItemsFrame(4)
  elseif itemType == rewardType.SOUL_STONE or itemType == "SOUL_STONE" then
    local path = ""
    if heroBaseId == 0 then
      path = "images/Other/soul_stone.png"
    elseif heroBaseId > 0 then
      path = string.format("images/Other/soulStone%s.png", heroBaseId)
    end
    heroImg = CCSprite:create(path)
    heroBgImg = Logic:Get("Compose"):GetItemsFrame(4)
  end
  if heroImg then
    self.imgHeroIcon:setDisplayFrame(heroImg:displayFrame())
  end
  if heroBgImg then
    self.imgHeroBg:setDisplayFrame(heroBgImg:displayFrame())
  end
  Logic:Get("HeroCardInfo"):AddShanCardSmall(self.imgHeroIcon, heroBaseId)
  if fra then
    self.imgFra:setDisplayFrame(fra:displayFrame())
  end
  self.imgLevel:setVisible(false)
  self.labLevel:setVisible(false)
  if level then
    self.labLevel:create()
    self.labLevel:setValue(level or 0)
    self.imgLevel:setVisible(true)
    self.labLevel:setVisible(true)
  end
  self.btnHeroIcon:setEnabled(bClick)
  if other then
    self.heroInfo = other
  else
    self.heroBaseId = heroBaseId
  end
end
function prototype:onBtnHeroIcon(sender, event)
  if self.heroInfo then
    Logic:Get("HeroCardInfo"):OpenHeroInfoByNparma(self.heroInfo)
  elseif self.heroBaseId and self.heroBaseId ~= 0 then
    Logic:Get("HeroCardInfo"):OpenHeroInfoById(self.heroBaseId)
  end
end
function prototype:ReFrashEmailInfo(heroBaseId, bClick, itemType, level, other)
  local heroImg = CCSprite:create("images/public/hero.png")
  local heroBgImg = CCSprite:create("images/public/herobg.png")
  local fra = CCSprite:create("images/public/clarity80.png")
  local reward = {}
  reward.type = itemType or "Hero"
  reward.code = heroBaseId or 0
  local heroBgImg = Logic:Get("Reward"):GetBgByOneReward(reward)
  local heroImg = Logic:Get("Reward"):GetImgByOneReward(reward)
  if heroImg then
    local texture, textureRect = Logic:Get("HeroCardInfo"):GetCardTexture(heroImg)
    self.imgHeroIcon:setTexture(texture)
    self.imgHeroIcon:setTextureRect(textureRect)
  end
  if heroBgImg then
    self.imgHeroBg:setDisplayFrame(heroBgImg:displayFrame())
  end
  Logic:Get("HeroCardInfo"):AddShanCardSmall(self.imgHeroIcon, heroBaseId)
  if fra then
    self.imgFra:setDisplayFrame(fra:displayFrame())
  end
  self.imgLevel:setVisible(false)
  self.labLevel:setVisible(false)
  if level then
    self.labLevel:create()
    self.labLevel:setValue(level or 0)
    self.imgLevel:setVisible(true)
    self.labLevel:setVisible(true)
  end
  self.btnHeroIcon:setEnabled(bClick)
  if other then
    self.heroInfo = {
      baseId = heroBaseId,
      level = level,
      powerSkill = other.powerSkill
    }
  else
    self.heroBaseId = heroBaseId
  end
end
