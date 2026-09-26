module((...), package.seeall)
require("SceneHelper")
require("BtnPosition")
require("FabaoLookForItem")
require("Logic.SureConfirm")
prototype = BtnPosition.prototype:extend()
ARRIVE_TIP = {
  "arriveTip1",
  "arriveTip2",
  "arriveTip3",
  "arriveTip4"
}
POP_TIP = {
  "popTip1",
  "popTip2",
  "popTip3",
  "popTip4"
}
ARROW = {
  "arrow1",
  "arrow2",
  "arrow3"
}
TTF_MONEY = {
  "ttfMoney1",
  "ttfMoney2",
  "ttfMoney3",
  "ttfMoney4"
}
TTF_NPCNAME = {
  "ttfNpcName1",
  "ttfNpcName2",
  "ttfNpcName3",
  "ttfNpcName4"
}
NCP_BTN = {
  "btnNpc1",
  "btnNpc2",
  "btnNpc3",
  "btnNpc4"
}
local OPEN_FUNC_ID = 601
local LOCK_XIAN_YU_BUY = "TALISMAN_DRAGON_KING"
function prototype:onEnter()
  super.onEnter(self)
  Logic:Get("FabaoLookFor"):On(Logic.FabaoLookFor.EVT.REFRESH_INFO, self:Event("onRefreshInfo"))
  Logic:Get("FabaoLookFor"):On(Logic.FabaoLookFor.EVT.REFRESH_LOOKFOR, self:Event("onRefreshLookFor"))
  Logic:Get("FabaoLookFor"):On(Logic.FabaoLookFor.EVT.REFRESH_AUTO_LOOKFOR, self:Event("onRefreshAutoLook"))
  Logic:Get("Talisman"):On(Logic.Talisman.EVT.REFRESH_OPEN_DRAGON_KING, self:Event("onOpenDragonKing"))
  Logic:Get("Guide"):On(Logic.Guide.EVT.STEP, self:Event("updateGuide"))
  self:RefreshNpcCost()
  self:RefreshVipBuy()
  self:RefreshXianYuBuy()
end
function prototype:bindAnimationMgr()
  return true
end
function prototype:completedAnimationSequenceNamed(name)
  if name ~= "Default Timeline" then
    return
  end
  Logic:Get("FabaoLookFor"):PostInfo()
  self:updateGuide()
end
function prototype:RefreshVipBuy()
  local ITEM_BG_IMG = {}
  ITEM_BG_IMG.NORMAL = {
    normal = "images/Christmas/lgre_button_nor.png",
    select = "images/Christmas/lgre_button_hig.png",
    disable = "images/Christmas/l_button_dis.png"
  }
  ITEM_BG_IMG.DISABLE = {
    normal = "images/Christmas/l_button_dis.png",
    select = "images/Christmas/l_button_dis.png",
    disable = "images/Christmas/l_button_dis.png"
  }
  local bOpen = Logic:Get("PlayerInfo"):IsOpenFunc(OPEN_FUNC_ID)
  local imgs = bOpen and ITEM_BG_IMG.NORMAL or ITEM_BG_IMG.DISABLE
  self.btnGetvip:setBackgroundSpriteForState(CCScale9Sprite:create(imgs.normal), CCControlStateNormal)
  self.btnGetvip:setBackgroundSpriteForState(CCScale9Sprite:create(imgs.select), CCControlStateHighlighted)
  self.btnGetvip:setBackgroundSpriteForState(CCScale9Sprite:create(imgs.disable), CCControlStateDisabled)
end
function prototype:onRefreshInfo()
  self:RefreshNpc()
  self:RefreshTreasure()
end
function prototype:onRefreshAutoLook()
  self.btnDeal:setEnabled(false)
  self.btnGetNor:setEnabled(false)
  self.btnGetvip:setEnabled(false)
  self.btnTurnBack:setEnabled(false)
  self.autoLookForCurIdx = 1
  Singleton(Timer):Repeat(200, self:Event("RefreshTreaAutoPerTime"))
