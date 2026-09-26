module((...), package.seeall)
require("SceneHelper")
require("TableViewEx")
prototype = Tw.Controller.prototype:extend()
local DEFT_NUMS = 20
function prototype:onEnter()
  self.ttfPage:setStyle(kCCLabelTTFStyleOutline)
  self.data = {}
  Logic:Get("SmeltResource"):initTempSmeltList()
  self.data = Logic:Get("SmeltResource"):getSmeltList()
  self:sort()
  self:updateTbv()
  Logic:Get("SmeltResource"):On(Logic.SmeltResource.EVT.REFRESH_LIST, self:Event("OnRefreshSmeltList"))
end
function prototype:updateTbv()
  if not self.data then
    return
  end
  self.allNums = #self.data or 0
  self.allPage = math.ceil(self.allNums / DEFT_NUMS) or 0
  if not self.tableViewControl then
    self.tableViewControl = TableViewEx.prototype:createList(self, self.m_pList, self.allPage)
    if self.tableViewControl and self.tableViewControl.tableView then
      self.ttfPage:setString(1 .. "/" .. self.allPage)
      self.m_pList:addChild(self.tableViewControl.tableView)
      self.tableViewControl:RequireUpdate()
    end
  else
    self.tableViewControl:RequireUpdate()
  end
end
function prototype:onBtnOK(sender, event)
  Logic:Get("SmeltResource"):finalySmeltList()
  Logic:Get("SmeltResource"):PostRefreshCell()
  SceneHelper:removeScene("SmeltResourceList")
end
function prototype:onBtnReturn(sender, event)
  SceneHelper:removeScene("SmeltResourceList")
end
function prototype:numberOfCellsInTableView(curPage)
  if self.allPage == 0 then
    self.ttfPage:setString(curPage .. "/" .. 1)
    return 0
  end
  if curPage == self.allPage then
    return self.allNums - (curPage - 1) * DEFT_NUMS
  end
  return DEFT_NUMS
end
function prototype:cellSizeForTable()
  return CCSizeMake(590, 130)
end
function prototype:tableCellAtIndex(table, index, cell, curPage)
  local idx = (curPage - 1) * DEFT_NUMS + index + 1
  if not cell then
    cell = CCTableViewCellEx:create()
    local subNode = Tw.Controller:load("SmeltResourceListItem", self.rootNode)
    if subNode then
      subNode:refresh(self.data[idx])
      cell:addChild(subNode, 0, 1)
    end
  else
    cell:getChildByTag(1):refresh(self.data[idx])
  end
  return cell
end
function prototype:tablePageTurn(curPage)
  self.ttfPage:setString(curPage .. "/" .. self.allPage)
  self.tableViewControl:RequireUpdate()
end
function prototype:tableCellTouched()
end
function prototype:OnRefreshSmeltList()
  self.tableViewControl:RequireUpdateWithoutAnimat()
  local tempSmeltIds = Logic:Get("SmeltResource"):GetCheckedSmeltList()
  local visible = not table.empty(tempSmeltIds)
  self.nodeBottom:setVisible(visible)
end
function prototype:sort()
  table.sort(self.data, function(param1, param2)
    if param1.type ~= param2.type then
      return param1.sort < param2.sort
    end
    if param1.type == "EQUIPMENT" then
      if param1.rank ~= param2.rank then
        return param1.rank < param2.rank
      end
      if param1.star == param2.star then
        return param1.id < param2.id
      end
      return param1.star < param2.star
    end
    local card1 = param1.card == "EXP_CARD" and 1 or 0
    local card2 = param2.card == "EXP_CARD" and 1 or 0
    if card1 ~= card2 then
      return card1 > card2
    end
    if param1.star ~= param2.star then
      return param1.star < param2.star
    end
    if param1.id == param2.id then
      return param1.cardId < param2.cardId
    end
    return param1.id < param2.id
  end)
end
