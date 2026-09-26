local L0_0
L0_0 = module
L0_0((...), package.seeall)
L0_0 = require
L0_0("SceneHelper")
L0_0 = require
L0_0("TableViewEx")
L0_0 = require
L0_0("Logic.Compose")
L0_0 = require
L0_0("BtnPosition")
L0_0 = BtnPosition
L0_0 = L0_0.prototype
L0_0 = L0_0.extend
L0_0 = L0_0(L0_0)
prototype = L0_0
L0_0 = 1
function prototype.onBtnReturn(A0_1)
  _UPVALUE0_ = true
  SceneHelper:runWithScene("Gift", A0_1.rootNode)
end
function prototype.onExit(A0_2)
  if _UPVALUE0_ then
    _UPVALUE1_ = 1
    _UPVALUE2_ = nil
    _UPVALUE0_ = false
  elseif A0_2.tableViewControl and A0_2.tableViewControl.tableView then
    _UPVALUE1_ = A0_2.tableViewControl:GetPage()
    _UPVALUE2_ = A0_2.tableViewControl.tableView:getContentOffset().y
  end
end
function prototype.onEnter(A0_3)
  local L1_4, L2_5, L3_6, L4_7, L5_8, L6_9
  L1_4 = super
  L1_4 = L1_4.onEnter
  L2_5 = A0_3
  L1_4(L2_5)
  L1_4 = Logic
  L2_5 = L1_4
  L1_4 = L1_4.Get
  L3_6 = "Target"
  L1_4 = L1_4(L2_5, L3_6)
  L2_5 = L1_4
  L1_4 = L1_4.PostGetProgress
  L3_6 = nil
  L1_4(L2_5, L3_6)
  L1_4 = Logic
  L2_5 = L1_4
  L1_4 = L1_4.Get
  L3_6 = "Gift"
  L1_4 = L1_4(L2_5, L3_6)
  L2_5 = L1_4
  L1_4 = L1_4.SetGiftInfoType
  L3_6 = "Activity"
  L1_4(L2_5, L3_6)
  L1_4 = Logic
  L2_5 = L1_4
  L1_4 = L1_4.Get
  L3_6 = "Gift"
  L1_4 = L1_4(L2_5, L3_6)
  L2_5 = L1_4
  L1_4 = L1_4.GetCanShowAcivityList
  L1_4 = L1_4(L2_5)
  L2_5 = Logic
  L3_6 = L2_5
  L2_5 = L2_5.Get
  L4_7 = "NewMonopoly"
  L2_5 = L2_5(L3_6, L4_7)
  L3_6 = L2_5
  L2_5 = L2_5.On
  L4_7 = Logic
  L4_7 = L4_7.NewMonopoly
  L4_7 = L4_7.EVT
  L4_7 = L4_7.LOAD_NEWMONOPOLY
  L6_9 = A0_3
  L5_8 = A0_3.Event
  L6_9 = L5_8(L6_9, "onLoadNewMonopoly")
  L2_5(L3_6, L4_7, L5_8, L6_9, L5_8(L6_9, "onLoadNewMonopoly"))
  L2_5 = table
  L2_5 = L2_5.empty
  L3_6 = L1_4
  L2_5 = L2_5(L3_6)
  if L2_5 then
    L2_5 = A0_3.ttfPage
    L3_6 = L2_5
    L2_5 = L2_5.setString
    L4_7 = 1
    L5_8 = "/"
    L6_9 = 1
    L4_7 = L4_7 .. L5_8 .. L6_9
    L2_5(L3_6, L4_7)
    return
  end
  if L1_4 then
    A0_3.activityList = L1_4
    L2_5 = math
    L2_5 = L2_5.ceil
    L3_6 = A0_3.activityList
    L3_6 = #L3_6
    L4_7 = Logic
    L4_7 = L4_7.Compose
    L4_7 = L4_7.MAX_LIST
    L3_6 = L3_6 / L4_7
    L2_5 = L2_5(L3_6)
    A0_3.page = L2_5
    L2_5 = A0_3.activityList
    A0_3.data = L2_5
    L2_5 = TableViewEx
    L2_5 = L2_5.prototype
    L3_6 = L2_5
    L2_5 = L2_5.createList
    L4_7 = A0_3
    L5_8 = A0_3.m_pCList
    L6_9 = A0_3.page
    L2_5 = L2_5(L3_6, L4_7, L5_8, L6_9)
    A0_3.tableViewControl = L2_5
    L2_5 = A0_3.tableViewControl
    L3_6 = L2_5
    L2_5 = L2_5.TurnPageTo
    L4_7 = _UPVALUE0_
    L5_8 = true
    L6_9 = false
    L2_5(L3_6, L4_7, L5_8, L6_9)
    L2_5 = _UPVALUE1_
    if L2_5 then
      L2_5 = A0_3.tableViewControl
      L2_5 = L2_5.tableView
      L4_7 = L2_5
      L3_6 = L2_5.getContentOffset
      L3_6 = L3_6(L4_7)
      L5_8 = L2_5
      L4_7 = L2_5.minContainerOffset
      L4_7 = L4_7(L5_8)
      L6_9 = L2_5
      L5_8 = L2_5.maxContainerOffset
      L5_8 = L5_8(L6_9)
      L6_9 = math
      L6_9 = L6_9.min
      L6_9 = L6_9(L5_8.y, math.max(_UPVALUE1_, L4_7.y))
      L2_5:setContentOffset(ccp(L3_6.x, L6_9), false)
    end
    L2_5 = A0_3.tableViewControl
    L2_5 = L2_5.tableView
    L3_6 = L2_5
    L2_5 = L2_5.runUIAnimat
    L2_5(L3_6)
    L2_5 = A0_3.page
    if L2_5 == 1 then
      L2_5 = A0_3.tableViewControl
      L2_5 = L2_5.tableView
      L3_6 = L2_5
      L2_5 = L2_5.setDirection
      L4_7 = kCCScrollViewDirectionVertical
      L2_5(L3_6, L4_7)
    end
    L2_5 = A0_3.m_pCList
    L3_6 = L2_5
    L2_5 = L2_5.addChild
    L4_7 = A0_3.tableViewControl
    L4_7 = L4_7.tableView
    L2_5(L3_6, L4_7)
  end