end
function prototype:RefreshTreaAutoPerTime()
  local autoLookForArray = Logic:Get("FabaoLookFor"):GetAutoLookFor()
  local lookForResult = autoLookForArray[self.autoLookForCurIdx]
  if lookForResult == nil then
    self.btnDeal:setEnabled(true)
    self.btnGetNor:setEnabled(true)
    self.btnGetvip:setEnabled(true)
    self.btnTurnBack:setEnabled(true)
    self:EventTracer():Cancel("RefreshTreaAutoPerTime")
    return
  end
  local rank = Logic:Get("FabaoLookFor"):GetFabaoRank()
  local bRankUp = rank < lookForResult.rank
  Logic:Get("FabaoLookFor"):SetFabaoRank(lookForResult.rank)
  Logic:Get("FabaoLookFor"):AddFabaoTreasures(lookForResult.treasures)
  self:RefreshNpc()
  self:RefreshTreasure()
  if bRankUp then
    self:runRankUpAni()
  end
  self.autoLookForCurIdx = self.autoLookForCurIdx + 1
end
function prototype:onRefreshLookFor()
  local logicTreasure = Logic:Get("FabaoLookFor")
  if logicTreasure:isHunting() then
    Singleton(Timer):After(0, self:Event("TimerGuide", function()
      logicTreasure:setHunting(false)
      Logic:Get("Guide"):check()
    end))
  end
  self:RefreshNpc()
  self:RefreshTreasure()
  if logicTreasure:isRankUp() then
    self:runRankUpAni()
  end
end
function prototype:runRankUpAni()
  local logicTreasure = Logic:Get("FabaoLookFor")
  local rank = logicTreasure:GetFabaoRank()
  local rec = KFDBGetRecord("TaSearchRankConfig", rank)
  if not rec then
    return
  end
  local ani = Logic:Get("AniMgr"):NewCCB("UI/UIbpgod", self.rootNode, ccp(320, 450))
  if ani then
    local child = ani:GetChild("ttfText")
    child:setStyle(kCCLabelTTFStyleOutline)
    child:setString(rec.updateDesr or "")
    local color = Logic:Get("Lottery"):GetHeroRankColor3(rank)
    child:setColor(color)
    ani:RunAni(nil, nil, bind(function()
      ani:RemoveAnimation()
    end, self))
  end
end
function prototype:onOpenDragonKing()
  local logicTreasure = Logic:Get("FabaoLookFor")
  if logicTreasure:isHunting() then
    Singleton(Timer):After(0, self:Event("TimerGuide", function()
      logicTreasure:setHunting(false)
      Logic:Get("Guide"):check()
    end))
  end
  self:RefreshNpc()
end
function prototype:RefreshNpcCost()
  for i = 1, #TTF_MONEY do
    self[TTF_MONEY[i]]:setStyle(kCCLabelTTFStyleOutline)
    self[TTF_MONEY[i]]:setColor(ccColor3B(255, 255, 255))
    local infoRank = KFDBGetRecord("TaSearchRankConfig", i)
    if infoRank ~= nil then
      self[TTF_MONEY[i]]:setString(infoRank.costs)
    end
  end
end
function prototype:RefreshNpc()
  if self.ani ~= nil then
    self.ani:RemoveAnimation()
  end
  for i = 1, #NCP_BTN do
    self[NCP_BTN[i]]:setEnabled(false)
    self[TTF_MONEY[i]]:setColor(ccColor3B(255, 255, 255))
  end
  local rank = Logic:Get("FabaoLookFor"):GetFabaoRank()
  if rank == nil then
    return
  end
  rank = tonumber(rank)
  if rank > #NCP_BTN then
    rank = #NCP_BTN
  end
  local x = self[NCP_BTN[rank]]:getPositionX()
  local y = self[NCP_BTN[rank]]:getPositionY()
  self.ani = Logic:Get("AniMgr"):RunCCBAni("UI/UIxlqy", self, ccp(x, y), 0.8)
  self[NCP_BTN[rank]]:setEnabled(true)
  self[TTF_MONEY[rank]]:setColor(ccColor3B(0, 255, 0))
