local L0_0
L0_0 = require
L0_0("Logic")
L0_0 = require
L0_0("SceneHelper")
L0_0 = module
L0_0((...), package.seeall)
L0_0 = Logic
L0_0 = L0_0.class
L0_0 = L0_0.subclass
L0_0 = L0_0(L0_0)
class = L0_0
L0_0 = {}
L0_0.ADD = 1
L0_0.REDUCE = 2
L0_0.SWAP = 3
PLAYER_DATA_CHANGE = L0_0
L0_0 = 0
PLAYER_MAX_PHYSICAL = L0_0
L0_0 = {}
L0_0.DATA_CHANGE = 1
L0_0.LEVEL_CHANGE = 2
L0_0.CHECK_MAINBTN_STATE = 3
L0_0.CHANK_VIP = 4
L0_0.SHOW_DAILY = 5
L0_0.DRAW_DAILY_REWARDS = 6
L0_0.GET_TOKEN_COIN = 7
L0_0.TOKEN_COIN_EXCHANGE = 8
L0_0.GET_CONSUME_RANK = 9
L0_0.REFRESH_GET_REWARD = 10
L0_0.GET_OPEN_BETA_GOODS_INFO = 11
L0_0.BUY_OPEN_BETA_GOODS = 12
EVT = L0_0
L0_0 = Enum
L0_0 = L0_0({
  "PLAYER_NAME",
  "MENPAI_NAME"
})
CHANGE_NAME = L0_0
L0_0 = Enum
L0_0 = L0_0(TypeDef("com.eyu.mt.module.player.facade.PlayerResult"))
function class.initialize(A0_1)
  super.initialize(A0_1)
  A0_1.playerInfo = {}
  A0_1.wallet = {}
  A0_1.physicalInfo = {}
  A0_1.dailyCheckInfo = {}
  A0_1.checkedId = 0
  A0_1.consunm_rank = {}
  A0_1.allRankList = {}
  A0_1.myRankList = {}
  A0_1.lvlChange = false
  A0_1.systemBtn = false
  PLAYER_MAX_PHYSICAL = tonumber(KFDBGetRecord("ConfigValue", "POINT:SINGLE_INCREASE_LIMIT").content)
  Logic:Get("MsgAssist"):RecordErrorMsg("MsgPlayer", _UPVALUE0_, _UPVALUE1_)
  MsgPlayer:On("VIP", A0_1:Event("OnGetVip"))
  MsgPlayer:On("WALLET", A0_1:Event("OnWallet"))
  MsgPoint:On("CURRENT_POINT", A0_1:Event("OnGetPhysical"))
  MsgPlayer:On("DAILY_CHECK_INFO", A0_1:Event("OnDailyCheckInfo"))
  MsgPlayer:On("DAILY_CHECK_IN", A0_1:Event("OnDailyCheckIn"))
  A0_1.tokenCoin = 0
  A0_1.exchangeTimes = {}
  A0_1.exchangeData = {}
  MsgPlayer:On("GET_ACTIVITY_MONEY", A0_1:Event("OnGetTokenCoin"))
  MsgPlayer:On("TOKEN_COIN_EXCHANGE", A0_1:Event("OnTokenCoinExchnage"))
  A0_1.buyGoods = {}
  A0_1.rewardStr = nil
  A0_1.resetPlayerName = false
  A0_1.shopRename = false
  A0_1.changeNameType = CHANGE_NAME.PLAYER_NAME
  MsgPlayer:On("GET_OPEN_BETA_GOODS_INFO", A0_1:Event("OnGetOpenBetaGoodsInfo"))
  MsgPlayer:On("BUY_OPEN_BETA_GOODS", A0_1:Event("OnBuyOpenBetaGoods"))
  MsgPlayer:On("GET_BUFFS", A0_1:Event("OnGetBuffs"))
  MsgPlayer:On("RESETNAME", A0_1:Event("OnResetName"), false)
  MsgPlayer:On("GET_CONSUME_RANK", A0_1:Event("OnGetConsumeRank"))
  Singleton(NetMgr):On(NetMgr.EVT.VIP_CHANGE, A0_1:Event("OnVipChange"))
  Singleton(NetMgr):On(NetMgr.EVT.CHARGE, A0_1:Event("OnChange"))
  Singleton(NetMgr):On(NetMgr.EVT.POINT_EXTRA, A0_1:Event("SendMsgGetPhysical"))
end
function class.InitInfo(A0_2, A1_3)
  A0_2.playerInfo = A1_3
end
function class.OnChange(A0_4)
  A0_4:PostWallet()
  Logic:Get("PhoneFee"):SetCharge(true)
