local L0_0
L0_0 = module
L0_0((...), package.seeall)
L0_0 = require
L0_0("SceneHelper")
L0_0 = TypeDef
L0_0 = L0_0("com.eyu.mt.module.reward.model.RewardType")
prototype = Tw.Controller.prototype:extend()
function prototype.initialize(A0_1, ...)
  local L3_3, L4_4
  L3_3 = super
  L3_3 = L3_3.initialize
  L4_4 = A0_1
  L3_3(L4_4, ...)
end
function prototype.dispose(A0_5, ...)
  super.dispose(A0_5)
end
function prototype.onEnter(A0_7)
  local L1_8, L2_9, L3_10, L4_11, L5_12, L6_13, L7_14, L8_15, L9_16, L10_17, L11_18, L12_19, L13_20, L14_21, L15_22, L16_23, L17_24, L18_25, L19_26, L20_27, L21_28
  L1_8 = Logic
  L2_9 = L1_8
  L1_8 = L1_8.Get
  L3_10 = "Pvp"
  L1_8 = L1_8(L2_9, L3_10)
  L2_9 = L1_8
  L1_8 = L1_8.IsPvp
  L1_8 = L1_8(L2_9)
  if L1_8 then
    L1_8 = SceneHelper
    L2_9 = L1_8
    L1_8 = L1_8.pushScene
    L3_10 = "PvpResult"
    L4_11 = A0_7.rootNode
    L1_8(L2_9, L3_10, L4_11)
    return
  end
  L1_8 = A0_7.ttfGetPoints
  L2_9 = L1_8
  L1_8 = L1_8.setVisible
  L3_10 = false
  L1_8(L2_9, L3_10)
  L1_8 = A0_7.ttfIntegral
  L2_9 = L1_8
  L1_8 = L1_8.setVisible
  L3_10 = false
  L1_8(L2_9, L3_10)
  L1_8 = Logic
  L2_9 = L1_8
  L1_8 = L1_8.Get
  L3_10 = "Fight"
  L1_8 = L1_8(L2_9, L3_10)
  L2_9 = L1_8
  L1_8 = L1_8.On
  L3_10 = Logic
  L3_10 = L3_10.Fight
  L3_10 = L3_10.EVT
  L3_10 = L3_10.SHOW_COMPARE
  L5_12 = A0_7
  L4_11 = A0_7.Event
  L6_13 = "showCompare"
  L21_28 = L4_11(L5_12, L6_13)
  L1_8(L2_9, L3_10, L4_11, L5_12, L6_13, L7_14, L8_15, L9_16, L10_17, L11_18, L12_19, L13_20, L14_21, L15_22, L16_23, L17_24, L18_25, L19_26, L20_27, L21_28, L4_11(L5_12, L6_13))
  L1_8 = Logic
  L2_9 = L1_8
  L1_8 = L1_8.Get
  L3_10 = "Mall"
  L1_8 = L1_8(L2_9, L3_10)
  L2_9 = L1_8
  L1_8 = L1_8.On
  L3_10 = Logic
  L3_10 = L3_10.Mall
  L3_10 = L3_10.EVT
  L3_10 = L3_10.GET_LOTTERY_LIST
  L5_12 = A0_7
  L4_11 = A0_7.Event
  L6_13 = "onGetLotteryList"
  L21_28 = L4_11(L5_12, L6_13)
  L1_8(L2_9, L3_10, L4_11, L5_12, L6_13, L7_14, L8_15, L9_16, L10_17, L11_18, L12_19, L13_20, L14_21, L15_22, L16_23, L17_24, L18_25, L19_26, L20_27, L21_28, L4_11(L5_12, L6_13))
  L1_8 = Logic
  L2_9 = L1_8
  L1_8 = L1_8.Get
  L3_10 = "BattleShow"
  L1_8 = L1_8(L2_9, L3_10)
  L2_9 = L1_8
  L1_8 = L1_8.CleanUp
  L1_8(L2_9)
  L1_8 = A0_7.ttfGetPoints
  L2_9 = L1_8
  L1_8 = L1_8.setString
  L3_10 = TwGetStr
  L4_11 = 105328
  L21_28 = L3_10(L4_11)
  L1_8(L2_9, L3_10, L4_11, L5_12, L6_13, L7_14, L8_15, L9_16, L10_17, L11_18, L12_19, L13_20, L14_21, L15_22, L16_23, L17_24, L18_25, L19_26, L20_27, L21_28, L3_10(L4_11))
  L1_8 = Logic
  L2_9 = L1_8
  L1_8 = L1_8.Get
  L3_10 = "Fight"
  L1_8 = L1_8(L2_9, L3_10)
  L2_9 = L1_8
  L1_8 = L1_8.GetDefyIntegral
  L1_8 = L1_8(L2_9)
  L2_9 = A0_7.ttfIntegral
  L3_10 = L2_9
  L2_9 = L2_9.setString
  L4_11 = L1_8 or 0
  L2_9(L3_10, L4_11)
  L2_9 = Logic
  L3_10 = L2_9
  L2_9 = L2_9.Get
  L4_11 = "Fight"
  L2_9 = L2_9(L3_10, L4_11)
  L3_10 = L2_9
  L2_9 = L2_9.isGuideFightDraw
  L2_9 = L2_9(L3_10)
  if L2_9 then
    L2_9 = A0_7.btnCompare
    L3_10 = L2_9
    L2_9 = L2_9.setVisible
    L4_11 = false
    L2_9(L3_10, L4_11)
    L2_9 = A0_7.sprCompare
    L3_10 = L2_9
    L2_9 = L2_9.setVisible
    L4_11 = false
    L2_9(L3_10, L4_11)
    L2_9 = A0_7.btnClose
    L3_10 = L2_9
    L2_9 = L2_9.setPositionX
    L4_11 = 320
    L2_9(L3_10, L4_11)
    L2_9 = A0_7.sprClose
    L3_10 = L2_9
    L2_9 = L2_9.setPositionX
    L4_11 = 320
    L2_9(L3_10, L4_11)
  end
  L2_9 = SceneHelper
  L3_10 = L2_9
  L2_9 = L2_9.removeScene
  L4_11 = "EmbattleGroup"
  L2_9(L3_10, L4_11)
  L2_9 = Logic
  L3_10 = L2_9
  L2_9 = L2_9.Get
  L4_11 = "Fight"
  L2_9 = L2_9(L3_10, L4_11)
  L3_10 = L2_9
  L2_9 = L2_9.GetSuccess
  L2_9 = L2_9(L3_10)
  L3_10 = nil
  L4_11 = A0_7.btnUpgrade
  L5_12 = L4_11
  L4_11 = L4_11.setVisible
  L6_13 = not L2_9
  L4_11(L5_12, L6_13)
  if L2_9 then
    L4_11 = CCSprite
    L5_12 = L4_11
    L4_11 = L4_11.create
    L6_13 = _UPVALUE0_
    L4_11 = L4_11(L5_12, L6_13)
    L3_10 = L4_11
    L4_11 = A0_7.sprGetFra
    L5_12 = L4_11
    L4_11 = L4_11.setVisible
    L6_13 = false
    L4_11(L5_12, L6_13)
    L4_11 = A0_7.btnLottery
    L5_12 = L4_11
    L4_11 = L4_11.setVisible
    L6_13 = false
    L4_11(L5_12, L6_13)
    L4_11 = A0_7.sprFailDecr
    L5_12 = L4_11
    L4_11 = L4_11.setVisible
    L6_13 = false
    L4_11(L5_12, L6_13)
  else
    L4_11 = CCSprite
    L5_12 = L4_11
    L4_11 = L4_11.create
    L6_13 = _UPVALUE1_
    L4_11 = L4_11(L5_12, L6_13)
    L3_10 = L4_11
    L4_11 = A0_7.sprGetFra
    L5_12 = L4_11
    L4_11 = L4_11.setVisible
    L6_13 = false
    L4_11(L5_12, L6_13)
    L4_11 = A0_7.btnLottery
    L5_12 = L4_11
    L4_11 = L4_11.setVisible
    L6_13 = true
    L4_11(L5_12, L6_13)
    L4_11 = A0_7.sprFailDecr
    L5_12 = L4_11
    L4_11 = L4_11.setVisible
    L6_13 = true
    L4_11(L5_12, L6_13)
  end
  if L3_10 then
    L4_11 = A0_7.sprTitle
    L5_12 = L4_11
    L4_11 = L4_11.setDisplayFrame
    L7_14 = L3_10
    L6_13 = L3_10.displayFrame
    L21_28 = L6_13(L7_14)
    L4_11(L5_12, L6_13, L7_14, L8_15, L9_16, L10_17, L11_18, L12_19, L13_20, L14_21, L15_22, L16_23, L17_24, L18_25, L19_26, L20_27, L21_28, L6_13(L7_14))
  end
  L4_11 = Logic
  L5_12 = L4_11
  L4_11 = L4_11.Get
  L6_13 = "Lock"
  L4_11 = L4_11(L5_12, L6_13)
  L5_12 = L4_11
  L4_11 = L4_11.GetStatusByLockId
  L6_13 = Logic
  L6_13 = L6_13.Lock
  L6_13 = L6_13.LOCK_ID
  L6_13 = L6_13.MALL
  L4_11 = L4_11(L5_12, L6_13)
  L5_12 = A0_7.btnLottery
  L6_13 = L5_12
  L5_12 = L5_12.setVisible
  L7_14 = false
  L5_12(L6_13, L7_14)
  if L4_11 then
  end
  L5_12 = Logic
  L6_13 = L5_12
  L5_12 = L5_12.Get
  L7_14 = "PlayerInfo"
  L5_12 = L5_12(L6_13, L7_14)
  L6_13 = L5_12
  L5_12 = L5_12.GetPlayerName
  L5_12 = L5_12(L6_13)
  L6_13 = Logic
  L7_14 = L6_13
  L6_13 = L6_13.Get
  L8_15 = "Fight"
  L6_13 = L6_13(L7_14, L8_15)
  L7_14 = L6_13
  L6_13 = L6_13.GetFighter
  L6_13 = L6_13(L7_14)
  L7_14 = A0_7.ttfPlayerName
  L8_15 = L7_14
  L7_14 = L7_14.setString
  L9_16 = L5_12
  L7_14(L8_15, L9_16)
  L7_14 = A0_7.ttfFighterName
  L8_15 = L7_14
  L7_14 = L7_14.setString
  L9_16 = L6_13.name
  L7_14(L8_15, L9_16)
  L7_14 = Logic
  L8_15 = L7_14
  L7_14 = L7_14.Get
  L9_16 = "Hero"
  L7_14 = L7_14(L8_15, L9_16)
  L8_15 = L7_14
  L7_14 = L7_14.GetLeaderId
  L7_14 = L7_14(L8_15)
  L8_15 = Logic
  L9_16 = L8_15
  L8_15 = L8_15.Get
  L10_17 = "Hero"
  L8_15 = L8_15(L9_16, L10_17)
  L9_16 = L8_15
  L8_15 = L8_15.GetHeroInfoById
  L10_17 = L7_14
  L8_15 = L8_15(L9_16, L10_17)
  L8_15 = L8_15.baseId
  L9_16 = Logic
  L10_17 = L9_16
  L9_16 = L9_16.Get
  L11_18 = "Hero"
  L9_16 = L9_16(L10_17, L11_18)
  L10_17 = L9_16
  L9_16 = L9_16.GetHeroImage
  L11_18 = L8_15
  L9_16 = L9_16(L10_17, L11_18)
  L10_17 = CCSprite
  L11_18 = L10_17
  L10_17 = L10_17.create
  L12_19 = L9_16
  L10_17 = L10_17(L11_18, L12_19)
  if L10_17 then
    L11_18 = A0_7.playerIcon
    L12_19 = L11_18
    L11_18 = L11_18.setDisplayFrame
    L13_20 = L10_17.displayFrame
    L21_28 = L13_20(L14_21)
    L11_18(L12_19, L13_20, L14_21, L15_22, L16_23, L17_24, L18_25, L19_26, L20_27, L21_28, L13_20(L14_21))
  end
  L11_18 = Logic
  L12_19 = L11_18
  L11_18 = L11_18.Get
  L13_20 = "Hero"
  L11_18 = L11_18(L12_19, L13_20)
  L12_19 = L11_18
  L11_18 = L11_18.GetHeroBgImage
  L13_20 = L8_15
  L11_18 = L11_18(L12_19, L13_20)
  L12_19 = CCSprite
  L13_20 = L12_19
  L12_19 = L12_19.create
  L12_19 = L12_19(L13_20, L14_21)
  if L12_19 then
    L13_20 = A0_7.playerBg
    L13_20 = L13_20.setDisplayFrame
    L21_28 = L15_22(L16_23)
    L13_20(L14_21, L15_22, L16_23, L17_24, L18_25, L19_26, L20_27, L21_28, L15_22(L16_23))
  end
  L13_20 = Logic
  L13_20 = L13_20.Get
  L13_20 = L13_20(L14_21, L15_22)
  L13_20 = L13_20.AddShanCardSmall
  L13_20(L14_21, L15_22, L16_23)
  L13_20 = Logic
  L13_20 = L13_20.Get
  L13_20 = L13_20(L14_21, L15_22)
  L13_20 = L13_20.GetHeroImage
  L13_20 = L13_20(L14_21, L15_22)
  L9_16 = L13_20
  L13_20 = CCSprite
  L13_20 = L13_20.create
  L13_20 = L13_20(L14_21, L15_22)
  L10_17 = L13_20
  if L10_17 then
    L13_20 = A0_7.fighterIcon
    L13_20 = L13_20.setDisplayFrame
    L21_28 = L15_22(L16_23)
    L13_20(L14_21, L15_22, L16_23, L17_24, L18_25, L19_26, L20_27, L21_28, L15_22(L16_23))
  end
  L13_20 = Logic
  L13_20 = L13_20.Get
  L13_20 = L13_20(L14_21, L15_22)
  L13_20 = L13_20.GetHeroBgImage
  L13_20 = L13_20(L14_21, L15_22)
  L11_18 = L13_20
  L13_20 = CCSprite
  L13_20 = L13_20.create
  L13_20 = L13_20(L14_21, L15_22)
  L12_19 = L13_20
  if L12_19 then
    L13_20 = A0_7.fighterBg
    L13_20 = L13_20.setDisplayFrame
    L21_28 = L15_22(L16_23)
    L13_20(L14_21, L15_22, L16_23, L17_24, L18_25, L19_26, L20_27, L21_28, L15_22(L16_23))
  end
  L13_20 = Logic
  L13_20 = L13_20.Get
  L13_20 = L13_20(L14_21, L15_22)
  L13_20 = L13_20.AddShanCardSmall
  L13_20(L14_21, L15_22, L16_23)
  L13_20 = Logic
  L13_20 = L13_20.Get
  L13_20 = L13_20(L14_21, L15_22)
  L13_20 = L13_20.GetRewards
  L13_20 = L13_20(L14_21)
  if L13_20 == nil then
    return
  end
  for L17_24, L18_25 in L14_21(L15_22) do
    L19_26 = L18_25.type
    L20_27 = _UPVALUE2_
    L20_27 = L20_27.CURRENCY
    if L19_26 == L20_27 then
    else
      L19_26 = L18_25.type
      L20_27 = _UPVALUE2_
      L20_27 = L20_27.FRAGMENT
      if L19_26 == L20_27 then
        L19_26 = Logic
        L20_27 = L19_26
        L19_26 = L19_26.Get
        L21_28 = "Equip"
        L19_26 = L19_26(L20_27, L21_28)
        L20_27 = L19_26
        L19_26 = L19_26.GetComposeImg
        L21_28 = L18_25.contents
        L21_28 = L21_28[1]
        L21_28 = L21_28.baseId
        L19_26 = L19_26(L20_27, L21_28)
        if L19_26 == nil then
          return
        end
        L20_27 = Logic
        L21_28 = L20_27
        L20_27 = L20_27.Get
        L20_27 = L20_27(L21_28, "HeroCardInfo")
        L21_28 = L20_27
        L20_27 = L20_27.GetCardTexture
        L21_28 = L20_27(L21_28, L19_26, L19_26:getContentSize())
        if L20_27 and L21_28 then
          A0_7.sprFraBg:setTexture(L20_27)
          A0_7.sprFraBg:setTextureRect(L21_28)
          A0_7.sprFraBg:setVisible(true)
        end
      end
    end
  end
