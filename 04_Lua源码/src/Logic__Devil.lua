local L0_0
L0_0 = module
L0_0((...), package.seeall)
L0_0 = require
L0_0("Logic")
L0_0 = Logic
L0_0 = L0_0.class
L0_0 = L0_0.subclass
L0_0 = L0_0(L0_0)
class = L0_0
L0_0 = 1000
EVT = Enum({
  "PAGE_CHANGE",
  "UPDATE_ACT_TIME",
  "PUSH_DEMOG_INFO",
  "PUSH_MAIN_INFO",
  "PUSH_DAMOG_LIST",
  "UPDATE_DAMOG_LIST",
  "GET_FEATS_RANK",
  "GET_MAX_DAMAGE_RANK",
  "PUSH_REPORT",
  "SHOW_DAMAGE_RANK",
  "UPDATE_REWARD_LIST",
  "GET_RANK_GROUP_INFO",
  "UPDATE_FRAGMENT_EXCHANGE",
  "EXCHANGE_SUCCESS",
  "BUY_SUCCESSED",
  "PUSH_NEW_REWARD",
  "GOT_NEW_DEVIL",
  "OPEN_NEW_ACTIVE",
  "PUSH_FEATS_RANK",
  "PRAISE_CHANGE",
  "REFRESH_GROUP_DATA",
  "SHOW_GROUP_INFO",
  "REFRESH_RED_COM",
  "UPDATE_ENERGY"
})
ENTER_TYPE = Enum({"BATTLE", "DEVIL_LIST"})
REWARD_TYPE = {FEATS = "FEATS", DAMAGE = "DAMAGE"}
RANK_TYPE = {
  FEATSRANK = "FEATSRANK",
  DAMAGERANK = "DAMAGERANK",
  DEVILMAIN = "DEVILMAIN"
}
function class.initialize(A0_1)
  local L1_2
  L1_2 = super
  L1_2 = L1_2.initialize
  L1_2(A0_1)
  A0_1.rankGroupId = 0
  L1_2 = {}
  A0_1.oldTeamers = L1_2
  L1_2 = {}
  A0_1.teamers = L1_2
  A0_1.fragment = 0
  L1_2 = {}
  A0_1.changeGroup = L1_2
  A0_1.reward = false
  L1_2 = {}
  A0_1.energy = L1_2
  A0_1.activeId = nil
  A0_1.feat = 0
  A0_1.rank = nil
  A0_1.pct = 0
  L1_2 = {}
  A0_1.devilList = L1_2
  A0_1.enterType = -1
  L1_2 = {}
  A0_1.devilData = L1_2
  A0_1.damage = nil
  A0_1.actFeat = nil
  A0_1.isKill = false
  A0_1.isInvited = false
  L1_2 = {}
  A0_1.totalDamageRank = L1_2
  A0_1.changeType = nil
  A0_1.groupNum = 0
  L1_2 = {}
  A0_1.featsRank = L1_2
  L1_2 = {}
  A0_1.maxDamageRank = L1_2
  A0_1.rankType = ""
  L1_2 = {}
  A0_1.featsRankTop = L1_2
  L1_2 = {}
  A0_1.featsRankMyRank = L1_2
  L1_2 = {}
  A0_1.maxDamageRankTop = L1_2
  L1_2 = {}
  A0_1.maxDamageRankMyRank = L1_2
  L1_2 = {}
  A0_1.drawReward = L1_2
  L1_2 = {}
  A0_1.drawRewardId = L1_2
  A0_1.isRankTop = false
  L1_2 = {}
  A0_1.killList = L1_2
  A0_1.drawKillId = 0
  A0_1.dropDemog = false
  A0_1.gotPushDemog = false
  A0_1.requestFeatsRankTime = 0
  A0_1.requestDamageRankTime = 0
  A0_1.buyType = 0
  A0_1.comBattleId = ""
  A0_1.myFeatsRank = 0
  A0_1.myDamageRank = 0
  A0_1.devilGetAllRankTime = 0
  A0_1.lastAttackDrawNum = 0
  L1_2 = {}
  A0_1.primExchangeLimit = L1_2
  A0_1.primExchangeNum = 0
  A0_1.primExchangeConfigId = 0
  L1_2 = KFDBGetRecord
  L1_2 = L1_2("ConfigValue", "DEMOG:ATTACK_NORMAL_ENERGY")
  A0_1.normalAct = L1_2 and tonumber(L1_2.content) or 0
  L1_2 = KFDBGetRecord("ConfigValue", "DEMOG:ATTACK_ALL_OUT_ENERGY")
  A0_1.allAct = L1_2 and tonumber(L1_2.content) or 0
  A0_1.isAllAct = false
  L1_2 = KFDBGetRecord("ConfigValue", "DEMOG:ALL_OUT_ATTACK_ADD")
  A0_1.fullPowerMul = L1_2 and tonumber(L1_2.content) or 1
  L1_2 = KFDBGetRecord("ConfigValue", "POINT:DEMOG_BUY_COST")
  A0_1.buyCost = L1_2 and json.decode(L1_2.content) or {}
  L1_2 = KFDBGetRecord("ConfigValue", "POINT:DEMOG_BUY_COUNT")
  A0_1.BuyCnt = L1_2 and tonumber(L1_2.content) or 1
  L1_2 = KFDBGetRecord("ConfigValue", "DEMOG:HERO_STAR_ATTACK_ADD")
  A0_1.starUp = L1_2 and json.decode(L1_2.content) or {}
  L1_2 = KFDBGetRecord("ConfigValue", "DEMOG:BUY_ENERGY_TYPE")
  A0_1.buyEnergyType = L1_2 and json.decode(L1_2.content) or {}
  L1_2 = KFDBGetRecord("ConfigValue", "POINT:DEMOG_INCREASE_INTERVAL")
  A0_1.energyRefresh = L1_2 and L1_2.content * 60 or 0
  L1_2 = KFDBGetRecord("ConfigValue", "POINT:DEMOG_INCREASE_COUNT")
  A0_1.recoverEng = L1_2 and tonumber(L1_2.content) or 0
  L1_2 = KFDBGetRecord("ConfigValue", "POINT:DEMOG_INCREASE_LIMIT")
  A0_1.maxEnergy = L1_2 and tonumber(L1_2.content) or 1
  A0_1.addBuyCnt = 0
  A0_1.leaveBuyTime = 0
  A0_1.rankGroupInfo = {}
  A0_1.primExchangeResult = {}
  A0_1.actLeftTime = 0
  A0_1.actTimeMarker = nil
  A0_1.waitTime = nil
  A0_1.addFeatMarker = Logic:Get("System"):GetTimeDate()
  Logic:Get("MsgAssist"):RecordErrorMsg("MsgDemog", _UPVALUE0_, _UPVALUE1_)
  MsgDemog:On("ACTIVE_INFO", A0_1:Event("OnActiveInfo"))
  MsgDemog:On("DEMOG_LIST", A0_1:Event("OnDemogList"))
  MsgDemog:On("ATTACK_DEMOG", A0_1:Event("OnAttackDemog"))
  MsgDemog:On("TOTAL_DAMAGE_RANK", A0_1:Event("OnTotalDamageRank"))
  MsgDemog:On("INVITE_FRIEND_ATTACK", A0_1:Event("OnInviteFriendAttack"))
  MsgDemog:On("MAX_DAMAGE_RANK", A0_1:Event("OnMaxDamageRank"))
  MsgDemog:On("FEAT_RANK", A0_1:Event("OnFeatRank"))
  MsgDemog:On("RANK_GROUP_INFO", A0_1:Event("OnRankGroupInfo"))
  MsgDemog:On("FRAGMENT_EXCHANGE", A0_1:Event("OnFragmentExchange"))
  MsgDemog:On("BUY_ENERGY", A0_1:Event("OnBuyEnergy"))
  MsgDemog:On("DRAW_FEAT_REWARD", A0_1:Event("OnDrawFeatReward"), false)
  MsgDemog:On("GET_ACTIVE_ID", A0_1:Event("OnGetActiveId"))
  MsgDemog:On("DRAW_KILLED_DEMOG_REWARD", A0_1:Event("OnDrawKilledDemogReward"), false)
  MsgDemog:On("REFRESH_DEMOG", A0_1:Event("OnRefreshDemog"))
  MsgDemog:On("ALL_RANK", A0_1:Event("OnAllRank"))
  MsgDemog:On("PRAISE_RANK", A0_1:Event("OnPraiseRank"))
  MsgDemog:On("RED_CARD_COMPOSE", A0_1:Event("OnRedCardCompose"))
  Singleton(NetMgr):On(NetMgr.EVT.NEW_DEMOG, A0_1:Event("OnNewDemog"))
  Singleton(NetMgr):On(NetMgr.EVT.DEMOG_ACTIVE_OPEN, A0_1:Event("OnDemogActiveOpen"))
