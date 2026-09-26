module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
require("SceneHelper")
CURRENCY_TYPE = TypeDef("com.eyu.mt.module.currency.model.CurrencyType")
CURRENCY_CODE = Enum(CURRENCY_TYPE)
CURRENCY_TYPE_NAME = {}
CURRENCY_TYPE_NAME[CURRENCY_TYPE.COPPER] = "103008"
CURRENCY_TYPE_NAME[CURRENCY_TYPE.GOLD] = "103009"
CURRENCY_TYPE_NAME[CURRENCY_TYPE.GIFT] = "103010"
CURRENCY_TYPE_NAME[CURRENCY_TYPE.INTER] = "103011"
CURRENCY_TYPE_NAME[CURRENCY_TYPE.EXCHANGE] = "103012"
CURRENCY_TYPE_NAME[CURRENCY_TYPE.FRIENDSHIP] = "103013"
function prototype.onEnter(A0_0)
  local L1_1
end
function prototype.ReFrashReward(A0_2, A1_3, A2_4)
  local L3_5, L4_6, L5_7, L6_8, L7_9, L8_10
  L3_5 = A0_2.btnGain
  L4_6 = L3_5
  L3_5 = L3_5.setEnabled
  L5_7 = false
  L3_5(L4_6, L5_7)
  if A1_3 == nil then
    return
  end
  L3_5 = Logic
  L4_6 = L3_5
  L3_5 = L3_5.Get
  L5_7 = "HeroCardInfo"
  L3_5 = L3_5(L4_6, L5_7)
  L4_6 = L3_5
  L3_5 = L3_5.ClearShanCardSmall
  L5_7 = A0_2.goodsImg
  L3_5(L4_6, L5_7)
  A0_2.giftInfo = A1_3
  L3_5 = A1_3.progressCategory
  if L3_5 then
    L3_5 = Logic
    L4_6 = L3_5
    L3_5 = L3_5.Get
    L5_7 = "HeroCardInfo"
    L3_5 = L3_5(L4_6, L5_7)
    L4_6 = L3_5
    L3_5 = L3_5.ClearShanCardSmall
    L5_7 = A0_2.goodsImg
    L3_5(L4_6, L5_7)
    L4_6 = A0_2
    L3_5 = A0_2.createImg
    L5_7 = A1_3
    L3_5(L4_6, L5_7)
    L3_5 = A0_2.ttfGain
    L4_6 = L3_5
    L3_5 = L3_5.setStyle
    L5_7 = kCCLabelTTFStyleOutline
    L3_5(L4_6, L5_7)
    L3_5 = A0_2.ttfGiftInfo
    L4_6 = L3_5
    L3_5 = L3_5.setString
    L5_7 = A1_3.description
    L5_7 = L5_7.name
    L5_7 = L5_7 or ""
    L3_5(L4_6, L5_7)
    L3_5 = A0_2.ttfGain
    L4_6 = L3_5
    L3_5 = L3_5.setString
    L5_7 = A1_3.description
    L5_7 = L5_7.conditions
    L5_7 = L5_7 or ""
    L3_5(L4_6, L5_7)
    L3_5 = A0_2.ttfProgress
    L4_6 = L3_5
    L3_5 = L3_5.setStyle
    L5_7 = kCCLabelTTFStyleOutline
    L3_5(L4_6, L5_7)
    L3_5 = A0_2.ttfProgress
    L4_6 = L3_5
    L3_5 = L3_5.setString
    L5_7 = A1_3.description
    L5_7 = L5_7.info
    L5_7 = L5_7 or ""
    L3_5(L4_6, L5_7)
    L4_6 = A0_2
    L3_5 = A0_2.createProgress
    L5_7 = A1_3
    L3_5(L4_6, L5_7)
    L4_6 = A0_2
    L3_5 = A0_2.setBtnStage
    L5_7 = A1_3
    L3_5(L4_6, L5_7)
    return
  end
  L4_6 = A0_2
  L3_5 = A0_2.createImg
  L5_7 = A1_3
  L3_5(L4_6, L5_7)
  L3_5 = A0_2.ttfGain
  L4_6 = L3_5
  L3_5 = L3_5.setStyle
  L5_7 = kCCLabelTTFStyleOutline
  L3_5(L4_6, L5_7)
  L3_5 = A0_2.ttfGiftInfo
  L4_6 = L3_5
  L3_5 = L3_5.setString
  L5_7 = A1_3.description
  L5_7 = L5_7.name
  L5_7 = L5_7 or ""
  L3_5(L4_6, L5_7)
  L3_5 = A0_2.ttfGain
  L4_6 = L3_5
  L3_5 = L3_5.setString
  L5_7 = A1_3.description
  L5_7 = L5_7.conditions
  L5_7 = L5_7 or ""
  L3_5(L4_6, L5_7)
  L3_5 = Logic
  L4_6 = L3_5
  L3_5 = L3_5.Get
  L5_7 = "Gift"
  L3_5 = L3_5(L4_6, L5_7)
  L4_6 = L3_5
  L3_5 = L3_5.GetInfoStr
  L5_7 = A1_3.description
  L5_7 = L5_7.info
  L6_8 = A1_3.canDraw
  L7_9 = A1_3.id
  L3_5 = L3_5(L4_6, L5_7, L6_8, L7_9)
  L4_6 = A0_2.ttfProgress
  L5_7 = L4_6
  L4_6 = L4_6.setStyle
  L6_8 = kCCLabelTTFStyleOutline
  L4_6(L5_7, L6_8)
  L4_6 = A0_2.ttfProgress
  L5_7 = L4_6
  L4_6 = L4_6.setString
  L6_8 = L3_5
  L4_6(L5_7, L6_8)
  L5_7 = A0_2
  L4_6 = A0_2.createProgress
  L6_8 = A1_3
  L4_6(L5_7, L6_8)
  L5_7 = A0_2
  L4_6 = A0_2.setBtnStage
  L6_8 = A1_3
  L4_6(L5_7, L6_8)
  L4_6 = string
  L4_6 = L4_6.sub
  L5_7 = tostring
  L6_8 = A1_3.id
  L6_8 = L6_8 or ""
  L5_7 = L5_7(L6_8)
  L6_8 = 1
  L7_9 = 7
  L4_6 = L4_6(L5_7, L6_8, L7_9)
  if L4_6 == "charge_" then
    L4_6 = json
    L4_6 = L4_6.decode
    L5_7 = A1_3.reward
    L5_7 = L5_7 or {}
    L5_7 = L5_7.content
    L5_7 = L5_7 or "[]"
    L4_6 = L4_6(L5_7)
    L4_6 = L4_6 or {}
    L5_7 = L4_6[1]
    if L5_7 then
      L5_7 = L4_6[1]
      L5_7 = L5_7.amount
    else
      L5_7 = L5_7 or 0
    end
    L6_8 = A1_3.description
    if L6_8 then
      L6_8 = A1_3.description
      L6_8 = L6_8.info
    else
      L6_8 = L6_8 or "[]"
    end
    L7_9 = type
    L8_10 = L6_8
    L7_9 = L7_9(L8_10)
    if L7_9 == "string" then
      L7_9 = json
      L7_9 = L7_9.decode
      L8_10 = L6_8 or "[]"
      L7_9 = L7_9(L8_10)
      L6_8 = L7_9 or L7_9
    end
    L7_9 = L6_8[1]
    if L7_9 then
      L7_9 = L6_8[1]
      L7_9 = L7_9.amount
    else
      L7_9 = L7_9 or 0
    end
    L8_10 = L6_8[1]
    if L8_10 then
      L8_10 = L6_8[1]
      L8_10 = L8_10.current
    end
    if L8_10 == nil then
      L8_10 = A1_3.chargeAmount or 0
    end
    A0_2.ttfProgress:setString("\229\143\175\233\162\134\229\143\150\239\188\154" .. tostring(L5_7) .. "\233\146\187\231\159\179 " .. tostring(L8_10) .. "/" .. tostring(L7_9))
  else
    L4_6 = A1_3.leftDays
    if L4_6 then
      L4_6 = A1_3.leftDays
      if L4_6 > 0 then
        L4_6 = A0_2.ttfProgress
        L5_7 = L4_6
        L4_6 = L4_6.setString
        L6_8 = TwGetStr
        L7_9 = 110809
        L8_10 = A1_3.leftDays
        L8_10 = L6_8(L7_9, L8_10)
        L4_6(L5_7, L6_8, L7_9, L8_10, L6_8(L7_9, L8_10))
      end
    end
  end
