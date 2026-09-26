local L0_0
L0_0 = module
L0_0((...), package.seeall)
L0_0 = "images/public/progress1.png"
prototype = Tw.Controller.prototype:extend()
function prototype.onEnter(A0_1)
  local L1_2, L2_3, L3_4, L4_5, L5_6
  A0_1.endDropItems = nil
  A0_1.endLevelUp = nil
  A0_1.exitPosted = false
  A0_1.resultShown = false
  L1_2 = A0_1.mPnlLevelUp
  L2_3 = L1_2
  L1_2 = L1_2.setVisible
  L3_4 = false
  L1_2(L2_3, L3_4)
  L1_2 = A0_1.mPnlReward
  L2_3 = L1_2
  L1_2 = L1_2.setVisible
  L3_4 = false
  L1_2(L2_3, L3_4)
  L1_2 = A0_1.mStaCoin
  L2_3 = L1_2
  L1_2 = L1_2.create
  L1_2(L2_3)
  L1_2 = A0_1.mStaExp
  L2_3 = L1_2
  L1_2 = L1_2.create
  L1_2(L2_3)
  L1_2 = A0_1.mStaSoul
  L2_3 = L1_2
  L1_2 = L1_2.create
  L1_2(L2_3)
  L1_2 = A0_1.mStaCoin
  L2_3 = L1_2
  L1_2 = L1_2.setAlign
  L3_4 = "RIGHT"
  L4_5 = "TOP"
  L1_2(L2_3, L3_4, L4_5)
  L1_2 = A0_1.mStaExp
  L2_3 = L1_2
  L1_2 = L1_2.setAlign
  L3_4 = "RIGHT"
  L4_5 = "TOP"
  L1_2(L2_3, L3_4, L4_5)
  L1_2 = A0_1.mStaSoul
  L2_3 = L1_2
  L1_2 = L1_2.setAlign
  L3_4 = "RIGHT"
  L4_5 = "TOP"
  L1_2(L2_3, L3_4, L4_5)
  L1_2 = Logic
  L2_3 = L1_2
  L1_2 = L1_2.Get
  L3_4 = "BattleShow"
  L1_2 = L1_2(L2_3, L3_4)
  L2_3 = L1_2
  L1_2 = L1_2.SetSpecialDropItems
  L3_4 = nil
  L1_2(L2_3, L3_4)
  L2_3 = A0_1
  L1_2 = A0_1.IsShowOtherCurrency
  L1_2 = L1_2(L2_3)
  L2_3 = A0_1.mStaSoul
  L3_4 = L2_3
  L2_3 = L2_3.setVisible
  L4_5 = L1_2
  L2_3(L3_4, L4_5)
  L2_3 = A0_1.staSoul
  L3_4 = L2_3
  L2_3 = L2_3.setVisible
  L4_5 = L1_2
  L2_3(L3_4, L4_5)
  L3_4 = A0_1
  L2_3 = A0_1.InitialString
  L2_3(L3_4)
  L3_4 = A0_1
  L2_3 = A0_1.SetBackGround
  L2_3(L3_4)
  L2_3 = Logic
  L3_4 = L2_3
  L2_3 = L2_3.Get
  L4_5 = "BattleShow"
  L2_3 = L2_3(L3_4, L4_5)
  L3_4 = L2_3
  L2_3 = L2_3.GetCurHeroInfo
  L2_3 = L2_3(L3_4)
  L2_3 = L2_3.level
  L3_4 = L2_3 or 1
  A0_1.lv = L3_4
  L3_4 = A0_1.staLevel
  L4_5 = L3_4
  L3_4 = L3_4.create
  L5_6 = L2_3
  L3_4(L4_5, L5_6)
  L3_4 = Logic
  L4_5 = L3_4
  L3_4 = L3_4.Get
  L5_6 = "Battle"
  L3_4 = L3_4(L4_5, L5_6)
  L4_5 = A0_1.eventTracer
  L5_6 = L4_5
  L4_5 = L4_5.Exist
  L4_5 = L4_5(L5_6, "OnExitBattle")
  if not L4_5 then
    L5_6 = L3_4
    L4_5 = L3_4.On
    L4_5(L5_6, Logic.Battle.EVT.EXIT_BATTLE, A0_1:Event("OnExitBattle"))
  end
  L5_6 = A0_1
  L4_5 = A0_1.PostExitMsg
  L4_5(L5_6)
  L4_5 = Logic
  L5_6 = L4_5
  L4_5 = L4_5.Get
  L4_5 = L4_5(L5_6, "BattleShow")
  L5_6 = L4_5
  L4_5 = L4_5.IsBattleWin
  L4_5 = L4_5(L5_6)
  if not L4_5 then
    L4_5 = Logic
    L5_6 = L4_5
    L4_5 = L4_5.Get
    L4_5 = L4_5(L5_6, "BattleShow")
    L5_6 = L4_5.IsUpGradeSkillUnlock
    L5_6 = L5_6(L4_5)
    if L5_6 then
      L5_6 = L4_5.IsInHardCampaignMode
      L5_6 = L5_6(L4_5)
    end
    A0_1.btnCardTip:setVisible(not L5_6)
    A0_1.btnSkillTip:setVisible(L5_6)
    A0_1.staTip:setVisible(true)
  end
  L4_5 = Logic
  L5_6 = L4_5
  L4_5 = L4_5.Get
  L4_5 = L4_5(L5_6, "BattleShow")
  L5_6 = L4_5
  L4_5 = L4_5.GetBattleId
  L4_5 = L4_5(L5_6)
  L5_6 = L3_4.GetBattleInfoById
  L5_6 = L5_6(L3_4, L4_5)
  if L5_6 == nil then
    return
  end
  A0_1.mStaGuankia:setString(L5_6.name)
  if L3_4:GetCampaignInfoById(L5_6.campaignId) == nil then
    return
  end
  A0_1.mStaFuben:setString(L3_4:GetCampaignInfoById(L5_6.campaignId).name)
  A0_1.mPrgLv:createProgress(_UPVALUE0_, _UPVALUE1_)
  A0_1.mPrgLv:setValue(100 * ((Logic:Get("BattleShow"):GetCurHeroInfo().playerInfo or {}).exp or 0) / (Logic:Get("PlayerInfo"):GetUpgradeNeedByLevel(A0_1.lv) or 1))
  A0_1:OnExitBattle()
  Logic:Get("BattleShow"):BattleShowInEnd()
