module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
function prototype:onEnter()
  self.btnSureTwo:setString(TwGetStr(103117))
  self.rew = Logic:Get("Treasure"):GetRewardResult()
  local strArr = Logic:Get("Treasure"):GetTreaRewStrTip(self.rew.rewards, self.rew.solds)
  if #strArr == 0 then
    self.strArr = {}
  else
    self.strArr = strArr
  end
  self.page = 1
  self.tableViewControl = TableViewEx.prototype:createList(self, self.m_pCList, self.page)
  self.tableViewControl.tableView:setDirection(kCCScrollViewDirectionVertical)
  self.m_pCList:addChild(self.tableViewControl.tableView)
end
function prototype:onExit()
  if Logic:Get("Treasure"):isDrawing() then
    Logic:Get("Treasure"):setDrawing(false)
    Logic:Get("Guide"):check()
  end
end
function prototype:cellSizeForTable(...)
  return CCSizeMake(560, 32)
end
function prototype:tableCellAtIndex(table, index, cell, curPage)
  if not cell then
    cell = CCTableViewCellEx:create()
    local subScene = Tw.Controller:load("TreasureTipItem", self.rootNode)
    subScene:ReFrashReward(self.strArr[index + 1], index + 1)
    cell:addChild(subScene, 0, 2)
  else
    cell:getChildByTag(2):ReFrashReward(self.strArr[index + 1], index + 1)
  end
  return cell
end
function prototype:numberOfCellsInTableView(curPage)
  if #self.strArr == 0 then
    return 1
  end
  return #self.strArr
end
function prototype:tableCellTouched(table, cell)
  local idx = tolua.cast(cell, "CCTableViewCellEx"):getIdx()
end
function prototype:tablePageTurn(curPage)
  self.tableViewControl:RequireUpdate()
end
function prototype:onBtnSure(node, loader)
  local actionScaleTo = CCScaleTo:create(0.1, 0.3)
  local arr1 = CCArray:create()
  arr1:addObject(actionScaleTo)
  arr1:addObject(CCCallFuncN:create(function()
    SceneHelper:removePrompt(self.rootNode)
  end))
  self.layer:runAction(CCSequence:create(arr1))
end
