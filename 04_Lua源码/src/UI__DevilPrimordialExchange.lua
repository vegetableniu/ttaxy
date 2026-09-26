local L0_0
L0_0 = module
L0_0((...), package.seeall)
L0_0 = TypeDef
L0_0 = L0_0("com.eyu.mt.module.demog.facade.DemogResult")
EXCHANGE_RESULT = L0_0
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
L0_0 = 10
function prototype.initialize(A0_1)
  super.initialize(A0_1)
end
function prototype.onEnter(A0_2)
  local L1_3, L2_4, L3_5, L4_6, L5_7, L6_8, L7_9, L8_10, L9_11
  L1_3 = super
  L1_3 = L1_3.onEnter
  L2_4 = A0_2
  L1_3(L2_4)
  L1_3 = Logic
  L2_4 = L1_3
  L1_3 = L1_3.Get
  L1_3 = L1_3(L2_4, L3_5)
  L2_4 = L1_3
  L1_3 = L1_3.On
  L6_8 = "RefreshPrimInfo"
  L9_11 = L4_6(L5_7, L6_8)
  L1_3(L2_4, L3_5, L4_6, L5_7, L6_8, L7_9, L8_10, L9_11, L4_6(L5_7, L6_8))
  L1_3 = Logic
  L2_4 = L1_3
  L1_3 = L1_3.Get
  L1_3 = L1_3(L2_4, L3_5)
  L2_4 = L1_3
  L1_3 = L1_3.On
  L6_8 = "onExchangeSuccess"
  L9_11 = L4_6(L5_7, L6_8)
  L1_3(L2_4, L3_5, L4_6, L5_7, L6_8, L7_9, L8_10, L9_11, L4_6(L5_7, L6_8))
  L1_3 = {}
  A0_2.exchangeInfo = L1_3
  A0_2.page = 1
  L1_3 = A0_2.staPrim
  L2_4 = L1_3
  L1_3 = L1_3.setStyle
  L1_3(L2_4, L3_5)
  L1_3 = A0_2.staFeat
  L2_4 = L1_3
  L1_3 = L1_3.setStyle
  L1_3(L2_4, L3_5)
  L1_3 = Logic
  L2_4 = L1_3
  L1_3 = L1_3.Get
  L1_3 = L1_3(L2_4, L3_5)
  L2_4 = L1_3
  L1_3 = L1_3.getActiveId
  L1_3 = L1_3(L2_4)
  L2_4 = Logic
  L2_4 = L2_4.Get
  L2_4 = L2_4(L3_5, L4_6)
  L2_4 = L2_4.GetPrimExchangeLimit
  L2_4 = L2_4(L3_5)
  A0_2.exchangeLimit = L2_4
  L2_4 = Logic
  L2_4 = L2_4.Get
  L2_4 = L2_4(L3_5, L4_6)
  L2_4 = L2_4.GetPlayerLevel
  L2_4 = L2_4(L3_5)
  L2_4 = L2_4 or 1
  A0_2.bOpenFeat = L3_5
  if L1_3 then
    for L6_8 = 1, L4_6(L5_7) do
      L7_9 = KFDBGetRecordByIdx
      L8_10 = "FragmentExchange"
      L9_11 = L6_8
      L7_9 = L7_9(L8_10, L9_11)
      L8_10 = L1_3 == "DA04" and (L8_10 == 1001 or L8_10 == 1007)
      if L7_9 and not L8_10 then
        L9_11 = L7_9.activeId
        if L9_11 == L1_3 then
          L9_11 = L7_9.level
          if L2_4 >= L9_11 then
            L9_11 = L7_9.isLimit
            if L9_11 then
              L9_11 = A0_2.exchangeLimit
              L9_11 = L9_11[L7_9.id]
              if L9_11 == nil then
                L9_11 = A0_2.exchangeLimit
                L9_11[L7_9.id] = 0
              end
              L9_11 = A0_2.exchangeLimit
              L9_11 = L9_11[L7_9.id]
              if L9_11 < L7_9.limit then
                L9_11 = {}
                if L7_9.mutexId ~= "" and L7_9.mutexId ~= nil then
                  L9_11 = json.decode(L7_9.mutexId)
                end
                if L9_11 ~= nil and next(L9_11) ~= nil then
                  for _FORV_14_, _FORV_15_ in ipairs(L9_11) do
                  end
                end
                if A0_2.exchangeLimit[L7_9.id] + A0_2.exchangeLimit[_FORV_15_] < L7_9.limit then
                  table.insert(A0_2.exchangeInfo, L7_9)
                end
              end
            else
              L9_11 = table
              L9_11 = L9_11.insert
              L9_11(A0_2.exchangeInfo, L7_9)
            end
          end
        end
      end
    end
    L3_5(L4_6, L5_7)
  end
  if L3_5 then
    L3_5(L4_6, L5_7)
    L3_5(L4_6, L5_7)
    L6_8 = L3_5
    L4_6(L5_7, L6_8)
    L6_8 = "images/Devil/gongxunbaodian.png"
    if L4_6 then
      L6_8 = L5_7
      L7_9 = 1.2
      L5_7(L6_8, L7_9)
      L6_8 = L5_7
      L8_10 = L4_6
      L7_9 = L4_6.displayFrame
      L9_11 = L7_9(L8_10)
      L5_7(L6_8, L7_9, L8_10, L9_11, L7_9(L8_10))
    end
  end
  if L3_5 then
    A0_2.data = L3_5
    if L4_6 == 0 then
    else
    end
    if L5_7 == 0 then
      A0_2.page = 1
    else
      A0_2.page = L5_7
    end
    L6_8 = TableViewEx
    L6_8 = L6_8.prototype
    L7_9 = L6_8
    L6_8 = L6_8.createList
    L8_10 = A0_2
    L9_11 = A0_2.lstExchange
    L6_8 = L6_8(L7_9, L8_10, L9_11, A0_2.page)
    A0_2.tableViewControl = L6_8
    L6_8 = A0_2.tableViewControl
    L6_8 = L6_8.tableView
    L7_9 = L6_8
    L6_8 = L6_8.runUIAnimat
    L6_8(L7_9)
    L6_8 = A0_2.page
    if L6_8 == 1 then
      L6_8 = A0_2.tableViewControl
      L6_8 = L6_8.tableView
      L7_9 = L6_8
      L6_8 = L6_8.setDirection
      L8_10 = kCCScrollViewDirectionVertical
      L6_8(L7_9, L8_10)
    end
    L6_8 = A0_2.lstExchange
    L7_9 = L6_8
    L6_8 = L6_8.addChild
    L8_10 = A0_2.tableViewControl
    L8_10 = L8_10.tableView
    L6_8(L7_9, L8_10)
  end
  L6_8 = L3_5
  L4_6(L5_7, L6_8)
