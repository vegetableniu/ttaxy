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
  Logic:Get("Devil"):On(Logic.Devil.EVT.UPDATE_REWARD_LIST, self:Event("RefrashGiftInfo"))
  self.allGiftIdTable = Logic:Get("Devil"):initRewardData()
  Logic:Get("Devil"):removeDrawFeatReward(self.allGiftIdTable)
  self:showDrawBtn()
  self.data = self.allGiftIdTable
  self.page = math.ceil(#self.allGiftIdTable / Logic.Compose.MAX_LIST)
  self.tableViewControl = TableViewEx.prototype:createList(self, self.m_pCList, self.page)
  if self.page == 1 then
    self.tableViewControl.tableView:setDirection(kCCScrollViewDirectionVertical)
  end
  self.m_pCList:addChild(self.tableViewControl.tableView)
end
function prototype:onNodeLoaded(node, loader)
end
function prototype:showDrawBtn()
  local funcLock = Logic:Get("Lock"):checkStatusById("DEMOG_DRAW_REWARDS")
  self.btnDrawAll:setVisible(not funcLock)
  self.sprRight:setVisible(not funcLock)
  self.imgBtnRightBg:setVisible(not funcLock)
end
function prototype:onBtnReturn(sender, event)
  SceneHelper:runWithScene("DevilMain", self.rootNode)
end
function prototype:onBtnDrawAll(sender, event)
  local canDrawReward = function(reward)
    local feat = Logic:Get("Devil"):getFeat()
    if feat < reward.feat then
      return false, false
    end
    if reward.showType == "ACTION" and Logic:Get("PlayerInfo"):IsPhysicalPointFull() then
      return false, true
    end
    return true, false
  end
  local sendIds = {}
  local hasPointReward = false
  for _, reward in ipairs(self.data or {}) do
    local canDraw, bActionPointReward = canDrawReward(reward)
    if canDraw then
      table.insert(sendIds, reward.id)
    end
    if bActionPointReward then
      hasPointReward = true
    end
  end
  if table.empty(sendIds) then
    if hasPointReward then
      Prompt:Fail(115154)
      return
    end
    Prompt:Fail(105589)
    return
  end
  Logic:Get("Devil"):postDrawFeatReward(sendIds)
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
function prototype:RefrashGiftInfo()
  self.allGiftIdTable = Logic:Get("Devil"):initRewardData()
  Logic:Get("Devil"):removeDrawFeatReward(self.allGiftIdTable)
  self.data = self.allGiftIdTable
  self.page = math.ceil(#self.allGiftIdTable / Logic.Compose.MAX_LIST)
  self.tableViewControl:RequireUpdate(self.page, true, true)
end
function prototype:cellSizeForTable(...)
  return CCSizeMake(588, 164)
end
function prototype:tableCellAtIndex(table, index, cell, curPage)
  local lstIdx = index + 1 + (curPage - 1) * Logic.Compose.MAX_LIST
  local key = self.allGiftIdTable[lstIdx]
  if not cell then
    cell = CCTableViewCellEx:create()
    local subScene = Tw.Controller:load("DevilGiftItem", self.rootNode)
    subScene:RefrashGiftInfo(key)
    cell:addChild(subScene, 0, 2)
  else
    cell:getChildByTag(2):RefrashGiftInfo(key)
  end
  return cell
end
function prototype:numberOfCellsInTableView(curPage)
  if #self.allGiftIdTable == 0 then
    return 0
  end
  self.ttfPage:setString(curPage .. "/" .. self.page)
  if self.page == curPage then
    local num = #self.allGiftIdTable - (self.page - 1) * Logic.Hero.MAX_HEROS_PER_PAGE
    if num > Logic.Compose.MAX_LIST then
      num = Logic.Compose.MAX_LIST or num
    end
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
