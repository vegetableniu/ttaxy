local L0_0
L0_0 = module
L0_0((...), package.seeall)
L0_0 = require
L0_0("utf8")
L0_0 = require
L0_0("Logic")
L0_0 = Logic
L0_0 = L0_0.class
L0_0 = L0_0.subclass
L0_0 = L0_0(L0_0)
class = L0_0
L0_0 = TypeDef
L0_0 = L0_0("com.eyu.mt.module.dumpling.facade.DumplingResult")
DUMPLING_STATE = Enum({
  "NONE",
  "COOKING",
  "FINISHED"
})
EVT = Enum({
  "GET_COOLTIME_OK",
  "COOKING_BEGIN",
  "TIMER_EVENT",
  "COOKING_FINISHED"
})
function class.initialize(A0_1)
  super.initialize(A0_1)
  A0_1.cookingInfo = {}
  A0_1.dumplingDetails = {}
  A0_1.rewards = {}
  A0_1.hasGet = false
  A0_1.beginCookFlag = false
  A0_1.cost = 0
  Logic:Get("MsgAssist"):RecordErrorMsg("MsgDumpling", _UPVALUE0_, _UPVALUE1_)
  MsgDumpling:On("COOK_COOLTIME", A0_1:Event("OnGetCoolTime"), false)
  MsgDumpling:On("COOK", A0_1:Event("OnCookDumpling"))
  MsgDumpling:On("GET_COOK_REWARD", A0_1:Event("OnGetCookReward"))
  MsgDumpling:On("CLEAR_COOL_TIME", A0_1:Event("OnClearCoolTime"))
end
function class.dispose(A0_2)
  super.dispose(A0_2)
end
function class.OnReset(A0_3)
  local L1_4
end
function class.OnGetCoolTime(A0_5, A1_6, A2_7)
  if A1_6 ~= 0 then
    A0_5.cookingInfo = {}
    A0_5.hasGet = false
    Logic:Get("Gift"):FireEvent(Logic.Gift.EVT.REFRESH_GIFT)
    return
  end
  A0_5.cookingInfo = A2_7
  A0_5.hasGet = A2_7 ~= nil and A2_7.baseId ~= nil and 0 < A2_7.baseId and A2_7.coolTime ~= nil and A2_7.coolTime <= Logic:Get("System"):GetTime() * 1000
  if A2_7 ~= nil and A2_7.baseId ~= nil and 0 < A2_7.baseId and A2_7.coolTime ~= nil then
    A0_5:startTimer()
  end
  Logic:Get("Gift"):FireEvent(Logic.Gift.EVT.REFRESH_GIFT)
  A0_5:FireEvent(EVT.GET_COOLTIME_OK, A2_7)
end
function class.OnCookDumpling(A0_8, A1_9, A2_10)
  if A1_9 ~= 0 then
    Logic:Get("MsgAssist"):OnMsgResult("MsgDumpling", A1_9)
    return
  end
  A0_8.cookingInfo.coolTime = A2_10.coolTime
  A0_8.cookingInfo.baseId = A2_10.type
  Logic:Get("Cost"):AddCosts(A2_10.costs)
  A0_8.beginCookFlag = true
  A0_8.hasGet = false
  A0_8:startTimer()
  A0_8:FireEvent(EVT.GET_COOLTIME_OK, A2_10)
  A0_8:FireEvent(EVT.COOKING_BEGIN)
end
function class.OnGetCookReward(A0_11, A1_12, A2_13)
  local L3_14, L4_15, L5_16, L6_17, L7_18, L8_19
  if A1_12 ~= 0 then
    L3_14 = Logic
    L3_14 = L3_14.Get
    L3_14 = L3_14(L4_15, L5_16)
    L3_14 = L3_14.OnMsgResult
    L3_14(L4_15, L5_16, L6_17)
    return
  end
  L3_14 = Logic
  L3_14 = L3_14.Get
  L3_14 = L3_14(L4_15, L5_16)
  L3_14 = L3_14.AddRewards
  L3_14(L4_15, L5_16)
  L3_14 = TwGetStr
  L3_14 = L3_14(L4_15)
  for L7_18, L8_19 in L4_15(L5_16) do
    L3_14 = L3_14 .. Logic:Get("Reward"):RewardTreaTip(L8_19) .. "\n"
  end
  L4_15(L5_16, L6_17)
  A0_11.cookingInfo = L4_15
  A0_11.hasGet = false
  L4_15(L5_16, L6_17)
  L7_18 = A0_11.cookingInfo
  L4_15(L5_16, L6_17, L7_18)
