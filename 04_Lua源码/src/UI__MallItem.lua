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
L0_0 = "images/public/clarity05.png"
function prototype.onEnter(A0_1)
  A0_1.ttfTitle:setStyle(kCCLabelTTFStyleOutline)
  A0_1.ttfTime:setStyle(kCCLabelTTFStyleOutline)
end
function prototype.Refrash(A0_2, A1_3)
  local L2_4, L3_5, L4_6, L5_7, L6_8, L7_9, L8_10, L9_11
  if A1_3 == nil then
    return
  end
  A0_2.tabInfo = A1_3
  L2_4 = A1_3.lotteryType
  if L2_4 == "ACTIVITY_EQUIP" then
    L2_4 = A0_2.eventTracer
    L3_5 = L2_4
    L2_4 = L2_4.Exist
    L4_6 = "OnMsgTimeChanged"
    L2_4 = L2_4(L3_5, L4_6)
    if not L2_4 then
      L2_4 = Logic
      L3_5 = L2_4
      L2_4 = L2_4.Get
      L4_6 = "Lottery"
      L2_4 = L2_4(L3_5, L4_6)
      L3_5 = L2_4
      L2_4 = L2_4.On
      L4_6 = Logic
      L4_6 = L4_6.Lottery
      L4_6 = L4_6.EVT
      L4_6 = L4_6.MSG_LOTTERY_TIME
      L6_8 = A0_2
      L5_7 = A0_2.Event
      L7_9 = "OnMsgTimeChanged"
      L9_11 = L5_7(L6_8, L7_9)
      L2_4(L3_5, L4_6, L5_7, L6_8, L7_9, L8_10, L9_11, L5_7(L6_8, L7_9))
    end
    L2_4 = A0_2.eventTracer
    L3_5 = L2_4
    L2_4 = L2_4.Exist
    L4_6 = "OnMsgTimeOK"
    L2_4 = L2_4(L3_5, L4_6)
    if not L2_4 then
      L2_4 = Logic
      L3_5 = L2_4
      L2_4 = L2_4.Get
      L4_6 = "Lottery"
      L2_4 = L2_4(L3_5, L4_6)
      L3_5 = L2_4
      L2_4 = L2_4.On
      L4_6 = Logic
      L4_6 = L4_6.Lottery
      L4_6 = L4_6.EVT
      L4_6 = L4_6.MSG_LOTTERY_OK
      L6_8 = A0_2
      L5_7 = A0_2.Event
      L7_9 = "OnMsgTimeOK"
      L9_11 = L5_7(L6_8, L7_9)
      L2_4(L3_5, L4_6, L5_7, L6_8, L7_9, L8_10, L9_11, L5_7(L6_8, L7_9))
    end
  end
  L2_4 = A0_2.ttfDecr
  L3_5 = L2_4
  L2_4 = L2_4.setString
  L4_6 = ""
  L2_4(L3_5, L4_6)
  L2_4 = A0_2.ttfTitle
  L3_5 = L2_4
  L2_4 = L2_4.setString
  L4_6 = ""
  L2_4(L3_5, L4_6)
  L2_4 = A0_2.ttfTime
  L3_5 = L2_4
  L2_4 = L2_4.setString
  L4_6 = ""
  L2_4(L3_5, L4_6)
  L2_4 = A0_2.ttfTitle
  L3_5 = L2_4
  L2_4 = L2_4.setString
  L4_6 = A1_3.title
  L2_4(L3_5, L4_6)
  L3_5 = A0_2
  L2_4 = A0_2.refreshLotteryTime
  L2_4(L3_5)
  L2_4 = A0_2.sprExtraCard
  if L2_4 then
    L2_4 = A0_2.sprExtraCard
    L3_5 = L2_4
    L2_4 = L2_4.removeFromParentAndCleanup
    L4_6 = true
    L2_4(L3_5, L4_6)
    A0_2.sprExtraCard = nil
  end
  L2_4, L3_5 = nil, nil
  L4_6 = CCScale9Sprite
  L5_7 = L4_6
  L4_6 = L4_6.create
  L6_8 = A1_3.path
  L6_8 = L6_8 or _UPVALUE0_
  L4_6 = L4_6(L5_7, L6_8)
  L2_4 = L4_6
  L4_6 = CCScale9Sprite
  L5_7 = L4_6
  L4_6 = L4_6.create
  L6_8 = A1_3.path
  L6_8 = L6_8 or _UPVALUE0_
  L4_6 = L4_6(L5_7, L6_8)
  L3_5 = L4_6
  if L2_4 and L3_5 then
    L4_6 = A0_2.btnMallItem
    L5_7 = L4_6
    L4_6 = L4_6.setBackgroundSpriteForState
    L6_8 = L2_4
    L7_9 = CCControlStateNormal
    L4_6(L5_7, L6_8, L7_9)
    L4_6 = A0_2.btnMallItem
    L5_7 = L4_6
    L4_6 = L4_6.setBackgroundSpriteForState
    L6_8 = L3_5
    L7_9 = CCControlStateHighlighted
    L4_6(L5_7, L6_8, L7_9)
  end
  L4_6 = nil
  L5_7 = Logic
  L6_8 = L5_7
  L5_7 = L5_7.Get
  L7_9 = "HeroCardInfo"
  L5_7 = L5_7(L6_8, L7_9)
  L6_8 = L5_7
  L5_7 = L5_7.ClearShanCard
  L7_9 = A0_2.sprSmallCard
  L5_7(L6_8, L7_9)
  L5_7 = A1_3.baseId
  if L5_7 ~= nil then
    L5_7 = A1_3.baseId
    if L5_7 > 0 then
      L5_7 = Logic
      L6_8 = L5_7
      L5_7 = L5_7.Get
      L7_9 = "HeroCardInfo"
      L5_7 = L5_7(L6_8, L7_9)
      L6_8 = L5_7
      L5_7 = L5_7.GetSprCard
      L7_9 = A1_3.baseId
      L5_7 = L5_7(L6_8, L7_9)
      L6_8 = Logic
      L7_9 = L6_8
      L6_8 = L6_8.Get
      L8_10 = "HeroCardInfo"
      L6_8 = L6_8(L7_9, L8_10)
      L7_9 = L6_8
      L6_8 = L6_8.GetCardTexture
      L8_10 = L5_7
      L6_8 = L6_8(L7_9, L8_10)
      if L6_8 then
        L7_9 = A0_2.sprSmallCard
        L8_10 = L7_9
        L7_9 = L7_9.setTexture
        L9_11 = L6_8
        L7_9(L8_10, L9_11)
        L7_9 = A0_2.sprSmallCard
        L8_10 = L7_9
        L7_9 = L7_9.setTextureRect
        L9_11 = L5_7.getTextureRect
        L9_11 = L9_11(L5_7)
        L7_9(L8_10, L9_11, L9_11(L5_7))
      end
      L7_9 = Logic
      L8_10 = L7_9
      L7_9 = L7_9.Get
      L9_11 = "HeroCardInfo"
      L7_9 = L7_9(L8_10, L9_11)
      L8_10 = L7_9
      L7_9 = L7_9.AddShanCard
      L9_11 = A0_2.sprSmallCard
      L7_9(L8_10, L9_11, A1_3.baseId)
      L7_9 = A0_2.sprSmallCard
      L8_10 = L7_9
      L7_9 = L7_9.setRotation
      L9_11 = 30
      L7_9(L8_10, L9_11)
      L7_9 = A0_2.sprSmallCard
      L8_10 = L7_9
      L7_9 = L7_9.setScale
      L9_11 = 0.4
      L7_9(L8_10, L9_11)
      L7_9 = A1_3.lotteryType
      if L7_9 == "LOTTERY_ORANGE" then
        L7_9 = json
        L7_9 = L7_9.decode
        L8_10 = A1_3.cardID
        L8_10 = L8_10 or "[]"
        L7_9 = L7_9(L8_10)
        L7_9 = L7_9 or {}
        L8_10 = L7_9[2]
        if L8_10 then
          L8_10 = Logic
          L9_11 = L8_10
          L8_10 = L8_10.Get
          L8_10 = L8_10(L9_11, "HeroCardInfo")
          L9_11 = L8_10
          L8_10 = L8_10.GetSprCard
          L8_10 = L8_10(L9_11, L7_9[2])
          L9_11 = Logic
          L9_11 = L9_11.Get
          L9_11 = L9_11(L9_11, "HeroCardInfo")
          L9_11 = L9_11.GetCardTexture
          L9_11 = L9_11(L9_11, L8_10)
          if L9_11 then
            A0_2.sprExtraCard = CCSprite:createWithTexture(L9_11)
            A0_2.sprExtraCard:setTextureRect(L8_10:getTextureRect())
            A0_2.sprExtraCard:setRotation(15)
            A0_2.sprExtraCard:setScale(0.4)
            A0_2.sprExtraCard:setPosition(ccp(A0_2.sprSmallCard:getPositionX() + 48, A0_2.sprSmallCard:getPositionY() - 8))
            A0_2.sprSmallCard:getParent():addChild(A0_2.sprExtraCard, 2)
          end
        end
      end
    end
  else
    L5_7 = CCSprite
    L6_8 = L5_7
    L5_7 = L5_7.create
    L7_9 = _UPVALUE1_
    L5_7 = L5_7(L6_8, L7_9)
    L4_6 = L5_7
    if L4_6 then
      L5_7 = A0_2.sprSmallCard
      L6_8 = L5_7
      L5_7 = L5_7.setDisplayFrame
      L8_10 = L4_6
      L7_9 = L4_6.displayFrame
      L9_11 = L7_9(L8_10)
      L5_7(L6_8, L7_9, L8_10, L9_11, L7_9(L8_10))
    end
  end
  L5_7 = A1_3.limits
  L5_7 = L5_7 or 0
  if L5_7 > 0 then
    L6_8 = string
    L6_8 = L6_8.format
    L7_9 = "data/Mall2/limit%d.png"
    L8_10 = L5_7
    L6_8 = L6_8(L7_9, L8_10)
    L7_9 = CCSprite
    L8_10 = L7_9
    L7_9 = L7_9.create
    L9_11 = L6_8
    L7_9 = L7_9(L8_10, L9_11)
    L4_6 = L7_9
    if L4_6 then
      L7_9 = A0_2.sprLimit
      L8_10 = L7_9
      L7_9 = L7_9.setDisplayFrame
      L9_11 = L4_6.displayFrame
      L9_11 = L9_11(L4_6)
      L7_9(L8_10, L9_11, L9_11(L4_6))
    end
  else
    L6_8 = CCSprite
    L7_9 = L6_8
    L6_8 = L6_8.create
    L8_10 = _UPVALUE1_
    L6_8 = L6_8(L7_9, L8_10)
    L4_6 = L6_8
    if L4_6 then
      L6_8 = A0_2.sprLimit
      L7_9 = L6_8
      L6_8 = L6_8.setDisplayFrame
      L9_11 = L4_6
      L8_10 = L4_6.displayFrame
      L9_11 = L8_10(L9_11)
      L6_8(L7_9, L8_10, L9_11, L8_10(L9_11))
    end
  end
  L6_8 = A0_2.ttfDecr
  L7_9 = L6_8
  L6_8 = L6_8.setStyle
  L8_10 = kCCLabelTTFStyleOutline
  L6_8(L7_9, L8_10)
  L6_8 = A0_2.ttfDecr
  L7_9 = L6_8
  L6_8 = L6_8.setColor
  L8_10 = ccc3
  L9_11 = 255
  L9_11 = L8_10(L9_11, 255, 255)
  L6_8(L7_9, L8_10, L9_11, L8_10(L9_11, 255, 255))
  L6_8 = A1_3.endTime
  if L6_8 then
    L6_8 = A1_3.endTime
    if L6_8 >= 4102444800000 then
      L6_8 = A0_2.ttfDecr
      L7_9 = L6_8
      L6_8 = L6_8.setColor
      L8_10 = ccc3
      L9_11 = 0
      L9_11 = L8_10(L9_11, 255, 0)
      L6_8(L7_9, L8_10, L9_11, L8_10(L9_11, 255, 0))
      L6_8 = A0_2.ttfDecr
      L7_9 = L6_8
      L6_8 = L6_8.setString
      L8_10 = "\230\176\184\228\185\133\230\156\137\230\149\136"
      L6_8(L7_9, L8_10)
      return
    end
  end
  L6_8 = A1_3.endTime
  if L6_8 then
    L6_8 = A1_3.endTime
    if L6_8 > 0 then
      L7_9 = A0_2
      L6_8 = A0_2.SetTimeStr
      L8_10 = ""
      L9_11 = A1_3.endTime
      L6_8(L7_9, L8_10, L9_11)
      return
    end
  end
  L6_8 = A1_3.description
  if nil ~= L6_8 then
    L6_8 = A1_3.description
    if "" ~= L6_8 then
      L6_8 = A1_3.description
      L6_8 = L6_8 or ""
      L7_9 = A0_2.ttfDecr
      L8_10 = L7_9
      L7_9 = L7_9.setString
      L9_11 = L6_8
      L7_9(L8_10, L9_11)
    end
  end
