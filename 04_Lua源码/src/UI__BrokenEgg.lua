local L0_0
L0_0 = module
L0_0((...), package.seeall)
L0_0 = require
L0_0("SceneHelper")
L0_0 = require
L0_0("TableViewEx")
L0_0 = require
L0_0("BtnPosition")
L0_0 = BtnPosition
L0_0 = L0_0.prototype
L0_0 = L0_0.extend
L0_0 = L0_0(L0_0)
prototype = L0_0
L0_0 = 1014
function prototype.initialize(A0_1, ...)
  local L3_3, L4_4
  L3_3 = super
  L3_3 = L3_3.initialize
  L4_4 = A0_1
  L3_3(L4_4, ...)
end
function prototype.dispose(A0_5, ...)
  super.dispose(A0_5)
end
function prototype.onEnter(A0_7)
  local L1_8, L2_9, L3_10
  L1_8 = super
  L1_8 = L1_8.onEnter
  L2_9 = A0_7
  L1_8(L2_9)
  L1_8 = {}
  A0_7.sendData = L1_8
  L1_8 = Logic
  L2_9 = L1_8
  L1_8 = L1_8.Get
  L3_10 = "Gift"
  L1_8 = L1_8(L2_9, L3_10)
  L2_9 = L1_8
  L1_8 = L1_8.GetActivityGift
  L1_8 = L1_8(L2_9)
  L2_9 = A0_7.ttfTitle
  L3_10 = L2_9
  L2_9 = L2_9.setColor
  L2_9(L3_10, ccc3(255, 183, 18))
  L2_9 = A0_7.ttfTitle
  L3_10 = L2_9
  L2_9 = L2_9.setString
  L2_9(L3_10, L1_8.name)
  L2_9 = A0_7.ttfTitle
  L3_10 = L2_9
  L2_9 = L2_9.setStyle
  L2_9(L3_10, kCCLabelTTFStyleOutline)
  L2_9 = KFDBGetRecord
  L3_10 = "LanguageSetting"
  L2_9 = L2_9(L3_10, _UPVALUE0_)
  L3_10 = ReplaceStringTab
  L3_10 = L3_10(L2_9.content)
  A0_7.ttfDesr:setString(L3_10)
  if Logic:Get("Lock"):checkStatusById("LOCK_SMASH_50") then
    A0_7.nodFifty:setVisible(false)
    A0_7.nodOnce:setPositionX(_UPVALUE1_.LEFT)
    A0_7.nodTenth:setPositionX(_UPVALUE1_.RIGHT)
  end
  if Logic:Get("Lock"):checkStatusById("LOCK_SMASH_10") then
    A0_7.nodFifty:setVisible(false)
    A0_7.nodTenth:setVisible(false)
    A0_7.nodOnce:setPositionX(_UPVALUE1_.MIDDLE)
  end
  Logic:Get("Egg"):PostLoadEggInfo()
  Logic:Get("Egg"):On(Logic.Egg.EVT.LOAD_EGG_INFO, A0_7:Event("onloadEggInfo"))
  Logic:Get("Egg"):On(Logic.Egg.EVT.SMASH, A0_7:Event("onSmash"))
  Logic:Get("Egg"):On(Logic.Egg.EVT.SMASH_FAILED, A0_7:Event("onSmashFailed"))
  Logic:Get("Egg"):On(Logic.Egg.EVT.ON_CONFIRM, A0_7:Event("onConfirm"))
  A0_7.data = {}
  A0_7.tableIdx = 1
  A0_7.tableViewControl = TableViewEx.prototype:createList(A0_7, A0_7.nodLst, 1, false)
  A0_7.tableViewControl.tableView:setDirection(kCCScrollViewDirectionVertical)
  A0_7.tableViewControl.tableView:setTouchEnabled(false)
  A0_7.nodLst:addChild(A0_7.tableViewControl.tableView)
end
function prototype.onBtnReturn(A0_11, A1_12, A2_13)
  if A0_11.smashRequestPending or A0_11.smashAnimationPending then
    return
  end
  SceneHelper:runWithScene("GiftActivityList", A0_11.rootNode)
end
function prototype.onBtnCheck(A0_14, A1_15, A2_16)
  SceneHelper:runWithScene("BrokenEggReward", A0_14.rootNode)
end
function prototype.onBtnOnce(A0_17, A1_18, A2_19)
  A0_17:SendMsg(_UPVALUE0_.ONCE)
end
function prototype.onBtnTen(A0_20, A1_21, A2_22)
  A0_20:SendMsg(_UPVALUE0_.TENTH)
end
function prototype.onBtnFifty(A0_23, A1_24, A2_25)
  A0_23:SendMsg(_UPVALUE0_.FIFTY)
