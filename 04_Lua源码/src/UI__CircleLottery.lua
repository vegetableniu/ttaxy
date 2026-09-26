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
L0_0 = 247
function prototype.onEnter(A0_1)
  local L1_2, L2_3, L3_4
  L1_2 = super
  L1_2 = L1_2.onEnter
  L2_3 = A0_1
  L1_2(L2_3)
  L1_2 = A0_1.title_ttf
  L2_3 = L1_2
  L1_2 = L1_2.setStyle
  L3_4 = kCCLabelTTFStyleOutline
  L1_2(L2_3, L3_4)
  L1_2 = A0_1.ttfTip
  L2_3 = L1_2
  L1_2 = L1_2.setStyle
  L3_4 = kCCLabelTTFStyleOutline
  L1_2(L2_3, L3_4)
  L1_2 = A0_1.ttfTime
  L2_3 = L1_2
  L1_2 = L1_2.setStyle
  L3_4 = kCCLabelTTFStyleOutline
  L1_2(L2_3, L3_4)
  L1_2 = A0_1.ttfDesc
  L2_3 = L1_2
  L1_2 = L1_2.setStyle
  L3_4 = kCCLabelTTFStyleOutline
  L1_2(L2_3, L3_4)
  L1_2 = A0_1.sprAniPoint
  L2_3 = L1_2
  L1_2 = L1_2.setVisible
  L3_4 = false
  L1_2(L2_3, L3_4)
  L1_2 = A0_1.sprClicked
  L2_3 = L1_2
  L1_2 = L1_2.setVisible
  L3_4 = false
  L1_2(L2_3, L3_4)
  L1_2 = A0_1.ttfCost
  L2_3 = L1_2
  L1_2 = L1_2.setVisible
  L3_4 = false
  L1_2(L2_3, L3_4)
  L1_2 = A0_1.sprShuffle
  L2_3 = L1_2
  L1_2 = L1_2.setVisible
  L3_4 = false
  L1_2(L2_3, L3_4)
  L1_2 = Logic
  L2_3 = L1_2
  L1_2 = L1_2.Get
  L3_4 = "Gift"
  L1_2 = L1_2(L2_3, L3_4)
  L2_3 = L1_2
  L1_2 = L1_2.GetActivityGift
  L1_2 = L1_2(L2_3)
  L2_3 = A0_1.title_ttf
  L3_4 = L2_3
  L2_3 = L2_3.setString
  L2_3(L3_4, L1_2.name)
  L2_3 = A0_1.title_ttf
  L3_4 = L2_3
  L2_3 = L2_3.setColor
  L2_3(L3_4, ccc3(255, 183, 18))
  L2_3 = A0_1.ttfTip
  L3_4 = L2_3
  L2_3 = L2_3.setString
  L2_3(L3_4, TwGetStr(111301))
  L2_3 = KFDBGetRecord
  L3_4 = "LanguageSetting"
  L2_3 = L2_3(L3_4, _UPVALUE0_)
  L3_4 = ReplaceStringTab
  L3_4 = L3_4(L2_3.content)
  A0_1.ttfDesc:setString(L3_4)
  A0_1.orgXPos = A0_1.subNode:getPositionX()
  A0_1.orgYPos = A0_1.subNode:getPositionY()
  A0_1.needRequestNewData = false
  A0_1.cardShuffleAni = Logic:Get("AniMgr"):NewCCB("UI/UIxipai", A0_1, ccp(320, 555), 0, nil, nil)
  A0_1.cardShuffleAni:setVisible(false)
  Logic:Get("Raffle"):PostLoadRaffle()
  Logic:Get("Raffle"):On(Logic.Raffle.EVT.GET_RAFFLE_OK, A0_1:Event("createLotterysImages"))
  Logic:Get("Raffle"):On(Logic.Raffle.EVT.RAFFLE_OK, A0_1:Event("raffleResultShow"))
