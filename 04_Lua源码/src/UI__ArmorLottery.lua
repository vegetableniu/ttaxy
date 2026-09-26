local L0_0
L0_0 = module
L0_0((...), package.seeall)
L0_0 = require
L0_0("SceneHelper")
L0_0 = require
L0_0("BtnPosition")
L0_0 = BtnPosition
L0_0 = L0_0.prototype
L0_0 = L0_0.extend
L0_0 = L0_0(L0_0)
prototype = L0_0
L0_0 = 246
function prototype.onEnter(A0_1)
  super.onEnter(A0_1)
  if Logic:Get("Guide"):isActive("EquipLottery", "SelectTimes") then
    Logic:Get("Lottery"):setGuideLottery(true)
    Logic:Get("Guide"):lockTouch(A0_1.btnDrawOnce)
  end
  A0_1.ttfFree:setStyle(kCCLabelTTFStyleOutline)
  A0_1.ttfTime:setStyle(kCCLabelTTFStyleOutline)
  A0_1.ttfTimes:setStyle(kCCLabelTTFStyleOutline)
  A0_1.drawData = Logic:Get("Lottery"):GetDrawData()
  Logic:Get("Lottery"):SetFromArmor(true)
  A0_1:refreshText()
  A0_1:refreshImage()
  A0_1:checkLotteryTime()
  A0_1:refreshByAcceptJade()
  Logic:Get("Lottery"):On(Logic.Lottery.EVT.MSG_LOTTERY_TIME, A0_1:Event("OnUILotteryTime"))
  Logic:Get("Lottery"):On(Logic.Lottery.EVT.MSG_LOTTERY_OK, A0_1:Event("OnUILotteryOK"))
  Logic:Get("Lottery"):On(Logic.Lottery.EVT.ON_EQUIP_LOTTERY, A0_1:Event("OnEquipLottery"))
  Logic:Get("Lottery"):On(Logic.Lottery.EVT.DRAW_FAILED, A0_1:Event("OnDrawFailed"))
end
function prototype.onExit(A0_2)
  Logic:Get("Lottery"):SetFromArmor(false)
end
function prototype.checkLotteryTime(A0_3)
  local L1_4, L2_5, L3_6
  L1_4 = false
  L2_5 = KFDBGetRecord
  L3_6 = "EquipLottery"
  L2_5 = L2_5(L3_6, A0_3.drawData.id)
  if L2_5 then
    L3_6 = L2_5.resetTimes
    if L3_6 then
      L3_6 = L2_5.resetTimes
      L3_6 = L3_6 or 1
      if A0_3.drawData.usedFreeTimes == 0 or L3_6 > A0_3.drawData.usedFreeTimes then
        L1_4 = true
      end
    end
  end
  if not L1_4 then
    L3_6 = Logic
    L3_6 = L3_6.Get
    L3_6 = L3_6(L3_6, "Lottery")
    L3_6 = L3_6.IsLotteryTimeCold
    L3_6 = L3_6(L3_6)
    if not L3_6 then
      L3_6 = Logic
      L3_6 = L3_6.Get
      L3_6 = L3_6(L3_6, "Lottery")
      L3_6 = L3_6.DecLotteryTime
      L3_6(L3_6)
    else
      L3_6 = Logic
      L3_6 = L3_6.Get
      L3_6 = L3_6(L3_6, "Lottery")
      L3_6 = L3_6.GetArmorColdTime
      L3_6 = L3_6(L3_6, A0_3.drawData)
      A0_3.ttfTime:setString(L3_6)
    end
  end
  L3_6 = Logic
  L3_6 = L3_6.Get
  L3_6 = L3_6(L3_6, "Lottery")
  L3_6 = L3_6.IsLotteryTimeCold
  L3_6 = L3_6(L3_6)
  if not L3_6 then
    L1_4 = true
  end
  A0_3.ttfFree:setVisible(L1_4)
  A0_3.sprFree:setVisible(not L1_4)
  A0_3.ttfTime:setVisible(not L1_4)
  if not L1_4 and not Logic:Get("Lottery"):IsLotteryAcceptJade() then
    A0_3.btnDrawOnce:setBackgroundSpriteForState(CCScale9Sprite:create(_UPVALUE0_), CCControlStateNormal)
    A0_3.btnDrawOnce:setBackgroundSpriteForState(CCScale9Sprite:create(_UPVALUE0_), CCControlStateHighlighted)
  end
end
function prototype.refreshImage(A0_7)
  A0_7:startHeroMove()
  if Logic:Get("Lottery"):IsLotteryAcceptJade() then
    A0_7.sprFirst:setVisible(A0_7.drawData.current == A0_7.drawData.usedFreeTimes)
  else
    A0_7.sprFirst:setVisible(false)
  end
