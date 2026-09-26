local L0_0
L0_0 = module
L0_0((...), package.seeall)
L0_0 = Tw
L0_0 = L0_0.Controller
L0_0 = L0_0.prototype
L0_0 = L0_0.extend
L0_0 = L0_0(L0_0)
prototype = L0_0
L0_0 = require
L0_0("SceneHelper")
L0_0 = 40
function prototype.onEnter(A0_1)
  local L1_2
  L1_2 = Logic
  L1_2 = L1_2.Get
  L1_2(L1_2, "Home")
  L1_2 = A0_1.staChat
  L1_2 = L1_2.setString
  L1_2(L1_2, "")
  L1_2 = A0_1.staChat
  L1_2 = L1_2.setVisible
  L1_2(L1_2, true)
  L1_2 = Logic
  L1_2 = L1_2.Get
  L1_2 = L1_2(L1_2, "PlayerInfo")
  L1_2 = L1_2.On
  L1_2(L1_2, Logic.PlayerInfo.EVT.LEVEL_CHANGE, A0_1:Event("onLevelChanged"))
  L1_2 = Logic
  L1_2 = L1_2.Get
  L1_2 = L1_2(L1_2, "PlayerInfo")
  L1_2 = L1_2.On
  L1_2(L1_2, Logic.PlayerInfo.EVT.CHANK_VIP, A0_1:Event("RefrashGiftInfoThree"))
  L1_2 = Logic
  L1_2 = L1_2.Get
  L1_2 = L1_2(L1_2, "PlayerInfo")
  L1_2 = L1_2.On
  L1_2(L1_2, Logic.PlayerInfo.EVT.DATA_CHANGE, A0_1:Event("RefrashGiftInfoFour"))
  L1_2 = Logic
  L1_2 = L1_2.Get
  L1_2 = L1_2(L1_2, "Hero")
  L1_2 = L1_2.On
  L1_2(L1_2, Logic.Hero.EVT.FIGHT_POINT, A0_1:Event("RefrashGiftInfoFive"))
  L1_2 = Logic
  L1_2 = L1_2.Get
  L1_2 = L1_2(L1_2, "Target")
  L1_2 = L1_2.On
  L1_2(L1_2, Logic.Target.EVT.RE_GET_PROGRESS, A0_1:Event("RefrashGiftInfoSix"))
  L1_2 = Logic
  L1_2 = L1_2.Get
  L1_2 = L1_2(L1_2, "Rebirth")
  L1_2 = L1_2.On
  L1_2(L1_2, Logic.Rebirth.EVT.CLEAR_BATTLE, A0_1:Event("RefrashGiftInfoSeven"))
  L1_2 = Logic
  L1_2 = L1_2.Get
  L1_2 = L1_2(L1_2, "Battle")
  L1_2 = L1_2.On
  L1_2(L1_2, Logic.Battle.EVT.CAMPAIGN_COMPLETED, A0_1:Event("RefrashGiftInfo"))
  L1_2 = Logic
  L1_2 = L1_2.Get
  L1_2 = L1_2(L1_2, "ChristmasActivity")
  L1_2 = L1_2.On
  L1_2(L1_2, Logic.ChristmasActivity.EVT.NEW_REWARD, A0_1:Event("NewChristmasActivity"))
  L1_2 = Logic
  L1_2 = L1_2.Get
  L1_2 = L1_2(L1_2, "Battle")
  L1_2 = L1_2.On
  L1_2(L1_2, Logic.Battle.EVT.BATTLE_COMPLETED, A0_1:Event("OpenCommentTip"))
  L1_2 = Logic
  L1_2 = L1_2.Get
  L1_2 = L1_2(L1_2, "BattleShow")
  L1_2 = L1_2.On
  L1_2(L1_2, Logic.BattleShow.EVT.END, A0_1:Event("onBattleEnd"))
  L1_2 = Logic
  L1_2 = L1_2.Get
  L1_2 = L1_2(L1_2, "Chat")
  L1_2 = L1_2.On
  L1_2(L1_2, Logic.Chat.EVT.POSTS, A0_1:Event("OnGetPosts"))
  L1_2 = Logic
  L1_2 = L1_2.Get
  L1_2 = L1_2(L1_2, "Main")
  L1_2 = L1_2.On
  L1_2(L1_2, Logic.Main.EVT.REFRESH_FUCNTION, A0_1:Event("SetFunctionsVisible"))
  L1_2 = Logic
  L1_2 = L1_2.Get
  L1_2 = L1_2(L1_2, "Main")
  L1_2 = L1_2.On
  L1_2(L1_2, Logic.Main.EVT.GOTO_RECHARGE, A0_1:Event("onConfirmRecharge"))
  L1_2 = Logic
  L1_2 = L1_2.Get
  L1_2 = L1_2(L1_2, "Main")
  L1_2 = L1_2.On
  L1_2(L1_2, Logic.Main.EVT.GOTO_BIND_ACCOUNT, A0_1:Event("onBindAccount"))
  L1_2 = Logic
  L1_2 = L1_2.Get
  L1_2 = L1_2(L1_2, "Mall")
  L1_2 = L1_2.On
  L1_2(L1_2, Logic.Mall.EVT.BUY_POINTS, A0_1:Event("BuyPoints"))
  L1_2 = Logic
  L1_2 = L1_2.Get
  L1_2 = L1_2(L1_2, "Achievement")
  L1_2 = L1_2.On
  L1_2(L1_2, Logic.Achievement.EVT.GET_CHAPTER, A0_1:Event("onGetAchievement"))
  L1_2 = Logic
  L1_2 = L1_2.Get
  L1_2 = L1_2(L1_2, "Account")
  L1_2 = L1_2.On
  L1_2(L1_2, Logic.Account.EVT.BIND_ACCOUNT, A0_1:Event("BingAccountGift"))
  L1_2 = Logic
  L1_2 = L1_2.Get
  L1_2 = L1_2(L1_2, "Devil")
  L1_2 = L1_2.On
  L1_2(L1_2, Logic.Devil.EVT.PUSH_DEMOG_INFO, A0_1:Event("pushDemogInfo"))
  L1_2 = Logic
  L1_2 = L1_2.Get
  L1_2 = L1_2(L1_2, "Devil")
  L1_2 = L1_2.On
  L1_2(L1_2, Logic.Devil.EVT.PUSH_FEATS_RANK, A0_1:Event("pushDemogFeatsRank"))
  L1_2 = Logic
  L1_2 = L1_2.Get
  L1_2 = L1_2(L1_2, "Pvp")
  L1_2 = L1_2.On
  L1_2(L1_2, Logic.Pvp.EVT.RELOAD_MATCH_LIST, A0_1:Event("GetMatchList"))
  L1_2 = Logic
  L1_2 = L1_2.Get
  L1_2 = L1_2(L1_2, "Lottery")
  L1_2 = L1_2.On
  L1_2(L1_2, Logic.Lottery.EVT.SHOW_CARDS, A0_1:Event("onShowCards"))
  L1_2 = Logic
  L1_2 = L1_2.Get
  L1_2 = L1_2(L1_2, "PlayerInfo")
  L1_2 = L1_2.On
  L1_2(L1_2, Logic.PlayerInfo.EVT.SHOW_DAILY, A0_1:Event("onShowDaily"))
  L1_2 = Singleton
  L1_2 = L1_2(NetMgr)
  L1_2 = L1_2.On
  L1_2(L1_2, NetMgr.EVT.NEW_DAY, A0_1:Event("OnNewDay"))
  L1_2 = A0_1.RunAnimation
  L1_2(A0_1)
  L1_2 = Logic
  L1_2 = L1_2.Get
  L1_2 = L1_2(L1_2, "PlayerInfo")
  L1_2 = L1_2.GetPlayerLevel
  L1_2 = L1_2(L1_2)
  A0_1.level = L1_2
  L1_2 = Logic
  L1_2 = L1_2.Get
  L1_2 = L1_2(L1_2, "Devil")
  L1_2 = L1_2.GetFeatsRankTop
  L1_2 = L1_2(L1_2)
  A0_1:UpdateCallboardState()
  if Logic:Get("PlayerInfo"):IsNeedResetPlayerName() then
    Logic:Get("PlayerInfo"):SetResetNameType(Logic.PlayerInfo.CHANGE_NAME.PLAYER_NAME)
    SceneHelper:pushPrompt("Rename", A0_1.rootNode)
    return
  end
  if Logic:Get("Sect"):IsNeedRename() then
    Logic:Get("PlayerInfo"):SetResetNameType(Logic.PlayerInfo.CHANGE_NAME.MENPAI_NAME)
    SceneHelper:pushPrompt("Rename", A0_1.rootNode)
    return
  end
  if Logic:Get("Login"):GetIsCreateRole() then
    SceneHelper:pushScene("DrawLoginEntry", nil, A0_1.mainScene)
  elseif A0_1.level >= Logic:Get("Draw"):getNextDrawLevel() and Logic:Get("Draw"):getHasDraw() and not Logic:Get("BattleShow"):IsEnterBattle() then
    SceneHelper:pushScene("DrawEntry", nil, A0_1.mainScene)
  else
    Logic:Get("Guide"):check()
    if not Logic:Get("Guide"):isGuiding() and not Logic:Get("BattleShow"):IsEnterBattle() then
      if not Logic:Get("PlayerInfo"):IsDrawTodayReward() then
        SceneHelper:pushScene("LoginReward", A0_1.rootNode)
      end
      if Logic:Get("Devil"):getActiveId() ~= nil and L1_2 ~= nil and next(L1_2) ~= nil and tonumber(Logic:Get("System"):GetTimeStr("%H")) >= 9 and not SceneHelper:isExistScene("DevilShowFeatsRank") then
        Singleton(Timer):After(0, A0_1:Event("SHOW_FEATS_RANK", function()
          SceneHelper:pushScene("DevilShowFeatsRank", _UPVALUE0_.rootNode)
        end))
      end
      if Logic:Get("PhoneFee"):IsShowLoginCallFee() then
        Singleton(Timer):After(0, A0_1:Event("SHOW_PHONE_FEE", function()
          SceneHelper:pushPrompt("GiveCallFee", _UPVALUE0_.rootNode)
        end))
        return
      end
      if Logic:Get("Platform"):IsOpenAd() then
        Singleton(Timer):After(0, A0_1:Event("SHOW_AD", function()
          SceneHelper:pushPrompt("MainAdVote", _UPVALUE0_.rootNode)
        end))
        return
      end
      if A0_1:IsNeedShowAd() then
        Singleton(Timer):After(0, A0_1:Event("SHOW_AD", function()
          SceneHelper:pushPrompt("MainAd", _UPVALUE0_.rootNode)
        end))
      end
    end
  end
