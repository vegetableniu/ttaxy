require("SceneHelper")
module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
function prototype.onEnter(A0_0)
  local L1_1, L2_2
  L1_1 = Logic
  L2_2 = L1_1
  L1_1 = L1_1.Get
  L1_1 = L1_1(L2_2, "NewMonopoly")
  L2_2 = L1_1
  L1_1 = L1_1.GetMonoInfo
  L1_1 = L1_1(L2_2)
  A0_0.info = L1_1
  L1_1 = A0_0.info
  if L1_1 then
    L1_1 = A0_0.info
    L1_1 = L1_1.tasks
  else
    L1_1 = L1_1 or {}
  end
  L2_2 = L1_1[1]
  A0_0.info.taskProgress = A0_0.info.taskProgress or {}
  if not L2_2 then
    for _FORV_6_, _FORV_7_ in pairs(A0_0.info.taskProgress) do
      L2_2 = _FORV_6_
      break
    end
  end
  A0_0.taskInfo = L2_2 and KFDBGetRecord("MoTaskSetting", L2_2)
  if not A0_0.taskInfo then
    SceneHelper:removePrompt(A0_0.rootNode)
    return
  end
  A0_0.progress = A0_0.info.taskProgress[L2_2] or 0
  A0_0:refreshBtnStatus()
  A0_0:refreshTaskInfo()
  Logic:Get("NewMonopoly"):On(Logic.NewMonopoly.EVT.PICKUP_TASK, A0_0:Event("onPickUpTask"))
  Logic:Get("NewMonopoly"):On(Logic.NewMonopoly.EVT.COMPLETE_TASK, A0_0:Event("onCompleteTask"))
  Logic:Get("NewMonopoly"):On(Logic.NewMonopoly.EVT.GIVEUP_TASK, A0_0:Event("onGiveUpTask"))
  Logic:Get("NewMonopoly"):On(Logic.NewMonopoly.EVT.DRAW_TASK_REWARD, A0_0:Event("onDrawpTaskReward"))
  Logic:Get("Devil"):On(Logic.Devil.EVT.PUSH_MAIN_INFO, A0_0:Event("OnPushMainInfo"))
end
function prototype.refreshBtnStatus(A0_3)
  local L1_4, L2_5
  L1_4 = table
  L1_4 = L1_4.empty
  L2_5 = A0_3.info
  L2_5 = L2_5.taskProgress
  L1_4 = L1_4(L2_5)
  L1_4 = not L1_4
  L2_5 = A0_3.progress
  L2_5 = L2_5 >= A0_3.taskInfo.target
  A0_3.nodAcceptTask:setVisible(not L2_5 and not L1_4)
  A0_3.nodSkipTask:setVisible(not L2_5 and not L1_4)
  A0_3.nodCompleteTask:setVisible(not L2_5 and L1_4)
  A0_3.nodGoToTask:setVisible(not L2_5 and L1_4)
  A0_3.nodGiveUp:setVisible(not L2_5 and L1_4)
  A0_3.nodDrawReward:setVisible(L2_5)