end
function prototype.refreshLotteryTime(A0_12)
  local L1_13
  L1_13 = A0_12.tabInfo
  L1_13 = L1_13.lotteryType
  if L1_13 == "ACTIVITY_EQUIP" then
    L1_13 = Logic
    L1_13 = L1_13.Get
    L1_13 = L1_13(L1_13, "Lottery")
    L1_13 = L1_13.GetArmorColdTime
    L1_13 = L1_13(L1_13, A0_12.tabInfo)
    if L1_13(L1_13, A0_12.tabInfo) then
      A0_12.ttfTime:setString(TwGetStr(110083))
    else
      A0_12.ttfTime:setString(TwGetStr(111147, L1_13))
    end
    Logic:Get("Lottery"):SetDrawData(A0_12.tabInfo)
    if not Logic:Get("Lottery"):IsLotteryTimeCold() then
      Logic:Get("Lottery"):DecLotteryTime()
    end
  end
end
function prototype.SetTimeStr(A0_14, A1_15, A2_16)
  local L3_17, L4_18, L5_19
  L3_17 = Logic
  L4_18 = L3_17
  L3_17 = L3_17.Get
  L5_19 = "System"
  L3_17 = L3_17(L4_18, L5_19)
  L4_18 = L3_17
  L3_17 = L3_17.DiffTime
  L5_19 = A2_16 / 1000
  L3_17 = L3_17(L4_18, L5_19)
  L4_18 = Logic
  L5_19 = L4_18
  L4_18 = L4_18.Get
  L4_18 = L4_18(L5_19, "System")
  L5_19 = L4_18
  L4_18 = L4_18.SecToDay
  L4_18 = L4_18(L5_19, L3_17)
  L5_19 = ""
  if L4_18.day > 0 then
    L5_19 = TwGetStr(105502, L4_18.day)
    if 0 < L4_18.hour then
      L5_19 = L5_19 .. TwGetStr(100045, L4_18.hour)
    end
    A1_15 = A1_15 .. TwGetStr(105279, L5_19)
    A0_14.ttfDecr:setString(A1_15)
    return
  end
  if 0 < L4_18.hour then
    L5_19 = TwGetStr(100045, L4_18.hour)
    A1_15 = A1_15 .. TwGetStr(105279, L5_19)
    A0_14.ttfDecr:setString(A1_15)
    return
  end
  if 0 < L4_18.min then
    L5_19 = L5_19 .. TwGetStr(100046, L4_18.min)
    A1_15 = A1_15 .. TwGetStr(105279, L5_19)
    A0_14.ttfDecr:setString(A1_15)
    return
  end
  A1_15 = A1_15 .. TwGetStr(105280)
  A0_14.ttfDecr:setString(A1_15)
