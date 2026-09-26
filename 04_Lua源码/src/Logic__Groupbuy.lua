local L0_0
L0_0 = module
L0_0((...), package.seeall)
L0_0 = require
L0_0("Logic")
L0_0 = require
L0_0("MsgGroupbuy")
L0_0 = Logic
L0_0 = L0_0.class
L0_0 = L0_0.subclass
L0_0 = L0_0(L0_0)
class = L0_0
L0_0 = Enum
L0_0 = L0_0({
  "REFRESH_LOAD_REWARD_INFO",
  "REFRESH_TIP",
  "REFRESH_AFFTER_GET_FIT",
  "REFRESH_TIP_NEW_REWARD"
})
EVT = L0_0
L0_0 = Enum
L0_0 = L0_0(TypeDef("com.eyu.mt.module.groupbuy.facade.GroupbuyResult"))
function class.initialize(A0_1)
  super.initialize(A0_1)
  A0_1.loadRewardInfoVo = {}
  A0_1.rewardId = 0
  Logic:Get("MsgAssist"):RecordErrorMsg("MsgGroupbuy", _UPVALUE0_, _UPVALUE1_)
  MsgGroupbuy:On("GET_REWARD", A0_1:Event("OnGetReward"))
  MsgGroupbuy:On("LOAD_REWARD_INFO", A0_1:Event("OnLoadRewardInfo"))
end
function class.PostGetReward(A0_2, A1_3)
  MsgGroupbuy:Post("GET_REWARD", {baseId = A1_3})
end
function class.OnGetReward(A0_4, A1_5, A2_6)
  local L3_7
  if A1_5 == 0 then
    L3_7 = Logic
    L3_7 = L3_7.Get
    L3_7 = L3_7(L3_7, "BGSound")
    L3_7 = L3_7.PlayEffect
    L3_7(L3_7, "audio/gift.mp3")
    L3_7 = Logic
    L3_7 = L3_7.Get
    L3_7 = L3_7(L3_7, "Reward")
    L3_7 = L3_7.AddRewards
    L3_7(L3_7, A2_6)
    L3_7 = Logic
    L3_7 = L3_7.Get
    L3_7 = L3_7(L3_7, "Reward")
    L3_7 = L3_7.AddRewardsTip
    L3_7 = L3_7(L3_7, A2_6)
    Prompt:Confirm(nil, 0, L3_7, A0_4.PostLoadRewardInfo)
  end
end
function class.PostLoadRewardInfo(A0_8)
  MsgGroupbuy:Post("LOAD_REWARD_INFO", {})
end
function class.OnLoadRewardInfo(A0_9, A1_10, A2_11)
  if A1_10 == 0 then
    A0_9.loadRewardInfoVo = A2_11
    A0_9:FireEvent(EVT.REFRESH_TIP_NEW_REWARD)
    A0_9:FireEvent(EVT.REFRESH_LOAD_REWARD_INFO)
  end
end
function class.GetLoadRewardInfoVo(A0_12)
  local L1_13
  L1_13 = A0_12.loadRewardInfoVo
  return L1_13
end
function class.GetAllGroupKFDB(A0_14)
  local L1_15, L2_16, L3_17, L4_18, L5_19, L6_20, L7_21
  L1_15 = {}
  L2_16 = KFDBGetRecordAmt
  L2_16 = L2_16(L3_17)
  if L2_16 == nil then
    return L1_15
  end
  for L6_20 = 1, L2_16 do
    L7_21 = KFDBGetRecordByIdx
    L7_21 = L7_21("GroupbuyRewardSetting", L6_20)
    table.insert(L1_15, L7_21)
  end
  return L1_15
end
function class.GetShowGroups(A0_22, A1_23)
  local L2_24, L3_25, L4_26, L5_27, L6_28
  L2_24 = A0_22.GetAllGroupKFDB
  L2_24 = L2_24(L3_25)
  if A1_23 == nil then
    return L3_25
  end
  for L6_28 = 1, #L2_24 do
    for _FORV_10_ = 1, #A1_23 do
      if L2_24[L6_28] and L2_24[L6_28].id == A1_23[_FORV_10_] then
        table.remove(L2_24, L6_28)
      end
    end
  end
  return L2_24
end
function class.GetItemData(A0_29)
  local L1_30
  L1_30 = A0_29.GetShowGroups
  L1_30 = L1_30(A0_29, A0_29.loadRewardInfoVo.baseRewardIds)
  A0_29.loadRewardInfoVo.chargeCount = A0_29.loadRewardInfoVo.chargeCount or 0
  for _FORV_11_ = 1, #L1_30 do
    L1_30[_FORV_11_].canDraw = false
    if Logic:Get("PlayerInfo"):IsMonVip() and L1_30[_FORV_11_].userType == "MONTH" and ({
      CHARGE = A0_29.loadRewardInfoVo.chargeCount or 0,
      MONTH = A0_29.loadRewardInfoVo.monthPlayers or 0,
      WEEK = A0_29.loadRewardInfoVo.weekPlayers or 0
    })[L1_30[_FORV_11_].type] >= L1_30[_FORV_11_].count then
      L1_30[_FORV_11_].canDraw = true
    end
    if Logic:Get("PlayerInfo"):IsWeekVip() and L1_30[_FORV_11_].userType == "WEEK" and ({
      CHARGE = A0_29.loadRewardInfoVo.chargeCount or 0,
      MONTH = A0_29.loadRewardInfoVo.monthPlayers or 0,
      WEEK = A0_29.loadRewardInfoVo.weekPlayers or 0
    })[L1_30[_FORV_11_].type] >= L1_30[_FORV_11_].count then
      L1_30[_FORV_11_].canDraw = true
    end
    if (Logic:Get("PlayerInfo"):IsMonVip() or Logic:Get("PlayerInfo"):IsWeekVip()) and L1_30[_FORV_11_].userType == "ALL" and ({
      CHARGE = A0_29.loadRewardInfoVo.chargeCount or 0,
      MONTH = A0_29.loadRewardInfoVo.monthPlayers or 0,
      WEEK = A0_29.loadRewardInfoVo.weekPlayers or 0
    })[L1_30[_FORV_11_].type] >= L1_30[_FORV_11_].count then
      L1_30[_FORV_11_].canDraw = true
    end
  end
  _FOR_.sort(L1_30, function(A0_31, A1_32)
    local L2_33, L3_34
    L2_33 = A0_31.canDraw
    if L2_33 then
      L2_33 = 0
    else
      L2_33 = L2_33 or 1
    end
    L3_34 = A1_32.canDraw
    if L3_34 then
      L3_34 = 0
    else
      L3_34 = L3_34 or 1
    end
    if L2_33 == L3_34 then
      return A0_31.sort < A1_32.sort
    else
      return L2_33 < L3_34
    end
  end)
  return L1_30
end
function class.IsHasNewReward(A0_35)
  for _FORV_5_ = 1, #A0_35:GetItemData() do
    if A0_35:GetItemData()[_FORV_5_].canDraw then
      return true
    end
  end
  return _FOR_
end
