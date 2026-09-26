local L0_0
L0_0 = require
L0_0("SceneHelper")
L0_0 = module
L0_0((...), package.seeall)
L0_0 = require
L0_0("SceneHelper")
L0_0 = Tw
L0_0 = L0_0.Controller
L0_0 = L0_0.prototype
L0_0 = L0_0.extend
L0_0 = L0_0(L0_0)
prototype = L0_0
L0_0 = "images/Main/skillLock.png"
function prototype.onEnter(A0_1)
  local L1_2, L2_3, L3_4, L4_5, L5_6, L6_7, L7_8, L8_9, L9_10, L10_11, L11_12, L12_13, L13_14
  A0_1.opening = true
  L1_2 = Logic
  L2_3 = L1_2
  L1_2 = L1_2.Get
  L3_4 = "Sect"
  L1_2 = L1_2(L2_3, L3_4)
  L2_3 = L1_2
  L1_2 = L1_2.PostRefreshSelfMenpai
  L1_2(L2_3)
  L1_2 = Logic
  L2_3 = L1_2
  L1_2 = L1_2.Get
  L3_4 = "Guide"
  L1_2 = L1_2(L2_3, L3_4)
  L2_3 = L1_2
  L1_2 = L1_2.On
  L3_4 = Logic
  L3_4 = L3_4.Guide
  L3_4 = L3_4.EVT
  L3_4 = L3_4.STEP
  L5_6 = A0_1
  L4_5 = A0_1.Event
  L6_7 = "GUIDE_STEP"
  L7_8 = "updateGuide"
  L13_14 = L4_5(L5_6, L6_7, L7_8)
  L1_2(L2_3, L3_4, L4_5, L5_6, L6_7, L7_8, L8_9, L9_10, L10_11, L11_12, L12_13, L13_14, L4_5(L5_6, L6_7, L7_8))
  L1_2 = A0_1.btnHeroCap
  L2_3 = L1_2
  L1_2 = L1_2.setZoomOnTouchDown
  L3_4 = false
  L1_2(L2_3, L3_4)
  L1_2 = A0_1.btnLeft
  L2_3 = L1_2
  L1_2 = L1_2.setEnabled
  L3_4 = true
  L1_2(L2_3, L3_4)
  L1_2 = A0_1.btnRight
  L2_3 = L1_2
  L1_2 = L1_2.setEnabled
  L3_4 = true
  L1_2(L2_3, L3_4)
  L1_2 = A0_1.layer
  L2_3 = L1_2
  L1_2 = L1_2.setContentSize
  L3_4 = CCSizeMake
  L4_5 = 640
  L5_6 = 960
  L13_14 = L3_4(L4_5, L5_6)
  L1_2(L2_3, L3_4, L4_5, L5_6, L6_7, L7_8, L8_9, L9_10, L10_11, L11_12, L12_13, L13_14, L3_4(L4_5, L5_6))
  L1_2 = A0_1.layer
  L2_3 = L1_2
  L1_2 = L1_2.setTouchEnabled
  L3_4 = true
  L1_2(L2_3, L3_4)
  L1_2 = A0_1.layer
  L2_3 = L1_2
  L1_2 = L1_2.registerScriptTouchHandler
  L3_4 = bind
  L4_5 = A0_1.onArrowTouch
  L5_6 = A0_1
  L3_4 = L3_4(L4_5, L5_6)
  L4_5 = false
  L5_6 = -1000
  L6_7 = true
  L1_2(L2_3, L3_4, L4_5, L5_6, L6_7)
  L1_2 = Logic
  L2_3 = L1_2
  L1_2 = L1_2.Get
  L3_4 = "PlayerInfo"
  L1_2 = L1_2(L2_3, L3_4)
  L2_3 = L1_2
  L1_2 = L1_2.FireEvent
  L3_4 = Logic
  L3_4 = L3_4.PlayerInfo
  L3_4 = L3_4.EVT
  L3_4 = L3_4.CHECK_MAINBTN_STATE
  L4_5 = false
  L1_2(L2_3, L3_4, L4_5)
  L2_3 = A0_1
  L1_2 = A0_1.RefreshHeros
  L1_2(L2_3)
  L1_2 = Logic
  L2_3 = L1_2
  L1_2 = L1_2.Get
  L3_4 = "Hero"
  L1_2 = L1_2(L2_3, L3_4)
  L2_3 = L1_2
  L1_2 = L1_2.On
  L3_4 = Logic
  L3_4 = L3_4.Hero
  L3_4 = L3_4.EVT
  L3_4 = L3_4.ALL_HEROS
  L5_6 = A0_1
  L4_5 = A0_1.Event
  L6_7 = "OnGetAllHeros"
  L13_14 = L4_5(L5_6, L6_7)
  L1_2(L2_3, L3_4, L4_5, L5_6, L6_7, L7_8, L8_9, L9_10, L10_11, L11_12, L12_13, L13_14, L4_5(L5_6, L6_7))
  L1_2 = Logic
  L2_3 = L1_2
  L1_2 = L1_2.Get
  L3_4 = "Email"
  L1_2 = L1_2(L2_3, L3_4)
  L2_3 = L1_2
  L1_2 = L1_2.On
  L3_4 = Logic
  L3_4 = L3_4.Email
  L3_4 = L3_4.EVT
  L3_4 = L3_4.EMAIL_NEWMAIL
  L5_6 = A0_1
  L4_5 = A0_1.Event
  L6_7 = "RunMyEmailAni"
  L13_14 = L4_5(L5_6, L6_7)
  L1_2(L2_3, L3_4, L4_5, L5_6, L6_7, L7_8, L8_9, L9_10, L10_11, L11_12, L12_13, L13_14, L4_5(L5_6, L6_7))
  L1_2 = Logic
  L2_3 = L1_2
  L1_2 = L1_2.Get
  L3_4 = "Achievement"
  L1_2 = L1_2(L2_3, L3_4)
  L2_3 = L1_2
  L1_2 = L1_2.On
  L3_4 = Logic
  L3_4 = L3_4.Achievement
  L3_4 = L3_4.EVT
  L3_4 = L3_4.GET_CHAPTER
  L5_6 = A0_1
  L4_5 = A0_1.Event
  L6_7 = "updateGuide"
  L13_14 = L4_5(L5_6, L6_7)
  L1_2(L2_3, L3_4, L4_5, L5_6, L6_7, L7_8, L8_9, L9_10, L10_11, L11_12, L12_13, L13_14, L4_5(L5_6, L6_7))
  L1_2 = Logic
  L2_3 = L1_2
  L1_2 = L1_2.Get
  L3_4 = "Hero"
  L1_2 = L1_2(L2_3, L3_4)
  L2_3 = L1_2
  L1_2 = L1_2.On
  L3_4 = Logic
  L3_4 = L3_4.Hero
  L3_4 = L3_4.EVT
  L3_4 = L3_4.FIGHT_POINT
  L5_6 = A0_1
  L4_5 = A0_1.Event
  L6_7 = "OnNewScore"
  L13_14 = L4_5(L5_6, L6_7)
  L1_2(L2_3, L3_4, L4_5, L5_6, L6_7, L7_8, L8_9, L9_10, L10_11, L11_12, L12_13, L13_14, L4_5(L5_6, L6_7))
  L1_2 = Logic
  L2_3 = L1_2
  L1_2 = L1_2.Get
  L3_4 = "Hero"
  L1_2 = L1_2(L2_3, L3_4)
  L2_3 = L1_2
  L1_2 = L1_2.On
  L3_4 = Logic
  L3_4 = L3_4.Hero
  L3_4 = L3_4.EVT
  L3_4 = L3_4.ADD_LEADERSHIP
  L5_6 = A0_1
  L4_5 = A0_1.Event
  L6_7 = "OnAddLeadership"
  L13_14 = L4_5(L5_6, L6_7)
  L1_2(L2_3, L3_4, L4_5, L5_6, L6_7, L7_8, L8_9, L9_10, L10_11, L11_12, L12_13, L13_14, L4_5(L5_6, L6_7))
  L1_2 = Logic
  L2_3 = L1_2
  L1_2 = L1_2.Get
  L3_4 = "Hero"
  L1_2 = L1_2(L2_3, L3_4)
  L2_3 = L1_2
  L1_2 = L1_2.On
  L3_4 = Logic
  L3_4 = L3_4.Hero
  L3_4 = L3_4.EVT
  L3_4 = L3_4.HERO_CURRENT
  L5_6 = A0_1
  L4_5 = A0_1.Event
  L6_7 = "onRefreshGroupData"
  L13_14 = L4_5(L5_6, L6_7)
  L1_2(L2_3, L3_4, L4_5, L5_6, L6_7, L7_8, L8_9, L9_10, L10_11, L11_12, L12_13, L13_14, L4_5(L5_6, L6_7))
  L1_2 = Logic
  L2_3 = L1_2
  L1_2 = L1_2.Get
  L3_4 = "Hero"
  L1_2 = L1_2(L2_3, L3_4)
  L2_3 = L1_2
  L1_2 = L1_2.On
  L3_4 = Logic
  L3_4 = L3_4.Hero
  L3_4 = L3_4.EVT
  L3_4 = L3_4.LEADER_CHANGE
  L5_6 = A0_1
  L4_5 = A0_1.Event
  L6_7 = "onRefreshGroupData"
  L13_14 = L4_5(L5_6, L6_7)
  L1_2(L2_3, L3_4, L4_5, L5_6, L6_7, L7_8, L8_9, L9_10, L10_11, L11_12, L12_13, L13_14, L4_5(L5_6, L6_7))
  L1_2 = Logic
  L2_3 = L1_2
  L1_2 = L1_2.Get
  L3_4 = "Hero"
  L1_2 = L1_2(L2_3, L3_4)
  L2_3 = L1_2
  L1_2 = L1_2.On
  L3_4 = Logic
  L3_4 = L3_4.Hero
  L3_4 = L3_4.EVT
  L3_4 = L3_4.EMBATTLE_SET
  L5_6 = A0_1
  L4_5 = A0_1.Event
  L6_7 = "onRefreshGroupData"
  L13_14 = L4_5(L5_6, L6_7)
  L1_2(L2_3, L3_4, L4_5, L5_6, L6_7, L7_8, L8_9, L9_10, L10_11, L11_12, L12_13, L13_14, L4_5(L5_6, L6_7))
  L1_2 = Logic
  L2_3 = L1_2
  L1_2 = L1_2.Get
  L3_4 = "Devil"
  L1_2 = L1_2(L2_3, L3_4)
  L2_3 = L1_2
  L1_2 = L1_2.On
  L3_4 = Logic
  L3_4 = L3_4.Devil
  L3_4 = L3_4.EVT
  L3_4 = L3_4.PUSH_MAIN_INFO
  L5_6 = A0_1
  L4_5 = A0_1.Event
  L6_7 = "OnPushMainInfo"
  L13_14 = L4_5(L5_6, L6_7)
  L1_2(L2_3, L3_4, L4_5, L5_6, L6_7, L7_8, L8_9, L9_10, L10_11, L11_12, L12_13, L13_14, L4_5(L5_6, L6_7))
  L1_2 = Logic
  L2_3 = L1_2
  L1_2 = L1_2.Get
  L3_4 = "Devil"
  L1_2 = L1_2(L2_3, L3_4)
  L2_3 = L1_2
  L1_2 = L1_2.On
  L3_4 = Logic
  L3_4 = L3_4.Devil
  L3_4 = L3_4.EVT
  L3_4 = L3_4.REFRESH_GROUP_DATA
  L5_6 = A0_1
  L4_5 = A0_1.Event
  L6_7 = "onRefreshGroupData"
  L13_14 = L4_5(L5_6, L6_7)
  L1_2(L2_3, L3_4, L4_5, L5_6, L6_7, L7_8, L8_9, L9_10, L10_11, L11_12, L12_13, L13_14, L4_5(L5_6, L6_7))
  L1_2 = Logic
  L2_3 = L1_2
  L1_2 = L1_2.Get
  L3_4 = "Hero"
  L1_2 = L1_2(L2_3, L3_4)
  L2_3 = L1_2
  L1_2 = L1_2.On
  L3_4 = Logic
  L3_4 = L3_4.Hero
  L3_4 = L3_4.EVT
  L3_4 = L3_4.SWITCH_HERO_GROUP
  L5_6 = A0_1
  L4_5 = A0_1.Event
  L6_7 = "onSwitchGroup"
  L13_14 = L4_5(L5_6, L6_7)
  L1_2(L2_3, L3_4, L4_5, L5_6, L6_7, L7_8, L8_9, L9_10, L10_11, L11_12, L12_13, L13_14, L4_5(L5_6, L6_7))
  L1_2 = Logic
  L2_3 = L1_2
  L1_2 = L1_2.Get
  L3_4 = "Lineup"
  L1_2 = L1_2(L2_3, L3_4)
  L2_3 = L1_2
  L1_2 = L1_2.On
  L3_4 = Logic
  L3_4 = L3_4.Lineup
  L3_4 = L3_4.EVT
  L3_4 = L3_4.USE_TEAM
  L5_6 = A0_1
  L4_5 = A0_1.Event
  L6_7 = "onUseTeam"
  L13_14 = L4_5(L5_6, L6_7)
  L1_2(L2_3, L3_4, L4_5, L5_6, L6_7, L7_8, L8_9, L9_10, L10_11, L11_12, L12_13, L13_14, L4_5(L5_6, L6_7))
  L1_2 = Logic
  L2_3 = L1_2
  L1_2 = L1_2.Get
  L3_4 = "Hero"
  L1_2 = L1_2(L2_3, L3_4)
  L2_3 = L1_2
  L1_2 = L1_2.PostGetFightPoint
  L1_2(L2_3)
  A0_1.btnStop = false
  L1_2 = Logic
  L2_3 = L1_2
  L1_2 = L1_2.Get
  L3_4 = "GameSetting"
  L1_2 = L1_2(L2_3, L3_4)
  L2_3 = L1_2
  L1_2 = L1_2.IsOpenVision
  L1_2 = L1_2(L2_3)
  if L1_2 then
    L1_2 = Logic
    L2_3 = L1_2
    L1_2 = L1_2.Get
    L3_4 = "GameSetting"
    L1_2 = L1_2(L2_3, L3_4)
    L2_3 = L1_2
    L1_2 = L1_2.SetOpenVision
    L3_4 = false
    L1_2(L2_3, L3_4)
    L1_2 = A0_1.animationMgr
    L2_3 = L1_2
    L1_2 = L1_2.runAnimations
    L3_4 = "allTimeLine"
    L1_2(L2_3, L3_4)
  else
    A0_1.btnStop = true
    L2_3 = A0_1
    L1_2 = A0_1.RunMyEmailAni
    L1_2(L2_3)
  end
  L1_2 = Logic
  L2_3 = L1_2
  L1_2 = L1_2.Get
  L3_4 = "Home"
  L1_2 = L1_2(L2_3, L3_4)
  L2_3 = L1_2
  L1_2 = L1_2.GetBtnItem
  L1_2 = L1_2(L2_3)
  L2_3 = #L1_2
  if L2_3 == 0 then
    L2_3 = {}
    A0_1.btnArr = L2_3
  else
    A0_1.btnArr = L1_2
  end
  L2_3 = A0_1.btnArr
  L2_3 = #L2_3
  A0_1.page = L2_3
  L2_3 = TableViewEx
  L2_3 = L2_3.prototype
  L3_4 = L2_3
  L2_3 = L2_3.createList
  L4_5 = A0_1
  L5_6 = A0_1.m_pCList
  L6_7 = A0_1.page
  L2_3 = L2_3(L3_4, L4_5, L5_6, L6_7)
  A0_1.tableViewControl = L2_3
  L2_3 = A0_1.tableViewControl
  L2_3 = L2_3.tableView
  L3_4 = L2_3
  L2_3 = L2_3.runUIAnimat
  L2_3(L3_4)
  L2_3 = A0_1.tableViewControl
  L2_3 = L2_3.tableView
  L3_4 = L2_3
  L2_3 = L2_3.setDirection
  L4_5 = kCCScrollViewDirectionHorizontal
  L2_3(L3_4, L4_5)
  L2_3 = A0_1.m_pCList
  L3_4 = L2_3
  L2_3 = L2_3.addChild
  L4_5 = A0_1.tableViewControl
  L4_5 = L4_5.tableView
  L2_3(L3_4, L4_5)
  L2_3 = Logic
  L3_4 = L2_3
  L2_3 = L2_3.Get
  L4_5 = "Achievement"
  L2_3 = L2_3(L3_4, L4_5)
  L3_4 = L2_3
  L2_3 = L2_3.GetAchievePro
  L2_3 = L2_3(L3_4)
  L3_4 = Logic
  L4_5 = L3_4
  L3_4 = L3_4.Get
  L5_6 = "Home"
  L3_4 = L3_4(L4_5, L5_6)
  L4_5 = L3_4
  L3_4 = L3_4.GetLvLView
  L3_4 = L3_4(L4_5)
  L5_6 = A0_1
  L4_5 = A0_1.IsGuideAtHome
  L6_7 = L4_5(L5_6)
  if L2_3 or L4_5 then
    L7_8 = Logic
    L8_9 = L7_8
    L7_8 = L7_8.Get
    L9_10 = "Lock"
    L7_8 = L7_8(L8_9, L9_10)
    L8_9 = L7_8
    L7_8 = L7_8.GetStatusByLockId
    L9_10 = Logic
    L9_10 = L9_10.Lock
    L9_10 = L9_10.LOCK_ID
    L9_10 = L9_10.ACHIEVEMENT
    L7_8 = L7_8(L8_9, L9_10)
    if L4_5 and L5_6 ~= nil and L6_7 ~= nil then
      L8_9 = A0_1.tableViewControl
      L9_10 = L8_9
      L8_9 = L8_9.TurnPageTo
      L10_11 = L5_6
      L11_12 = true
      L12_13 = true
      L8_9(L9_10, L10_11, L11_12, L12_13)
    elseif L2_3 and not L7_8 then
      L8_9 = Logic
      L9_10 = L8_9
      L8_9 = L8_9.Get
      L10_11 = "Home"
      L8_9 = L8_9(L9_10, L10_11)
      L9_10 = L8_9
      L8_9 = L8_9.GetBtnPos
      L10_11 = "btnAchievement"
      L10_11 = L8_9(L9_10, L10_11)
      L11_12 = A0_1.tableViewControl
      L12_13 = L11_12
      L11_12 = L11_12.TurnPageTo
      L13_14 = L8_9
      L11_12(L12_13, L13_14, true, true)
    end
  end
  L7_8 = Logic
  L8_9 = L7_8
  L7_8 = L7_8.Get
  L9_10 = "Lock"
  L7_8 = L7_8(L8_9, L9_10)
  L8_9 = L7_8
  L7_8 = L7_8.GetStatusByLockId
  L9_10 = Logic
  L9_10 = L9_10.Lock
  L9_10 = L9_10.LOCK_ID
  L9_10 = L9_10.FOURTH_HERO
  L7_8 = L7_8(L8_9, L9_10)
  A0_1.fourthStatus = L7_8
  L8_9 = A0_1
  L7_8 = A0_1.onLockFourthHero
  L9_10 = A0_1.fourthStatus
  L7_8(L8_9, L9_10)
  L7_8 = Logic
  L8_9 = L7_8
  L7_8 = L7_8.Get
  L9_10 = "Lock"
  L7_8 = L7_8(L8_9, L9_10)
  L8_9 = L7_8
  L7_8 = L7_8.GetStatusByLockId
  L9_10 = Logic
  L9_10 = L9_10.Lock
  L9_10 = L9_10.LOCK_ID
  L9_10 = L9_10.FIFTH_HERO
  L7_8 = L7_8(L8_9, L9_10)
  A0_1.fifthStatus = L7_8
  L8_9 = A0_1
  L7_8 = A0_1.onLockFifthHero
  L9_10 = A0_1.fifthStatus
  L7_8(L8_9, L9_10)
  L7_8 = Logic
  L8_9 = L7_8
  L7_8 = L7_8.Get
  L9_10 = "Lock"
  L7_8 = L7_8(L8_9, L9_10)
  L8_9 = L7_8
  L7_8 = L7_8.GetStatusByLockId
  L9_10 = Logic
  L9_10 = L9_10.Lock
  L9_10 = L9_10.LOCK_ID
  L9_10 = L9_10.FIRST_HERO_GROUP
  L7_8 = L7_8(L8_9, L9_10)
  A0_1.groupStatus = L7_8
  L8_9 = A0_1
  L7_8 = A0_1.onLockHeroGroup
  L9_10 = A0_1.groupStatus
  L7_8(L8_9, L9_10)
  A0_1.aniDemog = nil
