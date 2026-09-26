local L0_0
L0_0 = module
L0_0((...), package.seeall)
L0_0 = require
L0_0("SceneHelper")
L0_0 = Tw
L0_0 = L0_0.Controller
L0_0 = L0_0.prototype
L0_0 = L0_0.extend
L0_0 = L0_0(L0_0)
prototype = L0_0
L0_0 = TypeDef
L0_0 = L0_0("com.eyu.mt.module.currency.model.CurrencyType")
CURRENCY_TYPE = L0_0
L0_0 = TypeDef
L0_0 = L0_0("com.eyu.mt.module.reward.model.RewardType")
REWARDS_TYPE = L0_0
L0_0 = 320
function prototype.initialize(A0_1, ...)
  super.initialize(A0_1, ...)
  A0_1.cards = {}
  A0_1.currPage = 1
  A0_1.times = Logic:Get("Lottery"):GetTimes()
  A0_1.drawData = {}
end
function prototype.dispose(A0_3, ...)
  super.dispose(A0_3)
end
function prototype.onEnter(A0_5)
  A0_5.drawData = Logic:Get("Lottery"):GetDrawData()
  A0_5.ccbArmor:setVisible(false)
  A0_5.ccbTreaInfo:setVisible(false)
  A0_5.nodeHead:setVisible(false)
  A0_5.nodeBottom:setVisible(false)
  A0_5.btnBg:setEnabled(false)
  A0_5.btnPrev:setVisible(false)
  A0_5.btnClose:setVisible(false)
  A0_5.btnNext:setVisible(false)
  A0_5.ttfClose:setVisible(false)
  A0_5.sprPrev:setVisible(false)
  A0_5.sprNext:setVisible(false)
  A0_5.ttfClick:setStyle(kCCLabelTTFStyleOutline)
  A0_5.ttfClick:setVisible(false)
  A0_5.ttfClick:setString(TwGetStr(105249))
  A0_5.ttfCardName:setStyle(kCCLabelTTFStyleOutline)
  if CCSprite:create(_UPVALUE0_) then
    A0_5.sprHill:setDisplayFrame(CCSprite:create(_UPVALUE0_):displayFrame())
  end
  A0_5:runAni()
end
function prototype.onExit(A0_6)
  Logic:Get("Lottery"):SetShowCard(false)
end
function prototype.showResult(A0_7)
  local L1_8, L2_9, L3_10, L4_11, L5_12, L6_13, L7_14, L8_15
  L1_8 = A0_7.btnBg
  L2_9 = L1_8
  L1_8 = L1_8.setEnabled
  L3_10 = false
  L1_8(L2_9, L3_10)
  L1_8 = A0_7.btnPrev
  L2_9 = L1_8
  L1_8 = L1_8.setVisible
  L3_10 = true
  L1_8(L2_9, L3_10)
  L1_8 = A0_7.btnClose
  L2_9 = L1_8
  L1_8 = L1_8.setVisible
  L3_10 = true
  L1_8(L2_9, L3_10)
  L1_8 = A0_7.btnNext
  L2_9 = L1_8
  L1_8 = L1_8.setVisible
  L3_10 = true
  L1_8(L2_9, L3_10)
  L1_8 = A0_7.nodeBottom
  L2_9 = L1_8
  L1_8 = L1_8.setVisible
  L3_10 = true
  L1_8(L2_9, L3_10)
  L1_8 = A0_7.times
  L1_8 = L1_8 ~= 1
  L2_9 = A0_7.btnPrev
  L3_10 = L2_9
  L2_9 = L2_9.setVisible
  L2_9(L3_10, L4_11)
  L2_9 = A0_7.sprPrev
  L3_10 = L2_9
  L2_9 = L2_9.setVisible
  L2_9(L3_10, L4_11)
  L2_9 = A0_7.btnNext
  L3_10 = L2_9
  L2_9 = L2_9.setVisible
  L2_9(L3_10, L4_11)
  L2_9 = A0_7.sprNext
  L3_10 = L2_9
  L2_9 = L2_9.setVisible
  L2_9(L3_10, L4_11)
  L2_9 = A0_7.ttfClick
  L3_10 = L2_9
  L2_9 = L2_9.setVisible
  L2_9(L3_10, L4_11)
  L2_9 = A0_7.ttfClose
  L3_10 = L2_9
  L2_9 = L2_9.setVisible
  L2_9(L3_10, L4_11)
  L3_10 = A0_7
  L2_9 = A0_7.setNameVisible
  L2_9(L3_10, L4_11)
  L2_9 = Logic
  L3_10 = L2_9
  L2_9 = L2_9.Get
  L2_9 = L2_9(L3_10, L4_11)
  L3_10 = L2_9
  L2_9 = L2_9.isGuideLottery
  L2_9 = L2_9(L3_10)
  if not L2_9 then
    L2_9 = Logic
    L3_10 = L2_9
    L2_9 = L2_9.Get
    L2_9 = L2_9(L3_10, L4_11)
    L3_10 = L2_9
    L2_9 = L2_9.IsShowCard
    L2_9 = L2_9(L3_10)
    if not L2_9 then
      L2_9 = A0_7.times
      if L2_9 ~= 3 then
        L2_9 = A0_7.drawData
        if L2_9 then
          L2_9 = Logic
          L3_10 = L2_9
          L2_9 = L2_9.Get
          L2_9 = L2_9(L3_10, L4_11)
          L3_10 = L2_9
          L2_9 = L2_9.IsOnceDraw
          L2_9 = L2_9(L3_10, L4_11)
        end
      end
    end
  elseif L2_9 then
    L2_9 = A0_7.btnClose
    L3_10 = L2_9
    L2_9 = L2_9.setVisible
    L2_9(L3_10, L4_11)
    L2_9 = A0_7.btnPrev
    L3_10 = L2_9
    L2_9 = L2_9.setVisible
    L2_9(L3_10, L4_11)
    L2_9 = A0_7.btnNext
    L3_10 = L2_9
    L2_9 = L2_9.setVisible
    L2_9(L3_10, L4_11)
    L2_9 = A0_7.sprPrev
    L3_10 = L2_9
    L2_9 = L2_9.setVisible
    L2_9(L3_10, L4_11)
    L2_9 = A0_7.sprNext
    L3_10 = L2_9
    L2_9 = L2_9.setVisible
    L2_9(L3_10, L4_11)
  end
  L2_9 = Logic
  L3_10 = L2_9
  L2_9 = L2_9.Get
  L2_9 = L2_9(L3_10, L4_11)
  L3_10 = L2_9
  L2_9 = L2_9.isOpenTenDraw
  L2_9 = L2_9(L3_10)
  if L2_9 then
    L2_9 = A0_7.drawData
    if L2_9 then
      L2_9 = A0_7.drawData
      L2_9 = L2_9.lotteryType
    elseif L2_9 ~= "ACTIVITY_RP" then
      L2_9 = A0_7.drawData
      if L2_9 then
        L2_9 = A0_7.drawData
        L2_9 = L2_9.showTemplete
      end
    end
  elseif "VIP" == L2_9 then
    L2_9 = A0_7.btnClose
    L3_10 = L2_9
    L2_9 = L2_9.setVisible
    L2_9(L3_10, L4_11)
    L2_9 = A0_7.btnNext
    L3_10 = L2_9
    L2_9 = L2_9.setVisible
    L2_9(L3_10, L4_11)
    L2_9 = A0_7.sprNext
    L3_10 = L2_9
    L2_9 = L2_9.setVisible
    L2_9(L3_10, L4_11)
  end
  L2_9 = A0_7.layer
  L3_10 = L2_9
  L2_9 = L2_9.getChildByTag
  L2_9 = L2_9(L3_10, L4_11)
  if L2_9 ~= nil then
    L3_10 = A0_7.layer
    L3_10 = L3_10.removeChildByTag
    L3_10(L4_11, L5_12, L6_13)
  end
  L3_10 = CCSprite
  L3_10 = L3_10.create
  L3_10 = L3_10(L4_11, L5_12)
  if L3_10 then
    L7_14 = L3_10
    L8_15 = L6_13(L7_14)
    L4_11(L5_12, L6_13, L7_14, L8_15, L6_13(L7_14))
  end
  A0_7.data = L4_11
  for L7_14, L8_15 in L4_11(L5_12) do
    table.insert(A0_7.data, {
      Logic:Get("Lottery"):formatTabData(L8_15)
    })
  end
  A0_7.index = 1
  A0_7.actionFinish = true
  L4_11(L5_12)
