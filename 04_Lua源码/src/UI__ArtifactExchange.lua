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
  self.ttfStone:setStyle(kCCLabelTTFStyleOutline)
  for i = 1, 3 do
    local str = string.format("ttfStone%d", i)
    if self[str] then
      self[str]:setStyle(kCCLabelTTFStyleOutline)
    end
  end
  Logic:Get("Artifact"):On(Logic.Artifact.EVT.SOUL_STONE_EXCHANGE, self:Event("onSoulStoneExchange"))
  self:onSoulStoneExchange()
  self.data = {}
  for i = 1, KFDBGetRecordAmt("StoneExchangePackage") do
    local rec = KFDBGetRecordByIdx("StoneExchangePackage", i)
    if rec == nil then
      return
    end
    table.insert(self.data, rec)
  end
  local sortData = function(a, b)
    if a == nil or b == nil then
      return false
    end
    return a.costNum < b.costNum
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
end
function prototype:onNodeLoaded(node, loader)
end
function prototype:onBtnReturn(sender, event)
  SceneHelper:runWithScene("Artifact", self.rootNode)
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
function prototype:onSoulStoneExchange()
  local soulStoneSp = Logic:Get("Artifact"):GetSoulStoneSp()
  local normalStone = Logic:Get("Artifact"):GetSoulNum()
  self.ttfStone:setString(":" .. normalStone)
  for i = 1, 3 do
    local str = string.format("ttfStone%d", i)
    if self[str] then
      self[str]:setString(":" .. soulStoneSp[i])
    end
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
    local subScene = Tw.Controller:load("ArtifactExchangeItem", self.rootNode)
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