end
function prototype.createLotterysImages(A0_5, A1_6)
  local L2_7, L3_8, L4_9, L5_10, L6_11, L7_12, L8_13
  L2_7(L3_8, L4_9)
  L2_7(L3_8, L4_9)
  L2_7(L3_8, L4_9)
  if A1_6 then
  elseif not L2_7 then
    A0_5.rewards = L2_7
    A0_5.counts = 0
    A0_5.needRequestNewData = true
    L2_7(L3_8, L4_9)
    L2_7(L3_8, L4_9)
    for L5_10 = 1, 71 do
      L6_11 = string
      L6_11 = L6_11.format
      L7_12 = "item%d"
      L8_13 = L5_10
      L6_11 = L6_11(L7_12, L8_13)
      A0_5[L6_11] = nil
    end
    L2_7(L3_8, L4_9)
    L2_7(L3_8, L4_9)
    L2_7(L3_8, L4_9)
    return
  end
  L2_7(L3_8, L4_9)
  L2_7(L3_8, L4_9)
  L2_7(L3_8, L4_9)
  A0_5.rewards = A1_6
  A0_5.counts = L2_7
  L6_11 = 111305
  L7_12 = L2_7
  L8_13 = L5_10(L6_11, L7_12)
  L3_8(L4_9, L5_10, L6_11, L7_12, L8_13, L5_10(L6_11, L7_12))
  L3_8(L4_9, L5_10)
  A0_5.needRequestNewData = false
  L3_8(L4_9, L5_10)
  for L6_11 = 1, A0_5.counts do
    L8_13 = A0_5
    L7_12 = A0_5.calculateItemPosition
    L8_13 = L7_12(L8_13, L6_11)
    A0_5[string.format("item%d", L6_11)] = Tw.Controller:load("CircleLotteryIcon", A0_5.rootNode)
    A0_5[string.format("item%d", L6_11)]:setAnchorPoint(CCPointMake(0, 0))
    A0_5[string.format("item%d", L6_11)]:setScale(0.9)
    A0_5[string.format("item%d", L6_11)]:setPosition(CCPointMake(L7_12, L8_13))
    A0_5[string.format("item%d", L6_11)]:refreshItem(L6_11, A1_6[L6_11])
    A0_5.subNode:addChild(A0_5[string.format("item%d", L6_11)])
  end
  L3_8(L4_9, L5_10)
  L3_8(L4_9)
  if not L3_8 then
    L7_12 = A0_5
    L6_11 = A0_5.Event
    L8_13 = "refreshResetTime"
    L8_13 = L6_11(L7_12, L8_13)
    L3_8(L4_9, L5_10, L6_11, L7_12, L8_13, L6_11(L7_12, L8_13))
  end
end
function prototype.refreshResetTime(A0_14)
  local L1_15, L2_16, L3_17, L4_18, L5_19
  L1_15 = KFDBGetRecord
  L2_16 = "ConfigValue"
  L3_17 = "RAFFLE:RESET_HOUR"
  L1_15 = L1_15(L2_16, L3_17)
  if L1_15 then
    L2_16 = tonumber
    L3_17 = L1_15.content
    L2_16 = L2_16(L3_17)
    L2_16 = L2_16 * 3600
  else
    L1_15 = L2_16 or 0
  end
  L2_16 = Logic
  L3_17 = L2_16
  L2_16 = L2_16.Get
  L4_18 = "Raffle"
  L2_16 = L2_16(L3_17, L4_18)
  L3_17 = L2_16
  L2_16 = L2_16.getResetTime
  L2_16 = L2_16(L3_17)
  L3_17 = L1_15 * 1000
  L2_16 = L2_16 + L3_17
  L3_17 = Logic
  L4_18 = L3_17
  L3_17 = L3_17.Get
  L5_19 = "System"
  L3_17 = L3_17(L4_18, L5_19)
  L4_18 = L3_17
  L3_17 = L3_17.DiffTime
  L5_19 = L2_16 / 1000
  L3_17 = L3_17(L4_18, L5_19)
  L4_18 = Logic
  L5_19 = L4_18
  L4_18 = L4_18.Get
  L4_18 = L4_18(L5_19, "System")
  L5_19 = L4_18
  L4_18 = L4_18.SecToDay
  L4_18 = L4_18(L5_19, L3_17)
  if L4_18 and L3_17 > 0 then
    L5_19 = string
    L5_19 = L5_19.format
    L5_19 = L5_19("%02d:%02d:%02d", L4_18.hour or 0, L4_18.min or 0, L4_18.sec or 0)
    A0_14.ttfTime:setString(L5_19)
  else
    A0_14.needRequestNewData = true
    L5_19 = Logic
    L5_19 = L5_19.Get
    L5_19 = L5_19(L5_19, "Raffle")
    L5_19 = L5_19.setRequestState
    L5_19(L5_19, true)
    L5_19 = A0_14.ttfTime
    L5_19 = L5_19.setString
    L5_19(L5_19, "00:00:00")
  end
