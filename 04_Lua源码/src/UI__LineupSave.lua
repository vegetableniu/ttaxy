require("SceneHelper")
module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
function prototype:onEnter()
  self:onUpdateTeamName()
  self.tableViewControl = TableViewEx.prototype:createList(self, self.nodList, 1)
  self.nodList:addChild(self.tableViewControl.tableView)
  Logic:Get("Lineup"):On(Logic.Lineup.EVT.UPDATE_TEAM, self:Event("onUpdataTeam"))
  Logic:Get("Lineup"):On(Logic.Lineup.EVT.UPDATE_TEAM_NAME, self:Event("onUpdateTeamName"))
end
function prototype:onBtnReturn(sender, event)
  SceneHelper:removeScene("LineupSave", self.rootNode)
end
function prototype:onBtnSave(sender, event)
  local lockId = Logic.Lock.LOCK_ID.TALISMAN_EQUIP_2_LOCK
  local bLockTali = Logic:Get("Lock"):GetStatusByLockId(lockId)
  local talisCnt = bLockTali and 1 or 2
  local heros = Logic:Get("Hero"):GetAllFightHero()
  self.heroNotEnough = #heros < 15
  if self.heroNotEnough then
    local tip = TwGetStr(115330) .. [[


]] .. TwGetStr(115336)
    Prompt:Confirm(self, "", tip, self.onConfirm, Prompt.PROMPT_TYPE.SELECT, true)
    return
  end
  local tip = TwGetStr(115337)
  local notEquipTali = false
  local notEquipArmor = false
  self.equipNotEnough = false
  for i, heroId in ipairs(heros) do
    local heroInfo = Logic:Get("Hero"):GetHeroInfoById(heroId)
    local heroRec = Logic:Get("Hero"):GetHeroInfoByBaseId(heroInfo.baseId)
    local talismans = Logic:Get("Talisman"):GetHeroEquipTailsmanByHeroId(heroInfo.id)
    if talisCnt > table.size(talismans or {}) then
      notEquipTali = true
    end
    local armors = Logic:Get("Armor"):getHeroEquipArmors(heroInfo.id)
    if 2 > table.size(armors or {}) then
      notEquipArmor = true
    end
  end
  if notEquipTali then
    tip = tip .. TwGetStr(115332) .. "\n"
  end
  if notEquipArmor then
    tip = tip .. TwGetStr(115331) .. "\n"
  end
  self.equipNotEnough = notEquipTali or notEquipArmor
  if self.equipNotEnough then
    tip = tip .. "\n" .. TwGetStr(115336)
    Prompt:Confirm(self, "", tip, self.onConfirm, Prompt.PROMPT_TYPE.SELECT, true)
    return
  end
  Logic:Get("Lineup"):postUpdataTeam(self.data[self.selectIdx].name)
end
function prototype:onConfirm(clickType)
  local CANCEL = 2
  if clickType == CANCEL and self.heroNotEnough then
    self:onBtnReturn()
    return
  end
  if clickType == CANCEL and self.equipNotEnough then
    SceneHelper:runWithScene("Home", self.rootNode)
    return
  end
  Logic:Get("Lineup"):postUpdataTeam(self.data[self.selectIdx].name)
end
function prototype:selectedItem(idx)
  local bSameIdx = self.selectIdx == idx
  self.selectIdx = bSameIdx and 0 or idx
  self.btnSave:setEnabled(not bSameIdx)
  self.tableViewControl:RequireUpdateWithoutAnimat()
end
function prototype:isSelected(idx)
  return self.selectIdx == idx
end
function prototype:isFull()
  return self.selectIdx ~= 0
end
function prototype:onUpdataTeam()
  self:onBtnReturn()
end
function prototype:onUpdateTeamName()
  self.data = {}
  self.selectIdx = 0
  self.btnSave:setEnabled(false)
  local teams = Logic:Get("Lineup"):getTeams()
  for name, v in pairs(teams) do
    local data = {}
    data.name = name
    table.insert(self.data, data)
  end
  if self.tableViewControl then
    self.tableViewControl:RequireUpdate()
  end
end
function prototype:cellSizeForTable(...)
  return CCSizeMake(563, 120)
end
function prototype:tableCellAtIndex(table, index, cell, curPage)
  local tag = 2
  if not cell then
    cell = CCTableViewCellEx:create()
    local subScene = Tw.Controller:load("LineupSaveItem", self.rootNode)
    cell:addChild(subScene, 0, tag)
  end
  cell:getChildByTag(tag):refreshItem(self.data[index + 1], self, index + 1)
  return cell
end
function prototype:numberOfCellsInTableView(curPage)
  return #self.data
end
function prototype:tableCellTouched(table, cell)
end
function prototype:tablePageTurn(curPage)
  self.tableViewControl:RequireUpdate()
end
