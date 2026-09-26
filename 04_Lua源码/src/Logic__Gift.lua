local L0_0
L0_0 = module
L0_0((...), package.seeall)
L0_0 = require
L0_0("Logic")
L0_0 = require
L0_0("MsgGift")
L0_0 = require
L0_0("SceneHelper")
L0_0 = require
L0_0("MsgAccount")
L0_0 = Enum
L0_0 = L0_0({
  "REFRESH_GIFT",
  "REFRESH_TIP",
  "REFRESH_AFFTER_GET_FIT",
  "OPEN_PROGRESS"
})
EVT = L0_0
L0_0 = Enum
L0_0 = L0_0(TypeDef("com.eyu.mt.module.gift.facade.GiftResult"))
SHOW_TYPES = {
  COPPER = "images/Other/goldBig.png",
  GOLD = "images/Other/xianyu.png",
  ACTION = "images/Other/action.png",
  MYSTCARD = "images/Other/mstycard.png",
  GOLDCARD = "images/Other/ncard.png",
  EXP = "images/Other/playerExp.png",
  DEMOG_ENERGY = "images/Other/energy.png",
  DEMOG_FRAGMENT = "images/Other/devilFrag.png",
  LOTTERY = "images/Other/mstycard.png",
  SOUL_STONE = "images/Other/soul_stone.png",
  SOUL_STONE_1 = "images/Other/soulStone1.png",
  SOUL_STONE_2 = "images/Other/soulStone2.png",
  SOUL_STONE_3 = "images/Other/soulStone3.png",
  TOKEN_COIN = "images/Other/tokenCoin.png",
  ARENA_INTEGRAL = "images/Other/integral.png",
  TOKEN_COIN_1 = "images/Other/luckyCoin.png",
  TOKEN_COIN_4 = "images/Other/coinGold.png",
  TOKEN_COIN_6 = "images/Other/diamond.png",
  TOKEN_COIN_7 = "images/Other/xianjinClean.png",
  VIP_TIME = "images/Other/xianyu.png",
  EGG_HAMMER = "images/Other/eggHammer.png",
  BOX_KEY_0 = "images/Other/bronzeKey.png",
  BOX_KEY_1 = "images/Other/silverKey.png",
  BOX_KEY_2 = "images/Other/goldenKey.png",
  TREASURE_ROOM_CURRENCY = "images/Other/gift.png",
  COUPON = "images/Other/coupon.png",
  JIPING = "images/Other/jiPing.png",
  MENPAI_MONEY = "images/Other/bpFeat.png",
  PURPLE = "images/Other/purple.png",
  ORANGE = "images/Other/orange.png",
  SECRETSHOP_CURRENCY = "images/Other/secretshop.png",
  FOOTBALL = "images/Other/football.png",
  RED = "images/Other/red.png",
  MONOPOLY = "images/Other/monopoly.png",
  NEW_MONOPOLY = "images/Other/monopoly.png",
  MYST_FRAGMENT = "images/Other/mstycardFra.png",
  TALISMAN_LIEBI = "images/Other/talismanLieBi.png",
  FIRE_REWARD = "images/Other/fireWorks.png",
  SLOT_LOTTERY_TIMES = "images/Other/lotteryChance.png",
  SWEET_1 = "images/Other/sweet1.png",
  SWEET_2 = "images/Other/sweet2.png",
  SWEET_4 = "images/Other/sweet1.png",
  SWEET_5 = "images/Other/sweet2.png",
  EXPLOIT = "images/Other/exploit.png",
  BOX_1 = "images/Other/box1.png",
  BOX_2 = "images/Other/box2.png",
  GLOBAL_GIFt = "images/Other/globalGift.png",
  EXPLORE_NPC_EXP = "images/Other/npcExp.png",
  SWEET_0 = "images/Other/sweet0.png",
  SWEET_3 = "images/Other/sweet3.png",
  MOON = "images/Other/moon.png",
  DICE = "images/Other/dice.png",
  UNIVERSAL_DICE = "images/Other/universalDice.png",
  RENAME = "images/Other/coupon.png"
}
class = Logic.class:subclass()
function class.initialize(A0_1)
  super.initialize(A0_1)
  A0_1.validGiftVo = {}
  A0_1.users = {}
  A0_1.arrGift = {}
  A0_1.arrGiftIndexOfId = {}
  A0_1.canShowGift = {}
  A0_1.giftID = {}
  A0_1.integrateID = {}
  A0_1.hasReward = nil
  A0_1.logs = {}
  A0_1.activitys = {}
  A0_1.spRecord = {}
  A0_1.activityGift = {}
  A0_1.arrGiftsActivitys = {}
  A0_1.switchComment = false
  A0_1.christmasNew = false
  A0_1.costRankType = 1
  Logic:Get("MsgAssist"):RecordErrorMsg("MsgGift", _UPVALUE0_, _UPVALUE1_)
  MsgGift:On("ALL_GIFTS", A0_1:Event("OnAllGift"), true)
  MsgGift:On("DRAW_GLOBAL", A0_1:Event("OnDrawGloBal"), false)
  MsgGift:On("DRAW_SP_REGISTER", A0_1:Event("OnDRAW_SP_REGISTER"), true)
  MsgGift:On("DRAW_SP_COMMENT", A0_1:Event("OnDRAW_SP_COMMENT"), true)
  MsgGift:On("DRAW_USER", A0_1:Event("OnDRAW_USER"), false)
  MsgGift:On("DRAW_SERIAL", A0_1:Event("onDrawSerial"))
  MsgGift:On("GET_ACTIVITYS", A0_1:Event("OnGetActivitys"))
  MsgGift:On("DRAW_ACTIVITY", A0_1:Event("onDrawActivitys"))
  MsgGift:On("PROGRESS_REWARDS", A0_1:Event("OnProgressRewards"))
  MsgGift:On("CLAIM_PROGRESS", A0_1:Event("OnClaimProgress"), false)
  Singleton(NetMgr):On(NetMgr.EVT.NEW_GIFT, A0_1:Event("PostAllGift"), true)
  Singleton(NetMgr):On(NetMgr.EVT.NEW_ACTIVITY, A0_1:Event("PostGetActivitys"), true)
  Singleton(NetMgr):On(NetMgr.EVT.CHARGE, A0_1:Event("PostGetActivitys"), true)
  Singleton(NetMgr):On(NetMgr.EVT.GIFT_SP_COMMENT_CLOSED, A0_1:Event("setSwitchCommentClose"), true)
end
function class.PostProgressRewards(A0_2)
  MsgGift:Post("PROGRESS_REWARDS", {})
end
function class.OnProgressRewards(A0_3, A1_4, A2_5)
  if A1_4 == 0 then
    A0_3.progressRewards = A2_5
    A0_3:FireEvent(EVT.REFRESH_GIFT)
  end
end
function class.PostClaimProgress(A0_6, A1_7, A2_8)
  MsgGift:Post("CLAIM_PROGRESS", {category = A1_7, threshold = A2_8})
end
function class.OnClaimProgress(A0_9, A1_10, A2_11)
  local L3_12
  if A1_10 == 0 then
    L3_12 = Logic
    L3_12 = L3_12.Get
    L3_12 = L3_12(L3_12, "BGSound")
    L3_12 = L3_12.PlayEffect
    L3_12(L3_12, "audio/gift.mp3")
    L3_12 = A2_11.state
    A0_9.progressRewards = L3_12
    L3_12 = Logic
    L3_12 = L3_12.Get
    L3_12 = L3_12(L3_12, "Reward")
    L3_12 = L3_12.AddRewards
    L3_12(L3_12, A2_11.rewards)
    L3_12 = Logic
    L3_12 = L3_12.Get
    L3_12 = L3_12(L3_12, "Reward")
    L3_12 = L3_12.AddRewardsTip
    L3_12 = L3_12(L3_12, A2_11.rewards)
    Prompt:Confirm(nil, 0, L3_12)
    A0_9:FireEvent(EVT.REFRESH_GIFT)
  else
    L3_12 = Logic
    L3_12 = L3_12.Get
    L3_12 = L3_12(L3_12, "MsgAssist")
    L3_12 = L3_12.OnMsgResult
    L3_12(L3_12, "MsgGift", A1_10)
    L3_12 = A0_9.PostProgressRewards
    L3_12(A0_9)
  end
end
function class.OpenProgress(A0_13, A1_14)
  A0_13:FireEvent(EVT.OPEN_PROGRESS, A1_14)
end
function class.HasProgressReward(A0_15, A1_16)
  local L2_17
  L2_17 = A0_15.progressRewards
  L2_17 = L2_17 or {}
  if A1_16 == "LEVEL" then
  else
  end
  for _FORV_7_, _FORV_8_ in ipairs(L2_17.powerTiers or {}) do
    if _FORV_8_.reached and not _FORV_8_.claimed then
      if A1_16 == "LOGIN" and _FORV_8_.rewardType == "TOKEN_COIN" and tonumber(_FORV_8_.code) == 7 and tonumber(_FORV_8_.amount) == 30 then
        if Logic:Get("PlayerInfo"):hasMonthVipFunc() then
          return true
        end
      else
        return true
      end
    end
  end
  return false
end
function class.GetProgressBanner(A0_18, A1_19)
  local L2_20, L3_21, L4_22
  L2_20 = {}
  L3_21 = {}
  L3_21.icon = "data/Mall2/commenBg1.png"
  L3_21.name = "\229\134\178\231\186\167\229\165\150\229\138\177"
  L2_20.LEVEL = L3_21
  L3_21 = {}
  L3_21.icon = "data/Mall2/commenBg2.png"
  L3_21.name = "\230\136\152\229\138\155\229\165\150\229\138\177"
  L2_20.POWER = L3_21
  L3_21 = {}
  L3_21.icon = "data/Mall2/commenBg3.png"
  L3_21.name = "\231\180\175\232\174\161\231\153\187\229\189\149"
  L2_20.LOGIN = L3_21
  L3_21 = L2_20[A1_19]
  L3_21 = L3_21 or L2_20.LOGIN
  L4_22 = {}
  L4_22.id = "PROGRESS_" .. A1_19
  L4_22.activityType = A1_19
  L4_22.progressBanner = true
  L4_22.canDraw = A0_18:HasProgressReward(A1_19)
  L4_22.icon = L3_21.icon
  L4_22.name = L3_21.name
  return L4_22
end
function class.GetProgressGifts(A0_23, A1_24)
  local L2_25, L3_26, L4_27, L5_28, L6_29, L7_30, L8_31, L9_32, L10_33, L11_34, L12_35, L13_36, L14_37, L15_38, L16_39, L17_40
  L2_25 = A0_23.progressRewards
  L2_25 = L2_25 or {}
  L3_26 = L2_25.loginTiers
  L4_27 = L2_25.loginDays
  L4_27 = L4_27 or 0
  L5_28 = "\231\153\187\229\189\149\232\191\155\229\186\166\239\188\154"
  if A1_24 == "LEVEL" then
    L3_26 = L2_25.levelTiers
    L6_29 = L2_25.level
    L4_27 = L6_29 or 0
    L5_28 = "\231\173\137\231\186\167\232\191\155\229\186\166\239\188\154"
  elseif A1_24 == "POWER" then
    L3_26 = L2_25.powerTiers
    L6_29 = L2_25.teamPower
    L4_27 = L6_29 or 0
    L5_28 = "\230\136\152\229\138\155\232\191\155\229\186\166\239\188\154"
  end
  L6_29 = {}
  L7_30 = {}
  L9_32 = L3_26 or {}
  for L11_34, L12_35 in L8_31(L9_32) do
    if A1_24 == "LOGIN" then
      L13_36 = L12_35.claimed
    elseif not L13_36 then
      L13_36 = L12_35.rewardType
      L14_37 = L12_35.code
      if L13_36 == "EXP_CARD" or L13_36 == "TREASURE" then
        L13_36 = "HERO"
      elseif L13_36 == "MYSTCARD" then
        L14_37 = 4
      elseif L13_36 == "TOKEN_COIN" and L14_37 ~= 0 then
        L15_38 = "TOKEN_COIN_"
        L16_39 = tostring
        L17_40 = L14_37
        L16_39 = L16_39(L17_40)
        L13_36 = L15_38 .. L16_39
      elseif L14_37 == 0 then
        L14_37 = 1
      end
      L15_38 = "progress:"
      L16_39 = A1_24
      L17_40 = ":"
      L15_38 = L15_38 .. L16_39 .. L17_40 .. tostring(L12_35.threshold)
      L16_39 = A1_24 == "LOGIN" and L13_36 == "TOKEN_COIN_7" and L16_39 == 30
      L17_40 = L12_35.rewardName
      L17_40 = L17_40 .. "\195\151" .. tostring(L12_35.amount)
      if A1_24 == "LOGIN" and L12_35.rewardName == "\228\187\153\231\142\137" and tonumber(L12_35.amount) == 1000 and tonumber(L12_35.threshold) <= 7 then
        L17_40 = "\228\187\153\231\142\137\195\1511000\227\128\129\228\189\147\229\138\155\195\151200"
        if tonumber(L12_35.threshold) == 1 then
          L17_40 = L17_40 .. "\227\128\129\228\187\153\233\135\145\195\151200"
        end
      end
      if L12_35.claimed then
      elseif L12_35.reached then
        if L16_39 then
        else
        end
      end
      L6_29[L15_38] = {
        id = L15_38,
        canDraw = L12_35.reached and not L12_35.claimed and L16_39 and Logic:Get("PlayerInfo"):hasMonthVipFunc() or false,
        canShow = true,
        claimed = L12_35.claimed,
        progressCategory = A1_24,
        progressThreshold = L12_35.threshold,
        progressCurrent = L4_27,
        reward = {content = "[]"},
        description = {
          name = L5_28 .. tostring(L4_27) .. "/" .. tostring(L12_35.threshold),
          conditions = "\231\130\185\229\135\187\233\162\134\229\143\150",
          info = L17_40,
          showId = L14_37,
          showType = L13_36,
          sort = L11_34
        }
      }
      table.insert(L7_30, L15_38)
    end
  end
  return L8_31, L9_32
end
function class.onLoginAcc(A0_41, A1_42)
  A0_41.accInfo = A1_42
end
function class.GetAccInfo(A0_43)
  local L1_44
  L1_44 = A0_43.accInfo
  return L1_44
end
function class.setSwitchCommentClose(A0_45)
  local L1_46
  A0_45.switchComment = true
end
function class.PostAllGift(A0_47)
  MsgGift:Post("ALL_GIFTS", {})
end
function class.OnAllGift(A0_48, A1_49, A2_50)
  if A1_49 == 0 then
    A0_48.users = A2_50.users
    A0_48.logs = A2_50.drawVo.logs
    A0_48.spRecord = A2_50.spRecord
    A0_48:ConversionIndex(A2_50.globals, A2_50.users)
    A0_48:IsDrawSpREcard()
    A0_48:FireEvent(EVT.REFRESH_GIFT)
  end
end
function class.ConversionIndex(A0_51, A1_52, A2_53)
  A0_51.arrGift = {}
  for _FORV_6_, _FORV_7_ in pairs(A2_53) do
    _FORV_7_.canShow = true
    _FORV_7_.canDraw = true
    _FORV_7_["repeat"] = false
    _FORV_7_.type = 0
    _FORV_7_.description.info = {}
    _FORV_7_.userbool = true
    A0_51.arrGift[_FORV_7_.id] = A2_53[_FORV_6_]
  end
  for _FORV_6_, _FORV_7_ in pairs(A1_52) do
    if _FORV_7_.description.info ~= nil then
      if pcall(function()
        _UPVALUE0_ = json.decode(_UPVALUE1_.description.info)
      end) then
        _FORV_7_.description.info = nil
      end
    end
    if _FORV_7_.reward.content ~= nil then
    end
    A0_51.arrGift[_FORV_7_.id] = A1_52[_FORV_6_]
  end
  A0_51:SetCanShowGif()