end
function prototype:RefreshXianYuBuy()
  local lock = Logic:Get("Lock"):checkStatusById(LOCK_XIAN_YU_BUY)
  self.btnXunXian:setVisible(not lock)
  self.imgXunXian:setVisible(not lock)
end
function prototype:RefreshTreasure()
  if self.tableViewControl then
    local curPage = self.tableViewControl:GetPage()
    local pages = self:getFabaoLstPages()
    self.tableViewControl:RequireUpdateWithoutAnimat(pages)
    if curPage ~= pages then
      self.tableViewControl:TurnPageTo(pages, true, true)
    end
  else
    self:createFabaoLst()
  end
  self:onsetBagNum()
end
function prototype:onBtnNpc()
  self:onBtnGetNor()
end
function prototype:checkCanBuy()
  if not Logic:Get("FabaoLookFor"):CheckPackFull() then
    Prompt:Tip(112012)
    return false
  end
  if not Logic:Get("FabaoLookFor"):CheckRankCost() then
    Prompt:ConfirmLeft(self, 106014, 104156)
    return
  end
  return true
end
function prototype:onBtnVipNpc()
  self:onBtnGetNor()
end
function prototype:onBtnXunXian()
  if Logic:Get("FabaoLookFor"):IsYaoChiRank() then
    Logic:Get("SureConfirm").btnText.ok = TwGetStr(112051)
    local str = TwGetStr(112050)
    Prompt:Confirm(self, "", str, self.onBtnGetNor, Prompt.PROMPT_TYPE.CONFIRM)
    return
  end
  local cost, costtype = Logic:Get("FabaoLookFor"):GetOpenXunXianCost()
  if nil == cost or nil == costtype then
    return
  end
  local currTime = Logic:Get("Talisman"):GetDragonCount()
  local maxTime = Logic:Get("Talisman"):GetTheDragonMaxTimes()
  if currTime >= maxTime then
    Prompt:Fail(TwGetStr(112047))
    return
  end
  local strCostType = Logic:Get("PlayerInfo"):GetPlayerMoneyType(json.decode(costtype))
  local str = TwGetStr(112035, cost, strCostType)
  Prompt:ConfirmRecord(self, TwGetStr(112036, strCostType), str, self.confirmXunXianBuy, Prompt.PROMPT_TYPE.SELECT, nil, Logic.SureConfirm.RECORD_TYPE.ADV_LOOK_FOR)
end
function prototype:confirmXunXianBuy()
  local cost, costtype = Logic:Get("FabaoLookFor"):GetOpenXunXianCost()
  if nil == cost or nil == costtype then
    return
  end
  local rolegold = Logic:Get("PlayerInfo"):GetPlayerAllJade()
  if cost > rolegold then
    Prompt:Fail(TwGetStr(112010))
    return
  end
  MsgTalisman:Post("OPEN_DRAGON_KING")
end
function prototype:callBackFunc()
  SceneHelper:pushScene("Artifact", self.rootNode)
end
function prototype:onBtnGetVip(sender, event)
  local bVip = Logic:Get("PlayerInfo"):IsOpenFunc(OPEN_FUNC_ID)
  if not bVip then
    if event == CCControlEventTouchDown then
      Prompt:PopTip(103047)
    end
    if event == CCControlEventTouchUpOutside or event == CCControlEventTouchUpInside or event == CCControlEventTouchCancel then
      Logic:Get("SureConfirm"):FireEvent(Logic.SureConfirm.EVT.CLOSE_POPTIP)
    end
  elseif event == CCControlEventTouchUpInside and self:checkCanBuy() then
    Logic:Get("FabaoLookFor"):PostAutoLookFor()
  end
