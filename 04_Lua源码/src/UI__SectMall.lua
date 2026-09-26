module((...), package.seeall)
require("SceneHelper")
require("TableViewEx")
require("BtnPosition")
prototype = Tw.Controller.prototype:extend()
local MAX_PER_PAGE = 20
function prototype:initialize()
  super.initialize(self)
  self.normalGoodsInfo = {}
  self.goodsList = {}
end
function prototype:onEnter()
  super.onEnter(self)
  Logic:Get("Sect"):On(Logic.Sect.EVT.GET_GOODS_LIST, self:Event("RefreshGoodsList"))
  MsgMenpai:Post("GET_GOODS")
  self.position = self.ttfMoney:getPositionX()
  self.ttfMoney:setStyle(kCCLabelTTFStyleOutline)
  self.sprFeat:setVisible(false)
  self.ttfDesc:setString(TwGetStr(108146))
  self.page = 1
  self.tableViewControl = TableViewEx.prototype:createList(self, self.lstExchange, self.page)
  self.lstExchange:addChild(self.tableViewControl.tableView)
end
function prototype:RefreshGoodsList()
  self.goodsList = Logic:Get("Sect"):getGoodsList() or {}
  self.normalGoodsInfo = {}
  if table.empty(self.goodsList) then
    return
  end
  self.ttfMoney:setString(self.goodsList.money or 0)
  self.sprFeat:setVisible(true)
  local x = self.position + self.ttfMoney:getContentSize().width + 30
  self.sprFeat:setPositionX(x)
  for i, v in ipairs(self.goodsList.goods) do
    local rec = KFDBGetRecord("GoodsSetting", v.id)
    if rec then
      rec.exchange = rec.exchange - v.exchange
      table.insert(self.normalGoodsInfo, rec)
    end
  end
  self.page = math.ceil(#self.normalGoodsInfo / MAX_PER_PAGE)
  if self.page == 0 then
    self.page = 1
  end
  self:sortData()
  self.tableViewControl:RequireUpdate(self.page, true, true)
end
function prototype:sortData()
  if not table.empty(self.normalGoodsInfo) then
    local goodsSort = function(param1, param2)
      if not param1 or not param2 then
        return false
      end
      return param1.sort > param2.sort
    end
    table.sort(self.normalGoodsInfo, goodsSort)
  end
end
function prototype:onBtnReturn()
  SceneHelper:runWithScene("SectMain", self.rootNode)
end
function prototype:onBtnTurnLeft()
  if self.tableViewControl ~= nil then
    self.tableViewControl:TurnPage(-1)
  end
end
function prototype:onBtnTurnRight()
  if self.tableViewControl ~= nil then
    self.tableViewControl:TurnPage(1)
  end
end
function prototype:cellSizeForTable(...)
  return CCSizeMake(563, 164)
end
function prototype:tableCellAtIndex(table, index, cell, curPage)
  if not cell then
    cell = CCTableViewCellEx:create()
    local subScene = Tw.Controller:load("SectMallItem", self.rootNode)
    subScene.pExchangeItem:RefreshGoodsInfo(self.normalGoodsInfo[(curPage - 1) * MAX_PER_PAGE + index + 1])
    cell:addChild(subScene, 0, 2)
  else
    cell:getChildByTag(2).pExchangeItem:RefreshGoodsInfo(self.normalGoodsInfo[(curPage - 1) * MAX_PER_PAGE + index + 1])
  end
  return cell
end
function prototype:numberOfCellsInTableView(curPage)
  self.staPage:setString(string.format("%d/%d", curPage or 1, self.page or 1))
  if self.normalGoodsInfo == nil and next(self.normalGoodsInfo) == nil then
    return 0
  end
  if self.page == curPage then
    return #self.normalGoodsInfo - (self.page - 1) * MAX_PER_PAGE
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