end
function class.OnReset(A0_3)
  local L1_4
end
function class.initRewardData(A0_5)
  local L1_6, L2_7, L3_8, L4_9, L5_10, L6_11, L7_12
  L1_6 = {}
  L2_7 = Logic
  L2_7 = L2_7.Get
  L2_7 = L2_7(L3_8, L4_9)
  L2_7 = L2_7.GetPlayerLevel
  L2_7 = L2_7(L3_8)
  for L6_11 = 1, L4_9(L5_10) do
    L7_12 = KFDBGetRecordByIdx
    L7_12 = L7_12("FeatReward", L6_11)
    if L7_12 and A0_5.activeId == L7_12.activeId and L2_7 >= L7_12.minLevel and L2_7 <= L7_12.maxLevel then
      table.insert(L1_6, L7_12)
    end
  end
  return L1_6
end
function class.checkFeatReward(A0_13)
  local L1_14
  L1_14 = A0_13.initRewardData
  L1_14 = L1_14(A0_13)
  A0_13:removeDrawFeatReward(L1_14)
  for _FORV_5_, _FORV_6_ in pairs(L1_14) do
    if A0_13.feat >= _FORV_6_.feat then
      return true
    end
  end
  return false
end
function class.fdbAddBuyTime(A0_15)
  local L1_16, L2_17, L3_18, L4_19
  A0_15.addBuyCnt = 0
  for L4_19 = 1, L2_17(L3_18) do
    if KFDBGetRecordByIdx("Charge2Times", L4_19) and KFDBGetRecordByIdx("Charge2Times", L4_19).type == "DEMOG_ENERGY" and Logic:Get("PlayerInfo"):GetPlayerMoney().totalCharge >= KFDBGetRecordByIdx("Charge2Times", L4_19).chargeAmount and KFDBGetRecordByIdx("Charge2Times", L4_19).addTimes > A0_15.addBuyCnt then
      A0_15.addBuyCnt = KFDBGetRecordByIdx("Charge2Times", L4_19).addTimes
    end
  end
end
function class.checkNewDemogAct(A0_20)
  if A0_20.activeId == nil then
    return false
  end
  if KFDBGetRecord("DemogActiveConfig", A0_20.activeId) and KFDBGetRecord("DemogActiveConfig", A0_20.activeId).type == "TOP_LEVEL" then
    return true
  end
  return false
end
function class.GetLastAttackDrawNum(A0_21)
  local L1_22
  L1_22 = A0_21.lastAttackDrawNum
  return L1_22
end
function class.SetComBattleId(A0_23, A1_24)
  A0_23.comBattleId = A1_24
end
function class.GetMaxEnergy(A0_25)
  local L1_26
  L1_26 = A0_25.maxEnergy
  return L1_26
end
function class.clearPushDemog(A0_27)
  A0_27.gotPushDemog = false
  A0_27:FireEvent(EVT.GOT_NEW_DEVIL)
end
function class.GetPushDemog(A0_28)
  local L1_29
  L1_29 = A0_28.gotPushDemog
  return L1_29
end
function class.SetHasDemog(A0_30, A1_31)
  A0_30.hasDemog = A1_31
end
function class.GetHasDemog(A0_32)
  local L1_33
  L1_33 = A0_32.hasDemog
  return L1_33
end
function class.GetBuyEnergyType(A0_34)
  local L1_35
  L1_35 = A0_34.buyEnergyType
  return L1_35
end
function class.GetStarUpByCardStar(A0_36, A1_37)
  if A1_37 == nil or A0_36.starUp == nil or table.empty(A0_36.starUp) then
    return 1
  end
  if A1_37 < 1 then
    A1_37 = 1 or A1_37
  end
  if A1_37 > #A0_36.starUp then
    A1_37 = #A0_36.starUp or A1_37
  end
  return A0_36.starUp[A1_37]