end
function prototype.refreshText(A0_8)
  local L1_9, L2_10, L3_11, L4_12, L5_13, L6_14, L7_15, L8_16
  L1_9 = Logic
  L2_10 = L1_9
  L1_9 = L1_9.Get
  L3_11 = "Lottery"
  L1_9 = L1_9(L2_10, L3_11)
  L2_10 = L1_9
  L1_9 = L1_9.GetDrawData
  L1_9 = L1_9(L2_10)
  A0_8.drawData = L1_9
  L1_9 = A0_8.ttfTitle
  L2_10 = L1_9
  L1_9 = L1_9.setString
  L3_11 = A0_8.drawData
  L3_11 = L3_11.title
  L3_11 = L3_11 or ""
  L1_9(L2_10, L3_11)
  L1_9 = A0_8.ttfFree
  L2_10 = L1_9
  L1_9 = L1_9.setString
  L3_11 = TwGetStr
  L4_12 = 110083
  L8_16 = L3_11(L4_12)
  L1_9(L2_10, L3_11, L4_12, L5_13, L6_14, L7_15, L8_16, L3_11(L4_12))
  L1_9 = KFDBGetRecord
  L2_10 = "EquipLottery"
  L3_11 = A0_8.drawData
  L3_11 = L3_11.id
  L1_9 = L1_9(L2_10, L3_11)
  L2_10 = 0
  if L1_9 then
    L3_11 = L1_9.mustOutTimes
    if L3_11 then
      L3_11 = tonumber
      L4_12 = L1_9.mustOutTimes
      L3_11 = L3_11(L4_12)
      L3_11 = L3_11 or 10
      L4_12 = A0_8.drawData
      L4_12 = L4_12.current
      L4_12 = L4_12 % 10
      L4_12 = L3_11 - L4_12
      L2_10 = L4_12 - 1
    end
  end
  L3_11 = A0_8.ttfTimes
  L4_12 = L3_11
  L3_11 = L3_11.setString
  L5_13 = L2_10
  L3_11(L4_12, L5_13)
  L3_11 = A0_8.ttfTimes
  L4_12 = L3_11
  L3_11 = L3_11.setVisible
  L5_13 = L2_10 ~= 0
  L3_11(L4_12, L5_13)
  L3_11 = A0_8.sprTimes
  L4_12 = L3_11
  L3_11 = L3_11.setVisible
  L5_13 = L2_10 ~= 0
  L3_11(L4_12, L5_13)
  L3_11 = A0_8.sprSure
  L4_12 = L3_11
  L3_11 = L3_11.setVisible
  L5_13 = L2_10 == 0
  L3_11(L4_12, L5_13)
  L3_11 = TwGetStr
  L4_12 = 105227
  L3_11 = L3_11(L4_12)
  L4_12 = TwGetStr
  L5_13 = 105228
  L4_12 = L4_12(L5_13)
  L5_13 = Logic
  L6_14 = L5_13
  L5_13 = L5_13.Get
  L7_15 = "Lottery"
  L5_13 = L5_13(L6_14, L7_15)
  L6_14 = L5_13
  L5_13 = L5_13.GetCostTableByLotteryType
  L5_13 = L5_13(L6_14)
  L7_15 = A0_8
  L6_14 = A0_8.formatDesctrion
  L8_16 = A0_8.ttfOne
  L6_14 = L6_14(L7_15, L8_16, L3_11, L5_13[1], L4_12)
  L7_15 = TwGetStr
  L8_16 = 111128
  L7_15 = L7_15(L8_16)
  L3_11 = L7_15
  L7_15 = TwGetStr
  L8_16 = 111143
  L7_15 = L7_15(L8_16)
  L4_12 = L7_15
  L7_15 = A0_8.ttfTip
  L8_16 = L7_15
  L7_15 = L7_15.setDimensions
  L7_15(L8_16, 200, 50)
  L8_16 = A0_8
  L7_15 = A0_8.formatDesctrion
  L7_15 = L7_15(L8_16, A0_8.ttfTip, L3_11, 1, L4_12, "\n", "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;")
  L8_16 = TwGetStr
  L8_16 = L8_16(111139)
  L3_11 = L8_16
  L8_16 = TwGetStr
  L8_16 = L8_16(111140)
  L4_12 = L8_16
  L8_16 = A0_8.formatDesctrion
  L8_16 = L8_16(A0_8, A0_8.ttfTen, L3_11, L5_13[1] * 10 - L5_13[2], L4_12)
  A0_8.ttfTen:setString(L6_14 .. "\n" .. "&nbsp;" .. "\n" .. L7_15 .. "\n" .. "&nbsp;" .. "\n" .. L8_16)
  if not A0_8.ttfTenCost then
    A0_8.ttfTenCost = CCLabelTTF:create("", "Helvetica", 22)
    A0_8.ttfTenCost:setColor(ccc3(0, 249, 121))
    A0_8.ttfTenCost:setStyle(kCCLabelTTFStyleOutline)
    A0_8.ttfTenCost:setPosition(ccp(A0_8.btnDrawTen:getPositionX(), A0_8.btnDrawTen:getPositionY() - 55))
    A0_8.rootNode:addChild(A0_8.ttfTenCost, 10)
  end
  A0_8.ttfTenCost:setString(tostring(L5_13[2] or 0) .. "\228\187\153\231\142\137")
