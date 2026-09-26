local L0_0, L1_1, L2_2, L3_3, L4_4, L5_5, L6_6, L7_7, L8_8, L9_9, L10_10
L0_0 = module
L1_1 = (...)
L2_2 = package
L2_2 = L2_2.seeall
L0_0(L1_1, L2_2)
L0_0 = Logic
L0_0 = L0_0.class
L1_1 = L0_0
L0_0 = L0_0.subclass
L0_0 = L0_0(L1_1)
class = L0_0
L0_0 = {}
L1_1 = class
function L2_2(A0_11)
  super.initialize(A0_11)
  Singleton(NetMsg):OnEvent(NetMsg.EVT.RECEIVE_MSG_ERROR_CODE, A0_11:Event("OnReceiveMsgErrorCode"))
end
L1_1.initialize = L2_2
L1_1 = class
function L2_2(A0_12, A1_13)
  local L2_14, L3_15, L4_16
  if nil ~= A1_13 then
    L2_14 = A1_13.code
    if nil ~= L2_14 then
      L2_14 = A1_13.code
    end
  elseif L2_14 == 0 then
    return
  end
  L2_14 = tonumber
  L3_15 = A1_13.mod
  L2_14 = L2_14(L3_15)
  if L2_14 == 11 then
    L2_14 = tonumber
    L3_15 = A1_13.cmd
    L2_14 = L2_14(L3_15)
    if L2_14 == 1 then
      L2_14 = tonumber
      L3_15 = A1_13.code
      L2_14 = L2_14(L3_15)
      if L2_14 == -22 then
        L2_14 = Logic
        L3_15 = L2_14
        L2_14 = L2_14.Get
        L4_16 = "Lottery"
        L2_14 = L2_14(L3_15, L4_16)
        L3_15 = L2_14
        L2_14 = L2_14.GetDrawData
        L2_14 = L2_14(L3_15)
        L3_15 = L2_14 and L3_15(L4_16)
        L4_16 = "\230\156\170\229\188\128\233\128\154\229\175\185\229\186\148\231\137\185\230\157\131\239\188\140\230\151\160\230\179\149\230\138\189\229\143\150\227\128\130"
        if L3_15 == 1025 then
          L4_16 = "\233\156\128\232\166\129\228\184\141\229\128\188\229\141\161\229\137\169\228\189\153\230\151\182\233\151\180300\229\164\169\228\187\165\228\184\138"
        end
        Prompt:Confirm(Logic:Get("Main"), "", L4_16, Logic:Get("Main").GotoRecharge, Prompt.PROMPT_TYPE.SELECT)
        return
      end
    end
  end
  L2_14 = tonumber
  L3_15 = A1_13.mod
  L2_14 = L2_14(L3_15)
  if L2_14 == 11 then
    L2_14 = tonumber
    L3_15 = A1_13.cmd
    L2_14 = L2_14(L3_15)
    if L2_14 == 16 then
      L2_14 = tonumber
      L3_15 = A1_13.code
      L2_14 = L2_14(L3_15)
      if L2_14 == -22 then
        L2_14 = Prompt
        L3_15 = L2_14
        L2_14 = L2_14.Fail
        L4_16 = "\233\156\128\232\166\129\229\185\180\229\141\161\230\137\141\232\131\189\230\148\185\229\144\141"
        L2_14(L3_15, L4_16)
        return
      end
    end
  end
  L2_14 = tonumber
  L3_15 = A1_13.mod
  L2_14 = L2_14(L3_15)
  if L2_14 == 11 then
    L2_14 = tonumber
    L3_15 = A1_13.cmd
    L2_14 = L2_14(L3_15)
    if L2_14 == 16 then
      L2_14 = tonumber
      L3_15 = A1_13.code
      L2_14 = L2_14(L3_15)
      if L2_14 == -20 then
        L2_14 = Prompt
        L3_15 = L2_14
        L2_14 = L2_14.Fail
        L4_16 = "7\229\164\169\229\134\133\229\143\170\232\131\189\230\148\185\228\184\128\230\172\161\229\144\141"
        L2_14(L3_15, L4_16)
        return
      end
    end
  end
  L2_14 = tonumber
  L3_15 = A1_13.mod
  L2_14 = L2_14(L3_15)
  if L2_14 == 11 then
    L2_14 = tonumber
    L3_15 = A1_13.cmd
    L2_14 = L2_14(L3_15)
    if L2_14 == 8 then
      L2_14 = tonumber
      L3_15 = A1_13.code
      L2_14 = L2_14(L3_15)
      if L2_14 == -22 then
        L2_14 = Prompt
        L3_15 = L2_14
        L2_14 = L2_14.Fail
        L4_16 = "\232\175\183\229\133\136\229\156\168\228\187\153\233\135\145\229\149\134\229\186\151\232\180\173\228\185\176\230\148\185\229\144\141"
        L2_14(L3_15, L4_16)
        return
      end
    end
  end
  L3_15 = A0_12
  L2_14 = A0_12.OnMsgResult
  L4_16 = A1_13.name
  L2_14(L3_15, L4_16, A1_13.code, A1_13.mod, A1_13.cmd)