end
function class.OnClearCoolTime(A0_20, A1_21, A2_22)
  if A1_21 ~= 0 then
    Logic:Get("MsgAssist"):OnMsgResult("MsgDumpling", A1_21)
    return
  end
  Logic:Get("Cost"):AddCosts(A2_22)
  A0_20.cookingInfo.coolTime = Logic:Get("System"):GetTime() * 1000
  A0_20:FireEvent(EVT.GET_COOLTIME_OK, A0_20.cookingInfo)
end
function class.PostGetCoolTime(A0_23)
  MsgDumpling:Post("COOK_COOLTIME")
end
function class.PostCookDumpling(A0_24, A1_25)
  MsgDumpling:Post("COOK", {dumpling = A1_25})
end
function class.PostGetCookReward(A0_26)
  MsgDumpling:Post("GET_COOK_REWARD")
end
function class.PostClearCoolTime(A0_27)
  MsgDumpling:Post("CLEAR_COOL_TIME")
end
function class.setCoolTime(A0_28, A1_29)
  if A1_29 and A1_29 > 0 then
    A0_28.cookingInfo.coolTime = A1_29
  end
end
function class.getCookingDumpling(A0_30)
  local L1_31
  L1_31 = A0_30.cookingInfo
  return L1_31
end
function class.getDumplingDetails(A0_32)
  local L1_33, L2_34
  L2_34 = A0_32
  L1_33 = A0_32.getRewardsInfo
  L1_33 = L1_33(L2_34)
  L2_34 = Logic
  L2_34 = L2_34.Get
  L2_34 = L2_34(L2_34, "Hero")
  L2_34 = L2_34.GetDumplingCard
  L2_34 = L2_34(L2_34)
  L2_34 = L2_34 or {}
  L2_34 = Logic:Get("Hero"):GetHeroInfosByIds(L2_34)
  table.sort(L1_33, function(A0_35, A1_36)
    return A0_35.baseId < A1_36.baseId
  end)
  for _FORV_7_, _FORV_8_ in pairs(L2_34) do
    ({})[_FORV_8_.baseId] = ({})[_FORV_8_.baseId] or 0
    ;({})[_FORV_8_.baseId] = ({})[_FORV_8_.baseId] + 1
  end
  A0_32.dumplingDetails = {}
  for _FORV_7_, _FORV_8_ in ipairs(L1_33) do
    A0_32.dumplingDetails[_FORV_7_] = A0_32.dumplingDetails[_FORV_7_] or {}
    A0_32.dumplingDetails[_FORV_7_].id = _FORV_8_.baseId
    A0_32.dumplingDetails[_FORV_7_].info = Logic:Get("Hero"):GetHeroInfoByBaseId(_FORV_8_.baseId)
    A0_32.dumplingDetails[_FORV_7_].count = ({})[_FORV_8_.baseId] or 0
  end
  return A0_32.dumplingDetails
end
function class.getDumplingCardId(A0_37, A1_38)
  local L2_39
  L2_39 = Logic
  L2_39 = L2_39.Get
  L2_39 = L2_39(L2_39, "Hero")
  L2_39 = L2_39.GetDumplingCard
  L2_39 = L2_39(L2_39)
  if L2_39 == nil or table.empty(L2_39) then
    return nil
  end
  L2_39 = Logic:Get("Hero"):GetHeroInfosByIds(L2_39)
  if L2_39 then
    for _FORV_6_ = 1, #L2_39 do
      if L2_39[_FORV_6_].baseId == A1_38 then
        return L2_39[_FORV_6_].id
      end
    end
  end
  return _FOR_
