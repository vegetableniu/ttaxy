module((...), package.seeall)
require("SceneHelper")
class = Logic.class:subclass()
eType = Enum({"PROTECT", "CLOSE"})
HERO_RACE = Enum({"SAMLL", "BIG"})
local SHINECARD_ANI = {
  BIG1 = "UI/supercard",
  BIG2 = "UI/supercard_E",
  SMALL1 = "UI/supercardS",
  SMALL2 = "UI/supercardS_E"
}
local HERO_TAG = 1
local DEAD_TAG = 10
local CARD_SIZE_WIDTH = 175
function class:initialize()
  super.initialize(self)
  self.heroInfo = {}
  self.treasureInfo = {}
  self.closeB = false
end
function class:OpenHeroInfo(heroInfo, eTypeD)
  if heroInfo == nil then
    return
  end
  local fdb_baseHero = Logic:Get("HeroCardInfo"):kdbBaseHero(heroInfo.baseId)
  if fdb_baseHero == nil then
    return
  end
  if fdb_baseHero.card == "HERO" then
    self:SetHeoInfo(heroInfo, eTypeD)
    local Talismans = Logic:Get("Talisman"):GetHeroEquipTailsmanByHeroId(heroInfo.id)
    self:SetHeroTalismanVo(Talismans)
    local armors = Logic:Get("Armor"):getHeroEquipArmors(heroInfo.id)
    self:SetHeroArmorsVo(armors)
    SceneHelper:pushScene("HeroInfo", nil)
  else
    self:SetTreasureInfo(heroInfo, eTypeD)
    SceneHelper:pushScene("TreasureInfo", nil)
  end
end
function class:OpenHeroInfoByNparma(heroInfoP, fra)
  if heroInfoP == nil then
    return
  end
  local basehero = KFDBGetRecord("BaseHero", heroInfoP.baseId or 1)
  if basehero == nil then
    if heroInfoP.baseId ~= nil then
      log4misc:warn("OpenHeroInfoByNparma:baseId:" .. heroInfoP.baseId)
    else
      log4misc:warn(nil)
    end
  end
  if heroInfoP.powerSkill ~= nil and heroInfoP.powerSkill == 0 then
    heroInfoP.powerSkill = basehero.powerSkill
  end
  self:initHeroInfo(heroInfoP, fra)
  SceneHelper:pushScene("HeroInfo", nil)
end
function class:initHeroInfo(heroInfoP, fra)
  local heroInfo = {
    exp = 0,
    id = 68719480211,
    level = heroInfoP.level or 1,
    baseId = heroInfoP.baseId or 1,
    powerSkill = tonumber(heroInfoP.powerSkill) or 1,
    fra = fra,
    talisman = heroInfoP.talisman,
    armors = heroInfoP.equips,
    userBuffs = heroInfoP.userBuffs,
    artifactLevel = heroInfoP.artifactLevel,
    otherPlayer = heroInfoP.otherPlayer,
    cultivateVo = heroInfoP.cultivateVo
  }
  self:SetHeroTalismanVo(heroInfoP.talisman)
  self:SetHeroArmorsVo(heroInfoP.equips)
  self:SetHeroCultiVo(heroInfoP.cultivateVo)
  self:SetHeoInfo(heroInfo)
end
function class:OpenHeroInfoById(baseId, fra, itemName)
  if baseId == nil then
    return
  end
  local fdb_baseHero = Logic:Get("HeroCardInfo"):kdbBaseHero(baseId)
  local basehero = KFDBGetRecord("BaseHero", baseId)
  if basehero == nil then
    log4misc:warn("OpenHeroInfoById:BaseHero:baseId:" .. baseId)
    return
  end
  local heroInfo = {
    exp = 0,
    id = 68719480211,
    level = 1,
    baseId = baseId,
    powerSkill = tonumber(basehero.powerSkill),
    fra = fra,
    itemName = itemName
  }
  self:SetHeroTalismanVo(nil)
  if fdb_baseHero.card == "HERO" then
    self:SetHeoInfo(heroInfo)
    SceneHelper:pushScene("HeroInfo", nil)
  else
    self:SetTreasureInfo(heroInfo)
    SceneHelper:pushScene("TreasureInfo", nil)
  end
