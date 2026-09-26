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
L0_0 = "images/public/progress1.png"
function prototype.initialize(A0_1)
  super.initialize(A0_1)
end
function prototype.onEnter(A0_2)
  super.onEnter(A0_2)
  A0_2.ttfSoulNum:setStyle(kCCLabelTTFStyleOutline)
  A0_2.ttfNextGrade:setStyle(kCCLabelTTFStyleOutline)
  A0_2.ttfTip:setStyle(kCCLabelTTFStyleOutline)
  A0_2.ttfTip:setString(TwGetStr(105910))
  A0_2.nodProgress:createProgress(_UPVALUE0_, _UPVALUE1_)
  Logic:Get("Artifact"):On(Logic.Artifact.EVT.ENTER, A0_2:Event("refreshData"))
  Logic:Get("Artifact"):On(Logic.Artifact.EVT.INJECT_SOULSTONE, A0_2:Event("onInjectSoulStone"))
  A0_2.data = {}
  A0_2.tableViewControl = TableViewEx.prototype:createList(A0_2, A0_2.lstRebirth, 1)
  A0_2.tableViewControl:RequireUpdate()
  A0_2.tableViewControl.tableView:setDirection(kCCScrollViewDirectionVertical)
  A0_2.lstRebirth:addChild(A0_2.tableViewControl.tableView)
  Logic:Get("Artifact"):PostEnterArtifact()
end
function prototype.refreshData(A0_3)
  local L1_4, L2_5, L3_6
  L1_4 = Logic
  L2_5 = L1_4
  L1_4 = L1_4.Get
  L3_6 = "Artifact"
  L1_4 = L1_4(L2_5, L3_6)
  L2_5 = L1_4
  L1_4 = L1_4.GetProgress
  L1_4 = L1_4(L2_5)
  L2_5 = Logic
  L3_6 = L2_5
  L2_5 = L2_5.Get
  L2_5 = L2_5(L3_6, "Artifact")
  L3_6 = L2_5
  L2_5 = L2_5.GetCurrLvMaxProgress
  L2_5 = L2_5(L3_6)
  L3_6 = math
  L3_6 = L3_6.ceil
  L3_6 = L3_6(100 * L1_4 / L2_5)
  if L3_6 and L3_6 >= 0 then
    A0_3.nodProgress:setValue(L3_6)
  end
  A0_3:createHuLu()
  A0_3:refreshBaseData(true)
end
function prototype.refreshBaseData(A0_7, A1_8)
  local L2_9, L3_10, L4_11, L5_12, L6_13, L7_14, L8_15, L9_16, L10_17, L11_18, L12_19, L13_20, L14_21, L15_22
  L2_9 = Logic
  L3_10 = L2_9
  L2_9 = L2_9.Get
  L4_11 = "Artifact"
  L2_9 = L2_9(L3_10, L4_11)
  L3_10 = L2_9
  L2_9 = L2_9.GetSoulNum
  L2_9 = L2_9(L3_10)
  L3_10 = A0_7.ttfSoulNum
  L4_11 = L3_10
  L3_10 = L3_10.setString
  L3_10(L4_11, L5_12)
  L3_10 = Logic
  L4_11 = L3_10
  L3_10 = L3_10.Get
  L3_10 = L3_10(L4_11, L5_12)
  L4_11 = L3_10
  L3_10 = L3_10.GetArtLevel
  L3_10 = L3_10(L4_11)
  if L3_10 >= 0 then
    L4_11 = A0_7.nodLevel
    L4_11 = L4_11.create
    L4_11(L5_12, L6_13, L7_14)
    L4_11 = A0_7.nodLevel
    L4_11 = L4_11.setAlign
    L4_11(L5_12, L6_13, L7_14)
    L4_11 = A0_7.nodLevel
    L4_11 = L4_11.setValue
    L4_11(L5_12, L6_13)
  end
  L4_11 = Logic
  L4_11 = L4_11.Get
  L4_11 = L4_11(L5_12, L6_13)
  L4_11 = L4_11.GetSoulStoneSp
  L4_11 = L4_11(L5_12)
  for L8_15, L9_16 in L5_12(L6_13) do
    L12_19 = L8_15
    if L11_18 then
      L12_19 = L11_18
      L13_20 = L4_11[L8_15]
      L11_18(L12_19, L13_20)
    end
  end
  if L5_12 then
  else
  end
  if L3_10 < L6_13 then
    L8_15 = L7_14
    L12_19 = L3_10 + 1
    L15_22 = L9_16(L10_17, L11_18, L12_19)
    L7_14(L8_15, L9_16, L10_17, L11_18, L12_19, L13_20, L14_21, L15_22, L9_16(L10_17, L11_18, L12_19))
  else
    L8_15 = L7_14
    L7_14(L8_15, L9_16)
  end
  L8_15 = L7_14
  L8_15 = L7_14
  L8_15 = Logic
  L8_15 = L8_15.Get
  L8_15 = L8_15(L9_16, L10_17)
  L8_15 = L8_15.GetCurrLvMaxProgress
  L8_15 = L8_15(L9_16)
  if A1_8 then
    A0_7.data = L9_16
    L9_16[1] = L10_17
    for L12_19 = 1, 12 do
      L13_20 = string
      L13_20 = L13_20.format
      L14_21 = "%d_%d"
      L15_22 = L3_10
      L13_20 = L13_20(L14_21, L15_22, L12_19)
      L14_21 = KFDBGetRecord
      L15_22 = "ArtifactLevelSetting"
      L14_21 = L14_21(L15_22, L13_20)
      if L14_21 then
        L15_22 = {}
        L15_22.star = L12_19
        L15_22.currDesr = L14_21.desr
        if L12_19 == 12 then
          L15_22.tip = TwGetStr(105909)
        end
        L15_22.nextDesr = L14_21.desrNext
        table.insert(A0_7.data[1], L15_22)
      end
    end
    L9_16(L10_17)
  end