end
function prototype.RefreshVipReward(A0_11, A1_12, A2_13)
  local L3_14
  L3_14 = A0_11.btnGain
  L3_14 = L3_14.setEnabled
  L3_14(L3_14, false)
  if A1_12 == nil then
    return
  end
  L3_14 = Logic
  L3_14 = L3_14.Get
  L3_14 = L3_14(L3_14, "HeroCardInfo")
  L3_14 = L3_14.ClearShanCardSmall
  L3_14(L3_14, A0_11.goodsImg)
  A0_11.giftInfo = A1_12
  L3_14 = A0_11.createImg
  L3_14(A0_11, A1_12)
  L3_14 = A0_11.ttfGain
  L3_14 = L3_14.setStyle
  L3_14(L3_14, kCCLabelTTFStyleOutline)
  L3_14 = Logic
  L3_14 = L3_14.Get
  L3_14 = L3_14(L3_14, "Gift")
  L3_14 = L3_14.GetInfoStr
  L3_14 = L3_14(L3_14, A1_12.description.info, A1_12.canDraw, A1_12.id)
  A0_11.ttfGiftInfo:setString(L3_14)
  A0_11.ttfGain:setString(A1_12.description.conditions or "")
  A0_11.ttfProgress:setStyle(kCCLabelTTFStyleOutline)
  A0_11.ttfProgress:setString(A1_12.description.name or "")
  A0_11:createProgress(A1_12)
  A0_11:setBtnStage(A1_12)