end
function prototype.RefreshPrimInfo(A0_12)
  local L1_13, L2_14, L3_15, L4_16, L5_17, L6_18, L7_19, L8_20, L9_21, L10_22
  L1_13 = Logic
  L2_14 = L1_13
  L1_13 = L1_13.Get
  L3_15 = "Devil"
  L1_13 = L1_13(L2_14, L3_15)
  L2_14 = L1_13
  L1_13 = L1_13.GetFragment
  L1_13 = L1_13(L2_14)
  L2_14 = A0_12.staPrim
  L3_15 = L2_14
  L2_14 = L2_14.setString
  L4_16 = L1_13
  L2_14(L3_15, L4_16)
  L2_14 = Logic
  L3_15 = L2_14
  L2_14 = L2_14.Get
  L4_16 = "Devil"
  L2_14 = L2_14(L3_15, L4_16)
  L3_15 = L2_14
  L2_14 = L2_14.GetExchangeNum
  L2_14 = L2_14(L3_15)
  L3_15 = Logic
  L4_16 = L3_15
  L3_15 = L3_15.Get
  L3_15 = L3_15(L4_16, L5_17)
  L4_16 = L3_15
  L3_15 = L3_15.GetExchangeConfigId
  L3_15 = L3_15(L4_16)
  L4_16 = false
  for L8_20, L9_21 in L5_17(L6_18) do
    L10_22 = L9_21.isLimit
    if L10_22 then
      L10_22 = L9_21.id
      if L10_22 == L3_15 then
        L10_22 = L9_21.limit
        if L2_14 >= L10_22 then
          L10_22 = table
          L10_22 = L10_22.remove
          L10_22(A0_12.exchangeInfo, L8_20)
          L4_16 = true
        else
          L10_22 = {}
          if L9_21.mutexId ~= "" and L9_21.mutexId ~= nil then
            L10_22 = json.decode(L9_21.mutexId)
          end
          if L10_22 ~= nil and next(L10_22) ~= nil then
            for _FORV_15_, _FORV_16_ in ipairs(L10_22) do
            end
          end
          if L2_14 + A0_12.exchangeLimit[_FORV_16_] >= L9_21.limit then
            table.remove(A0_12.exchangeInfo, L8_20)
            L4_16 = true
          end
        end
      end
    end
  end
  if L5_17 then
    L8_20 = L5_17
    L6_18(L7_19, L8_20)
  end
  if L4_16 then
    L5_17(L6_18)
  end
