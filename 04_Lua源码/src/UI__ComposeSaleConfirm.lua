require("SceneHelper")
module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
function prototype.onEnter(A0_0)
  local L1_1, L2_2
  L1_1 = A0_0.titleOne
  L2_2 = L1_1
  L1_1 = L1_1.setString
  L1_1(L2_2, TwGetStr(104266))
  L1_1 = A0_0.titleTwo
  L2_2 = L1_1
  L1_1 = L1_1.setString
  L1_1(L2_2, TwGetStr(104267))
end
function prototype.ApplySaleMoneyIcon(A0_3, A1_4)
  if A0_3.imgSaleMoney == nil and A0_3.staTotal ~= nil and A0_3.staTotal:getParent() ~= nil and A0_3.staTotal:getParent().getChildren ~= nil and A0_3.staTotal:getParent():getChildren() ~= nil then
    for _FORV_9_ = 1, A0_3.staTotal:getParent():getChildren():count() do
      if tolua.cast(A0_3.staTotal:getParent():getChildren():objectAtIndex(_FORV_9_ - 1), "CCSprite") ~= nil and tolua.cast(A0_3.staTotal:getParent():getChildren():objectAtIndex(_FORV_9_ - 1), "CCSprite") ~= A0_3.staTotal and tolua.cast(A0_3.staTotal:getParent():getChildren():objectAtIndex(_FORV_9_ - 1), "CCSprite") ~= A0_3.staNum then
        if math.abs((tolua.cast(A0_3.staTotal:getParent():getChildren():objectAtIndex(_FORV_9_ - 1), "CCSprite"):getPositionX() or 0) - A0_3.staTotal:getPositionX()) < 80 and math.abs((tolua.cast(A0_3.staTotal:getParent():getChildren():objectAtIndex(_FORV_9_ - 1), "CCSprite"):getPositionY() or 0) - A0_3.staTotal:getPositionY()) < 24 and tolua.cast(A0_3.staTotal:getParent():getChildren():objectAtIndex(_FORV_9_ - 1), "CCSprite"):getContentSize().width > 8 and tolua.cast(A0_3.staTotal:getParent():getChildren():objectAtIndex(_FORV_9_ - 1), "CCSprite"):getContentSize().width <= 64 and 8 < tolua.cast(A0_3.staTotal:getParent():getChildren():objectAtIndex(_FORV_9_ - 1), "CCSprite"):getContentSize().height and 64 >= tolua.cast(A0_3.staTotal:getParent():getChildren():objectAtIndex(_FORV_9_ - 1), "CCSprite"):getContentSize().height then
          A0_3.imgSaleMoney = tolua.cast(A0_3.staTotal:getParent():getChildren():objectAtIndex(_FORV_9_ - 1), "CCSprite")
          break
        end
      end
    end
  end
  if A0_3.imgSaleMoney ~= nil then
    Logic:Get("Compose"):ApplySaleMoneyIcon(A0_3.imgSaleMoney, A1_4)
  end
end
function prototype.onConfirm(A0_5)
  local L1_6, L2_7, L3_8, L4_9, L5_10, L6_11, L7_12
  L1_6 = false
  L2_7 = Logic
  L3_8 = L2_7
  L2_7 = L2_7.Get
  L4_9 = "Compose"
  L2_7 = L2_7(L3_8, L4_9)
  L3_8 = L2_7
  L2_7 = L2_7.GetSaleComposeList
  L2_7 = L2_7(L3_8)
  L3_8 = Logic
  L4_9 = L3_8
  L3_8 = L3_8.Get
  L5_10 = "Compose"
  L3_8 = L3_8(L4_9, L5_10)
  L4_9 = L3_8
  L3_8 = L3_8.GetGoodsByType
  L5_10 = "FRAGMENT"
  L3_8(L4_9, L5_10)
  L3_8 = Logic
  L4_9 = L3_8
  L3_8 = L3_8.Get
  L5_10 = "Compose"
  L3_8 = L3_8(L4_9, L5_10)
  L4_9 = L3_8
  L3_8 = L3_8.GetCasualGoods
  L3_8 = L3_8(L4_9)
  L4_9 = 4
  L5_10 = Logic
  L6_11 = L5_10
  L5_10 = L5_10.Get
  L7_12 = "Compose"
  L5_10 = L5_10(L6_11, L7_12)
  L6_11 = L5_10
  L5_10 = L5_10.SaleCurrencyTotals
  L7_12 = L2_7
  L7_12 = L5_10(L6_11, L7_12, L3_8)
  for _FORV_11_, _FORV_12_ in pairs(L2_7) do
    if L3_8[_FORV_11_] ~= nil and Logic:Get("Compose"):kdbItemConfig(L3_8[_FORV_11_].baseId) ~= nil and Logic:Get("Hero"):GetHeroInfoByBaseId(Logic:Get("Compose"):kdbItemConfig(L3_8[_FORV_11_].baseId).baseId) and L4_9 <= Logic:Get("Hero"):GetHeroInfoByBaseId(Logic:Get("Compose"):kdbItemConfig(L3_8[_FORV_11_].baseId).baseId).star then
      L1_6 = true
    end
  end
  if L1_6 then
    Prompt:Confirm(A0_5, 104158, TwGetStr(103093, L4_9), A0_5.onConfirmSale, Prompt.PROMPT_TYPE.SELECT)
    return
  end
  Prompt:Confirm(A0_5, 104180, TwGetStr(103094, L7_12, Logic:Get("Compose"):FormatSaleTotal(L5_10, L6_11)), A0_5.onConfirmSale, Prompt.PROMPT_TYPE.SELECT)
end
function prototype.onConfirmSale(A0_13)
  local L1_14
  L1_14 = Logic
  L1_14 = L1_14.Get
  L1_14 = L1_14(L1_14, "Compose")
  L1_14 = L1_14.GetSaleComposeList
  L1_14 = L1_14(L1_14)
  Logic:Get("Compose"):PostSellItems(L1_14)
  Logic:Get("BGSound"):PlayEffect("audio/sale.mp3")
end
