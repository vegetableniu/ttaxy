module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
local WIN_WIDTH, WIN_HEIGHT = 325, 120
function prototype:onEnter()
  Logic:Get("Guide"):On(Logic.Guide.EVT.STEP, self:Event("updateGuide"))
end
function prototype:initInfo(heroBaseId)
  local info = Logic:Get("Hero"):GetHeroInfoByBaseId(heroBaseId)
  if not info then
    return
  end
  self.weaponSet = json.decode(info.weaponSet or "[]") or {}
  self.armorSet = json.decode(info.armorSet or "[]") or {}
  if table.empty(self.weaponSet) or table.empty(self.armorSet) then
    if self.tableViewControl then
      self.tableViewControl:RequireUpdate(1)
    end
    self.imgBg:setVisible(true)
    self.imgTip:setVisible(true)
    self.sprArrow:setVisible(false)
    return
  end
  self.sprArrow:setVisible(#self.weaponSet > 1)
  self.imgBg:setVisible(false)
  self.imgTip:setVisible(false)
  self.maxPage = 1
  self.tableViewControl = TableViewEx.prototype:createList(self, self.detailsList, self.maxPage, false)
  self.detailsList:removeAllChildrenWithCleanup(true)
  self.detailsList:addChild(self.tableViewControl.tableView)
  self.tableViewControl.tableView:setDirection(kCCScrollViewDirectionVertical)
end
function prototype:cellSizeForTable()
  return CCSizeMake(WIN_WIDTH, WIN_HEIGHT)
end
function prototype:tableCellAtIndex(table, index, cell, curPage)
  if not cell then
    cell = CCTableViewCellEx:create()
    local subScene = Tw.Controller:load("ArmorDetailsItem", self.rootNode)
    subScene:refresh(index + 1, self.armorSet[index + 1], self.weaponSet[index + 1])
    cell:addChild(subScene, 0, 2)
  else
    cell:getChildByTag(2):refresh(index + 1, self.armorSet[index + 1], self.weaponSet[index + 1])
  end
  return cell
end
function prototype:numberOfCellsInTableView(curPage)
  return #self.weaponSet
end
function prototype:tableCellTouched(table, cell)
end
function prototype:tablePageTurn(curPage)
  self.tableViewControl:RequireUpdate()
end
function prototype:updateGuide()
  if self.tableViewControl == nil then
    return
  end
  local tableView = self.tableViewControl.tableView
  if tableView == nil then
    return
  end
  if not Logic:Get("Guide"):isGuiding() then
    return
  end
  local data = 1
  if data == nil then
    return
  end
  local cell = tableView:cellAtIndex(data - 1)
  if cell == nil then
    return
  end
  local item = cell:getChildByTag(2)
  if item == nil then
    return
  end
  item:updateGuide()
end
