module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
local PROG_BG_PATH = "images/Deposit/progBg.png"
local CURR_PROG_PATH = "images/Deposit/progGreen.png"
local DESC_ID = 1017
function prototype:initialize(...)
  super.initialize(self, ...)
end
function prototype:dispose(...)
  super.dispose(self)
end
function prototype:onEnter()
  self.ttfDesc:setStyle(kCCLabelTTFStyleOutline)
  self.ttfCurDay:setStyle(kCCLabelTTFStyleOutline)
  local rec = KFDBGetRecord("LanguageSetting", DESC_ID)
  local strDesc = ReplaceStringTab(rec.content)
  self.ttfDesc:setString(strDesc)
  self.ttfDesc:setHorizontalAlignment(kCCVerticalTextAlignmentCenter)
  local rec = KFDBGetRecord("ConfigValue", "DEPOSIT:MIN_DEPOSIT_DAYS")
  self.minDays = rec and tonumber(rec.content) or 0
  Logic:Get("AniMgr"):RunCCBAni("UI/uizhaocaijingbao", self.sprCursor, ccp(38, -2), 1, nil, nil, nil, -1)
  self:initInfo()
end
function prototype:initInfo()
  self.depositInfo = Logic:Get("Deposit"):getDepositInfo()
  self.kindsofRates = Logic:Get("Deposit"):getKindsofRates()
  for i = 1, 3 do
    local strProg = string.format("prog%d", i)
    if self[strProg] then
      self[strProg]:createProgress(PROG_BG_PATH, CURR_PROG_PATH)
    end
  end
  local curDayCount = self.depositInfo and self.depositInfo.depositDay and self.depositInfo.depositDay or 0
  for i = 1, 4 do
    local strItem = string.format("item%d", i)
    if self[strItem] then
      local dayCount = self.kindsofRates and self.kindsofRates[i] and self.kindsofRates[i].id or 0
      self[strItem]:refreshInfo(i, dayCount or 0, curDayCount)
    end
  end
  for i = 1, 4 do
    local strPercent = string.format("percent%d", i)
    if self[strPercent] then
      local rate = self.kindsofRates and self.kindsofRates[i] and self.kindsofRates[i].rate or 0
      rate = rate or 0
      if rate < 0 then
        rate = 0 or rate
      end
      self[strPercent]:create(0, "BLUE_NUM")
      self[strPercent]:setAlign("RIGHT", "CENTER")
      self[strPercent]:setValue(rate)
    end
  end
  local depositJades = self.depositInfo and self.depositInfo.amount and self.depositInfo.amount or 0
  for i = 1, 4 do
    local strJade = string.format("ttfJade%d", i)
    if self[strJade] then
      local rate = self.kindsofRates and self.kindsofRates[i] and self.kindsofRates[i].rate or 0
      rate = rate and rate / 100 or 1
      self[strJade]:setStyle(kCCLabelTTFStyleOutline)
      self[strJade]:setString(TwGetStr(111093, depositJades * rate))
    end
  end
  self:setCursorInfo(curDayCount)
  self:setBtnStateAndPos(curDayCount)
  self:setProgressInfo(curDayCount)
end
function prototype:setCursorInfo(dayCount)
  self.ttfCurDay:setString(TwGetStr(111094, dayCount))
  local isSpecial = Logic:Get("Deposit"):isSpecialDay(dayCount)
  self.sprCursor:setVisible(not isSpecial)
  self.ttfCurDay:setVisible(not isSpecial)
  if not isSpecial then
    local prevInfo, nextInfo = Logic:Get("Deposit"):getBothInfosByCurDay(dayCount)
    if prevInfo.count == nil or prevInfo.count < self.minDays or nextInfo.count == nil then
      self.sprCursor:setVisible(false)
      self.ttfCurDay:setVisible(false)
      return
    end
    local strPrevPos = string.format("pos%d", prevInfo.index)
    local strNextPos = string.format("pos%d", nextInfo.index)
    if not self[strPrevPos] or not self[strNextPos] then
      return
    end
    local prevXPos, prevYPos = self[strPrevPos]:getPosition()
    local nextXPos, nextYPos = self[strNextPos]:getPosition()
    local totalCounts = nextInfo.count - prevInfo.count
    local curCounts = dayCount - prevInfo.count
    local deltaX = nextXPos - prevXPos
    local deltaY = nextYPos - prevYPos
    local xPos = prevXPos + deltaX * (curCounts / totalCounts)
    local yPos = prevYPos + deltaY * (curCounts / totalCounts) - 10
    self.sprCursor:setPosition(ccp(xPos, yPos))
    yPos = yPos + 30
    self.ttfCurDay:setPosition(ccp(xPos, yPos))
  end
end
function prototype:setBtnStateAndPos(dayCount)
  local rewardIndex = Logic:Get("Deposit"):getIndexByCurDay(dayCount)
  self.btnGet:setEnabled(rewardIndex ~= 0)
  self.btnCover:setVisible(rewardIndex == 0)
  local strJade = string.format("ttfJade%d", rewardIndex == 0 and 1 or rewardIndex)
  if self[strJade] then
    local xPos, yPos = self[strJade]:getPosition()
    yPos = yPos - 40
    self.sprGet:setPosition(ccp(xPos, yPos))
    self.btnGet:setPosition(ccp(xPos, yPos))
  end
end
function prototype:setProgressInfo(dayCount)
  local rewardIndex = Logic:Get("Deposit"):getIndexByCurDay(dayCount)
  if rewardIndex > 4 then
    rewardIndex = 4 or rewardIndex
  end
  if rewardIndex and rewardIndex > 1 then
    for i = 1, rewardIndex - 1 do
      local strProg = string.format("prog%d", i)
      if self[strProg] then
        self[strProg]:setValue(100)
      end
    end
  end
  if not rewardIndex or rewardIndex <= 1 and rewardIndex >= 3 then
    return
  end
  local prevInfo, nextInfo = Logic:Get("Deposit"):getBothInfosByCurDay(dayCount)
  if prevInfo.count == nil or prevInfo.count < self.minDays or nextInfo.count == nil then
    return
  end
  local totalCounts = nextInfo.count - prevInfo.count
  local curCounts = dayCount - prevInfo.count
  local percent = math.floor(curCounts / totalCounts * 100)
  local strProg = string.format("prog%d", rewardIndex)
  if self[strProg] then
    self[strProg]:setValue(percent)
  end
end
function prototype:getWealth()
  Logic:Get("Deposit"):PostWithDraw()
end
function prototype:onBtnGetClicked(sender, event)
  local days = self.depositInfo and self.depositInfo.depositDay and self.depositInfo.depositDay or 0
  if days < self.minDays then
    Prompt:Tip(TwGetStr(111089, days, self.minDays))
    return
  end
  local days = self.depositInfo and self.depositInfo.depositDay and self.depositInfo.depositDay or 0
  local nextRate, nextDays = Logic:Get("Deposit"):getNextRateInfoByDays(days)
  if days < nextDays then
    local depositJades = self.depositInfo and self.depositInfo.amount and self.depositInfo.amount or 0
    Prompt:Confirm(self, "", TwGetStr(111087, days, nextDays - days, depositJades * nextRate / 100), self.getWealth, Prompt.PROMPT_TYPE.SELECT)
    return
  end
  self:getWealth()
end
