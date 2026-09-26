module((...), package.seeall)
require("SceneHelper")
require("TableViewEx")
require("Logic.Activity")
require("BtnPosition")
prototype = BtnPosition.prototype:extend()
local MIN_GET_FRIEND_NUM = 3
function prototype:initialize()
  super.initialize(self)
  Logic:Get("Activity"):On(Logic.Activity.EVT.CLICK_ACTIVITY_COPY_ITEM, self:Event("onClickItem"))
  Logic:Get("Activity"):On(Logic.Activity.EVT.OPEN_BATTLE_FRIEND, self:Event("onOpenBattleFriend"))
  Logic:Get("Battle"):On(Logic.Battle.EVT.BATTLE_FRIEND_SCENE_RETURN, self:Event("onBattleFriendSceneReturn"))
  self.titleinfo = {}
  self.data = {}
end
function prototype:cellSizeForTable(...)
  return CCSizeMake(563, 120)
end
function prototype:tableCellAtIndex(table, index, cell, curPage)
  if not cell then
    cell = CCTableViewCellEx:create()
    local subScene = Tw.Controller:load("ActivityBattleCopyNode", self.rootNode)
    subScene:reFrashInfo(self.titleinfo[index + 1])
    cell:addChild(subScene, 0, 2)
  else
    cell:getChildByTag(2):reFrashInfo(self.titleinfo[index + 1])
  end
  return cell
end
function prototype:numberOfCellsInTableView(curPage)
  return #self.data[curPage]
end
function prototype:getcurActiveId(idx)
  local i = 1
  local result = ""
  for k, v in pairs(table_name) do
    if idx == i then
      result = k
      return result
    end
    i = i + 1
  end
  return result
end
function prototype:tableCellTouched(table, cell)
  local idx = tolua.cast(cell, "CCTableViewCellEx"):getIdx()
end
function prototype:tablePageTurn(curPage)
  self.tableViewControl:RequireUpdate()
end
function prototype:onEnter()
  super.onEnter(self)
  Logic:Get("BattleShow"):On(Logic.BattleShow.EVT.END, self:Event("onBattleFinished"))
  Logic:Get("Activity"):On(Logic.Activity.EVT.GETED_MSG_RETURN, self:Event("reFrashFightTimes"))
  local activeName, _ = Logic:Get("Activity"):getEachGrpNameAndAward(Logic:Get("Activity"):getCurrentActivity())
  self.activityName:setString(activeName)
  self.titleinfo = self:getAllBattleInfo()
  self.data = {
    self.titleinfo
  }
  self:createList()
end
function prototype:createList()
  self.tableViewControl = TableViewEx.prototype:createList(self, self.lstBattleCopy, 1)
  self.tableViewControl:RequireUpdate()
  self.tableViewControl.tableView:setDirection(kCCScrollViewDirectionVertical)
  self.lstBattleCopy:addChild(self.tableViewControl.tableView)
end
function prototype:getAllBattleInfo()
  local result = {}
  result = Logic:Get("Activity"):getBattleCopyInfoForUI()
  return result
end
function prototype:onBtnReturn(sender, event)
  self:closeSceneDelay(function()
    Logic:Get("Activity"):FireEvent(Logic.Activity.EVT.REFRESH_ACTIVE_COPY)
    SceneHelper:popScene()
  end)
end
function prototype:onBattleFinished()
  Logic:Get("Activity"):PostActivesMsg()
end
function prototype:reFrashFightTimes()
  self.titleinfo = self:getAllBattleInfo()
  self.data = {
    self.titleinfo
  }
  self.tableViewControl:RequireUpdate()
end
function prototype:closeSceneDelay(funDelay)
  if self.tableViewControl and self.tableViewControl.tableView then
    self.tableViewControl.tableView:runUIAnimat(false)
  end
  local arrAction = CCArray:create()
  arrAction:addObject(CCDelayTime:create(0.3))
  arrAction:addObject(CCCallFuncN:create(function()
    if funDelay then
      funDelay()
    end
  end))
  self.rootNode:runAction(CCSequence:create(arrAction))
end
function prototype:openNewSceneDelay(funOpen)
  if self.tableViewControl and self.tableViewControl.tableView then
    self.tableViewControl.tableView:runUIAnimat(false)
  end
  local arrAction = CCArray:create()
  arrAction:addObject(CCDelayTime:create(0.2))
  arrAction:addObject(CCCallFuncN:create(function()
    if funOpen then
      funOpen()
    end
  end))
  self.rootNode:runAction(CCSequence:create(arrAction))
end
function prototype:onClickItem()
  self:openNewSceneDelay(function()
    SceneHelper:pushScene("BattleCopyFriend")
  end)
end
function prototype:onOpenBattleFriend()
  self:openNewSceneDelay(function()
    SceneHelper:pushScene("BattleCopyFriend")
  end)
end
function prototype:onBattleFriendSceneReturn()
  self.tableViewControl.tableView:runUIAnimat(true)
end
function prototype:actionFinish(tableView)
  if not Logic:Get("Guide"):isGuiding() then
    return
  end
  local idx = 1
  local cell = tableView:cellAtIndex(idx - 1)
  if cell == nil then
    return
  end
  local item = cell:getChildByTag(2)
  if item == nil then
    return
  end
  item:updateGuide()
end
