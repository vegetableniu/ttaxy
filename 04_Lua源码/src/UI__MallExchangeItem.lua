module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
function prototype.initialize(A0_0, ...)
  local L2_2, L3_3, L4_4
  L2_2 = super
  L2_2 = L2_2.initialize
  L3_3 = A0_0
  L4_4 = ...
  L2_2(L3_3, L4_4)
  L2_2 = {}
  A0_0.data = L2_2
end
function prototype.dispose(A0_5, ...)
  super.dispose(A0_5)
end
function prototype.onEnter(A0_7)
  A0_7.staName:setStyle(kCCLabelTTFStyleOutline)
  A0_7.staTip:setStyle(kCCLabelTTFStyleOutline)
  A0_7.ttfLimit:setStyle(kCCLabelTTFStyleOutline)
  A0_7.ttfNeed:setStyle(kCCLabelTTFStyleOutline)
  A0_7.ttfBuyLimit:setStyle(kCCLabelTTFStyleOutline)
end
function prototype.onNodeLoaded(A0_8, A1_9, A2_10)
end
function prototype.RefreshExchangeInfo(A0_11, A1_12)
  local L2_13, L3_14, L4_15, L5_16
  if A1_12 ~= nil then
    L2_13 = table
    L2_13 = L2_13.empty
    L3_14 = A1_12
    L2_13 = L2_13(L3_14)
  elseif L2_13 then
    return
  end
  A0_11.data = A1_12
  L2_13 = A0_11.btnExchange
  L3_14 = L2_13
  L2_13 = L2_13.setVisible
  L4_15 = true
  L2_13(L3_14, L4_15)
  L3_14 = A0_11
  L2_13 = A0_11.createImg
  L4_15 = A1_12
  L2_13(L3_14, L4_15)
  L2_13 = A0_11.staName
  L3_14 = L2_13
  L2_13 = L2_13.setString
  L4_15 = A1_12.name
  L2_13(L3_14, L4_15)
  L2_13 = A0_11.ttfLimit
  L3_14 = L2_13
  L2_13 = L2_13.setString
  L4_15 = ""
  L2_13(L3_14, L4_15)
  L2_13 = A0_11.sprExchange
  L3_14 = L2_13
  L2_13 = L2_13.setVisible
  L4_15 = true
  L2_13(L3_14, L4_15)
  L2_13 = Logic
  L3_14 = L2_13
  L2_13 = L2_13.Get
  L4_15 = "Mall"
  L2_13 = L2_13(L3_14, L4_15)
  L3_14 = L2_13
  L2_13 = L2_13.GetTokenCoinData
  L2_13 = L2_13(L3_14)
  L3_14 = Logic
  L4_15 = L3_14
  L3_14 = L3_14.Get
  L5_16 = "Mall"
  L3_14 = L3_14(L4_15, L5_16)
  L4_15 = L3_14
  L3_14 = L3_14.GetTokenCoinName
  L5_16 = L2_13.type
  L3_14 = L3_14(L4_15, L5_16)
  A0_11.currencyName = L3_14
  L3_14 = A0_11.ttfNeed
  L4_15 = L3_14
  L3_14 = L3_14.setString
  L5_16 = TwGetStr
  L5_16 = L5_16(105923, A0_11.currencyName or "")
  L3_14(L4_15, L5_16, L5_16(105923, A0_11.currencyName or ""))
  L3_14 = Logic
  L4_15 = L3_14
  L3_14 = L3_14.Get
  L5_16 = "Mall"
  L3_14 = L3_14(L4_15, L5_16)
  L4_15 = L3_14
  L3_14 = L3_14.GetTokenCoinPath
  L5_16 = L2_13.type
  L3_14 = L3_14(L4_15, L5_16)
  A0_11.iconPath = L3_14
  L3_14 = A0_11.ttfNeed
  L4_15 = L3_14
  L3_14 = L3_14.getPositionX
  L3_14 = L3_14(L4_15)
  L4_15 = A0_11.ttfNeed
  L5_16 = L4_15
  L4_15 = L4_15.getContentSize
  L4_15 = L4_15(L5_16)
  L4_15 = L4_15.width
  L3_14 = L3_14 + L4_15
  L4_15 = A0_11.staTip
  L5_16 = L4_15
  L4_15 = L4_15.setString
  L4_15(L5_16, A1_12.costTokenCoin)
  L4_15 = A0_11.staTip
  L5_16 = L4_15
  L4_15 = L4_15.setPositionX
  L4_15(L5_16, L3_14)
  L4_15 = A0_11.ttfBuyLimit
  L5_16 = L4_15
  L4_15 = L4_15.setString
  L4_15(L5_16, "")
  L4_15 = A1_12.id
  if L4_15 == 814 then
    L4_15 = A0_11.ttfBuyLimit
    L5_16 = L4_15
    L4_15 = L4_15.setString
    L4_15(L5_16, "\229\185\180\229\141\161\231\137\185\230\157\131")
  else
    L4_15 = A1_12.limit
    if L4_15 > 0 then
      L4_15 = Logic
      L5_16 = L4_15
      L4_15 = L4_15.Get
      L4_15 = L4_15(L5_16, "PlayerInfo")
      L5_16 = L4_15
      L4_15 = L4_15.getExchangeTime
      L4_15 = L4_15(L5_16, A1_12.id)
      L5_16 = TwGetStr
      L5_16 = L5_16(105929, A1_12.limit - L4_15)
      A0_11.ttfBuyLimit:setString(L5_16)
    end
  end