end
function prototype.onExit(A0_29)
  Logic:Get("Fight"):clearCompareData()
end
function prototype.onNodeLoaded(A0_30, A1_31, A2_32)
end
function prototype.showCompare(A0_33)
  SceneHelper:pushScene("FightCompare", A0_33.rootNode)
end
function prototype.onBtnCompareClicked(A0_34, A1_35, A2_36)
  if Logic:Get("Fight"):GetOwn() == nil or Logic:Get("Fight"):GetEnemy() == nil then
    MsgArena:Post("LINEUP_COMPARE", {
      id = Logic:Get("Fight"):GetFighter().id
    })
  else
    A0_34:showCompare()
  end
end
function prototype.onBtnCloseClicked(A0_37, A1_38, A2_39)
  SceneHelper:popScene()
  Logic:Get("Fight"):clearCompareData()
  Logic:Get("Fight"):FireEvent(Logic.Fight.EVT.UPDATE_FIGHT_INFO)
  if Logic:Get("Fight"):isGuideFightDraw() then
    SceneHelper:pushPrompt("FightEvo", nil)
  end
end
function prototype.onBtnUpgrade(A0_40, A1_41, A2_42)
  SceneHelper:runWithScene("HeroUpgrade", A0_40.rootNode)
end
function prototype.onBtnLotteryClicked(A0_43, A1_44, A2_45)
  Logic:Get("Mall"):initItemData()
  if table.empty(Logic:Get("Mall"):GetTabData() or {}) then
    MsgPlayer:Post("GET_LOTTERY_LIST")
    return
  end
  A0_43:onGetLotteryList()
