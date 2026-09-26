local L0_0
L0_0 = module
L0_0((...), package.seeall)
L0_0 = require
L0_0("SceneHelper")
L0_0 = Logic
L0_0 = L0_0.class
L0_0 = L0_0.subclass
L0_0 = L0_0(L0_0)
class = L0_0
L0_0 = Enum
L0_0 = L0_0(TypeDef("com.eyu.mt.module.hero.facade.HeroResult"))
EVT = Enum({
  "ALL_HEROS",
  "HERO_CURRENT",
  "LEADER_CHANGE",
  "SWALLOW_HERO",
  "EMBATTLE_SET",
  "SELL_HERO",
  "HERO_LOCK",
  "REMOVE_HERO",
  "ADD_HERO",
  "HERO_RESOLVE",
  "RANK_UP",
  "HERO_SKILL_UP",
  "FIGHT_POINT",
  "ADD_LEADERSHIP",
  "HERO_GROUPS",
  "SWITCH_HERO_GROUP",
  "OPT_SWALLOW",
  "OPT_HERO_SALE",
  "OPT_TEAMER_SELECT",
  "OPT_UPGRADEHERO_SET",
  "OPT_SWALLOWHERO_SET",
  "HERO_CHANGE",
  "LOCK_HERO_LIST",
  "UNLOCK_HERO_LIST",
  "ON_RANKUP_MENPAICARD"
})
SORT_CHOICE = Enum({
  "STAR_LOWER",
  "STAR_UPPER",
  "HERO_SWALLOW",
  "HERO_BAG",
  "HERO_SALE",
  "HERO_SKILL",
  "HERO_TEAMER",
  "HERO_SKILL_CARD"
})
HEROIMG_SIZE = Enum({"BIG", "MIDDLE"})
CARD_TYPE = Enum({
  "HERO",
  "TREASURE",
  "SKILL_CARD",
  "COIN_CARD",
  "EXP_CARD",
  "MENPAI_CARD",
  "DUMPLING"
})
CARD_RACE = Enum({
  "XIAN",
  "LING",
  "YAO"
})
PHY_TYPE = {
  "WUSHI",
  "KAIJIA",
  "GONGSHOU",
  "ANQI",
  "ZHANSHEN",
  "MOWANG",
  "TIANBING"
}
MAGIC_TYPE = {
  "CHANSHI",
  "DIFU",
  "JINGANG",
  "DAOFA",
  "JIANXIAN",
  "LONGGONG",
  "YAOSHU"
}
RANK_COLOR = {
  [1] = {
    255,
    255,
    255
  },
  [2] = {
    76,
    171,
    5
  },
  [3] = {
    77,
    173,
    255
  },
  [4] = {
    206,
    36,
    242
  },
  [5] = {
    255,
    255,
    0
  },
  [6] = {
    255,
    134,
    0
  },
  [7] = {
    255,
    0,
    0
  }
}
MAXSWALLOW_NUM = 6
MAX_HEROS_PER_PAGE = 20
function class.initialize(A0_1)
  super.initialize(A0_1)
  Logic:Get("MsgAssist"):RecordErrorMsg("MsgHero", _UPVALUE0_, _UPVALUE1_)
  Logic:Get("BattleShow"):On(Logic.BattleShow.EVT.END, A0_1:Event("OnBattleShowEnd"))
  A0_1.heroInfo = {}
  A0_1.teamers = {}
  A0_1.swallow = {}
  A0_1.sales = {}
  A0_1.tempHeros = {}
  A0_1.sendGroupHeros = {}
  A0_1.embattleArry = {}
  A0_1.heroGroupId = 0
  A0_1.heroUpgradePage = 1
  A0_1.heroSwallowPage = 1
  A0_1.heroUpSkillPage = 1
  A0_1.treasurePage = 1
  A0_1.rankGroupInfo = {}
  A0_1.battleHeroCopy = {}
  A0_1.resCosAndRew = {}
  A0_1.bCurrent = true
  A0_1.leadership = Logic:Get("PlayerInfo"):GetPlayerAllInfo().leadership or 0
  MsgHero:On("ALL_HEROS", A0_1:Event("OnAllHeros"), true)
  MsgHero:On("HERO_CURRENT", A0_1:Event("OnSetHeroCurrent"), true)
  MsgHero:On("CHANGE_LEADER", A0_1:Event("OnChangeLeader"), true)
  MsgHero:On("EMBATTLE", A0_1:Event("OnSetEmbattle"), true)
  MsgHero:On("SWALLOW", A0_1:Event("OnSwallowHero"), false)
  MsgHero:On("SELL_HERO", A0_1:Event("OnSellHero"), true)
  MsgHero:On("CURRENT_SCORE", A0_1:Event("OnGetFightPoint"), true)
  MsgHero:On("SWITCH_HERO_GROUP", A0_1:Event("OnSwitchHeroGroup"), true)
  MsgHero:On("RANK_UP", A0_1:Event("OnRankUp"), false)
  MsgHero:On("RANK_UP_BY_GOLD", A0_1:Event("OnRankUpByGold"), false)
  MsgHero:On("CRUSH_HERO", A0_1:Event("OnCrushHero"), true)
  MsgHero:On("LOCK", A0_1:Event("OnLock"), true)
  MsgHero:On("SKILL_UP", A0_1:Event("OnSkillUp"), true)
  MsgHero:On("EMBATTLE_GROUP", A0_1:Event("OnEmbattleGroup"), true)
  MsgHero:On("SWITCH_GROUP", A0_1:Event("onSwitchGroup"))
  Singleton(NetMgr):On(NetMgr.EVT.FIGHT_POINT, A0_1:Event("OnFightPoint"))
end
function class.CheckAppointLevelCardExist(A0_2, A1_3, A2_4)
  local L3_5, L4_6, L5_7, L6_8, L7_9
  L4_6 = A0_2
  L3_5 = A0_2.GetBattlingHero
  L3_5 = L3_5(L4_6)
  if not L3_5 then
    L4_6 = false
    return L4_6
  end
  L5_7 = A0_2
  L4_6 = A0_2.GetHeroInfosByIds
  L6_8 = L3_5
  L4_6 = L4_6(L5_7, L6_8)
  if not L4_6 then
    L5_7 = false
    return L5_7
  end
  L5_7 = false
  L6_8 = 0
  L7_9 = 0
  for _FORV_11_ = 1, #L4_6 do
    if A1_3 <= L4_6[_FORV_11_].level then
      L5_7 = true
      L6_8 = L6_8 + 1
    end
    if A2_4 and A0_2:GetHeroInfoByBaseId(L4_6[_FORV_11_].baseId) and A2_4 <= A0_2:GetHeroInfoByBaseId(L4_6[_FORV_11_].baseId).star then
      L7_9 = L7_9 + 1
    end
  end
  return L5_7, L6_8, L7_9
end
function class.GetLeaderId(A0_10)
  local L1_11, L2_12
  L1_11 = A0_10.group
  if L1_11 then
    L1_11 = A0_10.group
    L1_11 = L1_11.groups
    if L1_11 then
      L1_11 = A0_10.group
      L1_11 = L1_11.groups
      L2_12 = A0_10.group
      L2_12 = L2_12.curGroupId
      L1_11 = L1_11[L2_12]
      if L1_11 then
        L1_11 = A0_10.group
        L1_11 = L1_11.groups
        L2_12 = A0_10.group
        L2_12 = L2_12.curGroupId
        L1_11 = L1_11[L2_12]
        L1_11 = L1_11.leaderId
        return L1_11
      end
    end
  end
end
function class.GetGroupLeaderId(A0_13, A1_14)
  local L2_15
  if A1_14 ~= nil and not (A1_14 < 1) then
    L2_15 = A0_13.group
    L2_15 = L2_15.groups
    L2_15 = #L2_15
  elseif A1_14 > L2_15 then
    return
  end
  L2_15 = A0_13.group
  L2_15 = L2_15.groups
  L2_15 = L2_15[A1_14]
  L2_15 = L2_15.leaderId
  return L2_15
end
function class.OnFightPoint(A0_16)
  A0_16:PostGetFightPoint()
end
function class.GetImageByType(A0_17, A1_18)
  local L2_19
  if A1_18 == "TREASURE" then
    L2_19 = "images/Other/type_fa.png"
    return L2_19
  elseif A1_18 == "SKILL_CARD" then
    L2_19 = "images/Other/type_ji.png"
    return L2_19
  end
  L2_19 = "images/Other/type_fa.png"
  return L2_19
end
function class.GetCardTypeById(A0_20, A1_21)
  if not A0_20.heroInfo.heros[A1_21] then
    return
  end
  if A0_20:GetHeroInfoByBaseId(A0_20.heroInfo.heros[A1_21].baseId) then
    return A0_20:GetHeroInfoByBaseId(A0_20.heroInfo.heros[A1_21].baseId).card
  end
end
function class.CheckHeroBattleOrGroup(A0_22, A1_23)
  if not A1_23 then
    return false
  end
  if A0_22:CheckHeroState(A1_23) then
    return true
  end
  if not A0_22.group or not A0_22.group.groups then
    return false
  end
  for _FORV_5_ = 1, #A0_22.group.groups do
    for _FORV_9_ = 1, #A0_22.group.groups[_FORV_5_].embattles do
      for _FORV_13_ = 1, #A0_22.group.groups[_FORV_5_].embattles[_FORV_9_] do
        if A1_23 == A0_22.group.groups[_FORV_5_].embattles[_FORV_9_][_FORV_13_] then
          A0_22.heroGroupId = _FORV_5_
          return true
        end
      end
    end
  end
  return _FOR_
end
function class.CheckHeroState(A0_24, A1_25)
  if not A1_25 then
    return false
  end
  if not A0_24:GetCurrentEmbattle() then
    return false
  end
  for _FORV_6_ = 1, #A0_24:GetCurrentEmbattle() do
    for _FORV_10_ = 1, #A0_24:GetCurrentEmbattle()[_FORV_6_] do
      if A0_24:GetCurrentEmbattle()[_FORV_6_][_FORV_10_] == A1_25 then
        A0_24.heroGroupId = 1
        return true
      end
    end
  end
  return _FOR_
end
function class.GetTotalCoinCard(A0_26)
  return A0_26:GetCardByType("COIN_CARD")
end
function class.GetTotalSkillCard(A0_27)
  return A0_27:GetCardByType("SKILL_CARD")
end
function class.GetTotalExpCard(A0_28)
  return A0_28:GetCardByType("EXP_CARD")
end
function class.GetTotalTreasureId(A0_29)
  return A0_29:GetCardByType("TREASURE")
end
function class.GetTotalHeroId(A0_30)
  return A0_30:GetCardByType("HERO")
end
function class.GetMenpaiCard(A0_31)
  return A0_31:GetCardByType("MENPAI_CARD")
end
function class.GetDumplingCard(A0_32)
  return A0_32:GetCardByType("DUMPLING")
