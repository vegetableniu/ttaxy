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
L0_0 = TypeDef
L0_0 = L0_0("com.eyu.mt.module.currency.model.CurrencyType")
CURRENCY_TYPE = L0_0
L0_0 = 6
function prototype.initialize(A0_1, ...)
  local L3_3, L4_4
  L3_3 = super
  L3_3 = L3_3.initialize
  L4_4 = A0_1
  L3_3(L4_4, ...)
  A0_1.drawType = nil
  A0_1.oneDrawCost = 0
  A0_1.drawData = nil
  A0_1.timer = 0
end
function prototype.dispose(A0_5, ...)
  super.dispose(A0_5)
end
function prototype.onEnter(A0_7)
  local L1_8, L2_9, L3_10, L4_11
  L1_8(L2_9)
  A0_7.drawData = L1_8
  L1_8(L2_9, L3_10)
  for L4_11 = 1, _UPVALUE0_ do
    if A0_7[string.format("ttfTip%d", L4_11)] then
      A0_7[string.format("ttfTip%d", L4_11)]:setStyle(kCCLabelTTFStyleOutline)
    end
    if A0_7[string.format("ttfNum%d", L4_11)] then
      A0_7[string.format("ttfNum%d", L4_11)]:setStyle(kCCLabelTTFStyleOutline)
    end
  end
  L1_8(L2_9, L3_10)
  L1_8(L2_9, L3_10)
  L1_8(L2_9, L3_10)
  L1_8(L2_9)
  L1_8(L2_9)
  L4_11 = A0_7.Event
  L4_11 = L4_11(A0_7, "onDrawSuccussed")
  L1_8(L2_9, L3_10, L4_11, L4_11(A0_7, "onDrawSuccussed"))
  L4_11 = A0_7.Event
  L4_11 = L4_11(A0_7, "onDrawFailed")
  L1_8(L2_9, L3_10, L4_11, L4_11(A0_7, "onDrawFailed"))
  L4_11 = "SelectTimes"
  if L1_8 then
    L1_8(L2_9, L3_10)
    L1_8(L2_9, L3_10)
    L1_8(L2_9, L3_10)
  end
  L1_8(L2_9)
  L4_11 = A0_7.sprRight
  A0_7.ani = L1_8
  if L1_8 then
    L1_8(L2_9)
  end
end
function prototype.onExit(A0_12)
  Logic:Get("Lottery"):SetFrom(Logic.Lottery.FROM_MALL)
end
function prototype.onNodeLoaded(A0_13, A1_14, A2_15)
end
function prototype.onBtnRecharge(A0_16, A1_17, A2_18)
  Logic:Get("Main"):GotoRecharge()
end
function prototype.onBtnBackCliecked(A0_19, A1_20, A2_21)
  if Logic:Get("Lottery"):GetFrom() == Logic.Lottery.FROM_DEVIL then
    SceneHelper:runWithScene("DevilMain", A0_19.rootNode)
  else
    SceneHelper:runWithScene("Mall", A0_19.rootNode)
  end
end
function prototype.onDrawOnceClicked(A0_22, A1_23, A2_24)
  local L3_25, L4_26, L5_27, L6_28, L7_29
  L3_25 = A0_22.drawType
  if L3_25 == nil then
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
  L3_25 = A0_22.drawData
  L3_25 = L3_25.lotteryType
  if L3_25 == "ACTIVITY_RP" then
    L4_26 = A0_22
    L3_25 = A0_22.SendRateUpDraw
    L3_25(L4_26)
    return
  end
  L3_25 = A0_22.drawData
  L3_25 = L3_25.type
  L4_26 = Logic
  L4_26 = L4_26.Mall
  L4_26 = L4_26.ITEM_TYPE
  L4_26 = L4_26.LOTTERY_STONE
  if L3_25 == L4_26 then
    L4_26 = A0_22
    L3_25 = A0_22.SendColorDraw
    L5_27 = 1
    L3_25(L4_26, L5_27)
    return
  end
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
  L4_26 = L4_26.GetCostTableByLotteryType
  L4_26 = L4_26(L5_27)
  L5_27 = L4_26[1]
  L5_27 = L5_27 or 0
  if L3_25 < L5_27 then
    L6_28 = Logic
    L7_29 = L6_28
    L6_28 = L6_28.Get
    L6_28 = L6_28(L7_29, "SureConfirm")
    L6_28 = L6_28.btnText
    L7_29 = TwGetStr
    L7_29 = L7_29(104003)
    L6_28.ok = L7_29
    L6_28 = Prompt
    L7_29 = L6_28
    L6_28 = L6_28.Confirm
    L6_28(L7_29, Logic:Get("Main"), "", 105316, Logic:Get("Main").GotoRecharge, Prompt.PROMPT_TYPE.SELECT)
    return
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
function prototype.onDrawTenClicked(A0_30, A1_31, A2_32)
  local L3_33, L4_34, L5_35, L6_36, L7_37, L8_38, L9_39
  L3_33 = A0_30.drawType
  if L3_33 == nil then
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
  L3_33 = A0_30.drawData
  L3_33 = L3_33.type
  L4_34 = Logic
  L4_34 = L4_34.Mall
  L4_34 = L4_34.ITEM_TYPE
  L4_34 = L4_34.LOTTERY_THREE
  if L3_33 == L4_34 then
    L4_34 = A0_30
    L3_33 = A0_30.SendThreeDraw
    L3_33(L4_34)
    return
  end
  L3_33 = A0_30.drawData
  L3_33 = L3_33.type
  L4_34 = Logic
  L4_34 = L4_34.Mall
  L4_34 = L4_34.ITEM_TYPE
  L4_34 = L4_34.LOTTERY_STONE
  if L3_33 == L4_34 then
    L4_34 = A0_30
    L3_33 = A0_30.SendColorDraw
    L5_35 = 10
    L3_33(L4_34, L5_35)
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
  L4_34 = L4_34 or 0
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
  L7_37 = "PlayerInfo"
  L5_35 = L5_35(L6_36, L7_37)
  L6_36 = L5_35
  L5_35 = L5_35.GetPlayerAllJade
  L5_35 = L5_35(L6_36)
  L6_36 = Logic
  L7_37 = L6_36
  L6_36 = L6_36.Get
  L8_38 = "Lottery"
  L6_36 = L6_36(L7_37, L8_38)
  L7_37 = L6_36
  L6_36 = L6_36.GetCostTableByLotteryType
  L6_36 = L6_36(L7_37)
  L7_37 = L6_36[2]
  L7_37 = L7_37 or 0
  if L5_35 < L7_37 then
    L8_38 = Logic
    L9_39 = L8_38
    L8_38 = L8_38.Get
    L8_38 = L8_38(L9_39, "SureConfirm")
    L8_38 = L8_38.btnText
    L9_39 = TwGetStr
    L9_39 = L9_39(104003)
    L8_38.ok = L9_39
    L8_38 = Prompt
    L9_39 = L8_38
    L8_38 = L8_38.Confirm
    L8_38(L9_39, Logic:Get("Main"), "", 105316, Logic:Get("Main").GotoRecharge, Prompt.PROMPT_TYPE.SELECT)
    return
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
function prototype.resetDescription(A0_40)
  if A0_40.drawData == nil or table.empty(A0_40.drawData) then
    return
  end
  if Logic:Get("Mall"):IsOnceDraw(A0_40.drawData.type) then
    A0_40:InitOneDrawDesc()
    return
  end
  if A0_40.drawData.lotteryType == "ACTIVITY_RP" then
    A0_40:InitRateUpDesc()
    return
  end
  if A0_40.drawData.type == Logic.Mall.ITEM_TYPE.LOTTERY_THREE then
    A0_40:InitThreeDesc()
    return
  end
  if A0_40.drawData.type == Logic.Mall.ITEM_TYPE.LOTTERY_STONE then
    A0_40:InitColorBoxDesc()
    return
  end
  if string.find(A0_40.drawData.showTemplete, "ORANGE_") then
    A0_40:InitOrangeDesc()
    return
  end
  if "VIP" == A0_40.drawData.showTemplete then
    A0_40:InitVipDesc()
    return
  end
  A0_40:InitStoneDesc()
end
function prototype.refreshFirstTenDiscount(A0_41)
  if not A0_41.sprFirstTenDiscount then
    A0_41.sprFirstTenDiscount = CCSprite:create("images/MallRace/discount5.png")
    if A0_41.sprFirstTenDiscount then
      A0_41.sprFirstTenDiscount:setPosition(ccp(A0_41.btnDrawTen:getPositionX() - 70, A0_41.btnDrawTen:getPositionY() + 45))
      A0_41.rootNode:addChild(A0_41.sprFirstTenDiscount, 99)
    end
  end
  if not A0_41.sprFirstTenDiscount then
    return
  end
  A0_41.sprFirstTenDiscount:setVisible((json.decode(A0_41.drawData.prices or "[]") or {})[2] and (A0_41.drawData.salePrices or {})[2] and tonumber((json.decode(A0_41.drawData.prices or "[]") or {})[2]) < tonumber((A0_41.drawData.salePrices or {})[2]) and true or false)