end
function class.getDumplingState(A0_40)
  local L1_41
  L1_41 = A0_40.cookingInfo
  if L1_41 then
    L1_41 = A0_40.cookingInfo
    L1_41 = L1_41.baseId
    if L1_41 then
      L1_41 = A0_40.cookingInfo
      L1_41 = L1_41.baseId
    end
  elseif L1_41 <= 0 then
    L1_41 = DUMPLING_STATE
    L1_41 = L1_41.NONE
    return L1_41
  end
  L1_41 = A0_40.cookingInfo
  L1_41 = L1_41.coolTime
  if not L1_41 then
    L1_41 = DUMPLING_STATE
    L1_41 = L1_41.NONE
    return L1_41
  else
    L1_41 = A0_40.cookingInfo
    L1_41 = L1_41.coolTime
    if L1_41 > Logic:Get("System"):GetTime() * 1000 then
      L1_41 = DUMPLING_STATE
      L1_41 = L1_41.COOKING
      return L1_41
    else
      L1_41 = DUMPLING_STATE
      L1_41 = L1_41.FINISHED
      return L1_41
    end
  end
end
function class.getRewardsInfo(A0_42, A1_43)
  local L2_44, L3_45, L4_46, L5_47
  if L2_44 then
  elseif L2_44 then
    A0_42.rewards = L2_44
    for L5_47 = 1, L3_45(L4_46) do
      if KFDBGetRecordByIdx("DumplingSetting", L5_47) then
        KFDBGetRecordByIdx("DumplingSetting", L5_47).showTypes = json.decode(KFDBGetRecordByIdx("DumplingSetting", L5_47).showTypeId or "[]")
        KFDBGetRecordByIdx("DumplingSetting", L5_47).showIds = json.decode(KFDBGetRecordByIdx("DumplingSetting", L5_47).showIds or "[]")
        KFDBGetRecordByIdx("DumplingSetting", L5_47).counts = json.decode(KFDBGetRecordByIdx("DumplingSetting", L5_47).counts or "[]")
        A0_42.rewards[L5_47] = KFDBGetRecordByIdx("DumplingSetting", L5_47)
      end
    end
  end
  if not A1_43 then
    return L2_44
  end
  for L5_47, _FORV_6_ in L2_44(L3_45) do
    if _FORV_6_.baseId == A1_43 then
      return _FORV_6_
    end
  end
  return L2_44
end
function class.startTimer(A0_48)
  if not A0_48.eventTracer:Exist("refreshCookDumpling") then
    Singleton(Timer):Repeat(1000, A0_48:Event("refreshCookDumpling"))
  end
end
function class.refreshCookDumpling(A0_49)
  if A0_49:getDumplingState() == DUMPLING_STATE.NONE then
    if A0_49.hasGet then
      A0_49.hasGet = false
      Logic:Get("Gift"):FireEvent(Logic.Gift.EVT.REFRESH_GIFT)
    end
    return
  end
  A0_49:FireEvent(EVT.TIMER_EVENT)
  if A0_49:getDumplingState() == DUMPLING_STATE.FINISHED and A0_49.cookingInfo and A0_49.cookingInfo.coolTime and Logic:Get("System"):DiffTime(A0_49.cookingInfo.coolTime / 1000) <= 0 and not A0_49.hasGet then
    A0_49.hasGet = true
    Logic:Get("Gift"):FireEvent(Logic.Gift.EVT.REFRESH_GIFT)
    A0_49:FireEvent(EVT.COOKING_FINISHED)
  end
end
function class.getTipFlag(A0_50)
  local L1_51
  L1_51 = A0_50.hasGet
  return L1_51
end
function class.getBeginCookingFlag(A0_52)
  local L1_53
  L1_53 = A0_52.beginCookFlag
  return L1_53
end
function class.setBeginCookingFlag(A0_54, A1_55)
  A0_54.beginCookFlag = A1_55
end
function class.gotoCopy(A0_56)
  SceneHelper:runWithScene("BattleCopy", A0_56.rootNode)
  Logic:Get("Battle"):OpenLastCamp()
end
