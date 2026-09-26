module((...), package.seeall)
require("SceneHelper")
require("BtnPosition")
prototype = BtnPosition.prototype:extend()
function prototype.onEnter(A0_0)
  super.onEnter(A0_0)
  A0_0.ttfCount:setStyle(kCCLabelTTFStyleOutline)
  Logic:Get("HallowmasExchange"):On(Logic.HallowmasExchange.EVT.GET_LOAD_INFO, A0_0:Event("onLoadInfo"))
  Logic:Get("HallowmasExchange"):On(Logic.HallowmasExchange.EVT.EXCHANGE_SUCCESS, A0_0:Event("onExchange"))
  Logic:Get("Mall"):On(Logic.Mall.EVT.GET_LOTTERY_LIST, A0_0:Event("onGetMallList"))
  A0_0.activity = Logic:Get("Gift"):GetActivityGift()
  Logic:Get("HallowmasExchange"):PostLoadInfo(A0_0.activity.id)
  A0_0:refresh(A0_0.activity.id)
  A0_0.sprRight:setScale(0.75)
  A0_0.imgBtnRightBg:setVisible(false)
  A0_0.sprRight:setVisible(false)
end
function prototype.onExit(A0_1)
  local L1_2
end
function prototype.refresh(A0_3, A1_4)
  A0_3.cardInfo = Logic:Get("HallowmasExchange"):GetExchangeCards(A1_4)
  if A0_3.cardInfo == nil then
    return
  end
  A0_3.cardInfo.mainCard = Logic:Get("Reward"):kdbRewardConfig(A0_3.cardInfo.mainCard).fixed[1].code
  A0_3:updateCards(A0_3.cardInfo)
  A0_3:setBg()
end
function prototype.setBg(A0_5)
  local L1_6
  L1_6 = A0_5.activity
  L1_6 = L1_6.showTemplete
  if L1_6 == "" or L1_6 == nil then
    L1_6 = "images/Hallowmas/exchangeBg.png"
  end
  if CCSprite:create(L1_6) then
    A0_5.sprBg:setDisplayFrame(CCSprite:create(L1_6):displayFrame())
  end
end
function prototype.onLoadInfo(A0_7)
  A0_7:checkHasExchange(A0_7.cardInfo.id)
  A0_7:refreshPanel()
end
function prototype.onExchange(A0_8)
  A0_8:checkHasExchange(A0_8.cardInfo.id)
  A0_8:refreshPanel()