end
function prototype.onExit(A0_7)
  if A0_7.eventTracer:Exist("OnExitBattle") then
    A0_7.eventTracer:Cancel("OnExitBattle")
  end
  if Logic:Get("Elite"):isEliteBattle() then
    Logic:Get("Elite"):setEliteBattle(false)
  end
end
function prototype.InitialString(A0_8)
  local L1_9, L2_10
  L1_9 = A0_8.mPnlLevelUp
  L2_10 = L1_9.staTili
  L2_10 = L2_10.setString
  L2_10(L2_10, TwGetStr(107010))
  L2_10 = L1_9.staKapai
  L2_10 = L2_10.setString
  L2_10(L2_10, TwGetStr(107011))
  L2_10 = L1_9.staTongyu
  L2_10 = L2_10.setString
  L2_10(L2_10, TwGetStr(107012))
  L2_10 = L1_9.staHaoyou
  L2_10 = L2_10.setString
  L2_10(L2_10, TwGetStr(107013))
  L2_10 = A0_8.staYuanbao
  L2_10 = L2_10.setString
  L2_10(L2_10, TwGetStr(107014))
  L2_10 = A0_8.staExp
  L2_10 = L2_10.setString
  L2_10(L2_10, TwGetStr(107015))
  L2_10 = A0_8.GetCurrencyName
  L2_10 = L2_10(A0_8)
  A0_8.staSoul:setString(L2_10)
  A0_8.staMenPaiExp:setString(TwGetStr(107017, 0))
  A0_8.staMenPaiExp:setOpacity(0)
  A0_8.staExGold:setString(TwGetStr(107019, 0))
  A0_8.staExGold:setOpacity(0)
end
function prototype.SetBackGround(A0_11)
  local L1_12, L2_13, L3_14
  L1_12 = CCSprite
  L2_13 = L1_12
  L1_12 = L1_12.create
  L3_14 = "images/BattleShow/fightResult_bg.png"
  L1_12 = L1_12(L2_13, L3_14)
  L2_13 = Logic
  L3_14 = L2_13
  L2_13 = L2_13.Get
  L2_13 = L2_13(L3_14, "HeroCardInfo")
  L3_14 = L2_13
  L2_13 = L2_13.GetCardTexture
  L3_14 = L2_13(L3_14, L1_12, nil, false, CCSize(640, 833))
  A0_11.mSpBg:setTexture(L2_13)
  A0_11.mSpBg:setTextureRect(L3_14)
end
function prototype.PostExitMsg(A0_15)
  if A0_15.exitPosted then
    return
  end
  if Logic:Get("BattleShow"):IsEnterBattle() and (Logic:Get("BattleShow"):IsInCampaign() or Logic:Get("BattleShow"):IsInActive()) then
    A0_15.exitPosted = true
    Logic:Get("Battle"):PostExitMsg()
  end
end
function prototype.SetGotCoin(A0_16, A1_17)
  A0_16.coin = A1_17
end
function prototype.SetGotExp(A0_18, A1_19)
  A0_18.exp = A1_19
end
function prototype.onBtnClose(A0_20)
  if A0_20:GetReward() == nil then
    A0_20:Close()
    return
  end
  A0_20:ShowContinueTip()
  if A0_20.endDropItems then
    A0_20:Close()
  elseif A0_20.endLevelUp and A0_20:ShowDropItems() then
    A0_20:Close()
  end
end
function prototype.OnExitBattle(A0_21, A1_22)
  local L2_23
  L2_23 = A0_21.resultShown
  if L2_23 then
    return
  end
  L2_23 = A0_21.GetReward
  L2_23 = L2_23(A0_21)
  if L2_23 ~= nil then
    if not Logic:Get("BattleShow"):IsBattleWin() then
      Logic:Get("BattleShow"):SetFailReward(L2_23)
      L2_23 = {}
    end
    A0_21.resultShown = true
    A0_21:ShowResult(L2_23)
    A0_21:ShowLevelUp()
  end
  if A1_22 then
    A0_21:Close(A1_22)
  end
end
function prototype.GetReward(A0_24)
  local L1_25, L2_26
  L2_26 = Logic
  L2_26 = L2_26.Get
  L2_26 = L2_26(L2_26, "BattleShow")
  L2_26 = L2_26.GetCostAndReward
  L2_26 = L2_26(L2_26)
  if type(L2_26) == "table" then
    L1_25 = L2_26
  end
  return L1_25
end
function prototype.Close(A0_27, A1_28)
  local L2_29, L3_30
  L2_29 = Logic
  L3_30 = L2_29
  L2_29 = L2_29.Get
  L2_29 = L2_29(L3_30, "AniMgr")
  L3_30 = L2_29
  L2_29 = L2_29.RemoveAll
  L2_29(L3_30)
  L2_29 = SceneHelper
  L3_30 = L2_29
  L2_29 = L2_29.removeScene
  L2_29(L3_30, "BattleShowResult")
  L2_29 = Logic
  L3_30 = L2_29
  L2_29 = L2_29.Get
  L2_29 = L2_29(L3_30, "BattleShow")
  L3_30 = L2_29
  L2_29 = L2_29.GetFriendInfo
  L2_29 = L2_29(L3_30)
  if L2_29 ~= nil then
    L3_30 = L2_29.name
  else
    if L3_30 == nil then
      L3_30 = Logic
      L3_30 = L3_30.Get
      L3_30 = L3_30(L3_30, "BattleShow")
      L3_30 = L3_30.BattleShowEnd
      L3_30(L3_30)
  end
  elseif not A1_28 then
    L3_30 = SceneHelper
    L3_30 = L3_30.pushScene
    L3_30(L3_30, "BattleFriendAdd")
  end
  if A1_28 then
    return
  end
  L3_30 = Logic
  L3_30 = L3_30.Get
  L3_30 = L3_30(L3_30, "BattleShow")
  L3_30 = L3_30.GetSpecialDropItems
  L3_30 = L3_30(L3_30)
  if L3_30 ~= nil and not table.empty(L3_30) then
    SceneHelper:pushScene("BattleShowDrops")
  end
