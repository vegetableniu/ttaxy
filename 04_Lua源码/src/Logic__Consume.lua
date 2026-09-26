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
  "GET_INFO",
  "CAN_SHOW_REWARD_LIST"
})
EVT = L0_0
L0_0 = TypeDef
L0_0 = L0_0("com.eyu.mt.module.consumerank.facade.ConsumeRankResult")
function class.initialize(A0_1)
  super.initialize(A0_1)
  A0_1.consumerankInfo = {}
  A0_1.consumeToprank = {}
  A0_1.consumeOtherrank = {}
  A0_1.hadDrawRewardList = {}
  A0_1.drawRewardId = 0
  A0_1.curScore = 0
  A0_1.closeTime = 0
  A0_1.hasReward = false
  Logic:Get("MsgAssist"):RecordErrorMsg("MsgConsumerank", _UPVALUE0_, _UPVALUE1_)
  MsgConsumerank:On("GET_INFO", A0_1:Event("OnGetInfo"))
  MsgConsumerank:On("DRAW_SCORE_REWARD", A0_1:Event("OnDrawScoreReward"))
  Singleton(NetMgr):On(NetMgr.EVT.CONSUME_RANK_SCORE_REWARD, A0_1:Event("OnConsumeRankScoreReward"))
end
function class.dispose(A0_2)
  super.dispose(A0_2)
end
function class.PostGetInfo(A0_3)
  MsgConsumerank:Post("GET_INFO")
end
function class.OnGetInfo(A0_4, A1_5, A2_6)
  if A1_5 == 0 then
    A0_4.consumerankInfo = A2_6
    A0_4.consumeToprank = A2_6.topList
    A0_4.consumeOtherrank = A2_6.nearList
    A0_4.hadDrawRewardList = A2_6.drawedIds
    A0_4.curScore = A2_6.score or 0
    A0_4.closeTime = A2_6.closeTime
    A0_4:FireEvent(EVT.GET_INFO)
  end
end
function class.OnDrawScoreReward(A0_7, A1_8, A2_9)
  local L3_10
  if A1_8 == 0 then
    L3_10 = A0_7.drawRewardId
    if L3_10 ~= 0 then
      L3_10 = table
      L3_10 = L3_10.insert
      L3_10(A0_7.hadDrawRewardList, A0_7.drawRewardId)
    end
    L3_10 = A0_7.FireEvent
    L3_10(A0_7, EVT.CAN_SHOW_REWARD_LIST)
    L3_10 = Logic
    L3_10 = L3_10.Get
    L3_10 = L3_10(L3_10, "Reward")
    L3_10 = L3_10.AddRewards
    L3_10(L3_10, A2_9)
    L3_10 = Logic
    L3_10 = L3_10.Get
    L3_10 = L3_10(L3_10, "Reward")
    L3_10 = L3_10.AddRewardsTip
    L3_10 = L3_10(L3_10, A2_9)
    Prompt:Fail(L3_10)
    A0_7:checkHasDraw()
    Logic:Get("Gift"):FireEvent(Logic.Gift.EVT.REFRESH_GIFT)
  end
end
function class.OnConsumeRankScoreReward(A0_11)
  A0_11.hasReward = true
  A0_11:PostGetInfo()
  Logic:Get("Gift"):FireEvent(Logic.Gift.EVT.REFRESH_GIFT)
end
function class.initConsumeList(A0_12)
  local L1_13, L2_14, L3_15, L4_16, L5_17, L6_18
  L1_13 = {}
  A0_12.canShowRewardList = L1_13
  L1_13 = Logic
  L1_13 = L1_13.Get
  L1_13 = L1_13(L2_14, L3_15)
  L1_13 = L1_13.GetActivityGift
  L1_13 = L1_13(L2_14)
  for L5_17 = 1, L3_15(L4_16) do
    L6_18 = KFDBGetRecordByIdx
    L6_18 = L6_18("ScoreReward", L5_17)
    for _FORV_11_, _FORV_12_ in ipairs(A0_12.hadDrawRewardList) do
      if L6_18.id == _FORV_12_ then
        break
      end
    end
    if not true and L6_18.activityId == L1_13.id then
      table.insert(A0_12.canShowRewardList, L6_18)
    end
  end
end
function class.setDrawRewardId(A0_19, A1_20)
  if A1_20 == nil then
    return
  end
  A0_19.drawRewardId = A1_20
end
function class.checkHasDraw(A0_21)
  A0_21.hasReward = false
  if A0_21.canShowRewardList == nil then
    return
  end
  for _FORV_4_, _FORV_5_ in ipairs(A0_21.canShowRewardList) do
    if A0_21.curScore >= _FORV_5_.needScore then
      A0_21.hasReward = true
    end
  end
end
function class.setHasConsumeReward(A0_22, A1_23)
  A0_22.hasReward = A1_23
end
function class.getConsumeRankInfo(A0_24)
  local L1_25
  L1_25 = A0_24.consumerankInfo
  return L1_25
end
function class.getConsumeToprank(A0_26)
  local L1_27
  L1_27 = A0_26.consumeToprank
  return L1_27
end
function class.getConsumeOtherrank(A0_28)
  local L1_29
  L1_29 = A0_28.consumeOtherrank
  return L1_29
end
function class.getCanShowRewardList(A0_30)
  local L1_31
  L1_31 = A0_30.canShowRewardList
  return L1_31
end
function class.GetCurScore(A0_32)
  local L1_33
  L1_33 = A0_32.curScore
  return L1_33
end
function class.getCloseTime(A0_34)
  local L1_35
  L1_35 = A0_34.closeTime
  return L1_35
end
function class.hasConsumeReward(A0_36)
  local L1_37
  L1_37 = A0_36.hasReward
  return L1_37
end