end
function prototype.onNodeLoaded(A0_16, A1_17, A2_18)
end
function prototype.onBtnCloseClicked(A0_19, A1_20, A2_21)
  if Logic:Get("Lottery"):IsShowCard() then
    Logic:Get("PlayerInfo"):ShowRewarTip()
    SceneHelper:popScene()
    return
  end
  SceneHelper:popScene()
  if Logic:Get("Mall"):IsFriendDraw(A0_19.drawData.type) then
    SceneHelper:removeScene("Lottery")
    SceneHelper:runWithScene("Lottery", A0_19.rootNode)
    return
  end
  if Logic:Get("Lottery"):IsFromArmor() then
    SceneHelper:removeScene("LotteryArmor")
    SceneHelper:runWithScene("LotteryArmor", A0_19.rootNode)
    if Logic:Get("Lottery"):isGuideLottery() then
      Logic:Get("Lottery"):setGuideLottery(false)
      Logic:Get("Guide"):check()
    end
    return
  end
  SceneHelper:removeScene("LotteryGold")
  SceneHelper:runWithScene("LotteryGold", A0_19.rootNode)
  if Logic:Get("Lottery"):isGuideLottery() then
    Logic:Get("Lottery"):setGuideLotterEvo(true)
    Logic:Get("DramaControl"):setVisibleBG(true)
    SceneHelper:pushPrompt("LotteryEvo", nil)
  else
    Logic:Get("Facebook"):OpenFaceBook()
    Logic:Get("WeChat"):OpenWeChat()
  end
