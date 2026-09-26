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
function prototype.initialize(A0_1)
  super.initialize(A0_1)
  MsgTalisman:Post("GET_FRAGMENT")
end
function prototype.onEnter(A0_2)
  local L1_3, L2_4, L3_5, L4_6, L5_7, L6_8
  L1_3 = super
  L1_3 = L1_3.onEnter
  L1_3(L2_4)
  L1_3 = {}
  A0_2.data = L1_3
  L1_3 = Logic
  L1_3 = L1_3.Get
  L1_3 = L1_3(L2_4, L3_5)
  L1_3 = L1_3.GetPlayerLevel
  L1_3 = L1_3(L2_4)
  for L5_7 = 1, L3_5(L4_6) do
    L6_8 = KFDBGetRecordByIdx
    L6_8 = L6_8("FragmentExSetting", L5_7)
    if L6_8 == nil then
      return
    end
    if L1_3 >= L6_8.minLevel and L1_3 <= L6_8.maxLevel then
      table.insert(A0_2.data, L6_8)
    end
  end
  if L3_5 then
    if not L3_5 then
      L5_7 = L2_4
      L3_5(L4_6, L5_7)
    end
  end
  L5_7 = _UPVALUE0_
  A0_2.page = L3_5
  L5_7 = A0_2
  L6_8 = A0_2.lstExchange
  A0_2.tableViewControl = L3_5
  if L3_5 < 2 then
    L5_7 = kCCScrollViewDirectionVertical
    L3_5(L4_6, L5_7)
  end
  L5_7 = "ttfLei"
  L6_8 = "ttfPage"
  L5_7 = A0_2
  L6_8 = L3_5
  L4_6(L5_7, L6_8)
  L5_7 = L4_6
  L6_8 = A0_2.tableViewControl
  L6_8 = L6_8.tableView
  L4_6(L5_7, L6_8)
  L5_7 = L4_6
  L6_8 = "Talisman"
  L5_7 = L4_6
  L6_8 = Logic
  L6_8 = L6_8.Talisman
  L6_8 = L6_8.EVT
  L6_8 = L6_8.GET_FRAGMENT_EVT
  L4_6(L5_7, L6_8, A0_2:Event("SetttfPoint"))
  L5_7 = A0_2
  L4_6(L5_7)
end
function prototype.addTranslateEntries(A0_9)
  local L1_10, L2_11, L3_12
  L1_10 = A0_9.translateHits
  if L1_10 then
    return
  end
  L1_10 = Logic
  L2_11 = L1_10
  L1_10 = L1_10.Get
  L3_12 = "PlayerInfo"
  L1_10 = L1_10(L2_11, L3_12)
  L2_11 = L1_10
  L1_10 = L1_10.GetPlayerLevel
  L1_10 = L1_10(L2_11)
  L1_10 = L1_10 or 1
  L2_11 = _UPVALUE0_
  if L1_10 < L2_11 then
    L2_11 = A0_9.imgBtnRightBg
    if L2_11 then
      L2_11 = A0_9.imgBtnRightBg
      L3_12 = L2_11
      L2_11 = L2_11.setVisible
      L2_11(L3_12, false)
    end
    return
  end
  A0_9.translateHits = true
  L2_11 = A0_9.imgBtnRightBg
  if L2_11 then
    L2_11 = A0_9.imgBtnRightBg
    L3_12 = L2_11
    L2_11 = L2_11.getParent
    L2_11 = L2_11(L3_12)
  end
  if L2_11 == nil then
    return
  end
  L3_12 = A0_9.imgBtnRightBg
  L3_12 = L3_12.setVisible
  L3_12(L3_12, true)
  L3_12 = A0_9.imgBtnLeftBg
  if L3_12 then
    L3_12 = pcall
    L3_12(function()
      local L0_13, L1_14
      L0_13 = _UPVALUE0_
      L0_13 = L0_13.imgBtnRightBg
      L1_14 = L0_13
      L0_13 = L0_13.setDisplayFrame
      L0_13(L1_14, _UPVALUE0_.imgBtnLeftBg:displayFrame())
    end)
    L3_12 = A0_9.imgBtnLeftBg
    L3_12 = L3_12.getContentSize
    L3_12 = L3_12(L3_12)
    if L3_12 and L3_12.width > 20 then
      A0_9.imgBtnRightBg:setContentSize(L3_12)
    end
  end
  L3_12 = A0_9.sprRight
  if L3_12 then
    L3_12 = A0_9.sprRight
    L3_12 = L3_12.setVisible
    L3_12(L3_12, false)
  end
  L3_12 = A0_9.placeCaptionButton
  L3_12(A0_9, L2_11, A0_9.imgBtnRightBg, "\230\179\149\229\174\157\232\189\172\230\141\162", bind(A0_9.onOpenTranslate, A0_9))
