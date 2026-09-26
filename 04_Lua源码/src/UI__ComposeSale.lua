module((...), package.seeall)
require("SceneHelper")
require("TableViewEx")
require("BtnPosition")
prototype = BtnPosition.prototype:extend()
function prototype.onNodeLoaded(A0_0, A1_1, A2_2)
end
function prototype.onQuitBottent(A0_3)
  Logic:Get("Main"):SetFuncVisible(true)
  Logic:Get("Compose"):ClearSaleComposeList()
  SceneHelper:runWithScene("Compose", A0_3.rootNode)
end
function prototype.onExplainBottent(A0_4)
  local L1_5, L2_6
  L1_5 = "images/font/all_select.png"
  if L2_6 then
    if not L2_6 then
      for _FORV_5_, _FORV_6_ in L2_6(A0_4.allGift) do
        if Logic:Get("Compose"):kdbItemConfig(_FORV_6_.baseId) and Logic:Get("Compose"):kdbItemConfig(_FORV_6_.baseId).sell ~= nil and tonumber(Logic:Get("Compose"):kdbItemConfig(_FORV_6_.baseId).sell) == 1 then
          Logic:Get("Compose"):SetSaleComposeList(_FORV_6_.id, _FORV_6_.amount)
        end
      end
      L1_5 = "images/newfont/Cancel.png"
      A0_4.allSelect = true
    else
      L1_5 = "images/font/all_select.png"
      L2_6(L2_6)
      A0_4.allSelect = false
    end
    if L2_6 then
      A0_4.sprRight:setDisplayFrame(L2_6:displayFrame())
    end
  end
  L2_6(L2_6, "FRAGMENT")
  A0_4.allGiftIdTable = Logic:Get("Compose"):GetSaleArrItemOfId()
  if next(L2_6) == nil then
    A0_4.btnLeft:setEnabled(false)
    A0_4.btnRight:setEnabled(false)
    return
  end
  A0_4.allGift = L2_6
  A0_4.data = A0_4.allGift
  A0_4.page = math.ceil(#A0_4.allGiftIdTable / Logic.Compose.MAX_LIST)
  A0_4.tableViewControl:RequireUpdateWithoutAnimat(A0_4.page, TableViewEx.RESET_POS_TYPE.RESET_OLD_POS)
  A0_4:RefreshConfig()
end
function prototype.onExit(A0_7)
  Logic:Get("Compose"):ClearSaleComposeList()
  Logic:Get("Main"):SetFuncVisible(true)
end
function prototype.onEnter(A0_8)
  local L1_9
  L1_9 = super
  L1_9 = L1_9.onEnter
  L1_9(A0_8)
  L1_9 = A0_8.pnlConfirm
  L1_9 = L1_9.setAnchorPoint
  L1_9(L1_9, CCPoint(0, 0))
  L1_9 = Logic
  L1_9 = L1_9.Get
  L1_9 = L1_9(L1_9, "Compose")
  L1_9 = L1_9.SetHasCompsoeB
  L1_9(L1_9, false)
  L1_9 = Logic
  L1_9 = L1_9.Get
  L1_9 = L1_9(L1_9, "Compose")
  L1_9 = L1_9.On
  L1_9(L1_9, Logic.Compose.EVT.REFRESH_SELL_ITEMS, A0_8:Event("RefrashItem"))
  L1_9 = Logic
  L1_9 = L1_9.Get
  L1_9 = L1_9(L1_9, "Compose")
  L1_9 = L1_9.On
  L1_9(L1_9, Logic.Compose.EVT.REFRESH_CONFIG, A0_8:Event("RefreshConfig"))
  L1_9 = Logic
  L1_9 = L1_9.Get
  L1_9 = L1_9(L1_9, "Compose")
  L1_9 = L1_9.SetRedVisible
  L1_9(L1_9, false)
  L1_9 = Logic
  L1_9 = L1_9.Get
  L1_9 = L1_9(L1_9, "Compose")
  L1_9 = L1_9.GetGoodsByType
  L1_9(L1_9, "FRAGMENT")
  L1_9 = Logic
  L1_9 = L1_9.Get
  L1_9 = L1_9(L1_9, "Compose")
  L1_9 = L1_9.GetCasualGoods
  L1_9 = L1_9(L1_9)
  A0_8.allGiftIdTable = Logic:Get("Compose"):GetSaleArrItemOfId()
  A0_8.pnlConfirm:setVisible(false)
  Logic:Get("Main"):SetFuncVisible(true)
  A0_8.allSelect = false
  if next(L1_9) == nil then
    A0_8.btnLeft:setEnabled(false)
    A0_8.btnRight:setEnabled(false)
    A0_8.ttfPage:setString(1 .. "/" .. 1)
    return
  end
  if L1_9 then
    A0_8.allGift = L1_9
    A0_8.page = math.ceil(#A0_8.allGiftIdTable / Logic.Compose.MAX_LIST)
    A0_8.data = A0_8.allGift
    A0_8.tableViewControl = TableViewEx.prototype:createList(A0_8, A0_8.m_pCList, A0_8.page)
    A0_8.tableViewControl.tableView:runUIAnimat()
    if A0_8.page == 1 then
      A0_8.tableViewControl.tableView:setDirection(kCCScrollViewDirectionVertical)
    end
    A0_8.m_pCList:addChild(A0_8.tableViewControl.tableView)
  end
end
function prototype.RefrashItem(A0_10)
  local L1_11
  L1_11 = Logic
  L1_11 = L1_11.Get
  L1_11 = L1_11(L1_11, "Compose")
  L1_11 = L1_11.GetGoodsByType
  L1_11(L1_11, "FRAGMENT")
  L1_11 = Logic
  L1_11 = L1_11.Get
  L1_11 = L1_11(L1_11, "Compose")
  L1_11 = L1_11.GetCasualGoods
  L1_11 = L1_11(L1_11)
  A0_10.allGiftIdTable = Logic:Get("Compose"):GetSaleArrItemOfId()
  if next(L1_11) == nil then
    A0_10.btnLeft:setEnabled(false)
    A0_10.btnRight:setEnabled(false)
  end
  A0_10.allGift = L1_11
  A0_10.data = A0_10.allGift
  A0_10.page = math.ceil(#A0_10.allGiftIdTable / Logic.Compose.MAX_LIST)
  A0_10.tableViewControl:RequireUpdate(A0_10.page)
  A0_10:RefreshConfig()
end
function prototype.cellSizeForTable(A0_12, ...)
  return CCSizeMake(588, 164)
end
function prototype.tableCellAtIndex(A0_14, A1_15, A2_16, A3_17, A4_18)
  local L5_19, L6_20, L7_21, L8_22
  L5_19 = A2_16 + 1
  L6_20 = A4_18 - 1
  L7_21 = Logic
  L7_21 = L7_21.Compose
  L7_21 = L7_21.MAX_LIST
  L6_20 = L6_20 * L7_21
  L6_20 = L5_19 + L6_20
  L7_21 = A0_14.allGiftIdTable
  L7_21 = L7_21[L6_20]
  if not A3_17 then
    L8_22 = CCTableViewCellEx
    L8_22 = L8_22.create
    L8_22 = L8_22(L8_22)
    A3_17 = L8_22
    L8_22 = Tw
    L8_22 = L8_22.Controller
    L8_22 = L8_22.load
    L8_22 = L8_22(L8_22, "ComposeSaleItem", A0_14.rootNode)
    L8_22:ReFrashReward(A0_14.allGift[L7_21])
    A3_17:addChild(L8_22, 0, 2)
  else
    L8_22 = A3_17.getChildByTag
    L8_22 = L8_22(A3_17, 2)
    L8_22 = L8_22.ReFrashReward
    L8_22(L8_22, A0_14.allGift[L7_21])
  end
  return A3_17
end
function prototype.numberOfCellsInTableView(A0_23, A1_24)
  if A0_23.page == 0 then
    A0_23.page = 1
  end
  A0_23.ttfPage:setString(A1_24 .. "/" .. A0_23.page)
  if #A0_23.allGiftIdTable == 0 then
    return 0
  end
  if A0_23.page == A1_24 then
    return #A0_23.allGiftIdTable - (A0_23.page - 1) * Logic.Hero.MAX_HEROS_PER_PAGE
  else
    return Logic.Compose.MAX_LIST
  end
end
function prototype.tableCellTouched(A0_25, A1_26, A2_27)
end
function prototype.tablePageTurn(A0_28, A1_29)
  A0_28.tableViewControl:RequireUpdate()
end
function prototype.onBtnLeft(A0_30)
  if A0_30.tableViewControl ~= nil then
    A0_30.tableViewControl:TurnPage(-1)
  end
end
function prototype.onBtnRight(A0_31)
  if A0_31.tableViewControl ~= nil then
    A0_31.tableViewControl:TurnPage(1)
  end
end
function prototype.RefreshConfig(A0_32)
  local L1_33, L2_34, L3_35, L4_36, L5_37
  L1_33 = Logic
  L2_34 = L1_33
  L1_33 = L1_33.Get
  L3_35 = "Compose"
  L1_33 = L1_33(L2_34, L3_35)
  L2_34 = L1_33
  L1_33 = L1_33.GetSaleComposeList
  L1_33 = L1_33(L2_34)
  L2_34 = Logic
  L3_35 = L2_34
  L2_34 = L2_34.Get
  L4_36 = "Main"
  L2_34 = L2_34(L3_35, L4_36)
  L3_35 = L2_34
  L2_34 = L2_34.SetFuncVisible
  L4_36 = false
  L2_34(L3_35, L4_36)
  L2_34 = Logic
  L3_35 = L2_34
  L2_34 = L2_34.Get
  L4_36 = "Compose"
  L2_34 = L2_34(L3_35, L4_36)
  L3_35 = L2_34
  L2_34 = L2_34.SaleCurrencyTotals
  L4_36 = L1_33
  L5_37 = A0_32.allGift
  L4_36 = L2_34(L3_35, L4_36, L5_37)
  L5_37 = table
  L5_37 = L5_37.empty
  L5_37 = L5_37(L1_33)
  if L5_37 then
    L5_37 = A0_32.pnlConfirm
    L5_37 = L5_37.staNum
    L5_37 = L5_37.setString
    L5_37(L5_37, 0)
    L5_37 = A0_32.pnlConfirm
    L5_37 = L5_37.staTotal
    L5_37 = L5_37.setString
    L5_37(L5_37, 0)
    L5_37 = A0_32.pnlConfirm
    L5_37 = L5_37.setVisible
    L5_37(L5_37, false)
    L5_37 = Logic
    L5_37 = L5_37.Get
    L5_37 = L5_37(L5_37, "Main")
    L5_37 = L5_37.SetFuncVisible
    L5_37(L5_37, true)
    L5_37 = A0_32.pnlConfirm
    L5_37 = L5_37.ApplySaleMoneyIcon
    if L5_37 then
      L5_37 = A0_32.pnlConfirm
      L5_37 = L5_37.ApplySaleMoneyIcon
      L5_37(L5_37, false)
    end
  else
    L5_37 = A0_32.pnlConfirm
    L5_37 = L5_37.staNum
    L5_37 = L5_37.setString
    L5_37(L5_37, L4_36)
    L5_37 = A0_32.pnlConfirm
    L5_37 = L5_37.staTotal
    L5_37 = L5_37.setString
    L5_37(L5_37, Logic:Get("Compose"):FormatSaleTotal(L2_34, L3_35))
    L5_37 = A0_32.pnlConfirm
    L5_37 = L5_37.setVisible
    L5_37(L5_37, true)
    L5_37 = A0_32.pnlConfirm
    L5_37 = L5_37.ApplySaleMoneyIcon
    if L5_37 then
      L5_37 = A0_32.pnlConfirm
      L5_37 = L5_37.ApplySaleMoneyIcon
      L5_37(L5_37, L3_35 > 0 and L2_34 <= 0)
    end
  end
  L5_37 = table
  L5_37 = L5_37.empty
  L5_37 = L5_37(L1_33)
  if L5_37 then
    L5_37 = "images/font/all_select.png"
    if CCSprite:create(L5_37) then
      A0_32.sprRight:setDisplayFrame(CCSprite:create(L5_37):displayFrame())
    end
    A0_32.allSelect = false
  else
    L5_37 = A0_32.allGiftIdTable
    L5_37 = #L5_37
    if L4_36 == L5_37 then
      L5_37 = "images/newfont/Cancel.png"
      if CCSprite:create(L5_37) then
        A0_32.sprRight:setDisplayFrame(CCSprite:create(L5_37):displayFrame())
      end
      A0_32.allSelect = true
    end
  end
end
