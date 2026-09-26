local L0_0
L0_0 = module
L0_0((...), package.seeall)
L0_0 = require
L0_0("SceneHelper")
L0_0 = Logic
L0_0 = L0_0.class
L0_0 = L0_0.subclass
L0_0 = L0_0(L0_0)
class = L0_0
L0_0 = KFDBGetRecord
L0_0 = L0_0("ConfigValue", "CHRISTMAS:MAX_FREE_COMPLETE_COUNTS")
MAX_TASK = tonumber(L0_0.content)
FREE_REFRESH_TIME = 1
EVT = Enum({
  "OPEN_UI",
  "REFRASH_UI",
  "REFRASH_LIST",
  "NEW_REWARD",
  "CLEAR_COOL_TIME",
  "REFRASH_PROGRESS"
})
function class.initialize(A0_1)
  super.initialize(A0_1)
  Logic:Get("MsgAssist"):RecordErrorMsg("MsgTask", _UPVALUE0_, _UPVALUE1_)
  A0_1.taskList = {}
  A0_1.targetValues = {}
  A0_1.completeCount = 0
  A0_1.todayBuyTimes = 0
  A0_1.canCompleteTasks = {}
  A0_1.gottask = {}
  A0_1.refreshCount = 1
  A0_1.totalCompleteCount = 0
  A0_1.gottaskId = 0
  A0_1.receiveTask = {}
  A0_1.pastReceicedCount = 0
  A0_1.giveUpId = 0
  A0_1.btn = "OPEN"
  A0_1.newRewardFlag = false
  A0_1.coolTime = 0
  A0_1.coolState = false
  A0_1.buyCost = 0
  A0_1.resetCost = 0
  MsgTask:On("OPEN", A0_1:Event("OnChristmas"), true)
  MsgTask:On("FREE_REFRESH_ACTIVITY", A0_1:Event("OnFreeRefrashActivity"), true)
  MsgTask:On("REFRESH_ACTIVITY", A0_1:Event("OnRefrashActivity"), true)
  MsgTask:On("BUY_TASK", A0_1:Event("OnBuyTask"), true)
  MsgTask:On("IMMEDIATELY_COMPLETE_TASK", A0_1:Event("OnImmediatelyCompleteTask"), true)
  MsgTask:On("GET_REWARD", A0_1:Event("OnGetReward"), true)
  MsgTask:On("ADVANCED_REFRESH_ACTIVITY", A0_1:Event("OnAdvancedRefrashActivity"), true)
  MsgTask:On("PICK_UP_TASK", A0_1:Event("OnPickUpTask"), true)
  MsgTask:On("GIVE_UP", A0_1:Event("OnGiveUp"), true)
  MsgTask:On("CLEAR_COOL_TIME", A0_1:Event("OnClearCoolTime"))
  Singleton(NetMgr):On(NetMgr.EVT.TASK_COMPLETE, A0_1:Event("OnDemogActiveOpen"))
end
function class.reFrashUI(A0_2)
  SceneHelper:runWithScene("GiftChristmasActivity", A0_2.rootNode, nil, true)
end
function class.OnGiveUp(A0_3, A1_4, A2_5)
  if A1_4 ~= 0 then
    return
  end
  A0_3.receiveTask = A2_5.pickUpTasks
  A0_3.targetValues = A2_5.targetValues
  A0_3.taskList = A2_5.tasks
  A0_3:removeRevecieTask(A0_3.giveUpId)
  if A2_5.tasks ~= nil and #A2_5.tasks == 3 then
    A0_3.canCompleteTasks = {}
    A0_3.gottask = {}
  end
  A0_3:reFrashUI()
end
function class.PostGiveUpMsg(A0_6, A1_7)
  A0_6.giveUpId = A1_7
  MsgTask:Post("GIVE_UP", {taskId = A1_7})