end
function prototype.onBtnDrawOnceClicked(A0_22, A1_23, A2_24)
  local L3_25, L4_26, L5_27, L6_28, L7_29
  L3_25 = Logic
  L4_26 = L3_25
  L3_25 = L3_25.Get
  L5_27 = "Mall"
  L3_25 = L3_25(L4_26, L5_27)
  L4_26 = L3_25
  L3_25 = L3_25.IsOverTimeByData
  L5_27 = A0_22.drawData
  L3_25 = L3_25(L4_26, L5_27)
  if L3_25 then
    L3_25 = Prompt
    L4_26 = L3_25
    L3_25 = L3_25.Fail
    L5_27 = TwGetStr
    L6_28 = 105539
    L7_29 = L5_27(L6_28)
    L3_25(L4_26, L5_27, L6_28, L7_29, L5_27(L6_28))
    return
  end
  L3_25 = Logic
  L4_26 = L3_25
  L3_25 = L3_25.Get
  L5_27 = "Mall"
  L3_25 = L3_25(L4_26, L5_27)
  L4_26 = L3_25
  L3_25 = L3_25.IsOverDrawLimit
  L5_27 = A0_22.drawData
  L5_27 = L5_27.type
  L6_28 = A0_22.drawData
  L6_28 = L6_28.limits
  L3_25 = L3_25(L4_26, L5_27, L6_28)
  if L3_25 then
    L3_25 = A0_22.drawData
    L3_25 = L3_25.limits
    L3_25 = L3_25 or 0
    L4_26 = Prompt
    L5_27 = L4_26
    L4_26 = L4_26.Fail
    L6_28 = TwGetStr
    L7_29 = 105261
    L7_29 = L6_28(L7_29, L3_25)
    L4_26(L5_27, L6_28, L7_29, L6_28(L7_29, L3_25))
    return
  end
  L3_25 = A0_22.drawData
  L3_25 = L3_25.lotteryType
  if L3_25 == "ACTIVITY_RP" then
    L3_25 = Logic
    L4_26 = L3_25
    L3_25 = L3_25.Get
    L5_27 = "PlayerInfo"
    L3_25 = L3_25(L4_26, L5_27)
    L4_26 = L3_25
    L3_25 = L3_25.GetPlayerAllJade
    L3_25 = L3_25(L4_26)
    L4_26 = Logic
    L5_27 = L4_26
    L4_26 = L4_26.Get
    L6_28 = "Lottery"
    L4_26 = L4_26(L5_27, L6_28)
    L5_27 = L4_26
    L4_26 = L4_26.GetRateUpCostByType
    L6_28 = A0_22.drawData
    L6_28 = L6_28.type
    L4_26 = L4_26(L5_27, L6_28)
    if L3_25 < L4_26 then
      L5_27 = Logic
      L6_28 = L5_27
      L5_27 = L5_27.Get
      L7_29 = "SureConfirm"
      L5_27 = L5_27(L6_28, L7_29)
      L5_27 = L5_27.btnText
      L6_28 = TwGetStr
      L7_29 = 104003
      L6_28 = L6_28(L7_29)
      L5_27.ok = L6_28
      L5_27 = Prompt
      L6_28 = L5_27
      L5_27 = L5_27.Confirm
      L7_29 = Logic
      L7_29 = L7_29.Get
      L7_29 = L7_29(L7_29, "Main")
      L5_27(L6_28, L7_29, "", 105316, Logic:Get("Main").GotoRecharge, Prompt.PROMPT_TYPE.SELECT)
      return
    end
    L5_27 = Prompt
    L6_28 = L5_27
    L5_27 = L5_27.Confirm
    L7_29 = A0_22
    L5_27(L6_28, L7_29, "", TwGetStr(105269, L4_26), A0_22.onComfirmRateUpDraw, Prompt.PROMPT_TYPE.SELECT)
    return
  end
  L3_25 = Logic
  L4_26 = L3_25
  L3_25 = L3_25.Get
  L5_27 = "Lottery"
  L3_25 = L3_25(L4_26, L5_27)
  L4_26 = L3_25
  L3_25 = L3_25.GetDrawType
  L3_25 = L3_25(L4_26)
  L4_26, L5_27 = nil, nil
  L6_28 = CURRENCY_TYPE
  L6_28 = L6_28.FRIENDSHIP
  if L3_25 == L6_28 then
    L6_28 = Logic
    L7_29 = L6_28
    L6_28 = L6_28.Get
    L6_28 = L6_28(L7_29, "Lottery")
    L7_29 = L6_28
    L6_28 = L6_28.GetFriendCostAndPoints
    L7_29 = L6_28(L7_29)
    L5_27 = L7_29
    L4_26 = L6_28
    L6_28 = L4_26[1]
    if L5_27 < L6_28 then
      L6_28 = Prompt
      L7_29 = L6_28
      L6_28 = L6_28.Fail
      L6_28(L7_29, TwGetStr(105235))
      return
    end
  else
    L6_28 = CURRENCY_TYPE
    L6_28 = L6_28.GOLD
    if L3_25 == L6_28 then
      L6_28 = Logic
      L7_29 = L6_28
      L6_28 = L6_28.Get
      L6_28 = L6_28(L7_29, "PlayerInfo")
      L7_29 = L6_28
      L6_28 = L6_28.GetPlayerAllJade
      L6_28 = L6_28(L7_29)
      L5_27 = L6_28
      L6_28 = Logic
      L7_29 = L6_28
      L6_28 = L6_28.Get
      L6_28 = L6_28(L7_29, "Lottery")
      L7_29 = L6_28
      L6_28 = L6_28.GetCostTableByLotteryType
      L6_28 = L6_28(L7_29)
      L7_29 = L6_28[1]
      L4_26 = L7_29 or 0
      if L5_27 < L4_26 then
        L7_29 = Logic
        L7_29 = L7_29.Get
        L7_29 = L7_29(L7_29, "SureConfirm")
        L7_29 = L7_29.btnText
        L7_29.ok = TwGetStr(104003)
        L7_29 = Prompt
        L7_29 = L7_29.Confirm
        L7_29(L7_29, Logic:Get("Main"), "", 105316, Logic:Get("Main").GotoRecharge, Prompt.PROMPT_TYPE.SELECT)
        return
      end
    else
      L6_28 = CURRENCY_TYPE
      L6_28 = L6_28.STONE
      if L3_25 == L6_28 then
        L6_28 = Logic
        L7_29 = L6_28
        L6_28 = L6_28.Get
        L6_28 = L6_28(L7_29, "Lottery")
        L7_29 = L6_28
        L6_28 = L6_28.checkStoneEnough
        L6_28 = L6_28(L7_29, 1)
        if not L6_28 then
          L6_28 = Prompt
          L7_29 = L6_28
          L6_28 = L6_28.Fail
          L6_28(L7_29, TwGetStr(105583))
          return
        end
      end
    end
  end
  L6_28 = Logic
  L7_29 = L6_28
  L6_28 = L6_28.Get
  L6_28 = L6_28(L7_29, "Hero")
  L7_29 = L6_28
  L6_28 = L6_28.CheckInsistCard
  L6_28 = L6_28(L7_29, A0_22.drawData.cardTip)
  L7_29 = table
  L7_29 = L7_29.empty
  L7_29 = L7_29(L6_28)
  if not L7_29 then
    A0_22.drawTimes = 1
    L7_29 = Logic
    L7_29 = L7_29.Get
    L7_29 = L7_29(L7_29, "Lottery")
    L7_29 = L7_29.GetNameStr
    L7_29 = L7_29(L7_29, L6_28)
    Prompt:Confirm(A0_22, "", TwGetStr(105272, L7_29), A0_22.GoOnLottery, Prompt.PROMPT_TYPE.SELECT)
    return
  end
  L7_29 = A0_22.askDrawConfirm
  L7_29(A0_22, 1)
