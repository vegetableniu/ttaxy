module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
local CLARITY_PATH = "images/public/clarity05.png"
local DEFAULT_BG_PATH = "images/public/herobg.png"
DUMPLING_TYPE = Enum({
  "LOW",
  "MIDDLE",
  "HIGH"
})
function prototype:initialize(...)
  super.initialize(self, ...)
end
function prototype:dispose(...)
  super.dispose(self)
end
function prototype:onEnter()
  self.labLow:setStyle(kCCLabelTTFStyleOutline)
  self.labMiddle:setStyle(kCCLabelTTFStyleOutline)
  self.labHigh:setStyle(kCCLabelTTFStyleOutline)
  self.labUseTip:setStyle(kCCLabelTTFStyleOutline)
  self.rewards = {}
  self.dumplingType = DUMPLING_TYPE.LOW
  for i = 1, 5 do
    local str = string.format("count%d", i)
    if self[str] then
      self[str]:setStyle(kCCLabelTTFStyleOutline)
    end
  end
  Logic:Get("Dumpling"):On(Logic.Dumpling.EVT.COOKING_BEGIN, self:Event("beginCooking"))
  self:initInfo()
end
function prototype:initInfo()
  self.dumplingDetails = Logic:Get("Dumpling"):getDumplingDetails()
  local infos = Logic:Get("Dumpling"):getRewardsInfo()
  self.allDumplingCards = {}
  for i = 1, #infos do
    self.allDumplingCards[i] = Logic:Get("Hero"):GetHeroInfoByBaseId(infos[i].baseId)
  end
  self.labLow:setString(TwGetStr(111002, self.allDumplingCards[1].name or "", self.dumplingDetails[1].count or 0))
  self.labMiddle:setString(TwGetStr(111002, self.allDumplingCards[2].name or "", self.dumplingDetails[2].count or 0))
  self.labHigh:setString(TwGetStr(111002, self.allDumplingCards[3].name or "", self.dumplingDetails[3].count or 0))
  if self.dumplingDetails[3].count and 0 < self.dumplingDetails[3].count then
    self:chooseDumpling(DUMPLING_TYPE.HIGH)
  elseif self.dumplingDetails[2].count and 0 < self.dumplingDetails[2].count then
    self:chooseDumpling(DUMPLING_TYPE.MIDDLE)
  else
    self:chooseDumpling(DUMPLING_TYPE.LOW)
  end
end
function prototype:beginCooking()
  SceneHelper:runWithScene("DumplingMain", self.rootNode)
end
function prototype:chooseDumpling(dumplingType)
  self.dumplingType = dumplingType
  self.sprSelectLow:setVisible(false)
  self.sprSelectMiddle:setVisible(false)
  self.sprSelectHigh:setVisible(false)
  self.sprSleepLow:setVisible(true)
  self.sprSleepMiddle:setVisible(true)
  self.sprSleepHigh:setVisible(true)
  self.sprLow:setEnabled(true)
  self.sprMiddle:setEnabled(true)
  self.sprHigh:setEnabled(true)
  if dumplingType == DUMPLING_TYPE.LOW then
    self.sprLow:setEnabled(false)
    self.sprSelectLow:setVisible(true)
    self.sprSleepLow:setVisible(false)
  elseif dumplingType == DUMPLING_TYPE.MIDDLE then
    self.sprMiddle:setEnabled(false)
    self.sprSelectMiddle:setVisible(true)
    self.sprSleepMiddle:setVisible(false)
  elseif dumplingType == DUMPLING_TYPE.HIGH then
    self.sprHigh:setEnabled(false)
    self.sprSelectHigh:setVisible(true)
    self.sprSleepHigh:setVisible(false)
  end
  local str = string.format(TwGetStr(111009), self.allDumplingCards[dumplingType].name)
  self.labUseTip:setString(str)
  self:refreshRewardInfo()
end
function prototype:onReturnBtnClicked(sender, event)
  SceneHelper:runWithScene("DumplingMain", self.rootNode)
end
function prototype:onBtnLowClicked(sender, event)
  self:chooseDumpling(DUMPLING_TYPE.LOW)
