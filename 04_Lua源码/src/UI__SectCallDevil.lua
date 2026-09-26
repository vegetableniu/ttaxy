module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
require("SceneHelper")
local CLARITY_PATH = "images/public/clarity05.png"
local DEFAULT_BG_PATH = "images/public/herobg.png"
function prototype:onEnter()
  self.numTable = {}
  self:calculateDemogCard()
  local _, id = Logic:Get("Sect"):GetDemogCardIdByName(TwGetStr(110055))
  self.ttfLow:setString(TwGetStr(110055) .. TwGetStr(110075, self.numTable[id] or 0))
  _, id = Logic:Get("Sect"):GetDemogCardIdByName(TwGetStr(110056))
  self.ttfMiddle:setString(TwGetStr(110056) .. TwGetStr(110075, self.numTable[id] or 0))
  _, id = Logic:Get("Sect"):GetDemogCardIdByName(TwGetStr(110057))
  self.ttfHigh:setString(TwGetStr(110057) .. TwGetStr(110075, self.numTable[id] or 0))
  self.baseIds = Logic:Get("Sect"):GetCardBaseIds()
  self.btnReturn:setVisible(true)
  self:initShow(false)
  self:chooseDevil("LOW")
  for i = 1, 5 do
    local str = string.format("ttfNum%d", i)
    if self[str] then
      self[str]:setStyle(kCCLabelTTFStyleOutline)
    end
  end
  Logic:Get("Sect"):On(Logic.Sect.EVT.ON_SUMMON_DEMOG, self:Event("OnSummonDemog"))
end
function prototype:initShow(enable)
  self.imgBorderLow:setVisible(enable)
  self.imgBorderMiddle:setVisible(enable)
  self.imgBorderHigh:setVisible(enable)
  self.imgLow:setScale(0.9523809523809523)
  self.imgMiddle:setScale(0.9523809523809523)
  self.imgHigh:setScale(0.9523809523809523)
end
function prototype:chooseDevil(demogType)
  self:initShow(false)
  self.demogType = demogType
  if demogType == "LOW" then
    self.ttfText:setString(TwGetStr(110040, TwGetStr(110043)))
    self.chooseCard = TwGetStr(110055)
    self.imgLow:setScale(1.05)
    self.imgBorderLow:setVisible(true)
  elseif demogType == "MIDDLE" then
    self.ttfText:setString(TwGetStr(110040, TwGetStr(110042)))
    self.chooseCard = TwGetStr(110056)
    self.imgMiddle:setScale(1.05)
    self.imgBorderMiddle:setVisible(true)
  elseif demogType == "HIGH" then
    self.ttfText:setString(TwGetStr(110040, TwGetStr(110041)))
    self.chooseCard = TwGetStr(110057)
    self.imgHigh:setScale(1.05)
    self.imgBorderHigh:setVisible(true)
  end
  self:refreshRewardInfo()
end
function prototype:onHighDevil(sender, event)
  self:chooseDevil("HIGH")
end
function prototype:onMiddleDevil(sender, event)
  self:chooseDevil("MIDDLE")
end
function prototype:onLowDevil(sender, event)
  self:chooseDevil("LOW")
end
function prototype:onCall(sender, event)
  local id = Logic:Get("Sect"):GetDemogCardIdByName(self.chooseCard)
  if id then
    Logic:Get("Sect"):PostSummonDemog(id)
  else
    Prompt:Confirm(self, "", 110054, nil, Prompt.PROMPT_TYPE.CONFIRM)
  end
end
function prototype:onBtnReturn(sender, event)
  if Logic:Get("Sect"):isFromDemogList() then
    SceneHelper:runWithScene("SectDemogList", self.rootNode)
  else
    SceneHelper:runWithScene("SectDemogMain", self.rootNode)
  end
end
function prototype:onBg(sender, event)
end
function prototype:OnSummonDemog(rewards)
  Logic:Get("Sect"):SetCheckedDemogInfo(Logic:Get("Sect"):GetSummonInfo())
  Logic:Get("Sect"):setCallDemog(true)
  SceneHelper:runWithScene("SectDemogMain", self.rootNode)
end
function prototype:calculateDemogCard()
  self.numTable = {}
  local cards = Logic:Get("Sect"):GetMenpaiCardInfo()
  if cards and not table.empty(cards) then
    for i = 1, #cards do
      local baseId = cards[i].baseId
      if self.numTable[baseId] == nil then
        self.numTable[baseId] = 0
      end
      self.numTable[baseId] = self.numTable[baseId] + 1
    end
  end
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
function prototype:onBtn1Clicked(sender, event)
  self:showHeroInfo(1)
end
function prototype:onBtn2Clicked(sender, event)
  self:showHeroInfo(2)
end
function prototype:onBtn3Clicked(sender, event)
  self:showHeroInfo(3)
end
function prototype:onBtn4Clicked(sender, event)
  self:showHeroInfo(4)
end
function prototype:onBtn5Clicked(sender, event)
  self:showHeroInfo(5)
end
function prototype:getRewardsInfo()
  self.rewards = {}
  local sectInfo = Logic:Get("Sect"):getSectInfo()
  for i = 1, KFDBGetRecordAmt("DemogConfig") do
    local rec = KFDBGetRecordByIdx("DemogConfig", i)
    if rec and rec.demogType == self.demogType and rec.menpaiLevel == sectInfo.level then
      rec.showTypes = json.decode(rec.showTypeId or "[]")
      rec.showIds = json.decode(rec.showIds or "[]")
      rec.counts = json.decode(rec.counts or "[]")
      self.rewards = rec
      break
    end
  end
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
  self:getRewardsInfo()
  self:createCardImg(self.rewards.showTypes, self.rewards.showIds)
  for i, v in ipairs(self.rewards.counts) do
    local param = string.format("ttfNum%d", i)
    if self[param] then
      self[param]:setString(v)
    end
  end
end
function prototype:clear()
  local spr = CCSprite:create(CLARITY_PATH)
  if spr == nil then
    return
  end
  local bgSpr = CCSprite:create(DEFAULT_BG_PATH)
  if not bgSpr then
    return
  end
  for i = 1, 5 do
    local iconStr = string.format("img%d", i)
    local bgStr = string.format("imgBg%d", i)
    local param = string.format("ttfNum%d", i)
    if self[bgStr] then
      self[bgStr]:setDisplayFrame(bgSpr:displayFrame())
    end
    if self[iconStr] then
      self[iconStr]:setDisplayFrame(spr:displayFrame())
    end
    if self[param] then
      self[param]:setString("")
    end
  end
end