end
function prototype.onBtnDrawTenClicked(A0_30, A1_31, A2_32)
  local L3_33, L4_34, L5_35, L6_36, L7_37, L8_38, L9_39
  L3_33 = Logic
  L4_34 = L3_33
  L3_33 = L3_33.Get
  L5_35 = "Mall"
  L3_33 = L3_33(L4_34, L5_35)
  L4_34 = L3_33
  L3_33 = L3_33.IsOverTimeByData
  L5_35 = A0_30.drawData
  L3_33 = L3_33(L4_34, L5_35)
  if L3_33 then
    L3_33 = Prompt
    L4_34 = L3_33
    L3_33 = L3_33.Fail
    L5_35 = TwGetStr
    L6_36 = 105539
    L9_39 = L5_35(L6_36)
    L3_33(L4_34, L5_35, L6_36, L7_37, L8_38, L9_39, L5_35(L6_36))
    return
  end
  L3_33 = Logic
  L4_34 = L3_33
  L3_33 = L3_33.Get
  L5_35 = "Mall"
  L3_33 = L3_33(L4_34, L5_35)
  L4_34 = L3_33
  L3_33 = L3_33.IsOverDrawLimit
  L5_35 = A0_30.drawData
  L5_35 = L5_35.type
  L6_36 = A0_30.drawData
  L6_36 = L6_36.limits
  L3_33 = L3_33(L4_34, L5_35, L6_36)
  if L3_33 then
    L3_33 = A0_30.drawData
    L3_33 = L3_33.limits
    L3_33 = L3_33 or 0
    L4_34 = Prompt
    L5_35 = L4_34
    L4_34 = L4_34.Fail
    L6_36 = TwGetStr
    L7_37 = 105261
    L8_38 = L3_33
    L9_39 = L6_36(L7_37, L8_38)
    L4_34(L5_35, L6_36, L7_37, L8_38, L9_39, L6_36(L7_37, L8_38))
    return
  end
  L3_33 = Logic
  L4_34 = L3_33
  L3_33 = L3_33.Get
  L5_35 = "Mall"
  L3_33 = L3_33(L4_34, L5_35)
  L4_34 = L3_33
  L3_33 = L3_33.GetDrawProgressByKey
  L5_35 = A0_30.drawData
  L5_35 = L5_35.type
  L3_33 = L3_33(L4_34, L5_35)
  L4_34 = A0_30.drawData
  L4_34 = L4_34.limits
  if L4_34 > 0 then
    L5_35 = L4_34 - L3_33
    if L5_35 < 10 then
      L5_35 = Logic
      L6_36 = L5_35
      L5_35 = L5_35.Get
      L7_37 = "SureConfirm"
      L5_35 = L5_35(L6_36, L7_37)
      L5_35 = L5_35.btnText
      L6_36 = TwGetStr
      L7_37 = 105260
      L6_36 = L6_36(L7_37)
      L5_35.ok = L6_36
      L5_35 = Prompt
      L6_36 = L5_35
      L5_35 = L5_35.Confirm
      L7_37 = A0_30
      L8_38 = ""
      L9_39 = 105259
      L5_35(L6_36, L7_37, L8_38, L9_39, A0_30.onDrawOnceClicked, Prompt.PROMPT_TYPE.SELECT)
      return
    end
  end
  L5_35 = Logic
  L6_36 = L5_35
  L5_35 = L5_35.Get
  L7_37 = "Lottery"
  L5_35 = L5_35(L6_36, L7_37)
  L6_36 = L5_35
  L5_35 = L5_35.GetDrawType
  L5_35 = L5_35(L6_36)
  L6_36, L7_37 = nil, nil
  L8_38 = CURRENCY_TYPE
  L8_38 = L8_38.FRIENDSHIP
  if L5_35 == L8_38 then
    L8_38 = Logic
    L9_39 = L8_38
    L8_38 = L8_38.Get
    L8_38 = L8_38(L9_39, "Lottery")
    L9_39 = L8_38
    L8_38 = L8_38.GetFriendCostAndPoints
    L9_39 = L8_38(L9_39)
    L7_37 = L9_39
    L6_36 = L8_38
    L8_38 = L6_36[2]
    if L7_37 < L8_38 then
      L8_38 = Prompt
      L9_39 = L8_38
      L8_38 = L8_38.Fail
      L8_38(L9_39, TwGetStr(105235))
      return
    end
  else
    L8_38 = CURRENCY_TYPE
    L8_38 = L8_38.GOLD
    if L5_35 == L8_38 then
      L8_38 = Logic
      L9_39 = L8_38
      L8_38 = L8_38.Get
      L8_38 = L8_38(L9_39, "PlayerInfo")
      L9_39 = L8_38
      L8_38 = L8_38.GetPlayerAllJade
      L8_38 = L8_38(L9_39)
      L7_37 = L8_38
      L8_38 = Logic
      L9_39 = L8_38
      L8_38 = L8_38.Get
      L8_38 = L8_38(L9_39, "Lottery")
      L9_39 = L8_38
      L8_38 = L8_38.GetCostTableByLotteryType
      L8_38 = L8_38(L9_39)
      L9_39 = L8_38[2]
      L6_36 = L9_39 or 0
      if L7_37 < L6_36 then
        L9_39 = Logic
        L9_39 = L9_39.Get
        L9_39 = L9_39(L9_39, "SureConfirm")
        L9_39 = L9_39.btnText
        L9_39.ok = TwGetStr(104003)
        L9_39 = Prompt
        L9_39 = L9_39.Confirm
        L9_39(L9_39, Logic:Get("Main"), "", 105316, Logic:Get("Main").GotoRecharge, Prompt.PROMPT_TYPE.SELECT)
        return
      end
    else
      L8_38 = CURRENCY_TYPE
      L8_38 = L8_38.STONE
      if L5_35 == L8_38 then
        L8_38 = Logic
        L9_39 = L8_38
        L8_38 = L8_38.Get
        L8_38 = L8_38(L9_39, "Lottery")
        L9_39 = L8_38
        L8_38 = L8_38.checkStoneEnough
        L8_38 = L8_38(L9_39, 10)
        if not L8_38 then
          L8_38 = Prompt
          L9_39 = L8_38
          L8_38 = L8_38.Fail
          L8_38(L9_39, TwGetStr(105583))
          return
        end
      end
    end
  end
  L8_38 = Logic
  L9_39 = L8_38
  L8_38 = L8_38.Get
  L8_38 = L8_38(L9_39, "Hero")
  L9_39 = L8_38
  L8_38 = L8_38.CheckInsistCard
  L8_38 = L8_38(L9_39, A0_30.drawData.cardTip)
  L9_39 = table
  L9_39 = L9_39.empty
  L9_39 = L9_39(L8_38)
  if not L9_39 then
    A0_30.drawTimes = 10
    L9_39 = Logic
    L9_39 = L9_39.Get
    L9_39 = L9_39(L9_39, "Lottery")
    L9_39 = L9_39.GetNameStr
    L9_39 = L9_39(L9_39, L8_38)
    Prompt:Confirm(A0_30, "", TwGetStr(105272, L9_39), A0_30.GoOnLottery, Prompt.PROMPT_TYPE.SELECT)
    return
  end
  L9_39 = A0_30.askDrawConfirm
  L9_39(A0_30, 10)
end
function prototype.onBtnPrev(A0_40, A1_41, A2_42)
  if not A0_40.actionFinish then
    return
  end
  A0_40:runAnimatOut(true)
end
function prototype.onBtnNext(A0_43, A1_44, A2_45)
  if not A0_43.actionFinish then
    return
  end
  A0_43:runAnimatOut(false)
end
function prototype.showPrev(A0_46)
  A0_46.index = A0_46.index - 1
  if A0_46.index < 1 then
    A0_46.index = A0_46.times
  end
  A0_46:showCards()
end
function prototype.showNext(A0_47)
  A0_47.index = A0_47.index + 1
  if A0_47.index > A0_47.times then
    A0_47.index = 1
  end
  A0_47:showCards()
end
function prototype.onBtnBgClicked(A0_48, A1_49, A2_50)
  if A0_48.ani then
    A0_48.ani:RemoveAnimation()
  end
  A0_48:showResult()
end
function prototype.onComfirmRateUpDraw(A0_51)
  Logic:Get("Lottery"):PostLottery(1)
end
function prototype.askDrawConfirm(A0_52, A1_53)
  A0_52.drawTimes = A1_53
  if A0_52.drawData and ("VIP" == A0_52.drawData.showTemplete or Logic:Get("Mall"):IsFriendDraw(A0_52.drawData.type)) then
    A0_52:GoOnLottery()
    return
  end
  Prompt:Confirm(A0_52, "", "\231\161\174\229\174\154\230\138\189\229\141\161\229\144\151\239\188\159", A0_52.GoOnLottery, Prompt.PROMPT_TYPE.SELECT)
