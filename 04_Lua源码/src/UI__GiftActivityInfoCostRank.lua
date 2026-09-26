module((...), package.seeall)
require("SceneHelper")
require("TableViewEx")
require("Logic.Compose")
require("BtnPosition")
prototype = BtnPosition.prototype:extend()
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
  Logic:Get("PlayerInfo"):On(Logic.PlayerInfo.EVT.GET_CONSUME_RANK, self:Event("SetNumberOne"))
  Logic:Get("PlayerInfo"):PostGetConsumeRank()
  self:RefreInfo()
end
function prototype:RefreInfo(...)
  local giftInfo = Logic:Get("Gift"):GetActivityGift()
  self.title_ttf:setColor(ccc3(255, 183, 18))
  self.title_ttf:setString(giftInfo.name)
  self.title_ttf:setStyle(kCCLabelTTFStyleOutline)
  self.content1:setString(TwGetStr(103320))
  self.content1:setStyle(kCCLabelTTFStyleOutline)
  self.content1:setDimensions(CCSize(200, 0))
  self.content1:setFontSize(19)
  self.ttfTime:setString(TwGetStr(103323))
  local sysTime = Logic:Get("System"):GetTimeStr("%H")
  self.ttfTime:setString(self:setTime(sysTime))
  self.ttfTime:setStyle(kCCLabelTTFStyleOutline)
  self:setHero(5452)
end
function prototype:setTime(sysTime)
  sysTime = tonumber(sysTime)
  if sysTime == nil or type(sysTime) ~= "number" then
    return
  end
  if sysTime >= 21 then
    return TwGetStr(103336)
  elseif sysTime >= 12 then
    return TwGetStr(103337)
  else
    return TwGetStr(103338)
  end
end
function prototype:SetNumberOne()
  self.ttfName:setStyle(kCCLabelTTFStyleOutline)
  self.numberOne:setStyle(kCCLabelTTFStyleOutline)
  self.ttf_myName:setStyle(kCCLabelTTFStyleOutline)
  self.ttf_myValue:setStyle(kCCLabelTTFStyleOutline)
  local nameberOne = Logic:Get("PlayerInfo"):GetConsunm_Rank()
  if nameberOne ~= nil and nameberOne[1] then
    self.ttfName:setString(nameberOne[1].name)
    self.numberOne:setString(nameberOne[1].consume)
  end
  local playerName = Logic:Get("PlayerInfo"):GetPlayerName()
  for i = 1, #nameberOne do
    if nameberOne[i].name == playerName then
      self.ttf_myName:setString(nameberOne[i].rank)
      self.ttf_myValue:setString(nameberOne[i].consume)
    end
  end
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
    self.level = tonumber(fdb_baseHero.level)
  end
  local color = Logic:Get("Hero"):getColorByBaseId(baseId)
  if color == nil then
    return
  end
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
function prototype:onBtnOpenRankReward()
  SceneHelper:runWithScene("GiftActivityInfoCostReward", self.rootNode)
end