end
function prototype.refreshTaskInfo(A0_6)
  local L1_7, L2_8, L3_9, L4_10, L5_11, L6_12, L7_13, L8_14, L9_15, L10_16, L11_17
  L1_7 = {
    L2_8,
    L3_9,
    L4_10,
    L5_11,
    L6_12
  }
  L2_8 = {L3_9}
  L3_9 = 320
  L3_9 = {L4_10, L5_11}
  L4_10 = 260
  L5_11 = 380
  L4_10 = {
    L5_11,
    L6_12,
    L7_13
  }
  L5_11 = 320
  L5_11 = {
    L6_12,
    L7_13,
    L8_14,
    L9_15
  }
  L9_15 = 380
  L9_15 = 420
  L10_16 = 120
  L11_17 = 520
  L2_8 = json
  L2_8 = L2_8.decode
  L3_9 = A0_6.taskInfo
  L3_9 = L3_9.showTypes
  L3_9 = L3_9 or "[]"
  L2_8 = L2_8(L3_9)
  L2_8 = L2_8 or {}
  L3_9 = json
  L3_9 = L3_9.decode
  L4_10 = A0_6.taskInfo
  L4_10 = L4_10.showIds
  L4_10 = L4_10 or "[]"
  L3_9 = L3_9(L4_10)
  L3_9 = L3_9 or {}
  L4_10 = json
  L4_10 = L4_10.decode
  L5_11 = A0_6.taskInfo
  L5_11 = L5_11.amounts
  L5_11 = L5_11 or "[]"
  L4_10 = L4_10(L5_11)
  L4_10 = L4_10 or {}
  L5_11 = 5
  for L9_15 = 1, L5_11 do
    L10_16 = "ccbReward"
    L11_17 = L9_15
    L10_16 = L10_16 .. L11_17
    L11_17 = A0_6[L10_16]
    L11_17 = L11_17.setVisible
    L11_17(L11_17, false)
    L11_17 = L2_8[L9_15]
    if L11_17 then
      L11_17 = A0_6[L10_16]
      if L11_17 then
        L11_17 = {}
        L11_17.showType = L2_8[L9_15]
        L11_17.showId = L3_9[L9_15]
        L11_17.amount = L4_10[L9_15]
        A0_6[L10_16]:ReFreshByGift(L11_17)
        A0_6[L10_16]:setPositionX(L1_7[#L2_8][L9_15])
        A0_6[L10_16]:setVisible(true)
      end
    end
  end
  L9_15 = L6_12
  L7_13(L8_14, L9_15)
  L9_15 = kCCLabelTTFStyleOutline
  L7_13(L8_14, L9_15)
  L9_15 = kCCLabelTTFStyleOutline
  L7_13(L8_14, L9_15)
  L9_15 = kCCLabelTTFStyleOutline
  L7_13(L8_14, L9_15)
  L9_15 = A0_6.taskInfo
  L9_15 = L9_15.name
  L7_13(L8_14, L9_15)
  L9_15 = A0_6.taskInfo
  L9_15 = L9_15.desc
  L7_13(L8_14, L9_15)
  L9_15 = A0_6.progress
  L10_16 = "/"
  L11_17 = A0_6.taskInfo
  L11_17 = L11_17.target
  L9_15 = L9_15 .. L10_16 .. L11_17
  L7_13(L8_14, L9_15)
end
function prototype.onPickUpTask(A0_18)
  A0_18:refreshBtnStatus()
end
function prototype.onCompleteTask(A0_19)
  A0_19.progress = A0_19.taskInfo.target
  A0_19.ttfProgress:setString(A0_19.taskInfo.target .. "/" .. A0_19.taskInfo.target)
  A0_19:refreshBtnStatus()
end
function prototype.onGiveUpTask(A0_20)
  A0_20:onBtnSkipTask()
end
function prototype.onDrawpTaskReward(A0_21)
  A0_21:onBtnSkipTask()
end
function prototype.onMenuClose(A0_22)
  local L1_23
  L1_23 = A0_22.progress
  L1_23 = L1_23 >= A0_22.taskInfo.target
  if L1_23 then
    Logic:Get("NewMonopoly"):PostDrawTaskReward(A0_22.info.tasks[1])
    return
  end
  SceneHelper:removePrompt(A0_22.rootNode)
end
function prototype.onBtnGiveUp(A0_24)
  Prompt:Confirm(A0_24, "", TwGetStr(115073), A0_24.confirmGiveUp, Prompt.PROMPT_TYPE.SELECT)
end
function prototype.confirmGiveUp(A0_25)
  Logic:Get("NewMonopoly"):PostGiveUpTask(A0_25.info.tasks[1])
end
function prototype.onBtnSkipTask(A0_26)
  SceneHelper:removePrompt(A0_26.rootNode)
end
function prototype.onBtnAcceptTask(A0_27)
  Logic:Get("NewMonopoly"):PostAcceptTask(A0_27.info.tasks[1])
end
function prototype.onBtnGoToTask(A0_28)
  local L1_29, L2_30
  L1_29 = {}
  L1_29.CROSS_BATTLE_NUM = "BattleCopy"
  L1_29.PASS_ELITE_TIMES = "EliteCampaign"
  L1_29.DEFY_MATCH_NUM = "FightPvp"
  L1_29.TALISMAN_LOOK_FOR = "FabaoLookFor"
  L2_30 = A0_28.taskInfo
  L2_30 = L2_30.targetType
  if L2_30 == "ATTACK_DEMOG_TIMES" then
    L2_30 = MsgDemog
    L2_30 = L2_30.Post
    L2_30(L2_30, "ACTIVE_INFO")
    return
  end
  L2_30 = A0_28.taskInfo
  L2_30 = L2_30.targetType
  L2_30 = L1_29[L2_30]
  if L2_30 then
    SceneHelper:runWithScene(L2_30, A0_28.rootNode)
    return
  end
end
function prototype.onBtnCompleteTask(A0_31)
  Prompt:Confirm(A0_31, "", TwGetStr(115074, A0_31.taskInfo.completeCost), A0_31.confirmComplete, Prompt.PROMPT_TYPE.SELECT)
end
function prototype.confirmComplete(A0_32)
  if not Logic:Get("PlayerInfo"):IsMoneyEnough(A0_32.taskInfo.completeCost) then
    Logic:Get("Main"):PromptCharge()
    return
  end
  Logic:Get("NewMonopoly"):PostCompleteTask(A0_32.info.tasks[1])
end
function prototype.onBtnDrawReward(A0_33)
  Logic:Get("NewMonopoly"):PostDrawTaskReward(A0_33.info.tasks[1])
end
function prototype.OnPushMainInfo(A0_34)
  SceneHelper:runWithScene("DevilMain", A0_34.rootNode)
end