end
function prototype.GoOnLottery(A0_54)
  if Logic:Get("Lottery"):IsFromArmor() then
    Logic:Get("Lottery"):PostEquipLottery(A0_54.drawTimes)
    return
  end
  Logic:Get("Lottery"):SetDrawType(A0_54.drawType)
  Logic:Get("Lottery"):PostLottery(A0_54.drawTimes)
end
function prototype.runAni(A0_55)
  A0_55.cards = Logic:Get("Lottery"):GetCards()
  if A0_55.times == 1 then
    A0_55.ani = Logic:Get("AniMgr"):NewCCB("UI/uicjyc", A0_55, ccp(_UPVALUE0_, _UPVALUE1_), 0, nil, 1)
  elseif A0_55.times == 3 then
    A0_55.ani = Logic:Get("AniMgr"):NewCCB("UI/uicjyc02", A0_55, ccp(_UPVALUE0_, _UPVALUE1_), 0, nil, 1)
  elseif A0_55.times == 10 then
    A0_55.ani = Logic:Get("AniMgr"):NewCCB("UI/uicjsc", A0_55, ccp(_UPVALUE0_, _UPVALUE1_), 0, nil, 1)
  end
  A0_55:setCardBgAndIcon()
  if A0_55.ani then
    A0_55.ani:RunAni(nil, nil, bind(A0_55.aniEnd, A0_55))
    Logic:Get("BGSound"):PlayEffect("audio/lottery.mp3")
  end
end
function prototype.setCardBgAndIcon(A0_56)
  local L1_57, L2_58, L3_59, L4_60, L5_61, L6_62, L7_63, L8_64
  for L4_60, L5_61 in L1_57(L2_58) do
    if L4_60 > 0 then
      L6_62 = A0_56.times
      if L4_60 <= L6_62 then
        L6_62 = string
        L6_62 = L6_62.format
        L7_63 = "cardBg%d"
        L8_64 = L4_60
        L6_62 = L6_62(L7_63, L8_64)
        L7_63 = nil
        L8_64 = L5_61.rewardType
        if L8_64 == REWARDS_TYPE.EQUIPMENT then
          L8_64 = Logic
          L8_64 = L8_64.Get
          L8_64 = L8_64(L8_64, "Armor")
          L8_64 = L8_64.createArmorCard
          L8_64 = L8_64(L8_64, L5_61.baseId)
          L7_63 = L8_64
        else
          L8_64 = L5_61.rewardType
          if L8_64 == REWARDS_TYPE.EQUIPMENT_FRAGMENT then
            L8_64 = Logic
            L8_64 = L8_64.Get
            L8_64 = L8_64(L8_64, "Armor")
            L8_64 = L8_64.createArmorCard
            L8_64 = L8_64(L8_64, L5_61.baseId, true)
            L7_63 = L8_64
          else
            L8_64 = L5_61.rewardType
            if L8_64 == REWARDS_TYPE.EQUIPMENT_MATERIAL then
              L8_64 = Logic
              L8_64 = L8_64.Get
              L8_64 = L8_64(L8_64, "HeroCardInfo")
              L8_64 = L8_64.createHeroCardForByFight
              L8_64 = L8_64(L8_64, L5_61.baseId)
              L7_63 = L8_64
            else
              L8_64 = L5_61.powerSkill
              if L8_64 == nil then
                L8_64 = L5_61.level
              L8_64 = L8_64 == nil or true
              L7_63 = Logic:Get("HeroCardInfo"):GetSprCard(L5_61.baseId, L8_64)
            end
          end
        end
        if L7_63 then
          L8_64 = Logic
          L8_64 = L8_64.Get
          L8_64 = L8_64(L8_64, "HeroCardInfo")
          L8_64 = L8_64.GetCardTexture
          L8_64 = L8_64(L8_64, L7_63)
          if A0_56.times ~= 1 then
            A0_56.ani:GetChild(L6_62):setScale(_UPVALUE0_)
          else
            A0_56.ani:GetChild(L6_62):setScale(0.9)
          end
          A0_56.ani:GetChild(L6_62):setTexture(L8_64)
          A0_56.ani:GetChild(L6_62):setTextureRect(L7_63:getTextureRect())
          if Logic:Get("Lottery"):IsFromArmor() and L5_61.rewardType == REWARDS_TYPE.EQUIPMENT and L5_61.rewardType == REWARDS_TYPE.EQUIPMENT_FRAGMENT then
            Logic:Get("Armor"):addStarLv(A0_56.ani:GetChild(L6_62), L5_61.baseId)
          end
        end
      end
    end
  end
end
function prototype.showShineCard(A0_65)
  local L1_66, L2_67, L3_68, L4_69, L5_70, L6_71
  for L4_69, L5_70 in L1_66(L2_67) do
    if L4_69 > 0 then
      L6_71 = A0_65.times
      if L4_69 <= L6_71 then
        L6_71 = string
        L6_71 = L6_71.format
        L6_71 = L6_71("cardBg%d", L4_69)
        if L5_70.powerSkill ~= nil or L5_70.level ~= nil then
          Logic:Get("HeroCardInfo"):AddShanCard(A0_65.ani:GetChild(L6_71), L5_70.baseId)
        end
      end
    end
  end
end
function prototype.aniEnd(A0_72)
  local L1_73, L2_74
  L1_73 = CCSprite
  L2_74 = L1_73
  L1_73 = L1_73.create
  L1_73 = L1_73(L2_74, "images/font/click_go_on.png")
  if L1_73 ~= nil then
    L2_74 = A0_72.layer
    L2_74 = L2_74.addChild
    L2_74(L2_74, L1_73, 0, 10)
    L2_74 = Logic
    L2_74 = L2_74.Get
    L2_74 = L2_74(L2_74, "Gift")
    L2_74 = L2_74.fadetoSpr
    L2_74 = L2_74(L2_74)
    L1_73:runAction(CCRepeatForever:create(L2_74))
    L1_73:setPosition(A0_72.ttfClick:getPosition())
  end
  L2_74 = A0_72.showShineCard
  L2_74(A0_72)
  L2_74 = A0_72.animationMgr
  L2_74 = L2_74.runAnimations
  L2_74(L2_74, "fadeIn")
  L2_74 = A0_72.btnBg
  L2_74 = L2_74.setEnabled
  L2_74(L2_74, true)
  L2_74 = A0_72.setNameStrAndColor
  L2_74(A0_72)
