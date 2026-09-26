local L0_0
L0_0 = module
L0_0((...), package.seeall)
L0_0 = require
L0_0("Logic")
L0_0 = Logic
L0_0 = L0_0.class
L0_0 = L0_0.subclass
L0_0 = L0_0(L0_0)
class = L0_0
L0_0 = TypeDef
L0_0 = L0_0("com.eyu.mt.module.reward.model.RewardType")
REWARDS_TYPE = L0_0
L0_0 = {}
L0_0[0] = "\230\156\136\233\165\188"
L0_0[1] = "\232\138\177"
L0_0[2] = "\229\165\189"
L0_0[3] = "\230\156\136"
L0_0[4] = "\229\156\134"
CURRENCY_TYPE = TypeDef("com.eyu.mt.module.currency.model.CurrencyType")
CURRENCY_CODE = Enum(CURRENCY_TYPE)
CURRENCY_TYPE_NAME = {}
CURRENCY_TYPE_NAME[CURRENCY_TYPE.COPPER] = "103008"
CURRENCY_TYPE_NAME[CURRENCY_TYPE.GOLD] = "103009"
CURRENCY_TYPE_NAME[CURRENCY_TYPE.GIFT] = "103010"
CURRENCY_TYPE_NAME[CURRENCY_TYPE.INTER] = "103011"
CURRENCY_TYPE_NAME[CURRENCY_TYPE.EXCHANGE] = "103012"
CURRENCY_TYPE_NAME[CURRENCY_TYPE.FRIENDSHIP] = "103013"
CURRENCY_TYPE_NAME[CURRENCY_TYPE.FRAGMENT] = "103026"
CURRENCY_TYPE_NAME[CURRENCY_TYPE.COUPON] = "105287"
CURRENCY_TYPE_NAME[CURRENCY_TYPE.EXPLOIT] = "105594"
CURRENCY_TYPE_NAME[CURRENCY_TYPE.PURPLE] = "108813"
CURRENCY_TYPE_NAME[CURRENCY_TYPE.ORANGE] = "108814"
TOKEN_COIN = {
  [0] = TwGetStr(105922),
  [1] = TwGetStr(105925),
  [2] = TwGetStr(110602),
  [3] = TwGetStr(110623),
  [4] = TwGetStr(105927),
  [5] = TwGetStr(117003),
  [6] = TwGetStr(115108),
  [7] = "\228\187\153\233\135\145"
}
function class.initialize(A0_1)
  super.initialize(A0_1)
end
function class.AddRewards(A0_2, A1_3, A2_4)
  local L3_5, L4_6, L5_7, L6_8, L7_9, L8_10, L9_11
  if not A1_3 then
    return
  end
  L3_5, L4_6 = nil, nil
  for L8_10, L9_11 in L5_7(L6_8) do
    if L9_11.type == REWARDS_TYPE.MENPAI_EXP then
      L3_5 = L8_10
    elseif L9_11.type == REWARDS_TYPE.EXP then
      L4_6 = L8_10
    end
  end
  if L3_5 and L4_6 then
    if not (L5_7 > L6_8) then
      if L5_7 == L6_8 then
      end
    elseif L5_7 > L6_8 then
      L5_7.exp = L6_8
      L5_7.level = L6_8
    end
  end
  for L8_10, L9_11 in L5_7(L6_8) do
    A0_2:AddOneReward(L9_11, A2_4)
  end
  if A2_4 then
    L5_7(L6_8, L7_9)
  end
end
function class.AddOneReward(A0_12, A1_13, A2_14)
  local L3_15, L4_16, L5_17, L6_18, L7_19
  if nil == A1_13 then
    return
  end
  if L3_15 == L4_16 then
    L3_15(L4_16, L5_17)
    L3_15(L4_16, L5_17)
  elseif L3_15 == L4_16 then
    L7_19 = L4_16(L5_17)
    L6_18 = L5_17
    L7_19 = "PlayerInfo"
    L6_18 = L5_17
    L7_19 = A1_13.code
    L5_17(L6_18, L7_19, A1_13.amount, Logic.PlayerInfo.PLAYER_DATA_CHANGE.ADD)
    if not A2_14 then
    end
  elseif L3_15 == L4_16 then
    L3_15(L4_16, L5_17)
  elseif L3_15 == L4_16 then
    L3_15(L4_16, L5_17)
  elseif L3_15 == L4_16 then
    L3_15(L4_16, L5_17)
  elseif L3_15 == L4_16 then
    L3_15(L4_16, L5_17)
  elseif L3_15 == L4_16 then
    L3_15(L4_16, L5_17)
  elseif L3_15 == L4_16 then
    L3_15(L4_16, L5_17)
  elseif L3_15 == L4_16 then
    L3_15(L4_16, L5_17)
  elseif L3_15 == L4_16 then
    if L3_15 == 0 then
      L3_15.point = L4_16
      L3_15.refreshTime = L4_16
      L6_18 = "PlayerInfo"
      L6_18 = L3_15
      L4_16(L5_17, L6_18)
    elseif L3_15 == 1 then
      L3_15(L4_16, L5_17)
    end
  elseif L3_15 == L4_16 then
    L3_15(L4_16, L5_17)
  elseif L3_15 == L4_16 then
    L3_15(L4_16, L5_17)
  elseif L3_15 == L4_16 then
    L3_15(L4_16, L5_17)
  elseif L3_15 == L4_16 then
    L3_15(L4_16, L5_17)
  elseif L3_15 == L4_16 then
    L3_15(L4_16, L5_17)
  elseif L3_15 == L4_16 then
    if L3_15 == 0 then
      L3_15(L4_16, L5_17)
    elseif L3_15 > 0 then
      L3_15(L4_16, L5_17)
    end
  elseif L3_15 == L4_16 then
    L3_15(L4_16, L5_17)
  elseif L3_15 == L4_16 then
    L3_15(L4_16, L5_17)
  elseif L3_15 == L4_16 then
    L3_15(L4_16, L5_17)
  elseif L3_15 == L4_16 then
    L3_15(L4_16, L5_17)
  elseif L3_15 == L4_16 then
  elseif L3_15 == L4_16 then
    L3_15(L4_16, L5_17)
  elseif L3_15 == L4_16 then
    L6_18 = A1_13.amount
    L3_15(L4_16, L5_17, L6_18)
  elseif L3_15 == L4_16 then
    L3_15(L4_16, L5_17)
  elseif L3_15 == L4_16 then
    L3_15(L4_16, L5_17)
  elseif L3_15 == L4_16 then
  elseif L3_15 == L4_16 then
    L3_15(L4_16, L5_17)
  elseif L3_15 == L4_16 then
    for L6_18, L7_19 in L3_15(L4_16) do
      Logic:Get("Armor"):addOneArmor(L7_19)
    end
  elseif L3_15 == L4_16 then
  elseif L3_15 == L4_16 then
  elseif L3_15 == L4_16 then
  elseif L3_15 == L4_16 then
  elseif L3_15 == L4_16 then
    L3_15(L4_16, L5_17)
  elseif L3_15 == L4_16 then
  elseif L3_15 == L4_16 then
    L3_15(L4_16, L5_17)
  elseif L3_15 == L4_16 then
    L3_15(L4_16, L5_17)
  elseif L3_15 == L4_16 then
    L3_15(L4_16, L5_17)
  elseif L3_15 == L4_16 then
    L3_15(L4_16, L5_17)
  elseif L3_15 == L4_16 then
    L3_15(L4_16, L5_17)
  elseif L3_15 == L4_16 then
    L3_15(L4_16, L5_17)
  elseif L3_15 == L4_16 then
    L3_15(L4_16, L5_17)
  elseif L3_15 ~= nil then
    L6_18 = A1_13.type
    L3_15(L4_16, L5_17)
  else
    L3_15(L4_16, L5_17)
  end
end
function class.GetItemsByType(A0_20, A1_21, A2_22, A3_23)
  local L4_24, L5_25, L6_26, L7_27, L8_28, L9_29
  if not A1_21 then
    L4_24 = {}
    return L4_24
  end
  L4_24 = {}
  for L8_28, L9_29 in L5_25(L6_26) do
    if L9_29.type == A2_22 and (not A3_23 or L9_29.code == A3_23) then
      table.insert(L4_24, L9_29)
    end
  end
  return L4_24
end
function class.CalcTotleNum(A0_30, A1_31, A2_32, A3_33)
  local L4_34, L5_35
  if nil == A1_31 then
    L4_34 = 0
    return L4_34
  end
  L4_34 = 0
  L5_35 = 0
  for _FORV_9_, _FORV_10_ in ipairs(A1_31) do
    if not A2_32 or _FORV_10_.code == A2_32 then
      L4_34 = L4_34 + _FORV_10_.amount
      for _FORV_14_, _FORV_15_ in pairs(_FORV_10_.additionRate or {}) do
        if _FORV_14_ == A3_33 then
          L5_35 = L5_35 + _FORV_15_
        end
      end
    end
  end
  return L4_34, L5_35
end
function class.AddDupiCardTip(A0_36, A1_37)
  local L2_38, L3_39, L4_40, L5_41, L6_42, L7_43, L8_44, L9_45, L10_46, L11_47, L12_48, L13_49
  if not A1_37 then
    return
  end
  L2_38 = ""
  L3_39 = {}
  L4_40 = {}
  L5_41 = {}
  function L6_42(A0_50)
    local L1_51, L2_52
    L1_51 = A0_50.type
    L2_52 = REWARDS_TYPE
    L2_52 = L2_52.HERO
    if L1_51 == L2_52 then
      L1_51 = true
      return L1_51
    end
    L1_51 = A0_50.type
    L2_52 = REWARDS_TYPE
    L2_52 = L2_52.EXP_CARD
    if L1_51 == L2_52 then
      L1_51 = true
      return L1_51
    end
    L1_51 = A0_50.type
    L2_52 = REWARDS_TYPE
    L2_52 = L2_52.COIN_CARD
    if L1_51 == L2_52 then
      L1_51 = true
      return L1_51
    end
    L1_51 = A0_50.type
    L2_52 = REWARDS_TYPE
    L2_52 = L2_52.TREASURE
    if L1_51 == L2_52 then
      L1_51 = true
      return L1_51
    end
    L1_51 = false
    return L1_51
  end
  for L10_46, L11_47 in L7_43(L8_44) do
    L12_48 = L6_42
    L13_49 = L11_47
    L12_48 = L12_48(L13_49)
    if L12_48 then
      L12_48 = Logic
      L13_49 = L12_48
      L12_48 = L12_48.Get
      L12_48 = L12_48(L13_49, "Hero")
      L13_49 = L12_48
      L12_48 = L12_48.GetHeroInfoByBaseId
      L12_48 = L12_48(L13_49, L11_47.code)
      if L12_48 then
        L13_49 = L12_48.id
        L3_39[L13_49] = L3_39[L12_48.id] and L3_39[L12_48.id] + 1 or 1
      end
    else
      L12_48 = L11_47.type
      L13_49 = "_"
      L12_48 = L12_48 .. L13_49 .. L11_47.code
      L13_49 = L4_40[L12_48]
      if L13_49 then
        L13_49 = L4_40[L12_48]
        L13_49.amount = L4_40[L12_48].amount + L11_47.amount
      else
        L4_40[L12_48] = L11_47
      end
    end
  end
  for L10_46, L11_47 in L7_43(L8_44) do
    L12_48 = Logic
    L13_49 = L12_48
    L12_48 = L12_48.Get
    L12_48 = L12_48(L13_49, "Hero")
    L13_49 = L12_48
    L12_48 = L12_48.GetHeroInfoByBaseId
    L12_48 = L12_48(L13_49, L10_46)
    L13_49 = nil
    if L12_48.card == "HERO" then
      L13_49 = TwGetStr(103074, TwGetStr(104250, L12_48.star) .. L12_48.name) .. "*" .. L11_47
    else
      L13_49 = TwGetStr(103074, L12_48.name) .. "*" .. L11_47
    end
    L2_38 = L2_38 .. L13_49 .. "\n"
    table.insert(L5_41, L13_49)
  end
  for L10_46, L11_47 in L7_43(L8_44) do
    L13_49 = A0_36
    L12_48 = A0_36.RewardTip
    L12_48 = L12_48(L13_49, L11_47)
    L13_49 = L2_38
    L2_38 = L13_49 .. L12_48 .. "\n"
    L13_49 = table
    L13_49 = L13_49.insert
    L13_49(L5_41, L12_48)
  end
  return L7_43, L8_44