end
function prototype.cellSizeForTable(A0_15, ...)
  return CCSizeMake(640, 330)
end
function prototype.tableCellAtIndex(A0_17, A1_18, A2_19, A3_20, A4_21)
  local L5_22
  A0_17.curPage = A4_21
  if not A3_20 then
    L5_22 = CCTableViewCellEx
    L5_22 = L5_22.create
    L5_22 = L5_22(L5_22)
    A3_20 = L5_22
    L5_22 = Tw
    L5_22 = L5_22.Controller
    L5_22 = L5_22.load
    L5_22 = L5_22(L5_22, "HomeItem", A0_17.rootNode)
    L5_22:RefreshItem(A0_17.btnArr[A4_21], A4_21)
    A3_20:addChild(L5_22, 0, 2)
  else
    L5_22 = A3_20.getChildByTag
    L5_22 = L5_22(A3_20, 2)
    L5_22 = L5_22.RefreshItem
    L5_22(L5_22, A0_17.btnArr[A4_21], A4_21)
  end
  return A3_20
end
function prototype.numberOfCellsInTableView(A0_23, A1_24)
  A0_23.curPage = A1_24
  if A0_23.curPage == 1 then
    A0_23.btnLeft:setVisible(false)
    A0_23.btnRight:setVisible(true)
  else
    A0_23.btnLeft:setVisible(true)
    A0_23.btnRight:setVisible(false)
  end
  return 1