end
function prototype.placeCaptionButton(A0_15, A1_16, A2_17, A3_18, A4_19)
  local L5_20, L6_21, L7_22, L8_23
  L6_21 = A2_17
  L5_20 = A2_17.getContentSize
  L5_20 = L5_20(L6_21)
  L6_21 = L5_20.width
  if L6_21 < 20 then
    L6_21 = CCSize
    L7_22 = 88
    L8_23 = 48
    L6_21 = L6_21(L7_22, L8_23)
    L5_20 = L6_21
    L7_22 = A2_17
    L6_21 = A2_17.setContentSize
    L8_23 = L5_20
    L6_21(L7_22, L8_23)
  end
  L6_21 = CCLabelTTF
  L7_22 = L6_21
  L6_21 = L6_21.create
  L6_21 = L6_21(L7_22)
  L8_23 = L6_21
  L7_22 = L6_21.setString
  L7_22(L8_23, A3_18)
  L8_23 = L6_21
  L7_22 = L6_21.setFontSize
  L7_22(L8_23, 28)
  L8_23 = L6_21
  L7_22 = L6_21.setColor
  L7_22(L8_23, ccc3(255, 220, 80))
  L8_23 = L6_21
  L7_22 = L6_21.setStyle
  L7_22(L8_23, kCCLabelTTFStyleOutline, ccc3(0, 0, 0))
  L8_23 = L6_21
  L7_22 = L6_21.setAnchorPoint
  L7_22(L8_23, ccp(0.5, 0.5))
  L8_23 = L6_21
  L7_22 = L6_21.setPosition
  L7_22(L8_23, ccp(L5_20.width / 2, L5_20.height / 2))
  L8_23 = A2_17
  L7_22 = A2_17.addChild
  L7_22(L8_23, L6_21, 40)
  L8_23 = A2_17
  L7_22 = A2_17.getPositionLua
  L7_22 = L7_22(L8_23)
  L8_23 = CCLayer
  L8_23 = L8_23.create
  L8_23 = L8_23(L8_23)
  L8_23:setContentSize(L5_20)
  L8_23:setAnchorPoint(ccp(0.5, 0.5))
  L8_23:setPosition(ccp(L7_22.x, L7_22.y))
  L8_23:registerScriptTouchHandler(function(A0_24, A1_25, A2_26)
    local L3_27, L4_28
    L3_27 = CCTOUCHBEGAN
    if A0_24 ~= L3_27 then
      L3_27 = false
      return L3_27
    end
    L3_27 = _UPVALUE0_
    L4_28 = L3_27
    L3_27 = L3_27.convertToNodeSpace
    L3_27 = L3_27(L4_28, ccp(A1_25, A2_26))
    L4_28 = _UPVALUE1_
    L4_28 = L4_28.x
    L4_28 = L4_28 - _UPVALUE2_.width / 2
    if L4_28 <= L3_27.x and L3_27.x <= L4_28 + _UPVALUE2_.width and _UPVALUE1_.y - _UPVALUE2_.height / 2 <= L3_27.y and L3_27.y <= _UPVALUE1_.y - _UPVALUE2_.height / 2 + _UPVALUE2_.height then
      _UPVALUE3_()
      return true
    end
    return false
  end, false, -200, true)
  L8_23:setTouchEnabled(true)
  A1_16:addChild(L8_23, 41)
end
function prototype.onOpenTranslate(A0_29)
  SceneHelper:runWithScene("FabaoTranslate", A0_29.rootNode)