end
function class:OpenTailsmanByID(talismanID)
  local rec = KFDBGetRecord("TalismanSetting", talismanID)
  if rec and rec.baseId then
    local talisman = {
      id = "2.816455e+014",
      level = rec.initLevel or 1,
      baseId = talismanID or rec.baseId,
      exp = 0
    }
    if rec.type == "FRAGMENT" then
      Logic:Get("HeroCardInfo"):OpenHeroInfoById(rec.baseId)
    else
      Logic:Get("HeroCardInfo"):OpenTailsman(talisman)
    end
  end
end
function class:OpenTailsman(Talismans)
  local rec = KFDBGetRecord("TalismanSetting", Talismans.baseId)
  if rec == nil then
    return
  end
  local expCard = string.find(rec.race, "EXP")
  if expCard then
    self:OpenHeroInfoById(rec.baseId)
  else
    self:SetTailInfo(Talismans)
    SceneHelper:pushPrompt("TailsmanInfo", nil)
  end
end
function class:SetTailInfo(tailInfo)
  self.tailInfo = tailInfo
end
function class:GetTailInfo()
  return self.tailInfo
end
function class:SetTreasureInfo(treasureInfo, eTypeD)
  if treasureInfo == nil then
    return
  end
  self.treasureInfo = treasureInfo
  eTypeD = eTypeD ~= nil and eType.PROTECT or eType.CLOSE
  self.treasureInfo.eType = eTypeD
end
function class:GetTreasureInfo()
  return self.treasureInfo
end
function class:SetHeoInfo(heroInfo, eTypeD)
  if heroInfo == nil then
    return
  end
  self.heroInfo = heroInfo
  eTypeD = eTypeD ~= nil and eType.PROTECT or eType.CLOSE
  self.heroInfo.eType = eTypeD
end
function class:GetHeroInfo()
  return self.heroInfo
end
function class:kdbBaseHero(id)
  if id == nil then
    log4misc:warn("HeroCardInfo:kdbBaseHero:id:nil")
    return
  end
  local basehero = KFDBGetRecord("BaseHero", id)
  return basehero
end
function class:kdbLeaderxkill(str)
  if str == nil then
    log4misc:warn("BuffEffect:Id:nil")
    return
  end
  local basehero = KFDBGetRecord("BuffEffect", str)
  return basehero
end
function class:kdbSkillConfig(id)
  if id == nil then
    log4misc:warn("SkillConfig:Id:nil")
    return
  end
  local skill = KFDBGetRecord("SkillConfig", id)
  if skill ~= nil then
    skill.state = json.decode(skill.state)
    if skill.costItems ~= "" then
      skill.costItems = json.decode(skill.costItems)
    end
  end
  return skill
end
function class:createHeroCardForByFight(baseId, tailsman)
  local ccSprite = self:GetSprCard(baseId)
  if tailsman then
    ccSprite:removeChildByTag(20, true)
  end
  if ccSprite and self:IsShanCard(baseId) then
    local imgGoldEdge = CCSprite:create("images/BattleShow/gold_edage.png")
    ccSprite:addChild(imgGoldEdge)
    imgGoldEdge:setAnchorPoint(ccp(0, 0))
  end
  return ccSprite
