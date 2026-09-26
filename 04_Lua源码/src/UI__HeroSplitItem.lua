module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
require("SceneHelper")
function prototype:onEnter()
  self.ttfStar:setStyle(kCCLabelTTFStyleOutline)
  self.ttfGain:setStyle(kCCLabelTTFStyleOutline)
  self.ttfName:setStyle(kCCLabelTTFStyleOutline)
  self.ttfProgress:setStyle(kCCLabelTTFStyleOutline)
end
function prototype:ReFrashReward(giftInfo)
  if giftInfo == nil then
    return
  end
  local heroFdb = Logic:Get("Hero"):GetHeroInfoByBaseId(giftInfo.baseId)
  self.giftInfo = giftInfo
  self.heroFdb = heroFdb
  self:createImg(giftInfo, heroFdb)
  self:initBackGround(giftInfo)
  self.ttfGiftInfo:setString(TwGetStr(105266, heroFdb.star, heroFdb.name))
  local jsonRec = json.decode(heroFdb.splitId) or {}
  local splitCardInfo = {}
  for k, v in pairs(jsonRec) do
    table.insert(splitCardInfo, {baseId = k, amount = v})
  end
  self.targetHero = Logic:Get("Hero"):GetHeroInfoByBaseId(splitCardInfo[1].baseId)
  self.targetHero.amount = splitCardInfo[1].amount
  self.ttfGain:setString(TwGetStr(105764))
  self.ttfStar:setString(TwGetStr(105768, self.targetHero.star))
  local x = self.ttfStar:getPositionX() + self.ttfStar:getContentSize().width
  self.ttfName:setPositionX(x)
  self.ttfName:setString(self.targetHero.name)
  local color = Logic:Get("Hero"):getColorByBaseId(splitCardInfo[1].baseId)
  self.ttfName:setColor(color)
  x = self.ttfName:getPositionX() + self.ttfName:getContentSize().width
  self.ttfProgress:setPositionX(x)
  self.ttfProgress:setString("*" .. self.targetHero.amount)
end
function prototype:initBackGround(giftInfo)
  local path = {
    "images/HeroCardInfo/btn_split.png",
    "images/HeroCardInfo/fighting.png",
    "images/HeroCardInfo/protecting.png"
  }
  self.btnGain:setEnabled(true)
  local spr = CCSprite:create(path[giftInfo.sort])
  if spr then
    self.sprFinish:setDisplayFrame(spr:displayFrame())
  end
  local DISABLE = 2
  if DISABLE <= giftInfo.sort then
    self.btnGain:setEnabled(false)
  end
end
function prototype:createImg(giftInfo, fraConfig)
  Logic:Get("HeroCardInfo"):ClearShanCard(self.goodsImg)
  local str = Logic:Get("Hero"):GetHeroBgImage(giftInfo.baseId, Logic.Hero.HEROIMG_SIZE.MIDDLE)
  local spr = CCSprite:create(str)
  self.sprHeroHead:setDisplayFrame(spr:displayFrame())
  local strGoods = Logic:Get("Hero"):GetHeroImage(giftInfo.baseId, Logic.Hero.HEROIMG_SIZE.MIDDLE)
  local sprGoods = CCSprite:create(strGoods)
  self.goodsImg:setDisplayFrame(sprGoods:displayFrame())
  Logic:Get("HeroCardInfo"):AddShanCardSmall(self.goodsImg, giftInfo.baseId)
end
function prototype:onBtnGain()
  local title = TwGetStr(105765)
  local content = TwGetStr(105766, self.heroFdb.star, self.heroFdb.name, self.heroFdb.splitCostAmount)
  content = content .. "\n" .. TwGetStr(105767, self.targetHero.star, self.targetHero.name, self.targetHero.amount)
  content = content .. "\n" .. TwGetStr(105770)
  Prompt:Confirm(self, title, content, self.GainGoods, Prompt.PROMPT_TYPE.SELECT)
end
function prototype:GainGoods()
  local jade = Logic:Get("PlayerInfo"):GetPlayerAllJade()
  if jade < self.heroFdb.splitCostAmount then
    Logic:Get("Main"):PromptCharge()
    return
  end
  local bagBool = Logic:Get("Hero"):IsBagEnough()
  if bagBool then
    SceneHelper:pushPrompt("BattleTip")
    return
  end
  local talisman = Logic:Get("Talisman"):GetHeroEquipTailsmanByHeroId(self.giftInfo.id)
  if not table.empty(talisman or {}) then
    Prompt:Fail(TwGetStr(105769))
    return
  end
  Logic:Get("Compose"):SetSplitCard(self.giftInfo)
  Logic:Get("BGSound"):PlayEffect("audio/resolve.mp3")
  Logic:Get("Compose"):PostSplit(self.giftInfo.id)
end
function prototype:onBtnInfo()
  Logic:Get("HeroCardInfo"):OpenHeroInfo(self.giftInfo)
end