end
function prototype.setHaloPosition(A0_20, A1_21)
  A0_20.sprAniPoint:setVisible(true)
  if A0_20[string.format("item%d", A1_21)] == nil then
    return
  end
  A0_20.sprAniPoint:setPosition(CCPointMake(A0_20.orgXPos + A0_20[string.format("item%d", A1_21)]:getPositionX() - 32, A0_20.orgYPos + A0_20[string.format("item%d", A1_21)]:getPositionY() - 21))
end
function prototype.calculateItemPosition(A0_22, A1_23)
  local L2_24, L3_25
  L2_24 = _UPVALUE0_
  L3_25 = A0_22.counts
  L2_24 = L2_24[L3_25]
  if L2_24 ~= nil then
    L2_24 = _UPVALUE0_
    L3_25 = A0_22.counts
    L2_24 = L2_24[L3_25]
    L2_24 = L2_24[A1_23]
  elseif L2_24 == nil then
    L2_24 = 0
    L3_25 = 0
    return L2_24, L3_25
  end
  L2_24 = _UPVALUE0_
  L3_25 = A0_22.counts
  L2_24 = L2_24[L3_25]
  L2_24 = L2_24[A1_23]
  L3_25 = L2_24.x
  L3_25 = L3_25 - 13
  return L3_25, L2_24.y - 13
end
function prototype.concentrateAllItems(A0_26)
  if A0_26.index < 0 or A0_26.index > A0_26.counts then
    return
  end
  if A0_26[string.format("item%d", A0_26.index)] then
    A0_26[string.format("item%d", A0_26.index)]:runAction(CCMoveTo:create(0.2, ccp(_UPVALUE0_, _UPVALUE1_)))
  end
  A0_26.index = A0_26.index + 1
  if A0_26.index > A0_26.counts then
    A0_26.index = 1
    if not A0_26.eventTracer:Exist("shuffleAni") then
      Singleton(Timer):After(400, A0_26:Event("shuffleAni"))
    end
    return
  end
  if not A0_26.eventTracer:Exist("concentrateAllItems") then
    Singleton(Timer):After(70, A0_26:Event("concentrateAllItems"))
  end
end
function prototype.shuffleAni(A0_27)
  A0_27.cardShuffleAni:setVisible(true)
  A0_27.cardShuffleAni:RunAni(nil, nil, bind(A0_27.shuffleAniEnd, A0_27))
end
function prototype.shuffleAniEnd(A0_28)
  A0_28.cardShuffleAni:setVisible(false)
  A0_28:emanateAllItems()
end
function prototype.emanateAllItems(A0_29)
  local L1_30, L2_31, L3_32
  L1_30 = A0_29.index
  if not (L1_30 < 0) then
    L1_30 = A0_29.index
    L2_31 = A0_29.counts
  elseif L1_30 > L2_31 then
    return
  end
  L1_30 = string
  L1_30 = L1_30.format
  L2_31 = "item%d"
  L3_32 = A0_29.index
  L1_30 = L1_30(L2_31, L3_32)
  L2_31 = A0_29[L1_30]
  if L2_31 then
    L3_32 = A0_29
    L2_31 = A0_29.calculateItemPosition
    L3_32 = L2_31(L3_32, A0_29.index)
    A0_29[L1_30]:runAction(CCMoveTo:create(0.2, ccp(L2_31, L3_32)))
  end
  L2_31 = A0_29.index
  L2_31 = L2_31 + 1
  A0_29.index = L2_31
  L2_31 = A0_29.index
  L3_32 = A0_29.counts
  if L2_31 > L3_32 then
    L2_31 = A0_29.eventTracer
    L3_32 = L2_31
    L2_31 = L2_31.Exist
    L2_31 = L2_31(L3_32, "aniEnd")
    if not L2_31 then
      L2_31 = Singleton
      L3_32 = Timer
      L2_31 = L2_31(L3_32)
      L3_32 = L2_31
      L2_31 = L2_31.After
      L2_31(L3_32, 500, A0_29:Event("aniEnd"))
    end
    return
  end
  L2_31 = A0_29.eventTracer
  L3_32 = L2_31
  L2_31 = L2_31.Exist
  L2_31 = L2_31(L3_32, "emanateAllItems")
  if not L2_31 then
    L2_31 = Singleton
    L3_32 = Timer
    L2_31 = L2_31(L3_32)
    L3_32 = L2_31
    L2_31 = L2_31.After
    L2_31(L3_32, 70, A0_29:Event("emanateAllItems"))
  end
