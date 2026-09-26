require("SceneHelper")
require("Guide.LevelUp")
module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
function prototype:onEnter()
end
function prototype:RefreshHeros(hero)
  if not hero then
    return
  end
  self.hero = hero
  self.staLevelTip:setString(TwGetStr(104279))
  self.staLevelTip:setStyle(kCCLabelTTFStyleOutline)
  self.imgSelect:setVisible(true)
  local updateHeroId = Logic:Get("Hero"):GetUpgradeHero()
  local frame = CCSprite:create("images/public/selcet1.png")
  if updateHeroId and updateHeroId == hero.id then
    frame = CCSprite:create("images/public/selcet2.png")
  else
    frame = CCSprite:create("images/public/selcet1.png")
  end
  if frame then
    self.imgSelect:setDisplayFrame(frame:displayFrame())
  end
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
  if hero.level then
    self.staLevel:create(0, "YELLOW_E_NUM")
    self.staLevel:setAlign("CENTER", "CENTER")
    self.staLevel:setValue(hero.level or 1)
  end
  local maxLevel = 0
  local info = Logic:Get("Hero"):GetHeroInfoByBaseId(hero.baseId)
  if info then
    maxLevel = info.level
  end
  self.staPercent:setStyle(kCCLabelTTFStyleOutline)
  self.staPercent:setString(string.format("%d/%d", hero.level or 0, maxLevel))
  local info = Logic:Get("Hero"):GetHeroInfoByBaseId(hero.baseId)
  if info then
    self.staName:setString(info.name)
  end
  local nLife, nAttack = Logic:Get("Hero"):GetHeroLifeAndAttack(hero.baseId, hero.level)
  if nLife and nAttack then
    self.staLife:setStyle(kCCLabelTTFStyleOutline)
    self.staAttack:setStyle(kCCLabelTTFStyleOutline)
    self.staLife:setString(tostring(nLife))
    self.staAttack:setString(tostring(nAttack))
  end
end
function prototype:onHeroImage()
  Logic:Get("HeroCardInfo"):OpenHeroInfo(self.hero)
end
function prototype:onBtnSelect()
  self.btnHero:setEnabled(true)
  Logic:Get("Main"):CuMengMainGuide("LevelUp", "SelectHero")
  Logic:Get("Guide"):done("LevelUp", "SelectHero")
  Logic:Get("Guide"):done("FightLevelUp", "SelectHero")
  local maxLevel = 0
  local info = Logic:Get("Hero"):GetHeroInfoByBaseId(self.hero.baseId)
  if info then
    maxLevel = info.level
  end
  if self.hero.level == maxLevel then
    local btnText = {}
    btnText.ok = TwGetStr(103086)
    Logic:Get("SureConfirm"):SetAni(true)
    Logic:Get("SureConfirm"):SetBtnText(btnText)
    Prompt:Confirm(self, "", 104155, self.gotoEvoUI, Prompt.PROMPT_TYPE.SELECT)
    return
  end
  Logic:Get("Hero"):SetUpgradeHero(self.hero.id)
  SceneHelper:popScene("HeroUpgrade", self.rootNode)
end
function prototype:gotoEvoUI()
  Logic:Get("ExplainEquip"):setEvolutionType(Logic.ExplainEquip.EVO_TYPE.MATERIAL_EVO)
  SceneHelper:runWithScene("HeroEvolution", self.rootNode)
end
function prototype:updateGuide()
  if Logic:Get("Guide"):isActive("LevelUp", "SelectHero") then
    self.btnHero:setEnabled(false)
    Logic:Get("Guide"):lockTouch(self.btnSelect)
  end
  if Logic:Get("Guide"):isActive("FightLevelUp", "SelectHero") then
    self.btnHero:setEnabled(false)
    Logic:Get("Guide"):lockTouch(self.btnSelect)
  end
end