end
function class.PostWallet(A0_5)
  MsgPlayer:Post("WALLET")
end
function class.OnWallet(A0_6, A1_7, A2_8)
  if A1_7 == 0 then
    A0_6.wallet = A2_8
    A0_6:FireEvent(EVT.DATA_CHANGE)
  end
end
function class.OnVipChange(A0_9)
  A0_9:PostGetVip()
end
function class.OnGetVip(A0_10, A1_11, A2_12)
  if A2_12 == nil then
    return
  end
  A0_10:SetVipInfo(A2_12)
end
function class.PostGetVip(A0_13)
  MsgPlayer:Post("VIP")
end
function class.SetVipInfo(A0_14, A1_15)
  if A1_15 == nil then
    return
  end
  A0_14.playerInfo.vip = A1_15
  A0_14:FireEvent(EVT.DATA_CHANGE, true)
  A0_14:FireEvent(EVT.CHANK_VIP)
end
function class.IsWeekVip(A0_16)
  A0_16:IsVipOverTime()
  if A0_16.playerInfo.vip then
    return A0_16.playerInfo.vip.week or false
  else
    return false
  end
end
function class.GetLastChargeDate(A0_17)
  if table.empty(A0_17.playerInfo.vip or {}) then
    return
  end
  return A0_17.playerInfo.vip.lastChargeDate
end
function class.hasMonthVipFunc(A0_18)
  return A0_18:IsMonVip() or A0_18:IsSuperMonVip()
end
function class.IsMonVip(A0_19)
  A0_19:IsVipOverTime()
  if A0_19.playerInfo.vip then
    return A0_19.playerInfo.vip.vip or false
  else
    return false
  end
end
function class.IsSuperMonVip(A0_20)
  if table.empty(A0_20.playerInfo.vip or {}) then
    return false
  end
  return A0_20.playerInfo.vip.monsth or false
end
function class.getMonsthTime(A0_21)
  local L1_22
  L1_22 = A0_21.playerInfo
  L1_22 = L1_22.vip
  L1_22 = L1_22.monsthTime
  L1_22 = L1_22 or 0
  return L1_22
end
function class.InitPhysical(A0_23, A1_24)
  if A1_24 == nil or table.empty(A1_24) then
    return
  end
  A0_23.physicalInfo = A1_24
  A0_23:FireEvent(EVT.DATA_CHANGE)
end
function class.IsOpenFunc(A0_25, A1_26)
  local L2_27, L3_28
  L3_28 = A0_25
  L2_27 = A0_25.hasMonthVipFunc
  L2_27 = L2_27(L3_28)
  L3_28 = A0_25.IsChargeOverNum
  L3_28 = L3_28(A0_25, A1_26)
  return L2_27 or L3_28
end
function class.IsChargeOverNum(A0_29, A1_30)
  if KFDBGetRecord("Charge2Times", A1_30 or 403) and A0_29:GetPlayerMoney().totalCharge >= tonumber(KFDBGetRecord("Charge2Times", A1_30 or 403).chargeAmount) then
    return true
  else
    return false
  end
end
function class.InitWallet(A0_31, A1_32)
  A0_31.wallet = A1_32
end
function class.CheckIsVip(A0_33)
  A0_33:IsVipOverTime()
  if A0_33.playerInfo.vip == nil then
    return false
  end
  if A0_33.playerInfo.vip.vip == nil or A0_33.playerInfo.vip.week == nil or A0_33.playerInfo.vip.monsth == nil then
    return false
  end
  return A0_33.playerInfo.vip.vip or A0_33.playerInfo.vip.week or A0_33.playerInfo.vip.monsth
end
function class.GetPlayerId(A0_34)
  return A0_34.playerInfo.id
end
function class.SetPlayerName(A0_35, A1_36)
  A0_35.playerInfo.name = A1_36
end
function class.GetPlayerName(A0_37)
  return A0_37.playerInfo.name
end
function class.IsMoneyEnough(A0_38, A1_39)
  if A1_39 == nil then
    return false
  end
  return A1_39 <= A0_38:GetPlayerAllJade()
end
function class.PlayerLevelChange(A0_40, A1_41, A2_42)
  local L3_43
  L3_43 = A0_40.playerInfo
  L3_43 = L3_43.level
  if A2_42 == PLAYER_DATA_CHANGE.REDUCE and A0_40.playerInfo.level then
    A0_40.playerInfo.level = A0_40.playerInfo.level - A1_41
  elseif A2_42 == PLAYER_DATA_CHANGE.ADD and A0_40.playerInfo.level then
    A0_40.playerInfo.level = A0_40.playerInfo.level + A1_41
  else
    A0_40.playerInfo.level = A1_41
  end
  if L3_43 ~= A0_40.playerInfo.level then
    A0_40:FireEvent(EVT.DATA_CHANGE)
    A0_40:FireEvent(EVT.LEVEL_CHANGE)
    A0_40:SendPlayerInfo()
  end