end
function prototype.createImg(A0_15, A1_16)
  local L2_17, L3_18, L4_19, L5_20
  L2_17 = Logic
  L3_18 = L2_17
  L2_17 = L2_17.Get
  L4_19 = "Gift"
  L2_17 = L2_17(L3_18, L4_19)
  L3_18 = L2_17
  L2_17 = L2_17.createImg
  L4_19 = A1_16.description
  L2_17 = L2_17(L3_18, L4_19)
  if L2_17 ~= nil then
    L3_18 = A0_15.sprHeroHead
    L4_19 = L3_18
    L3_18 = L3_18.setDisplayFrame
    L5_20 = L2_17.displayFrame
    L5_20 = L5_20(L2_17)
    L3_18(L4_19, L5_20, L5_20(L2_17))
    L3_18 = Logic
    L4_19 = L3_18
    L3_18 = L3_18.Get
    L5_20 = "Gift"
    L3_18 = L3_18(L4_19, L5_20)
    L4_19 = L3_18
    L3_18 = L3_18.createGoodsImg
    L5_20 = A1_16.description
    L5_20 = L3_18(L4_19, L5_20)
    if L3_18 ~= nil then
      A0_15.goodsImg:setDisplayFrame(L3_18:displayFrame())
      Logic:Get("HeroCardInfo"):AddShanCardSmall(A0_15.goodsImg, L4_19, nil, L5_20)
    end
    A0_15.sprCompose:setDisplayFrame(CCSprite:create("images/public/clarity80.png"):displayFrame())
    if L5_20 then
      A0_15.sprCompose:setDisplayFrame(Logic:Get("Compose"):GetJigsawImg():displayFrame())
    end
  end
end
function prototype.createProgress(A0_21, A1_22)
  A0_21.sprFinish:setDisplayFrame(Logic:Get("Gift"):createProgress(A1_22):displayFrame())
  A0_21.sprFinish:setAnchorPoint(CCPoint(0.5, 0.5))
