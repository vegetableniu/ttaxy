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
L0_0 = L0_0({"GET_INFO"})
EVT = L0_0
L0_0 = TypeDef
L0_0 = L0_0("com.eyu.mt.module.godreward.facade.GodRewardResult")
function class.initialize(A0_1)
  super.initialize(A0_1)
  A0_1.taskInfo = {}
  A0_1.tasksId = 0
  A0_1.bComplete = false
  Logic:Get("MsgAssist"):RecordErrorMsg("MsgGodreward", _UPVALUE0_, _UPVALUE1_)
  MsgGodreward:On("GET_INFO", A0_1:Event("OnGetInfo"))
  MsgGodreward:On("REFRESH_TASK", A0_1:Event("OnRefreshTask"))
  MsgGodreward:On("BUY_REFRESH_TASK", A0_1:Event("OnBuyRefreshTask"))
  MsgGodreward:On("ACCEPT_TASK", A0_1:Event("OnAcceptTask"))
  MsgGodreward:On("GIVE_UP_TASK", A0_1:Event("OnGiveUpTask"))
  MsgGodreward:On("GET_TASK_REWARD", A0_1:Event("OnGetTaskReward"))
  MsgGodreward:On("GET_FEAT_REWARD", A0_1:Event("OnGetFeatReward"))
  Singleton(NetMgr):On(NetMgr.EVT.GOD_TASK_COMPLETE, A0_1:Event("OnGodTaskComplete"))
end
function class.dispose(A0_2)
  super.dispose(A0_2)
end
function class.IsCompleteTask(A0_3)
  local L1_4
  L1_4 = A0_3.bComplete
  return L1_4
end
function class.GetTasks(A0_5)
  local L1_6
  L1_6 = A0_5.taskInfo
  L1_6 = L1_6.tasks
  L1_6 = L1_6 or {}
  return L1_6
end
function class.GetProgress(A0_7)
  local L1_8
  L1_8 = A0_7.taskInfo
  L1_8 = L1_8.progress
  L1_8 = L1_8 or {}
  return L1_8
end
function class.GetFeats(A0_9)
  local L1_10
  L1_10 = A0_9.taskInfo
  L1_10 = L1_10.feats
  L1_10 = L1_10 or 0
  return L1_10
end
function class.GetRewardFeats(A0_11)
  local L1_12
  L1_12 = A0_11.taskInfo
  L1_12 = L1_12.rewardFeats
  L1_12 = L1_12 or {}
  return L1_12
end
function class.GetFreeTimes(A0_13)
  local L1_14
  L1_14 = A0_13.taskInfo
  L1_14 = L1_14.freeTimes
  L1_14 = L1_14 or 0
  return L1_14
end
function class.IsDrawFeatReward(A0_15, A1_16)
  return table.invert(A0_15.taskInfo.rewardFeats or {})[A1_16] and true or false
end
function class.PostGetInfo(A0_17)
  A0_17.bComplete = false
  MsgGodreward:Post("GET_INFO")
end
function class.PostRefreshTask(A0_18)
  MsgGodreward:Post("REFRESH_TASK")
end
function class.PostBuyRefreshTask(A0_19)
  MsgGodreward:Post("BUY_REFRESH_TASK")
end
function class.PostAcceptTask(A0_20, A1_21)
  if not A1_21 then
    return
  end
  MsgGodreward:Post("ACCEPT_TASK", A1_21)
end
function class.PostGiveUpTask(A0_22, A1_23)
  if not A1_23 then
    return
  end
  MsgGodreward:Post("GIVE_UP_TASK", A1_23)
end
function class.PostGetTaskReward(A0_24, A1_25)
  if not A1_25 then
    return
  end
  A0_24.taskId = A1_25
  MsgGodreward:Post("GET_TASK_REWARD", A1_25)
end
function class.PostGetFeatReward(A0_26, A1_27)
  if not A1_27 then
    return
  end
  MsgGodreward:Post("GET_FEAT_REWARD", A1_27)
end
function class.RefreshCompleteFlag(A0_28)
  local L1_29, L2_30, L3_31, L4_32, L5_33
  A0_28.bComplete = false
  for L4_32, L5_33 in L1_29(L2_30) do
    if tonumber(L5_33) ~= nil then
      if tonumber(L5_33) >= tonumber((KFDBGetRecord("GodTaskSetting", tonumber(L4_32) or L4_32) or {}).target or math.huge) then
        A0_28.bComplete = true
        break
      end
    end
  end
  L1_29(L2_30, L3_31)
