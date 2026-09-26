local L0_0
L0_0 = module
L0_0((...), package.seeall)
L0_0 = require
L0_0("Logic")
L0_0 = require
L0_0("MsgTreasure")
L0_0 = require
L0_0("SceneHelper")
L0_0 = Logic
L0_0 = L0_0.class
L0_0 = L0_0.subclass
L0_0 = L0_0(L0_0)
class = L0_0
L0_0 = Enum
L0_0 = L0_0(TypeDef("com.eyu.mt.module.treasure.facade.TreasureResult"))
EVT = Enum({
  "REFRESH_INFO",
  "REFRESH_LOOKFOR",
  "REFRESH_CONFIG",
  "REFRESH_TREA",
  "REFRESH_SELE_HERO",
  "REFRESH_AUTO_LOOKFOR"
})
function class.initialize(A0_1)
  super.initialize(A0_1)
  A0_1.treasurePackVo = {}
  A0_1.lookForResult = {}
  A0_1.rewardResult = {}
  A0_1.seleHeroIds = {}
  A0_1.heroSeleCur = {}
  A0_1.rewardResultArr = {}
  A0_1.skillHero = {}
  Logic:Get("MsgAssist"):RecordErrorMsg("MsgTreasure", _UPVALUE0_, _UPVALUE1_)
  MsgTreasure:On("INFO", A0_1:Event("OnInfo"), true)
  MsgTreasure:On("LOOKFOR", A0_1:Event("OnLookFor"), true)
  MsgTreasure:On("AUTO_LOOKFOR", A0_1:Event("OnAutoLookFor"), true)
  MsgTreasure:On("RECEIVE", A0_1:Event("OnReceive"), true)
end
function class.PostInfo(A0_2)
  MsgTreasure:Post("INFO", {})
end
function class.OnInfo(A0_3, A1_4, A2_5)
  if A1_4 ~= 0 then
    return
  end
  A0_3:setInfo(A2_5)
end
function class.setInfo(A0_6, A1_7)
  A0_6.treasurePackVo = A1_7
  A0_6:FireEvent(EVT.REFRESH_INFO)
end
function class.PostLookFor(A0_8)
  MsgTreasure:Post("LOOKFOR", {})
end
function class.OnLookFor(A0_9, A1_10, A2_11)
  if A1_10 == 0 then
    A0_9.lookForResult = A2_11
    Logic:Get("Cost"):AddCosts(A0_9.lookForResult.costs)
  end
  A0_9:FireEvent(EVT.REFRESH_LOOKFOR)
end
function class.PostAutoLookFor(A0_12)
  MsgTreasure:Post("AUTO_LOOKFOR", {})
end
function class.OnAutoLookFor(A0_13, A1_14, A2_15)
  if A1_14 == 0 then
    A0_13.lookForResultArr = A2_15
    for _FORV_6_ = 1, #A0_13.lookForResultArr do
      Logic:Get("Cost"):AddCosts(A0_13.lookForResultArr[_FORV_6_].costs)
    end
  end
  A0_13:FireEvent(EVT.REFRESH_AUTO_LOOKFOR)
end
function class.PostReceive(A0_16)
  MsgTreasure:Post("RECEIVE", {})
end
function class.OnReceive(A0_17, A1_18, A2_19)
  if A1_18 == 0 then
    A0_17.rewardResult = A2_19
    Logic:Get("Reward"):AddRewards(A0_17.rewardResult.rewards)
    SceneHelper:pushPrompt("TreasureTip", nil)
  end
  A0_17:PostInfo()
end
function class.GetTreasurePackVo(A0_20)
  local L1_21
  L1_21 = A0_20.treasurePackVo
  return L1_21
end
function class.GetLookForResult(A0_22)
  local L1_23
  L1_23 = A0_22.lookForResult
  return L1_23
end
function class.GetLookForResultArr(A0_24)
  local L1_25
  L1_25 = A0_24.lookForResultArr
  return L1_25
end
function class.GetRewardResult(A0_26)
  local L1_27
  L1_27 = A0_26.rewardResult
  return L1_27
end
function class.SetHeroInfo(A0_28, A1_29)
  if A1_29 ~= nil then
    A0_28.heroClone = tree.clone(A1_29)
  end
  A0_28.hero = A1_29
end
function class.GetHeroClone(A0_30)
  local L1_31
  L1_31 = A0_30.heroClone
  return L1_31
end
function class.setHeroClone(A0_32, A1_33)
  A0_32.heroClone = tree.clone(A1_33)
end
function class.GetHeroInfo(A0_34)
  if A0_34.hero ~= nil then
    A0_34.hero = Logic:Get("Hero"):GetHeroInfoById(A0_34.hero.id)
  end
  return A0_34.hero
