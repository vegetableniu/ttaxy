local L0_0
L0_0 = module
L0_0((...), package.seeall)
L0_0 = require
L0_0("SceneHelper")
L0_0 = require
L0_0("TableViewEx")
L0_0 = require
L0_0("BtnPosition")
L0_0 = BtnPosition
L0_0 = L0_0.prototype
L0_0 = L0_0.extend
L0_0 = L0_0(L0_0)
prototype = L0_0
L0_0 = "images/public/selcet2.png"
function prototype.onNodeLoaded(A0_1, A1_2, A2_3)
end
function prototype.onQuitBottent(A0_4)
  SceneHelper:runWithScene("Home", A0_4.rootNode)
end
function prototype.onExplainBottent(A0_5)
  local L1_6
  L1_6 = "images/font/kapaisuipian_small.png"
  if A0_5.inHero then
    A0_5:onBtnArmor()
  else
    A0_5:onBtnHero()
    L1_6 = "images/font/shipin_small.png"
  end
  if CCSprite:create(L1_6) then
    A0_5.sprRight:setDisplayFrame(CCSprite:create(L1_6):displayFrame())
  end
end
function prototype.onBtnBottent(A0_7)
  SceneHelper:runWithScene("Resolve", A0_7.rootNode)
end
function prototype.onBtnBreak(A0_8)
  SceneHelper:runWithScene("HeroSplit", A0_8.rootNode)
end
function prototype.onBtnSell(A0_9)
  SceneHelper:runWithScene("ComposeSale", A0_9.rootNode)
end
function prototype.onMeunItem(A0_10)
  local L1_11, L2_12
  L1_11 = A0_10.seleTrue
  L2_12 = _UPVALUE0_
  if L1_11 then
    L2_12 = _UPVALUE1_
    A0_10.seleTrue = false
    Logic:Get("Compose"):SetEtend(A0_10.seleTrue)
  else
    A0_10.seleTrue = true
    Logic:Get("Compose"):SetEtend(A0_10.seleTrue)
  end
  if CCSprite:create(L2_12) then
    A0_10.sprCheck:setDisplayFrame(CCSprite:create(L2_12):displayFrame())
  end
  if A0_10.tableViewControl ~= nil then
    A0_10.tableViewControl:RequireUpdateWithoutAnimat(A0_10.page, false)
  end