end
function prototype.tableCellTouched(A0_25, A1_26, A2_27)
end
function prototype.tablePageTurn(A0_28, A1_29)
  A0_28.tableViewControl:RequireUpdate()
end
function prototype.actionFinish(A0_30, A1_31)
  A0_30.opening = nil
  A0_30:updateGuide()
  A0_30.btnStop = true
  Logic:Get("Main"):FireEvent(Logic.Main.EVT.SHOW_NEW_TIP)
  if 1 == nil then
    return
  end
  if A1_31:cellAtIndex(1 - 1) == nil then
    return
  end
  if A1_31:cellAtIndex(1 - 1):getChildByTag(2) == nil then
    return
  end
  A1_31:cellAtIndex(1 - 1):getChildByTag(2):NewTip(A0_30.curPage)
  if not Logic:Get("Guide"):isGuiding() then
    return
  end
  A0_30:LockTableViewByGuide()
  A1_31:cellAtIndex(1 - 1):getChildByTag(2):updateGuide()
end
function prototype.onBtnTab(A0_32, A1_33, A2_34)
  local L3_35, L4_36, L5_37, L6_38, L7_39
  L3_35 = Logic
  L4_36 = L3_35
  L3_35 = L3_35.Get
  L5_37 = "Guide"
  L3_35 = L3_35(L4_36, L5_37)
  L4_36 = L3_35
  L3_35 = L3_35.done
  L5_37 = "Reinforc"
  L6_38 = "Start"
  L3_35(L4_36, L5_37, L6_38)
  L3_35 = A0_32.groupStatus
  if L3_35 then
    L3_35 = CCControlEventTouchDown
    if A2_34 == L3_35 then
      L3_35 = Logic
      L4_36 = L3_35
      L3_35 = L3_35.Get
      L5_37 = "Lock"
      L3_35 = L3_35(L4_36, L5_37)
      L4_36 = L3_35
      L3_35 = L3_35.GetOpenLevelAndBattle
      L5_37 = Logic
      L5_37 = L5_37.Lock
      L5_37 = L5_37.LOCK_ID
      L5_37 = L5_37.FIRST_HERO_GROUP
      L4_36 = L3_35(L4_36, L5_37)
      L6_38 = A0_32
      L5_37 = A0_32.showLockTip
      L7_39 = L3_35
      L5_37(L6_38, L7_39, L4_36)
    end
    L4_36 = A0_32
    L3_35 = A0_32.closeLockTip
    L5_37 = A2_34
    L3_35(L4_36, L5_37)
    return
  end
  L3_35 = CCControlEventTouchUpInside
  if A2_34 == L3_35 then
    L3_35 = SceneHelper
    L4_36 = L3_35
    L3_35 = L3_35.pushScene
    L5_37 = "DevilGroup"
    L6_38 = A0_32.rootNode
    L3_35(L4_36, L5_37, L6_38)
  end
