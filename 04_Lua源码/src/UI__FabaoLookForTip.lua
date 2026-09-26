module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
function prototype:onEnter()
  self.btnSureTwo:setString(TwGetStr(103117))
  self.rew = Logic:Get("FabaoLookFor"):GetRewardResult()
  local strArr = Logic:Get("FabaoLookFor"):GetTreaRewStrTip(self.rew.rewards, self.rew.solds)
  self.strArr = strArr or {}
  self.page = 1
  self.tableViewControl = TableViewEx.prototype:createList(self, self.m_pCList, self.page)
  self.tableViewControl.tableView:setDirection(kCCScrollViewDirectionVertical)
  self.m_pCList:addChild(self.tableViewControl.tableView)
end
function prototype:onExit()
  if Logic:Get("FabaoLookFor"):isDrawing() then
    Logic:Get("FabaoLookFor"):setDrawing(false)
    Logic:Get("Guide"):check()
  end
  Logic:Get("WeChat"):OpenWeChat()
end
function prototype:cellSizeForTable(...)
  return CCSizeMake(560, 32)
end
function prototype:tableCellAtIndex(table, index, cell, curPage)
  if not cell then
    cell = CCTableViewCellEx:create()
    local subScene = Tw.Controller:load("FabaoLookForTipItem", self.rootNode)
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