end
function class:GetSprCard(baseId, fra, bool)
  local strBg, strStar = Logic:Get("Hero"):GetHeroBgImage(baseId, Logic.Hero.HEROIMG_SIZE.BIG)
  if strBg == nil or strStar == nil then
    if baseId ~= nil then
      log4misc:warn("strBg:Hero.baseId:" .. baseId)
    else
      log4misc:warn(nil)
    end
    local strBg = "images/public/BigCardBg.png"
    local strQu = "images/public/hero.png"
    local sprBg = CCSprite:create(strBg)
    local sprQu = CCSprite:create(strQu)
    if sprQu ~= nil or sprBg ~= nil then
      sprBg:setAnchorPoint(CCPoint(0.5, 0.5))
      sprQu:setAnchorPoint(CCPoint(0.5, 0.5))
      sprBg:addChild(sprQu, 2, 2)
      sprQu:setPosition(CCPoint(sprBg:getContentSize().width * 0.5, sprBg:getContentSize().height * 0.5))
    end
    return sprBg
  end
  local sprBg = CCSprite:create(strBg)
  local strHead = Logic:Get("Hero"):GetHeroImage(baseId, Logic.Hero.HEROIMG_SIZE.BIG)
  if strHead == nil then
    if baseId ~= nil then
      log4misc:warn("strHead:Hero.baseId:" .. baseId)
    else
      log4misc:warn(nil)
    end
    local strBg = "images/public/BigCardBg.png"
    local strQu = "images/public/hero.png"
    local sprBg = CCSprite:create(strBg)
    local sprQu = CCSprite:create(strQu)
    if sprQu ~= nil or sprBg ~= nil then
      sprBg:setAnchorPoint(CCPoint(0.5, 0.5))
      sprQu:setAnchorPoint(CCPoint(0.5, 0.5))
      sprBg:addChild(sprQu, 2, 2)
      sprQu:setPosition(CCPoint(sprBg:getContentSize().width * 0.5, sprBg:getContentSize().height * 0.5))
    end
    return sprBg
  end
  local sprHead = CCSprite:create(strHead)
  if sprHead == nil then
    if baseId ~= nil then
      log4misc:warn("sprHead:Hero.baseId:" .. baseId)
    else
      log4misc:warn(nil)
    end
    local strBg = "images/public/BigCardBg.png"
    local strQu = "images/public/hero.png"
    local sprBg = CCSprite:create(strBg)
    local sprQu = CCSprite:create(strQu)
    if sprQu ~= nil or sprBg ~= nil then
      sprBg:setAnchorPoint(CCPoint(0.5, 0.5))
      sprQu:setAnchorPoint(CCPoint(0.5, 0.5))
      sprBg:addChild(sprQu, 2, 2)
      sprQu:setPosition(CCPoint(sprBg:getContentSize().width * 0.5, sprBg:getContentSize().height * 0.5))
    end
    return sprBg
  end
  if fra ~= nil then
    local comSpr = CCSprite:create("images/HeroCardInfo/compose.png")
    if comSpr ~= nil then
      sprBg:addChild(comSpr, 3, 2)
      comSpr:setAnchorPoint(CCPoint(0, 0))
    end
  end
  if sprHead ~= nil then
    sprBg:addChild(sprHead, 1, 3)
    sprHead:setAnchorPoint(CCPoint(0, 0))
  end
  if bool then
    return sprBg
  end
  local sprStar = CCSprite:create(strStar)
  if sprStar ~= nil then
    sprBg:setAnchorPoint(CCPoint(0.5, 0.5))
    sprBg:addChild(sprStar, 3, 20)
    sprStar:setAnchorPoint(CCPoint(0, 0))
    local x = sprBg:getContentSize().width * 0.11
    local y = sprBg:getContentSize().height * 0.001
    sprStar:setPosition(CCPoint(x, y))
  end
  local strRaceBg = self:GetRaceBg(baseId)
  local sprRaceBg = CCSprite:create(strRaceBg)
  if sprRaceBg ~= nil then
    sprBg:addChild(sprRaceBg, 2, 2)
    sprRaceBg:setAnchorPoint(CCPoint(0, 0))
    local xR = sprBg:getContentSize().width * 0.635
    local yR = sprBg:getContentSize().height * 0
    sprRaceBg:setPosition(CCPoint(xR, yR))
  end
  local strRace = self:GetHeroPhyleStr(baseId, "BIG")
  local sprRace = CCSprite:create(strRace)
  if sprRace ~= nil then
    sprBg:addChild(sprRace, 2, 2)
    sprRace:setAnchorPoint(CCPoint(0, 0))
    local xR = sprBg:getContentSize().width * 0.635
    local yR = sprBg:getContentSize().height * 0
    sprRace:setPosition(CCPoint(xR, yR))
  end
  return sprBg
end
function class:GetShanCardAni(baseId, prefix)
  if baseId == nil then
    return
  end
  local aniName
  local heroInfo = KFDBGetRecord("BaseHero", baseId)
  if heroInfo and heroInfo.shine ~= nil and heroInfo.shine ~= 0 then
    aniName = prefix .. tostring(heroInfo.shine)
  end
  return SHINECARD_ANI[aniName] or SHINECARD_ANI[prefix .. 1]
end
function class:SetParticlePositionTypeRelative(ani)
  local particle = ani:GetChild("mParticle")
  if particle then
    particle:setPositionType(kCCPositionTypeRelative)
  end
