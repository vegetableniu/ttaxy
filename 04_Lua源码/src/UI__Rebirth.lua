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
L0_0 = "images/Rebirth/limitChallenge.png"
function prototype.initialize(A0_1)
  super.initialize(A0_1)
  A0_1.titleinfo = {}
  A0_1.data = {}
end
function prototype.onEnter(A0_2)
  local L1_3
  L1_3 = super
  L1_3 = L1_3.onEnter
  L1_3(A0_2)
  L1_3 = A0_2.sprRight
  L1_3 = L1_3.setVisible
  L1_3(L1_3, true)
  L1_3 = A0_2.imgBtnRightBg
  L1_3 = L1_3.setVisible
  L1_3(L1_3, true)
  L1_3 = Logic
  L1_3 = L1_3.Get
  L1_3 = L1_3(L1_3, "Rebirth")
  L1_3 = L1_3.On
  L1_3(L1_3, Logic.Rebirth.EVT.PROGRESS, A0_2:Event("OnProgress"))
  L1_3 = Logic
  L1_3 = L1_3.Get
  L1_3 = L1_3(L1_3, "BattleShow")
  L1_3 = L1_3.On
  L1_3(L1_3, Logic.BattleShow.EVT.INEND, A0_2:Event("onInBattleEnd"))
  L1_3 = Logic
  L1_3 = L1_3.Get
  L1_3 = L1_3(L1_3, "BattleShow")
  L1_3 = L1_3.On
  L1_3(L1_3, Logic.BattleShow.EVT.END, A0_2:Event("onBattleResultEnd"))
  L1_3 = {}
  A0_2.data = L1_3
  L1_3 = TableViewEx
  L1_3 = L1_3.prototype
  L1_3 = L1_3.createList
  L1_3 = L1_3(L1_3, A0_2, A0_2.lstRebirth, 1)
  A0_2.tableViewControl = L1_3
  L1_3 = A0_2.tableViewControl
  L1_3 = L1_3.RequireUpdate
  L1_3(L1_3)
  L1_3 = A0_2.tableViewControl
  L1_3 = L1_3.tableView
  L1_3 = L1_3.setDirection
  L1_3(L1_3, kCCScrollViewDirectionVertical)
  L1_3 = A0_2.lstRebirth
  L1_3 = L1_3.addChild
  L1_3(L1_3, A0_2.tableViewControl.tableView)
  L1_3 = Logic
  L1_3 = L1_3.Get
  L1_3 = L1_3(L1_3, "Rebirth")
  L1_3 = L1_3.PostProgress
  L1_3(L1_3)
  L1_3 = Logic
  L1_3 = L1_3.Get
  L1_3 = L1_3(L1_3, "System")
  L1_3 = L1_3.GetTimeDate
  L1_3 = L1_3(L1_3)
  Logic:Get("Rebirth"):SetEnterTime(L1_3)
  if KFDBGetRecord("CampaignConfig", Logic:Get("Rebirth"):GetCampaignId()).type == "LIMITED" then
    if CCSprite:create(_UPVALUE0_) then
      A0_2.imgTitle:setDisplayFrame(CCSprite:create(_UPVALUE0_):displayFrame())
    end
    return
  end
  if KFDBGetRecord("CampaignConfig", Logic:Get("Rebirth"):GetCampaignId()).type == "FULLED" and CCSprite:create(KFDBGetRecord("CampaignConfig", Logic:Get("Rebirth"):GetCampaignId()).imgTitle) then
    A0_2.imgTitle:setDisplayFrame(CCSprite:create(KFDBGetRecord("CampaignConfig", Logic:Get("Rebirth"):GetCampaignId()).imgTitle):displayFrame())
    A0_2.imgTitle:setScale(0.8)
  end
end
function prototype.onBtnReturn(A0_4, A1_5, A2_6)
  local L3_7
  L3_7 = Logic
  L3_7 = L3_7.Get
  L3_7 = L3_7(L3_7, "Rebirth")
  L3_7 = L3_7.GetCampaignId
  L3_7 = L3_7(L3_7)
  if Logic:Get("Rebirth"):isRebirthActive(L3_7) and Logic:Get("Rebirth"):IsSkipCampaign() then
    Logic:Get("Rebirth"):PostQuickCampaign()
    return
  end
  if string.match(L3_7 or "", "^CLX0[1-6]$") then
    Logic:Get("Rebirth"):SetLockTowerListMode(true)
    SceneHelper:runWithScene("Activity", A0_4.rootNode)
    return
  end
  SceneHelper:runWithScene("Activity", A0_4.rootNode)
