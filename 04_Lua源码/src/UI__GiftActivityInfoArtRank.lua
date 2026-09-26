module((...), package.seeall)
require("SceneHelper")
require("TableViewEx")
require("Logic.Compose")
require("BtnPosition")
prototype = BtnPosition.prototype:extend()
ITEM_BG_IMG = {
  normal = "images/public/btn_long_disable.png",
  select = "images/public/btn_long_disable.png",
  disable = "images/public/btn_long_disable.png"
}
function prototype:onBtnReturn()
  SceneHelper:runWithScene("GiftActivityList", self.rootNode)
end
function prototype:onBtnRecharge(sender, event)
  Logic:Get("Main"):GotoRecharge()
end
function prototype:onEnter()
  super.onEnter(self)
  self.ani = Logic:Get("AniMgr"):NewCCB("UI/UIcz", self.sprRight, ccp(35, 19), 0, nil, nil)
  if self.ani then
    self.ani:RunAni()
  end
  Logic:Get("Artifact"):On(Logic.Artifact.EVT.GETRANK, self:Event("SetNumberOne"))
  Logic:Get("Artifact"):PostGetRankList()
  local numOfVisi = Logic:Get("Home"):GetLvLView()
  if numOfVisi == 1 then
    self.btnOpenArt:setBackgroundSpriteForState(CCScale9Sprite:create(ITEM_BG_IMG.normal), CCControlStateNormal)
    self.btnOpenArt:setBackgroundSpriteForState(CCScale9Sprite:create(ITEM_BG_IMG.select), CCControlStateHighlighted)
    self.btnOpenArt:setBackgroundSpriteForState(CCScale9Sprite:create(ITEM_BG_IMG.disable), CCControlStateDisabled)
  end
  self:RefreInfo()
end
function prototype:RefreInfo(...)
  local giftInfo = Logic:Get("Gift"):GetActivityGift()
  self.title_ttf:setColor(ccc3(255, 183, 18))
  self.title_ttf:setString(giftInfo.name)
  self.title_ttf:setStyle(kCCLabelTTFStyleOutline)
  self.ttfTip1:setStyle(kCCLabelTTFStyleOutline)
  self.contentTTF:setStyle(kCCLabelTTFStyleOutline)
  self.contentReward:setStyle(kCCLabelTTFStyleOutline)
  self.contentReward1:setStyle(kCCLabelTTFStyleOutline)
  self.contentReward2:setStyle(kCCLabelTTFStyleOutline)
  self.titleTTF:setStyle(kCCLabelTTFStyleOutline)
  self.contentTTF2:setStyle(kCCLabelTTFStyleOutline)
  self.contentTTF3:setStyle(kCCLabelTTFStyleOutline)
  self.titleTTF:setString(TwGetStr(103300))
  self.contentTTF:setString(TwGetStr(103301))
  self.contentReward:setString(TwGetStr(103302))
  self.contentTTF2:setString(TwGetStr(103311))
  self.contentReward1:setString(TwGetStr(103309))
  self.contentTTF3:setString(TwGetStr(103312))
  self.contentReward2:setString(TwGetStr(103310))
  self.ttfTip1:setString(TwGetStr(103307))
  self:setHero(5267)
end
function prototype:SetNumberOne()
  local str = ""
  local rankData = Logic:Get("Artifact"):GetRankList()
  if rankData ~= nil and rankData[1] ~= nil then
    if rankData[1].level ~= nil and rankData[1].name ~= nil then
      str = TwGetStr(103306, rankData[1].level)
    end
    self.ttfName:setStyle(kCCLabelTTFStyleOutline)
    self.ttfName:setString(rankData[1].name or "")
    self.numberOne:setStyle(kCCLabelTTFStyleOutline)
    self.numberOne:setString(str)
  end
end
function prototype:onBtnLookRank(sender, event)
  SceneHelper:runWithScene("ArtifactRank", self.rootNode)
end
function prototype:onBtnOpenArt(sender, event)
  local numOfVisi = Logic:Get("Home"):GetLvLView()
  if numOfVisi == 1 then
    if event == CCControlEventTouchDown then
      Prompt:PopTip(103308)
    end
    if event == CCControlEventTouchUpOutside or event == CCControlEventTouchUpInside or event == CCControlEventTouchCancel then
      Logic:Get("SureConfirm"):FireEvent(Logic.SureConfirm.EVT.CLOSE_POPTIP)
    end
    return
  end
  SceneHelper:runWithScene("Artifact", self.rootNode)
end
function prototype:setHero(baseId, level)
  self.baseId = baseId
  self.level = level
  local node = Logic:Get("HeroCardInfo"):createHeroCard(baseId, 200)
  self.rootNode:addChild(node, 0, 2)
  node:setPosition(self.heroImg:getPosition())
  local fdb_baseHero = Logic:Get("HeroCardInfo"):kdbBaseHero(baseId)
  if fdb_baseHero ~= nil then
    self.heroName:setString(fdb_baseHero.name)
  end
  local color = Logic:Get("Hero"):getColorByBaseId(baseId)
  self.heroName:setStyle(kCCLabelTTFStyleOutline)
  self.heroName:setColor(color)
end
function prototype:onBtnCheckHero()
  local heroInfo = {
    exp = 0,
    id = 68719480211,
    level = self.level or 1,
    baseId = self.baseId or 1,
    powerSkill = 0
  }
  Logic:Get("HeroCardInfo"):OpenHeroInfoByNparma(heroInfo)
end
