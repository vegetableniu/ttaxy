module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
CLARITY_PATH = "images/public/clarity05.png"
function prototype.initialize(A0_0, ...)
  local L3_2, L4_3
  L3_2 = super
  L3_2 = L3_2.initialize
  L4_3 = A0_0
  L3_2(L4_3, ...)
end
function prototype.dispose(A0_4, ...)
  super.dispose(A0_4)
end
function prototype.onEnter(A0_6)
  A0_6.ttfName:setStyle(kCCLabelTTFStyleOutline)
  A0_6.ttfRank:setStyle(kCCLabelTTFStyleOutline)
  A0_6.ttfLevel:setStyle(kCCLabelTTFStyleOutline)
  A0_6.ttfReward:setStyle(kCCLabelTTFStyleOutline)
  A0_6.ttfRewardRank:setStyle(kCCLabelTTFStyleOutline)
end
function prototype.onNodeLoaded(A0_7, A1_8, A2_9)
end
function prototype.RefreshRewardInfo(A0_10, A1_11)
  if A1_11 == nil then
    return
  end
  A0_10.info = A1_11
  A0_10.rankLayer:setVisible(false)
  A0_10.rewardLayer:setVisible(false)
  A0_10.rankType = Logic:Get("Pvp"):GetRankType()
  if A0_10.rankType == Logic.Pvp.RANK_TYPE.RANK_REWARD then
    A0_10.rankLayer:setVisible(false)
    A0_10.rewardLayer:setVisible(true)
    A0_10:loadReward(A1_11)
    return
  end
  A0_10.rankLayer:setVisible(true)
  A0_10.rewardLayer:setVisible(false)
  A0_10:loadRank(A1_11)
end
function prototype.onBtnHeroClicked(A0_12)
  local L1_13
  L1_13 = {}
  L1_13.exp = 0
  L1_13.id = 68719480211
  L1_13.level = A0_12.info.leaderLevel or 1
  L1_13.baseId = A0_12.info.leaderBaseId
  L1_13.powerSkill = 0
  L1_13.talisman = A0_12.info.leaderTalisman
  L1_13.equips = A0_12.info.leaderEquip
  L1_13.userBuffs = A0_12.info.userBuffs
  L1_13.artifactLevel = A0_12.info.artifactLevel
  L1_13.otherPlayer = true
  L1_13.cultivateVo = A0_12.info.cultivateVo
  Logic:Get("HeroCardInfo"):OpenHeroInfoByNparma(L1_13)
end
function prototype.loadReward(A0_14, A1_15)
  if A1_15.topRank == A1_15.lowRank then
    A0_14.ttfRewardRank:setString(TwGetStr(105512, A1_15.topRank or 0))
  else
    A0_14.ttfRewardRank:setString(TwGetStr(105517, A1_15.topRank or 0, A1_15.lowRank or 0))
  end
  A0_14.ttfReward:setString(A1_15.name or "")
  if A0_14.rewardTextOriginX == nil then
    A0_14.rewardTextOriginX = A0_14.ttfReward:getPositionX()
  end
  A0_14.ttfReward:setPositionX(A0_14.rewardTextOriginX - 140)
