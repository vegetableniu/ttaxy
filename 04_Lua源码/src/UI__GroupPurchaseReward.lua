module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
local CLARITY_PATH = "images/public/clarity05.png"
local LEFT_BORDER = "images/groupChase/leftBorder.png"
local MIDDLE_BORDER = "images/groupChase/middleBorder.png"
local RIGHT_BORDER = "images/groupChase/rightBorder.png"
local PROG1 = "images/groupChase/prog1.png"
local PROG2 = "images/groupChase/prog2.png"
local PROG3 = "images/groupChase/prog3.png"
function prototype:onEnter()
  for i = 1, 3 do
    local str = string.format("labText%d", i)
    local count = string.format("ttfCount%d", i)
    if self[str] then
      self[str]:setStyle(kCCLabelTTFStyleOutline)
    end
    if self[count] then
      self[count]:setStyle(kCCLabelTTFStyleOutline)
    end
  end
end
function prototype:refresh(pageNo, detailsInfo)
  local _, rewardNum = Logic:Get("GroupPurchase"):getCanGetRewardInfo(detailsInfo.id)
  rewardNum = rewardNum or 0
  self.pageNo = pageNo
  self.rewards = detailsInfo
  self.sprGoods:setVisible(pageNo == 1)
  self.imgBorder0:setVisible(pageNo ~= 1)
  self.progress0:setVisible(pageNo ~= 1)
  if pageNo ~= 1 then
    local offset = 3 * ((self.pageNo or 1) - 1)
    local state = Logic:Get("GroupPurchase"):getRewardState(self.rewards.id, offset - 1, self.rewards.region[offset])
    local showFlag = Logic.GroupPurchase.REWARD_TYPE.CAN_GET == state or Logic.GroupPurchase.REWARD_TYPE.HAS_GET == state
    self.progress0:setVisible(showFlag)
  end
  self:refreshRewardInfo()
  self:refreshBorderProg()
end
function prototype:createCardImg(tabShowType, tabShowId)
  if not table.empty(tabShowType or {}) then
  elseif table.empty(tabShowId or {}) then
    return
  end
  local offset = 3 * ((self.pageNo or 1) - 1)
  for i = 0, 3 do
    local bgStr = string.format("img%d", i)
    local iconStr = string.format("imgBg%d", i)
    local data = {}
    if tabShowType[offset + i] and tabShowId[offset + i] and self[bgStr] and self[iconStr] then
      data.showId = tabShowId[offset + i] or 1
      if tonumber(data.showId) == 0 and tabShowType[offset + i] ~= "HERO" then
        data.showId = "4"
      end
      data.showType = tabShowType[offset + i] or "OTHER"
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
  self:createCardImg(self.rewards.showTypes, self.rewards.showIds)
  self:refreshRewardState()
  local offset = 3 * ((self.pageNo or 1) - 1)
  for i = 0, 3 do
    local param = string.format("ttfCount%d", i)
    if self[param] then
      self[param]:setString(self.rewards.counts[offset + i] or "")
    end
  end
  local num = tonumber(self.rewards.showIds[1] or "2")
  if not num or num < 2 or num > 5 then
    num = 2
  end
  local img = string.format("images/groupChase/present_%d.png", num or 1)
  local imgBg = string.format("data/MiddleBg/captain_%d.png", num or 1)
  if self.pageNo == 1 then
    local spr = CCSprite:create(img)
    if spr and self.img1 then
      self.img1:setDisplayFrame(spr:displayFrame())
    end
    local bgSpr = CCSprite:create(imgBg)
    if bgSpr and self.imgBg1 then
      self.imgBg1:setDisplayFrame(bgSpr:displayFrame())
    end
  end
end
function prototype:refreshRewardState()
  local offset = 3 * ((self.pageNo or 1) - 1)
  for i = 0, 3 do
    local lay = string.format("lay%d", i)
    local hasGet = string.format("sprHas%d", i)
    local canGet = string.format("sprGet%d", i)
    local labText = string.format("labText%d", i)
    local prog = string.format("progress%d", i)
    local state = Logic:Get("GroupPurchase"):getRewardState(self.rewards.id, offset + i - 1, self.rewards.region[offset + i - 1])
    if Logic.GroupPurchase.REWARD_TYPE.NONE == state then
      self[lay]:setVisible(true)
      self[prog]:setVisible(false)
      self[labText]:setVisible(true)
      self[labText]:setString(tostring(self.rewards.region[offset + i - 1] or 0))
      self[hasGet]:setVisible(false)
      self[canGet]:setVisible(false)
    elseif Logic.GroupPurchase.REWARD_TYPE.CAN_GET == state then
      self[lay]:setVisible(false)
      self[prog]:setVisible(true)
      self[labText]:setVisible(false)
      self[hasGet]:setVisible(false)
      self[canGet]:setVisible(true)
    elseif Logic.GroupPurchase.REWARD_TYPE.HAS_GET == state then
      self[lay]:setVisible(false)
      self[prog]:setVisible(true)
      self[labText]:setVisible(false)
      self[hasGet]:setVisible(true)
      self[canGet]:setVisible(false)
    else
      if self.pageNo == 1 and i == 1 then
        self[prog]:setVisible(true)
      end
      self[lay]:setVisible(false)
      self[labText]:setVisible(false)
      self[hasGet]:setVisible(false)
      self[canGet]:setVisible(false)
    end
  end