end
function prototype:onBtnGetNor()
  Logic:Get("Guide"):done("Talisman", "HuntFabao")
  if self:checkCanBuy() then
    Logic:Get("FabaoLookFor"):PostLookFor()
  end
end
function prototype:onBtnDeal()
  Logic:Get("Guide"):done("TalismanDraw", "Draw")
  local temsize = Logic:Get("FabaoLookFor"):GetTemCurSize()
  if temsize == 0 then
    Prompt:Fail(TwGetStr(112011))
    return
  end
  Logic:Get("FabaoLookFor"):PostReceive()
end
function prototype:onBtnTurnBack()
  SceneHelper:runWithScene("FabaoHome", self.rootNode)
end
function prototype:onBtnLeft()
  SceneHelper:runWithScene("FabaoHome", self.rootNode)
end
function prototype:onBtnRight()
  SceneHelper:runWithScene("ChipExchange", self.rootNode)
end
function prototype:onBtnTurnLeft()
  if self.tableViewControl ~= nil then
    self.tableViewControl:TurnPage(-1)
  end
end
function prototype:onBtnTurnRight()
  if self.tableViewControl ~= nil then
    self.tableViewControl:TurnPage(1)
  end
end
function prototype:onsetBagNum()
  local tembag = Logic:Get("FabaoLookFor"):GetTempPackMaxNum()
  local tempcursize = Logic:Get("FabaoLookFor"):GetTemCurSize()
  self.staBagNum:setString(string.format("%d/%d", tempcursize or 0, tembag or 0))
end
function prototype:updateGuide()
  local logicGuide = Logic:Get("Guide")
  if not logicGuide:isGuiding() then
    return
  end
  if logicGuide:isActive("Talisman", "HuntFabao") then
    Logic:Get("Treasure"):setHunting(true)
    logicGuide:lockTouch(self.btnGetNor)
  end
  logicGuide:lockTouch("TalismanEquip", "Start", self.btnTurnBack)
  if logicGuide:isActive("TalismanDraw", "Start") then
    logicGuide:done("TalismanDraw", "Start")
  end
  if logicGuide:isActive("TalismanDraw", "Draw") then
    Logic:Get("FabaoLookFor"):setDrawing(true)
    logicGuide:lockTouch(self.btnDeal)
  end
end
function prototype:getFabaoLstPages()
  local allPages = 1
  local itemNumPerPage = FabaoLookForItem.MAX_FABAO_TREA_PER_PAGE
  local treaPacVo = Logic:Get("FabaoLookFor"):GetTreasurePackVo()
  local treaLst = treaPacVo and treaPacVo.treasures or nil
  if treaLst == nil or table.empty(treaLst) then
    return allPages
  end
  allPages = math.modf(#treaLst / itemNumPerPage)
  allPages = allPages + (math.fmod(#treaLst, itemNumPerPage) > 0 and 1 or 0)
  return allPages
end
function prototype:createFabaoLst()
  local allPages = self:getFabaoLstPages()
  self.tableViewControl = TableViewEx.prototype:createList(self, self.lstFabao, allPages)
  self.lstFabao:addChild(self.tableViewControl.tableView)
  self.tableViewControl.tableView:setDirection(kCCScrollViewDirectionHorizontal)
end
function prototype:cellSizeForTable(...)
  return CCSizeMake(480, 130)
end
function prototype:tableCellAtIndex(table, index, cell, curPage)
  if not cell then
    cell = CCTableViewCellEx:create()
    local subScene = Tw.Controller:load("FabaoLookForItem", self.rootNode)
    subScene:ReFrashInfo(curPage)
    cell:addChild(subScene, 0, 2)
  else
    cell:getChildByTag(2):ReFrashInfo(curPage)
  end
  return cell
end
function prototype:numberOfCellsInTableView(curPage)
  return 1
end
function prototype:tableCellTouched(table, cell)
end
function prototype:tablePageTurn(curPage)
  self.tableViewControl:RequireUpdate()
end
