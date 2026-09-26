module((...), package.seeall)
require("SceneHelper")
require("TableViewEx")
require("Logic.Compose")
require("BtnPosition")
prototype = BtnPosition.prototype:extend()
function prototype:onEnter()
  super.onEnter(self)
  local giftInfo = Logic:Get("Gift"):GetActivityGift()
  self.ttfTitle:setColor(ccc3(255, 183, 18))
  self.ttfTitle:setString(giftInfo.name)
  self.ttfTitle:setStyle(kCCLabelTTFStyleOutline)
  self.ani = Logic:Get("AniMgr"):NewCCB("UI/UIcz", self.sprRight, ccp(35, 19), 0, nil, nil)
  if self.ani then
    self.ani:RunAni()
  end
  self.data = {}
  self.page = 0
  self.tableViewControl = TableViewEx.prototype:createList(self, self.nodList, self.page)
  self.nodList:addChild(self.tableViewControl.tableView)
  Logic:Get("JuHuaSuan"):PostGetInfo()
  Logic:Get("JuHuaSuan"):On(Logic.JuHuaSuan.EVT.GET_INFO, self:Event("onGetInfo"))
end
function prototype:onBtnReturn()
  SceneHelper:runWithScene("GiftActivityList", self.rootNode)
end
function prototype:onBtnRecharge(sender, event)
  Logic:Get("Main"):GotoRecharge()
end
function prototype:onGetInfo()
  self.data = Logic:Get("JuHuaSuan"):GetShowList()
  self.page = math.ceil(#self.data / Logic.Compose.MAX_LIST)
  self.tableViewControl:RequireUpdate()
end
function prototype:cellSizeForTable(...)
  return CCSizeMake(588, 147)
end
function prototype:tableCellAtIndex(table, index, cell, curPage)
  local idx = index + 1
  local lstIdx = idx + (curPage - 1) * Logic.Compose.MAX_LIST
  local key = self.data[lstIdx]
  if not cell then
    cell = CCTableViewCellEx:create()
    local subScene = Tw.Controller:load("GiftHuaSuanItem", self.rootNode)
    subScene:fresh(key, index)
    cell:addChild(subScene, 0, 2)
  else
    cell:getChildByTag(2):fresh(key, index)
  end
  return cell
end
function prototype:numberOfCellsInTableView(curPage)
  if self.page == 0 then
    self.page = 1
  end
  self.ttfPage:setString(curPage .. "/" .. self.page)
  if table.empty(self.data or {}) then
    return 0
  end
  if self.page == curPage then
    local num = #self.data - (self.page - 1) * Logic.Hero.MAX_HEROS_PER_PAGE
    return num
  else
    return Logic.Compose.MAX_LIST
  end
end
function prototype:tableCellTouched(table, cell)
end
function prototype:tablePageTurn(curPage)
  self.tableViewControl:RequireUpdate()
end
function prototype:onBtnLeft()
  if self.tableViewControl then
    self.tableViewControl:TurnPage(-1)
  end
end
function prototype:onBtnRight()
  if self.tableViewControl then
    self.tableViewControl:TurnPage(1)
  end
end