end
function class:GetShanCard(node, baseId, fra, bool)
  local aniName = self:GetShanCardAni(baseId, "BIG")
  local aniHero = Logic:Get("AniMgr"):NewCCB(aniName, node, nil, nil, nil, nil, true)
  self:SetParticlePositionTypeRelative(aniHero)
  local strBg, strStar = Logic:Get("Hero"):GetHeroBgImage(baseId, Logic.Hero.HEROIMG_SIZE.BIG)
  if strBg == nil or strStar == nil then
    if baseId ~= nil then
      log4misc:warn("strBg:Hero.baseId:" .. baseId)
    else
      log4misc:warn(nil)
    end
    local strBg = "images/public/BigCardBg.png"
    local strQu = "images/public/hero.png"
    local sprBg = CCSprite:create(strBg)
    local sprQu = CCSprite:create(strQu)
    if sprQu ~= nil or sprBg ~= nil then
    end
    return aniHero
  end
  local sprBg = CCSprite:create(strBg)
  aniHero:GetChild("imgBg"):setDisplayFrame(sprBg:displayFrame())
  local strHead = Logic:Get("Hero"):GetHeroImage(baseId, Logic.Hero.HEROIMG_SIZE.BIG)
  if strHead == nil then
    if baseId ~= nil then
      log4misc:warn("strHead:Hero.baseId:" .. baseId)
    else
      log4misc:warn(nil)
    end
    return aniHero
  end
  local sprHead = CCSprite:create(strHead)
  if sprHead == nil then
    if baseId ~= nil then
      log4misc:warn("sprHead:Hero.baseId:" .. baseId)
    else
      log4misc:warn(nil)
    end
  end
  if fra ~= nil then
    local comSpr = CCSprite:create("images/HeroCardInfo/compose.png")
    if comSpr ~= nil then
      aniHero:GetLayer():addChild(comSpr, 3, 2)
      comSpr:setAnchorPoint(CCPoint(0, 0))
    end
  end
  if sprHead ~= nil then
    aniHero:GetChild("imgHero"):setDisplayFrame(sprHead:displayFrame())
  end
  if bool then
    return aniHero
  end
  local sprStar = CCSprite:create(strStar)
  if sprStar ~= nil then
    aniHero:GetLayer():addChild(sprStar, 3, 2)
    sprStar:setAnchorPoint(CCPoint(0, 0))
    local x = aniHero:GetLayer():getContentSize().width * 0.11
    local y = aniHero:GetLayer():getContentSize().height * 0.001
    sprStar:setPosition(CCPoint(x, y))
  end
  local strRaceBg = self:GetRaceBg(baseId)
  local sprRaceBg = CCSprite:create(strRaceBg)
  if sprRaceBg ~= nil then
    aniHero:GetLayer():addChild(sprRaceBg, 2, 2)
    sprRaceBg:setAnchorPoint(CCPoint(0, 0))
    local xR = aniHero:GetLayer():getContentSize().width * 0.635
    local yR = aniHero:GetLayer():getContentSize().height * 0
    sprRaceBg:setPosition(CCPoint(xR, yR))
  end
  local strRace = self:GetHeroPhyleStr(baseId, "BIG")
  local sprRace = CCSprite:create(strRace)
  if sprRace ~= nil then
    aniHero:GetLayer():addChild(sprRace, 2, 2)
    sprRace:setAnchorPoint(CCPoint(0, 0))
    local xR = aniHero:GetLayer():getContentSize().width * 0.635
    local yR = aniHero:GetLayer():getContentSize().height * 0
    sprRace:setPosition(CCPoint(xR, yR))
  end
  return aniHero
end
function class:GetCompose(width)
  width = width or CARD_SIZE_WIDTH
  local ccSprite = CCSprite:create("images/HeroCardInfo/compose.png")
  local cardSz = ccSprite:getContentSize()
  ccSprite:setScale(1 * (width / cardSz.width))
  local ccLayer = CCLayer:create()
  ccLayer:setContentSize(CCSize(100, 100))
  if ccSprite ~= nil then
    ccLayer:addChild(ccSprite)
    ccSprite:setAnchorPoint(ccp(0.52, 0.43))
  end
  ccLayer:setAnchorPoint(ccp(0.5, 0.5))
  return ccLayer
end
function class:IsShanCard(baseId)
  if baseId == nil then
    return false
  end
  local heroInfo = KFDBGetRecord("BaseHero", baseId)
  if heroInfo and heroInfo.shine ~= nil and heroInfo.shine ~= 0 then
    return true
  end
  return false
end
function class:ClearShanCard(node)
  node:removeChildByTag(require("BattleShow.BattleDefine").HERO_TAG, true)
