module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
require("SceneHelper")
local BTN_ON_PICTURE = "images/public/selcet2.png"
local BTN_OFF_PICTURE = "images/public/selcet1.png"
local SET_OUTLINE_TITLE = {
  "HeadName",
  "IsAbilityEvolution",
  "HealthNum",
  "FightNum",
  "rankTitle",
  "CurrAndMaxRank"
}
local EVO_TYPE = Enum({
  "MATERIAL_EVO",
  "PAY_MONEY_EVO"
})
function prototype:initialize()
  super.initialize(self)
  self.hero = {}
  self.type = 0
  self.flag = 1
end
function prototype:onEnter()
  self.rankTitle:setString(TwGetStr(104279))
  self:setOutLine()
end
function prototype:setOutLine()
  for i = 1, #SET_OUTLINE_TITLE do
    self[SET_OUTLINE_TITLE[i]]:setStyle(kCCLabelTTFStyleOutline, ccc3(0, 0, 0))
  end
end
function prototype:RefreshHeros(type, hero)
  if not hero then
    return
  end
  self.type = type
  self.hero = hero
  self:HeroInfo(hero)
  if type == Logic.Hero.EVT.HERO_CURRENT then
    local battleHeros = Logic:Get("Hero"):GetBattlingHero()
    if not battleHeros then
      return
    end
    self.hero.bSelect = false
  end
end
function prototype:setSomeTitleNotVisible(tag)
  local artifactStr = tag and "images/public/clarity80.png" or "images/Other/type_fa.png"
  local sprite1 = CCSprite:create(artifactStr)
  if sprite1 then
    self.imgArtifact:setDisplayFrame(sprite1:displayFrame())
    self.imgArtifact:setPosition(ccp(90, 27))
  end
  self.staLeaderLevel:setVisible(tag)
  self.imgLeadertip:setVisible(tag)
  self.HealthPoint:setVisible(tag)
  self.HealthNum:setVisible(tag)
  self.FightImg:setVisible(tag)
  self.FightNum:setVisible(tag)
  self.rankTitle:setVisible(tag)
  self.CurrAndMaxRank:setVisible(tag)
end
function prototype:HeroInfo(hero)
  local info = KFDBGetRecord("BaseHero", hero.baseId)
  if info ~= nil and info.card == "EXP_CARD" then
    self:setSomeTitleNotVisible(false)
  else
    self:setSomeTitleNotVisible(true)
  end
  local strPath = Logic:Get("Hero"):GetHeroImage(hero.baseId)
  if strPath == nil or #strPath == 0 then
    return
  end
  self:setImgByStr(strPath, self.imgHero)
  self.staLeaderLevel:create()
  self.staLeaderLevel:setValue(hero.level or 1)
  local info = Logic:Get("Hero"):GetHeroInfoByBaseId(hero.baseId)
  if info == nil then
    return
  end
  self.CurrAndMaxRank:setString(hero.level .. "/" .. info.level)
  self:setHeroEvolutionCondition(Logic:Get("ExplainEquip"):AnalyseCondition(hero, info))
  if info then
    self.HeadName:setString(info.name)
  end
  local qualityCardPath, _ = Logic:Get("Hero"):GetHeroBgImage(info.id, Logic.Hero.HEROIMG_SIZE.MIDDLE, false)
  self:setImgByStr(qualityCardPath, self.imgBg)
  Logic:Get("HeroCardInfo"):AddShanCardSmall(self.imgHero, hero.baseId)
  local nLife, nAttack = Logic:Get("Hero"):GetHeroLifeAndAttack(hero.baseId, hero.level)
  if nLife and nAttack then
    self.HealthNum:setString(tostring(nLife))
    self.FightNum:setString(tostring(nAttack))
  end
end
function prototype:setHeroEvolutionCondition(strtag)
  self.IsAbilityEvolution:setString(TwGetStr(strtag))
  if 106011 == strtag then
    self.IsAbilityEvolution:setColor(ccc3(80, 255, 0))
  else
    self.IsAbilityEvolution:setColor(ccc3(255, 0, 0))
  end
end
function prototype:onBtnHeroHead()
  Logic:Get("HeroCardInfo"):OpenHeroInfo(self.hero)
end
function prototype:onBtnSelect()
  self.btnHeroHead:setEnabled(true)
  Logic:Get("Main"):CuMengMainGuide("Evolution", "SelectHero")
  Logic:Get("Guide"):done("Evolution", "SelectHero")
  Logic:Get("Guide"):done("FightEvolution", "SelectHero")
  local imgStr = 1 == self.flag and BTN_OFF_PICTURE or BTN_ON_PICTURE
  self.flag = self.flag * -1
  self:setImgByStr(imgStr, self.chickTitle)
  SceneHelper:popScene()
  SceneHelper:getTopLayer():setPic(self.hero)
end
function prototype:setImgByStr(str, img)
  local spr = CCSprite:create(str)
  img:setDisplayFrame(spr:displayFrame())
  img:setAnchorPoint(CCPoint(0.5, 0.5))
end
function prototype:updateGuide()
  if Logic:Get("Guide"):isActive("Evolution", "SelectHero") then
    self.btnHeroHead:setEnabled(false)
    Logic:Get("Guide"):lockTouch(self.btnSelect)
  end
  if Logic:Get("Guide"):isActive("FightEvolution", "SelectHero") then
    self.btnHeroHead:setEnabled(false)
    Logic:Get("Guide"):lockTouch(self.btnSelect)
  end
end