end
function prototype:onBtnMiddleClicked(sender, event)
  self:chooseDumpling(DUMPLING_TYPE.MIDDLE)
end
function prototype:onBtnHighClicked(sender, event)
  self:chooseDumpling(DUMPLING_TYPE.HIGH)
end
function prototype:onUseBtnClicked(sender, event)
  local id = Logic:Get("Dumpling"):getDumplingCardId(self.allDumplingCards[self.dumplingType].id)
  if id then
    Logic:Get("Dumpling"):PostCookDumpling(id)
  else
    Prompt:Confirm(self, "", 111013, self.gotoCopy, Prompt.PROMPT_TYPE.SELECT)
  end
end
function prototype:gotoCopy()
  Logic:Get("Dumpling"):gotoCopy()
end
function prototype:showHeroInfo(index)
  if self.rewards == nil or self.rewards.showIds == nil or table.empty(self.rewards) or index > #self.rewards.showIds then
    return
  end
  local goodsId = tonumber(self.rewards.showIds[index])
  if self.rewards.showTypes[index] == "HERO" then
    Logic:Get("HeroCardInfo"):OpenHeroInfoById(goodsId)
  elseif self.rewards.showTypes[index] == "FRAGMENT" then
    local fraConfig = Logic:Get("Compose"):kdbItemConfig(goodsId)
    if fraConfig ~= nil then
      Logic:Get("HeroCardInfo"):OpenHeroInfoById(fraConfig.baseId)
    end
  end
end
function prototype:onImgBtn1Clicked(sender, event)
  self:showHeroInfo(1)
end
function prototype:onImgBtn2Clicked(sender, event)
  self:showHeroInfo(2)
end
function prototype:onImgBtn3Clicked(sender, event)
  self:showHeroInfo(3)
end
function prototype:onImgBtn4Clicked(sender, event)
  self:showHeroInfo(4)
end
function prototype:onImgBtn5Clicked(sender, event)
  self:showHeroInfo(5)
end
function prototype:createCardImg(tabShowType, tabShowId)
  if not table.empty(tabShowType or {}) then
  elseif table.empty(tabShowId or {}) then
    return
  end
  for i = 1, 5 do
    local bgStr = string.format("img%d", i)
    local iconStr = string.format("imgBg%d", i)
    local data = {}
    if tabShowType[i] and tabShowId[i] and self[bgStr] and self[iconStr] then
      data.showId = tabShowId[i] or 1
      data.showType = tabShowType[i] or "OTHER"
      self:createImg(data, self[iconStr], self[bgStr])
    end
  end
end
function prototype:createImg(giftInfo, bgNode, IconNode)
  local spr = Logic:Get("Gift"):createImg(giftInfo)
  if spr ~= nil then
    bgNode:setDisplayFrame(spr:displayFrame())
    local strGoods = Logic:Get("Gift"):createGoodsImg(giftInfo)
    if strGoods ~= nil then
      local texture, textureRect = Logic:Get("HeroCardInfo"):GetCardTexture(strGoods)
      IconNode:setTexture(texture)
      IconNode:setTextureRect(textureRect)
    end
  end
end
function prototype:refreshRewardInfo()
  self:clear()
  self.rewards = Logic:Get("Dumpling"):getRewardsInfo(self.allDumplingCards[self.dumplingType].id)
  self:createCardImg(self.rewards.showTypes, self.rewards.showIds)
  for i, v in ipairs(self.rewards.counts) do
    local param = string.format("count%d", i)
    if self[param] then
      self[param]:setString(v)
    end
  end
end
function prototype:clear()
  local spr = CCSprite:create(CLARITY_PATH)
  if not spr then
    return
  end
  local bgSpr = CCSprite:create(DEFAULT_BG_PATH)
  if not bgSpr then
    return
  end
  for i = 1, 5 do
    local str = string.format("count%d", i)
    local iconStr = string.format("img%d", i)
    local bgStr = string.format("imgBg%d", i)
    if self[str] then
      self[str]:setString("")
    end
    if self[iconStr] then
      self[iconStr]:setDisplayFrame(spr:displayFrame())
    end
    if self[bgStr] then
      self[bgStr]:setDisplayFrame(bgSpr:displayFrame())
    end
  end
end
