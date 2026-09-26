module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
function prototype:onEnter()
  self.ttfLv:setStyle(kCCLabelTTFStyleOutline)
  self.ttfName:setStyle(kCCLabelTTFStyleOutline)
  self.ttfCurrAndMax:setStyle(kCCLabelTTFStyleOutline)
  self.ttfAttack:setStyle(kCCLabelTTFStyleOutline)
  self.ttfLife:setStyle(kCCLabelTTFStyleOutline)
  self.ttfIsFit:setStyle(kCCLabelTTFStyleOutline)
end
function prototype:onBtnSelect(sender, event)
  Logic:Get("Soaring"):setSelectedCard(self.heroData)
  Logic:Get("Soaring"):FireEvent(Logic.Soaring.EVT.SELECTED_CARD)
  SceneHelper:removeScene("SoaringSelect")
end
function prototype:onBtnHeroHead(sender, event)
  Logic:Get("HeroCardInfo"):OpenHeroInfo(self.heroData)
end
function prototype:RefrashItem(data)
  if table.empty(data or {}) then
    return
  end
  self.heroData = data
  self:HeroInfo(data)
  self:showCondition()
  self:showSelected()
end
function prototype:showSelected()
  local selectedInfo = Logic:Get("Soaring"):getSelectedCard()
  local normalPath = "images/public/selcet1.png"
  local selectedPath = "images/public/selcet2.png"
  local path = selectedInfo.id == self.heroData.id and selectedPath or normalPath
  local spr = CCSprite:create(path)
  if spr then
    self.sprClick:setDisplayFrame(spr:displayFrame())
  end
end
function prototype:showCondition()
  local result = Logic:Get("Soaring"):canSoaring(self.heroData)
  local RESULT_CODE = Logic.Soaring.METRIAL_RESULT
  local resultStr = {
    [RESULT_CODE.ENOUGH] = TwGetStr(115454),
    [RESULT_CODE.LEVEL_NOT_ENOUGH] = TwGetStr(115456),
    [RESULT_CODE.METRIAL_NOT_ENOUGH] = TwGetStr(115455)
  }
  self.ttfIsFit:setString(resultStr[result] or "")
  local color = result == RESULT_CODE.ENOUGH and ccc3(0, 255, 0) or ccc3(255, 0, 0)
  self.ttfIsFit:setColor(color)
end
function prototype:HeroInfo(hero)
  local info = KFDBGetRecord("BaseHero", hero.baseId)
  local strPath = Logic:Get("Hero"):GetHeroImage(hero.baseId)
  if strPath == nil or #strPath == 0 then
    return
  end
  self:setImgByPath(strPath, self.imgHero)
  self.labLeaderLevel:create()
  self.labLeaderLevel:setValue(hero.level or 1)
  local info = Logic:Get("Hero"):GetHeroInfoByBaseId(hero.baseId)
  if info == nil then
    return
  end
  self.ttfLv:setString(TwGetStr(103007))
  self.ttfCurrAndMax:setString(hero.level .. "/" .. info.level)
  self.ttfName:setString(info.name or "")
  local qualityCardPath, starPath = Logic:Get("Hero"):GetHeroBgImage(info.id)
  self:setImgByPath(qualityCardPath, self.imgBg)
  self:setImgByPath(starPath, self.sprStar)
  Logic:Get("HeroCardInfo"):AddShanCardSmall(self.imgHero, hero.baseId)
  local nLife, nAttack = Logic:Get("Hero"):GetHeroLifeAndAttack(hero.baseId, hero.level)
  self.ttfLife:setString(nLife or 0)
  self.ttfAttack:setString(nAttack or 0)
end
function prototype:setImgByPath(path, node)
  local spr = CCSprite:create(path)
  if spr == nil then
    return
  end
  node:setDisplayFrame(spr:displayFrame())
end