end
function class.OnPickUpTask(A0_8, A1_9, A2_10)
  if A1_9 ~= 0 then
    return
  end
  A0_8.receiveTask = A2_10.pickUpTasks
  A0_8.completeCount = A0_8.completeCount + 1
  A0_8.totalCompleteCount = A2_10.totalCompleteCount
  A0_8.targetValues = {}
  A0_8:FireEvent(EVT.REFRASH_LIST)
end
function class.PostPickUpTaskMsg(A0_11, A1_12)
  MsgTask:Post("PICK_UP_TASK", {taskId = A1_12})
end
function class.OnChristmas(A0_13, A1_14, A2_15)
  if A1_14 ~= 0 then
    return
  end
  A0_13.coolTime = A2_15.coolTime or A0_13.coolTime
  A0_13.coolState = A2_15.coolState
  A0_13.completeCount = A2_15.completeCount
  A0_13.canCompleteTasks = A2_15.completeTasks
  A0_13.gottask = A2_15.gottask
  A0_13.todayBuyTimes = A2_15.todayBuyCompleteCount
  A0_13.refreshCount = A2_15.refreshCount
  A0_13.taskList = A2_15.tasks
  A0_13.receiveTask = A2_15.pickUpTasks
  A0_13.targetValues = A2_15.targetValues
  A0_13.totalCompleteCount = A2_15.totalCompleteCount
  A0_13.newRewardFlag = A0_13:IsNewDrawReward()
  A0_13:FireEvent(EVT.NEW_REWARD)
  if A0_13.btn == "OPEN" then
    A0_13:reFrashUI()
  end
end
function class.OnDemogActiveOpen(A0_16)
  A0_16.newRewardFlag = true
  A0_16:FireEvent(EVT.NEW_REWARD)
end
function class.getNewRewardFlag(A0_17)
  local L1_18
  L1_18 = A0_17.newRewardFlag
  return L1_18
end
function class.IsCanDirectGetReward(A0_19, A1_20)
  if KFDBGetRecord("TaskSetting", A1_20) == nil then
    return false
  end
  if A0_19:getTargetValuesById(KFDBGetRecord("TaskSetting", A1_20).targetType) >= KFDBGetRecord("TaskSetting", A1_20).target or A0_19:IsInCanDirectGetReward(A1_20) then
    return true
  end
  return false
end
function class.IsInCanDirectGetReward(A0_21, A1_22)
  for _FORV_6_ = 1, #A0_21:getCanDirectGetRewardTasks() do
    if A1_22 == A0_21:getCanDirectGetRewardTasks()[_FORV_6_] then
      return true
    end
  end
  return _FOR_
end
function class.IsHaveDirectGetRewardTask(A0_23)
  local L1_24
  L1_24 = false
  for _FORV_6_ = 1, #A0_23:getTaskList() do
    if A0_23:IsCanDirectGetReward(A0_23:getTaskList()[_FORV_6_]) then
      return true
    end
  end
  return L1_24
end
function class.OpenChristmas(A0_25)
  A0_25.btn = "OPEN"
  A0_25:PostChristmasMsg()
end
function class.PostChristmasMsg(A0_26)
  MsgTask:Post("OPEN")
end
function class.OnFreeRefrashActivity(A0_27, A1_28, A2_29)
  if A1_28 ~= 0 then
    return
  end
  A0_27.coolState = A2_29.coolState
  A0_27.coolTime = A2_29.coolTime or A0_27.coolTime
  A0_27.taskList = A2_29.tasks
  A0_27.targetValues = {}
  A0_27.canCompleteTasks = {}
  A0_27.receiveTask = {}
  A0_27.gottask = {}
  A0_27.refreshCount = A0_27.refreshCount + 1
  A0_27.newRewardFlag = false
  A0_27:reFrashUI()
end
function class.PostFreeRefrashActivityMsg(A0_30)
  MsgTask:Post("FREE_REFRESH_ACTIVITY")