end
function prototype.updateCards(A0_9, A1_10)
  local L2_11, L3_12, L4_13, L5_14, L6_15, L7_16, L8_17, L9_18, L10_19, L11_20, L12_21, L13_22, L14_23, L15_24, L16_25
  if not A1_10 then
    return
  end
  A0_9.cardInfo = A1_10
  L2_11 = A0_9.rootNode
  L3_12 = L2_11
  L2_11 = L2_11.getChildByTag
  L4_13 = 0
  L2_11 = L2_11(L3_12, L4_13)
  if L2_11 then
    L3_12 = A0_9.rootNode
    L4_13 = L3_12
    L3_12 = L3_12.removeChild
    L3_12(L4_13, L5_14, L6_15)
  end
  L3_12 = Logic
  L4_13 = L3_12
  L3_12 = L3_12.Get
  L3_12 = L3_12(L4_13, L5_14)
  L4_13 = L3_12
  L3_12 = L3_12.getColorByBaseId
  L3_12 = L3_12(L4_13, L5_14)
  L4_13 = A0_9.ttfName
  L4_13 = L4_13.setColor
  L4_13(L5_14, L6_15)
  L4_13 = Logic
  L4_13 = L4_13.Get
  L4_13 = L4_13(L5_14, L6_15)
  L4_13 = L4_13.createHeroCard
  L4_13 = L4_13(L5_14, L6_15)
  L5_14(L6_15, L7_16, L8_17, L9_18)
  L16_25 = L7_16(L8_17)
  L5_14(L6_15, L7_16, L8_17, L9_18, L10_19, L11_20, L12_21, L13_22, L14_23, L15_24, L16_25, L7_16(L8_17))
  L5_14(L6_15, L7_16)
  for L8_17, L9_18 in L5_14(L6_15) do
    L10_19 = string
    L10_19 = L10_19.format
    L11_20 = "ccb%d"
    L12_21 = L8_17
    L10_19 = L10_19(L11_20, L12_21)
    L11_20 = string
    L11_20 = L11_20.format
    L12_21 = "ttfName%d"
    L13_22 = L8_17
    L11_20 = L11_20(L12_21, L13_22)
    L12_21 = {}
    L13_22 = Logic
    L14_23 = L13_22
    L13_22 = L13_22.Get
    L15_24 = "HallowmasShop"
    L13_22 = L13_22(L14_23, L15_24)
    L14_23 = L13_22
    L13_22 = L13_22.GetSweetAmountByCode
    L15_24 = L9_18.code
    L13_22 = L13_22(L14_23, L15_24)
    L14_23 = Logic
    L14_23 = L14_23.Reward
    L14_23 = L14_23.REWARDS_TYPE
    L14_23 = L14_23.SWEET
    L12_21.type = L14_23
    L14_23 = L9_18.code
    L12_21.code = L14_23
    L14_23 = A0_9[L10_19]
    if L14_23 then
      L12_21.amount = ""
      L14_23 = A0_9[L10_19]
      L15_24 = L14_23
      L14_23 = L14_23.ReFreshByReward
      L16_25 = L12_21
      L14_23(L15_24, L16_25)
    end
    L14_23 = A0_9[L11_20]
    L15_24 = L14_23
    L14_23 = L14_23.setString
    L16_25 = TwGetStr
    L16_25 = L16_25(108261, L13_22 .. "/" .. L9_18.amount)
    L14_23(L15_24, L16_25, L16_25(108261, L13_22 .. "/" .. L9_18.amount))
    L14_23 = A0_9[L11_20]
    L15_24 = L14_23
    L14_23 = L14_23.setStyle
    L16_25 = kCCLabelTTFStyleOutline
    L14_23(L15_24, L16_25)
    L14_23 = A0_9[L11_20]
    L15_24 = L14_23
    L14_23 = L14_23.setColor
    L16_25 = ccc3
    L16_25 = L16_25(255, 134, 0)
    L14_23(L15_24, L16_25, L16_25(255, 134, 0))
  end
  for L10_19, L11_20 in L7_16(L8_17) do
    L12_21 = table
    L12_21 = L12_21.insert
    L13_22 = L6_15
    L14_23 = A1_10.stars
    L14_23 = L14_23[L10_19]
    L14_23 = L11_20 + L14_23
    L12_21(L13_22, L14_23)
  end
  for L10_19, L11_20 in L7_16(L8_17) do
    L12_21 = string
    L12_21 = L12_21.format
    L13_22 = "ccb%d"
    L14_23 = L10_19 + L5_14
    L12_21 = L12_21(L13_22, L14_23)
    L13_22 = {}
    L13_22.showType = "HERO"
    L13_22.showId = L11_20
    L14_23 = A0_9[L12_21]
    if L14_23 then
      L14_23 = A0_9[L12_21]
      L15_24 = L14_23
      L14_23 = L14_23.ReFreshByGift
      L16_25 = L13_22
      L14_23(L15_24, L16_25)
    end
    L14_23 = string
    L14_23 = L14_23.format
    L15_24 = "ttfName%d"
    L16_25 = L10_19 + L5_14
    L14_23 = L14_23(L15_24, L16_25)
    L15_24 = Logic
    L16_25 = L15_24
    L15_24 = L15_24.Get
    L15_24 = L15_24(L16_25, "Hero")
    L16_25 = L15_24
    L15_24 = L15_24.GetHeroInfoByBaseId
    L15_24 = L15_24(L16_25, L11_20)
    if L15_24 then
      L16_25 = A0_9[L14_23]
      L16_25 = L16_25.setStyle
      L16_25(L16_25, kCCLabelTTFStyleOutline)
      L16_25 = TwGetStr
      L16_25 = L16_25(104250, L15_24.star)
      A0_9[L14_23]:setString(L16_25 .. (L15_24.name or ""))
    end
    L16_25 = Logic
    L16_25 = L16_25.Get
    L16_25 = L16_25(L16_25, "Hero")
    L16_25 = L16_25.getColorByBaseId
    L16_25 = L16_25(L16_25, L11_20)
    A0_9[L14_23]:setColor(L16_25)
  end
