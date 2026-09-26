module((...), package.seeall)
require("SceneHelper")
require("TableViewEx")
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
  self.data = {}
  local data = Logic:Get("Mall"):GetOpenBetaData()
  self.ttfTitle:setStyle(kCCLabelTTFStyleOutline)
  self.ttfTitle:setString(data.title or "")
  self.tableViewControl = TableViewEx.prototype:createList(self, self.lstMall, 1)
  self.tableViewControl.tableView:setDirection(kCCScrollViewDirectionVertical)
  self.lstMall:addChild(self.tableViewControl.tableView)
  self.ani = Logic:Get("AniMgr"):NewCCB("UI/UIcz", self.sprRight, ccp(35, 19), 0, nil, nil)
  if self.ani then
    self.ani:RunAni()
  end
  Logic:Get("PlayerInfo"):On(Logic.PlayerInfo.EVT.GET_OPEN_BETA_GOODS_INFO, self:Event("onGetOpenBetaGoodsInfo"))
  Logic:Get("PlayerInfo"):On(Logic.PlayerInfo.EVT.BUY_OPEN_BETA_GOODS, self:Event("onBuyOpenBetaGoods"))
  Logic:Get("PlayerInfo"):PostGetOpenBetaGoodsInfo()
end
function prototype:onNodeLoaded(node, loader)
end
function prototype:onBtnReturn(sender, event)
  SceneHelper:runWithScene("Mall", self.rootNode)
end
function prototype:onBtnRecharge(sender, event)
  Logic:Get("Main"):GotoRecharge()
end
function prototype:onGetOpenBetaGoodsInfo()
  self.data = {}
  local data = Logic:Get("Mall"):GetOpenBetaData()
  for i = 1, KFDBGetRecordAmt("OpenBetaGoodsConfig") do
    local rec = KFDBGetRecordByIdx("OpenBetaGoodsConfig", i)
    if rec and rec.mallId == data.id then
      rec.showTypes = json.decode(rec.showTypes or "[]")
      rec.showIds = json.decode(rec.showIds or "[]")
      rec.counts = json.decode(rec.counts or "[]")
      rec.fullPrice = json.decode(rec.fullPrice or "[]")
      rec.price = json.decode(rec.price or "[]")
      table.insert(self.data, rec)
    end
  end
  local sort = function(a, b)
    local buyTimesA = Logic:Get("PlayerInfo"):GetBetaBuyTimeById(a.id)
    local buyTimesB = Logic:Get("PlayerInfo"):GetBetaBuyTimeById(b.id)
    if buyTimesA < a.limit then
      if buyTimesB < b.limit then
        return a.sort < b.sort
      end
      return true
    end
    if buyTimesB < b.limit then
      return false
    end
    return a.sort < b.sort
  end
  table.sort(self.data, sort)
  self.tableViewControl:RequireUpdate()
end
function prototype:onBuyOpenBetaGoods()
  self:onGetOpenBetaGoodsInfo()
end
function prototype:cellSizeForTable(...)
  return CCSizeMake(563, 242)
end
function prototype:tableCellAtIndex(table, index, cell, curPage)
  if not cell then
    cell = CCTableViewCellEx:create()
    local subScene = Tw.Controller:load("MallPackageItem", self.rootNode)
    subScene:Refrash(self.data[index + 1])
    cell:addChild(subScene, 0, 2)
  else
    cell:getChildByTag(2):Refrash(self.data[index + 1])
  end
  return cell
end
function prototype:numberOfCellsInTableView(curPage)
  if self.data and not table.empty(self.data) then
    return #self.data
  else
    return 0
  end
end
function prototype:tableCellTouched(table, cell)
  local idx = tolua.cast(cell, "CCTableViewCellEx"):getIdx()
end
function prototype:tablePageTurn(curPage)
  self.tableViewControl:RequireUpdate()
end