end
function class.AddRewardsTip(A0_53, A1_54)
  local L2_55, L3_56, L4_57, L5_58, L6_59, L7_60
  if not A1_54 then
    return
  end
  L2_55 = ""
  for L6_59, L7_60 in L3_56(L4_57) do
    L2_55 = L2_55 .. A0_53:RewardTip(L7_60) .. "\n"
  end
  return L2_55
end
function class.RewardTip(A0_61, A1_62)
  local L2_63, L3_64, L4_65
  if nil == A1_62 then
    L2_63 = ""
    return L2_63
  end
  L2_63 = ""
  L3_64 = A1_62.type
  L4_65 = REWARDS_TYPE
  L4_65 = L4_65.EXP
  if L3_64 ~= L4_65 then
    L3_64 = A1_62.type
  else
    if L3_64 == "EXP" then
      L3_64 = TwGetStr
      L4_65 = 103072
      L3_64 = L3_64(L4_65, A1_62.amount)
      L2_63 = L3_64
      return L2_63
  end
  else
    L3_64 = A1_62.type
    L4_65 = REWARDS_TYPE
    L4_65 = L4_65.CURRENCY
    if L3_64 ~= L4_65 then
      L3_64 = A1_62.type
    else
      if L3_64 == "CURRENCY" then
        L3_64 = TwGetStr
        L4_65 = CURRENCY_TYPE_NAME
        L4_65 = L4_65[A1_62.code]
        L3_64 = L3_64(L4_65)
        L4_65 = A1_62.amount
        L2_63 = TwGetStr(103014) .. " " .. L3_64 .. "*" .. L4_65
        return L2_63
    end
    else
      L3_64 = A1_62.type
      L4_65 = REWARDS_TYPE
      L4_65 = L4_65.ITEM
      if L3_64 ~= L4_65 then
        L3_64 = A1_62.type
      else
        if L3_64 == "ITEM" then
          return L2_63
      end
      else
        L3_64 = A1_62.type
        L4_65 = REWARDS_TYPE
        L4_65 = L4_65.EQUIP
        if L3_64 ~= L4_65 then
          L3_64 = A1_62.type
        else
          if L3_64 == "EQUIP" then
            return L2_63
        end
        else
          L3_64 = A1_62.type
          L4_65 = REWARDS_TYPE
          L4_65 = L4_65.FRAGMENT
          if L3_64 ~= L4_65 then
            L3_64 = A1_62.type
          else
            if L3_64 == "FRAGMENT" then
              L3_64 = Logic
              L4_65 = L3_64
              L3_64 = L3_64.Get
              L3_64 = L3_64(L4_65, "Compose")
              L4_65 = L3_64
              L3_64 = L3_64.kdbItemConfig
              L3_64 = L3_64(L4_65, A1_62.code)
              if L3_64 then
                L4_65 = L3_64.name
                if L4_65 then
                  L4_65 = TwGetStr
                  L4_65 = L4_65(103074, L3_64.name)
                  L2_63 = L4_65 .. "*" .. A1_62.amount
                end
              end
              return L2_63
          end
          else
            L3_64 = A1_62.type
            L4_65 = REWARDS_TYPE
            L4_65 = L4_65.HERO
            if L3_64 ~= L4_65 then
              L3_64 = A1_62.type
            else
              if L3_64 == "HERO" then
                L3_64 = KFDBGetRecord
                L4_65 = "BaseHero"
                L3_64 = L3_64(L4_65, A1_62.code)
                if L3_64 then
                  L4_65 = L3_64.name
                  if L4_65 then
                    L4_65 = TwGetStr
                    L4_65 = L4_65(103074, TwGetStr(104250, L3_64.star or 0) .. L3_64.name)
                    L2_63 = L4_65 .. "*" .. A1_62.amount
                  end
                end
                return L2_63
            end
            else
              L3_64 = A1_62.type
              L4_65 = REWARDS_TYPE
              L4_65 = L4_65.EXP_CARD
              if L3_64 ~= L4_65 then
                L3_64 = A1_62.type
              else
                if L3_64 == "EXP_CARD" then
                  L3_64 = KFDBGetRecord
                  L4_65 = "BaseHero"
                  L3_64 = L3_64(L4_65, A1_62.code)
                  if L3_64 then
                    L4_65 = L3_64.name
                    if L4_65 then
                      L4_65 = TwGetStr
                      L4_65 = L4_65(103074, L3_64.name)
                      L2_63 = L4_65 .. "*" .. A1_62.amount
                    end
                  end
                  return L2_63
              end
              else
                L3_64 = A1_62.type
                L4_65 = REWARDS_TYPE
                L4_65 = L4_65.COIN_CARD
                if L3_64 ~= L4_65 then
                  L3_64 = A1_62.type
                else
                  if L3_64 == "COIN_CARD" then
                    L3_64 = KFDBGetRecord
                    L4_65 = "BaseHero"
                    L3_64 = L3_64(L4_65, A1_62.code)
                    if L3_64 then
                      L4_65 = L3_64.name
                      if L4_65 then
                        L4_65 = TwGetStr
                        L4_65 = L4_65(103074, L3_64.name)
                        L2_63 = L4_65 .. "*" .. A1_62.amount
                      end
                    end
                    return L2_63
                end
                else
                  L3_64 = A1_62.type
                  L4_65 = REWARDS_TYPE
                  L4_65 = L4_65.TREASURE
                  if L3_64 ~= L4_65 then
                    L3_64 = A1_62.type
                  else
                    if L3_64 == "TREASURE" then
                      L3_64 = KFDBGetRecord
                      L4_65 = "BaseHero"
                      L3_64 = L3_64(L4_65, A1_62.code)
                      if L3_64 then
                        L4_65 = L3_64.name
                        if L4_65 then
                          L4_65 = TwGetStr
                          L4_65 = L4_65(103074, L3_64.name)
                          L2_63 = L4_65 .. "*" .. A1_62.amount
                        end
                      end
                      return L2_63
                  end
                  else
                    L3_64 = A1_62.type
                    L4_65 = REWARDS_TYPE
                    L4_65 = L4_65.ACTION_POINT
                    if L3_64 ~= L4_65 then
                      L3_64 = A1_62.type
                    else
                      if L3_64 == "ACTION_POINT" then
                        L3_64 = A1_62.code
                        if L3_64 == 0 then
                          L3_64 = TwGetStr
                          L4_65 = 103073
                          L3_64 = L3_64(L4_65, A1_62.amount)
                          L2_63 = L3_64
                        else
                          L3_64 = A1_62.code
                          if L3_64 == 1 then
                            L3_64 = TwGetStr
                            L4_65 = 103080
                            L3_64 = L3_64(L4_65)
                            L4_65 = " "
                            L2_63 = L3_64 .. L4_65 .. TwGetStr(103084) .. "*" .. A1_62.amount
                          end
                        end
                        return L2_63
                    end
                    else
                      L3_64 = A1_62.type
                      L4_65 = REWARDS_TYPE
                      L4_65 = L4_65.VIP_TIME
                      if L3_64 ~= L4_65 then
                        L3_64 = A1_62.type
                      else
                        if L3_64 == "VIP_TIME" then
                          L3_64 = TwGetStr
                          L4_65 = 103076
                          L3_64 = L3_64(L4_65)
                          L2_63 = L3_64
                          return L2_63
                      end
                      else
                        L3_64 = A1_62.type
                        L4_65 = REWARDS_TYPE
                        L4_65 = L4_65.BUFF
                        if L3_64 ~= L4_65 then
                          L3_64 = A1_62.type
                        else
                          if L3_64 == "BUFF" then
                            return L2_63
                        end
                        else
                          L3_64 = A1_62.type
                          L4_65 = REWARDS_TYPE
                          L4_65 = L4_65.LEADERSHIP
                          if L3_64 ~= L4_65 then
                            L3_64 = A1_62.type
                          else
                            if L3_64 == "LEADERSHIP" then
                              return L2_63
                          end
                          else
                            L3_64 = A1_62.type
                            L4_65 = REWARDS_TYPE
                            L4_65 = L4_65.DEMOG_FEAT
                            if L3_64 ~= L4_65 then
                              L3_64 = A1_62.type
                            else
                              if L3_64 == "DEMOG_FEAT" then
                                L3_64 = TwGetStr
                                L4_65 = 103014
                                L3_64 = L3_64(L4_65)
                                L4_65 = " "
                                L2_63 = L3_64 .. L4_65 .. TwGetStr(103083) .. "*" .. A1_62.amount
                                return L2_63
                            end
                            else
                              L3_64 = A1_62.type
                              L4_65 = REWARDS_TYPE
                              L4_65 = L4_65.DEMOG_FRAGMENT
                              if L3_64 ~= L4_65 then
                                L3_64 = A1_62.type
                              else
                                if L3_64 == "DEMOG_FRAGMENT" then
                                  L3_64 = TwGetStr
                                  L4_65 = 103080
                                  L3_64 = L3_64(L4_65)
                                  L4_65 = " "
                                  L2_63 = L3_64 .. L4_65 .. TwGetStr(103082) .. "*" .. A1_62.amount
                                  return L2_63
                              end
                              else
                                L3_64 = A1_62.type
                                L4_65 = REWARDS_TYPE
                                L4_65 = L4_65.SOUL_STONE
                                if L3_64 ~= L4_65 then
                                  L3_64 = A1_62.type
                                else
                                  if L3_64 == "SOUL_STONE" then
                                    L3_64 = A1_62.code
                                    if L3_64 == 0 then
                                      L3_64 = TwGetStr
                                      L4_65 = 103080
                                      L3_64 = L3_64(L4_65)
                                      L4_65 = " "
                                      L2_63 = L3_64 .. L4_65 .. TwGetStr(105907) .. "*" .. A1_62.amount
                                    else
                                      L3_64 = A1_62.code
                                      if L3_64 == 1 then
                                        L3_64 = TwGetStr
                                        L4_65 = 103080
                                        L3_64 = L3_64(L4_65)
                                        L4_65 = " "
                                        L2_63 = L3_64 .. L4_65 .. TwGetStr(105913) .. "*" .. A1_62.amount
                                      else
                                        L3_64 = A1_62.code
                                        if L3_64 == 2 then
                                          L3_64 = TwGetStr
                                          L4_65 = 103080
                                          L3_64 = L3_64(L4_65)
                                          L4_65 = " "
                                          L2_63 = L3_64 .. L4_65 .. TwGetStr(105914) .. "*" .. A1_62.amount
                                        else
                                          L3_64 = A1_62.code
                                          if L3_64 == 3 then
                                            L3_64 = TwGetStr
                                            L4_65 = 103080
                                            L3_64 = L3_64(L4_65)
                                            L4_65 = " "
                                            L2_63 = L3_64 .. L4_65 .. TwGetStr(105915) .. "*" .. A1_62.amount
                                          end
                                        end
                                      end
                                    end
                                    return L2_63
                                end
                                else
                                  L3_64 = A1_62.type
                                  L4_65 = REWARDS_TYPE
                                  L4_65 = L4_65.TOKEN_COIN
                                  if L3_64 == L4_65 then
                                    L3_64 = TwGetStr
                                    L4_65 = 103080
                                    L3_64 = L3_64(L4_65)
                                    L4_65 = " "
                                    L2_63 = L3_64 .. L4_65 .. (TOKEN_COIN[A1_62.code] or "") .. "*" .. A1_62.amount
                                    return L2_63
                                  else
                                    L3_64 = A1_62.type
                                    L4_65 = REWARDS_TYPE
                                    L4_65 = L4_65.ARENA_INTEGRAL
                                    if L3_64 == L4_65 then
                                      L3_64 = TwGetStr
                                      L4_65 = 103080
                                      L3_64 = L3_64(L4_65)
                                      L4_65 = " "
                                      L2_63 = L3_64 .. L4_65 .. TwGetStr(105336) .. "*" .. A1_62.amount
                                      return L2_63
                                    else
                                      L3_64 = A1_62.type
                                      L4_65 = REWARDS_TYPE
                                      L4_65 = L4_65.TALISMAN_FRAGMENT
                                      if L3_64 == L4_65 then
                                        L3_64 = TwGetStr
                                        L4_65 = 103080
                                        L3_64 = L3_64(L4_65)
                                        L4_65 = " "
                                        L2_63 = L3_64 .. L4_65 .. TwGetStr(112043) .. "*" .. A1_62.amount
                                        return L2_63
                                      else
                                        L3_64 = A1_62.type
                                        L4_65 = REWARDS_TYPE
                                        L4_65 = L4_65.TALISMAN
                                        if L3_64 == L4_65 then
                                          L3_64 = KFDBGetRecord
                                          L4_65 = "TalismanSetting"
                                          L3_64 = L3_64(L4_65, A1_62.code)
                                          if L3_64 ~= nil then
                                            L4_65 = Logic
                                            L4_65 = L4_65.Get
                                            L4_65 = L4_65(L4_65, "Hero")
                                            L4_65 = L4_65.GetHeroInfoByBaseId
                                            L4_65 = L4_65(L4_65, L3_64.baseId)
                                            if L4_65 and L4_65.name then
                                              L2_63 = TwGetStr(103074, L4_65.name) .. "*" .. A1_62.amount
                                              return L2_63
                                            end
                                          end
                                          return L2_63
                                        else
                                          L3_64 = A1_62.type
                                          L4_65 = REWARDS_TYPE
                                          L4_65 = L4_65.MENPAI_EXP
                                          if L3_64 == L4_65 then
                                            L3_64 = TwGetStr
                                            L4_65 = 103080
                                            L3_64 = L3_64(L4_65)
                                            L4_65 = " "
                                            L2_63 = L3_64 .. L4_65 .. TwGetStr(110202) .. "*" .. A1_62.amount
                                            return L2_63
                                          else
                                            L3_64 = A1_62.type
                                            L4_65 = REWARDS_TYPE
                                            L4_65 = L4_65.EGG_HAMMER
                                            if L3_64 == L4_65 then
                                              L3_64 = A1_62.code
                                              if L3_64 == 0 then
                                                L3_64 = TwGetStr
                                                L4_65 = 103080
                                                L3_64 = L3_64(L4_65)
                                                L4_65 = " "
                                                L2_63 = L3_64 .. L4_65 .. TwGetStr(110507) .. "*" .. A1_62.amount
                                              else
                                                L3_64 = A1_62.code
                                                if L3_64 == 1 then
                                                  L3_64 = TwGetStr
                                                  L4_65 = 103080
                                                  L3_64 = L3_64(L4_65)
                                                  L4_65 = " "
                                                  L2_63 = L3_64 .. L4_65 .. TwGetStr(117004) .. "*" .. A1_62.amount
                                                end
                                              end
                                              return L2_63
                                            else
                                              L3_64 = A1_62.type
                                              L4_65 = REWARDS_TYPE
                                              L4_65 = L4_65.BOX_KEY
                                              if L3_64 == L4_65 then
                                                L3_64 = TwGetStr
                                                L4_65 = 103080
                                                L3_64 = L3_64(L4_65)
                                                L4_65 = " "
                                                L2_63 = L3_64 .. L4_65 .. (_UPVALUE0_[A1_62.code] or "") .. "*" .. A1_62.amount
                                                return L2_63
                                              else
                                                L3_64 = A1_62.type
                                                L4_65 = REWARDS_TYPE
                                                L4_65 = L4_65.TREASURE_ROOM_CURRENCY
                                                if L3_64 == L4_65 then
                                                  L3_64 = TwGetStr
                                                  L4_65 = 103080
                                                  L3_64 = L3_64(L4_65)
                                                  L4_65 = " "
                                                  L2_63 = L3_64 .. L4_65 .. TwGetStr(110602) .. "*" .. A1_62.amount
                                                  return L2_63
                                                else
                                                  L3_64 = A1_62.type
                                                  L4_65 = REWARDS_TYPE
                                                  L4_65 = L4_65.JIPING
                                                  if L3_64 == L4_65 then
                                                    L3_64 = TwGetStr
                                                    L4_65 = 103080
                                                    L3_64 = L3_64(L4_65)
                                                    L4_65 = " "
                                                    L2_63 = L3_64 .. L4_65 .. TwGetStr(110761) .. "*" .. A1_62.amount
                                                    return L2_63
                                                  else
                                                    L3_64 = A1_62.type
                                                    L4_65 = REWARDS_TYPE
                                                    L4_65 = L4_65.MENPAI_MONEY
                                                    if L3_64 == L4_65 then
                                                      L3_64 = TwGetStr
                                                      L4_65 = 103080
                                                      L3_64 = L3_64(L4_65)
                                                      L4_65 = " "
                                                      L2_63 = L3_64 .. L4_65 .. TwGetStr(108132) .. "*" .. A1_62.amount
                                                      return L2_63
                                                    else
                                                      L3_64 = A1_62.type
                                                      L4_65 = REWARDS_TYPE
                                                      L4_65 = L4_65.SECRETSHOP_CURRENCY
                                                      if L3_64 == L4_65 then
                                                        L3_64 = TwGetStr
                                                        L4_65 = 103080
                                                        L3_64 = L3_64(L4_65)
                                                        L4_65 = TwGetStr
                                                        L4_65 = L4_65(111146)
                                                        L2_63 = L3_64 .. L4_65 .. "*" .. A1_62.amount
                                                        return L2_63
                                                      else
                                                        L3_64 = A1_62.type
                                                        L4_65 = REWARDS_TYPE
                                                        L4_65 = L4_65.EQUIPMENT
                                                        if L3_64 == L4_65 then
                                                          L3_64 = Logic
                                                          L4_65 = L3_64
                                                          L3_64 = L3_64.Get
                                                          L3_64 = L3_64(L4_65, "Armor")
                                                          L4_65 = L3_64
                                                          L3_64 = L3_64.getArmorInfoByBaseId
                                                          L3_64 = L3_64(L4_65, A1_62.code)
                                                          L4_65 = TwGetStr
                                                          L4_65 = L4_65(103080)
                                                          L2_63 = L4_65 .. " " .. L3_64.name .. "*" .. A1_62.amount
                                                          return L2_63
                                                        else
                                                          L3_64 = A1_62.type
                                                          L4_65 = REWARDS_TYPE
                                                          L4_65 = L4_65.EQUIPMENT_FRAGMENT
                                                          if L3_64 == L4_65 then
                                                            L3_64 = Logic
                                                            L4_65 = L3_64
                                                            L3_64 = L3_64.Get
                                                            L3_64 = L3_64(L4_65, "Armor")
                                                            L4_65 = L3_64
                                                            L3_64 = L3_64.getArmorInfoByBaseId
                                                            L3_64 = L3_64(L4_65, A1_62.code)
                                                            L4_65 = TwGetStr
                                                            L4_65 = L4_65(103080)
                                                            L2_63 = L4_65 .. " " .. TwGetStr(111420, L3_64.name) .. "*" .. A1_62.amount
                                                            return L2_63
                                                          else
                                                            L3_64 = A1_62.type
                                                            L4_65 = REWARDS_TYPE
                                                            L4_65 = L4_65.EQUIPMENT_MATERIAL
                                                            if L3_64 == L4_65 then
                                                              L3_64 = A1_62.code
                                                              if L3_64 == 0 then
                                                                L3_64 = TwGetStr
                                                                L4_65 = 103080
                                                                L3_64 = L3_64(L4_65)
                                                                L4_65 = " "
                                                                L2_63 = L3_64 .. L4_65 .. TwGetStr(111417) .. "*" .. A1_62.amount
                                                              else
                                                                L3_64 = A1_62.code
                                                                if L3_64 == 1 then
                                                                  L3_64 = TwGetStr
                                                                  L4_65 = 103080
                                                                  L3_64 = L3_64(L4_65)
                                                                  L4_65 = " "
                                                                  L2_63 = L3_64 .. L4_65 .. TwGetStr(111418) .. "*" .. A1_62.amount
                                                                else
                                                                  L3_64 = A1_62.code
                                                                  if L3_64 == 2 then
                                                                    L3_64 = TwGetStr
                                                                    L4_65 = 103080
                                                                    L3_64 = L3_64(L4_65)
                                                                    L4_65 = " "
                                                                    L2_63 = L3_64 .. L4_65 .. TwGetStr(111454) .. "*" .. A1_62.amount
                                                                  end
                                                                end
                                                              end
                                                              return L2_63
                                                            else
                                                              L3_64 = A1_62.type
                                                              L4_65 = REWARDS_TYPE
                                                              L4_65 = L4_65.FOOTBALL
                                                              if L3_64 == L4_65 then
                                                                L3_64 = TwGetStr
                                                                L4_65 = 103080
                                                                L3_64 = L3_64(L4_65)
                                                                L4_65 = " "
                                                                L2_63 = L3_64 .. L4_65 .. TwGetStr(111660) .. "*" .. A1_62.amount
                                                                return L2_63
                                                              else
                                                                L3_64 = A1_62.type
                                                                L4_65 = REWARDS_TYPE
                                                                L4_65 = L4_65.MOON
                                                                if L3_64 == L4_65 then
                                                                  L3_64 = TwGetStr
                                                                  L4_65 = 103080
                                                                  L3_64 = L3_64(L4_65)
                                                                  L4_65 = " "
                                                                  L2_63 = L3_64 .. L4_65 .. _UPVALUE1_(A1_62)
                                                                  return L2_63
                                                                else
                                                                  L3_64 = A1_62.type
                                                                  L4_65 = REWARDS_TYPE
                                                                  L4_65 = L4_65.MONOPOLY
                                                                  if L3_64 == L4_65 then
                                                                    L3_64 = TwGetStr
                                                                    L4_65 = 103080
                                                                    L3_64 = L3_64(L4_65)
                                                                    L4_65 = " "
                                                                    L2_63 = L3_64 .. L4_65 .. TwGetStr(115068 + A1_62.code) .. "*" .. A1_62.amount
                                                                    return L2_63
                                                                  else
                                                                    L3_64 = A1_62.type
                                                                    L4_65 = REWARDS_TYPE
                                                                    L4_65 = L4_65.TALISMAN_LIEBI
                                                                    if L3_64 == L4_65 then
                                                                      L3_64 = TwGetStr
                                                                      L4_65 = 103080
                                                                      L3_64 = L3_64(L4_65)
                                                                      L4_65 = " "
                                                                      L2_63 = L3_64 .. L4_65 .. TwGetStr(112054) .. "*" .. A1_62.amount
                                                                      return L2_63
                                                                    else
                                                                      L3_64 = A1_62.type
                                                                      L4_65 = REWARDS_TYPE
                                                                      L4_65 = L4_65.SLOT_LOTTERY_TIMES
                                                                      if L3_64 == L4_65 then
                                                                        L3_64 = TwGetStr
                                                                        L4_65 = 103080
                                                                        L3_64 = L3_64(L4_65)
                                                                        L4_65 = " "
                                                                        L2_63 = L3_64 .. L4_65 .. TwGetStr(115106) .. "*" .. A1_62.amount
                                                                        return L2_63
                                                                      else
                                                                        L3_64 = A1_62.type
                                                                        L4_65 = REWARDS_TYPE
                                                                        L4_65 = L4_65.SWEET
                                                                        if L3_64 == L4_65 then
                                                                          L3_64 = A1_62.code
                                                                          if L3_64 == 0 then
                                                                            L3_64 = TwGetStr
                                                                            L4_65 = 103080
                                                                            L3_64 = L3_64(L4_65)
                                                                            L4_65 = " "
                                                                            L2_63 = L3_64 .. L4_65 .. TwGetStr(108260) .. "*" .. A1_62.amount
                                                                          else
                                                                            L3_64 = A1_62.code
                                                                            if L3_64 == 1 then
                                                                              L3_64 = TwGetStr
                                                                              L4_65 = 103080
                                                                              L3_64 = L3_64(L4_65)
                                                                              L4_65 = " "
                                                                              L2_63 = L3_64 .. L4_65 .. TwGetStr(108258) .. "*" .. A1_62.amount
                                                                            else
                                                                              L3_64 = A1_62.code
                                                                              if L3_64 == 2 then
                                                                                L3_64 = TwGetStr
                                                                                L4_65 = 103080
                                                                                L3_64 = L3_64(L4_65)
                                                                                L4_65 = " "
                                                                                L2_63 = L3_64 .. L4_65 .. TwGetStr(108259) .. "*" .. A1_62.amount
                                                                              else
                                                                                L3_64 = A1_62.code
                                                                                if L3_64 == 3 then
                                                                                  L3_64 = TwGetStr
                                                                                  L4_65 = 103080
                                                                                  L3_64 = L3_64(L4_65)
                                                                                  L4_65 = " "
                                                                                  L2_63 = L3_64 .. L4_65 .. TwGetStr(108263) .. "*" .. A1_62.amount
                                                                                else
                                                                                  L3_64 = _UPVALUE2_
                                                                                  L4_65 = A1_62.code
                                                                                  L3_64 = L3_64[L4_65]
                                                                                  if L3_64 ~= nil then
                                                                                    L3_64 = TwGetStr
                                                                                    L4_65 = 103080
                                                                                    L3_64 = L3_64(L4_65)
                                                                                    L4_65 = " "
                                                                                    L2_63 = L3_64 .. L4_65 .. _UPVALUE2_[A1_62.code] .. "*" .. A1_62.amount
                                                                                  end
                                                                                end
                                                                              end
                                                                            end
                                                                          end
                                                                          return L2_63
                                                                        else
                                                                          L3_64 = A1_62.type
                                                                          L4_65 = REWARDS_TYPE
                                                                          L4_65 = L4_65.CULTIVATE_ELIXIR
                                                                          if L3_64 == L4_65 then
                                                                            L3_64 = Logic
                                                                            L4_65 = L3_64
                                                                            L3_64 = L3_64.Get
                                                                            L3_64 = L3_64(L4_65, "Cultivate")
                                                                            L4_65 = L3_64
                                                                            L3_64 = L3_64.GetPillInfoByBaseId
                                                                            L3_64 = L3_64(L4_65, A1_62.code)
                                                                            L4_65 = TwGetStr
                                                                            L4_65 = L4_65(103080)
                                                                            L2_63 = L4_65 .. " " .. L3_64.name .. "*" .. A1_62.amount
                                                                            return L2_63
                                                                          else
                                                                            L3_64 = A1_62.type
                                                                            L4_65 = REWARDS_TYPE
                                                                            L4_65 = L4_65.CULTIVATE_MATERIAL
                                                                            if L3_64 == L4_65 then
                                                                              L3_64 = Logic
                                                                              L4_65 = L3_64
                                                                              L3_64 = L3_64.Get
                                                                              L3_64 = L3_64(L4_65, "Cultivate")
                                                                              L4_65 = L3_64
                                                                              L3_64 = L3_64.GetStuffInfoByBaseId
                                                                              L3_64 = L3_64(L4_65, A1_62.code)
                                                                              L4_65 = TwGetStr
                                                                              L4_65 = L4_65(103080)
                                                                              L2_63 = L4_65 .. " " .. L3_64.name .. "*" .. A1_62.amount
                                                                              return L2_63
                                                                            else
                                                                              L3_64 = A1_62.type
                                                                              L4_65 = REWARDS_TYPE
                                                                              L4_65 = L4_65.TURKEY
                                                                              if L3_64 == L4_65 then
                                                                                L3_64 = A1_62.code
                                                                                if L3_64 == 0 then
                                                                                  L3_64 = TwGetStr
                                                                                  L4_65 = 103080
                                                                                  L3_64 = L3_64(L4_65)
                                                                                  L4_65 = " "
                                                                                  L2_63 = L3_64 .. L4_65 .. TwGetStr(108764) .. "*" .. A1_62.amount
                                                                                else
                                                                                  L3_64 = A1_62.code
                                                                                  if L3_64 == 1 then
                                                                                    L3_64 = TwGetStr
                                                                                    L4_65 = 103080
                                                                                    L3_64 = L3_64(L4_65)
                                                                                    L4_65 = " "
                                                                                    L2_63 = L3_64 .. L4_65 .. TwGetStr(108765) .. "*" .. A1_62.amount
                                                                                  else
                                                                                    L3_64 = A1_62.code
                                                                                    if L3_64 == 2 then
                                                                                      L3_64 = TwGetStr
                                                                                      L4_65 = 103080
                                                                                      L3_64 = L3_64(L4_65)
                                                                                      L4_65 = " "
                                                                                      L2_63 = L3_64 .. L4_65 .. TwGetStr(108766) .. "*" .. A1_62.amount
                                                                                    end
                                                                                  end
                                                                                end
                                                                                return L2_63
                                                                              else
                                                                                L3_64 = A1_62.type
                                                                                L4_65 = REWARDS_TYPE
                                                                                L4_65 = L4_65.EXPLORE_NPC_EXP
                                                                                if L3_64 == L4_65 then
                                                                                  L3_64 = TwGetStr
                                                                                  L4_65 = 103080
                                                                                  L3_64 = L3_64(L4_65)
                                                                                  L4_65 = " "
                                                                                  L2_63 = L3_64 .. L4_65 .. TwGetStr(115235) .. "*" .. A1_62.amount
                                                                                  return L2_63
                                                                                else
                                                                                  L3_64 = A1_62.type
                                                                                  L4_65 = REWARDS_TYPE
                                                                                  L4_65 = L4_65.NEW_MONOPOLY
                                                                                  if L3_64 == L4_65 then
                                                                                    L3_64 = {}
                                                                                    L4_65 = TwGetStr
                                                                                    L4_65 = L4_65(115068)
                                                                                    L3_64[0] = L4_65
                                                                                    L4_65 = TwGetStr
                                                                                    L4_65 = L4_65(115069)
                                                                                    L3_64[1] = L4_65
                                                                                    L4_65 = TwGetStr
                                                                                    L4_65 = L4_65(115070)
                                                                                    L3_64[2] = L4_65
                                                                                    L4_65 = TwGetStr
                                                                                    L4_65 = L4_65(115370)
                                                                                    L3_64[3] = L4_65
                                                                                    L4_65 = TwGetStr
                                                                                    L4_65 = L4_65(103080)
                                                                                    L2_63 = L4_65 .. " " .. (L3_64[A1_62.code] or "") .. "*" .. A1_62.amount
                                                                                    return L2_63
                                                                                  else
                                                                                    return L2_63
                                                                                  end
                                                                                end
                                                                              end
                                                                            end
                                                                          end
                                                                        end
                                                                      end
                                                                    end
                                                                  end
                                                                end
                                                              end
                                                            end
                                                          end
                                                        end
                                                      end
                                                    end
                                                  end
                                                end
                                              end
                                            end
                                          end
                                        end
                                      end
                                    end
                                  end
                                end
                              end
                            end
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end
function class.OpenTip(A0_66, A1_67)
  Prompt:Tip(A1_67)