end
function prototype.InitVipDesc(A0_42)
  local L1_43, L2_44
  L1_43 = CURRENCY_TYPE
  L1_43 = L1_43.GOLD
  A0_42.drawType = L1_43
  L1_43 = Logic
  L2_44 = L1_43
  L1_43 = L1_43.Get
  L1_43 = L1_43(L2_44, "Lottery")
  L2_44 = L1_43
  L1_43 = L1_43.GetCostTableByLotteryType
  L1_43 = L1_43(L2_44)
  L2_44 = L1_43[1]
  L2_44 = L2_44 or 0
  if L2_44 == nil then
    return
  end
  A0_42.btnDrawTen:setVisible(false)
  A0_42.imgDrawTen:setVisible(false)
  A0_42.btnDrawOnce:setPositionX(320)
  A0_42.imgDrawOnce:setPositionX(320)
  A0_42:VipDesc(L2_44)
  A0_42:refreshPrivilegeCooldown()
end
function prototype.VipDesc(A0_45, A1_46)
  local L2_47, L3_48, L4_49, L5_50
  L2_47 = tonumber
  L3_48 = A0_45.drawData
  L3_48 = L3_48.id
  L2_47 = L2_47(L3_48)
  if L2_47 == 1022 or L2_47 == 1025 then
    L3_48 = A0_45.ttfTip1
    L4_49 = L3_48
    L3_48 = L3_48.setString
    L5_50 = "\229\191\133\229\135\186\230\169\153\229\141\161\231\162\142\231\137\135"
    L3_48(L4_49, L5_50)
    L3_48 = A0_45.ttfText2
    L4_49 = L3_48
    L3_48 = L3_48.setString
    L5_50 = "\228\184\128\230\172\161\230\138\189\229\165\150\233\156\128\232\166\1297\229\164\169"
    L3_48(L4_49, L5_50)
    L3_48 = A0_45.ttfTip5
    L4_49 = L3_48
    L3_48 = L3_48.setString
    L5_50 = "\230\156\137\230\166\130\231\142\135\229\135\186\228\184\138\229\143\164\231\178\190\233\173\132"
    L3_48(L4_49, L5_50)
  elseif L2_47 == 1023 then
    L3_48 = A0_45.ttfTip1
    L4_49 = L3_48
    L3_48 = L3_48.setString
    L5_50 = "\229\191\133\229\135\186\233\151\170\229\141\161\231\162\142\231\137\135"
    L3_48(L4_49, L5_50)
    L3_48 = A0_45.ttfText2
    L4_49 = L3_48
    L3_48 = L3_48.setString
    L5_50 = "\228\184\128\230\172\161\230\138\189\229\165\150\233\156\128\232\166\1296\229\164\169"
    L3_48(L4_49, L5_50)
    L3_48 = A0_45.ttfTip5
    L4_49 = L3_48
    L3_48 = L3_48.setString
    L5_50 = "\230\156\137\230\166\130\231\142\135\229\135\186\229\166\130\230\157\165\231\156\159\231\187\143"
    L3_48(L4_49, L5_50)
  elseif L2_47 == 1024 then
    L3_48 = A0_45.ttfTip1
    L4_49 = L3_48
    L3_48 = L3_48.setString
    L5_50 = "\229\135\186\228\184\137\230\152\159\229\159\186\231\161\128\229\141\161"
    L3_48(L4_49, L5_50)
    L3_48 = A0_45.ttfText2
    L4_49 = L3_48
    L3_48 = L3_48.setString
    L5_50 = "\228\184\128\230\172\161\230\138\189\229\165\150\233\156\128\232\166\1291\229\164\169"
    L3_48(L4_49, L5_50)
    L3_48 = A0_45.ttfTip5
    L4_49 = L3_48
    L3_48 = L3_48.setString
    L5_50 = "\230\156\137\230\166\130\231\142\135\229\135\186\228\185\157\232\189\172\233\135\145\228\184\185"
    L3_48(L4_49, L5_50)
  else
    L3_48 = A0_45.ttfTip1
    L4_49 = L3_48
    L3_48 = L3_48.setString
    L5_50 = TwGetStr
    L5_50 = L5_50(105211, 3)
    L3_48(L4_49, L5_50, L5_50(105211, 3))
    L3_48 = TwGetStr
    L4_49 = 105227
    L3_48 = L3_48(L4_49)
    L4_49 = TwGetStr
    L5_50 = 105228
    L4_49 = L4_49(L5_50)
    L5_50 = A0_45.formatDesctrion
    L5_50(A0_45, A0_45.ttfText2, L3_48, A1_46, L4_49)
    L5_50 = A0_45.ttfTip5
    L5_50 = L5_50.setString
    L5_50(L5_50, TwGetStr(105277))
  end
  L3_48 = A0_45.drawData
  L3_48 = L3_48.limits
  L3_48 = L3_48 or 0
  if L3_48 > 0 then
    L4_49 = Logic
    L5_50 = L4_49
    L4_49 = L4_49.Get
    L4_49 = L4_49(L5_50, "Mall")
    L5_50 = L4_49
    L4_49 = L4_49.GetDrawProgressByKey
    L4_49 = L4_49(L5_50, A0_45.drawData.type)
    L5_50 = string
    L5_50 = L5_50.format
    L5_50 = L5_50("%d/%d", L4_49, L3_48)
    A0_45.ttfTip4:setColor(ccc3(255, 0, 0))
    A0_45.ttfTip4:setString(TwGetStr(105258, L3_48) .. " " .. L5_50)
  end
  L4_49 = A0_45.drawData
  if L4_49 then
    L4_49 = A0_45.drawData
    L4_49 = L4_49.desInPage
    if L4_49 then
      L4_49 = A0_45.ttfLast
      L5_50 = L4_49
      L4_49 = L4_49.setString
      L4_49(L5_50, ReplaceStringTab(A0_45.drawData.desInPage) or "")
    end
  end
end
function prototype.refreshPrivilegeCooldown(A0_51)
  local L1_52, L2_53, L3_54, L4_55, L5_56
  L1_52 = tonumber
  L2_53 = A0_51.drawData
  L2_53 = L2_53.cooldownHours
  L1_52 = L1_52(L2_53)
  L1_52 = L1_52 or 0
  if L1_52 <= 0 then
    return
  end
  L2_53 = tonumber
  L3_54 = A0_51.drawData
  L3_54 = L3_54.resetDate
  L2_53 = L2_53(L3_54)
  L2_53 = L2_53 or 0
  L3_54 = 0
  if L2_53 > 0 then
    L4_55 = Logic
    L5_56 = L4_55
    L4_55 = L4_55.Get
    L4_55 = L4_55(L5_56, "System")
    L5_56 = L4_55
    L4_55 = L4_55.DiffTime
    L4_55 = L4_55(L5_56, L2_53 / 1000 + L1_52 * 3600)
    L3_54 = L4_55
  end
  if L3_54 <= 0 then
    L4_55 = A0_51.ttfLast
    L5_56 = L4_55
    L4_55 = L4_55.setString
    L4_55(L5_56, "\229\143\175\228\187\165\230\138\189\229\143\150")
    L4_55 = A0_51.btnDrawOnce
    L5_56 = L4_55
    L4_55 = L4_55.setEnabled
    L4_55(L5_56, true)
    return
  end
  L4_55 = Logic
  L5_56 = L4_55
  L4_55 = L4_55.Get
  L4_55 = L4_55(L5_56, "System")
  L5_56 = L4_55
  L4_55 = L4_55.SecToDay
  L4_55 = L4_55(L5_56, L3_54)
  L4_55 = L4_55 or {}
  L5_56 = L4_55.hour
  L5_56 = L5_56 or 0
  L5_56 = L5_56 + (L4_55.day or 0) * 24
  A0_51.ttfLast:setString(string.format("%02d:%02d:%02d\229\144\142\229\143\175\228\187\165\230\138\189\229\143\150", L5_56, L4_55.min or 0, L4_55.sec or 0))
  A0_51.btnDrawOnce:setEnabled(false)
  Singleton(Timer):After(1000, A0_51:Event("refreshPrivilegeCooldown"))
