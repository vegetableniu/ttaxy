module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
local ITEM_WIDTH, ITEM_HEIGHT = 195, 235
local WIN_WIDTH, WIN_HEIGHT = 540, 30
function prototype:onEnter()
  super.onEnter(self)
  self.title_ttf:setStyle(kCCLabelTTFStyleOutline)
  self.ttfTip:setStyle(kCCLabelTTFStyleOutline)
  self.ttfResetTip:setStyle(kCCLabelTTFStyleOutline)
  self.ttfTimeOverTip:setStyle(kCCLabelTTFStyleOutline)
  self.sprSelect:setVisible(false)
  self:createLotterysImages()
  self.tableViewControl = TableViewEx.prototype:createList(self, self.ttfListNode, 1, true)
  self.ttfListNode:addChild(self.tableViewControl.tableView)
  self.tableViewControl.tableView:setDirection(kCCScrollViewDirectionVertical)
  local giftInfo = Logic:Get("Gift"):GetActivityGift()
  self.title_ttf:setString(giftInfo.name)
  self.title_ttf:setColor(ccc3(255, 183, 18))
  self.ttfTip:setString(TwGetStr(111343))
  Logic:Get("FoolsDay"):getCurTime()
  Logic:Get("FoolsDay"):PostGetInfo()
  Logic:Get("FoolsDay"):On(Logic.FoolsDay.EVT.GET_INFO_OK, self:Event("refresh"))
  Logic:Get("FoolsDay"):On(Logic.FoolsDay.EVT.FLOP_OK, self:Event("flopCardOK"))
end
function prototype:refresh()
  self.sprSelect:setVisible(false)
  local cardsMap = Logic:Get("FoolsDay"):getCardsMap()
  local resetTimes = Logic:Get("FoolsDay"):getResetTimes()
  local maxResetTimes = KFDBGetRecord("ConfigValue", "FOOLSDAY:PAY_RESET_LIMIT")
  maxResetTimes = maxResetTimes and tonumber(maxResetTimes.content) or 0
  local freeResetTimes = KFDBGetRecord("ConfigValue", "FOOLSDAY:FREE_RESET_LIMIT")
  freeResetTimes = freeResetTimes and tonumber(freeResetTimes.content) or 0
  for i = 1, 8 do
    local strItem = string.format("item%d", i)
    if self[strItem] then
      if resetTimes == maxResetTimes + freeResetTimes and #table.values(cardsMap) == 8 then
        self[strItem]:setVisible(false)
      else
        self[strItem]:setVisible(true)
        self[strItem]:setCardInfoByBaseId(cardsMap[i])
      end
    end
  end
  self.tableViewControl:RequireUpdateWithoutAnimat(1)
  local resetCost = Logic:Get("FoolsDay"):getCurResetCost()
  local strTip = resetTimes < freeResetTimes and TwGetStr(111344) or TwGetStr(111350, resetCost)
  if resetTimes == maxResetTimes + freeResetTimes then
    strTip = TwGetStr(111352)
    self.btnReSet:setEnabled(false)
    if #table.values(cardsMap) == 8 then
      self.sprReset:setVisible(false)
      self.btnReSet:setVisible(false)
      self.ttfResetTip:setVisible(false)
      self.rotateCardTip:setVisible(false)
      self.ttfTimeOverTip:setString(TwGetStr(111353))
      return
    end
  end
  self.ttfResetTip:setString(strTip)
  self:setRotateCardTip()
end
function prototype:setRotateCardTip()
  local freeFlopTimes = KFDBGetRecord("ConfigValue", "FOOLSDAY:FREE_FLOP_LIMIT")
  freeFlopTimes = freeFlopTimes and tonumber(freeFlopTimes.content) or 0
  local flopTimes = Logic:Get("FoolsDay"):getFlopTimes()
  if freeFlopTimes <= flopTimes then
    self.rotateCardTip:setString(TwGetStr(111354, Logic:Get("FoolsDay"):getCurFlopCost()))
    return
  end
  local freeTimesStr = TwGetStr(111342, freeFlopTimes <= flopTimes and 0 or freeFlopTimes - flopTimes, freeFlopTimes)
  self.rotateCardTip:setString(TwGetStr(111341, freeTimesStr))
end
function prototype:setComboEffect()
  local finishCards = Logic:Get("FoolsDay"):getFinishCombos()
  for i, v in pairs(finishCards) do
    local strItem = string.format("item%d", v)
    if self[strItem] then
      self[strItem]:showShanEffect(i)
    end
  end
end
function prototype:clearComboEffect()
  for i = 1, 8 do
    local strItem = string.format("item%d", i)
    if self[strItem] then
      self[strItem]:clearShanEffect()
    end
  end
end
function prototype:flopCardOK(index, baseId, strTip)
  local strItem = string.format("item%d", index)
  if self[strItem] and baseId then
    self[strItem]:rotateCard(baseId)
  end
  self.index = index
  self.tipTab = self.tipTab or {}
  if strTip then
    table.insert(self.tipTab, strTip)
    self:setAllIconTouchEnabled(false)
  end
  if not self.eventTracer:Exist("showFlopResult") then
    Singleton(Timer):After(350, self:Event("showFlopResult"))
  end