end
function class.kdbRewardConfig(A0_68, A1_69)
  if A1_69 == nil then
    return
  end
  if KFDBGetRecord("RewardConfig", A1_69) and KFDBGetRecord("RewardConfig", A1_69).fixed then
    KFDBGetRecord("RewardConfig", A1_69).fixed = json.decode(KFDBGetRecord("RewardConfig", A1_69).fixed)
  end
  return (KFDBGetRecord("RewardConfig", A1_69))
end
function class.GetTreaStr(A0_70, A1_71)
end
function class.comRewards(A0_72, A1_73)
  local L2_74, L3_75, L4_76, L5_77, L6_78, L7_79, L8_80, L9_81
  L2_74 = {}
  for L6_78 = 1, #A1_73 do
    L7_79 = A1_73[L6_78]
    L7_79 = L7_79.code
    L7_79 = L2_74[L7_79]
    if L7_79 then
      L7_79 = A1_73[L6_78]
      L7_79 = L7_79.code
      L7_79 = L2_74[L7_79]
      L8_80 = A1_73[L6_78]
      L8_80 = L8_80.code
      L8_80 = L2_74[L8_80]
      L8_80 = L8_80.amount
      L9_81 = A1_73[L6_78]
      L9_81 = L9_81.amount
      L8_80 = L8_80 + L9_81
      L7_79.amount = L8_80
    else
      L7_79 = A1_73[L6_78]
      L7_79 = L7_79.code
      L8_80 = A1_73[L6_78]
      L2_74[L7_79] = L8_80
    end
  end
  return L2_74