end
function prototype.SendMsg(A0_26, A1_27)
  local L2_28
  A0_26.sendData = A1_27
  L2_28 = Logic
  L2_28 = L2_28.Get
  L2_28 = L2_28(L2_28, "Egg")
  L2_28 = L2_28.IsOverTimes
  L2_28 = L2_28(L2_28, A1_27.TIMES)
  if L2_28 then
    L2_28 = Logic
    L2_28 = L2_28.Get
    L2_28 = L2_28(L2_28, "Egg")
    L2_28 = L2_28.GetLeftSmashTime
    L2_28 = L2_28(L2_28)
    if L2_28 > 0 then
      A0_26.sendData = A1_27
      Prompt:Confirm(A0_26, "", TwGetStr(110505, L2_28), A0_26.CaulateCost, Prompt.PROMPT_TYPE.SELECT)
      return
    end
    Prompt:Fail(110504)
    return
  end
  L2_28 = A0_26.CaulateCost
  L2_28(A0_26, A1_27)
end
function prototype.CaulateCost(A0_29, A1_30)
  local L2_31, L3_32
  L2_31 = Logic
  L3_32 = L2_31
  L2_31 = L2_31.Get
  L2_31 = L2_31(L3_32, "Egg")
  L3_32 = L2_31
  L2_31 = L2_31.caulateSmashCost
  L3_32 = L2_31(L3_32, A1_30.TIMES)
  if L2_31 <= 0 then
    return
  end
  if L3_32 > 0 then
    if L3_32 > Logic:Get("PlayerInfo"):GetPlayerAllJade() then
      Logic:Get("Main"):PromptCharge()
      return
    end
    Prompt:ConfirmRecord(A0_29, "", TwGetStr(110506, L3_32), A0_29.Send, Prompt.PROMPT_TYPE.SELECT, nil, A1_30.PROMPT_KEY)
    return
  end
  A0_29:Send()
end
function prototype.Send(A0_33)
  if A0_33.smashRequestPending then
    return
  end
  A0_33.smashRequestPending = true
  A0_33:setSmashButtonsEnabled(false)
  Singleton(Timer):After(10000, A0_33:Event("SMASH_REQUEST_GUARD", function()
    _UPVALUE0_:onSmashFailed()
  end))
  Logic:Get("Egg"):PostSmash(A0_33.sendData.ID or 0)
end
function prototype.setSmashButtonsEnabled(A0_34, A1_35)
  A0_34.btnOnce:setEnabled(A1_35)
  A0_34.btnTen:setEnabled(A1_35)
  A0_34.btnFifty:setEnabled(A1_35)
end
function prototype.onSmashFailed(A0_36)
  A0_36.smashRequestPending = false
  if A0_36.eventTracer:Exist("SMASH_REQUEST_GUARD") then
    A0_36:EventTracer():Cancel("SMASH_REQUEST_GUARD")
  end
  A0_36:setSmashButtonsEnabled(true)