end
function prototype.ShowResult(A0_31, A1_32)
  local L2_33, L3_34, L4_35, L5_36, L6_37, L7_38, L8_39, L9_40, L10_41, L11_42, L12_43, L13_44, L14_45, L15_46, L16_47, L17_48, L18_49, L19_50, L20_51, L21_52, L22_53
  L3_34 = A0_31
  L2_33 = A0_31.GetCurrencyAmount
  L4_35 = A1_32.rewards
  L2_33 = L2_33(L3_34, L4_35)
  L3_34 = Logic
  L4_35 = L3_34
  L3_34 = L3_34.Get
  L5_36 = "Reward"
  L3_34 = L3_34(L4_35, L5_36)
  L4_35 = L3_34
  L3_34 = L3_34.GetItemsByType
  L5_36 = A1_32.rewards
  L6_37 = Logic
  L6_37 = L6_37.Reward
  L6_37 = L6_37.REWARDS_TYPE
  L6_37 = L6_37.CURRENCY
  L7_38 = Logic
  L7_38 = L7_38.Reward
  L7_38 = L7_38.CURRENCY_TYPE
  L7_38 = L7_38.COPPER
  L3_34 = L3_34(L4_35, L5_36, L6_37, L7_38)
  L4_35 = Logic
  L5_36 = L4_35
  L4_35 = L4_35.Get
  L6_37 = "Reward"
  L4_35 = L4_35(L5_36, L6_37)
  L5_36 = L4_35
  L4_35 = L4_35.CalcTotleNum
  L6_37 = L3_34
  L7_38 = nil
  L8_39 = "MENPAI_COUNTRY_HOLD"
  L5_36 = L4_35(L5_36, L6_37, L7_38, L8_39)
  L6_37 = Logic
  L7_38 = L6_37
  L6_37 = L6_37.Get
  L8_39 = "Reward"
  L6_37 = L6_37(L7_38, L8_39)
  L7_38 = L6_37
  L6_37 = L6_37.GetItemsByType
  L8_39 = A1_32.rewards
  L9_40 = Logic
  L9_40 = L9_40.Reward
  L9_40 = L9_40.REWARDS_TYPE
  L9_40 = L9_40.EXP
  L6_37 = L6_37(L7_38, L8_39, L9_40)
  L7_38 = Logic
  L8_39 = L7_38
  L7_38 = L7_38.Get
  L9_40 = "Reward"
  L7_38 = L7_38(L8_39, L9_40)
  L8_39 = L7_38
  L7_38 = L7_38.CalcTotleNum
  L9_40 = L6_37
  L10_41 = nil
  L11_42 = "MENPAI_EXP_ADD"
  L8_39 = L7_38(L8_39, L9_40, L10_41, L11_42)
  L9_40 = L6_37[1]
  if L9_40 then
    L9_40 = L6_37[1]
    L9_40 = L9_40.contents
    L9_40 = L9_40.exp
  else
    L9_40 = L9_40 or 0
  end
  L10_41 = L6_37[1]
  if L10_41 then
    L10_41 = L6_37[1]
    L10_41 = L10_41.contents
    L10_41 = L10_41.level
  elseif not L10_41 then
    L10_41 = Logic
    L11_42 = L10_41
    L10_41 = L10_41.Get
    L12_43 = "PlayerInfo"
    L10_41 = L10_41(L11_42, L12_43)
    L11_42 = L10_41
    L10_41 = L10_41.GetPlayerLevel
    L10_41 = L10_41(L11_42)
  end
  L11_42 = L6_37[1]
  if L11_42 then
    L11_42 = L6_37[1]
    L11_42 = L11_42.contents
    L11_42 = L11_42.exp
  else
    L11_42 = L11_42 or 0
  end
  L12_43 = L6_37[1]
  if L12_43 then
    L12_43 = L6_37[1]
    L12_43 = L12_43.contents
    L12_43 = L12_43.level
  elseif not L12_43 then
    L12_43 = Logic
    L13_44 = L12_43
    L12_43 = L12_43.Get
    L14_45 = "PlayerInfo"
    L12_43 = L12_43(L13_44, L14_45)
    L13_44 = L12_43
    L12_43 = L12_43.GetPlayerLevel
    L12_43 = L12_43(L13_44)
  end
  if L10_41 ~= L12_43 or not (L9_40 > L11_42) or not L9_40 then
    L9_40 = L11_42
  end
  if not (L10_41 > L12_43) or not L10_41 then
    L10_41 = L12_43
  end
  L13_44 = Logic
  L14_45 = L13_44
  L13_44 = L13_44.Get
  L15_46 = "Reward"
  L13_44 = L13_44(L14_45, L15_46)
  L14_45 = L13_44
  L13_44 = L13_44.GetItemsByType
  L15_46 = A1_32.rewards
  L16_47 = Logic
  L16_47 = L16_47.Reward
  L16_47 = L16_47.REWARDS_TYPE
  L16_47 = L16_47.ACTION_POINT
  L13_44 = L13_44(L14_45, L15_46, L16_47)
  L14_45 = L13_44[1]
  if L14_45 then
    L14_45 = L13_44[1]
    L14_45 = L14_45.contents
    L14_45 = L14_45.point
  else
    L14_45 = L14_45 or 0
  end
  function L15_46(A0_54)
    return #Logic:Get("Reward"):GetItemsByType(_UPVALUE0_.rewards, A0_54) ~= 0 and Logic:Get("Reward"):GetItemsByType(_UPVALUE0_.rewards, A0_54) or nil
  end
  L16_47 = {
    L17_48,
    L18_49,
    L19_50,
    L20_51,
    L21_52,
    L22_53,
    L15_46(Logic.Reward.REWARDS_TYPE.EQUIPMENT),
    L15_46(Logic.Reward.REWARDS_TYPE.EQUIPMENT_FRAGMENT),
    L15_46(Logic.Reward.REWARDS_TYPE.EQUIPMENT_MATERIAL),
    L15_46(Logic.Reward.REWARDS_TYPE.CULTIVATE_MATERIAL),
    L15_46(Logic.Reward.REWARDS_TYPE.MOON),
    L15_46(Logic.Reward.REWARDS_TYPE.SPRING)
  }
  L17_48 = L15_46
  L18_49 = Logic
  L18_49 = L18_49.Reward
  L18_49 = L18_49.REWARDS_TYPE
  L18_49 = L18_49.HERO
  L17_48 = L17_48(L18_49)
  L18_49 = L15_46
  L19_50 = Logic
  L19_50 = L19_50.Reward
  L19_50 = L19_50.REWARDS_TYPE
  L19_50 = L19_50.FRAGMENT
  L18_49 = L18_49(L19_50)
  L19_50 = L15_46
  L20_51 = Logic
  L20_51 = L20_51.Reward
  L20_51 = L20_51.REWARDS_TYPE
  L20_51 = L20_51.EQUIP
  L19_50 = L19_50(L20_51)
  L20_51 = L15_46
  L21_52 = Logic
  L21_52 = L21_52.Reward
  L21_52 = L21_52.REWARDS_TYPE
  L21_52 = L21_52.EXP_CARD
  L20_51 = L20_51(L21_52)
  L21_52 = L15_46
  L22_53 = Logic
  L22_53 = L22_53.Reward
  L22_53 = L22_53.REWARDS_TYPE
  L22_53 = L22_53.COIN_CARD
  L21_52 = L21_52(L22_53)
  L22_53 = L15_46
  L22_53 = L22_53(Logic.Reward.REWARDS_TYPE.TREASURE)
  A0_31.points = L14_45
  A0_31.nextLv = L10_41
  A0_31.soul = L2_33
  A0_31.coin = L4_35
  A0_31.exp = L7_38
  A0_31.dropItems = L16_47
  L17_48 = A0_31.lv
  A0_31.level = L17_48
  L18_49 = A0_31
  L17_48 = A0_31.InitDropItems
  L17_48(L18_49)
  L18_49 = A0_31
  L17_48 = A0_31.InitLeveUp
  L17_48(L18_49)
  L17_48 = A0_31.mStaSoul
  L18_49 = L17_48
  L17_48 = L17_48.setValueAni
  L19_50 = A0_31.soul
  L20_51 = 1000
  L17_48(L18_49, L19_50, L20_51)
  L17_48 = A0_31.mStaCoin
  L18_49 = L17_48
  L17_48 = L17_48.setValueAni
  L19_50 = A0_31.coin
  L20_51 = 1000
  L17_48(L18_49, L19_50, L20_51)
  L17_48 = A0_31.staMenPaiExp
  L18_49 = L17_48
  L17_48 = L17_48.setString
  L19_50 = TwGetStr
  L20_51 = 107017
  L21_52 = L8_39
  L22_53 = L19_50(L20_51, L21_52)
  L17_48(L18_49, L19_50, L20_51, L21_52, L22_53, L19_50(L20_51, L21_52))
  if L8_39 > 0 then
    L17_48 = A0_31.staMenPaiExp
    L18_49 = L17_48
    L17_48 = L17_48.runAction
    L19_50 = CCFadeTo
    L20_51 = L19_50
    L19_50 = L19_50.create
    L21_52 = 0.5
    L22_53 = 255
    L22_53 = L19_50(L20_51, L21_52, L22_53)
    L17_48(L18_49, L19_50, L20_51, L21_52, L22_53, L19_50(L20_51, L21_52, L22_53))
  end
  L17_48 = A0_31.staExGold
  L18_49 = L17_48
  L17_48 = L17_48.setString
  L19_50 = TwGetStr
  L20_51 = 107019
  L21_52 = L5_36
  L22_53 = L19_50(L20_51, L21_52)
  L17_48(L18_49, L19_50, L20_51, L21_52, L22_53, L19_50(L20_51, L21_52))
  if L5_36 > 0 then
    L17_48 = A0_31.staExGold
    L18_49 = L17_48
    L17_48 = L17_48.runAction
    L19_50 = CCFadeTo
    L20_51 = L19_50
    L19_50 = L19_50.create
    L21_52 = 0.5
    L22_53 = 255
    L22_53 = L19_50(L20_51, L21_52, L22_53)
    L17_48(L18_49, L19_50, L20_51, L21_52, L22_53, L19_50(L20_51, L21_52, L22_53))
  end
  L17_48 = A0_31.mStaExp
  L18_49 = L17_48
  L17_48 = L17_48.setValueAni
  L19_50 = A0_31.exp
  L20_51 = 1000
  L17_48(L18_49, L19_50, L20_51)
  L17_48 = Logic
  L18_49 = L17_48
  L17_48 = L17_48.Get
  L19_50 = "PlayerInfo"
  L17_48 = L17_48(L18_49, L19_50)
  L18_49 = Logic
  L19_50 = L18_49
  L18_49 = L18_49.Get
  L20_51 = "BattleShow"
  L18_49 = L18_49(L19_50, L20_51)
  L19_50 = L18_49
  L18_49 = L18_49.GetCurHeroInfo
  L18_49 = L18_49(L19_50)
  L18_49 = L18_49.playerInfo
  L19_50 = L18_49.exp
  L19_50 = 100 * L19_50
  L21_52 = L17_48
  L20_51 = L17_48.GetUpgradeNeedByLevel
  L22_53 = A0_31.level
  L20_51 = L20_51(L21_52, L22_53)
  L20_51 = L20_51 or 1
  L19_50 = L19_50 / L20_51
  L20_51 = 100 * L9_40
  L22_53 = L17_48
  L21_52 = L17_48.GetUpgradeNeedByLevel
  L21_52 = L21_52(L22_53, A0_31.nextLv)
  L21_52 = L21_52 or 1
  L20_51 = L20_51 / L21_52
  L21_52 = math
  L21_52 = L21_52.max
  L22_53 = A0_31.nextLv
  L22_53 = L22_53 - A0_31.level
  L21_52 = L21_52(L22_53, 0)
  L22_53 = A0_31.mPrgLv
  L22_53 = L22_53.setMoveCallBack
  L22_53(L22_53, bind(A0_31.SetLv, A0_31))
  L22_53 = L7_38 + L8_39
  if L22_53 == 0 then
    return
  end
  L22_53 = A0_31.nextLv
  L22_53 = L22_53 - A0_31.level
  if L22_53 > 0 then
    L22_53 = A0_31.mPrgLv
    L22_53 = L22_53.setValue
    L22_53(L22_53, L19_50)
    L22_53 = A0_31.mPrgLv
    L22_53 = L22_53.setValue
    L22_53(L22_53, math.fmod(L20_51, 100), true, A0_31.nextLv - A0_31.level, 1000)
  else
    L22_53 = A0_31.mPrgLv
    L22_53 = L22_53.setValue
    L22_53(L22_53, L19_50)
    L22_53 = math
    L22_53 = L22_53.fmod
    L22_53 = L22_53(L20_51, 100)
    if L19_50 < L22_53 then
      A0_31.mPrgLv:setValue(L22_53, true, 0, 1000)
    end
  end
  L22_53 = A0_31.ShowContinueTip
  L22_53(A0_31, true)