end
function prototype.createHuLu(A0_23)
  local L1_24, L2_25, L3_26, L4_27, L5_28, L6_29, L7_30, L8_31, L9_32, L10_33, L11_34
  L1_24 = Logic
  L2_25 = L1_24
  L1_24 = L1_24.Get
  L1_24 = L1_24(L2_25, L3_26)
  L2_25 = L1_24
  L1_24 = L1_24.GetArtLevel
  L1_24 = L1_24(L2_25)
  L2_25 = KFDBGetRecord
  L2_25 = L2_25(L3_26, L4_27)
  if L2_25 == nil then
    return
  end
  for L6_29 = 1, L2_25.imgLv do
    L8_31 = A0_23.nodHulu
    L9_32 = L8_31
    L8_31 = L8_31.getChildByTag
    L10_33 = L7_30
    L8_31 = L8_31(L9_32, L10_33)
    if L8_31 then
      L9_32 = A0_23.nodHulu
      L10_33 = L9_32
      L9_32 = L9_32.removeChildByTag
      L11_34 = L7_30
      L9_32(L10_33, L11_34, true)
    end
  end
  if L3_26 then
  else
  end
  if L1_24 >= L4_27 then
    if L5_28 then
      L8_31 = "images/public/clarity05.png"
      if L7_30 then
        return
      end
      L8_31 = L7_30
      L9_32 = "AniMgr"
      L8_31 = L7_30
      L9_32 = "UI/UIsqsj03"
      L10_33 = A0_23.nodHulu
      L11_34 = ccp
      L11_34 = L11_34(0, -130)
      A0_23.maxAni = L7_30
      L8_31 = L7_30
      L9_32 = "sprHulu1"
      L8_31 = L7_30
      L10_33 = L6_29
      L9_32 = L6_29.displayFrame
      L11_34 = L9_32(L10_33)
      L7_30(L8_31, L9_32, L10_33, L11_34, L9_32(L10_33))
      L8_31 = L7_30
      L9_32 = "sprHulu1"
      L8_31 = L7_30
      L9_32 = L5_28
      L10_33 = 0
      L11_34 = 1
      L7_30(L8_31, L9_32, L10_33, L11_34)
      L8_31 = L7_30
      L9_32 = "sprHulu2"
      L8_31 = L7_30
      L10_33 = L6_29
      L9_32 = L6_29.displayFrame
      L11_34 = L9_32(L10_33)
      L7_30(L8_31, L9_32, L10_33, L11_34, L9_32(L10_33))
      if L7_30 then
        L8_31 = L7_30
        L7_30(L8_31)
      end
    end
    return
  end
  for L8_31 = 1, L2_25.imgLv do
    L9_32 = 100 + L8_31
    L10_33 = string
    L10_33 = L10_33.format
    L11_34 = "images/Artifact/hulu%d.png"
    L10_33 = L10_33(L11_34, L8_31)
    L11_34 = CCSprite
    L11_34 = L11_34.create
    L11_34 = L11_34(L11_34, L10_33)
    if L11_34 then
      L11_34:setAnchorPoint(ccp(0.5, 0.5))
      L11_34:setPosition(ccp(0, 0))
      A0_23.nodHulu:addChild(L11_34, 0, L9_32)
    end
  end
end
function prototype.onBtnReturn(A0_35, A1_36, A2_37)
  SceneHelper:runWithScene("ArtifactExchange", A0_35.rootNode)
