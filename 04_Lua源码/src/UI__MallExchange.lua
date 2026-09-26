local L0_0
L0_0 = module
L0_0((...), package.seeall)
L0_0 = require
L0_0("SceneHelper")
L0_0 = require
L0_0("TableViewEx")
L0_0 = require
L0_0("BtnPosition")
L0_0 = 20
prototype = BtnPosition.prototype:extend()
function prototype.initialize(A0_1, ...)
  local L3_3, L4_4
  L3_3 = super
  L3_3 = L3_3.initialize
  L4_4 = A0_1
  L3_3(L4_4, ...)
end
function prototype.dispose(A0_5, ...)
  super.dispose(A0_5)
end
function prototype.onEnter(A0_7)
  local L1_8, L2_9, L3_10, L4_11, L5_12
  L1_8 = super
  L1_8 = L1_8.onEnter
  L2_9 = A0_7
  L1_8(L2_9)
  L1_8 = Logic
  L2_9 = L1_8
  L1_8 = L1_8.Get
  L3_10 = "Mall"
  L1_8 = L1_8(L2_9, L3_10)
  L2_9 = L1_8
  L1_8 = L1_8.GetTokenCoinData
  L1_8 = L1_8(L2_9)
  L2_9 = A0_7.ttfTitle
  L3_10 = L2_9
  L2_9 = L2_9.setStyle
  L4_11 = kCCLabelTTFStyleOutline
  L2_9(L3_10, L4_11)
  L2_9 = A0_7.ttfTitle
  L3_10 = L2_9
  L2_9 = L2_9.setString
  L4_11 = L1_8.title
  L4_11 = L4_11 or ""
  L2_9(L3_10, L4_11)
  L2_9 = A0_7.ttfCount
  L3_10 = L2_9
  L2_9 = L2_9.setStyle
  L4_11 = kCCLabelTTFStyleOutline
  L2_9(L3_10, L4_11)
  L2_9 = Logic
  L3_10 = L2_9
  L2_9 = L2_9.Get
  L4_11 = "Mall"
  L2_9 = L2_9(L3_10, L4_11)
  L3_10 = L2_9
  L2_9 = L2_9.GetTokenCoinName
  L4_11 = L1_8.type
  L2_9 = L2_9(L3_10, L4_11)
  L3_10 = A0_7.ttfCount
  L4_11 = L3_10
  L3_10 = L3_10.setString
  L5_12 = TwGetStr
  L5_12 = L5_12(105924, L2_9 or "")
  L3_10(L4_11, L5_12, L5_12(105924, L2_9 or ""))
  L3_10 = Logic
  L4_11 = L3_10
  L3_10 = L3_10.Get
  L5_12 = "Mall"
  L3_10 = L3_10(L4_11, L5_12)
  L4_11 = L3_10
  L3_10 = L3_10.GetTokenCoinPath
  L5_12 = L1_8.type
  L3_10 = L3_10(L4_11, L5_12)
  L4_11 = CCSprite
  L5_12 = L4_11
  L4_11 = L4_11.create
  L4_11 = L4_11(L5_12, L3_10)
  if L4_11 then
    L5_12 = Logic
    L5_12 = L5_12.Get
    L5_12 = L5_12(L5_12, "Mall")
    L5_12 = L5_12.GetTokenCoinColor
    L5_12 = L5_12(L5_12, L1_8.type)
    if L5_12 then
      L4_11:setColor(L5_12)
    end
    A0_7.sprIntegral:setDisplayFrame(L4_11:displayFrame())
    if L5_12 then
      A0_7.sprIntegral:setColor(L5_12)
    end
    if L1_8.type == "TOKEN_COIN_7" then
      A0_7.sprIntegral:setScale(0.32)
    else
      A0_7.sprIntegral:setScale(1)
    end
  end
  L5_12 = A0_7.sprIntegral
  L5_12 = L5_12.setVisible
  L5_12(L5_12, false)
  L5_12 = L1_8.type
  if L5_12 == "TOKEN_COIN_1" then
    L5_12 = A0_7.staStr
    L5_12 = L5_12.setString
    L5_12(L5_12, TwGetStr(105926))
  end
  L5_12 = {}
  A0_7.data = L5_12
  A0_7.page = 1
  L5_12 = TableViewEx
  L5_12 = L5_12.prototype
  L5_12 = L5_12.createList
  L5_12 = L5_12(L5_12, A0_7, A0_7.lstExchange, A0_7.page)
  A0_7.tableViewControl = L5_12
  L5_12 = A0_7.page
  if L5_12 < 2 then
    L5_12 = A0_7.tableViewControl
    L5_12 = L5_12.tableView
    L5_12 = L5_12.setDirection
    L5_12(L5_12, kCCScrollViewDirectionVertical)
  end
  L5_12 = A0_7.lstExchange
  L5_12 = L5_12.addChild
  L5_12(L5_12, A0_7.tableViewControl.tableView)
  L5_12 = A0_7.tableViewControl
  L5_12 = L5_12.tableView
  L5_12 = L5_12.runUIAnimat
  L5_12(L5_12)
  L5_12 = Logic
  L5_12 = L5_12.Get
  L5_12 = L5_12(L5_12, "PlayerInfo")
  L5_12 = L5_12.On
  L5_12(L5_12, Logic.PlayerInfo.EVT.GET_TOKEN_COIN, A0_7:Event("onGetTokenCoin"))
  L5_12 = Logic
  L5_12 = L5_12.Get
  L5_12 = L5_12(L5_12, "PlayerInfo")
  L5_12 = L5_12.On
  L5_12(L5_12, Logic.PlayerInfo.EVT.TOKEN_COIN_EXCHANGE, A0_7:Event("onExchangeTokenCoin"))
  L5_12 = Logic
  L5_12 = L5_12.Get
  L5_12 = L5_12(L5_12, "PlayerInfo")
  L5_12 = L5_12.PostGetTokenCoin
  L5_12(L5_12, L1_8.id)
