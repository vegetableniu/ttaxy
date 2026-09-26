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
function prototype.ReFrashReward(A0_2, A1_3)
  local L2_4, L3_5, L4_6, L5_7, L6_8, L7_9, L8_10
  if A1_3 == nil then
    return
  end
  L2_4 = Logic
  L3_5 = L2_4
  L2_4 = L2_4.Get
  L4_6 = "Compose"
  L2_4 = L2_4(L3_5, L4_6)
  L3_5 = L2_4
  L2_4 = L2_4.kdbItemConfig
  L4_6 = A1_3.baseId
  L2_4 = L2_4(L3_5, L4_6)
  L3_5 = A0_2.ttfProgress
  L4_6 = L3_5
  L3_5 = L3_5.setStyle
  L5_7 = kCCLabelTTFStyleOutline
  L3_5(L4_6, L5_7)
  L3_5 = A0_2.ttfGiftInfo
  L4_6 = L3_5
  L3_5 = L3_5.setStyle
  L5_7 = kCCLabelTTFStyleOutline
  L3_5(L4_6, L5_7)
  A0_2.giftInfo = A1_3
  L4_6 = A0_2
  L3_5 = A0_2.createImg
  L5_7 = A1_3
  L6_8 = L2_4
  L3_5(L4_6, L5_7, L6_8)
  L3_5 = A0_2.ttfGiftInfo
  L4_6 = L3_5
  L3_5 = L3_5.setString
  L5_7 = L2_4.name
  L3_5(L4_6, L5_7)
  L3_5 = Logic
  L4_6 = L3_5
  L3_5 = L3_5.Get
  L5_7 = "Compose"
  L3_5 = L3_5(L4_6, L5_7)
  L4_6 = L3_5
  L3_5 = L3_5.kdbComposeConfig
  L5_7 = A1_3.baseId
  L3_5 = L3_5(L4_6, L5_7)
  if L3_5 == nil then
    L4_6 = log4misc
    L5_7 = L4_6
    L4_6 = L4_6.warn
    L6_8 = "Compose:"
    L7_9 = A1_3.baseId
    L6_8 = L6_8 .. L7_9
    L4_6(L5_7, L6_8)
    return
  end
  L4_6 = A1_3.amount
  L4_6 = L4_6 or 0
  A1_3.amount = L4_6
  L4_6 = TwGetStr
  L5_7 = 103092
  L6_8 = A1_3.amount
  L4_6 = L4_6(L5_7, L6_8)
  L5_7 = A0_2.ttfGain
  L6_8 = L5_7
  L5_7 = L5_7.setStyle
  L7_9 = kCCLabelTTFStyleOutline
  L5_7(L6_8, L7_9)
  L5_7 = A0_2.ttfGain
  L6_8 = L5_7
  L5_7 = L5_7.setString
  L7_9 = L4_6
  L5_7(L6_8, L7_9)
  L5_7 = L2_4.sellPrice
  L6_8 = A1_3.amount
  L5_7 = L5_7 * L6_8
  L6_8 = Logic
  L7_9 = L6_8
  L6_8 = L6_8.Get
  L8_10 = "Compose"
  L6_8 = L6_8(L7_9, L8_10)
  L7_9 = L6_8
  L6_8 = L6_8.IsStaminaSaleFragment
  L8_10 = A1_3.baseId
  L8_10 = L8_10 or L2_4.baseId
  L6_8 = L6_8(L7_9, L8_10)
  L7_9 = Logic
  L8_10 = L7_9
  L7_9 = L7_9.Get
  L7_9 = L7_9(L8_10, "Compose")
  L8_10 = L7_9
  L7_9 = L7_9.ApplySaleMoneyIcon
  L7_9(L8_10, A0_2.imgMoney, L6_8)
  L7_9 = A0_2.ttfProgress
  L8_10 = L7_9
  L7_9 = L7_9.setString
  L7_9(L8_10, L5_7)
  L7_9 = Logic
  L8_10 = L7_9
  L7_9 = L7_9.Get
  L7_9 = L7_9(L8_10, "Compose")
  L8_10 = L7_9
  L7_9 = L7_9.GetSaleComposeList
  L7_9 = L7_9(L8_10)
  L8_10 = "images/public/selcet1.png"
  if L7_9[A1_3.id] then
    L8_10 = "images/public/selcet2.png"
    A0_2.bSelect = true
  else
    L8_10 = "images/public/selcet1.png"
    A0_2.bSelect = false
  end
  if CCSprite:create(L8_10) then
    A0_2.sprSelect:setDisplayFrame(CCSprite:create(L8_10):displayFrame())
  end
end
function prototype.createImg(A0_11, A1_12, A2_13)
  A0_11.sprHeroHead:setDisplayFrame(Logic:Get("Compose"):GetItemsFrame(tonumber(A2_13.quality)):displayFrame())
  if Logic:Get("Compose"):GetFraImg(A1_12.baseId) ~= nil then
    A0_11.goodsImg:setDisplayFrame(Logic:Get("Compose"):GetFraImg(A1_12.baseId):displayFrame())
  end
  if Logic:Get("Compose"):GetJigsawImg() ~= nil then
    A0_11.sprCompose:setDisplayFrame(Logic:Get("Compose"):GetJigsawImg():displayFrame())
  end
end
function prototype.createProgress(A0_14, A1_15)
  A0_14.sprFinish:setDisplayFrame(Logic:Get("Compose"):createProgress(A1_15):displayFrame())
  A0_14.sprFinish:setAnchorPoint(CCPoint(0.5, 0.5))
end
function prototype.setBtnStage(A0_16, A1_17)
end
function prototype.onBtnGain(A0_18)
  A0_18:onMeunItem()
end
function prototype.GainGoods(A0_19)
  local L1_20
end
function prototype.onBtnInfo(A0_21)
  if Logic:Get("Compose"):kdbItemConfig(A0_21.giftInfo.baseId) ~= nil or Logic:Get("Compose"):kdbItemConfig(A0_21.giftInfo.baseId).baseId ~= 0 then
    Logic:Get("HeroCardInfo"):OpenHeroInfoById(Logic:Get("Compose"):kdbItemConfig(A0_21.giftInfo.baseId).baseId, true, Logic:Get("Compose"):kdbItemConfig(A0_21.giftInfo.baseId).name)
  end
end
function prototype.onMeunItem(A0_22)
  if Logic:Get("Compose"):GetSaleComposeList()[A0_22.giftInfo.id] then
    if A0_22.bSelect then
      A0_22.sprSelect:setDisplayFrame(CCSprite:create("images/public/selcet1.png"):displayFrame())
      A0_22.bSelect = false
    end
    Logic:Get("Compose"):SetSaleComposeList(A0_22.giftInfo.id, nil)
  else
    if not A0_22.bSelect then
      A0_22.sprSelect:setDisplayFrame(CCSprite:create("images/public/selcet2.png"):displayFrame())
      A0_22.bSelect = true
    end
    Logic:Get("Compose"):SetSaleComposeList(A0_22.giftInfo.id, A0_22.giftInfo.amount)
  end
  Logic:Get("Compose"):FireEnvenConfig()
end
