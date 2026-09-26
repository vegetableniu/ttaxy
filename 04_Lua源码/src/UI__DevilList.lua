module((...), package.seeall)
require("SceneHelper")
require("BtnPosition")
prototype = BtnPosition.prototype:extend()
local MAX_ITEM = 20
function prototype:initialize(...)
  super.initialize(self, ...)
  self.data = {}
  self.devilCnt = 0
end
function prototype:dispose(...)
  super.dispose(self)
end
function prototype:onEnter()
  super.onEnter(self)
  self.ttfNotFound:setStyle(kCCLabelTTFStyleOutline)
  local list = Logic:Get("Devil"):getDevilList()
  local killList = Logic:Get("Devil"):getKillList()
  for _, v in pairs(killList) do
    table.insert(list, 1, v)
  end
  self.data = list
  self.devilCnt = #self.data
  self.page = math.ceil(#self.data / MAX_ITEM)
  self.tableViewControl = TableViewEx.prototype:createList(self, self.m_pList, self.page)
  if self.page == 1 then
    self.tableViewControl.tableView:setDirection(kCCScrollViewDirectionVertical)
  end
  self.m_pList:addChild(self.tableViewControl.tableView)
  if not table.empty(self.data) then
    self.tableViewControl:RequireUpdate()
  else
    self.sprNotFound:setVisible(true)
    self.ttfNotFound:setString(TwGetStr(105508))
  end
  Logic:Get("Devil"):On(Logic.Devil.EVT.UPDATE_DAMOG_LIST, self:Event("OnUpdateDamogList"))
  Logic:Get("Devil"):showPhyWaitTime()
end
function prototype:onNodeLoaded(node, loader)
end
function prototype:onBtnReturnClicked(sender, event)
  SceneHelper:runWithScene("DevilMain", self.rootNode)
end
function prototype:onBtnLeftClicked(sender, event)
  if self.tableViewControl ~= nil then
    self.tableViewControl:TurnPage(-1)
  end
end
function prototype:onBtnRightClicked(sender, event)
  if self.tableViewControl ~= nil then
    self.tableViewControl:TurnPage(1)
  end
end
function prototype:cellSizeForTable(...)
  return CCSizeMake(640, 170)
end
function prototype:tableCellAtIndex(table, index, cell, curPage)
  local lstIdx = index + 1 + (curPage - 1) * MAX_ITEM
  local key = self.data[lstIdx]
  if not cell then
    cell = CCTableViewCellEx:create()
    local subScene = Tw.Controller:load("DevilListItem", self.rootNode)
    subScene:Refrash(key)
    cell:addChild(subScene, 0, 2)
  else
    cell:getChildByTag(2):Refrash(key)
  end
  return cell
end
function prototype:numberOfCellsInTableView(curPage)
  if self.data == nil or table.empty(self.data) then
    return 0
  end
  self.ttfPage:setString(curPage .. "/" .. self.page)
  if self.page == curPage then
    local num = #self.data - (self.page - 1) * MAX_ITEM
    return num
  else
    return MAX_ITEM
  end
end
function prototype:tableCellTouched(table, cell)
  local idx = tolua.cast(cell, "CCTableViewCellEx"):getIdx()
end
function prototype:tablePageTurn(curPage)
  self.tableViewControl:RequireUpdate()
end
function prototype:OnUpdateDamogList(killId)
  self.data = {}
  local list = Logic:Get("Devil"):getDevilList()
  if killId then
    for i = #list, 1, -1 do
      if list[i].id == killId then
        table.remove(list, i)
        break
      end
    end
    local bHasReward = false
    for i, v in ipairs(list) do
      if v.killed == true then
        bHasReward = true
        break
      end
    end
    if not bHasReward then
      Logic:Get("Devil"):FireEvent(Logic.Devil.EVT.PUSH_NEW_REWARD)
    end
  end
  self.data = list
  self.page = math.ceil(#self.data / MAX_ITEM)
  if self.devilCnt ~= #self.data then
    self.devilCnt = #self.data
    if self.devilCnt <= 0 then
      self.sprNotFound:setVisible(true)
      self.ttfNotFound:setString(TwGetStr(105508))
    end
    self.tableViewControl:RequireUpdate()
  else
    self.tableViewControl.tableView:refreshData()
  end
end