end
function prototype.RefreshHeros(A0_40)
  local L1_41, L2_42, L3_43, L4_44, L5_45, L6_46, L7_47, L8_48, L9_49, L10_50, L11_51, L12_52, L13_53, L14_54, L15_55, L16_56
  L1_41 = A0_40.staLeaderLevel
  L2_42 = L1_41
  L1_41 = L1_41.create
  L1_41(L2_42)
  L1_41 = A0_40.staLeadership
  L2_42 = L1_41
  L1_41 = L1_41.create
  L1_41(L2_42)
  L1_41 = A0_40.staFight
  L2_42 = L1_41
  L1_41 = L1_41.create
  L1_41(L2_42)
  L1_41 = Logic
  L2_42 = L1_41
  L1_41 = L1_41.Get
  L3_43 = "Hero"
  L1_41 = L1_41(L2_42, L3_43)
  L2_42 = L1_41
  L1_41 = L1_41.GetAllHeroInfo
  L1_41 = L1_41(L2_42)
  L2_42 = Logic
  L3_43 = L2_42
  L2_42 = L2_42.Get
  L4_44 = "Hero"
  L2_42 = L2_42(L3_43, L4_44)
  L3_43 = L2_42
  L2_42 = L2_42.GetLeaderId
  L2_42 = L2_42(L3_43)
  L3_43 = L1_41.heros
  L3_43 = L3_43[L2_42]
  if L3_43 then
    L3_43 = L1_41.heros
    L3_43 = L3_43[L2_42]
    L4_44 = Logic
    L4_44 = L4_44.Get
    L4_44 = L4_44(L5_45, L6_46)
    L4_44 = L4_44.GetHeroImage
    L4_44 = L4_44(L5_45, L6_46)
    if L4_44 then
      L9_49 = L4_44
      L5_45(L6_46, L7_47, L8_48)
      L9_49 = L4_44
      L5_45(L6_46, L7_47, L8_48)
      L5_45(L6_46, L7_47, L8_48)
      L5_45(L6_46, L7_47)
    end
    L9_49 = true
    if L5_45 then
      if L6_46 then
        L10_50 = L6_46
        L9_49 = L6_46.displayFrame
        L16_56 = L9_49(L10_50)
        L7_47(L8_48, L9_49, L10_50, L11_51, L12_52, L13_53, L14_54, L15_55, L16_56, L9_49(L10_50))
      end
    end
    L9_49 = L3_43.baseId
    L6_46(L7_47, L8_48, L9_49)
  end
  L3_43 = Logic
  L4_44 = L3_43
  L3_43 = L3_43.Get
  L3_43 = L3_43(L4_44, L5_45)
  L4_44 = L3_43
  L3_43 = L3_43.GetBattlingHero
  L3_43 = L3_43(L4_44)
  L4_44 = {}
  for L8_48 = 1, #L3_43 do
    L9_49 = L3_43[L8_48]
    if L9_49 ~= L2_42 then
      L9_49 = table
      L9_49 = L9_49.insert
      L10_50 = L4_44
      L11_51 = L3_43[L8_48]
      L9_49(L10_50, L11_51)
    end
  end
  if L6_46 then
  elseif L6_46 then
  else
  end
  for L9_49 = 1, L5_45 do
    L10_50 = string
    L10_50 = L10_50.format
    L11_51 = "btnHero%d"
    L12_52 = L9_49
    L10_50 = L10_50(L11_51, L12_52)
    L11_51 = string
    L11_51 = L11_51.format
    L12_52 = "staHero%dLevel"
    L13_53 = L9_49
    L11_51 = L11_51(L12_52, L13_53)
    L12_52 = string
    L12_52 = L12_52.format
    L13_53 = "imgTeamer%d"
    L14_54 = L9_49
    L12_52 = L12_52(L13_53, L14_54)
    L13_53 = string
    L13_53 = L13_53.format
    L14_54 = "imgHero%dtip"
    L15_55 = L9_49
    L13_53 = L13_53(L14_54, L15_55)
    L14_54 = string
    L14_54 = L14_54.format
    L15_55 = "imgAdd%d"
    L16_56 = L9_49
    L14_54 = L14_54(L15_55, L16_56)
    L15_55 = A0_40[L10_50]
    L16_56 = L15_55
    L15_55 = L15_55.setZoomOnTouchDown
    L15_55(L16_56, false)
    L15_55 = Logic
    L16_56 = L15_55
    L15_55 = L15_55.Get
    L15_55 = L15_55(L16_56, "HeroCardInfo")
    L16_56 = L15_55
    L15_55 = L15_55.ClearShanCardSmall
    L15_55(L16_56, A0_40[L10_50])
    L15_55 = L4_44[L9_49]
    if L15_55 then
      L15_55 = A0_40[L11_51]
      L16_56 = L15_55
      L15_55 = L15_55.create
      L15_55(L16_56)
      L15_55 = A0_40[L11_51]
      L16_56 = L15_55
      L15_55 = L15_55.setVisible
      L15_55(L16_56, true)
      L15_55 = A0_40[L13_53]
      L16_56 = L15_55
      L15_55 = L15_55.setVisible
      L15_55(L16_56, true)
      L15_55 = A0_40[L14_54]
      L16_56 = L15_55
      L15_55 = L15_55.setVisible
      L15_55(L16_56, false)
      L15_55 = Logic
      L16_56 = L15_55
      L15_55 = L15_55.Get
      L15_55 = L15_55(L16_56, "Hero")
      L16_56 = L15_55
      L15_55 = L15_55.GetHeroImage
      L15_55 = L15_55(L16_56, L1_41.heros[L4_44[L9_49]].baseId)
      if L15_55 then
        L16_56 = A0_40[L10_50]
        L16_56 = L16_56.setBackgroundSpriteForState
        L16_56(L16_56, CCScale9Sprite:create(L15_55), CCControlStateNormal)
        L16_56 = A0_40[L10_50]
        L16_56 = L16_56.setBackgroundSpriteForState
        L16_56(L16_56, CCScale9Sprite:create(L15_55), CCControlStateHighlighted)
        L16_56 = A0_40[L11_51]
        L16_56 = L16_56.setAlign
        L16_56(L16_56, "LEFT", "CENTER")
        L16_56 = A0_40[L11_51]
        L16_56 = L16_56.setValue
        L16_56(L16_56, L1_41.heros[L4_44[L9_49]].level or 1)
      end
      L16_56 = Logic
      L16_56 = L16_56.Get
      L16_56 = L16_56(L16_56, "HeroCardInfo")
      L16_56 = L16_56.AddShanCardSmall
      L16_56(L16_56, A0_40[L10_50], L1_41.heros[L4_44[L9_49]].baseId)
      L16_56 = Logic
      L16_56 = L16_56.Get
      L16_56 = L16_56(L16_56, "Hero")
      L16_56 = L16_56.GetHeroBgImage
      L16_56 = L16_56(L16_56, L1_41.heros[L4_44[L9_49]].baseId)
      if L16_56 and CCSprite:create(L16_56) then
        A0_40[L12_52]:setDisplayFrame(CCSprite:create(L16_56):displayFrame())
      end
    else
      L15_55 = A0_40[L11_51]
      L16_56 = L15_55
      L15_55 = L15_55.setVisible
      L15_55(L16_56, false)
      L15_55 = A0_40[L13_53]
      L16_56 = L15_55
      L15_55 = L15_55.setVisible
      L15_55(L16_56, false)
      L15_55 = A0_40[L14_54]
      L16_56 = L15_55
      L15_55 = L15_55.setVisible
      L15_55(L16_56, true)
      L15_55 = "images/public/clarity05.png"
      if L15_55 then
        L16_56 = A0_40[L10_50]
        L16_56 = L16_56.setBackgroundSpriteForState
        L16_56(L16_56, CCScale9Sprite:create(L15_55), CCControlStateNormal)
        L16_56 = A0_40[L10_50]
        L16_56 = L16_56.setBackgroundSpriteForState
        L16_56(L16_56, CCScale9Sprite:create(L15_55), CCControlStateHighlighted)
      end
      L16_56 = "data/MiddleBg/1.png"
      if L16_56 and CCSprite:create(L16_56) then
        A0_40[L12_52]:setDisplayFrame(CCSprite:create(L16_56):displayFrame())
      end
    end
  end
  L9_49 = "Hero"
  if L7_47 and L6_46 then
    L9_49 = L8_48
    L10_50 = string
    L10_50 = L10_50.format
    L11_51 = "%d/%d"
    L12_52 = L6_46
    L13_53 = L7_47
    L16_56 = L10_50(L11_51, L12_52, L13_53)
    L8_48(L9_49, L10_50, L11_51, L12_52, L13_53, L14_54, L15_55, L16_56, L10_50(L11_51, L12_52, L13_53))
    L9_49 = L8_48
    L10_50 = "CENTER"
    L11_51 = "CENTER"
    L8_48(L9_49, L10_50, L11_51)
  end
  L9_49 = L8_48
  L10_50 = "Hero"
  L9_49 = L8_48
  L9_49 = A0_40.staFight
  L10_50 = L9_49
  L9_49 = L9_49.setValue
  L11_51 = L8_48[2]
  L11_51 = L11_51 or 0
  L9_49(L10_50, L11_51)
  L9_49 = A0_40.staFight
  L10_50 = L9_49
  L9_49 = L9_49.setAlign
  L11_51 = "CENTER"
  L12_52 = "CENTER"
  L9_49(L10_50, L11_51, L12_52)