end
function prototype.onNodeLoaded(A0_13, A1_14, A2_15)
end
function prototype.initTableViewData(A0_16)
  local L1_17, L2_18, L3_19, L4_20, L5_21, L6_22, L7_23, L8_24
  L1_17 = Logic
  L2_18 = L1_17
  L1_17 = L1_17.Get
  L3_19 = "Mall"
  L1_17 = L1_17(L2_18, L3_19)
  L2_18 = L1_17
  L1_17 = L1_17.GetTokenCoinData
  L1_17 = L1_17(L2_18)
  L2_18 = Logic
  L3_19 = L2_18
  L2_18 = L2_18.Get
  L2_18 = L2_18(L3_19, L4_20)
  L3_19 = L2_18
  L2_18 = L2_18.GetPlayerLevel
  L2_18 = L2_18(L3_19)
  function L3_19(A0_25)
    if A0_25.mallId ~= _UPVALUE0_.id then
      return false
    end
    if _UPVALUE1_ < A0_25.minLevel then
      return false
    end
    if _UPVALUE1_ > A0_25.maxLevel then
      return false
    end
    if A0_25.limit <= 0 then
      return true
    end
    return Logic:Get("PlayerInfo"):getExchangeTime(A0_25.id) < A0_25.limit
  end
  A0_16.data = L4_20
  for L7_23 = 1, L5_21(L6_22) do
    L8_24 = KFDBGetRecordByIdx
    L8_24 = L8_24("TokenCoinConfig", L7_23)
    if L3_19(L8_24) then
      table.insert(A0_16.data, L8_24)
    end
  end
  if L5_21 then
    if not L5_21 then
      L7_23 = L4_20
      L5_21(L6_22, L7_23)
    end
  end
  L7_23 = _UPVALUE0_
  A0_16.page = L5_21
  if L5_21 then
    L7_23 = A0_16.page
    L5_21(L6_22, L7_23)
  end
end
function prototype.onBtnReturn(A0_26, A1_27, A2_28)
  SceneHelper:removeScene("MallExchange", A0_26.rootNode)
end
function prototype.onBtnTurnLeft(A0_29, A1_30, A2_31)
  if A0_29.tableViewControl then
    A0_29.tableViewControl:TurnPage(-1)
  end
end
function prototype.onBtnTurnRight(A0_32, A1_33, A2_34)
  if A0_32.tableViewControl then
    A0_32.tableViewControl:TurnPage(1)
  end
end
function prototype.cellSizeForTable(A0_35, ...)
  return CCSizeMake(563, 164)
