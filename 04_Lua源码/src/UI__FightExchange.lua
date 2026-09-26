module((...), package.seeall)
require("SceneHelper")
require("TableViewEx")
require("BtnPosition")
local MAX_PER_PAGE = 20
prototype = BtnPosition.prototype:extend()
function prototype:initialize(...)
  super.initialize(self, ...)
end
function prototype:dispose(...)
  super.dispose(self)
end
function prototype:onEnter()
  super.onEnter(self)
  local fightPoints = Logic:Get("Fight"):GetTotalIntegral()
  self.ttfPoint:setString(fightPoints)
  local sprIntegralX = self.ttfPoint:getPositionX() + self.ttfPoint:getContentSize().width + self.sprIntegral:getContentSize().width
  local sprIntegralY = self.ttfPoint:getPositionY()
  self.sprIntegral:setPosition(ccp(sprIntegralX, sprIntegralY))
  self.staStr:setString(TwGetStr(105337))
  self.data = {}
  for i = 1, KFDBGetRecordAmt("IntegralExchange") do
    local rec = KFDBGetRecordByIdx("IntegralExchange", i)
    if rec == nil then
      return
    end
    if rec.minLevel == nil then
      return
    end
    if rec.maxLevel == nil then
      return
    end
    local playerLevel = Logic:Get("PlayerInfo"):GetPlayerLevel()
    local wallet = Logic:Get("PlayerInfo"):GetPlayerMoney()
    if playerLevel >= rec.minLevel and playerLevel <= rec.maxLevel and wallet.totalCharge >= rec.chargeAmount then
      table.insert(self.data, rec)
    end
  end
  local sortData = function(a, b)
    if a == nil or b == nil then
      return false
    end
    return a.integral < b.integral
  end
  if self.data and not table.empty(self.data) then
    table.sort(self.data, sortData)
  end
  self.page = math.ceil(#self.data / MAX_PER_PAGE)
  self.tableViewControl = TableViewEx.prototype:createList(self, self.lstExchange, self.page)
  if self.page < 2 then
    self.tableViewControl.tableView:setDirection(kCCScrollViewDirectionVertical)
  end
  self.lstExchange:addChild(self.tableViewControl.tableView)
  self.tableViewControl.tableView:runUIAnimat()
  Logic:Get("Fight"):On(Logic.Fight.EVT.REFRESH_INTEGRAL, self:Event("refreshIntegral"))
end
function prototype:onNodeLoaded(node, loader)
end
function prototype:onBtnReturn(sender, event)
  SceneHelper:runWithScene("FightPvp", self.rootNode)
end
function prototype:onBtnTurnLeft(sender, event)
  if self.tableViewControl then
    self.tableViewControl:TurnPage(-1)
  end
end
function prototype:onBtnTurnRight(sender, event)
  if self.tableViewControl then
    self.tableViewControl:TurnPage(1)
  end
end
function prototype:cellSizeForTable(...)
  return CCSizeMake(563, 164)
end
function prototype:tableCellAtIndex(table, index, cell, curPage)
  local lstIdx = index + 1 + (curPage - 1) * MAX_PER_PAGE
  local key = self.data[lstIdx]
  if not cell then
    cell = CCTableViewCellEx:create()
    local subScene = Tw.Controller:load("FightExchangeItem", self.rootNode)
    subScene.pExchangeItem:RefreshExchangeInfo(key)
    cell:addChild(subScene, 0, 2)
  else
    cell:getChildByTag(2).pExchangeItem:RefreshExchangeInfo(key)
  end
  return cell
end
function prototype:numberOfCellsInTableView(curPage)
  if self.data == nil or table.empty(self.data) then
    return 0
  end
  self.staPage:setString(string.format("%d/%d", curPage or 1, self.page or 1))
  if self.page == curPage then
    return #self.data - (self.page - 1) * MAX_PER_PAGE
  else
    return MAX_PER_PAGE
  end
end
function prototype:tableCellTouched(table, cell)
  local idx = tolua.cast(cell, "CCTableViewCellEx"):getIdx()
end
function prototype:tablePageTurn(curPage)
  self.tableViewControl:RequireUpdate()
end
function prototype:refreshIntegral()
  local fightPoints = Logic:Get("Fight"):GetTotalIntegral()
  self.ttfPoint:setString(fightPoints)
end
function prototype:actionFinish(tableView)
  if not Logic:Get("Guide"):isGuiding() then
    return
  end
  local idx = self:getTableViewOffset()
  if idx == nil then
    return
  end
  local cell = tableView:cellAtIndex(idx - 1)
  if cell == nil then
    return
  end
  local item = cell:getChildByTag(2)
  if item == nil then
    return
  end
  item:updateGuide()
end
function prototype:getTableViewOffset()
  return 1
end