end
function class.OnRefrashActivity(A0_31, A1_32, A2_33)
  if A1_32 ~= 0 then
    return
  end
  Logic:Get("Cost"):AddCosts(A2_33.costResults)
  A0_31.coolState = A2_33.coolState
  A0_31.coolTime = A2_33.coolTime or A0_31.coolTime
  A0_31.taskList = A2_33.tasks
  A0_31.targetValues = {}
  A0_31.canCompleteTasks = {}
  A0_31.receiveTask = {}
  A0_31.gottask = {}
  A0_31.refreshCount = A0_31.refreshCount + 1
  A0_31.newRewardFlag = false
  A0_31:reFrashUI()
end
function class.PostRefrashActivityMsg(A0_34)
  MsgTask:Post("REFRESH_ACTIVITY")
end
function class.OnBuyTask(A0_35, A1_36, A2_37)
  if A1_36 ~= 0 then
    return
  end
  Logic:Get("Cost"):AddCosts(A2_37.costResults)
  A0_35.todayBuyTimes = A2_37.todayBuyCompleteCount
  A0_35.totalCompleteCount = A2_37.totalCompleteCount
  A0_35:AddJadeProgressAndCost(1, A0_35.buyCost)
  A0_35:FireEvent(EVT.REFRASH_PROGRESS)
end
function class.PostBuyTaskMsg(A0_38, A1_39)
  A0_38.buyCost = A1_39 or A0_38.buyCost
  MsgTask:Post("BUY_TASK")
end
function class.OnImmediatelyCompleteTask(A0_40, A1_41, A2_42)
  if A1_41 ~= 0 then
    return
  end
  Logic:Get("Cost"):AddCosts(A2_42.costResults)
  A0_40.canCompleteTasks = A2_42.completeTasks
  if A0_40:IsHaveDirectGetRewardTask() then
    A0_40.newRewardFlag = true
  else
    A0_40.newRewardFlag = false
  end
  A0_40:FireEvent(EVT.NEW_REWARD)
  A0_40:reFrashUI()
end
function class.PostImmediatelyCompleteTaskMsg(A0_43, A1_44)
  A0_43.gottaskId = A1_44
  MsgTask:Post("IMMEDIATELY_COMPLETE_TASK", {taskId = A1_44})
end
function class.OnGetReward(A0_45, A1_46, A2_47)
  local L3_48
  if A1_46 ~= 0 then
    return
  end
  L3_48 = Logic
  L3_48 = L3_48.Get
  L3_48 = L3_48(L3_48, "Reward")
  L3_48 = L3_48.AddRewards
  L3_48(L3_48, A2_47.rewardResults)
  L3_48 = A2_47.targetValues
  A0_45.targetValues = L3_48
  L3_48 = A0_45.removeTask
  L3_48(A0_45, A0_45.gottaskId)
  L3_48 = A0_45.removeRevecieTask
  L3_48(A0_45, A0_45.gottaskId)
  L3_48 = A2_47.tasks
  if L3_48 ~= nil then
    L3_48 = A2_47.tasks
    L3_48 = #L3_48
    if L3_48 ~= 0 then
      L3_48 = A2_47.tasks
      A0_45.taskList = L3_48
      L3_48 = {}
      A0_45.canCompleteTasks = L3_48
      L3_48 = {}
      A0_45.gottask = L3_48
    end
  end
  L3_48 = A0_45.IsHaveDirectGetRewardTask
  L3_48 = L3_48(A0_45)
  if L3_48 then
    A0_45.newRewardFlag = true
  else
    A0_45.newRewardFlag = false
  end
  L3_48 = A0_45.FireEvent
  L3_48(A0_45, EVT.NEW_REWARD)
  L3_48 = A0_45.reFrashUI
  L3_48(A0_45)
  L3_48 = Logic
  L3_48 = L3_48.Get
  L3_48 = L3_48(L3_48, "Reward")
  L3_48 = L3_48.AddDupiCardTip
  L3_48 = L3_48(L3_48, A2_47.rewardResults)
  Prompt:Fail(L3_48)