end
function class.GetCardByType(A0_33, A1_34)
  local L2_35, L3_36
  L3_36 = A0_33
  L2_35 = A0_33.GetHeroTableFromMap
  L2_35 = L2_35(L3_36, A0_33.heroInfo.heros)
  if not L2_35 then
    return
  end
  L3_36 = {}
  for _FORV_7_ = 1, #L2_35 do
    if A0_33:GetHeroInfoByBaseId(A0_33.heroInfo.heros[L2_35[_FORV_7_]].baseId) and A0_33:GetHeroInfoByBaseId(A0_33.heroInfo.heros[L2_35[_FORV_7_]].baseId).card and A0_33:GetHeroInfoByBaseId(A0_33.heroInfo.heros[L2_35[_FORV_7_]].baseId).card == A1_34 then
      table.insert(L3_36, L2_35[_FORV_7_])
    end
  end
  return L3_36
end
function class.GetCardNumber(A0_37)
  return #A0_37:GetHeroTableFromMap()
end
function class.GetTotalCardByBaseId(A0_38, A1_39)
  local L2_40, L3_41
  if not A1_39 then
    return
  end
  L3_41 = A0_38
  L2_40 = A0_38.GetHeroTableFromMap
  L2_40 = L2_40(L3_41, A0_38.heroInfo.heros)
  if not L2_40 then
    return
  end
  L3_41 = {}
  for _FORV_7_ = 1, #L2_40 do
    if A0_38.heroInfo.heros[L2_40[_FORV_7_]] and A0_38.heroInfo.heros[L2_40[_FORV_7_]].baseId == A1_39 then
      table.insert(L3_41, L2_40[_FORV_7_])
    end
  end
  return L3_41
end
function class.AddLeadership(A0_42, A1_43, A2_44)
  if not A1_43 or type(A1_43) ~= "number" then
    return
  end
  if A2_44 then
    A0_42.leadership = A1_43
  else
    A0_42.leadership = A0_42.leadership + A1_43
  end
  A0_42:FireEvent(EVT.ADD_LEADERSHIP)
end
function class.AddCard(A0_45, A1_46)
  if not A1_46 or not A1_46.id then
    return
  end
  A0_45.heroInfo.heros[A1_46.id] = A1_46
  A0_45:FireEvent(EVT.ALL_HEROS)
  A0_45:FireEvent(EVT.ADD_HERO)
  A0_45:FireEvent(EVT.HERO_CHANGE)
end
function class.RemoveCard(A0_47, A1_48)
  if not A1_48 then
    return
  end
  if A0_47.heroInfo.heros[A1_48] then
    A0_47.heroInfo.heros[A1_48] = nil
  end
  A0_47:FireEvent(EVT.ALL_HEROS)
  A0_47:FireEvent(EVT.REMOVE_HERO)
end
function class.GetFragmentHero(A0_49)
  local L1_50, L2_51
  L2_51 = A0_49
  L1_50 = A0_49.GetHeroTableFromMap
  L1_50 = L1_50(L2_51)
  if not L1_50 then
    return
  end
  L2_51 = {}
  for _FORV_9_ = 1, #L1_50 do
    if A0_49:GetHeroInfoById(L1_50[_FORV_9_]) and A0_49:GetHeroInfoByBaseId(A0_49:GetHeroInfoById(L1_50[_FORV_9_]).baseId) and A0_49:GetHeroInfoByBaseId(A0_49:GetHeroInfoById(L1_50[_FORV_9_]).baseId).fragment > 0 then
      table.insert(L2_51, L1_50[_FORV_9_])
      if A0_49:GetHeroInfoById(L1_50[_FORV_9_]).locked then
        ({})[L1_50[_FORV_9_]] = 1
      end
      if L1_50[_FORV_9_] == Logic:Get("Hero"):GetLeaderId() then
        ({})[L1_50[_FORV_9_]] = 2
      end
      for _FORV_15_ = 1, #Logic:Get("Hero"):GetAllFightHero() do
        if Logic:Get("Hero"):GetAllFightHero()[_FORV_15_] == L1_50[_FORV_9_] then
          ({})[L1_50[_FORV_9_]] = 2
        end
      end
      if ({})[_FOR_] == nil then
        ({})[L1_50[_FORV_9_]] = 3
      end
    end
  end
  _FOR_.sort(L2_51, function(A0_52, A1_53)
    local L2_54, L3_55, L4_56
    L2_54 = _UPVALUE0_
    L2_54 = L2_54[A0_52]
    L3_55 = _UPVALUE0_
    L3_55 = L3_55[A1_53]
    L4_56 = L2_54 > L3_55
    return L4_56
  end)
  return L2_51
end
function class.SetPackExtendLimit(A0_57, A1_58)
  A0_57.heroInfo.extendLimit = A1_58
end
function class.GetTotalExtendLimit(A0_59, A1_60)
  local L2_61
  L2_61 = A1_60 or L2_61(L2_61)
  if not A0_59:GetLevelConfig(L2_61) then
    return
  end
  if A0_59:GetLevelConfig(L2_61).packSize and A0_59.heroInfo.extendLimit then
    return A0_59:GetLevelConfig(L2_61).packSize + A0_59.heroInfo.extendLimit
  end
end
function class.getEvolutionHeroByType(A0_62, A1_63, A2_64)
  local L3_65, L4_66, L5_67, L6_68, L7_69, L8_70, L9_71
  L3_65 = {}
  for L7_69 = 1, #A1_63 do
    L9_71 = A0_62
    L8_70 = A0_62.GetHeroInfoById
    L8_70 = L8_70(L9_71, A1_63[L7_69])
    if L8_70 then
      L9_71 = A0_62.GetHeroInfoByBaseId
      L9_71 = L9_71(A0_62, L8_70.baseId)
      if L9_71 and L9_71.nextId and L9_71.nextId ~= 0 and L9_71.nextId ~= -1 then
        L8_70.cardInfo = L9_71
        L8_70.evolutionType = Logic:Get("ExplainEquip"):AnalyseCondition(L8_70, L9_71)
        if A2_64 then
          if nil ~= KFDBGetRecord("BaseHero", L8_70.baseId) and KFDBGetRecord("BaseHero", L8_70.baseId).costGold ~= 0 then
            table.insert(L3_65, L8_70)
          end
        else
          table.insert(L3_65, L8_70)
        end
      end
    end
  end
  return L3_65
end
function class.GetEvolutionHero(A0_72)
  local L1_73, L2_74, L3_75, L4_76, L5_77, L6_78, L7_79, L8_80
  L1_73 = {}
  L3_75 = A0_72
  L2_74 = A0_72.GetTotalHeroId
  L2_74 = L2_74(L3_75)
  L2_74 = L2_74 or {}
  L3_75 = A0_72.GetTotalExpCard
  L3_75 = L3_75(L4_76)
  L3_75 = L3_75 or {}
  for L7_79, L8_80 in L4_76(L5_77) do
    table.insert(L2_74, L8_80)
  end
  for L8_80 = 1, #L4_76 do
    if A0_72:GetHeroInfoById(L4_76[L8_80]) and _UPVALUE0_[A0_72:GetHeroInfoById(L4_76[L8_80]).baseId] then
      table.insert(L2_74, L4_76[L8_80])
    end
  end
  if not L2_74 then
    return
  end
  if L5_77 == L6_78 then
    L8_80 = true
    L1_73 = L5_77
  else
    L8_80 = false
    L1_73 = L5_77
  end
  return L1_73
end
function class.GetFightingPoints(A0_81)
  return A0_81.heroInfo.score
end
function class.GetBattlingLeadership(A0_82)
  if not A0_82:GetBattlingHero() then
    return 0
  end
  for _FORV_6_ = 1, #A0_82:GetBattlingHero() do
    if A0_82:GetHeroInfoByBaseId(A0_82.heroInfo.heros[A0_82:GetBattlingHero()[_FORV_6_]].baseId) then
    end
  end
  return 0 + A0_82:GetHeroInfoByBaseId(A0_82.heroInfo.heros[A0_82:GetBattlingHero()[_FORV_6_]].baseId).leadership
end
function class.GetLeadershipByGroupId(A0_83, A1_84)
  local L2_85
  if A1_84 == 0 then
    L2_85 = 0
    return L2_85
  end
  L2_85 = A0_83.GetGroupEmbattle
  L2_85 = L2_85(A0_83, A1_84)
  if L2_85 == nil or next(L2_85) == nil then
    return 0
  end
  for _FORV_7_ = 1, #L2_85 do
    for _FORV_11_ = 1, #L2_85[_FORV_7_] do
      if L2_85[_FORV_7_][_FORV_11_] ~= ID[0] and L2_85[_FORV_7_][_FORV_11_] ~= ID[-1] and A0_83:GetHeroInfoByBaseId(A0_83.heroInfo.heros[L2_85[_FORV_7_][_FORV_11_]].baseId) then
      end
    end
  end
  return 0 + A0_83:GetHeroInfoByBaseId(A0_83.heroInfo.heros[L2_85[_FORV_7_][_FORV_11_]].baseId).leadership
end
function class.GetAllGroupLeadership(A0_86)
  local L1_87, L2_88, L3_89, L4_90, L5_91, L6_92
  L2_88 = A0_86
  L1_87 = A0_86.GetGroups
  L1_87 = L1_87(L2_88)
  L1_87 = L1_87 or {}
  L2_88 = 0
  for L6_92 = 1, #L1_87 do
    L2_88 = L2_88 + A0_86:GetLeadershipByGroupId(L6_92)
  end
  return L2_88
end
function class.GetHeroImage(A0_93, A1_94, A2_95)
  local L3_96
  L3_96 = A2_95 or L3_96.MIDDLE
  if not A0_93:GetRoleSkin(A1_94) then
    return
  end
  if L3_96 == HEROIMG_SIZE.MIDDLE then
    return A0_93:GetRoleSkin(A1_94).MiddleCard
  elseif L3_96 == HEROIMG_SIZE.BIG then
    return A0_93:GetRoleSkin(A1_94).BigCard
  end
end
function class.GetHeroProfessionImage(A0_97, A1_98)
  if not A0_97:GetHeroInfoByBaseId(A1_98) then
    return
  end
  return string.format("data/profession/%s.png", A0_97:GetHeroInfoByBaseId(A1_98).type)
