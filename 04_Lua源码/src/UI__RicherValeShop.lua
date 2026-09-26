module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
function prototype:onEnter()
  self.monoInfo = Logic:Get("NewMonopoly"):GetMonoInfo()
  self.data = {}
  for _, id in ipairs(self.monoInfo.goodsItems or {}) do
    local rec = KFDBGetRecord("MoGoodsItemSetting", id)
    table.insert(self.data, rec)
  end
  table.sort(self.data, function(a, b)
    return a.sort > b.sort
  end)
  self.ttfMyGold:setStyle(kCCLabelTTFStyleOutline)
  self.ttfMyGold:setString(self.monoInfo.currency)
  self.tableViewControl = TableViewEx.prototype:createList(self, self.nodList, 1)
  self.tableViewControl.tableView:setDirection(kCCScrollViewDirectionVertical)
  self.nodList:addChild(self.tableViewControl.tableView)
  Logic:Get("NewMonopoly"):On(Logic.NewMonopoly.EVT.BUY_GOODS, self:Event("onBuyGoods"))
  Singleton(Timer):After(0, self:Event("SWITCH_DRAG", function()
    Logic:Get("NewMonopoly"):FireEvent(Logic.NewMonopoly.EVT.SWITCH_DRAG, false)
  end))
end
function prototype:onBuyGoods()
  self.ttfMyGold:setString(self.monoInfo.currency)
  self.tableViewControl:RequireUpdateWithoutAnimat()
end
function prototype:IsExchagedGood(id, buyLimit)
  local changeTimes = self.monoInfo.boughtGoods[id] or 0
  return buyLimit <= changeTimes
end
function prototype:onBtnBg()
end
function prototype:onBtnReturn()
  SceneHelper:popScene()
  Logic:Get("NewMonopoly"):FireEvent(Logic.NewMonopoly.EVT.SWITCH_DRAG, true)
end
function prototype:onBtnRecharge()
  Logic:Get("Main"):GotoRecharge()
end
function prototype:cellSizeForTable(...)
  return CCSizeMake(319, 100)
end
function prototype:tableCellAtIndex(table, index, cell, curPage)
  local tag = 2
  if not cell then
    cell = CCTableViewCellEx:create()
    local subScene = Tw.Controller:load("RicherValeShopItem", self.rootNode)
    cell:addChild(subScene, 0, tag)
  end
  cell:getChildByTag(tag):refreshGood(self, self.data[index + 1])
  return cell
end
function prototype:numberOfCellsInTableView(curPage)
  if table.empty(self.data or {}) then
    return 0
  end
  return #self.data
end
function prototype:tableCellTouched(table, cell)
end
function prototype:tablePageTurn(curPage)
  self.tableViewControl:RequireUpdate()
end
