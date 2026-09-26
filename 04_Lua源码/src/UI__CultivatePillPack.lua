module((...), package.seeall)
require("SceneHelper")
require("TableViewEx")
require("BtnPosition")
prototype = BtnPosition.prototype:extend()
local MAX_ROW = 10
local path_stuff_nor = "images/Cultivate/pack_stuffnor.png"
local path_stuff_sel = "images/Cultivate/pack_stuffsel.png"
local path_pill_nor = "images/Cultivate/pack_pillnor.png"
local path_pill_sel = "images/Cultivate/pack_pillsel.png"
function prototype:onEnter()
  super.onEnter(self)
  self.ttfPage:setStyle(kCCLabelTTFStyleOutline)
  Logic:Get("Cultivate"):SetBtlScrollEnabled(false)
  self:onBtnStuff()
end
function prototype:onExit(...)
  Logic:Get("Cultivate"):SetBtlScrollEnabled(true)
end
function prototype:updateTbv(data)
  if not data then
    return
  end
  self.data = data
  self.allNum = #data
  self.allPage = math.ceil(#data / MAX_ROW)
  if not self.tableViewControl then
    self.curPage = 1
    self.tableViewControl = TableViewEx.prototype:createList(self, self.m_pList, self.allPage)
    self.m_pList:addChild(self.tableViewControl.tableView)
  end
  self.ttfPage:setString(self.curPage .. "/" .. self.allPage)
  self.tableViewControl:RequireUpdate(self.allPage)
end
function prototype:cellSizeForTable()
  return CCSizeMake(580, 130)
end
function prototype:tableCellAtIndex(table, index, cell, curPage)
  local idx = (curPage - 1) * MAX_ROW + index + 1
  if not cell then
    cell = CCTableViewCellEx:create()
    local subScene = Tw.Controller:load("CultivatePillItem", self.rootNode)
    subScene:refresh(self.data[idx])
    cell:addChild(subScene, 0, 2)
  else
    cell:getChildByTag(2):refresh(self.data[idx])
  end
  return cell
end
function prototype:numberOfCellsInTableView(curPage)
  if self.allPage == 0 then
    return 0
  end
  if curPage ~= self.allPage then
    return MAX_ROW
  end
  return (self.allNum - 1) % MAX_ROW + 1
end
function prototype:tableCellTouched(table, cell)
end
function prototype:tablePageTurn(curPage)
  self.curPage = curPage
  self.ttfPage:setString(curPage .. "/" .. self.allPage)
  self.tableViewControl:RequireUpdate()
end
function prototype:onBtnStuff(...)
  local data = Logic:Get("Cultivate"):GetStuffList()
  self.curPage = 1
  self:updateTbv(data)
  self.bInStuff = true
  self:updateTabs(self.bInStuff)
end
function prototype:onBtnPill(...)
  local data = Logic:Get("Cultivate"):GetPillList()
  self.curPage = 1
  self:updateTbv(data)
  self.bInStuff = false
  self:updateTabs(self.bInStuff)
end
function prototype:onBtnTrain(...)
  Logic:Get("Cultivate"):setFromBattle(true)
  SceneHelper:pushScene("CultivateSelectHero")
end
function prototype:onBtnReturn(sender, event)
  SceneHelper:removeScene("CultivatePillPack")
end
function prototype:updateTabs(bStuff)
  bStuff = bStuff or false
  self.btnStuff:setEnabled(not bStuff)
  self.btnPill:setEnabled(bStuff)
  local path = bStuff and path_stuff_sel or path_stuff_nor
  local spr = CCSprite:create(path)
  if spr then
    self.sprStuff:setDisplayFrame(spr:displayFrame())
  end
  path = bStuff and path_pill_nor or path_pill_sel
  spr = CCSprite:create(path)
  if spr then
    self.sprPill:setDisplayFrame(spr:displayFrame())
  end
end