end
function class.GetHeroBgImage(A0_99, A1_100, A2_101, A3_102)
  local L4_103, L5_104, L6_105, L7_106, L8_107, L9_108
  L4_103 = A2_101 or L4_103.MIDDLE
  L6_105 = A0_99
  L5_104 = A0_99.GetHeroInfoByBaseId
  L7_106 = A1_100
  L5_104 = L5_104(L6_105, L7_106)
  if not L5_104 then
    L6_105, L7_106 = nil, nil
    return L6_105, L7_106
  end
  L6_105 = L5_104.rank
  if L6_105 == nil then
    L6_105, L7_106 = nil, nil
    return L6_105, L7_106
  end
  L6_105 = 7
  L7_106 = L5_104.rank
  if L7_106 <= 0 then
    L7_106 = 1
  elseif L6_105 < L7_106 then
    L8_107 = log4misc
    L9_108 = L8_107
    L8_107 = L8_107.warn
    L8_107(L9_108, "Logic.Hero.GetHeroBgImage,baseId:" .. A1_100 .. ":,Rank:" .. L7_106)
    L7_106 = L6_105
  end
  L8_107 = L5_104.star
  if L8_107 > 12 then
    L8_107 = 1
  end
  L9_108 = ""
  if L4_103 == HEROIMG_SIZE.MIDDLE and A3_102 then
    return string.format("data/MiddleBg/captain_%d.png", L7_106)
  elseif L4_103 == HEROIMG_SIZE.MIDDLE then
    if L8_107 == 0 then
      L9_108 = "images/public/clarity80.png"
    else
      L9_108 = string.format("data/star/%d.png", L8_107)
    end
    return string.format("data/MiddleBg/%d.png", L7_106), L9_108
  elseif L4_103 == HEROIMG_SIZE.BIG then
    if L8_107 == 0 then
      L9_108 = "images/public/clarity80.png"
    else
      L9_108 = string.format("data/star/%d.png", L8_107)
    end
    return string.format("data/BigBg/%d.png", L7_106), L9_108
  else
    return nil, nil
  end
end
function class.GetAllHeroInfo(A0_109)
  local L1_110
  L1_110 = A0_109.heroInfo
  return L1_110
end
function class.GetHeroInfoById(A0_111, A1_112)
  local L2_113
  if not A1_112 then
    return
  end
  L2_113 = A0_111.heroInfo
  L2_113 = L2_113.heros
  L2_113 = L2_113[A1_112]
  return L2_113
end
function class.GetHeroInfosByIds(A0_114, A1_115)
  local L2_116, L4_117, L5_118, L6_119
  L2_116 = {}
  if A1_115 then
  elseif L4_117 == 0 then
    return L2_116
  end
  for _FORV_6_ = 1, #A1_115 do
    if A0_114.heroInfo.heros[A1_115[_FORV_6_]] then
      table.insert(L2_116, A0_114.heroInfo.heros[A1_115[_FORV_6_]])
    end
  end
  return L2_116
end
function class.GetBattlingHero(A0_120)
  local L1_121
  L1_121 = {}
  if A0_120:GetCurrentEmbattle() and #A0_120:GetCurrentEmbattle() ~= 0 then
    for _FORV_6_ = 1, #A0_120:GetCurrentEmbattle() do
      for _FORV_10_ = 1, #A0_120:GetCurrentEmbattle()[_FORV_6_] do
        if A0_120:GetCurrentEmbattle()[_FORV_6_][_FORV_10_] ~= ID[0] and A0_120:GetCurrentEmbattle()[_FORV_6_][_FORV_10_] ~= ID[-1] and A0_120.heroInfo.heros[A0_120:GetCurrentEmbattle()[_FORV_6_][_FORV_10_]] then
          table.insert(L1_121, A0_120:GetCurrentEmbattle()[_FORV_6_][_FORV_10_])
        end
      end
    end
  end
  return L1_121
end
function class.GetUnbattlingHero(A0_122, A1_123, A2_124)
  local L3_125, L4_126, L5_127, L6_128, L7_129, L8_130, L9_131
  L3_125 = true
  if A1_123 ~= nil then
    L3_125 = A1_123
  end
  L4_126 = {}
  L5_127 = A0_122.GetBattlingHero
  L5_127 = L5_127(L6_128)
  for L9_131, _FORV_10_ in L6_128(L7_129) do
    if A2_124 == nil or A2_124 == false then
      if _FORV_10_.locked == false then
        if L3_125 then
          if A0_122:GetHeroInfoByBaseId(_FORV_10_.baseId) and A0_122:GetHeroInfoByBaseId(_FORV_10_.baseId).card and A0_122:GetHeroInfoByBaseId(_FORV_10_.baseId).card == "HERO" then
            for _FORV_16_ = 1, #L5_127 do
              if L5_127[_FORV_16_] == L9_131 then
                break
              end
            end
            if not true then
              table.insert(L4_126, L9_131)
            end
          end
        else
          for _FORV_15_ = 1, #L5_127 do
            if L5_127[_FORV_15_] == L9_131 then
              break
            end
          end
          if not true then
            table.insert(L4_126, L9_131)
          end
        end
      end
    elseif L3_125 then
      if A0_122:GetHeroInfoByBaseId(_FORV_10_.baseId) and A0_122:GetHeroInfoByBaseId(_FORV_10_.baseId).card and A0_122:GetHeroInfoByBaseId(_FORV_10_.baseId).card == "HERO" then
        for _FORV_16_ = 1, #L5_127 do
          if L5_127[_FORV_16_] == L9_131 then
            break
          end
        end
        if not true then
          table.insert(L4_126, L9_131)
        end
      end
    else
      for _FORV_15_ = 1, #L5_127 do
        if L5_127[_FORV_15_] == L9_131 then
          break
        end
      end
      if not true then
        table.insert(L4_126, L9_131)
      end
    end
  end
  if L7_129 then
    if L7_129 then
      for _FORV_10_ = 1, #L8_130 do
        if A0_122.group.groups[_FORV_10_] and A0_122.group.groups[_FORV_10_].embattles then
          for _FORV_14_ = 1, #A0_122.group.groups[_FORV_10_].embattles do
            for _FORV_18_ = 1, #A0_122.group.groups[_FORV_10_].embattles[_FORV_14_] do
              if A0_122.group.groups[_FORV_10_].embattles[_FORV_14_][_FORV_18_] ~= ID[0] and A0_122.group.groups[_FORV_10_].embattles[_FORV_14_][_FORV_18_] ~= ID[-1] then
                table.insert(L6_128, A0_122.group.groups[_FORV_10_].embattles[_FORV_14_][_FORV_18_])
              end
            end
          end
        end
      end
    end
  end
  if L7_129 ~= 0 then
    for _FORV_11_ = 1, #L4_126 do
      for _FORV_16_ = 1, #L6_128 do
      end
      if not true then
        table.insert(L7_129, L4_126[_FORV_11_])
      end
    end
    return L7_129
  else
    return L4_126
  end
end
function class.OnLoginHeroInfo(A0_132, A1_133)
  if not A1_133 then
    return
  end
  A0_132.heroInfo = A1_133
  A0_132:CreateHeroMapTable(A0_132.heroInfo.heros)
  if A0_132:GetBattlingHero() then
    for _FORV_6_ = 1, #A0_132:GetBattlingHero() do
      A0_132.teamers[A0_132:GetBattlingHero()[_FORV_6_]] = true
    end
  end
end
function class.SetGroupInfo(A0_134, A1_135)
  if not A1_135 then
    return
  end
  A0_134.group = A1_135
end
function class.CreateHeroMapTable(A0_136, A1_137)
  local L2_138
  if not A1_137 then
    return
  end
  L2_138 = {}
  for _FORV_6_, _FORV_7_ in pairs(A1_137) do
    L2_138[_FORV_7_.id] = _FORV_7_
  end
  A0_136.heroInfo.heros = L2_138
end
function class.GetHeroTableFromMap(A0_139, A1_140)
  local L2_141, L3_142
  L2_141 = A1_140 or L2_141.heros
  if not L2_141 then
    return
  end
  L3_142 = {}
  for _FORV_7_, _FORV_8_ in pairs(L2_141) do
    if _FORV_8_.id then
      table.insert(L3_142, _FORV_8_.id)
    end
  end
  return L3_142
end
function class.AddTeamerHero(A0_143, A1_144)
  if not A1_144 then
    return
  end
  for _FORV_6_, _FORV_7_ in pairs(A0_143.teamers) do
    if _FORV_6_ == A1_144 then
      break
    end
  end
  if not true then
    A0_143.teamers[A1_144] = true
  end
  A0_143:FireEvent(EVT.OPT_TEAMER_SELECT, A0_143.teamers)
end
function class.RemoveTeamerHero(A0_145, A1_146)
  if not A1_146 then
    return
  end
  A0_145.teamers[A1_146] = nil
  A0_145:FireEvent(EVT.OPT_TEAMER_SELECT, A0_145.teamers)
end
function class.GetTeamerHero(A0_147)
  local L1_148
  L1_148 = A0_147.teamers
  return L1_148
end
function class.InitTeamerHero(A0_149)
  A0_149.teamers = {}
  if A0_149:GetBattlingHero() then
    for _FORV_5_ = 1, #A0_149:GetBattlingHero() do
      A0_149.teamers[A0_149:GetBattlingHero()[_FORV_5_]] = true
    end
  end
end
function class.AddSwallowHero(A0_150, A1_151)
  if not A1_151 then
    return
  end
  for _FORV_6_, _FORV_7_ in pairs(A0_150.tempHeros) do
  end
  if not true then
    A0_150.tempHeros[A1_151] = true
  end
  A0_150:FireEvent(EVT.OPT_SWALLOW, A0_150.tempHeros)
end
function class.RemoveSwallowHero(A0_152, A1_153)
  if not A1_153 then
    return
  end
  A0_152.tempHeros[A1_153] = nil
  A0_152:FireEvent(EVT.OPT_SWALLOW, A0_152.tempHeros)
end
function class.ClearSwallowHero(A0_154)
  local L1_155
  L1_155 = {}
  A0_154.swallow = L1_155
  L1_155 = {}
  A0_154.tempHeros = L1_155
end
function class.GetTempHero(A0_156)
  local L1_157
  L1_157 = A0_156.tempHeros
  return L1_157
end
function class.GetSwallowHero(A0_158)
  local L1_159
  L1_159 = A0_158.swallow
  return L1_159
end
function class.SwapHero(A0_160, A1_161)
  if A1_161 then
    A0_160.tempHeros = table.clone(A0_160.swallow)
  else
    A0_160.swallow = table.clone(A0_160.tempHeros)
  end
end
function class.upgradeHeroFullExp(A0_162, A1_163)
  local L2_164, L3_165, L4_166, L5_167, L6_168, L7_169
  L2_164 = 0
  L3_165 = A0_162.GetHeroInfoByBaseId
  L3_165 = L3_165(L4_166, L5_167)
  if L3_165 then
    if L4_166 then
      if L4_166 >= L5_167 then
        for L7_169 = A1_163.level, L5_167 - 1 do
          if A0_162:GetHeroNextExp(A1_163.baseId, L7_169) then
            L2_164 = L2_164 + A0_162:GetHeroNextExp(A1_163.baseId, L7_169)
          end
        end
        L2_164 = L2_164 - L4_166
      end
    end
  end
  return L2_164
