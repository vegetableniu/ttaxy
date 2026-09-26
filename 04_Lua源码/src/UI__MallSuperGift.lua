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
  self.curId = 0
  self.numberOfGood = 0
  self.isFirstEnter = true
  self.MallInfo = Logic:Get("Mall"):getSuperGoodInfo()
  self.ttfTitle:setStyle(kCCLabelTTFStyleOutline)
  self.ttfTitle:setString(self.MallInfo.title or "")
  self.tableViewControl = TableViewEx.prototype:createList(self, self.lstMall, 1)
  self.tableViewControl.tableView:setDirection(kCCScrollViewDirectionVertical)
  self.lstMall:addChild(self.tableViewControl.tableView)
  self.ani = Logic:Get("AniMgr"):NewCCB("UI/UIcz", self.sprRight, ccp(35, 19), 0, nil, nil)
  if self.ani then
    self.ani:RunAni()
  end
  Logic:Get("SuperGift"):On(Logic.SuperGift.EVT.GOOD_INFO, self:Event("onRefresh"))
  if self.MallInfo and self.MallInfo.id then
    Logic:Get("SuperGift"):PostGetInfo(self.MallInfo.id)
  end
  self:onTimer()
end
function prototype:onRefresh()
  local goodList = Logic:Get("SuperGift"):getGoodsInfo()
  if table.empty(goodList or {}) then
    return
  end
  self:initGoodsInfo(goodList)
  if self.numberOfGood ~= #self.data and not self.isFirstEnter then
    self.tableViewControl:RequireUpdate()
  else
    self.tableViewControl:RequireUpdateWithoutAnimat()
  end
  self.numberOfGood = #self.data or 0
  self.isFirstEnter = false
end
function prototype:initGoodsInfo(goodList)
  self.data = {}
  for i, v in ipairs(goodList) do
    local rec = KFDBGetRecord("SuperGoods", v.id)
    if rec and rec.mallId == self.MallInfo.id then
      local info = {}
      rec.start = Logic:Get("SuperGift"):GetItemTime(rec.start)
      rec.endTime = Logic:Get("SuperGift"):GetItemTime(rec.endTime)
      info.goodInfo = rec
      info.goodList = v
      info.canBuy = Logic:Get("SuperGift"):compareTime(rec.start, rec.endTime)
      if Logic:Get("System"):DiffTime(rec.endTime) > 0 then
        table.insert(self.data, info)
      end
    end
  end
  self:sortData()
end
function prototype:onTimer()
  if not self.eventTracer:Exist("checkData") then
    Singleton(Timer):Repeat(1000, self:Event("checkData"))
  end
end
function prototype:checkData()
  if table.empty(self.data or {}) then
    return
  end
  local isChange = false
  for i, v in ipairs(self.data) do
    local canBuy = Logic:Get("SuperGift"):compareTime(v.goodInfo.start, v.goodInfo.endTime)
    local isStop = Logic:Get("System"):DiffTime(v.goodInfo.endTime) < 0
    if not v.canBuy and canBuy or isStop then
      isChange = true
      break
    end
  end
  if isChange then
    self:onRefresh()
  end
end
function prototype:sortData()
  local sort = function(a, b)
    if not a or not b then
      return false
    end
    return a.goodInfo.sort > b.goodInfo.sort
  end
  table.sort(self.data, sort)
end
function prototype:onNodeLoaded(node, loader)
end
function prototype:onBtnReturn(sender, event)
  SceneHelper:runWithScene("Mall", self.rootNode)
end
function prototype:onBtnRecharge(sender, event)
  Logic:Get("Main"):GotoRecharge()
end
function prototype:cellSizeForTable(...)
  return CCSizeMake(558, 182)
end
function prototype:tableCellAtIndex(table, index, cell, curPage)
  if not cell then
    cell = CCTableViewCellEx:create()
    local subScene = Tw.Controller:load("MallSuperGiftItem", self.rootNode)
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