end
function class.GetBuyCost(A0_38, A1_39)
  if A0_38.buyCost == nil or table.empty(A0_38.buyCost) then
    return 0
  end
  if A1_39 == nil then
    return 0
  end
  if A0_38.buyEnergyType == nil or table.empty(A0_38.buyEnergyType) then
    return 0
  end
  if #A0_38.buyCost < 1 then
  end
  if A1_39 < 0 then
    A1_39 = 0
  end
  if A1_39 > 2 then
    A1_39 = 2
  end
  for _FORV_9_ = 0, math.ceil(A0_38.buyEnergyType[A1_39 + 1] / A0_38.BuyCnt) - 1 do
    if #A0_38.buyCost + _FORV_9_ > #A0_38.buyCost then
    end
  end
  return 0 + A0_38.buyCost[#A0_38.buyCost]
end
function class.GetLeaveBuyTimes(A0_40)
  A0_40:fdbAddBuyTime()
  A0_40.leaveBuyTime = A0_40.addBuyCnt - A0_40.energy.exchangeCount
  return A0_40.leaveBuyTime > 0 and A0_40.leaveBuyTime or 0
end
function class.GetBuyCnt(A0_41)
  local L1_42
  L1_42 = A0_41.BuyCnt
  return L1_42
end
function class.GetFragment(A0_43)
  local L1_44
  L1_44 = A0_43.fragment
  return L1_44
end
function class.GetPrimExchangeLimit(A0_45)
  local L1_46
  L1_46 = A0_45.primExchangeLimit
  return L1_46
end
function class.GetExchangeConfigId(A0_47)
  local L1_48
  L1_48 = A0_47.primExchangeConfigId
  return L1_48
end
function class.GetExchangeNum(A0_49)
  local L1_50
  L1_50 = A0_49.primExchangeNum
  return L1_50
end
function class.GetFullPower(A0_51)
  local L1_52
  L1_52 = A0_51.fullPowerMul
  return L1_52
end
function class.SetChangeGroup(A0_53, A1_54)
  if A1_54 == nil then
    return
  end
  A0_53.changeGroup = A1_54
end
function class.GetChangeGroup(A0_55)
  local L1_56
  L1_56 = A0_55.changeGroup
  return L1_56
end
function class.SetChangeType(A0_57, A1_58)
  A0_57.changeType = A1_58
end
function class.GetChangeType(A0_59)
  local L1_60
  L1_60 = A0_59.changeType
  return L1_60
end
function class.GetBuyTimes(A0_61)
  local L1_62
  L1_62 = A0_61.buyTime
  return L1_62
end
function class.SetEnergy(A0_63, A1_64)
  A0_63.energy = A1_64
  A0_63:initTimer()
end
function class.GetEnergy(A0_65)
  local L1_66
  L1_66 = A0_65.energy
  return L1_66
end
function class.GetFeatsRankTop(A0_67)
  local L1_68
  L1_68 = A0_67.featsRankTop
  return L1_68
end
function class.GetFeatsRankMyRank(A0_69)
  local L1_70
  L1_70 = A0_69.featsRankMyRank
  return L1_70
end
function class.GetDamageRankTop(A0_71)
  local L1_72
  L1_72 = A0_71.maxDamageRankTop
  return L1_72
end
function class.GetDamageRankMyRank(A0_73)
  local L1_74
  L1_74 = A0_73.maxDamageRankMyRank
  return L1_74
end
function class.setEnterType(A0_75, A1_76)
  if A1_76 == nil then
    return
  end
  A0_75.enterType = A1_76
end
function class.getEnterType(A0_77)
  local L1_78
  L1_78 = A0_77.enterType
  return L1_78
end
function class.setDavilData(A0_79, A1_80)
  if A1_80 == nil then
    return
  end
  A0_79.devilData = A1_80
end
function class.getDavilData(A0_81)
  local L1_82
  L1_82 = A0_81.devilData
  return L1_82
end
function class.SetFeat(A0_83, A1_84)
  if A1_84 == nil then
    return
  end
  A0_83.feat = A1_84
end
function class.getFeat(A0_85)
  local L1_86
  L1_86 = A0_85.feat
  return L1_86
end
function class.getRank(A0_87)
  local L1_88
  L1_88 = A0_87.rank
  return L1_88
end
function class.setActiveId(A0_89, A1_90)
  if A1_90 == nil then
    return
  end
  A0_89.activeId = A1_90
end
function class.getActiveId(A0_91)
  local L1_92
  L1_92 = A0_91.activeId
  return L1_92
end
function class.getPersent(A0_93)
  local L1_94
  L1_94 = A0_93.pct
  return L1_94
end
function class.getDevilList(A0_95)
  local L1_96
  L1_96 = A0_95.devilList
  return L1_96
end
function class.getKillList(A0_97)
  local L1_98
  L1_98 = A0_97.killList
  return L1_98
end
function class.getNormalAct(A0_99)
  local L1_100
  L1_100 = A0_99.normalAct
  return L1_100
end
function class.getAllOutAct(A0_101)
  local L1_102
  L1_102 = A0_101.allAct
  return L1_102
end
function class.setIsAllAct(A0_103, A1_104)
  if A1_104 == nil then
    return
  end
  A0_103.isAllAct = A1_104
end
function class.GetIsAllAct(A0_105)
  local L1_106
  L1_106 = A0_105.isAllAct
  return L1_106
end
function class.getActFeat(A0_107)
  local L1_108
  L1_108 = A0_107.actFeat
  return L1_108
end
function class.getActDamage(A0_109)
  local L1_110
  L1_110 = A0_109.damage
  return L1_110
end
function class.getTotalDamageRank(A0_111)
  local L1_112
  L1_112 = A0_111.totalDamageRank
  return L1_112
end
function class.clearTotalDamageData(A0_113)
  A0_113.totalDamageRank = {}
end
function class.isKilled(A0_114)
  local L1_115
  L1_115 = A0_114.isKill
  return L1_115
end
function class.isFriendInvited(A0_116)
  local L1_117
  L1_117 = A0_116.isInvited
  return L1_117
end
function class.setRankType(A0_118, A1_119)
  if A1_119 == nil then
    return
  end
  A0_118.rankType = A1_119
end
function class.getRankType(A0_120)
  local L1_121
  L1_121 = A0_120.rankType
  return L1_121
end
function class.cutFeatsRankData(A0_122)
  local L1_123, L2_124, L3_125, L4_126
  L1_123 = Logic
  L2_124 = L1_123
  L1_123 = L1_123.Get
  L3_125 = "PlayerInfo"
  L1_123 = L1_123(L2_124, L3_125)
  L2_124 = L1_123
  L1_123 = L1_123.GetPlayerName
  L1_123 = L1_123(L2_124)
  L2_124 = {}
  L3_125 = {}
  L4_126 = A0_122.featsRank
  L4_126 = #L4_126
  if L1_123 then
    for _FORV_8_, _FORV_9_ in pairs(A0_122.featsRank) do
      if _FORV_8_ <= 5 then
        table.insert(L2_124, A0_122.featsRank[_FORV_8_])
      end
      if _FORV_9_.name == L1_123 then
        if _FORV_8_ <= 3 then
          for _FORV_13_ = 1, L4_126 do
            table.insert(L3_125, A0_122.featsRank[_FORV_13_])
          end
        else
          for _FORV_13_ = _FORV_8_ - 2, L4_126 do
            table.insert(L3_125, A0_122.featsRank[_FORV_13_])
          end
        end
      end
    end
  end
  A0_122.featsRankTop = L2_124
  A0_122.featsRankMyRank = L3_125
end
function class.cutDamageRankData(A0_127)
  local L1_128, L2_129, L3_130, L4_131
  L1_128 = Logic
  L2_129 = L1_128
  L1_128 = L1_128.Get
  L3_130 = "PlayerInfo"
  L1_128 = L1_128(L2_129, L3_130)
  L2_129 = L1_128
  L1_128 = L1_128.GetPlayerName
  L1_128 = L1_128(L2_129)
  L2_129 = {}
  L3_130 = {}
  L4_131 = A0_127.maxDamageRank
  L4_131 = #L4_131
  if L1_128 then
    for _FORV_8_, _FORV_9_ in pairs(A0_127.maxDamageRank) do
      if _FORV_8_ <= 5 then
        table.insert(L2_129, A0_127.maxDamageRank[_FORV_8_])
      end
      if _FORV_9_.name == L1_128 then
        if _FORV_8_ <= 3 then
          for _FORV_13_ = 1, L4_131 do
            table.insert(L3_130, A0_127.maxDamageRank[_FORV_13_])
          end
        else
          for _FORV_13_ = _FORV_8_ - 2, L4_131 do
            table.insert(L3_130, A0_127.maxDamageRank[_FORV_13_])
          end
        end
      end
    end
  end
  A0_127.maxDamageRankTop = L2_129
  A0_127.maxDamageRankMyRank = L3_130
end
function class.AddEnergy(A0_132, A1_133)
  if A1_133 == nil then
    return
  end
  A0_132.energy = A0_132.energy or {}
  A0_132.energy.point = A1_133.point
  A0_132.energy.refreshTime = A1_133.refreshTime
  A0_132:initTimer()
end
function class.AddFragment(A0_134, A1_135)
  local L2_136
  if A1_135 == nil then
    return
  end
  L2_136 = A0_134.fragment
  L2_136 = L2_136 + A1_135
  A0_134.fragment = L2_136
end
function class.AddFeat(A0_137, A1_138)
  if A1_138 == nil then
    return
  end
  if A0_137.addFeatMarker.day ~= Logic:Get("System"):GetTimeDate().day then
    A0_137.feat = 0
    A0_137.drawReward = {}
  end
  A0_137.addFeatMarker, A0_137.feat = Logic:Get("System"):GetTimeDate(), A0_137.feat + A1_138
end
function class.PostBuyEnergy(A0_139, A1_140)
  if A1_140 == nil then
    return
  end
  A0_139.buyType = A1_140
  MsgDemog:Post("BUY_ENERGY", {type = A1_140})
end
function class.PostAttackDemog(A0_141)
  if A0_141.devilData then
    MsgDemog:Post("ATTACK_DEMOG", {
      demogId = A0_141.devilData.id,
      summoner = A0_141.devilData.summoner,
      allOut = A0_141.isAllAct,
      embattle = Logic:Get("Hero"):GetSendGroupHeros()
    })
  end
end
function class.PostTotalDamageRank(A0_142)
  if A0_142.devilData then
    MsgDemog:Post("TOTAL_DAMAGE_RANK", {
      demogId = A0_142.devilData.id,
      summoner = A0_142.devilData.summoner
    })
  end
end
function class.PostInviteFriendAttack(A0_143)
  if A0_143.devilData then
    MsgDemog:Post("INVITE_FRIEND_ATTACK", {
      demogId = A0_143.devilData.id
    })
  end
end
function class.PostDrawKilledDemogReward(A0_144, A1_145)
  if A1_145 == nil then
    return
  end
  A0_144.drawKillId = A1_145
  MsgDemog:Post("DRAW_KILLED_DEMOG_REWARD", {demogId = A1_145})
end
function class.postDrawFeatReward(A0_146, A1_147)
  if table.empty(A1_147 or {}) then
    return
  end
  A0_146.drawRewardId = A1_147
  MsgDemog:Post("DRAW_FEAT_REWARD", {ids = A1_147})
end
function class.OnActiveInfo(A0_148, A1_149, A2_150)
  if A1_149 == 0 and A2_150 ~= nil then
    A0_148.energy = A2_150.pointValue
    A0_148.reward = A2_150.hasReward
    A0_148.activeId = A2_150.activeId or ""
    A0_148.actLeftTime = A2_150.endTime or 0
    A0_148.feat = A2_150.feat or 0
    A0_148.rank = A2_150.rank or 0
    A0_148.pct = A2_150.pct or 0
    A0_148.drawReward = A2_150.drawReward
    A0_148.rankGroupId = A2_150.rankGroupId
    A0_148.lastAttackDrawNum = A2_150.lastAttackDrawNum
    A0_148.fragment = A2_150.fragment
    A0_148.primExchangeLimit = A2_150.exchangeMap
    A0_148:FireEvent(EVT.PUSH_MAIN_INFO)
  end
end
function class.OnDemogList(A0_151, A1_152, A2_153)
  local L3_154, L4_155, L5_156, L6_157, L7_158
  if A1_152 == 0 then
    if A2_153 ~= nil then
      A0_151.devilList = L3_154
      A0_151.killList = L3_154
      A0_151.devilList = L3_154
      A0_151.killList = L3_154
      for L6_157, L7_158 in L3_154(L4_155) do
        L7_158.killed = false
        A0_151:initData(L7_158)
      end
      L3_154(L4_155)
      for L6_157, L7_158 in L3_154(L4_155) do
        L7_158.killed = true
        A0_151:initData(L7_158)
      end
    end
    L3_154(L4_155, L5_156)
  end
end
function class.OnAttackDemog(A0_159, A1_160, A2_161)
  if A1_160 == 0 and A2_161 ~= nil then
    Logic:Get("Hero"):clearGroupEmbattle()
    A0_159.isAllAct = A2_161.allOut or A0_159.isAllAct
    A0_159.energy.point = A2_161.costResult[1].contents.point
    A0_159.energy.refreshTime = A2_161.costResult[1].contents.refreshTime
    A0_159:initTimer()
    A0_159.damage = A2_161.damage
    if A0_159.devilData and A0_159.devilData.currentHp then
      A0_159.devilData.currentHp = A0_159.devilData.currentHp - A2_161.damage
    end
    A0_159.devilData.attacked = true
    A0_159.actFeat = A2_161.feat
    A0_159:AddFeat(A0_159.actFeat)
    A0_159.pct = A2_161.featRankPct
    A0_159.isKill = A2_161.killed
    A0_159.isInvited = A2_161.shared
    A0_159.groupNum = A2_161.groupNum
    A0_159.luckHeros = A2_161.luckHeros
    A0_159.totalDamageRank = A2_161.rankList
    A0_159.devilGetAllRankTime = 0
    MsgDemog:Post("ALL_RANK")
    Logic:Get("BattleShow"):CleanUp()
    Logic:Get("BattleShow"):SetEnemyCount(1, 3)
    Logic:Get("BattleShow"):SetEnterBattle(true)
    Logic:Get("BattleShow"):SetTotleMultiFightWaves(A2_161.groupNum * A2_161.enemyNum)
    Logic:Get("BattleShow"):SetMultiFightWaves(A2_161.groupNum, A2_161.enemyNum)
    Logic:Get("BattleShow"):SaveMultiFightReport(A2_161.reports)
    Logic:Get("BattleShow"):StartMultiFightReport()
  end
end
function class.OnTotalDamageRank(A0_162, A1_163, A2_164)
  if A1_163 == 0 and A2_164 ~= nil then
    A0_162.totalDamageRank = A2_164
    A0_162:FireEvent(EVT.SHOW_DAMAGE_RANK)
  end
end
function class.OnInviteFriendAttack(A0_165, A1_166, A2_167)
  if A1_166 ~= 0 or A2_167 ~= nil then
  end
end
function class.OnDrawFeatReward(A0_168, A1_169, A2_170)
  local L3_171, L4_172, L5_173, L6_174, L7_175
  if A1_169 ~= 0 or A2_170 == nil then
    if A1_169 == L4_172 then
    elseif A1_169 == L4_172 then
    else
      L6_174 = "MsgAssist"
      L6_174 = "MsgDemog"
      L7_175 = A1_169
      L4_172(L5_173, L6_174, L7_175)
      return
    end
    L6_174 = Logic
    L7_175 = L6_174
    L6_174 = L6_174.Get
    L6_174 = L6_174(L7_175, "Main")
    L7_175 = ""
    L4_172(L5_173, L6_174, L7_175, L3_171, Logic:Get("Main").GotoHomePage, Prompt.PROMPT_TYPE.CONFIRM)
    return
  end
  L3_171(L4_172, L5_173)
  for L6_174, L7_175 in L3_171(L4_172) do
    table.insert(A0_168.drawReward, L7_175)
  end
  L6_174 = L3_171
  L4_172(L5_173, L6_174)
  L6_174 = EVT
  L6_174 = L6_174.UPDATE_REWARD_LIST
  L4_172(L5_173, L6_174)
end
function class.OnDrawKilledDemogReward(A0_176, A1_177, A2_178)
  local L3_179
  if A1_177 == 0 and A2_178 ~= nil then
    L3_179 = A2_178.rank
    L3_179 = L3_179 or A0_176.rank
    A0_176.rank = L3_179
    L3_179 = A0_176.AddFeat
    L3_179(A0_176, A2_178.feat)
    L3_179 = Logic
    L3_179 = L3_179.Get
    L3_179 = L3_179(L3_179, "Reward")
    L3_179 = L3_179.AddRewards
    L3_179(L3_179, A2_178.rewardResults)
    L3_179 = A0_176.FireEvent
    L3_179(A0_176, EVT.UPDATE_DAMOG_LIST, A0_176.drawKillId)
  else
    L3_179 = ""
    if A1_177 == _UPVALUE0_.DEMOG_KILLED_REWARD_NOT_FOUND then
      L3_179 = TwGetStr(105567)
    else
      Logic:Get("MsgAssist"):OnMsgResult("MsgDemog", A1_177)
      return
    end
    Prompt:Confirm(Logic:Get("Main"), "", L3_179, Logic:Get("Main").GotoHomePage, Prompt.PROMPT_TYPE.CONFIRM)
  end
end
function class.OnGetActiveId(A0_180, A1_181, A2_182)
  if A1_181 == 0 and A2_182 ~= nil then
    A0_180.activeId = A2_182
    A0_180.FireEvent(EVT.OPEN_NEW_ACTIVE)
  end
end
function class.OnNewDemog(A0_183)
  A0_183.gotPushDemog = true
  A0_183:FireEvent(EVT.GOT_NEW_DEVIL)
end
function class.OnDemogActiveOpen(A0_184)
  MsgDemog:Post("GET_ACTIVE_ID")
end
function class.OnMaxDamageRank(A0_185, A1_186, A2_187)
  local L3_188
  if A1_186 == 0 and A2_187 ~= nil then
    A0_185.maxDamageRank = A2_187
    L3_188 = table
    L3_188 = L3_188.empty
    L3_188 = L3_188(A0_185.maxDamageRank)
    if not L3_188 then
      function L3_188(A0_189, A1_190)
        if not A0_189 or not A1_190 then
          return false
        end
        return A0_189.rank < A1_190.rank
      end
      table.sort(A0_185.maxDamageRank, L3_188)
    end
    L3_188 = os
    L3_188 = L3_188.time
    L3_188 = L3_188()
    A0_185.requestDamageRankTime = L3_188
    L3_188 = A0_185.cutDamageRankData
    L3_188(A0_185)
    L3_188 = A0_185.FireEvent
    L3_188(A0_185, EVT.GET_MAX_DAMAGE_RANK)
  end
end
function class.OnFeatRank(A0_191, A1_192, A2_193)
  local L3_194
  if A1_192 == 0 and A2_193 ~= nil then
    A0_191.featsRank = A2_193
    L3_194 = table
    L3_194 = L3_194.empty
    L3_194 = L3_194(A0_191.featsRank)
    if not L3_194 then
      function L3_194(A0_195, A1_196)
        if not A0_195 or not A1_196 then
          return false
        end
        return A0_195.rank < A1_196.rank
      end
      table.sort(A0_191.featsRank, L3_194)
    end
    L3_194 = os
    L3_194 = L3_194.time
    L3_194 = L3_194()
    A0_191.requestFeatsRankTime = L3_194
    L3_194 = A0_191.cutFeatsRankData
    L3_194(A0_191)
    L3_194 = A0_191.FireEvent
    L3_194(A0_191, EVT.GET_FEATS_RANK)
  end
end
function class.SendMsgRankGroupInfo(A0_197, A1_198)
  if A1_198 then
    MsgDemog:Post("RANK_GROUP_INFO", {owner = A1_198})
  end
end
function class.OnRankGroupInfo(A0_199, A1_200, A2_201)
  if A1_200 == 0 and A2_201 ~= nil then
    Logic:Get("Hero"):SetRankGroupInfo(A2_201)
    A0_199:FireEvent(EVT.GET_RANK_GROUP_INFO)
    A0_199:FireEvent(EVT.SHOW_GROUP_INFO)
  end
end
function class.SendMsgFragmentExchange(A0_202, A1_203)
  if A1_203 then
    MsgDemog:Post("FRAGMENT_EXCHANGE", {id = A1_203})
  end
end
function class.OnFragmentExchange(A0_204, A1_205, A2_206)
  if A1_205 == 0 and A2_206 ~= nil then
    A0_204.fragment = A2_206.fragment
    A0_204.primExchangeResult = A2_206.rewardResult
    A0_204.primExchangeConfigId = A2_206.configId
    A0_204.primExchangeNum = A2_206.exchangeNum
    Logic:Get("Cost"):AddCosts(A2_206.costResults)
    if A0_204.primExchangeLimit[A0_204.primExchangeConfigId] == nil then
      A0_204.primExchangeLimit[A0_204.primExchangeConfigId] = A0_204.primExchangeNum
    else
      A0_204.primExchangeLimit[A0_204.primExchangeConfigId] = A0_204.primExchangeLimit[A0_204.primExchangeConfigId] + A0_204.primExchangeNum
    end
    if not table.empty(A0_204.primExchangeResult) then
      Logic:Get("Reward"):AddRewards(A0_204.primExchangeResult)
      Logic:Get("WeChat"):FragmentExchange(A2_206.rewardResult)
      A0_204:FireEvent(EVT.EXCHANGE_SUCCESS)
    end
    A0_204:FireEvent(EVT.UPDATE_FRAGMENT_EXCHANGE)
  end
end
function class.OnBuyEnergy(A0_207, A1_208, A2_209)
  if A1_208 == 0 and A2_209 ~= nil then
    Logic:Get("Cost"):AddCosts(A2_209.costs)
    A0_207.energy.point = A2_209.rewards[1].contents.point
    A0_207.energy.refreshTime = A2_209.rewards[1].contents.refreshTime
    if 0 > A0_207.buyType then
      A0_207.buyType = 0
    end
    if A0_207.buyType > #A0_207.buyEnergyType then
      A0_207.buyType = #A0_207.buyEnergyType
    end
    A0_207.energy.exchangeCount = A0_207.energy.exchangeCount + A0_207.buyEnergyType[A0_207.buyType + 1] / A0_207.BuyCnt
    if Logic:Get("Target"):IsActivityOpen() then
      Logic:Get("Target"):PostGetProgress(nil)
    end
    A0_207:FireEvent(EVT.BUY_SUCCESSED)
    Prompt:Msg(TwGetStr(105207))
  end
end
function class.OnRefreshDemog(A0_210, A1_211, A2_212)
  if A1_211 == 0 and A2_212 ~= nil then
    A0_210:setDavilData(A2_212)
    A0_210.activeId = A2_212.activeId or ""
    A0_210:initData(A0_210.devilData)
    A0_210.devilData.killed = false
    A0_210.lastAttackDrawNum = A2_212.lastAttackDrawNum
    table.insert(A0_210.devilList, 1, A0_210.devilData)
    A0_210.enterType = ENTER_TYPE.BATTLE
    A0_210.energy = A2_212.pointValue
    if A2_212.rank then
      A0_210.rank = A2_212.rank or -1
    end
    A0_210.drawReward = A2_212.drawReward or A0_210.drawReward
    A0_210.feat = A2_212.feat or A0_210.feat
    A0_210:initTimer()
    A0_210:FireEvent(EVT.PUSH_DEMOG_INFO)
  end
end
function class.PostAllRank(A0_213)
  if os.time() - A0_213.devilGetAllRankTime > 300 then
    MsgDemog:Post("ALL_RANK")
  end
end
function class.OnAllRank(A0_214, A1_215, A2_216)
  if A1_215 == 0 and A2_216 ~= nil then
    A0_214:setFeatsRank(A2_216)
    A0_214.rank = A2_216.featRank or A0_214.rank
    A0_214.devilGetAllRankTime = os.time()
    A0_214.requestFeatsRankTime = os.time()
    A0_214.requestDamageRankTime = os.time()
    A0_214:FireEvent(EVT.PUSH_FEATS_RANK)
    A0_214:FireEvent(EVT.GET_FEATS_RANK)
    A0_214:FireEvent(EVT.GET_MAX_DAMAGE_RANK)
    A0_214:FireEvent(EVT.PUSH_MAIN_INFO)
  end
end
function class.OnPraiseRank(A0_217, A1_218, A2_219)
  local L3_220
  if A1_218 == 0 and A2_219 ~= nil then
    L3_220 = A2_219.rankList
    A0_217.featsRank = L3_220
    L3_220 = table
    L3_220 = L3_220.empty
    L3_220 = L3_220(A0_217.featsRank)
    if not L3_220 then
      function L3_220(A0_221, A1_222)
        if not A0_221 or not A1_222 then
          return false
        end
        return A0_221.rank < A1_222.rank
      end
      table.sort(A0_217.featsRank, L3_220)
    end
    L3_220 = A0_217.cutFeatsRankData
    L3_220(A0_217)
    L3_220 = A0_217.FireEvent
    L3_220(A0_217, EVT.PRAISE_CHANGE)
    L3_220 = A0_217.FireEvent
    L3_220(A0_217, EVT.GET_FEATS_RANK)
    L3_220 = A2_219.rewardResults
    if L3_220 ~= nil then
      L3_220 = Logic
      L3_220 = L3_220.Get
      L3_220 = L3_220(L3_220, "Reward")
      L3_220 = L3_220.AddRewards
      L3_220(L3_220, A2_219.rewardResults)
      L3_220 = Logic
      L3_220 = L3_220.Get
      L3_220 = L3_220(L3_220, "Reward")
      L3_220 = L3_220.AddRewardsTip
      L3_220 = L3_220(L3_220, A2_219.rewardResults)
      Prompt:Fail(L3_220)
    else
      L3_220 = Prompt
      L3_220 = L3_220.Fail
      L3_220(L3_220, TwGetStr(105579))
    end
  end
end
function class.initTimer(A0_223)
  local L1_224, L2_225
  L1_224 = Logic
  L2_225 = L1_224
  L1_224 = L1_224.Get
  L1_224 = L1_224(L2_225, "System")
  L2_225 = L1_224
  L1_224 = L1_224.GetTime
  L1_224 = L1_224(L2_225)
  L2_225 = A0_223.actLeftTime
  L1_224 = L1_224 + L2_225
  L2_225 = _UPVALUE0_
  L1_224 = L1_224 * L2_225
  A0_223.actTimeMarker = L1_224
  L1_224 = Logic
  L2_225 = L1_224
  L1_224 = L1_224.Get
  L1_224 = L1_224(L2_225, "System")
  L2_225 = L1_224
  L1_224 = L1_224.DiffTime
  L1_224 = L1_224(L2_225, A0_223.actTimeMarker / _UPVALUE0_)
  if L1_224 < 0 then
    L2_225 = Logic
    L2_225 = L2_225.Get
    L2_225 = L2_225(L2_225, "System")
    L2_225 = L2_225.GetTime
    L2_225 = L2_225(L2_225)
    A0_223.actLoseTime = L2_225
  else
    L2_225 = Logic
    L2_225 = L2_225.Get
    L2_225 = L2_225(L2_225, "System")
    L2_225 = L2_225.GetTime
    L2_225 = L2_225(L2_225)
    L2_225 = L2_225 + L1_224
    if not L2_225 then
      L2_225 = Logic
      L2_225 = L2_225.Get
      L2_225 = L2_225(L2_225, "System")
      L2_225 = L2_225.GetTime
      L2_225 = L2_225(L2_225)
      L2_225 = L2_225 + A0_223.actLeftTime
    end
    A0_223.actLoseTime = L2_225
  end
  L2_225 = A0_223.energy
  if L2_225 ~= nil then
    L2_225 = table
    L2_225 = L2_225.empty
    L2_225 = L2_225(A0_223.energy)
    if not L2_225 then
      L2_225 = A0_223.energy
      L2_225 = L2_225.refreshTime
      if L2_225 == nil then
        L2_225 = A0_223.energy
        L2_225.refreshTime = 0
      end
      L2_225 = Logic
      L2_225 = L2_225.Get
      L2_225 = L2_225(L2_225, "System")
      L2_225 = L2_225.DiffTime
      L2_225 = L2_225(L2_225, A0_223.energy.refreshTime / _UPVALUE0_)
      if L2_225 < 0 then
        A0_223.energy.engLostTime = Logic:Get("System"):GetTime() + A0_223.energyRefresh - math.abs(L2_225) % A0_223.energyRefresh
      else
        A0_223.energy.engLostTime = Logic:Get("System"):GetTime() + L2_225
      end
    end
  end
  L2_225 = A0_223.eventTracer
  L2_225 = L2_225.Exist
  L2_225 = L2_225(L2_225, "showPhyWaitTime")
  if not L2_225 then
    L2_225 = Singleton
    L2_225 = L2_225(Timer)
    L2_225 = L2_225.Repeat
    L2_225(L2_225, _UPVALUE0_, A0_223:Event("showPhyWaitTime"))
  end
  L2_225 = A0_223.showPhyWaitTime
  L2_225(A0_223)
end
function class.showPhyWaitTime(A0_226)
  local L1_227, L2_228, L3_229, L4_230, L5_231, L6_232, L7_233, L8_234
  L1_227 = Logic
  L2_228 = L1_227
  L1_227 = L1_227.Get
  L3_229 = "System"
  L1_227 = L1_227(L2_228, L3_229)
  L2_228 = L1_227
  L1_227 = L1_227.DiffTime
  L3_229 = A0_226.actLoseTime
  L1_227 = L1_227(L2_228, L3_229)
  if L1_227 > 0 then
    L2_228 = Logic
    L3_229 = L2_228
    L2_228 = L2_228.Get
    L2_228 = L2_228(L3_229, L4_230)
    L3_229 = L2_228
    L2_228 = L2_228.SecToDay
    L2_228 = L2_228(L3_229, L4_230)
    A0_226.waitTime = L2_228
    L3_229 = A0_226
    L2_228 = A0_226.FireEvent
    L2_228(L3_229, L4_230, L5_231)
  end
  L2_228 = nil
  L3_229 = A0_226.energy
  if L3_229 then
    L3_229 = Logic
    L3_229 = L3_229.Get
    L3_229 = L3_229(L4_230, L5_231)
    L3_229 = L3_229.DiffTime
    L3_229 = L3_229(L4_230, L5_231)
    L2_228 = L3_229
  end
  if L2_228 and L2_228 <= 0 then
    L3_229 = A0_226.energy
    L3_229.engLostTime = L4_230
    L3_229 = KFDBGetRecord
    L3_229 = L3_229(L4_230, L5_231)
    if L3_229 then
    else
    end
    if L4_230 > L5_231 then
      L7_233 = A0_226.recoverEng
      L5_231.point = L6_232
    end
  end
  L3_229 = A0_226.energy
  if L3_229 then
    L3_229 = A0_226.energy
    L6_232 = L2_228 or 0
    L3_229.waitTime = L4_230
    L3_229 = A0_226.FireEvent
    L3_229(L4_230, L5_231)
  end
  L3_229 = table
  L3_229 = L3_229.empty
  L3_229 = L3_229(L4_230)
  if not L3_229 then
    L3_229 = Logic
    L3_229 = L3_229.Get
    L3_229 = L3_229(L4_230, L5_231)
    L3_229 = L3_229.GetTime
    L3_229 = L3_229(L4_230)
    for L7_233 = #L4_230, 1, -1 do
      L8_234 = A0_226.devilList
      L8_234 = L8_234[L7_233]
      L8_234 = L8_234.killed
      if not L8_234 then
        L8_234 = Logic
        L8_234 = L8_234.Get
        L8_234 = L8_234(L8_234, "System")
        L8_234 = L8_234.DiffTime
        L8_234 = L8_234(L8_234, A0_226.devilList[L7_233].loseTime or L3_229)
        A0_226.devilList[L7_233].waitTime = Logic:Get("System"):SecToDay(L8_234)
      end
    end
    L4_230(L5_231, L6_232)
  end
end
function class.checkTimeOut(A0_235, A1_236)
  local L2_237, L3_238, L4_239, L5_240, L6_241, L7_242
  if A1_236 == nil then
    L2_237 = true
    return L2_237
  end
  L2_237 = A1_236.day
  L2_237 = L2_237 or 0
  L3_238 = A1_236.hour
  L3_238 = L3_238 or 0
  L4_239 = A1_236.min
  L4_239 = L4_239 or 0
  L5_240 = A1_236.sec
  L5_240 = L5_240 or 0
  L6_241 = L2_237 + L3_238
  L6_241 = L6_241 + L4_239
  L6_241 = L6_241 + L5_240
  if L6_241 > 0 then
    L7_242 = false
    return L7_242
  else
    L7_242 = true
    return L7_242
  end
end
function class.IsNeedPushAdv(A0_243)
  if A0_243.comBattleId == nil or "" == A0_243.comBattleId then
    return false
  end
  if Logic:Get("Battle"):GetBattleInfoById(A0_243.comBattleId) == nil or Logic:Get("Battle"):GetBattleInfoById(A0_243.comBattleId).demogFirst == nil then
    return false
  end
  if Logic:Get("Battle"):GetBattleInfoById(A0_243.comBattleId).demogFirst == "true" or Logic:Get("Battle"):GetBattleInfoById(A0_243.comBattleId).demogFirst == "TRUE" then
    return true
  end
  return false
end
function class.isEnergyFull(A0_244)
  if A0_244.energy == nil or table.empty(A0_244.energy) then
    return false
  end
  if A0_244.energy.point then
    return A0_244.energy.point >= A0_244.maxEnergy
  end
  return false
end
function class.sortActDevil(A0_245)
  local L1_246
  L1_246 = A0_245.devilList
  if L1_246 ~= nil then
    L1_246 = table
    L1_246 = L1_246.empty
    L1_246 = L1_246(A0_245.devilList)
  elseif L1_246 then
    return
  end
  function L1_246(A0_247, A1_248)
    local L2_249
    if A0_247 and A1_248 then
      L2_249 = Logic
      L2_249 = L2_249.Get
      L2_249 = L2_249(L2_249, "System")
      L2_249 = L2_249.GetTime
      L2_249 = L2_249(L2_249)
      if Logic:Get("System"):DiffTime(A0_247.loseTime or L2_249) > 0 and Logic:Get("System"):DiffTime(A1_248.loseTime or L2_249) > 0 then
        return Logic:Get("PlayerInfo"):GetPlayerName() == A0_247.summonerName and Logic:Get("PlayerInfo"):GetPlayerName() ~= A1_248.summonerName
      elseif Logic:Get("System"):DiffTime(A0_247.loseTime or L2_249) > 0 and Logic:Get("System"):DiffTime(A1_248.loseTime or L2_249) < 0 then
        return true
      elseif Logic:Get("System"):DiffTime(A0_247.loseTime or L2_249) < 0 and Logic:Get("System"):DiffTime(A1_248.loseTime or L2_249) < 0 then
        return Logic:Get("System"):DiffTime(A0_247.loseTime or L2_249) > Logic:Get("System"):DiffTime(A1_248.loseTime or L2_249)
      end
    end
    L2_249 = false
    return L2_249
  end
  table.sort(A0_245.devilList, L1_246)
end
function class.removeUselessData(A0_250)
  local L1_251, L2_252, L3_253, L4_254, L5_255, L6_256, L7_257
  L1_251 = A0_250.devilList
  if L1_251 ~= nil then
    L1_251 = table
    L1_251 = L1_251.empty
    L2_252 = A0_250.devilList
    L1_251 = L1_251(L2_252)
  elseif L1_251 then
    return
  end
  L1_251 = 0
  L2_252 = 0
  L3_253 = A0_250.sortActDevil
  L3_253(L4_254)
  L3_253 = Logic
  L3_253 = L3_253.Get
  L3_253 = L3_253(L4_254, L5_255)
  L3_253 = L3_253.GetTime
  L3_253 = L3_253(L4_254)
  for L7_257, _FORV_8_ in L4_254(L5_255) do
    if 0 > Logic:Get("System"):DiffTime(_FORV_8_.loseTime or L3_253) then
      L1_251 = L1_251 + 1
    end
    if L1_251 >= 6 then
      L2_252 = L7_257
      break
    end
  end
  if L2_252 > 0 then
    for L7_257 = #L4_254, L2_252, -1 do
      table.remove(A0_250.devilList, L7_257)
    end
  end
end
function class.initData(A0_258, A1_259)
  local L2_260, L3_261
  if A1_259 == nil then
    return
  end
  L2_260 = KFDBGetRecord
  L3_261 = "DemogBattleConfig"
  L2_260 = L2_260(L3_261, A1_259.battleId)
  if L2_260 then
    L3_261 = Logic
    L3_261 = L3_261.Get
    L3_261 = L3_261(L3_261, "System")
    L3_261 = L3_261.GetTime
    L3_261 = L3_261(L3_261)
    A1_259.baseId = L2_260.baseId
    L2_260 = Logic:Get("Hero"):GetHeroInfoByBaseId(A1_259.baseId)
    if L2_260 then
      A1_259.name = L2_260.name or ""
      A1_259.loseTime = A1_259.escapeTime and L3_261 + A1_259.escapeTime or L3_261
    end
  end
end
function class.isActiveOver(A0_262)
  return A0_262:checkTimeOut(A0_262.waitTime)
end
function class.GetGroupLeadership(A0_263)
  local L1_264, L2_265, L3_266, L4_267, L5_268
  L1_264 = A0_263.changeGroup
  if L1_264 ~= nil then
    L1_264 = table
    L1_264 = L1_264.empty
    L1_264 = L1_264(L2_265)
  elseif L1_264 then
    L1_264 = -1
    return L1_264
  end
  L1_264 = 0
  if L2_265 ~= L3_266 then
    if L2_265 ~= L3_266 then
      if L2_265 ~= nil then
        L5_268 = "Hero"
        L5_268 = L2_265.baseId
        if L3_266 ~= nil then
          if L4_267 then
            L1_264 = L1_264 + L4_267
          end
        end
      end
    end
  end
  for L5_268, _FORV_6_ in L2_265(L3_266) do
    if Logic:Get("Hero"):GetHeroInfoById(L5_268) ~= nil and Logic:Get("Hero"):GetHeroInfoByBaseId(Logic:Get("Hero"):GetHeroInfoById(L5_268).baseId) ~= nil and Logic:Get("Hero"):GetHeroInfoByBaseId(Logic:Get("Hero"):GetHeroInfoById(L5_268).baseId).leadership then
      L1_264 = L1_264 + Logic:Get("Hero"):GetHeroInfoByBaseId(Logic:Get("Hero"):GetHeroInfoById(L5_268).baseId).leadership
    end
  end
  return L1_264
end
function class.AddGroupTeamerHero(A0_269, A1_270)
  if not A1_270 then
    return
  end
  for _FORV_6_, _FORV_7_ in pairs(A0_269.teamers) do
    if _FORV_6_ == A1_270 then
      break
    end
  end
  if not true then
    A0_269.teamers[A1_270] = true
  end
  Logic:Get("Hero"):FireEvent(EVT.OPT_TEAMER_SELECT, A0_269.teamers)
end
function class.RemoveGroupTeamerHero(A0_271, A1_272)
  if not A1_272 then
    return
  end
  A0_271.teamers[A1_272] = nil
  Logic:Get("Hero"):FireEvent(EVT.OPT_TEAMER_SELECT, A0_271.teamers)
end
function class.GetGroupTeamerHero(A0_273)
  local L1_274
  L1_274 = A0_273.teamers
  return L1_274
end
function class.GetOldTeamerHero(A0_275)
  local L1_276
  L1_276 = A0_275.oldTeamers
  return L1_276
end
function class.CheckGroupHeroState(A0_277, A1_278)
  if not A1_278 then
    return false
  end
  for _FORV_5_, _FORV_6_ in pairs(A0_277.oldTeamers) do
    if _FORV_5_ == A1_278 then
      return true
    end
  end
  return false
end
function class.clearGroupHero(A0_279)
  local L1_280
  L1_280 = {}
  A0_279.teamers = L1_280
  L1_280 = {}
  A0_279.oldTeamers = L1_280
end
function class.InitGroupTeamerHero(A0_281, A1_282)
  if A1_282 == nil then
    return -1
  end
  if A1_282 < 1 or A1_282 > #Logic:Get("Hero"):GetGroups() then
    return -1
  end
  A0_281.teamers = {}
  A0_281.oldTeamers = {}
  for _FORV_6_ = 1, #Logic:Get("Hero"):GetGroups()[A1_282].embattles do
    for _FORV_10_ = 1, #Logic:Get("Hero"):GetGroups()[A1_282].embattles[_FORV_6_] do
      if Logic:Get("Hero"):GetGroups()[A1_282].embattles[_FORV_6_][_FORV_10_] ~= Logic:Get("Hero"):GetGroups()[A1_282].leaderId and Logic:Get("Hero"):GetGroups()[A1_282].embattles[_FORV_6_][_FORV_10_] ~= ID[0] and Logic:Get("Hero"):GetGroups()[A1_282].embattles[_FORV_6_][_FORV_10_] ~= ID[-1] then
        A0_281.teamers[Logic:Get("Hero"):GetGroups()[A1_282].embattles[_FORV_6_][_FORV_10_]] = true
        A0_281.oldTeamers[Logic:Get("Hero"):GetGroups()[A1_282].embattles[_FORV_6_][_FORV_10_]] = true
      end
    end
  end
end
function class.removeDrawFeatReward(A0_283, A1_284)
  local L2_285, L3_286, L4_287, L5_288, L6_289, L7_290, L8_291, L9_292, L10_293
  if L2_285 ~= nil then
    if not L2_285 and A1_284 ~= nil then
    end
  elseif L2_285 then
    return
  end
  for L5_288, L6_289 in L2_285(L3_286) do
    for L10_293 = #A1_284, 1, -1 do
      if A1_284[L10_293].id == L6_289 then
        table.remove(A1_284, L10_293)
      end
    end
  end
end
function class.getRankGroupInfo(A0_294)
  local L1_295
  L1_295 = A0_294.rankGroupInfo
  return L1_295
end
function class.getRankGroupId(A0_296)
  local L1_297
  L1_297 = A0_296.rankGroupId
  return L1_297
end
function class.setIsRankTop(A0_298, A1_299)
  A0_298.isRankTop = A1_299
end
function class.getIsRankTop(A0_300)
  local L1_301
  L1_301 = A0_300.isRankTop
  return L1_301
end
function class.getRequestFeatsRankTime(A0_302)
  local L1_303
  L1_303 = A0_302.requestFeatsRankTime
  return L1_303
end
function class.getRequestDamageRankTime(A0_304)
  local L1_305
  L1_305 = A0_304.requestDamageRankTime
  return L1_305
end
function class.getMyFeatsRank(A0_306)
  local L1_307
  L1_307 = A0_306.myFeatsRank
  return L1_307
end
function class.getMyDamageRank(A0_308)
  local L1_309
  L1_309 = A0_308.myDamageRank
  return L1_309
end
function class.setFeatsRank(A0_310, A1_311)
  local L2_312
  if A1_311 ~= nil then
    L2_312 = next
    L2_312 = L2_312(A1_311)
  elseif L2_312 == nil then
    return
  end
  L2_312 = A1_311.featRankList
  L2_312 = L2_312 or {}
  A0_310.featsRank = L2_312
  L2_312 = A1_311.damageRankList
  L2_312 = L2_312 or {}
  A0_310.maxDamageRank = L2_312
  L2_312 = A1_311.featRank
  A0_310.myFeatsRank = L2_312
  L2_312 = A1_311.damageRank
  A0_310.myDamageRank = L2_312
  function L2_312(A0_313, A1_314)
    if not A0_313 or not A1_314 then
      return false
    end
    return A0_313.rank < A1_314.rank
  end
  if not table.empty(A0_310.featsRank) then
    table.sort(A0_310.featsRank, L2_312)
  end
  A0_310:cutFeatsRankData()
  if not table.empty(A0_310.maxDamageRank) then
    table.sort(A0_310.maxDamageRank, L2_312)
  end
  A0_310:cutDamageRankData()
end
function class.setGuideDevil(A0_315, A1_316)
  A0_315.devilGuideBool = A1_316 or nil
end
function class.isGuideDevil(A0_317, A1_318)
  local L2_319
  L2_319 = A0_317.devilGuideBool
  return L2_319
end
function class.PoseRedCardCompose(A0_320, A1_321)
  MsgDemog:Post("RED_CARD_COMPOSE", {id = A1_321})
end
function class.OnRedCardCompose(A0_322, A1_323, A2_324)
  if A1_323 == 0 then
    Logic:Get("Cost"):CostAndReward(A2_324)
    A0_322:FireEvent(EVT.REFRESH_RED_COM)
  end
end