end
function class.AllSwallowHeroExp(A0_170)
  local L1_171, L2_172, L3_173, L4_174, L5_175, L6_176, L7_177, L8_178
  L1_171 = 0
  L2_172 = next
  L2_172 = L2_172(L3_173)
  if L2_172 ~= nil then
    L2_172 = {}
    for L6_176, L7_177 in L3_173(L4_174) do
      if L7_177 then
        L8_178 = A0_170.GetHeroInfoById
        L8_178 = L8_178(A0_170, L6_176)
        if L8_178 then
          table.insert(L2_172, L8_178)
        end
      end
    end
    if L2_172 then
      for L6_176, L7_177 in L3_173(L4_174) do
        L8_178 = L7_177.baseId
        L1_171 = L8_178 and (L8_178 or 0)
      end
    end
  end
  return L1_171
end
function class.AddSaleHero(A0_179, A1_180, A2_181)
  if not A1_180 then
    return
  end
  A0_179.sales[A1_180] = true
  if not A2_181 then
    A0_179:FireEvent(EVT.OPT_HERO_SALE)
  end
end
function class.RemoveSaleHero(A0_182, A1_183, A2_184)
  if not A1_183 then
    return
  end
  A0_182.sales[A1_183] = nil
  if not A2_184 then
    A0_182:FireEvent(EVT.OPT_HERO_SALE)
  end
end
function class.ClearSaleHero(A0_185)
  A0_185.sales = {}
end
function class.GetSaleHero(A0_186)
  local L1_187
  L1_187 = A0_186.sales
  return L1_187
end
function class.SetUpgradeHero(A0_188, A1_189)
  A0_188.upgradeHeroId = A1_189
  A0_188:FireEvent(EVT.OPT_UPGRADEHERO_SET)
end
function class.ClearUpgradeHero(A0_190)
  local L1_191
  A0_190.upgradeHeroId = nil
end
function class.GetUpgradeHero(A0_192)
  local L1_193
  L1_193 = A0_192.upgradeHeroId
  return L1_193
end
function class.SortHerosByChoice(A0_194, A1_195, A2_196, A3_197)
  local L4_198, L5_199, L6_200, L7_201, L8_202, L9_203
  if not A1_195 then
    return
  end
  L4_198 = A3_197 or false
  L5_199 = SORT_CHOICE
  L5_199 = L5_199.STAR_LOWER
  if A2_196 == L5_199 then
    L5_199 = table
    L5_199 = L5_199.sort
    L5_199(L6_200, L7_201)
  else
    L5_199 = SORT_CHOICE
    L5_199 = L5_199.STAR_UPPER
    if A2_196 == L5_199 then
      L5_199 = table
      L5_199 = L5_199.sort
      L5_199(L6_200, L7_201)
    else
      L5_199 = SORT_CHOICE
      L5_199 = L5_199.HERO_SWALLOW
      if A2_196 == L5_199 then
        L5_199 = table
        L5_199 = L5_199.sort
        L5_199(L6_200, L7_201)
      else
        L5_199 = SORT_CHOICE
        L5_199 = L5_199.HERO_BAG
        if A2_196 == L5_199 then
          L5_199 = table
          L5_199 = L5_199.sort
          L5_199(L6_200, L7_201)
        else
          L5_199 = SORT_CHOICE
          L5_199 = L5_199.HERO_SALE
          if A2_196 == L5_199 then
            L5_199 = table
            L5_199 = L5_199.sort
            L5_199(L6_200, L7_201)
          else
            L5_199 = SORT_CHOICE
            L5_199 = L5_199.HERO_SKILL
            if A2_196 == L5_199 then
              L5_199 = table
              L5_199 = L5_199.sort
              L5_199(L6_200, L7_201)
            else
              L5_199 = SORT_CHOICE
              L5_199 = L5_199.HERO_SKILL_CARD
              if A2_196 == L5_199 then
                L5_199 = table
                L5_199 = L5_199.sort
                L5_199(L6_200, L7_201)
              else
                L5_199 = SORT_CHOICE
                L5_199 = L5_199.HERO_TEAMER
                if A2_196 == L5_199 then
                  L5_199 = table
                  L5_199 = L5_199.sort
                  L5_199(L6_200, L7_201)
                end
              end
            end
          end
        end
      end
    end
  end
  if L4_198 then
    L5_199 = {}
    if L6_200 then
      for L9_203 = 1, #A1_195 do
        if A0_194.group and A0_194.group.groups[A0_194.group.curGroupId] and A1_195[L9_203].id == A0_194.group.groups[A0_194.group.curGroupId].leaderId then
          L5_199 = A1_195[L9_203]
          table.remove(A1_195, L9_203)
          break
        end
      end
      L9_203 = L5_199
      L6_200(L7_201, L8_202, L9_203)
    end
  end
end
function class.SetFriendInfo(A0_204, A1_205)
  A0_204.friend = A1_205
end
function class.GetFriendInfo(A0_206)
  local L1_207
  L1_207 = A0_206.friend
  return L1_207
end
function class.EnsureHelperPosition(A0_208)
  local L1_209, L2_210, L3_211, L4_212, L5_213, L6_214, L7_215, L8_216, L9_217, L10_218, L11_219
  L2_210 = A0_208
  L1_209 = A0_208.GetCurrentEmbattle
  L1_209 = L1_209(L2_210)
  if L1_209 == nil then
    L2_210 = false
    return L2_210
  end
  L2_210, L3_211 = nil, nil
  for L7_215 = 1, #L1_209 do
    for L11_219 = 1, #L9_217 do
      if L1_209[L7_215][L11_219] == ID[-1] then
        if L2_210 == nil then
          L2_210 = {L7_215, L11_219}
        else
          L1_209[L7_215][L11_219] = ID[0]
          L3_211 = {L7_215, L11_219}
        end
      elseif L1_209[L7_215][L11_219] == ID[0] then
        L3_211 = {L7_215, L11_219}
      end
    end
  end
  if L2_210 == nil and L3_211 ~= nil then
    L4_212[L5_213] = L6_214
    L4_212(L5_213, L6_214)
    L4_212(L5_213, L6_214)
    return L4_212
  end
  L4_212 = L2_210 ~= nil
  return L4_212
end
function class.SetHelperInfo(A0_220, A1_221)
  A0_220.helperInfo = A1_221
  if A1_221 ~= nil then
    A0_220:EnsureHelperPosition()
  end
  Logic:Get("BattleShow"):SetFriendInfo(A1_221)
end
function class.GetHelperInfo(A0_222)
  local L1_223
  L1_223 = A0_222.helperInfo
  return L1_223
end
function class.ClearFiendInfo(A0_224)
  local L1_225
  A0_224.friend = nil
  A0_224.helperInfo = nil
end
function class.SetUpgradeCost(A0_226, A1_227)
  A0_226.cost = A1_227
end
function class.GetUpgradeCost(A0_228)
  local L1_229
  L1_229 = A0_228.cost
  return L1_229
end
function class.PostGetAllHeros(A0_230)
  MsgHero:Post("ALL_HEROS")
end
function class.OnAllHeros(A0_231, A1_232, A2_233)
  if A1_232 ~= 0 or not A2_233 then
    return
  end
  A0_231.heroInfo = A2_233
  A0_231:CreateHeroMapTable(A0_231.heroInfo.heros)
  A0_231:FireEvent(EVT.ALL_HEROS)
end
function class.PostSetHeroCurrent(A0_234, A1_235, A2_236)
  A0_234.groupId = A1_235
  MsgHero:Post("HERO_CURRENT", {groupId = A1_235, heros = A2_236})
end
function class.OnSetHeroCurrent(A0_237, A1_238, A2_239)
  if A1_238 ~= 0 then
    Logic:Get("MsgAssist"):OnMsgResult("MsgHero", A1_238)
    return
  end
  if not A2_239 then
    return
  end
  if A0_237.groupId == 1 then
    A0_237:SetCurrentEmbattle(A2_239)
  else
    A0_237.group.groups[A0_237.groupId].embattles = A2_239
  end
  A0_237:FireEvent(EVT.HERO_CURRENT)
end
function class.PostChangeLeader(A0_240, A1_241, A2_242)
  A0_240.leaderId = A2_242
  MsgHero:Post("CHANGE_LEADER", {groupId = A1_241, src = A2_242})
end
function class.OnChangeLeader(A0_243, A1_244, A2_245)
  local L3_246, L4_247
  if A1_244 ~= 0 then
    L3_246 = Logic
    L3_246 = L3_246.Get
    L3_246 = L3_246(L4_247, "MsgAssist")
    L3_246 = L3_246.OnMsgResult
    L3_246(L4_247, "MsgHero", A1_244)
    return
  end
  if not A2_245 then
    return
  end
  L3_246 = A0_243.GetCurrentEmbattle
  L3_246 = L3_246(L4_247)
  if not L3_246 then
    return
  end
  if A2_245 == 0 then
    for _FORV_7_ = 1, #L3_246 do
      for _FORV_11_ = 1, #L3_246[_FORV_7_] do
        if L3_246[_FORV_7_][_FORV_11_] == A0_243.leaderId then
          L3_246[_FORV_7_][_FORV_11_] = ID[0]
        end
        if L3_246[_FORV_7_][_FORV_11_] == A0_243.group.groups[A0_243.group.curGroupId].leaderId then
          L3_246[_FORV_7_][_FORV_11_] = A0_243.leaderId
        end
      end
    end
    L4_247[A0_243.group.groups[A0_243.group.curGroupId].leaderId] = nil
    L4_247[A0_243.leaderId] = true
    L4_247.leaderId = A0_243.leaderId
    L4_247(A0_243, L3_246)
  elseif L4_247 then
    L4_247[A0_243.group.groups[A0_243.group.curGroupId].leaderId] = nil
    L4_247[A0_243.leaderId] = true
    L4_247.leaderId = A0_243.leaderId
    if L4_247 == "table" then
      L4_247(A0_243, A2_245)
    end
  elseif L4_247 then
    L4_247.embattles = A2_245
    L4_247.leaderId = A0_243.leaderId
  end
  if L4_247 and A0_243:GetHeroInfoById(A0_243.leaderId) then
    L4_247.baseId = A0_243:GetHeroInfoById(A0_243.leaderId).baseId
    Logic:Get("PlayerInfo"):InitInfo(L4_247)
  end
  A0_243:FireEvent(EVT.LEADER_CHANGE)
end
function class.SetSelectIndex(A0_248, A1_249)
  A0_248.realIndex = A1_249
end
function class.GetSelectIndex(A0_250)
  local L1_251
  L1_251 = A0_250.realIndex
  return L1_251
end
function class.ClearSelectIndex(A0_252)
  local L1_253
  A0_252.realIndex = nil
