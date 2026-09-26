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
L0_0 = 246
function prototype.onBtnReturn(A0_1)
  SceneHelper:runWithScene("GiftActivityList", A0_1.rootNode)
end
function prototype.onBtnRank(A0_2, A1_3, A2_4)
  SceneHelper:runWithScene("ConsumeRank", A0_2.rootNode)
end
function prototype.onEnter(A0_5)
  super.onEnter(A0_5)
  Logic:Get("Consume"):On(Logic.Consume.EVT.GET_INFO, A0_5:Event("onGetInfo"))
  Logic:Get("Consume"):PostGetInfo()
  A0_5:RefreInfo()
  A0_5:TipConsumeReward()
end
function prototype.RefreInfo(A0_6)
  A0_6.title_ttf:setColor(ccc3(255, 183, 18))
  A0_6.title_ttf:setString(Logic:Get("Gift"):GetActivityGift().name)
  A0_6.title_ttf:setStyle(kCCLabelTTFStyleOutline)
  A0_6:straHeroMove()
  A0_6:setContent()
  A0_6:SetNumberOne()
end
function prototype.onGetInfo(A0_7)
  A0_7:SetNumberOne()
  A0_7:onTimer()
  if not A0_7.eventTracer:Exist("onTimer") then
    Singleton(Timer):Repeat(1000, A0_7:Event("onTimer"))
  end
end
function prototype.setContent(A0_8)
  local L1_9, L2_10, L3_11, L4_12
  for L4_12 = 1, 2 do
    if KFDBGetRecord("LanguageSetting", 1017 + L4_12) then
      A0_8[string.format("content%d", L4_12)]:setString(ReplaceStringTab(KFDBGetRecord("LanguageSetting", 1017 + L4_12).content))
      A0_8[string.format("content%d", L4_12)]:setStyle(kCCLabelTTFStyleOutline)
      A0_8[string.format("content%d", L4_12)]:setDimensions(CCSize(200, 0))
      A0_8[string.format("content%d", L4_12)]:setFontSize(19)
    end
  end
  if L1_9 == nil then
    return
  end
  L4_12 = "LanguageSetting"
  if L3_11 == nil then
    return
  end
  L4_12 = string
  L4_12 = L4_12.gsub
  L4_12 = L4_12(L3_11.content, "{NAME}", "<font SIZE='19' color='#FF8600'>" .. L1_9.name .. "</font>")
  L4_12 = string.format(L2_10, L4_12)
  A0_8.content5:setString(L4_12)
end
function prototype.SetNumberOne(A0_13)
  local L1_14, L2_15
  L1_14 = A0_13.ttfName
  L2_15 = L1_14
  L1_14 = L1_14.setStyle
  L1_14(L2_15, kCCLabelTTFStyleOutline)
  L1_14 = A0_13.numberOne
  L2_15 = L1_14
  L1_14 = L1_14.setStyle
  L1_14(L2_15, kCCLabelTTFStyleOutline)
  L1_14 = A0_13.ttf_myName
  L2_15 = L1_14
  L1_14 = L1_14.setStyle
  L1_14(L2_15, kCCLabelTTFStyleOutline)
  L1_14 = A0_13.ttf_myValue
  L2_15 = L1_14
  L1_14 = L1_14.setStyle
  L1_14(L2_15, kCCLabelTTFStyleOutline)
  L1_14 = Logic
  L2_15 = L1_14
  L1_14 = L1_14.Get
  L1_14 = L1_14(L2_15, "Consume")
  L2_15 = L1_14
  L1_14 = L1_14.getConsumeRankInfo
  L1_14 = L1_14(L2_15)
  if L1_14 ~= nil then
    L2_15 = next
    L2_15 = L2_15(L1_14)
  elseif L2_15 == nil then
    return
  end
  L2_15 = L1_14.topName
  if L2_15 ~= nil then
    L2_15 = A0_13.ttfName
    L2_15 = L2_15.setString
    L2_15(L2_15, L1_14.topName)
  end
  L2_15 = protocol
  L2_15 = L2_15.Id2Str
  L2_15 = L2_15(L1_14.topScore)
  if not L2_15 then
    L2_15 = L1_14.topScore
    L2_15 = L2_15 or 0
  end
  A0_13.numberOne:setString(tostring(tonumber(L2_15) or 0))
  if L1_14.rank ~= 0 then
    A0_13.ttf_myName:setString(L1_14.rank)
  end
  A0_13.ttf_myValue:setString(L1_14.score or 0)
