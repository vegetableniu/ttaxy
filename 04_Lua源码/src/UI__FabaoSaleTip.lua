module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
function prototype:onEnter()
  self.saleFabaoBaseIdMapToNum = {}
  self.saleFabaoResult = {}
  self.saleFabaoId = Logic:Get("Talisman"):GetSaleFabao()
  self:SaleFabaoResult()
  self:setLableString()
  self.page = 1
  self.tableViewControl = TableViewEx.prototype:createList(self, self.heroList, self.page)
  self.tableViewControl.tableView:setDirection(kCCScrollViewDirectionVertical)
  self.heroList:addChild(self.tableViewControl.tableView)
  Logic:Get("Talisman"):FireEvent(Logic.Talisman.EVT.LOCK_FABAO_LIST)
end
function prototype:onExit()
  Logic:Get("Talisman"):FireEvent(Logic.Talisman.EVT.UNLOCK_FABAO_LIST)
end
function prototype:setLableString()
  if not self.saleFabaoId then
    return
  end
  self.fabaos = {}
  local num = 0
  local nPrice = 0
  local bConfirm = false
  local star = 4
  for k, _ in pairs(self.saleFabaoId) do
    table.insert(self.fabaos, k)
    num = num + 1
    local fabao = Logic:Get("Talisman"):GetTheFabao(k)
    if fabao and fabao.baseId then
      local baseid = fabao.baseId .. "_" .. fabao.level
      local rec = KFDBGetRecord("TalismanLevelSetting", baseid)
      if rec then
        nPrice = nPrice + rec.price
      end
      local rec = KFDBGetRecord("TalismanSetting", fabao.baseId)
      if rec then
        local info = Logic:Get("Hero"):GetHeroInfoByBaseId(rec.baseId)
        if info and star <= info.star then
          bConfirm = true
        end
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
function prototype:SaleFabaoResult()
  if self.saleFabaoId == nil or next(self.saleFabaoId) == nil then
    return
  end
  for k, v in pairs(self.saleFabaoId) do
    if v then
      local fabao = Logic:Get("Talisman"):GetTheFabao(k)
      if self.saleFabaoBaseIdMapToNum[fabao.baseId] == nil then
        self.saleFabaoBaseIdMapToNum[fabao.baseId] = 1
      else
        self.saleFabaoBaseIdMapToNum[fabao.baseId] = self.saleFabaoBaseIdMapToNum[fabao.baseId] + 1
      end
    end
  end
  for k, v in pairs(self.saleFabaoBaseIdMapToNum) do
    local rec = KFDBGetRecord("TalismanSetting", k)
    if rec then
      local fabaoInfo = Logic:Get("Hero"):GetHeroInfoByBaseId(rec.baseId)
      if fabaoInfo then
        table.insert(self.saleFabaoResult, {
          star = fabaoInfo.star,
          name = fabaoInfo.name,
          num = v,
          rank = fabaoInfo.rank
        })
      end
    end
  end
  if not table.empty(self.saleFabaoResult) then
    local rankSort = function(param1, param2)
      if not param1 or not param2 then
        return false
      end
      return param1.star > param2.star
    end
    table.sort(self.saleFabaoResult, rankSort)
  end
  self.data = {
    self.saleFabaoResult
  }
end
function prototype:cellSizeForTable(...)
  return CCSizeMake(560, 40)
end
function prototype:tableCellAtIndex(table, index, cell, curPage)
  if not cell then
    cell = CCTableViewCellEx:create()
    local subScene = Tw.Controller:load("FabaoSaleTipItem", self.rootNode)
    subScene:ReFrashReward(self.saleFabaoResult[index + 1])
    cell:addChild(subScene, 0, 2)
  else
    cell:getChildByTag(2):ReFrashReward(self.saleFabaoResult[index + 1])
  end
  return cell
end
function prototype:numberOfCellsInTableView(curPage)
  if #self.saleFabaoResult == 0 then
    return 1
  end
  return #self.saleFabaoResult
end
function prototype:tableCellTouched(table, cell)
  local idx = tolua.cast(cell, "CCTableViewCellEx"):getIdx()
end
function prototype:tablePageTurn(curPage)
  self.tableViewControl:RequireUpdate()
end
function prototype:onBtnSure()
  if #self.fabaos ~= 0 then
    Logic:Get("Talisman"):PostSellFabao(self.fabaos)
    Logic:Get("BGSound"):PlayEffect("audio/sale.mp3")
  end
  SceneHelper:removePrompt(self.rootNode)
end
function prototype:onBtnCancel()
  SceneHelper:removePrompt(self.rootNode)
end
