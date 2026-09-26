module((...), package.seeall)
require("SceneHelper")
require("TableViewEx")
prototype = Tw.Controller.prototype:extend()
local DEFT_NUMS = 10
function prototype:onEnter()
  self.ttfPage:setStyle(kCCLabelTTFStyleOutline)
  Logic:Get("Armor"):On(Logic.Armor.EVT.ON_COMPOSE, self:Event("OnArmorCombine"))
  Logic:Get("Armor"):On(Logic.Armor.EVT.ON_EQUIP_PACK, self:Event("OnArmorPack"))
  Logic:Get("Armor"):PostEquipPackInfo()
end
function prototype:updateTbv(data)
  if not data then
    return
  end
  self.data = data
  self.allNums = #data or 0
  self.allPage = math.ceil(self.allNums / DEFT_NUMS) or 0
  if self.allPage == 0 then
    return
  end
  if not self.tableViewControl then
    self.tableViewControl = TableViewEx.prototype:createList(self, self.m_pList, self.allPage)
    if self.tableViewControl and self.tableViewControl.tableView then
      self.ttfPage:setString(1 .. "/" .. self.allPage)
      self.m_pList:addChild(self.tableViewControl.tableView)
      self.tableViewControl:RequireUpdate(self.allPage)
    end
  else
    self.tableViewControl:RequireUpdate(self.allPage)
  end
end
function prototype:refresh()
  self:updateTbv(self.data)
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
  return CCSizeMake(590, 140)
end
function prototype:tableCellAtIndex(table, index, cell, curPage)
  local idx = (curPage - 1) * DEFT_NUMS + index + 1
  if not cell then
    cell = CCTableViewCellEx:create()
    local subNode = Tw.Controller:load("ArmorCombineItem", self.rootNode)
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
function prototype:OnArmorCombine(count, baseId)
  local rec = Logic:Get("Armor"):getArmorInfoByBaseId(baseId)
  local name = rec and rec.name or ""
  local tip = TwGetStr(111135, count, name, name)
  Prompt:Confirm(self, "", tip)
  local data = Logic:Get("Armor"):GetFragments()
  self:updateTbv(data or {})
end
function prototype:OnArmorPack()
  local data = Logic:Get("Armor"):GetFragments()
  self:updateTbv(data or {})
end