end
function class.removeRevecieTask(A0_49, A1_50)
  local L2_51, L3_52, L4_53, L5_54
  for L5_54 = 1, #L3_52 do
    if A0_49.receiveTask[L5_54] == A1_50 then
      table.remove(A0_49.receiveTask, L5_54)
    end
  end
end
function class.PostGetRewardMsg(A0_55, A1_56)
  A0_55.gottaskId = A1_56
  MsgTask:Post("GET_REWARD", {taskId = A1_56})
end
function class.OnAdvancedRefrashActivity(A0_57, A1_58, A2_59)
  if A1_58 ~= 0 then
    return
  end
  Logic:Get("Cost"):AddCosts(A2_59.costResults)
  A0_57.coolState = A2_59.coolState
  A0_57.coolTime = A2_59.coolTime or 0
  A0_57.taskList = A2_59.tasks
  A0_57.targetValues = {}
  A0_57.canCompleteTasks = {}
  A0_57.receiveTask = {}
  A0_57.gottask = {}
  A0_57.newRewardFlag = false
  A0_57:reFrashUI()
end
function class.PostAdvancedRefrashActivityMsg(A0_60)
  MsgTask:Post("ADVANCED_REFRESH_ACTIVITY")
end
function class.getTaskList(A0_61)
  local L1_62, L2_63, L3_64, L4_65, L5_66, L6_67, L7_68
  L1_62 = {}
  L2_63 = {}
  for L6_67, L7_68 in L3_64(L4_65) do
    if not L2_63[L7_68] then
      table.insert(L1_62, L7_68)
      L2_63[L7_68] = true
    end
  end
  for L6_67, L7_68 in L3_64(L4_65) do
    if not L2_63[L7_68] then
      table.insert(L1_62, L7_68)
      L2_63[L7_68] = true
    end
  end
  for L7_68, _FORV_8_ in L4_65(L5_66) do
    L3_64[_FORV_8_] = true
  end
  for L7_68 = #L1_62, 1, -1 do
    if L3_64[L1_62[L7_68]] then
      table.remove(L1_62, L7_68)
    end
  end
  return L1_62
end
function class.getRefrashTime(A0_69)
  local L1_70
  L1_70 = A0_69.refreshCount
  return L1_70
end
function class.getTargetValuesById(A0_71, A1_72, A2_73)
  local L3_74
  L3_74 = 0
  if A0_71:IsReceivedTask(A2_73) and A0_71.targetValues[A1_72] ~= nil then
    L3_74 = A0_71.targetValues[A1_72]
  end
  return L3_74
end
function class.getCompleteTaskNum(A0_75)
  local L1_76
  L1_76 = A0_75.completeCount
  return L1_76
end
function class.getTotalTaskNum(A0_77)
  local L1_78
  L1_78 = A0_77.totalCompleteCount
  return L1_78
end
function class.removeTask(A0_79, A1_80)
  table.insert(A0_79.gottask, A1_80)
end
function class.getCanDirectGetRewardTasks(A0_81)
  local L1_82
  L1_82 = A0_81.canCompleteTasks
  return L1_82
end
function class.IsReceivedTask(A0_83, A1_84)
  if table.empty(A0_83.receiveTask or {}) then
    return false
  end
  for _FORV_5_ = 1, #A0_83.receiveTask do
    if A1_84 == A0_83.receiveTask[_FORV_5_] then
      return true
    end
  end
  return _FOR_
end
function class.getBuyTaskTimes(A0_85)
  local L1_86
  L1_86 = A0_85.todayBuyTimes
  return L1_86
end
function class.IsHaveReceivedTask(A0_87)
  if table.empty(A0_87.receiveTask or {}) then
    return false
  else
    return true
  end
end
function class.getPastReceicedCount(A0_88)
  local L1_89
  L1_89 = A0_88.pastReceicedCount
  return L1_89