end
function prototype.loadRank(A0_16, A1_17)
  local L2_18, L3_19, L4_20, L5_21, L6_22, L7_23, L8_24, L9_25, L10_26
  L2_18 = CCSprite
  L3_19 = L2_18
  L2_18 = L2_18.create
  L4_20 = CLARITY_PATH
  L2_18 = L2_18(L3_19, L4_20)
  if L2_18 then
    L3_19 = A0_16.sprTitle1
    L4_20 = L3_19
    L3_19 = L3_19.setDisplayFrame
    L6_22 = L2_18
    L5_21 = L2_18.displayFrame
    L10_26 = L5_21(L6_22)
    L3_19(L4_20, L5_21, L6_22, L7_23, L8_24, L9_25, L10_26, L5_21(L6_22))
    L3_19 = A0_16.sprTitle2
    L4_20 = L3_19
    L3_19 = L3_19.setDisplayFrame
    L6_22 = L2_18
    L5_21 = L2_18.displayFrame
    L10_26 = L5_21(L6_22)
    L3_19(L4_20, L5_21, L6_22, L7_23, L8_24, L9_25, L10_26, L5_21(L6_22))
  end
  L3_19 = Logic
  L4_20 = L3_19
  L3_19 = L3_19.Get
  L5_21 = "Hero"
  L3_19 = L3_19(L4_20, L5_21)
  L4_20 = L3_19
  L3_19 = L3_19.GetHeroImage
  L5_21 = A1_17.leaderBaseId
  L3_19 = L3_19(L4_20, L5_21)
  L4_20 = CCSprite
  L5_21 = L4_20
  L4_20 = L4_20.create
  L6_22 = L3_19
  L4_20 = L4_20(L5_21, L6_22)
  if L4_20 then
    L5_21 = A0_16.heroIcon
    L6_22 = L5_21
    L5_21 = L5_21.setDisplayFrame
    L8_24 = L4_20
    L7_23 = L4_20.displayFrame
    L10_26 = L7_23(L8_24)
    L5_21(L6_22, L7_23, L8_24, L9_25, L10_26, L7_23(L8_24))
  end
  L5_21 = Logic
  L6_22 = L5_21
  L5_21 = L5_21.Get
  L7_23 = "Hero"
  L5_21 = L5_21(L6_22, L7_23)
  L6_22 = L5_21
  L5_21 = L5_21.GetHeroBgImage
  L7_23 = A1_17.leaderBaseId
  L6_22 = L5_21(L6_22, L7_23)
  L7_23 = CCSprite
  L8_24 = L7_23
  L7_23 = L7_23.create
  L9_25 = L5_21
  L7_23 = L7_23(L8_24, L9_25)
  if L7_23 then
    L8_24 = A0_16.heroBg
    L9_25 = L8_24
    L8_24 = L8_24.setDisplayFrame
    L10_26 = L7_23.displayFrame
    L10_26 = L10_26(L7_23)
    L8_24(L9_25, L10_26, L10_26(L7_23))
  end
  L8_24 = Logic
  L9_25 = L8_24
  L8_24 = L8_24.Get
  L10_26 = "HeroCardInfo"
  L8_24 = L8_24(L9_25, L10_26)
  L9_25 = L8_24
  L8_24 = L8_24.AddShanCardSmall
  L10_26 = A0_16.heroIcon
  L8_24(L9_25, L10_26, A1_17.leaderBaseId)
  L8_24 = Logic
  L9_25 = L8_24
  L8_24 = L8_24.Get
  L10_26 = "PlayerInfo"
  L8_24 = L8_24(L9_25, L10_26)
  L9_25 = L8_24
  L8_24 = L8_24.GetPlayerName
  L8_24 = L8_24(L9_25)
  L9_25 = A1_17.name
  if L9_25 == L8_24 then
    L9_25 = A0_16.ttfName
    L10_26 = L9_25
    L9_25 = L9_25.setColor
    L9_25(L10_26, ccColor3B(255, 0, 0))
  else
    L9_25 = A0_16.ttfName
    L10_26 = L9_25
    L9_25 = L9_25.setColor
    L9_25(L10_26, ccColor3B(255, 255, 255))
  end
  L9_25 = A0_16.ttfName
  L10_26 = L9_25
  L9_25 = L9_25.setString
  L9_25(L10_26, A1_17.name)
  L9_25 = A0_16.ttfRank
  L10_26 = L9_25
  L9_25 = L9_25.setString
  L9_25(L10_26, A1_17.rank)
  L9_25 = A0_16.ttfLevel
  L10_26 = L9_25
  L9_25 = L9_25.setString
  L9_25(L10_26, TwGetStr(105305, A1_17.level))
  L9_25 = A1_17.battleScore
  if L9_25 then
    L9_25 = A1_17.battleScore
    if L9_25 >= 0 then
      L9_25 = A0_16.nodBattle
      L10_26 = L9_25
      L9_25 = L9_25.create
      L9_25(L10_26, 0, "YELLOW_E_NUM")
      L9_25 = A0_16.nodBattle
      L10_26 = L9_25
      L9_25 = L9_25.setAlign
      L9_25(L10_26, "LEFT", "CENTER")
      L9_25 = A0_16.nodBattle
      L10_26 = L9_25
      L9_25 = L9_25.setValue
      L9_25(L10_26, A1_17.battleScore)
    end
  end
  L9_25 = Logic
  L10_26 = L9_25
  L9_25 = L9_25.Get
  L9_25 = L9_25(L10_26, "Pvp")
  L10_26 = L9_25
  L9_25 = L9_25.GetRecordByDesId
  L9_25 = L9_25(L10_26, A1_17.desId)
  if L9_25 then
    L10_26 = L9_25.icoPath
    if L10_26 ~= "" then
      L10_26 = CCSprite
      L10_26 = L10_26.create
      L10_26 = L10_26(L10_26, L9_25.logoPath)
      if L10_26 then
        A0_16.sprTitle1:setDisplayFrame(L10_26:displayFrame())
      end
      L10_26 = CCSprite:create(L9_25.icoPath)
      if L10_26 then
        A0_16.sprTitle2:setDisplayFrame(L10_26:displayFrame())
      end
    end
  end
end