end
function prototype.bindAnimationMgr(A0_75)
  local L1_76
  L1_76 = true
  return L1_76
end
function prototype.cellSizeForTable(A0_77, ...)
  return CCSizeMake(640, 1400)
end
function prototype.tableCellAtIndex(A0_79, A1_80, A2_81, A3_82, A4_83)
  local L5_84, L6_85
  if not A3_82 then
    A0_79.currPage = A4_83
    L5_84 = CCTableViewCellEx
    L6_85 = L5_84
    L5_84 = L5_84.create
    L5_84 = L5_84(L6_85)
    A3_82 = L5_84
    L5_84 = Tw
    L5_84 = L5_84.Controller
    L6_85 = L5_84
    L5_84 = L5_84.load
    L5_84 = L5_84(L6_85, "HeroCardInfoTail", A0_79.rootNode)
    L6_85 = {}
    L6_85.exp = 0
    L6_85.id = 68719480211
    L6_85.level = 1
    L6_85.baseId = 1024
    L6_85.powerSkill = 1
    L5_84:ReFrashHeroInfo(L6_85)
    A3_82:addChild(L5_84, 0, 2)
  else
    L5_84 = {}
    L5_84.exp = 0
    L5_84.id = 68719480211
    L5_84.level = 1
    L5_84.baseId = 1024
    L5_84.powerSkill = 1
    L6_85 = A3_82.getChildByTag
    L6_85 = L6_85(A3_82, 2)
    L6_85 = L6_85.ReFrashHeroInfo
    L6_85(L6_85, L5_84)
  end
  return A3_82
end
function prototype.numberOfCellsInTableView(A0_86, A1_87)
  local L2_88
  L2_88 = 1
  return L2_88
end
function prototype.tableCellTouched(A0_89, A1_90, A2_91)
end
function prototype.tablePageTurn(A0_92, A1_93)
  if A1_93 >= 1 and A1_93 <= #A0_92.cards then
    A0_92.tableViewControl:RequireUpdate()
  end
end
function prototype.setNameVisible(A0_94, A1_95)
  local L2_96, L3_97, L4_98, L5_99
  for L5_99 = 1, _UPVALUE0_ do
    if A0_94[string.format("ttfName%d", L5_99)] then
      A0_94[string.format("ttfName%d", L5_99)]:setVisible(A1_95)
    end
  end
end
function prototype.setNameStyle(A0_100)
  local L1_101, L2_102, L3_103, L4_104
  for L4_104 = 1, _UPVALUE0_ do
    if A0_100[string.format("ttfName%d", L4_104)] then
      A0_100[string.format("ttfName%d", L4_104)]:setStyle(kCCLabelTTFStyleOutline)
    end
  end
end
function prototype.setNameStrAndColor(A0_105)
  local L1_106, L2_107, L3_108, L4_109, L5_110, L6_111, L7_112, L8_113, L9_114, L10_115, L11_116, L12_117, L13_118
  if L1_106 == 1 then
    if L2_107 ~= L3_108 then
    else
      if L2_107 == L3_108 then
        L4_109 = "Armor"
        L4_109 = A0_105.cards
        L4_109 = L4_109[1]
        L4_109 = L4_109.baseId
    end
    else
      L4_109 = "Hero"
      L4_109 = A0_105.cards
      L4_109 = L4_109[1]
      L4_109 = L4_109.baseId
    end
    if L1_106 then
      L4_109 = A0_105
      L5_110 = A0_105.cards
      L5_110 = L5_110[1]
      if L3_108 then
        L4_109 = "\n"
        L5_110 = TwGetStr
        L6_111 = 103134
        L5_110 = L5_110(L6_111)
      end
      L4_109 = Logic
      L5_110 = L4_109
      L4_109 = L4_109.Get
      L6_111 = "Lottery"
      L4_109 = L4_109(L5_110, L6_111)
      L5_110 = L4_109
      L4_109 = L4_109.GetHeroRankColor3
      L6_111 = L3_108
      L4_109 = L4_109(L5_110, L6_111)
      L5_110 = A0_105.ttfName1
      L6_111 = L5_110
      L5_110 = L5_110.setStyle
      L7_112 = kCCLabelTTFStyleOutline
      L5_110(L6_111, L7_112)
      L5_110 = A0_105.ttfName1
      L6_111 = L5_110
      L5_110 = L5_110.setString
      L7_112 = L2_107
      L5_110(L6_111, L7_112)
      L5_110 = A0_105.ttfName1
      L6_111 = L5_110
      L5_110 = L5_110.setColor
      L7_112 = L4_109
      L5_110(L6_111, L7_112)
      L5_110 = A0_105.ttfName1
      L6_111 = L5_110
      L5_110 = L5_110.setPosition
      L7_112 = CCPoint
      L8_113 = _UPVALUE0_
      L9_114 = _UPVALUE1_
      L13_118 = L7_112(L8_113, L9_114)
      L5_110(L6_111, L7_112, L8_113, L9_114, L10_115, L11_116, L12_117, L13_118, L7_112(L8_113, L9_114))
    end
  else
    for L4_109, L5_110 in L1_106(L2_107) do
      L6_111 = string
      L6_111 = L6_111.format
      L7_112 = "ttfName%d"
      L8_113 = L4_109
      L6_111 = L6_111(L7_112, L8_113)
      L7_112 = {}
      L8_113 = L5_110.rewardType
      L9_114 = REWARDS_TYPE
      L9_114 = L9_114.EQUIPMENT
      if L8_113 ~= L9_114 then
        L8_113 = L5_110.rewardType
        L9_114 = REWARDS_TYPE
        L9_114 = L9_114.EQUIPMENT_FRAGMENT
      else
        if L8_113 == L9_114 then
          L8_113 = Logic
          L9_114 = L8_113
          L8_113 = L8_113.Get
          L10_115 = "Armor"
          L8_113 = L8_113(L9_114, L10_115)
          L9_114 = L8_113
          L8_113 = L8_113.getArmorInfoByBaseId
          L10_115 = L5_110.baseId
          L8_113 = L8_113(L9_114, L10_115)
          L7_112 = L8_113
      end
      else
        L8_113 = Logic
        L9_114 = L8_113
        L8_113 = L8_113.Get
        L10_115 = "Hero"
        L8_113 = L8_113(L9_114, L10_115)
        L9_114 = L8_113
        L8_113 = L8_113.GetHeroInfoByBaseId
        L10_115 = L5_110.baseId
        L8_113 = L8_113(L9_114, L10_115)
        L7_112 = L8_113
      end
      if L7_112 then
        L8_113 = L7_112.name
        L8_113 = L8_113 or ""
        L10_115 = A0_105
        L9_114 = A0_105.IsFragment
        L11_116 = L5_110
        L9_114 = L9_114(L10_115, L11_116)
        if L9_114 then
          L9_114 = L8_113
          L10_115 = "\n"
          L11_116 = TwGetStr
          L12_117 = 103134
          L11_116 = L11_116(L12_117)
          L8_113 = L9_114 .. L10_115 .. L11_116
        end
        L9_114 = L7_112.rank
        L9_114 = L9_114 or 1
        L10_115 = Logic
        L11_116 = L10_115
        L10_115 = L10_115.Get
        L12_117 = "Lottery"
        L10_115 = L10_115(L11_116, L12_117)
        L11_116 = L10_115
        L10_115 = L10_115.GetHeroRankColor3
        L12_117 = L9_114
        L10_115 = L10_115(L11_116, L12_117)
        L11_116 = A0_105[L6_111]
        if L11_116 then
          L11_116 = A0_105[L6_111]
          L12_117 = L11_116
          L11_116 = L11_116.setStyle
          L13_118 = kCCLabelTTFStyleOutline
          L11_116(L12_117, L13_118)
          L11_116 = A0_105[L6_111]
          L12_117 = L11_116
          L11_116 = L11_116.setScale
          L13_118 = 0.7
          L11_116(L12_117, L13_118)
          L11_116 = A0_105[L6_111]
          L12_117 = L11_116
          L11_116 = L11_116.setString
          L13_118 = L8_113
          L11_116(L12_117, L13_118)
          L11_116 = A0_105[L6_111]
          L12_117 = L11_116
          L11_116 = L11_116.setColor
          L13_118 = L10_115
          L11_116(L12_117, L13_118)
          L11_116 = A0_105.times
          if L11_116 == 3 then
            L11_116 = string
            L11_116 = L11_116.format
            L12_117 = "cardBg%d"
            L13_118 = L4_109
            L11_116 = L11_116(L12_117, L13_118)
            L12_117 = A0_105.ani
            L13_118 = L12_117
            L12_117 = L12_117.GetChild
            L12_117 = L12_117(L13_118, L11_116)
            if L12_117 then
              L12_117 = A0_105.ani
              L13_118 = L12_117
              L12_117 = L12_117.GetChild
              L12_117 = L12_117(L13_118, L11_116)
              L13_118 = L12_117
              L12_117 = L12_117.getPositionX
              L12_117 = L12_117(L13_118)
              L13_118 = A0_105.ani
              L13_118 = L13_118.GetChild
              L13_118 = L13_118(L13_118, L11_116)
              L13_118 = L13_118.getPositionY
              L13_118 = L13_118(L13_118)
              L13_118 = L13_118 - 100
              A0_105[L6_111]:setPosition(ccp(L12_117, L13_118))
            end
          end
        end
      end
    end
  end