end
function class.GetSelectGroup(A0_254)
  local L1_255, L2_256
  L1_255 = A0_254.realIndex
  if not L1_255 then
    L1_255 = A0_254.group
    L1_255 = L1_255.groups
    L2_256 = A0_254.group
    L2_256 = L2_256.curGroupId
    L1_255 = L1_255[L2_256]
    return L1_255
  end
  L1_255 = A0_254.group
  L1_255 = L1_255.groups
  L2_256 = A0_254.realIndex
  L1_255 = L1_255[L2_256]
  return L1_255
end
function class.GetSelectGroupHerosId(A0_257)
  local L1_258, L2_259
  L2_259 = A0_257
  L1_258 = A0_257.GetSelectGroup
  L1_258 = L1_258(L2_259)
  if not L1_258 then
    return
  end
  L2_259 = L1_258.leaderId
  if L2_259 == ID[-1] then
    return
  end
  L2_259 = {}
  for _FORV_6_ = 1, #L1_258.embattles do
    for _FORV_10_ = 1, #L1_258.embattles[_FORV_6_] do
      if L1_258.embattles[_FORV_6_][_FORV_10_] ~= ID[-1] and L1_258.embattles[_FORV_6_][_FORV_10_] ~= ID[0] then
        table.insert(L2_259, L1_258.embattles[_FORV_6_][_FORV_10_])
      end
    end
  end
  return L2_259
end
function class.SetCurrentLeaderTag(A0_260, A1_261)
  A0_260.bCurrent = A1_261
end
function class.GetTag(A0_262)
  local L1_263
  L1_263 = A0_262.bCurrent
  return L1_263
end
function class.SetGroupEmbattle(A0_264, A1_265, A2_266)
  local L3_267
  L3_267 = A0_264.group
  if L3_267 then
    L3_267 = A0_264.group
    L3_267 = L3_267.groups
    if L3_267 then
      L3_267 = A0_264.group
      L3_267 = L3_267.groups
      L3_267 = L3_267[A1_265]
      if L3_267 then
        L3_267 = A0_264.group
        L3_267 = L3_267.groups
        L3_267 = L3_267[A1_265]
        L3_267.embattles = A2_266
      end
    end
  end
end
function class.GetGroupEmbattle(A0_268, A1_269)
  local L2_270
  L2_270 = A0_268.group
  if L2_270 then
    L2_270 = A0_268.group
    L2_270 = L2_270.groups
    if L2_270 then
      L2_270 = A0_268.group
      L2_270 = L2_270.groups
      L2_270 = L2_270[A1_269]
      if L2_270 then
        L2_270 = A0_268.group
        L2_270 = L2_270.groups
        L2_270 = L2_270[A1_269]
        L2_270 = L2_270.embattles
        return L2_270
      end
    end
  end
end
function class.SetCurrentEmbattle(A0_271, A1_272)
  local L2_273, L3_274
  L2_273 = A0_271.group
  if L2_273 then
    L2_273 = A0_271.group
    L2_273 = L2_273.groups
    if L2_273 then
      L2_273 = A0_271.group
      L2_273 = L2_273.groups
      L3_274 = A0_271.group
      L3_274 = L3_274.curGroupId
      L2_273 = L2_273[L3_274]
      if L2_273 then
        L2_273 = A0_271.group
        L2_273 = L2_273.groups
        L3_274 = A0_271.group
        L3_274 = L3_274.curGroupId
        L2_273 = L2_273[L3_274]
        L2_273.embattles = A1_272
      end
    end
  end
end
function class.GetCurrentEmbattle(A0_275)
  local L1_276, L2_277
  L1_276 = A0_275.group
  if L1_276 then
    L1_276 = A0_275.group
    L1_276 = L1_276.groups
    if L1_276 then
      L1_276 = A0_275.group
      L1_276 = L1_276.groups
      L2_277 = A0_275.group
      L2_277 = L2_277.curGroupId
      L1_276 = L1_276[L2_277]
      if L1_276 then
        L1_276 = A0_275.group
        L1_276 = L1_276.groups
        L2_277 = A0_275.group
        L2_277 = L2_277.curGroupId
        L1_276 = L1_276[L2_277]
        L1_276 = L1_276.embattles
        return L1_276
      end
    end
  end
end
function class.SetGroups(A0_278, A1_279)
  local L3_280
  L3_280 = A0_278.group
  L3_280.groups = A1_279 or A0_278.group.groups
end
function class.GetGroups(A0_281)
  return A0_281.group.groups
end
function class.GetHeroGroupId(A0_282)
  local L1_283
  L1_283 = A0_282.heroGroupId
  return L1_283
end
function class.PostSetEmbattle(A0_284, A1_285, A2_286)
  local L3_287
  L3_287 = {}
  if not A0_284:GetCurrentEmbattle() then
    return
  end
  for _FORV_8_ = 1, #A0_284:GetCurrentEmbattle() do
    L3_287[_FORV_8_] = {}
    for _FORV_12_ = 1, #A0_284:GetCurrentEmbattle()[_FORV_8_] do
      L3_287[_FORV_8_][_FORV_12_] = A0_284:GetCurrentEmbattle()[_FORV_8_][_FORV_12_]
    end
  end
  L3_287[A1_285[1] + 1][A1_285[2] + 1] = L3_287[A2_286[1] + 1][A2_286[2] + 1]
  L3_287[A2_286[1] + 1][A2_286[2] + 1] = L3_287[_FOR_ + 1][A1_285[2] + 1]
  A0_284.tempEmbattle = L3_287
  A0_284:SetCurrentEmbattle(A0_284.tempEmbattle)
  A0_284.embattleArry = L3_287
  A0_284:FireEvent(EVT.EMBATTLE_SET)
  MsgHero:Post("EMBATTLE", {src = A1_285, tar = A2_286})
end
function class.OnSetEmbattle(A0_288, A1_289, A2_290)
  if A1_289 ~= 0 or not A2_290 then
    return
  end
  A0_288:SetCurrentEmbattle(A0_288.tempEmbattle)
  A0_288:FireEvent(EVT.EMBATTLE_SET)
end
function class.clearGroupEmbattle(A0_291)
  A0_291.sendGroupHeros = {}
end
function class.GetSendGroupHeros(A0_292)
  A0_292:initSendGroups()
  if table.empty(A0_292.sendGroupHeros or {}) then
    A0_292.sendGroupHeros = nil
  end
  return A0_292.sendGroupHeros
end
function class.initSendGroups(A0_293)
  local L1_294
  L1_294 = A0_293.GetGroups
  L1_294 = L1_294(A0_293)
  A0_293.sendGroupHeros = {}
  for _FORV_5_, _FORV_6_ in ipairs(L1_294) do
    table.insert(A0_293.sendGroupHeros, _FORV_6_.embattles)
  end
end
function class.PostGroupEmbattle(A0_295, A1_296, A2_297, A3_298)
  local L4_299
  L4_299 = {}
  A0_295.emGroupId = A1_296
  if not A0_295:GetGroups()[A1_296].embattles then
    return
  end
  for _FORV_10_ = 1, #A0_295:GetGroups()[A1_296].embattles do
    L4_299[_FORV_10_] = {}
    for _FORV_14_ = 1, #A0_295:GetGroups()[A1_296].embattles[_FORV_10_] do
      L4_299[_FORV_10_][_FORV_14_] = A0_295:GetGroups()[A1_296].embattles[_FORV_10_][_FORV_14_]
    end
  end
  L4_299[A2_297[1] + 1][A2_297[2] + 1] = L4_299[A3_298[1] + 1][A3_298[2] + 1]
  L4_299[A3_298[1] + 1][A3_298[2] + 1] = L4_299[_FOR_ + 1][A2_297[2] + 1]
  A0_295.tempEmbattle = L4_299
  A0_295:GetGroups()[A1_296].embattles = L4_299
  A0_295:FireEvent(EVT.EMBATTLE_SET)
  MsgHero:Post("EMBATTLE_GROUP", {groupId = A1_296, embattle = L4_299})
end
function class.OnEmbattleGroup(A0_300, A1_301, A2_302)
  if A1_301 ~= 0 or not A2_302 then
    return
  end
  A0_300:SetGroupEmbattle(A0_300.emGroupId, A0_300.tempEmbattle)
end
function class.GetTempEmbattle(A0_303)
  local L1_304
  L1_304 = A0_303.embattleArry
  return L1_304
end
function class.setEmbattleArry(A0_305)
  A0_305.embattleArry = {}
end
function class.PostSwallowHero(A0_306, A1_307, A2_308)
  MsgHero:Post("SWALLOW", {src = A1_307, tar = A2_308})
end
function class.OnSwallowHero(A0_309, A1_310, A2_311)
  if A1_310 == 0 then
    if A2_311 == nil then
      Logic:Get("Login"):Login()
      return
    end
    Logic:Get("Cost"):AddCosts(A2_311.costs)
    if A2_311.hero and A2_311.hero.id then
      A0_309.heroInfo.heros[A2_311.hero.id] = A2_311.hero
      A0_309:FireEvent(EVT.SWALLOW_HERO, A2_311.hero)
      A0_309:FireEvent(EVT.HERO_CHANGE)
    end
  else
    Logic:Get("MsgAssist"):OnMsgResult("MsgHero", A1_310)
    if A1_310 ~= -2 then
      Logic:Get("Login"):Login()
    end
  end
end
function class.PostSellHero(A0_312, A1_313)
  MsgHero:Post("SELL_HERO", {tar = A1_313})
end
function class.OnSellHero(A0_314, A1_315, A2_316)
  if A1_315 ~= 0 or not A2_316 then
    return
  end
  Logic:Get("Reward"):AddRewards(A2_316.rewards)
  Logic:Get("Cost"):AddCosts(A2_316.costs)
  A0_314:FireEvent(EVT.SELL_HERO)
end
function class.PostGetFightPoint(A0_317)
  MsgHero:Post("CURRENT_SCORE")
end
function class.OnGetFightPoint(A0_318, A1_319, A2_320)
  if A1_319 ~= 0 or not A2_320 then
    return
  end
  A0_318.scoreTable = A2_320
  A0_318.heroInfo.score = A2_320
  A0_318:FireEvent(EVT.FIGHT_POINT, A2_320)
end
function class.GetScoreTable(A0_321)
  local L1_322
  L1_322 = A0_321.scoreTable
  return L1_322
end
function class.CheckCanUpdate(A0_323)
  if A0_323:GetUpgradeCost() and Logic:Get("PlayerInfo"):GetPlayerMoney() and A0_323:GetUpgradeCost() > Logic:Get("PlayerInfo"):GetPlayerMoney().copper then
    return false
  end
  return true
end
function class.GetGroupIndex(A0_324)
  local L1_325
  L1_325 = A0_324.itemIndex
  return L1_325
end
function class.GetCurrentGroup(A0_326)
  local L1_327
  L1_327 = A0_326.group
  return L1_327
end
function class.PostSwitchGroup(A0_328, A1_329)
  MsgHero:Post("SWITCH_HERO_GROUP", {groupId = A1_329})