end
L1_1.OnReceiveMsgErrorCode = L2_2
L1_1 = class
function L2_2(A0_17, A1_18, A2_19, A3_20, A4_21, A5_22)
  local L6_23, L7_24
  if 0 == A2_19 then
    L6_23 = false
    return L6_23
  end
  if nil == A1_18 then
    L6_23 = true
    return L6_23
  end
  if nil == A5_22 then
    A5_22 = true
  end
  L6_23 = _UPVALUE0_
  L7_24 = L6_23
  L6_23 = L6_23.GetCodeErrorStr
  L6_23 = L6_23(L7_24, A1_18, A2_19)
  L7_24 = L6_23 or L7_24(A2_19)
  Prompt:Fail(L7_24)
  return true
end
L1_1.OnMsgResult = L2_2
L1_1 = class
function L2_2(A0_25, A1_26, A2_27, A3_28)
  _UPVALUE0_:RecordErrorMsg(A1_26, A2_27, A3_28)
end
L1_1.RecordErrorMsg = L2_2
L1_1 = {}
L0_0.commErrorCode = L1_1
L1_1 = {}
L0_0.errorCode = L1_1
function L1_1(A0_29, A1_30, A2_31, A3_32)
  local L4_33, L5_34, L6_35, L7_36, L8_37, L9_38
  if nil == A2_31 or nil == A3_32 then
    return
  end
  for L7_36, L8_37 in L4_33(L5_34) do
    L9_38 = A3_32[L8_37]
    if L9_38 == nil then
      log4msg:warn("Undefined msg error [%s-%s]", A1_30, L8_37)
    elseif type(L9_38) ~= "number" then
      log4msg:warn("Msg error id is not a number: [%s-%s]", A1_30 and A1_30 or "<nil>", L9_38)
    end
    if nil ~= L9_38 then
      if nil == A1_30 then
        _UPVALUE0_.commErrorCode[L7_36] = L9_38
      else
        _UPVALUE0_.errorCode[_UPVALUE0_:MakeKey(A1_30, L7_36)] = L9_38
      end
    end
  end
end
L0_0.RecordErrorMsg = L1_1
function L1_1(A0_39, A1_40, A2_41)
  if _UPVALUE0_.commErrorCode[A2_41] then
    return _UPVALUE0_.commErrorCode[A2_41]
  end
  return _UPVALUE0_.errorCode[_UPVALUE0_:MakeKey(A1_40, A2_41)] or A1_40 .. " " .. TwGetStr(10076, A2_41)
end
L0_0.GetCodeErrorStr = L1_1
function L1_1(A0_42, A1_43, A2_44)
  return A1_43 .. A2_44