end
function class.SetCanShowGif(A0_54)
  local L1_55, L2_56, L3_57, L4_58, L5_59, L6_60, L7_61, L8_62
  L1_55 = {}
  A0_54.arrGiftId = L1_55
  L1_55 = {}
  A0_54.giftID = L1_55
  L1_55 = {}
  A0_54.integrateID = L1_55
  L1_55 = {}
  A0_54.canShowGift = L1_55
  L1_55 = {}
  A0_54.activitysID = L1_55
  L1_55 = Logic
  L1_55 = L1_55.Get
  L1_55 = L1_55(L2_56, L3_57)
  L1_55 = L1_55.GetTime
  L1_55 = L1_55(L2_56)
  for L5_59, L6_60 in L2_56(L3_57) do
    L7_61 = A0_54.logs
    L8_62 = L6_60.id
    L7_61 = L7_61[L8_62]
    if L7_61 ~= nil then
      L7_61 = L6_60["repeat"]
      if L7_61 then
        L7_61 = Logic
        L8_62 = L7_61
        L7_61 = L7_61.Get
        L7_61 = L7_61(L8_62, "System")
        L8_62 = L7_61
        L7_61 = L7_61.GetTimeStr
        L7_61 = L7_61(L8_62, "%x", A0_54.logs[L6_60.id] / 1000)
        L8_62 = Logic
        L8_62 = L8_62.Get
        L8_62 = L8_62(L8_62, "System")
        L8_62 = L8_62.GetTime
        L8_62 = L8_62(L8_62)
        if L7_61 == Logic:Get("System"):GetTimeStr("%x", L8_62) then
          L6_60.canShow = false
        end
      end
    end
    L7_61 = true
    L8_62 = L6_60.startTime
    if L8_62 ~= nil then
      L8_62 = L6_60.startTime
      L8_62 = L8_62 / 1000
      L7_61 = L1_55 >= L8_62
    end
    L8_62 = true
    if L6_60.endTime ~= nil then
      L8_62 = L1_55 <= L6_60.endTime / 1000
    end
    if L7_61 and L8_62 and L6_60.canShow then
      A0_54.canShowGift[L5_59] = L6_60
      table.insert(A0_54.arrGiftId, L5_59)
    end
  end
  L2_56(L3_57, L4_58)
  for L5_59, L6_60 in L2_56(L3_57) do
    L7_61 = A0_54.canShowGift
    L7_61 = L7_61[L6_60]
    L7_61 = L7_61.canShow
    if L7_61 then
      L7_61 = tonumber
      L8_62 = A0_54.canShowGift
      L8_62 = L8_62[L6_60]
      L8_62 = L8_62.type
      L7_61 = L7_61(L8_62)
      if L7_61 ~= 3 then
        L7_61 = type
        L8_62 = A0_54.canShowGift
        L8_62 = L8_62[L6_60]
        L8_62 = L8_62.description
        L8_62 = L8_62.info
        L7_61 = L7_61(L8_62)
        if L7_61 == "table" then
          L7_61 = table
          L7_61 = L7_61.empty
          L8_62 = A0_54.canShowGift
          L8_62 = L8_62[L6_60]
          L8_62 = L8_62.description
          L8_62 = L8_62.info
          L7_61 = L7_61(L8_62)
          if not L7_61 then
            L7_61 = A0_54.canShowGift
            L7_61 = L7_61[L6_60]
            L7_61 = L7_61.description
            L7_61 = L7_61.info
            L7_61 = L7_61[1]
            L7_61 = L7_61.type
            if L7_61 == "CHARGE" then
              L7_61 = table
              L7_61 = L7_61.insert
              L8_62 = A0_54.integrateID
              L7_61(L8_62, L6_60)
            end
          end
        else
          L7_61 = table
          L7_61 = L7_61.insert
          L8_62 = A0_54.giftID
          L7_61(L8_62, L6_60)
        end
      end
    end
  end
end
function class.GetCanShowGif(A0_63)
  local L1_64
  L1_64 = A0_63.canShowGift
  return L1_64
end
function class.GetArrGiftId(A0_65)
  local L1_66
  L1_66 = A0_65.arrGiftId
  return L1_66
end
function class.GetAllGift(A0_67)
  local L1_68
  L1_68 = A0_67.arrGift
  return L1_68
end
function class.GetIntegrateID(A0_69)
  local L1_70
  L1_70 = A0_69.integrateID
  return L1_70
end
function class.GetGiftID(A0_71)
  local L1_72
  L1_72 = A0_71.giftID
  return L1_72
end
function class.HasRewardGift(A0_73, A1_74, A2_75, A3_76)
  local L4_77, L5_78, L6_79, L7_80, L8_81, L9_82, L10_83, L11_84, L12_85, L13_86, L14_87
  L4_77 = Logic
  L5_78 = L4_77
  L4_77 = L4_77.Get
  L4_77 = L4_77(L5_78, L6_79)
  L5_78 = L4_77
  L4_77 = L4_77.GetTime
  L4_77 = L4_77(L5_78)
  L5_78 = A0_73.IsOpenBattleActivtyGift
  L5_78(L6_79)
  L5_78 = false
  for L9_82, L10_83 in L6_79(L7_80) do
    L11_84 = true
    L12_85 = L10_83.startTime
    if L12_85 ~= nil then
      L12_85 = L10_83.startTime
      L12_85 = L12_85 / 1000
      L11_84 = L4_77 >= L12_85
    end
    L12_85 = true
    L13_86 = L10_83.endTime
    if L13_86 ~= nil then
      L13_86 = L10_83.endTime
      L13_86 = L13_86 / 1000
      L12_85 = L4_77 <= L13_86
    end
    if L11_84 and L12_85 then
      L13_86 = L10_83.description
      L13_86 = L13_86.info
      if L13_86 ~= nil then
        L13_86 = type
        L14_87 = L10_83.description
        L14_87 = L14_87.info
        L13_86 = L13_86(L14_87)
        if L13_86 == "table" then
          L13_86 = table
          L13_86 = L13_86.empty
          L14_87 = L10_83.description
          L14_87 = L14_87.info
          L13_86 = L13_86(L14_87)
          if not L13_86 then
            L13_86 = L10_83.description
            L13_86 = L13_86.info
            L13_86 = L13_86[1]
            if L13_86 ~= nil then
              L13_86 = L10_83.description
              L13_86 = L13_86.info
              L13_86 = L13_86[1]
              L13_86 = L13_86.type
              if L13_86 == "TOTAL_DAYS" then
              else
                L13_86 = L10_83.description
                L13_86 = L13_86.info
                L13_86 = L13_86[1]
                L13_86 = L13_86.type
                if L13_86 == "LEVEL" then
                  L13_86 = Logic
                  L14_87 = L13_86
                  L13_86 = L13_86.Get
                  L13_86 = L13_86(L14_87, "PlayerInfo")
                  L14_87 = L13_86
                  L13_86 = L13_86.GetPlayerLevel
                  L13_86 = L13_86(L14_87)
                  L14_87 = tonumber
                  L14_87 = L14_87(L10_83.description.info[1].amount)
                  if L13_86 >= L14_87 then
                    L10_83.canDraw = true
                    A0_73.hasReward = true
                  end
                else
                  L13_86 = L10_83.description
                  L13_86 = L13_86.info
                  L13_86 = L13_86[1]
                  L13_86 = L13_86.type
                  if L13_86 == "BATTLE" then
                    if A1_74 ~= nil then
                      L13_86 = L10_83.description
                      L13_86 = L13_86.info
                      L13_86 = L13_86[1]
                      L13_86 = L13_86.code
                      if A1_74 == L13_86 then
                        L10_83.canDraw = true
                        A0_73.hasReward = true
                      end
                    end
                  else
                    L13_86 = L10_83.description
                    L13_86 = L13_86.info
                    L13_86 = L13_86[1]
                    L13_86 = L13_86.type
                    if L13_86 == "ARENA_INTEGRAL" then
                      L13_86 = Logic
                      L14_87 = L13_86
                      L13_86 = L13_86.Get
                      L13_86 = L13_86(L14_87, "Fight")
                      L14_87 = L13_86
                      L13_86 = L13_86.GetIntegral
                      L13_86 = L13_86(L14_87)
                      L13_86 = L13_86 or 0
                      L14_87 = tonumber
                      L14_87 = L14_87(L10_83.description.info[1].amount)
                      if L13_86 >= L14_87 then
                        L10_83.canDraw = true
                        A0_73.hasReward = true
                      end
                    else
                      L13_86 = L10_83.description
                      L13_86 = L13_86.info
                      L13_86 = L13_86[1]
                      L13_86 = L13_86.type
                      if L13_86 == "CHARGE" then
                        L13_86 = Logic
                        L14_87 = L13_86
                        L13_86 = L13_86.Get
                        L13_86 = L13_86(L14_87, "PlayerInfo")
                        L14_87 = L13_86
                        L13_86 = L13_86.GetPlayerMoney
                        L13_86 = L13_86(L14_87)
                        L14_87 = L13_86.totalCharge
                        if L14_87 >= tonumber(L10_83.description.info[1].amount) then
                          L10_83.canDraw = true
                          A0_73.hasReward = true
                        end
                      else
                        L13_86 = L10_83.description
                        L13_86 = L13_86.info
                        L13_86 = L13_86[1]
                        L13_86 = L13_86.type
                        if L13_86 == "REGISTER" then
                          L14_87 = A0_73
                          L13_86 = A0_73.GetSpRecord
                          L13_86 = L13_86(L14_87)
                          if L13_86 then
                            L14_87 = L13_86.register
                            if L14_87 == 1 then
                              L10_83.canDraw = true
                              A0_73.hasReward = true
                            end
                          end
                        else
                          L13_86 = L10_83.description
                          L13_86 = L13_86.info
                          L13_86 = L13_86[1]
                          L13_86 = L13_86.type
                          if L13_86 == "DEMOG" then
                            L13_86 = Logic
                            L14_87 = L13_86
                            L13_86 = L13_86.Get
                            L13_86 = L13_86(L14_87, "Devil")
                            L14_87 = L13_86
                            L13_86 = L13_86.getFeat
                            L13_86 = L13_86(L14_87)
                            L14_87 = tonumber
                            L14_87 = L14_87(L10_83.description.info[1].amount)
                            if L13_86 >= L14_87 then
                              L10_83.canDraw = true
                              A0_73.hasReward = true
                            end
                          else
                            L13_86 = L10_83.description
                            L13_86 = L13_86.info
                            L13_86 = L13_86[1]
                            L13_86 = L13_86.type
                            if L13_86 == "BATTLE_ACTIVITY" then
                              if A3_76 ~= nil then
                                L13_86 = L10_83.description
                                L13_86 = L13_86.info
                                L13_86 = L13_86[1]
                                L13_86 = L13_86.code
                                if A3_76 == L13_86 then
                                  L10_83.canDraw = true
                                  A0_73.hasReward = true
                                end
                              end
                            else
                              L13_86 = L10_83.description
                              L13_86 = L13_86.info
                              L13_86 = L13_86[1]
                              L13_86 = L13_86.type
                              if L13_86 == "BATTLE_POINT" then
                                if A1_74 then
                                  L13_86 = L10_83.description
                                  L13_86 = L13_86.info
                                  L13_86 = L13_86[1]
                                  L13_86 = L13_86.code
                                  if A1_74 == L13_86 then
                                    L10_83.canDraw = true
                                    A0_73.hasReward = true
                                  end
                                end
                              else
                                L13_86 = L10_83.description
                                L13_86 = L13_86.info
                                L13_86 = L13_86[1]
                                L13_86 = L13_86.type
                                if L13_86 == "TIMING_ACTION_POINT" then
                                  L10_83.canDraw = true
                                  A0_73.hasReward = true
                                else
                                  L13_86 = L10_83.userbool
                                  if L13_86 ~= nil then
                                    L10_83.canDraw = true
                                    A0_73.hasReward = true
                                  end
                                end
                              end
                            end
                          end
                        end
                      end
                    end
                  end
                end
              end
              L13_86 = A0_73.logs
              L14_87 = L10_83.id
              L13_86 = L13_86[L14_87]
              if L13_86 ~= nil then
                L13_86 = L10_83["repeat"]
                if L13_86 then
                  L13_86 = Logic
                  L14_87 = L13_86
                  L13_86 = L13_86.Get
                  L13_86 = L13_86(L14_87, "System")
                  L14_87 = L13_86
                  L13_86 = L13_86.GetTimeStr
                  L13_86 = L13_86(L14_87, "%x", A0_73.logs[L10_83.id] / 1000)
                  L14_87 = Logic
                  L14_87 = L14_87.Get
                  L14_87 = L14_87(L14_87, "System")
                  L14_87 = L14_87.GetTime
                  L14_87 = L14_87(L14_87)
                  if L13_86 == Logic:Get("System"):GetTimeStr("%x", L14_87) then
                    L10_83.canDraw = false
                    A0_73.hasReward = false
                  end
                end
              end
            end
          end
        end
      end
    end
  end
  L6_79(L7_80)
  if A2_75 == nil then
    L6_79(L7_80, L8_81)
  end
end
function class.IsOpenBattleActivtyGift(A0_88)
  if not Logic:Get("Lock"):checkStatusById("BATTLE_ACTIVITY") and A0_88.arrGift.ARTHERO01 and A0_88.logs.ARTHERO01 == nil then
    A0_88.arrGift.ARTHERO01.canShow = true
  end
end
function class.HasIntiGift(A0_89)
  for _FORV_5_, _FORV_6_ in pairs(A0_89.canShowGift) do
    if _FORV_6_.startTime ~= nil then
    end
    if _FORV_6_.endTime ~= nil then
    end
    if Logic:Get("System"):GetTime() >= _FORV_6_.startTime / 1000 and Logic:Get("System"):GetTime() <= _FORV_6_.endTime / 1000 and _FORV_6_.description.info ~= nil and type(_FORV_6_.description.info) == "table" and not table.empty(_FORV_6_.description.info) and _FORV_6_.description.info[1] ~= nil and _FORV_6_.description.info[1].type == "ARENA_INTEGRAL" then
      if (Logic:Get("Fight"):GetIntegral() or 0) >= tonumber(_FORV_6_.description.info[1].amount) then
        _FORV_6_.canDraw = true
        A0_89.hasReward = true
      end
    end
  end
  A0_89:SetCanShowGif()
  A0_89:FireEvent(EVT.REFRESH_TIP)
end
function class.IsGiftDraw(A0_90)
  for _FORV_4_, _FORV_5_ in pairs(A0_90.canShowGift) do
    if _FORV_5_.userbool ~= nil and _FORV_5_.canDraw then
      return true
    end
    if _FORV_5_.canDraw then
      A0_90.hasReward = true
      return true
    end
  end
  return A0_90:IsAcitivityDraw()
end
function class.IsInitDraw(A0_91)
  for _FORV_4_, _FORV_5_ in pairs(A0_91.canShowGift) do
    if _FORV_5_.description.info ~= nil and type(_FORV_5_.description.info) == "table" and not table.empty(_FORV_5_.description.info) and _FORV_5_.description.info[1] ~= nil and _FORV_5_.description.info[1].type == "CHARGE" and _FORV_5_.canDraw then
      A0_91.hasReward = true
      return true
    end
  end
  A0_91.hasReward = false
  return false