end
function prototype.onGetLotteryList(A0_46)
  local L1_47, L2_48
  L1_47 = Logic
  L2_48 = L1_47
  L1_47 = L1_47.Get
  L1_47 = L1_47(L2_48, "Mall")
  L2_48 = L1_47
  L1_47 = L1_47.initItemData
  L1_47(L2_48)
  L1_47 = Logic
  L2_48 = L1_47
  L1_47 = L1_47.Get
  L1_47 = L1_47(L2_48, "Mall")
  L2_48 = L1_47
  L1_47 = L1_47.GetTabData
  L1_47 = L1_47(L2_48)
  L2_48 = nil
  for _FORV_8_, _FORV_9_ in pairs(L1_47) do
    if "LOTTERY" == _FORV_9_.kind and ({
      LOTTERY_XIAN = 1,
      LOTTERY_LING = 2,
      LOTTERY_YAO = 3
    })[_FORV_9_.type] and 0 < ({
      LOTTERY_XIAN = 1,
      LOTTERY_LING = 2,
      LOTTERY_YAO = 3
    })[_FORV_9_.type] then
      L2_48 = _FORV_9_
    end
  end
  if L2_48 then
    Logic:Get("Lottery"):SetDrawData(L2_48)
    Logic:Get("Lottery"):SetFrom(Logic.Lottery.FROM_MALL)
    SceneHelper:runWithScene("LotteryGold", A0_46.rootNode)
  else
    Prompt:Fail(TwGetStr(105325))
  end
end
