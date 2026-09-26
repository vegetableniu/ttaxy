local L0_0
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
L0_0 = "images/Cultivate/fb_prev.png"
function prototype.onEnter(A0_1, ...)
  super.onEnter(A0_1)
  A0_1:registerEvent()
  A0_1:refreshTitle()
  A0_1:createScrollView()
  A0_1:refreshNewTip()
  if Logic:Get("Elite"):IsActiveCountEmpty() then
    Logic:Get("Elite"):PostGetBattlesTimes()
  end
  Logic:Get("Elite"):initBattleList("PILL")
  Logic:Get("Elite"):SetBattleId(Logic:Get("Elite"):GetBattleList()[1].id)
  A0_1:refreshView()
  if not A0_1:checkBattleIdAndAdapt() then
    A0_1:AdaptByBattleNode()
  end
end
function prototype.onExit(A0_3, ...)
  Logic:Get("Cultivate"):SetCheckedBattleId(nil)
  Logic:Get("Cultivate"):SetFromCultivateStuff(false)
end
function prototype.registerEvent(A0_5, ...)
  Logic:Get("BattleShow"):On(Logic.BattleShow.EVT.INEND, A0_5:Event("OnCultivateBattleInEnd"))
  Logic:Get("Cultivate"):On(Logic.Cultivate.EVT.SET_BTLSCROLL, A0_5:Event("OnSetScroll"))
  Logic:Get("Cultivate"):On(Logic.Cultivate.EVT.SET_BTLBTN, A0_5:Event("OnSetBtn"))
  Logic:Get("Elite"):On(Logic.Elite.EVT.FIRST_CLEAR, A0_5:Event("OnFirstClear"))
  Logic:Get("BattleShow"):On(Logic.BattleShow.EVT.END, A0_5:Event("OnEndBattle"))
  Logic:Get("Elite"):On(Logic.Elite.EVT.BUY_TIMES, A0_5:Event("OnBuyTimes"))
  Logic:Get("Elite"):On(Logic.Elite.EVT.GET_BATTLES_TIMES, A0_5:Event("OnGetBattleTimes"))
  Logic:Get("Cultivate"):On(Logic.Cultivate.EVT.ON_LOAD_INFO, A0_5:Event("OnLoadInfo"))
  Logic:Get("Cultivate"):On(Logic.Cultivate.EVT.SWALLOW_ELIXIR, A0_5:Event("OnSwallowElixir"))
  Logic:Get("Cultivate"):On(Logic.Cultivate.EVT.COM_ELIXIR, A0_5:Event("OnComElixir"))
  Logic:Get("Cultivate"):On(Logic.Cultivate.EVT.RE_CULTIVATE_SUCCESS, A0_5:Event("OnRecultivate"))
  Logic:Get("Cultivate"):On(Logic.Cultivate.EVT.ON_HERO_CROSSING, A0_5:Event("OnHeroCrossing"))
  Logic:Get("Cultivate"):On(Logic.Cultivate.EVT.STUFF_CHANGE, A0_5:Event("OnStuffChange"))
end
function prototype.refreshTitle(A0_7, ...)
  local L2_9
  L2_9 = Logic
  L2_9 = L2_9.Get
  L2_9 = L2_9(L2_9, "Elite")
  L2_9 = L2_9.GetCampaignId
  L2_9 = L2_9(L2_9)
  if Logic:Get("Cultivate"):GetTitleSprByState(tonumber((KFDBGetRecord("CampaignConfig", L2_9) or {}).intro_title)) then
    A0_7.imgTitle:setDisplayFrame(Logic:Get("Cultivate"):GetTitleSprByState(tonumber((KFDBGetRecord("CampaignConfig", L2_9) or {}).intro_title)):displayFrame())
  end
  A0_7.bClearCamp = Logic:Get("Elite"):IsClearCampaign(L2_9)
end
function prototype.createScrollView(A0_10, ...)
  local L2_12, L3_13
  L2_12 = CCScrollViewEx
  L3_13 = L2_12
  L2_12 = L2_12.create
  L2_12 = L2_12(L3_13, CCSizeMake(580, 734))
  L3_13 = L2_12.setPosition
  L3_13(L2_12, ccp(0, 0))
  L3_13 = L2_12.setClippingToBounds
  L3_13(L2_12, true)
  L3_13 = L2_12.setTouchEnabled
  L3_13(L2_12, true)
  L3_13 = Tw
  L3_13 = L3_13.Controller
  L3_13 = L3_13.load
  L3_13 = L3_13(L3_13, "CultivateBattleView", A0_10.rootNode)
  L2_12:setContainer(L3_13)
  L2_12:setDirection(kCCScrollViewDirectionVertical)
  L2_12:updateInset()
  A0_10.nodeView:addChild(L2_12)
  A0_10.scroll = L2_12
