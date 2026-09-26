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
  Logic:Get("Chargereturn"):On(Logic.Chargereturn.EVT.LOAD_CHARGERETURN, self:Event("onLoadChargereturn"))
  Logic:Get("Chargereturn"):On(Logic.Chargereturn.EVT.DRAW_REWARD, self:Event("onDrawReward"))
  self.data = {}
  self:createTableView()
  Logic:Get("Chargereturn"):PostLoadChargereturn()
end
function prototype:onLoadChargereturn()
  local chargereturn = Logic:Get("Chargereturn"):getChargereturn()
  for i = 1, KFDBGetRecordAmt("DateReturn") do
    local rec = KFDBGetRecordByIdx("DateReturn", i)
    if rec and rec.date == chargereturn.day then
      rec.hasCharge = chargereturn.charge
      table.insert(self.data, rec)
    end
  end
  table.sort(self.data, function(l, r)
    return l.sort < r.sort
  end)
  self.tableViewControl:RequireUpdate()
end
function prototype:onDrawReward()
  self.tableViewControl:RequireUpdate()
end
function prototype:createTableView()
  self.page = 1
  self.tableViewControl = TableViewEx.prototype:createList(self, self.nodeList, self.page)
  self.tableViewControl.tableView:setDirection(kCCScrollViewDirectionVertical)
  self.nodeList:addChild(self.tableViewControl.tableView)
end
function prototype:onBtnRecharge(sender, Event)
  local activity = Logic:Get("Gift"):GetActivityByType("TURKEY")
  Logic:Get("Gift"):SetActivityGift(activity[1])
  SceneHelper:runWithScene("ThanksgivingDay", self.rootNode)
end
function prototype:onBtnReturn(sender, Event)
  SceneHelper:runWithScene("GiftActivityList", self.rootNode)
end
function prototype:cellSizeForTable(...)
  return CCSizeMake(590, 135)
end
function prototype:tableCellAtIndex(table, index, cell, curPage)
  if not cell then
    cell = CCTableViewCellEx:create()
    local subScene = Tw.Controller:load("ThanksgivingDayChargeItem", self.rootNode)
    subScene.itemList:refreshInfo(self.data[index + 1], index + 1)
    cell:addChild(subScene, 0, 2)
  else
    cell:getChildByTag(2)
    cell:getChildByTag(2).itemList:refreshInfo(self.data[index + 1], index + 1)
  end
  return cell
end
function prototype:numberOfCellsInTableView(curPage)
  if self.data == nil then
    return 0
  end
  return #self.data
end
function prototype:tableCellTouched(table, cell)
  local idx = tolua.cast(cell, "CCTableViewCellEx"):getIdx()
end
function prototype:tablePageTurn(curPage)
  self.tableViewControl:RequireUpdate()
end
