module((...), package.seeall)
require("SceneHelper")
require("TableViewEx")
require("BtnPosition")
prototype = BtnPosition.prototype:extend()
function prototype.RefreshHeroBag(A0_0)
  local L1_1, L2_2, L3_3, L4_4, L5_5, L6_6
  L1_1 = Logic
  L2_2 = L1_1
  L1_1 = L1_1.Get
  L3_3 = "Hero"
  L1_1 = L1_1(L2_2, L3_3)
  L2_2 = L1_1
  L1_1 = L1_1.GetAllHeroInfo
  L1_1 = L1_1(L2_2)
  if not L1_1 then
    return
  end
  L2_2 = Logic
  L3_3 = L2_2
  L2_2 = L2_2.Get
  L4_4 = "Hero"
  L2_2 = L2_2(L3_3, L4_4)
  L3_3 = L2_2
  L2_2 = L2_2.GetHeroTableFromMap
  L4_4 = L1_1.heros
  L2_2 = L2_2(L3_3, L4_4)
  if not L2_2 then
    return
  end
  L3_3 = Logic
  L4_4 = L3_3
  L3_3 = L3_3.Get
  L5_5 = "Hero"
  L3_3 = L3_3(L4_4, L5_5)
  L4_4 = L3_3
  L3_3 = L3_3.GetHeroInfosByIds
  L5_5 = L2_2
  L3_3 = L3_3(L4_4, L5_5)
  if L3_3 then
    L4_4 = Logic
    L5_5 = L4_4
    L4_4 = L4_4.Get
    L6_6 = "Hero"
    L4_4 = L4_4(L5_5, L6_6)
    L5_5 = L4_4
    L4_4 = L4_4.SortHerosByChoice
    L6_6 = L3_3
    L4_4(L5_5, L6_6, Logic.Hero.SORT_CHOICE.HERO_BAG)
    A0_0.heros = L3_3
    L4_4 = {L5_5}
    L5_5 = A0_0.heros
    A0_0.data = L4_4
    L4_4 = math
    L4_4 = L4_4.modf
    L5_5 = #L3_3
    L6_6 = Logic
    L6_6 = L6_6.Hero
    L6_6 = L6_6.MAX_HEROS_PER_PAGE
    L5_5 = L5_5 / L6_6
    L5_5 = L4_4(L5_5)
    L6_6 = 1
    if L5_5 == 0 then
      L6_6 = L4_4
    else
      L6_6 = L4_4 + 1
    end
    A0_0.page = L6_6
    if A0_0.tableViewControl then
      A0_0.tableViewControl:RequireUpdate(A0_0.page)
    else
      A0_0.tableViewControl = TableViewEx.prototype:createList(A0_0, A0_0.lstHeros, L6_6)
      A0_0.tableViewControl.tableView:runUIAnimat()
      A0_0.lstHeros:addChild(A0_0.tableViewControl.tableView)
    end
    A0_0.staBag:setString(TwGetStr(104153, #L3_3 or 0, Logic:Get("Hero"):GetTotalExtendLimit() or 0))
  end
end
function prototype.onEnter(A0_7)
  super.onEnter(A0_7)
  Logic:Get("Hero"):On(Logic.Hero.EVT.ALL_HEROS, A0_7:Event("RefreshHeroBag"))
  Logic:Get("Hero"):On(Logic.Hero.EVT.HERO_LOCK, A0_7:Event("OnHeroLock"))
  A0_7:RefreshHeroBag()
  A0_7:ShowSaleCardTip()
  if Logic:Get("Lock"):checkStatusById("CARD_SWAP_XIAN") and CCSprite:create("images/Swap/swapDisable.png") then
    A0_7.sprLeft:setDisplayFrame(CCSprite:create("images/Swap/swapDisable.png"):displayFrame())
  end
end
function prototype.OnHeroLock(A0_8)
  A0_8:RefreshHeroBag()
end
function prototype.onBtnLeft(A0_9)
  A0_9.tableViewControl:TurnPage(-1)
end
function prototype.onBtnRight(A0_10)
  A0_10.tableViewControl:TurnPage(1)
end
function prototype.onBtnReturn(A0_11, A1_12, A2_13)
  if A0_11.btnSale:isVisible() then
    if Logic:Get("Lock"):checkStatusById("CARD_SWAP_XIAN") then
      if A2_13 == CCControlEventTouchDown then
        Logic:Get("Lock"):showLockTipById("CARD_SWAP_XIAN")
      end
      Logic:Get("Lock"):closeLockTip(A2_13)
      return
    end
    if A2_13 == CCControlEventTouchUpInside then
      SceneHelper:runWithScene("HeroTranslate", A0_11.rootNode)
    end
  else
    A0_11.staTitle:setString(TwGetStr(104002))
    A0_11.btnSale:setVisible(true)
    A0_11.staSale:setVisible(true)
    SceneHelper:runWithScene("Hero", A0_11.rootNode)
  end
end
function prototype.onBtnSale(A0_14, A1_15, A2_16)
  SceneHelper:runWithScene("HeroSale", A0_14.rootNode)
end
function prototype.cellSizeForTable(A0_17, ...)
  return CCSizeMake(563, 117)
end
function prototype.tableCellAtIndex(A0_19, A1_20, A2_21, A3_22, A4_23)
  local L5_24
  L5_24 = A0_19.staPage
  L5_24 = L5_24.setString
  L5_24(L5_24, string.format("%d/%d", A4_23 or 1, A0_19.page or 1))
  if not A3_22 then
    L5_24 = CCTableViewCellEx
    L5_24 = L5_24.create
    L5_24 = L5_24(L5_24)
    A3_22 = L5_24
    L5_24 = Tw
    L5_24 = L5_24.Controller
    L5_24 = L5_24.load
    L5_24 = L5_24(L5_24, "HeroViewItem", A0_19.rootNode)
    L5_24.pHeroItem:RefreshHeros(A0_19.heros[(A4_23 - 1) * Logic.Hero.MAX_HEROS_PER_PAGE + A2_21 + 1])
    A3_22:addChild(L5_24, 0, 2)
  else
    L5_24 = A3_22.getChildByTag
    L5_24(A3_22, 2)
    L5_24 = A3_22.getChildByTag
    L5_24 = L5_24(A3_22, 2)
    L5_24 = L5_24.pHeroItem
    L5_24 = L5_24.RefreshHeros
    L5_24(L5_24, A0_19.heros[(A4_23 - 1) * Logic.Hero.MAX_HEROS_PER_PAGE + A2_21 + 1])
  end
  return A3_22
end
function prototype.numberOfCellsInTableView(A0_25, A1_26)
  local L2_27, L3_28, L4_29
  L2_27 = A0_25.page
  if L2_27 == A1_26 then
    L2_27 = A0_25.heros
    L2_27 = #L2_27
    L3_28 = A0_25.page
    L3_28 = L3_28 - 1
    L4_29 = Logic
    L4_29 = L4_29.Hero
    L4_29 = L4_29.MAX_HEROS_PER_PAGE
    L3_28 = L3_28 * L4_29
    L2_27 = L2_27 - L3_28
    return L2_27
  else
    L2_27 = Logic
    L2_27 = L2_27.Hero
    L2_27 = L2_27.MAX_HEROS_PER_PAGE
    return L2_27
  end
end
function prototype.tableCellTouched(A0_30, A1_31, A2_32)
end
function prototype.tablePageTurn(A0_33, A1_34)
  A0_33.tableViewControl:RequireUpdate()
end
function prototype.ShowSaleCardTip(A0_35)
  local L1_36
  L1_36 = A0_35.imgSaleTip
  L1_36 = L1_36.removeAllChildrenWithCleanup
  L1_36(L1_36, true)
  L1_36 = false
  if L1_36 then
    Logic:Get("AniMgr"):RunCCBAni("UI/uinew", A0_35.imgSaleTip, nil, 1, nil, nil, nil, -1)
  end
  A0_35.imgSaleTip:setVisible(L1_36)
end