end
function class.SendPlayerInfo(A0_44)
  local L1_45, L2_46, L3_47
  L1_45 = Logic
  L2_46 = L1_45
  L1_45 = L1_45.Get
  L3_47 = "System"
  L1_45 = L1_45(L2_46, L3_47)
  L2_46 = L1_45
  L1_45 = L1_45.IsSendPlayerInfo
  L1_45 = L1_45(L2_46)
  if not L1_45 then
    return
  end
  L1_45 = Logic
  L2_46 = L1_45
  L1_45 = L1_45.Get
  L3_47 = "Login"
  L1_45 = L1_45(L2_46, L3_47)
  L2_46 = L1_45
  L1_45 = L1_45.GetLoginInfo
  L1_45 = L1_45(L2_46)
  L2_46 = {}
  L3_47 = A0_44.GetPlayerName
  L3_47 = L3_47(A0_44)
  L2_46.name = L3_47
  L3_47 = A0_44.GetPlayerLevel
  L3_47 = L3_47(A0_44)
  L2_46.level = L3_47
  L3_47 = A0_44.GetPlayerAllJade
  L3_47 = L3_47(A0_44)
  L2_46.gold = L3_47
  L3_47 = L1_45.server
  L2_46.serverid = L3_47
  L2_46.vip = 0
  L2_46.exp = 0
  L3_47 = ""
  if pcall(function()
    _UPVALUE0_ = json.encode(_UPVALUE1_)
  end) then
    Logic:Get("EnvLogic"):SendPlayerInfo(L3_47)
  end
end
function class.GetPlayerLevel(A0_48)
  return A0_48.playerInfo.level
end
function class.PlayerExpChange(A0_49, A1_50, A2_51)
  if A2_51 == PLAYER_DATA_CHANGE.REDUCE and A0_49.playerInfo.exp then
    A0_49.playerInfo.exp = A0_49.playerInfo.exp - A1_50
  elseif A2_51 == PLAYER_DATA_CHANGE.ADD and A0_49.playerInfo.exp then
    A0_49.playerInfo.exp = A0_49.playerInfo.exp + A1_50
  else
    A0_49.playerInfo.exp = A1_50
  end
  A0_49:FireEvent(EVT.DATA_CHANGE)
end
function class.GetPalyerExp(A0_52)
  return A0_52.playerInfo.exp
end
function class.GetUpgradeNeedByLevel(A0_53, A1_54)
  if A0_53:GetFdbInfoByLevel(A1_54) and A0_53:GetFdbInfoByLevel(A1_54).exp then
    return A0_53:GetFdbInfoByLevel(A1_54).exp
  else
    return nil
  end
end
function class.PlayerPhysical(A0_55, A1_56, A2_57)
  if A0_55.physicalInfo == nil then
    return
  end
  if A2_57 == PLAYER_DATA_CHANGE.ADD and A0_55.physicalInfo.point then
    A0_55.physicalInfo.point = A0_55.physicalInfo.point + A1_56
    if A0_55.physicalInfo.point > Logic.PlayerInfo.PLAYER_MAX_PHYSICAL then
      A0_55.physicalInfo.point = Logic.PlayerInfo.PLAYER_MAX_PHYSICAL
    end
  elseif A2_57 == PLAYER_DATA_CHANGE.REDUCE and A0_55.physicalInfo.point then
    A0_55.physicalInfo.point = A0_55.physicalInfo.point - A1_56
    if A0_55.physicalInfo.point < 0 then
      A0_55.physicalInfo.point = 0
    end
  else
    A0_55.physicalInfo.point = A1_56
  end
  A0_55:FireEvent(EVT.DATA_CHANGE)
end
function class.GetPlayerPhysical(A0_58)
  local L1_59
  L1_59 = A0_58.physicalInfo
  return L1_59
end
function class.PostGetBuffs(A0_60)
  MsgPlayer:Post("GET_BUFFS")
end
function class.OnGetBuffs(A0_61, A1_62, A2_63)
  if A1_62 ~= 0 then
    return
  end
  Logic:Get("Achievement"):onBuff(A2_63)
end
function class.SendMsgGetPhysical(A0_64)
  MsgPoint:Post("CURRENT_POINT")
end
function class.OnGetPhysical(A0_65, A1_66, A2_67)
  if A2_67.points then
    A0_65:InitPhysical(A2_67.points[0])
  end