end
function prototype.OnGetAllHeros(A0_57)
  A0_57:RefreshHeros()
end
function prototype.onRefreshGroupData(A0_58)
  A0_58:RefreshHeros()
  Logic:Get("Hero"):PostGetFightPoint()
end
function prototype.onSwitchGroup(A0_59)
  A0_59:RefreshHeros()
  Logic:Get("Hero"):PostGetFightPoint()
end
function prototype.onUseTeam(A0_60)
  A0_60:RefreshHeros()
  Logic:Get("Hero"):PostGetFightPoint()
end
function prototype.OnNewScore(A0_61, A1_62)
  if A1_62 then
    A0_61.staFight:setValue(A1_62[2] or 0)
  end
end
function prototype.OnAddLeadership(A0_63)
  local L1_64, L2_65
  L1_64 = _UPVALUE0_
  L1_64 = L1_64()
  L2_65 = Logic
  L2_65 = L2_65.Get
  L2_65 = L2_65(L2_65, "Hero")
  L2_65 = L2_65.GetLeadership
  L2_65 = L2_65(L2_65)
  if L1_64 and L2_65 then
    A0_63.staLeadership:setValue(string.format("%d/%d", L1_64, L2_65))
  end
end
function prototype.onBtnSelectLeader(A0_66, A1_67, A2_68)
  SceneHelper:runWithScene("HeroLeaderSelect", A0_66.rootNode)
  Logic:Get("PlayerInfo"):FireEvent(Logic.PlayerInfo.EVT.CHECK_MAINBTN_STATE, false)
