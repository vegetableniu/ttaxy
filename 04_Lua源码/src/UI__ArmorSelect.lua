module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
local WIN_WIDTH, WIN_HEIGHT = 590, 120
local PAGE_SIZE = 20
function prototype:onEnter()
  self.ttfTip:setStyle(kCCLabelTTFStyleOutline)
  self:getAmormInfo()
  if table.empty(self.armorInfos) then
    self.sprPageBg:setVisible(false)
    self.ttfTip:setString(TwGetStr(111441))
    return
  end
  Logic:Get("Armor"):On(Logic.Armor.EVT.CHANGE_ARMOR_OK, self:Event("onBtnReturn"))
  Logic:Get("Armor"):On(Logic.Armor.EVT.REFRESH_TABLE, self:Event("onRefreshTable"))
  Logic:Get("Armor"):On(Logic.Armor.EVT.SET_TOUCH_ENABLED, self:Event("onSetTouch"))
  self.maxPage = math.ceil(#self.armorInfos / PAGE_SIZE)
  self.ttfPage:setString(TwGetStr(111413, 1, self.maxPage))
  self.tableViewControl = TableViewEx.prototype:createList(self, self.itemList, self.maxPage, true)
  self.tableViewControl.tableView:runUIAnimat()
  self.itemList:addChild(self.tableViewControl.tableView)
  self.tableViewControl:RequireUpdate()
end
function prototype:getAmormInfo()
  self.armorInfos, self.otherArmors = Logic:Get("Armor"):getChooseArmors()
  self:sort(self.armorInfos, true)
  self:sort(self.otherArmors)
  for i, v in ipairs(self.otherArmors) do
    table.insert(self.armorInfos, v)
  end
end
function prototype:onBtnReturn(sender, event)
  SceneHelper:runWithScene("ArmorMain", self.rootNode)
end
function prototype:onRefreshTable()
  self:getAmormInfo()
  self.tableViewControl:RequireUpdate()
end
function prototype:onSetTouch(canTouch)
  self.tableViewControl.tableView:setTouchEnabled(canTouch)
end
function prototype:cellSizeForTable()
  return CCSizeMake(WIN_WIDTH, WIN_HEIGHT)
end
function prototype:tableCellAtIndex(table, index, cell, curPage)
  local curIndex = index + 1 + (curPage - 1) * PAGE_SIZE
  if not cell then
    cell = CCTableViewCellEx:create()
    local subScene = Tw.Controller:load("ArmorSelectItem", self.rootNode)
    subScene:refresh(self.armorInfos[curIndex])
    cell:addChild(subScene, 0, 2)
  else
    cell:getChildByTag(2):refresh(self.armorInfos[curIndex])
  end
  return cell
end
function prototype:numberOfCellsInTableView(curPage)
  if curPage == self.maxPage then
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
function prototype:sort(Infos, isEquip)
  table.sort(Infos, function(param1, param2)
    local info1 = Logic:Get("Armor"):getArmorInfoByBaseId(param1.baseId)
    local info2 = Logic:Get("Armor"):getArmorInfoByBaseId(param2.baseId)
    if not info1 or not info2 then
      return false
    end
    local equipType1 = param1.isFitEquipType and 1 or 0
    local equipType2 = param2.isFitEquipType and 1 or 0
    local equipHero1 = param1.equipHero and 1 or 0
    local equipHero2 = param2.equipHero and 1 or 0
    if isEquip and equipHero1 ~= equipHero2 then
      return equipHero1 > equipHero2
    end
    if equipType1 ~= equipType2 then
      return equipType1 > equipType2
    end
    if info1.rank ~= info2.rank then
      return info1.rank > info2.rank
    end
    if info1.star ~= info2.star then
      return info1.star > info2.star
    end
    return param1.baseId > param2.baseId
  end)
end
function prototype:actionFinish(tableView)
  if not Logic:Get("Guide"):isGuiding() then
    return
  end
  local idx = self:getTableViewOffset()
  if idx == nil then
    return
  end
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
function prototype:getTableViewOffset()
  return 1
end