end
function class.SetPlaerPhsicalExchange(A0_68, A1_69)
  if A1_69 then
    A0_68.physicalInfo.exchangeCount = A1_69
  end
end
function class.PlayerMoneyChange(A0_70, A1_71, A2_72, A3_73)
  if A0_70.wallet == nil or type(A0_70.wallet) ~= "table" then
    return
  end
  if type(A1_71) == "number" then
    A1_71 = string.lower(_UPVALUE0_[A1_71])
  else
    A1_71 = string.lower(A1_71)
  end
  if A3_73 == PLAYER_DATA_CHANGE.REDUCE and A0_70.wallet[A1_71] then
    A0_70.wallet[A1_71] = A0_70.wallet[A1_71] - A2_72
  elseif A3_73 == PLAYER_DATA_CHANGE.ADD and A0_70.wallet[A1_71] then
    A0_70.wallet[A1_71] = A0_70.wallet[A1_71] + A2_72
  else
    A0_70.wallet[A1_71] = A2_72
  end
  if A1_71 == "fragment" then
    Logic:Get("Compose"):IsHasCompose()
    Logic:Get("Compose"):FireEvent(Logic.Compose.EVT.NEW_COMPOSE)
  end
  A0_70:FireEvent(EVT.DATA_CHANGE)
end
function class.GetPlayerStone(A0_74)
  return A0_74.wallet.stone
end
function class.GetPlayerAllJade(A0_75)
  if A0_75.wallet == nil or table.empty(A0_75.wallet) then
    return 0
  end
  return A0_75.wallet.gold + A0_75.wallet.gift + A0_75.wallet.inter
end
function class.GetPlayerMoney(A0_76)
  local L1_77
  L1_77 = A0_76.wallet
  return L1_77
end
function class.GetFeatNum(A0_78)
  return A0_78:GetPlayerMoney().exploit or 0
end
function class.GetPlayerMoneyType(A0_79, A1_80)
  local L2_81, L3_82, L4_83, L5_84, L6_85, L7_86
  if nil == L2_81 then
    return L2_81
  end
  L3_82 = A1_80 or {}
  for L5_84, L6_85 in L2_81(L3_82) do
    L7_86 = string
    L7_86 = L7_86.upper
    L7_86 = L7_86(L6_85)
    if type(L6_85) == "number" then
      L7_86 = string.upper(_UPVALUE0_[L6_85])
    end
    if L7_86 == "COPPER" then
      return TwGetStr(103008)
    elseif L7_86 == "GOLD" or L7_86 == "GIFT" or L7_86 == "INTER" then
      return TwGetStr(103009)
    elseif L7_86 == "EXCHANGE" then
      return TwGetStr(103012)
    elseif L7_86 == "FRIENDSHIP" then
      return TwGetStr(103013)
    elseif L7_86 == "FRAGMENT" then
      return TwGetStr(103026)
    elseif L7_86 == "STONE" then
      return TwGetStr(105255)
    elseif L7_86 == "CONSUME" then
      return TwGetStr(100067)
    end
  end
  return L2_81
end
function class.GetPlayerMoneyByType(A0_87, A1_88)
  local L2_89, L3_90, L4_91, L5_92, L6_93, L7_94
  L2_89 = A0_87.wallet
  if nil == L2_89 then
    L2_89 = 0
    return L2_89
  end
  L2_89 = 0
  L4_91 = A1_88 or {}
  for L6_93, L7_94 in L3_90(L4_91) do
    if A0_87.wallet[string.lower(L7_94)] then
      L2_89 = L2_89 + A0_87.wallet[string.lower(L7_94)]
    end
  end
  return L2_89
end
function class.PlayerJobChange(A0_95, A1_96)
  A0_95.playerInfo.job = A1_96
  A0_95:FireEvent(EVT.DATA_CHANGE)
end
function class.GetPlayerJob(A0_97)
  return A0_97.playerInfo.job
end
function class.GetPlayerAllInfo(A0_98)
  A0_98:IsVipOverTime()
  return A0_98.playerInfo
end
function class.GetFdbInfoByLevel(A0_99, A1_100)
  return KFDBGetRecord("LevelConfig", A1_100)
end
function class.GetPlayerMaxLevel(A0_101)
  return KFDBGetRecordAmt("LevelConfig")
end
function class.SetSystemBtnState(A0_102, A1_103)
  A0_102.systemBtn = A1_103
end
function class.GetSystemBtnState(A0_104)
  local L1_105
  L1_105 = A0_104.systemBtn
  return L1_105