end
function prototype.onBtnGetRewards(A0_20, A1_21, A2_22)
  local L3_23, L4_24, L5_25, L6_26, L7_27, L8_28, L9_29
  L3_23 = A0_20.tabInfo
  L3_23 = L3_23.kind
  L4_24 = Logic
  L4_24 = L4_24.Mall
  L4_24 = L4_24.ITEM_KIND
  L4_24 = L4_24.LOTTERY
  if L3_23 == L4_24 then
    L3_23 = A0_20.tabInfo
    L3_23 = L3_23.vip
    L4_24 = A0_20.tabInfo
    L4_24 = L4_24.week
    L5_25 = Logic
    L6_26 = L5_25
    L5_25 = L5_25.Get
    L7_27 = "PlayerInfo"
    L5_25 = L5_25(L6_26, L7_27)
    L6_26 = L5_25
    L5_25 = L5_25.hasMonthVipFunc
    L5_25 = L5_25(L6_26)
    L6_26 = Logic
    L7_27 = L6_26
    L6_26 = L6_26.Get
    L8_28 = "PlayerInfo"
    L6_26 = L6_26(L7_27, L8_28)
    L7_27 = L6_26
    L6_26 = L6_26.IsWeekVip
    L6_26 = L6_26(L7_27)
    if L3_23 and L4_24 then
      if not L5_25 and not L6_26 then
        L7_27 = Logic
        L8_28 = L7_27
        L7_27 = L7_27.Get
        L9_29 = "SureConfirm"
        L7_27 = L7_27(L8_28, L9_29)
        L7_27 = L7_27.btnText
        L8_28 = TwGetStr
        L9_29 = 105219
        L8_28 = L8_28(L9_29)
        L7_27.ok = L8_28
        L7_27 = Prompt
        L8_28 = L7_27
        L7_27 = L7_27.Confirm
        L9_29 = Logic
        L9_29 = L9_29.Get
        L9_29 = L9_29(L9_29, "Main")
        L7_27(L8_28, L9_29, "", 105278, Logic:Get("Main").GotoRecharge, Prompt.PROMPT_TYPE.SELECT)
        return
      end
    else
      if L3_23 and not L5_25 then
        L7_27 = Logic
        L8_28 = L7_27
        L7_27 = L7_27.Get
        L9_29 = "SureConfirm"
        L7_27 = L7_27(L8_28, L9_29)
        L7_27 = L7_27.btnText
        L8_28 = TwGetStr
        L9_29 = 105219
        L8_28 = L8_28(L9_29)
        L7_27.ok = L8_28
        L7_27 = Prompt
        L8_28 = L7_27
        L7_27 = L7_27.Confirm
        L9_29 = Logic
        L9_29 = L9_29.Get
        L9_29 = L9_29(L9_29, "Main")
        L7_27(L8_28, L9_29, "", 105276, Logic:Get("Main").GotoRecharge, Prompt.PROMPT_TYPE.SELECT)
        return
      end
      if L4_24 and not L6_26 then
        L7_27 = Logic
        L8_28 = L7_27
        L7_27 = L7_27.Get
        L9_29 = "SureConfirm"
        L7_27 = L7_27(L8_28, L9_29)
        L7_27 = L7_27.btnText
        L8_28 = TwGetStr
        L9_29 = 105219
        L8_28 = L8_28(L9_29)
        L7_27.ok = L8_28
        L7_27 = Prompt
        L8_28 = L7_27
        L7_27 = L7_27.Confirm
        L9_29 = Logic
        L9_29 = L9_29.Get
        L9_29 = L9_29(L9_29, "Main")
        L7_27(L8_28, L9_29, "", 105275, Logic:Get("Main").GotoRecharge, Prompt.PROMPT_TYPE.SELECT)
        return
      end
    end
    L7_27 = A0_20.tabInfo
    L7_27 = L7_27.type
    L8_28 = Logic
    L8_28 = L8_28.Mall
    L8_28 = L8_28.ITEM_TYPE
    L8_28 = L8_28.LOTTERY_XIAN
    if L7_27 == L8_28 then
      L7_27 = Logic
      L8_28 = L7_27
      L7_27 = L7_27.Get
      L9_29 = "Guide"
      L7_27 = L7_27(L8_28, L9_29)
      L8_28 = L7_27
      L7_27 = L7_27.done
      L9_29 = "Lottery"
      L7_27(L8_28, L9_29, "SelectItem")
    end
    L7_27 = A0_20.tabInfo
    L7_27 = L7_27.lotteryType
    if L7_27 == "ACTIVITY_EQUIP" then
      L7_27 = Logic
      L8_28 = L7_27
      L7_27 = L7_27.Get
      L9_29 = "Guide"
      L7_27 = L7_27(L8_28, L9_29)
      L8_28 = L7_27
      L7_27 = L7_27.done
      L9_29 = "EquipLottery"
      L7_27(L8_28, L9_29, "SelectItem")
    end
    L7_27 = Logic
    L8_28 = L7_27
    L7_27 = L7_27.Get
    L9_29 = "Lottery"
    L7_27 = L7_27(L8_28, L9_29)
    L8_28 = L7_27
    L7_27 = L7_27.SetDrawData
    L9_29 = A0_20.tabInfo
    L7_27(L8_28, L9_29)
    L7_27 = A0_20.tabInfo
    L7_27 = L7_27.lotteryType
    L8_28 = Logic
    L8_28 = L8_28.Mall
    L8_28 = L8_28.ITEM_KIND
    L8_28 = L8_28.ACTIVITY_EQUIP
    if L7_27 == L8_28 then
      L7_27 = SceneHelper
      L8_28 = L7_27
      L7_27 = L7_27.runWithScene
      L9_29 = "LotteryArmor"
      L7_27(L8_28, L9_29, A0_20.rootNode)
      return
    end
    L7_27 = Logic
    L8_28 = L7_27
    L7_27 = L7_27.Get
    L9_29 = "Mall"
    L7_27 = L7_27(L8_28, L9_29)
    L8_28 = L7_27
    L7_27 = L7_27.IsFriendDraw
    L9_29 = A0_20.tabInfo
    L9_29 = L9_29.type
    L7_27 = L7_27(L8_28, L9_29)
    if L7_27 then
      L7_27 = SceneHelper
      L8_28 = L7_27
      L7_27 = L7_27.runWithScene
      L9_29 = "Lottery"
      L7_27(L8_28, L9_29, A0_20.rootNode)
    else
      L7_27 = SceneHelper
      L8_28 = L7_27
      L7_27 = L7_27.runWithScene
      L9_29 = "LotteryGold"
      L7_27(L8_28, L9_29, A0_20.rootNode)
    end
    return
  end
  L3_23 = A0_20.tabInfo
  L3_23 = L3_23.kind
  L4_24 = Logic
  L4_24 = L4_24.Mall
  L4_24 = L4_24.ITEM_KIND
  L4_24 = L4_24.BUY_POINTS
  if L3_23 == L4_24 then
    L3_23 = Logic
    L4_24 = L3_23
    L3_23 = L3_23.Get
    L5_25 = "Mall"
    L3_23 = L3_23(L4_24, L5_25)
    L4_24 = L3_23
    L3_23 = L3_23.SetFromMall
    L5_25 = true
    L3_23(L4_24, L5_25)
    L3_23 = Logic
    L4_24 = L3_23
    L3_23 = L3_23.Get
    L5_25 = "Mall"
    L3_23 = L3_23(L4_24, L5_25)
    L4_24 = L3_23
    L3_23 = L3_23.BuyPoints
    L3_23(L4_24)
    return
  end
  L3_23 = A0_20.tabInfo
  L3_23 = L3_23.kind
  L4_24 = Logic
  L4_24 = L4_24.Mall
  L4_24 = L4_24.ITEM_KIND
  L4_24 = L4_24.BUY_BAG
  if L3_23 == L4_24 then
    L3_23 = Logic
    L4_24 = L3_23
    L3_23 = L3_23.Get
    L5_25 = "Mall"
    L3_23 = L3_23(L4_24, L5_25)
    L4_24 = L3_23
    L3_23 = L3_23.BuyBag
    L3_23(L4_24)
    return
  end
  L3_23 = A0_20.tabInfo
  L3_23 = L3_23.kind
  L4_24 = Logic
  L4_24 = L4_24.Mall
  L4_24 = L4_24.ITEM_KIND
  L4_24 = L4_24.BUY_FRIEND
  if L3_23 == L4_24 then
    L3_23 = Logic
    L4_24 = L3_23
    L3_23 = L3_23.Get
    L5_25 = "Mall"
    L3_23 = L3_23(L4_24, L5_25)
    L4_24 = L3_23
    L3_23 = L3_23.buyFriendLimit
    L3_23(L4_24)
    return
  end
  L3_23 = A0_20.tabInfo
  L3_23 = L3_23.kind
  L4_24 = Logic
  L4_24 = L4_24.Mall
  L4_24 = L4_24.ITEM_KIND
  L4_24 = L4_24.BUY_SOUL
  if L3_23 == L4_24 then
    L3_23 = Logic
    L4_24 = L3_23
    L3_23 = L3_23.Get
    L5_25 = "Mall"
    L3_23 = L3_23(L4_24, L5_25)
    L4_24 = L3_23
    L3_23 = L3_23.SetSoulStoneData
    L5_25 = A0_20.tabInfo
    L3_23(L4_24, L5_25)
    L3_23 = SceneHelper
    L4_24 = L3_23
    L3_23 = L3_23.pushPrompt
    L5_25 = "ArtifactBuy"
    L6_26 = A0_20.rootNode
    L3_23(L4_24, L5_25, L6_26)
    return
  end
  L3_23 = A0_20.tabInfo
  L3_23 = L3_23.kind
  L4_24 = Logic
  L4_24 = L4_24.Mall
  L4_24 = L4_24.ITEM_KIND
  L4_24 = L4_24.TOKEN_COIN
  if L3_23 == L4_24 then
    L3_23 = Logic
    L4_24 = L3_23
    L3_23 = L3_23.Get
    L5_25 = "Mall"
    L3_23 = L3_23(L4_24, L5_25)
    L4_24 = L3_23
    L3_23 = L3_23.SetTokenCoinData
    L5_25 = A0_20.tabInfo
    L3_23(L4_24, L5_25)
    L3_23 = Logic
    L4_24 = L3_23
    L3_23 = L3_23.Get
    L5_25 = "Mall"
    L3_23 = L3_23(L4_24, L5_25)
    L4_24 = L3_23
    L3_23 = L3_23.setIsFrom
    L5_25 = "Mall"
    L3_23(L4_24, L5_25)
    L3_23 = SceneHelper
    L4_24 = L3_23
    L3_23 = L3_23.pushScene
    L5_25 = "MallExchange"
    L6_26 = A0_20.rootNode
    L3_23(L4_24, L5_25, L6_26)
    return
  end
  L3_23 = A0_20.tabInfo
  L3_23 = L3_23.kind
  L4_24 = Logic
  L4_24 = L4_24.Mall
  L4_24 = L4_24.ITEM_KIND
  L4_24 = L4_24.OPEN_BETA_GOODS
  if L3_23 == L4_24 then
    L3_23 = Logic
    L4_24 = L3_23
    L3_23 = L3_23.Get
    L5_25 = "Mall"
    L3_23 = L3_23(L4_24, L5_25)
    L4_24 = L3_23
    L3_23 = L3_23.SetOpenBetaData
    L5_25 = A0_20.tabInfo
    L3_23(L4_24, L5_25)
    L3_23 = SceneHelper
    L4_24 = L3_23
    L3_23 = L3_23.runWithScene
    L5_25 = "MallPackage"
    L6_26 = A0_20.rootNode
    L3_23(L4_24, L5_25, L6_26)
    return
  end
  L3_23 = A0_20.tabInfo
  L3_23 = L3_23.kind
  L4_24 = Logic
  L4_24 = L4_24.Mall
  L4_24 = L4_24.ITEM_KIND
  L4_24 = L4_24.BUY_TALISMAN_PACK
  if L3_23 == L4_24 then
    L3_23 = Logic
    L4_24 = L3_23
    L3_23 = L3_23.Get
    L5_25 = "Talisman"
    L3_23 = L3_23(L4_24, L5_25)
    L4_24 = L3_23
    L3_23 = L3_23.GetBuyPackCost
    L3_23 = L3_23(L4_24)
    L4_24 = KFDBGetRecord
    L5_25 = "ConfigValue"
    L6_26 = "TALISMAN:BUY_PACK_CAPACITY_VALUE"
    L4_24 = L4_24(L5_25, L6_26)
    L5_25 = tonumber
    L6_26 = L4_24.content
    L5_25 = L5_25(L6_26)
    L6_26 = KFDBGetRecord
    L7_27 = "ConfigValue"
    L8_28 = "TALISMAN:BUY_PACK_CAPACITY_BY_COUPON_COST"
    L6_26 = L6_26(L7_27, L8_28)
    L6_26 = L6_26 or {}
    L7_27 = tonumber
    L8_28 = L6_26.content
    L8_28 = L8_28 or 0
    L7_27 = L7_27(L8_28)
    L9_29 = A0_20
    L8_28 = A0_20.getCoupon
    L8_28(L9_29)
    L8_28 = TwGetStr
    L9_29 = 105284
    L8_28 = L8_28(L9_29, L5_25, L3_23)
    L9_29 = L8_28
    L8_28 = L9_29 .. [[

 
]] .. TwGetStr(105286, A0_20.coupon or 0, L7_27)
    L9_29 = Prompt
    L9_29 = L9_29.Confirm
    L9_29(L9_29, A0_20, A0_20.tabInfo.title, L8_28, A0_20.sendBuyTalismanPack, Prompt.PROMPT_TYPE.SELECT)
    return
  end
  L3_23 = A0_20.tabInfo
  L3_23 = L3_23.kind
  L4_24 = Logic
  L4_24 = L4_24.Mall
  L4_24 = L4_24.ITEM_KIND
  L4_24 = L4_24.BUY_EQUIP_PACK
  if L3_23 == L4_24 then
    L3_23 = Logic
    L4_24 = L3_23
    L3_23 = L3_23.Get
    L5_25 = "Armor"
    L3_23 = L3_23(L4_24, L5_25)
    L4_24 = L3_23
    L3_23 = L3_23.getBuyPackCost
    L3_23 = L3_23(L4_24)
    L4_24 = KFDBGetRecord
    L5_25 = "ConfigValue"
    L6_26 = "EQUIP:PACK_EXTEND_SPACE"
    L4_24 = L4_24(L5_25, L6_26)
    L5_25 = tonumber
    L6_26 = L4_24.content
    L5_25 = L5_25(L6_26)
    L7_27 = A0_20
    L6_26 = A0_20.getCoupon
    L6_26(L7_27)
    L6_26 = KFDBGetRecord
    L7_27 = "ConfigValue"
    L8_28 = "EQUIP:BUY_PACK_CAPACITY_BY_COUPON_COST"
    L6_26 = L6_26(L7_27, L8_28)
    L6_26 = L6_26 or {}
    L7_27 = tonumber
    L8_28 = L6_26.content
    L8_28 = L8_28 or 0
    L7_27 = L7_27(L8_28)
    L8_28 = TwGetStr
    L9_29 = 111406
    L8_28 = L8_28(L9_29, L5_25, L3_23)
    L9_29 = L8_28
    L8_28 = L9_29 .. [[

 
]] .. TwGetStr(105286, A0_20.coupon or 0, L7_27)
    L9_29 = Prompt
    L9_29 = L9_29.Confirm
    L9_29(L9_29, A0_20, A0_20.tabInfo.title, L8_28, A0_20.sendBugEquipPack, Prompt.PROMPT_TYPE.SELECT)
    return
  end
  L3_23 = A0_20.tabInfo
  L3_23 = L3_23.kind
  L4_24 = Logic
  L4_24 = L4_24.Mall
  L4_24 = L4_24.ITEM_KIND
  L4_24 = L4_24.CHEAP_BUY
  if L3_23 == L4_24 then
    L3_23 = Logic
    L4_24 = L3_23
    L3_23 = L3_23.Get
    L5_25 = "Mall"
    L3_23 = L3_23(L4_24, L5_25)
    L4_24 = L3_23
    L3_23 = L3_23.setCheapBuyInfo
    L5_25 = A0_20.tabInfo
    L3_23(L4_24, L5_25)
    L3_23 = SceneHelper
    L4_24 = L3_23
    L3_23 = L3_23.runWithScene
    L5_25 = "MallNewPackage"
    L6_26 = A0_20.rootNode
    L3_23(L4_24, L5_25, L6_26)
    return
  end
  L3_23 = A0_20.tabInfo
  L3_23 = L3_23.kind
  L4_24 = Logic
  L4_24 = L4_24.Mall
  L4_24 = L4_24.ITEM_KIND
  L4_24 = L4_24.SUPER_GIFT
  if L3_23 == L4_24 then
    L3_23 = Logic
    L4_24 = L3_23
    L3_23 = L3_23.Get
    L5_25 = "Mall"
    L3_23 = L3_23(L4_24, L5_25)
    L4_24 = L3_23
    L3_23 = L3_23.setSuperGoodInfo
    L5_25 = A0_20.tabInfo
    L3_23(L4_24, L5_25)
    L3_23 = SceneHelper
    L4_24 = L3_23
    L3_23 = L3_23.runWithScene
    L5_25 = "MallSuperGift"
    L6_26 = A0_20.rootNode
    L3_23(L4_24, L5_25, L6_26)
    return
  end
  L3_23 = A0_20.tabInfo
  L3_23 = L3_23.kind
  L4_24 = Logic
  L4_24 = L4_24.Mall
  L4_24 = L4_24.ITEM_KIND
  L4_24 = L4_24.EQUIP_GIFT
  if L3_23 == L4_24 then
    L3_23 = Logic
    L4_24 = L3_23
    L3_23 = L3_23.Get
    L5_25 = "EquipGift"
    L3_23 = L3_23(L4_24, L5_25)
    L4_24 = L3_23
    L3_23 = L3_23.setFromMallFlag
    L5_25 = true
    L3_23(L4_24, L5_25)
    L3_23 = Logic
    L4_24 = L3_23
    L3_23 = L3_23.Get
    L5_25 = "EquipGift"
    L3_23 = L3_23(L4_24, L5_25)
    L4_24 = L3_23
    L3_23 = L3_23.setActivityInfo
    L5_25 = tostring
    L6_26 = A0_20.tabInfo
    L6_26 = L6_26.id
    L5_25 = L5_25(L6_26)
    L6_26 = A0_20.tabInfo
    L6_26 = L6_26.title
    L7_27 = A0_20.tabInfo
    L7_27 = L7_27.endTime
    L3_23(L4_24, L5_25, L6_26, L7_27)
    L3_23 = SceneHelper
    L4_24 = L3_23
    L3_23 = L3_23.pushScene
    L5_25 = "ArmorGift"
    L6_26 = A0_20.rootNode
    L3_23(L4_24, L5_25, L6_26)
    return
  end
  L3_23 = A0_20.tabInfo
  L3_23 = L3_23.kind
  L4_24 = Logic
  L4_24 = L4_24.Mall
  L4_24 = L4_24.ITEM_KIND
  L4_24 = L4_24.EQUIP_MATERIAL
  if L3_23 == L4_24 then
    L3_23 = Logic
    L4_24 = L3_23
    L3_23 = L3_23.Get
    L5_25 = "EquipGift"
    L3_23 = L3_23(L4_24, L5_25)
    L4_24 = L3_23
    L3_23 = L3_23.setFromMallFlag
    L5_25 = true
    L3_23(L4_24, L5_25)
    L3_23 = Logic
    L4_24 = L3_23
    L3_23 = L3_23.Get
    L5_25 = "EquipGift"
    L3_23 = L3_23(L4_24, L5_25)
    L4_24 = L3_23
    L3_23 = L3_23.setActivityInfo
    L5_25 = tostring
    L6_26 = A0_20.tabInfo
    L6_26 = L6_26.id
    L5_25 = L5_25(L6_26)
    L6_26 = A0_20.tabInfo
    L6_26 = L6_26.title
    L7_27 = A0_20.tabInfo
    L7_27 = L7_27.endTime
    L3_23(L4_24, L5_25, L6_26, L7_27)
    L3_23 = SceneHelper
    L4_24 = L3_23
    L3_23 = L3_23.pushScene
    L5_25 = "ArmorMaterialGift"
    L6_26 = A0_20.rootNode
    L3_23(L4_24, L5_25, L6_26)
    return
  end
  L3_23 = A0_20.tabInfo
  L3_23 = L3_23.kind
  L4_24 = Logic
  L4_24 = L4_24.Mall
  L4_24 = L4_24.ITEM_KIND
  L4_24 = L4_24.PRECIOUSROOM
  if L3_23 == L4_24 then
    L3_23 = Logic
    L4_24 = L3_23
    L3_23 = L3_23.Get
    L5_25 = "Preciousroom"
    L3_23 = L3_23(L4_24, L5_25)
    L4_24 = L3_23
    L3_23 = L3_23.SetMallData
    L5_25 = A0_20.tabInfo
    L3_23(L4_24, L5_25)
    L3_23 = SceneHelper
    L4_24 = L3_23
    L3_23 = L3_23.runWithScene
    L5_25 = "MallRaceShop"
    L6_26 = A0_20.rootNode
    L3_23(L4_24, L5_25, L6_26)
    return
  end