end
function prototype.onloadEggInfo(A0_37)
  local L1_38, L2_39, L3_40, L4_41
  L1_38 = Logic
  L2_39 = L1_38
  L1_38 = L1_38.Get
  L3_40 = "Egg"
  L1_38 = L1_38(L2_39, L3_40)
  L2_39 = L1_38
  L1_38 = L1_38.GetEggInfo
  L1_38 = L1_38(L2_39)
  L2_39 = A0_37.ttfJade
  L3_40 = L2_39
  L2_39 = L2_39.setStyle
  L4_41 = kCCLabelTTFStyleOutline
  L2_39(L3_40, L4_41)
  L2_39 = A0_37.ttfJade
  L3_40 = L2_39
  L2_39 = L2_39.setString
  L4_41 = TwGetStr
  L4_41 = L4_41(105246, L1_38.totalCurrency)
  L2_39(L3_40, L4_41, L4_41(105246, L1_38.totalCurrency))
  L2_39 = A0_37.ttfHammer
  L3_40 = L2_39
  L2_39 = L2_39.setStyle
  L4_41 = kCCLabelTTFStyleOutline
  L2_39(L3_40, L4_41)
  L2_39 = A0_37.ttfHammer
  L3_40 = L2_39
  L2_39 = L2_39.setString
  L4_41 = TwGetStr
  L4_41 = L4_41(110502)
  L2_39(L3_40, L4_41, L4_41(110502))
  L2_39 = A0_37.ttfHammerCnt
  L3_40 = L2_39
  L2_39 = L2_39.setStyle
  L4_41 = kCCLabelTTFStyleOutline
  L2_39(L3_40, L4_41)
  L2_39 = A0_37.ttfHammerCnt
  L3_40 = L2_39
  L2_39 = L2_39.setString
  L4_41 = L1_38.hammer
  L4_41 = L4_41 or 0
  L2_39(L3_40, L4_41)
  L2_39 = A0_37.ttfFree
  L3_40 = L2_39
  L2_39 = L2_39.setStyle
  L4_41 = kCCLabelTTFStyleOutline
  L2_39(L3_40, L4_41)
  L2_39 = A0_37.ttfFree
  L3_40 = L2_39
  L2_39 = L2_39.setString
  L4_41 = TwGetStr
  L4_41 = L4_41(110501)
  L2_39(L3_40, L4_41, L4_41(110501))
  L2_39 = Logic
  L3_40 = L2_39
  L2_39 = L2_39.Get
  L4_41 = "Egg"
  L2_39 = L2_39(L3_40, L4_41)
  L3_40 = L2_39
  L2_39 = L2_39.GetCongifValueByKey
  L4_41 = "SMASH_EGG:INIT_FREE_TIMES"
  L2_39 = L2_39(L3_40, L4_41)
  L3_40 = L1_38.freeSmashCount
  if L2_39 >= L3_40 then
    L3_40 = L1_38.freeSmashCount
    L3_40 = L2_39 - L3_40
  else
    L3_40 = L3_40 or 0
  end
  L4_41 = A0_37.ttfFreeTimes
  L4_41 = L4_41.setStyle
  L4_41(L4_41, kCCLabelTTFStyleOutline)
  L4_41 = A0_37.ttfFreeTimes
  L4_41 = L4_41.setString
  L4_41(L4_41, L3_40)
  L4_41 = table
  L4_41 = L4_41.empty
  L4_41 = L4_41(L1_38.topRewardVo or {})
  if not L4_41 then
    L4_41 = A0_37.ttfLastReward
    L4_41 = L4_41.setStyle
    L4_41(L4_41, kCCLabelTTFStyleOutline)
    L4_41 = L1_38.topRewardVo
    L4_41 = L4_41.rewardResults
    if L4_41 then
      L4_41 = Logic
      L4_41 = L4_41.Get
      L4_41 = L4_41(L4_41, "Reward")
      L4_41 = L4_41.RewardTreaTip
      L4_41 = L4_41(L4_41, L1_38.topRewardVo.rewardResults[1])
      A0_37.ttfLastReward:setString(L4_41)
    end
    L4_41 = A0_37.ttfLastName
    L4_41 = L4_41.setStyle
    L4_41(L4_41, kCCLabelTTFStyleOutline)
    L4_41 = L1_38.topRewardVo
    L4_41 = L4_41.name
    if L4_41 then
      L4_41 = A0_37.ttfLastName
      L4_41 = L4_41.setString
      L4_41(L4_41, TwGetStr(110508, L1_38.topRewardVo.name))
    end
  end
  L4_41 = L1_38.eggRewardVos
  L4_41 = L4_41 or {}
  A0_37.list = L4_41
  L4_41 = A0_37.getLstData
  L4_41 = L4_41(A0_37)
  A0_37.data = L4_41
  L4_41 = A0_37.tableViewControl
  L4_41 = L4_41.RequireUpdate
  L4_41(L4_41)
  L4_41 = A0_37.list
  L4_41 = #L4_41
  if L4_41 > _UPVALUE0_ + 1 then
    L4_41 = A0_37.eventTracer
    L4_41 = L4_41.Exist
    L4_41 = L4_41(L4_41, "updateRewardList")
    if not L4_41 then
      L4_41 = Singleton
      L4_41 = L4_41(Timer)
      L4_41 = L4_41.Repeat
      L4_41(L4_41, _UPVALUE1_, A0_37:Event("updateRewardList"))
    end
  end
