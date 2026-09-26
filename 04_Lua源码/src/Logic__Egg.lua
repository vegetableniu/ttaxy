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
L0_0 = Enum
L0_0 = L0_0({
  "LOAD_EGG_INFO",
  "SMASH",
  "SMASH_FAILED",
  "ON_CONFIRM"
})
EVT = L0_0
L0_0 = TypeDef
L0_0 = L0_0("com.eyu.mt.module.egg.facade.EggResult")
function class.initialize(A0_1)
  super.initialize(A0_1)
  A0_1.eggInfo = {}
  Logic:Get("MsgAssist"):RecordErrorMsg("MsgEgg", _UPVALUE0_, _UPVALUE1_)
  MsgEgg:On("LOAD_EGG_INFO", A0_1:Event("OnLoadEggInfo"))
  MsgEgg:On("SMASH", A0_1:Event("OnSmash"), false)
end
function class.dispose(A0_2)
  super.dispose(A0_2)
end
function class.GetEggInfo(A0_3)
  local L1_4
  L1_4 = A0_3.eggInfo
  return L1_4
end
function class.IsTopReward(A0_5)
  local L1_6
  L1_6 = A0_5.bTopReward
  return L1_6
end
function class.AddHammer(A0_7, A1_8)
  local L2_9, L3_10
  L2_9 = A0_7.eggInfo
  L2_9 = L2_9.hammer
  if L2_9 then
    L2_9 = A0_7.eggInfo
    L3_10 = A0_7.eggInfo
    L3_10 = L3_10.hammer
    L3_10 = L3_10 + A1_8
    L2_9.hammer = L3_10
  end
end
function class.GetCongifValueByKey(A0_11, A1_12)
  return KFDBGetRecord("ConfigValue", A1_12) and tonumber(KFDBGetRecord("ConfigValue", A1_12).content) or 0
end
function class.IsOverTimes(A0_13, A1_14)
  if A0_13:GetCongifValueByKey("SMASH_EGG:TOTAL_SMASH") < 0 then
    return false
  end
  if table.empty(A0_13.eggInfo or {}) then
    return false
  end
  return A0_13.eggInfo.todaySmash and A0_13:GetCongifValueByKey("SMASH_EGG:TOTAL_SMASH") < A0_13.eggInfo.todaySmash + A1_14
end
function class.GetLeftSmashTime(A0_15)
  if A0_15:GetCongifValueByKey("SMASH_EGG:TOTAL_SMASH") <= 0 then
    return 0
  end
  return A0_15:GetCongifValueByKey("SMASH_EGG:TOTAL_SMASH") - A0_15.eggInfo.todaySmash
end
function class.caulateSmashCost(A0_16, A1_17)
  local L2_18, L3_19, L4_20, L5_21, L6_22, L7_23, L8_24, L9_25, L10_26, L11_27, L12_28
  L2_18 = table
  L2_18 = L2_18.empty
  L3_19 = A0_16.eggInfo
  L3_19 = L3_19 or {}
  L2_18 = L2_18(L3_19)
  if L2_18 then
    L2_18 = 0
    L3_19 = 0
    return L2_18, L3_19
  end
  L3_19 = A0_16
  L2_18 = A0_16.GetCongifValueByKey
  L4_20 = "SMASH_EGG:INIT_FREE_TIMES"
  L2_18 = L2_18(L3_19, L4_20)
  L3_19 = A0_16.eggInfo
  L3_19 = L3_19.freeSmashCount
  if L2_18 >= L3_19 then
    L3_19 = A0_16.eggInfo
    L3_19 = L3_19.freeSmashCount
    L3_19 = L2_18 - L3_19
  else
    L3_19 = L3_19 or 0
  end
  L4_20 = A0_16.eggInfo
  L4_20 = L4_20.hammer
  L4_20 = L3_19 + L4_20
  if A1_17 <= L4_20 then
    L5_21 = A1_17
    L6_22 = 0
    return L5_21, L6_22
  end
  L5_21 = A1_17 - L4_20
  L6_22 = 0
  for L10_26 = 1, L5_21 do
    L11_27 = string
    L11_27 = L11_27.format
    L12_28 = "COST_%d"
    L11_27 = L11_27(L12_28, A0_16.eggInfo.costSmashCount + L10_26)
    L12_28 = KFDBGetRecord
    L12_28 = L12_28("TodayTimesSetting", L11_27)
    if L12_28 then
      L6_22 = L6_22 + L12_28.cost
    else
      L12_28 = KFDBGetRecord("TodayTimesSetting", "COST_0")
      if L12_28 then
        L6_22 = L6_22 + L12_28.cost
      end
    end
  end
  return L7_23, L8_24