end
function prototype.InitOneDrawDesc(A0_57)
  local L1_58, L2_59
  L1_58 = CURRENCY_TYPE
  L1_58 = L1_58.GOLD
  A0_57.drawType = L1_58
  L1_58 = Logic
  L2_59 = L1_58
  L1_58 = L1_58.Get
  L1_58 = L1_58(L2_59, "Lottery")
  L2_59 = L1_58
  L1_58 = L1_58.GetCostTableByLotteryType
  L1_58 = L1_58(L2_59)
  L2_59 = L1_58[1]
  L2_59 = L2_59 or 0
  if L2_59 == nil then
    return
  end
  A0_57.btnDrawTen:setVisible(false)
  A0_57.imgDrawTen:setVisible(false)
  A0_57.btnDrawOnce:setPositionX(320)
  A0_57.imgDrawOnce:setPositionX(320)
  A0_57:OneDraw(L2_59, A0_57.drawData.baseId)
end
function prototype.OneDraw(A0_60, A1_61, A2_62)
  local L3_63, L4_64, L5_65, L6_66, L7_67
  L3_63 = tostring
  L4_64 = A1_61
  L3_63 = L3_63(L4_64)
  L4_64 = TwGetStr
  L5_65 = 105227
  L4_64 = L4_64(L5_65)
  L5_65 = TwGetStr
  L6_66 = 105228
  L5_65 = L5_65(L6_66)
  L7_67 = A0_60
  L6_66 = A0_60.formatDesctrion
  L6_66(L7_67, A0_60.ttfText2, L4_64, L3_63, L5_65)
  L6_66 = A0_60.ttfTip5
  L7_67 = L6_66
  L6_66 = L6_66.setString
  L6_66(L7_67, TwGetStr(105267))
  L6_66 = Logic
  L7_67 = L6_66
  L6_66 = L6_66.Get
  L6_66 = L6_66(L7_67, "Hero")
  L7_67 = L6_66
  L6_66 = L6_66.GetHeroInfoByBaseId
  L6_66 = L6_66(L7_67, A2_62)
  if L6_66 then
    L7_67 = TwGetStr
    L7_67 = L7_67(105266, L6_66.star or 0, L6_66.name or "")
    A0_60.ttfTip4:setFontSize(30)
    A0_60.ttfTip4:setColor(ccc3(255, 0, 0))
    A0_60.ttfTip4:setString(L7_67)
  end
  L7_67 = A0_60.ttfTip6
  L7_67 = L7_67.setFontSize
  L7_67(L7_67, 25)
  L7_67 = A0_60.ttfTip6
  L7_67 = L7_67.setColor
  L7_67(L7_67, ccc3(255, 0, 0))
  L7_67 = A0_60.ttfTip6
  L7_67 = L7_67.setString
  L7_67(L7_67, TwGetStr(105258, 1))
  L7_67 = A0_60.drawData
  if L7_67 then
    L7_67 = A0_60.drawData
    L7_67 = L7_67.desInPage
    if L7_67 then
      L7_67 = A0_60.ttfLast
      L7_67 = L7_67.setString
      L7_67(L7_67, ReplaceStringTab(A0_60.drawData.desInPage) or "")
    end
  end
end
function prototype.SendRateUpDraw(A0_68)
  local L1_69, L2_70, L3_71, L4_72
  L1_69 = Logic
  L2_70 = L1_69
  L1_69 = L1_69.Get
  L3_71 = "PlayerInfo"
  L1_69 = L1_69(L2_70, L3_71)
  L2_70 = L1_69
  L1_69 = L1_69.GetPlayerAllJade
  L1_69 = L1_69(L2_70)
  L2_70 = Logic
  L3_71 = L2_70
  L2_70 = L2_70.Get
  L4_72 = "Lottery"
  L2_70 = L2_70(L3_71, L4_72)
  L3_71 = L2_70
  L2_70 = L2_70.GetRateUpCostByType
  L4_72 = A0_68.drawData
  L4_72 = L4_72.type
  L2_70 = L2_70(L3_71, L4_72)
  if L1_69 < L2_70 then
    L3_71 = Logic
    L4_72 = L3_71
    L3_71 = L3_71.Get
    L3_71 = L3_71(L4_72, "SureConfirm")
    L3_71 = L3_71.btnText
    L4_72 = TwGetStr
    L4_72 = L4_72(104003)
    L3_71.ok = L4_72
    L3_71 = Prompt
    L4_72 = L3_71
    L3_71 = L3_71.Confirm
    L3_71(L4_72, Logic:Get("Main"), "", 105316, Logic:Get("Main").GotoRecharge, Prompt.PROMPT_TYPE.SELECT)
    return
  end
  L3_71 = Logic
  L4_72 = L3_71
  L3_71 = L3_71.Get
  L3_71 = L3_71(L4_72, "Hero")
  L4_72 = L3_71
  L3_71 = L3_71.CheckInsistCard
  L3_71 = L3_71(L4_72, A0_68.drawData.cardTip)
  L4_72 = table
  L4_72 = L4_72.empty
  L4_72 = L4_72(L3_71)
  if not L4_72 then
    A0_68.drawTimes = 1
    L4_72 = Logic
    L4_72 = L4_72.Get
    L4_72 = L4_72(L4_72, "Lottery")
    L4_72 = L4_72.GetNameStr
    L4_72 = L4_72(L4_72, L3_71)
    Prompt:Confirm(A0_68, "", TwGetStr(105272, L4_72), A0_68.GoOnLottery, Prompt.PROMPT_TYPE.SELECT)
    return
  end
  L4_72 = A0_68.askDrawConfirm
  L4_72(A0_68, 1)
end
function prototype.InitRateUpDesc(A0_73)
  local L1_74, L2_75, L3_76, L4_77, L5_78, L6_79
  L1_74 = CURRENCY_TYPE
  L1_74 = L1_74.GOLD
  A0_73.drawType = L1_74
  L1_74 = Logic
  L2_75 = L1_74
  L1_74 = L1_74.Get
  L3_76 = "Lottery"
  L1_74 = L1_74(L2_75, L3_76)
  L2_75 = L1_74
  L1_74 = L1_74.GetRateUpCostByType
  L3_76 = A0_73.drawData
  L3_76 = L3_76.type
  L1_74 = L1_74(L2_75, L3_76)
  L2_75 = A0_73.drawData
  L2_75 = L2_75.probability
  if L2_75 ~= nil then
    L2_75 = A0_73.drawData
    L2_75 = L2_75.probability
  elseif "" == L2_75 then
    return
  end
  L2_75 = json
  L2_75 = L2_75.decode
  L3_76 = A0_73.drawData
  L3_76 = L3_76.probability
  L2_75 = L2_75(L3_76)
  L2_75 = L2_75 or {}
  L3_76 = Logic
  L4_77 = L3_76
  L3_76 = L3_76.Get
  L5_78 = "Mall"
  L3_76 = L3_76(L4_77, L5_78)
  L4_77 = L3_76
  L3_76 = L3_76.GetDrawProgressByKey
  L5_78 = A0_73.drawData
  L5_78 = L5_78.type
  L3_76 = L3_76(L4_77, L5_78)
  if L3_76 == nil then
    L4_77 = 0
    L3_76 = L4_77 or L3_76
  end
  L3_76 = L3_76 + 1
  if L3_76 <= 0 then
    L4_77 = 1
    L3_76 = L4_77 or L3_76
  end
  L4_77 = #L2_75
  if L3_76 > L4_77 then
    L4_77 = #L2_75
    L3_76 = L4_77 or L3_76
  end
  L4_77 = L3_76 + 1
  L5_78 = #L2_75
  if L4_77 > L5_78 then
    L5_78 = #L2_75
    L4_77 = L5_78 or L4_77
  end
  L5_78 = L2_75[L3_76]
  L5_78 = L5_78 or 0
  L6_79 = L2_75[L4_77]
  L6_79 = L6_79 or 0
  A0_73.btnDrawTen:setVisible(false)
  A0_73.imgDrawTen:setVisible(false)
  A0_73.btnDrawOnce:setPositionX(320)
  A0_73.imgDrawOnce:setPositionX(320)
  A0_73:RateUpDraw(L1_74, A0_73.drawData.baseId, L5_78, L6_79)
