module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
function prototype:onEnter()
  self.saleHeroBaseIdMapToNum = {}
  self.saleHeroResult = {}
  self.saleHeroId = Logic:Get("Hero"):GetSaleHero()
  self:SaleHeroResult()
  self:setLableString()
  self.page = 1
  self.tableViewControl = TableViewEx.prototype:createList(self, self.heroList, self.page)
  self.tableViewControl.tableView:setDirection(kCCScrollViewDirectionVertical)
  self.heroList:addChild(self.tableViewControl.tableView)
  Logic:Get("Hero"):FireEvent(Logic.Hero.EVT.LOCK_HERO_LIST)
end
function prototype:onExit()
  Logic:Get("Hero"):FireEvent(Logic.Hero.EVT.UNLOCK_HERO_LIST)
end
function prototype:setLableString()
  if not self.saleHeroId then
    return
  end
  self.heros = {}
  local num = 0
  local nPrice = 0
  local bConfirm = false
  local star = 4
  for k, _ in pairs(self.saleHeroId) do
    table.insert(self.heros, k)
    num = num + 1
    local hero = Logic:Get("Hero"):GetHeroInfoById(k)
    if hero and hero.baseId then
      local price = Logic:Get("Hero"):GetHeroPrice(hero.baseId, hero.level)
      nPrice = nPrice + price
      local info = Logic:Get("Hero"):GetHeroInfoByBaseId(hero.baseId)
      if info and star <= info.star then
        bConfirm = true
      end
    end
  end
  if bConfirm then
    local str = TwGetStr(104157, star)
    self.ttfTip:setString(str)
  end
  self.ttfTitle:setString(TwGetStr(104158))
  self.ttfTitle:setStyle(kCCLabelTTFStyleOutline)
  self.ttfTitle:setColor(ccColor3B(187, 255, 0))
  self.ttfSellResult:setString(TwGetStr(104181, num, nPrice))
end
function prototype:SaleHeroResult()
  if self.saleHeroId == nil or next(self.saleHeroId) == nil then
    return
  end
  for k, v in pairs(self.saleHeroId) do
    if v then
      local hero = Logic:Get("Hero"):GetHeroInfoById(k)
      if self.saleHeroBaseIdMapToNum[hero.baseId] == nil then
        self.saleHeroBaseIdMapToNum[hero.baseId] = 1
      else
        self.saleHeroBaseIdMapToNum[hero.baseId] = self.saleHeroBaseIdMapToNum[hero.baseId] + 1
      end
    end
  end
  for k, v in pairs(self.saleHeroBaseIdMapToNum) do
    local heroInfo = Logic:Get("Hero"):GetHeroInfoByBaseId(k)
    if heroInfo then
      table.insert(self.saleHeroResult, {
        star = heroInfo.star,
        name = heroInfo.name,
        num = v,
        rank = heroInfo.rank
      })
    end
  end
  if not table.empty(self.saleHeroResult) then
    local rankSort = function(param1, param2)
      if not param1 or not param2 then
        return false
      end
      return param1.star > param2.star
    end
    table.sort(self.saleHeroResult, rankSort)
  end
  self.data = {
    self.saleHeroResult
  }
end
function prototype:cellSizeForTable(...)
  return CCSizeMake(560, 40)
end
function prototype:tableCellAtIndex(table, index, cell, curPage)
  if not cell then
    cell = CCTableViewCellEx:create()
    local subScene = Tw.Controller:load("HeroSaleTipItem", self.rootNode)
    subScene:ReFrashReward(self.saleHeroResult[index + 1])
    cell:addChild(subScene, 0, 2)
  else
    cell:getChildByTag(2):ReFrashReward(self.saleHeroResult[index + 1])
  end
  return cell
end
function prototype:numberOfCellsInTableView(curPage)
  if #self.saleHeroResult == 0 then
    return 1
  end
  return #self.saleHeroResult
end
function prototype:tableCellTouched(table, cell)
  local idx = tolua.cast(cell, "CCTableViewCellEx"):getIdx()
end
function prototype:tablePageTurn(curPage)
  self.tableViewControl:RequireUpdate()
end
function prototype:onBtnSure()
  if #self.heros ~= 0 then
    Logic:Get("Hero"):PostSellHero(self.heros)
    Logic:Get("BGSound"):PlayEffect("audio/sale.mp3")
  end
  SceneHelper:removePrompt(self.rootNode)
end
function prototype:onBtnCancel()
  SceneHelper:removePrompt(self.rootNode)
end
