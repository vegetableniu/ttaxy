module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
function prototype:onEnter()
  self.title_ttf:setStyle(kCCLabelTTFStyleOutline)
  self.ttfTime:setStyle(kCCLabelTTFStyleOutline)
  self.ttfTimes:setStyle(kCCLabelTTFStyleOutline)
  local giftInfo = Logic:Get("EquipGift"):getActivityInfo()
  self.title_ttf:setColor(ccc3(255, 183, 18))
  self.title_ttf:setString(giftInfo.name)
  self.ani = Logic:Get("AniMgr"):NewCCB("UI/UIcz", self.sprCharge, ccp(35, 19), 0, nil, nil)
  if self.ani then
    self.ani:RunAni()
  end
  self.id = giftInfo.id
  self:setInfo()
  Logic:Get("EquipGift"):PostLoadEquipGift(giftInfo.id)
  Logic:Get("EquipGift"):On(Logic.EquipGift.EVT.BUY_GIFT_OVER, self:Event("jumpToPrevUI"))
  Logic:Get("EquipGift"):On(Logic.EquipGift.EVT.BUY_GIFT_OK, self:Event("refreshTimes"))
  self:refreshCountdown()
  if not self.eventTracer:Exist("refreshCountdown") then
    Singleton(Timer):Repeat(1000, self:Event("refreshCountdown"))
  end
  local goodArr = Logic:Get("EquipGift"):getGiftArray(giftInfo.id)
  if #goodArr == 0 then
    return
  end
  local goodsInfo = Logic:Get("EquipGift"):getGiftInfo(tonumber(goodArr[1]))
  self.nodePrice:setString(TwGetStr(111602, goodsInfo.cost or 0))
end
function prototype:clear()
  for i = 1, 6 do
    local strItem = string.format("item%d", i)
    if self[strItem] then
      self[strItem]:setVisible(false)
    end
    local strRare = string.format("select%d", i)
    if self[strRare] then
      self[strRare]:setVisible(false)
    end
  end
end
function prototype:setInfo()
  self:clear()
  local goodArr = Logic:Get("EquipGift"):getGiftArray(self.id)
  if #goodArr == 0 then
    return
  end
  local goodsInfo = Logic:Get("EquipGift"):getGiftInfo(tonumber(goodArr[1]))
  if goodsInfo.showType == nil or table.empty(goodsInfo.showType) then
    return
  end
  for i, v in ipairs(goodsInfo.showType) do
    local strItem = string.format("item%d", i)
    if self[strItem] then
      local giftInfo = {}
      giftInfo.showType = goodsInfo.showType[i] or ""
      giftInfo.showId = tonumber(goodsInfo.showIds[i]) or 1
      giftInfo.amount = goodsInfo.counts[i]
      self[strItem]:ReFreshByGift(giftInfo)
      self[strItem]:setVisible(true)
    end
    local strRare = string.format("select%d", i)
    if self[strRare] and goodsInfo.rare[i] and tonumber(goodsInfo.rare[i]) == 1 then
      self[strRare]:setVisible(true)
    end
  end
end
function prototype:refreshCountdown()
  local giftInfo = Logic:Get("EquipGift"):getActivityInfo()
  local endTime = giftInfo.endTime or Logic:Get("System"):GetTime() * 1000
  local diffTime = Logic:Get("System"):DiffTime(endTime / 1000)
  local resetTime = Logic:Get("System"):SecToDay(diffTime)
  if resetTime and diffTime > 0 then
    local str = string.format("%02d:%02d:%02d:%02d", resetTime.day or 0, resetTime.hour or 0, resetTime.min or 0, resetTime.sec or 0)
    self.ttfTime:setString(str)
  else
    self.ttfTime:setString("00:00:00")
  end
end
function prototype:onBtnReturn(sender, event)
  if Logic:Get("EquipGift"):isFromMallFlag() then
    SceneHelper:runWithScene("Mall", self.rootNode)
  else
    SceneHelper:runWithScene("GiftActivityList", self.rootNode)
  end
end
function prototype:onBtnRecharge(sender, event)
  Logic:Get("Main"):GotoRecharge()
end
function prototype:onBtnBuy(sender, event)
  local goodArr = Logic:Get("EquipGift"):getGiftArray(self.id)
  if #goodArr == 0 then
    return
  end
  local goodsInfo = Logic:Get("EquipGift"):getGiftInfo(tonumber(goodArr[1]))
  if table.empty(goodsInfo) then
    return
  end
  local str = ""
  local times, totalTimes = Logic:Get("EquipGift"):getTimesInfo(tonumber(goodArr[1]))
  if goodsInfo.buyLimit and 0 < goodsInfo.buyLimit then
    if times >= goodsInfo.buyLimit then
      Prompt:Tip(TwGetStr(111604))
      return
    else
      str = TwGetStr(111606, goodsInfo.buyLimit - times)
    end
  end
  if goodsInfo.totalbuyLimit and 0 < goodsInfo.totalbuyLimit then
    if totalTimes >= goodsInfo.totalbuyLimit then
      Prompt:Tip(TwGetStr(111605))
      return
    else
      str = str .. TwGetStr(111607, goodsInfo.totalbuyLimit - totalTimes)
    end
  end
  local jade = Logic:Get("PlayerInfo"):GetPlayerAllJade()
  if jade < goodsInfo.cost then
    Logic:Get("Main"):PromptCharge()
    return
  end
  str = str .. TwGetStr(111603, goodsInfo.cost or 0)
  Prompt:Confirm(self, "", str, self.buyGift, Prompt.PROMPT_TYPE.SELECT)
end
function prototype:buyGift()
  if not self.id then
    return
  end
  local goodArr = Logic:Get("EquipGift"):getGiftArray(self.id)
  if #goodArr == 0 then
    Prompt:Fail(TwGetStr(111609))
    return
  end
  Logic:Get("EquipGift"):PostBuyEquipGift(self.id, goodArr[1])
end
function prototype:jumpToPrevUI()
  if Logic:Get("EquipGift"):isFromMallFlag() then
    SceneHelper:runWithScene("Mall", self.rootNode)
  else
    SceneHelper:runWithScene("GiftActivityList", self.rootNode)
  end
end
function prototype:refreshTimes()
  self.sprTimes:setVisible(false)
  self.ttfTimes:setString("")
  local goodArr = Logic:Get("EquipGift"):getGiftArray(self.id)
  if #goodArr == 0 then
    return
  end
  local goodsInfo = Logic:Get("EquipGift"):getGiftInfo(tonumber(goodArr[1]))
  if table.empty(goodsInfo) then
    return
  end
  local _, totalTimes = Logic:Get("EquipGift"):getTimesInfo(tonumber(goodArr[1]))
  if goodsInfo.totalbuyLimit and 0 < goodsInfo.totalbuyLimit then
    self.sprTimes:setVisible(true)
    self.ttfTimes:setString(tostring(goodsInfo.totalbuyLimit - totalTimes))
  end
end