end
function class.IsVipOverTime(A0_106)
  if table.empty(A0_106.playerInfo.vip or {}) then
    return
  end
  if A0_106.playerInfo.vip.week and A0_106.playerInfo.vip.weekTime ~= nil and Logic:Get("System"):GetTime() - A0_106.playerInfo.vip.weekTime / 1000 >= 0 then
    A0_106.playerInfo.vip.week = false
  end
  if A0_106.playerInfo.vip.vip and A0_106.playerInfo.vip.vipTime ~= nil and 0 <= Logic:Get("System"):GetTime() - A0_106.playerInfo.vip.vipTime / 1000 then
    A0_106.playerInfo.vip.vip = false
  end
  if A0_106.playerInfo.vip.monsth and A0_106.playerInfo.vip.monsthTime ~= nil and 0 > Logic:Get("System"):DiffTime(A0_106.playerInfo.vip.monsthTime / 1000) then
    A0_106.playerInfo.vip.monsth = false
  end
  if true then
    A0_106:FireEvent(EVT.DATA_CHANGE)
  end
end
function class.SetCheckId(A0_107, A1_108)
  A0_107.checkedId = A1_108 or A0_107.checkedId
end
function class.SetDailyCheckInfo(A0_109, A1_110)
  A0_109.dailyCheckInfo = A1_110 or A0_109.dailyCheckInfo
end
function class.GetDailyCheckInfo(A0_111)
  local L1_112
  L1_112 = A0_111.dailyCheckInfo
  return L1_112
end
function class.PostDailyCheckInfo(A0_113)
  MsgPlayer:Post("DAILY_CHECK_INFO")
end
function class.PostDailyCheckIn(A0_114)
  A0_114:SetDrawId()
  MsgPlayer:Post("DAILY_CHECK_IN")
end
function class.SetDailyData(A0_115, A1_116)
  local L2_117, L3_118
  L2_117 = A0_115.dailyCheckInfo
  L3_118 = A1_116.checkedIds
  L2_117.checkedIds = L3_118
  L2_117 = A0_115.dailyCheckInfo
  L3_118 = A1_116.continueDays
  L2_117.continueDays = L3_118
  L2_117 = A0_115.dailyCheckInfo
  L3_118 = A1_116.segment
  L2_117.segment = L3_118
end
function class.GetDailyRewardData(A0_119)
  local L1_120, L2_121, L3_122, L4_123, L5_124, L6_125, L7_126, L8_127, L9_128
  L1_120 = A0_119.dailyCheckInfo
  L2_121 = L1_120.segment
  L2_121 = L2_121 or 1
  L3_122 = {}
  L4_123 = A0_119.GetDailyXls
  L4_123 = L4_123(L5_124)
  for L8_127 = 1, L6_125(L7_126) do
    L9_128 = KFDBGetRecordByIdx
    L9_128 = L9_128(L4_123, L8_127)
    if L9_128 and L9_128.levelSegment == L2_121 then
      L9_128.hasDraw = A0_119:IsDrawById(L9_128.id)
      table.insert(L3_122, L9_128)
    end
  end
  return L3_122
end
function class.IsDrawById(A0_129, A1_130)
  if A0_129.dailyCheckInfo.checkedIds == nil or A1_130 == nil then
    return false
  end
  for _FORV_5_, _FORV_6_ in pairs(A0_129.dailyCheckInfo.checkedIds) do
    if _FORV_6_ == A1_130 then
      return true
    end
  end
  return false
end
function class.GetDailyXls(A0_131)
  local L1_132, L2_133
  L1_132 = ""
  L2_133 = A0_131.dailyCheckInfo
  L2_133 = L2_133.first
  if L2_133 then
    L1_132 = "FirstDailyCheckConfig"
  else
    L1_132 = "DailyCheckConfig"
  end
  return L1_132
end
function class.IsDrawTodayReward(A0_134)
  if A0_134.dailyCheckInfo == nil or table.empty(A0_134.dailyCheckInfo) then
    return false
  end
  if A0_134.dailyCheckInfo.checkedIds == nil or table.empty(A0_134.dailyCheckInfo.checkedIds) then
    return false
  end
  if (KFDBGetRecord("ConfigValue", "PLAYER:DAILY_CHECK_PERIOD") and tonumber(KFDBGetRecord("ConfigValue", "PLAYER:DAILY_CHECK_PERIOD").content) or 7 or A0_134.dailyCheckInfo.continueDays % (KFDBGetRecord("ConfigValue", "PLAYER:DAILY_CHECK_PERIOD") and tonumber(KFDBGetRecord("ConfigValue", "PLAYER:DAILY_CHECK_PERIOD").content) or 7)) <= #A0_134.dailyCheckInfo.checkedIds then
    return true
  end
  return false