end
function class.OnSwitchHeroGroup(A0_330, A1_331, A2_332)
  if A1_331 ~= 0 or not A2_332 then
    return
  end
  if A0_330.group and A0_330.group.groups then
    A0_330.group.groups[1] = A0_330.group.groups[A2_332]
    A0_330.group.groups[1].groupId = 1
    A0_330.group.groups[A2_332] = A0_330.group.groups[1]
    A0_330.group.groups[A2_332].groupId = A2_332
  end
  A0_330:FireEvent(EVT.SWITCH_HERO_GROUP)
end
function class.onSwitchGroup(A0_333, A1_334, A2_335)
  if A1_334 ~= 0 or not A2_335 then
    return
  end
  if table.empty(A0_333.group) or table.empty(A0_333.group.groups) then
    return
  end
  A0_333.group.groups[2] = A0_333.group.groups[3]
  A0_333.group.groups[2].groupId = 2
  A0_333.group.groups[3] = A0_333.group.groups[2]
  A0_333.group.groups[3].groupId = 3
  A0_333:FireEvent(EVT.SWITCH_HERO_GROUP)
end
function class.GetHeroInfoByBaseId(A0_336, A1_337)
  return KFDBGetRecord("BaseHero", A1_337)
end
function class.GetHeroName(A0_338, A1_339)
  if nil == A0_338:GetHeroInfoByBaseId(A1_339) then
    return ""
  end
  return A0_338:GetHeroInfoByBaseId(A1_339).name
end
function class.GetRoleSkin(A0_340, A1_341)
  if KFDBGetRecord("BaseHero", A1_341) and KFDBGetRecord("BaseHero", A1_341).model then
    return KFDBGetRecord("RoleSkin", KFDBGetRecord("BaseHero", A1_341).model)
  end
end
function class.GetHeroLifeAndAttack(A0_342, A1_343, A2_344)
  local L3_345, L4_346, L5_347, L6_348, L7_349
  L4_346 = A0_342
  L3_345 = A0_342.GetHeroInfoByBaseId
  L5_347 = A1_343
  L3_345 = L3_345(L4_346, L5_347)
  if L3_345 then
    L4_346, L5_347 = nil, nil
    L6_348 = L3_345.initValues
    if L6_348 then
      L6_348 = L3_345.initGrows
      if L6_348 then
        L6_348 = L3_345.initValues
        if L6_348 ~= "" then
          L6_348 = L3_345.initGrows
          if L6_348 ~= "" then
            L6_348 = json
            L6_348 = L6_348.decode
            L7_349 = L3_345.initValues
            L6_348 = L6_348(L7_349)
            L4_346 = L6_348
            L6_348 = json
            L6_348 = L6_348.decode
            L7_349 = L3_345.initGrows
            L6_348 = L6_348(L7_349)
            L5_347 = L6_348
          end
        end
      end
    end
    if not L4_346 or not L5_347 then
      L6_348 = 0
      L7_349 = 0
      return L6_348, L7_349
    end
    L6_348 = math
    L6_348 = L6_348.modf
    L7_349 = L4_346.LIFE
    L7_349 = L7_349 or 0
    L7_349 = L7_349 + A2_344 * (L5_347.LIFE or 0)
    L6_348 = L6_348(L7_349)
    L7_349 = math
    L7_349 = L7_349.modf
    L7_349 = L7_349((L4_346.ATTACK or 0) + A2_344 * (L5_347.ATTACK or 0))
    return L6_348, L7_349
  end
end
function class.GetLeadership(A0_350, A1_351)
  local L2_352
  L2_352 = A1_351 or L2_352(L2_352)
  if not L2_352 then
    return A0_350.leadership or 0
  end
  return A0_350.leadership + A0_350:GetLeadershipByLevel(L2_352)
end
function class.GetLeadershipByLevel(A0_353, A1_354)
  if not A0_353:GetLevelConfig(A1_354) then
    return 0
  end
  return tonumber(A0_353:GetLevelConfig(A1_354).leadership) or 0
end
function class.GetHeroPrice(A0_355, A1_356, A2_357)
  if not A0_355:GetHeroInfoByBaseId(A1_356) then
    return 0
  end
  if A0_355:GetHeroInfoByBaseId(A1_356).baseCoins and A0_355:GetHeroInfoByBaseId(A1_356).growCoins then
    return math.modf(A0_355:GetHeroInfoByBaseId(A1_356).baseCoins + A2_357 * A0_355:GetHeroInfoByBaseId(A1_356).growCoins)
  end
end
function class.GetHeroSwallowExp(A0_358, A1_359, A2_360)
  if not A0_358:GetHeroInfoByBaseId(A1_359) then
    return 0
  end
  return math.modf(A0_358:GetHeroInfoByBaseId(A1_359).baseExp + A2_360 * A0_358:GetHeroInfoByBaseId(A1_359).growExp)
end
function class.GetSwallowCost(A0_361, A1_362, A2_363)
  if not A0_361:GetHeroInfoByBaseId(A1_362) or not A0_361:GetHeroInfoByBaseId(A1_362).coinRate then
    return 0
  end
  if A0_361:GetHeroSwallowExp(A1_362, A2_363) then
    return A0_361:GetHeroSwallowExp(A1_362, A2_363) * A0_361:GetHeroInfoByBaseId(A1_362).coinRate
  end
end
function class.GetLevelConfig(A0_364, A1_365)
  local L2_366, L3_367
  L2_366 = KFDBGetRecord
  L3_367 = "LevelConfig"
  L2_366 = L2_366(L3_367, A1_365)
  if nil == L2_366 then
    L3_367 = KFDBGetRecordAmt
    L3_367 = L3_367("LevelConfig")
    if nil == KFDBGetRecordByIdx("LevelConfig", L3_367) then
      return nil
    end
    if A1_365 > KFDBGetRecordByIdx("LevelConfig", L3_367).id then
      return (KFDBGetRecordByIdx("LevelConfig", L3_367))
    end
  end
  return L2_366
end
function class.GetSkillInfoById(A0_368, A1_369)
  return KFDBGetRecord("SkillConfig", A1_369)
end
function class.GetHeroLevelConfig(A0_370, A1_371)
  return KFDBGetRecord("HeroLevelConfig", A1_371)
end
function class.GetHeroNextExp(A0_372, A1_373, A2_374)
  local L3_375
  L3_375 = 0
  if A0_372:GetHeroLevelConfig(A2_374) and A0_372:GetHeroLevelConfig(A2_374).exp and A0_372:GetHeroInfoByBaseId(A1_373) and A0_372:GetHeroInfoByBaseId(A1_373).expRate then
    L3_375 = L3_375 + A0_372:GetHeroLevelConfig(A2_374).exp * A0_372:GetHeroInfoByBaseId(A1_373).expRate
  end
  return math.modf(L3_375)
end
function class.PostRankUp(A0_376, A1_377)
  local L2_378
  L2_378 = {}
  for _FORV_6_, _FORV_7_ in ipairs(Logic:Get("CoordinatesSale"):getAllCard()) do
    if _FORV_7_.card ~= nil then
      table.insert(L2_378, _FORV_7_.card.id)
    end
  end
  MsgHero:Post("RANK_UP", {src = A1_377, tar = L2_378})
end
function class.PostRankUpByGold(A0_379, A1_380)
  MsgHero:Post("RANK_UP_BY_GOLD", {src = A1_380})
end
function class.OnRankUp(A0_381, A1_382, A2_383)
  if A1_382 == 0 then
    Logic:Get("Cost"):AddCosts(A2_383.costs)
    A0_381:AddCard(A2_383.hero)
    Logic:Get("WeChat"):RankUp(A2_383.hero)
    if Logic:Get("Sect"):IsMixMenaiCard() then
      A0_381:FireEvent(EVT.ON_RANKUP_MENPAICARD)
    else
      A0_381:FireEvent(EVT.RANK_UP)
      A0_381:FireEvent(EVT.HERO_CHANGE)
    end
  else
    Logic:Get("MsgAssist"):OnMsgResult("MsgHero", A1_382)
    if -6 == A1_382 then
      Logic:Get("Login"):Login()
    end
  end
end
function class.OnRankUpByGold(A0_384, A1_385, A2_386)
  A0_384:OnRankUp(A1_385, A2_386)
end
function class.PostCrushHero(A0_387, A1_388)
  MsgHero:Post("CRUSH_HERO", {
    tar = {A1_388}
  })
end
function class.OnCrushHero(A0_389, A1_390, A2_391)
  if A1_390 == 0 then
    A0_389.resCosAndRew = A2_391
    Logic:Get("Cost"):AddCosts(A2_391.costs)
    Logic:Get("Reward"):AddRewards(A2_391.rewards)
  end
  A0_389:FireEvent(EVT.ALL_HEROS)
end
function class.PostLock(A0_392, A1_393, A2_394)
  A0_392.lockId = A2_394
  MsgHero:Post("LOCK", {lock = A1_393, src = A2_394})
end
function class.OnLock(A0_395, A1_396, A2_397)
  if A1_396 ~= 0 or not A2_397 then
    return
  end
  if not A0_395.heroInfo.heros[A0_395.lockId] then
    return
  end
  if A0_395.heroInfo.heros[A0_395.lockId].locked then
    A0_395.heroInfo.heros[A0_395.lockId].locked = false
  else
    A0_395.heroInfo.heros[A0_395.lockId].locked = true
  end
  A0_395:FireEvent(EVT.HERO_LOCK)
end
function class.PostSkillUp(A0_398, A1_399, A2_400)
  MsgHero:Post("SKILL_UP", {src = A1_399, tar = A2_400})
end
function class.OnSkillUp(A0_401, A1_402, A2_403)
  if A1_402 == 0 then
    Logic:Get("Cost"):AddCosts(A2_403.costs)
    A0_401:AddCard(A2_403.hero)
    A0_401:FireEvent(EVT.HERO_SKILL_UP, true)
  end
end
function class.OnBattleShowEnd(A0_404)
  A0_404:ClearFiendInfo()