end
function class.SetTreaSele(A0_35, A1_36, A2_37)
  A0_35.seleHeroIds[A1_36] = A2_37
end
function class.SetSeleTreaIds(A0_38, A1_39)
  if table.empty(A1_39) then
    A0_38.seleHeroIds = {}
    return
  end
  A0_38.seleHeroIds = {}
  for _FORV_5_, _FORV_6_ in pairs(A1_39) do
    A0_38.seleHeroIds[_FORV_5_] = _FORV_6_
  end
end
function class.GetSeleTrea(A0_40)
  local L1_41
  L1_41 = A0_40.seleHeroIds
  return L1_41
end
function class.SetHeroSeleCur(A0_42, A1_43, A2_44)
  A0_42.heroSeleCur[A1_43] = A2_44
end
function class.SetHeroSeleCur(A0_45, A1_46)
  if table.empty(A1_46) then
    A0_45.heroSeleCur = {}
    return
  end
  A0_45.heroSeleCur = {}
  for _FORV_5_, _FORV_6_ in pairs(A1_46) do
    A0_45.heroSeleCur[_FORV_5_] = _FORV_6_
  end
end
function class.GetHeroSeleCur(A0_47)
  local L1_48
  L1_48 = A0_47.heroSeleCur
  return L1_48
end
function class.SetAutoSelect(A0_49)
  local L1_50, L2_51, L3_52, L4_53, L5_54, L6_55, L7_56, L8_57, L9_58, L10_59, L11_60, L12_61
  L2_51 = A0_49
  L1_50 = A0_49.GetTreaByHero
  L1_50 = L1_50(L2_51)
  L2_51 = table
  L2_51 = L2_51.empty
  L2_51 = L2_51(L3_52)
  if L2_51 then
    L2_51 = Prompt
    L2_51 = L2_51.Fail
    L12_61 = L4_53(L5_54)
    L2_51(L3_52, L4_53, L5_54, L6_55, L7_56, L8_57, L9_58, L10_59, L11_60, L12_61, L4_53(L5_54))
    return
  end
  L2_51 = Logic
  L2_51 = L2_51.Get
  L2_51 = L2_51(L3_52, L4_53)
  L2_51 = L2_51.SortHerosByChoice
  L2_51(L3_52, L4_53, L5_54)
  L2_51 = {}
  for L6_55 = #L1_50, 1, -1 do
    if L7_56 ~= 1 then
      L9_58 = L1_50[L6_55]
      L7_56(L8_57, L9_58)
    end
  end
  for L8_57, L9_58 in L5_54(L6_55) do
    if L9_58 then
      L10_59 = Logic
      L11_60 = L10_59
      L10_59 = L10_59.Get
      L12_61 = "Hero"
      L10_59 = L10_59(L11_60, L12_61)
      L11_60 = L10_59
      L10_59 = L10_59.GetHeroInfoById
      L12_61 = L8_57
      L10_59 = L10_59(L11_60, L12_61)
      L11_60 = L10_59 and L11_60(L12_61, L10_59.baseId)
      if L11_60 then
        L12_61 = tonumber
        L12_61 = L12_61(L11_60.baseExp)
      end
    end
  end
  for L9_58, L10_59 in L6_55(L7_56) do
    if L4_53 >= 6 then
      break
    end
    L11_60 = Logic
    L12_61 = L11_60
    L11_60 = L11_60.Get
    L11_60 = L11_60(L12_61, "Hero")
    L12_61 = L11_60
    L11_60 = L11_60.GetHeroInfoById
    L11_60 = L11_60(L12_61, L10_59.id)
    L12_61 = 0
    if L11_60 ~= nil then
      L12_61 = tonumber(Logic:Get("Hero"):GetHeroInfoByBaseId(L11_60.baseId).baseExp)
    end
    if not A0_49.heroSeleCur[L10_59.id] and L12_61 > 0 and A0_49.hero.skillExp + L3_52 + L12_61 <= tonumber(L5_54.maxExps) then
      A0_49.heroSeleCur[L10_59.id] = true
      if A0_49.hero.skillExp + L3_52 == tonumber(L5_54.maxExps) then
        break
      end
    end
  end
end
function class.FireEnvenConfig(A0_62)
  A0_62:FireEvent(EVT.REFRESH_CONFIG)