end
function class.PostLoadEggInfo(A0_29)
  MsgEgg:Post("LOAD_EGG_INFO")
end
function class.PostSmash(A0_30, A1_31)
  if nil == A1_31 then
    return
  end
  MsgEgg:Post("SMASH", {smashId = A1_31})
end
function class.OnLoadEggInfo(A0_32, A1_33, A2_34)
  if A1_33 ~= 0 then
    return
  end
  A0_32.eggInfo = A2_34
  A0_32:FireEvent(EVT.LOAD_EGG_INFO)
end
function class.OnSmash(A0_35, A1_36, A2_37)
  local L3_38, L4_39, L5_40, L6_41, L7_42, L8_43, L9_44, L10_45, L11_46, L12_47, L13_48, L14_49, L15_50
  if A1_36 ~= 0 then
    A0_35.pendingPrompt = false
    L4_39 = A0_35
    L3_38 = A0_35.FireEvent
    L5_40 = EVT
    L5_40 = L5_40.SMASH_FAILED
    L3_38(L4_39, L5_40)
    L3_38 = _UPVALUE0_
    L3_38 = L3_38.NOT_FOUNT_PLAYER_LEVEL_SECTION
    if A1_36 == L3_38 then
      L3_38 = Prompt
      L4_39 = L3_38
      L3_38 = L3_38.Fail
      L5_40 = "\229\142\134\229\143\178\231\180\175\232\174\161\230\182\136\232\180\185\232\190\190\229\136\176300\228\187\153\233\135\145\229\144\142\230\137\141\232\131\189\231\160\184\232\155\139"
      L3_38(L4_39, L5_40)
      return
    end
    L3_38 = _UPVALUE0_
    L3_38 = L3_38.ACTIVITY_IS_NOT_OPEN
    if A1_36 == L3_38 then
      L3_38 = TwGetStr
      L4_39 = 100071
      L3_38 = L3_38(L4_39)
      L4_39 = Prompt
      L5_40 = L4_39
      L4_39 = L4_39.Confirm
      L9_44 = Logic
      L10_45 = L9_44
      L9_44 = L9_44.Get
      L9_44 = L9_44(L10_45, L11_46)
      L9_44 = L9_44.GotoHomePage
      L10_45 = Prompt
      L10_45 = L10_45.PROMPT_TYPE
      L10_45 = L10_45.CONFIRM
      L4_39(L5_40, L6_41, L7_42, L8_43, L9_44, L10_45)
      return
    end
    L3_38 = Logic
    L4_39 = L3_38
    L3_38 = L3_38.Get
    L5_40 = "MsgAssist"
    L3_38 = L3_38(L4_39, L5_40)
    L4_39 = L3_38
    L3_38 = L3_38.OnMsgResult
    L5_40 = "MsgEgg"
    L3_38(L4_39, L5_40, L6_41)
    return
  end
  L3_38 = Logic
  L4_39 = L3_38
  L3_38 = L3_38.Get
  L5_40 = "Cost"
  L3_38 = L3_38(L4_39, L5_40)
  L4_39 = L3_38
  L3_38 = L3_38.AddCosts
  L5_40 = A2_37.costResult
  L3_38(L4_39, L5_40)
  L3_38 = KFDBGetRecord
  L4_39 = "ConfigValue"
  L5_40 = "SMASH_EGG:TOP_REWARD"
  L3_38 = L3_38(L4_39, L5_40)
  if L3_38 then
    L4_39 = L3_38.content
  else
    L4_39 = L4_39 or ""
  end
  A0_35.bTopReward = false
  L5_40 = {}
  for L9_44, L10_45 in L6_41(L7_42) do
    for L14_49, L15_50 in L11_46(L12_47) do
      table.insert(L5_40, L15_50)
    end
    if L4_39 == L11_46 then
      A0_35.bTopReward = true
    end
  end
  L6_41(L7_42, L8_43)
  A0_35.strTab = L6_41
  A0_35.strTab = L7_42
  A0_35.rewardsStr = L6_41
  A0_35.pendingPrompt = true
  L6_41.costSmashCount = L7_42
  L6_41.eggRewardVos = L7_42
  L6_41.freeSmashCount = L7_42
  L6_41.hammer = L7_42
  L6_41.hammerSmashCount = L7_42
  L6_41.todaySmash = L7_42
  L6_41.totalCurrency = L7_42
  L6_41.topRewardVo = L7_42
  if L6_41 then
  else
  end
  L9_44 = L6_41
  L10_45 = A0_35.Event
  L15_50 = L10_45(L11_46, L12_47)
  L7_42(L8_43, L9_44, L10_45, L11_46, L12_47, L13_48, L14_49, L15_50, L10_45(L11_46, L12_47))
  L9_44 = EVT
  L9_44 = L9_44.SMASH
  L7_42(L8_43, L9_44)