end
function prototype.refreshPanel(A0_26)
  local L1_27, L2_28, L3_29, L4_30, L5_31, L6_32, L7_33, L8_34
  L1_27 = A0_26.cardInfo
  if not L1_27 then
    return
  end
  L1_27 = Logic
  L2_28 = L1_27
  L1_27 = L1_27.Get
  L1_27 = L1_27(L2_28, L3_29)
  L2_28 = L1_27
  L1_27 = L1_27.GetComsumeList
  L1_27 = L1_27(L2_28, L3_29)
  L1_27 = L1_27 or {}
  A0_26.cardList = L1_27
  A0_26.bCanExchange = false
  L1_27 = 0
  A0_26.isMaterialEnough = true
  L2_28 = false
  for L6_32, L7_33 in L3_29(L4_30) do
    L1_27 = L1_27 + 1
    L8_34 = 0
    L8_34 = Logic:Get("HallowmasShop"):GetSweetAmountByCode(L7_33.code)
    if L8_34 >= L7_33.amount then
      A0_26[string.format("sprBg%d", L1_27)]:setVisible(true)
      A0_26[string.format("sprEnough%d", L1_27)]:setVisible(false)
      L2_28 = true
    else
      A0_26[string.format("sprBg%d", L1_27)]:setVisible(false)
      A0_26[string.format("sprEnough%d", L1_27)]:setVisible(true)
      A0_26.isMaterialEnough = false
    end
    A0_26[string.format("ttfName%d", L1_27)]:setString(TwGetStr(108261, L8_34 .. "/" .. L7_33.amount))
    if CCSprite:create("images/Hallowmas/material.png") then
      A0_26[string.format("sprEnough%d", L1_27)]:setDisplayFrame(CCSprite:create("images/Hallowmas/material.png"):displayFrame())
    end
  end
  for L6_32, L7_33 in L3_29(L4_30) do
    L8_34 = string
    L8_34 = L8_34.format
    L8_34 = L8_34("sprBg%d", L1_27 + L6_32)
    for _FORV_13_, _FORV_14_ in pairs(A0_26.cardList) do
      if Logic:Get("Hero"):GetHeroInfoByBaseId(_FORV_14_.baseId).sameNameId == L7_33 then
        A0_26[L8_34]:setVisible(true)
        A0_26[string.format("sprEnough%d", L1_27 + L6_32)]:setVisible(false)
        L2_28 = true
        break
      else
        A0_26[L8_34]:setVisible(false)
        A0_26[string.format("sprEnough%d", L1_27 + L6_32)]:setVisible(true)
      end
    end
    if table.empty(A0_26.cardList) then
      A0_26[L8_34]:setVisible(false)
      A0_26[string.format("sprEnough%d", L1_27 + L6_32)]:setVisible(true)
    end
    if CCSprite:create("images/Exchange/kapiabuzu.png") then
      A0_26[string.format("sprEnough%d", L1_27 + L6_32)]:setDisplayFrame(CCSprite:create("images/Exchange/kapiabuzu.png"):displayFrame())
    end
  end
  L3_29(L4_30, L5_31)
  L3_29(L4_30, L5_31)
  if L3_29 == L4_30 then
    A0_26.bCanExchange = true
  end
end
function prototype.checkHasExchange(A0_35, A1_36)
  local L2_37, L3_38, L4_39
  L2_37 = Logic
  L3_38 = L2_37
  L2_37 = L2_37.Get
  L4_39 = "HallowmasExchange"
  L2_37 = L2_37(L3_38, L4_39)
  L3_38 = L2_37
  L2_37 = L2_37.GetExchangeRestCount
  L4_39 = A1_36
  L2_37 = L2_37(L3_38, L4_39)
  L3_38 = A0_35.ttfCount
  L4_39 = L3_38
  L3_38 = L3_38.setString
  L3_38(L4_39, L2_37)
  L3_38 = true
  L4_39 = A0_35.cardInfo
  L4_39 = L4_39.level
  L4_39 = L4_39 or 0
  if L4_39 > Logic:Get("PlayerInfo"):GetPlayerLevel() then
    L3_38 = false
    A0_35.ttfExchange:setString(TwGetStr(114005, L4_39))
  end
  if L2_37 <= 0 then
    L3_38 = false
    A0_35.ttfExchange:setString(TwGetStr(114006))
  end
  A0_35.nodeExchange:setVisible(L3_38)
  A0_35.ttfExchange:setVisible(not L3_38)
end
function prototype.onBtnExchange(A0_40, ...)
  if A0_40.activity and A0_40.activity.id == "EXCHANGE_2" then
    for _FORV_7_, _FORV_8_ in pairs((Logic:Get("Hero"):GetAllHeroInfo() or {}).heros or {}) do
      if KFDBGetRecord("BaseHero", _FORV_8_.baseId) and tonumber(KFDBGetRecord("BaseHero", _FORV_8_.baseId).sameNameId) == 1240 and tonumber(KFDBGetRecord("BaseHero", _FORV_8_.baseId).star) >= 11 then
        break
      end
    end
    if not true then
      Prompt:Tip("\230\156\170\230\139\165\230\156\13711\230\152\159\231\156\159\233\190\153\229\164\170\229\173\144")
      return
    end
  end
  if not A0_40.bCanExchange then
    Prompt:Tip(TwGetStr(108214))
    return
  end
  if not A0_40.isMaterialEnough then
    Prompt:Tip(TwGetStr(108215))
    return
  end
  A0_40:OnPopTip()
