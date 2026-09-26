module((...), package.seeall)
require("SceneHelper")
require("TableViewEx")
require("BtnPosition")
prototype = BtnPosition.prototype:extend()
function prototype:initialize()
  super.initialize(self)
end
function prototype:onEnter()
  super.onEnter(self)
  self.imgBtnRightBg:setVisible(false)
  local positon = Logic:Get("Talisman"):getTalismanPosition()
  self:setTitleImg(positon)
  self:oncreatetabelview(positon)
  Logic:Get("Talisman"):ClearSwallFabaos()
  Logic:Get("Talisman"):On(Logic.Talisman.EVT.GET_ALL_HERO_FABAO, self:Event("onGetAllHeroFabao"))
  Logic:Get("Talisman"):On(Logic.Talisman.EVT.CHANGE_IMG_FABAO, self:Event("ontoArtifact"))
  Logic:Get("Talisman"):On(Logic.Talisman.EVT.UPDATE_FABAO_SELECT, self:Event("onUpdateFabaoSelect"))
  Logic:Get("Talisman"):On(Logic.Talisman.EVT.HAD_SELECT_PUT_ON_FABAO, self:Event("onHadSelectPutonFabao"))
  Logic:Get("Talisman"):On(Logic.Talisman.EVT.CONFIG_SELE_TREASURE_BTN, self:Event("onBtnEnter"))
  Logic:Get("Talisman"):On(Logic.Talisman.EVT.SELEL_EQUIP_FABAO, self:Event("RefreshConfig"))
end
function prototype:oncreatetabelview(positon)
  local allFabaos = Logic:Get("Talisman"):GetTailsmanVoByHero(positon)
  if allFabaos then
    self.data = allFabaos
    self.page = math.ceil(#allFabaos / Logic.Talisman.MAX_FABAO_PER_PAGE)
    self.page = self.page == 0 and 1 or self.page
    self.tableViewControl = TableViewEx.prototype:createList(self, self.lstFabao, self.page)
    self.tableViewControl:TurnPageTo(1, true, true)
    self.lstFabao:addChild(self.tableViewControl.tableView)
  end
end
function prototype:RefreshConfig()
  self.tableViewControl:RequireUpdateWithoutAnimat(self.page)
end
function prototype:onGetAllHeroFabao()
  local allFabaos = Logic:Get("Talisman"):GetAllfabaos()
  if allFabaos then
    self.Fabaos = allFabaos
  end
end
function prototype:setTitleImg(positon)
  local path = {
    "images/Talisman/title_yao.png",
    "images/Talisman/title_shen.png"
  }
  local frame = CCSprite:create(path[positon])
  if frame then
    self.sprTitle:setDisplayFrame(frame:displayFrame())
  end
end
function prototype:onHadSelectPutonFabao(content)
  self:onUpdateFabaoSelect()
end
function prototype:onBtnReturn()
  Logic:Get("Talisman"):ClearSelectFabao()
  SceneHelper:popScene()
end
function prototype:onBtnEnter()
end
function prototype:ontoArtifact()
  SceneHelper:popScene()
end
function prototype:onBtnLeft()
  if self.tableViewControl ~= nil then
    self.tableViewControl:TurnPage(-1)
  end
end
function prototype:onBtnRight()
  if self.tableViewControl ~= nil then
    self.tableViewControl:TurnPage(1)
  end
end
function prototype:onBtnSaleFabao()
end
function prototype:onNoShowFabaos(datas)
  local selechero = Logic:Get("Talisman"):GetSelectHero()
  local canshowfabaos = {}
  if datas and #datas ~= 0 then
    for _, v in ipairs(datas) do
      local heroInfo = Logic:Get("Hero"):GetHeroInfosByIds({
        v.equipHero
      })
      if heroInfo and #heroInfo == 0 and v then
        table.insert(canshowfabaos, v)
      elseif #heroInfo ~= 0 and #heroInfo[1] and heroInfo[1].id == selechero.id and v then
        table.insert(canshowfabaos, v)
      end
    end
  end
  return canshowfabaos
end
function prototype:onUpdateFabaoSelect()
  self.tableViewControl:RequireUpdateWithoutAnimat(self.page)
end
function prototype:cellSizeForTable(...)
  return CCSizeMake(563, 130)
end
function prototype:tableCellAtIndex(table, index, cell, curPage)
  if not cell then
    cell = CCTableViewCellEx:create()
    local subScene = Tw.Controller:load("FabaoSelectItem", self.rootNode)
    if self.data[index + 1] then
      subScene:ReFrashInfo(self.data[(curPage - 1) * Logic.Talisman.MAX_FABAO_PER_PAGE + index + 1])
      cell:addChild(subScene, 0, 2)
    end
  elseif self.data[index + 1] then
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
function prototype:onExit()
  Logic:Get("Main"):SetFuncVisible(true)
end
function prototype:actionFinish(tableView)
  local cell = tableView:cellAtIndex(0)
  if cell == nil then
    return
  end
  local item = cell:getChildByTag(2)
  if item == nil then
    return
  end
  item:updateGuide()
end