end
function class.IsAcitivityDraw(A0_92)
  for _FORV_4_, _FORV_5_ in pairs(A0_92.canShowGiftActivity) do
    if _FORV_5_.canDraw then
      if _FORV_5_.startTime ~= nil then
      end
      if _FORV_5_.endTime ~= nil then
      end
      if Logic:Get("System"):GetTime() >= _FORV_5_.startTime / 1000 and Logic:Get("System"):GetTime() <= _FORV_5_.endTime / 1000 then
        A0_92.hasReward = true
        return true
      end
    end
  end
  if Logic:Get("ChristmasActivity"):getNewRewardFlag() then
    A0_92.hasReward = true
    return true
  end
  if Logic:Get("Dumpling"):getTipFlag() then
    A0_92.hasReward = true
    return true
  end
  if Logic:Get("Consume"):hasConsumeReward() then
    A0_92.hasReward = true
    return true
  end
  if Logic:Get("GodReward"):IsCompleteTask() then
    A0_92.hasReward = true
    return true
  end
  if Logic:Get("Monopoly"):IsCompleteMonoTask() then
    A0_92.hasReward = true
    return true
  end
  if Logic:Get("Explore"):IsCompleteExplore() then
    A0_92.hasReward = true
    return true
  end
  if Logic:Get("ActivityCharge"):hasNewReward() then
    A0_92.hasReward = true
    return true
  end
  if Logic:Get("NewMonopoly"):IsCompleteMonoTask() then
    A0_92.hasReward = true
    return true
  end
  A0_92.hasReward = false
  return false
end
function class.GetInfoStr(A0_93, A1_94, A2_95, A3_96)
  local L4_97, L5_98, L6_99, L7_100, L8_101, L9_102
  L4_97 = A1_94[1]
  L5_98 = TwGetStr
  L6_99 = 103016
  L5_98 = L5_98(L6_99)
  L6_99 = A1_94[1]
  if L6_99 == nil then
    L6_99 = ""
    return L6_99
  end
  L6_99 = type
  L7_100 = L4_97
  L6_99 = L6_99(L7_100)
  if L6_99 == "string" then
    return A1_94
  end
  L6_99 = L4_97.type
  if L6_99 == "TOTAL_DAYS" then
    L6_99 = string
    L6_99 = L6_99.find
    L7_100 = A3_96
    L8_101 = "DengluLibao"
    L6_99 = L6_99(L7_100, L8_101)
    if L6_99 ~= nil and not A2_95 then
      L7_100 = L5_98
      L8_101 = "0/1"
      L5_98 = L7_100 .. L8_101
    elseif L6_99 ~= nil and A2_95 then
      L7_100 = L5_98
      L8_101 = "1/1"
      L5_98 = L7_100 .. L8_101
    else
      L7_100 = L5_98
      L8_101 = A0_93.accInfo
      L8_101 = L8_101.dayByContinuous
      L8_101 = L8_101 + 1
      L9_102 = "/"
      L5_98 = L7_100 .. L8_101 .. L9_102 .. L4_97.amount
    end
    return L5_98
  else
    L6_99 = L4_97.type
    if L6_99 == "LEVEL" then
      L6_99 = Logic
      L7_100 = L6_99
      L6_99 = L6_99.Get
      L8_101 = "PlayerInfo"
      L6_99 = L6_99(L7_100, L8_101)
      L7_100 = L6_99
      L6_99 = L6_99.GetPlayerLevel
      L6_99 = L6_99(L7_100)
      L7_100 = L5_98
      L8_101 = L6_99
      L9_102 = "/"
      L5_98 = L7_100 .. L8_101 .. L9_102 .. L4_97.amount
      return L5_98
    else
      L6_99 = L4_97.type
      if L6_99 == "BATTLE" then
        if A2_95 then
          L6_99 = L5_98
          L7_100 = "1/1"
          L6_99 = L6_99 .. L7_100
          return L6_99
        else
          L6_99 = L5_98
          L7_100 = "0/1"
          L6_99 = L6_99 .. L7_100
          return L6_99
        end
      else
        L6_99 = L4_97.type
        if L6_99 == "ARENA_INTEGRAL" then
          L6_99 = Logic
          L7_100 = L6_99
          L6_99 = L6_99.Get
          L8_101 = "Fight"
          L6_99 = L6_99(L7_100, L8_101)
          L7_100 = L6_99
          L6_99 = L6_99.GetIntegral
          L6_99 = L6_99(L7_100)
          L6_99 = L6_99 or 0
          L7_100 = L5_98
          L8_101 = L6_99
          L9_102 = "/"
          L5_98 = L7_100 .. L8_101 .. L9_102 .. L4_97.amount
          return L5_98
        else
          L6_99 = L4_97.type
          if L6_99 == "CHARGE" then
            L6_99 = Logic
            L7_100 = L6_99
            L6_99 = L6_99.Get
            L8_101 = "PlayerInfo"
            L6_99 = L6_99(L7_100, L8_101)
            L7_100 = L6_99
            L6_99 = L6_99.GetPlayerMoney
            L6_99 = L6_99(L7_100)
            L7_100 = L6_99.totalCharge
            L7_100 = L7_100 or 0
            L8_101 = TwGetStr
            L9_102 = 103069
            L8_101 = L8_101(L9_102)
            L9_102 = L8_101
            L8_101 = L9_102 .. L7_100 .. "/" .. L4_97.amount
            return L8_101
          else
            L6_99 = L4_97.type
            if L6_99 == "GROUP_SCORE" then
              L6_99 = Logic
              L7_100 = L6_99
              L6_99 = L6_99.Get
              L8_101 = "Hero"
              L6_99 = L6_99(L7_100, L8_101)
              L7_100 = L6_99
              L6_99 = L6_99.GetFightingPoints
              L6_99 = L6_99(L7_100)
              L7_100 = L5_98
              L8_101 = L6_99[2]
              L9_102 = "/"
              L5_98 = L7_100 .. L8_101 .. L9_102 .. L4_97.amount
              return L5_98
            else
              L6_99 = L4_97.type
              if L6_99 == "GROUP_STAR" then
                L6_99 = Logic
                L7_100 = L6_99
                L6_99 = L6_99.Get
                L8_101 = "Hero"
                L6_99 = L6_99(L7_100, L8_101)
                L7_100 = L6_99
                L6_99 = L6_99.GetGroupsSrar
                L6_99 = L6_99(L7_100)
                L7_100 = L5_98
                L8_101 = L6_99
                L9_102 = "/"
                L5_98 = L7_100 .. L8_101 .. L9_102 .. L4_97.amount
                return L5_98
              else
                L6_99 = L4_97.type
                if L6_99 == "STAGE_CHARGE" then
                  L6_99 = Logic
                  L7_100 = L6_99
                  L6_99 = L6_99.Get
                  L8_101 = "PlayerInfo"
                  L6_99 = L6_99(L7_100, L8_101)
                  L7_100 = L6_99
                  L6_99 = L6_99.GetPlayerMoney
                  L6_99 = L6_99(L7_100)
                  L7_100 = L6_99.stageCharges
                  L8_101 = L4_97.code
                  L7_100 = L7_100[L8_101]
                  if L7_100 ~= nil then
                    L8_101 = L5_98
                    L9_102 = L7_100
                    L5_98 = L8_101 .. L9_102 .. "/" .. L4_97.amount
                    return L5_98
                  else
                    L8_101 = L5_98
                    L9_102 = 0
                    L5_98 = L8_101 .. L9_102 .. "/" .. L4_97.amount
                    return L5_98
                  end
                else
                  L6_99 = L4_97.type
                  if L6_99 == "TARGET" then
                    L6_99 = 0
                    L7_100 = Logic
                    L8_101 = L7_100
                    L7_100 = L7_100.Get
                    L9_102 = "Target"
                    L7_100 = L7_100(L8_101, L9_102)
                    L8_101 = L7_100
                    L7_100 = L7_100.GetProgress
                    L7_100 = L7_100(L8_101)
                    L8_101 = L4_97.code
                    L8_101 = L7_100[L8_101]
                    if L8_101 then
                      L8_101 = L4_97.code
                      L6_99 = L7_100[L8_101]
                    end
                    L8_101 = L5_98
                    L9_102 = L6_99
                    L5_98 = L8_101 .. L9_102 .. "/" .. L4_97.amount
                    return L5_98
                  else
                    L6_99 = L4_97.type
                    if L6_99 == "DEMOG" then
                      L6_99 = 0
                      L7_100 = Logic
                      L8_101 = L7_100
                      L7_100 = L7_100.Get
                      L9_102 = "Devil"
                      L7_100 = L7_100(L8_101, L9_102)
                      L8_101 = L7_100
                      L7_100 = L7_100.getFeat
                      L7_100 = L7_100(L8_101)
                      L8_101 = L5_98
                      L9_102 = L7_100
                      L5_98 = L8_101 .. L9_102 .. "/" .. L4_97.amount
                      return L5_98
                    else
                      L6_99 = ""
                      return L6_99
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end
function class.PostDrawGlobal(A0_103, A1_104)
  A0_103.giftId = A1_104
  MsgGift:Post("DRAW_GLOBAL", {giftId = A1_104})
end
function class.OnDrawGloBal(A0_105, A1_106, A2_107)
  local L3_108
  if A1_106 == 0 then
    L3_108 = Logic
    L3_108 = L3_108.Get
    L3_108 = L3_108(L3_108, "BGSound")
    L3_108 = L3_108.PlayEffect
    L3_108(L3_108, "audio/gift.mp3")
    A0_105.arrRewardResult = A2_107
    L3_108 = Logic
    L3_108 = L3_108.Get
    L3_108 = L3_108(L3_108, "Reward")
    L3_108 = L3_108.AddRewards
    L3_108(L3_108, A2_107)
    L3_108 = A0_105.arrGift
    L3_108 = L3_108[A0_105.giftId]
    if L3_108 then
      L3_108 = A0_105.arrGift
      L3_108 = L3_108[A0_105.giftId]
      L3_108 = L3_108.description
      L3_108 = L3_108.showType
      if L3_108 == "LOTTERY" then
        L3_108 = Logic
        L3_108 = L3_108.Get
        L3_108 = L3_108(L3_108, "Lottery")
        L3_108 = L3_108.ShowDrawResult
        L3_108(L3_108, A2_107)
      else
        L3_108 = Logic
        L3_108 = L3_108.Get
        L3_108 = L3_108(L3_108, "Reward")
        L3_108 = L3_108.AddRewardsTip
        L3_108 = L3_108(L3_108, A2_107)
        Prompt:Confirm(nil, 0, L3_108, A0_105.FireEnvenAffGetGift)
      end
    else
      L3_108 = Logic
      L3_108 = L3_108.Get
      L3_108 = L3_108(L3_108, "Reward")
      L3_108 = L3_108.AddRewardsTip
      L3_108 = L3_108(L3_108, A2_107)
      Prompt:Confirm(nil, 0, L3_108, A0_105.FireEnvenAffGetGift)
    end
    L3_108 = A0_105.Updata
    L3_108(A0_105, A0_105.giftId)
    L3_108 = A0_105.FireEvent
    L3_108(A0_105, EVT.REFRESH_GIFT)
  else
    L3_108 = Logic
    L3_108 = L3_108.Get
    L3_108 = L3_108(L3_108, "MsgAssist")
    L3_108 = L3_108.OnMsgResult
    L3_108(L3_108, "MsgGift", A1_106)
    if A1_106 ~= -11 then
      L3_108 = Logic
      L3_108 = L3_108.Get
      L3_108 = L3_108(L3_108, "Login")
      L3_108 = L3_108.Login
      L3_108(L3_108)
    end
  end
end
function class.FireEnvenAffGetGift(A0_109)
  Logic:Get("Gift"):FireEvent(EVT.REFRESH_AFFTER_GET_FIT)
end
function class.PoseHasReward(A0_110)
  MsgGift:Post("HAS_REWARD", {})
end
function class.OnHasReward(A0_111, A1_112, A2_113)
  if A1_112 == 0 then
    A0_111.hasReward = A2_113
    A0_111:FireEvent(EVT.REFRESH_GIFT)
  end
end
function class.SetHasReward(A0_114, A1_115)
  A0_114.hasReward = A1_115
end
function class.GetHasReward(A0_116)
  local L1_117
  L1_117 = A0_116.hasReward
  return L1_117
end
function class.PoseDRAW_USER(A0_118, A1_119)
  A0_118.userId = A1_119
  MsgGift:Post("DRAW_USER", {giftId = A1_119})
end
function class.OnDRAW_USER(A0_120, A1_121, A2_122)
  local L3_123
  if A1_121 == 0 then
    L3_123 = Logic
    L3_123 = L3_123.Get
    L3_123 = L3_123(L3_123, "BGSound")
    L3_123 = L3_123.PlayEffect
    L3_123(L3_123, "audio/gift.mp3")
    A0_120.arrRewardResult = A2_122
    L3_123 = Logic
    L3_123 = L3_123.Get
    L3_123 = L3_123(L3_123, "Reward")
    L3_123 = L3_123.AddRewards
    L3_123(L3_123, A2_122)
    L3_123 = Logic
    L3_123 = L3_123.Get
    L3_123 = L3_123(L3_123, "Reward")
    L3_123 = L3_123.AddRewardsTip
    L3_123 = L3_123(L3_123, A2_122)
    Prompt:Confirm(nil, 0, L3_123, A0_120.FireEnvenAffGetGift)
    A0_120:Updata(A0_120.userId)
    A0_120:FireEvent(EVT.REFRESH_GIFT)
  else
    L3_123 = Logic
    L3_123 = L3_123.Get
    L3_123 = L3_123(L3_123, "MsgAssist")
    L3_123 = L3_123.OnMsgResult
    L3_123(L3_123, "MsgGift", A1_121)
    if A1_121 ~= -11 then
      L3_123 = MsgAccount
      L3_123 = L3_123.Post
      L3_123(L3_123, "LOGIN_INFO")
    end
  end
end
function class.PoseDRAW_SP_REGISTER(A0_124)
  MsgGift:Post("DRAW_SP_REGISTER", {})
end
function class.OnDRAW_SP_REGISTER(A0_125, A1_126, A2_127)
  if A1_126 == 0 then
    A0_125.spRecord = A2_127
    Logic:Get("Gift"):HasRewardGift()
  end
end
function class.GetSpRecord(A0_128)
  local L1_129
  L1_129 = A0_128.spRecord
  return L1_129
end
function class.IsDrawSpREcard(A0_130, A1_131)
  if not Logic:Get("Account"):GetIsVisitorType() and A0_130.spRecord.register == 0 then
    A0_130:PoseDRAW_SP_REGISTER()
  end
end
function class.PoseDRAW_SP_COMMENT(A0_132)
  MsgGift:Post("DRAW_SP_COMMENT", {})
end
function class.OnDRAW_SP_COMMENT(A0_133, A1_134, A2_135)
  if A1_134 == 0 then
    A0_133.spRecord = A2_135
  end
end
function class.IsDrawSpComent(A0_136)
  local L1_137