end
function prototype.onBtnSelectTeamer(A0_69, A1_70, A2_71)
  local L3_72, L4_73, L5_74, L6_75, L7_76
  L3_72 = Logic
  L4_73 = L3_72
  L3_72 = L3_72.Get
  L5_74 = "Guide"
  L3_72 = L3_72(L4_73, L5_74)
  L4_73 = L3_72
  L3_72 = L3_72.done
  L5_74 = "Team"
  L6_75 = "Start"
  L3_72(L4_73, L5_74, L6_75)
  L3_72 = A0_69.btnHero3
  if A1_70 == L3_72 then
    L3_72 = A0_69.fourthStatus
    if L3_72 then
      L3_72 = CCControlEventTouchDown
      if A2_71 == L3_72 then
        L3_72 = Logic
        L4_73 = L3_72
        L3_72 = L3_72.Get
        L5_74 = "Lock"
        L3_72 = L3_72(L4_73, L5_74)
        L4_73 = L3_72
        L3_72 = L3_72.GetOpenLevelAndBattle
        L5_74 = Logic
        L5_74 = L5_74.Lock
        L5_74 = L5_74.LOCK_ID
        L5_74 = L5_74.FOURTH_HERO
        L4_73 = L3_72(L4_73, L5_74)
        L6_75 = A0_69
        L5_74 = A0_69.showLockTip
        L7_76 = L3_72
        L5_74(L6_75, L7_76, L4_73)
      end
      L4_73 = A0_69
      L3_72 = A0_69.closeLockTip
      L5_74 = A2_71
      L3_72(L4_73, L5_74)
      return
    end
  end
  L3_72 = A0_69.btnHero4
  if A1_70 == L3_72 then
    L3_72 = A0_69.fifthStatus
    if L3_72 then
      L3_72 = CCControlEventTouchDown
      if A2_71 == L3_72 then
        L3_72 = Logic
        L4_73 = L3_72
        L3_72 = L3_72.Get
        L5_74 = "Lock"
        L3_72 = L3_72(L4_73, L5_74)
        L4_73 = L3_72
        L3_72 = L3_72.GetOpenLevelAndBattle
        L5_74 = Logic
        L5_74 = L5_74.Lock
        L5_74 = L5_74.LOCK_ID
        L5_74 = L5_74.FIFTH_HERO
        L4_73 = L3_72(L4_73, L5_74)
        L5_74 = TwGetStr
        L6_75 = 105403
        L7_76 = L3_72
        L5_74 = L5_74(L6_75, L7_76)
        L6_75 = "\n"
        L7_76 = TwGetStr
        L7_76 = L7_76(105404)
        L5_74 = L5_74 .. L6_75 .. L7_76
        L6_75 = Prompt
        L7_76 = L6_75
        L6_75 = L6_75.PopTip
        L6_75(L7_76, L5_74)
      end
      L4_73 = A0_69
      L3_72 = A0_69.closeLockTip
      L5_74 = A2_71
      L3_72(L4_73, L5_74)
      return
    end
  end
  L3_72 = CCControlEventTouchUpInside
  if A2_71 == L3_72 then
    L3_72 = SceneHelper
    L4_73 = L3_72
    L3_72 = L3_72.runWithScene
    L5_74 = "HeroTeamerSelect"
    L6_75 = A0_69.rootNode
    L3_72(L4_73, L5_74, L6_75)
    L3_72 = Logic
    L4_73 = L3_72
    L3_72 = L3_72.Get
    L5_74 = "PlayerInfo"
    L3_72 = L3_72(L4_73, L5_74)
    L4_73 = L3_72
    L3_72 = L3_72.FireEvent
    L5_74 = Logic
    L5_74 = L5_74.PlayerInfo
    L5_74 = L5_74.EVT
    L5_74 = L5_74.CHECK_MAINBTN_STATE
    L6_75 = false
    L3_72(L4_73, L5_74, L6_75)
  end
end
function prototype.bindAnimationMgr(A0_77)
  local L1_78
  L1_78 = true
  return L1_78
end
function prototype.completedAnimationSequenceNamed(A0_79, A1_80)
  if A1_80 ~= "allTimeLine" and A1_80 ~= "btnTimeLine" then
    return
  end
  A0_79.opening = nil
  Logic:Get("Main"):FireEvent(Logic.Main.EVT.SHOW_NEW_TIP)
  A0_79:RunMyEmailAni()
  A0_79:updateGuide()
