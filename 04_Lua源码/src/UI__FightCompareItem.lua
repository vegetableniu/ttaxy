module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
function prototype:initialize(...)
  super.initialize(self, ...)
end
function prototype:dispose(...)
  super.dispose(self)
end
function prototype:onEnter()
end
function prototype:onNodeLoaded(node, loader)
end
function prototype:initData(data, bPlayer)
  if data then
    local iconPath = Logic:Get("Hero"):GetHeroImage(data.baseId)
    local spriteIcon = CCSprite:create(iconPath)
    if spriteIcon then
      self.heroIcon:setDisplayFrame(spriteIcon:displayFrame())
    end
    local strBg, strStar = Logic:Get("Hero"):GetHeroBgImage(data.baseId)
    local spriteBg = CCSprite:create(strBg)
    if spriteBg then
      self.heroBg:setDisplayFrame(spriteBg:displayFrame())
    end
    local spriteStar = CCSprite:create(strStar)
    if spriteStar then
      self.sprStar:setDisplayFrame(spriteStar:displayFrame())
    end
    Logic:Get("HeroCardInfo"):AddShanCardSmall(self.heroIcon, data.baseId)
    if data.level then
      self.staLevel:create(0, "YELLOW_E_NUM")
      self.staLevel:setAlign("CENTER", "CENTER")
      self.staLevel:setValue(data.level)
    end
    local heroFdb = KFDBGetRecord("BaseHero", data.baseId)
    self.ttfName:setString(heroFdb and heroFdb.name or "")
    local hp, attack = Logic:Get("Hero"):GetHeroLifeAndAttack(data.baseId, data.level)
    Logic:Get("HeroCardInfo"):SetHeroTalismanVo(data.talismanVos)
    Logic:Get("HeroCardInfo"):SetHeroArmorsVo(data.equipVos)
    Logic:Get("HeroCardInfo"):SetHeroCultiVo(data.cultivateVo)
    Logic:Get("HeroCardInfo"):SetHeoInfo(data)
    if bPlayer then
      local buff = Logic:Get("HeroCardInfo"):GetMyBUffEffect(heroFdb.type, heroFdb.star)
      hp = hp + buff.LIFE
      attack = attack + buff.ATTACK
    else
      local enemy = Logic:Get("Fight"):GetEnemy()
      local artRec = Logic:Get("Artifact"):GetBuffByLevelAndStar(enemy.artifactLevel, heroFdb.star)
      local buff = Logic:Get("HeroCardInfo"):AllBuffEffect(heroFdb.type, enemy.buffs or {}, artRec or {}, data.id)
      if not table.empty(buff) then
        hp = hp + buff.LIFE
        attack = attack + buff.ATTACK
      end
    end
    self.ttfLife:setString(hp or 0)
    self.ttfAttack:setString(attack or 0)
    Logic:Get("HeroCardInfo"):SetHeroTalismanVo(nil)
    Logic:Get("HeroCardInfo"):SetHeroArmorsVo(nil)
    Logic:Get("HeroCardInfo"):SetHeoInfo(nil)
  end
end