end
function class.FabaocomRewards(A0_82, A1_83)
  local L2_84, L3_85, L4_86, L5_87, L6_88, L7_89, L8_90, L9_91
  L2_84 = {}
  for L6_88 = 1, #A1_83 do
    L7_89 = #L2_84
    if L7_89 ~= 0 then
      L7_89 = A1_83[L6_88]
      L7_89 = L7_89.type
      L7_89 = L2_84[L7_89]
      if L7_89 then
        L7_89 = A1_83[L6_88]
        L7_89 = L7_89.type
        L7_89 = L2_84[L7_89]
        L8_90 = A1_83[L6_88]
        L8_90 = L8_90.code
        L7_89 = L7_89[L8_90]
        if L7_89 then
          L7_89 = A1_83[L6_88]
          L7_89 = L7_89.type
          L7_89 = L2_84[L7_89]
          L8_90 = A1_83[L6_88]
          L8_90 = L8_90.code
          L7_89 = L7_89[L8_90]
          L8_90 = A1_83[L6_88]
          L8_90 = L8_90.type
          L8_90 = L2_84[L8_90]
          L9_91 = A1_83[L6_88]
          L9_91 = L9_91.code
          L8_90 = L8_90[L9_91]
          L8_90 = L8_90.amount
          L9_91 = A1_83[L6_88]
          L9_91 = L9_91.amount
          L8_90 = L8_90 + L9_91
          L7_89.amount = L8_90
        end
      end
    else
      L7_89 = A1_83[L6_88]
      L7_89 = L7_89.type
      L7_89 = L2_84[L7_89]
      if L7_89 then
        L7_89 = A1_83[L6_88]
        L7_89 = L7_89.type
        L7_89 = L2_84[L7_89]
        L8_90 = A1_83[L6_88]
        L8_90 = L8_90.code
        L9_91 = {}
        L7_89[L8_90] = L9_91
        L7_89 = A1_83[L6_88]
        L7_89 = L7_89.type
        L7_89 = L2_84[L7_89]
        L8_90 = A1_83[L6_88]
        L8_90 = L8_90.code
        L9_91 = A1_83[L6_88]
        L7_89[L8_90] = L9_91
      else
        L7_89 = A1_83[L6_88]
        L7_89 = L7_89.type
        L8_90 = {}
        L2_84[L7_89] = L8_90
        L7_89 = A1_83[L6_88]
        L7_89 = L7_89.type
        L7_89 = L2_84[L7_89]
        L8_90 = A1_83[L6_88]
        L8_90 = L8_90.code
        L9_91 = {}
        L7_89[L8_90] = L9_91
        L7_89 = A1_83[L6_88]
        L7_89 = L7_89.type
        L7_89 = L2_84[L7_89]
        L8_90 = A1_83[L6_88]
        L8_90 = L8_90.code
        L9_91 = A1_83[L6_88]
        L7_89[L8_90] = L9_91
      end
    end
  end
  return L2_84
end
function class.AddDupiTreaTip(A0_92, A1_93)
  local L2_94, L3_95, L4_96, L5_97, L6_98, L7_99, L8_100, L9_101, L10_102, L11_103, L12_104
  if not A1_93 then
    return
  end
  L2_94 = {}
  L3_95 = {}
  L4_96 = {}
  function L5_97(A0_105)
    local L1_106, L2_107
    L1_106 = A0_105.type
    L2_107 = REWARDS_TYPE
    L2_107 = L2_107.HERO
    if L1_106 == L2_107 then
      L1_106 = true
      return L1_106
    end
    L1_106 = A0_105.type
    L2_107 = REWARDS_TYPE
    L2_107 = L2_107.EXP_CARD
    if L1_106 == L2_107 then
      L1_106 = true
      return L1_106
    end
    L1_106 = A0_105.type
    L2_107 = REWARDS_TYPE
    L2_107 = L2_107.COIN_CARD
    if L1_106 == L2_107 then
      L1_106 = true
      return L1_106
    end
    L1_106 = A0_105.type
    L2_107 = REWARDS_TYPE
    L2_107 = L2_107.TREASURE
    if L1_106 == L2_107 then
      L1_106 = true
      return L1_106
    end
    L1_106 = false
    return L1_106
  end
  for L9_101, L10_102 in L6_98(L7_99) do
    L11_103 = L5_97
    L12_104 = L10_102
    L11_103 = L11_103(L12_104)
    if L11_103 then
      L11_103 = Logic
      L12_104 = L11_103
      L11_103 = L11_103.Get
      L11_103 = L11_103(L12_104, "Hero")
      L12_104 = L11_103
      L11_103 = L11_103.GetHeroInfoByBaseId
      L11_103 = L11_103(L12_104, L10_102.code)
      if L11_103 then
        L12_104 = L11_103.id
        L2_94[L12_104] = L2_94[L11_103.id] and L2_94[L11_103.id] + 1 or 1
      end
    else
      L11_103 = L10_102.type
      L12_104 = "_"
      L11_103 = L11_103 .. L12_104 .. L10_102.code
      L12_104 = L3_95[L11_103]
      if L12_104 then
        L12_104 = L3_95[L11_103]
        L12_104.amount = L3_95[L11_103].amount + L10_102.amount
      else
        L3_95[L11_103] = L10_102
      end
    end
  end
  for L9_101, L10_102 in L6_98(L7_99) do
    L11_103 = Logic
    L12_104 = L11_103
    L11_103 = L11_103.Get
    L11_103 = L11_103(L12_104, "Hero")
    L12_104 = L11_103
    L11_103 = L11_103.GetHeroInfoByBaseId
    L11_103 = L11_103(L12_104, L9_101)
    L12_104 = nil
    if L11_103.card == "HERO" then
      L12_104 = TwGetStr(104250, L11_103.star) .. L11_103.name .. "*" .. L10_102
    else
      L12_104 = L11_103.name .. "*" .. L10_102
    end
    table.insert(L4_96, L12_104)
  end
  for L9_101, L10_102 in L6_98(L7_99) do
    L12_104 = A0_92
    L11_103 = A0_92.RewardTreaTip
    L11_103 = L11_103(L12_104, L10_102)
    L12_104 = table
    L12_104 = L12_104.insert
    L12_104(L4_96, L11_103)
  end
  return L7_99, L8_100
