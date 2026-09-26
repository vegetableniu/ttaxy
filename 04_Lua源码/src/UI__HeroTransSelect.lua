module((...), package.seeall)
require("SceneHelper")
require("BtnPosition")
prototype = BtnPosition.prototype:extend()
local MAX_PER_PAGE = 20
function prototype:initialize()
  super.initialize(self)
end
function prototype:onNodeLoaded(node, loader)
end
function prototype:onEnter()
  super.onEnter(self)
  self.data = Logic:Get("Compose"):GetTranslateCards()
  self.page = math.ceil(#self.data / MAX_PER_PAGE)
  self.tableViewControl = TableViewEx.prototype:createList(self, self.lstCard, self.page)
  if self.page < 2 then
    self.tableViewControl.tableView:setDirection(kCCScrollViewDirectionVertical)
  end
  self.lstCard:addChild(self.tableViewControl.tableView)
  self.tableViewControl.tableView:runUIAnimat()
  Logic:Get("Compose"):On(Logic.Compose.EVT.SELECT_CARD, self:Event("onSelectCard"))
end
function prototype:onSelectCard()
  local selectCard = Logic:Get("Compose"):GetSelectCard()
  if selectCard then
    SceneHelper:popScene()
    return
  end
  self.tableViewControl:RequireUpdateWithoutAnimat()
end
function prototype:onBtnReturn(sender, event)
  SceneHelper:popScene()
end
function prototype:onBtnLeft(sender, event)
end
function prototype:onBtnRight(sender, event)
end
function prototype:cellSizeForTable(...)
  return CCSizeMake(563, 117)
end
function prototype:tableCellAtIndex(table, index, cell, curPage)
  local lstIdx = index + 1 + (curPage - 1) * MAX_PER_PAGE
  local key = self.data[lstIdx]
  if not cell then
    cell = CCTableViewCellEx:create()
    local subScene = Tw.Controller:load("HeroTransSelectItem", self.rootNode)
    subScene:RefreshInfo(key)
    cell:addChild(subScene, 0, 2)
  else
    cell:getChildByTag(2):RefreshInfo(key)
  end
  return cell
end
function prototype:numberOfCellsInTableView(curPage)
  if self.data == nil or table.empty(self.data) then
    return 0
  end
  self.ttfPage:setString(string.format("%d/%d", curPage or 1, self.page or 1))
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