end
function prototype.onBtnAdd(A0_38, A1_39, A2_40)
  if (KFDBGetRecord("ConfigValue", "BEEEFFGEE:LEVEL_COUNT") and tonumber(KFDBGetRecord("ConfigValue", "BEEEFFGEE:LEVEL_COUNT").content) or 0) <= Logic:Get("Artifact"):GetArtLevel() then
    Prompt:Fail(TwGetStr(105971))
    return
  end
  SceneHelper:pushPrompt("ArtifactSoul", A0_38.rootNode)
end
function prototype.onBtnActivity(A0_41, A1_42, A2_43)
  Logic:Get("Rebirth"):SetLockTowerListMode(true)
  SceneHelper:runWithScene("Activity", A0_41.rootNode)
end
function prototype.onInjectSoulStone(A0_44, A1_45)
  local L2_46, L3_47, L4_48, L5_49
  L2_46 = A1_45
  L4_48 = A0_44
  L3_47 = A0_44.showCrit
  L3_47(L4_48)
  if L2_46 > 0 then
    L3_47 = A0_44.nodProgress
    L4_48 = L3_47
    L3_47 = L3_47.setMoveCallBack
    L5_49 = bind
    L5_49 = L5_49(A0_44.upgradeEnd, A0_44)
    L3_47(L4_48, L5_49, L5_49(A0_44.upgradeEnd, A0_44))
  else
    L3_47 = A0_44.nodProgress
    L4_48 = L3_47
    L3_47 = L3_47.setMoveCallBack
    L5_49 = bind
    L5_49 = L5_49(A0_44.progressEnd, A0_44)
    L3_47(L4_48, L5_49, L5_49(A0_44.progressEnd, A0_44))
  end
  L3_47 = Logic
  L4_48 = L3_47
  L3_47 = L3_47.Get
  L5_49 = "Artifact"
  L3_47 = L3_47(L4_48, L5_49)
  L4_48 = L3_47
  L3_47 = L3_47.GetProgress
  L3_47 = L3_47(L4_48)
  L4_48 = Logic
  L5_49 = L4_48
  L4_48 = L4_48.Get
  L4_48 = L4_48(L5_49, "Artifact")
  L5_49 = L4_48
  L4_48 = L4_48.GetCurrLvMaxProgress
  L4_48 = L4_48(L5_49)
  L5_49 = math
  L5_49 = L5_49.ceil
  L5_49 = L5_49(100 * L3_47 / L4_48)
  A0_44.nodProgress:setValue(L5_49, true, L2_46, 1000)
end
function prototype.progressEnd(A0_50)
  A0_50:refreshBaseData(false)
end
function prototype.upgradeEnd(A0_51, A1_52, A2_53)
  if A2_53 == Progress.CALL_BACK_TYPE.PASS_END or Logic:Get("Artifact"):GetProgress() == 0 and A2_53 == Progress.CALL_BACK_TYPE.MOVE_FINISH then
    A0_51:refreshBaseData(true)
    A0_51:createHuLu()
    A0_51.ani = Logic:Get("AniMgr"):NewCCB("UI/UIsqsj02", A0_51.nodHulu, ccp(0, -91.5), 0, nil, 1)
    if A0_51.ani then
      A0_51.ani:RunAni()
    end
  end
end
function prototype.showCrit(A0_54)
  local L1_55, L2_56, L3_57, L4_58, L5_59, L6_60
  L1_55 = Logic
  L2_56 = L1_55
  L1_55 = L1_55.Get
  L3_57 = "Artifact"
  L1_55 = L1_55(L2_56, L3_57)
  L2_56 = L1_55
  L1_55 = L1_55.GetInjectNum
  L1_55 = L1_55(L2_56)
  if L1_55 == 1 then
    return
  end
  L2_56 = Logic
  L3_57 = L2_56
  L2_56 = L2_56.Get
  L4_58 = "Artifact"
  L2_56 = L2_56(L3_57, L4_58)
  L3_57 = L2_56
  L2_56 = L2_56.GetCritNum
  L2_56 = L2_56(L3_57)
  if L2_56 > 0 then
    L3_57 = Logic
    L4_58 = L3_57
    L3_57 = L3_57.Get
    L5_59 = "Gift"
    L3_57 = L3_57(L4_58, L5_59)
    L4_58 = L3_57
    L3_57 = L3_57.IsOpenActivity
    L5_59 = "BANSHU_ARTIFACT_SOUL"
    L3_57 = L3_57(L4_58, L5_59)
    L4_58 = Logic
    L5_59 = L4_58
    L4_58 = L4_58.Get
    L6_60 = "Egg"
    L4_58 = L4_58(L5_59, L6_60)
    L5_59 = L4_58
    L4_58 = L4_58.GetCongifValueByKey
    L6_60 = "BEEEFFGEE:BANSHU_CRIT_PROGRESS_MULTIPLE"
    L4_58 = L4_58(L5_59, L6_60)
    L5_59 = Logic
    L6_60 = L5_59
    L5_59 = L5_59.Get
    L5_59 = L5_59(L6_60, "Egg")
    L6_60 = L5_59
    L5_59 = L5_59.GetCongifValueByKey
    L5_59 = L5_59(L6_60, "BEEEFFGEE:CRIT_PROGRESS_MULTIPLE")
    L6_60 = L3_57 and L4_58 or L5_59
    Prompt:Fail(TwGetStr(105911, L2_56, L6_60))
    return
  end