end
function prototype.refreshByAcceptJade(A0_17, ...)
  local L2_19, L3_20, L4_21
  L2_19 = Logic
  L3_20 = L2_19
  L2_19 = L2_19.Get
  L4_21 = "Lottery"
  L2_19 = L2_19(L3_20, L4_21)
  L3_20 = L2_19
  L2_19 = L2_19.IsLotteryAcceptJade
  L2_19 = L2_19(L3_20)
  if not L2_19 then
    L3_20 = A0_17.imgDrawTen
    L4_21 = L3_20
    L3_20 = L3_20.setVisible
    L3_20(L4_21, false)
    L3_20 = A0_17.btnDrawTen
    L4_21 = L3_20
    L3_20 = L3_20.setVisible
    L3_20(L4_21, false)
    L3_20 = A0_17.imgDrawOnce
    L4_21 = L3_20
    L3_20 = L3_20.setPositionX
    L3_20(L4_21, 320)
    L3_20 = A0_17.btnDrawOnce
    L4_21 = L3_20
    L3_20 = L3_20.setPositionX
    L3_20(L4_21, 320)
    L3_20 = A0_17.ttfFree
    L4_21 = L3_20
    L3_20 = L3_20.setPositionX
    L3_20(L4_21, 320)
    L3_20 = A0_17.ttfTime
    L4_21 = L3_20
    L3_20 = L3_20.setPositionX
    L3_20(L4_21, 290)
    L3_20 = A0_17.sprFree
    L4_21 = L3_20
    L3_20 = L3_20.setPositionX
    L3_20(L4_21, 300)
    L4_21 = A0_17
    L3_20 = A0_17.formatDesctrion
    L3_20 = L3_20(L4_21, nil, TwGetStr(111154))
    L4_21 = A0_17.formatDesctrion
    L4_21 = L4_21(A0_17, nil, TwGetStr(111155))
    A0_17.ttfTip:setString(L3_20 .. "\n" .. "&nbsp;" .. L4_21)
    A0_17.ttfTip:setPositionX(A0_17.ttfTip:getPositionX() + 20)
    A0_17.ttfTen:setVisible(false)
  end
end
function prototype.formatDesctrion(A0_22, A1_23, A2_24, A3_25, A4_26, A5_27, A6_28)
  local L7_29, L8_30, L9_31, L10_32, L11_33
  A5_27 = A5_27 or ""
  A6_28 = A6_28 or ""
  L7_29 = "<font SIZE='20' color='#ffff22' >%s</font> "
  L8_30 = A6_28
  L9_31 = "<font SIZE='20' color='#00F979' >%s</font>"
  L8_30 = L8_30 .. L9_31
  L9_31 = string
  L9_31 = L9_31.format
  L10_32 = L7_29
  L11_33 = A2_24 or ""
  L9_31 = L9_31(L10_32, L11_33)
  L10_32 = string
  L10_32 = L10_32.format
  L11_33 = L8_30
  L10_32 = L10_32(L11_33, A3_25 or "")
  L11_33 = string
  L11_33 = L11_33.format
  L11_33 = L11_33(L7_29, A4_26 or "")
  return L9_31 .. A5_27 .. L10_32 .. L11_33
end
function prototype.onBtnRecharge(A0_34, A1_35, A2_36)
  Logic:Get("Armor"):setSmeltUIBtnNodeDisabled(false)
  SceneHelper:pushScene("ArmorSmelt", A0_34.rootNode)
end
function prototype.onBtnBackCliecked(A0_37, A1_38, A2_39)
  SceneHelper:runWithScene("Mall", A0_37.rootNode)
end
function prototype.onDrawOnceClicked(A0_40, A1_41, A2_42)
  local L3_43, L4_44, L5_45
  L3_43 = Logic
  L4_44 = L3_43
  L3_43 = L3_43.Get
  L5_45 = "Guide"
  L3_43 = L3_43(L4_44, L5_45)
  L4_44 = L3_43
  L3_43 = L3_43.done
  L5_45 = "EquipLottery"
  L3_43(L4_44, L5_45, "SelectTimes")
  L3_43 = true
  L4_44 = A0_40.drawData
  L4_44 = L4_44.resetDate
  if L4_44 then
    L4_44 = Logic
    L5_45 = L4_44
    L4_44 = L4_44.Get
    L4_44 = L4_44(L5_45, "Lottery")
    L5_45 = L4_44
    L4_44 = L4_44.CheckCanLottery
    L4_44 = L4_44(L5_45)
    L3_43 = L4_44
  end
  L4_44 = Logic
  L5_45 = L4_44
  L4_44 = L4_44.Get
  L4_44 = L4_44(L5_45, "Mall")
  L5_45 = L4_44
  L4_44 = L4_44.IsOverDrawLimit
  L4_44 = L4_44(L5_45, A0_40.drawData.type, A0_40.drawData.limits)
  if L4_44 then
    L4_44 = A0_40.drawData
    L4_44 = L4_44.limits
    L4_44 = L4_44 or 0
    L5_45 = Prompt
    L5_45 = L5_45.Fail
    L5_45(L5_45, TwGetStr(105261, L4_44))
    return
  end
  L4_44 = Logic
  L5_45 = L4_44
  L4_44 = L4_44.Get
  L4_44 = L4_44(L5_45, "Mall")
  L5_45 = L4_44
  L4_44 = L4_44.IsOverTimeByData
  L4_44 = L4_44(L5_45, A0_40.drawData)
  if L4_44 then
    L4_44 = Prompt
    L5_45 = L4_44
    L4_44 = L4_44.Fail
    L4_44(L5_45, TwGetStr(105539))
    return
  end
  if not L3_43 then
    L4_44 = Logic
    L5_45 = L4_44
    L4_44 = L4_44.Get
    L4_44 = L4_44(L5_45, "Lottery")
    L5_45 = L4_44
    L4_44 = L4_44.IsLotteryAcceptJade
    L4_44 = L4_44(L5_45)
    if not L4_44 then
      L5_45 = Prompt
      L5_45 = L5_45.Tip
      L5_45(L5_45, TwGetStr(111156) .. TwGetStr(111154) .. TwGetStr(111155))
      return
    end
    L5_45 = Logic
    L5_45 = L5_45.Get
    L5_45 = L5_45(L5_45, "PlayerInfo")
    L5_45 = L5_45.GetPlayerAllJade
    L5_45 = L5_45(L5_45)
    if L5_45 < (Logic:Get("Lottery"):GetCostTableByLotteryType()[1] or 0) then
      Logic:Get("SureConfirm").btnText.ok = TwGetStr(104003)
      Prompt:Confirm(Logic:Get("Main"), "", 105316, Logic:Get("Main").GotoRecharge, Prompt.PROMPT_TYPE.SELECT)
      return
    end
  end
  L4_44 = Logic
  L5_45 = L4_44
  L4_44 = L4_44.Get
  L4_44 = L4_44(L5_45, "Hero")
  L5_45 = L4_44
  L4_44 = L4_44.CheckInsistCard
  L4_44 = L4_44(L5_45, A0_40.drawData.cardTip)
  L5_45 = table
  L5_45 = L5_45.empty
  L5_45 = L5_45(L4_44)
  if not L5_45 then
    A0_40.drawTimes = 1
    L5_45 = Logic
    L5_45 = L5_45.Get
    L5_45 = L5_45(L5_45, "Lottery")
    L5_45 = L5_45.GetNameStr
    L5_45 = L5_45(L5_45, L4_44)
    Prompt:Confirm(A0_40, "", TwGetStr(105272, L5_45), A0_40.GoOnLottery, Prompt.PROMPT_TYPE.SELECT)
    return
  end
  L5_45 = A0_40.askDrawConfirm
  L5_45(A0_40, 1)