end
function class:AddShanCard(node, baseId, width, fra, bool)
  if not self:IsShanCard(baseId) then
    return
  end
  local ccSprite = self:GetShanCard(node, baseId, fra, bool):GetLayer()
  if ccSprite == nil then
    return
  end
  ccSprite:setAnchorPoint(ccp(0, 0))
  ccSprite:setPosition(ccp(0, 0))
  local cardSz = ccSprite:getContentSize()
  width = width or node and node:getContentSize().width or cardSz.width
  ccSprite:setScale(1 * (width / cardSz.width))
  return ccSprite
end
function class:ClearShanCardSmall(node)
  local tag = node.heroCardInfo_baseId
  if tag then
    node:removeChildByTag(tag, true)
  end
  node.heroCardInfo_baseId = nil
end
function class:AddShanCardSmall(node, baseId, width, bIsFragment)
  if not self:IsShanCard(baseId) or node == nil or bIsFragment then
    if node then
      self:ClearShanCardSmall(node)
    end
    return
  end
  local cardImg = node:getChildByTag(baseId)
  if cardImg then
    node:reorderChild(cardImg, 999)
    return
  end
  self:ClearShanCardSmall(node)
  local strPath = Logic:Get("Hero"):GetHeroImage(baseId)
  local strBg = Logic:Get("Hero"):GetHeroBgImage(baseId)
  if strPath and strBg then
    local heroImg = CCSprite:create(strPath)
    local bgImg = CCSprite:create(strBg)
    if heroImg and bgImg then
      local aniName = self:GetShanCardAni(baseId, "SMALL")
      local aniCard = Logic:Get("AniMgr"):NewCCB(aniName, node, nil, 999, nil, nil, true)
      self:SetParticlePositionTypeRelative(aniCard)
      aniCard:GetChild("imgBg"):setDisplayFrame(bgImg:displayFrame())
      aniCard:GetChild("imgHero"):setDisplayFrame(heroImg:displayFrame())
      cardImg = aniCard:GetLayer()
      cardImg:setTag(baseId)
      node.heroCardInfo_baseId = baseId
      if width then
        width = width or cardSz.width
        local cardSz = cardImg:getContentSize()
        cardImg:setScale(1 * (width / cardSz.width))
      end
    end
  end
  return cardImg
end
function class:createHeroCard(baseId, width, fra, bool, node, rebool, tailsman)
  local ccSprite = self:AddShanCard(node, baseId, width, fra, bool)
  if ccSprite == nil then
    width = width or CARD_SIZE_WIDTH
    ccSprite = self:GetSprCard(baseId, fra, bool)
    if tailsman then
      ccSprite:removeChildByTag(20, true)
    end
    if fra == nil and rebool then
      local strRec = self:GetRecommend(baseId)
      local sprRec = CCSprite:create(strRec)
      ccSprite:addChild(sprRec, 3, 4)
      sprRec:setAnchorPoint(CCPoint(0.5, 0.5))
      local xR = ccSprite:getContentSize().width * 0.5
      local yR = ccSprite:getContentSize().height * 0.4
      sprRec:setPosition(CCPoint(xR, yR))
    end
    local cardSz = ccSprite:getContentSize()
    ccSprite:setScale(1 * (width / cardSz.width))
  end
  local ccLayer = CCLayer:create()
  ccLayer:setContentSize(CCSize(100, 100))
  if ccSprite ~= nil then
    ccLayer:addChild(ccSprite)
    ccSprite:setAnchorPoint(ccp(0.5, 0.45))
  end
  ccLayer:setAnchorPoint(ccp(0.5, 0.5))
  return ccLayer
end
function class:GetCardTexture(node, scaleToSize, bAntiAlias, renderSize)
  local scaleY = node:getScaleY()
  local scaleX = node:getScaleX()
  local sz = node:getContentSize()
  local scaleToWidth = scaleToSize and scaleToSize.width or sz.width
  local scale = scaleToWidth / sz.width
  local width = renderSize and renderSize.width or scale * sz.width
  local height = renderSize and renderSize.height or scale * sz.height
  local outTexture = CCRenderTexture:create(width, height)
  outTexture:getSprite():setAnchorPoint(ccp(0, 0))
  outTexture:setPosition(ccp(0, 0))
  node:setAnchorPoint(ccp(0.5, 0.5))
  node:setPosition(ccp(width / 2, height / 2))
  outTexture:begin()
  node:setScaleY(-scaleY * scale)
  node:setScaleX(scaleX * scale)
  node:visit()
  outTexture:endToLua()
  node:setScaleY(scaleY)
  node:setScaleX(scaleX)
  local texture = outTexture:getSprite():getTexture()
  local textureSz = texture:getContentSize()
  if bAntiAlias then
    texture:setAntiAliasTexParameters()
  end
  return texture, CCRect(0, 0, textureSz.width, textureSz.height)