end
function class.Updata(A0_138, A1_139)
  local L2_140, L3_141, L4_142, L5_143, L6_144, L7_145, L8_146
  if L2_140 == nil then
    return
  end
  L2_140[A1_139] = nil
  L5_143 = "System"
  L2_140[A1_139] = L3_141
  for L5_143, L6_144 in L2_140(L3_141) do
    L7_145 = L6_144.description
    L7_145 = L7_145.info
    if L7_145 ~= nil then
      L7_145 = table
      L7_145 = L7_145.empty
      L8_146 = L6_144.description
      L8_146 = L8_146.info
      L7_145 = L7_145(L8_146)
      if not L7_145 then
        L7_145 = L6_144.description
        L7_145 = L7_145.info
        L7_145 = L7_145[1]
        if L7_145 ~= nil then
          L7_145 = L6_144.description
          L7_145 = L7_145.info
          L7_145 = L7_145[1]
          if L7_145 ~= nil then
            L7_145 = L6_144.description
            L7_145 = L7_145.info
            L7_145 = L7_145[1]
            L7_145 = L7_145.type
            if L7_145 == "TOTAL_DAYS" then
              L7_145 = L6_144.description
              L7_145 = L7_145.prev
              if L7_145 ~= nil then
                L7_145 = A0_138.logs
                L8_146 = L6_144.description
                L8_146 = L8_146.prev
                L7_145 = L7_145[L8_146]
                if L7_145 ~= nil then
                  L6_144.canShow = true
                end
              end
            else
              L7_145 = L6_144.description
              L7_145 = L7_145.info
              L7_145 = L7_145[1]
              L7_145 = L7_145.type
              if L7_145 == "LEVEL" then
                L7_145 = L6_144.description
                L7_145 = L7_145.prev
                if L7_145 ~= nil then
                  L7_145 = A0_138.logs
                  L8_146 = L6_144.description
                  L8_146 = L8_146.prev
                  L7_145 = L7_145[L8_146]
                  if L7_145 ~= nil then
                    L6_144.canShow = true
                  end
                end
              else
                L7_145 = L6_144.description
                L7_145 = L7_145.info
                L7_145 = L7_145[1]
                L7_145 = L7_145.type
                if L7_145 == "BATTLE" then
                  L7_145 = L6_144.description
                  L7_145 = L7_145.prev
                  if L7_145 ~= nil then
                    L7_145 = A0_138.logs
                    L8_146 = L6_144.description
                    L8_146 = L8_146.prev
                    L7_145 = L7_145[L8_146]
                    if L7_145 ~= nil then
                      L6_144.canShow = true
                    end
                  end
                else
                  L7_145 = L6_144.description
                  L7_145 = L7_145.info
                  L7_145 = L7_145[1]
                  L7_145 = L7_145.type
                  if L7_145 == "ARENA_INTEGRAL" then
                    L7_145 = L6_144.description
                    L7_145 = L7_145.prev
                    if L7_145 ~= nil then
                      L7_145 = A0_138.logs
                      L8_146 = L6_144.description
                      L8_146 = L8_146.prev
                      L7_145 = L7_145[L8_146]
                      if L7_145 ~= nil then
                        L6_144.canShow = true
                      end
                    end
                  else
                    L7_145 = L6_144.description
                    L7_145 = L7_145.info
                    L7_145 = L7_145[1]
                    L7_145 = L7_145.type
                    if L7_145 == "CHARGE" then
                      L7_145 = L6_144.description
                      L7_145 = L7_145.prev
                      if L7_145 ~= nil then
                        L7_145 = A0_138.logs
                        L8_146 = L6_144.description
                        L8_146 = L8_146.prev
                        L7_145 = L7_145[L8_146]
                        if L7_145 ~= nil then
                          L6_144.canShow = true
                        end
                      end
                    else
                      L7_145 = L6_144.description
                      L7_145 = L7_145.info
                      L7_145 = L7_145[1]
                      L7_145 = L7_145.type
                      if L7_145 == "DEMOG" then
                        L7_145 = L6_144.description
                        L7_145 = L7_145.prev
                        if L7_145 ~= nil then
                          L7_145 = A0_138.logs
                          L8_146 = L6_144.description
                          L8_146 = L8_146.prev
                          L7_145 = L7_145[L8_146]
                          if L7_145 ~= nil then
                            L6_144.canShow = true
                          end
                        end
                      else
                        L7_145 = L6_144.description
                        L7_145 = L7_145.info
                        L7_145 = L7_145[1]
                        L7_145 = L7_145.type
                        if L7_145 == "TARGET" then
                          L7_145 = L6_144.description
                          L7_145 = L7_145.prev
                          if L7_145 ~= nil then
                            L7_145 = A0_138.logs
                            L8_146 = L6_144.description
                            L8_146 = L8_146.prev
                            L7_145 = L7_145[L8_146]
                            if L7_145 ~= nil then
                              L6_144.canShow = true
                            end
                          end
                        else
                          L7_145 = L6_144.description
                          L7_145 = L7_145.info
                          L7_145 = L7_145[1]
                          L7_145 = L7_145.type
                          if L7_145 == "BATTLE_ACTIVITY" then
                            L7_145 = L6_144.description
                            L7_145 = L7_145.prev
                            if L7_145 ~= nil then
                              L7_145 = A0_138.logs
                              L8_146 = L6_144.description
                              L8_146 = L8_146.prev
                              L7_145 = L7_145[L8_146]
                              if L7_145 ~= nil then
                                L6_144.canShow = true
                              end
                            end
                          else
                            L7_145 = L6_144.description
                            L7_145 = L7_145.info
                            L7_145 = L7_145[1]
                            L7_145 = L7_145.type
                            if L7_145 == "BATTLE_POINT" then
                              L7_145 = L6_144.description
                              L7_145 = L7_145.prev
                              if L7_145 then
                                L7_145 = A0_138.logs
                                L8_146 = L6_144.description
                                L8_146 = L8_146.prev
                                L7_145 = L7_145[L8_146]
                                if L7_145 then
                                  L6_144.canShow = true
                                end
                              end
                            end
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
            L7_145 = A0_138.logs
            L8_146 = L6_144.id
            L7_145 = L7_145[L8_146]
            if L7_145 ~= nil then
              L7_145 = L6_144["repeat"]
              if L7_145 then
                L7_145 = Logic
                L8_146 = L7_145
                L7_145 = L7_145.Get
                L7_145 = L7_145(L8_146, "System")
                L8_146 = L7_145
                L7_145 = L7_145.GetTimeStr
                L7_145 = L7_145(L8_146, "%x", A0_138.logs[L6_144.id] / 1000)
                L8_146 = Logic
                L8_146 = L8_146.Get
                L8_146 = L8_146(L8_146, "System")
                L8_146 = L8_146.GetTime
                L8_146 = L8_146(L8_146)
                if L7_145 == Logic:Get("System"):GetTimeStr("%x", L8_146) then
                  L6_144.canShow = false
                end
              end
            end
            L7_145 = A0_138.logs
            L8_146 = L6_144.description
            L8_146 = L8_146.prev
            L7_145 = L7_145[L8_146]
            if L7_145 ~= nil then
              L7_145 = L6_144["repeat"]
              if L7_145 then
                L7_145 = Logic
                L8_146 = L7_145
                L7_145 = L7_145.Get
                L7_145 = L7_145(L8_146, "System")
                L8_146 = L7_145
                L7_145 = L7_145.GetTimeStr
                L7_145 = L7_145(L8_146, "%x", A0_138.logs[L6_144.description.prev] / 1000)
                L8_146 = Logic
                L8_146 = L8_146.Get
                L8_146 = L8_146(L8_146, "System")
                L8_146 = L8_146.GetTime
                L8_146 = L8_146(L8_146)
                if L7_145 ~= Logic:Get("System"):GetTimeStr("%x", L8_146) then
                  L6_144.canShow = false
                end
              end
            end
          end
        end
      end
    end
  end
  L2_140(L3_141)
end
function class.UpdataVipGift(A0_147)
  for _FORV_5_, _FORV_6_ in pairs(A0_147.arrGift) do
    if _FORV_6_.description.info ~= nil and not table.empty(_FORV_6_.description.info) and _FORV_6_.description.info[1] ~= nil and _FORV_6_.description.info[1].type == "VIP" then
      if tonumber(_FORV_6_.description.info[1].code) == 1 and Logic:Get("PlayerInfo"):GetPlayerAllInfo().vip.week then
        _FORV_6_.canDraw = true
        _FORV_6_.canShow = true
        A0_147.hasReward = true
      end
      if tonumber(_FORV_6_.description.info[1].code) == 0 and Logic:Get("PlayerInfo"):GetPlayerAllInfo().vip.vip then
        _FORV_6_.canDraw = true
        _FORV_6_.canShow = true
        A0_147.hasReward = true
      end
    end
  end
  A0_147:SetCanShowGif()
  A0_147:FireEvent(EVT.REFRESH_GIFT)
end
function class.createImg(A0_148, A1_149)
  local L2_150, L3_151, L4_152, L5_153
  L2_150 = "images/public/herobg.png"
  L3_151 = CCSprite
  L4_152 = L3_151
  L3_151 = L3_151.create
  L5_153 = L2_150
  L3_151 = L3_151(L4_152, L5_153)
  if A1_149 ~= nil then
    L4_152 = A1_149.showType
  elseif L4_152 == nil then
    return L3_151
  end
  if L3_151 ~= nil then
    L5_153 = L3_151
    L4_152 = L3_151.setAnchorPoint
    L4_152(L5_153, CCPoint(0, 0))
    L5_153 = L3_151
    L4_152 = L3_151.setAnchorPoint
    L4_152(L5_153, CCPoint(0, 0))
  end
  L4_152 = A1_149.showType
  if L4_152 == "HERO" then
    L4_152 = Logic
    L5_153 = L4_152
    L4_152 = L4_152.Get
    L4_152 = L4_152(L5_153, "Hero")
    L5_153 = L4_152
    L4_152 = L4_152.GetHeroBgImage
    L4_152 = L4_152(L5_153, A1_149.showId)
    if L4_152 ~= nil then
      L5_153 = CCSprite
      L5_153 = L5_153.create
      L5_153 = L5_153(L5_153, L4_152)
      L3_151 = L5_153
    end
  else
    L4_152 = A1_149.showType
    if L4_152 == "FRAGMENT" then
      L4_152 = Logic
      L5_153 = L4_152
      L4_152 = L4_152.Get
      L4_152 = L4_152(L5_153, "Compose")
      L5_153 = L4_152
      L4_152 = L4_152.kdbItemConfig
      L4_152 = L4_152(L5_153, A1_149.showId)
      if L4_152 ~= nil then
        L5_153 = Logic
        L5_153 = L5_153.Get
        L5_153 = L5_153(L5_153, "Compose")
        L5_153 = L5_153.GetItemsFrame
        L5_153 = L5_153(L5_153, tonumber(L4_152.quality))
        L3_151 = L5_153
      else
        L5_153 = CCSprite
        L5_153 = L5_153.create
        L5_153 = L5_153(L5_153, L2_150)
        L3_151 = L5_153
      end
    else
      L4_152 = A1_149.showType
      if L4_152 == "REAL_GOODS" then
        L4_152 = Logic
        L5_153 = L4_152
        L4_152 = L4_152.Get
        L4_152 = L4_152(L5_153, "Hero")
        L5_153 = L4_152
        L4_152 = L4_152.GetHeroBgImage
        L4_152 = L4_152(L5_153, A1_149.showId)
        if L4_152 ~= nil then
          L5_153 = CCSprite
          L5_153 = L5_153.create
          L5_153 = L5_153(L5_153, L4_152)
          L3_151 = L5_153
        end
      else
        L4_152 = A1_149.showType
        if L4_152 == "TALISMAN" then
          L4_152 = KFDBGetRecord
          L5_153 = "TalismanSetting"
          L4_152 = L4_152(L5_153, A1_149.showId)
          if L4_152 ~= nil then
            L5_153 = Logic
            L5_153 = L5_153.Get
            L5_153 = L5_153(L5_153, "Hero")
            L5_153 = L5_153.GetHeroBgImage
            L5_153 = L5_153(L5_153, L4_152.baseId)
            if L5_153 ~= nil then
              L3_151 = CCSprite:create(L5_153)
            end
          end
        else
          L4_152 = A1_149.showType
          if L4_152 ~= "EQUIPMENT" then
            L4_152 = A1_149.showType
          else
            if L4_152 == "EQUIPMENT_FRAGMENT" then
              L4_152 = Logic
              L5_153 = L4_152
              L4_152 = L4_152.Get
              L4_152 = L4_152(L5_153, "Armor")
              L5_153 = L4_152
              L4_152 = L4_152.getArmorImgBg
              L4_152 = L4_152(L5_153, A1_149.showId)
              if L4_152 ~= nil then
                L5_153 = CCSprite
                L5_153 = L5_153.create
                L5_153 = L5_153(L5_153, L4_152)
                L3_151 = L5_153
              end
          end
          else
            L4_152 = A1_149.showType
            if L4_152 == "EQUIPMENT_MATERIAL" then
              L4_152 = A1_149.showId
              if L4_152 == 0 then
                L4_152 = 4
              else
                L4_152 = L4_152 or 6
              end
              L5_153 = string
              L5_153 = L5_153.format
              L5_153 = L5_153("data/MiddleBg/%d.png", L4_152)
              L3_151 = CCSprite:create(L5_153)
            else
              L4_152 = A1_149.showType
              if L4_152 == "CULTIVATE_ELIXIR" then
                L4_152 = Logic
                L5_153 = L4_152
                L4_152 = L4_152.Get
                L4_152 = L4_152(L5_153, "Cultivate")
                L5_153 = L4_152
                L4_152 = L4_152.getElixirImgBg
                L4_152 = L4_152(L5_153, A1_149.showId)
                if L4_152 ~= nil then
                  L5_153 = CCSprite
                  L5_153 = L5_153.create
                  L5_153 = L5_153(L5_153, L4_152)
                  L3_151 = L5_153
                end
              else
                L4_152 = A1_149.showType
                if L4_152 == "CULTIVATE_MATERIAL" then
                  L4_152 = Logic
                  L5_153 = L4_152
                  L4_152 = L4_152.Get
                  L4_152 = L4_152(L5_153, "Cultivate")
                  L5_153 = L4_152
                  L4_152 = L4_152.getStuffImgBg
                  L4_152 = L4_152(L5_153, A1_149.showId)
                  if L4_152 ~= nil then
                    L5_153 = CCSprite
                    L5_153 = L5_153.create
                    L5_153 = L5_153(L5_153, L4_152)
                    L3_151 = L5_153
                  end
                end
              end
            end
          end
        end
      end
    end
  end
  L4_152 = SHOW_TYPES
  L5_153 = A1_149.showType
  L4_152 = L4_152[L5_153]
  if L4_152 ~= nil then
    L4_152 = Logic
    L5_153 = L4_152
    L4_152 = L4_152.Get
    L4_152 = L4_152(L5_153, "Compose")
    L5_153 = L4_152
    L4_152 = L4_152.GetItemsFrame
    L4_152 = L4_152(L5_153, tonumber(A1_149.showId))
    L3_151 = L4_152
  end
  return L3_151