end
function prototype.SetLv(A0_55, A1_56, A2_57)
  if A2_57 == Progress.CALL_BACK_TYPE.MOVE_FINISH then
    A0_55.staLevel:setValue(A0_55.nextLv)
  elseif A2_57 == Progress.CALL_BACK_TYPE.PASS_END then
    A0_55.staLevel:setValue(A0_55.lv + 1)
    A0_55.lv = A0_55.lv + 1
  end
end
function prototype.ShowLevelUp(A0_58)
  if A0_58.lv < A0_58.nextLv and not Logic:Get("AniMgr"):FindGroup("AniLevelUp") then
    Logic:Get("AniMgr"):Add(A0_58.mPnlLevelUp, "AniLevelUp")
    Logic:Get("AniMgr"):Sequence("AniLevelUp", false, function()
      local L1_59
      L1_59 = _UPVALUE0_
      L1_59.endLevelUp = true
    end)
  else
    A0_58.endLevelUp = true
  end
end
function prototype.InitLeveUp(A0_60)
  local L1_61, L2_62, L3_63, L4_64, L5_65, L6_66, L7_67, L8_68, L9_69, L10_70, L11_71, L12_72, L13_73
  L1_61 = A0_60.lv
  L2_62 = A0_60.nextLv
  if not (L1_61 < L2_62) then
    return
  end
  L2_62 = Logic
  L3_63 = L2_62
  L2_62 = L2_62.Get
  L4_64 = "BattleShow"
  L2_62 = L2_62(L3_63, L4_64)
  L3_63 = L2_62
  L2_62 = L2_62.GetCurHeroInfo
  L2_62 = L2_62(L3_63)
  L2_62 = L2_62.curPhyPoint
  if not L2_62 then
    L3_63 = 0
  else
    L3_63 = L3_63 or L2_62.point
  end
  if not L3_63 or L3_63 < 0 then
    L4_64 = 0
    L3_63 = L4_64 or L3_63
  end
  L4_64 = Logic
  L5_65 = L4_64
  L4_64 = L4_64.Get
  L6_66 = "BattleShow"
  L4_64 = L4_64(L5_65, L6_66)
  L5_65 = L4_64
  L4_64 = L4_64.GetCostAndReward
  L4_64 = L4_64(L5_65)
  L5_65 = L4_64.costs
  L5_65 = L5_65[1]
  L5_65 = L5_65.amount
  L6_66 = L3_63 + L5_65
  if L6_66 < 0 then
    L7_67 = 0
    L6_66 = L7_67 or L6_66
  end
  L7_67 = Logic
  L8_68 = L7_67
  L7_67 = L7_67.Get
  L9_69 = "BattleShow"
  L7_67 = L7_67(L8_68, L9_69)
  L8_68 = L7_67
  L7_67 = L7_67.GetCurHeroInfo
  L7_67 = L7_67(L8_68)
  L7_67 = L7_67.curHero
  L8_68 = Logic
  L9_69 = L8_68
  L8_68 = L8_68.Get
  L10_70 = "BattleShow"
  L8_68 = L8_68(L9_69, L10_70)
  L9_69 = L8_68
  L8_68 = L8_68.GetCurHeroInfo
  L8_68 = L8_68(L9_69)
  L8_68 = L8_68.curLeadership
  L9_69 = Logic
  L10_70 = L9_69
  L9_69 = L9_69.Get
  L11_71 = "BattleShow"
  L9_69 = L9_69(L10_70, L11_71)
  L10_70 = L9_69
  L9_69 = L9_69.GetCurHeroInfo
  L9_69 = L9_69(L10_70)
  L9_69 = L9_69.curFriMax
  L10_70 = A0_60.points
  L10_70 = L10_70 == 0 and L3_63 or A0_60.points
  L11_71 = Logic
  L12_72 = L11_71
  L11_71 = L11_71.Get
  L13_73 = "Hero"
  L11_71 = L11_71(L12_72, L13_73)
  L12_72 = L11_71
  L11_71 = L11_71.GetTotalExtendLimit
  L13_73 = A0_60.nextLv
  L11_71 = L11_71(L12_72, L13_73)
  L12_72 = Logic
  L13_73 = L12_72
  L12_72 = L12_72.Get
  L12_72 = L12_72(L13_73, "Hero")
  L13_73 = L12_72
  L12_72 = L12_72.GetLeadership
  L12_72 = L12_72(L13_73, A0_60.nextLv)
  L13_73 = Logic
  L13_73 = L13_73.Get
  L13_73 = L13_73(L13_73, "Friend")
  L13_73 = L13_73.GetFriendNextMax
  L13_73 = L13_73(L13_73, A0_60.nextLv - 1)
  A0_60.mPnlLevelUp.mStaCurPoint:setString(tostring(L6_66))
  A0_60.mPnlLevelUp.mStaCurHero:setString(tostring(L7_67))
  A0_60.mPnlLevelUp.mStaCurLeader:setString(tostring(L8_68))
  A0_60.mPnlLevelUp.mStaCurFri:setString(tostring(L9_69))
  A0_60.mPnlLevelUp.mStaPoint:setString(tostring(L10_70))
  A0_60.mPnlLevelUp.mStaHero:setString(tostring(L11_71))
  A0_60.mPnlLevelUp.mStaLeader:setString(tostring(L12_72))
  A0_60.mPnlLevelUp.mStaFri:setString(tostring(L13_73))
  if L6_66 < L10_70 then
    A0_60.mPnlLevelUp.mStaPoint:setColor(ccColor3B(0, 255, 0))
    A0_60.mPnlLevelUp.mSpArrow1:setColor(ccColor3B(0, 255, 0))
  end
  if L7_67 < L11_71 then
    A0_60.mPnlLevelUp.mStaHero:setColor(ccColor3B(0, 255, 0))
    A0_60.mPnlLevelUp.mSpArrow2:setColor(ccColor3B(0, 255, 0))
  end
  if L8_68 < L12_72 then
    A0_60.mPnlLevelUp.mStaLeader:setColor(ccColor3B(0, 255, 0))
    A0_60.mPnlLevelUp.mSpArrow3:setColor(ccColor3B(0, 255, 0))
  end
  if L9_69 < L13_73 then
    A0_60.mPnlLevelUp.mStaFri:setColor(ccColor3B(0, 255, 0))
    A0_60.mPnlLevelUp.mSpArrow4:setColor(ccColor3B(0, 255, 0))
  end