end
function prototype.IsNeedShowAd(A0_3)
  if Logic:Get("Gift"):IsOpenActivity("OPEN_BETA_GOODS") then
    return true
  end
  if Logic:Get("Gift"):IsOpenActivity("CONSUME_RANK") then
    return true
  end
  if Logic:Get("Gift"):IsOpenActivity("OLD_USER_CHARGE_TREBLE") then
    return true
  end
  if A0_3.level >= 60 then
    return true
  end
  return false
end
function prototype.UpdateCallboardState(A0_4)
  if Logic:Get("PlayerInfo"):GetPlayerLevel() > 5 and (Logic:Get("System"):GetSysVariableMisc("NeedOpenCallboard") == 0 or Logic:Get("System"):GetSysVariableMisc("NeedOpenCallboard") == "" or Logic:Get("System"):GetSysVariableMisc("NeedOpenCallboard") == nil) then
    Logic:Get("System"):SetSysVariableMisc("NeedOpenCallboard", 1)
  end
end
function prototype.OnGetPosts(A0_5, A1_6, A2_7)
  local L3_8, L4_9, L5_10, L6_11, L7_12
  L3_8 = A0_5.staChat
  L4_9 = L3_8
  L3_8 = L3_8.setString
  L5_10 = A2_7
  L3_8(L4_9, L5_10)
  L3_8 = A0_5.staChat
  L4_9 = L3_8
  L3_8 = L3_8.getContentSize
  L3_8 = L3_8(L4_9)
  L4_9 = ccp
  L5_10 = L3_8.width
  L5_10 = 640 - L5_10
  L6_11 = 114
  L4_9 = L4_9(L5_10, L6_11)
  L5_10 = L3_8.width
  L6_11 = _UPVALUE0_
  L5_10 = L5_10 / L6_11
  L6_11 = {}
  L7_12 = CCMoveTo
  L7_12 = L7_12.create
  L7_12 = L7_12(L7_12, L5_10, L4_9)
  table.insert(L6_11, CCMoveTo:create(0, ccp(640, 114)))
  table.insert(L6_11, L7_12)
  table.insert(L6_11, CCDelayTime:create(3))
  table.insert(L6_11, CCMoveTo:create(0, ccp(640, 114)))
  A0_5.staChat:runAction(Logic:Get("AniMgr"):CreateSequence(L6_11))