end
function class.RewardTreaTip(A0_108, A1_109)
  local L2_110, L3_111, L4_112
  if nil == A1_109 then
    L2_110 = ""
    return L2_110
  end
  L2_110 = ""
  L3_111 = A1_109.type
  L4_112 = REWARDS_TYPE
  L4_112 = L4_112.EXP
  if L3_111 ~= L4_112 then
    L3_111 = A1_109.type
  else
    if L3_111 == "EXP" then
      L3_111 = TwGetStr
      L4_112 = 103072
      L3_111 = L3_111(L4_112, A1_109.amount)
      L2_110 = L3_111
      return L2_110
  end
  else
    L3_111 = A1_109.type
    L4_112 = REWARDS_TYPE
    L4_112 = L4_112.CURRENCY
    if L3_111 ~= L4_112 then
      L3_111 = A1_109.type
    else
      if L3_111 == "CURRENCY" then
        L3_111 = TwGetStr
        L4_112 = CURRENCY_TYPE_NAME
        L4_112 = L4_112[A1_109.code]
        L3_111 = L3_111(L4_112)
        L4_112 = A1_109.amount
        L2_110 = L3_111 .. "*" .. L4_112
        return L2_110
    end
    else
      L3_111 = A1_109.type
      L4_112 = REWARDS_TYPE
      L4_112 = L4_112.ITEM
      if L3_111 ~= L4_112 then
        L3_111 = A1_109.type
      else
        if L3_111 == "ITEM" then
          return L2_110
      end
      else
        L3_111 = A1_109.type
        L4_112 = REWARDS_TYPE
        L4_112 = L4_112.EQUIP
        if L3_111 ~= L4_112 then
          L3_111 = A1_109.type
        else
          if L3_111 == "EQUIP" then
            return L2_110
        end
        else
          L3_111 = A1_109.type
          L4_112 = REWARDS_TYPE
          L4_112 = L4_112.FRAGMENT
          if L3_111 ~= L4_112 then
            L3_111 = A1_109.type
          else
            if L3_111 == "FRAGMENT" then
              L3_111 = Logic
              L4_112 = L3_111
              L3_111 = L3_111.Get
              L3_111 = L3_111(L4_112, "Compose")
              L4_112 = L3_111
              L3_111 = L3_111.kdbItemConfig
              L3_111 = L3_111(L4_112, A1_109.code)
              if L3_111 then
                L4_112 = L3_111.name
                if L4_112 then
                  L4_112 = L3_111.name
                  L2_110 = L4_112 .. "*" .. A1_109.amount
                end
              end
              return L2_110
          end
          else
            L3_111 = A1_109.type
            L4_112 = REWARDS_TYPE
            L4_112 = L4_112.HERO
            if L3_111 ~= L4_112 then
              L3_111 = A1_109.type
            else
              if L3_111 == "HERO" then
                L3_111 = KFDBGetRecord
                L4_112 = "BaseHero"
                L3_111 = L3_111(L4_112, A1_109.code)
                if L3_111 then
                  L4_112 = L3_111.name
                  if L4_112 then
                    L4_112 = TwGetStr
                    L4_112 = L4_112(104250, L3_111.star or 0)
                    L2_110 = L4_112 .. L3_111.name .. "*" .. A1_109.amount
                  end
                end
                return L2_110
            end
            else
              L3_111 = A1_109.type
              L4_112 = REWARDS_TYPE
              L4_112 = L4_112.EXP_CARD
              if L3_111 ~= L4_112 then
                L3_111 = A1_109.type
              else
                if L3_111 == "EXP_CARD" then
                  L3_111 = KFDBGetRecord
                  L4_112 = "BaseHero"
                  L3_111 = L3_111(L4_112, A1_109.code)
                  if L3_111 then
                    L4_112 = L3_111.name
                    if L4_112 then
                      L4_112 = L3_111.name
                      L2_110 = L4_112 .. "*" .. A1_109.amount
                    end
                  end
                  return L2_110
              end
              else
                L3_111 = A1_109.type
                L4_112 = REWARDS_TYPE
                L4_112 = L4_112.COIN_CARD
                if L3_111 ~= L4_112 then
                  L3_111 = A1_109.type
                else
                  if L3_111 == "COIN_CARD" then
                    L3_111 = KFDBGetRecord
                    L4_112 = "BaseHero"
                    L3_111 = L3_111(L4_112, A1_109.code)
                    if L3_111 then
                      L4_112 = L3_111.name
                      if L4_112 then
                        L4_112 = L3_111.name
                        L2_110 = L4_112 .. "*" .. A1_109.amount
                      end
                    end
                    return L2_110
                end
                else
                  L3_111 = A1_109.type
                  L4_112 = REWARDS_TYPE
                  L4_112 = L4_112.TREASURE
                  if L3_111 ~= L4_112 then
                    L3_111 = A1_109.type
                  else
                    if L3_111 == "TREASURE" then
                      L3_111 = KFDBGetRecord
                      L4_112 = "BaseHero"
                      L3_111 = L3_111(L4_112, A1_109.code)
                      if L3_111 then
                        L4_112 = L3_111.name
                        if L4_112 then
                          L4_112 = L3_111.name
                          L2_110 = L4_112 .. "*" .. A1_109.amount
                        end
                      end
                      return L2_110
                  end
                  else
                    L3_111 = A1_109.type
                    L4_112 = REWARDS_TYPE
                    L4_112 = L4_112.ACTION_POINT
                    if L3_111 ~= L4_112 then
                      L3_111 = A1_109.type
                    else
                      if L3_111 == "ACTION_POINT" then
                        L3_111 = TwGetStr
                        L4_112 = 103085
                        L3_111 = L3_111(L4_112, A1_109.amount)
                        L2_110 = L3_111
                        return L2_110
                    end
                    else
                      L3_111 = A1_109.type
                      L4_112 = REWARDS_TYPE
                      L4_112 = L4_112.VIP_TIME
                      if L3_111 ~= L4_112 then
                        L3_111 = A1_109.type
                      else
                        if L3_111 == "VIP_TIME" then
                          L3_111 = TwGetStr
                          L4_112 = 103076
                          L3_111 = L3_111(L4_112)
                          L2_110 = L3_111
                          return L2_110
                      end
                      else
                        L3_111 = A1_109.type
                        L4_112 = REWARDS_TYPE
                        L4_112 = L4_112.BUFF
                        if L3_111 ~= L4_112 then
                          L3_111 = A1_109.type
                        else
                          if L3_111 == "BUFF" then
                            return L2_110
                        end
                        else
                          L3_111 = A1_109.type
                          L4_112 = REWARDS_TYPE
                          L4_112 = L4_112.BUFF
                          if L3_111 ~= L4_112 then
                            L3_111 = A1_109.type
                          else
                            if L3_111 == "LEADERSHIP" then
                              return L2_110
                          end
                          else
                            L3_111 = A1_109.type
                            L4_112 = REWARDS_TYPE
                            L4_112 = L4_112.DEMOG_FEAT
                            if L3_111 ~= L4_112 then
                              L3_111 = A1_109.type
                            else
                              if L3_111 == "DEMOG_FEAT" then
                                L3_111 = TwGetStr
                                L4_112 = 103083
                                L3_111 = L3_111(L4_112)
                                L4_112 = "*"
                                L2_110 = L3_111 .. L4_112 .. A1_109.amount
                                return L2_110
                            end
                            else
                              L3_111 = A1_109.type
                              L4_112 = REWARDS_TYPE
                              L4_112 = L4_112.DEMOG_FRAGMENT
                              if L3_111 ~= L4_112 then
                                L3_111 = A1_109.type
                              else
                                if L3_111 == "DEMOG_FRAGMENT" then
                                  L3_111 = TwGetStr
                                  L4_112 = 103082
                                  L3_111 = L3_111(L4_112)
                                  L4_112 = "*"
                                  L2_110 = L3_111 .. L4_112 .. A1_109.amount
                                  return L2_110
                              end
                              else
                                L3_111 = A1_109.type
                                L4_112 = REWARDS_TYPE
                                L4_112 = L4_112.DEMOG_ENERGY
                                if L3_111 ~= L4_112 then
                                  L3_111 = A1_109.type
                                else
                                  if L3_111 == "DEMOG_ENERGY" then
                                    L3_111 = TwGetStr
                                    L4_112 = 103084
                                    L3_111 = L3_111(L4_112)
                                    L4_112 = "*"
                                    L2_110 = L3_111 .. L4_112 .. A1_109.amount
                                    return L2_110
                                end
                                else
                                  L3_111 = A1_109.type
                                  L4_112 = REWARDS_TYPE
                                  L4_112 = L4_112.SOUL_STONE
                                  if L3_111 ~= L4_112 then
                                    L3_111 = A1_109.type
                                  else
                                    if L3_111 == "SOUL_STONE" then
                                      L3_111 = A1_109.code
                                      if L3_111 == 0 then
                                        L3_111 = TwGetStr
                                        L4_112 = 105907
                                        L3_111 = L3_111(L4_112)
                                        L4_112 = "*"
                                        L2_110 = L3_111 .. L4_112 .. A1_109.amount
                                      else
                                        L3_111 = A1_109.code
                                        if L3_111 == 1 then
                                          L3_111 = TwGetStr
                                          L4_112 = 105913
                                          L3_111 = L3_111(L4_112)
                                          L4_112 = "*"
                                          L2_110 = L3_111 .. L4_112 .. A1_109.amount
                                        else
                                          L3_111 = A1_109.code
                                          if L3_111 == 2 then
                                            L3_111 = TwGetStr
                                            L4_112 = 105914
                                            L3_111 = L3_111(L4_112)
                                            L4_112 = "*"
                                            L2_110 = L3_111 .. L4_112 .. A1_109.amount
                                          else
                                            L3_111 = A1_109.code
                                            if L3_111 == 3 then
                                              L3_111 = TwGetStr
                                              L4_112 = 105915
                                              L3_111 = L3_111(L4_112)
                                              L4_112 = "*"
                                              L2_110 = L3_111 .. L4_112 .. A1_109.amount
                                            end
                                          end
                                        end
                                      end
                                      return L2_110
                                  end
                                  else
                                    L3_111 = A1_109.type
                                    L4_112 = REWARDS_TYPE
                                    L4_112 = L4_112.TOKEN_COIN
                                    if L3_111 == L4_112 then
                                      L3_111 = TOKEN_COIN
                                      L4_112 = A1_109.code
                                      L3_111 = L3_111[L4_112]
                                      L3_111 = L3_111 or ""
                                      L4_112 = "*"
                                      L2_110 = L3_111 .. L4_112 .. A1_109.amount
                                      return L2_110
                                    else
                                      L3_111 = A1_109.type
                                      L4_112 = REWARDS_TYPE
                                      L4_112 = L4_112.ARENA_INTEGRAL
                                      if L3_111 == L4_112 then
                                        L3_111 = TwGetStr
                                        L4_112 = 105336
                                        L3_111 = L3_111(L4_112)
                                        L4_112 = "*"
                                        L2_110 = L3_111 .. L4_112 .. A1_109.amount
                                        return L2_110
                                      else
                                        L3_111 = A1_109.type
                                        L4_112 = REWARDS_TYPE
                                        L4_112 = L4_112.TALISMAN_FRAGMENT
                                        if L3_111 == L4_112 then
                                          L3_111 = TwGetStr
                                          L4_112 = 112043
                                          L3_111 = L3_111(L4_112)
                                          L4_112 = "*"
                                          L2_110 = L3_111 .. L4_112 .. A1_109.amount
                                          return L2_110
                                        else
                                          L3_111 = A1_109.type
                                          L4_112 = REWARDS_TYPE
                                          L4_112 = L4_112.TALISMAN
                                          if L3_111 == L4_112 then
                                            L3_111 = KFDBGetRecord
                                            L4_112 = "TalismanSetting"
                                            L3_111 = L3_111(L4_112, A1_109.code)
                                            if L3_111 ~= nil then
                                              L4_112 = Logic
                                              L4_112 = L4_112.Get
                                              L4_112 = L4_112(L4_112, "Hero")
                                              L4_112 = L4_112.GetHeroInfoByBaseId
                                              L4_112 = L4_112(L4_112, L3_111.baseId)
                                              if L4_112 and L4_112.name then
                                                L2_110 = L4_112.name .. "*" .. A1_109.amount
                                                return L2_110
                                              end
                                            end
                                          else
                                            L3_111 = A1_109.type
                                            L4_112 = REWARDS_TYPE
                                            L4_112 = L4_112.MENPAI_EXP
                                            if L3_111 == L4_112 then
                                              L3_111 = TwGetStr
                                              L4_112 = 110202
                                              L3_111 = L3_111(L4_112)
                                              L4_112 = "*"
                                              L2_110 = L3_111 .. L4_112 .. A1_109.amount
                                              return L2_110
                                            else
                                              L3_111 = A1_109.type
                                              L4_112 = REWARDS_TYPE
                                              L4_112 = L4_112.EGG_HAMMER
                                              if L3_111 == L4_112 then
                                                L3_111 = TwGetStr
                                                L4_112 = 110507
                                                L3_111 = L3_111(L4_112)
                                                L4_112 = "*"
                                                L2_110 = L3_111 .. L4_112 .. A1_109.amount
                                                return L2_110
                                              else
                                                L3_111 = A1_109.type
                                                L4_112 = REWARDS_TYPE
                                                L4_112 = L4_112.BOX_KEY
                                                if L3_111 == L4_112 then
                                                  L3_111 = _UPVALUE0_
                                                  L4_112 = A1_109.code
                                                  L3_111 = L3_111[L4_112]
                                                  L3_111 = L3_111 or ""
                                                  L4_112 = "*"
                                                  L2_110 = L3_111 .. L4_112 .. A1_109.amount
                                                  return L2_110
                                                else
                                                  L3_111 = A1_109.type
                                                  L4_112 = REWARDS_TYPE
                                                  L4_112 = L4_112.TREASURE_ROOM_CURRENCY
                                                  if L3_111 == L4_112 then
                                                    L3_111 = TwGetStr
                                                    L4_112 = 110602
                                                    L3_111 = L3_111(L4_112)
                                                    L4_112 = "*"
                                                    L2_110 = L3_111 .. L4_112 .. A1_109.amount
                                                    return L2_110
                                                  else
                                                    L3_111 = A1_109.type
                                                    L4_112 = REWARDS_TYPE
                                                    L4_112 = L4_112.JIPING
                                                    if L3_111 == L4_112 then
                                                      L3_111 = TwGetStr
                                                      L4_112 = 110761
                                                      L3_111 = L3_111(L4_112)
                                                      L4_112 = "*"
                                                      L2_110 = L3_111 .. L4_112 .. A1_109.amount
                                                      return L2_110
                                                    else
                                                      L3_111 = A1_109.type
                                                      L4_112 = REWARDS_TYPE
                                                      L4_112 = L4_112.MENPAI_MONEY
                                                      if L3_111 == L4_112 then
                                                        L3_111 = TwGetStr
                                                        L4_112 = 108132
                                                        L3_111 = L3_111(L4_112)
                                                        L4_112 = "*"
                                                        L2_110 = L3_111 .. L4_112 .. A1_109.amount
                                                        return L2_110
                                                      else
                                                        L3_111 = A1_109.type
                                                        L4_112 = REWARDS_TYPE
                                                        L4_112 = L4_112.SECRETSHOP_CURRENCY
                                                        if L3_111 == L4_112 then
                                                          L3_111 = TwGetStr
                                                          L4_112 = 111146
                                                          L3_111 = L3_111(L4_112)
                                                          L4_112 = "*"
                                                          L2_110 = L3_111 .. L4_112 .. A1_109.amount
                                                          return L2_110
                                                        else
                                                          L3_111 = A1_109.type
                                                          L4_112 = REWARDS_TYPE
                                                          L4_112 = L4_112.EQUIPMENT
                                                          if L3_111 == L4_112 then
                                                            L3_111 = Logic
                                                            L4_112 = L3_111
                                                            L3_111 = L3_111.Get
                                                            L3_111 = L3_111(L4_112, "Armor")
                                                            L4_112 = L3_111
                                                            L3_111 = L3_111.getArmorInfoByBaseId
                                                            L3_111 = L3_111(L4_112, A1_109.code)
                                                            L4_112 = L3_111.name
                                                            L2_110 = L4_112 .. "*" .. A1_109.amount
                                                            return L2_110
                                                          else
                                                            L3_111 = A1_109.type
                                                            L4_112 = REWARDS_TYPE
                                                            L4_112 = L4_112.EQUIPMENT_FRAGMENT
                                                            if L3_111 == L4_112 then
                                                              L3_111 = Logic
                                                              L4_112 = L3_111
                                                              L3_111 = L3_111.Get
                                                              L3_111 = L3_111(L4_112, "Armor")
                                                              L4_112 = L3_111
                                                              L3_111 = L3_111.getArmorInfoByBaseId
                                                              L3_111 = L3_111(L4_112, A1_109.code)
                                                              L4_112 = TwGetStr
                                                              L4_112 = L4_112(111420, L3_111.name)
                                                              L2_110 = L4_112 .. "*" .. A1_109.amount
                                                              return L2_110
                                                            else
                                                              L3_111 = A1_109.type
                                                              L4_112 = REWARDS_TYPE
                                                              L4_112 = L4_112.EQUIPMENT_MATERIAL
                                                              if L3_111 == L4_112 then
                                                                L3_111 = A1_109.code
                                                                if L3_111 == 0 then
                                                                  L3_111 = TwGetStr
                                                                  L4_112 = 111417
                                                                  L3_111 = L3_111(L4_112)
                                                                  L4_112 = "*"
                                                                  L2_110 = L3_111 .. L4_112 .. A1_109.amount
                                                                else
                                                                  L3_111 = A1_109.code
                                                                  if L3_111 == 1 then
                                                                    L3_111 = TwGetStr
                                                                    L4_112 = 111418
                                                                    L3_111 = L3_111(L4_112)
                                                                    L4_112 = "*"
                                                                    L2_110 = L3_111 .. L4_112 .. A1_109.amount
                                                                  else
                                                                    L3_111 = A1_109.code
                                                                    if L3_111 == 2 then
                                                                      L3_111 = TwGetStr
                                                                      L4_112 = 111454
                                                                      L3_111 = L3_111(L4_112)
                                                                      L4_112 = "*"
                                                                      L2_110 = L3_111 .. L4_112 .. A1_109.amount
                                                                    end
                                                                  end
                                                                end
                                                                return L2_110
                                                              else
                                                                L3_111 = A1_109.type
                                                                L4_112 = REWARDS_TYPE
                                                                L4_112 = L4_112.FOOTBALL
                                                                if L3_111 == L4_112 then
                                                                  L3_111 = TwGetStr
                                                                  L4_112 = 111660
                                                                  L3_111 = L3_111(L4_112)
                                                                  L4_112 = "*"
                                                                  L2_110 = L3_111 .. L4_112 .. A1_109.amount
                                                                  return L2_110
                                                                else
                                                                  L3_111 = A1_109.type
                                                                  L4_112 = REWARDS_TYPE
                                                                  L4_112 = L4_112.MOON
                                                                  if L3_111 == L4_112 then
                                                                    L3_111 = _UPVALUE1_
                                                                    L4_112 = A1_109
                                                                    L3_111 = L3_111(L4_112)
                                                                    L2_110 = L3_111
                                                                    return L2_110
                                                                  else
                                                                    L3_111 = A1_109.type
                                                                    L4_112 = REWARDS_TYPE
                                                                    L4_112 = L4_112.MONOPOLY
                                                                    if L3_111 == L4_112 then
                                                                      L3_111 = TwGetStr
                                                                      L4_112 = A1_109.code
                                                                      L4_112 = 115068 + L4_112
                                                                      L3_111 = L3_111(L4_112)
                                                                      L4_112 = "*"
                                                                      L2_110 = L3_111 .. L4_112 .. A1_109.amount
                                                                      return L2_110
                                                                    else
                                                                      L3_111 = A1_109.type
                                                                      L4_112 = REWARDS_TYPE
                                                                      L4_112 = L4_112.TALISMAN_LIEBI
                                                                      if L3_111 == L4_112 then
                                                                        L3_111 = TwGetStr
                                                                        L4_112 = 112054
                                                                        L3_111 = L3_111(L4_112)
                                                                        L4_112 = "*"
                                                                        L2_110 = L3_111 .. L4_112 .. A1_109.amount
                                                                        return L2_110
                                                                      else
                                                                        L3_111 = A1_109.type
                                                                        L4_112 = REWARDS_TYPE
                                                                        L4_112 = L4_112.SLOT_LOTTERY_TIMES
                                                                        if L3_111 == L4_112 then
                                                                          L3_111 = TwGetStr
                                                                          L4_112 = 115106
                                                                          L3_111 = L3_111(L4_112)
                                                                          L4_112 = "*"
                                                                          L2_110 = L3_111 .. L4_112 .. A1_109.amount
                                                                          return L2_110
                                                                        else
                                                                          L3_111 = A1_109.type
                                                                          L4_112 = REWARDS_TYPE
                                                                          L4_112 = L4_112.SWEET
                                                                          if L3_111 == L4_112 then
                                                                            L3_111 = A1_109.code
                                                                            if L3_111 == 0 then
                                                                              L3_111 = TwGetStr
                                                                              L4_112 = 108260
                                                                              L3_111 = L3_111(L4_112)
                                                                              L4_112 = "*"
                                                                              L2_110 = L3_111 .. L4_112 .. A1_109.amount
                                                                            else
                                                                              L3_111 = A1_109.code
                                                                              if L3_111 == 1 then
                                                                                L3_111 = TwGetStr
                                                                                L4_112 = 108258
                                                                                L3_111 = L3_111(L4_112)
                                                                                L4_112 = "*"
                                                                                L2_110 = L3_111 .. L4_112 .. A1_109.amount
                                                                              else
                                                                                L3_111 = A1_109.code
                                                                                if L3_111 == 2 then
                                                                                  L3_111 = TwGetStr
                                                                                  L4_112 = 108259
                                                                                  L3_111 = L3_111(L4_112)
                                                                                  L4_112 = "*"
                                                                                  L2_110 = L3_111 .. L4_112 .. A1_109.amount
                                                                                else
                                                                                  L3_111 = A1_109.code
                                                                                  if L3_111 == 3 then
                                                                                    L3_111 = TwGetStr
                                                                                    L4_112 = 108263
                                                                                    L3_111 = L3_111(L4_112)
                                                                                    L4_112 = "*"
                                                                                    L2_110 = L3_111 .. L4_112 .. A1_109.amount
                                                                                  else
                                                                                    L3_111 = _UPVALUE2_
                                                                                    L4_112 = A1_109.code
                                                                                    L3_111 = L3_111[L4_112]
                                                                                    if L3_111 ~= nil then
                                                                                      L3_111 = _UPVALUE2_
                                                                                      L4_112 = A1_109.code
                                                                                      L3_111 = L3_111[L4_112]
                                                                                      L4_112 = "*"
                                                                                      L2_110 = L3_111 .. L4_112 .. A1_109.amount
                                                                                    end
                                                                                  end
                                                                                end
                                                                              end
                                                                            end
                                                                            return L2_110
                                                                          else
                                                                            L3_111 = A1_109.type
                                                                            L4_112 = REWARDS_TYPE
                                                                            L4_112 = L4_112.CULTIVATE_ELIXIR
                                                                            if L3_111 == L4_112 then
                                                                              L3_111 = Logic
                                                                              L4_112 = L3_111
                                                                              L3_111 = L3_111.Get
                                                                              L3_111 = L3_111(L4_112, "Cultivate")
                                                                              L4_112 = L3_111
                                                                              L3_111 = L3_111.GetPillInfoByBaseId
                                                                              L3_111 = L3_111(L4_112, A1_109.code)
                                                                              L4_112 = TwGetStr
                                                                              L4_112 = L4_112(114102)
                                                                              L2_110 = L4_112 .. " " .. L3_111.name .. "*" .. A1_109.amount
                                                                              return L2_110
                                                                            else
                                                                              L3_111 = A1_109.type
                                                                              L4_112 = REWARDS_TYPE
                                                                              L4_112 = L4_112.CULTIVATE_MATERIAL
                                                                              if L3_111 == L4_112 then
                                                                                L3_111 = Logic
                                                                                L4_112 = L3_111
                                                                                L3_111 = L3_111.Get
                                                                                L3_111 = L3_111(L4_112, "Cultivate")
                                                                                L4_112 = L3_111
                                                                                L3_111 = L3_111.GetStuffInfoByBaseId
                                                                                L3_111 = L3_111(L4_112, A1_109.code)
                                                                                L4_112 = TwGetStr
                                                                                L4_112 = L4_112(114102)
                                                                                L2_110 = L4_112 .. " " .. L3_111.name .. "*" .. A1_109.amount
                                                                                return L2_110
                                                                              else
                                                                                L3_111 = A1_109.type
                                                                                L4_112 = REWARDS_TYPE
                                                                                L4_112 = L4_112.TURKEY
                                                                                if L3_111 == L4_112 then
                                                                                  L3_111 = A1_109.code
                                                                                  if L3_111 == 0 then
                                                                                    L3_111 = TwGetStr
                                                                                    L4_112 = 108764
                                                                                    L3_111 = L3_111(L4_112)
                                                                                    L4_112 = "*"
                                                                                    L2_110 = L3_111 .. L4_112 .. A1_109.amount
                                                                                  else
                                                                                    L3_111 = A1_109.code
                                                                                    if L3_111 == 1 then
                                                                                      L3_111 = TwGetStr
                                                                                      L4_112 = 108765
                                                                                      L3_111 = L3_111(L4_112)
                                                                                      L4_112 = "*"
                                                                                      L2_110 = L3_111 .. L4_112 .. A1_109.amount
                                                                                    else
                                                                                      L3_111 = A1_109.code
                                                                                      if L3_111 == 2 then
                                                                                        L3_111 = TwGetStr
                                                                                        L4_112 = 108766
                                                                                        L3_111 = L3_111(L4_112)
                                                                                        L4_112 = "*"
                                                                                        L2_110 = L3_111 .. L4_112 .. A1_109.amount
                                                                                      end
                                                                                    end
                                                                                  end
                                                                                  return L2_110
                                                                                else
                                                                                  L3_111 = A1_109.type
                                                                                  L4_112 = REWARDS_TYPE
                                                                                  L4_112 = L4_112.EXPLORE_NPC_EXP
                                                                                  if L3_111 == L4_112 then
                                                                                    L3_111 = TwGetStr
                                                                                    L4_112 = 115235
                                                                                    L3_111 = L3_111(L4_112)
                                                                                    L4_112 = "*"
                                                                                    L2_110 = L3_111 .. L4_112 .. A1_109.amount
                                                                                    return L2_110
                                                                                  else
                                                                                    L3_111 = A1_109.type
                                                                                    L4_112 = REWARDS_TYPE
                                                                                    L4_112 = L4_112.NEW_MONOPOLY
                                                                                    if L3_111 == L4_112 then
                                                                                      L3_111 = {}
                                                                                      L4_112 = TwGetStr
                                                                                      L4_112 = L4_112(115068)
                                                                                      L3_111[0] = L4_112
                                                                                      L4_112 = TwGetStr
                                                                                      L4_112 = L4_112(115069)
                                                                                      L3_111[1] = L4_112
                                                                                      L4_112 = TwGetStr
                                                                                      L4_112 = L4_112(115070)
                                                                                      L3_111[2] = L4_112
                                                                                      L4_112 = TwGetStr
                                                                                      L4_112 = L4_112(115370)
                                                                                      L3_111[3] = L4_112
                                                                                      L4_112 = A1_109.code
                                                                                      L4_112 = L3_111[L4_112]
                                                                                      L4_112 = L4_112 or ""
                                                                                      L2_110 = L4_112 .. "*" .. A1_109.amount
                                                                                      return L2_110
                                                                                    else
                                                                                      return L2_110
                                                                                    end
                                                                                  end
                                                                                end
                                                                              end
                                                                            end
                                                                          end
                                                                        end
                                                                      end
                                                                    end
                                                                  end
                                                                end
                                                              end
                                                            end
                                                          end
                                                        end
                                                      end
                                                    end
                                                  end
                                                end
                                              end
                                            end
                                          end
                                        end
                                      end
                                    end
                                  end
                                end
                              end
                            end
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end
function class.GetRewardsStr(A0_113, A1_114)
  local L2_115, L3_116
  if A1_114 ~= nil then
    L2_115 = type
    L3_116 = A1_114
    L2_115 = L2_115(L3_116)
    if L2_115 == "table" then
      L2_115 = next
      L3_116 = A1_114
      L2_115 = L2_115(L3_116)
    end
  elseif L2_115 == nil then
    L2_115 = ""
    return L2_115
  end
  L2_115 = A1_114.type
  L3_116 = REWARDS_TYPE
  L3_116 = L3_116.EXP
  if L2_115 ~= L3_116 then
    L2_115 = A1_114.type
  else
    if L2_115 == "EXP" then
      L2_115 = TwGetStr
      L3_116 = 102100
      return L2_115(L3_116, A1_114.amount)
  end
  else
    L2_115 = A1_114.type
    L3_116 = REWARDS_TYPE
    L3_116 = L3_116.CURRENCY
    if L2_115 ~= L3_116 then
      L2_115 = A1_114.type
    else
      if L2_115 == "CURRENCY" then
        L2_115 = ""
        L3_116 = CURRENCY_TYPE_NAME
        L3_116 = L3_116[A1_114.code]
        if L3_116 then
          L3_116 = string
          L3_116 = L3_116.format
          L3_116 = L3_116("%s*%d", TwGetStr(CURRENCY_TYPE_NAME[A1_114.code]) or "", A1_114.amount or 0)
          L2_115 = L3_116
        end
        return L2_115
    end
    else
      L2_115 = A1_114.type
      L3_116 = REWARDS_TYPE
      L3_116 = L3_116.ITEM
      if L2_115 ~= L3_116 then
        L2_115 = A1_114.type
        if L2_115 ~= "ITEM" then
          L2_115 = A1_114.type
          L3_116 = REWARDS_TYPE
          L3_116 = L3_116.FRAGMENT
          if L2_115 ~= L3_116 then
            L2_115 = A1_114.type
          end
        end
      else
        if L2_115 == "FRAGMENT" then
          L2_115 = KFDBGetRecord
          L3_116 = "ItemConfig"
          L2_115 = L2_115(L3_116, A1_114.code)
          L3_116 = ""
          if L2_115 and L2_115.name then
            L3_116 = string.format("%s%s%s", L3_116, L2_115.name, TwGetStr(101201, A1_114.amount) or 0)
          end
          return L3_116
      end
      else
        L2_115 = A1_114.type
        if L2_115 ~= "HERO" then
          L2_115 = A1_114.type
          L3_116 = REWARDS_TYPE
          L3_116 = L3_116.HERO
          if L2_115 ~= L3_116 then
            L2_115 = A1_114.type
            if L2_115 ~= "TREASURE" then
              L2_115 = A1_114.type
              L3_116 = REWARDS_TYPE
              L3_116 = L3_116.TREASURE
              if L2_115 ~= L3_116 then
                L2_115 = A1_114.type
                if L2_115 ~= "SKILL_CARD" then
                  L2_115 = A1_114.type
                  L3_116 = REWARDS_TYPE
                  L3_116 = L3_116.SKILL_CARD
                  if L2_115 ~= L3_116 then
                    L2_115 = A1_114.type
                    if L2_115 ~= "COIN_CARD" then
                      L2_115 = A1_114.type
                      L3_116 = REWARDS_TYPE
                      L3_116 = L3_116.COIN_CARD
                      if L2_115 ~= L3_116 then
                        L2_115 = A1_114.type
                        if L2_115 ~= "EXP_CARD" then
                          L2_115 = A1_114.type
                          L3_116 = REWARDS_TYPE
                          L3_116 = L3_116.EXP_CARD
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        else
          if L2_115 == L3_116 then
            L2_115 = KFDBGetRecord
            L3_116 = "BaseHero"
            L2_115 = L2_115(L3_116, A1_114.code)
            L3_116 = ""
            if L2_115 and L2_115.name then
              L3_116 = L2_115.name .. TwGetStr(101201, 1)
            end
            return L3_116
        end
        else
          L2_115 = A1_114.type
          L3_116 = REWARDS_TYPE
          L3_116 = L3_116.ACTION_POINT
          if L2_115 ~= L3_116 then
            L2_115 = A1_114.type
          else
            if L2_115 == "ACTION_POINT" then
              L2_115 = TwGetStr
              L3_116 = 103073
              return L2_115(L3_116, A1_114.amount or 0)
          end
          else
            L2_115 = A1_114.type
            if L2_115 ~= "BUFF" then
              L2_115 = A1_114.type
              L3_116 = REWARDS_TYPE
              L3_116 = L3_116.BUFF
            else
              if L2_115 == L3_116 then
                L2_115 = KFDBGetRecord
                L3_116 = "BuffEffect"
                L2_115 = L2_115(L3_116, A1_114.content or A1_114.contents)
                L3_116 = L2_115 and L2_115.skill_desc
                return L3_116
            end
            else
              L2_115 = A1_114.type
              if L2_115 ~= "LEADERSHIP" then
                L2_115 = A1_114.type
                L3_116 = REWARDS_TYPE
                L3_116 = L3_116.LEADERSHIP
              else
                if L2_115 == L3_116 then
                  L2_115 = TwGetStr
                  L3_116 = 102130
                  return L2_115(L3_116, A1_114.amount or 0)
              end
              else
                L2_115 = A1_114.type
                if L2_115 ~= "DEMOG_FEAT" then
                  L2_115 = A1_114.type
                  L3_116 = REWARDS_TYPE
                  L3_116 = L3_116.DEMOG_FEAT
                else
                  if L2_115 == L3_116 then
                    L2_115 = ""
                    L3_116 = TwGetStr
                    L3_116 = L3_116(103083)
                    L2_115 = L3_116 .. "*" .. A1_114.amount
                    return L2_115
                end
                else
                  L2_115 = A1_114.type
                  if L2_115 ~= "DEMOG_FRAGMENT" then
                    L2_115 = A1_114.type
                    L3_116 = REWARDS_TYPE
                    L3_116 = L3_116.DEMOG_FRAGMENT
                  else
                    if L2_115 == L3_116 then
                      L2_115 = ""
                      L3_116 = TwGetStr
                      L3_116 = L3_116(103082)
                      L2_115 = L3_116 .. "*" .. A1_114.amount
                      return L2_115
                  end
                  else
                    L2_115 = A1_114.type
                    if L2_115 ~= "DEMOG_ENERGY" then
                      L2_115 = A1_114.type
                      L3_116 = REWARDS_TYPE
                      L3_116 = L3_116.DEMOG_ENERGY
                    else
                      if L2_115 == L3_116 then
                        L2_115 = ""
                        L3_116 = TwGetStr
                        L3_116 = L3_116(103084)
                        L2_115 = L3_116 .. "*" .. A1_114.amount
                        return L2_115
                    end
                    else
                      L2_115 = A1_114.type
                      L3_116 = REWARDS_TYPE
                      L3_116 = L3_116.SOUL_STONE
                      if L2_115 ~= L3_116 then
                        L2_115 = A1_114.type
                      else
                        if L2_115 == "SOUL_STONE" then
                          L2_115 = ""
                          L3_116 = A1_114.code
                          if L3_116 == 0 then
                            L3_116 = TwGetStr
                            L3_116 = L3_116(105907)
                            L2_115 = L3_116 .. "*" .. A1_114.amount
                          else
                            L3_116 = A1_114.code
                            if L3_116 == 1 then
                              L3_116 = TwGetStr
                              L3_116 = L3_116(105913)
                              L2_115 = L3_116 .. "*" .. A1_114.amount
                            else
                              L3_116 = A1_114.code
                              if L3_116 == 2 then
                                L3_116 = TwGetStr
                                L3_116 = L3_116(105914)
                                L2_115 = L3_116 .. "*" .. A1_114.amount
                              else
                                L3_116 = A1_114.code
                                if L3_116 == 3 then
                                  L3_116 = TwGetStr
                                  L3_116 = L3_116(105915)
                                  L2_115 = L3_116 .. "*" .. A1_114.amount
                                end
                              end
                            end
                          end
                          return L2_115
                      end
                      else
                        L2_115 = A1_114.type
                        L3_116 = REWARDS_TYPE
                        L3_116 = L3_116.MOON
                        if L2_115 ~= L3_116 then
                          L2_115 = A1_114.type
                        else
                          if L2_115 == "MOON" then
                            L2_115 = _UPVALUE0_
                            L3_116 = A1_114
                            L2_115 = L2_115(L3_116)
                            return L2_115
                        end
                        else
                          L2_115 = A1_114.type
                          L3_116 = REWARDS_TYPE
                          L3_116 = L3_116.TURKEY
                          if L2_115 ~= L3_116 then
                            L2_115 = A1_114.type
                          else
                            if L2_115 == "TURKEY" then
                              L2_115 = ""
                              L3_116 = A1_114.code
                              if L3_116 == 0 then
                                L3_116 = TwGetStr
                                L3_116 = L3_116(108764)
                                L2_115 = L3_116 .. "*" .. A1_114.amount
                              else
                                L3_116 = A1_114.code
                                if L3_116 == 1 then
                                  L3_116 = TwGetStr
                                  L3_116 = L3_116(108765)
                                  L2_115 = L3_116 .. "*" .. A1_114.amount
                                else
                                  L3_116 = A1_114.code
                                  if L3_116 == 2 then
                                    L3_116 = TwGetStr
                                    L3_116 = L3_116(108766)
                                    L2_115 = L3_116 .. "*" .. A1_114.amount
                                  end
                                end
                              end
                              return L2_115
                          end
                          else
                            L2_115 = ""
                            return L2_115
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end
function class.PushRewardsTips(A0_117, A1_118)
  local L2_119, L3_120, L4_121, L5_122, L6_123, L7_124
  L2_119 = ""
  if L3_120 then
    for L6_123, L7_124 in L3_120(L4_121) do
      if L2_119 and L2_119 ~= "" then
        L2_119 = L2_119 .. ","
      end
      if A0_117:RewardTreaTip(L7_124) ~= nil and A0_117:RewardTreaTip(L7_124) ~= "" then
        L2_119 = L2_119 .. A0_117:RewardTreaTip(L7_124)
      end
      if L7_124.type == "BUFF" or L7_124.type == REWARDS_TYPE.BUFF then
        break
      end
    end
  else
    L2_119 = L3_120
  end
  L5_122 = L2_119 or ""
  L3_120(L4_121, L5_122)
  if L3_120 ~= nil then
  elseif not L3_120 then
    L7_124 = A0_117
    L6_123 = A0_117.Event
    L7_124 = L6_123(L7_124, "showCloseTime")
    L3_120(L4_121, L5_122, L6_123, L7_124, L6_123(L7_124, "showCloseTime"))
    L3_120(L4_121, L5_122)
    A0_117.bShow = true
  end
