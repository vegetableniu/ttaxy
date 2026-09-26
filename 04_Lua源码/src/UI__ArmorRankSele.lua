module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
local WIN_WIDTH, WIN_HEIGHT = 590, 120
local PAGE_SIZE = 20
function prototype:onEnter()
  self.ttfTip:setStyle(kCCLabelTTFStyleOutline)
  local chooseHeroId = Logic:Get("Armor"):getChooseHeroId()
  self.armorInfos = Logic:Get("Armor"):getHeroEquipArmors(chooseHeroId)
  if table.empty(self.armorInfos) then
    self.ttfTip:setString(TwGetStr(111441))
    return
  end
  self.maxPage = math.ceil(#self.armorInfos / PAGE_SIZE)
  self.tableViewControl = TableViewEx.prototype:createList(self, self.itemList, self.maxPage, true)
  self.itemList:addChild(self.tableViewControl.tableView)
  self.tableViewControl:RequireUpdate()
end
function prototype:onBtnReturn(sender, event)
  if Logic:Get("Armor"):IsFromRank() then
    SceneHelper:runWithScene("ArmorRank", self.rootNode)
  else
    SceneHelper:runWithScene("ArmorMain", self.rootNode)
  end
end
function prototype:cellSizeForTable()
  return CCSizeMake(WIN_WIDTH, WIN_HEIGHT)
end
function prototype:tableCellAtIndex(table, index, cell, curPage)
  local curIndex = index + 1 + (curPage - 1) * PAGE_SIZE
  if not cell then
    cell = CCTableViewCellEx:create()
    local subScene = Tw.Controller:load("ArmorRankSeleItem", self.rootNode)
    subScene:refresh(self.armorInfos[curIndex])
    cell:addChild(subScene, 0, 2)
  else
    cell:getChildByTag(2):refresh(self.armorInfos[curIndex])
  end
  return cell
end
function prototype:numberOfCellsInTableView(curPage)
  if curPage == self.maxPage then
    return (#self.armorInfos - 1) % PAGE_SIZE + 1
  end
  return PAGE_SIZE
end
function prototype:tableCellTouched(table, cell)
end
function prototype:tablePageTurn(curPage)
  self.tableViewControl:RequireUpdate()
end