end
function prototype.bindAnimationMgr(A0_13)
  local L1_14
  L1_14 = true
  return L1_14
end
function prototype.completedAnimationSequenceNamed(A0_15, A1_16)
end
function prototype.RunAnimation(A0_17, A1_18)
  local L2_19, L3_20
  L2_19 = "Default Timeline"
  L3_20 = A1_18 or L2_19
  A0_17.animationMgr:runAnimations(L3_20)
end
function prototype.onLevelChanged(A0_21)
  Logic:Get("Guide"):check()
  if Logic:Get("PlayerInfo"):GetPlayerLevel() == 56 then
    Logic:Get("Gift"):PostGetActivitys()
  end
  Logic:Get("Gift"):HasRewardGift()
  Logic:Get("Gift"):HasRewardGiftActivity()
  A0_21:UpdateCallboardState()
  Logic:Get("PhoneFee"):SetLevelChange(true)
  Logic:Get("WeChat"):LevelUp()
end
function prototype.onBattleEnd(A0_22)
  if Logic:Get("Facebook"):GetShareCbbBool() then
    Logic:Get("Facebook"):SetShareCbbBool(false)
  end
  if Logic:Get("Draw"):getHasDraw() and Logic:Get("PlayerInfo"):GetPlayerLevel() >= Logic:Get("Draw"):getNextDrawLevel() then
    SceneHelper:pushScene("DrawEntry", nil, A0_22.mainScene)
    return
  end
  Logic:Get("Guide"):check()
  if not Logic:Get("Guide"):isGuiding() then
    if Logic:Get("Devil"):IsNeedPushAdv() then
      SceneHelper:pushPrompt("DevilAdv", nil)
      return
    end
    if Logic:Get("Devil"):GetHasDemog() then
      MsgDemog:Post("REFRESH_DEMOG")
      Singleton(Timer):After(1000, A0_22:Event("SET_HAS_DEMOG", function()
        Logic:Get("Devil"):SetHasDemog(false)
      end))
      return
    end
    if not Logic:Get("BattleShow"):GetFailRewardAndResult() and Logic:Get("BattleShow"):GetFailRewardAndResult() then
      if not table.empty(Logic:Get("BattleShow"):GetFailRewardAndResult().rewards or {}) then
        SceneHelper:pushPrompt("BattleFailTip", A0_22.rootNode)
        return
      end
    end
    if true then
      Logic:Get("Facebook"):SetShareCbbBool(true)
    end
    Logic:Get("Facebook"):OpenFaceBook()
    Logic:Get("WeChat"):OpenWeChat()
    if Logic:Get("PhoneFee"):CanShowCallFee() then
      SceneHelper:pushPrompt("GiveCallFee", A0_22.rootNode)
    end
    Logic:Get("PhoneFee"):SetLevelChange(false)
  end