end
function class.showCloseTime(A0_125)
  A0_125:EventTracer():Cancel("showCloseTime")
  A0_125.bShow = false
  Logic:Get("SureConfirm"):FireEvent(Logic.SureConfirm.EVT.CLOSE_POPTIP)
end
function class.IsActionPoint(A0_126, A1_127)
  if table.empty(A1_127 or {}) then
    return false
  end
  if A1_127.type ~= REWARDS_TYPE.ACTION_POINT then
    return false
  end
  return A1_127.code == 0
end
function class.mergeRewards(A0_128, A1_129)
  local L2_130
  if A1_129 ~= nil then
    L2_130 = table
    L2_130 = L2_130.empty
    L2_130 = L2_130(A1_129)
  elseif L2_130 then
    return
  end
  L2_130 = {}
  for _FORV_6_, _FORV_7_ in ipairs(A1_129) do
    if L2_130[_FORV_7_.type .. _FORV_7_.code] then
      L2_130[_FORV_7_.type .. _FORV_7_.code].amount = L2_130[_FORV_7_.type .. _FORV_7_.code].amount + _FORV_7_.amount
    else
      L2_130[_FORV_7_.type .. _FORV_7_.code] = _FORV_7_
    end
  end
  return table.values(L2_130)
end
function class.GetIconByReward(A0_131, A1_132)
  local L2_133, L3_134, L4_135, L5_136, L6_137, L7_138, L8_139
  L2_133 = table
  L2_133 = L2_133.empty
  L3_134 = A1_132 or {}
  L2_133 = L2_133(L3_134)
  if L2_133 then
    L2_133 = {}
    return L2_133
  end
  L2_133 = {}
  for L6_137, L7_138 in L3_134(L4_135) do
    L8_139 = A0_131.GetImgByOneReward
    L8_139 = L8_139(A0_131, L7_138)
    table.insert(L2_133, L8_139)
  end
  return L2_133
