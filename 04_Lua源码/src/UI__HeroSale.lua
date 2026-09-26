module((...), package.seeall)
require("SceneHelper")
require("TableViewEx")
require("BtnPosition")
prototype = BtnPosition.prototype:extend()
function prototype:onEnter()
  super.onEnter(self)
  self.pnlConfirm:setVisible(false)
  self.pnlConfirm:setAnchorPoint(CCPoint(0, 0))
  self.hasSaleHero = false
  self.isCheck = false
  self.tempSaleHero = {}
  local playerLevel = Logic:Get("PlayerInfo"):GetPlayerLevel()
  local limitLevel = KFDBGetRecord("ConfigValue", "HERO:HERO_SALE_CHECK_LIMIT")
  if limitLevel and playerLevel < tonumber(limitLevel.content) then
    self.imgBtnRightBg:setVisible(false)
    self.btnAutoCheckSale:setVisible(false)
    self.sprRight:setVisible(false)
  end
  local heroId = Logic:Get("Hero"):GetUnbattlingHero(false)
  local allHeros = Logic:Get("Hero"):GetHeroInfosByIds(heroId)
  if not allHeros then
    return
  end
  if #allHeros == 0 then
    self.heros = {}
    self.page = 1
  else
    Logic:Get("Hero"):SortHerosByChoice(allHeros, Logic.Hero.SORT_CHOICE.STAR_UPPER)
    self.heros = allHeros
    self.data = {
      self.heros
    }
    local int, fra = math.modf(#allHeros / Logic.Hero.MAX_HEROS_PER_PAGE)
    local page = 1
    if fra == 0 then
      page = int
    else
      page = int + 1
    end
    self.page = page
  end
  self.tableViewControl = TableViewEx.prototype:createList(self, self.lstHeros, self.page)
  self.tableViewControl.tableView:runUIAnimat()
  self.lstHeros:addChild(self.tableViewControl.tableView)
  Logic:Get("Hero"):On(Logic.Hero.EVT.OPT_HERO_SALE, self:Event("OnOptHeroSale"))
  Logic:Get("Hero"):On(Logic.Hero.EVT.SELL_HERO, self:Event("OnSellHero"))
  Logic:Get("Hero"):On(Logic.Hero.EVT.LOCK_HERO_LIST, self:Event("OnLockHeroList"))
  Logic:Get("Hero"):On(Logic.Hero.EVT.UNLOCK_HERO_LIST, self:Event("OnUnlockHeroList"))
end
function prototype:OnLockHeroList()
  self.tableViewControl.tableView:setTouchEnabled(false)
  self.tableViewControl.tableView:stopScrolling()
end
function prototype:OnUnlockHeroList()
  self.tableViewControl.tableView:setTouchEnabled(true)
end
function prototype:OnSellHero()
  local heroId = Logic:Get("Hero"):GetUnbattlingHero(false)
  if not heroId then
    return
  end
  local allHeros = Logic:Get("Hero"):GetHeroInfosByIds(heroId)
  if allHeros then
    if #allHeros == 0 then
      self.heros = {}
      self.page = 1
      self.tableViewControl:RequireUpdate(self.page)
    else
      Logic:Get("Hero"):SortHerosByChoice(allHeros, Logic.Hero.SORT_CHOICE.STAR_UPPER)
      self.heros = allHeros
      local int, fra = math.modf(#allHeros / Logic.Hero.MAX_HEROS_PER_PAGE)
      if fra == 0 then
        self.page = int
      else
        self.page = int + 1
      end
      self.tableViewControl:RequireUpdate(self.page)
    end
    self.pnlConfirm:setVisible(false)
    self.tableViewControl:RequireUpdate(self.page)
    Logic:Get("Hero"):ClearSaleHero()
    Logic:Get("Main"):SetFuncVisible(true)
    if self.hasSaleHero then
      self:setImgBtnRightBg()
      self.hasSaleHero = false
      self.isCheck = false
    end
    Prompt:Tip(104182)
  end
end
function prototype:OnOptHeroSale()
  local saleHeroId = Logic:Get("Hero"):GetSaleHero()
  if not saleHeroId then
    return
  end
  local saleHero = {}
  for k, _ in pairs(saleHeroId) do
    local hero = Logic:Get("Hero"):GetHeroInfoById(k)
    if hero then
      table.insert(saleHero, hero)
    end
  end
  if #saleHero == 0 then
    if self.hasSaleHero and self.isCheck then
      self:setImgBtnRightBg()
      self.hasSaleHero = false
      self.isCheck = false
    end
    self.pnlConfirm:setVisible(false)
    Logic:Get("Main"):SetFuncVisible(true)
  else
    self.pnlConfirm:setVisible(true)
    Logic:Get("Main"):SetFuncVisible(false)
    local price = 0
    for i = 1, #saleHero do
      price = price + Logic:Get("Hero"):GetHeroPrice(saleHero[i].baseId, saleHero[i].level)
    end
    self.pnlConfirm.staNum:setString(tostring(#saleHero))
    self.pnlConfirm.staTotal:setString(tostring(price))
    self.pnlConfirm.staNumTip:setStyle(kCCLabelTTFStyleOutline)
    self.pnlConfirm.staNum:setStyle(kCCLabelTTFStyleOutline)
    self.pnlConfirm.staTotalTip:setStyle(kCCLabelTTFStyleOutline)
    self.pnlConfirm.staTotal:setStyle(kCCLabelTTFStyleOutline)
    self.pnlConfirm.staNumTip:setString(TwGetStr(104266))
    self.pnlConfirm.staTotalTip:setString(TwGetStr(104267))
  end
end
function prototype:onBtnLeft()
  self.tableViewControl:TurnPage(-1)
end
function prototype:onBtnRight()
  self.tableViewControl:TurnPage(1)
end
function prototype:onBtnReturn()
  Logic:Get("Hero"):ClearSaleHero()
  SceneHelper:runWithScene("Hero", self.rootNode)
end
function prototype:onExit()
  Logic:Get("Hero"):ClearSaleHero()
  Logic:Get("Main"):SetFuncVisible(true)
end
function prototype:onBtnAutoCheckSale()
  self:filterSaleHero()
  if not self.hasSaleHero then
    Prompt:Fail(TwGetStr(104183))
    return
  end
  if self.isCheck then
    self.hasSaleHero = false
    self:clearCheckHero()
    self:OnOptHeroSale()
  end
  self:setImgBtnRightBg()
  self.tableViewControl:RequireUpdateWithoutAnimat(self.page)
end
function prototype:clearCheckHero()
  for k, v in pairs(self.tempSaleHero) do
    Logic:Get("Hero"):RemoveSaleHero(v.id, true)
  end
  self.tempSaleHero = {}
end
function prototype:filterSaleHero()
  if self.heros == nil or next(self.heros) == nil then
    return
  end
  local checkedSaleHero = Logic:Get("Hero"):GetSaleHero()
  for k, v in pairs(self.heros) do
    local saleHero = Logic:Get("Hero"):GetHeroInfoByBaseId(v.baseId)
    if saleHero.funcFlag and bit.band(bit.rshift(saleHero.funcFlag, 2), 1) == 1 and saleHero.star < 3 and not checkedSaleHero[v.id] then
      Logic:Get("Hero"):AddSaleHero(v.id, true)
      table.insert(self.tempSaleHero, v)
      self.hasSaleHero = true
    end
  end
  self:OnOptHeroSale()
end
function prototype:setImgBtnRightBg()
  if self.isCheck then
    local sprite = CCSprite:create("images/newfont/AutoCheck.png")
    if sprite then
      self.sprRight:setDisplayFrame(sprite:displayFrame())
    end
    self.isCheck = false
  else
    local sprite = CCSprite:create("images/newfont/Cancel.png")
    if sprite then
      self.sprRight:setDisplayFrame(sprite:displayFrame())
    end
    self.isCheck = true
  end
end
function prototype:cellSizeForTable(...)
  return CCSizeMake(563, 117)
end
function prototype:tableCellAtIndex(table, index, cell, curPage)
  if not cell then
    cell = CCTableViewCellEx:create()
    local subScene = Tw.Controller:load("HeroSaleItem", self.rootNode)
    subScene.pHeroItem:RefreshHeros(self.heros[(curPage - 1) * Logic.Hero.MAX_HEROS_PER_PAGE + index + 1])
    cell:addChild(subScene, 0, 2)
  else
    cell:getChildByTag(2)
    cell:getChildByTag(2).pHeroItem:RefreshHeros(self.heros[(curPage - 1) * Logic.Hero.MAX_HEROS_PER_PAGE + index + 1])
  end
  return cell
end
function prototype:numberOfCellsInTableView(curPage)
  self.staPage:setString(string.format("%d/%d", curPage or 0, self.page or 1))
  if self.page == curPage then
    return #self.heros - (self.page - 1) * Logic.Hero.MAX_HEROS_PER_PAGE
  else
    return Logic.Hero.MAX_HEROS_PER_PAGE
  end
end
function prototype:tableCellTouched(table, cell)
  local idx = tolua.cast(cell, "CCTableViewCellEx"):getIdx()
end
function prototype:tablePageTurn(curPage)
  self.tableViewControl:RequireUpdate()
end