end
function prototype.onExchangeSuccess(A0_23)
  local L1_24
  L1_24 = TwGetStr
  L1_24 = L1_24(105554)
  Prompt:Msg(L1_24)
end
function prototype.onBtnReturn(A0_25)
  if Logic:Get("Devil"):getRankType() == Logic.Devil.RANK_TYPE.DAMAGERANK then
    SceneHelper:runWithScene("DevilHarmRank", A0_25.rootNode)
  elseif Logic:Get("Devil"):getRankType() == Logic.Devil.RANK_TYPE.FEATSRANK then
    SceneHelper:runWithScene("DevilFeatsRank", A0_25.rootNode)
  elseif Logic:Get("Devil"):getRankType() == Logic.Devil.RANK_TYPE.DEVILMAIN then
    SceneHelper:runWithScene("DevilMain", A0_25.rootNode)
  end
end
function prototype.onBtnTurnLeft(A0_26)
  if A0_26.tableViewControl ~= nil then
    A0_26.tableViewControl:TurnPage(-1)
  end
end
function prototype.onBtnTurnRight(A0_27)
  if A0_27.tableViewControl ~= nil then
    A0_27.tableViewControl:TurnPage(1)
  end
end
function prototype.cellSizeForTable(A0_28, ...)
  return CCSizeMake(563, 164)
end
function prototype.tableCellAtIndex(A0_30, A1_31, A2_32, A3_33, A4_34)
  local L5_35
  if not A3_33 then
    L5_35 = CCTableViewCellEx
    L5_35 = L5_35.create
    L5_35 = L5_35(L5_35)
    A3_33 = L5_35
    L5_35 = Tw
    L5_35 = L5_35.Controller
    L5_35 = L5_35.load
    L5_35 = L5_35(L5_35, "DevilPrimordialExchangeItem", A0_30.rootNode)
    L5_35.pExchangeItem:RefreshExchangeInfo(A0_30.exchangeInfo[(A4_34 - 1) * _UPVALUE0_ + A2_32 + 1])
    A3_33:addChild(L5_35, 0, 2)
  else
    L5_35 = A3_33.getChildByTag
    L5_35 = L5_35(A3_33, 2)
    L5_35 = L5_35.pExchangeItem
    L5_35 = L5_35.RefreshExchangeInfo
    L5_35(L5_35, A0_30.exchangeInfo[(A4_34 - 1) * _UPVALUE0_ + A2_32 + 1])
  end
  return A3_33
end
function prototype.numberOfCellsInTableView(A0_36, A1_37)
  A0_36.staPage:setString(string.format("%d/%d", A1_37 or 1, A0_36.page or 1))
  if A0_36.exchangeInfo ~= nil and next(A0_36.exchangeInfo) ~= nil then
    if A0_36.page == A1_37 then
      return #A0_36.exchangeInfo - (A0_36.page - 1) * _UPVALUE0_
    else
      return _UPVALUE0_
    end
  else
    return 0
  end
end
function prototype.tableCellTouched(A0_38, A1_39, A2_40)
end
function prototype.tablePageTurn(A0_41, A1_42)
  A0_41.tableViewControl:RequireUpdate()
end