end
function class.createGoodsImg(A0_154, A1_155)
  local L2_156, L3_157, L4_158, L5_159, L6_160, L7_161, L8_162, L9_163
  L2_156 = "images/Other/gift.png"
  L3_157 = CCSprite
  L4_158 = L3_157
  L3_157 = L3_157.create
  L5_159 = L2_156
  L3_157 = L3_157(L4_158, L5_159)
  if A1_155 ~= nil then
    L4_158 = A1_155.showType
  elseif L4_158 == nil then
    return L3_157
  end
  L4_158 = nil
  L5_159 = "images/Other/gift.png"
  L6_160 = ""
  L7_161 = ""
  L8_162 = ""
  L9_163 = A1_155.showType
  if L9_163 == "HERO" then
    L9_163 = Logic
    L9_163 = L9_163.Get
    L9_163 = L9_163(L9_163, "Hero")
    L9_163 = L9_163.GetHeroImage
    L9_163 = L9_163(L9_163, A1_155.showId)
    L5_159 = L9_163
    if L5_159 == "" then
      L5_159 = "images/public/hero.png"
    end
    L4_158 = A1_155.showId
  else
    L9_163 = A1_155.showType
    if L9_163 == "FRAGMENT" then
      L9_163 = Logic
      L9_163 = L9_163.Get
      L9_163 = L9_163(L9_163, "Compose")
      L9_163 = L9_163.kdbItemConfig
      L9_163 = L9_163(L9_163, A1_155.showId)
      if L9_163 == nil or L9_163.baseId == 0 then
        L5_159 = "images/HeroCardInfo/composeItem.png"
      else
        L5_159 = Logic:Get("Hero"):GetHeroImage(L9_163.baseId)
      end
      L6_160 = "images/HeroCardInfo/composeItem.png"
    else
      L9_163 = A1_155.showType
      if L9_163 == "REAL_GOODS" then
        L9_163 = Logic
        L9_163 = L9_163.Get
        L9_163 = L9_163(L9_163, "Hero")
        L9_163 = L9_163.GetHeroImage
        L9_163 = L9_163(L9_163, A1_155.showId)
        L5_159 = L9_163
        if L5_159 == "" then
          L5_159 = "images/public/hero.png"
        end
        L4_158 = A1_155.showId
      else
        L9_163 = A1_155.showType
        if L9_163 == "TALISMAN" then
          L9_163 = KFDBGetRecord
          L9_163 = L9_163("TalismanSetting", A1_155.showId)
          if L9_163 ~= nil then
            L5_159 = Logic:Get("Hero"):GetHeroImage(L9_163.baseId)
            if L5_159 == "" then
              L5_159 = "images/public/hero.png"
            end
          else
            L5_159 = "images/public/hero.png"
          end
          L4_158 = A1_155.showId
        else
          L9_163 = A1_155.showType
          if L9_163 == "SECRETSHOP_CURRENCY" then
            L9_163 = Logic
            L9_163 = L9_163.Get
            L9_163 = L9_163(L9_163, "MysticShop")
            L9_163 = L9_163.GetCurrencyPath
            L9_163 = L9_163(L9_163)
            L5_159 = L9_163
            if L5_159 == "" then
              L5_159 = "images/public/hero.png"
            end
          else
            L9_163 = A1_155.showType
            if L9_163 == "EQUIPMENT" then
              L9_163 = Logic
              L9_163 = L9_163.Get
              L9_163 = L9_163(L9_163, "Armor")
              L9_163 = L9_163.getArmorImg
              L9_163 = L9_163(L9_163, A1_155.showId)
              L5_159 = L9_163
              if L5_159 == "" then
                L5_159 = "images/public/hero.png"
              end
              L9_163 = Logic
              L9_163 = L9_163.Get
              L9_163 = L9_163(L9_163, "Armor")
              L9_163 = L9_163.getArmorInfoByBaseId
              L9_163 = L9_163(L9_163, A1_155.showId)
              if L9_163 and L9_163.star and 0 < L9_163.star then
                L8_162 = string.format("images/Equip/%d.png", L9_163.star)
              end
              L4_158 = A1_155.showId
            else
              L9_163 = A1_155.showType
              if L9_163 == "EQUIPMENT_FRAGMENT" then
                L9_163 = Logic
                L9_163 = L9_163.Get
                L9_163 = L9_163(L9_163, "Armor")
                L9_163 = L9_163.getArmorImg
                L9_163 = L9_163(L9_163, A1_155.showId)
                L5_159 = L9_163
                if L5_159 == "" then
                  L5_159 = "images/public/hero.png"
                end
                L9_163 = Logic
                L9_163 = L9_163.Get
                L9_163 = L9_163(L9_163, "Armor")
                L9_163 = L9_163.getArmorInfoByBaseId
                L9_163 = L9_163(L9_163, A1_155.showId)
                if L9_163 and L9_163.star and 0 < L9_163.star then
                  L8_162 = string.format("images/Equip/%d.png", L9_163.star)
                end
                L6_160 = "images/HeroCardInfo/composeItem.png"
                L4_158 = A1_155.showId
              else
                L9_163 = A1_155.showType
                if L9_163 == "CULTIVATE_ELIXIR" then
                  L9_163 = Logic
                  L9_163 = L9_163.Get
                  L9_163 = L9_163(L9_163, "Cultivate")
                  L9_163 = L9_163.getElixirImg
                  L9_163 = L9_163(L9_163, A1_155.showId)
                  L5_159 = L9_163
                  if L5_159 == "" then
                    L5_159 = "images/public/hero.png"
                  end
                else
                  L9_163 = A1_155.showType
                  if L9_163 == "CULTIVATE_MATERIAL" then
                    L9_163 = Logic
                    L9_163 = L9_163.Get
                    L9_163 = L9_163(L9_163, "Cultivate")
                    L9_163 = L9_163.getStuffImg
                    L9_163 = L9_163(L9_163, A1_155.showId)
                    L5_159 = L9_163
                    if L5_159 == "" then
                      L5_159 = "images/public/hero.png"
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
  L9_163 = SHOW_TYPES
  L9_163 = L9_163[A1_155.showType]
  if L9_163 ~= nil then
    L9_163 = SHOW_TYPES
    L5_159 = L9_163[A1_155.showType]
  end
  if L5_159 ~= nil then
    L9_163 = CCSprite
    L9_163 = L9_163.create
    L9_163 = L9_163(L9_163, L5_159)
    L3_157 = L9_163
  end
  if L8_162 ~= "" and L3_157 ~= nil then
    L9_163 = CCSprite
    L9_163 = L9_163.create
    L9_163 = L9_163(L9_163, L8_162)
    L9_163:setPosition(CCPoint(56, 80))
    L9_163:setAnchorPoint(ccp(0, 0.5))
    L9_163:setScale(0.6)
    L3_157:addChild(L9_163)
  end
  if L6_160 ~= "" and L3_157 ~= nil then
    L9_163 = CCSprite
    L9_163 = L9_163.create
    L9_163 = L9_163(L9_163, L6_160)
    L3_157:addChild(L9_163)
    L9_163:setAnchorPoint(ccp(0, 0))
  end
  L9_163 = L3_157
  return L9_163, L4_158, A1_155.showType == "FRAGMENT" or A1_155.showType == "EQUIPMENT_FRAGMENT"
end
function class.CreateMoneyImg(A0_164, A1_165)
  local L2_166
  L2_166 = "images/Other/goldBig.png"
  return L2_166
end
function class.createProgress(A0_167, A1_168)
  local L2_169
  L2_169 = ""
  if A1_168.canDraw then
    L2_169 = "images/HeroCardInfo/gift_fin.png"
  else
    L2_169 = "images/HeroCardInfo/gift_ing.png"
  end
  CCSprite:create(L2_169):setAnchorPoint(CCPoint(0, 0))
  return (CCSprite:create(L2_169))
end
function class.scaleImg(A0_170)
  local L1_171, L2_172, L3_173
  L1_171 = CCScaleTo
  L2_172 = L1_171
  L1_171 = L1_171.create
  L3_173 = 0.5
  L1_171 = L1_171(L2_172, L3_173, 1.1)
  L2_172 = CCScaleTo
  L3_173 = L2_172
  L2_172 = L2_172.create
  L2_172 = L2_172(L3_173, 0.5, 0.9)
  L3_173 = CCArray
  L3_173 = L3_173.create
  L3_173 = L3_173(L3_173)
  L3_173:addObject(L1_171)
  L3_173:addObject(L2_172)
  return (CCSequence:create(L3_173))
end
function class.fadetoSpr(A0_174)
  local L1_175, L2_176, L3_177, L4_178
  L1_175 = CCFadeTo
  L2_176 = L1_175
  L1_175 = L1_175.create
  L3_177 = 0
  L4_178 = 255
  L1_175 = L1_175(L2_176, L3_177, L4_178)
  L2_176 = CCFadeTo
  L3_177 = L2_176
  L2_176 = L2_176.create
  L4_178 = 1
  L2_176 = L2_176(L3_177, L4_178, 0)
  L3_177 = CCFadeTo
  L4_178 = L3_177
  L3_177 = L3_177.create
  L3_177 = L3_177(L4_178, 1, 255)
  L4_178 = CCArray
  L4_178 = L4_178.create
  L4_178 = L4_178(L4_178)
  L4_178:addObject(L1_175)
  L4_178:addObject(L2_176)
  L4_178:addObject(L3_177)
  return (CCSequence:create(L4_178))
end
function class.IsDrawable(A0_179, A1_180, A2_181)
  local L3_182, L4_183, L5_184, L6_185, L7_186
  for L6_185, L7_186 in L3_182(L4_183) do
    if A0_179:Test(L7_186, A1_180, A2_181) then
      return true
    end
  end
  return L3_182
end
function class.Test(A0_187, A1_188, A2_189, A3_190)
  local L4_191
  L4_191 = A1_188.description
  return L4_191.showType == A2_189 and tonumber(L4_191.showId) == A3_190
end
function class.setDrawing(A0_192, A1_193)
  A0_192.drawing = A1_193 or nil
end
function class.isDrawing(A0_194)
  local L1_195
  L1_195 = A0_194.drawing
  return L1_195
end
function class.PostSerialNumber(A0_196, A1_197)
  if A1_197 then
    A0_196.serialNumber = A1_197
    MsgGift:Post("DRAW_SERIAL", {serial = A1_197})
  end
end
function class.onDrawSerial(A0_198, A1_199, A2_200)
  local L3_201, L4_202, L5_203, L6_204
  L4_202 = A0_198
  L3_201 = A0_198.EventTracer
  L3_201 = L3_201(L4_202)
  L4_202 = L3_201
  L3_201 = L3_201.Cancel
  L5_203 = "POST_HTTP_GIFT"
  L3_201(L4_202, L5_203)
  if A1_199 == 0 and A2_200 ~= nil then
    L3_201 = A2_200.check
    if L3_201 then
      L3_201 = A2_200.url
      if L3_201 then
        L3_201 = string
        L3_201 = L3_201.match
        L4_202 = A2_200.url
        L5_203 = "http://(.+):%d+/"
        L3_201 = L3_201(L4_202, L5_203)
        if L3_201 == nil then
          L4_202 = string
          L4_202 = L4_202.match
          L5_203 = A2_200.url
          L6_204 = "http://(.+)/"
          L4_202 = L4_202(L5_203, L6_204)
          L3_201 = L4_202
        end
        L4_202 = string
        L4_202 = L4_202.match
        L5_203 = A2_200.url
        L6_204 = ":(%d+)"
        L4_202 = L4_202(L5_203, L6_204)
        L4_202 = L4_202 or 80
        L5_203 = string
        L5_203 = L5_203.match
        L6_204 = A2_200.url
        L5_203 = L5_203(L6_204, ":%d+(/.+)")
        if L5_203 == nil then
          L6_204 = string
          L6_204 = L6_204.match
          L6_204 = L6_204(A2_200.url, ".+(/.+)")
          L5_203 = L6_204
        end
        L6_204 = ITwHttp
        L6_204 = L6_204.Request
        L6_204 = L6_204()
        L6_204.strHost = L3_201
        L6_204.strMethod = "POST"
        L6_204.strAction = L5_203
        L6_204.usPort = L4_202
        Singleton(NetHttp):On(L6_204.uReqId, A0_198:Event("POST_HTTP_GIFT", "OnGetHttpGiftSerial"))
        Singleton(NetHttp):Send(L6_204, false)
        return
      end
    end
    L3_201 = Logic
    L4_202 = L3_201
    L3_201 = L3_201.Get
    L5_203 = "Reward"
    L3_201 = L3_201(L4_202, L5_203)
    L4_202 = L3_201
    L3_201 = L3_201.AddRewards
    L5_203 = A2_200.reward
    L3_201(L4_202, L5_203)
    L3_201 = Logic
    L4_202 = L3_201
    L3_201 = L3_201.Get
    L5_203 = "Reward"
    L3_201 = L3_201(L4_202, L5_203)
    L4_202 = L3_201
    L3_201 = L3_201.AddRewardsTip
    L5_203 = A2_200.reward
    L3_201 = L3_201(L4_202, L5_203)
    L4_202 = Prompt
    L5_203 = L4_202
    L4_202 = L4_202.Confirm
    L6_204 = nil
    L4_202(L5_203, L6_204, A2_200.giftName, L3_201, A0_198.FireEnvenAffGetGift)
  end
end
function class.OnGetHttpGiftSerial(A0_205, A1_206, A2_207)
  local L3_208, L4_209
  L4_209 = A0_205
  L3_208 = A0_205.EventTracer
  L3_208 = L3_208(L4_209)
  L4_209 = L3_208
  L3_208 = L3_208.Cancel
  L3_208(L4_209, "POST_HTTP_GIFT")
  if A1_206 == 0 then
    L3_208 = json
    L3_208 = L3_208.decode
    L4_209 = A2_207
    L3_208 = L3_208(L4_209)
    L4_209 = L3_208.code
    if L4_209 == 0 then
      L4_209 = MsgGift
      L4_209 = L4_209.Post
      L4_209(L4_209, "DRAW_SERIAL", {
        serial = A0_205.serialNumber,
        signal = L3_208.content
      })
    else
      L4_209 = _UPVALUE0_
      L4_209 = L4_209[_UPVALUE1_[L3_208.code]]
      Prompt:Tip(L4_209)
    end
  end
end
function class.PostGetActivitys(A0_210)
  MsgGift:Post("GET_ACTIVITYS", {})
end
function class.OnGetActivitys(A0_211, A1_212, A2_213)
  if A1_212 == 0 and A2_213 ~= nil then
    A0_211.arrGiftsActivitys = {}
    A0_211.acLogs = {}
    A0_211.acLogs = A2_213.logs
    if A2_213.activitys == nil then
      return
    end
    for _FORV_6_ = 1, #A2_213.activitys do
      if A2_213.activitys[_FORV_6_].gifts ~= nil then
        for _FORV_10_, _FORV_11_ in pairs(A2_213.activitys[_FORV_6_].gifts) do
          if _FORV_11_.description.info ~= nil then
            _FORV_11_.description.info = json.decode(_FORV_11_.description.info)
          end
          if _FORV_11_.reward.content ~= nil then
          end
          A0_211.arrGiftsActivitys[_FORV_11_.id] = A2_213.activitys[_FORV_6_].gifts[_FORV_10_]
        end
      end
    end
    _FOR_(_FOR_)
    A0_211.activitys = A2_213.activitys
    for _FORV_6_ = 1, #A2_213.activitys do
      if A2_213.activitys[_FORV_6_].activityType == "DUMPLING" then
        Logic:Get("Dumpling"):PostGetCoolTime()
      elseif A2_213.activitys[_FORV_6_].activityType == "GOD_REWARD" then
        Logic:Get("GodReward"):PostGetInfo()
      end
    end
    _FOR_:Get("EquipGift"):jumpToPrevUI()
  end
end
function class.PoseDrawActivity(A0_214, A1_215)
  A0_214.acGiftID = A1_215
  MsgGift:Post("DRAW_ACTIVITY", {
    activity = A0_214.activityGift.id,
    giftId = A1_215
  })