end
function prototype.onDrawTenClicked(A0_46, A1_47, A2_48)
  local L3_49, L4_50, L5_51, L6_52, L7_53, L8_54, L9_55
  L3_49 = Logic
  L4_50 = L3_49
  L3_49 = L3_49.Get
  L5_51 = "Mall"
  L3_49 = L3_49(L4_50, L5_51)
  L4_50 = L3_49
  L3_49 = L3_49.IsOverDrawLimit
  L5_51 = A0_46.drawData
  L5_51 = L5_51.type
  L6_52 = A0_46.drawData
  L6_52 = L6_52.limits
  L3_49 = L3_49(L4_50, L5_51, L6_52)
  if L3_49 then
    L3_49 = A0_46.drawData
    L3_49 = L3_49.limits
    L3_49 = L3_49 or 0
    L4_50 = Prompt
    L5_51 = L4_50
    L4_50 = L4_50.Fail
    L6_52 = TwGetStr
    L7_53 = 105261
    L8_54 = L3_49
    L9_55 = L6_52(L7_53, L8_54)
    L4_50(L5_51, L6_52, L7_53, L8_54, L9_55, L6_52(L7_53, L8_54))
    return
  end
  L3_49 = Logic
  L4_50 = L3_49
  L3_49 = L3_49.Get
  L5_51 = "Mall"
  L3_49 = L3_49(L4_50, L5_51)
  L4_50 = L3_49
  L3_49 = L3_49.IsOverTimeByData
  L5_51 = A0_46.drawData
  L3_49 = L3_49(L4_50, L5_51)
  if L3_49 then
    L3_49 = Prompt
    L4_50 = L3_49
    L3_49 = L3_49.Fail
    L5_51 = TwGetStr
    L6_52 = 105539
    L9_55 = L5_51(L6_52)
    L3_49(L4_50, L5_51, L6_52, L7_53, L8_54, L9_55, L5_51(L6_52))
    return
  end
  L3_49 = Logic
  L4_50 = L3_49
  L3_49 = L3_49.Get
  L5_51 = "Mall"
  L3_49 = L3_49(L4_50, L5_51)
  L4_50 = L3_49
  L3_49 = L3_49.GetDrawProgressByKey
  L5_51 = A0_46.drawData
  L5_51 = L5_51.type
  L3_49 = L3_49(L4_50, L5_51)
  L4_50 = A0_46.drawData
  L4_50 = L4_50.limits
  L4_50 = L4_50 or 0
  if L4_50 > 0 then
    L5_51 = L4_50 - L3_49
    if L5_51 < 10 then
      L5_51 = Logic
      L6_52 = L5_51
      L5_51 = L5_51.Get
      L7_53 = "SureConfirm"
      L5_51 = L5_51(L6_52, L7_53)
      L5_51 = L5_51.btnText
      L6_52 = TwGetStr
      L7_53 = 105260
      L6_52 = L6_52(L7_53)
      L5_51.ok = L6_52
      L5_51 = Prompt
      L6_52 = L5_51
      L5_51 = L5_51.Confirm
      L7_53 = A0_46
      L8_54 = ""
      L9_55 = 105259
      L5_51(L6_52, L7_53, L8_54, L9_55, A0_46.onDrawOnceClicked, Prompt.PROMPT_TYPE.SELECT)
      return
    end
  end
  L5_51 = Logic
  L6_52 = L5_51
  L5_51 = L5_51.Get
  L7_53 = "PlayerInfo"
  L5_51 = L5_51(L6_52, L7_53)
  L6_52 = L5_51
  L5_51 = L5_51.GetPlayerAllJade
  L5_51 = L5_51(L6_52)
  L6_52 = Logic
  L7_53 = L6_52
  L6_52 = L6_52.Get
  L8_54 = "Lottery"
  L6_52 = L6_52(L7_53, L8_54)
  L7_53 = L6_52
  L6_52 = L6_52.GetCostTableByLotteryType
  L6_52 = L6_52(L7_53)
  L7_53 = L6_52[2]
  L7_53 = L7_53 or 0
  if L5_51 < L7_53 then
    L8_54 = Logic
    L9_55 = L8_54
    L8_54 = L8_54.Get
    L8_54 = L8_54(L9_55, "SureConfirm")
    L8_54 = L8_54.btnText
    L9_55 = TwGetStr
    L9_55 = L9_55(104003)
    L8_54.ok = L9_55
    L8_54 = Prompt
    L9_55 = L8_54
    L8_54 = L8_54.Confirm
    L8_54(L9_55, Logic:Get("Main"), "", 105316, Logic:Get("Main").GotoRecharge, Prompt.PROMPT_TYPE.SELECT)
    return
  end
  L8_54 = Logic
  L9_55 = L8_54
  L8_54 = L8_54.Get
  L8_54 = L8_54(L9_55, "Hero")
  L9_55 = L8_54
  L8_54 = L8_54.CheckInsistCard
  L8_54 = L8_54(L9_55, A0_46.drawData.cardTip)
  L9_55 = table
  L9_55 = L9_55.empty
  L9_55 = L9_55(L8_54)
  if not L9_55 then
    A0_46.drawTimes = 10
    L9_55 = Logic
    L9_55 = L9_55.Get
    L9_55 = L9_55(L9_55, "Lottery")
    L9_55 = L9_55.GetNameStr
    L9_55 = L9_55(L9_55, L8_54)
    Prompt:Confirm(A0_46, "", TwGetStr(105272, L9_55), A0_46.GoOnLottery, Prompt.PROMPT_TYPE.SELECT)
    return
  end
  L9_55 = A0_46.askDrawConfirm
  L9_55(A0_46, 10)