end
function class.GetFightById(A0_405, A1_406)
  if A0_405:GetHeroInfoById(A1_406) == nil then
    return 0
  end
  if A0_405:GetHeroInfoByBaseId(A0_405:GetHeroInfoById(A1_406).baseId) ~= nil and A0_405:GetHeroInfoByBaseId(A0_405:GetHeroInfoById(A1_406).baseId).initRates ~= "" then
    A0_405:GetHeroInfoByBaseId(A0_405:GetHeroInfoById(A1_406).baseId).initRates = json.decode(A0_405:GetHeroInfoByBaseId(A0_405:GetHeroInfoById(A1_406).baseId).initRates)
  else
    return 0
  end
  if KFDBGetRecord("SkillConfig", A0_405:GetHeroInfoById(A1_406).powerSkill) == nil then
    return 0
  end
  if A0_405:GetHeroTypeByFight(A0_405:GetHeroInfoById(A1_406).baseId) == "PHY" then
    return math.floor((A0_405:GetHeroLifeAndAttack(A0_405:GetHeroInfoById(A1_406).baseId, A0_405:GetHeroInfoById(A1_406).level) * (0.85 + (A0_405:GetHeroInfoByBaseId(A0_405:GetHeroInfoById(A1_406).baseId).initRates.HIT or 0)) * (1 + (A0_405:GetHeroInfoByBaseId(A0_405:GetHeroInfoById(A1_406).baseId).initRates.CRIT or 0) * (1.5 + (A0_405:GetHeroInfoByBaseId(A0_405:GetHeroInfoById(A1_406).baseId).initRates.HURT_CRIT or 0))) * (1 + (A0_405:GetHeroInfoByBaseId(A0_405:GetHeroInfoById(A1_406).baseId).initRates.HARM_P or 0)) * A0_405:GetHeroLifeAndAttack(A0_405:GetHeroInfoById(A1_406).baseId, A0_405:GetHeroInfoById(A1_406).level) / 3 * (1 + (A0_405:GetHeroInfoByBaseId(A0_405:GetHeroInfoById(A1_406).baseId).initRates.DODGY or 0)) * (1 + (A0_405:GetHeroInfoByBaseId(A0_405:GetHeroInfoById(A1_406).baseId).initRates.UNCRIT or 0) * (1.5 + (A0_405:GetHeroInfoByBaseId(A0_405:GetHeroInfoById(A1_406).baseId).initRates.UNHURT_CRIT or 0))) * (1 + (A0_405:GetHeroInfoByBaseId(A0_405:GetHeroInfoById(A1_406).baseId).initRates.UNHARM_P or 0)) * tonumber(KFDBGetRecord("SkillConfig", A0_405:GetHeroInfoById(A1_406).powerSkill).skillRate or 0)) ^ 0.5)
  elseif A0_405:GetHeroTypeByFight(A0_405:GetHeroInfoById(A1_406).baseId) == "MAGIC" then
    return math.floor((A0_405:GetHeroLifeAndAttack(A0_405:GetHeroInfoById(A1_406).baseId, A0_405:GetHeroInfoById(A1_406).level) * (0.85 + (A0_405:GetHeroInfoByBaseId(A0_405:GetHeroInfoById(A1_406).baseId).initRates.HIT or 0)) * (1 + (A0_405:GetHeroInfoByBaseId(A0_405:GetHeroInfoById(A1_406).baseId).initRates.HARM_M or 0)) * A0_405:GetHeroLifeAndAttack(A0_405:GetHeroInfoById(A1_406).baseId, A0_405:GetHeroInfoById(A1_406).level) / 3 * (1 + (A0_405:GetHeroInfoByBaseId(A0_405:GetHeroInfoById(A1_406).baseId).initRates.DODGY or 0)) * (1 + (A0_405:GetHeroInfoByBaseId(A0_405:GetHeroInfoById(A1_406).baseId).initRates.UNHARM_M or 0)) * tonumber(KFDBGetRecord("SkillConfig", A0_405:GetHeroInfoById(A1_406).powerSkill).skillRate or 0)) ^ 0.5)
  end
end
function class.GetHeroTypeByFight(A0_407, A1_408)
  if A1_408 == nil then
    return
  end
  if A0_407:GetHeroInfoByBaseId(A1_408) == nil then
    return
  end
  for _FORV_6_ = 1, #PHY_TYPE do
    if A0_407:GetHeroInfoByBaseId(A1_408).type == PHY_TYPE[_FORV_6_] then
      return "PHY"
    end
  end
  for _FORV_6_ = 1, #PHY_TYPE do
    if A0_407:GetHeroInfoByBaseId(A1_408).type == MAGIC_TYPE[_FORV_6_] then
      return "MAGIC"
    end
  end
end
function class.GetCardByTypeForSkill(A0_409)
  local L1_410, L2_411, L3_412, L4_413, L5_414, L6_415
  L2_411 = A0_409
  L1_410 = A0_409.GetHeroTableFromMap
  L3_412 = A0_409.heroInfo
  L3_412 = L3_412.heros
  L1_410 = L1_410(L2_411, L3_412)
  if not L1_410 then
    return
  end
  L2_411 = {}
  L3_412 = {}
  L4_413 = {}
  L5_414 = {}
  L6_415 = {}
  for _FORV_10_ = 1, #L1_410 do
    if A0_409:GetHeroInfoByBaseId(A0_409.heroInfo.heros[L1_410[_FORV_10_]].baseId) and A0_409:GetHeroInfoByBaseId(A0_409.heroInfo.heros[L1_410[_FORV_10_]].baseId).card and A0_409:GetHeroInfoByBaseId(A0_409.heroInfo.heros[L1_410[_FORV_10_]].baseId).card == "HERO" then
      table.insert(L2_411, L1_410[_FORV_10_])
      table.insert(L4_413, A0_409.heroInfo.heros[L1_410[_FORV_10_]])
    elseif A0_409:GetHeroInfoByBaseId(A0_409.heroInfo.heros[L1_410[_FORV_10_]].baseId) and A0_409:GetHeroInfoByBaseId(A0_409.heroInfo.heros[L1_410[_FORV_10_]].baseId).card and A0_409:GetHeroInfoByBaseId(A0_409.heroInfo.heros[L1_410[_FORV_10_]].baseId).card == "SKILL_CARD" then
      table.insert(L3_412, L1_410[_FORV_10_])
      table.insert(L5_414, A0_409.heroInfo.heros[L1_410[_FORV_10_]])
      if L6_415[A0_409.heroInfo.heros[L1_410[_FORV_10_]].baseId] then
        table.insert(L6_415[A0_409.heroInfo.heros[L1_410[_FORV_10_]].baseId], A0_409.heroInfo.heros[L1_410[_FORV_10_]].id)
      else
        L6_415[A0_409.heroInfo.heros[L1_410[_FORV_10_]].baseId] = {}
        table.insert(L6_415[A0_409.heroInfo.heros[L1_410[_FORV_10_]].baseId], A0_409.heroInfo.heros[L1_410[_FORV_10_]].id)
      end
    end
  end
  _FOR_:Get("Treasure"):SetSkillCard(L6_415)
  for _FORV_10_ = 1, #L4_413 do
    L4_413[_FORV_10_].boolCanLvl = Logic:Get("Treasure"):boolCanLvl(L4_413[_FORV_10_].powerSkill)
  end
  return L2_411, L3_412, L4_413, L5_414
end
function class.IsHasSkillCard(A0_416, A1_417)
  if not A0_416:GetHeroTableFromMap(A0_416.heroInfo.heros) then
    return
  end
  for _FORV_7_ = 1, #A0_416:GetHeroTableFromMap(A0_416.heroInfo.heros) do
    if A0_416:GetHeroInfoByBaseId(A0_416.heroInfo.heros[A0_416:GetHeroTableFromMap(A0_416.heroInfo.heros)[_FORV_7_]].baseId) and A0_416:GetHeroInfoByBaseId(A0_416.heroInfo.heros[A0_416:GetHeroTableFromMap(A0_416.heroInfo.heros)[_FORV_7_]].baseId).card and A0_416:GetHeroInfoByBaseId(A0_416.heroInfo.heros[A0_416:GetHeroTableFromMap(A0_416.heroInfo.heros)[_FORV_7_]].baseId).card == A1_417 then
      return true
    end
  end
  return _FOR_
end
function class.IsHeroSkilUp(A0_418)
  local L1_419, L2_420, L3_421, L4_422, L5_423, L6_424
  L2_420 = A0_418
  L1_419 = A0_418.GetHeroTableFromMap
  L3_421 = A0_418.heroInfo
  L3_421 = L3_421.heros
  L1_419 = L1_419(L2_420, L3_421)
  if not L1_419 then
    return
  end
  L2_420 = {}
  L3_421 = {}
  L4_422 = {}
  L5_423 = {}
  L6_424 = {}
  for _FORV_10_ = 1, #L1_419 do
    if A0_418:GetHeroInfoByBaseId(A0_418.heroInfo.heros[L1_419[_FORV_10_]].baseId) and A0_418:GetHeroInfoByBaseId(A0_418.heroInfo.heros[L1_419[_FORV_10_]].baseId).card and A0_418:GetHeroInfoByBaseId(A0_418.heroInfo.heros[L1_419[_FORV_10_]].baseId).card == "HERO" then
      table.insert(L4_422, A0_418.heroInfo.heros[L1_419[_FORV_10_]])
    elseif A0_418:GetHeroInfoByBaseId(A0_418.heroInfo.heros[L1_419[_FORV_10_]].baseId) and A0_418:GetHeroInfoByBaseId(A0_418.heroInfo.heros[L1_419[_FORV_10_]].baseId).card and A0_418:GetHeroInfoByBaseId(A0_418.heroInfo.heros[L1_419[_FORV_10_]].baseId).card == "SKILL_CARD" then
      if L6_424[A0_418.heroInfo.heros[L1_419[_FORV_10_]].baseId] then
        table.insert(L6_424[A0_418.heroInfo.heros[L1_419[_FORV_10_]].baseId], A0_418.heroInfo.heros[L1_419[_FORV_10_]].id)
      else
        L6_424[A0_418.heroInfo.heros[L1_419[_FORV_10_]].baseId] = {}
        table.insert(L6_424[A0_418.heroInfo.heros[L1_419[_FORV_10_]].baseId], A0_418.heroInfo.heros[L1_419[_FORV_10_]].id)
      end
    end
  end
  _FOR_:Get("Treasure"):SetSkillCard(L6_424)
  for _FORV_10_ = 1, #L4_422 do
    L4_422[_FORV_10_].boolCanLvl = Logic:Get("Treasure"):boolCanLvl(L4_422[_FORV_10_].powerSkill)
    if L4_422[_FORV_10_].boolCanLvl == 0 then
      return true
    end
  end
  return _FOR_
end
function class.IsBagEnough(A0_425)
  if Logic:Get("Hero"):GetTotalExtendLimit() <= Logic:Get("Hero"):GetCardNumber() then
    return true
  else
    return false
  end
end
function class.setGuideLevel(A0_426, A1_427)
  A0_426.bool = A1_427 or false
end
function class.isGuideLevel(A0_428)
  local L1_429
  L1_429 = A0_428.bool
  return L1_429
end
function class.setEvoHunting(A0_430, A1_431)
  A0_430.evoHunting = A1_431 or nil
end
function class.isEvoHunting(A0_432)
  local L1_433
  L1_433 = A0_432.evoHunting
  return L1_433
end
function class.setChangingTeam(A0_434, A1_435)
  A0_434.changingTeam = A1_435 or nil
end
function class.isChangingTeam(A0_436)
  local L1_437
  L1_437 = A0_436.changingTeam
  return L1_437