end
function class.onDrawActivitys(A0_216, A1_217, A2_218)
  local L3_219
  if A1_217 == 0 then
    L3_219 = Logic
    L3_219 = L3_219.Get
    L3_219 = L3_219(L3_219, "BGSound")
    L3_219 = L3_219.PlayEffect
    L3_219(L3_219, "audio/gift.mp3")
    L3_219 = Logic
    L3_219 = L3_219.Get
    L3_219 = L3_219(L3_219, "Reward")
    L3_219 = L3_219.AddRewards
    L3_219(L3_219, A2_218)
    L3_219 = A0_216.arrGiftsActivitys
    L3_219 = L3_219[A0_216.acGiftID]
    if L3_219 then
      L3_219 = A0_216.arrGiftsActivitys
      L3_219 = L3_219[A0_216.acGiftID]
      L3_219 = L3_219.description
      L3_219 = L3_219.showType
      if L3_219 == "LOTTERY" then
        L3_219 = Logic
        L3_219 = L3_219.Get
        L3_219 = L3_219(L3_219, "Lottery")
        L3_219 = L3_219.ShowDrawResult
        L3_219(L3_219, A2_218)
      else
        L3_219 = Logic
        L3_219 = L3_219.Get
        L3_219 = L3_219(L3_219, "Reward")
        L3_219 = L3_219.AddRewardsTip
        L3_219 = L3_219(L3_219, A2_218)
        Prompt:Confirm(nil, 0, L3_219, A0_216.FireEnvenAffGetGift)
      end
    else
      L3_219 = Logic
      L3_219 = L3_219.Get
      L3_219 = L3_219(L3_219, "Reward")
      L3_219 = L3_219.AddRewardsTip
      L3_219 = L3_219(L3_219, A2_218)
      Prompt:Confirm(nil, 0, L3_219, A0_216.FireEnvenAffGetGift)
    end
    L3_219 = A0_216.UpdataActivity
    L3_219(A0_216, A0_216.acGiftID)
    L3_219 = A0_216.FireEvent
    L3_219(A0_216, EVT.REFRESH_GIFT)
  else
    L3_219 = Logic
    L3_219 = L3_219.Get
    L3_219 = L3_219(L3_219, "MsgAssist")
    L3_219 = L3_219.OnMsgResult
    L3_219(L3_219, "MsgGift", A1_217)
    if A1_217 ~= -11 then
      L3_219 = Logic
      L3_219 = L3_219.Get
      L3_219 = L3_219(L3_219, "Login")
      L3_219 = L3_219.Login
      L3_219(L3_219)
    end
  end
end
function class.SetCanShowActivityGift(A0_220)
  local L1_221, L2_222, L3_223, L4_224, L5_225, L6_226, L7_227, L8_228, L9_229
  L1_221 = {}
  A0_220.canShowGiftActivity = L1_221
  L1_221 = Logic
  L2_222 = L1_221
  L1_221 = L1_221.Get
  L1_221 = L1_221(L2_222, L3_223)
  L2_222 = L1_221
  L1_221 = L1_221.GetTime
  L1_221 = L1_221(L2_222)
  L2_222 = Logic
  L2_222 = L2_222.Get
  L2_222 = L2_222(L3_223, L4_224)
  L2_222 = L2_222.GetLevelChange
  L2_222 = L2_222(L3_223)
  for L6_226, L7_227 in L3_223(L4_224) do
    L8_228 = A0_220.acLogs
    L9_229 = L7_227.id
    L8_228 = L8_228[L9_229]
    if L8_228 ~= nil then
      L8_228 = L7_227["repeat"]
      if L8_228 then
        L8_228 = Logic
        L9_229 = L8_228
        L8_228 = L8_228.Get
        L8_228 = L8_228(L9_229, "System")
        L9_229 = L8_228
        L8_228 = L8_228.GetTimeStr
        L8_228 = L8_228(L9_229, "%x", A0_220.acLogs[L7_227.id] / 1000)
        L9_229 = Logic
        L9_229 = L9_229.Get
        L9_229 = L9_229(L9_229, "System")
        L9_229 = L9_229.GetTime
        L9_229 = L9_229(L9_229)
        if L8_228 == Logic:Get("System"):GetTimeStr("%x", L9_229) then
          L7_227.canShow = false
        end
      end
    end
    L8_228 = true
    L9_229 = L7_227.startTime
    if L9_229 ~= nil then
      L9_229 = L7_227.startTime
      L9_229 = L9_229 / 1000
      L8_228 = L1_221 >= L9_229
    end
    L9_229 = string
    L9_229 = L9_229.find
    L9_229 = L9_229(L7_227.actitityId, "Target")
    if L9_229 then
      L8_228 = true
    end
    if string.find(L7_227.id, "level") and L2_222 == true and L7_227.actitityId == "Lv2" then
      L8_228 = true
    end
    if L7_227.endTime ~= nil then
    end
    if L8_228 and L1_221 <= L7_227.endTime / 1000 and L7_227.canShow then
      A0_220.canShowGiftActivity[L6_226] = L7_227
    end
  end
end
function class.GetCanShowActivityGift(A0_230)
  local L1_231
  L1_231 = A0_230.canShowGiftActivity
  return L1_231
end
function class.HasRewardGiftActivity(A0_232, A1_233, A2_234)
  local L3_235, L4_236, L5_237, L6_238, L7_239, L8_240, L9_241, L10_242, L11_243, L12_244, L13_245, L14_246, L15_247
  L3_235 = Logic
  L4_236 = L3_235
  L3_235 = L3_235.Get
  L5_237 = "System"
  L3_235 = L3_235(L4_236, L5_237)
  L4_236 = L3_235
  L3_235 = L3_235.GetTime
  L3_235 = L3_235(L4_236)
  L4_236 = false
  L5_237 = Logic
  L5_237 = L5_237.Get
  L5_237 = L5_237(L6_238, L7_239)
  L5_237 = L5_237.GetLevelChange
  L5_237 = L5_237(L6_238)
  for L9_241, L10_242 in L6_238(L7_239) do
    L11_243 = true
    L12_244 = L10_242.startTime
    if L12_244 ~= nil then
      L12_244 = L10_242.startTime
      L12_244 = L12_244 / 1000
      L11_243 = L3_235 >= L12_244
    end
    L12_244 = string
    L12_244 = L12_244.find
    L13_245 = L10_242.id
    L14_246 = "level"
    L12_244 = L12_244(L13_245, L14_246)
    if L12_244 and L5_237 == true then
      L13_245 = L10_242.actitityId
      if L13_245 == "Lv2" then
        L11_243 = true
      end
    end
    L13_245 = true
    L14_246 = L10_242.endTime
    if L14_246 ~= nil then
      L14_246 = L10_242.endTime
      L14_246 = L14_246 / 1000
      L13_245 = L3_235 <= L14_246
    end
    if L11_243 and L13_245 then
      L14_246 = L10_242.description
      L14_246 = L14_246.info
      if L14_246 ~= nil then
        L14_246 = table
        L14_246 = L14_246.empty
        L15_247 = L10_242.description
        L15_247 = L15_247.info
        L14_246 = L14_246(L15_247)
        if not L14_246 then
          L14_246 = L10_242.description
          L14_246 = L14_246.info
          L14_246 = L14_246[1]
          if L14_246 ~= nil then
            L14_246 = L10_242.description
            L14_246 = L14_246.info
            L14_246 = L14_246[1]
            L14_246 = L14_246.type
            if L14_246 == "LEVEL" then
              L14_246 = Logic
              L15_247 = L14_246
              L14_246 = L14_246.Get
              L14_246 = L14_246(L15_247, "PlayerInfo")
              L15_247 = L14_246
              L14_246 = L14_246.GetPlayerLevel
              L14_246 = L14_246(L15_247)
              L15_247 = tonumber
              L15_247 = L15_247(L10_242.description.info[1].amount)
              if L14_246 >= L15_247 then
                L10_242.canDraw = true
                A0_232.hasReward = true
              end
            else
              L14_246 = L10_242.description
              L14_246 = L14_246.info
              L14_246 = L14_246[1]
              L14_246 = L14_246.type
              if L14_246 == "BATTLE" then
                if A1_233 ~= nil then
                  L14_246 = L10_242.description
                  L14_246 = L14_246.info
                  L14_246 = L14_246[1]
                  L14_246 = L14_246.code
                  if A1_233 == L14_246 then
                    L10_242.canDraw = true
                    A0_232.hasReward = true
                  end
                end
              else
                L14_246 = L10_242.description
                L14_246 = L14_246.info
                L14_246 = L14_246[1]
                L14_246 = L14_246.type
                if L14_246 == "CHARGE" then
                  L14_246 = L10_242.canDraw
                  if L14_246 then
                    L10_242.canDraw = true
                    A0_232.hasReward = true
                  end
                else
                  L14_246 = L10_242.description
                  L14_246 = L14_246.info
                  L14_246 = L14_246[1]
                  L14_246 = L14_246.type
                  if L14_246 == "GROUP_SCORE" then
                    L14_246 = Logic
                    L15_247 = L14_246
                    L14_246 = L14_246.Get
                    L14_246 = L14_246(L15_247, "Hero")
                    L15_247 = L14_246
                    L14_246 = L14_246.GetFightingPoints
                    L14_246 = L14_246(L15_247)
                    L15_247 = L14_246[2]
                    if L15_247 >= tonumber(L10_242.description.info[1].amount) then
                      L10_242.canDraw = true
                      A0_232.hasReward = true
                    end
                  else
                    L14_246 = L10_242.description
                    L14_246 = L14_246.info
                    L14_246 = L14_246[1]
                    L14_246 = L14_246.type
                    if L14_246 == "GROUP_STAR" then
                      L14_246 = Logic
                      L15_247 = L14_246
                      L14_246 = L14_246.Get
                      L14_246 = L14_246(L15_247, "Hero")
                      L15_247 = L14_246
                      L14_246 = L14_246.GetGroupsSrar
                      L14_246 = L14_246(L15_247)
                      L15_247 = tonumber
                      L15_247 = L15_247(L10_242.description.info[1].amount)
                      if L14_246 >= L15_247 then
                        L10_242.canDraw = true
                        A0_232.hasReward = true
                      end
                    else
                      L14_246 = L10_242.description
                      L14_246 = L14_246.info
                      L14_246 = L14_246[1]
                      L14_246 = L14_246.type
                      if L14_246 == "STAGE_CHARGE" then
                        L14_246 = Logic
                        L15_247 = L14_246
                        L14_246 = L14_246.Get
                        L14_246 = L14_246(L15_247, "PlayerInfo")
                        L15_247 = L14_246
                        L14_246 = L14_246.GetPlayerMoney
                        L14_246 = L14_246(L15_247)
                        L15_247 = L14_246.stageCharges
                        L15_247 = L15_247[L10_242.description.info[1].code]
                        if L15_247 ~= nil and tonumber(L15_247) >= tonumber(L10_242.description.info[1].amount) then
                          L10_242.canDraw = true
                          A0_232.hasReward = true
                        end
                      else
                        L14_246 = L10_242.description
                        L14_246 = L14_246.info
                        L14_246 = L14_246[1]
                        L14_246 = L14_246.type
                        if L14_246 == "TARGET" then
                          L14_246 = 0
                          L15_247 = Logic
                          L15_247 = L15_247.Get
                          L15_247 = L15_247(L15_247, "Target")
                          L15_247 = L15_247.GetProgress
                          L15_247 = L15_247(L15_247)
                          if L15_247[L10_242.description.info[1].code] then
                            if L15_247[L10_242.description.info[1].code] >= tonumber(L10_242.description.info[1].amount) then
                              L10_242.canDraw = true
                              A0_232.hasReward = true
                            else
                              L10_242.canDraw = false
                            end
                          end
                        else
                          L14_246 = L10_242.description
                          L14_246 = L14_246.info
                          L14_246 = L14_246[1]
                          L14_246 = L14_246.type
                          if L14_246 == "DEMOG" then
                            L14_246 = Logic
                            L15_247 = L14_246
                            L14_246 = L14_246.Get
                            L14_246 = L14_246(L15_247, "Devil")
                            L15_247 = L14_246
                            L14_246 = L14_246.getFeat
                            L14_246 = L14_246(L15_247)
                            L15_247 = tonumber
                            L15_247 = L15_247(L10_242.description.info[1].amount)
                            if L14_246 >= L15_247 then
                              L10_242.canDraw = true
                              A0_232.hasReward = true
                            end
                          else
                            L14_246 = L10_242.description
                            L14_246 = L14_246.info
                            L14_246 = L14_246[1]
                            L14_246 = L14_246.type
                            if L14_246 == "BATTLE_POINT" and A1_233 then
                              L14_246 = L10_242.description
                              L14_246 = L14_246.info
                              L14_246 = L14_246[1]
                              L14_246 = L14_246.code
                              if A1_233 == L14_246 then
                                L10_242.canDraw = true
                                A0_232.hasReward = true
                              end
                            end
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
            L14_246 = A0_232.acLogs
            L15_247 = L10_242.id
            L14_246 = L14_246[L15_247]
            if L14_246 ~= nil then
              L14_246 = L10_242["repeat"]
              if L14_246 then
                L14_246 = Logic
                L15_247 = L14_246
                L14_246 = L14_246.Get
                L14_246 = L14_246(L15_247, "System")
                L15_247 = L14_246
                L14_246 = L14_246.GetTimeStr
                L14_246 = L14_246(L15_247, "%x", A0_232.acLogs[L10_242.id] / 1000)
                L15_247 = Logic
                L15_247 = L15_247.Get
                L15_247 = L15_247(L15_247, "System")
                L15_247 = L15_247.GetTime
                L15_247 = L15_247(L15_247)
                if L14_246 == Logic:Get("System"):GetTimeStr("%x", L15_247) then
                  L10_242.canDraw = false
                  A0_232.hasReward = false
                end
              end
            end
          end
        end
      end
    end
  end
  L6_238(L7_239)
  if A2_234 == nil then
    L6_238(L7_239, L8_240)
  end