end
function prototype.onSmash(A0_42)
  local L1_43, L2_44
  A0_42.smashRequestPending = false
  L1_43 = A0_42.eventTracer
  L2_44 = L1_43
  L1_43 = L1_43.Exist
  L1_43 = L1_43(L2_44, "SMASH_REQUEST_GUARD")
  if L1_43 then
    L2_44 = A0_42
    L1_43 = A0_42.EventTracer
    L1_43 = L1_43(L2_44)
    L2_44 = L1_43
    L1_43 = L1_43.Cancel
    L1_43(L2_44, "SMASH_REQUEST_GUARD")
  end
  L2_44 = A0_42
  L1_43 = A0_42.onloadEggInfo
  L1_43(L2_44)
  L1_43 = A0_42.nodEgg
  L2_44 = L1_43
  L1_43 = L1_43.setVisible
  L1_43(L2_44, false)
  L2_44 = A0_42
  L1_43 = A0_42.setSmashButtonsEnabled
  L1_43(L2_44, false)
  A0_42.smashAnimationPending = true
  L1_43 = Logic
  L2_44 = L1_43
  L1_43 = L1_43.Get
  L1_43 = L1_43(L2_44, "Egg")
  L2_44 = L1_43
  L1_43 = L1_43.IsTopReward
  L1_43 = L1_43(L2_44)
  L2_44 = ""
  if L1_43 then
    L2_44 = "UI/uigoldegg"
  else
    L2_44 = "UI/uigoldegg03"
  end
  if A0_42.ani then
    A0_42.ani:RemoveAnimation()
    A0_42.ani = nil
  end
  A0_42.ani = Logic:Get("AniMgr"):NewCCB(L2_44, A0_42.rootNode, ccp(320, 500), 0, nil, nil)
  if A0_42.ani then
    A0_42.ani:RunAni(nil, nil, bind(A0_42.aniEnd, A0_42))
    if A0_42.eventTracer:Exist("SMASH_ANIMATION_GUARD") then
      A0_42:EventTracer():Cancel("SMASH_ANIMATION_GUARD")
    end
    Singleton(Timer):After(5000, A0_42:Event("SMASH_ANIMATION_GUARD", function()
      _UPVALUE0_:aniEnd()
    end))
  else
    A0_42:aniEnd()
  end
end
function prototype.aniEnd(A0_45)
  A0_45.smashAnimationPending = false
  if A0_45.eventTracer:Exist("SMASH_ANIMATION_GUARD") then
    A0_45:EventTracer():Cancel("SMASH_ANIMATION_GUARD")
  end
  A0_45.nodEgg:setVisible(true)
  A0_45:setSmashButtonsEnabled(true)
  if A0_45.ani then
    A0_45.ani:RemoveAnimation()
    A0_45.ani = nil
  end
end
function prototype.getLstData(A0_46)
  local L1_47
  L1_47 = table
  L1_47 = L1_47.empty
  L1_47 = L1_47(A0_46.list or {})
  if L1_47 then
    L1_47 = {}
    return L1_47
  end
  L1_47 = A0_46.list
  L1_47 = #L1_47
  if L1_47 <= _UPVALUE0_ + 1 then
    L1_47 = A0_46.list
    return L1_47
  end
  L1_47 = {}
  if A0_46.tableIdx + _UPVALUE0_ <= #A0_46.list then
    for _FORV_5_ = A0_46.tableIdx, A0_46.tableIdx + _UPVALUE0_ do
      table.insert(L1_47, A0_46.list[_FORV_5_])
    end
    return L1_47
  end
  for _FORV_6_ = A0_46.tableIdx, #A0_46.list do
    table.insert(L1_47, A0_46.list[_FORV_6_])
  end
  for _FORV_6_ = 1, _UPVALUE0_ - (#A0_46.list - A0_46.tableIdx) do
    table.insert(L1_47, A0_46.list[_FORV_6_])
  end
  return L1_47
end
function prototype.updateRewardList(A0_48)
  A0_48.tableIdx = A0_48.tableIdx + 1
  A0_48.tableIdx = A0_48.tableIdx > #A0_48.list and 1 or A0_48.tableIdx
  A0_48.data = A0_48:getLstData()
  A0_48.tableViewControl:RequireUpdateWithoutAnimat()
end
function prototype.onConfirm(A0_49)
  A0_49:aniEnd()
end
function prototype.cellSizeForTable(A0_50, ...)
  return CCSizeMake(200, 70)
end
function prototype.tableCellAtIndex(A0_52, A1_53, A2_54, A3_55, A4_56)
  local L5_57
  if not A3_55 then
    L5_57 = CCTableViewCellEx
    L5_57 = L5_57.create
    L5_57 = L5_57(L5_57)
    A3_55 = L5_57
    L5_57 = Tw
    L5_57 = L5_57.Controller
    L5_57 = L5_57.load
    L5_57 = L5_57(L5_57, "BrokenEggItem", A0_52.rootNode)
    L5_57:Refrash(A0_52.data[A2_54 + 1])
    A3_55:addChild(L5_57, 0, 2)
  else
    L5_57 = A3_55.getChildByTag
    L5_57 = L5_57(A3_55, 2)
    L5_57 = L5_57.Refrash
    L5_57(L5_57, A0_52.data[A2_54 + 1])
  end
  return A3_55
end
function prototype.numberOfCellsInTableView(A0_58, A1_59)
  if table.empty(A0_58.data or {}) then
    return 0
  end
  return #A0_58.data
end
function prototype.tableCellTouched(A0_60, A1_61, A2_62)
end
function prototype.tablePageTurn(A0_63, A1_64)
  A0_63.tableViewControl:RequireUpdate()
end