end
function prototype.rotateAllCards(A0_33, A1_34, A2_35)
  local L3_36, L4_37, L5_38, L6_39
  for L6_39 = 1, A0_33.counts do
    if A0_33[string.format("item%d", L6_39)] and L6_39 ~= A2_35 then
      A0_33[string.format("item%d", L6_39)]:rotateCards(A1_34)
    end
  end
end
function prototype.coverAllItems(A0_40, A1_41)
  local L2_42, L3_43, L4_44, L5_45
  for L5_45 = 1, A0_40.counts do
    if A0_40[string.format("item%d", L5_45)] then
      A0_40[string.format("item%d", L5_45)]:setCoverVisible(A1_41)
    end
  end
end
function prototype.setAllItemsTouchEnable(A0_46, A1_47)
  local L2_48, L3_49, L4_50, L5_51
  for L5_51 = 1, A0_46.counts do
    if A0_46[string.format("item%d", L5_51)] then
      A0_46[string.format("item%d", L5_51)]:setItemTouchEnable(A1_47)
    end
  end
end
function prototype.aniEnd(A0_52)
  A0_52:setAllItemsTouchEnable(true)
  A0_52.sprClicked:setVisible(true)
  A0_52.ttfCost:setVisible(true)
end
function prototype.raffleResultShow(A0_53, A1_54, A2_55, A3_56)
  for _FORV_7_, _FORV_8_ in ipairs(A0_53.rewards) do
    if _FORV_8_ == A2_55 and A3_56 ~= 0 then
      A0_53.rewards[_FORV_7_], A0_53.rewards[A3_56] = A0_53.rewards[A3_56], _FORV_8_
      break
    end
  end
  A0_53:shuffle(A3_56)
  A0_53.index = A3_56
  A0_53:refreshAllItems()
  if A0_53[string.format("item%d", A3_56)] then
    A0_53[string.format("item%d", A3_56)]:setCoverVisible(false)
    A0_53[string.format("item%d", A3_56)]:rotateCards(true)
  end
  A0_53.sprClicked:setVisible(false)
  A0_53.ttfCost:setVisible(false)
  A0_53.strTip = A1_54
  if not A0_53.eventTracer:Exist("showAllItemRewards") then
    Singleton(Timer):After(350, A0_53:Event("showAllItemRewards"))
  end
  if not A0_53.eventTracer:Exist("showRewardDialog") then
    Singleton(Timer):After(2000, A0_53:Event("showRewardDialog"))
  end
end
function prototype.showAllItemRewards(A0_57)
  A0_57:setHaloPosition(A0_57.index)
  A0_57:rotateAllCards(true, A0_57.index)
  A0_57:coverAllItems(false)
end
function prototype.showRewardDialog(A0_58)
  Prompt:Confirm(A0_58, "", A0_58.strTip, A0_58.refreshLayout, Prompt.PROMPT_TYPE.CONFIRM)