end
function prototype.InitDropItems(A0_74)
  local L1_75, L2_76, L3_77, L4_78, L5_79, L6_80, L7_81, L8_82, L9_83, L10_84, L11_85, L12_86, L13_87, L14_88
  if L1_75 == nil then
    return
  end
  for L4_78 = 1, 10 do
    L5_79(L6_80, L7_81)
  end
  L2_76[1] = "hua.png"
  L2_76[2] = "hao.png"
  L2_76[3] = "yue.png"
  L2_76[4] = "yuan.png"
  function L4_78(A0_89)
    local L1_90, L2_91, L3_92
    L2_91 = A0_89.type
    L3_92 = Logic
    L3_92 = L3_92.Reward
    L3_92 = L3_92.REWARDS_TYPE
    L3_92 = L3_92.MOON
    if L2_91 == L3_92 then
      L2_91 = _UPVALUE0_
      L3_92 = "images/MoonCake/"
      L2_91 = L2_91(L3_92, A0_89.code)
      L1_90 = L2_91
    else
      L2_91 = A0_89.type
      L3_92 = Logic
      L3_92 = L3_92.Reward
      L3_92 = L3_92.REWARDS_TYPE
      L3_92 = L3_92.SPRING
      if L2_91 == L3_92 then
        L2_91 = _UPVALUE0_
        L3_92 = "images/Moon/"
        L2_91 = L2_91(L3_92, A0_89.code)
        L1_90 = L2_91
      else
        L2_91 = Logic
        L3_92 = L2_91
        L2_91 = L2_91.Get
        L2_91 = L2_91(L3_92, "Equip")
        L3_92 = L2_91
        L2_91 = L2_91.GetGoodsSpr
        L2_91 = L2_91(L3_92, A0_89.code, A0_89.type)
        L1_90 = L2_91
      end
    end
    if L1_90 == nil then
      return
    end
    L2_91 = Logic
    L3_92 = L2_91
    L2_91 = L2_91.Get
    L2_91 = L2_91(L3_92, "HeroCardInfo")
    L3_92 = L2_91
    L2_91 = L2_91.GetCardTexture
    L3_92 = L2_91(L3_92, L1_90, L1_90:getContentSize())
    if _UPVALUE1_.mPnlReward["mImg" .. _UPVALUE2_] then
      _UPVALUE1_.mPnlReward["mImg" .. _UPVALUE2_]:setTexture(L2_91)
      _UPVALUE1_.mPnlReward["mImg" .. _UPVALUE2_]:setTextureRect(L3_92)
      _UPVALUE1_.mPnlReward["mImg" .. _UPVALUE2_]:setVisible(true)
    end
    _UPVALUE2_ = _UPVALUE2_ + 1
  end
  for L8_82, L9_83 in L5_79(L6_80) do
    for L13_87, L14_88 in L10_84(L11_85) do
      if L1_75 > 10 then
        break
      end
      if L14_88.type == Logic.Reward.REWARDS_TYPE.EQUIPMENT_MATERIAL or L14_88.type == Logic.Reward.REWARDS_TYPE.EQUIPMENT_FRAGMENT or L14_88.type == Logic.Reward.REWARDS_TYPE.CULTIVATE_MATERIAL then
        for _FORV_18_ = 1, L14_88.amount do
          L4_78(L14_88)
          if L1_75 > 10 then
            break
          end
        end
      else
        L4_78(L14_88)
      end
    end
  end