end
function prototype.RunMyEmailAni(A0_81)
  local L1_82, L2_83, L3_84
  L1_82 = Logic
  L2_83 = L1_82
  L1_82 = L1_82.Get
  L3_84 = "Email"
  L1_82 = L1_82(L2_83, L3_84)
  L2_83 = L1_82
  L1_82 = L1_82.GetNewMailPro
  L1_82 = L1_82(L2_83)
  if L1_82 == true then
    L1_82 = A0_81.btnStop
    if L1_82 then
      L1_82 = A0_81.imgEmail
      L2_83 = L1_82
      L1_82 = L1_82.setVisible
      L3_84 = true
      L1_82(L2_83, L3_84)
      L1_82 = A0_81.imgEmail
      L2_83 = L1_82
      L1_82 = L1_82.setAnchorPoint
      L3_84 = CCPoint
      L3_84 = L3_84(0.5, 0.5)
      L1_82(L2_83, L3_84, L3_84(0.5, 0.5))
      L1_82 = A0_81.imgEmail
      L2_83 = L1_82
      L1_82 = L1_82.getPositionX
      L1_82 = L1_82(L2_83)
      L1_82 = L1_82 + 30
      L2_83 = A0_81.imgEmail
      L3_84 = L2_83
      L2_83 = L2_83.getPositionY
      L2_83 = L2_83(L3_84)
      L2_83 = L2_83 + 30
      L3_84 = Logic
      L3_84 = L3_84.Get
      L3_84 = L3_84(L3_84, "AniMgr")
      L3_84 = L3_84.RunCCBAni
      L3_84 = L3_84(L3_84, "UI/uinew", A0_81, ccp(L1_82, L2_83), 0.7)
      A0_81.aniMail = L3_84
      L3_84 = CCSprite
      L3_84 = L3_84.create
      L3_84 = L3_84(L3_84, "images/public/tip.png")
      if L3_84 ~= nil then
        A0_81.rootNode:addChild(L3_84, 0, 11)
        L3_84:setAnchorPoint(CCPoint(0.5, 0.5))
        L3_84:setPosition(ccp(L1_82, L2_83))
        L3_84:setScale(0.8)
      end
    end
  else
    L1_82 = A0_81.aniMail
    if L1_82 then
      L1_82 = A0_81.aniMail
      L2_83 = L1_82
      L1_82 = L1_82.RemoveAnimation
      L1_82(L2_83)
      A0_81.aniMail = nil
    end
  end
end
function prototype.onBtnEmail(A0_85, A1_86, A2_87)
  Logic:Get("Main"):CuMengMain("onBtnEmail")
  SceneHelper:runWithScene("Email", A0_85.rootNode)
  Logic:Get("PlayerInfo"):FireEvent(Logic.PlayerInfo.EVT.CHECK_MAINBTN_STATE, false)
end
function prototype.onLockFourthHero(A0_88, A1_89)
  if A1_89 then
    A0_88:addLock(A0_88.btnHero3, 99, _UPVALUE0_)
  else
    A0_88:removeLock(A0_88.btnHero3, 99)
  end
  if #Logic:Get("Hero"):GetBattlingHero() >= 4 then
    A0_88.imgAdd3:setVisible(false)
  else
    A0_88.imgAdd3:setVisible(not A1_89)
  end
end
function prototype.onLockFifthHero(A0_90, A1_91)
  if A1_91 then
    A0_90:addLock(A0_90.btnHero4, 97, _UPVALUE0_)
  else
    A0_90:removeLock(A0_90.btnHero4, 97)
  end
  if #Logic:Get("Hero"):GetBattlingHero() >= 5 then
    A0_90.imgAdd4:setVisible(false)
  else
    A0_90.imgAdd4:setVisible(not A1_91)
  end
end
function prototype.onLockHeroGroup(A0_92, A1_93)
  local L2_94
  if A1_93 then
    L2_94 = CCSprite:create(_UPVALUE0_.lock)
  else
    L2_94 = CCSprite:create(_UPVALUE0_.normal)
  end
  if nil == L2_94 then
    return
  end
  A0_92.sprGroup:setDisplayFrame(L2_94:displayFrame())
end
function prototype.showLockTip(A0_95, A1_96, A2_97)
  local L3_98
  if nil ~= A2_97 and "" ~= A2_97 then
    L3_98 = TwGetStr
    L3_98 = L3_98(105403, A1_96)
    L3_98 = L3_98 .. "\n" .. TwGetStr(105401, A2_97)
    Prompt:PopTip(L3_98)
  else
    L3_98 = Prompt
    L3_98 = L3_98.PopTip
    L3_98(L3_98, TwGetStr(105402, A1_96))
  end
end
function prototype.closeLockTip(A0_99, A1_100)
  if A1_100 == CCControlEventTouchUpOutside or A1_100 == CCControlEventTouchUpInside or A1_100 == CCControlEventTouchCancel then
    Logic:Get("SureConfirm"):FireEvent(Logic.SureConfirm.EVT.CLOSE_POPTIP)
  end
end
function prototype.addLock(A0_101, A1_102, A2_103, A3_104)
  local L4_105, L5_106, L6_107, L7_108
  if A1_102 and A2_103 then
    L5_106 = A1_102
    L4_105 = A1_102.getChildByTag
    L6_107 = A2_103
    L4_105 = L4_105(L5_106, L6_107)
    if L4_105 ~= nil then
      return
    end
    if A3_104 then
      L5_106 = CCSprite
      L6_107 = L5_106
      L5_106 = L5_106.create
      L7_108 = A3_104
      L5_106 = L5_106(L6_107, L7_108)
    elseif not L5_106 then
      L5_106 = CCSprite
      L6_107 = L5_106
      L5_106 = L5_106.create
      L7_108 = _UPVALUE0_
      L5_106 = L5_106(L6_107, L7_108)
    end
    if nil == L5_106 then
      return
    end
    L7_108 = L5_106
    L6_107 = L5_106.setAnchorPoint
    L6_107(L7_108, CCPoint(0.5, 0.5))
    L7_108 = A1_102
    L6_107 = A1_102.getContentSize
    L6_107 = L6_107(L7_108)
    L6_107 = L6_107.width
    L6_107 = L6_107 / 2
    L7_108 = A1_102.getContentSize
    L7_108 = L7_108(A1_102)
    L7_108 = L7_108.height
    L7_108 = L7_108 / 2
    L5_106:setPosition(ccp(L6_107, L7_108))
    A1_102:addChild(L5_106, 10, A2_103)
  end
end
function prototype.removeLock(A0_109, A1_110, A2_111)
  if A1_110 and A2_111 and A1_110:getChildByTag(A2_111) ~= nil then
    A1_110:removeChildByTag(A2_111, true)
  end
end
function prototype.updateGuide(A0_112)
  if A0_112.opening or not Logic:Get("Guide"):isGuiding() then
    return
  end
  Logic:Get("Guide"):lockTouch("Team", "Start", A0_112.btnHero3)
  Logic:Get("Guide"):lockTouch("Reinforc", "Start", A0_112.btnTab)
end
function prototype.OnPushMainInfo(A0_113)
  SceneHelper:runWithScene("DevilMain", A0_113.rootNode)
end
function prototype.onBtnLeft(A0_114)
  print("AXY_HOME_ARROW_LEFT")
  A0_114.tableViewControl:TurnPage(-1)
end
function prototype.onBtnRight(A0_115)
  print("AXY_HOME_ARROW_RIGHT")
  A0_115.tableViewControl:TurnPage(1)