end
function prototype.IsFragment(A0_119, A1_120)
  local L2_121, L3_122
  L2_121 = A1_120.rewardType
  L3_122 = Logic
  L3_122 = L3_122.Reward
  L3_122 = L3_122.REWARDS_TYPE
  L3_122 = L3_122.EQUIPMENT_FRAGMENT
  if L2_121 == L3_122 then
    L2_121 = true
    return L2_121
  end
  L2_121 = A1_120.rewardType
  L3_122 = Logic
  L3_122 = L3_122.Reward
  L3_122 = L3_122.REWARDS_TYPE
  L3_122 = L3_122.HERO
  if L2_121 ~= L3_122 then
    L2_121 = false
    return L2_121
  end
  L2_121 = A1_120.powerSkill
  L2_121 = L2_121 == nil and L2_121 == nil
  return L2_121
end
function prototype.showCards(A0_123)
  local L1_124, L2_125, L3_126, L4_127
  L1_124 = A0_123.index
  if L1_124 then
    L1_124 = A0_123.data
  elseif not L1_124 then
    return
  end
  L1_124 = A0_123.data
  L2_125 = A0_123.index
  L1_124 = L1_124[L2_125]
  L1_124 = L1_124[1]
  L2_125 = nil
  L3_126 = true
  L4_127 = Logic
  L4_127 = L4_127.Get
  L4_127 = L4_127(L4_127, "Hero")
  L4_127 = L4_127.getColorByBaseId
  L4_127 = L4_127(L4_127, L1_124.baseId)
  if A0_123.scroll then
    A0_123.scroll:removeFromParentAndCleanup(true)
    A0_123.scroll = nil
  end
  A0_123.ccbTreaInfo:setVisible(false)
  A0_123.ccbArmor:setVisible(false)
  if L1_124.rewardType == REWARDS_TYPE.HERO then
    A0_123:showHeroCard(L1_124)
  elseif L1_124.rewardType == REWARDS_TYPE.FRAGMENT then
    A0_123:showHeroCard(L1_124, true)
    L3_126 = (Logic:Get("Hero"):GetHeroInfoByBaseId(L1_124.baseId) or {}).card == "HERO"
  elseif L1_124.rewardType == REWARDS_TYPE.EQUIPMENT or L1_124.rewardType == REWARDS_TYPE.EQUIPMENT_FRAGMENT then
    L2_125 = ""
    L3_126 = false
    A0_123.curCCB = A0_123.ccbArmor
    L4_127 = Logic:Get("Armor"):getColorByBaseId(L1_124.baseId)
    A0_123.ccbArmor:setVisible(true)
    A0_123.ccbArmor:refreshArmorInfo(L1_124.baseId, nil, true)
  else
    L2_125 = ""
    L3_126 = false
    A0_123.curCCB = A0_123.ccbTreaInfo
    A0_123.ccbTreaInfo:setVisible(true)
    A0_123.ccbTreaInfo:ReFrashHeroInfo(L1_124)
  end
  if L2_125 == nil then
    L2_125 = Logic:Get("HeroCardInfo"):kdbBaseHero(L1_124.baseId) and (Logic:Get("HeroCardInfo"):kdbBaseHero(L1_124.baseId).name or "")
  end
  A0_123.ttfCardName:setString(L2_125)
  A0_123.ttfCardName:setColor(L4_127)
  A0_123.nodeHead:setVisible(L3_126)
