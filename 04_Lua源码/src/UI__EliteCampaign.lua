module((...), package.seeall)
require("SceneHelper")
require("TableViewEx")
require("BtnPosition")
local CELL_TAG = 2
prototype = BtnPosition.prototype:extend()
local LIMITED_TITLE_PATH = "images/Rebirth/limitChallenge.png"
function prototype:initialize()
  super.initialize(self)
  self.titleinfo = {}
  self.data = {}
end
function prototype:onEnter()
  super.onEnter(self)
  Logic:Get("Elite"):initCampaignList()
  self.data = Logic:Get("Elite"):GetCampaignList()
  self.tableViewControl = TableViewEx.prototype:createList(self, self.lstRebirth, 1)
  self.tableViewControl:RequireUpdate()
  self.tableViewControl.tableView:setDirection(kCCScrollViewDirectionVertical)
  self.lstRebirth:addChild(self.tableViewControl.tableView)
end
function prototype:onBtnReturn(sender, event)
  local layerType = Logic:Get("Battle"):GetCurSelLayerType()
  SceneHelper:runWithScene("BattleCopy", self.rootNode, nil, layerType ~= Logic.Battle.UI_LAYER_TYPE.CAMPAIGN)
end
function prototype:cellSizeForTable(...)
  return CCSizeMake(563, 120)
end
function prototype:tableCellAtIndex(table, index, cell, curPage)
  if not cell then
    cell = CCTableViewCellEx:create()
    local subScene = Tw.Controller:load("EliteCampaignItem", self.rootNode)
    subScene:refresh(self.data[index + 1])
    cell:addChild(subScene, 0, 2)
  else
    cell:getChildByTag(2):refresh(self.data[index + 1])
  end
  return cell
end
function prototype:numberOfCellsInTableView(curPage)
  if self.data == nil or table.empty(self.data) then
    return 0
  end
  return #self.data
end
function prototype:tableCellTouched(table, cell)
end
function prototype:tablePageTurn(curPage)
  self.tableViewControl:RequireUpdate()
end
function prototype:actionFinish(tableView)
  if not Logic:Get("Guide"):isGuiding() then
    return
  end
  local data = self:getData()
  if data == nil or table.empty(data) then
    return
  end
  local cell = tableView:cellAtIndex(#data - 1)
  if cell == nil then
    return
  end
  local item = cell:getChildByTag(CELL_TAG)
  if item == nil then
    return
  end
  item:updateGuide()
end
function prototype:getData()
  return Logic:Get("Elite"):GetCampaignList()
end
