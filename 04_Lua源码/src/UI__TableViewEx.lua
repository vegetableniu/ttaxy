module((...), package.seeall)
prototype = {}
local TURN_LEFT = 1
local TURN_RIGHT = -1
RESET_POS_TYPE = {RESET_TOP = 0, RESET_OLD_POS = 1}
local Clamp = function(value, min, max)
  if max < min then
    local tmp = min
    min = max
    max = tmp
  end
  return value >= max and max or value < min and min or value
end
function prototype:createList(objSelf, cnode, pageCount, needScrollBar)
  local tableViewControl = {}
  tableViewControl.proxy = CCTableViewProxy:create()
  if tableViewControl.proxy == nil then
    return
  end
  function tableViewControl:RequireUpdate(pageCount, needAnimat, needResetPos)
    tableViewControl.pageCount = pageCount and pageCount or tableViewControl.pageCount
    tableViewControl.pageNum = Clamp(tableViewControl.pageNum, 1, tableViewControl.pageCount)
    if needAnimat == nil then
      needAnimat = true
    end
    if tableViewControl.tableView ~= nil then
      do
        local ClampPos = function(pos, minPos, maxPos)
          pos.y = math.min(pos.y, maxPos.y)
          pos.y = math.max(pos.y, minPos.y)
          return pos
        end
        local function slinceUpadate(needAnimat)
          local pos = tableViewControl.tableView:getContainer():getPositionLua()
          tableViewControl.tableView:reloadData(false)
          local minPos = tableViewControl.tableView:minContainerOffset()
          local maxPos = tableViewControl.tableView:maxContainerOffset()
          if pos.y > 0 then
            tableViewControl.tableView:resetOffsetPositon()
          else
            tableViewControl.tableView:setContentOffset(ClampPos(pos, minPos, maxPos), false)
          end
          if needAnimat then
            tableViewControl.tableView:runUIAnimat(true)
          end
        end
        if needAnimat then
          if needResetPos == RESET_POS_TYPE.RESET_OLD_POS then
            local arrAction = CCArray:create()
            arrAction:addObject(CCDelayTime:create(0))
            arrAction:addObject(CCCallFuncN:create(function()
              tableViewControl.tableView:runAction(CCCallFuncN:create(function()
                tableViewControl.tableView:getContainer():setVisible(true)
                slinceUpadate(needAnimat)
              end))
            end))
            tableViewControl.tableView:runAction(CCSequence:create(arrAction))
            tableViewControl.tableView:getContainer():setVisible(false)
          else
            local arrAction = CCArray:create()
            arrAction:addObject(CCDelayTime:create(0))
            arrAction:addObject(CCCallFuncN:create(function()
              tableViewControl.tableView:runAction(CCCallFuncN:create(function()
                tableViewControl.tableView:getContainer():setVisible(true)
                tableViewControl.tableView:reloadData(needAnimat)
              end))
            end))
            tableViewControl.tableView:runAction(CCSequence:create(arrAction))
            tableViewControl.tableView:getContainer():setVisible(false)
          end
        elseif needResetPos == RESET_POS_TYPE.RESET_OLD_POS then
          slinceUpadate(needAnimat)
        elseif needResetPos == true or needResetPos == RESET_POS_TYPE.RESET_TOP then
          tableViewControl.tableView:reloadDataAndResetOffset()
        else
          tableViewControl.tableView:reloadData(needAnimat)
        end
      end
    end
  end
  function tableViewControl:RequireUpdateWithoutAnimat(pageCount, needResetPos)
    tableViewControl:RequireUpdate(pageCount, false, needResetPos)
  end
  function tableViewControl:GetPage()
    return tableViewControl.pageNum
  end
  function tableViewControl:TurnPage(dir)
    if tableViewControl.pageCount < 1 or type(dir) ~= "number" then
      return
    end
    local _pageNum = tableViewControl.pageNum
    tableViewControl.pageNum = tableViewControl.pageNum + dir
    if tableViewControl.pageTurnRepeat then
      if tableViewControl.pageNum > tableViewControl.pageCount then
        tableViewControl.pageNum = 1
      elseif 1 > tableViewControl.pageNum then
        tableViewControl.pageNum = tableViewControl.pageCount
      end
    else
      tableViewControl.pageNum = math.min(tableViewControl.pageNum, tableViewControl.pageCount)
      tableViewControl.pageNum = math.max(tableViewControl.pageNum, 1)
    end
    local ret
    if _pageNum ~= tableViewControl.pageNum then
      ret = objSelf:tablePageTurn(tableViewControl.pageNum, dir)
      tableViewControl.tableView:getContainer():setVisible(true)
    end
    return ret
  end
  function tableViewControl:TurnPageTo(Index, needRefresh, needAnimat)
    if tableViewControl.pageCount < 1 or type(Index) ~= "number" then
      return
    end
    tableViewControl.pageNum = Index
    tableViewControl.pageNum = math.min(tableViewControl.pageNum, tableViewControl.pageCount)
    tableViewControl.pageNum = math.max(tableViewControl.pageNum, 1)
    if needRefresh then
      if needAnimat then
        tableViewControl.tableView:reloadData(true)
      else
        tableViewControl.tableView:reloadDataAndResetOffset()
      end
    end
  end
  function tableViewControl:SetTurnRepeat(state)
    if state == true then
      tableViewControl.pageTurnRepeat = state
    elseif state == false then
      tableViewControl.pageTurnRepeat = state
    end
  end
  tableViewControl.pageNum = 1
  tableViewControl.pageCount = pageCount
  tableViewControl.pageTurnRepeat = true
  tableViewControl.proxy:hook(function(name, table, arg1, arg2)
    local retValue
    if name == "cellSizeForTable" then
      retValue = objSelf:cellSizeForTable(table, arg1, arg2)
    elseif name == "tableCellAtIndex" then
      retValue = objSelf:tableCellAtIndex(table, arg1, arg2, tableViewControl.pageNum)
    elseif name == "numberOfCellsInTableView" then
      retValue = objSelf:numberOfCellsInTableView(tableViewControl.pageNum)
    elseif name == "tableCellTouched" then
      retValue = objSelf:tableCellTouched(table, arg1, arg2)
    elseif name == "tablePageTurn" then
      retValue = tableViewControl:TurnPage(arg1)
    elseif name == "actionFinish_Open" or name == "actionFinish" then
      if objSelf.actionFinish ~= nil then
        objSelf:actionFinish(table, arg1)
      end
    elseif name == "actionFinish_Close" and objSelf.actionFinish_Close ~= nil then
      objSelf:actionFinish_Close(table, arg1)
    end
    return retValue
  end)
  local oldContentSize = cnode:getContentSize()
  local scaleX = cnode:getScaleX()
  local scaleY = cnode:getScaleY()
  local newContentSize = CCSizeMake(oldContentSize.width * scaleX, oldContentSize.height * scaleY)
  cnode:setContentSize(newContentSize)
  cnode:setScale(1)
  local contentSize = cnode:getContentSize()
  tableViewControl.tableView = CCTableViewEx:create(tableViewControl.proxy, CCSizeMake(newContentSize.width, newContentSize.height))
  if tableViewControl.tableView == nil then
    tableViewControl = {}
    return nil
  end
  tableViewControl.tableView:setDirection(kCCScrollViewDirectionBoth)
  tableViewControl.tableView:setPosition(ccp(0, 0))
  if needScrollBar or needScrollBar == nil then
    local bar = CCScale9Sprite:create("images/public/imgSlider.png")
    local barBg = CCScale9Sprite:create("images/public/imgSliderBg.png")
    tableViewControl.tableView:setScrollBar(bar, barBg)
  end
  local oldRunUIAnimat = tableViewControl.tableView.runUIAnimat
  function tableViewControl.tableView:runUIAnimat(isOpen)
    if isOpen or isOpen == nil then
      tableViewControl.tableView:getContainer():setVisible(false)
    end
    local arrAction = CCArray:create()
    arrAction:addObject(CCDelayTime:create(0))
    arrAction:addObject(CCCallFuncN:create(function()
      tableViewControl.tableView:runAction(CCCallFuncN:create(function()
        tableViewControl.tableView:getContainer():setVisible(true)
        oldRunUIAnimat(self, isOpen or isOpen == nil and true or false)
      end))
    end))
    tableViewControl.tableView:runAction(CCSequence:create(arrAction))
  end
  return tableViewControl
end