end
function class.GetTaskCost(A0_90)
  local L1_91
  L1_91 = A0_90.todayBuyTimes
  L1_91 = L1_91 + 1
  if not KFDBGetRecord("ConfigValue", "CHRISTMAS:BUY_COMPLETE_TIMES_COSTS") then
    return 0
  end
  if table.empty(json.decode(KFDBGetRecord("ConfigValue", "CHRISTMAS:BUY_COMPLETE_TIMES_COSTS").content or "[]") or {} or {}) then
    return 0
  end
  if L1_91 < 1 then
    L1_91 = 1 or L1_91
  end
  if L1_91 > #(json.decode(KFDBGetRecord("ConfigValue", "CHRISTMAS:BUY_COMPLETE_TIMES_COSTS").content or "[]") or {}) then
    L1_91 = #(json.decode(KFDBGetRecord("ConfigValue", "CHRISTMAS:BUY_COMPLETE_TIMES_COSTS").content or "[]") or {}) or L1_91
  end
  return (json.decode(KFDBGetRecord("ConfigValue", "CHRISTMAS:BUY_COMPLETE_TIMES_COSTS").content or "[]") or {})[L1_91] or 0
end
function class.GetCoolState(A0_92)
  local L1_93
  L1_93 = A0_92.coolState
  return L1_93
end
function class.GetCoolTime(A0_94)
  local L1_95
  L1_95 = A0_94.coolTime
  return L1_95
end
function class.CanFreeFresh(A0_96)
  if Logic:Get("System"):DiffTime(A0_96.coolTime / 1000) < 0 then
    return true
  end
  return not A0_96.coolState
end
function class.PostClearCoolTime(A0_97, A1_98)
  A0_97.resetCost = A1_98 or A0_97.resetCost
  MsgTask:Post("CLEAR_COOL_TIME")
end
function class.OnClearCoolTime(A0_99, A1_100, A2_101)
  if A1_100 ~= 0 then
    return
  end
  Logic:Get("Cost"):AddCosts(A2_101)
  A0_99.coolTime = 0
  A0_99.coolState = false
  A0_99:AddJadeProgressAndCost(1, A0_99.resetCost)
  A0_99:FireEvent(EVT.REFRASH_PROGRESS)
  A0_99:FireEvent(EVT.CLEAR_COOL_TIME)
end
function class.AddJadeProgressAndCost(A0_102, A1_103, A2_104)
  local L3_105, L4_106
  if not A1_103 or not A2_104 then
    return
  end
  L3_105 = A0_102.targetValues
  if L3_105 then
    L3_105 = A0_102.targetValues
  else
    L3_105 = L3_105 or {}
  end
  A0_102.targetValues = L3_105
  L3_105 = A0_102.targetValues
  L3_105 = L3_105.CURRENCY_COST_TIMES
  if not L3_105 then
    L3_105 = A0_102.targetValues
    L3_105.CURRENCY_COST_TIMES = 0
  end
  L3_105 = A0_102.targetValues
  L4_106 = A0_102.targetValues
  L4_106 = L4_106.CURRENCY_COST_TIMES
  L4_106 = L4_106 + A1_103
  L3_105.CURRENCY_COST_TIMES = L4_106
  L3_105 = A0_102.targetValues
  L3_105 = L3_105.CONSUME_NUM
  if not L3_105 then
    L3_105 = A0_102.targetValues
    L3_105.CONSUME_NUM = 0
  end
  L3_105 = A0_102.targetValues
  L4_106 = A0_102.targetValues
  L4_106 = L4_106.CONSUME_NUM
  L4_106 = L4_106 + A2_104
  L3_105.CONSUME_NUM = L4_106
end
function class.IsNewDrawReward(A0_107)
  local L1_108, L2_109, L3_110, L4_111, L5_112
  if L1_108 then
    return L1_108
  end
  for L4_111, L5_112 in L1_108(L2_109) do
    if A0_107:IsReceivedTask(L5_112) then
      return A0_107:getTargetValuesById((KFDBGetRecord("TaskSetting", L5_112) or {}).targetType, L5_112) >= (KFDBGetRecord("TaskSetting", L5_112) or {}).target or A0_107:IsInCanDirectGetReward(L5_112)
    end
  end
  return L1_108
end