end
function prototype.refreshLayout(A0_59)
  local L1_60
  L1_60 = A0_59.btnLottery
  L1_60 = L1_60.setEnabled
  L1_60(L1_60, true)
  L1_60 = A0_59.btnReSet
  L1_60 = L1_60.setEnabled
  L1_60(L1_60, true)
  L1_60 = A0_59.sprShuffle
  L1_60 = L1_60.setVisible
  L1_60(L1_60, true)
  L1_60 = Logic
  L1_60 = L1_60.Get
  L1_60 = L1_60(L1_60, "Raffle")
  L1_60 = L1_60.getRewards
  L1_60 = L1_60(L1_60)
  A0_59:createLotterysImages(L1_60)
end
function prototype.shuffle(A0_61, A1_62)
  if not A0_61.rewards or table.empty(A0_61.rewards) then
    return
  end
  for _FORV_5_ = 1, A0_61.counts - 1 do
    if _FORV_5_ ~= A1_62 and math.random(_FORV_5_ + 1, A0_61.counts) ~= A1_62 then
      A0_61.rewards[_FORV_5_], A0_61.rewards[math.random(_FORV_5_ + 1, A0_61.counts)] = A0_61.rewards[math.random(_FORV_5_ + 1, A0_61.counts)], A0_61.rewards[_FORV_5_]
    end
  end
end
function prototype.refreshAllItems(A0_63)
  local L1_64, L2_65, L3_66, L4_67
  for L4_67 = 1, A0_63.counts do
    if A0_63[string.format("item%d", L4_67)] then
      A0_63[string.format("item%d", L4_67)]:refreshItem(L4_67, A0_63.rewards[L4_67])
    end
  end
end
function prototype.onBtnReturnClicked(A0_68, A1_69, A2_70)
  SceneHelper:runWithScene("GiftActivityList", A0_68.rootNode)
end
function prototype.onBtnShowClicked(A0_71, A1_72, A2_73)
  Logic:Get("Raffle"):setTreasureShowStr("RaffleShow")
  SceneHelper:runWithScene("GiftTreasureShow", A0_71.rootNode)
end
function prototype.onBtnLotteryClicked(A0_74, A1_75, A2_76)
  if A0_74.needRequestNewData then
    Prompt:Confirm(A0_74, "", TwGetStr(111304), A0_74.loadRaffles, Prompt.PROMPT_TYPE.CONFIRM)
    return
  end
  if A0_74.counts == 1 then
    A0_74:coverAllItems(true)
    A0_74.sprClicked:setVisible(true)
    A0_74.ttfCost:setVisible(true)
    A0_74.sprShuffle:setVisible(false)
    return
  end
  A0_74.btnLottery:setEnabled(false)
  A0_74.btnReSet:setEnabled(false)
  A0_74.sprShuffle:setVisible(false)
  A0_74.index = 1
  A0_74:rotateAllCards(false, -1)
  A0_74:coverAllItems(true)
  A0_74:setAllItemsTouchEnable(false)
  if not A0_74.eventTracer:Exist("startConcentrate") then
    Singleton(Timer):After(350, A0_74:Event("startConcentrate"))
  end
end
function prototype.startConcentrate(A0_77)
  A0_77:concentrateAllItems()
end
function prototype.onBtnResetClicked(A0_78, A1_79, A2_80)
  local L3_81, L4_82
  L3_81 = Logic
  L4_82 = L3_81
  L3_81 = L3_81.Get
  L3_81 = L3_81(L4_82, "PlayerInfo")
  L4_82 = L3_81
  L3_81 = L3_81.GetPlayerAllJade
  L3_81 = L3_81(L4_82)
  L4_82 = Logic
  L4_82 = L4_82.Get
  L4_82 = L4_82(L4_82, "Raffle")
  L4_82 = L4_82.getCurResetCost
  L4_82 = L4_82(L4_82)
  if L3_81 < L4_82 then
    Logic:Get("Main"):PromptCharge()
    return
  end
  Prompt:ConfirmRecord(A0_78, "", TwGetStr(111303, L4_82), A0_78.reset, Prompt.PROMPT_TYPE.SELECT, nil, Logic.SureConfirm.RECORD_TYPE.RAFFLE_RESET)
end
function prototype.loadRaffles(A0_83)
  Logic:Get("Raffle"):PostLoadRaffle()
end
function prototype.reset(A0_84)
  Logic:Get("Raffle"):PostRefresh()
end