end
function prototype.createImg(A0_17, A1_18)
  local L2_19, L3_20, L4_21, L5_22
  L2_19 = Logic
  L3_20 = L2_19
  L2_19 = L2_19.Get
  L4_21 = "Gift"
  L2_19 = L2_19(L3_20, L4_21)
  L3_20 = L2_19
  L2_19 = L2_19.createImg
  L4_21 = A1_18
  L2_19 = L2_19(L3_20, L4_21)
  L3_20 = A1_18.showType
  if L3_20 ~= "VIP_TIME" then
    L3_20 = A1_18.showType
  elseif L3_20 == "RENAME" then
    L3_20 = Logic
    L4_21 = L3_20
    L3_20 = L3_20.Get
    L5_22 = "Compose"
    L3_20 = L3_20(L4_21, L5_22)
    L4_21 = L3_20
    L3_20 = L3_20.GetItemsFrame
    L5_22 = 5
    L3_20 = L3_20(L4_21, L5_22)
    L2_19 = L3_20
  end
  if L2_19 ~= nil then
    L3_20 = A0_17.iconBg
    L4_21 = L3_20
    L3_20 = L3_20.setDisplayFrame
    L5_22 = L2_19.displayFrame
    L5_22 = L5_22(L2_19)
    L3_20(L4_21, L5_22, L5_22(L2_19))
    L3_20 = Logic
    L4_21 = L3_20
    L3_20 = L3_20.Get
    L5_22 = "Gift"
    L3_20 = L3_20(L4_21, L5_22)
    L4_21 = L3_20
    L3_20 = L3_20.createGoodsImg
    L5_22 = A1_18
    L3_20 = L3_20(L4_21, L5_22)
    if L3_20 ~= nil then
      L4_21 = Logic
      L5_22 = L4_21
      L4_21 = L4_21.Get
      L4_21 = L4_21(L5_22, "HeroCardInfo")
      L5_22 = L4_21
      L4_21 = L4_21.GetCardTexture
      L5_22 = L4_21(L5_22, L3_20)
      A0_17.iconImage:setTexture(L4_21)
      A0_17.iconImage:setTextureRect(L5_22)
    end
  end
  L3_20 = Logic
  L4_21 = L3_20
  L3_20 = L3_20.Get
  L5_22 = "HeroCardInfo"
  L3_20 = L3_20(L4_21, L5_22)
  L4_21 = L3_20
  L3_20 = L3_20.AddShanCardSmall
  L5_22 = A0_17.iconBg
  L3_20(L4_21, L5_22, A0_17.data.showId)
end
function prototype.onBtnImage(A0_23, A1_24, A2_25)
  if A0_23.data.showType == "HERO" then
    Logic:Get("HeroCardInfo"):OpenHeroInfoById(A0_23.data.showId)
  elseif A0_23.data.showType == "FRAGMENT" and Logic:Get("Compose"):kdbItemConfig(A0_23.data.showId) ~= nil then
    Logic:Get("HeroCardInfo"):OpenHeroInfoById(Logic:Get("Compose"):kdbItemConfig(A0_23.data.showId).baseId)
  end
end
function prototype.onBtnExchange(A0_26, A1_27, A2_28)
  local L3_29, L4_30, L5_31
  L3_29 = Logic
  L4_30 = L3_29
  L3_29 = L3_29.Get
  L5_31 = "Mall"
  L3_29 = L3_29(L4_30, L5_31)
  L4_30 = L3_29
  L3_29 = L3_29.GetTokenCoinData
  L3_29 = L3_29(L4_30)
  L4_30 = Logic
  L5_31 = L4_30
  L4_30 = L4_30.Get
  L4_30 = L4_30(L5_31, "Mall")
  L5_31 = L4_30
  L4_30 = L4_30.IsOverTimeByData
  L4_30 = L4_30(L5_31, L3_29)
  if L4_30 then
    L4_30 = Prompt
    L5_31 = L4_30
    L4_30 = L4_30.Fail
    L4_30(L5_31, TwGetStr(105539))
    return
  end
  L4_30 = A0_26.data
  L4_30 = L4_30.id
  if L4_30 == 814 then
    L4_30 = Logic
    L5_31 = L4_30
    L4_30 = L4_30.Get
    L4_30 = L4_30(L5_31, "PlayerInfo")
    L5_31 = L4_30
    L4_30 = L4_30.PostTokenCoinExchnage
    L4_30(L5_31, A0_26.data.id, 1)
    return
  end
  L4_30 = Logic
  L5_31 = L4_30
  L4_30 = L4_30.Get
  L4_30 = L4_30(L5_31, "PlayerInfo")
  L5_31 = L4_30
  L4_30 = L4_30.GetTokenCoin
  L4_30 = L4_30(L5_31)
  L5_31 = A0_26.data
  L5_31 = L5_31.costTokenCoin
  if L4_30 >= L5_31 then
    L5_31 = {}
    L5_31.title = 105550
    L5_31.func = A0_26.onExchange
    L5_31.cost = A0_26.data.costTokenCoin
    L5_31.amount = L4_30
    L5_31.currencyName = A0_26.currencyName
    L5_31.currencyPath = A0_26.iconPath
    L5_31.currencyColor = Logic:Get("Mall"):GetTokenCoinColor(L3_29.type)
    if A0_26.data.limit > 0 then
      L5_31.max = A0_26.data.limit - Logic:Get("PlayerInfo"):getExchangeTime(A0_26.data.id)
    end
    Prompt:BuyConfirm(A0_26, L5_31)
  else
    L5_31 = Prompt
    L5_31 = L5_31.Fail
    L5_31(L5_31, TwGetStr(105916, A0_26.currencyName or ""))
  end
end
function prototype.onExchange(A0_32, A1_33, A2_34)
  Logic:Get("PlayerInfo"):PostTokenCoinExchnage(A0_32.data.id, A2_34)
end
