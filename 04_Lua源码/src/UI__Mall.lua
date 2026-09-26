module((...), package.seeall)
require("SceneHelper")
require("TableViewEx")
require("BtnPosition")
prototype = BtnPosition.prototype:extend()
local BUY_POINT = 1
local BUY_BAG = 2
local BUY_FRIEND_LIMIT = 3
function prototype:initialize(...)
  super.initialize(self, ...)
  self.buyType = 0
  self.cost = 0
end
function prototype:dispose(...)
  super.dispose(self)
end
function prototype:onEnter()
  super.onEnter(self)
  Logic:Get("Mall"):On(Logic.Mall.EVT.BUY_BAG, self:Event("BuyBag"))
  Logic:Get("Mall"):On(Logic.Mall.EVT.BUY_FRIEND_LIMITE, self:Event("buyFriendLimit"))
  Logic:Get("Mall"):On(Logic.Mall.EVT.BUY_SUCCESSED, self:Event("onBuySuccussed"))
  Logic:Get("Mall"):On(Logic.Mall.EVT.GET_LOTTERY_LIST, self:Event("onGetLotteryList"))
  self.tableViewControl = TableViewEx.prototype:createList(self, self.lstMall, 1)
  self.tableViewControl.tableView:setDirection(kCCScrollViewDirectionVertical)
  self.lstMall:addChild(self.tableViewControl.tableView)
  self.ani = Logic:Get("AniMgr"):NewCCB("UI/UIcz", self.sprRight, ccp(35, 19), 0, nil, nil)
  if self.ani then
    self.ani:RunAni()
  end
  MsgPlayer:Post("GET_LOTTERY_LIST")
end
function prototype:onChange()
  do return end
  self.tableViewControl.tableView:runUIAnimat(false)
  return 0.2
end
function prototype:onNodeLoaded(node, loader)
end
function prototype:onBtnRecharge(sender, event)
  Logic:Get("Main"):GotoRecharge()
end
function prototype:BuyBag(cost, size)
  self.buyType = BUY_BAG
  self.cost = cost
  local text = TwGetStr(105204, size, cost)
  Prompt:Confirm(self, 105203, text, self.onConfirmBuy, Prompt.PROMPT_TYPE.SELECT)
end
function prototype:buyFriendLimit(cost, size)
  self.buyType = BUY_FRIEND_LIMIT
  self.cost = cost
  local text = TwGetStr(105206, size, cost)
  Prompt:Confirm(self, 105205, text, self.onConfirmBuy, Prompt.PROMPT_TYPE.SELECT)
end
function prototype:onBuySuccussed()
  self.tableViewControl:RequireUpdateWithoutAnimat(1, false)
end
function prototype:onGetLotteryList()
  Logic:Get("Mall"):initItemData()
  self.mallTab = Logic:Get("Mall"):GetTabData()
  self.mallTab = list.filter(function(data)
    return data.show
  end, self.mallTab)
  self.data = {
    [1] = self.mallTab
  }
  if self.tableViewControl then
    self.tableViewControl:RequireUpdate()
  end
end
function prototype:onConfirmBuy()
  local money = Logic:Get("PlayerInfo"):GetPlayerAllJade()
  if money < self.cost then
    Logic:Get("SureConfirm").btnText.ok = TwGetStr(104003)
    Prompt:Confirm(Logic:Get("Main"), "", 105316, Logic:Get("Main").GotoRecharge, Prompt.PROMPT_TYPE.SELECT)
    return
  end
  if self.buyType == BUY_BAG then
    Logic:Get("Mall"):PostBuyBag()
  elseif self.buyType == BUY_FRIEND_LIMIT then
    Logic:Get("Mall"):PostBuyFriendLimit()
  end
end
function prototype:cellSizeForTable(...)
  return CCSizeMake(563, 121)
end
function prototype:tableCellAtIndex(table, index, cell, curPage)
  if not cell then
    cell = CCTableViewCellEx:create()
    local subScene = Tw.Controller:load("MallItem", self.rootNode)
    subScene:Refrash(self.data[curPage][index + 1])
    cell:addChild(subScene, 0, 2)
  else
    cell:getChildByTag(2):Refrash(self.data[curPage][index + 1])
  end
  return cell
end
function prototype:actionFinish(tableView)
  if not Logic:Get("Guide"):isGuiding() then
    return
  end
  local LotteryType = Logic.Mall.ITEM_TYPE.LOTTERY_XIAN
  local key = "type"
  if Logic:Get("Guide"):isActive("EquipLottery", "SelectItem") then
    LotteryType = "ACTIVITY_EQUIP"
    key = "lotteryType"
  end
  local idx
  for i, tab in ipairs(self.mallTab) do
    if tab[key] == LotteryType then
      idx = i
      break
    end
  end
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
function prototype:numberOfCellsInTableView(curPage)
  if self.data and not table.empty(self.data) and self.data[curPage] and not table.empty(self.data[curPage]) then
    return #self.data[curPage]
  else
    return 0
  end
end
function prototype:tableCellTouched(table, cell)
  local idx = tolua.cast(cell, "CCTableViewCellEx"):getIdx()
end
function prototype:tablePageTurn(curPage)
  self.tableViewControl:RequireUpdate()
end
