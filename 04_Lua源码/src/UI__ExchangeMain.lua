module((...), package.seeall)
require("SceneHelper")
require("BtnPosition")
prototype = BtnPosition.prototype:extend()
function prototype.onEnter(A0_0)
  super.onEnter(A0_0)
  A0_0.ttfCount:setStyle(kCCLabelTTFStyleOutline)
  Logic:Get("Exchange"):On(Logic.Exchange.EVT.ON_GET_CARDS, A0_0:Event("OnUIGetCards"))
  Logic:Get("Exchange"):On(Logic.Exchange.EVT.MSG_POP_TIP, A0_0:Event("OnPopTip"))
  Logic:Get("Exchange"):On(Logic.Exchange.EVT.ON_EXCHANGE, A0_0:Event("OnExhanged"))
  A0_0.ani = Logic:Get("AniMgr"):NewCCB("UI/UIcz", A0_0.sprRight, ccp(35, 19), 0, nil, nil)
  if A0_0.ani then
    A0_0.ani:RunAni()
  end
  Logic:Get("Exchange"):PostGetCards()
end
function prototype.onExit(A0_1)
  Logic:Get("Exchange"):ClearCards()
  Logic:Get("Exchange"):ClearExchangeIds()
end
function prototype.refreshByExchangeId(A0_2)
  local L1_3, L2_4, L3_5
  L1_3 = Logic
  L2_4 = L1_3
  L1_3 = L1_3.Get
  L3_5 = "Exchange"
  L1_3 = L1_3(L2_4, L3_5)
  L2_4 = L1_3
  L1_3 = L1_3.GetExchangeId
  L1_3 = L1_3(L2_4)
  L2_4 = #L1_3
  L2_4 = L1_3[L2_4]
  A0_2.curId = L2_4
  L3_5 = Logic
  L3_5 = L3_5.Get
  L3_5 = L3_5(L3_5, "Exchange")
  L3_5 = L3_5.GetExchangeCards
  L3_5 = L3_5(L3_5, L2_4)
  A0_2:updateCards(L3_5)
  A0_2:refreshPanel(L2_4)
  A0_2:checkHasExchange(L2_4)