end
function class:SetDead(owner, bDead)
  local heroImg = owner:getChildByTag(HERO_TAG)
  if heroImg == nil then
    return
  end
  if not bDead then
    heroImg:stopAllActions()
    heroImg:removeChildByTag(DEAD_TAG, true)
    return
  end
  local deadImg = CCSprite:create("images/BattleShow/memem_dead.png")
  if deadImg ~= nil then
    deadImg:setAnchorPoint(CCPoint(0, 0))
    heroImg:addChild(deadImg, 0, DEAD_TAG)
  end
  local actions1 = CCArray:create()
  actions1:addObject(CCFadeTo:create(0.8, 100))
  actions1:addObject(CCFadeTo:create(0.8, 255))
  local actions2 = CCArray:create()
  actions2:addObject(CCTintTo:create(1, 30, 30, 255))
  actions2:addObject(CCTintTo:create(1, 150, 150, 255))
  local actions3 = CCArray:create()
  actions3:addObject(CCSequence:create(actions1))
  actions3:addObject(CCSequence:create(actions2))
  local actions5 = CCArray:create()
  actions5:addObject(CCSpawn:create(actions3))
  local actions4 = CCArray:create()
  actions4:addObject(CCFadeTo:create(1, 10))
  actions4:addObject(CCFadeTo:create(1, 200))
  heroImg:runAction(CCRepeatForever:create(CCSequence:create(actions5)))
  deadImg:runAction(CCRepeatForever:create(CCSequence:create(actions4)))
end
function class:GetRecommend(baseId)
  local info = Logic:Get("Hero"):GetHeroInfoByBaseId(baseId)
  if info.funcFlag and bit.band(bit.rshift(info.funcFlag, 1), 1) == 1 then
    return "images/HeroCardInfo/recommend.png"
  end
  return "images/public/clarity80.png"
end
function class:GetHeroPhyleStr(baseId, size)
  local info = Logic:Get("Hero"):GetHeroInfoByBaseId(baseId)
  size = size or HERO_RACE.SAMLL
  if size == HERO_RACE.SAMLL then
    if info == nil or info.race == nil then
      return "images/public/clarity80.png"
    end
    if info.race == "LING" then
      return "images/HeroCardInfo/ling.png"
    elseif info.race == "YAO" then
      return "images/HeroCardInfo/yao.png"
    elseif info.race == "XIAN" then
      return "images/HeroCardInfo/shen.png"
    else
      return "images/public/clarity80.png"
    end
  else
    if info == nil or info.race == nil then
      return "images/public/clarity80.png"
    end
    if info.race == "LING" then
      return "images/HeroCardInfo/ling_big.png"
    elseif info.race == "YAO" then
      return "images/HeroCardInfo/yao_big.png"
    elseif info.race == "XIAN" then
      return "images/HeroCardInfo/xian_big.png"
    else
      return "images/public/clarity80.png"
    end
  end
end
function class:GetHeroSexStr(baseId)
  local info = Logic:Get("Hero"):GetHeroInfoByBaseId(baseId)
  if info == nil or info.sex == nil then
    return "images/public/clarity80.png"
  end
  if info.sex == "MALE" then
    return "images/HeroCardInfo/man.png"
  elseif info.sex == "FEMALE" then
    return "images/HeroCardInfo/women.png"
  else
    return "images/public/clarity80.png"
  end
end
function class:GetRaceBg(baseId, bSelect)
  if bSelect then
    return "images/HeroCardInfo/raceBg.png"
  end
  return "images/public/clarity80.png"
end
function class:GetMyBUffEffect(profession, stars, heroId)
  local buffsId = Logic:Get("Achievement"):GetBuffs()
  local buff_KFD = Logic:Get("Artifact"):GetArtiBuffByStar(stars)
  local buff = self:AllBuffEffect(profession, buffsId, buff_KFD, heroId)
  return buff