end
function prototype.setBtnStage(A0_23, A1_24)
  local L2_25
  L2_25 = ""
  A0_23.btnGain:setEnabled(A1_24.canDraw)
  if A1_24.canDraw then
    L2_25 = "images/public/btn_com_nor.png"
  else
    L2_25 = "images/public/btn_com_dis.png"
  end
  A0_23.btnGain:setBackgroundSpriteForState(CCScale9Sprite:create(L2_25), CCControlStateDisabled)
end
function prototype.onBtnGain(A0_26)
  A0_26.btnInfo:setEnabled(true)
  Logic:Get("Guide"):done("DrawGift", "Draw")
  Logic:Get("Guide"):done("EvolutionPrepare", "Draw")
  Logic:Get("Guide"):done("FightDrawGiftLevelUp", "Draw")
  if A0_26.giftInfo.progressCategory then
    Logic:Get("Gift"):PostClaimProgress(A0_26.giftInfo.progressCategory, A0_26.giftInfo.progressThreshold)
    return
  end
  if A0_26:isActionPointGift() then
    return
  end
  if Logic:Get("Gift"):GetGiftInfoType() == "Gift" then
    if A0_26.giftInfo.userbool ~= nil then
      Logic:Get("Gift"):PoseDRAW_USER(A0_26.giftInfo.id)
    else
      Logic:Get("Gift"):PostDrawGlobal(A0_26.giftInfo.id)
    end
  else
    Logic:Get("Gift"):PoseDrawActivity(A0_26.giftInfo.id)
  end
end
function prototype.isActionPointGift(A0_27)
  local L1_28, L2_29, L3_30, L4_31, L5_32, L6_33
  L1_28 = require
  L1_28(L2_29)
  L1_28 = json
  L1_28 = L1_28.decode
  L1_28 = L1_28(L2_29)
  L3_30 = L1_28 or {}
  for L5_32, L6_33 in L2_29(L3_30) do
    L6_33.type = Logic.Reward.REWARDS_TYPE[L6_33.type]
    L6_33.code = tonumber(L6_33.code)
    if Logic:Get("Reward"):IsActionPoint(L6_33) and Logic:Get("PlayerInfo"):IsPhysicalPointFull() then
      Prompt:Fail(115153)
      return true
    end
  end
  return L2_29
end
function prototype.onBtnInfo(A0_34)
  local L1_35, L2_36, L3_37, L4_38, L5_39, L6_40
  L1_35 = A0_34.giftInfo
  L1_35 = L1_35.description
  L2_36 = L1_35.showType
  if L2_36 == "HERO" then
    L2_36 = Logic
    L3_37 = L2_36
    L2_36 = L2_36.Get
    L4_38 = "HeroCardInfo"
    L2_36 = L2_36(L3_37, L4_38)
    L3_37 = L2_36
    L2_36 = L2_36.kdbBaseHero
    L4_38 = L1_35.showId
    L2_36 = L2_36(L3_37, L4_38)
    if L2_36 ~= nil then
      L3_37 = L2_36.card
      if L3_37 == "HERO" then
        L3_37 = nil
        L4_38 = pcall
        function L5_39()
          _UPVALUE0_ = json.decode(_UPVALUE1_.giftInfo.reward.content)
        end
        L5_39 = L4_38(L5_39)
        if not L4_38 then
          return
        end
        L6_40 = {}
        L6_40.exp = 0
        L6_40.id = 68719480211
        L6_40.level = 1
        L6_40.baseId = L1_35.showId or 1
        L6_40.powerSkill = 0
        if L3_37[1] and L3_37[1].amount ~= nil then
          L6_40.level = L3_37[1].amount
        end
        Logic:Get("HeroCardInfo"):OpenHeroInfoByNparma(L6_40)
      else
        L3_37 = Logic
        L4_38 = L3_37
        L3_37 = L3_37.Get
        L5_39 = "HeroCardInfo"
        L3_37 = L3_37(L4_38, L5_39)
        L4_38 = L3_37
        L3_37 = L3_37.OpenHeroInfoById
        L5_39 = L1_35.showId
        L3_37(L4_38, L5_39)
      end
    end
  else
    L2_36 = L1_35.showType
    if L2_36 == "FRAGMENT" then
      L2_36 = Logic
      L3_37 = L2_36
      L2_36 = L2_36.Get
      L4_38 = "Compose"
      L2_36 = L2_36(L3_37, L4_38)
      L3_37 = L2_36
      L2_36 = L2_36.kdbItemConfig
      L4_38 = L1_35.showId
      L2_36 = L2_36(L3_37, L4_38)
      if L2_36 ~= nil then
        L3_37 = Logic
        L4_38 = L3_37
        L3_37 = L3_37.Get
        L5_39 = "HeroCardInfo"
        L3_37 = L3_37(L4_38, L5_39)
        L4_38 = L3_37
        L3_37 = L3_37.OpenHeroInfoById
        L5_39 = L2_36.baseId
        L6_40 = true
        L3_37(L4_38, L5_39, L6_40, L2_36.name)
      end
    end
  end
  L2_36 = L1_35.showType
  if L2_36 == "EQUIPMENT" then
    L2_36 = Logic
    L3_37 = L2_36
    L2_36 = L2_36.Get
    L4_38 = "Armor"
    L2_36 = L2_36(L3_37, L4_38)
    L3_37 = L2_36
    L2_36 = L2_36.openArmorDetails
    L4_38 = L1_35.showId
    L2_36(L3_37, L4_38)
    return
  end
  L2_36 = L1_35.showType
  if L2_36 == "EQUIPMENT_FRAGMENT" then
    L2_36 = Logic
    L3_37 = L2_36
    L2_36 = L2_36.Get
    L4_38 = "Armor"
    L2_36 = L2_36(L3_37, L4_38)
    L3_37 = L2_36
    L2_36 = L2_36.openArmorDetails
    L4_38 = L1_35.showId
    L5_39 = true
    L2_36(L3_37, L4_38, L5_39)
  end