end
function prototype.updateCards(A0_6, A1_7)
  local L2_8, L3_9, L4_10, L5_11, L6_12, L7_13, L8_14, L9_15, L10_16, L11_17, L12_18, L13_19, L14_20, L15_21, L16_22, L17_23
  if not A1_7 then
    return
  end
  if L2_8 then
    L2_8(L3_9, L4_10)
    A0_6.mainCardNode = nil
  end
  for L5_11 = 1, 4 do
    L9_15 = L5_11
    if L6_12 then
      L10_16 = L6_12
      L9_15 = L6_12.setVisible
      L11_17 = false
      L9_15(L10_16, L11_17)
    end
    if L7_13 then
      L10_16 = L7_13
      L9_15 = L7_13.setVisible
      L11_17 = false
      L9_15(L10_16, L11_17)
    end
    if L8_14 then
      L10_16 = L8_14
      L9_15 = L8_14.setVisible
      L11_17 = false
      L9_15(L10_16, L11_17)
    end
  end
  A0_6.cardInfo = A1_7
  if L2_8 then
    L5_11 = kCCLabelTTFStyleOutline
    L3_9(L4_10, L5_11)
    L5_11 = L2_8.star
    L5_11 = L4_10
    L4_10(L5_11, L6_12)
  end
  L5_11 = "Hero"
  L5_11 = A1_7.mainCard
  L5_11 = L4_10
  L4_10(L5_11, L6_12)
  L5_11 = L4_10
  L5_11 = L4_10
  L5_11 = A0_6.rootNode
  L5_11 = L5_11.addChild
  L5_11(L6_12, L7_13)
  A0_6.mainCardNode = L4_10
  L5_11 = L4_10.setPosition
  L17_23 = L7_13(L8_14)
  L5_11(L6_12, L7_13, L8_14, L9_15, L10_16, L11_17, L12_18, L13_19, L14_20, L15_21, L16_22, L17_23, L7_13(L8_14))
  L5_11 = L4_10.setScale
  L5_11(L6_12, L7_13)
  L5_11 = {}
  for L9_15, L10_16 in L6_12(L7_13) do
    L11_17 = table
    L11_17 = L11_17.insert
    L12_18 = L5_11
    L13_19 = A1_7.stars
    L13_19 = L13_19[L9_15]
    L13_19 = L10_16 + L13_19
    L11_17(L12_18, L13_19)
  end
  A1_7.cards = L5_11
  for L9_15, L10_16 in L6_12(L7_13) do
    L11_17 = Logic
    L12_18 = L11_17
    L11_17 = L11_17.Get
    L13_19 = "Hero"
    L11_17 = L11_17(L12_18, L13_19)
    L12_18 = L11_17
    L11_17 = L11_17.GetHeroBgImage
    L13_19 = L10_16
    L11_17 = L11_17(L12_18, L13_19)
    L12_18 = CCSprite
    L13_19 = L12_18
    L12_18 = L12_18.create
    L14_20 = L11_17
    L12_18 = L12_18(L13_19, L14_20)
    L13_19 = string
    L13_19 = L13_19.format
    L14_20 = "sprBg%d"
    L15_21 = L9_15
    L13_19 = L13_19(L14_20, L15_21)
    if L12_18 then
      L14_20 = A0_6[L13_19]
      if L14_20 then
        L14_20 = A0_6[L13_19]
        L15_21 = L14_20
        L14_20 = L14_20.setDisplayFrame
        L17_23 = L12_18
        L16_22 = L12_18.displayFrame
        L17_23 = L16_22(L17_23)
        L14_20(L15_21, L16_22, L17_23, L16_22(L17_23))
      end
    end
    L14_20 = Logic
    L15_21 = L14_20
    L14_20 = L14_20.Get
    L16_22 = "Hero"
    L14_20 = L14_20(L15_21, L16_22)
    L15_21 = L14_20
    L14_20 = L14_20.GetHeroImage
    L16_22 = L10_16
    L14_20 = L14_20(L15_21, L16_22)
    L15_21 = CCSprite
    L16_22 = L15_21
    L15_21 = L15_21.create
    L17_23 = L14_20
    L15_21 = L15_21(L16_22, L17_23)
    L16_22 = string
    L16_22 = L16_22.format
    L17_23 = "sprIcon%d"
    L16_22 = L16_22(L17_23, L9_15)
    L13_19 = L16_22
    if L15_21 then
      L16_22 = A0_6[L13_19]
      if L16_22 then
        L16_22 = A0_6[L13_19]
        L17_23 = L16_22
        L16_22 = L16_22.setDisplayFrame
        L16_22(L17_23, L15_21:displayFrame())
      end
    end
    L16_22 = string
    L16_22 = L16_22.format
    L17_23 = "ttfName%d"
    L16_22 = L16_22(L17_23, L9_15)
    L13_19 = L16_22
    L16_22 = Logic
    L17_23 = L16_22
    L16_22 = L16_22.Get
    L16_22 = L16_22(L17_23, "Hero")
    L17_23 = L16_22
    L16_22 = L16_22.GetHeroInfoByBaseId
    L16_22 = L16_22(L17_23, L10_16)
    if L16_22 then
      L17_23 = A0_6[L13_19]
      L17_23 = L17_23.setStyle
      L17_23(L17_23, kCCLabelTTFStyleOutline)
      L17_23 = TwGetStr
      L17_23 = L17_23(104250, L16_22.star)
      A0_6[L13_19]:setString(L17_23 .. (L16_22.name or ""))
    end
    L17_23 = Logic
    L17_23 = L17_23.Get
    L17_23 = L17_23(L17_23, "Hero")
    L17_23 = L17_23.getColorByBaseId
    L17_23 = L17_23(L17_23, L10_16)
    A0_6[L13_19]:setColor(L17_23)
    L13_19 = string.format("node%d", L9_15)
    A0_6[L13_19]:setVisible(true)
  end
  L6_12(L7_13)
end
function prototype.showHead(A0_24)
  local L1_25, L2_26, L3_27, L4_28, L5_29, L6_30, L7_31, L8_32
  L1_25 = A0_24.nodeHead1
  L1_25 = L1_25.setVisible
  L1_25(L2_26, L3_27)
  L1_25 = A0_24.nodeHead2
  L1_25 = L1_25.setVisible
  L1_25(L2_26, L3_27)
  L1_25 = Logic
  L1_25 = L1_25.Get
  L1_25 = L1_25(L2_26, L3_27)
  L1_25 = L1_25.GetExchangeId
  L1_25 = L1_25(L2_26)
  for L5_29 = #L1_25, 1, -1 do
    L6_30 = Logic
    L7_31 = L6_30
    L6_30 = L6_30.Get
    L8_32 = "Exchange"
    L6_30 = L6_30(L7_31, L8_32)
    L7_31 = L6_30
    L6_30 = L6_30.GetExchangeCards
    L8_32 = L1_25[L5_29]
    L6_30 = L6_30(L7_31, L8_32)
    L6_30 = L6_30 or {}
    L7_31 = L6_30.mainCard
    L8_32 = #L1_25
    L8_32 = L8_32 - L5_29
    L8_32 = L8_32 + 1
    A0_24:refreshHead(L8_32, L7_31)
  end
