module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
function prototype:initialize(...)
  super.initialize(self, ...)
  self.cards = {}
  self.currPage = 1
end
function prototype:dispose(...)
  super.dispose(self)
end
function prototype:onEnter()
  local lotteryInst = Logic:Get("Lottery")
  local rewards = Logic:Get("BattleShow"):GetSpecialDropItems()
  self.cards = lotteryInst:formatRewardData(rewards)
  self.data = {}
  for _, v in pairs(self.cards) do
    table.insert(self.data, {
      lotteryInst:formatTabData(v)
    })
  end
  self.tableViewControl = TableViewEx.prototype:createList(self, self.m_pList, #self.data)
  self.tableViewControl.tableView:setDirection(kCCScrollViewDirectionBoth)
  self.m_pList:addChild(self.tableViewControl.tableView)
end
function prototype:onNodeLoaded(node, loader)
end
function prototype:onBtnCloseClicked(sender, event)
  SceneHelper:popScene()
end
function prototype:onBtnLeftClicked(sender, event)
  self.tableViewControl:TurnPage(-1)
end
function prototype:onBtnRightClicked(sender, event)
  self.tableViewControl:TurnPage(1)
end
function prototype:onBtnBgClicked(sender, event)
end
function prototype:cellSizeForTable(...)
  return CCSizeMake(640, 960)
end
function prototype:tableCellAtIndex(table, index, cell, curPage)
  if not cell then
    self.currPage = curPage
    cell = CCTableViewCellEx:create()
    local subScene = Tw.Controller:load("LotteryItem", self.rootNode)
    subScene:RefreshInfo(self.data[curPage][1])
    cell:addChild(subScene, 0, 2)
  else
    cell:getChildByTag(2):RefreshInfo(self.data[curPage][1])
  end
  return cell
end
function prototype:numberOfCellsInTableView(curPage)
  return 1
end
function prototype:tableCellTouched(table, cell)
end
function prototype:tablePageTurn(curPage)
  if curPage >= 1 and curPage <= #self.cards then
    self.tableViewControl:RequireUpdate()
  end
end
