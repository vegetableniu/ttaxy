module((...), package.seeall)
require("SceneHelper")
require("BtnPosition")
prototype = BtnPosition.prototype:extend()
local MAX_GROUP = 3
function prototype:initialize(...)
  super.initialize(self, ...)
end
function prototype:dispose(...)
  super.dispose(self)
end
function prototype:onEnter()
  super.onEnter(self)
  self.selected = nil
  Logic:Get("Devil"):On(Logic.Devil.EVT.REFRESH_GROUP_DATA, self:Event("onRefreshGroupData"))
  Logic:Get("Hero"):On(Logic.Hero.EVT.SWITCH_HERO_GROUP, self:Event("onSwitchGroup"))
  Logic:Get("Lineup"):On(Logic.Lineup.EVT.USE_TEAM, self:Event("onUseTeam"))
  local bLockLineup = Logic:Get("Lock"):checkStatusById("HERO_TEAM")
  local node = bLockLineup and self.nodLockList or self.m_pCList
  self:showLineup(bLockLineup)
  self:onRefreshGroupData()
  self.tableViewControl = TableViewEx.prototype:createList(self, node, 1)
  self.tableViewControl.tableView:setDirection(kCCScrollViewDirectionVertical)
  node:addChild(self.tableViewControl.tableView)
  local teamInfo = Logic:Get("Lineup"):getTeamInfo()
  if not bLockLineup and table.empty(teamInfo) then
    MsgHero:Post("GET_TEAM_INFO")
  end
end
function prototype:onExit()
  self.allHeroTable = {}
end
function prototype:onNodeLoaded(node, loader)
end
function prototype:showLineup(bLock)
  self.nodSave:setVisible(not bLock)
end
function prototype:onBtnSave(sender, event)
  for i, data in ipairs(self.allHeroTable or {}) do
    if data.heros.leaderId == ID[-1] then
      Logic:Get("Devil"):SetChangeType(Logic.Hero.EVT.LEADER_CHANGE)
      Logic:Get("Devil"):SetChangeGroup(data)
      SceneHelper:pushScene("DevilTeamerSelect", self.rootNode)
      return
    end
  end
  SceneHelper:pushScene("LineupSave", self.rootNode)
end
function prototype:onBtnSelect(sender, event)
  local bLockLineup = Logic:Get("Lock"):checkStatusById("HERO_TEAM")
  if bLockLineup then
    if event == CCControlEventTouchDown then
      Logic:Get("Lock"):showLockTipById("HERO_TEAM")
    end
    Logic:Get("Lock"):closeLockTip(event)
    return
  end
  if event ~= CCControlEventTouchUpInside then
    return
  end
  SceneHelper:pushScene("Lineup", self.rootNode)
end
function prototype:onRefreshGroupData()
  self.allHeroTable = {}
  local heros = {}
  local groups = Logic:Get("Hero"):GetGroups()
  local backIdx = 0
  local str = ""
  for i, v in pairs(groups) do
    if i == 1 then
      str = TwGetStr(105532) .. TwGetStr(105533)
    elseif backIdx >= 0 and backIdx <= 10 then
      str = TwGetStr(105534, TwGetStr(102131 + backIdx))
      backIdx = backIdx + 1
    end
    table.insert(self.allHeroTable, {
      name = str,
      heros = v,
      sort = i
    })
  end
  local sortGroup = function(groupA, groupB)
    return groupA.sort < groupB.sort
  end
  table.sort(self.allHeroTable, sortGroup)
  self.data = self.allHeroTable
  if self.tableViewControl then
    self.tableViewControl:RequireUpdate()
  end
end
function prototype:onBtnReturn(sender, event)
  SceneHelper:popScene()
end
function prototype:getbtnStatues(groupId)
  if self.selected == nil then
    return "NORMAL"
  end
  if self.selected == groupId then
    return "SELECTED"
  end
  return "SHINING"
end
function prototype:selectedGroup(groupId)
  if self.selected == nil then
    self.selected = groupId
    self.tableViewControl:RequireUpdate()
    return
  end
  if self.selected == 1 then
    Logic:Get("Hero"):PostSwitchGroup(groupId)
    return
  end
  if groupId == 1 then
    Logic:Get("Hero"):PostSwitchGroup(self.selected)
    return
  end
  MsgHero:Post("SWITCH_GROUP")
end
function prototype:onSwitchGroup()
  self.selected = nil
  self:onRefreshGroupData()
end
function prototype:onUseTeam()
  self:onRefreshGroupData()
end
function prototype:cellSizeForTable(...)
  return CCSizeMake(588, 275)
end
function prototype:tableCellAtIndex(table, index, cell, curPage)
  if not cell then
    cell = CCTableViewCellEx:create()
    local subScene = Tw.Controller:load("DevilGroupItem", self.rootNode)
    cell:addChild(subScene, 0, 2)
  end
  cell:getChildByTag(2):RefreshHeroInfo(self.data[index + 1], self)
  return cell
end
function prototype:numberOfCellsInTableView(curPage)
  if #self.allHeroTable == 0 then
    return 0
  else
    return #self.allHeroTable
  end
end
function prototype:tableCellTouched(table, cell)
  local idx = tolua.cast(cell, "CCTableViewCellEx"):getIdx()
end
function prototype:tablePageTurn(curPage)
  self.tableViewControl:RequireUpdate()
end