end
function prototype.refreshView(A0_14)
  local L1_15
  L1_15 = A0_14.scroll
  if not L1_15 then
    return
  end
  L1_15 = Logic
  L1_15 = L1_15.Get
  L1_15 = L1_15(L1_15, "Elite")
  L1_15 = L1_15.initBattleList
  L1_15(L1_15, "PILL")
  L1_15 = Logic
  L1_15 = L1_15.Get
  L1_15 = L1_15(L1_15, "Elite")
  L1_15 = L1_15.GetAllBattles
  L1_15 = L1_15(L1_15, Logic:Get("Elite"):GetCampaignId())
  A0_14.data = L1_15
  A0_14.scroll:getContainer():refresh(L1_15)
  A0_14.scroll:updateInset()
  A0_14:refreshBtns(L1_15)
  A0_14:OnSetBtn(true)
  A0_14.scroll:setTouchEnabled(#L1_15 > 4)
end
function prototype.refreshNewTip(A0_16, ...)
  local L2_18
  L2_18 = Logic
  L2_18 = L2_18.Get
  L2_18 = L2_18(L2_18, "Cultivate")
  L2_18 = L2_18.showTip
  L2_18 = L2_18(L2_18)
  A0_16.sprNew:setVisible(L2_18)
  if A0_16.aniNew then
    A0_16.aniNew:RemoveAnimation()
    A0_16.aniNew = nil
  end
  if L2_18 then
    A0_16.aniNew = Logic:Get("AniMgr"):NewCCB("UI/uinew", A0_16.sprNew, ccp(27, 27), 0, nil, nil)
    if A0_16.aniNew then
      A0_16.aniNew:RunAni()
    end
  end
end
function prototype.checkBattleIdAndAdapt(A0_19, ...)
  local L2_21, L3_22, L4_23, L5_24, L6_25, L7_26, L8_27, L9_28, L10_29, L11_30
  L2_21 = Logic
  L3_22 = L2_21
  L2_21 = L2_21.Get
  L4_23 = "Cultivate"
  L2_21 = L2_21(L3_22, L4_23)
  L3_22 = L2_21
  L2_21 = L2_21.GetCheckedBattleId
  L2_21 = L2_21(L3_22)
  if not L2_21 then
    L3_22 = false
    return L3_22
  end
  L3_22 = A0_19.scroll
  L4_23 = L3_22
  L3_22 = L3_22.getContainer
  L3_22 = L3_22(L4_23)
  L5_24 = L3_22
  L4_23 = L3_22.getNodePos
  L6_25 = L2_21
  L4_23 = L4_23(L5_24, L6_25)
  if not L4_23 then
    return
  end
  L5_24 = 380
  L6_25 = A0_19.scroll
  L7_26 = L6_25
  L6_25 = L6_25.getContentOffset
  L6_25 = L6_25(L7_26)
  L7_26 = L4_23.y
  L8_27 = L6_25.y
  L7_26 = L7_26 + L8_27
  L7_26 = 380 - L7_26
  L8_27 = L6_25.y
  L8_27 = L8_27 + L7_26
  L9_28 = A0_19.scroll
  L10_29 = L9_28
  L9_28 = L9_28.minContainerOffset
  L9_28 = L9_28(L10_29)
  L10_29 = A0_19.scroll
  L11_30 = L10_29
  L10_29 = L10_29.maxContainerOffset
  L10_29 = L10_29(L11_30)
  L11_30 = math
  L11_30 = L11_30.min
  L11_30 = L11_30(L10_29.y, math.max(L8_27, L9_28.y))
  A0_19.scroll:setContentOffset(ccp(L6_25.x, L11_30))
  return true
end
function prototype.AdaptByBattleNode(A0_31, ...)
  local L2_33, L3_34, L4_35, L5_36, L6_37, L7_38, L8_39, L9_40, L10_41, L11_42
  L2_33 = Logic
  L3_34 = L2_33
  L2_33 = L2_33.Get
  L4_35 = "Elite"
  L2_33 = L2_33(L3_34, L4_35)
  L3_34 = L2_33
  L2_33 = L2_33.GetBattleId
  L2_33 = L2_33(L3_34)
  if not L2_33 then
    return
  end
  L3_34 = A0_31.scroll
  L4_35 = L3_34
  L3_34 = L3_34.getContainer
  L3_34 = L3_34(L4_35)
  L5_36 = L3_34
  L4_35 = L3_34.getNodePos
  L6_37 = L2_33
  L4_35 = L4_35(L5_36, L6_37)
  if not L4_35 then
    return
  end
  L5_36 = 380
  L6_37 = A0_31.scroll
  L7_38 = L6_37
  L6_37 = L6_37.getContentOffset
  L6_37 = L6_37(L7_38)
  L7_38 = L4_35.y
  L8_39 = L6_37.y
  L7_38 = L7_38 + L8_39
  L7_38 = 380 - L7_38
  L8_39 = L6_37.y
  L8_39 = L8_39 + L7_38
  L9_40 = A0_31.scroll
  L10_41 = L9_40
  L9_40 = L9_40.minContainerOffset
  L9_40 = L9_40(L10_41)
  L10_41 = A0_31.scroll
  L11_42 = L10_41
  L10_41 = L10_41.maxContainerOffset
  L10_41 = L10_41(L11_42)
  L11_42 = math
  L11_42 = L11_42.min
  L11_42 = L11_42(L10_41.y, math.max(L8_39, L9_40.y))
  A0_31.scroll:setContentOffset(ccp(L6_37.x, L11_42))
end
function prototype.refreshBtns(A0_43, A1_44)
  local L2_45, L3_46, L4_47, L5_48, L6_49, L7_50, L8_51, L9_52, L10_53, L11_54, L12_55, L13_56, L14_57, L15_58
  L2_45 = Logic
  L3_46 = L2_45
  L2_45 = L2_45.Get
  L4_47 = "Cultivate"
  L2_45 = L2_45(L3_46, L4_47)
  L3_46 = L2_45
  L2_45 = L2_45.GetCheckedBattleId
  L2_45 = L2_45(L3_46)
  L3_46 = Logic
  L4_47 = L3_46
  L3_46 = L3_46.Get
  L5_48 = "Elite"
  L3_46 = L3_46(L4_47, L5_48)
  L4_47 = L3_46
  L3_46 = L3_46.GetCampaignId
  L3_46 = L3_46(L4_47)
  L4_47 = Logic
  L5_48 = L4_47
  L4_47 = L4_47.Get
  L6_49 = "Elite"
  L4_47 = L4_47(L5_48, L6_49)
  L5_48 = L4_47
  L4_47 = L4_47.IsFirstCampaign
  L6_49 = L3_46
  L4_47 = L4_47(L5_48, L6_49)
  L5_48 = A0_43.btnPrev
  L6_49 = L5_48
  L5_48 = L5_48.setVisible
  L5_48(L6_49, L7_50)
  L5_48 = Logic
  L6_49 = L5_48
  L5_48 = L5_48.Get
  L5_48 = L5_48(L6_49, L7_50)
  L6_49 = L5_48
  L5_48 = L5_48.IsFinalCampaign
  L5_48 = L5_48(L6_49, L7_50)
  L6_49 = false
  for L10_53, L11_54 in L7_50(L8_51) do
    if L12_55 then
      if L12_55 then
        L6_49 = true
        break
      end
    end
  end
  for L11_54 = 1, L9_52(L10_53) do
    L7_50 = L12_55 or L12_55
    if L13_56 then
      if L13_56 == L3_46 then
        break
      end
    end
  end
  if L9_52 then
  L9_52 = L8_51 >= L9_52 or false
  L11_54 = L10_53
  L11_54 = L10_53
  L11_54 = {}
  L11_54 = Logic
  L11_54 = L11_54.Get
  L11_54 = L11_54(L12_55, L13_56)
  L11_54 = L11_54.GetNextCamp
  L11_54 = L11_54(L12_55, L13_56)
  L11_54 = L11_54 or {}
  for L15_58 = 1, L13_56(L14_57) do
    if (KFDBGetRecordByIdx("BattleInfoConfig", L15_58) or {}).campaignId == L11_54.id and (KFDBGetRecordByIdx("BattleInfoConfig", L15_58) or {}).prevId == "" then
      break
    end
  end
  L9_52 = L9_52 and L10_53 and L12_55
  A0_43.bOpen = L9_52
  A0_43.bClear = L10_53
  A0_43.rec = L7_50
  L12_55(L13_56, L14_57)
  if L9_52 then
  else
  end
  if not L9_52 then
    L15_58 = false
    L13_56(L14_57, L15_58)
  end
  L15_58 = CCScale9Sprite
  L15_58 = L15_58.create
  L15_58 = L15_58(L15_58, L12_55)
  L13_56(L14_57, L15_58, CCControlStateNormal)
  L15_58 = CCScale9Sprite
  L15_58 = L15_58.create
  L15_58 = L15_58(L15_58, L12_55)
  L13_56(L14_57, L15_58, CCControlStateHighlighted)
end
function prototype.onBtnHonor(A0_59, A1_60, A2_61)
  Logic:Get("Elite"):SetFirstRecordType(Logic.Rebirth.HONOR_TYPE.ELITE)
  SceneHelper:pushScene("HonorFirstRecord", A0_59.rootNode)
end
function prototype.onBtnTrain(A0_62, ...)
  Logic:Get("Cultivate"):setFromBattle(true)
  Logic:Get("Cultivate"):SetFromCultivateStuff(false)
  SceneHelper:pushScene("CultivateSelectHero")
end
function prototype.onBtnPack(A0_64, ...)
  Logic:Get("Cultivate"):SetFromCultivateStuff(false)
  SceneHelper:pushScene("CultivatePillPack")
end
function prototype.onBtnReturn(A0_66, ...)
  SceneHelper:removeScene("CultivateBattle")
  if not Logic:Get("Cultivate"):IsFromCultivateStuff() then
    SceneHelper:removeScene("CultivateCampaign")
    SceneHelper:pushScene("CultivateCampaign")
  end
end
function prototype.onBtnPrev(A0_68, ...)
  local L2_70
  L2_70 = Logic
  L2_70 = L2_70.Get
  L2_70 = L2_70(L2_70, "Elite")
  L2_70 = L2_70.GetCampaignId
  L2_70 = L2_70(L2_70)
  if (json.decode((KFDBGetRecord("CampaignConfig", Logic:Get("Elite"):GetCampaignId()) or {}).prevId or "") or {})[1] then
    Logic:Get("Elite"):SetCampaignId((json.decode((KFDBGetRecord("CampaignConfig", Logic:Get("Elite"):GetCampaignId()) or {}).prevId or "") or {})[1])
    SceneHelper:removeScene("CultivateBattle")
    SceneHelper:pushScene("CultivateBattle")
  end
end
function prototype.onBtnNext(A0_71, ...)
  local L2_73, L3_74, L4_75, L5_76, L6_77, L7_78, L8_79, L9_80, L10_81, L11_82
  L2_73 = Logic
  L3_74 = L2_73
  L2_73 = L2_73.Get
  L4_75 = "Elite"
  L2_73 = L2_73(L3_74, L4_75)
  L3_74 = L2_73
  L2_73 = L2_73.GetCampaignId
  L2_73 = L2_73(L3_74)
  L3_74 = tonumber
  L4_75 = string
  L4_75 = L4_75.match
  L5_76 = L2_73
  L11_82 = L4_75(L5_76, L6_77)
  L3_74 = L3_74(L4_75, L5_76, L6_77, L7_78, L8_79, L9_80, L10_81, L11_82, L4_75(L5_76, L6_77))
  if L3_74 >= 5 then
    L4_75 = Prompt
    L5_76 = L4_75
    L4_75 = L4_75.Fail
    L4_75(L5_76, L6_77)
    return
  end
  L4_75 = A0_71.bOpen
  if not L4_75 then
    L4_75 = ""
    L5_76 = json
    L5_76 = L5_76.decode
    L5_76 = L5_76(L6_77)
    L5_76 = L5_76 or {}
    for L9_80, L10_81 in L6_77(L7_78) do
      L11_82 = Logic
      L11_82 = L11_82.Get
      L11_82 = L11_82(L11_82, "Cultivate")
      L11_82 = L11_82.GetStateName
      L11_82 = L11_82(L11_82, tonumber(L9_80))
      L4_75 = L4_75 .. TwGetStr(114123, L10_81, L11_82)
    end
    L4_75 = L6_77
    L6_77(L7_78, L8_79)
    return
  end
  L4_75 = Logic
  L5_76 = L4_75
  L4_75 = L4_75.Get
  L4_75 = L4_75(L5_76, L6_77)
  L5_76 = L4_75
  L4_75 = L4_75.GetCampaignId
  L4_75 = L4_75(L5_76)
  L5_76 = Logic
  L5_76 = L5_76.Get
  L5_76 = L5_76(L6_77, L7_78)
  L5_76 = L5_76.GetNextCamp
  L5_76 = L5_76(L6_77, L7_78)
  L5_76 = L5_76 or {}
  L11_82 = L8_79(L9_80)
  for L11_82 = 1, L9_80(L10_81) do
    if (json.decode((KFDBGetRecordByIdx("CampaignConfig", L11_82) or {}).prevId or "") or {})[1] and (json.decode((KFDBGetRecordByIdx("CampaignConfig", L11_82) or {}).prevId or "") or {})[1] == L7_78 then
      Logic:Get("Elite"):SetCampaignId((KFDBGetRecordByIdx("CampaignConfig", L11_82) or {}).id)
      SceneHelper:removeScene("CultivateBattle")
      SceneHelper:pushScene("CultivateBattle")
    end
  end
end
function prototype.OnCulBattleEnd(A0_83, ...)
  SceneHelper:removeScene("EmbattleGroup")
  A0_83:refreshView()
  if not Logic:Get("Elite"):GetClearBtlFlag() then
    Logic:Get("Elite"):SetBattleId(Logic:Get("Elite"):GetBattleList()[1].id)
    A0_83:AdaptByBattleNode()
  end
end
function prototype.OnEndBattle(A0_85, ...)
  A0_85.rootNode:setVisible(true)
  A0_85:OnCulBattleEnd()
  A0_85:refreshNewTip()
  A0_85:refreshView()
  if not Logic:Get("Cultivate"):GetCheckedStuffInfo() or not Logic:Get("Cultivate"):GetCheckedStuffInfo().amount then
    return
  end
  if Logic:Get("Cultivate"):GetStuffByBaseId(Logic:Get("Cultivate"):GetCheckedStuffInfo().baseId) >= Logic:Get("Cultivate"):GetCheckedStuffInfo().amount then
    SceneHelper:removeScene("CultivateBattle")
  end
end
function prototype.OnSetScroll(A0_87, A1_88)
  if A0_87.scroll then
    A0_87.scroll:setTouchEnabled(A1_88 and #A0_87.data > 4)
  end
end
function prototype.OnSetBtn(A0_89, A1_90)
  A0_89.nodeBtn:setVisible(A1_90 and not Logic:Get("Cultivate"):GetCheckedBattleId())
end
function prototype.OnCultivateBattleInEnd(A0_91, ...)
  SceneHelper:removeScene("CultivateBattleTip")
  A0_91:OnSetScroll(true)
  A0_91.rootNode:setVisible(false)
  Logic:Get("Cultivate"):SetBtlBtnVisible(true)
end
function prototype.OnFirstClear(A0_93, ...)
  local L2_95
  L2_95 = Logic
  L2_95 = L2_95.Get
  L2_95 = L2_95(L2_95, "Elite")
  L2_95 = L2_95.GetCampaignId
  L2_95 = L2_95(L2_95)
  A0_93.sprArrow:setVisible(not Logic:Get("Elite"):IsFinalCampaign(L2_95))
end
function prototype.OnBuyTimes(A0_96, ...)
  A0_96:refreshView()
end
function prototype.OnGetBattleTimes(A0_98, ...)
  Logic:Get("Elite"):initBattleList("PILL")
end
function prototype.OnLoadInfo(A0_100, ...)
  A0_100:refreshNewTip()
end
function prototype.OnSwallowElixir(A0_102, ...)
  A0_102:refreshNewTip()
end
function prototype.OnComElixir(A0_104, ...)
  A0_104:refreshNewTip()
end
function prototype.OnRecultivate(A0_106)
  A0_106:refreshNewTip()
end
function prototype.OnHeroCrossing(A0_107)
  A0_107:refreshNewTip()
  A0_107:refreshView()
end
function prototype.OnStuffChange(A0_108)
  A0_108:refreshNewTip()
end
