module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
function prototype.onEnter(A0_0)
  local L1_1, L2_2, L3_3, L4_4, L5_5, L6_6, L7_7
  L1_1 = Logic
  L2_2 = L1_1
  L1_1 = L1_1.Get
  L1_1 = L1_1(L2_2, L3_3)
  L2_2 = L1_1
  L1_1 = L1_1.getActiveId
  L1_1 = L1_1(L2_2)
  L2_2 = Logic
  L2_2 = L2_2.Get
  L2_2 = L2_2(L3_3, L4_4)
  L2_2 = L2_2.getRankGroupId
  L2_2 = L2_2(L3_3)
  if L2_2 and L2_2 > 0 then
    L1_1 = L3_3
  end
  A0_0.rewardCard = L3_3
  A0_0.heroInfo = L3_3
  A0_0.heroMaxStarInfo = L3_3
  if L1_1 then
    for L6_6 = 1, L4_4(L5_5) do
      L7_7 = KFDBGetRecordByIdx
      L7_7 = L7_7("FragmentExchange", L6_6)
      if L7_7 and L7_7.activeId == L1_1 then
        table.insert(A0_0.rewardCard, L7_7)
        break
      end
    end
  end
  if L3_3 ~= nil then
    if L3_3 ~= nil then
      L3_3(L4_4, L5_5)
      L3_3(L4_4)
      L3_3(L4_4, L5_5)
    end
  else
    L3_3(L4_4, L5_5)
    L3_3(L4_4, L5_5)
    L3_3(L4_4, L5_5)
    L3_3(L4_4, L5_5)
    L3_3(L4_4, L5_5)
  end
end
function prototype.RefreshCardInfo(A0_8, A1_9)
  local L2_10, L3_11, L4_12, L5_13, L6_14, L7_15
  if A1_9 == nil then
    return
  end
  L2_10 = A0_8.heroMaxStarInfo
  L2_10 = L2_10.level
  L3_11 = A0_8.staLevel
  L4_12 = L3_11
  L3_11 = L3_11.create
  L5_13 = 0
  L6_14 = "YELLOW_E_NUM"
  L3_11(L4_12, L5_13, L6_14)
  L3_11 = A0_8.staLevel
  L4_12 = L3_11
  L3_11 = L3_11.setAlign
  L5_13 = "CENTER"
  L6_14 = "CENTER"
  L3_11(L4_12, L5_13, L6_14)
  L3_11 = A0_8.staLevel
  L4_12 = L3_11
  L3_11 = L3_11.setValue
  L5_13 = L2_10 or 1
  L3_11(L4_12, L5_13)
  L3_11 = Logic
  L4_12 = L3_11
  L3_11 = L3_11.Get
  L5_13 = "Hero"
  L3_11 = L3_11(L4_12, L5_13)
  L4_12 = L3_11
  L3_11 = L3_11.GetHeroName
  L5_13 = A1_9
  L3_11 = L3_11(L4_12, L5_13)
  if L3_11 then
    L4_12 = A0_8.staName
    L5_13 = L4_12
    L4_12 = L4_12.setStyle
    L6_14 = kCCLabelTTFStyleOutline
    L4_12(L5_13, L6_14)
    L4_12 = A0_8.staName
    L5_13 = L4_12
    L4_12 = L4_12.setString
    L6_14 = L3_11
    L4_12(L5_13, L6_14)
  end
  L4_12 = Logic
  L5_13 = L4_12
  L4_12 = L4_12.Get
  L6_14 = "Hero"
  L4_12 = L4_12(L5_13, L6_14)
  L5_13 = L4_12
  L4_12 = L4_12.GetHeroLifeAndAttack
  L6_14 = A1_9
  L7_15 = L2_10
  L5_13 = L4_12(L5_13, L6_14, L7_15)
  if L4_12 and L5_13 then
    L6_14 = A0_8.staLife
    L7_15 = L6_14
    L6_14 = L6_14.setStyle
    L6_14(L7_15, kCCLabelTTFStyleOutline)
    L6_14 = A0_8.staAttack
    L7_15 = L6_14
    L6_14 = L6_14.setStyle
    L6_14(L7_15, kCCLabelTTFStyleOutline)
    L6_14 = A0_8.staLife
    L7_15 = L6_14
    L6_14 = L6_14.setString
    L6_14(L7_15, tostring(L4_12))
    L6_14 = A0_8.staAttack
    L7_15 = L6_14
    L6_14 = L6_14.setString
    L6_14(L7_15, tostring(L5_13))
  end
  L6_14 = Logic
  L7_15 = L6_14
  L6_14 = L6_14.Get
  L6_14 = L6_14(L7_15, "HeroCardInfo")
  L7_15 = L6_14
  L6_14 = L6_14.GetSprCard
  L6_14 = L6_14(L7_15, A1_9, nil, true)
  if L6_14 then
    L7_15 = Logic
    L7_15 = L7_15.Get
    L7_15 = L7_15(L7_15, "HeroCardInfo")
    L7_15 = L7_15.GetCardTexture
    L7_15 = L7_15(L7_15, L6_14)
    A0_8.iconBg:setTexture(L7_15)
    A0_8.iconBg:setTextureRect(L6_14:getTextureRect())
  end
  L7_15 = Logic
  L7_15 = L7_15.Get
  L7_15 = L7_15(L7_15, "HeroCardInfo")
  L7_15 = L7_15.AddShanCard
  L7_15(L7_15, A0_8.iconBg, A1_9, nil, nil, true)
  L7_15 = A0_8.rewardCard
  if L7_15 ~= nil then
    L7_15 = A0_8.rewardCard
    L7_15 = L7_15[1]
    L7_15 = L7_15.desc
    if L7_15 ~= nil then
      L7_15 = A0_8.staString
      L7_15 = L7_15.setDimensions
      L7_15(L7_15, CCSize(450, 0))
      L7_15 = A0_8.staString
      L7_15 = L7_15.setString
      L7_15(L7_15, A0_8.rewardCard[1].desc)
    end
  end
end
function prototype.findHeroMaxStarInfo(A0_16, A1_17)
  local L2_18
  L2_18 = KFDBGetRecord
  L2_18 = L2_18("BaseHero", A1_17)
  if L2_18 == nil or next(L2_18) == nil then
    return
  end
  for _FORV_6_ = L2_18.star, 12 do
    if L2_18.nextId ~= -1 then
      L2_18 = KFDBGetRecord("BaseHero", L2_18.nextId)
    else
      break
    end
  end
  A0_16.heroMaxStarInfo = L2_18
end
function prototype.createHeroInfo(A0_19)
  if A0_19.heroMaxStarInfo == nil or next(A0_19.heroMaxStarInfo) == nil then
    return
  end
  A0_19.heroInfo = {
    baseId = A0_19.heroMaxStarInfo.id,
    level = A0_19.heroMaxStarInfo.level,
    powerSkill = tonumber(A0_19.heroMaxStarInfo.powerSkill)
  }
end
function prototype.onBtnReturnHarm(A0_20)
  Logic:Get("Devil"):FireEvent(Logic.Devil.EVT.PAGE_CHANGE, 3)
end
function prototype.onBtnHeroImage(A0_21)
  if A0_21.heroInfo == nil or next(A0_21.heroInfo) == nil then
    return
  end
  Logic:Get("HeroCardInfo"):OpenHeroInfoByNparma(A0_21.heroInfo)
end
