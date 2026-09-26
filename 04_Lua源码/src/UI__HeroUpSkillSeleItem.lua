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
    local sprHero = CCSprite:create(strPath)
    self.sprImg:setDisplayFrame(sprHero:displayFrame())
  end
  local strBg = Logic:Get("Hero"):GetHeroBgImage(hero.baseId)
  if strBg then
    local sprHeroBg = CCSprite:create(strBg)
    self.sprBg:setDisplayFrame(sprHeroBg:displayFrame())
  end
  Logic:Get("HeroCardInfo"):AddShanCardSmall(self.sprImg, hero.baseId)
  self.staLevel:create()
  self.staLevel:setAlign("CENTER", "CENTER")
  self.staLevel:setValue(hero.level or 1)
  local info = Logic:Get("Hero"):GetHeroInfoByBaseId(hero.baseId)
  if info then
    self.staName:setStyle(kCCLabelTTFStyleOutline)
    self.staName:setString(info.name)
  end
  local fdbSkill = Logic:Get("HeroCardInfo"):kdbSkillConfig(hero.powerSkill)
  self.ttfSkillName:setStyle(kCCLabelTTFStyleOutline)
  self.ttfSkillName:setString(TwGetStr(103040, fdbSkill.skillname or ""))
  self.ttfSkillLvl:setStyle(kCCLabelTTFStyleOutline)
  self.ttfSkillLvl:setString("Lv:" .. fdbSkill.level .. "/" .. fdbSkill.maxlev)
  local boolLvl = hero.boolCanLvl
  self.ttfTIp:setStyle(kCCLabelTTFStyleOutline)
  if boolLvl ~= nil and boolLvl == 0 then
    self.ttfTIp:setString(TwGetStr(103045))
    self.ttfTIp:setColor(ccColor3B(0, 255, 0))
  else
    self.ttfTIp:setColor(ccColor3B(255, 0, 0))
    self.ttfTIp:setString(TwGetStr(103044))
  end
  if fdbSkill.level == fdbSkill.maxlev then
    self.ttfTIp:setColor(ccColor3B(128, 128, 128))
    self.ttfTIp:setString(TwGetStr(103050))
  end
  local seleHero = Logic:Get("Treasure"):GetHeroInfo()
  if seleHero then
    if hero.id == seleHero.id then
      local selcet1 = CCSprite:create("images/public/selcet2.png")
      self.sprSele:setDisplayFrame(selcet1:displayFrame())
    else
      local selcet2 = CCSprite:create("images/public/selcet1.png")
      self.sprSele:setDisplayFrame(selcet2:displayFrame())
    end
  else
    local selcet2 = CCSprite:create("images/public/selcet1.png")
    self.sprSele:setDisplayFrame(selcet2:displayFrame())
  end
end
function prototype:onHeroImage()
  Logic:Get("HeroCardInfo"):OpenHeroInfo(self.hero)
end
function prototype:onBtnSeleHero()
  local fdbSkill = Logic:Get("HeroCardInfo"):kdbSkillConfig(self.hero.powerSkill)
  if fdbSkill.level == fdbSkill.maxlev then
    Prompt:Tip(TwGetStr(103054))
    return
  end
  if Logic:Get("Guide"):isActive("SkillUpgrade", "SelectHero") then
    self.btnHero:setEnabled(true)
    Logic:Get("Guide"):done("SkillUpgrade", "SelectHero")
  end
  Logic:Get("Treasure"):SetHeroInfo(self.hero)
  Logic:Get("Treasure"):FireEvent(Logic.Treasure.EVT.REFRESH_SELE_HERO)
  SceneHelper:popScene()
end
function prototype:updateGuide()
  if Logic:Get("Guide"):isActive("SkillUpgrade", "SelectHero") then
    self.btnHero:setEnabled(false)
    Logic:Get("Guide"):lockTouch(self.btnSelect)
  end
end