end
function prototype.ShowDropItems(A0_93)
  if next(A0_93.dropItems) and not Logic:Get("AniMgr"):FindGroup("AniReward") then
    Logic:Get("AniMgr"):RemoveGroup("AniLevelUp")
    Logic:Get("AniMgr"):RemoveGroup("AniReward")
    Logic:Get("AniMgr"):Add(A0_93.mPnlReward, "AniReward")
    Logic:Get("AniMgr"):Sequence("AniReward", false, function()
      local L0_94, L1_95, L2_96, L3_97, L4_98, L5_99, L6_100, L7_101, L8_102, L9_103, L10_104, L11_105, L12_106
      L0_94 = _UPVALUE0_
      L0_94.endDropItems = true
      L0_94 = 1
      for L4_98, L5_99 in L1_95(L2_96) do
        for L9_103, L10_104 in L6_100(L7_101) do
          if L0_94 > 10 then
            break
          end
          L11_105 = L10_104.type
          L12_106 = Logic
          L12_106 = L12_106.Reward
          L12_106 = L12_106.REWARDS_TYPE
          L12_106 = L12_106.FRAGMENT
          L11_105 = L11_105 == L12_106
          L12_106 = L10_104.type
          if L12_106 == Logic.Reward.REWARDS_TYPE.HERO or L11_105 then
            L12_106 = _UPVALUE0_
            L12_106 = L12_106.mPnlReward
            L12_106 = L12_106["mImg" .. L0_94]
            Logic:Get("HeroCardInfo"):AddShanCardSmall(L12_106, L10_104.code, nil, L11_105)
          end
          L0_94 = L0_94 + 1
        end
      end
    end)
    A0_93:ShowExtraMoveItems()
  else
    A0_93.endDropItems = true
  end
  return A0_93.endDropItems