end
function prototype.onBtnBestAtt(A0_8, A1_9, A2_10)
  Logic:Get("Rebirth"):SetHonorType(Logic.Rebirth.HONOR_TYPE.REBIRTH)
  SceneHelper:pushScene("HonorBestRecord", A0_8.rootNode)
end
function prototype.OnProgress(A0_11)
  local L1_12, L2_13
  L1_12 = Logic
  L2_13 = L1_12
  L1_12 = L1_12.Get
  L1_12 = L1_12(L2_13, "Rebirth")
  L2_13 = L1_12
  L1_12 = L1_12.GetListData
  L1_12 = L1_12(L2_13)
  A0_11.data = L1_12
  L1_12 = A0_11.tableViewControl
  L2_13 = L1_12
  L1_12 = L1_12.RequireUpdate
  L1_12(L2_13)
  L1_12 = Logic
  L2_13 = L1_12
  L1_12 = L1_12.Get
  L1_12 = L1_12(L2_13, "Rebirth")
  L2_13 = L1_12
  L1_12 = L1_12.GetCampaignId
  L1_12 = L1_12(L2_13)
  L2_13 = Logic
  L2_13 = L2_13.Get
  L2_13 = L2_13(L2_13, "Rebirth")
  L2_13 = L2_13.isRebirthActive
  L2_13 = L2_13(L2_13, L1_12)
  if L2_13 then
    L2_13 = Logic
    L2_13 = L2_13.Get
    L2_13 = L2_13(L2_13, "Rebirth")
    L2_13 = L2_13.IsSkipCampaign
    L2_13 = L2_13(L2_13)
    if L2_13 then
      L2_13 = "images/newfont/SkipFightSmall.png"
      if CCSprite:create(L2_13) then
        A0_11.sprLeft:setDisplayFrame(CCSprite:create(L2_13):displayFrame())
      end
      return
    end
  end
  L2_13 = "images/font/return.png"
  if CCSprite:create(L2_13) then
    A0_11.sprLeft:setDisplayFrame(CCSprite:create(L2_13):displayFrame())
  end
end
function prototype.onInBattleEnd(A0_14)
  SceneHelper:removeScene("EmbattleGroup")
  A0_14.data = {}
  A0_14.tableViewControl:RequireUpdate()
end
function prototype.onBattleResultEnd(A0_15)
  Logic:Get("Rebirth"):PostProgress()
end
function prototype.cellSizeForTable(A0_16, ...)
  return CCSizeMake(563, 120)
end
function prototype.tableCellAtIndex(A0_18, A1_19, A2_20, A3_21, A4_22)
  local L5_23
  if not A3_21 then
    L5_23 = CCTableViewCellEx
    L5_23 = L5_23.create
    L5_23 = L5_23(L5_23)
    A3_21 = L5_23
    L5_23 = Tw
    L5_23 = L5_23.Controller
    L5_23 = L5_23.load
    L5_23 = L5_23(L5_23, "RebirthItem", A0_18.rootNode)
    L5_23:ReFrashInfo(A0_18.data[A2_20 + 1])
    A3_21:addChild(L5_23, 0, 2)
  else
    L5_23 = A3_21.getChildByTag
    L5_23 = L5_23(A3_21, 2)
    L5_23 = L5_23.ReFrashInfo
    L5_23(L5_23, A0_18.data[A2_20 + 1])
  end
  return A3_21
end
function prototype.numberOfCellsInTableView(A0_24, A1_25)
  if A0_24.data == nil or table.empty(A0_24.data) then
    return 0
  end
  return #A0_24.data
end
function prototype.tableCellTouched(A0_26, A1_27, A2_28)
end
function prototype.tablePageTurn(A0_29, A1_30)
  A0_29.tableViewControl:RequireUpdate()
end