end
function prototype.showHeroCard(A0_128, A1_129, A2_130)
  local L3_131, L4_132, L5_133, L6_134, L7_135
  if not A1_129 then
    return
  end
  L3_131 = Logic
  L4_132 = L3_131
  L3_131 = L3_131.Get
  L5_133 = "Hero"
  L3_131 = L3_131(L4_132, L5_133)
  L4_132 = L3_131
  L3_131 = L3_131.GetHeroInfoByBaseId
  L5_133 = A1_129.baseId
  L3_131 = L3_131(L4_132, L5_133)
  if L3_131 == nil then
    return
  end
  L4_132 = L3_131.card
  if L4_132 ~= "HERO" then
    L4_132 = A0_128.ccbTreaInfo
    L5_133 = L4_132
    L4_132 = L4_132.setVisible
    L6_134 = true
    L4_132(L5_133, L6_134)
    L4_132 = A0_128.ccbTreaInfo
    L5_133 = L4_132
    L4_132 = L4_132.ReFrashHeroInfo
    L6_134 = A1_129
    L4_132(L5_133, L6_134)
    return
  end
  L4_132 = CCScrollViewEx
  L5_133 = L4_132
  L4_132 = L4_132.create
  L6_134 = CCSizeMake
  L7_135 = 640
  L7_135 = L6_134(L7_135, 750)
  L4_132 = L4_132(L5_133, L6_134, L7_135, L6_134(L7_135, 750))
  L6_134 = L4_132
  L5_133 = L4_132.setDirection
  L7_135 = kCCScrollViewDirectionVertical
  L5_133(L6_134, L7_135)
  L6_134 = L4_132
  L5_133 = L4_132.setPosition
  L7_135 = ccp
  L7_135 = L7_135(0, 105)
  L5_133(L6_134, L7_135, L7_135(0, 105))
  L6_134 = L4_132
  L5_133 = L4_132.setClippingToBounds
  L7_135 = true
  L5_133(L6_134, L7_135)
  L6_134 = L4_132
  L5_133 = L4_132.setTouchEnabled
  L7_135 = true
  L5_133(L6_134, L7_135)
  A0_128.scroll = L4_132
  L5_133 = A0_128.nodeHead
  A0_128.curCCB = L5_133
  L5_133 = A0_128.nodeHead
  L6_134 = L5_133
  L5_133 = L5_133.addChild
  L7_135 = L4_132
  L5_133(L6_134, L7_135)
  L5_133 = Tw
  L5_133 = L5_133.Controller
  L6_134 = L5_133
  L5_133 = L5_133.load
  L7_135 = "HeroCardInfoTail"
  L5_133 = L5_133(L6_134, L7_135, A0_128.rootNode)
  if L5_133 then
    L6_134 = Logic
    L7_135 = L6_134
    L6_134 = L6_134.Get
    L6_134 = L6_134(L7_135, "HeroCardInfo")
    L7_135 = L6_134
    L6_134 = L6_134.kdbBaseHero
    L6_134 = L6_134(L7_135, A1_129.baseId)
    L7_135 = {}
    L7_135.exp = 0
    L7_135.id = 68719480211
    L7_135.level = 1
    L7_135.baseId = A1_129.baseId or 1
    L7_135.powerSkill = L6_134.powerSkill or 1
    L7_135.fra = A2_130
    L5_133:ReFrashHeroInfo(L7_135)
    L4_132:setContainer(L5_133)
    L4_132:setContentOffset(ccp(0, 750 - L5_133.layer:getContentSize().height))
    L4_132:updateInset()
  end
end
function prototype.runAnimatOut(A0_136, A1_137)
  local L2_138, L3_139, L4_140, L5_141, L6_142, L7_143, L8_144
  L2_138 = A0_136.curCCB
  if not L2_138 then
    return
  end
  L2_138 = nil
  A0_136.actionFinish = false
  A0_136.leftToRight = A1_137
  if A1_137 then
    L3_139 = 640
  else
    L3_139 = L3_139 or -640
  end
  if A1_137 then
    L4_140 = A0_136.showPrev
  else
    L4_140 = L4_140 or A0_136.showNext
  end
  L5_141 = CCMoveTo
  L6_142 = L5_141
  L5_141 = L5_141.create
  L7_143 = 0.3
  L8_144 = ccp
  L8_144 = L8_144(L3_139, 0)
  L5_141 = L5_141(L6_142, L7_143, L8_144, L8_144(L3_139, 0))
  L6_142 = CCEaseIn
  L7_143 = L6_142
  L6_142 = L6_142.create
  L8_144 = L5_141
  L6_142 = L6_142(L7_143, L8_144, 5)
  L7_143 = CCArray
  L8_144 = L7_143
  L7_143 = L7_143.create
  L7_143 = L7_143(L8_144)
  L8_144 = L7_143.addObject
  L8_144(L7_143, L6_142)
  L8_144 = L7_143.addObject
  L8_144(L7_143, CCCallFunc:create(bind(L4_140, A0_136)))
  L8_144 = L7_143.addObject
  L8_144(L7_143, CCCallFunc:create(bind(A0_136.runAnimatIn, A0_136)))
  L8_144 = CCSequence
  L8_144 = L8_144.create
  L8_144 = L8_144(L8_144, L7_143)
  A0_136.curCCB:runAction(L8_144)
end
function prototype.runAnimatIn(A0_145)
  local L1_146, L2_147, L3_148, L4_149, L5_150, L6_151
  L1_146 = A0_145.curCCB
  if not L1_146 then
    A0_145.actionFinish = true
    return
  end
  L1_146 = nil
  L2_147 = A0_145.leftToRight
  if L2_147 then
    L2_147 = -640
  else
    L2_147 = L2_147 or 640
  end
  L3_148 = A0_145.curCCB
  L4_149 = L3_148
  L3_148 = L3_148.setPosition
  L5_150 = ccp
  L6_151 = L2_147
  L6_151 = L5_150(L6_151, 0)
  L3_148(L4_149, L5_150, L6_151, L5_150(L6_151, 0))
  L3_148 = CCMoveTo
  L4_149 = L3_148
  L3_148 = L3_148.create
  L5_150 = 0.3
  L6_151 = ccp
  L6_151 = L6_151(0, 0)
  L3_148 = L3_148(L4_149, L5_150, L6_151, L6_151(0, 0))
  L4_149 = CCEaseOut
  L5_150 = L4_149
  L4_149 = L4_149.create
  L6_151 = L3_148
  L4_149 = L4_149(L5_150, L6_151, 5)
  L5_150 = CCArray
  L6_151 = L5_150
  L5_150 = L5_150.create
  L5_150 = L5_150(L6_151)
  L6_151 = L5_150.addObject
  L6_151(L5_150, L4_149)
  L6_151 = L5_150.addObject
  L6_151(L5_150, CCCallFunc:create(function()
    local L1_152
    L1_152 = _UPVALUE0_
    L1_152.actionFinish = true
  end))
  L6_151 = CCSequence
  L6_151 = L6_151.create
  L6_151 = L6_151(L6_151, L5_150)
  A0_145.curCCB:runAction(L6_151)
end