end
function prototype.ShowExtraMoveItems(A0_107)
  local L1_108, L2_109, L3_110, L4_111, L5_112, L6_113, L7_114, L8_115, L9_116, L10_117, L11_118, L12_119, L13_120, L14_121, L15_122, L16_123, L17_124, L18_125, L19_126, L20_127
  L1_108 = Logic
  L2_109 = L1_108
  L1_108 = L1_108.Get
  L3_110 = "AniMgr"
  L1_108 = L1_108(L2_109, L3_110)
  L3_110 = L1_108
  L2_109 = L1_108.NewCCB
  L4_111 = "UI/uijsgjk"
  L5_112 = A0_107
  L2_109 = L2_109(L3_110, L4_111, L5_112)
  L4_111 = L2_109
  L3_110 = L2_109.GetLayer
  L3_110 = L3_110(L4_111)
  L4_111 = L3_110
  L3_110 = L3_110.getContentSize
  L3_110 = L3_110(L4_111)
  L5_112 = L2_109
  L4_111 = L2_109.RemoveAnimation
  L4_111(L5_112)
  L4_111 = CCLayer
  L5_112 = L4_111
  L4_111 = L4_111.create
  L4_111 = L4_111(L5_112)
  L6_113 = L4_111
  L5_112 = L4_111.ignoreAnchorPointForPosition
  L7_114 = false
  L5_112(L6_113, L7_114)
  L6_113 = L4_111
  L5_112 = L4_111.setAnchorPoint
  L7_114 = ccp
  L8_115 = 0.5
  L9_116 = 0.5
  L20_127 = L7_114(L8_115, L9_116)
  L5_112(L6_113, L7_114, L8_115, L9_116, L10_117, L11_118, L12_119, L13_120, L14_121, L15_122, L16_123, L17_124, L18_125, L19_126, L20_127, L7_114(L8_115, L9_116))
  L6_113 = L4_111
  L5_112 = L4_111.setContentSize
  L7_114 = L3_110
  L5_112(L6_113, L7_114)
  L5_112 = A0_107.rootNode
  L6_113 = L5_112
  L5_112 = L5_112.getContentSize
  L5_112 = L5_112(L6_113)
  L7_114 = L4_111
  L6_113 = L4_111.setPosition
  L8_115 = ccp
  L9_116 = L5_112.width
  L9_116 = L9_116 / 2
  L10_117 = L5_112.height
  L10_117 = L10_117 / 2
  L20_127 = L8_115(L9_116, L10_117)
  L6_113(L7_114, L8_115, L9_116, L10_117, L11_118, L12_119, L13_120, L14_121, L15_122, L16_123, L17_124, L18_125, L19_126, L20_127, L8_115(L9_116, L10_117))
  L6_113 = {}
  function L7_114(A0_128, A1_129, A2_130)
    local L3_131, L4_132, L5_133, L6_134, L7_135
    L3_131 = _UPVALUE0_
    L3_131 = L3_131.mPnlReward
    L4_132 = "mImg"
    L5_133 = A0_128
    L4_132 = L4_132 .. L5_133
    L3_131 = L3_131[L4_132]
    L4_132 = L3_131
    L3_131 = L3_131.getPositionLua
    L3_131 = L3_131(L4_132)
    L4_132 = _UPVALUE1_
    L5_133 = L4_132
    L4_132 = L4_132.NewCCB
    L6_134 = "UI/uijsgjk"
    L7_135 = _UPVALUE2_
    L4_132 = L4_132(L5_133, L6_134, L7_135, ccp(_UPVALUE3_.width * #_UPVALUE4_ + _UPVALUE3_.width / 2, 0))
    L5_133 = Logic
    L6_134 = L5_133
    L5_133 = L5_133.Get
    L7_135 = "HeroCardInfo"
    L5_133 = L5_133(L6_134, L7_135)
    L6_134 = L5_133
    L5_133 = L5_133.createHeroCardForByFight
    L7_135 = A1_129
    L5_133 = L5_133(L6_134, L7_135)
    L6_134 = Logic
    L7_135 = L6_134
    L6_134 = L6_134.Get
    L6_134 = L6_134(L7_135, "HeroCardInfo")
    L7_135 = L6_134
    L6_134 = L6_134.GetCardTexture
    L7_135 = L6_134(L7_135, L5_133, L4_132:GetChild("mActor"):getContentSize())
    L4_132:GetChild("mActor"):setTexture(L6_134)
    L4_132:GetChild("mActor"):setTextureRect(L7_135)
    table.insert(_UPVALUE4_, {ani = L4_132, pos = L3_131})
  end
  function L8_115(A0_136, A1_137)
    local L2_138
    L2_138 = A0_136
    if A1_137 == Logic.Reward.REWARDS_TYPE.HERO and KFDBGetRecord("BaseHero", L2_138) and KFDBGetRecord("ConfigValue", "DROP:HERO_STAR") and KFDBGetRecord("BaseHero", L2_138).star >= tonumber(KFDBGetRecord("ConfigValue", "DROP:HERO_STAR").content) then
      return true
    end
    return false
  end
  L9_116 = {}
  L10_117 = 1
  for L14_121, L15_122 in L11_118(L12_119) do
    for L19_126, L20_127 in L16_123(L17_124) do
      if L10_117 > 10 then
        break
      end
      if L8_115(L20_127.code, L20_127.type) then
        L7_114(L10_117, L20_127.code, L20_127.type)
        table.insert(L9_116, L20_127)
      end
      L10_117 = L10_117 + 1
    end
  end
  L11_118(L12_119, L13_120)
  L14_121 = L3_110.width
  L15_122 = #L6_113
  L14_121 = L14_121 * L15_122
  L15_122 = 1
  L20_127 = L13_120(L14_121, L15_122)
  L11_118(L12_119, L13_120, L14_121, L15_122, L16_123, L17_124, L18_125, L19_126, L20_127, L13_120(L14_121, L15_122))
  L11_118(L12_119, L13_120)
  for L14_121, L15_122 in L11_118(L12_119) do
    L19_126 = L15_122.pos
    L19_126 = L16_123
    L18_125(L19_126)
    L19_126 = L16_123
    L20_127 = L1_108.CreateSequence
    L20_127 = L20_127(L1_108, {
      CCDelayTime:create(1),
      CCMoveTo:create(0.2, L17_124),
      function()
        _UPVALUE0_:RemoveAnimation()
      end
    })
    L18_125(L19_126, L20_127, L20_127(L1_108, {
      CCDelayTime:create(1),
      CCMoveTo:create(0.2, L17_124),
      function()
        _UPVALUE0_:RemoveAnimation()
      end
    }))
  end
end
function prototype.onBtnCardTip(A0_139)
  Logic:Get("BattleShow"):SetNeedLevelUpTip(true)
  A0_139:onBtnClose()
end
function prototype.onBtnSkillTip(A0_140)
  A0_140:onBtnCardTip()
end
function prototype.ShowContinueTip(A0_141, A1_142)
  local L2_143, L3_144, L4_145, L5_146
  L2_143 = A0_141.endLevelUp
  L3_144 = A0_141.dropItems
  if L3_144 then
    L3_144 = next
    L4_145 = A0_141.dropItems
    L3_144 = L3_144(L4_145)
    if L3_144 then
      L3_144 = A0_141.endDropItems
      L3_144 = not L3_144
    end
  end
  if (not A1_142 or L3_144) and (A1_142 or not L2_143) then
    return
  end
  L4_145 = CCSprite
  L5_146 = L4_145
  L4_145 = L4_145.create
  L4_145 = L4_145(L5_146, "images/font/click_go_on.png")
  L5_146 = L4_145.setPosition
  L5_146(L4_145, ccp(320, 35))
  L5_146 = A0_141.rootNode
  L5_146 = L5_146.addChild
  L5_146(L5_146, L4_145, 999)
  L5_146 = CCArray
  L5_146 = L5_146.create
  L5_146 = L5_146(L5_146)
  L5_146:addObject(CCFadeTo:create(1, 0))
  L5_146:addObject(CCFadeTo:create(1, 255))
  L4_145:runAction(CCRepeatForever:create(CCSequence:create(L5_146)))
end
function prototype.GetCurrencyName(A0_147)
  local L1_148
  L1_148 = ""
  if Logic:Get("BattleShow"):IsInActive2() then
    L1_148 = TwGetStr(107016)
    return L1_148
  end
  if Logic:Get("Gift"):IsOpenActivity("QINGMING") then
    L1_148 = TwGetStr(110760)
    return L1_148
  end
  if Logic:Get("Gift"):IsOpenActivity("OPEN_BOX_KEY") then
    L1_148 = TwGetStr(117018)
    return L1_148
  end
  if Logic:Get("Gift"):IsOpenActivity("SMASH_EGG") then
    L1_148 = TwGetStr(107070)
    return L1_148
  end
  if Logic:Get("Gift"):IsOpenActivity("SWEET_HOUSE") then
    L1_148 = TwGetStr(108262)
    return L1_148
  end
  if Logic:Get("Gift"):IsOpenActivity("TURKEY") then
    L1_148 = TwGetStr(108768)
    return L1_148
  end
  return L1_148
end
function prototype.IsShowOtherCurrency(A0_149)
  if Logic:Get("BattleShow"):IsInActive2() then
    return true
  end
  if Logic:Get("Gift"):IsOpenActivity("QINGMING") then
    return true
  end
  if Logic:Get("Gift"):IsOpenActivity("OPEN_BOX_KEY") then
    return true
  end
  if Logic:Get("Gift"):IsOpenActivity("SMASH_EGG") then
    return true
  end
  if Logic:Get("Gift"):IsOpenActivity("SWEET_HOUSE") then
    return false
  end
  if Logic:Get("Gift"):IsOpenActivity("TURKEY") then
    return true
  end
  return false
end
function prototype.GetCurrencyAmount(A0_150, A1_151)
  local L2_152
  function L2_152(A0_153, A1_154)
    local L2_155
    L2_155 = Logic
    L2_155 = L2_155.Get
    L2_155 = L2_155(L2_155, "Reward")
    L2_155 = L2_155.GetItemsByType
    L2_155 = L2_155(L2_155, A0_153, A1_154)
    return Logic:Get("Reward"):CalcTotleNum(L2_155) or 0
  end
  if Logic:Get("BattleShow"):IsInActive2() then
    return L2_152(A1_151, Logic.Reward.REWARDS_TYPE.SOUL_STONE)
  end
  if Logic:Get("Gift"):IsOpenActivity("QINGMING") then
    return L2_152(A1_151, Logic.Reward.REWARDS_TYPE.JIPING)
  end
  if Logic:Get("Gift"):IsOpenActivity("OPEN_BOX_KEY") then
    return L2_152(A1_151, Logic.Reward.REWARDS_TYPE.BOX_KEY)
  end
  if Logic:Get("Gift"):IsOpenActivity("SMASH_EGG") then
    return L2_152(A1_151, Logic.Reward.REWARDS_TYPE.EGG_HAMMER)
  end
  if Logic:Get("Gift"):IsOpenActivity("SWEET_HOUSE") then
    return L2_152(A1_151, Logic.Reward.REWARDS_TYPE.SWEET)
  end
  if Logic:Get("Gift"):IsOpenActivity("TURKEY") then
    return L2_152(A1_151, Logic.Reward.REWARDS_TYPE.TURKEY)
  end
  return 0
end