end
function class.UpdataActivity(A0_248, A1_249)
  local L2_250, L3_251, L4_252, L5_253, L6_254, L7_255, L8_256, L9_257, L10_258, L11_259
  if L2_250 == nil then
    return
  end
  if L2_250 ~= nil then
    if L2_250 == true then
      L2_250[A1_249] = nil
      L2_250[A1_249] = L3_251
    end
  else
    L2_250[A1_249] = nil
    L2_250[A1_249] = L3_251
  end
  for L5_253 = 1, #L3_251 do
    if L6_254 ~= nil then
      for L9_257, L10_258 in L6_254(L7_255) do
        L11_259 = L10_258.id
        if L11_259 == A1_249 then
          L11_259 = table
          L11_259 = L11_259.remove
          L11_259(A0_248.activitys[L5_253].gifts, L9_257)
        end
      end
    end
  end
  for L6_254, L7_255 in L3_251(L4_252) do
    L9_257 = L7_255.startTime
    if L9_257 ~= nil then
      L9_257 = L7_255.startTime
      L9_257 = L9_257 / 1000
      L8_256 = L2_250 >= L9_257
    end
    L9_257 = true
    L10_258 = L7_255.endTime
    if L10_258 ~= nil then
      L10_258 = L7_255.endTime
      L10_258 = L10_258 / 1000
      L9_257 = L2_250 <= L10_258
    end
    L10_258 = L7_255.description
    L10_258 = L10_258.info
    if L10_258 ~= nil then
      L10_258 = table
      L10_258 = L10_258.empty
      L11_259 = L7_255.description
      L11_259 = L11_259.info
      L10_258 = L10_258(L11_259)
      if not L10_258 then
        L10_258 = L7_255.description
        L10_258 = L10_258.info
        L10_258 = L10_258[1]
        if L10_258 ~= nil then
          L10_258 = L7_255.description
          L10_258 = L10_258.info
          L10_258 = L10_258[1]
          if L10_258 ~= nil then
            if L8_256 and L9_257 then
              L10_258 = L7_255.description
              L10_258 = L10_258.info
              L10_258 = L10_258[1]
              L10_258 = L10_258.type
              if L10_258 ~= "TARGET" then
                L7_255.canShow = true
              end
            end
            L10_258 = L7_255.description
            L10_258 = L10_258.info
            L10_258 = L10_258[1]
            L10_258 = L10_258.type
            if L10_258 == "TOTAL_DAYS" then
              L10_258 = L7_255.description
              L10_258 = L10_258.prev
              if L10_258 ~= nil then
                L10_258 = A0_248.acLogs
                L11_259 = L7_255.description
                L11_259 = L11_259.prev
                L10_258 = L10_258[L11_259]
                if L10_258 ~= nil then
                  L7_255.canShow = true
                end
              end
            else
              L10_258 = L7_255.description
              L10_258 = L10_258.info
              L10_258 = L10_258[1]
              L10_258 = L10_258.type
              if L10_258 == "LEVEL" then
                L10_258 = L7_255.description
                L10_258 = L10_258.prev
                if L10_258 ~= nil then
                  L10_258 = A0_248.acLogs
                  L11_259 = L7_255.description
                  L11_259 = L11_259.prev
                  L10_258 = L10_258[L11_259]
                  if L10_258 ~= nil then
                    L7_255.canShow = true
                  end
                end
              else
                L10_258 = L7_255.description
                L10_258 = L10_258.info
                L10_258 = L10_258[1]
                L10_258 = L10_258.type
                if L10_258 == "BATTLE" then
                  L10_258 = L7_255.description
                  L10_258 = L10_258.prev
                  if L10_258 ~= nil then
                    L10_258 = A0_248.acLogs
                    L11_259 = L7_255.description
                    L11_259 = L11_259.prev
                    L10_258 = L10_258[L11_259]
                    if L10_258 ~= nil then
                      L7_255.canShow = true
                    end
                  end
                else
                  L10_258 = L7_255.description
                  L10_258 = L10_258.info
                  L10_258 = L10_258[1]
                  L10_258 = L10_258.type
                  if L10_258 == "ARENA_INTEGRAL" then
                    L10_258 = L7_255.description
                    L10_258 = L10_258.prev
                    if L10_258 ~= nil then
                      L10_258 = A0_248.acLogs
                      L11_259 = L7_255.description
                      L11_259 = L11_259.prev
                      L10_258 = L10_258[L11_259]
                      if L10_258 ~= nil then
                        L7_255.canShow = true
                      end
                    end
                  else
                    L10_258 = L7_255.description
                    L10_258 = L10_258.info
                    L10_258 = L10_258[1]
                    L10_258 = L10_258.type
                    if L10_258 == "CHARGE" then
                      L10_258 = L7_255.description
                      L10_258 = L10_258.prev
                      if L10_258 ~= nil then
                        L10_258 = A0_248.acLogs
                        L11_259 = L7_255.description
                        L11_259 = L11_259.prev
                        L10_258 = L10_258[L11_259]
                        if L10_258 ~= nil then
                          L7_255.canShow = true
                        end
                      end
                    else
                      L10_258 = L7_255.description
                      L10_258 = L10_258.info
                      L10_258 = L10_258[1]
                      L10_258 = L10_258.type
                      if L10_258 == "TARGET" then
                        L10_258 = L7_255.description
                        L10_258 = L10_258.prev
                        if L10_258 ~= nil then
                          L10_258 = A0_248.acLogs
                          L11_259 = L7_255.description
                          L11_259 = L11_259.prev
                          L10_258 = L10_258[L11_259]
                          if L10_258 ~= nil then
                            L10_258 = L7_255["repeat"]
                            if L10_258 then
                              L10_258 = Logic
                              L11_259 = L10_258
                              L10_258 = L10_258.Get
                              L10_258 = L10_258(L11_259, "System")
                              L11_259 = L10_258
                              L10_258 = L10_258.GetTimeStr
                              L10_258 = L10_258(L11_259, "%x", A0_248.acLogs[L7_255.description.prev] / 1000)
                              L11_259 = Logic
                              L11_259 = L11_259.Get
                              L11_259 = L11_259(L11_259, "System")
                              L11_259 = L11_259.GetTime
                              L11_259 = L11_259(L11_259)
                              if L10_258 == Logic:Get("System"):GetTimeStr("%x", L11_259) then
                                L7_255.canShow = true
                              end
                            end
                          else
                            L10_258 = L7_255.description
                            L10_258 = L10_258.prev
                            if L10_258 ~= nil then
                              L10_258 = A0_248.acLogs
                              L11_259 = L7_255.description
                              L11_259 = L11_259.prev
                              L10_258 = L10_258[L11_259]
                              if L10_258 ~= nil then
                                L7_255.canShow = true
                              end
                            end
                          end
                        end
                      else
                        L10_258 = L7_255.description
                        L10_258 = L10_258.info
                        L10_258 = L10_258[1]
                        L10_258 = L10_258.type
                        if L10_258 == "DEMOG" then
                          L10_258 = L7_255.description
                          L10_258 = L10_258.prev
                          if L10_258 ~= nil then
                            L10_258 = A0_248.acLogs
                            L11_259 = L7_255.description
                            L11_259 = L11_259.prev
                            L10_258 = L10_258[L11_259]
                            if L10_258 ~= nil then
                              L7_255.canShow = true
                            end
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
            L10_258 = A0_248.acLogs
            L11_259 = L7_255.id
            L10_258 = L10_258[L11_259]
            if L10_258 ~= nil then
              L10_258 = L7_255["repeat"]
              if L10_258 then
                L10_258 = Logic
                L11_259 = L10_258
                L10_258 = L10_258.Get
                L10_258 = L10_258(L11_259, "System")
                L11_259 = L10_258
                L10_258 = L10_258.GetTimeStr
                L10_258 = L10_258(L11_259, "%x", A0_248.acLogs[L7_255.id] / 1000)
                L11_259 = Logic
                L11_259 = L11_259.Get
                L11_259 = L11_259(L11_259, "System")
                L11_259 = L11_259.GetTime
                L11_259 = L11_259(L11_259)
                if L10_258 == Logic:Get("System"):GetTimeStr("%x", L11_259) then
                  L7_255.canShow = false
                end
              end
            end
          end
        end
      end
    end
  end
  L3_251(L4_252)
end
function class.GetActivityList(A0_260)
  local L1_261
  L1_261 = A0_260.activitys
  return L1_261
end
function class.IsOpenActivity(A0_262, A1_263)
  local L2_264, L3_265, L4_266, L5_267
  L2_264 = false
  L3_265 = false
  L4_266 = Logic
  L5_267 = L4_266
  L4_266 = L4_266.Get
  L4_266 = L4_266(L5_267, "System")
  L5_267 = L4_266
  L4_266 = L4_266.GetTime
  L4_266 = L4_266(L5_267)
  L5_267 = Logic
  L5_267 = L5_267.Get
  L5_267 = L5_267(L5_267, "PlayerInfo")
  L5_267 = L5_267.GetPlayerLevel
  L5_267 = L5_267(L5_267)
  for _FORV_9_ = 1, #A0_262.activitys do
    if A0_262.activitys[_FORV_9_].activityType ~= nil and A0_262.activitys[_FORV_9_].activityType == A1_263 then
      if A0_262.activitys[_FORV_9_].level then
        if L4_266 >= A0_262.activitys[_FORV_9_].startTime / 1000 and L4_266 <= A0_262.activitys[_FORV_9_].endTime / 1000 and tonumber(L5_267) >= tonumber(A0_262.activitys[_FORV_9_].level) then
          L2_264 = true
        else
          L2_264 = false
        end
      end
      if A0_262.activitys[_FORV_9_].lockKey then
        L3_265 = not Logic:Get("Lock"):checkStatusById(A0_262.activitys[_FORV_9_].lockKey)
      else
        L3_265 = true
      end
      if A0_262.activitys[_FORV_9_].activityType == "SMASH_EGG" and A0_262.activitys[_FORV_9_].showTemplete == "egg" then
        L3_265 = false
      end
    end
  end
  return L2_264 and L3_265
end
function class.GetCanShowAcivityList(A0_268)
  local L1_269, L2_270, L3_271, L4_272, L5_273, L6_274, L7_275, L8_276, L9_277, L10_278, L11_279, L12_280, L13_281, L14_282, L15_283, L16_284
  L1_269 = false
  L2_270 = Logic
  L3_271 = L2_270
  L2_270 = L2_270.Get
  L4_272 = "PlayerInfo"
  L2_270 = L2_270(L3_271, L4_272)
  L3_271 = L2_270
  L2_270 = L2_270.GetPlayerMoney
  L2_270 = L2_270(L3_271)
  L3_271 = KFDBGetRecord
  L4_272 = "ConfigValue"
  L5_273 = "TARGET:OPEN_CHARGE_AMOUNT"
  L3_271 = L3_271(L4_272, L5_273)
  L4_272 = L2_270.totalCharge
  L5_273 = tonumber
  L6_274 = L3_271.content
  L5_273 = L5_273(L6_274)
  if L4_272 >= L5_273 then
    L1_269 = true
  end
  L4_272 = Logic
  L5_273 = L4_272
  L4_272 = L4_272.Get
  L6_274 = "PlayerInfo"
  L4_272 = L4_272(L5_273, L6_274)
  L5_273 = L4_272
  L4_272 = L4_272.GetPlayerLevel
  L4_272 = L4_272(L5_273)
  L5_273 = {}
  L6_274 = Logic
  L7_275 = L6_274
  L6_274 = L6_274.Get
  L6_274 = L6_274(L7_275, L8_276)
  L7_275 = L6_274
  L6_274 = L6_274.GetTime
  L6_274 = L6_274(L7_275)
  L7_275 = Logic
  L7_275 = L7_275.Get
  L7_275 = L7_275(L8_276, L9_277)
  L7_275 = L7_275.GetLevelChange
  L7_275 = L7_275(L8_276)
  for L11_279 = 1, #L9_277 do
    L12_280 = string
    L12_280 = L12_280.find
    L13_281 = A0_268.activitys
    L13_281 = L13_281[L11_279]
    L13_281 = L13_281.id
    L14_282 = "Target"
    L12_280 = L12_280(L13_281, L14_282)
    L13_281 = string
    L13_281 = L13_281.find
    L14_282 = A0_268.activitys
    L14_282 = L14_282[L11_279]
    L14_282 = L14_282.id
    L15_283 = "Lv2"
    L13_281 = L13_281(L14_282, L15_283)
    L14_282 = string
    L14_282 = L14_282.find
    L15_283 = A0_268.activitys
    L15_283 = L15_283[L11_279]
    L15_283 = L15_283.id
    L16_284 = "Lv"
    L14_282 = L14_282(L15_283, L16_284)
    L15_283 = string
    L15_283 = L15_283.find
    L16_284 = A0_268.activitys
    L16_284 = L16_284[L11_279]
    L16_284 = L16_284.id
    L15_283 = L15_283(L16_284, "Score")
    L16_284 = A0_268.activitys
    L16_284 = L16_284[L11_279]
    L16_284 = L16_284.icon
    if L16_284 then
      L16_284 = A0_268.activitys
      L16_284 = L16_284[L11_279]
      L16_284 = L16_284.show
      if L16_284 == true then
        L16_284 = A0_268.activitys
        L16_284 = L16_284[L11_279]
        L16_284 = L16_284.lockKey
        if L16_284 then
          L16_284 = Logic
          L16_284 = L16_284.Get
          L16_284 = L16_284(L16_284, "Lock")
          L16_284 = L16_284.checkStatusById
          L16_284 = L16_284(L16_284, A0_268.activitys[L11_279].lockKey)
        elseif not L16_284 then
          if L12_280 ~= nil then
            L16_284 = A0_268.activitys
            L16_284 = L16_284[L11_279]
            L16_284 = L16_284.level
            if L16_284 and L1_269 then
              L16_284 = A0_268.activitys
              L16_284 = L16_284[L11_279]
              L16_284 = L16_284.startTime
              L16_284 = L16_284 / 1000
              if L6_274 >= L16_284 then
                L16_284 = A0_268.activitys
                L16_284 = L16_284[L11_279]
                L16_284 = L16_284.endTime
                L16_284 = L16_284 / 1000
                if L6_274 <= L16_284 then
                  L16_284 = tonumber
                  L16_284 = L16_284(L4_272)
                  if L16_284 >= tonumber(A0_268.activitys[L11_279].level) then
                    L16_284 = table
                    L16_284 = L16_284.insert
                    L16_284(L5_273, A0_268.activitys[L11_279])
                  end
                end
              end
            end
          elseif L13_281 ~= nil and L7_275 == true then
            L16_284 = A0_268.activitys
            L16_284 = L16_284[L11_279]
            L16_284 = L16_284.level
            if L16_284 then
              L16_284 = A0_268.activitys
              L16_284 = L16_284[L11_279]
              L16_284 = L16_284.endTime
              L16_284 = L16_284 / 1000
              if L6_274 <= L16_284 then
                L16_284 = tonumber
                L16_284 = L16_284(L4_272)
                if L16_284 >= tonumber(A0_268.activitys[L11_279].level) then
                  L16_284 = table
                  L16_284 = L16_284.empty
                  L16_284 = L16_284(A0_268.activitys[L11_279].gifts)
                  if not L16_284 then
                    L16_284 = table
                    L16_284 = L16_284.insert
                    L16_284(L5_273, A0_268.activitys[L11_279])
                  end
                end
              end
            end
          elseif L15_283 ~= nil then
            L16_284 = A0_268.activitys
            L16_284 = L16_284[L11_279]
            L16_284 = L16_284.level
            if L16_284 then
              L16_284 = A0_268.activitys
              L16_284 = L16_284[L11_279]
              L16_284 = L16_284.startTime
              L16_284 = L16_284 / 1000
              if L6_274 >= L16_284 then
                L16_284 = A0_268.activitys
                L16_284 = L16_284[L11_279]
                L16_284 = L16_284.endTime
                L16_284 = L16_284 / 1000
                if L6_274 <= L16_284 then
                  L16_284 = tonumber
                  L16_284 = L16_284(L4_272)
                  if L16_284 >= tonumber(A0_268.activitys[L11_279].level) then
                    L16_284 = table
                    L16_284 = L16_284.empty
                    L16_284 = L16_284(A0_268.activitys[L11_279].gifts)
                    if not L16_284 then
                      L16_284 = table
                      L16_284 = L16_284.insert
                      L16_284(L5_273, A0_268.activitys[L11_279])
                    end
                  end
                end
              end
            end
          else
            L16_284 = A0_268.activitys
            L16_284 = L16_284[L11_279]
            L16_284 = L16_284.activityType
            if L16_284 ~= "SMASH_EGG" then
              L16_284 = A0_268.activitys
              L16_284 = L16_284[L11_279]
              L16_284 = L16_284.activityType
            else
              if L16_284 == "SLOT" then
                L16_284 = A0_268.activitys
                L16_284 = L16_284[L11_279]
                L16_284 = L16_284.level
                if L16_284 then
                  L16_284 = A0_268.activitys
                  L16_284 = L16_284[L11_279]
                  L16_284 = L16_284.startTime
                  L16_284 = L16_284 / 1000
                  if L6_274 >= L16_284 then
                    L16_284 = A0_268.activitys
                    L16_284 = L16_284[L11_279]
                    L16_284 = L16_284.endTime
                    L16_284 = L16_284 / 1000
                    if L6_274 <= L16_284 then
                      L16_284 = table
                      L16_284 = L16_284.insert
                      L16_284(L5_273, A0_268.activitys[L11_279])
                    end
                  end
                end
            end
            else
              L16_284 = A0_268.activitys
              L16_284 = L16_284[L11_279]
              L16_284 = L16_284.activityType
              if L16_284 == "GROUP_BUY" then
                L16_284 = A0_268.activitys
                L16_284 = L16_284[L11_279]
                L16_284 = L16_284.level
                if L16_284 then
                  L16_284 = A0_268.activitys
                  L16_284 = L16_284[L11_279]
                  L16_284 = L16_284.startTime
                  L16_284 = L16_284 / 1000
                  if L6_274 >= L16_284 then
                    L16_284 = A0_268.activitys
                    L16_284 = L16_284[L11_279]
                    L16_284 = L16_284.endTime
                    L16_284 = L16_284 / 1000
                    if L6_274 <= L16_284 then
                      L16_284 = tonumber
                      L16_284 = L16_284(L4_272)
                      if L16_284 >= tonumber(A0_268.activitys[L11_279].level) then
                        L16_284 = Logic
                        L16_284 = L16_284.Get
                        L16_284 = L16_284(L16_284, "Groupbuy")
                        L16_284 = L16_284.GetItemData
                        L16_284 = L16_284(L16_284)
                        if not table.empty(L16_284) then
                          table.insert(L5_273, A0_268.activitys[L11_279])
                        end
                      end
                    end
                  end
                end
              else
                L16_284 = A0_268.activitys
                L16_284 = L16_284[L11_279]
                L16_284 = L16_284.activityType
                if L16_284 == "OPEN_BETA_GOODS" then
                else
                  L16_284 = A0_268.activitys
                  L16_284 = L16_284[L11_279]
                  L16_284 = L16_284.level
                  if L16_284 then
                    L16_284 = A0_268.activitys
                    L16_284 = L16_284[L11_279]
                    L16_284 = L16_284.startTime
                    L16_284 = L16_284 / 1000
                    if L6_274 >= L16_284 then
                      L16_284 = A0_268.activitys
                      L16_284 = L16_284[L11_279]
                      L16_284 = L16_284.endTime
                      L16_284 = L16_284 / 1000
                      if L6_274 <= L16_284 then
                        L16_284 = tonumber
                        L16_284 = L16_284(L4_272)
                        if L16_284 >= tonumber(A0_268.activitys[L11_279].level) then
                          if L14_282 ~= nil then
                            L16_284 = table
                            L16_284 = L16_284.empty
                            L16_284 = L16_284(A0_268.activitys[L11_279].gifts)
                            if not L16_284 then
                              L16_284 = table
                              L16_284 = L16_284.insert
                              L16_284(L5_273, A0_268.activitys[L11_279])
                            end
                          else
                            L16_284 = table
                            L16_284 = L16_284.insert
                            L16_284(L5_273, A0_268.activitys[L11_279])
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
  return L5_273