end
function class.GetBgByReward(A0_140, A1_141)
  local L2_142, L3_143, L4_144, L5_145, L6_146, L7_147, L8_148
  L2_142 = table
  L2_142 = L2_142.empty
  L3_143 = A1_141 or {}
  L2_142 = L2_142(L3_143)
  if L2_142 then
    L2_142 = {}
    return L2_142
  end
  L2_142 = {}
  for L6_146, L7_147 in L3_143(L4_144) do
    L8_148 = A0_140.GetBgByOneReward
    L8_148 = L8_148(A0_140, L7_147)
    table.insert(L2_142, L8_148)
  end
  return L2_142
end
function class.GetImgByOneReward(A0_149, A1_150)
  local L2_151, L3_152, L4_153
  L2_151 = _UPVALUE0_
  L3_152 = A1_150
  L2_151 = L2_151(L3_152)
  if L2_151 then
    return L2_151
  end
  L4_153 = A0_149
  L3_152 = A0_149.createMap
  L3_152 = L3_152(L4_153, A1_150)
  L4_153 = {}
  if L3_152[A1_150.type] then
    L4_153.showType = L3_152[A1_150.type].showType[A1_150.code + 1] or ""
    L4_153.showId = L3_152[A1_150.type].showId[A1_150.code + 1] or 1
  end
  return Logic:Get("Gift"):createGoodsImg(L4_153)