end
function class:AllBuffEffect(profession, buffsId, buff_KFD, heroId)
  local buff = {}
  buff.ATTACK = 0
  buff.LIFE = 0
  local buffAch = self:AchBuff(profession, buffsId)
  local buffArti = self:ArtifactBuff(buff_KFD)
  local buffTailsman = self:TailsmanBuff(heroId)
  local buffEquip = self:EquipBuff()
  buff.ATTACK = buffAch.ATTACK + buffArti.ATTACK + buffTailsman.ATTACK + buffEquip.ATTACK
  buff.LIFE = buffAch.LIFE + buffArti.LIFE + buffTailsman.LIFE + buffEquip.LIFE
  local hp, attack = Logic:Get("Hero"):GetHeroLifeAndAttack(self.heroInfo.baseId, self.heroInfo.level)
  local buffArmor = self:ArmorsBuff(heroId, self:GetHeroArmorsVo())
  if buffArmor then
    buff.ATTACK = math.floor(buff.ATTACK + (attack + buff.ATTACK) * buffArmor.PCT_ATTACK)
    buff.LIFE = math.floor(buff.LIFE + (hp + buff.LIFE) * buffArmor.PCT_LIFE)
  end
  local cultivateBuffs = self:getCultivateBuff(heroId)
  if not table.empty(cultivateBuffs or {}) then
    if cultivateBuffs.ATTACK then
      buff.ATTACK = buff.ATTACK + cultivateBuffs.ATTACK
    end
    if cultivateBuffs.LIFE then
      buff.LIFE = buff.LIFE + cultivateBuffs.LIFE
    end
  end
  return buff
end
function class:TailsmanBuff(heroId)
  local buff = {}
  buff.ATTACK = 0
  buff.LIFE = 0
  local Talismans = Logic:Get("HeroCardInfo"):GetHeroTalismanVo()
  if Talismans == nil or Talismans[1] == nil then
    return buff
  end
  for i = 1, #Talismans do
    local baseId_level = Talismans[i].baseId .. "_" .. Talismans[i].level
    local alert = Logic:Get("Talisman"):GetTaIlsmanAlert(baseId_level)
    buff.ATTACK = buff.ATTACK + alert.ATTACK
    buff.LIFE = buff.LIFE + alert.LIFE
  end
  return buff
end
function class:AchBuff(profession, buffsId)
  if buffsId == nil then
    return
  end
  local buff = {}
  buff.ATTACK = 0
  buff.LIFE = 0
  if table.empty(buffsId) then
    return buff
  else
    for i = 1, #buffsId do
      do
        local buff_KFD = KFDBGetRecord("BuffEffect", buffsId[i])
        local buffJson
        local succ, msg = pcall(function()
          buffJson = json.decode(buff_KFD.alters)
        end)
        if succ and buff_KFD.unit == profession then
          buff.ATTACK = buff.ATTACK + buffJson.ATTACK
          buff.LIFE = buff.LIFE + buffJson.LIFE
        end
      end
    end
    return buff
  end
end
function class:ArtifactBuff(buff_KFD)
  local buff = {}
  buff.ATTACK = 0
  buff.LIFE = 0
  if buff_KFD == nil or table.empty(buff_KFD) or buff_KFD.alters == "" then
    return buff
  else
    do
      local buffJson
      local succ, msg = pcall(function()
        buffJson = json.decode(buff_KFD.alters)
      end)
      if succ then
        buff.ATTACK = buff.ATTACK + buffJson.ATTACK
        buff.LIFE = buff.LIFE + buffJson.LIFE
      end
      return buff
    end
  end
end
function class:EquipBuff()
  local equipBuff = {ATTACK = 0, LIFE = 0}
  local armors = self:GetHeroArmorsVo() or {}
  if table.empty(armors) then
    return equipBuff
  end
  for i = 1, #armors do
    local rec = Logic:Get("Armor"):getArmorInfoByBaseId(armors[i].baseId)
    if rec and rec.alters then
      local tAlters = json.decode(rec.alters) or {}
      equipBuff.ATTACK = equipBuff.ATTACK + (tAlters.ATTACK or 0)
      equipBuff.LIFE = equipBuff.LIFE + (tAlters.LIFE or 0)
    end
  end
  return equipBuff