end
function prototype.SetttfPoint(A0_30)
  local L1_31, L2_32, L3_33, L4_34
  L1_31 = Logic
  L2_32 = L1_31
  L1_31 = L1_31.Get
  L3_33 = "Talisman"
  L1_31 = L1_31(L2_32, L3_33)
  L2_32 = L1_31
  L1_31 = L1_31.GetFragment
  L1_31 = L1_31(L2_32)
  L2_32 = Logic
  L3_33 = L2_32
  L2_32 = L2_32.Get
  L4_34 = "Talisman"
  L2_32 = L2_32(L3_33, L4_34)
  L3_33 = L2_32
  L2_32 = L2_32.GetLeiBi
  L2_32 = L2_32(L3_33)
  L3_33 = A0_30.ttfFrag
  L4_34 = L3_33
  L3_33 = L3_33.setString
  L3_33(L4_34, L1_31)
  L3_33 = A0_30.ttfLei
  L4_34 = L3_33
  L3_33 = L3_33.setString
  L3_33(L4_34, L2_32)
  L3_33 = A0_30.ttfFrag
  L4_34 = L3_33
  L3_33 = L3_33.getPositionX
  L3_33 = L3_33(L4_34)
  L4_34 = A0_30.ttfFrag
  L4_34 = L4_34.getContentSize
  L4_34 = L4_34(L4_34)
  L4_34 = L4_34.width
  L3_33 = L3_33 + L4_34
  L3_33 = L3_33 + 10
  L4_34 = A0_30.sprIntegral
  L4_34 = L4_34.setPositionX
  L4_34(L4_34, L3_33)
  L4_34 = A0_30.ttfLei
  L4_34 = L4_34.getPositionX
  L4_34 = L4_34(L4_34)
  L4_34 = L4_34 + A0_30.ttfLei:getContentSize().width
  L4_34 = L4_34 + 10
  A0_30.sprLeiBi:setPositionX(L4_34)
end
function prototype.onBtnReturn(A0_35)
  SceneHelper:runWithScene("FabaoHome", A0_35.rootNode)
end
function prototype.onBtnTurnLeft(A0_36, A1_37, A2_38)
  if A0_36.tableViewControl then
    A0_36.tableViewControl:TurnPage(-1)
  end
end
function prototype.onBtnTurnRight(A0_39, A1_40, A2_41)
  if A0_39.tableViewControl then
    A0_39.tableViewControl:TurnPage(1)
  end
end
function prototype.onWriteBand(A0_42, A1_43)
  local L2_44, L3_45, L4_46, L5_47
  if A1_43 then
    for L5_47 = 1, #A1_43 do
      if A0_42[A1_43[L5_47]] then
        A0_42[A1_43[L5_47]]:setStyle(kCCLabelTTFStyleOutline)
      end
    end
  end
end
function prototype.cellSizeForTable(A0_48, ...)
  return CCSizeMake(580, 160)
end
function prototype.tableCellAtIndex(A0_50, A1_51, A2_52, A3_53, A4_54)
  local L5_55, L6_56, L7_57
  L5_55 = A2_52 + 1
  L6_56 = A4_54 - 1
  L7_57 = _UPVALUE0_
  L6_56 = L6_56 * L7_57
  L5_55 = L5_55 + L6_56
  L6_56 = A0_50.data
  L6_56 = L6_56[L5_55]
  if not A3_53 then
    L7_57 = CCTableViewCellEx
    L7_57 = L7_57.create
    L7_57 = L7_57(L7_57)
    A3_53 = L7_57
    L7_57 = Tw
    L7_57 = L7_57.Controller
    L7_57 = L7_57.load
    L7_57 = L7_57(L7_57, "ChipExchangeItem", A0_50.rootNode)
    L7_57:ReFrashInfo(L6_56)
    A3_53:addChild(L7_57, 0, 2)
  else
    L7_57 = A3_53.getChildByTag
    L7_57 = L7_57(A3_53, 2)
    L7_57 = L7_57.ReFrashInfo
    L7_57(L7_57, L6_56)
  end
  return A3_53
end
function prototype.numberOfCellsInTableView(A0_58, A1_59)
  if A0_58.data == nil or table.empty(A0_58.data) then
    return 0
  end
  A0_58.ttfPage:setString(string.format("%d/%d", A1_59 or 1, A0_58.page or 1))
  if A0_58.page == A1_59 then
    return #A0_58.data - (A0_58.page - 1) * _UPVALUE0_
  else
    return _UPVALUE0_
  end
end
function prototype.tableCellTouched(A0_60, A1_61, A2_62)
end
function prototype.tablePageTurn(A0_63, A1_64)
  A0_63.tableViewControl:RequireUpdate()
end