end
function class.PromptResult(A0_51)
  local L1_52
  L1_52 = A0_51.pendingPrompt
  if not L1_52 then
    return
  end
  A0_51.pendingPrompt = false
  L1_52 = A0_51.strTab
  L1_52 = #L1_52
  if L1_52 > 1 then
    L1_52 = {}
    L1_52.list = A0_51.strTab
    L1_52.func = A0_51.OnConfirm
    Prompt:TableViewConfirm(A0_51, L1_52)
  else
    L1_52 = Prompt
    L1_52 = L1_52.Confirm
    L1_52(L1_52, A0_51, "", A0_51.rewardsStr, A0_51.OnConfirm, Prompt.PROMPT_TYPE.CONFIRM)
  end
end
function class.OnConfirm(A0_53)
  A0_53:FireEvent(EVT.ON_CONFIRM)
end
function class.GetCost(A0_54, A1_55)
  local L2_56, L3_57, L4_58, L5_59, L6_60, L7_61, L8_62, L9_63
  L2_56 = table
  L2_56 = L2_56.empty
  L3_57 = A0_54.eggInfo
  L3_57 = L3_57 or {}
  L2_56 = L2_56(L3_57)
  if L2_56 then
    L2_56 = 0
    return L2_56
  end
  L2_56 = A0_54.eggInfo
  L2_56 = L2_56.hammer
  if A1_55 <= L2_56 then
    L2_56 = 0
    return L2_56
  end
  L2_56 = A0_54.eggInfo
  L2_56 = L2_56.hammer
  L2_56 = A1_55 - L2_56
  L3_57 = 0
  for L7_61 = 1, L2_56 do
    L8_62 = string
    L8_62 = L8_62.format
    L9_63 = "COST_%d"
    L8_62 = L8_62(L9_63, A0_54.eggInfo.costSmashCount + L7_61)
    L9_63 = KFDBGetRecord
    L9_63 = L9_63("TodayTimesSetting", L8_62)
    if L9_63 then
      L3_57 = L3_57 + L9_63.cost
    else
      L9_63 = KFDBGetRecord("TodayTimesSetting", "COST_0")
      if L9_63 then
        L3_57 = L3_57 + L9_63.cost
      end
    end
  end
  return L3_57
end
