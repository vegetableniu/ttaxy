module((...), package.seeall)
require("SceneHelper")
require("BtnPosition")
prototype = BtnPosition.prototype:extend()
function prototype:initialize(...)
  super.initialize(self, ...)
end
function prototype:dispose(...)
  super.dispose(self)
end
function prototype:onEnter()
  super.onEnter(self)
  Logic:Get("Fight"):On(Logic.Fight.EVT.UPDATE_REWARD_LIST, self:Event("RefrashGiftInfo"))
  self.allGiftIdTable = Logic:Get("Fight"):initGiftData()
  Logic:Get("Fight"):removeDrawGift(self.allGiftIdTable)
  self.data = self.allGiftIdTable
  self.page = math.ceil(#self.allGiftIdTable / Logic.Compose.MAX_LIST)
  self.tableViewControl = TableViewEx.prototype:createList(self, self.m_pCList, self.page)
  if self.page == 1 then
    self.tableViewControl.tableView:setDirection(kCCScrollViewDirectionVertical)
  end
  self.m_pCList:addChild(self.tableViewControl.tableView)
end
function prototype:onNodeLoaded(node, loader)
end
function prototype:onBtnReturn(sender, event)
  SceneHelper:runWithScene("FightPvp", self.rootNode)
end
function prototype:RefrashGiftInfo()
  self.allGiftIdTable = Logic:Get("Fight"):initGiftData()
  Logic:Get("Fight"):removeDrawGift(self.allGiftIdTable)
  self.data = self.allGiftIdTable
  self.page = math.ceil(#self.allGiftIdTable / Logic.Compose.MAX_LIST)
  self.tableViewControl:RequireUpdate(self.page, true, true)
end
function prototype:cellSizeForTable(...)
  return CCSizeMake(588, 164)
end
function prototype:tableCellAtIndex(table, index, cell, curPage)
  if not cell then
    cell = CCTableViewCellEx:create()
    local subScene = Tw.Controller:load("FightGiftItem", self.rootNode)
    subScene:RefrashGiftInfo(self.data[index + 1])
    cell:addChild(subScene, 0, 2)
  else
    cell:getChildByTag(2):RefrashGiftInfo(self.data[index + 1])
  end
  return cell
end
function prototype:numberOfCellsInTableView(curPage)
  if #self.allGiftIdTable == 0 then
    return 0
  end
  if self.page == curPage then
    local num = #self.allGiftIdTable - (self.page - 1) * Logic.Hero.MAX_HEROS_PER_PAGE
    return num
  else
    return Logic.Compose.MAX_LIST
  end
end
function prototype:tableCellTouched(table, cell)
  local idx = tolua.cast(cell, "CCTableViewCellEx"):getIdx()
end
function prototype:tablePageTurn(curPage)
  self.tableViewControl:RequireUpdate()
end