end
function prototype.onEnter(A0_13)
  local L1_14, L2_15
  L1_14 = super
  L1_14 = L1_14.onEnter
  L2_15 = A0_13
  L1_14(L2_15)
  L1_14 = Logic
  L2_15 = L1_14
  L1_14 = L1_14.Get
  L1_14 = L1_14(L2_15, "Compose")
  L2_15 = L1_14
  L1_14 = L1_14.SetHasCompsoeB
  L1_14(L2_15, false)
  L1_14 = Logic
  L2_15 = L1_14
  L1_14 = L1_14.Get
  L1_14 = L1_14(L2_15, "Compose")
  L2_15 = L1_14
  L1_14 = L1_14.On
  L1_14(L2_15, Logic.Compose.EVT.REFRESH_ITEM, A0_13:Event("RefrashItem"))
  L1_14 = Logic
  L2_15 = L1_14
  L1_14 = L1_14.Get
  L1_14 = L1_14(L2_15, "Devil")
  L2_15 = L1_14
  L1_14 = L1_14.On
  L1_14(L2_15, Logic.Devil.EVT.REFRESH_RED_COM, A0_13:Event("RefrashItemRED"))
  L1_14 = Logic
  L2_15 = L1_14
  L1_14 = L1_14.Get
  L1_14 = L1_14(L2_15, "Compose")
  L2_15 = L1_14
  L1_14 = L1_14.PostGetItems
  L1_14(L2_15)
  A0_13.seleTrue = false
  L1_14 = Logic
  L2_15 = L1_14
  L1_14 = L1_14.Get
  L1_14 = L1_14(L2_15, "Compose")
  L2_15 = L1_14
  L1_14 = L1_14.SetEtend
  L1_14(L2_15, A0_13.seleTrue)
  L1_14 = Logic
  L2_15 = L1_14
  L1_14 = L1_14.Get
  L1_14 = L1_14(L2_15, "PlayerInfo")
  L2_15 = L1_14
  L1_14 = L1_14.GetPlayerMoney
  L1_14 = L1_14(L2_15)
  L2_15 = A0_13.ttfNum
  L2_15 = L2_15.setString
  L2_15(L2_15, L1_14[string.lower("FRAGMENT")])
  L2_15 = Logic
  L2_15 = L2_15.Get
  L2_15 = L2_15(L2_15, "Compose")
  L2_15 = L2_15.SetRedVisible
  L2_15(L2_15)
  L2_15 = Logic
  L2_15 = L2_15.Get
  L2_15 = L2_15(L2_15, "Compose")
  L2_15 = L2_15.GetGoodsByType
  L2_15(L2_15, "FRAGMENT")
  L2_15 = Logic
  L2_15 = L2_15.Get
  L2_15 = L2_15(L2_15, "Compose")
  L2_15 = L2_15.GetCasualGoods
  L2_15 = L2_15(L2_15)
  A0_13.allGiftIdTable = Logic:Get("Compose"):GetArrItemOfId()
  if next(L2_15) == nil then
    A0_13.btnLeft:setEnabled(false)
    A0_13.btnRight:setEnabled(false)
    A0_13.ttfPage:setString(1 .. "/" .. 1)
    A0_13:onBtnHero()
    return
  end
  if L2_15 then
    A0_13.allGift = L2_15
    A0_13.page = math.ceil(#A0_13.allGiftIdTable / Logic.Compose.MAX_LIST)
    A0_13.data = A0_13.allGift
    A0_13.tableViewControl = TableViewEx.prototype:createList(A0_13, A0_13.m_pCList, A0_13.page)
    A0_13.tableViewControl.tableView:runUIAnimat()
    if A0_13.page == 1 then
      A0_13.tableViewControl.tableView:setDirection(kCCScrollViewDirectionVertical)
    end
    A0_13.m_pCList:addChild(A0_13.tableViewControl.tableView)
  end
  A0_13.loadArmor = false
  A0_13:onBtnHero()
end
function prototype.RefrashItem(A0_16)
  local L1_17, L2_18
  L1_17 = Logic
  L2_18 = L1_17
  L1_17 = L1_17.Get
  L1_17 = L1_17(L2_18, "PlayerInfo")
  L2_18 = L1_17
  L1_17 = L1_17.GetPlayerMoney
  L1_17 = L1_17(L2_18)
  L2_18 = A0_16.ttfNum
  L2_18 = L2_18.setString
  L2_18(L2_18, L1_17[string.lower("FRAGMENT")])
  L2_18 = Logic
  L2_18 = L2_18.Get
  L2_18 = L2_18(L2_18, "Compose")
  L2_18 = L2_18.GetGoodsByType
  L2_18(L2_18, "FRAGMENT")
  L2_18 = Logic
  L2_18 = L2_18.Get
  L2_18 = L2_18(L2_18, "Compose")
  L2_18 = L2_18.GetCasualGoods
  L2_18 = L2_18(L2_18)
  A0_16.allGiftIdTable = Logic:Get("Compose"):GetArrItemOfId()
  if next(L2_18) == nil then
    A0_16.btnLeft:setEnabled(false)
    A0_16.btnRight:setEnabled(false)
  end
  A0_16.allGift = L2_18
  A0_16.data = A0_16.allGift
  A0_16.page = math.ceil(#A0_16.allGiftIdTable / Logic.Compose.MAX_LIST)
  if A0_16.tableViewControl ~= nil then
    A0_16.tableViewControl:RequireUpdate(A0_16.page)
  end
end
function prototype.RefrashItemRED(A0_19)
  A0_19:RefrashItem()
end
function prototype.cellSizeForTable(A0_20, ...)
  return CCSizeMake(588, 164)
end
function prototype.tableCellAtIndex(A0_22, A1_23, A2_24, A3_25, A4_26)
  local L5_27, L6_28, L7_29, L8_30
  L5_27 = A2_24 + 1
  L6_28 = A4_26 - 1
  L7_29 = Logic
  L7_29 = L7_29.Compose
  L7_29 = L7_29.MAX_LIST
  L6_28 = L6_28 * L7_29
  L6_28 = L5_27 + L6_28
  L7_29 = A0_22.allGiftIdTable
  L7_29 = L7_29[L6_28]
  if not A3_25 then
    L8_30 = CCTableViewCellEx
    L8_30 = L8_30.create
    L8_30 = L8_30(L8_30)
    A3_25 = L8_30
    L8_30 = Tw
    L8_30 = L8_30.Controller
    L8_30 = L8_30.load
    L8_30 = L8_30(L8_30, "ComposeItem", A0_22.rootNode)
    L8_30:ReFrashReward(A0_22.allGift[L7_29])
    A3_25:addChild(L8_30, 0, 2)
  else
    L8_30 = A3_25.getChildByTag
    L8_30 = L8_30(A3_25, 2)
    L8_30 = L8_30.ReFrashReward
    L8_30(L8_30, A0_22.allGift[L7_29])
  end
  return A3_25
end
function prototype.numberOfCellsInTableView(A0_31, A1_32)
  if A0_31.page == 0 then
    A0_31.page = 1
  end
  A0_31.ttfPage:setString(A1_32 .. "/" .. A0_31.page)
  if #A0_31.allGiftIdTable == 0 then
    return 0
  end
  if A0_31.page == A1_32 then
    return #A0_31.allGiftIdTable - (A0_31.page - 1) * Logic.Hero.MAX_HEROS_PER_PAGE
  else
    return Logic.Compose.MAX_LIST
  end
end
function prototype.tableCellTouched(A0_33, A1_34, A2_35)
end
function prototype.tablePageTurn(A0_36, A1_37)
  A0_36.tableViewControl:RequireUpdate()
end
function prototype.onBtnLeft(A0_38)
  if A0_38.tableViewControl ~= nil then
    A0_38.tableViewControl:TurnPage(-1)
  end
end
function prototype.onBtnRight(A0_39)
  if A0_39.tableViewControl ~= nil then
    A0_39.tableViewControl:TurnPage(1)
  end
end
function prototype.onBtnHero(A0_40, A1_41, A2_42)
  A0_40.inHero = true
  A0_40:enableCtrl(true)
  if A0_40.tableViewControl then
    A0_40.tableViewControl:RequireUpdate()
  end
end
function prototype.onBtnArmor(A0_43, A1_44, A2_45)
  local L3_46, L4_47, L5_48, L6_49
  L3_46 = Logic
  L4_47 = L3_46
  L3_46 = L3_46.Get
  L5_48 = "Lock"
  L3_46 = L3_46(L4_47, L5_48)
  L4_47 = L3_46
  L3_46 = L3_46.checkStatusById
  L5_48 = "EQUIP"
  L3_46 = L3_46(L4_47, L5_48)
  L4_47 = Logic
  L5_48 = L4_47
  L4_47 = L4_47.Get
  L6_49 = "Lock"
  L4_47 = L4_47(L5_48, L6_49)
  L5_48 = L4_47
  L4_47 = L4_47.GetLevelAndBattleNames
  L6_49 = "EQUIP"
  L5_48 = L4_47(L5_48, L6_49)
  if L3_46 then
    L6_49 = Prompt
    L6_49 = L6_49.Tip
    L6_49(L6_49, TwGetStr(111148, L4_47, L5_48))
    return
  end
  L6_49 = A0_43.loadArmor
  if not L6_49 then
    L6_49 = Tw
    L6_49 = L6_49.Controller
    L6_49 = L6_49.load
    L6_49 = L6_49(L6_49, "ArmorCombine", A0_43.rootNode)
    A0_43.nodeArmor:addChild(L6_49, 0, 1)
    A0_43.loadArmor = true
  end
  A0_43.inHero = false
  L6_49 = A0_43.enableCtrl
  L6_49(A0_43, false)
  L6_49 = A0_43.nodeArmor
  L6_49 = L6_49.getChildByTag
  L6_49 = L6_49(L6_49, 1)
  L6_49 = L6_49.refresh
  L6_49(L6_49)
end
function prototype.enableCtrl(A0_50, A1_51)
  A0_50.nodeArmor:setVisible(not A1_51)
  A0_50.m_pCList:setVisible(A1_51)
  A0_50.sprHero:setVisible(A1_51)
  A0_50.sprArmor:setVisible(not A1_51)
  A0_50.ttfPage:setVisible(A1_51)
  A0_50.sprPage:setVisible(A1_51)
  A0_50.node:setVisible(A1_51)
end