end
function prototype.setHero(A0_16)
  local L1_17, L2_18, L3_19, L4_20, L5_21, L6_22
  L2_18 = A0_16
  L1_17 = A0_16.GetRewardCardInfo
  L1_17 = L1_17(L2_18)
  if L1_17 ~= nil then
    L2_18 = L1_17.showType
    if L2_18 ~= nil then
      L2_18 = L1_17.showId
    end
  elseif L2_18 == nil then
    return
  end
  L2_18 = {}
  L3_19 = L1_17.showType
  L3_19 = L3_19[1]
  L2_18.showType = L3_19
  L3_19 = L1_17.showId
  L3_19 = L3_19[1]
  L2_18.showId = L3_19
  A0_16.topRankRewardInfo = L2_18
  L2_18 = A0_16.topRankRewardInfo
  L2_18 = L2_18.showId
  L3_19 = false
  L4_20 = A0_16.topRankRewardInfo
  L4_20 = L4_20.showType
  if L4_20 == "TALISMAN" then
    L4_20 = KFDBGetRecord
    L5_21 = "TalismanSetting"
    L6_22 = L2_18
    L4_20 = L4_20(L5_21, L6_22)
    L2_18 = L4_20.baseId
    L3_19 = true
  end
  A0_16.baseId = L2_18
  L4_20 = Logic
  L5_21 = L4_20
  L4_20 = L4_20.Get
  L6_22 = "HeroCardInfo"
  L4_20 = L4_20(L5_21, L6_22)
  L5_21 = L4_20
  L4_20 = L4_20.createHeroCard
  L6_22 = A0_16.baseId
  L4_20 = L4_20(L5_21, L6_22, 200, nil, nil, nil, nil, L3_19)
  L5_21 = A0_16.rootNode
  L6_22 = L5_21
  L5_21 = L5_21.addChild
  L5_21(L6_22, L4_20, 0, 2)
  L6_22 = L4_20
  L5_21 = L4_20.setPosition
  L5_21(L6_22, A0_16.heroImg:getPosition())
  L5_21 = Logic
  L6_22 = L5_21
  L5_21 = L5_21.Get
  L5_21 = L5_21(L6_22, "HeroCardInfo")
  L6_22 = L5_21
  L5_21 = L5_21.kdbBaseHero
  L5_21 = L5_21(L6_22, A0_16.baseId)
  if L5_21 ~= nil then
    L6_22 = A0_16.heroName
    L6_22 = L6_22.setString
    L6_22(L6_22, L5_21.name)
  end
  L6_22 = Logic
  L6_22 = L6_22.Get
  L6_22 = L6_22(L6_22, "Hero")
  L6_22 = L6_22.getColorByBaseId
  L6_22 = L6_22(L6_22, A0_16.baseId)
  if L6_22 == nil then
    return
  end
  A0_16.heroName:setStyle(kCCLabelTTFStyleOutline)
  A0_16.heroName:setColor(L6_22)
end
function prototype.onBtnCheckHero(A0_23)
  local L1_24
  L1_24 = A0_23.topRankRewardInfo
  L1_24 = L1_24.showType
  if L1_24 == "TALISMAN" then
    L1_24 = {}
    L1_24.id = "2.816455e+014"
    L1_24.level = 10
    L1_24.baseId = A0_23.topRankRewardInfo.showId
    L1_24.exp = 0
    Logic:Get("HeroCardInfo"):OpenTailsman(L1_24)
  else
    L1_24 = {}
    L1_24.exp = 0
    L1_24.id = 68719480211
    L1_24.level = 100
    L1_24.baseId = A0_23.baseId or 1
    L1_24.powerSkill = 0
    Logic:Get("HeroCardInfo"):OpenHeroInfoByNparma(L1_24)
  end
end
function prototype.onBtnOpenRankReward(A0_25)
  SceneHelper:runWithScene("GiftActivityInfoConsumeReward", A0_25.rootNode)
end
function prototype.onBtnPoints(A0_26)
  SceneHelper:runWithScene("ConsumeGift", A0_26.rootNode)
