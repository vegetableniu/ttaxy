module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
local WIN_WIDTH, WIN_HEIGHT = 450, 120
function prototype:onEnter()
  self.orgPrice:setStyle(kCCLabelTTFStyleOutline)
  self.groupPrice:setStyle(kCCLabelTTFStyleOutline)
  self.labNum:setStyle(kCCLabelTTFStyleOutline)
end
function prototype:refreshInfo(goodDetails)
  self.goodDetails = goodDetails
  local curTime = Logic:Get("System"):GetTime()
  local regNum = math.floor((curTime - goodDetails.startTime) / 3600)
  regNum = regNum % 24
  self.orgPrice:setString(TwGetStr(111051, goodDetails.original or 0))
  self.groupPrice:setString(TwGetStr(111052, goodDetails.now or 0))
  self.labNum:setString(goodDetails.buyCounts[regNum + 1] or 0)
  local hasBuy = Logic:Get("GroupPurchase"):hasBuy(goodDetails.id)
  self.btnBuy:setVisible(not hasBuy)
  self.sprBuy:setVisible(not hasBuy)
  self.btnReward:setVisible(hasBuy)
  self.sprReward:setVisible(hasBuy)
  self:initRewards()
  local noRewards = Logic:Get("GroupPurchase"):isNoReward(goodDetails.id)
  self.btnReward:setVisible(not noRewards)
  self.sprReward:setVisible(not noRewards)
end
function prototype:initRewards()
  local canGetArr, rewardNum = Logic:Get("GroupPurchase"):getCanGetRewardInfo(self.goodDetails.id)
  if self.tableViewControl == nil then
    self.maxPage = math.ceil((#self.goodDetails.region + 1 or 1) / 3)
    self.tableViewControl = TableViewEx.prototype:createList(self, self.m_pList, self.maxPage)
    self.m_pList:addChild(self.tableViewControl.tableView)
    self.tableViewControl.tableView:setDirection(kCCScrollViewDirectionHorizontal)
  end
  local pageNum = math.ceil(((rewardNum or 0) + 1) / 3)
  if pageNum > self.maxPage then
    pageNum = self.maxPage or pageNum
  end
  self.tableViewControl:TurnPageTo(pageNum, true, true)
end
function prototype:cellSizeForTable()
  return CCSizeMake(WIN_WIDTH, WIN_HEIGHT)
end
function prototype:tableCellAtIndex(table, index, cell, curPage)
  if not cell then
    cell = CCTableViewCellEx:create()
    local subScene = Tw.Controller:load("GroupPurchaseReward", self.rootNode)
    subScene:refresh(curPage, self.goodDetails)
    cell:addChild(subScene, 0, 2)
  else
    cell:getChildByTag(2):refresh(curPage, self.goodDetails)
  end
  return cell
end
function prototype:numberOfCellsInTableView(curPage)
  return 1
end
function prototype:tableCellTouched(table, cell)
  local idx = tolua.cast(cell, "CCTableViewCellEx"):getIdx()
end
function prototype:tablePageTurn(curPage)
  self.tableViewControl:RequireUpdate()
end
function prototype:onBuyBtnClicked(sender, event)
end
function prototype:onRewardBtnClicked(sender, event)
end
function prototype:onBtnClicked(sender, event)
  if not self.goodDetails or table.empty(self.goodDetails) then
    return
  end
  local hasBuy = Logic:Get("GroupPurchase"):hasBuy(self.goodDetails.id)
  local noRewards = Logic:Get("GroupPurchase"):isNoReward(self.goodDetails.id)
  if hasBuy then
    if noRewards then
      return
    end
    local canGetArr = Logic:Get("GroupPurchase"):getCanGetRewardInfo(self.goodDetails.id)
    if table.empty(canGetArr) then
      Prompt:Fail(TwGetStr(111041))
    else
      Logic:Get("GroupPurchase"):PostDrawReward(self.goodDetails.id, {
        canGetArr[1]
      })
    end
  else
    local wallet = Logic:Get("PlayerInfo"):GetPlayerMoney()
    local xianyu = wallet.gift + wallet.inter + wallet.gold
    if xianyu < self.goodDetails.now then
      Logic:Get("SureConfirm").btnText.ok = TwGetStr(104003)
      Prompt:Confirm(Logic:Get("Main"), "", 105316, Logic:Get("Main").GotoRecharge, Prompt.PROMPT_TYPE.SELECT)
      return
    end
    Logic:Get("SureConfirm").btnText.ok = TwGetStr(105219)
    Prompt:Confirm(self, "", TwGetStr(111049, self.goodDetails.now), self.buyGoods, Prompt.PROMPT_TYPE.SELECT)
  end
end
function prototype:buyGoods()
  Logic:Get("GroupPurchase"):PostBuyGoods(self.goodDetails.id)
end