end
function prototype.onArrowTouch(A0_116, A1_117, A2_118, A3_119)
  if type(A2_118) == "number" then
    A2_118 = {A2_118, A3_119}
  end
  if type(A2_118) ~= "table" then
    return false
  end
  print("AXY_HOME_TOUCH", A1_117, A2_118[1], A2_118[2])
  if A1_117 == CCTOUCHBEGAN then
    if A2_118[2] >= 220 and A2_118[2] <= 390 and (A2_118[1] > 600 or A2_118[1] < 40) then
      A0_116.arrowTouchStart = A2_118
      return true
    end
  elseif A1_117 == CCTOUCHENDED and A0_116.arrowTouchStart ~= nil then
    A0_116.arrowTouchStart = nil
    if math.abs(A0_116.arrowTouchStart[1] - A2_118[1]) > 20 or math.abs(A0_116.arrowTouchStart[2] - A2_118[2]) > 20 or A2_118[2] < 220 or A2_118[2] > 390 then
      return
    end
    if A2_118[1] > 600 and A0_116.btnRight:isVisible() then
      A0_116:onBtnRight()
    elseif A2_118[1] < 40 and A0_116.btnLeft:isVisible() then
      A0_116:onBtnLeft()
    end
    return true
  end
  return false
end
function prototype.LockTableViewByGuide(A0_120)
  if Logic:Get("Guide"):isActive("Achievement", "Start") then
    A0_120.tableViewControl.tableView:setTouchEnabled(false)
  end
  if Logic:Get("Guide"):isActive("Activity", "Start") then
    A0_120.tableViewControl.tableView:setTouchEnabled(false)
  end
  if Logic:Get("Guide"):isActive("Treasure", "Start") then
    A0_120.tableViewControl.tableView:setTouchEnabled(false)
  end
  if Logic:Get("Guide"):isActive("Talisman", "Start") then
    A0_120.tableViewControl.tableView:setTouchEnabled(false)
  end
  if Logic:Get("Guide"):isActive("EquipEquip", "Start") then
    A0_120.tableViewControl.tableView:setTouchEnabled(false)
  end
  if Logic:Get("Guide"):isActive("EquipFetterOne", "Start") then
    A0_120.tableViewControl.tableView:setTouchEnabled(false)
  end
end
function prototype.IsGuideAtHome(A0_121)
  local L1_122, L2_123, L3_124, L4_125
  L1_122 = Logic
  L2_123 = L1_122
  L1_122 = L1_122.Get
  L3_124 = "Guide"
  L1_122 = L1_122(L2_123, L3_124)
  L2_123 = L1_122
  L1_122 = L1_122.isActive
  L3_124 = "Talisman"
  L4_125 = "Start"
  L1_122 = L1_122(L2_123, L3_124, L4_125)
  if L1_122 then
    L1_122 = true
    return L1_122
  end
  L1_122 = Logic
  L2_123 = L1_122
  L1_122 = L1_122.Get
  L3_124 = "Guide"
  L1_122 = L1_122(L2_123, L3_124)
  L2_123 = L1_122
  L1_122 = L1_122.isActive
  L3_124 = "Achievement"
  L4_125 = "Start"
  L1_122 = L1_122(L2_123, L3_124, L4_125)
  if L1_122 then
    L1_122 = Logic
    L2_123 = L1_122
    L1_122 = L1_122.Get
    L3_124 = "Home"
    L1_122 = L1_122(L2_123, L3_124)
    L2_123 = L1_122
    L1_122 = L1_122.GetBtnPos
    L3_124 = "btnAchievement"
    L2_123 = L1_122(L2_123, L3_124)
    L3_124 = true
    L4_125 = L1_122
    return L3_124, L4_125, L2_123
  end
  L1_122 = Logic
  L2_123 = L1_122
  L1_122 = L1_122.Get
  L3_124 = "Guide"
  L1_122 = L1_122(L2_123, L3_124)
  L2_123 = L1_122
  L1_122 = L1_122.isActive
  L3_124 = "EquipEquip"
  L4_125 = "Start"
  L1_122 = L1_122(L2_123, L3_124, L4_125)
  if L1_122 then
    L1_122 = Logic
    L2_123 = L1_122
    L1_122 = L1_122.Get
    L3_124 = "Home"
    L1_122 = L1_122(L2_123, L3_124)
    L2_123 = L1_122
    L1_122 = L1_122.GetBtnPos
    L3_124 = "btnArmor"
    L2_123 = L1_122(L2_123, L3_124)
    L3_124 = true
    L4_125 = L1_122
    return L3_124, L4_125, L2_123
  end
  L1_122 = Logic
  L2_123 = L1_122
  L1_122 = L1_122.Get
  L3_124 = "Guide"
  L1_122 = L1_122(L2_123, L3_124)
  L2_123 = L1_122
  L1_122 = L1_122.isActive
  L3_124 = "EquipFetterOne"
  L4_125 = "Start"
  L1_122 = L1_122(L2_123, L3_124, L4_125)
  if L1_122 then
    L1_122 = Logic
    L2_123 = L1_122
    L1_122 = L1_122.Get
    L3_124 = "Home"
    L1_122 = L1_122(L2_123, L3_124)
    L2_123 = L1_122
    L1_122 = L1_122.GetBtnPos
    L3_124 = "btnArmor"
    L2_123 = L1_122(L2_123, L3_124)
    L3_124 = true
    L4_125 = L1_122
    return L3_124, L4_125, L2_123
  end
  L1_122 = Logic
  L2_123 = L1_122
  L1_122 = L1_122.Get
  L3_124 = "Guide"
  L1_122 = L1_122(L2_123, L3_124)
  L2_123 = L1_122
  L1_122 = L1_122.isActive
  L3_124 = "Activity"
  L4_125 = "Start"
  L1_122 = L1_122(L2_123, L3_124, L4_125)
  if L1_122 then
    L1_122 = Logic
    L2_123 = L1_122
    L1_122 = L1_122.Get
    L3_124 = "Home"
    L1_122 = L1_122(L2_123, L3_124)
    L2_123 = L1_122
    L1_122 = L1_122.GetBtnPos
    L3_124 = "btnActivity"
    L2_123 = L1_122(L2_123, L3_124)
    L3_124 = true
    L4_125 = L1_122
    return L3_124, L4_125, L2_123
  end
  L1_122 = Logic
  L2_123 = L1_122
  L1_122 = L1_122.Get
  L3_124 = "Guide"
  L1_122 = L1_122(L2_123, L3_124)
  L2_123 = L1_122
  L1_122 = L1_122.isActive
  L3_124 = "Treasure"
  L4_125 = "Start"
  L1_122 = L1_122(L2_123, L3_124, L4_125)
  if L1_122 then
    L1_122 = Logic
    L2_123 = L1_122
    L1_122 = L1_122.Get
    L3_124 = "Home"
    L1_122 = L1_122(L2_123, L3_124)
    L2_123 = L1_122
    L1_122 = L1_122.GetBtnPos
    L3_124 = "btnSkill"
    L2_123 = L1_122(L2_123, L3_124)
    L3_124 = true
    L4_125 = L1_122
    return L3_124, L4_125, L2_123
  end
  L1_122 = false
  return L1_122
end