end
function prototype.OpenCommentTip(A0_23, A1_24)
  Logic:Get("Devil"):SetComBattleId(A1_24)
  A0_23:RefrashGiftInfo(A1_24)
  if A1_24 == "CN07BN01" then
    Logic:Get("SureConfirm"):SetMonVipShow(true)
  end
  if KFDBGetRecord("ConfigValue", "GIFT:SP_COMMENT_BATTLE") == nil then
    return
  end
  if not Logic:Get("System"):IsOperator("appstore") then
    return
  end
  if nil ~= Logic:Get("System"):GetMisc("HideAutoPatch") and 0 ~= Logic:Get("System"):GetMisc("HideAutoPatch") or false then
    return
  end
  if A1_24 ~= KFDBGetRecord("ConfigValue", "GIFT:SP_COMMENT_BATTLE").content then
    return
  end
end
function prototype.RefrashGiftInfo(A0_25, A1_26)
  Logic:Get("Gift"):HasRewardGift(A1_26)
  Logic:Get("Gift"):HasRewardGiftActivity(A1_26)
end
function prototype.RefrashGiftInfoThree(A0_27, A1_28)
  if Logic:Get("PlayerInfo"):CheckIsVip() then
    Logic:Get("Gift"):UpdataVipGift()
    Logic:Get("Gift"):HasRewardGiftActivity(A1_28)
  end