end
function class.OnGetInfo(A0_34, A1_35, A2_36)
  if A1_35 ~= 0 then
    A0_34.bComplete = false
    Logic:Get("Gift"):FireEvent(Logic.Gift.EVT.REFRESH_GIFT)
    return
  end
  A0_34.taskInfo = A2_36
  A0_34:RefreshCompleteFlag()
  A0_34:FireEvent(EVT.GET_INFO)
end
function class.OnRefreshTask(A0_37, A1_38, A2_39)
  A0_37:OnBuyRefreshTask(A1_38, A2_39)
end
function class.OnBuyRefreshTask(A0_40, A1_41, A2_42)
  if A1_41 ~= 0 then
    return
  end
  A0_40.taskInfo.buyTimes = A2_42.buyTimes
  A0_40.taskInfo.freeTimes = A2_42.freeTimes
  Logic:Get("Cost"):AddCosts(A2_42.costResults)
  A0_40.taskInfo.tasks = A2_42.tasks
  A0_40.taskInfo.progress = {}
  A0_40:RefreshCompleteFlag()
  A0_40:FireEvent(EVT.GET_INFO)
end
function class.OnAcceptTask(A0_43, A1_44, A2_45)
  if A1_44 ~= 0 then
    return
  end
  A0_43.taskInfo.progress = A2_45
  A0_43:RefreshCompleteFlag()
  A0_43:FireEvent(EVT.GET_INFO)
end
function class.OnGiveUpTask(A0_46, A1_47, A2_48)
  if A1_47 ~= 0 then
    return
  end
  A0_46.taskInfo.freeTimes = A2_48.freeTimes
  A0_46.taskInfo.progress = A2_48.progress
  A0_46.taskInfo.tasks = A2_48.tasks
  A0_46:RefreshCompleteFlag()
  A0_46:FireEvent(EVT.GET_INFO)
end
function class.OnGetTaskReward(A0_49, A1_50, A2_51)
  local L3_52, L4_53
  L3_52 = A0_49.taskInfo
  L4_53 = A2_51.tasks
  L3_52.tasks = L4_53
  L3_52 = A0_49.taskInfo
  L4_53 = A2_51.freeTimes
  L3_52.freeTimes = L4_53
  L3_52 = A0_49.taskInfo
  L4_53 = {}
  L3_52.progress = L4_53
  A0_49.bComplete = false
  L3_52 = KFDBGetRecord
  L4_53 = "GodTaskSetting"
  L3_52 = L3_52(L4_53, A0_49.taskId)
  L3_52 = L3_52 or {}
  L4_53 = A0_49.taskInfo
  L4_53.feats = A0_49.taskInfo.feats + (L3_52.feats or 0)
  L4_53 = Logic
  L4_53 = L4_53.Get
  L4_53 = L4_53(L4_53, "Reward")
  L4_53 = L4_53.AddRewards
  L4_53(L4_53, A2_51.rewardResults)
  L4_53 = Logic
  L4_53 = L4_53.Get
  L4_53 = L4_53(L4_53, "Reward")
  L4_53 = L4_53.AddDupiCardTip
  L4_53 = L4_53(L4_53, A2_51.rewardResults)
  Prompt:Msg(L4_53)
  Logic:Get("Gift"):FireEvent(Logic.Gift.EVT.REFRESH_GIFT)
  A0_49:FireEvent(EVT.GET_INFO)
end
function class.OnGetFeatReward(A0_54, A1_55, A2_56)
  local L3_57
  L3_57 = A0_54.taskInfo
  L3_57.rewardFeats = A2_56.rewardFeats
  L3_57 = Logic
  L3_57 = L3_57.Get
  L3_57 = L3_57(L3_57, "Reward")
  L3_57 = L3_57.AddRewards
  L3_57(L3_57, A2_56.rewardResults)
  L3_57 = Logic
  L3_57 = L3_57.Get
  L3_57 = L3_57(L3_57, "Reward")
  L3_57 = L3_57.AddDupiCardTip
  L3_57 = L3_57(L3_57, A2_56.rewardResults)
  Prompt:Msg(L3_57)
  A0_54:FireEvent(EVT.GET_INFO)
end
function class.OnGodTaskComplete(A0_58)
  A0_58.bComplete = true
  Logic:Get("Gift"):FireEvent(Logic.Gift.EVT.REFRESH_GIFT)
end