end
function prototype.tableCellAtIndex(A0_37, A1_38, A2_39, A3_40, A4_41)
  local L5_42, L6_43, L7_44
  L5_42 = A2_39 + 1
  L6_43 = A4_41 - 1
  L7_44 = _UPVALUE0_
  L6_43 = L6_43 * L7_44
  L5_42 = L5_42 + L6_43
  L6_43 = A0_37.data
  L6_43 = L6_43[L5_42]
  if not A3_40 then
    L7_44 = CCTableViewCellEx
    L7_44 = L7_44.create
    L7_44 = L7_44(L7_44)
    A3_40 = L7_44
    L7_44 = Tw
    L7_44 = L7_44.Controller
    L7_44 = L7_44.load
    L7_44 = L7_44(L7_44, "MallExchangeItem", A0_37.rootNode)
    L7_44.pExchangeItem:RefreshExchangeInfo(L6_43)
    A3_40:addChild(L7_44, 0, 2)
  else
    L7_44 = A3_40.getChildByTag
    L7_44 = L7_44(A3_40, 2)
    L7_44 = L7_44.pExchangeItem
    L7_44 = L7_44.RefreshExchangeInfo
    L7_44(L7_44, L6_43)
  end
  return A3_40
end
function prototype.numberOfCellsInTableView(A0_45, A1_46)
  if A0_45.data == nil or table.empty(A0_45.data) then
    return 0
  end
  A0_45.staPage:setString(string.format("%d/%d", A1_46 or 1, A0_45.page or 1))
  if A0_45.page == A1_46 then
    return #A0_45.data - (A0_45.page - 1) * _UPVALUE0_
  else
    return _UPVALUE0_
  end
end
function prototype.tableCellTouched(A0_47, A1_48, A2_49)
end
function prototype.tablePageTurn(A0_50, A1_51)
  A0_50.tableViewControl:RequireUpdate()
end
function prototype.onGetTokenCoin(A0_52)
  local L1_53, L2_54, L3_55, L4_56, L5_57
  L1_53 = Logic
  L2_54 = L1_53
  L1_53 = L1_53.Get
  L3_55 = "PlayerInfo"
  L1_53 = L1_53(L2_54, L3_55)
  L2_54 = L1_53
  L1_53 = L1_53.GetTokenCoin
  L1_53 = L1_53(L2_54)
  L2_54 = A0_52.ttfPoint
  L3_55 = L2_54
  L2_54 = L2_54.setString
  L4_56 = L1_53
  L2_54(L3_55, L4_56)
  L2_54 = A0_52.sprIntegral
  L3_55 = L2_54
  L2_54 = L2_54.getContentSize
  L2_54 = L2_54(L3_55)
  L2_54 = L2_54.width
  L3_55 = Logic
  L4_56 = L3_55
  L3_55 = L3_55.Get
  L5_57 = "Mall"
  L3_55 = L3_55(L4_56, L5_57)
  L4_56 = L3_55
  L3_55 = L3_55.GetTokenCoinData
  L3_55 = L3_55(L4_56)
  if L3_55 then
    L4_56 = L3_55.type
    if L4_56 == "TOKEN_COIN_7" then
      L2_54 = L2_54 * 0.32
    end
  end
  L4_56 = A0_52.ttfPoint
  L5_57 = L4_56
  L4_56 = L4_56.getPositionX
  L4_56 = L4_56(L5_57)
  L5_57 = A0_52.ttfPoint
  L5_57 = L5_57.getContentSize
  L5_57 = L5_57(L5_57)
  L5_57 = L5_57.width
  L4_56 = L4_56 + L5_57
  L4_56 = L4_56 + 8
  L5_57 = L2_54 / 2
  L4_56 = L4_56 + L5_57
  L5_57 = A0_52.ttfPoint
  L5_57 = L5_57.getPositionY
  L5_57 = L5_57(L5_57)
  A0_52.sprIntegral:setPosition(ccp(L4_56, L5_57))
  A0_52.sprIntegral:setVisible(true)
  A0_52:initTableViewData()
end
function prototype.onExchangeTokenCoin(A0_58)
  A0_58:onGetTokenCoin()
  if Logic:Get("Mall"):GetTokenCoinData() and Logic:Get("Mall"):GetTokenCoinData().type == "TOKEN_COIN_7" then
    Logic:Get("PlayerInfo"):PostWallet()
    Logic:Get("PlayerInfo"):PostGetVip()
    Logic:Get("Gift"):PostAllGift()
    Logic:Get("Gift"):PostGetActivitys()
  end
end
