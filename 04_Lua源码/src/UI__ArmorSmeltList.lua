module((...), package.seeall)
require("SceneHelper")
require("TableViewEx")
prototype = Tw.Controller.prototype:extend()
local DEFT_NUMS = 20
function prototype:onEnter()
  self.ttfPage:setStyle(kCCLabelTTFStyleOutline)
  Logic:Get("Armor"):initTempSmeltList()
  local data = Logic:Get("Armor"):GetSmeltList()
  self:updateTbv(data or {})
  Logic:Get("Armor"):On(Logic.Armor.EVT.REFRESH_SMELT_LIST, self:Event("OnRefreshSmeltList"))
end
function prototype:updateTbv(data)
  if not data then
    return
  end
  self.data = data
  self:sort()
  self.allNums = #data or 0
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
  Logic:Get("Armor"):finalySmeltList()
  local bRare = Logic:Get("Armor"):CheckRareArmor()
  if bRare then
    Prompt:Select(self, "", 111151, self.OnConfirmOK)
  else
    self:OnConfirmOK(Logic.SureConfirm.RET.OK)
  end
end
function prototype:OnConfirmOK(ret)
  if ret == Logic.SureConfirm.RET.OK then
    SceneHelper:removeScene("ArmorSmeltList")
    Logic:Get("Armor"):PostRefreshCell()
  end
end
function prototype:onBtnReturn(sender, event)
  SceneHelper:removeScene("ArmorSmeltList")
  Logic:Get("Armor"):PostRefreshCell()
end
function prototype:onBg()
end
function prototype:numberOfCellsInTableView(curPage)
  if self.allPage == 0 then
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
    local subNode = Tw.Controller:load("ArmorSmeltListItem", self.rootNode)
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
  local tempSmeltIds = Logic:Get("Armor"):GetCheckedTempSmelt()
  local smeltIds = Logic:Get("Armor"):GetCheckedSmelt()
  local visible = not table.empty(tempSmeltIds) or not table.empty(smeltIds)
  self.nodeBottom:setVisible(visible)
end
function prototype:sort()
  table.sort(self.data, function(param1, param2)
    local info1 = Logic:Get("Armor"):getArmorInfoByBaseId(param1.baseId)
    local info2 = Logic:Get("Armor"):getArmorInfoByBaseId(param2.baseId)
    if not info1 or not info2 then
      return false
    end
    local checked1 = Logic:Get("Armor"):IsCheckSmelt(param1.id)
    local checked2 = Logic:Get("Armor"):IsCheckSmelt(param2.id)
    if checked1 ~= checked2 then
      return checked1 or not checked2
    elseif info1.rank ~= info2.rank then
      return info1.rank < info2.rank
    elseif info1.star ~= info2.star then
      return info1.star < info2.star
    else
      return param1.baseId < param2.baseId
    end
  end)
end