end
function prototype:refreshBorderProg()
  local spr = CCSprite:create(CLARITY_PATH)
  local borSpr1 = CCSprite:create(LEFT_BORDER)
  local borSpr2 = CCSprite:create(MIDDLE_BORDER)
  local borSpr3 = CCSprite:create(RIGHT_BORDER)
  local progSpr1 = CCSprite:create(PROG1)
  local progSpr2 = CCSprite:create(PROG2)
  local progSpr3 = CCSprite:create(PROG3)
  local offset = 3 * ((self.pageNo or 1) - 1)
  for i = 1, 3 do
    local borderStr = string.format("imgBorder%d", i)
    local progStr = string.format("progress%d", i)
    if self.rewards.showIds and offset + i > #self.rewards.region + 1 then
      self[borderStr]:setDisplayFrame(spr:displayFrame())
      self[progStr]:setDisplayFrame(spr:displayFrame())
    elseif offset == 0 and i == 1 then
      self[borderStr]:setDisplayFrame(borSpr1:displayFrame())
      self[progStr]:setDisplayFrame(progSpr1:displayFrame())
    elseif self.rewards.showIds and offset + i == #self.rewards.region + 1 then
      self[borderStr]:setDisplayFrame(borSpr3:displayFrame())
      self[progStr]:setDisplayFrame(progSpr3:displayFrame())
    else
      self[borderStr]:setDisplayFrame(borSpr2:displayFrame())
      self[progStr]:setDisplayFrame(progSpr2:displayFrame())
    end
  end
end
function prototype:clear()
  local spr = CCSprite:create(CLARITY_PATH)
  if not spr then
    return
  end
  for i = 0, 3 do
    local strBg = string.format("imgBg%d", i)
    local str = string.format("img%d", i)
    local count = string.format("ttfCount%d", i)
    local lay = string.format("lay%d", i)
    local sprGet = string.format("sprGet%d", i)
    local labText = string.format("labText%d", i)
    if self[strBg] then
      self[strBg]:setDisplayFrame(spr:displayFrame())
    end
    if self[str] then
      self[str]:setDisplayFrame(spr:displayFrame())
    end
    if self[count] then
      self[count]:setString("")
    end
    if self[labText] then
      self[labText]:setString("")
    end
    if self[str] then
      self[lay]:setVisible(false)
    end
    if self[str] then
      self[sprGet]:setVisible(false)
    end
  end
end
function prototype:showHeroInfo(index)
  local offset = 3 * ((self.pageNo or 1) - 1)
  index = offset + index
  if self.rewards == nil or self.rewards.showIds == nil or table.empty(self.rewards) or index > #self.rewards.showIds then
    return
  end
  local goodsId = tonumber(self.rewards.region[index - 1])
  local typeTab = {}
  local canGetArr = Logic:Get("GroupPurchase"):getCanGetRewardInfo(self.rewards.id)
  if not goodsId then
    return
  end
  local state = Logic:Get("GroupPurchase"):getRewardState(self.rewards.id, index - 1, self.rewards.region[index - 1])
  if state ~= Logic.GroupPurchase.REWARD_TYPE.CAN_GET then
    return
  end
  local hasBuy = Logic:Get("GroupPurchase"):hasBuy(self.rewards.id)
  if not hasBuy then
    local wallet = Logic:Get("PlayerInfo"):GetPlayerMoney()
    local xianyu = wallet.gift + wallet.inter + wallet.gold
    if xianyu < self.rewards.now then
      Logic:Get("SureConfirm").btnText.ok = TwGetStr(104003)
      Prompt:Confirm(Logic:Get("Main"), "", 105316, Logic:Get("Main").GotoRecharge, Prompt.PROMPT_TYPE.SELECT)
      return
    end
    Logic:Get("SureConfirm").btnText.ok = TwGetStr(105219)
    Prompt:Confirm(self, "", TwGetStr(111050, self.rewards.now), self.buyGoods, Prompt.PROMPT_TYPE.SELECT)
    return
  end
  for i, v in ipairs(canGetArr) do
    if goodsId >= v then
      typeTab[#typeTab + 1] = v
    else
      break
    end
  end
  Logic:Get("GroupPurchase"):PostDrawReward(self.rewards.id, typeTab)
end
function prototype:buyGoods()
  Logic:Get("GroupPurchase"):PostBuyGoods(self.rewards.id)
end
function prototype:onBtn1Clicked(sender, event)
  if self.pageNo == 1 then
    Logic:Get("GroupPurchase"):setChooseDetails(self.rewards)
    SceneHelper:pushScene("GroupPurchasePopWin", self.rootNode)
  else
    self:showHeroInfo(1)
  end
end
function prototype:onBtn2Clicked(sender, event)
  self:showHeroInfo(2)
end
function prototype:onBtn3Clicked(sender, event)
  self:showHeroInfo(3)
end