end
function class.SetDrawId(A0_135)
  local L1_136, L2_137, L3_138, L4_139, L5_140, L6_141, L7_142, L8_143, L9_144, L10_145, L11_146
  L1_136 = A0_135.dailyCheckInfo
  L2_137 = KFDBGetRecord
  L3_138 = "ConfigValue"
  L4_139 = "PLAYER:DAILY_CHECK_PERIOD"
  L2_137 = L2_137(L3_138, L4_139)
  if L2_137 then
    L3_138 = tonumber
    L4_139 = L2_137.content
    L3_138 = L3_138(L4_139)
  else
    L3_138 = L3_138 or 7
  end
  L4_139 = L1_136.continueDays
  L4_139 = L4_139 % L3_138
  if L4_139 == 0 then
    L4_139 = L3_138 or L4_139
  end
  L5_140 = L1_136.segment
  L5_140 = L5_140 or 1
  L7_142 = A0_135
  L6_141 = A0_135.GetDailyXls
  L6_141 = L6_141(L7_142)
  L7_142 = 0
  for L11_146 = 1, L9_144(L10_145) do
    if KFDBGetRecordByIdx(L6_141, L11_146) and KFDBGetRecordByIdx(L6_141, L11_146).levelSegment == L5_140 and KFDBGetRecordByIdx(L6_141, L11_146).continueDay == L4_139 then
      L7_142 = KFDBGetRecordByIdx(L6_141, L11_146).id
    end
  end
  L8_143(L9_144, L10_145)
end
function class.OnDailyCheckInfo(A0_147, A1_148, A2_149)
  if A1_148 ~= 0 then
    return
  end
  A0_147:SetDailyData(A2_149)
  A0_147.dailyCheckInfo.first = A2_149.first
end
function class.OnDailyCheckIn(A0_150, A1_151, A2_152)
  local L3_153, L4_154, L5_155
  if A1_151 ~= 0 then
    return
  end
  L4_154 = A0_150
  L3_153 = A0_150.SetDailyData
  L5_155 = A2_152
  L3_153(L4_154, L5_155)
  L3_153 = Logic
  L4_154 = L3_153
  L3_153 = L3_153.Get
  L5_155 = "Reward"
  L3_153 = L3_153(L4_154, L5_155)
  L4_154 = L3_153
  L3_153 = L3_153.AddRewards
  L5_155 = A2_152.rewardResults
  L3_153(L4_154, L5_155)
  L4_154 = A0_150
  L3_153 = A0_150.FireEvent
  L5_155 = EVT
  L5_155 = L5_155.REFRESH_GET_REWARD
  L3_153(L4_154, L5_155)
  L4_154 = A0_150
  L3_153 = A0_150.GetDailyXls
  L3_153 = L3_153(L4_154)
  L4_154 = KFDBGetRecord
  L5_155 = L3_153
  L4_154 = L4_154(L5_155, A0_150.checkedId)
  if L4_154 then
    L5_155 = L4_154.rewardType
    if L5_155 == "CONFIG" then
      L5_155 = Logic
      L5_155 = L5_155.Get
      L5_155 = L5_155(L5_155, "Lottery")
      L5_155 = L5_155.ShowDrawResult
      L5_155(L5_155, A2_152.rewardResults)
      return
    end
  end
  L5_155 = Logic
  L5_155 = L5_155.Get
  L5_155 = L5_155(L5_155, "Reward")
  L5_155 = L5_155.AddRewardsTip
  L5_155 = L5_155(L5_155, A2_152.rewardResults)
  Prompt:Fail(L5_155)
end
function class.SetTokenCoin(A0_156, A1_157)
  A0_156.tokenCoin = A1_157
end
function class.GetTokenCoin(A0_158)
  local L1_159
  L1_159 = A0_158.tokenCoin
  return L1_159
end
function class.AddTokenCoin(A0_160, A1_161)
  local L2_162
  if A1_161 then
    L2_162 = A0_160.tokenCoin
    L2_162 = L2_162 + A1_161
  else
    L2_162 = L2_162 or A0_160.tokenCoin
  end
  A0_160.tokenCoin = L2_162
end
function class.getExchangeTime(A0_163, A1_164)
  local L2_165
  L2_165 = A0_163.exchangeTimes
  L2_165 = L2_165[A1_164]
  L2_165 = L2_165 or 0
  return L2_165
end
function class.PostGetTokenCoin(A0_166, A1_167)
  MsgPlayer:Post("GET_ACTIVITY_MONEY", {
    mallId = A1_167 or 400
  })