end
function prototype.updateGuide(A0_30)
  Logic:Get("Guide"):lockTouch("Lottery", "SelectItem", A0_30.btnMallItem)
  Logic:Get("Guide"):lockTouch("EquipLottery", "SelectItem", A0_30.btnMallItem)
end
function prototype.getCoupon(A0_31)
  A0_31.coupon = Logic:Get("PlayerInfo"):GetPlayerMoney()[string.lower("COUPON")] or 0
end
function prototype.sendBuyTalismanPack(A0_32)
  local L1_33, L2_34, L3_35, L4_36
  L1_33 = Logic
  L2_34 = L1_33
  L1_33 = L1_33.Get
  L3_35 = "Talisman"
  L1_33 = L1_33(L2_34, L3_35)
  L2_34 = L1_33
  L1_33 = L1_33.GetBuyPackTimes
  L1_33 = L1_33(L2_34)
  L2_34 = KFDBGetRecord
  L3_35 = "ConfigValue"
  L4_36 = "TALISMAN:MAX_BUY_PACK_CAPACITY_TIMES"
  L2_34 = L2_34(L3_35, L4_36)
  L3_35 = tonumber
  L4_36 = L2_34.content
  L3_35 = L3_35(L4_36)
  if L1_33 >= L3_35 then
    L4_36 = Prompt
    L4_36 = L4_36.Fail
    L4_36(L4_36, 10078)
    return
  end
  L4_36 = KFDBGetRecord
  L4_36 = L4_36("ConfigValue", "TALISMAN:BUY_PACK_CAPACITY_BY_COUPON_COST")
  L4_36 = L4_36 or {}
  if not table.empty(L4_36) and tonumber(L4_36.content or 0) <= A0_32.coupon then
    Logic:Get("Talisman"):PostBuyPackByCoupon()
    return
  end
  if Logic:Get("PlayerInfo"):GetPlayerAllJade() < Logic:Get("Talisman"):GetBuyPackCost() then
    Logic:Get("SureConfirm").btnText.ok = TwGetStr(105219)
    Prompt:Confirm(Logic:Get("Main"), "", 105316, Logic:Get("Main").GotoRecharge, Prompt.PROMPT_TYPE.SELECT)
    return
  end
  Logic:Get("Talisman"):PostBuyPack()