end
function class.GetTreaByHero(A0_63)
  local L1_64
  L1_64 = Logic
  L1_64 = L1_64.Get
  L1_64 = L1_64(L1_64, "Hero")
  L1_64 = L1_64.GetTotalSkillCard
  L1_64 = L1_64(L1_64)
  if not L1_64 then
    return {}
  end
  if Logic:Get("HeroCardInfo"):kdbSkillConfig(A0_63.hero.powerSkill) ~= nil then
    for _FORV_9_ = 1, #Logic:Get("Hero"):GetHeroInfosByIds(L1_64) do
      Logic:Get("Hero"):GetHeroInfosByIds(L1_64)[_FORV_9_].boolSkill = nil
      if Logic:Get("Hero"):GetHeroInfosByIds(L1_64)[_FORV_9_].locked then
        Logic:Get("Hero"):GetHeroInfosByIds(L1_64)[_FORV_9_].boolSkill = 1
      elseif ({})[Logic:Get("Hero"):GetHeroInfosByIds(L1_64)[_FORV_9_].baseId] then
        table.insert(({})[Logic:Get("Hero"):GetHeroInfosByIds(L1_64)[_FORV_9_].baseId], Logic:Get("Hero"):GetHeroInfosByIds(L1_64)[_FORV_9_].id)
      elseif not Logic:Get("Hero"):GetHeroInfosByIds(L1_64)[_FORV_9_].locked then
        ({})[Logic:Get("Hero"):GetHeroInfosByIds(L1_64)[_FORV_9_].baseId] = {}
        table.insert(({})[Logic:Get("Hero"):GetHeroInfosByIds(L1_64)[_FORV_9_].baseId], Logic:Get("Hero"):GetHeroInfosByIds(L1_64)[_FORV_9_].id)
      end
    end
    for _FORV_9_ = 1, #Logic:Get("HeroCardInfo"):kdbSkillConfig(A0_63.hero.powerSkill).costItems do
      if ({})[tonumber(Logic:Get("HeroCardInfo"):kdbSkillConfig(A0_63.hero.powerSkill).costItems[_FORV_9_])] ~= nil then
        for _FORV_13_ = 1, #({})[tonumber(Logic:Get("HeroCardInfo"):kdbSkillConfig(A0_63.hero.powerSkill).costItems[_FORV_9_])] do
          if Logic:Get("Hero"):GetHeroInfoById(({})[tonumber(Logic:Get("HeroCardInfo"):kdbSkillConfig(A0_63.hero.powerSkill).costItems[_FORV_9_])][_FORV_13_]) ~= nil then
            Logic:Get("Hero"):GetHeroInfoById(({})[tonumber(Logic:Get("HeroCardInfo"):kdbSkillConfig(A0_63.hero.powerSkill).costItems[_FORV_9_])][_FORV_13_]).boolSkill = 0
          end
        end
      end
    end
    for _FORV_9_ = 1, #Logic:Get("Hero"):GetHeroInfosByIds(L1_64) do
      if Logic:Get("Hero"):GetHeroInfosByIds(L1_64)[_FORV_9_].boolSkill == nil then
        Logic:Get("Hero"):GetHeroInfosByIds(L1_64)[_FORV_9_].boolSkill = 1
      end
    end
  end
  return (Logic:Get("Hero"):GetHeroInfosByIds(L1_64))
end
function class.boolCanLvl(A0_65, A1_66)
  if Logic:Get("HeroCardInfo"):kdbSkillConfig(A1_66) ~= nil then
    if table.empty(A0_65.skillHero) then
      return 1
    end
    for _FORV_6_ = 1, #Logic:Get("HeroCardInfo"):kdbSkillConfig(A1_66).costItems do
      if A0_65.skillHero[tonumber(Logic:Get("HeroCardInfo"):kdbSkillConfig(A1_66).costItems[_FORV_6_])] ~= nil then
        return 0
      end
    end
    return _FOR_
  end
end
function class.GetFullOfExpAmount(A0_67, A1_68)
end
function class.SetSkillCard(A0_69, A1_70)
  A0_69.skillHero = A1_70
end
function class.SetBaseIdKey(A0_71, A1_72)
  A0_71.skillCardForBaseId = {}
  if not table.empty(A1_72) then
    for _FORV_5_, _FORV_6_ in pairs(A1_72) do
      if A0_71.skillCardForBaseId[_FORV_6_.baseId] then
        table.insert(A0_71.skillCardForBaseId[_FORV_6_.baseId], _FORV_6_.id)
      else
        A0_71.skillCardForBaseId[_FORV_6_.baseId] = {}
        table.insert(A0_71.skillCardForBaseId[_FORV_6_.baseId], _FORV_6_.id)
      end
    end
  end