end
function prototype.updateGuide(A0_41)
  local L1_42, L2_43, L3_44
  L1_42 = A0_41.giftInfo
  L2_43 = Logic
  L3_44 = L2_43
  L2_43 = L2_43.Get
  L2_43 = L2_43(L3_44, "Gift")
  L3_44 = Logic
  L3_44 = L3_44.Get
  L3_44 = L3_44(L3_44, "Guide")
  L3_44 = L3_44.isActive
  L3_44 = L3_44(L3_44, "DrawGift", "Draw")
  if L3_44 then
    L3_44 = Guide
    L3_44 = L3_44.DrawGift
    L3_44 = L3_44.MATERIAL
    if L1_42.canDraw and L2_43:Test(L1_42, "HERO", L3_44) then
      A0_41.btnInfo:setEnabled(false)
      Logic:Get("Gift"):setDrawing(true)
      Logic:Get("Guide"):lockTouch(A0_41.btnGain)
    end
  end
  L3_44 = Logic
  L3_44 = L3_44.Get
  L3_44 = L3_44(L3_44, "Guide")
  L3_44 = L3_44.isActive
  L3_44 = L3_44(L3_44, "EvolutionPrepare", "Draw")
  if L3_44 then
    L3_44 = Guide
    L3_44 = L3_44.EvolutionPrepare
    L3_44 = L3_44.MATERIAL
    if L1_42.canDraw and L2_43:Test(L1_42, "HERO", L3_44) then
      A0_41.btnInfo:setEnabled(false)
      Logic:Get("Gift"):setDrawing(true)
      Logic:Get("Guide"):lockTouch(A0_41.btnGain)
    end
  end
  L3_44 = Logic
  L3_44 = L3_44.Get
  L3_44 = L3_44(L3_44, "Guide")
  L3_44 = L3_44.isActive
  L3_44 = L3_44(L3_44, "FightDrawGiftLevelUp", "Draw")
  if L3_44 then
    L3_44 = Guide
    L3_44 = L3_44.FightDrawGiftLevelUp
    L3_44 = L3_44.MATERIAL
    if L1_42.canDraw and L2_43:Test(L1_42, "HERO", L3_44) then
      A0_41.btnInfo:setEnabled(false)
      Logic:Get("Gift"):setDrawing(true)
      Logic:Get("Guide"):lockTouch(A0_41.btnGain)
    end
  end
end