end
function prototype.OnPopTip(A0_42)
  local L1_43, L2_44, L3_45, L4_46, L5_47, L6_48, L7_49
  L1_43 = ""
  for L5_47, L6_48 in L2_44(L3_45) do
    L7_49 = {}
    L7_49.type = Logic.Reward.REWARDS_TYPE[L6_48.type]
    L7_49.code = L6_48.code
    L7_49.amount = L6_48.amount
    if L1_43 == "" then
      L1_43 = Logic:Get("Reward"):RewardTreaTip(L7_49)
    else
      L1_43 = L1_43 .. "," .. Logic:Get("Reward"):RewardTreaTip(L7_49)
    end
  end
  for L5_47, L6_48 in L2_44(L3_45) do
    L7_49 = Logic
    L7_49 = L7_49.Get
    L7_49 = L7_49(L7_49, "Hero")
    L7_49 = L7_49.GetHeroInfoByBaseId
    L7_49 = L7_49(L7_49, L6_48.baseId)
    L7_49 = L7_49 or {}
    if L1_43 == "" then
      L1_43 = TwGetStr(114003, L7_49.star, L7_49.name)
    else
      L1_43 = L1_43 .. "," .. TwGetStr(114003, L7_49.star, L7_49.name)
    end
  end
  if L1_43 then
    if L3_45 then
      L5_47 = L2_44.star
      L5_47 = L5_47 or 1
      L6_48 = L2_44.name
      L6_48 = L6_48 or ""
      L5_47 = 114004
      L6_48 = L1_43
      L7_49 = L3_45
      L5_47 = Prompt
      L6_48 = L5_47
      L5_47 = L5_47.Select
      L7_49 = A0_42
      L5_47(L6_48, L7_49, "", L4_46, A0_42.OnConfirmExchange)
    end
  end
end
function prototype.OnConfirmExchange(A0_50, A1_51)
  local L2_52
  L2_52 = Prompt
  L2_52 = L2_52.RET
  L2_52 = L2_52.OK
  if A1_51 == L2_52 then
    L2_52 = {}
    for _FORV_6_, _FORV_7_ in pairs(A0_50.cardList) do
      table.insert(L2_52, _FORV_7_.id)
    end
    Logic:Get("HallowmasExchange"):PostLoadExchange(L2_52, A0_50.cardInfo.id)
  end
end
function prototype.onBtnCardMain(A0_53, ...)
  if not A0_53.cardInfo then
    return
  end
  Logic:Get("HeroCardInfo"):OpenHeroInfoById(A0_53.cardInfo.mainCard)
end
function prototype.onBtnSweet(A0_55, ...)
  do return end
  Logic:Get("Gift"):SetActivityGift(Logic:Get("Gift"):GetActivityByType("SWEET_HOUSE")[1])
  SceneHelper:runWithScene("GiftHallowmasShop", A0_55.rootNode)
end
function prototype.onBtnReturn(A0_57, ...)
  SceneHelper:runWithScene("GiftActivityList", A0_57.rootNode)
end
function prototype.onGetMallList(A0_59)
  local L1_60, L2_61, L3_62
  L1_60 = Logic
  L2_61 = L1_60
  L1_60 = L1_60.Get
  L3_62 = "Gift"
  L1_60 = L1_60(L2_61, L3_62)
  L2_61 = L1_60
  L1_60 = L1_60.GetActivityGift
  L1_60 = L1_60(L2_61)
  L2_61 = Logic
  L3_62 = L2_61
  L2_61 = L2_61.Get
  L2_61 = L2_61(L3_62, "Mall")
  L3_62 = L2_61
  L2_61 = L2_61.initItemData
  L2_61(L3_62)
  L2_61 = Logic
  L3_62 = L2_61
  L2_61 = L2_61.Get
  L2_61 = L2_61(L3_62, "Mall")
  L3_62 = L2_61
  L2_61 = L2_61.GetTabData
  L2_61 = L2_61(L3_62)
  L3_62 = nil
  for _FORV_7_, _FORV_8_ in pairs(L2_61) do
    if _FORV_8_.id == L1_60.mallId then
      L3_62 = _FORV_8_
      break
    end
  end
  if L3_62 then
    Logic:Get("Mall"):SetTokenCoinData(L3_62)
    SceneHelper:pushScene("MallExchange", A0_59.rootNode)
    return
  end
  Prompt:Fail(TwGetStr(105285))
end