end
function class.SetActivityGift(A0_285, A1_286)
  A0_285.activityGift = A1_286
end
function class.GetActivityGift(A0_287)
  local L1_288
  L1_288 = A0_287.activityGift
  return L1_288
end
function class.GetActivityGiftsID(A0_289)
  local L1_290
  L1_290 = {}
  if A0_289.activityGift.gifts ~= nil then
    for _FORV_5_, _FORV_6_ in pairs(A0_289.activityGift.gifts) do
      if A0_289.arrGiftsActivitys[_FORV_6_.id] and A0_289.arrGiftsActivitys[_FORV_6_.id].canShow then
        table.insert(L1_290, _FORV_6_.id)
      end
    end
  end
  table.sort(L1_290, function(A0_291, A1_292)
    local L2_293, L3_294
    L2_293 = _UPVALUE0_
    L2_293 = L2_293.canShowGiftActivity
    L2_293 = L2_293[A0_291]
    if L2_293 ~= nil then
      L2_293 = _UPVALUE0_
      L2_293 = L2_293.canShowGiftActivity
      L2_293 = L2_293[A1_292]
    elseif L2_293 == nil then
      L2_293 = false
      return L2_293
    end
    L2_293 = _UPVALUE0_
    L2_293 = L2_293.canShowGiftActivity
    L2_293 = L2_293[A0_291]
    L2_293 = L2_293.canDraw
    if L2_293 then
      L2_293 = 0
    else
      L2_293 = L2_293 or 1
    end
    L3_294 = _UPVALUE0_
    L3_294 = L3_294.canShowGiftActivity
    L3_294 = L3_294[A1_292]
    L3_294 = L3_294.canDraw
    if L3_294 then
      L3_294 = 0
    else
      L3_294 = L3_294 or 1
    end
    if L2_293 == L3_294 then
      return tonumber(_UPVALUE0_.canShowGiftActivity[A0_291].description.sort) > tonumber(_UPVALUE0_.canShowGiftActivity[A1_292].description.sort)
    else
      return L2_293 < L3_294
    end
  end)
  return L1_290, A0_289.activityGift.icon
end
function class.SetGiftInfoType(A0_295, A1_296)
  A0_295.strType = A1_296
end
function class.GetGiftInfoType(A0_297)
  local L1_298
  L1_298 = A0_297.strType
  return L1_298
end
function class.setCostRankType(A0_299, A1_300)
  A0_299.costRankType = A1_300
end
function class.GetCostRankType(A0_301)
  local L1_302
  L1_302 = A0_301.costRankType
  return L1_302
end
function class.IsHasNewActivityToday(A0_303)
  local L1_304, L2_305
  L2_305 = A0_303
  L1_304 = A0_303.GetCanShowAcivityList
  L1_304 = L1_304(L2_305)
  L2_305 = Logic
  L2_305 = L2_305.Get
  L2_305 = L2_305(L2_305, "System")
  L2_305 = L2_305.GetTime
  L2_305 = L2_305(L2_305)
  A0_303.todayActivtys = {}
  for _FORV_7_ = 1, #L1_304 do
    if Logic:Get("System"):GetTimeStr("%x", L1_304[_FORV_7_].startTime / 1000) == Logic:Get("System"):GetTimeStr("%x", L2_305) then
      table.insert(A0_303.todayActivtys, L1_304[_FORV_7_])
    end
  end
  if _FOR_.empty(A0_303.todayActivtys) then
    return false
  end
  return true
end
function class.IsSendEamin(A0_306)
  local L1_307, L2_308, L3_309, L4_310, L5_311
  L2_308 = A0_306
  L1_307 = A0_306.IsHasNewActivityToday
  L1_307 = L1_307(L2_308)
  if not L1_307 then
    L1_307 = false
    return L1_307
  end
  L1_307 = A0_306.todayActivtys
  L2_308 = {}
  A0_306.activityNames = L2_308
  L2_308 = {}
  A0_306.activityIds = L2_308
  L2_308 = Logic
  L2_308 = L2_308.Get
  L2_308 = L2_308(L3_309, L4_310)
  L2_308 = L2_308.GetUsrVariableMisc
  L2_308 = L2_308(L3_309, L4_310)
  if L2_308 ~= nil then
    L2_308 = L3_309
  else
    L2_308 = L3_309
  end
  for _FORV_6_ = 1, #L1_307 do
    if L2_308[L1_307[_FORV_6_].id] ~= nil then
      if tonumber(L2_308[L1_307[_FORV_6_].id]) ~= tonumber(L1_307[_FORV_6_].startTime) then
        L2_308[L1_307[_FORV_6_].id] = L1_307[_FORV_6_].startTime
        table.insert(A0_306.activityNames, L1_307[_FORV_6_].name)
        table.insert(A0_306.activityIds, L1_307[_FORV_6_].id)
      end
    else
      L2_308[L1_307[_FORV_6_].id] = L1_307[_FORV_6_].startTime
      table.insert(A0_306.activityNames, L1_307[_FORV_6_].name)
      table.insert(A0_306.activityIds, L1_307[_FORV_6_].id)
    end
  end
  L4_310(L5_311, "UV_ACTIVTYS", L3_309)
  if L4_310 then
    if L4_310 ~= nil then
      if L4_310 ~= nil and L4_310 ~= "null" then
        L4_310.time = L5_311
        Logic:Get("System"):SetUsrVariableMisc("UV_EMAIL", L5_311)
      end
    end
    return L4_310
  end
  for _FORV_8_ = 1, #A0_306.activityNames do
  end
  return L5_311, L4_310, A0_306.activityIds
end
function class.GetActivitysNameByIds(A0_312, A1_313)
  local L2_314, L3_315
  L3_315 = A0_312
  L2_314 = A0_312.GetCanShowAcivityList
  L2_314 = L2_314(L3_315)
  L3_315 = ""
  for _FORV_7_ = 1, #L2_314 do
    for _FORV_11_ = 1, #A1_313 do
      if L2_314[_FORV_7_].id == A1_313[_FORV_11_] then
        L3_315 = L3_315 .. L2_314[_FORV_7_].name .. "\n"
      end
    end
  end
  return L3_315
end
function class.SetChristmasNew(A0_316, A1_317)
  A0_316.christmasNew = A1_317
end
function class.GetChristmasNew(A0_318)
  local L1_319
  L1_319 = A0_318.christmasNew
  return L1_319
end
function class.GetActivityByType(A0_320, A1_321)
  local L2_322, L3_323, L4_324, L5_325, L6_326, L7_327, L8_328, L9_329, L10_330
  L2_322 = {}
  L3_323 = Logic
  L4_324 = L3_323
  L3_323 = L3_323.Get
  L5_325 = "System"
  L3_323 = L3_323(L4_324, L5_325)
  L4_324 = L3_323
  L3_323 = L3_323.GetTime
  L3_323 = L3_323(L4_324)
  L4_324 = Logic
  L5_325 = L4_324
  L4_324 = L4_324.Get
  L4_324 = L4_324(L5_325, L6_326)
  L5_325 = L4_324
  L4_324 = L4_324.GetPlayerLevel
  L4_324 = L4_324(L5_325)
  function L5_325(A0_331)
    if _UPVALUE0_ < A0_331.startTime / 1000 then
      return false
    end
    if _UPVALUE0_ > A0_331.endTime / 1000 then
      return false
    end
    if tonumber(_UPVALUE1_) < tonumber(A0_331.level) then
      return false
    end
    if Logic:Get("Lock"):checkStatusById(A0_331.lockKey) then
      return false
    end
    return true
  end
  for L9_329, L10_330 in L6_326(L7_327) do
    if L10_330.activityType and L10_330.activityType == A1_321 and L5_325(L10_330) then
      table.insert(L2_322, L10_330)
    end
  end
  return L2_322
end
function class.GetTimeStrByType(A0_332, A1_333)
  local L2_334, L3_335, L4_336, L5_337, L6_338, L7_339, L8_340, L9_341, L10_342, L11_343, L12_344, L13_345
  L3_335 = A0_332
  L2_334 = A0_332.GetActivityByType
  L2_334 = L2_334(L3_335, L4_336)
  L3_335 = {}
  for L7_339, L8_340 in L4_336(L5_337) do
    L9_341 = Logic
    L10_342 = L9_341
    L9_341 = L9_341.Get
    L11_343 = "System"
    L9_341 = L9_341(L10_342, L11_343)
    L10_342 = L9_341
    L9_341 = L9_341.DiffTime
    L11_343 = L8_340.endTime
    L11_343 = L11_343 / 1000
    L12_344 = L8_340.startTime
    L12_344 = L12_344 / 1000
    L9_341 = L9_341(L10_342, L11_343, L12_344)
    L10_342 = Logic
    L11_343 = L10_342
    L10_342 = L10_342.Get
    L12_344 = "System"
    L10_342 = L10_342(L11_343, L12_344)
    L11_343 = L10_342
    L10_342 = L10_342.SecToDay
    L12_344 = L9_341
    L10_342 = L10_342(L11_343, L12_344)
    L11_343 = L10_342.day
    if L11_343 <= 365 then
      L11_343 = TwGetStr
      L12_344 = 103088
      L11_343 = L11_343(L12_344)
      L12_344 = Logic
      L13_345 = L12_344
      L12_344 = L12_344.Get
      L12_344 = L12_344(L13_345, "System")
      L13_345 = L12_344
      L12_344 = L12_344.GetTimeStr
      L12_344 = L12_344(L13_345, L11_343, L8_340.startTime / 1000)
      L13_345 = Logic
      L13_345 = L13_345.Get
      L13_345 = L13_345(L13_345, "System")
      L13_345 = L13_345.GetTimeStr
      L13_345 = L13_345(L13_345, L11_343, L8_340.endTime / 1000)
      if Logic:Get("System"):GetTimeStr("%X", L8_340.endTime / 1000) and L13_345 ~= nil and Logic:Get("System"):GetTimeStr("%X", L8_340.endTime / 1000) == "00:00:00" then
        L13_345 = Logic:Get("System"):GetTimeStr(L11_343, L8_340.endTime / 1000 - 20)
      end
      if not L12_344 or not L13_345 then
        table.insert(L3_335, TwGetStr(103095))
      else
        table.insert(L3_335, L12_344 .. "-" .. L13_345)
      end
    else
      L11_343 = table
      L11_343 = L11_343.insert
      L12_344 = L3_335
      L13_345 = TwGetStr
      L13_345 = L13_345(103095)
      L11_343(L12_344, L13_345, L13_345(103095))
    end
  end
  return L3_335
end
function class.GetColorByGift(A0_346, A1_347)
  local L2_348, L3_349, L4_350, L5_351, L6_352, L7_353, L8_354, L9_355, L10_356, L11_357, L12_358, L13_359, L14_360
  L2_348 = Logic
  L2_348 = L2_348.Hero
  L2_348 = L2_348.RANK_COLOR
  L3_349 = {}
  for L7_353, L8_354 in L4_350(L5_351) do
    L9_355 = ""
    for L13_359, L14_360 in L10_356(L11_357) do
      L9_355 = L9_355 .. string.format("%02x", L14_360)
    end
    L10_356(L11_357, L12_358)
  end
  L5_351 = A1_347 or {}
  if L4_350 then
    L14_360 = L5_351(L6_352)
    return L4_350, L5_351
  end
  if L5_351 == "HERO" then
    L7_353 = "Hero"
    L7_353 = A1_347.showId
  end
  if L5_351 == "FRAGMENT" then
    L7_353 = "Compose"
    L7_353 = A1_347.showId
    if L5_351 then
      L7_353 = L6_352
      L8_354 = "Hero"
      L7_353 = L6_352
      L8_354 = L5_351.baseId
    end
  end
  if L5_351 == "TALISMAN" then
    L7_353 = A1_347.showId
    L7_353 = L6_352
    L8_354 = "Hero"
    L7_353 = L6_352
    L8_354 = L5_351.baseId
  end
  if L5_351 ~= "EQUIPMENT" then
  elseif L5_351 == "EQUIPMENT_FRAGMENT" then
    L7_353 = "Armor"
    L7_353 = A1_347.showId
  end
  if L5_351 == "CULTIVATE_ELIXIR" then
    L7_353 = "Cultivate"
    L7_353 = A1_347.showId
  end
  if L5_351 == "CULTIVATE_MATERIAL" then
    L7_353 = "Cultivate"
    L7_353 = A1_347.showId
  end
  if L4_350 then
    if L5_351 < 1 then
    else
    end
    L4_350.rank = L5_351
    if L5_351 > L6_352 then
    else
    end
    L4_350.rank = L5_351
    L7_353 = unpack
    L8_354 = L5_351
    L14_360 = L7_353(L8_354)
    L7_353 = L4_350.rank
    L7_353 = L3_349[L7_353]
    return L6_352, L7_353
  end
  if L5_351 < 1 then
  else
  end
  L7_353 = #L2_348
  if L6_352 > L7_353 then
  else
    L5_351 = L6_352 or A1_347.showId
  end
  L7_353 = unpack
  L8_354 = L2_348[L5_351]
  L14_360 = L7_353(L8_354)
  L7_353 = L3_349[L5_351]
  return L6_352, L7_353
end