end
function prototype:showFlopResult()
  self:setComboEffect()
  self:setSelectPos(self.index)
  self.tableViewControl:RequireUpdateWithoutAnimat(1)
  self:setRotateCardTip()
  if not self.eventTracer:Exist("showFlopResultDlg") then
    Singleton(Timer):After(1000, self:Event("showFlopResultDlg"))
  end
end
function prototype:showFlopResultDlg()
  if not self.tipTab[1] then
    return
  end
  local dlgStrTip = Logic:Get("FoolsDay"):getLastFinishCombosTip()
  dlgStrTip = dlgStrTip .. TwGetStr(111357) .. self.tipTab[1]
  if Logic:Get("FoolsDay"):getAutoResetFlag() then
    local resetTip = TwGetStr(111356)
    dlgStrTip = dlgStrTip .. resetTip
  end
  table.remove(self.tipTab, 1)
  Prompt:Confirm(self, "", dlgStrTip, self.refreshImages, Prompt.PROMPT_TYPE.CONFIRM)
end
function prototype:refreshImages()
  self:clearComboEffect()
  self:setAllIconTouchEnabled(true)
  local cardsMap = Logic:Get("FoolsDay"):getCardsMap()
  if table.empty(cardsMap) then
    self:refresh()
  end
end
function prototype:createLotterysImages()
  for i = 1, 8 do
    local xPos, yPos = 30 + (ITEM_WIDTH * 0.6 + 20) * ((i - 1) % 4), 10 + (ITEM_HEIGHT * 0.6 + 10) * math.floor(i / 5)
    local strItem = string.format("item%d", i)
    self[strItem] = Tw.Controller:load("FoolsDayActivityIcon", self.rootNode)
    self[strItem]:setAnchorPoint(CCPointMake(0, 0))
    self[strItem]:setScale(0.6)
    self[strItem]:setPosition(CCPointMake(xPos, yPos))
    self[strItem]:refreshInfo(i)
    self[strItem]:setVisible(false)
    self.subNode:addChild(self[strItem])
  end
end
function prototype:setSelectPos(index)
  local orgXPos = self.subNode:getPositionX()
  local orgYPos = self.subNode:getPositionY()
  self.sprSelect:setVisible(true)
  local strItem = string.format("item%d", index)
  if self[strItem] == nil then
    return
  end
  self.sprSelect:setPosition(CCPointMake(orgXPos + self[strItem]:getPositionX() - 8, orgYPos + self[strItem]:getPositionY() - 13))
end
function prototype:setAllIconTouchEnabled(bEnabled)
  for i = 1, 8 do
    local strItem = string.format("item%d", i)
    if self[strItem] then
      self[strItem]:setTouchEnabled(bEnabled)
    end
  end
end
function prototype:onBtnReturnClicked(sender, event)
  SceneHelper:runWithScene("GiftActivityList", self.rootNode)
end
function prototype:onBtnShowClicked(sender, event)
  Logic:Get("Raffle"):setTreasureShowStr("FoolsdayShow")
  SceneHelper:runWithScene("GiftTreasureShow", self.rootNode)
end
function prototype:onBtnResetClicked(sender, event)
  local resetTimes = Logic:Get("FoolsDay"):getResetTimes()
  local freeResetTimes = KFDBGetRecord("ConfigValue", "FOOLSDAY:FREE_RESET_LIMIT")
  freeResetTimes = freeResetTimes and tonumber(freeResetTimes.content) or 0
  local jade = Logic:Get("PlayerInfo"):GetPlayerAllJade()
  local resetCost = Logic:Get("FoolsDay"):getCurResetCost()
  if resetTimes >= freeResetTimes and jade < resetCost then
    Logic:Get("Main"):PromptCharge()
    return
  end
  local maxResetTimes = KFDBGetRecord("ConfigValue", "FOOLSDAY:PAY_RESET_LIMIT")
  maxResetTimes = maxResetTimes and tonumber(maxResetTimes.content) or 0
  local strTip = resetTimes >= freeResetTimes and TwGetStr(111346, resetCost, maxResetTimes + freeResetTimes - resetTimes) or TwGetStr(111347)
  Prompt:ConfirmRecord(self, "", strTip, self.reset, Prompt.PROMPT_TYPE.SELECT, nil, Logic.SureConfirm.RECORD_TYPE.FOOLSDAY_RESET)
end
function prototype:reset()
  Logic:Get("FoolsDay"):PostReset()
end
function prototype:cellSizeForTable()
  return CCSizeMake(WIN_WIDTH, WIN_HEIGHT)
end
function prototype:tableCellAtIndex(table, index, cell, curPage)
  local comboData = Logic:Get("FoolsDay"):getComboInfo()
  if not cell then
    cell = CCTableViewCellEx:create()
    local subScene = Tw.Controller:load("FoolsDayActivityItem", self.rootNode)
    subScene:refreshInfo(comboData[index + 1])
    cell:addChild(subScene, 0, 2)
  else
    cell:getChildByTag(2):refreshInfo(comboData[index + 1])
  end
  return cell
end
function prototype:numberOfCellsInTableView(curPage)
  local comboData = Logic:Get("FoolsDay"):getComboInfo()
  return #comboData
end
function prototype:tableCellTouched(table, cell)
  local idx = tolua.cast(cell, "CCTableViewCellEx"):getIdx()
end
function prototype:tablePageTurn(curPage)
  self.tableViewControl:RequireUpdate()
end