end
L0_0.MakeKey = L1_1
L1_1 = Enum
L2_2 = TypeDef
L3_3 = "com.eyu.mt.module.reward.facade.RewardResult"
L10_10 = L2_2(L3_3)
L1_1 = L1_1(L2_2, L3_3, L4_4, L5_5, L6_6, L7_7, L8_8, L9_9, L10_10, L2_2(L3_3))
L2_2 = {}
L2_2.SPACE_NOT_ENOUGH = 10045
L2_2.INVALID_REWARD = 10032
L2_2.INVALID_CODE = 10033
L2_2.INVALID_AMOUNT = 10034
L2_2.TREASURE_SPACE_FULL = 10082
L4_4 = L0_0
L3_3 = L0_0.RecordErrorMsg
L5_5 = nil
L6_6 = L1_1
L7_7 = L2_2
L3_3(L4_4, L5_5, L6_6, L7_7)
L3_3 = Enum
L4_4 = TypeDef
L5_5 = "com.eyu.mt.module.currency.facade.CurrencyResult"
L10_10 = L4_4(L5_5)
L3_3 = L3_3(L4_4, L5_5, L6_6, L7_7, L8_8, L9_9, L10_10, L4_4(L5_5))
L4_4 = {}
L4_4.COPPER_NOT_ENOUGH = 10035
L4_4.COST_INVALID_TYPE = 10083
L4_4.COST_INVALID_VALUE = 10084
L4_4.COST_VALUE_NOT_ENOUGH = 10085
L4_4.CURRENCY_NOT_ENOUGH = 10040
L4_4.DONATE_NOT_ENOUGH = 10041
L4_4.EXCHANGE_NOT_ENOUGH = 10086
L4_4.GIFT_NOT_ENOUGH = 10037
L4_4.GOLD_NOT_ENOUGH = 10036
L4_4.HONOUR_NOT_ENOUGH = 10087
L4_4.INTER_NOT_ENOUGH = 10038
L4_4.JADE_NOT_ENOUGH = 10039
L6_6 = L0_0
L5_5 = L0_0.RecordErrorMsg
L7_7 = nil
L8_8 = L3_3
L9_9 = L4_4
L5_5(L6_6, L7_7, L8_8, L9_9)
L5_5 = Enum
L6_6 = TypeDef
L7_7 = "com.eyu.mt.module.cost.facade.CostResult"
L10_10 = L6_6(L7_7)
L5_5 = L5_5(L6_6, L7_7, L8_8, L9_9, L10_10, L6_6(L7_7))
L6_6 = {}
L6_6.TENCENT_OPERATE_FAILED = 113001
L6_6.BATTLE_COUNT_ENOUGH = 113002
L6_6.HERO_NOT_ENOUGH = 113003
L6_6.HERO_NOT_FOUND = 113004
L6_6.NOT_SUPPORT = 113005
L6_6.GROW_NOT_ENOUGH = 113006
L6_6.TREASURE_REPEAT = 113007
L6_6.TREASURE_NOT_FOUND = 113008
L6_6.TREASURE_FORMAT_INVALID = 113009
L6_6.COST_INVALID_AMOUNT = 113010
L6_6.CURRENCY_NOT_ENOUGH = 113011
L6_6.COST_ITEM_NOT_FOUND = 113012
L6_6.MANAGE_NOT_EXIT = 113013
L6_6.AMOUNT_NOT_ENOUGH = 113014
L8_8 = L0_0
L7_7 = L0_0.RecordErrorMsg
L9_9 = nil
L10_10 = L5_5
L7_7(L8_8, L9_9, L10_10, L6_6)
L7_7 = Enum
L8_8 = TypeDef
L9_9 = "com.eyu.mt.module.point.facade.ActionPointResult"
L10_10 = L8_8(L9_9)
L7_7 = L7_7(L8_8, L9_9, L10_10, L8_8(L9_9))
L8_8 = {}
L8_8.NOT_ENOUGHT = 10077
L8_8.BUY_LIMIT = 10078
L8_8.POINT_FULL_LIMIT = 10081
L10_10 = L0_0
L9_9 = L0_0.RecordErrorMsg
L9_9(L10_10, nil, L7_7, L8_8)
L9_9 = Enum
L10_10 = TypeDef
L10_10 = L10_10("com.eyu.mt.module.common.facade.CommonResult")
L9_9 = L9_9(L10_10, L10_10("com.eyu.mt.module.common.facade.CommonResult"))
L10_10 = {}
L10_10.LOCKED = 10107
L0_0:RecordErrorMsg(nil, L9_9, L10_10)