end
function prototype.onLoadNewMonopoly(A0_10)
  if ({
    xiyou = "RicherValeNormal",
    valentine = "RicherValeMap"
  })[Logic:Get("NewMonopoly"):GetMonoInfo().currFloor] then
    SceneHelper:pushScene(({
      xiyou = "RicherValeNormal",
      valentine = "RicherValeMap"
    })[Logic:Get("NewMonopoly"):GetMonoInfo().currFloor], A0_10.rootNode)
  end
end
function prototype.cellSizeForTable(A0_11, ...)
  return CCSizeMake(561, 121)
end
function prototype.tableCellAtIndex(A0_13, A1_14, A2_15, A3_16, A4_17)
  local L5_18, L6_19, L7_20
  L5_18 = A2_15 + 1
  L6_19 = A4_17 - 1
  L7_20 = Logic
  L7_20 = L7_20.Compose
  L7_20 = L7_20.MAX_LIST
  L6_19 = L6_19 * L7_20
  L6_19 = L5_18 + L6_19
  if not A3_16 then
    L7_20 = CCTableViewCellEx
    L7_20 = L7_20.create
    L7_20 = L7_20(L7_20)
    A3_16 = L7_20
    L7_20 = Tw
    L7_20 = L7_20.Controller
    L7_20 = L7_20.load
    L7_20 = L7_20(L7_20, "GiftActivityItem", A0_13.rootNode)
    L7_20:ReFrashReward(A0_13.activityList[L6_19], A2_15)
    A3_16:addChild(L7_20, 0, 2)
  else
    L7_20 = A3_16.getChildByTag
    L7_20 = L7_20(A3_16, 2)
    L7_20 = L7_20.ReFrashReward
    L7_20(L7_20, A0_13.activityList[L6_19], A2_15)
  end
  return A3_16
end
function prototype.numberOfCellsInTableView(A0_21, A1_22)
  if A0_21.page == 0 then
    A0_21.page = 1
  end
  A0_21.ttfPage:setString(A1_22 .. "/" .. A0_21.page)
  if #A0_21.activityList == 0 then
    return 0
  end
  if A0_21.page == A1_22 then
    return #A0_21.activityList - (A0_21.page - 1) * Logic.Hero.MAX_HEROS_PER_PAGE
  else
    return Logic.Compose.MAX_LIST
  end
end
function prototype.tableCellTouched(A0_23, A1_24, A2_25)
end
function prototype.tablePageTurn(A0_26, A1_27)
  A0_26.tableViewControl:RequireUpdate()
end
function prototype.onBtnLeft(A0_28)
  if A0_28.tableViewControl ~= nil then
    A0_28.tableViewControl:TurnPage(-1)
  end
end
function prototype.onBtnRight(A0_29)
  if A0_29.tableViewControl ~= nil then
    A0_29.tableViewControl:TurnPage(1)
  end
end
