module((...), package.seeall)
require("SceneHelper")
require("TableViewEx")
prototype = Tw.Controller.prototype:extend()
local DEFT_NUMS = 9
local RET = Enum({"OK", "CANCEL"})
function prototype:onEnter()
  self.ttfRefreshTime:setStyle(kCCLabelTTFStyleOutline)
  self.ttfCost:setStyle(kCCLabelTTFStyleOutline)
  self.ttfCurrency:setStyle(kCCLabelTTFStyleOutline)
  self.canRefresh = false
  self:registerEvent()
  Logic:Get("MysticShop"):PostLoadShop()
end
function prototype:registerEvent()
  Logic:Get("MysticShop"):On(Logic.MysticShop.EVT.ON_LOAD_SHOP, self:Event("OnUILoadShop"))
  Logic:Get("MysticShop"):On(Logic.MysticShop.EVT.ON_REFRESH, self:Event("OnUIRefresh"))
  Logic:Get("MysticShop"):On(Logic.MysticShop.EVT.ON_EXCHANGED, self:Event("OnUIExchanged"))
  Logic:Get("MysticShop"):On(Logic.MysticShop.EVT.ON_CURRENCY, self:Event("OnUICurrency"))
  Logic:Get("MysticShop"):On(Logic.MysticShop.EVT.MSG_REFRESH_TIME, self:Event("OnUIRefreshTime"))
  Logic:Get("MysticShop"):On(Logic.MysticShop.EVT.MSG_CAN_REFRESH, self:Event("OnUICanRefresh"))
end
function prototype:updateTbv(data, bNoAnimat)
  if not data then
    return
  end
  self.data = data
  self.allNums = #data or 0
  self.allPage = math.ceil(self.allNums / DEFT_NUMS) or 0
  if not self.tableViewControl then
    self.tableViewControl = TableViewEx.prototype:createList(self, self.m_pList, self.allPage)
    if self.tableViewControl and self.tableViewControl.tableView then
      self.curPage = 1
      self.m_pList:addChild(self.tableViewControl.tableView)
      self.tableViewControl:RequireUpdate()
    end
  elseif bNoAnimat then
    self.tableViewControl:RequireUpdateWithoutAnimat(self.allPage, TableViewEx.RESET_POS_TYPE.RESET_OLD_POS)
  else
    self.tableViewControl:RequireUpdate(self.allPage)
  end
end
function prototype:updateRefreshTime()
  local cost = Logic:Get("MysticShop"):GetRefreshCost()
  self.cost = cost
  self.ttfCost:setString(cost or 0)
end
function prototype:refreshUIInfo(bNoAnimat)
  local currency = Logic:Get("MysticShop"):GetCurrency()
  self.ttfCurrency:setString(currency or 0)
  local treasures = Logic:Get("MysticShop"):GetTreasures() or {}
  self:updateTbv(treasures, bNoAnimat)
end
function prototype:onBtnRefresh(sender, event)
  local isOld = Logic:Get("MysticShop"):GetIsOld()
  if isOld then
    Prompt:Confirm(self, "", 111256, function()
      Logic:Get("MysticShop"):PostLoadShop()
    end)
    return
  end
  local canRefresh = Logic:Get("MysticShop"):CanRefreshByTimes()
  if not canRefresh then
    Prompt:Confirm(self, "", 111137)
    return
  end
  local currency = Logic:Get("MysticShop"):GetCurrency()
  if currency < self.cost then
    Prompt:Confirm(self, "", 111144)
    return
  end
  Prompt:ConfirmRecord(self, "", TwGetStr(111132, self.cost or 0), self.comfirmRefresh, Prompt.PROMPT_TYPE.SELECT, nil, Logic.SureConfirm.RECORD_TYPE.MYSTIC_SHOP)
end
function prototype:onBtnSmelt(sender, event)
  Logic:Get("Armor"):setSmeltUIBtnNodeDisabled(true)
  SceneHelper:pushScene("ArmorSmelt", self.rootNode)
end
function prototype:onBtnReturn(sender, event)
  SceneHelper:runWithScene("GiftActivityList", self.rootNode)
end
function prototype:onBg()
end
function prototype:numberOfCellsInTableView(curPage)
  if curPage == self.allPage then
    return self.allNums - (curPage - 1) * DEFT_NUMS
  end
  return DEFT_NUMS
end
function prototype:cellSizeForTable()
  return CCSizeMake(400, 130)
end
function prototype:tableCellAtIndex(table, index, cell, curPage)
  local idx = (curPage - 1) * DEFT_NUMS + index + 1
  if not cell then
    cell = CCTableViewCellEx:create()
    local subNode = Tw.Controller:load("MysticShopItem", self.rootNode)
    if subNode then
      subNode:refresh(idx, self.data[idx])
      cell:addChild(subNode, 0, 1)
    end
  else
    cell:getChildByTag(1):refresh(idx, self.data[idx])
  end
  return cell
end
function prototype:tablePageTurn(curPage)
  self.tableViewControl:RequireUpdate()
end
function prototype:tableCellTouched()
end
function prototype:OnUILoadShop()
  self:updateRefreshTime()
  self:refreshUIInfo()
end
function prototype:OnUIRefresh()
  self:updateRefreshTime()
  self:refreshUIInfo()
end
function prototype:OnUIExchanged(bNoAni)
  self:refreshUIInfo(bNoAni)
end
function prototype:OnUIRefreshTime(strTime)
  self.ttfRefreshTime:setString(strTime or "")
end
function prototype:OnUICanRefresh()
  self.ttfRefreshTime:setString("00:00:00")
end
function prototype:OnUICurrency(currency)
  self.ttfCurrency:setString(currency or 0)
end
function prototype:comfirmRefresh(ret)
  Logic:Get("MysticShop"):PostRefresh()
end