end
function class.PostTokenCoinExchnage(A0_168, A1_169, A2_170)
  if nil == A1_169 or nil == A2_170 then
    return
  end
  A0_168.exchangeData.id = A1_169
  A0_168.exchangeData.num = A2_170
  MsgPlayer:Post("TOKEN_COIN_EXCHANGE", {id = A1_169, num = A2_170})
end
function class.OnGetTokenCoin(A0_171, A1_172, A2_173)
  if A1_172 ~= 0 then
    return
  end
  A0_171.tokenCoin = A2_173.tokenCoin or 0
  A0_171.exchangeTimes = A2_173.exchangeTimes or {}
  A0_171:FireEvent(EVT.GET_TOKEN_COIN)
end
function class.OnTokenCoinExchnage(A0_174, A1_175, A2_176)
  local L3_177, L4_178
  if A1_175 ~= 0 then
    return
  end
  L3_177 = A2_176.tokenCoin
  A0_174.tokenCoin = L3_177
  L3_177 = A0_174.exchangeData
  L3_177 = L3_177.id
  L4_178 = A0_174.exchangeTimes
  L4_178 = L4_178[L3_177]
  if L4_178 then
    L4_178 = A0_174.exchangeTimes
    L4_178[L3_177] = A0_174.exchangeTimes[L3_177] + A0_174.exchangeData.num
  else
    L4_178 = A0_174.exchangeTimes
    L4_178[L3_177] = A0_174.exchangeData.num
  end
  if L3_177 == 814 then
    L4_178 = A0_174.SetResetNameType
    L4_178(A0_174, CHANGE_NAME.PLAYER_NAME)
    L4_178 = A0_174.SetShopRename
    L4_178(A0_174, true)
    L4_178 = SceneHelper
    L4_178 = L4_178.pushPrompt
    L4_178(L4_178, "ShopRename", nil)
    L4_178 = A0_174.FireEvent
    L4_178(A0_174, EVT.TOKEN_COIN_EXCHANGE)
    return
  end
  L4_178 = Logic
  L4_178 = L4_178.Get
  L4_178 = L4_178(L4_178, "Reward")
  L4_178 = L4_178.AddRewards
  L4_178(L4_178, A2_176.rewardResult)
  L4_178 = Logic
  L4_178 = L4_178.Get
  L4_178 = L4_178(L4_178, "Reward")
  L4_178 = L4_178.AddDupiCardTip
  L4_178 = L4_178(L4_178, A2_176.rewardResult)
  Prompt:Fail(L4_178)
  A0_174:FireEvent(EVT.TOKEN_COIN_EXCHANGE)
end
function class.PostGetOpenBetaGoodsInfo(A0_179)
  MsgPlayer:Post("GET_OPEN_BETA_GOODS_INFO")
end
function class.PostBuyOpenBetaGoods(A0_180, A1_181)
  if A1_181 == nil then
    return
  end
  MsgPlayer:Post("BUY_OPEN_BETA_GOODS", {goodsId = A1_181})
end
function class.GetBetaBuyTimeById(A0_182, A1_183)
  if A1_183 == nil then
    return 0
  end
  for _FORV_5_, _FORV_6_ in pairs(A0_182.buyGoods) do
    if _FORV_5_ == A1_183 then
      return _FORV_6_
    end
  end
  return 0
end
function class.IsNeedShowAniById(A0_184, A1_185)
  local L2_186, L3_187
  if A1_185 == nil then
    L2_186 = false
    return L2_186
  end
  L2_186 = KFDBGetRecord
  L3_187 = "OpenBetaGoodsConfig"
  L2_186 = L2_186(L3_187, A1_185)
  if L2_186 == nil then
    L3_187 = false
    return L3_187
  end
  L3_187 = json
  L3_187 = L3_187.decode
  L3_187 = L3_187(L2_186.showTypes or "[]")
  for _FORV_7_, _FORV_8_ in pairs(L3_187) do
    if _FORV_8_ == "MYSTCARD" then
      return true
    end
  end
  return false
end
function class.OnGetOpenBetaGoodsInfo(A0_188, A1_189, A2_190)
  if A1_189 ~= 0 then
    return
  end
  A0_188.buyGoods = A2_190
  A0_188:FireEvent(EVT.GET_OPEN_BETA_GOODS_INFO)