end
function prototype.onTimer(A0_27)
  local L1_28, L2_29, L3_30
  L1_28 = Logic
  L2_29 = L1_28
  L1_28 = L1_28.Get
  L3_30 = "Consume"
  L1_28 = L1_28(L2_29, L3_30)
  L2_29 = L1_28
  L1_28 = L1_28.getCloseTime
  L1_28 = L1_28(L2_29)
  L2_29 = A0_27.ttfTime
  L3_30 = L2_29
  L2_29 = L2_29.setStyle
  L2_29(L3_30, kCCLabelTTFStyleOutline)
  if L1_28 and L1_28 ~= 0 then
    L2_29 = Logic
    L3_30 = L2_29
    L2_29 = L2_29.Get
    L2_29 = L2_29(L3_30, "System")
    L3_30 = L2_29
    L2_29 = L2_29.DiffTime
    L2_29 = L2_29(L3_30, L1_28 / 1000)
    L3_30 = Logic
    L3_30 = L3_30.Get
    L3_30 = L3_30(L3_30, "System")
    L3_30 = L3_30.SecToDay
    L3_30 = L3_30(L3_30, L2_29)
    L1_28 = L3_30
    if L1_28 and L2_29 > 0 then
      L3_30 = L1_28.hour
      L3_30 = L3_30 + L1_28.day * 24
      L1_28.hour = L3_30
      L3_30 = string
      L3_30 = L3_30.format
      L3_30 = L3_30("%02d:%02d:%02d", L1_28.hour or 0, L1_28.min or 0, L1_28.sec or 0)
      A0_27.ttfTime:setString(L3_30)
    else
      L3_30 = A0_27.ttfTime
      L3_30 = L3_30.setString
      L3_30(L3_30, "")
    end
  else
    L2_29 = A0_27.ttfTime
    L3_30 = L2_29
    L2_29 = L2_29.setString
    L2_29(L3_30, "")
  end
end
function prototype.TipConsumeReward(A0_31)
  if Logic:Get("Consume"):hasConsumeReward() then
    if A0_31.rootNode:getChildByTag(11) == nil then
      A0_31:showRewardTip()
    end
  else
    if A0_31.ani ~= nil then
      A0_31.ani:RemoveAnimation()
    end
    A0_31.rootNode:removeChildByTag(11, true)
  end
end
function prototype.showRewardTip(A0_32)
  local L1_33, L2_34, L3_35
  L1_33 = A0_32.sprNewTip
  L2_34 = L1_33
  L1_33 = L1_33.getPositionX
  L1_33 = L1_33(L2_34)
  L2_34 = A0_32.sprNewTip
  L3_35 = L2_34
  L2_34 = L2_34.getPositionY
  L2_34 = L2_34(L3_35)
  L3_35 = Logic
  L3_35 = L3_35.Get
  L3_35 = L3_35(L3_35, "AniMgr")
  L3_35 = L3_35.RunCCBAni
  L3_35 = L3_35(L3_35, "UI/uinew", A0_32, ccp(L1_33, L2_34), 0.7)
  A0_32.ani = L3_35
  L3_35 = CCSprite
  L3_35 = L3_35.create
  L3_35 = L3_35(L3_35, "images/public/tip.png")
  if L3_35 ~= nil then
    A0_32.rootNode:addChild(L3_35, 0, 11)
    L3_35:setAnchorPoint(CCPoint(0.5, 0.5))
    L3_35:setPosition(ccp(L1_33, L2_34))
    L3_35:setScale(0.8)
  end
end
function prototype.GetRewardCardInfo(A0_36)
  local L1_37, L2_38, L3_39, L4_40, L5_41
  L1_37 = Logic
  L1_37 = L1_37.Get
  L1_37 = L1_37(L2_38, L3_39)
  L1_37 = L1_37.GetActivityGift
  L1_37 = L1_37(L2_38)
  for L5_41 = 1, L3_39(L4_40) do
    if KFDBGetRecordByIdx("ScoreRankReward", L5_41) and KFDBGetRecordByIdx("ScoreRankReward", L5_41).activityId == L1_37.id then
      return json.decode(KFDBGetRecordByIdx("ScoreRankReward", L5_41).rewardShow) or {}
    end
  end
