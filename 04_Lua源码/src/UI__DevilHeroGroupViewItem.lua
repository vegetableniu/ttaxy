module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
require("SceneHelper")
function prototype:SetImage(heroInfo, leaderId)
  Logic:Get("HeroCardInfo"):ClearShanCard(self.imgHero)
  if not heroInfo then
    self.staStar:setString("")
    local sprite = CCSprite:create("images/public/clarity80.png")
    if sprite then
      self.imgHero:setDisplayFrame(sprite:displayFrame())
      self.imgBg:setDisplayFrame(sprite:displayFrame())
      self.imgStar:setDisplayFrame(sprite:displayFrame())
      self.imgType:setDisplayFrame(sprite:displayFrame())
      self.imgTypeBg:setDisplayFrame(sprite:displayFrame())
      self.imgLeader:setDisplayFrame(sprite:displayFrame())
    end
    return
  end
  local scale = 1
  local strImage = Logic:Get("Hero"):GetHeroImage(heroInfo.baseId, Logic.Hero.HEROIMG_SIZE.BIG)
  if not strImage then
    local sprite = CCSprite:create("images/public/clarity80.png")
    if sprite then
      self.imgHero:setDisplayFrame(sprite:displayFrame())
      self.imgBg:setDisplayFrame(sprite:displayFrame())
      self.imgStar:setDisplayFrame(sprite:displayFrame())
      self.imgType:setDisplayFrame(sprite:displayFrame())
      self.imgTypeBg:setDisplayFrame(sprite:displayFrame())
      self.imgLeader:setDisplayFrame(sprite:displayFrame())
    end
    return
  end
  local strBg, strStar = Logic:Get("Hero"):GetHeroBgImage(heroInfo.baseId, Logic.Hero.HEROIMG_SIZE.BIG)
  if strBg and strStar then
    local spriteBg = CCSprite:create(strBg)
    if spriteBg then
      self.imgBg:setDisplayFrame(spriteBg:displayFrame())
      local size = self.imgBg:getContentSize()
      self.imgBg:setScale(176 / size.width)
      scale = 176 / size.width
    end
    local spriteStar = CCSprite:create(strStar)
    if spriteStar then
      self.imgStar:setScale(scale)
      self.imgStar:setDisplayFrame(spriteStar:displayFrame())
    end
  end
  local sprite = CCSprite:create(strImage)
  if sprite then
    self.imgHero:setDisplayFrame(sprite:displayFrame())
    local size = self.imgHero:getContentSize()
    self.imgHero:setScale(scale)
  end
  local info = Logic:Get("Hero"):GetHeroInfoByBaseId(heroInfo.baseId)
  if info and info.star then
    self.staStar:setString(info.star)
  end
  local strTypeBg = Logic:Get("HeroCardInfo"):GetRaceBg(heroInfo.baseId)
  if strTypeBg then
    local spriteTypeBg = CCSprite:create(strTypeBg)
    if spriteTypeBg then
      self.imgTypeBg:setDisplayFrame(spriteTypeBg:displayFrame())
      self.imgTypeBg:setScale(scale)
    end
  end
  local strType = Logic:Get("HeroCardInfo"):GetHeroPhyleStr(heroInfo.baseId, Logic.HeroCardInfo.HERO_RACE.BIG)
  if strType then
    local spriteType = CCSprite:create(strType)
    if spriteType then
      self.imgType:setDisplayFrame(spriteType:displayFrame())
      self.imgType:setScale(scale)
    end
  end
  Logic:Get("HeroCardInfo"):AddShanCard(self.imgHero, heroInfo.baseId)
  local bIsShanCard = Logic:Get("HeroCardInfo"):IsShanCard(heroInfo.baseId)
  self.imgStar:setVisible(not bIsShanCard)
  self.imgType:setVisible(not bIsShanCard)
  if leaderId == heroInfo.baseId and heroInfo.leader then
    local spriteLeader = CCSprite:create("images/public/embattle_leader.png")
    if spriteLeader then
      self.imgLeader:setDisplayFrame(spriteLeader:displayFrame())
    end
  else
    local spriteLeader = CCSprite:create("images/public/clarity80.png")
    if spriteLeader then
      self.imgLeader:setDisplayFrame(spriteLeader:displayFrame())
    end
  end
end