end
function prototype.GetHuluTexture(A0_61)
  local L1_62, L2_63, L3_64, L4_65, L5_66, L6_67, L7_68, L8_69, L9_70, L10_71, L11_72, L12_73
  L1_62 = Logic
  L2_63 = L1_62
  L1_62 = L1_62.Get
  L3_64 = "Artifact"
  L1_62 = L1_62(L2_63, L3_64)
  L2_63 = L1_62
  L1_62 = L1_62.GetArtLevel
  L1_62 = L1_62(L2_63)
  L2_63 = KFDBGetRecord
  L3_64 = "BeeEffGeeLevelSetting"
  L2_63 = L2_63(L3_64, L4_65)
  if L2_63 == nil then
    L3_64 = nil
    return L3_64
  end
  L3_64 = CCSprite
  L3_64 = L3_64.create
  L3_64 = L3_64(L4_65, L5_66)
  if L3_64 then
    L7_68 = 0.5
    L8_69 = 0.5
    L12_73 = L6_67(L7_68, L8_69)
    L4_65(L5_66, L6_67, L7_68, L8_69, L9_70, L10_71, L11_72, L12_73, L6_67(L7_68, L8_69))
    L7_68 = 0
    L8_69 = 0
    L12_73 = L6_67(L7_68, L8_69)
    L4_65(L5_66, L6_67, L7_68, L8_69, L9_70, L10_71, L11_72, L12_73, L6_67(L7_68, L8_69))
  end
  for L7_68 = 2, L2_63.imgLv do
    L8_69 = 100 + L7_68
    L9_70 = string
    L9_70 = L9_70.format
    L10_71 = "images/Artifact/hulu%d.png"
    L11_72 = L7_68
    L9_70 = L9_70(L10_71, L11_72)
    L10_71 = CCSprite
    L11_72 = L10_71
    L10_71 = L10_71.create
    L12_73 = L9_70
    L10_71 = L10_71(L11_72, L12_73)
    if L10_71 then
      L12_73 = L10_71
      L11_72 = L10_71.setAnchorPoint
      L11_72(L12_73, ccp(0.5, 0.5))
      L12_73 = L3_64
      L11_72 = L3_64.getContentSize
      L11_72 = L11_72(L12_73)
      L11_72 = L11_72.width
      L11_72 = L11_72 / 2
      L12_73 = L3_64.getContentSize
      L12_73 = L12_73(L3_64)
      L12_73 = L12_73.height
      L12_73 = L12_73 / 2
      L10_71:setPosition(ccp(L11_72, L12_73))
      L3_64:addChild(L10_71, 0, L8_69)
    end
  end
  return L3_64
end
function prototype.cellSizeForTable(A0_74, ...)
  return CCSizeMake(563, 550)
end
function prototype.tableCellAtIndex(A0_76, A1_77, A2_78, A3_79, A4_80)
  local L5_81
  if not A3_79 then
    L5_81 = CCTableViewCellEx
    L5_81 = L5_81.create
    L5_81 = L5_81(L5_81)
    A3_79 = L5_81
    L5_81 = Tw
    L5_81 = L5_81.Controller
    L5_81 = L5_81.load
    L5_81 = L5_81(L5_81, "ArtifactAttr", A0_76.rootNode)
    L5_81:ReFrashInfo(A0_76.data[A2_78 + 1])
    A3_79:addChild(L5_81, 0, 2)
  else
    L5_81 = A3_79.getChildByTag
    L5_81 = L5_81(A3_79, 2)
    L5_81 = L5_81.ReFrashInfo
    L5_81(L5_81, A0_76.data[A2_78 + 1])
  end
  return A3_79
end
function prototype.numberOfCellsInTableView(A0_82, A1_83)
  if A0_82.data == nil or table.empty(A0_82.data) then
    return 0
  end
  return #A0_82.data
end
function prototype.tableCellTouched(A0_84, A1_85, A2_86)
end
function prototype.tablePageTurn(A0_87, A1_88)
  A0_87.tableViewControl:RequireUpdate()
end