end
function class.OnBuyOpenBetaGoods(A0_191, A1_192, A2_193)
  if A1_192 ~= 0 then
    return
  end
  A0_191.buyGoods = A2_193.buyGoods
  Logic:Get("Cost"):AddCosts(A2_193.costResults)
  Logic:Get("Reward"):AddRewards(A2_193.randomRewardResults)
  Logic:Get("Reward"):AddRewards(A2_193.fixedRewardResults)
  A0_191.rewardStr = Logic:Get("Reward"):AddDupiCardTip(A2_193.randomRewardResults)
  A0_191.rewardStr = (A0_191.rewardStr or "") .. Logic:Get("Reward"):AddDupiCardTip(A2_193.fixedRewardResults)
  A0_191:FireEvent(EVT.BUY_OPEN_BETA_GOODS)
  if not table.empty(A2_193.randomRewardResults or {}) then
    Logic:Get("Lottery"):ShowDrawResult(A2_193.randomRewardResults)
    return
  end
  A0_191:ShowRewarTip()
end
function class.ShowRewarTip(A0_194)
  if A0_194.rewardStr then
    Prompt:Fail(A0_194.rewardStr)
    A0_194.rewardStr = nil
  end
end
function class.PostGetConsumeRank(A0_195)
  MsgPlayer:Post("GET_CONSUME_RANK")
end
function class.OnGetConsumeRank(A0_196, A1_197, A2_198)
  local L3_199, L4_200, L5_201, L6_202, L7_203, L8_204
  L3_199 = {}
  A0_196.allRankList = L3_199
  L3_199 = {}
  A0_196.myRankList = L3_199
  if A1_197 == 0 then
    A0_196.consunm_rank = A2_198
    L3_199 = Logic
    L3_199 = L3_199.Get
    L3_199 = L3_199(L4_200, L5_201)
    L3_199 = L3_199.GetPlayerName
    L3_199 = L3_199(L4_200)
    for L7_203, L8_204 in L4_200(L5_201) do
      if L7_203 <= 5 then
        table.insert(A0_196.allRankList, L8_204)
      end
      if L8_204.name == L3_199 then
        for _FORV_12_ = L7_203 - 2, L7_203 + 2 do
          if _FORV_12_ >= 1 and _FORV_12_ <= #A2_198 then
            table.insert(A0_196.myRankList, A2_198[_FORV_12_])
          end
        end
      end
    end
    L4_200(L5_201, L6_202)
  end
end
function class.GetConsunm_Rank(A0_205)
  local L1_206
  L1_206 = A0_205.consunm_rank
  return L1_206
end
function class.setMyRankConsunm(A0_207)
  A0_207.rankData = A0_207.myRankList
  if table.empty(A0_207.myRankList) then
    Prompt:Tip(103344)
  else
    A0_207:FireEvent(EVT.GET_CONSUME_RANK)
  end
end
function class.setPreFiveRank(A0_208)
  A0_208.rankData = A0_208.allRankList
  A0_208:FireEvent(EVT.GET_CONSUME_RANK)
end
function class.GetRankData(A0_209)
  local L1_210
  L1_210 = A0_209.rankData
  return L1_210
end
function class.GetLevelChange(A0_211)
  local L1_212
  L1_212 = A0_211.lvlChange
  return L1_212
end
function class.setLevelChange(A0_213, A1_214)
  A0_213.lvlChange = A1_214
end
function class.SetResetNameType(A0_215, A1_216)
  A0_215.changeNameType = A1_216
end
function class.GetResetNameType(A0_217)
  local L1_218
  L1_218 = A0_217.changeNameType
  return L1_218
end
function class.SetShopRename(A0_219, A1_220)
  local L2_221
  if A1_220 then
    L2_221 = true
  else
    L2_221 = L2_221 or false
  end
  A0_219.shopRename = L2_221
end
function class.IsShopRename(A0_222)
  return A0_222.shopRename == true
end
function class.SetResetPlayerName(A0_223, A1_224)
  A0_223.resetPlayerName = A1_224
end
function class.IsNeedResetPlayerName(A0_225)
  local L1_226
  L1_226 = A0_225.resetPlayerName
  return L1_226
end
function class.PostResetName(A0_227, A1_228)
  A0_227.resetName = A1_228
  MsgPlayer:Post("RESETNAME", A1_228)
end
function class.OnResetName(A0_229, A1_230, A2_231)
  if A1_230 ~= 0 then
    Logic:Get("Sect"):FireEvent(Logic.Sect.EVT.RENAME_ERROR)
    return
  end
  A0_229.playerInfo.name = A0_229.resetName
  if A0_229.shopRename then
    A0_229:SetShopRename(false)
  end
  A0_229:FireEvent(EVT.DATA_CHANGE)
end
function class.IsPhysicalPointFull(A0_232)
  return A0_232:GetPlayerPhysical().point >= PLAYER_MAX_PHYSICAL
end