end
function prototype.RefrashGiftInfoFour(A0_29, A1_30)
  Logic:Get("Gift"):HasRewardGift(A1_30)
  Logic:Get("Gift"):HasRewardGiftActivity(A1_30)
end
function prototype.RefrashGiftInfoFive(A0_31, A1_32)
  Logic:Get("Gift"):HasRewardGiftActivity()
end
function prototype.RefrashGiftInfoSix(A0_33)
  Logic:Get("Gift"):HasRewardGiftActivity()
end
function prototype.RefrashGiftInfoSeven(A0_34, A1_35)
  Logic:Get("Gift"):HasRewardGift(nil, nil, A1_35)
end
function prototype.BingAccountGift(A0_36)
  Logic:Get("Gift"):IsDrawSpREcard()
end
function prototype.onGetAchievement(A0_37)
  if A0_37.level >= Logic:Get("Draw"):getNextDrawLevel() and Logic:Get("Draw"):getHasDraw() and not Logic:Get("BattleShow"):IsEnterBattle() then
    SceneHelper:pushScene("DrawEntry", nil, A0_37.mainScene)
  else
    Logic:Get("Guide"):check()
  end
end
function prototype.SetFunctionsVisible(A0_38, A1_39)
  A0_38.functions:setVisible(A1_39)
end
function prototype.BuyPoints(A0_40, A1_41, A2_42, A3_43)
  local L4_44, L5_45, L6_46, L7_47
  if A1_41 and A2_42 and A3_43 then
    L4_44 = Logic
    L4_44 = L4_44.PlayerInfo
    L4_44 = L4_44.PLAYER_MAX_PHYSICAL
    if L4_44 then
      A0_40.cost = A1_41
      if A3_43 <= 0 then
        L4_44 = Logic
        L5_45 = L4_44
        L4_44 = L4_44.Get
        L6_46 = "SureConfirm"
        L4_44 = L4_44(L5_45, L6_46)
        L4_44 = L4_44.btnText
        L5_45 = TwGetStr
        L6_46 = 104003
        L5_45 = L5_45(L6_46)
        L4_44.ok = L5_45
        L4_44 = Prompt
        L5_45 = L4_44
        L4_44 = L4_44.Confirm
        L6_46 = A0_40
        L7_47 = nil
        L4_44(L5_45, L6_46, L7_47, TwGetStr(100049), A0_40.onConfirmRecharge, Prompt.PROMPT_TYPE.SELECT)
        return
      end
      L4_44 = Logic
      L5_45 = L4_44
      L4_44 = L4_44.Get
      L6_46 = "PlayerInfo"
      L4_44 = L4_44(L5_45, L6_46)
      L5_45 = L4_44
      L4_44 = L4_44.GetPlayerPhysical
      L4_44 = L4_44(L5_45)
      L5_45 = Logic
      L6_46 = L5_45
      L5_45 = L5_45.Get
      L7_47 = "Egg"
      L5_45 = L5_45(L6_46, L7_47)
      L6_46 = L5_45
      L5_45 = L5_45.GetCongifValueByKey
      L7_47 = "POINT:SINGLE_BUY_LIMIT"
      L5_45 = L5_45(L6_46, L7_47)
      if L5_45 > 0 then
        L6_46 = L4_44.point
        if L5_45 <= L6_46 then
          L6_46 = Prompt
          L7_47 = L6_46
          L6_46 = L6_46.Fail
          L6_46(L7_47, TwGetStr(105291, A3_43))
          return
        end
      end
      L6_46 = Logic
      L7_47 = L6_46
      L6_46 = L6_46.Get
      L6_46 = L6_46(L7_47, "Mall")
      L6_46 = L6_46.isFromMall
      if L6_46 then
        L7_47 = Logic
        L7_47 = L7_47.Get
        L7_47 = L7_47(L7_47, "Mall")
        L7_47 = L7_47.SetFromMall
        L7_47(L7_47, false)
        L7_47 = "    "
        L7_47 = L7_47 .. TwGetStr(105237, A1_41, A2_42, A3_43)
        Prompt:ConfirmLeft(A0_40, 105219, L7_47, A0_40.onConfirmBuy, Prompt.PROMPT_TYPE.SELECT)
        return
      end
      L7_47 = "    "
      L7_47 = L7_47 .. TwGetStr(105202, A1_41, A2_42, A3_43)
      Prompt:ConfirmLeft(A0_40, 105201, L7_47, A0_40.onConfirmBuy, Prompt.PROMPT_TYPE.SELECT)
    end
  end
