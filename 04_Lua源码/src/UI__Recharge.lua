module((...), package.seeall)
require("SceneHelper")
require("TableViewEx")
require("Logic.Recharge")
require("BtnPosition")
prototype = BtnPosition.prototype:extend()
local Recharge = Logic.Recharge
function prototype:onEnter(node, loader)
  super.onEnter(self)
  Logic:Get("PlayerInfo"):On(Logic.PlayerInfo.EVT.DATA_CHANGE, self:Event("RefreshInfo"))
  local bLockBuy = Logic:Get("Recharge"):IsLockBuy()
  self.layWait:setVisible(bLockBuy)
  self.staNetConnect:setString(TwGetStr(10109))
  self.staNetConectText:setDimensions(CCSize(350, 0))
  self.staNetConectText:setHorizontalAlignment(kCCTextAlignmentLeft)
  self.staNetConectText:setString(TwGetStr(10108))
  Logic:Get("Recharge"):On(Recharge.EVT.REFRESH_RECHARGE_LIST, self:Event("onRefreshList"))
  self.page = 1
  self.goods = Logic:Get("Recharge"):GetChargeGoods() or {}
  self:insertAdData()
  if self.goods then
    self.page = math.ceil(#self.goods / Logic.Compose.MAX_LIST)
    self.tableViewControl = TableViewEx.prototype:createList(self, self.lstBuyGoods, self.page)
    self.tableViewControl.tableView:runUIAnimat()
    if self.page == 1 then
      self.tableViewControl.tableView:setDirection(kCCScrollViewDirectionVertical)
      self.tableViewControl:RequireUpdateWithoutAnimat()
    end
    self.lstBuyGoods:addChild(self.tableViewControl.tableView)
  end
end
function prototype:onExit()
  Logic:Get("Recharge"):SetLockBuy(false)
end
function prototype:onRefreshList()
  local bLockBuy = Logic:Get("Recharge"):IsLockBuy()
  self.layWait:setVisible(bLockBuy)
  self.tableViewControl:RequireUpdateWithoutAnimat()
end
function prototype:insertAdData()
  if Logic:Get("Gift"):IsOpenActivity("OLD_USER_CHARGE_TREBLE") or Logic:Get("Gift"):IsOpenActivity("NEW_USER_CHARGE_TREBLE") then
    local itemCnt = 3
    for i = 1, itemCnt do
      table.insert(self.goods, 1, self.goods[1])
    end
  end
end
function prototype:onBtnStore()
  SceneHelper:popScene()
end
function prototype:cellSizeForTable(...)
  return CCSizeMake(577, 125)
end
function prototype:tableCellAtIndex(table, index, cell, curPage)
  local idx = index + 1
  local lstIdx = idx + (curPage - 1) * Logic.Compose.MAX_LIST
  if not cell then
    cell = CCTableViewCellEx:create()
    local subScene = Tw.Controller:load("BuyGoodsNode", self.rootNode)
    subScene:ReFreshInfo(self.goods[lstIdx], idx)
    cell:addChild(subScene, 0, 2)
  else
    cell:getChildByTag(2):ReFreshInfo(self.goods[lstIdx], idx)
  end
  return cell
end
function prototype:numberOfCellsInTableView(curPage)
  if self.page == curPage then
    local num = #self.goods - (self.page - 1) * Logic.Hero.MAX_HEROS_PER_PAGE
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
function prototype:RefreshInfo()
  self.goods = Logic:Get("Recharge"):GetChargeGoods() or {}
  self:insertAdData()
  if self.goods then
    self.page = math.ceil(#self.goods / Logic.Compose.MAX_LIST)
    if self.page == 1 then
      self.tableViewControl.tableView:setDirection(kCCScrollViewDirectionVertical)
      self.tableViewControl:RequireUpdateWithoutAnimat()
    end
  end
  self.tableViewControl:RequireUpdate(self.page, false, false)
end
