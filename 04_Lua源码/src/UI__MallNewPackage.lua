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
  local goodsInfo = Logic:Get("Mall"):getCheapBuyInfo()
  self.ttfTitle:setStyle(kCCLabelTTFStyleOutline)
  self.ttfTitle:setString(goodsInfo.title or "")
  self.tableViewControl = TableViewEx.prototype:createList(self, self.lstMall, 1)
  self.tableViewControl.tableView:setDirection(kCCScrollViewDirectionVertical)
  self.lstMall:addChild(self.tableViewControl.tableView)
  self.ani = Logic:Get("AniMgr"):NewCCB("UI/UIcz", self.sprRight, ccp(35, 19), 0, nil, nil)
  if self.ani then
    self.ani:RunAni()
  end
  Logic:Get("CheapBuy"):On(Logic.CheapBuy.EVT.GOODS_LIST, self:Event("OnGoodsList"))
  if goodsInfo and goodsInfo.id then
    Logic:Get("CheapBuy"):PostInfo(goodsInfo.id)
  end
end
function prototype:onNodeLoaded(node, loader)
end
function prototype:onBtnReturn(sender, event)
  SceneHelper:runWithScene("Mall", self.rootNode)
end
function prototype:onBtnRecharge(sender, event)
  Logic:Get("Main"):GotoRecharge()
end
function prototype:OnGoodsList()
  self.data = {}
  local data = Logic:Get("Mall"):getCheapBuyInfo()
  self.curId = Logic:Get("CheapBuy"):getCurId()
  local offset = 0
  local goodsList = Logic:Get("CheapBuy"):getGoodsList()
  for i = 1, KFDBGetRecordAmt("CheapBuySetting") do
    local rec = KFDBGetRecordByIdx("CheapBuySetting", i)
    if rec and rec.mallId == data.id then
      if self.curId == rec.id then
        rec.canBuy = true
      else
        rec.canBuy = false
      end
      if goodsList[rec.id] then
        rec.hasBuy = true
      else
        rec.hasBuy = false
      end
      rec.showTypes = json.decode(rec.showTypes or "[]")
      rec.showIds = json.decode(rec.showIds or "[]")
      rec.counts = json.decode(rec.counts or "[]")
      table.insert(self.data, rec)
    end
  end
  self:sortData()
  for k, v in pairs(self.data) do
    if v.canBuy then
      offset = k
      break
    end
  end
  self.tableViewControl:RequireUpdateWithoutAnimat(1, false)
  self.tableViewControl.tableView:setTableViewOffset(offset)
end
function prototype:sortData()
  local sort = function(a, b)
    if not a or not b then
      return false
    end
    return a.sort < b.sort
  end
  table.sort(self.data, sort)
end
function prototype:cellSizeForTable(...)
  return CCSizeMake(578, 180)
end
function prototype:tableCellAtIndex(table, index, cell, curPage)
  if not cell then
    cell = CCTableViewCellEx:create()
    local subScene = Tw.Controller:load("MallNewPackageItem", self.rootNode)
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
