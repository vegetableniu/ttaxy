module((...), package.seeall)
require("SceneHelper")
require("TableViewEx")
require("BtnPosition")
prototype = BtnPosition.prototype:extend()
function prototype:initialize()
  super.initialize(self)
  Logic:Get("Talisman"):CopySwallFabaos()
end
function prototype:onEnter()
  super.onEnter(self)
  self:onGetNotHeroFabao()
  Logic:Get("Talisman"):On(Logic.Talisman.EVT.HAN_SELECT_SWALL_FABAO, self:Event("onHadSelectSwallFabao"))
  Logic:Get("Talisman"):On(Logic.Talisman.EVT.OPT_FABAO_SWALLOW, self:Event("OnOptFabaoSwall"))
end
function prototype:onGetNotHeroFabao()
  local allFabaos = Logic:Get("Talisman"):canSwallFabao()
  if allFabaos == nil or table.empty(allFabaos) then
    self.staPage:setString(string.format("%d/%d", 1, 1))
    self.pnlConfirm:setVisible(false)
    return
  end
  self.data = allFabaos
  self.page = math.ceil(#allFabaos / Logic.Talisman.MAX_FABAO_PER_PAGE)
  self.page = self.page == 0 and 1 or self.page
  self.tableViewControl = TableViewEx.prototype:createList(self, self.lstFabaos, self.page)
  self.tableViewControl:TurnPageTo(1, true, true)
  self.lstFabaos:addChild(self.tableViewControl.tableView)
  self:OnOptFabaoSwall()
end
function prototype:OnOptFabaoSwall()
  local swallowFabao = Logic:Get("Talisman"):GetTemFabaos()
  if not swallowFabao then
    return
  end
  local num = 0
  for k, v in pairs(swallowFabao) do
    num = num + 1
  end
  if num == 0 then
    self.pnlConfirm:setVisible(false)
    Logic:Get("Main"):SetFuncVisible(true)
  else
    self.pnlConfirm:setVisible(true)
    self.tableViewControl:RequireUpdateWithoutAnimat()
    Logic:Get("Main"):SetFuncVisible(false)
  end
  local nExp = Logic:Get("Talisman"):AllTemFabaoExp()
  self.pnlConfirm.staExp:setString(nExp)
  self.pnlConfirm.staExpTip:setStyle(kCCLabelTTFStyleOutline)
  self.pnlConfirm.staExp:setStyle(kCCLabelTTFStyleOutline)
  self.pnlConfirm.staExpTip:setString(TwGetStr(104271))
  self.tableViewControl:RequireUpdateWithoutAnimat()
end
function prototype:onHadSelectSwallFabao(content)
  self.tableViewControl:RequireUpdateWithoutAnimat()
end
function prototype:OnOptSwallow()
  local swallowFabao = Logic:Get("Talisman"):GetTemFabaos()
  if not swallowFabao then
    return
  end
  local num = 0
  for k, v in pairs(swallowFabao) do
    num = num + 1
  end
  if num == 0 then
    self.pnlConfirm:setVisible(false)
    Logic:Get("Main"):SetFuncVisible(true)
  else
    self.pnlConfirm:setVisible(true)
    self.tableViewControl:RequireUpdateWithoutAnimat()
    Logic:Get("Main"):SetFuncVisible(false)
  end
  local nExp = Logic:Get("Talisman"):AllTemFabaoExp()
  self.pnlConfirm.staExp:setString(nExp)
  self.pnlConfirm.staExpTip:setStyle(kCCLabelTTFStyleOutline)
  self.pnlConfirm.staExp:setStyle(kCCLabelTTFStyleOutline)
  self.pnlConfirm.staExpTip:setString(TwGetStr(104271))
  self:updateGuide()
  self.pnlConfirm:updateGuide()
end
function prototype:onBtnLeft()
  if self.tableViewControl then
    self.tableViewControl:TurnPage(-1)
  end
end
function prototype:onBtnRight()
  if self.tableViewControl then
    self.tableViewControl:TurnPage(1)
  end
end
function prototype:onBtnReturn()
  SceneHelper:removeScene("FabaoSwallowSelect")
end
function prototype:onExit()
  Logic:Get("Main"):SetFuncVisible(true)
end
function prototype:cellSizeForTable(...)
  return CCSizeMake(563, 130)
end
function prototype:tableCellAtIndex(table, index, cell, curPage)
  if not cell then
    cell = CCTableViewCellEx:create()
    local subScene = Tw.Controller:load("FabaoSwallSelectItem", self.rootNode)
    subScene:ReFrashInfo(self.data[(curPage - 1) * Logic.Talisman.MAX_FABAO_PER_PAGE + index + 1])
    cell:addChild(subScene, 0, 2)
  else
    cell:getChildByTag(2):ReFrashInfo(self.data[(curPage - 1) * Logic.Talisman.MAX_FABAO_PER_PAGE + index + 1])
  end
  return cell
end
function prototype:numberOfCellsInTableView(curPage)
  self.staPage:setString(string.format("%d/%d", curPage or 1, self.page or 1))
  if self.page == curPage then
    return #self.data - (self.page - 1) * Logic.Talisman.MAX_FABAO_PER_PAGE
  else
    return Logic.Talisman.MAX_FABAO_PER_PAGE
  end
end
function prototype:tableCellTouched(table, cell)
end
function prototype:tablePageTurn(curPage)
  self.tableViewControl:RequireUpdate()
end