end
function class.GetBgByOneReward(A0_154, A1_155)
  local L2_156, L3_157
  L3_157 = A0_154
  L2_156 = A0_154.createMap
  L2_156 = L2_156(L3_157, A1_155)
  L3_157 = {}
  if L2_156[A1_155.type] then
    L3_157.showType = L2_156[A1_155.type].showType[A1_155.code + 1] or ""
    L3_157.showId = L2_156[A1_155.type].showId[A1_155.code + 1] or 1
  end
  return Logic:Get("Gift"):createImg(L3_157)
end
function class.createMap(A0_158, A1_159)
  if table.empty(A1_159 or {}) then
    return {}
  end
  ;({})[REWARDS_TYPE.EXP] = {
    showType = {
      [A1_159.code + 1] = "EXP"
    },
    showId = {
      [A1_159.code + 1] = 4
    }
  }
  ;({})[REWARDS_TYPE.CURRENCY] = {
    showType = {
      "COPPER",
      "GOLD",
      "GOLD",
      "GOLD",
      "",
      "",
      "GOLDCARD",
      "",
      "",
      "COUPON",
      "",
      "",
      "EXPLOIT"
    },
    showId = {
      4,
      4,
      4,
      4,
      1,
      1,
      4,
      1,
      1,
      4,
      1,
      1,
      4
    }
  }
  ;({})[REWARDS_TYPE.FRAGMENT] = {
    showType = {
      [A1_159.code + 1] = "FRAGMENT"
    },
    showId = {
      [A1_159.code + 1] = A1_159.code
    }
  }
  ;({})[REWARDS_TYPE.HERO] = {
    showType = {
      [A1_159.code + 1] = "HERO"
    },
    showId = {
      [A1_159.code + 1] = A1_159.code
    }
  }
  ;({})[REWARDS_TYPE.ACTION_POINT] = {
    showType = {
      "ACTION",
      "DEMOG_ENERGY"
    },
    showId = {4, 4}
  }
  ;({})[REWARDS_TYPE.DEMOG_FRAGMENT] = {
    showType = {
      "DEMOG_FRAGMENT"
    },
    showId = {4}
  }
  ;({})[REWARDS_TYPE.SOUL_STONE] = {
    showType = {
      "SOUL_STONE",
      "SOUL_STONE_1",
      "SOUL_STONE_2",
      "SOUL_STONE_3"
    },
    showId = {
      4,
      4,
      4,
      4
    }
  }
  ;({})[REWARDS_TYPE.EXP_CARD] = {
    showType = {
      [A1_159.code + 1] = "HERO"
    },
    showId = {
      [A1_159.code + 1] = A1_159.code
    }
  }
  ;({})[REWARDS_TYPE.TREASURE] = {
    showType = {
      [A1_159.code + 1] = "HERO"
    },
    showId = {
      [A1_159.code + 1] = A1_159.code
    }
  }
  ;({})[REWARDS_TYPE.COIN_CARD] = {
    showType = {
      [A1_159.code + 1] = "HERO"
    },
    showId = {
      [A1_159.code + 1] = A1_159.code
    }
  }
  ;({})[REWARDS_TYPE.TALISMAN] = {
    showType = {
      [A1_159.code + 1] = "TALISMAN"
    },
    showId = {
      [A1_159.code + 1] = A1_159.code
    }
  }
  ;({})[REWARDS_TYPE.TALISMAN_FRAGMENT] = ({})[REWARDS_TYPE.TALISMAN]
  ;({})[REWARDS_TYPE.TOKEN_COIN] = {
    showType = {
      "TOKEN_COIN",
      "TOKEN_COIN_1",
      "TOKEN_COIN_2",
      "TOKEN_COIN_3",
      "TOKEN_COIN_4",
      "TOKEN_COIN_5",
      "TOKEN_COIN_6",
      "TOKEN_COIN_7"
    },
    showId = {
      4,
      4,
      4,
      4,
      4,
      4,
      4,
      4
    }
  }
  ;({})[REWARDS_TYPE.EGG_HAMMER] = {
    showType = {"EGG_HAMMER"},
    showId = {4}
  }
  ;({})[REWARDS_TYPE.BOX_KEY] = {
    showType = {
      "BOX_KEY_0",
      "BOX_KEY_1",
      "BOX_KEY_2"
    },
    showId = {
      4,
      4,
      4
    }
  }
  ;({})[REWARDS_TYPE.TREASURE_ROOM_CURRENCY] = {
    showType = {
      "TREASURE_ROOM_CURRENCY"
    },
    showId = {4}
  }
  ;({})[REWARDS_TYPE.JIPING] = {
    showType = {"JIPING"},
    showId = {4}
  }
  ;({})[REWARDS_TYPE.MENPAI_MONEY] = {
    showType = {
      "MENPAI_MONEY"
    },
    showId = {4}
  }
  ;({})[REWARDS_TYPE.SECRETSHOP_CURRENCY] = {
    showType = {
      [A1_159.code + 1] = "SECRETSHOP_CURRENCY"
    },
    showId = {4}
  }
  ;({})[REWARDS_TYPE.EQUIPMENT] = {
    showType = {
      [A1_159.code + 1] = "EQUIPMENT"
    },
    showId = {
      [A1_159.code + 1] = A1_159.code
    }
  }
  ;({})[REWARDS_TYPE.EQUIPMENT_FRAGMENT] = {
    showType = {
      [A1_159.code + 1] = "EQUIPMENT_FRAGMENT"
    },
    showId = {
      [A1_159.code + 1] = A1_159.code
    }
  }
  ;({})[REWARDS_TYPE.EQUIPMENT_MATERIAL] = {
    showType = {
      "PURPLE",
      "ORANGE",
      "RED"
    },
    showId = {
      4,
      6,
      7
    }
  }
  ;({})[REWARDS_TYPE.FOOTBALL] = {
    showType = {"FOOTBALL"},
    showId = {4}
  }
  ;({})[REWARDS_TYPE.MONOPOLY] = {
    showType = {"MONOPOLY"},
    showId = {4}
  }
  ;({})[REWARDS_TYPE.TALISMAN_LIEBI] = {
    showType = {
      "TALISMAN_LIEBI"
    },
    showId = {6}
  }
  ;({})[REWARDS_TYPE.SLOT_LOTTERY_TIMES] = {
    showType = {
      "SLOT_LOTTERY_TIMES"
    },
    showId = {4}
  }
  ;({})[REWARDS_TYPE.SWEET] = {
    showType = {
      "SWEET_0",
      "SWEET_1",
      "SWEET_2",
      "SWEET_3",
      "SWEET_4",
      "SWEET_5"
    },
    showId = {
      6,
      6,
      6,
      6,
      4,
      4
    }
  }
  ;({})[REWARDS_TYPE.CULTIVATE_ELIXIR] = {
    showType = {
      [A1_159.code + 1] = "CULTIVATE_ELIXIR"
    },
    showId = {
      [A1_159.code + 1] = A1_159.code
    }
  }
  ;({})[REWARDS_TYPE.CULTIVATE_MATERIAL] = {
    showType = {
      [A1_159.code + 1] = "CULTIVATE_MATERIAL"
    },
    showId = {
      [A1_159.code + 1] = A1_159.code
    }
  }
  return {}
end