end
function class:ArmorsBuff(heroId, armors)
  local function getArmorsBuff(heroEquipArmors)
    if not heroEquipArmors then
      return
    end
    local counts = Logic:Get("Armor"):getActivateCounts(self.heroInfo.baseId, heroEquipArmors)
    if counts ~= 0 then
      do
        local armorBuff = {}
        local rec = Logic:Get("Hero"):GetHeroInfoByBaseId(self.heroInfo.baseId)
        local function getBuff(Set)
          local set = {}
          if rec and rec.weaponSet then
            set = json.decode(rec.weaponSet or "[]") or {}
          end
          local buffId = tostring(self.heroInfo.baseId) .. "_" .. tostring(set[counts] or 0)
          local buff = Logic:Get("Armor"):getTotalComboAlters(buffId) or {}
          return buff
        end
        if rec and rec.weaponSet then
          armorBuff = getBuff(rec.weaponSet)
        end
        if table.empty(armorBuff) and rec and rec.armorSet then
          armorBuff = getBuff(rec.armorSet)
        end
        armorBuff.PCT_ATTACK = armorBuff.PCT_ATTACK or 0
        armorBuff.PCT_LIFE = armorBuff.PCT_LIFE or 0
        return armorBuff
      end
    end
  end
  local buffArmor = {PCT_ATTACK = 0, PCT_LIFE = 0}
  if armors and #armors > 1 then
    buffArmor = getArmorsBuff(armors) or buffArmor
  else
    buffArmor = nil
  end
  return buffArmor
end
function class:getCultivateBuff(heroId)
  local buff = {ATTACK = 0, LIFE = 0}
  local function addBuff(cultivateBuffs)
    if cultivateBuffs.ATTACK then
      buff.ATTACK = buff.ATTACK + cultivateBuffs.ATTACK
    end
    if cultivateBuffs.LIFE then
      buff.LIFE = buff.LIFE + cultivateBuffs.LIFE
    end
    return buff
  end
  local cultivateBuffs = Logic:Get("Cultivate"):getHeroCutivateAlterValues(tostring(heroId))
  if not table.empty(cultivateBuffs or {}) then
    return addBuff(cultivateBuffs)
  end
  cultivateBuffs = self:GetHeroCultiVo()
  if not table.empty(cultivateBuffs or {}) then
    return addBuff(cultivateBuffs.alterValues)
  end
  return buff
end
function class:PromptHeroInfoByNparma(heroInfoP, fra)
  if heroInfoP == nil then
    return
  end
  local basehero = KFDBGetRecord("BaseHero", heroInfoP.baseId or 1)
  if basehero == nil then
    if heroInfoP.baseId ~= nil then
      log4misc:warn("OpenHeroInfoByNparma:baseId:" .. heroInfoP.baseId)
    else
      log4misc:warn(nil)
    end
  end
  if heroInfoP.powerSkill ~= nil and heroInfoP.powerSkill == 0 then
    heroInfoP.powerSkill = basehero.powerSkill
  end
  self:initHeroInfo(heroInfoP, fra)
  local Talismans = Logic:Get("Talisman"):GetHeroEquipTailsmanByHeroId(heroInfoP.id)
  self:SetHeroTalismanVo(Talismans)
  local armors = Logic:Get("Armor"):getHeroEquipArmors(heroInfoP.id)
  self:SetHeroArmorsVo(armors)
  self:SetPromptHeroInfo(true)
  SceneHelper:pushPrompt("HeroInfo", nil)
end
function class:PromptTreaInfoByNparma(heroInfoP, fra)
  self:SetPromptHeroInfo(true)
  self:SetTreasureInfo(heroInfoP)
  SceneHelper:pushPrompt("TreasureInfo", nil)
end
function class:SetPromptHeroInfo(bool)
  self.closeB = bool
end
function class:GetPromptHeroInfo()
  return self.closeB
end
function class:SetHeroTalismanVo(heroTalismanVo)
  self.heroTalismanVo = heroTalismanVo
end
function class:GetHeroTalismanVo()
  return self.heroTalismanVo or {}
end
function class:SetHeroArmorsVo(armorsVo)
  self.armorsVo = armorsVo
end
function class:GetHeroArmorsVo()
  return self.armorsVo
end
function class:SetHeroCultiVo(cultiVo)
  self.cultiVo = cultiVo or {}
end
function class:GetHeroCultiVo()
  return self.cultiVo
end
function class:PromptHeroInfoById(baseId, fra)
  if baseId == nil then
    return
  end
  local fdb_baseHero = Logic:Get("HeroCardInfo"):kdbBaseHero(baseId)
  if fdb_baseHero == nil then
    log4misc:warn("PromptHeroInfoById:BaseHero:baseId:" .. baseId)
    return
  end
  local heroInfo = {
    exp = 0,
    id = 68719480211,
    level = fdb_baseHero.level or 1,
    baseId = baseId,
    powerSkill = 0,
    fra = fra
  }
  if fdb_baseHero.card == "HERO" then
    self:PromptHeroInfoByNparma(heroInfo)
  else
    self:PromptTreaInfoByNparma(heroInfo)
  end
end