end
function prototype.onConfirmBuy(A0_48)
  if Logic:Get("PlayerInfo"):GetPlayerAllJade() < A0_48.cost then
    Logic:Get("SureConfirm").btnText.ok = TwGetStr(104003)
    Prompt:Confirm(A0_48, "", 105316, A0_48.onConfirmRecharge, Prompt.PROMPT_TYPE.SELECT)
    return
  end
  Logic:Get("Mall"):PostBuySingle()
end
function prototype.pushDemogInfo(A0_49)
  SceneHelper:pushScene("DevilInfo", A0_49.rootNode)
end
function prototype.onConfirmRecharge(A0_50)
  local L1_51
  L1_51 = 1409068800
  if Logic:Get("System"):DiffTime(L1_51) > 0 then
    return
  end
  if Logic:Get("System"):IsCloseCharge() then
    Logic:Get("Mall"):SetTokenCoinData({
      id = 460,
      type = "TOKEN_COIN_7",
      title = "\228\187\153\233\135\145\229\149\134\229\186\151",
      kind = "TOKEN_COIN",
      endTime = 4102444800000
    })
    Logic:Get("Mall"):setIsFrom("Mall")
    SceneHelper:pushScene("MallExchange", A0_50.rootNode)
    return
  end
  if Logic:Get("System"):IsOperator("ilovewebgame") and Logic:Get("Account"):GetIsVisitorType() then
    Prompt:Confirm(Logic:Get("Main"), "", 102217, Logic:Get("Main").GotoBindAccount, Prompt.PROMPT_TYPE.SELECT)
    return
  end
  SceneHelper:pushScene("Recharge", A0_50.rootNode)
end
function prototype.pushDemogFeatsRank(A0_52)
  local L1_53
end
function prototype.onBindAccount(A0_54)
  local L1_55
  L1_55 = Logic
  L1_55 = L1_55.Get
  L1_55 = L1_55(L1_55, "System")
  L1_55 = L1_55.IsSelfAccLogin
  L1_55 = L1_55(L1_55)
  if not L1_55 then
    L1_55 = Logic
    L1_55 = L1_55.Get
    L1_55 = L1_55(L1_55, "System")
    L1_55 = L1_55.IsSelfAccUI
    L1_55 = L1_55(L1_55)
  else
    if L1_55 then
      L1_55 = SceneHelper
      L1_55 = L1_55.pushScene
      L1_55(L1_55, "AccountBind", A0_54.rootNode)
  end
  else
    L1_55 = Logic
    L1_55 = L1_55.Get
    L1_55 = L1_55(L1_55, "Account")
    L1_55 = L1_55.GetAccName
    L1_55 = L1_55(L1_55)
    Logic:Get("EnvLogic"):BindAccount("", "", L1_55, Logic:Get("Login"):GetLoginInfo().server)
  end
end
function prototype.onShowCards(A0_56)
  SceneHelper:pushScene("LotteryResult", A0_56.rootNode)
end
function prototype.OnNewDay(A0_57)
  Logic:Get("Devil"):SetFeat(0)
  Logic:Get("PlayerInfo"):PostDailyCheckInfo()
  Logic:Get("PlayerInfo"):PostGetBuffs()
  if not Logic:Get("Lock"):checkStatusById("PVP_NEW") then
    Logic:Get("Pvp"):PostGetPvpInfo()
  end
  Logic:Get("Target"):PostGetProgress(nil)
  Logic:Get("Gift"):PostAllGift()
  Logic:Get("Gift"):PostGetActivitys()
end
function prototype.onShowDaily(A0_58)
  if not SceneHelper:isExistPrompt("LoginReward") and not SceneHelper:isExistScene("Strategy") then
    SceneHelper:pushScene("LoginReward", A0_58.rootNode)
  end
end
function prototype.GetMatchList(A0_59)
  SceneHelper:runWithScene("PvpMain", A0_59.rootNode)
end
function prototype.NewChristmasActivity(A0_60)
  Logic:Get("Gift"):FireEvent(Logic.Gift.EVT.REFRESH_GIFT)
end