end
function prototype.straHeroMove(A0_42)
  local L1_43, L2_44, L3_45, L4_46, L5_47, L6_48, L7_49, L8_50
  L1_43 = A0_42.GetRewardCardInfo
  L1_43 = L1_43(L2_44)
  L3_45 = L1_43 or {}
  if L2_44 then
    return
  end
  A0_42.baseIdDouble = L2_44
  for L5_47 = 1, #L3_45 do
    L6_48.showType = L7_49
    L6_48.showId = L7_49
    L6_48.level = L7_49
    L8_50 = A0_42.baseIdDouble
    L7_49(L8_50, L6_48)
  end
  A0_42.baseIdDouble = L2_44
  for L7_49 = 1, #L5_47 do
    L8_50 = string
    L8_50 = L8_50.format
    L8_50 = L8_50("subScene%d", L7_49)
    A0_42[L8_50] = Tw.Controller:load("LotteryMove", A0_42.rootNode)
  end
  L8_50 = A0_42.baseIdDouble
  L8_50 = #L8_50
  L8_50 = 246 * L8_50
  L8_50 = L8_50 / 2
  L8_50 = L7_49(L8_50, 280)
  L5_47(L6_48, L7_49, L8_50, L7_49(L8_50, 280))
  for L8_50 = 1, #L6_48 do
    if A0_42[string.format("subScene%d", L8_50)] then
      A0_42[string.format("subScene%d", L8_50)]:setCardData(A0_42.baseIdDouble[L8_50])
      A0_42[string.format("subScene%d", L8_50)]:setPosition(ccp(L2_44 + L8_50 * _UPVALUE0_, L3_45))
      L4_46:addChild(A0_42[string.format("subScene%d", L8_50)])
    end
  end
  L8_50 = 246
  L8_50 = L7_49(L8_50, 280)
  L8_50 = kCCScrollViewDirectionHorizontal
  L6_48(L7_49, L8_50)
  L8_50 = true
  L6_48(L7_49, L8_50)
  L8_50 = false
  L6_48(L7_49, L8_50)
  L8_50 = L4_46
  L6_48(L7_49, L8_50)
  L6_48(L7_49)
  A0_42.scrollTag = L6_48
  L8_50 = L5_47
  L6_48(L7_49, L8_50)
  L8_50 = true
  L6_48(L7_49, L8_50)
  L8_50 = bind
  L8_50 = L8_50(A0_42.onTouch, A0_42)
  L6_48(L7_49, L8_50, false, 300, true)
  L8_50 = L5_47.getContentOffset
  L8_50 = L8_50(L5_47)
  L8_50 = L8_50.x
  L8_50 = L8_50 - (#A0_42.baseIdDouble / 2 + 1) * _UPVALUE0_
  L6_48(L7_49, L8_50)
  if L6_48 > 2 then
    L6_48(L7_49)
    return
  end
end
function prototype.moveItem(A0_51)
  local L1_52, L2_53, L3_54
  L1_52 = tolua
  L1_52 = L1_52.cast
  L2_53 = A0_51.lstCard
  L3_54 = L2_53
  L2_53 = L2_53.getChildByTag
  L2_53 = L2_53(L3_54, A0_51.scrollTag)
  L3_54 = "CCScrollViewEx"
  L1_52 = L1_52(L2_53, L3_54)
  if L1_52 == nil then
    return
  end
  L3_54 = L1_52
  L2_53 = L1_52.getContainer
  L2_53 = L2_53(L3_54)
  L3_54 = CCArray
  L3_54 = L3_54.create
  L3_54 = L3_54(L3_54)
  L3_54:addObject(CCCallFuncN:create(function()
    if _UPVALUE0_:getContentOffset().x <= -(#_UPVALUE1_.baseIdDouble - 1) * _UPVALUE2_ then
      _UPVALUE3_:setPositionX(-((#_UPVALUE1_.baseIdDouble / 2 - 1) * _UPVALUE2_))
    else
      _UPVALUE3_:setPositionX(_UPVALUE3_:getPositionX() - 0.5)
    end
  end))
  L2_53:runAction(CCRepeatForever:create(CCSequence:create(L3_54)))
end
function prototype.onTouch(A0_55, A1_56, A2_57)
  if A1_56 == CCTOUCHBEGAN and A0_55:isTouchInScoreView(A2_57) then
    A0_55:onTouchBegined(A2_57)
  elseif A1_56 == CCTOUCHENDED then
    A0_55:onTouchEnded(A2_57)
  end
end
function prototype.onTouchBegined(A0_58, A1_59)
  if tolua.cast(A0_58.lstCard:getChildByTag(A0_58.scrollTag), "CCScrollViewEx") == nil then
    return
  end
  if A0_58:isTouchInScoreView(A1_59) then
    A0_58.startPos = A1_59
    tolua.cast(A0_58.lstCard:getChildByTag(A0_58.scrollTag), "CCScrollViewEx"):getContainer():stopAllActions()
  end
end
function prototype.onTouchEnded(A0_60, A1_61)
  local L2_62, L3_63, L4_64, L5_65, L6_66, L7_67, L8_68, L9_69
  L3_63 = A0_60
  L2_62 = A0_60.isTouchInScoreView
  L4_64 = A0_60.startPos
  L2_62 = L2_62(L3_63, L4_64)
  if not L2_62 then
    return
  end
  L2_62 = A0_60.baseIdDouble
  L2_62 = #L2_62
  if L2_62 < 3 then
    L2_62 = math
    L2_62 = L2_62.abs
    L3_63 = A0_60.startPos
    L3_63 = L3_63[1]
    L4_64 = A1_61[1]
    L3_63 = L3_63 - L4_64
    L2_62 = L2_62(L3_63)
    if L2_62 <= 20 then
      L2_62 = math
      L2_62 = L2_62.abs
      L3_63 = A0_60.startPos
      L3_63 = L3_63[2]
      L4_64 = A1_61[2]
      L3_63 = L3_63 - L4_64
      L2_62 = L2_62(L3_63)
      if L2_62 <= 20 then
        L3_63 = A0_60
        L2_62 = A0_60.isTouchInScoreView
        L4_64 = A1_61
        L2_62 = L2_62(L3_63, L4_64)
        if L2_62 then
          L3_63 = A0_60
          L2_62 = A0_60.clickHeroIcon
          L4_64 = A1_61
          L2_62(L3_63, L4_64)
          A0_60.startPos = nil
        end
      end
    end
    return
  end
  L2_62 = Logic
  L3_63 = L2_62
  L2_62 = L2_62.Get
  L4_64 = "System"
  L2_62 = L2_62(L3_63, L4_64)
  L3_63 = L2_62
  L2_62 = L2_62.GetTime
  L2_62 = L2_62(L3_63)
  A0_60.timer = L2_62
  L2_62 = A0_60.eventTracer
  L3_63 = L2_62
  L2_62 = L2_62.Exist
  L4_64 = "runActionAgain"
  L2_62 = L2_62(L3_63, L4_64)
  if not L2_62 then
    L2_62 = Singleton
    L3_63 = Timer
    L2_62 = L2_62(L3_63)
    L3_63 = L2_62
    L2_62 = L2_62.Repeat
    L4_64 = 1000
    L6_66 = A0_60
    L5_65 = A0_60.Event
    L7_67 = "runActionAgain"
    L9_69 = L5_65(L6_66, L7_67)
    L2_62(L3_63, L4_64, L5_65, L6_66, L7_67, L8_68, L9_69, L5_65(L6_66, L7_67))
  end
  L2_62 = math
  L2_62 = L2_62.abs
  L3_63 = A0_60.startPos
  L3_63 = L3_63[1]
  L4_64 = A1_61[1]
  L3_63 = L3_63 - L4_64
  L2_62 = L2_62(L3_63)
  if L2_62 <= 20 then
    L2_62 = math
    L2_62 = L2_62.abs
    L3_63 = A0_60.startPos
    L3_63 = L3_63[2]
    L4_64 = A1_61[2]
    L3_63 = L3_63 - L4_64
    L2_62 = L2_62(L3_63)
    if L2_62 <= 20 then
      L3_63 = A0_60
      L2_62 = A0_60.isTouchInScoreView
      L4_64 = A1_61
      L2_62 = L2_62(L3_63, L4_64)
      if L2_62 then
        L3_63 = A0_60
        L2_62 = A0_60.clickHeroIcon
        L4_64 = A1_61
        L2_62(L3_63, L4_64)
        A0_60.startPos = nil
        return
      end
    end
  end
  L2_62 = tolua
  L2_62 = L2_62.cast
  L3_63 = A0_60.lstCard
  L4_64 = L3_63
  L3_63 = L3_63.getChildByTag
  L5_65 = A0_60.scrollTag
  L3_63 = L3_63(L4_64, L5_65)
  L4_64 = "CCScrollViewEx"
  L2_62 = L2_62(L3_63, L4_64)
  if L2_62 == nil then
    return
  end
  L4_64 = L2_62
  L3_63 = L2_62.getContainer
  L3_63 = L3_63(L4_64)
  L5_65 = L2_62
  L4_64 = L2_62.getContentOffset
  L4_64 = L4_64(L5_65)
  L4_64 = L4_64.x
  L5_65 = math
  L5_65 = L5_65.ceil
  L6_66 = _UPVALUE0_
  L6_66 = L4_64 / L6_66
  L5_65 = L5_65(L6_66)
  L6_66 = _UPVALUE0_
  L5_65 = L5_65 * L6_66
  L6_66 = 0
  L7_67 = nil
  L8_68 = A0_60.startPos
  L8_68 = L8_68[1]
  L9_69 = A1_61[1]
  if L8_68 > L9_69 then
    L8_68 = _UPVALUE0_
    L6_66 = L5_65 - L8_68
  else
    L8_68 = A0_60.startPos
    L8_68 = L8_68[1]
    L9_69 = A1_61[1]
    if L8_68 < L9_69 then
      L8_68 = _UPVALUE0_
      L6_66 = L5_65 + L8_68
      L8_68 = _UPVALUE0_
      L8_68 = -L8_68
      if L6_66 >= L8_68 then
        L8_68 = _UPVALUE0_
        L6_66 = -L8_68
      end
    end
  end
  L8_68 = CCMoveTo
  L9_69 = L8_68
  L8_68 = L8_68.create
  L8_68 = L8_68(L9_69, 0.5, ccp(L6_66, L2_62:getContentOffset().y))
  L7_67 = L8_68
  L8_68 = CCArray
  L9_69 = L8_68
  L8_68 = L8_68.create
  L8_68 = L8_68(L9_69)
  L9_69 = L8_68.addObject
  L9_69(L8_68, L7_67)
  L9_69 = _UPVALUE0_
  L9_69 = -L9_69
  if L6_66 >= L9_69 then
    function L9_69()
      _UPVALUE0_:setPositionX(-((#_UPVALUE1_.baseIdDouble / 2 + 1) * _UPVALUE2_))
    end
    L8_68:addObject(CCCallFuncN:create(L9_69))
  end
  L9_69 = A0_60.baseIdDouble
  L9_69 = #L9_69
  L9_69 = L9_69 - 1
  L9_69 = -L9_69
  L9_69 = L9_69 * _UPVALUE0_
  if L6_66 < L9_69 then
    function L9_69()
      _UPVALUE0_:setPositionX(-(#_UPVALUE1_.baseIdDouble / 2 * _UPVALUE2_))
    end
    L8_68:addObject(CCCallFuncN:create(L9_69))
  end
  if L8_68 then
    L9_69 = L3_63.runAction
    L9_69(L3_63, CCSequence:create(L8_68))
  end
  A0_60.startPos = nil
end
function prototype.runActionAgain(A0_70)
  local L1_71
  L1_71 = Logic
  L1_71 = L1_71.Get
  L1_71 = L1_71(L1_71, "System")
  L1_71 = L1_71.GetTime
  L1_71 = L1_71(L1_71)
  if Logic:Get("System"):DiffTime(L1_71, A0_70.timer) >= 2 then
    A0_70:EventTracer():Cancel("runActionAgain")
    A0_70:moveItem()
  end
end
function prototype.isTouchInScoreView(A0_72, A1_73)
  if A1_73 == nil or table.empty(A1_73) or A1_73[1] == nil or A1_73[2] == nil then
    return false
  end
  if A0_72.lstCard:getPositionX() <= A1_73[1] and A1_73[1] <= A0_72.lstCard:getPositionX() + A0_72.lstCard:getContentSize().width and A0_72.lstCard:getPositionY() <= A1_73[2] and A1_73[2] <= A0_72.lstCard:getPositionY() + A0_72.lstCard:getContentSize().height then
    return true
  end
  return false
end
function prototype.clickHeroIcon(A0_74, A1_75)
  local L2_76, L3_77, L4_78, L5_79, L6_80, L7_81
  if A1_75 ~= nil then
    L2_76 = table
    L2_76 = L2_76.empty
    L3_77 = A1_75
    L2_76 = L2_76(L3_77)
  elseif L2_76 then
    return
  end
  L2_76 = tolua
  L2_76 = L2_76.cast
  L3_77 = A0_74.lstCard
  L3_77 = L3_77.getChildByTag
  L3_77 = L3_77(L4_78, L5_79)
  L2_76 = L2_76(L3_77, L4_78)
  if L2_76 == nil then
    return
  end
  L3_77 = L2_76.getContainer
  L3_77 = L3_77(L4_78)
  for L7_81 = 1, #L5_79 do
    if A0_74[string.format("subScene%d", L7_81)] and L2_76:getContentOffset().x + A0_74[string.format("subScene%d", L7_81)]:getPositionX() <= A1_75[1] and A1_75[1] <= L2_76:getContentOffset().x + A0_74[string.format("subScene%d", L7_81)]:getPositionX() + A0_74[string.format("subScene%d", L7_81)]:getContentSize().width then
      A0_74[string.format("subScene%d", L7_81)]:onBtnConsume()
      return
    end
  end
end
