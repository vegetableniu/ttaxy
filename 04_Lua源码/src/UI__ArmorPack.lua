module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
local WIN_WIDTH, WIN_HEIGHT = 590, 120
local PAGE_SIZE = 20
function prototype:onEnter()
  self.ttfPage:setStyle(kCCLabelTTFStyleOutline)
  self.ttfCounts:setStyle(kCCLabelTTFStyleOutline)
  self.ttfTip:setStyle(kCCLabelTTFStyleOutline)
  self:updateArmorList()
  Logic:Get("Armor"):On(Logic.Armor.EVT.ON_ARMORS_CHANGED, self:Event("OnArmorsChanged"))
end
function prototype:updateArmorList()
  self.armorInfos = Logic:Get("Armor"):getAllArmors()
  if table.empty(self.armorInfos) then
    self.sprPageBg:setVisible(false)
    self.imgNumBg:setVisible(false)
    self.ttfTip:setString(TwGetStr(111440))
    self.ttfPage:setString("")
    self.ttfCounts:setString("")
    if self.tableViewControl then
      self.tableViewControl:RequireUpdate(1)
    end
    return
  end
  self:sort()
  self.maxPage = math.ceil(#self.armorInfos / PAGE_SIZE)
  self.ttfPage:setString(TwGetStr(111413, 1, self.maxPage))
  local capacity = Logic:Get("Armor"):curArmorPackCapacity()
  self.ttfCounts:setString(TwGetStr(111414, #self.armorInfos, capacity))
  if not self.tableViewControl then
    self.tableViewControl = TableViewEx.prototype:createList(self, self.itemList, self.maxPage, true)
    self.itemList:addChild(self.tableViewControl.tableView)
  end
  self.tableViewControl:RequireUpdate(self.maxPage, false, false)
  self.tableViewControl:TurnPageTo(1, true, false)
end
function prototype:onBtnReturn(sender, event)
  SceneHelper:runWithScene("ArmorMain", self.rootNode)
end
function prototype:onBtnRecycle(sender, event)
  Logic:Get("Armor"):setSmeltUIBtnNodeDisabled(false)
  SceneHelper:pushScene("ArmorSmelt", self.rootNode)
end
function prototype:cellSizeForTable()
  return CCSizeMake(WIN_WIDTH, WIN_HEIGHT)
end
function prototype:tableCellAtIndex(table, index, cell, curPage)
  local curIndex = index + 1 + (curPage - 1) * PAGE_SIZE
  if not cell then
    cell = CCTableViewCellEx:create()
    local subScene = Tw.Controller:load("ArmorPackItem", self.rootNode)
    subScene:refresh(self.armorInfos[curIndex])
    cell:addChild(subScene, 0, 2)
  else
    cell:getChildByTag(2):refresh(self.armorInfos[curIndex])
  end
  return cell
end
function prototype:numberOfCellsInTableView(curPage)
  if curPage == self.maxPage then
    if #self.armorInfos == 0 then
      return 0
    end
    return (#self.armorInfos - 1) % PAGE_SIZE + 1
  end
  return PAGE_SIZE
end
function prototype:tableCellTouched(table, cell)
end
function prototype:tablePageTurn(curPage)
  self.ttfPage:setString(TwGetStr(111413, curPage, self.maxPage))
  self.tableViewControl:RequireUpdate()
end
function prototype:sort()
  table.sort(self.armorInfos, function(param1, param2)
    local info1 = Logic:Get("Armor"):getArmorInfoByBaseId(param1.baseId)
    local info2 = Logic:Get("Armor"):getArmorInfoByBaseId(param2.baseId)
    if not info1 or not info2 then
      return false
    end
    if param1.equipHero and not param2.equipHero or not param1.equipHero and param2.equipHero then
      return param1.equipHero and not param2.equipHero
    elseif info1.rank == info2.rank then
      if info1.star == info2.star then
        return param1.baseId > param2.baseId
      end
      return info1.star > info2.star
    else
      return info1.rank > info2.rank
    end
  end)
end
function prototype:OnArmorsChanged()
  self:updateArmorList()
end
function prototype:getData()
  return self.armorInfos
end
