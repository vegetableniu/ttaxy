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
  self.giftInfo = Logic:Get("Gift"):GetActivityGift()
  self.ttfTitle:setColor(ccc3(255, 183, 18))
  self.ttfTitle:setString(self.giftInfo.name)
  self.ttfTitle:setStyle(kCCLabelTTFStyleOutline)
  self.data = {}
  self.tableViewControl = TableViewEx.prototype:createList(self, self.lstMall, 1)
  self.tableViewControl.tableView:setDirection(kCCScrollViewDirectionVertical)
  self.lstMall:addChild(self.tableViewControl.tableView)
  Logic:Get("ActivityCharge"):On(Logic.ActivityCharge.EVT.LOAD_INFO, self:Event("onLoadInfo"))
  Logic:Get("ActivityCharge"):On(Logic.ActivityCharge.EVT.DRAW, self:Event("onDraw"))
  Logic:Get("PlayerInfo"):On(Logic.PlayerInfo.EVT.DATA_CHANGE, self:Event("refreshList"))
  Logic:Get("Mall"):On(Logic.Mall.EVT.GET_LOTTERY_LIST, self:Event("onGetMallList"))
  Logic:Get("ActivityCharge"):postLoadInfo()
end
function prototype:onBtnReturn(sender, event)
  SceneHelper:runWithScene("GiftActivityList", self.rootNode)
end
function prototype:onBtnRight(sender, event)
  Logic:Get("Mall"):initItemData()
  local data = Logic:Get("Mall"):GetTabData()
  if table.empty(data or {}) then
    MsgPlayer:Post("GET_LOTTERY_LIST")
    return
  end
  self:onGetMallList()
end
function prototype:onLoadInfo()
  self.data = {}
  for i = 1, KFDBGetRecordAmt("ChargeReward") do
    local rec = KFDBGetRecordByIdx("ChargeReward", i)
    if rec and rec.activityId == self.giftInfo.id then
      rec.showTypes = json.decode(rec.showTypes or "[]")
      rec.showIds = json.decode(rec.showIds or "[]")
      rec.amounts = json.decode(rec.amounts or "[]")
      table.insert(self.data, rec)
    end
  end
  table.sort(self.data, function(a, b)
    return a.sort > b.sort
  end)
  self.tableViewControl:RequireUpdate()
end
function prototype:onDraw()
  self:onLoadInfo()
end
function prototype:refreshList()
  self:onLoadInfo()
end
function prototype:onGetMallList()
  local giftInfo = Logic:Get("Gift"):GetActivityGift()
  Logic:Get("Mall"):initItemData()
  local data = Logic:Get("Mall"):GetTabData()
  local tokenCoinData
  for _, v in pairs(data) do
    if v.id == giftInfo.mallId then
      tokenCoinData = v
      break
    end
  end
  if tokenCoinData then
    Logic:Get("Mall"):SetTokenCoinData(tokenCoinData)
    SceneHelper:pushScene("MallExchange", self.rootNode)
    return
  end
  Prompt:Fail(TwGetStr(105285))
end
function prototype:cellSizeForTable(...)
  return CCSizeMake(563, 117)
end
function prototype:tableCellAtIndex(table, index, cell, curPage)
  if not cell then
    cell = CCTableViewCellEx:create()
    local subScene = Tw.Controller:load("ActivityChargeItem", self.rootNode)
    subScene:Refrash(self.data[index + 1])
    cell:addChild(subScene, 0, 2)
  end
  cell:getChildByTag(2):Refrash(self.data[index + 1])
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