end
function prototype.OnUILotteryTime(A0_56, A1_57)
  A0_56.ttfFree:setVisible(false)
  A0_56.sprFree:setVisible(true)
  A0_56.ttfTime:setVisible(true)
  A0_56.ttfTime:setString(A1_57 or "")
end
function prototype.OnUILotteryOK(A0_58)
  A0_58.ttfFree:setVisible(true)
  A0_58.sprFree:setVisible(false)
  A0_58.ttfTime:setVisible(false)
  if not Logic:Get("Lottery"):IsLotteryAcceptJade() then
    A0_58.btnDrawOnce:setBackgroundSpriteForState(CCScale9Sprite:create(_UPVALUE0_), CCControlStateNormal)
    A0_58.btnDrawOnce:setBackgroundSpriteForState(CCScale9Sprite:create(_UPVALUE1_), CCControlStateHighlighted)
  end
end
function prototype.OnEquipLottery(A0_59)
  A0_59.drawData = Logic:Get("Lottery"):GetDrawData()
  if Logic:Get("Lottery"):IsLotteryAcceptJade() then
    A0_59.sprFirst:setVisible(A0_59.drawData.current == A0_59.drawData.usedFreeTimes)
  end
  Logic:Get("Lottery"):SetFromArmor(true)
  A0_59.layer:unregisterScriptTouchHandler()
  SceneHelper:removeScene("LotteryResult")
  SceneHelper:pushScene("LotteryResult", A0_59.rootNode)
end
function prototype.OnDrawFailed(A0_60, A1_61)
  if A1_61 == -105 then
    if A0_60.drawType == CURRENCY_TYPE.FRIENDSHIP then
      Prompt:Fail(TwGetStr(105235))
    elseif A0_60.drawType == CURRENCY_TYPE.GOLD then
      Logic:Get("SureConfirm").btnText.ok = TwGetStr(104003)
      Prompt:Confirm(Logic:Get("Main"), "", 105316, Logic:Get("Main").GotoRecharge, Prompt.PROMPT_TYPE.SELECT)
    end
  elseif A1_61 == -8 then
    Prompt:Fail(TwGetStr(100022))
  elseif A1_61 == -20 then
    Prompt:Select(A0_60, "", 105288, A0_60.EquipLotteryByGold)
  else
    Prompt:Fail(tostring(A1_61))
  end
end
function prototype.askDrawConfirm(A0_62, A1_63)
  A0_62.drawTimes = A1_63
  Prompt:Confirm(A0_62, "", "\231\161\174\229\174\154\230\138\189\229\141\161\229\144\151\239\188\159", A0_62.GoOnEquipLottery, Prompt.PROMPT_TYPE.SELECT)
end
function prototype.GoOnEquipLottery(A0_64)
  Logic:Get("Lottery"):PostEquipLottery(A0_64.drawTimes)
end
function prototype.GoOnLottery(A0_65)
  Logic:Get("Lottery"):SetDrawType(A0_65.drawType)
  Logic:Get("Lottery"):PostLottery(A0_65.drawTimes)