end
function prototype.RateUpDraw(A0_80, A1_81, A2_82, A3_83, A4_84)
  local L5_85, L6_86, L7_87, L8_88, L9_89, L10_90, L11_91, L12_92, L13_93, L14_94, L15_95, L16_96
  L5_85 = tostring
  L6_86 = A1_81
  L5_85 = L5_85(L6_86)
  L6_86 = A0_80.sprLine
  L7_87 = L6_86
  L6_86 = L6_86.setVisible
  L8_88 = false
  L6_86(L7_87, L8_88)
  L6_86 = A0_80.drawData
  L6_86 = L6_86.showTemplete
  L6_86 = L6_86 == "EQUIP_LEIJIN"
  L7_87 = A0_80.sprRecommend
  L8_88 = L7_87
  L7_87 = L7_87.setVisible
  L9_89 = not L6_86
  L7_87(L8_88, L9_89)
  if L6_86 then
    L7_87 = TwGetStr
    L8_88 = 105289
    L7_87 = L7_87(L8_88)
  elseif not L7_87 then
    L7_87 = TwGetStr
    L8_88 = 105211
    L9_89 = 3
    L7_87 = L7_87(L8_88, L9_89)
  end
  L8_88 = A0_80.ttfTip1
  L9_89 = L8_88
  L8_88 = L8_88.setString
  L10_90 = L7_87
  L8_88(L9_89, L10_90)
  L8_88 = TwGetStr
  L9_89 = 105227
  L8_88 = L8_88(L9_89)
  L9_89 = TwGetStr
  L10_90 = 105228
  L9_89 = L9_89(L10_90)
  L11_91 = A0_80
  L10_90 = A0_80.formatDesctrion
  L12_92 = A0_80.ttfText2
  L13_93 = L8_88
  L14_94 = L5_85
  L15_95 = L9_89
  L10_90(L11_91, L12_92, L13_93, L14_94, L15_95)
  L10_90 = A0_80.ttfText2
  L11_91 = L10_90
  L10_90 = L10_90.setPositionY
  L12_92 = A0_80.ttfText2
  L13_93 = L12_92
  L12_92 = L12_92.getPositionY
  L12_92 = L12_92(L13_93)
  L12_92 = L12_92 + 20
  L10_90(L11_91, L12_92)
  if L6_86 then
    L10_90 = TwGetStr
    L11_91 = 105290
    L10_90 = L10_90(L11_91)
  elseif not L10_90 then
    L10_90 = TwGetStr
    L11_91 = 105263
    L10_90 = L10_90(L11_91)
  end
  L11_91 = A0_80.ttfTip5
  L12_92 = L11_91
  L11_91 = L11_91.setString
  L13_93 = L10_90
  L11_91(L12_92, L13_93)
  L11_91 = A0_80.ttfTip5
  L12_92 = L11_91
  L11_91 = L11_91.setPositionY
  L13_93 = A0_80.ttfTip5
  L14_94 = L13_93
  L13_93 = L13_93.getPositionY
  L13_93 = L13_93(L14_94)
  L13_93 = L13_93 + 60
  L11_91(L12_92, L13_93)
  L11_91 = "<font SIZE='22' color='#ffffff' >%s</font>"
  L12_92 = nil
  L13_93 = A0_80.drawData
  L13_93 = L13_93.cardType
  if L13_93 then
    L13_93 = A0_80.drawData
    L13_93 = L13_93.cardType
    if "FRAGMENT" == L13_93 then
      L13_93 = Logic
      L14_94 = L13_93
      L13_93 = L13_93.Get
      L15_95 = "Compose"
      L13_93 = L13_93(L14_94, L15_95)
      L14_94 = L13_93
      L13_93 = L13_93.kdbItemConfig
      L15_95 = A2_82
      L13_93 = L13_93(L14_94, L15_95)
      L12_92 = L13_93
      L13_93 = L12_92.quality
      L12_92.rank = L13_93
    end
  else
    L13_93 = Logic
    L14_94 = L13_93
    L13_93 = L13_93.Get
    L15_95 = "Hero"
    L13_93 = L13_93(L14_94, L15_95)
    L14_94 = L13_93
    L13_93 = L13_93.GetHeroInfoByBaseId
    L15_95 = A2_82
    L13_93 = L13_93(L14_94, L15_95)
    L12_92 = L13_93
  end
  if L12_92 then
    L13_93 = string
    L13_93 = L13_93.format
    L14_94 = _UPVALUE0_
    L15_95 = _UPVALUE1_
    L16_96 = L12_92.rank
    L15_95 = L15_95[L16_96]
    L15_95 = L15_95 or "ffffff"
    L16_96 = L12_92.name
    L16_96 = L16_96 or ""
    L13_93 = L13_93(L14_94, L15_95, L16_96)
    L14_94 = string
    L14_94 = L14_94.format
    L15_95 = L11_91
    L16_96 = TwGetStr
    L16_96 = L16_96(105264, L13_93)
    L14_94 = L14_94(L15_95, L16_96, L16_96(105264, L13_93))
    L15_95 = A0_80.ttfText3
    L16_96 = L15_95
    L15_95 = L15_95.setString
    L15_95(L16_96, L14_94)
  end
  L13_93 = A0_80.ttfTip4
  L14_94 = L13_93
  L13_93 = L13_93.setFontSize
  L15_95 = 35
  L13_93(L14_94, L15_95)
  L13_93 = A0_80.ttfTip4
  L14_94 = L13_93
  L13_93 = L13_93.setColor
  L15_95 = ccc3
  L16_96 = 255
  L16_96 = L15_95(L16_96, 0, 0)
  L13_93(L14_94, L15_95, L16_96, L15_95(L16_96, 0, 0))
  L13_93 = A0_80.ttfTip4
  L14_94 = L13_93
  L13_93 = L13_93.setString
  L15_95 = TwGetStr
  L16_96 = 105265
  L16_96 = L15_95(L16_96, A3_83)
  L13_93(L14_94, L15_95, L16_96, L15_95(L16_96, A3_83))
  L13_93 = A0_80.ttfTip4
  L14_94 = L13_93
  L13_93 = L13_93.setPositionY
  L15_95 = A0_80.ttfTip4
  L16_96 = L15_95
  L15_95 = L15_95.getPositionY
  L15_95 = L15_95(L16_96)
  L15_95 = L15_95 + 5
  L13_93(L14_94, L15_95)
  L13_93 = "<font SIZE='22' color='#ff0000' >%s</font>"
  if A4_84 ~= A3_83 then
    L14_94 = string
    L14_94 = L14_94.format
    L15_95 = L13_93
    L16_96 = TwGetStr
    L16_96 = L16_96(105265, A4_84)
    L14_94 = L14_94(L15_95, L16_96, L16_96(105265, A4_84))
    L15_95 = string
    L15_95 = L15_95.format
    L16_96 = L11_91
    L15_95 = L15_95(L16_96, TwGetStr(105270, L14_94 or ""))
    L16_96 = A0_80.ttfText4
    L16_96 = L16_96.setString
    L16_96(L16_96, L15_95)
    L16_96 = A0_80.ttfText4
    L16_96 = L16_96.setPositionY
    L16_96(L16_96, A0_80.ttfText4:getPositionY() - 45)
  end
  L14_94 = Logic
  L15_95 = L14_94
  L14_94 = L14_94.Get
  L16_96 = "Mall"
  L14_94 = L14_94(L15_95, L16_96)
  L15_95 = L14_94
  L14_94 = L14_94.GetDrawProgressByKey
  L16_96 = A0_80.drawData
  L16_96 = L16_96.type
  L14_94 = L14_94(L15_95, L16_96)
  L15_95 = string
  L15_95 = L15_95.format
  L16_96 = L13_93
  L15_95 = L15_95(L16_96, L14_94)
  L16_96 = string
  L16_96 = L16_96.format
  L16_96 = L16_96(L11_91, TwGetStr(105271, L15_95))
  A0_80.ttfText5:setString(L16_96)
  A0_80.ttfText5:setPositionY(A0_80.ttfText5:getPositionY() - 30)
  if Logic:Get("Mall"):GetDrawProgressByKey(A0_80.drawData.type) == nil then
  end
  if 0 >= (0 or Logic:Get("Mall"):GetDrawProgressByKey(A0_80.drawData.type)) + 1 then
  end
  if (1 or (0 or Logic:Get("Mall"):GetDrawProgressByKey(A0_80.drawData.type)) + 1) > #(json.decode(A0_80.drawData.desInPage) or {}) then
  end
  if (json.decode(A0_80.drawData.desInPage) or {})[#(json.decode(A0_80.drawData.desInPage) or {}) or 1 or (0 or Logic:Get("Mall"):GetDrawProgressByKey(A0_80.drawData.type)) + 1] then
    A0_80.ttfLast:setString(ReplaceStringTab((json.decode(A0_80.drawData.desInPage) or {})[#(json.decode(A0_80.drawData.desInPage) or {}) or 1 or (0 or Logic:Get("Mall"):GetDrawProgressByKey(A0_80.drawData.type)) + 1]) or "")
  end
end
function prototype.InitColorBoxDesc(A0_97)
  local L1_98, L2_99
  L1_98 = CURRENCY_TYPE
  L1_98 = L1_98.STONE
  A0_97.drawType = L1_98
  L1_98 = Logic
  L2_99 = L1_98
  L1_98 = L1_98.Get
  L1_98 = L1_98(L2_99, "Lottery")
  L2_99 = L1_98
  L1_98 = L1_98.GetColorBoxCost
  L1_98 = L1_98(L2_99)
  L2_99 = Logic
  L2_99 = L2_99.Get
  L2_99 = L2_99(L2_99, "PlayerInfo")
  L2_99 = L2_99.GetPlayerStone
  L2_99 = L2_99(L2_99)
  if L1_98 == nil or L2_99 == nil then
    return
  end
  A0_97:ColorBoxDraw(L1_98, L2_99)
end
function prototype.ColorBoxDraw(A0_100, A1_101, A2_102)
  local L3_103, L4_104, L5_105, L6_106, L7_107, L8_108, L9_109, L10_110, L11_111, L12_112
  L3_103 = tostring
  L4_104 = A1_101
  L3_103 = L3_103(L4_104)
  L4_104 = tostring
  L5_105 = A2_102
  L4_104 = L4_104(L5_105)
  L5_105 = "0"
  if A1_101 > 0 then
    L6_106 = string
    L6_106 = L6_106.format
    L7_107 = "%d"
    L8_108 = A2_102 / A1_101
    L6_106 = L6_106(L7_107, L8_108)
    L5_105 = L6_106
  end
  L6_106 = A0_100.ttfTip1
  L7_107 = L6_106
  L6_106 = L6_106.setString
  L8_108 = TwGetStr
  L9_109 = 105211
  L10_110 = 2
  L12_112 = L8_108(L9_109, L10_110)
  L6_106(L7_107, L8_108, L9_109, L10_110, L11_111, L12_112, L8_108(L9_109, L10_110))
  L6_106 = TwGetStr
  L7_107 = 105227
  L6_106 = L6_106(L7_107)
  L7_107 = A0_100.ttfTip2
  L8_108 = L7_107
  L7_107 = L7_107.setString
  L9_109 = L6_106
  L7_107(L8_108, L9_109)
  L7_107 = "<font SIZE='22' color='#ce24f2' >%s</font>"
  L8_108 = "<font SIZE='22' color='#ffffff' >%s</font>"
  L9_109 = "<font SIZE='22' color='#00F979' >%s</font>"
  L10_110 = string
  L10_110 = L10_110.format
  L11_111 = L7_107
  L12_112 = TwGetStr
  L12_112 = L12_112(105255)
  L10_110 = L10_110(L11_111, L12_112, L12_112(105255))
  L11_111 = L10_110
  L12_112 = string
  L12_112 = L12_112.format
  L12_112 = L12_112(L8_108, "*" .. L3_103)
  L11_111 = L11_111 .. L12_112
  L12_112 = A0_100.ttfText2
  L12_112 = L12_112.setPositionY
  L12_112(L12_112, A0_100.ttfText2:getPositionY() - 40)
  L12_112 = A0_100.ttfText2
  L12_112 = L12_112.setString
  L12_112(L12_112, L11_111)
  L12_112 = string
  L12_112 = L12_112.format
  L12_112 = L12_112(L8_108, TwGetStr(105256))
  L6_106 = L12_112
  L12_112 = string
  L12_112 = L12_112.format
  L12_112 = L12_112(L8_108, ":")
  L11_111 = L6_106 .. L10_110 .. string.format(L8_108, ":") .. string.format(L9_109, L4_104)
  A0_100.ttfText4:setString(L11_111)
  L6_106 = TwGetStr(105257)
  L12_112 = TwGetStr(105225)
  A0_100:formatDesctrion(A0_100.ttfText5, L6_106, L5_105, L12_112)
end
function prototype.SendColorDraw(A0_113, A1_114)
  if not Logic:Get("Lottery"):checkStoneEnough(A1_114) then
    Prompt:Fail(TwGetStr(105583))
    return
  end
  A0_113:askDrawConfirm(A1_114)
end
function prototype.InitThreeDesc(A0_115)
  local L1_116
  L1_116 = CURRENCY_TYPE
  L1_116 = L1_116.GOLD
  A0_115.drawType = L1_116
  L1_116 = Logic
  L1_116 = L1_116.Get
  L1_116 = L1_116(L1_116, "Lottery")
  L1_116 = L1_116.GetThreeCost
  L1_116 = L1_116(L1_116)
  if L1_116 == nil then
    return
  end
  A0_115.btnDrawOnce:setVisible(false)
  A0_115.imgDrawOnce:setVisible(false)
  A0_115.btnDrawTen:setPositionX(320)
  A0_115.imgDrawTen:setPositionX(320)
  if CCSprite:create("images/Mall/fontTripleDraw.png") == nil then
    return
  end
  A0_115.imgDrawTen:setDisplayFrame(CCSprite:create("images/Mall/fontTripleDraw.png"):displayFrame())
  A0_115:threeDraw(L1_116)
end
function prototype.threeDraw(A0_117, A1_118)
  local L2_119, L3_120, L4_121
  L2_119 = tostring
  L3_120 = A1_118
  L2_119 = L2_119(L3_120)
  L3_120 = A0_117.ttfTip1
  L4_121 = L3_120
  L3_120 = L3_120.setString
  L3_120(L4_121, TwGetStr(105250))
  L3_120 = TwGetStr
  L4_121 = 105227
  L3_120 = L3_120(L4_121)
  L4_121 = TwGetStr
  L4_121 = L4_121(105228)
  A0_117:formatDesctrion(A0_117.ttfText2, L3_120, L2_119, L4_121)
  A0_117.ttfTip5:setString(TwGetStr(105251))
  A0_117.ttfTip4:setColor(ccc3(255, 0, 0))
  A0_117.ttfTip4:setString(TwGetStr(105252))
end
function prototype.SendThreeDraw(A0_122)
  if not Logic:Get("PlayerInfo"):IsWeekVip() and not Logic:Get("PlayerInfo"):IsOpenFunc() then
    Logic:Get("SureConfirm").btnText.ok = TwGetStr(105254)
    Prompt:Confirm(Logic:Get("Main"), "", 105253, Logic:Get("Main").GotoRecharge, Prompt.PROMPT_TYPE.SELECT)
    return
  end
  if Logic:Get("PlayerInfo"):GetPlayerAllJade() < Logic:Get("Lottery"):GetThreeCost() then
    Logic:Get("SureConfirm").btnText.ok = TwGetStr(104003)
    Prompt:Confirm(Logic:Get("Main"), "", 105316, Logic:Get("Main").GotoRecharge, Prompt.PROMPT_TYPE.SELECT)
    return
  end
  A0_122:askDrawConfirm(3)
end
function prototype.InitOrangeDesc(A0_123)
  local L1_124, L2_125
  L1_124 = CURRENCY_TYPE
  L1_124 = L1_124.GOLD
  A0_123.drawType = L1_124
  L1_124 = Logic
  L2_125 = L1_124
  L1_124 = L1_124.Get
  L1_124 = L1_124(L2_125, "Lottery")
  L2_125 = L1_124
  L1_124 = L1_124.GetCostTableByLotteryType
  L1_124 = L1_124(L2_125)
  L2_125 = L1_124[1]
  L2_125 = L2_125 or 0
  if L2_125 then
    A0_123:orangeDraw(L2_125)
  end
end
function prototype.orangeDraw(A0_126, A1_127)
  local L2_128, L3_129, L4_130, L5_131, L6_132, L7_133, L8_134, L9_135, L10_136, L11_137, L12_138
  L2_128 = tostring
  L3_129 = A1_127
  L2_128 = L2_128(L3_129)
  L3_129 = A0_126.ttfTip1
  L4_130 = L3_129
  L3_129 = L3_129.setString
  L5_131 = TwGetStr
  L6_132 = 105211
  L7_133 = 3
  L12_138 = L5_131(L6_132, L7_133)
  L3_129(L4_130, L5_131, L6_132, L7_133, L8_134, L9_135, L10_136, L11_137, L12_138, L5_131(L6_132, L7_133))
  L3_129 = TwGetStr
  L4_130 = 105227
  L3_129 = L3_129(L4_130)
  L4_130 = TwGetStr
  L5_131 = 105228
  L4_130 = L4_130(L5_131)
  L6_132 = A0_126
  L5_131 = A0_126.formatDesctrion
  L7_133 = A0_126.ttfText2
  L8_134 = L3_129
  L9_135 = L2_128
  L10_136 = L4_130
  L5_131(L6_132, L7_133, L8_134, L9_135, L10_136)
  L5_131 = A0_126.ttfTip4
  L6_132 = L5_131
  L5_131 = L5_131.setString
  L7_133 = TwGetStr
  L8_134 = 105212
  L12_138 = L7_133(L8_134)
  L5_131(L6_132, L7_133, L8_134, L9_135, L10_136, L11_137, L12_138, L7_133(L8_134))
  L5_131 = string
  L5_131 = L5_131.match
  L6_132 = A0_126.drawData
  L6_132 = L6_132.showTemplete
  L7_133 = "%d"
  L5_131 = L5_131(L6_132, L7_133)
  L6_132 = A0_126.ttfTip5
  L7_133 = L6_132
  L6_132 = L6_132.setString
  L8_134 = TwGetStr
  L9_135 = 105274
  L10_136 = L5_131 or 0
  L12_138 = L8_134(L9_135, L10_136)
  L6_132(L7_133, L8_134, L9_135, L10_136, L11_137, L12_138, L8_134(L9_135, L10_136))
  L6_132 = Logic
  L7_133 = L6_132
  L6_132 = L6_132.Get
  L8_134 = "Lottery"
  L6_132 = L6_132(L7_133, L8_134)
  L7_133 = L6_132
  L6_132 = L6_132.GetCostTableByLotteryType
  L6_132 = L6_132(L7_133)
  L7_133 = L6_132[2]
  L7_133 = L7_133 or 0
  L8_134 = TwGetStr
  L9_135 = 105215
  L8_134 = L8_134(L9_135)
  L9_135 = TwGetStr
  L10_136 = 105228
  L9_135 = L9_135(L10_136)
  L10_136 = "!"
  L9_135 = L9_135 .. L10_136
  L11_137 = A0_126
  L10_136 = A0_126.formatDesctrion
  L12_138 = A0_126.ttfText5
  L10_136(L11_137, L12_138, L8_134, tostring(L7_133), L9_135)
  L10_136 = A0_126.drawData
  L10_136 = L10_136.limits
  L10_136 = L10_136 or 0
  if L10_136 > 0 then
    L11_137 = Logic
    L12_138 = L11_137
    L11_137 = L11_137.Get
    L11_137 = L11_137(L12_138, "Mall")
    L12_138 = L11_137
    L11_137 = L11_137.GetDrawProgressByKey
    L11_137 = L11_137(L12_138, A0_126.drawData.type)
    L12_138 = string
    L12_138 = L12_138.format
    L12_138 = L12_138("%d/%d", L11_137, L10_136)
    A0_126.ttfTip6:setColor(ccc3(255, 0, 0))
    A0_126.ttfTip6:setPositionY(A0_126.ttfTip6:getPositionY() - 30)
    A0_126.ttfTip6:setString(TwGetStr(105258, L10_136) .. " " .. L12_138)
  end
  L11_137 = A0_126.drawData
  if L11_137 then
    L11_137 = A0_126.drawData
    L11_137 = L11_137.desInPage
    if L11_137 then
      L11_137 = A0_126.ttfLast
      L12_138 = L11_137
      L11_137 = L11_137.setString
      L11_137(L12_138, ReplaceStringTab(A0_126.drawData.desInPage) or "")
    end
  end
  L11_137 = A0_126.ttfTipTen
  L12_138 = L11_137
  L11_137 = L11_137.setString
  L11_137(L12_138, TwGetStr(105247, A1_127 * 10 - L7_133))
end
function prototype.InitStoneDesc(A0_139)
  local L1_140, L2_141
  L1_140 = CURRENCY_TYPE
  L1_140 = L1_140.GOLD
  A0_139.drawType = L1_140
  L1_140 = Logic
  L2_141 = L1_140
  L1_140 = L1_140.Get
  L1_140 = L1_140(L2_141, "Lottery")
  L2_141 = L1_140
  L1_140 = L1_140.GetCostTableByLotteryType
  L1_140 = L1_140(L2_141)
  L2_141 = L1_140[1]
  L2_141 = L2_141 or 0
  if L2_141 then
    A0_139.oneDrawCost = L2_141
    A0_139:stoneDraw(L2_141)
  end
  A0_139.bTenStatus = Logic:Get("Lock"):GetStatusByLockId(Logic.Lock.LOCK_ID.LOTTERY_TEN)
  if not Logic:Get("PlayerInfo"):IsOpenFunc() then
    A0_139:onLockBtnTen(A0_139.bTenStatus)
  end
end
function prototype.stoneDraw(A0_142, A1_143)
  local L2_144, L3_145, L4_146, L5_147, L6_148, L7_149, L8_150, L9_151, L10_152, L11_153, L12_154
  L2_144 = tostring
  L3_145 = A1_143
  L2_144 = L2_144(L3_145)
  L3_145 = A0_142.ttfTip1
  L4_146 = L3_145
  L3_145 = L3_145.setString
  L5_147 = TwGetStr
  L6_148 = 105211
  L7_149 = 3
  L12_154 = L5_147(L6_148, L7_149)
  L3_145(L4_146, L5_147, L6_148, L7_149, L8_150, L9_151, L10_152, L11_153, L12_154, L5_147(L6_148, L7_149))
  L3_145 = TwGetStr
  L4_146 = 105227
  L3_145 = L3_145(L4_146)
  L4_146 = TwGetStr
  L5_147 = 105228
  L4_146 = L4_146(L5_147)
  L6_148 = A0_142
  L5_147 = A0_142.formatDesctrion
  L7_149 = A0_142.ttfText2
  L8_150 = L3_145
  L9_151 = L2_144
  L10_152 = L4_146
  L5_147(L6_148, L7_149, L8_150, L9_151, L10_152)
  L5_147 = A0_142.ttfTip4
  L6_148 = L5_147
  L5_147 = L5_147.setString
  L7_149 = TwGetStr
  L8_150 = 105212
  L12_154 = L7_149(L8_150)
  L5_147(L6_148, L7_149, L8_150, L9_151, L10_152, L11_153, L12_154, L7_149(L8_150))
  L5_147 = string
  L5_147 = L5_147.match
  L6_148 = A0_142.drawData
  L6_148 = L6_148.showTemplete
  L7_149 = "%d"
  L5_147 = L5_147(L6_148, L7_149)
  L5_147 = L5_147 or 1
  L6_148 = A0_142.ttfTip5
  L7_149 = L6_148
  L6_148 = L6_148.setString
  L8_150 = TwGetStr
  L9_151 = 105248
  L10_152 = L5_147
  L12_154 = L8_150(L9_151, L10_152)
  L6_148(L7_149, L8_150, L9_151, L10_152, L11_153, L12_154, L8_150(L9_151, L10_152))
  L6_148 = Logic
  L7_149 = L6_148
  L6_148 = L6_148.Get
  L8_150 = "Lottery"
  L6_148 = L6_148(L7_149, L8_150)
  L7_149 = L6_148
  L6_148 = L6_148.GetCostTableByLotteryType
  L6_148 = L6_148(L7_149)
  L7_149 = L6_148[2]
  L7_149 = L7_149 or 0
  L8_150 = TwGetStr
  L9_151 = 105215
  L8_150 = L8_150(L9_151)
  L9_151 = TwGetStr
  L10_152 = 105228
  L9_151 = L9_151(L10_152)
  L10_152 = "!"
  L9_151 = L9_151 .. L10_152
  L11_153 = A0_142
  L10_152 = A0_142.formatDesctrion
  L12_154 = A0_142.ttfText5
  L10_152(L11_153, L12_154, L8_150, tostring(L7_149), L9_151)
  L10_152 = A0_142.drawData
  L10_152 = L10_152.limits
  L10_152 = L10_152 or 0
  if L10_152 > 0 then
    L11_153 = Logic
    L12_154 = L11_153
    L11_153 = L11_153.Get
    L11_153 = L11_153(L12_154, "Mall")
    L12_154 = L11_153
    L11_153 = L11_153.GetDrawProgressByKey
    L11_153 = L11_153(L12_154, A0_142.drawData.type)
    L12_154 = string
    L12_154 = L12_154.format
    L12_154 = L12_154("%d/%d", L11_153, L10_152)
    A0_142.ttfTip6:setColor(ccc3(255, 0, 0))
    A0_142.ttfTip6:setPositionY(A0_142.ttfTip6:getPositionY() - 30)
    A0_142.ttfTip6:setString(TwGetStr(105258, L10_152) .. " " .. L12_154)
  end
  L11_153 = A0_142.drawData
  if L11_153 then
    L11_153 = A0_142.drawData
    L11_153 = L11_153.desInPage
    if L11_153 then
      L11_153 = A0_142.ttfLast
      L12_154 = L11_153
      L11_153 = L11_153.setString
      L11_153(L12_154, ReplaceStringTab(A0_142.drawData.desInPage) or "")
    end
  end
  L11_153 = A0_142.ttfTipTen
  L12_154 = L11_153
  L11_153 = L11_153.setString
  L11_153(L12_154, TwGetStr(105247, A1_143 * 10 - L7_149))
end
function prototype.formatDesctrion(A0_155, A1_156, A2_157, A3_158, A4_159)
  local L5_160, L6_161, L7_162, L8_163, L9_164, L10_165
  L5_160 = "<font SIZE='22' color='#ffffff' >%s</font>"
  L6_161 = "<font SIZE='22' color='#00F979' >%s</font>"
  L7_162 = string
  L7_162 = L7_162.format
  L8_163 = L5_160
  L9_164 = A2_157 or ""
  L7_162 = L7_162(L8_163, L9_164)
  L8_163 = string
  L8_163 = L8_163.format
  L9_164 = L6_161
  L10_165 = A3_158 or ""
  L8_163 = L8_163(L9_164, L10_165)
  L9_164 = string
  L9_164 = L9_164.format
  L10_165 = L5_160
  L9_164 = L9_164(L10_165, A4_159 or "")
  L10_165 = L7_162
  L10_165 = L10_165 .. L8_163 .. L9_164
  if A1_156 then
    A1_156:setString(L10_165)
  end
end
function prototype.askDrawConfirm(A0_166, A1_167)
  A0_166.drawTimes = A1_167
  if A0_166.drawData and "VIP" == A0_166.drawData.showTemplete then
    A0_166:GoOnLottery()
    return
  end
  Prompt:Confirm(A0_166, "", "\231\161\174\229\174\154\230\138\189\229\141\161\229\144\151\239\188\159", A0_166.GoOnLottery, Prompt.PROMPT_TYPE.SELECT)
end
function prototype.GoOnLottery(A0_168)
  Logic:Get("Lottery"):SetDrawType(A0_168.drawType)
  Logic:Get("Lottery"):PostLottery(A0_168.drawTimes)
end
function prototype.onDrawSuccussed(A0_169)
  A0_169.layer:unregisterScriptTouchHandler()
  SceneHelper:removeScene("LotteryResult")
  SceneHelper:pushScene("LotteryResult", A0_169.rootNode)
end
function prototype.onDrawFailed(A0_170, A1_171)
  if A1_171 == -105 then
    if A0_170.drawType == CURRENCY_TYPE.FRIENDSHIP then
      Prompt:Fail(TwGetStr(105235))
    elseif A0_170.drawType == CURRENCY_TYPE.GOLD then
      Logic:Get("SureConfirm").btnText.ok = TwGetStr(104003)
      Prompt:Confirm(Logic:Get("Main"), "", 105316, Logic:Get("Main").GotoRecharge, Prompt.PROMPT_TYPE.SELECT)
    end
  elseif A1_171 == -8 then
    Prompt:Fail(TwGetStr(100022))
  else
    Prompt:Fail(tostring(A1_171))
  end
end
function prototype.onLockBtnTen(A0_172, A1_173)
  local L2_174, L3_175, L4_176, L5_177
  if A1_173 then
    L2_174(L3_175, L4_176)
    L2_174(L3_175, L4_176)
    L2_174(L3_175, L4_176)
    L2_174(L3_175, L4_176)
    for L5_177 = 4, L3_175 - 1 do
      if A0_172[string.format("ttfTip%d", L5_177)] then
        A0_172[string.format("ttfTip%d", L5_177)]:setString("")
      end
      if A0_172[string.format("ttfNum%d", L5_177)] then
        A0_172[string.format("ttfNum%d", L5_177)]:setString("")
      end
    end
    for L5_177 = 3, 5 do
      if A0_172[string.format("ttfText%d", L5_177)] then
        A0_172[string.format("ttfText%d", L5_177)]:setString("")
      end
    end
    L2_174(L3_175, L4_176)
    L2_174(L3_175, L4_176)
    L5_177 = L4_176
    L2_174(L3_175, L4_176)
    L5_177 = L4_176
    L2_174(L3_175, L4_176)
    L5_177 = L4_176
    L2_174(L3_175, L4_176)
  end
end
function prototype.straHeroMove(A0_178)
  local L1_179, L2_180, L3_181, L4_182, L5_183, L6_184, L7_185, L8_186, L9_187, L10_188, L11_189, L12_190
  L1_179 = 0
  L2_180 = 0
  L3_181 = A0_178.drawData
  L3_181 = L3_181.cardID
  if L3_181 == nil then
    return
  end
  L3_181 = json
  L3_181 = L3_181.decode
  L4_182 = A0_178.drawData
  L4_182 = L4_182.cardLevel
  L3_181 = L3_181(L4_182)
  L4_182 = L3_181
  for L8_186 = 1, #L3_181 do
    L10_188 = L4_182
    L11_189 = L3_181[L8_186]
    L9_187(L10_188, L11_189)
  end
  A0_178.baseIdDouble = L5_183
  for L9_187 = 1, #L5_183 do
    L10_188 = table
    L10_188 = L10_188.insert
    L11_189 = A0_178.baseIdDouble
    L12_190 = L5_183[L9_187]
    L10_188(L11_189, L12_190)
  end
  for L9_187 = 1, #L7_185 do
    L10_188 = string
    L10_188 = L10_188.format
    L11_189 = "subScene%d"
    L12_190 = L9_187
    L10_188 = L10_188(L11_189, L12_190)
    L11_189 = A0_178.drawData
    L11_189 = L11_189.showTemplete
    L11_189 = L11_189 == "EQUIP_LEIJIN"
    if L11_189 then
      L12_190 = "ArmorLotteryMove"
    else
      L12_190 = L12_190 or "LotteryMove"
    end
    A0_178[L10_188] = Tw.Controller:load(L12_190, A0_178.rootNode)
  end
  L10_188 = A0_178.baseIdDouble
  L10_188 = #L10_188
  L10_188 = 246 * L10_188
  L10_188 = L10_188 / 2
  L11_189 = 280
  L12_190 = L9_187(L10_188, L11_189)
  L7_185(L8_186, L9_187, L10_188, L11_189, L12_190, L9_187(L10_188, L11_189))
  for L10_188 = 1, #L8_186 do
    L11_189 = string
    L11_189 = L11_189.format
    L12_190 = "subScene%d"
    L11_189 = L11_189(L12_190, L10_188)
    L12_190 = A0_178[L11_189]
    if L12_190 then
      L12_190 = A0_178.drawData
      L12_190 = L12_190.showTemplete
      if L12_190 == "EQUIP_LEIJIN" then
        L12_190 = A0_178[L11_189]
        L12_190 = L12_190.setArmor
        L12_190(L12_190, A0_178.baseIdDouble[L10_188], L4_182[L10_188])
      else
        L12_190 = A0_178[L11_189]
        L12_190 = L12_190.setHero
        L12_190(L12_190, A0_178.baseIdDouble[L10_188], L4_182[L10_188])
      end
      L12_190 = A0_178[L11_189]
      L12_190 = L12_190.setPosition
      L12_190(L12_190, ccp(L1_179 + L10_188 * _UPVALUE0_, L2_180))
      L12_190 = L6_184.addChild
      L12_190(L6_184, A0_178[L11_189])
    end
  end
  L10_188 = 246
  L11_189 = 280
  L12_190 = L9_187(L10_188, L11_189)
  L10_188 = kCCScrollViewDirectionHorizontal
  L8_186(L9_187, L10_188)
  L10_188 = true
  L8_186(L9_187, L10_188)
  L10_188 = false
  L8_186(L9_187, L10_188)
  L10_188 = L6_184
  L8_186(L9_187, L10_188)
  L8_186(L9_187)
  A0_178.scrollTag = L8_186
  L10_188 = L7_185
  L8_186(L9_187, L10_188)
  L10_188 = true
  L8_186(L9_187, L10_188)
  L10_188 = bind
  L11_189 = A0_178.onTouch
  L12_190 = A0_178
  L10_188 = L10_188(L11_189, L12_190)
  L11_189 = false
  L12_190 = 300
  L8_186(L9_187, L10_188, L11_189, L12_190, true)
  L11_189 = L7_185
  L10_188 = L7_185.getContentOffset
  L10_188 = L10_188(L11_189)
  L10_188 = L10_188.x
  L11_189 = A0_178.baseIdDouble
  L11_189 = #L11_189
  L11_189 = L11_189 / 2
  L11_189 = L11_189 + 1
  L12_190 = _UPVALUE0_
  L11_189 = L11_189 * L12_190
  L10_188 = L10_188 - L11_189
  L8_186(L9_187, L10_188)
  L8_186(L9_187)
end
function prototype.moveItem(A0_191)
  local L1_192, L2_193, L3_194
  L1_192 = tolua
  L1_192 = L1_192.cast
  L2_193 = A0_191.lstCard
  L3_194 = L2_193
  L2_193 = L2_193.getChildByTag
  L2_193 = L2_193(L3_194, A0_191.scrollTag)
  L3_194 = "CCScrollViewEx"
  L1_192 = L1_192(L2_193, L3_194)
  if L1_192 == nil then
    return
  end
  L3_194 = L1_192
  L2_193 = L1_192.getContainer
  L2_193 = L2_193(L3_194)
  L3_194 = CCArray
  L3_194 = L3_194.create
  L3_194 = L3_194(L3_194)
  L3_194:addObject(CCCallFuncN:create(function()
    if _UPVALUE0_:getContentOffset().x <= -(#_UPVALUE1_.baseIdDouble - 1) * _UPVALUE2_ then
      _UPVALUE3_:setPositionX(-((#_UPVALUE1_.baseIdDouble / 2 - 1) * _UPVALUE2_))
    else
      _UPVALUE3_:setPositionX(_UPVALUE3_:getPositionX() - 0.5)
    end
  end))
  L2_193:runAction(CCRepeatForever:create(CCSequence:create(L3_194)))
end
function prototype.onTouch(A0_195, A1_196, A2_197)
  if A1_196 == CCTOUCHBEGAN and A0_195:isTouchInScoreView(A2_197) then
    A0_195:onTouchBegined(A2_197)
  elseif A1_196 == CCTOUCHENDED then
    A0_195:onTouchEnded(A2_197)
  end
end
function prototype.onTouchBegined(A0_198, A1_199)
  if tolua.cast(A0_198.lstCard:getChildByTag(A0_198.scrollTag), "CCScrollViewEx") == nil then
    return
  end
  if A0_198:isTouchInScoreView(A1_199) then
    A0_198.startPos = A1_199
    tolua.cast(A0_198.lstCard:getChildByTag(A0_198.scrollTag), "CCScrollViewEx"):getContainer():stopAllActions()
  end
end
function prototype.onTouchEnded(A0_200, A1_201)
  local L2_202, L3_203, L4_204, L5_205, L6_206, L7_207, L8_208, L9_209
  L3_203 = A0_200
  L2_202 = A0_200.isTouchInScoreView
  L4_204 = A0_200.startPos
  L2_202 = L2_202(L3_203, L4_204)
  if not L2_202 then
    return
  end
  L2_202 = Logic
  L3_203 = L2_202
  L2_202 = L2_202.Get
  L4_204 = "System"
  L2_202 = L2_202(L3_203, L4_204)
  L3_203 = L2_202
  L2_202 = L2_202.GetTime
  L2_202 = L2_202(L3_203)
  A0_200.timer = L2_202
  L2_202 = A0_200.eventTracer
  L3_203 = L2_202
  L2_202 = L2_202.Exist
  L4_204 = "runActionAgain"
  L2_202 = L2_202(L3_203, L4_204)
  if not L2_202 then
    L2_202 = Singleton
    L3_203 = Timer
    L2_202 = L2_202(L3_203)
    L3_203 = L2_202
    L2_202 = L2_202.Repeat
    L4_204 = 1000
    L6_206 = A0_200
    L5_205 = A0_200.Event
    L7_207 = "runActionAgain"
    L9_209 = L5_205(L6_206, L7_207)
    L2_202(L3_203, L4_204, L5_205, L6_206, L7_207, L8_208, L9_209, L5_205(L6_206, L7_207))
  end
  L2_202 = math
  L2_202 = L2_202.abs
  L3_203 = A0_200.startPos
  L3_203 = L3_203[1]
  L4_204 = A1_201[1]
  L3_203 = L3_203 - L4_204
  L2_202 = L2_202(L3_203)
  if L2_202 <= 20 then
    L2_202 = math
    L2_202 = L2_202.abs
    L3_203 = A0_200.startPos
    L3_203 = L3_203[2]
    L4_204 = A1_201[2]
    L3_203 = L3_203 - L4_204
    L2_202 = L2_202(L3_203)
    if L2_202 <= 20 then
      L3_203 = A0_200
      L2_202 = A0_200.isTouchInScoreView
      L4_204 = A1_201
      L2_202 = L2_202(L3_203, L4_204)
      if L2_202 then
        L3_203 = A0_200
        L2_202 = A0_200.clickHeroIcon
        L4_204 = A1_201
        L2_202(L3_203, L4_204)
        A0_200.startPos = nil
        return
      end
    end
  end
  L2_202 = tolua
  L2_202 = L2_202.cast
  L3_203 = A0_200.lstCard
  L4_204 = L3_203
  L3_203 = L3_203.getChildByTag
  L5_205 = A0_200.scrollTag
  L3_203 = L3_203(L4_204, L5_205)
  L4_204 = "CCScrollViewEx"
  L2_202 = L2_202(L3_203, L4_204)
  if L2_202 == nil then
    return
  end
  L4_204 = L2_202
  L3_203 = L2_202.getContainer
  L3_203 = L3_203(L4_204)
  L5_205 = L2_202
  L4_204 = L2_202.getContentOffset
  L4_204 = L4_204(L5_205)
  L4_204 = L4_204.x
  L5_205 = math
  L5_205 = L5_205.ceil
  L6_206 = _UPVALUE0_
  L6_206 = L4_204 / L6_206
  L5_205 = L5_205(L6_206)
  L6_206 = _UPVALUE0_
  L5_205 = L5_205 * L6_206
  L6_206 = 0
  L7_207 = nil
  L8_208 = A0_200.startPos
  L8_208 = L8_208[1]
  L9_209 = A1_201[1]
  if L8_208 > L9_209 then
    L8_208 = _UPVALUE0_
    L6_206 = L5_205 - L8_208
  else
    L8_208 = A0_200.startPos
    L8_208 = L8_208[1]
    L9_209 = A1_201[1]
    if L8_208 < L9_209 then
      L8_208 = _UPVALUE0_
      L6_206 = L5_205 + L8_208
      L8_208 = _UPVALUE0_
      L8_208 = -L8_208
      if L6_206 >= L8_208 then
        L8_208 = _UPVALUE0_
        L6_206 = -L8_208
      end
    end
  end
  L8_208 = CCMoveTo
  L9_209 = L8_208
  L8_208 = L8_208.create
  L8_208 = L8_208(L9_209, 0.5, ccp(L6_206, L2_202:getContentOffset().y))
  L7_207 = L8_208
  L8_208 = CCArray
  L9_209 = L8_208
  L8_208 = L8_208.create
  L8_208 = L8_208(L9_209)
  L9_209 = L8_208.addObject
  L9_209(L8_208, L7_207)
  L9_209 = _UPVALUE0_
  L9_209 = -L9_209
  if L6_206 >= L9_209 then
    function L9_209()
      _UPVALUE0_:setPositionX(-((#_UPVALUE1_.baseIdDouble / 2 + 1) * _UPVALUE2_))
    end
    L8_208:addObject(CCCallFuncN:create(L9_209))
  end
  L9_209 = A0_200.baseIdDouble
  L9_209 = #L9_209
  L9_209 = L9_209 - 1
  L9_209 = -L9_209
  L9_209 = L9_209 * _UPVALUE0_
  if L6_206 < L9_209 then
    function L9_209()
      _UPVALUE0_:setPositionX(-(#_UPVALUE1_.baseIdDouble / 2 * _UPVALUE2_))
    end
    L8_208:addObject(CCCallFuncN:create(L9_209))
  end
  if L8_208 then
    L9_209 = L3_203.runAction
    L9_209(L3_203, CCSequence:create(L8_208))
  end
  A0_200.startPos = nil
end
function prototype.runActionAgain(A0_210)
  local L1_211
  L1_211 = Logic
  L1_211 = L1_211.Get
  L1_211 = L1_211(L1_211, "System")
  L1_211 = L1_211.GetTime
  L1_211 = L1_211(L1_211)
  if Logic:Get("System"):DiffTime(L1_211, A0_210.timer) >= 2 then
    A0_210:EventTracer():Cancel("runActionAgain")
    A0_210:moveItem()
  end
end
function prototype.isTouchInScoreView(A0_212, A1_213)
  if A1_213 == nil or table.empty(A1_213) or A1_213[1] == nil or A1_213[2] == nil then
    return false
  end
  if A0_212.lstCard:getPositionX() <= A1_213[1] and A1_213[1] <= A0_212.lstCard:getPositionX() + A0_212.lstCard:getContentSize().width and A0_212.lstCard:getPositionY() <= A1_213[2] and A1_213[2] <= A0_212.lstCard:getPositionY() + A0_212.lstCard:getContentSize().height then
    return true
  end
  return false
end
function prototype.clickHeroIcon(A0_214, A1_215)
  local L2_216, L3_217, L4_218, L5_219, L6_220, L7_221
  if A1_215 ~= nil then
    L2_216 = table
    L2_216 = L2_216.empty
    L3_217 = A1_215
    L2_216 = L2_216(L3_217)
  elseif L2_216 then
    return
  end
  L2_216 = tolua
  L2_216 = L2_216.cast
  L3_217 = A0_214.lstCard
  L3_217 = L3_217.getChildByTag
  L3_217 = L3_217(L4_218, L5_219)
  L2_216 = L2_216(L3_217, L4_218)
  if L2_216 == nil then
    return
  end
  L3_217 = L2_216.getContainer
  L3_217 = L3_217(L4_218)
  for L7_221 = 1, #L5_219 do
    if A0_214[string.format("subScene%d", L7_221)] and L2_216:getContentOffset().x + A0_214[string.format("subScene%d", L7_221)]:getPositionX() <= A1_215[1] and A1_215[1] <= L2_216:getContentOffset().x + A0_214[string.format("subScene%d", L7_221)]:getPositionX() + A0_214[string.format("subScene%d", L7_221)]:getContentSize().width then
      A0_214[string.format("subScene%d", L7_221)]:onBtnHeroInfo()
      return
    end
  end
end
