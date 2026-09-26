module((...), package.seeall)
require("SceneHelper")
require("TableViewEx")
require("Logic.Compose")
require("BtnPosition")
prototype = BtnPosition.prototype:extend()
function prototype:onEnter()
  super.onEnter(self)
  self.ttfName:setStyle(kCCLabelTTFStyleOutline)
  self.numberOne:setStyle(kCCLabelTTFStyleOutline)
  self.ttf_myName:setStyle(kCCLabelTTFStyleOutline)
  self.ttf_myValue:setStyle(kCCLabelTTFStyleOutline)
  self.title_ttf:setStyle(kCCLabelTTFStyleOutline)
  self.ttfTime:setStyle(kCCLabelTTFStyleOutline)
  self:RefreInfo()
end
function prototype:onBtnReturn()
  SceneHelper:runWithScene("GiftActivityList", self.rootNode)
end
function prototype:onBtnRank(sender, event)
  SceneHelper:runWithScene("GiftCommonRank", self.rootNode)
end
function prototype:onBtnCheckHero()
  if self.topRankRewardInfo.showType == "TALISMAN" then
    local talisman = {
      id = "2.816455e+014",
      level = 10,
      baseId = self.topRankRewardInfo.showId,
      exp = 0
    }
    Logic:Get("HeroCardInfo"):OpenTailsman(talisman)
    return
  end
  local heroInfo = {
    exp = 0,
    id = 68719480211,
    level = 100,
    baseId = self.baseId or 1,
    powerSkill = 0
  }
  Logic:Get("HeroCardInfo"):OpenHeroInfoByNparma(heroInfo)
end
function prototype:onBtnOpenRankReward()
  SceneHelper:runWithScene("GiftCommonReward", self.rootNode)
end
function prototype:onBtnPoints()
  local giftInfo = Logic:Get("Gift"):GetActivityGift()
  local activeData = Logic:Get("GiftRank"):GetActivesInfo(giftInfo.activityType)
  local data = Logic:Get("Gift"):GetActivityByType(activeData.activityType)
  Logic:Get("Gift"):SetActivityGift(data[1])
  SceneHelper:runWithScene(activeData.subScene, self.rootNode)
end
function prototype:RefreInfo()
  local giftInfo = Logic:Get("Gift"):GetActivityGift()
  self.title_ttf:setColor(ccc3(255, 183, 18))
  self.title_ttf:setString(giftInfo.name)
  Logic:Get("GiftRank"):Init(giftInfo.activityType)
  Logic:Get("GiftRank"):On(Logic.GiftRank.EVT.GET_INFO, self:Event("onGetInfo"))
  self:setHero()
  self:setContent()
end
function prototype:onGetInfo()
  self:SetNumberOne()
  self:onTimer()
  if not self.eventTracer:Exist("onTimer") then
    Singleton(Timer):Repeat(1000, self:Event("onTimer"))
  end
end
function prototype:setContent()
  local langIds = Logic:Get("GiftRank"):GetLanguageIds()
  local maxItem = 2
  for i = 1, maxItem do
    local content = KFDBGetRecord("LanguageSetting", langIds[i])
    if content then
      local str = string.format("content%d", i)
      self[str]:setString(ReplaceStringTab(content.content))
      self[str]:setStyle(kCCLabelTTFStyleOutline)
      self[str]:setDimensions(CCSize(200, 0))
      self[str]:setFontSize(19)
    end
  end
  local cardInfo = KFDBGetRecord("BaseHero", self.baseId)
  if not cardInfo then
    return
  end
  local strRedFormat = "<font SIZE='19' color='#F7EDA0' >%s</font>"
  local content5 = KFDBGetRecord("LanguageSetting", langIds[3])
  if not content5 then
    return
  end
  local colorStr = {
    "ffffff",
    "69ff9a",
    "004a96",
    "de1fff",
    "ffff00",
    "ff8600",
    "ff0000"
  }
  local tag = string.format("<font SIZE='19' color='#%s'>", colorStr[cardInfo.rank] or "ff8600")
  local strFormat = string.gsub(content5.content, "{NAME}", tag .. cardInfo.name .. "</font>")
  strFormat = string.format(strRedFormat, strFormat)
  self.content5:setString(strFormat)
end
function prototype:SetNumberOne()
  local nameberOne = Logic:Get("GiftRank"):GetRankData()
  if table.empty(nameberOne or {}) then
    return
  end
  if nameberOne.topName then
    self.ttfName:setString(nameberOne.topName)
  end
  self.numberOne:setString(nameberOne.topScore or 0)
  if nameberOne.rank ~= 0 then
    self.ttf_myName:setString(nameberOne.rank)
  end
  self.ttf_myValue:setString(nameberOne.score or 0)
end
function prototype:setHero()
  local key = Logic:Get("GiftRank"):GetCongifKey()
  local topRewardInfo = KFDBGetRecord("ConfigValue", key)
  if topRewardInfo == nil then
    return
  end
  self.topRankRewardInfo = json.decode(topRewardInfo.content)
  local showId = self.topRankRewardInfo.showId
  local isTalisman = false
  if self.topRankRewardInfo.showType == "TALISMAN" then
    local rec = KFDBGetRecord("TalismanSetting", showId)
    showId = rec.baseId
    isTalisman = true
  end
  self.baseId = showId
  local node = Logic:Get("HeroCardInfo"):createHeroCard(self.baseId, 200, nil, nil, nil, nil, isTalisman)
  self.rootNode:addChild(node, 0, 2)
  node:setPosition(self.heroImg:getPosition())
  local fdb_baseHero = Logic:Get("HeroCardInfo"):kdbBaseHero(self.baseId)
  if fdb_baseHero ~= nil then
    self.heroName:setString(fdb_baseHero.name)
  end
  local color = Logic:Get("Hero"):getColorByBaseId(self.baseId)
  if color == nil then
    return
  end
  self.heroName:setStyle(kCCLabelTTFStyleOutline)
  self.heroName:setColor(color)
end
function prototype:onTimer()
  local closeTime = Logic:Get("GiftRank"):GetCloseTime()
  if closeTime and closeTime ~= 0 then
    local diffTime = Logic:Get("System"):DiffTime(closeTime / 1000)
    closeTime = Logic:Get("System"):SecToDay(diffTime)
    if closeTime and diffTime > 0 then
      closeTime.hour = closeTime.hour + closeTime.day * 24
      local str = string.format("%02d:%02d:%02d", closeTime.hour or 0, closeTime.min or 0, closeTime.sec or 0)
      self.ttfTime:setString(str)
      return
    end
    self.ttfTime:setString("")
    return
  end
  self.ttfTime:setString("")
end