end
function prototype.refreshHead(A0_33, A1_34, A2_35)
  local L3_36, L4_37, L5_38, L6_39
  if not A1_34 or not A2_35 then
    return
  end
  L3_36 = "baseId"
  L4_37 = A1_34
  L3_36 = L3_36 .. L4_37
  A0_33[L3_36] = A2_35
  L3_36 = Logic
  L4_37 = L3_36
  L3_36 = L3_36.Get
  L5_38 = "Hero"
  L3_36 = L3_36(L4_37, L5_38)
  L4_37 = L3_36
  L3_36 = L3_36.GetHeroBgImage
  L5_38 = A2_35
  L3_36 = L3_36(L4_37, L5_38)
  L4_37 = L3_36 and L4_37(L5_38, L6_39)
  L5_38 = string
  L5_38 = L5_38.format
  L6_39 = "sprHeadBg%d"
  L5_38 = L5_38(L6_39, A1_34)
  if L4_37 then
    L6_39 = A0_33[L5_38]
    if L6_39 then
      L6_39 = A0_33[L5_38]
      L6_39 = L6_39.setDisplayFrame
      L6_39(L6_39, L4_37:displayFrame())
    end
  end
  L6_39 = Logic
  L6_39 = L6_39.Get
  L6_39 = L6_39(L6_39, "Hero")
  L6_39 = L6_39.GetHeroImage
  L6_39 = L6_39(L6_39, A2_35)
  L5_38 = string.format("sprHeadIcon%d", A1_34)
  if L6_39 and CCSprite:create(L6_39) and A0_33[L5_38] then
    A0_33[L5_38]:setDisplayFrame((L6_39 and CCSprite:create(L6_39)):displayFrame())
  end
  L5_38 = string.format("nodeHead%d", A1_34)
  A0_33[L5_38]:setVisible(true)
end
function prototype.refreshPanel(A0_40, A1_41)
  local L2_42, L3_43, L4_44, L5_45, L6_46, L7_47, L8_48, L9_49, L10_50
  if not A1_41 then
    return
  end
  L2_42 = Logic
  L3_43 = L2_42
  L2_42 = L2_42.Get
  L4_44 = "Exchange"
  L2_42 = L2_42(L3_43, L4_44)
  L3_43 = L2_42
  L2_42 = L2_42.GetComsumeList
  L4_44 = A1_41
  L3_43 = L2_42(L3_43, L4_44)
  L4_44 = false
  A0_40.bCanExchange = true
  for L8_48, L9_49 in L5_45(L6_46) do
    L10_50 = string
    L10_50 = L10_50.format
    L10_50 = L10_50("panel%d", L8_48)
    if L9_49 ~= 0 then
      L4_44 = true
    else
      A0_40.bCanExchange = false
    end
    A0_40[L10_50]:setVisible(L9_49 ~= 0)
    L10_50 = string.format("sprNotEnough%d", L8_48)
    A0_40[L10_50]:setVisible(L9_49 == 0)
  end
  L5_45(L6_46, L7_47)
end
function prototype.checkHasExchange(A0_51, A1_52)
  local L2_53, L3_54, L4_55
  L2_53 = Logic
  L3_54 = L2_53
  L2_53 = L2_53.Get
  L4_55 = "Exchange"
  L2_53 = L2_53(L3_54, L4_55)
  L3_54 = L2_53
  L2_53 = L2_53.GetExchangeRestCount
  L4_55 = A1_52
  L2_53 = L2_53(L3_54, L4_55)
  L3_54 = A0_51.ttfCount
  L4_55 = L3_54
  L3_54 = L3_54.setString
  L3_54(L4_55, L2_53)
  L3_54 = true
  L4_55 = 0
  L4_55 = (KFDBGetRecord("RedCardExchange", A1_52) or {}).playerLevel or 0
  if L4_55 > Logic:Get("PlayerInfo"):GetPlayerLevel() then
    L3_54 = false
    A0_51.ttfExchange:setString(TwGetStr(114005, L4_55))
  end
  if L2_53 <= 0 then
    L3_54 = false
    A0_51.ttfExchange:setString(TwGetStr(114006))
  end
  A0_51.nodeExchange:setVisible(L3_54)
  A0_51.ttfExchange:setVisible(not L3_54)
end
function prototype.onBtnExchange(A0_56, ...)
  if not A0_56.bCanExchange then
    Prompt:Tip(TwGetStr(114007))
    return
  end
  SceneHelper:pushScene("ExchangeChoose", A0_56.rootNode)
end
function prototype.onBtnCardMain(A0_58, ...)
  local L2_60
  L2_60 = A0_58.cardInfo
  if not L2_60 then
    return
  end
  L2_60 = tonumber
  L2_60 = L2_60(A0_58.cardInfo.mainCard)
  if not L2_60 then
    L2_60 = A0_58.cardInfo
    L2_60 = L2_60.mainCard
  end
  Logic:Get("HeroCardInfo"):OpenHeroInfoById(L2_60)