end
function prototype.startHeroMove(A0_66)
  local L1_67, L2_68, L3_69, L4_70, L5_71, L6_72, L7_73, L8_74, L9_75, L10_76
  L1_67 = 0
  L2_68 = 0
  L3_69 = A0_66.drawData
  L3_69 = L3_69.cardID
  if L3_69 ~= nil then
    L3_69 = A0_66.drawData
    L3_69 = L3_69.cardID
  elseif L3_69 == "" then
    return
  end
  L3_69 = json
  L3_69 = L3_69.decode
  L4_70 = A0_66.drawData
  L4_70 = L4_70.cardLevel
  L4_70 = L4_70 or "[]"
  L3_69 = L3_69(L4_70)
  L3_69 = L3_69 or {}
  L4_70 = json
  L4_70 = L4_70.decode
  L5_71 = A0_66.drawData
  L5_71 = L5_71.cardID
  L5_71 = L5_71 or "[]"
  L4_70 = L4_70(L5_71)
  L4_70 = L4_70 or {}
  L5_71 = #L3_69
  if L5_71 ~= 0 then
    L5_71 = #L4_70
  elseif L5_71 == 0 then
    return
  end
  L5_71 = L3_69
  for L9_75 = 1, #L3_69 do
    L10_76 = table
    L10_76 = L10_76.insert
    L10_76(L5_71, L3_69[L9_75])
  end
  A0_66.baseIdDouble = L4_70
  for L9_75 = 1, #L4_70 do
    L10_76 = table
    L10_76 = L10_76.insert
    L10_76(A0_66.baseIdDouble, L4_70[L9_75])
  end
  for L9_75 = 1, #L7_73 do
    L10_76 = string
    L10_76 = L10_76.format
    L10_76 = L10_76("subScene%d", L9_75)
    A0_66[L10_76] = Tw.Controller:load("ArmorLotteryMove", A0_66.rootNode)
  end
  L10_76 = A0_66.baseIdDouble
  L10_76 = #L10_76
  L10_76 = 246 * L10_76
  L10_76 = L10_76 / 2
  L10_76 = L9_75(L10_76, 280)
  L7_73(L8_74, L9_75, L10_76, L9_75(L10_76, 280))
  for L10_76 = 1, #L8_74 do
    if A0_66[string.format("subScene%d", L10_76)] then
      A0_66[string.format("subScene%d", L10_76)]:setArmor(A0_66.baseIdDouble[L10_76], L5_71[L10_76])
      A0_66[string.format("subScene%d", L10_76)]:setPosition(ccp(L1_67 + L10_76 * _UPVALUE0_, L2_68))
      L6_72:addChild(A0_66[string.format("subScene%d", L10_76)])
    end
  end
  L10_76 = 246
  L10_76 = L9_75(L10_76, 280)
  L10_76 = kCCScrollViewDirectionHorizontal
  L8_74(L9_75, L10_76)
  L10_76 = true
  L8_74(L9_75, L10_76)
  L10_76 = false
  L8_74(L9_75, L10_76)
  L10_76 = L6_72
  L8_74(L9_75, L10_76)
  L8_74(L9_75)
  A0_66.scrollTag = L8_74
  L10_76 = L7_73
  L8_74(L9_75, L10_76)
  L10_76 = true
  L8_74(L9_75, L10_76)
  L10_76 = bind
  L10_76 = L10_76(A0_66.onTouch, A0_66)
  L8_74(L9_75, L10_76, false, 300, true)
  L10_76 = L7_73.getContentOffset
  L10_76 = L10_76(L7_73)
  L10_76 = L10_76.x
  L10_76 = L10_76 - (#A0_66.baseIdDouble / 2 + 1) * _UPVALUE0_
  L8_74(L9_75, L10_76)
  L8_74(L9_75)
end
function prototype.moveItem(A0_77)
  local L1_78, L2_79, L3_80
  L1_78 = tolua
  L1_78 = L1_78.cast
  L2_79 = A0_77.lstCard
  L3_80 = L2_79
  L2_79 = L2_79.getChildByTag
  L2_79 = L2_79(L3_80, A0_77.scrollTag)
  L3_80 = "CCScrollViewEx"
  L1_78 = L1_78(L2_79, L3_80)
  if L1_78 == nil then
    return
  end
  L3_80 = L1_78
  L2_79 = L1_78.getContainer
  L2_79 = L2_79(L3_80)
  L3_80 = CCArray
  L3_80 = L3_80.create
  L3_80 = L3_80(L3_80)
  L3_80:addObject(CCCallFuncN:create(function()
    if _UPVALUE0_:getContentOffset().x <= -(#_UPVALUE1_.baseIdDouble - 1) * _UPVALUE2_ then
      _UPVALUE3_:setPositionX(-((#_UPVALUE1_.baseIdDouble / 2 - 1) * _UPVALUE2_))
    else
      _UPVALUE3_:setPositionX(_UPVALUE3_:getPositionX() - 0.5)
    end
  end))
  L2_79:runAction(CCRepeatForever:create(CCSequence:create(L3_80)))
end
function prototype.onTouch(A0_81, A1_82, A2_83)
  if A1_82 == CCTOUCHBEGAN and A0_81:isTouchInScoreView(A2_83) then
    A0_81:onTouchBegined(A2_83)
  elseif A1_82 == CCTOUCHENDED then
    A0_81:onTouchEnded(A2_83)
  end
end
function prototype.onTouchBegined(A0_84, A1_85)
  if tolua.cast(A0_84.lstCard:getChildByTag(A0_84.scrollTag), "CCScrollViewEx") == nil then
    return
  end
  if A0_84:isTouchInScoreView(A1_85) then
    A0_84.startPos = A1_85
    tolua.cast(A0_84.lstCard:getChildByTag(A0_84.scrollTag), "CCScrollViewEx"):getContainer():stopAllActions()
  end
end
function prototype.onTouchEnded(A0_86, A1_87)
  local L2_88, L3_89, L4_90, L5_91, L6_92, L7_93, L8_94, L9_95
  L3_89 = A0_86
  L2_88 = A0_86.isTouchInScoreView
  L4_90 = A0_86.startPos
  L2_88 = L2_88(L3_89, L4_90)
  if not L2_88 then
    return
  end
  L2_88 = Logic
  L3_89 = L2_88
  L2_88 = L2_88.Get
  L4_90 = "System"
  L2_88 = L2_88(L3_89, L4_90)
  L3_89 = L2_88
  L2_88 = L2_88.GetTime
  L2_88 = L2_88(L3_89)
  A0_86.timer = L2_88
  L2_88 = A0_86.eventTracer
  L3_89 = L2_88
  L2_88 = L2_88.Exist
  L4_90 = "runActionAgain"
  L2_88 = L2_88(L3_89, L4_90)
  if not L2_88 then
    L2_88 = Singleton
    L3_89 = Timer
    L2_88 = L2_88(L3_89)
    L3_89 = L2_88
    L2_88 = L2_88.Repeat
    L4_90 = 1000
    L6_92 = A0_86
    L5_91 = A0_86.Event
    L7_93 = "runActionAgain"
    L9_95 = L5_91(L6_92, L7_93)
    L2_88(L3_89, L4_90, L5_91, L6_92, L7_93, L8_94, L9_95, L5_91(L6_92, L7_93))
  end
  L2_88 = math
  L2_88 = L2_88.abs
  L3_89 = A0_86.startPos
  L3_89 = L3_89[1]
  L4_90 = A1_87[1]
  L3_89 = L3_89 - L4_90
  L2_88 = L2_88(L3_89)
  if L2_88 <= 20 then
    L2_88 = math
    L2_88 = L2_88.abs
    L3_89 = A0_86.startPos
    L3_89 = L3_89[2]
    L4_90 = A1_87[2]
    L3_89 = L3_89 - L4_90
    L2_88 = L2_88(L3_89)
    if L2_88 <= 20 then
      L3_89 = A0_86
      L2_88 = A0_86.isTouchInScoreView
      L4_90 = A1_87
      L2_88 = L2_88(L3_89, L4_90)
      if L2_88 then
        L3_89 = A0_86
        L2_88 = A0_86.clickHeroIcon
        L4_90 = A1_87
        L2_88(L3_89, L4_90)
        A0_86.startPos = nil
        return
      end
    end
  end
  L2_88 = tolua
  L2_88 = L2_88.cast
  L3_89 = A0_86.lstCard
  L4_90 = L3_89
  L3_89 = L3_89.getChildByTag
  L5_91 = A0_86.scrollTag
  L3_89 = L3_89(L4_90, L5_91)
  L4_90 = "CCScrollViewEx"
  L2_88 = L2_88(L3_89, L4_90)
  if L2_88 == nil then
    return
  end
  L4_90 = L2_88
  L3_89 = L2_88.getContainer
  L3_89 = L3_89(L4_90)
  L5_91 = L2_88
  L4_90 = L2_88.getContentOffset
  L4_90 = L4_90(L5_91)
  L4_90 = L4_90.x
  L5_91 = math
  L5_91 = L5_91.ceil
  L6_92 = _UPVALUE0_
  L6_92 = L4_90 / L6_92
  L5_91 = L5_91(L6_92)
  L6_92 = _UPVALUE0_
  L5_91 = L5_91 * L6_92
  L6_92 = 0
  L7_93 = nil
  L8_94 = A0_86.startPos
  L8_94 = L8_94[1]
  L9_95 = A1_87[1]
  if L8_94 > L9_95 then
    L8_94 = _UPVALUE0_
    L6_92 = L5_91 - L8_94
  else
    L8_94 = A0_86.startPos
    L8_94 = L8_94[1]
    L9_95 = A1_87[1]
    if L8_94 < L9_95 then
      L8_94 = _UPVALUE0_
      L6_92 = L5_91 + L8_94
      L8_94 = _UPVALUE0_
      L8_94 = -L8_94
      if L6_92 >= L8_94 then
        L8_94 = _UPVALUE0_
        L6_92 = -L8_94
      end
    end
  end
  L8_94 = CCMoveTo
  L9_95 = L8_94
  L8_94 = L8_94.create
  L8_94 = L8_94(L9_95, 0.5, ccp(L6_92, L2_88:getContentOffset().y))
  L7_93 = L8_94
  L8_94 = CCArray
  L9_95 = L8_94
  L8_94 = L8_94.create
  L8_94 = L8_94(L9_95)
  L9_95 = L8_94.addObject
  L9_95(L8_94, L7_93)
  L9_95 = _UPVALUE0_
  L9_95 = -L9_95
  if L6_92 >= L9_95 then
    function L9_95()
      _UPVALUE0_:setPositionX(-((#_UPVALUE1_.baseIdDouble / 2 + 1) * _UPVALUE2_))
    end
    L8_94:addObject(CCCallFuncN:create(L9_95))
  end
  L9_95 = A0_86.baseIdDouble
  L9_95 = #L9_95
  L9_95 = L9_95 - 1
  L9_95 = -L9_95
  L9_95 = L9_95 * _UPVALUE0_
  if L6_92 < L9_95 then
    function L9_95()
      _UPVALUE0_:setPositionX(-(#_UPVALUE1_.baseIdDouble / 2 * _UPVALUE2_))
    end
    L8_94:addObject(CCCallFuncN:create(L9_95))
  end
  if L8_94 then
    L9_95 = L3_89.runAction
    L9_95(L3_89, CCSequence:create(L8_94))
  end
  A0_86.startPos = nil
end
function prototype.runActionAgain(A0_96)
  local L1_97
  L1_97 = Logic
  L1_97 = L1_97.Get
  L1_97 = L1_97(L1_97, "System")
  L1_97 = L1_97.GetTime
  L1_97 = L1_97(L1_97)
  if Logic:Get("System"):DiffTime(L1_97, A0_96.timer) >= 2 then
    A0_96:EventTracer():Cancel("runActionAgain")
    A0_96:moveItem()
  end
end
function prototype.isTouchInScoreView(A0_98, A1_99)
  if A1_99 == nil or table.empty(A1_99) or A1_99[1] == nil or A1_99[2] == nil then
    return false
  end
  if A0_98.lstCard:getPositionX() <= A1_99[1] and A1_99[1] <= A0_98.lstCard:getPositionX() + A0_98.lstCard:getContentSize().width and A0_98.lstCard:getPositionY() <= A1_99[2] and A1_99[2] <= A0_98.lstCard:getPositionY() + A0_98.lstCard:getContentSize().height then
    return true
  end
  return false
end
function prototype.clickHeroIcon(A0_100, A1_101)
  local L2_102, L3_103, L4_104, L5_105, L6_106, L7_107
  if A1_101 ~= nil then
    L2_102 = table
    L2_102 = L2_102.empty
    L3_103 = A1_101
    L2_102 = L2_102(L3_103)
  elseif L2_102 then
    return
  end
  L2_102 = tolua
  L2_102 = L2_102.cast
  L3_103 = A0_100.lstCard
  L3_103 = L3_103.getChildByTag
  L3_103 = L3_103(L4_104, L5_105)
  L2_102 = L2_102(L3_103, L4_104)
  if L2_102 == nil then
    return
  end
  L3_103 = L2_102.getContainer
  L3_103 = L3_103(L4_104)
  for L7_107 = 1, #L5_105 do
    if A0_100[string.format("subScene%d", L7_107)] and L2_102:getContentOffset().x + A0_100[string.format("subScene%d", L7_107)]:getPositionX() <= A1_101[1] and A1_101[1] <= L2_102:getContentOffset().x + A0_100[string.format("subScene%d", L7_107)]:getPositionX() + A0_100[string.format("subScene%d", L7_107)]:getContentSize().width then
      A0_100[string.format("subScene%d", L7_107)]:onBtnHeroInfo()
      return
    end
  end
end
function prototype.EquipLotteryByGold(A0_108, A1_109)
  local L2_110, L3_111
  L2_110 = Logic
  L2_110 = L2_110.SureConfirm
  L2_110 = L2_110.RET
  L2_110 = L2_110.OK
  if A1_109 ~= L2_110 then
    return
  end
  L2_110 = Logic
  L3_111 = L2_110
  L2_110 = L2_110.Get
  L2_110 = L2_110(L3_111, "Mall")
  L3_111 = L2_110
  L2_110 = L2_110.IsOverDrawLimit
  L2_110 = L2_110(L3_111, A0_108.drawData.type, A0_108.drawData.limits)
  if L2_110 then
    L2_110 = A0_108.drawData
    L2_110 = L2_110.limits
    L2_110 = L2_110 or 0
    L3_111 = Prompt
    L3_111 = L3_111.Fail
    L3_111(L3_111, TwGetStr(105261, L2_110))
    return
  end
  L2_110 = Logic
  L3_111 = L2_110
  L2_110 = L2_110.Get
  L2_110 = L2_110(L3_111, "Mall")
  L3_111 = L2_110
  L2_110 = L2_110.IsOverTimeByData
  L2_110 = L2_110(L3_111, A0_108.drawData)
  if L2_110 then
    L2_110 = Prompt
    L3_111 = L2_110
    L2_110 = L2_110.Fail
    L2_110(L3_111, TwGetStr(105539))
    return
  end
  L2_110 = canLotteryFree
  if not L2_110 then
    L2_110 = Logic
    L3_111 = L2_110
    L2_110 = L2_110.Get
    L2_110 = L2_110(L3_111, "PlayerInfo")
    L3_111 = L2_110
    L2_110 = L2_110.GetPlayerAllJade
    L2_110 = L2_110(L3_111)
    L3_111 = Logic
    L3_111 = L3_111.Get
    L3_111 = L3_111(L3_111, "Lottery")
    L3_111 = L3_111.GetCostTableByLotteryType
    L3_111 = L3_111(L3_111)
    if L2_110 < (L3_111[1] or 0) then
      Logic:Get("SureConfirm").btnText.ok = TwGetStr(104003)
      Prompt:Confirm(Logic:Get("Main"), "", 105316, Logic:Get("Main").GotoRecharge, Prompt.PROMPT_TYPE.SELECT)
      return
    end
  end
  L2_110 = Logic
  L3_111 = L2_110
  L2_110 = L2_110.Get
  L2_110 = L2_110(L3_111, "Hero")
  L3_111 = L2_110
  L2_110 = L2_110.CheckInsistCard
  L2_110 = L2_110(L3_111, A0_108.drawData.cardTip)
  L3_111 = table
  L3_111 = L3_111.empty
  L3_111 = L3_111(L2_110)
  if not L3_111 then
    A0_108.drawTimes = 1
    L3_111 = Logic
    L3_111 = L3_111.Get
    L3_111 = L3_111(L3_111, "Lottery")
    L3_111 = L3_111.GetNameStr
    L3_111 = L3_111(L3_111, L2_110)
    Prompt:Confirm(A0_108, "", TwGetStr(105272, L3_111), A0_108.GoOnLottery, Prompt.PROMPT_TYPE.SELECT)
    return
  end
  L3_111 = Logic
  L3_111 = L3_111.Get
  L3_111 = L3_111(L3_111, "Lottery")
  L3_111 = L3_111.PostEquipLottery
  L3_111(L3_111, 1, false)
end