end
function class.setHeroUpgradePage(A0_438, A1_439)
  A0_438.heroUpgradePage = A1_439
end
function class.getHeroUpgradePage(A0_440)
  local L1_441
  L1_441 = A0_440.heroUpgradePage
  return L1_441
end
function class.setHeroSwallowPage(A0_442, A1_443)
  A0_442.heroSwallowPage = A1_443
end
function class.getHeroSwallowPage(A0_444)
  local L1_445
  L1_445 = A0_444.heroSwallowPage
  return L1_445
end
function class.setHeroUpSkillPage(A0_446, A1_447)
  A0_446.heroUpSkillPage = A1_447
end
function class.getHeroUpSkillPage(A0_448)
  local L1_449
  L1_449 = A0_448.heroUpSkillPage
  return L1_449
end
function class.setTreasurePage(A0_450, A1_451)
  A0_450.treasurePage = A1_451
end
function class.getTreasurePage(A0_452)
  local L1_453
  L1_453 = A0_452.treasurePage
  return L1_453
end
function class.SetRankGroupInfo(A0_454, A1_455)
  A0_454.rankGroupInfo = A1_455
end
function class.GetRankGroupInfo(A0_456)
  local L1_457
  L1_457 = A0_456.rankGroupInfo
  return L1_457
end
function class.getColorByBaseId(A0_458, A1_459)
  local L2_460, L3_461
  if A1_459 == nil then
    L2_460 = ccc3
    L3_461 = unpack
    L3_461 = L3_461(RANK_COLOR[1])
    return L2_460(L3_461, L3_461(RANK_COLOR[1]))
  end
  L3_461 = A0_458
  L2_460 = A0_458.GetHeroInfoByBaseId
  L2_460 = L2_460(L3_461, A1_459)
  if L2_460 then
    L3_461 = L2_460.rank
    if L3_461 < 1 then
      L2_460.rank = 1
    end
    L3_461 = L2_460.rank
    if L3_461 > #RANK_COLOR then
      L3_461 = RANK_COLOR
      L3_461 = #L3_461
      L2_460.rank = L3_461
    end
    L3_461 = RANK_COLOR
    L3_461 = L3_461[L2_460.rank]
    L3_461 = L3_461 or RANK_COLOR[1]
    return ccc3(unpack(L3_461))
  end
  L3_461 = ccc3
  return L3_461(unpack(RANK_COLOR[1]))
end
function class.GetBattleHeroCopy(A0_462)
  A0_462.battleHeroCopy = A0_462:GetAllFightHero()
end
function class.AddHeroToCopy(A0_463, A1_464)
  table.insert(A0_463.battleHeroCopy, A1_464)
end
function class.RemoveHeroFromCopy(A0_465, A1_466)
  local L2_467, L3_468, L4_469, L5_470
  for L5_470 = #L2_467, 1, -1 do
    if A1_466 == A0_465.battleHeroCopy[L5_470] then
      table.remove(A0_465.battleHeroCopy, L5_470)
      return
    end
  end
end
function class.checkLuckyHeroById(A0_471, A1_472, A2_473)
  local L3_474, L4_475, L5_476, L6_477
  L4_475 = A0_471
  L3_474 = A0_471.GetHeroInfoById
  L5_476 = A1_472
  L3_474 = L3_474(L4_475, L5_476)
  if L3_474 == nil then
    L4_475 = false
    return L4_475
  end
  L5_476 = A0_471
  L4_475 = A0_471.GetHeroInfoByBaseId
  L6_477 = L3_474.baseId
  L4_475 = L4_475(L5_476, L6_477)
  L6_477 = A0_471
  L5_476 = A0_471.GetHeroInfoByBaseId
  L5_476 = L5_476(L6_477, A2_473)
  if L4_475 then
    L6_477 = L4_475.limits
    if L6_477 > 0 then
      L6_477 = L4_475.mutexs
      if L6_477 then
        L6_477 = json
        L6_477 = L6_477.decode
        L6_477 = L6_477(L4_475.mutexs)
      else
        L6_477 = L6_477 or {}
      end
      if L6_477 ~= nil and not table.empty(L6_477) then
        if L3_474.baseId == A2_473 then
          return true
        end
        for _FORV_10_, _FORV_11_ in pairs(L6_477) do
          if _FORV_11_ == A2_473 then
            return true
          end
        end
      end
    end
  end
  if L5_476 then
    L6_477 = L5_476.limits
    if L6_477 > 0 then
      L6_477 = L5_476.mutexs
      if L6_477 then
        L6_477 = json
        L6_477 = L6_477.decode
        L6_477 = L6_477(L5_476.mutexs)
      else
        L6_477 = L6_477 or {}
      end
      if L6_477 ~= nil and not table.empty(L6_477) then
        for _FORV_10_, _FORV_11_ in pairs(L6_477) do
          if _FORV_11_ == L3_474.baseId then
            return true
          end
        end
      end
    end
  end
  L6_477 = false
  return L6_477
end
function class.checkCurrGroupMutex(A0_478, A1_479, A2_480)
  local L3_481, L4_482, L5_483, L6_484, L7_485, L8_486, L9_487, L10_488
  L3_481 = 0
  L4_482 = A0_478.battleHeroCopy
  L5_483 = A0_478.GetLeaderId
  L5_483 = L5_483(L6_484)
  for L9_487, L10_488 in L6_484(L7_485) do
    if (not A2_480 or L10_488 ~= L5_483) and A0_478:checkLuckyHeroById(L10_488, A1_479) then
      L3_481 = L3_481 + 1
    end
  end
  if L3_481 > 0 then
    if L6_484 then
      L7_485 = L3_481 >= L7_485
      return L7_485
    end
  end
  return L6_484
end
function class.CheckInsistCard(A0_489, A1_490)
  local L2_491, L3_492, L4_493, L5_494, L6_495, L7_496, L8_497, L9_498, L10_499
  if A1_490 == nil or "" == A1_490 then
    L2_491 = {}
    return L2_491
  end
  L2_491 = json
  L2_491 = L2_491.decode
  L3_492 = A1_490
  L2_491 = L2_491(L3_492)
  L2_491 = L2_491 or {}
  L3_492 = Logic
  L4_493 = L3_492
  L3_492 = L3_492.Get
  L5_494 = "Hero"
  L3_492 = L3_492(L4_493, L5_494)
  L4_493 = L3_492
  L3_492 = L3_492.GetAllHeroInfo
  L3_492 = L3_492(L4_493)
  L4_493 = {}
  function L5_494(A0_500, A1_501)
    for _FORV_5_, _FORV_6_ in pairs(A0_500) do
      if _FORV_6_ == A1_501 then
        return false
      end
    end
    return true
  end
  for L9_498, L10_499 in L6_495(L7_496) do
    for _FORV_14_, _FORV_15_ in pairs(L3_492.heros) do
      if Logic:Get("Hero"):checkLuckyHeroById(_FORV_15_.id, L10_499) and L5_494(L4_493, L10_499) then
        table.insert(L4_493, L10_499)
      end
    end
  end
  return L4_493
end
function class.checkAllGroupLeaderShip(A0_502)
  local L1_503, L2_504
  L2_504 = A0_502
  L1_503 = A0_502.GetLeadership
  L1_503 = L1_503(L2_504)
  L2_504 = A0_502.GetGroups
  L2_504 = L2_504(A0_502)
  for _FORV_7_, _FORV_8_ in ipairs(L2_504) do
    Logic:Get("Devil"):SetChangeGroup({heros = _FORV_8_})
    Logic:Get("Devil"):InitGroupTeamerHero(_FORV_8_.groupId)
    if L1_503 < Logic:Get("Devil"):GetGroupLeadership() then
      break
    end
  end
  return _FORV_8_.groupId
end
function class.GetGroupsSrar(A0_505)
  local L2_506, L3_507, L4_508, L5_509, L6_510, L7_511, L8_512, L9_513, L10_514, L11_515, L12_516
  L2_506 = 0
  for L6_510 = 1, #L4_508 do
    for L10_514 = 1, #L8_512 do
      for _FORV_13_ = 1, #L12_516 do
        if A0_505:GetHeroInfoById(A0_505.group.groups[L6_510].embattles[L10_514][_FORV_13_]) ~= nil then
          L2_506 = L2_506 + tonumber(A0_505:GetHeroInfoByBaseId(A0_505:GetHeroInfoById(A0_505.group.groups[L6_510].embattles[L10_514][_FORV_13_]).baseId).star)
        end
      end
    end
  end
  return L2_506
end
function class.GetAllFightHero(A0_517)
  local L1_518, L2_519, L3_520, L4_521, L5_522, L6_523, L7_524, L8_525, L9_526, L10_527, L11_528, L12_529, L13_530
  L1_518 = {}
  for L5_522 = 1, #L3_520 do
    for L9_526 = 1, #L7_524 do
      for L13_530 = 1, #L11_528 do
        if A0_517:GetHeroInfoById(A0_517.group.groups[L5_522].embattles[L9_526][L13_530]) ~= nil then
          table.insert(L1_518, A0_517.group.groups[L5_522].embattles[L9_526][L13_530])
        end
      end
    end
  end
  return L1_518
end
function class.GetFightHero(A0_531)
  local L1_532, L2_533, L3_534, L4_535, L5_536, L6_537, L7_538, L8_539, L9_540, L10_541, L11_542, L12_543, L13_544, L14_545, L15_546, L16_547
  L1_532 = {}
  for L5_536, L6_537 in L2_533(L3_534) do
    L7_538 = {}
    for L11_542 = 1, #L9_540 do
      for L15_546 = 1, #L13_544 do
        L16_547 = L6_537.embattles
        L16_547 = L16_547[L11_542]
        L16_547 = L16_547[L15_546]
        if L16_547 == L6_537.leaderId then
          L16_547 = Logic
          L16_547 = L16_547.Get
          L16_547 = L16_547(L16_547, "Hero")
          L16_547 = L16_547.GetHeroInfoById
          L16_547 = L16_547(L16_547, L6_537.embattles[L11_542][L15_546])
          if L16_547 ~= nil then
            table.insert(L7_538, L16_547)
          end
        end
      end
    end
    for L11_542 = 1, #L9_540 do
      for L15_546 = 1, #L13_544 do
        L16_547 = L6_537.embattles
        L16_547 = L16_547[L11_542]
        L16_547 = L16_547[L15_546]
        if L16_547 ~= L6_537.leaderId then
          L16_547 = Logic
          L16_547 = L16_547.Get
          L16_547 = L16_547(L16_547, "Hero")
          L16_547 = L16_547.GetHeroInfoById
          L16_547 = L16_547(L16_547, L6_537.embattles[L11_542][L15_546])
          if L16_547 ~= nil then
            table.insert(L7_538, L16_547)
          end
        end
      end
    end
    L8_539(L9_540, L10_541)
  end
  return L1_532
end