end
function prototype.onBtnCards(A0_61, A1_62, A2_63)
  local L3_64, L4_65, L5_66, L6_67, L7_68
  for L7_68 = 1, 4 do
    if A0_61[string.format("btn%d", L7_68)] == A1_62 then
      L3_64 = L7_68
      break
    end
  end
  L7_68 = "Exchange"
  L7_68 = L4_65
  if L5_66 then
    L7_68 = Logic
    L7_68 = L7_68.Get
    L7_68 = L7_68(L7_68, "Exchange")
    L7_68 = L7_68.AddExchangeId
    L7_68(L7_68, L6_67)
    L7_68 = A0_61.refreshByExchangeId
    L7_68(A0_61)
  else
    L7_68 = Logic
    L7_68 = L7_68.Get
    L7_68 = L7_68(L7_68, "HeroCardInfo")
    L7_68 = L7_68.OpenHeroInfoById
    L7_68(L7_68, L4_65)
  end
end
function prototype.onBtnRecharge(A0_69, ...)
  Logic:Get("Main"):GotoRecharge()
end
function prototype.onBtnReturn(A0_71, ...)
  SceneHelper:runWithScene("GiftActivityList", A0_71.rootNode)
end
function prototype.onBtnHead1(A0_73, ...)
  local L2_75
  L2_75 = A0_73.baseId1
  if not L2_75 then
    return
  end
  L2_75 = Logic
  L2_75 = L2_75.Get
  L2_75 = L2_75(L2_75, "Exchange")
  L2_75 = L2_75.GetExchangeIdByDestId
  L2_75 = L2_75(L2_75, A0_73.baseId1)
  Logic:Get("Exchange"):RemoveExchangeId()
  Logic:Get("Exchange"):AddExchangeId(L2_75)
  A0_73:refreshByExchangeId()
end
function prototype.onBtnHead2(A0_76, ...)
  if not A0_76.baseId2 then
    return
  end
  Logic:Get("Exchange"):RemoveExchangeId()
  A0_76:refreshByExchangeId()
end
function prototype.OnUIGetCards(A0_78)
  local L1_79, L2_80, L3_81, L4_82, L5_83, L6_84
  L1_79 = Logic
  L2_80 = L1_79
  L1_79 = L1_79.Get
  L1_79 = L1_79(L2_80, L3_81)
  L2_80 = L1_79
  L1_79 = L1_79.GetActivityGift
  L1_79 = L1_79(L2_80)
  L2_80 = 1001
  for L6_84 = 1, L4_82(L5_83) do
    if L1_79.id == (KFDBGetRecordByIdx("RedCardExchange", L6_84) or {}).activityId then
      L2_80 = (KFDBGetRecordByIdx("RedCardExchange", L6_84) or {}).id
      break
    end
  end
  L3_81(L4_82, L5_83)
  L3_81(L4_82)
end
function prototype.OnPopTip(A0_85)
  local L1_86, L2_87, L3_88, L4_89, L5_90, L6_91
  L1_86 = Logic
  L2_87 = L1_86
  L1_86 = L1_86.Get
  L3_88 = "Exchange"
  L1_86 = L1_86(L2_87, L3_88)
  L2_87 = L1_86
  L1_86 = L1_86.GetExchangeCardsInfo
  L1_86 = L1_86(L2_87)
  L2_87 = Logic
  L3_88 = L2_87
  L2_87 = L2_87.Get
  L4_89 = "Exchange"
  L2_87 = L2_87(L3_88, L4_89)
  L3_88 = L2_87
  L2_87 = L2_87.GetExchangeId
  L3_88 = L2_87(L3_88)
  L4_89 = Logic
  L5_90 = L4_89
  L4_89 = L4_89.Get
  L6_91 = "Hero"
  L4_89 = L4_89(L5_90, L6_91)
  L5_90 = L4_89
  L4_89 = L4_89.GetHeroInfoByBaseId
  L6_91 = L3_88
  L4_89 = L4_89(L5_90, L6_91)
  L4_89 = L4_89 or {}
  if L1_86 then
    L5_90 = L4_89.name
    if L5_90 then
      L5_90 = TwGetStr
      L6_91 = 114003
      L5_90 = L5_90(L6_91, L4_89.star or 1, L4_89.name or "")
      L6_91 = TwGetStr
      L6_91 = L6_91(114004, L1_86, L5_90)
      Prompt:Select(A0_85, "", L6_91, A0_85.OnConfirmExchange)
    end
  end
end
function prototype.OnConfirmExchange(A0_92, A1_93)
  if A1_93 == Prompt.RET.OK then
    Logic:Get("Exchange"):PostExchange(A0_92.curId)
  end
end
function prototype.OnExhanged(A0_94, A1_95)
  Prompt:Tip(A1_95)
  A0_94:refreshByExchangeId()
end