end
function class.GetSprTrea(A0_73, A1_74)
  local L2_75, L3_76, L4_77, L5_78, L6_79
  if A1_74 == nil then
    return
  end
  L2_75 = CCSprite
  L3_76 = L2_75
  L2_75 = L2_75.create
  L4_77 = "images/public/herobg.png"
  L2_75 = L2_75(L3_76, L4_77)
  L3_76 = Logic
  L4_77 = L3_76
  L3_76 = L3_76.Get
  L5_78 = "Hero"
  L3_76 = L3_76(L4_77, L5_78)
  L4_77 = L3_76
  L3_76 = L3_76.GetHeroBgImage
  L5_78 = A1_74
  L3_76 = L3_76(L4_77, L5_78)
  L4_77 = Logic
  L5_78 = L4_77
  L4_77 = L4_77.Get
  L6_79 = "Hero"
  L4_77 = L4_77(L5_78, L6_79)
  L5_78 = L4_77
  L4_77 = L4_77.GetHeroImage
  L6_79 = A1_74
  L4_77 = L4_77(L5_78, L6_79)
  if L3_76 == nil or L4_77 == nil then
    L5_78 = log4misc
    L6_79 = L5_78
    L5_78 = L5_78.warn
    L5_78(L6_79, "Hero.baseId:" .. A1_74)
    L3_76 = "images/public/herobg.png"
    L5_78 = CCSprite
    L6_79 = L5_78
    L5_78 = L5_78.create
    L5_78 = L5_78(L6_79, L3_76)
    return L5_78
  end
  L5_78 = CCSprite
  L6_79 = L5_78
  L5_78 = L5_78.create
  L5_78 = L5_78(L6_79, L3_76)
  L6_79 = CCSprite
  L6_79 = L6_79.create
  L6_79 = L6_79(L6_79, L4_77)
  if L5_78 == nil or L6_79 == nil then
    return L2_75
  end
  L2_75:addChild(L5_78, 0, 99)
  L5_78:setAnchorPoint(CCPoint(0, 0))
  L2_75:addChild(L6_79, 0, 98)
  L6_79:setAnchorPoint(CCPoint(0, 0))
  L2_75:setAnchorPoint(CCPoint(0.5, 0.5))
  return L2_75
end
function class.IsGetTrea(A0_80)
  if KFDBGetRecord("RankConfig", 1) ~= nil then
    if Logic:Get("PlayerInfo"):GetPlayerMoney().copper >= KFDBGetRecord("RankConfig", 1).costs then
      return true
    else
      return false
    end
  else
    return false
  end
end
function class.GetTreaRewStrTip(A0_81, A1_82, A2_83)
  local L3_84, L4_85, L5_86, L6_87, L7_88, L8_89, L9_90, L10_91, L11_92
  L3_84 = {}
  L4_85 = {}
  L3_84[1] = L4_85
  L4_85 = L3_84[1]
  L5_86 = TwGetStr
  L6_87 = 103077
  L5_86 = L5_86(L6_87)
  L4_85.strR = L5_86
  L4_85 = L3_84[1]
  L4_85.strK = 7
  L4_85 = 2
  L5_86 = Logic
  L6_87 = L5_86
  L5_86 = L5_86.Get
  L5_86 = L5_86(L6_87, L7_88)
  L6_87 = L5_86
  L5_86 = L5_86.comRewards
  L5_86 = L5_86(L6_87, L7_88)
  L6_87 = L5_86[0]
  L5_86[0] = nil
  for L10_91, L11_92 in L7_88(L8_89) do
    L3_84[L4_85] = {}
    L3_84[L4_85].strR = Logic:Get("Reward"):RewardTreaTip(L11_92)
    if KFDBGetRecord("BaseHero", L11_92.code) ~= nil then
      L3_84[L4_85].strK = KFDBGetRecord("BaseHero", L11_92.code).rank
    else
      L3_84[L4_85].strK = 1
    end
    L4_85 = L4_85 + 1
  end
  if A2_83 > 0 then
    L3_84[L4_85] = L7_88
    L7_88.strR = ""
    L7_88.strK = 7
    L3_84[L7_88] = L8_89
    L7_88.strR = L8_89
    L7_88.strK = 7
    L3_84[L7_88] = L8_89
    L7_88.strR = L8_89
    L7_88.strK = 7
    L3_84[L7_88] = L8_89
    L7_88.strR = L8_89
    L7_88.strK = 7
  end
  L8_89.strR = ""
  L8_89.strK = 7
  if L9_90 < 10 then
    for _FORV_12_ = 1, L10_91(L11_92) do
      table.insert(L7_88, L8_89)
    end
    for _FORV_12_ = 1, #L3_84 do
      table.insert(L7_88, L3_84[_FORV_12_])
    end
    return L7_88
  else
    return L3_84
  end
end
function class.setHunting(A0_93, A1_94)
  A0_93.hunting = A1_94 or nil
end
function class.isHunting(A0_95)
  local L1_96
  L1_96 = A0_95.hunting
  return L1_96
end
function class.setDrawing(A0_97, A1_98)
  A0_97.drawing = A1_98 or nil
end
function class.isDrawing(A0_99)
  local L1_100
  L1_100 = A0_99.drawing
  return L1_100
end
