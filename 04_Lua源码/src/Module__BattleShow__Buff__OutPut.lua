local L0_0
L0_0 = module
L0_0((...), package.seeall)
L0_0 = require
L0_0 = L0_0("BattleShow.BattleDefine")
class = objectlua.Object:subclass()
function class.initialize(A0_1, A1_2, A2_3, A3_4)
  super.initialize(A0_1)
  A0_1.target = A1_2
  A0_1.layer = A2_3
  A0_1.effects = A3_4
end
function class.dispose(A0_5)
  super.dispose(A0_5)
end
function class.Set(A0_6)
  local L1_7
end
function class.Add(A0_8, A1_9, A2_10)
  local L3_11, L4_12, L5_13, L6_14, L7_15
  L3_11 = A0_8.effects
  L3_11 = L3_11.effect
  L4_12 = A0_8.effects
  L4_12 = L4_12.action
  if not L3_11 or L3_11 == "" then
    return
  end
  L5_13 = L3_11
  L6_14 = string
  L6_14 = L6_14.sub
  L7_15 = L3_11
  L6_14 = L6_14(L7_15, 1, 5)
  if L6_14 ~= "text:" then
    L6_14 = string
    L6_14 = L6_14.format
    L7_15 = "%s%s.png"
    L6_14 = L6_14(L7_15, _UPVALUE0_.COMB_PATH, L3_11)
    L5_13 = L6_14
  end
  L6_14 = A0_8.target
  L6_14 = L6_14.rootNode
  L7_15 = _UPVALUE0_
  L7_15 = L7_15.CStatus
  L7_15 = L7_15.new
  L7_15 = L7_15(L7_15, 0)
  log4battle:debug(L5_13)
  if A1_9 ~= 0 then
    _UPVALUE1_.class:new(A1_9, L6_14, L5_13, L7_15)
  end
  if A2_10 ~= 0 then
    _UPVALUE1_.class:new(A2_10, L6_14, L5_13, L7_15)
  end
  if A1_9 == 0 and A2_10 == 0 then
    _UPVALUE1_.class:new(0, L6_14, L5_13, L7_15)
  end
end
function class.Remove(A0_16)
  local L1_17
end
function class.Active(A0_18)
  local L1_19
end
function class.Cancel(A0_20)
  local L1_21
end
function class.Change(A0_22)
  local L1_23
end
function class.GetType(A0_24)
  local L1_25
  L1_25 = "OutPut"
  return L1_25
end