end
function prototype.sendBugEquipPack(A0_37)
  local L1_38, L2_39, L3_40, L4_41
  L1_38 = Logic
  L2_39 = L1_38
  L1_38 = L1_38.Get
  L3_40 = "Armor"
  L1_38 = L1_38(L2_39, L3_40)
  L2_39 = L1_38
  L1_38 = L1_38.getBuyPackTimes
  L1_38 = L1_38(L2_39)
  L2_39 = KFDBGetRecord
  L3_40 = "ConfigValue"
  L4_41 = "EQUIP:PACK_EXTEND_COUNT_LIMIT"
  L2_39 = L2_39(L3_40, L4_41)
  L3_40 = tonumber
  L4_41 = L2_39.content
  L3_40 = L3_40(L4_41)
  if L1_38 >= L3_40 then
    L4_41 = Prompt
    L4_41 = L4_41.Fail
    L4_41(L4_41, 10078)
    return
  end
  L4_41 = KFDBGetRecord
  L4_41 = L4_41("ConfigValue", "EQUIP:BUY_PACK_CAPACITY_BY_COUPON_COST")
  L4_41 = L4_41 or {}
  if not table.empty(L4_41) and tonumber(L4_41.content or 0) <= A0_37.coupon then
    Logic:Get("Armor"):PostBuyEquipPackSpaceByCounpon()
    return
  end
  if Logic:Get("PlayerInfo"):GetPlayerAllJade() < Logic:Get("Armor"):getBuyPackCost() then
    Logic:Get("Main"):PromptCharge()
    return
  end
  Logic:Get("Armor"):PostBuyEquipPack()
end
function prototype.OnMsgTimeChanged(A0_42, A1_43)
  if A0_42.tabInfo.lotteryType == "ACTIVITY_EQUIP" then
    A0_42.ttfTime:setString(TwGetStr(111147, A1_43))
  else
    A0_42.ttfTime:setString("")
  end
end
function prototype.OnMsgTimeOK(A0_44)
  if A0_44.tabInfo.lotteryType == "ACTIVITY_EQUIP" then
    A0_44.ttfTime:setString(TwGetStr(110083))
  else
    A0_44.ttfTime:setString("")
  end
end
