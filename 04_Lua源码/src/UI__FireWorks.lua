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
L0_0 = 1034
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
  super.onEnter(A0_7)
  A0_7.sendData = {}
  A0_7.imgjade:setVisible(false)
  A0_7.ttfTitle:setColor(ccc3(255, 183, 18))
  A0_7.ttfTitle:setString(Logic:Get("Gift"):GetActivityGift().name)
  A0_7.ttfTitle:setStyle(kCCLabelTTFStyleOutline)
  if Logic:Get("Lock"):checkStatusById("LOCK_SMASH_50") then
    A0_7.nodFifty:setVisible(false)
    A0_7.nodOnce:setPositionX(_UPVALUE0_.LEFT)
    A0_7.nodTenth:setPositionX(_UPVALUE0_.RIGHT)
  end
  if Logic:Get("Lock"):checkStatusById("LOCK_SMASH_10") then
    A0_7.nodFifty:setVisible(false)
    A0_7.nodTenth:setVisible(false)
    A0_7.nodOnce:setPositionX(_UPVALUE0_.MIDDLE)
  end
  Logic:Get("Egg"):PostLoadEggInfo()
  Logic:Get("Egg"):On(Logic.Egg.EVT.LOAD_EGG_INFO, A0_7:Event("onloadEggInfo"))
  Logic:Get("Egg"):On(Logic.Egg.EVT.SMASH, A0_7:Event("onSmash"))
  Logic:Get("Egg"):On(Logic.Egg.EVT.SMASH_FAILED, A0_7:Event("onSmashFailed"))
  Logic:Get("Egg"):On(Logic.Egg.EVT.ON_CONFIRM, A0_7:Event("onConfirm"))
  Logic:Get("Mall"):On(Logic.Mall.EVT.GET_LOTTERY_LIST, A0_7:Event("onGetLotteryList"))
  A0_7.data = {}
  A0_7.tableIdx = 1
  A0_7.tableViewControl = TableViewEx.prototype:createList(A0_7, A0_7.nodLst, 1, false)
  A0_7.tableViewControl.tableView:setDirection(kCCScrollViewDirectionVertical)
  A0_7.tableViewControl.tableView:setTouchEnabled(false)
  A0_7.nodLst:addChild(A0_7.tableViewControl.tableView)
end
function prototype.onBtnReturn(A0_8, A1_9, A2_10)
  if A0_8.smashRequestPending or A0_8.smashAnimationPending then
    return
  end
  SceneHelper:runWithScene("GiftActivityList", A0_8.rootNode)
end
function prototype.onBtnCheck(A0_11, A1_12, A2_13)
  MsgPlayer:Post("GET_LOTTERY_LIST")
end
function prototype.onGetLotteryList(A0_14)
  local L1_15, L2_16, L3_17, L4_18, L5_19, L6_20
  L1_15 = Logic
  L1_15 = L1_15.Get
  L1_15 = L1_15(L2_16, L3_17)
  L1_15 = L1_15.initItemData
  L1_15(L2_16)
  L1_15 = Logic
  L1_15 = L1_15.Get
  L1_15 = L1_15(L2_16, L3_17)
  L1_15 = L1_15.GetTabData
  L1_15 = L1_15(L2_16)
  L1_15 = L1_15 or {}
  for L5_19, L6_20 in L2_16(L3_17) do
    if L6_20.kind == Logic.Mall.ITEM_KIND.TOKEN_COIN then
      Logic:Get("Mall"):SetTokenCoinData(L6_20)
      Logic:Get("Mall"):setIsFrom("FireWorks")
      SceneHelper:pushScene("MallExchange", A0_14.rootNode)
      return
    end
  end
  L5_19 = 105285
  L6_20 = L4_18(L5_19)
  L2_16(L3_17, L4_18, L5_19, L6_20, L4_18(L5_19))
end
function prototype.onBtnOnce(A0_21, A1_22, A2_23)
  A0_21:SendMsg(_UPVALUE0_.ONCE)
end
function prototype.onBtnTen(A0_24, A1_25, A2_26)
  A0_24:SendMsg(_UPVALUE0_.TENTH)
end
function prototype.onBtnFifty(A0_27, A1_28, A2_29)
  A0_27:SendMsg(_UPVALUE0_.FIFTY)
end
function prototype.SendMsg(A0_30, A1_31)
  A0_30.sendData = A1_31
  A0_30:CaulateCost(A1_31)
end
function prototype.CaulateCost(A0_32, A1_33)
  local L2_34
  L2_34 = Logic
  L2_34 = L2_34.Get
  L2_34 = L2_34(L2_34, "Egg")
  L2_34 = L2_34.GetCost
  L2_34 = L2_34(L2_34, A1_33.TIMES)
  if L2_34 > 0 then
    if L2_34 > Logic:Get("PlayerInfo"):GetPlayerAllJade() then
      Logic:Get("Main"):PromptCharge()
      return
    end
    Prompt:ConfirmRecord(A0_32, "", TwGetStr(117002, L2_34, A1_33.TIMES), A0_32.Send, Prompt.PROMPT_TYPE.SELECT, nil, A1_33.PROMPT_KEY)
    return
  end
  A0_32:Send()
end
function prototype.Send(A0_35)
  if A0_35.smashRequestPending then
    return
  end
  A0_35.smashRequestPending = true
  A0_35:setSmashButtonsEnabled(false)
  Singleton(Timer):After(10000, A0_35:Event("SMASH_REQUEST_GUARD", function()
    _UPVALUE0_:onSmashFailed()
  end))
  Logic:Get("Egg"):PostSmash(A0_35.sendData.ID or 0)
end
function prototype.setSmashButtonsEnabled(A0_36, A1_37)
  A0_36.btnOnce:setEnabled(A1_37)
  A0_36.btnTen:setEnabled(A1_37)
  A0_36.btnFifty:setEnabled(A1_37)
end
function prototype.onSmashFailed(A0_38)
  A0_38.smashRequestPending = false
  if A0_38.eventTracer:Exist("SMASH_REQUEST_GUARD") then
    A0_38:EventTracer():Cancel("SMASH_REQUEST_GUARD")
  end
  A0_38:setSmashButtonsEnabled(true)
end
function prototype.onloadEggInfo(A0_39)
  local L1_40, L2_41, L3_42
  L1_40 = Logic
  L2_41 = L1_40
  L1_40 = L1_40.Get
  L3_42 = "Egg"
  L1_40 = L1_40(L2_41, L3_42)
  L2_41 = L1_40
  L1_40 = L1_40.GetEggInfo
  L1_40 = L1_40(L2_41)
  L2_41 = A0_39.ttfJade
  L3_42 = L2_41
  L2_41 = L2_41.setStyle
  L2_41(L3_42, kCCLabelTTFStyleOutline)
  L2_41 = A0_39.ttfJade
  L3_42 = L2_41
  L2_41 = L2_41.setString
  L2_41(L3_42, L1_40.totalCurrency)
  L2_41 = A0_39.ttfJade
  L3_42 = L2_41
  L2_41 = L2_41.getPositionX
  L2_41 = L2_41(L3_42)
  L3_42 = A0_39.ttfJade
  L3_42 = L3_42.getContentSize
  L3_42 = L3_42(L3_42)
  L3_42 = L3_42.width
  L2_41 = L2_41 + L3_42
  L3_42 = A0_39.imgjade
  L3_42 = L3_42.getContentSize
  L3_42 = L3_42(L3_42)
  L3_42 = L3_42.width
  L2_41 = L2_41 + L3_42
  L3_42 = A0_39.imgjade
  L3_42 = L3_42.setPositionX
  L3_42(L3_42, L2_41)
  L3_42 = A0_39.imgjade
  L3_42 = L3_42.setVisible
  L3_42(L3_42, true)
  L3_42 = A0_39.ttfFireCount
  L3_42 = L3_42.setStyle
  L3_42(L3_42, kCCLabelTTFStyleOutline)
  L3_42 = A0_39.ttfFireCount
  L3_42 = L3_42.setString
  L3_42(L3_42, L1_40.hammer or 0)
  L3_42 = table
  L3_42 = L3_42.empty
  L3_42 = L3_42(L1_40.topRewardVo or {})
  if not L3_42 then
    L3_42 = A0_39.ttfLastReward
    L3_42 = L3_42.setStyle
    L3_42(L3_42, kCCLabelTTFStyleOutline)
    L3_42 = L1_40.topRewardVo
    L3_42 = L3_42.rewardResults
    if L3_42 then
      L3_42 = Logic
      L3_42 = L3_42.Get
      L3_42 = L3_42(L3_42, "Reward")
      L3_42 = L3_42.RewardTreaTip
      L3_42 = L3_42(L3_42, L1_40.topRewardVo.rewardResults[1])
      A0_39.ttfLastReward:setString(L3_42)
    end
    L3_42 = A0_39.ttfLastName
    L3_42 = L3_42.setStyle
    L3_42(L3_42, kCCLabelTTFStyleOutline)
    L3_42 = L1_40.topRewardVo
    L3_42 = L3_42.name
    if L3_42 then
      L3_42 = A0_39.ttfLastName
      L3_42 = L3_42.setString
      L3_42(L3_42, TwGetStr(110508, L1_40.topRewardVo.name))
    end
  end
  L3_42 = L1_40.eggRewardVos
  L3_42 = L3_42 or {}
  A0_39.list = L3_42
  L3_42 = A0_39.getLstData
  L3_42 = L3_42(A0_39)
  A0_39.data = L3_42
  L3_42 = A0_39.tableViewControl
  L3_42 = L3_42.RequireUpdate
  L3_42(L3_42)
  L3_42 = A0_39.list
  L3_42 = #L3_42
  if L3_42 > _UPVALUE0_ + 1 then
    L3_42 = A0_39.eventTracer
    L3_42 = L3_42.Exist
    L3_42 = L3_42(L3_42, "updateRewardList")
    if not L3_42 then
      L3_42 = Singleton
      L3_42 = L3_42(Timer)
      L3_42 = L3_42.Repeat
      L3_42(L3_42, _UPVALUE1_, A0_39:Event("updateRewardList"))
    end
  end
end
function prototype.onSmash(A0_43)
  local L1_44, L2_45
  A0_43.smashRequestPending = false
  L1_44 = A0_43.eventTracer
  L2_45 = L1_44
  L1_44 = L1_44.Exist
  L1_44 = L1_44(L2_45, "SMASH_REQUEST_GUARD")
  if L1_44 then
    L2_45 = A0_43
    L1_44 = A0_43.EventTracer
    L1_44 = L1_44(L2_45)
    L2_45 = L1_44
    L1_44 = L1_44.Cancel
    L1_44(L2_45, "SMASH_REQUEST_GUARD")
  end
  L2_45 = A0_43
  L1_44 = A0_43.onloadEggInfo
  L1_44(L2_45)
  L2_45 = A0_43
  L1_44 = A0_43.setSmashButtonsEnabled
  L1_44(L2_45, false)
  A0_43.smashAnimationPending = true
  L1_44 = Logic
  L2_45 = L1_44
  L1_44 = L1_44.Get
  L1_44 = L1_44(L2_45, "Egg")
  L2_45 = L1_44
  L1_44 = L1_44.IsTopReward
  L1_44 = L1_44(L2_45)
  L2_45 = ""
  if L1_44 then
    L2_45 = _UPVALUE0_.TopReward
  else
    L2_45 = _UPVALUE0_[A0_43.sendData.ID]
  end
  if A0_43.ani then
    A0_43.ani:RemoveAnimation()
    A0_43.ani = nil
  end
  A0_43.ani = Logic:Get("AniMgr"):NewCCB(L2_45, A0_43.rootNode, ccp(320, 500), 0, nil, nil)
  if A0_43.ani then
    A0_43.ani:RunAni(nil, nil, bind(A0_43.aniEnd, A0_43))
    if A0_43.eventTracer:Exist("SMASH_ANIMATION_GUARD") then
      A0_43:EventTracer():Cancel("SMASH_ANIMATION_GUARD")
    end
    Singleton(Timer):After(5000, A0_43:Event("SMASH_ANIMATION_GUARD", function()
      _UPVALUE0_:aniEnd()
    end))
  else
    A0_43:aniEnd()
  end
end
function prototype.aniEnd(A0_46)
  local L1_47
  L1_47 = A0_46.smashAnimationPending
  L1_47 = L1_47 == true
  A0_46.smashAnimationPending = false
  if A0_46.eventTracer:Exist("SMASH_ANIMATION_GUARD") then
    A0_46:EventTracer():Cancel("SMASH_ANIMATION_GUARD")
  end
  A0_46:setSmashButtonsEnabled(true)
  if A0_46.ani then
    A0_46.ani:RemoveAnimation()
    A0_46.ani = nil
  end
  if L1_47 then
    Logic:Get("Egg"):PromptResult()
  end
end
function prototype.getLstData(A0_48)
  local L1_49
  L1_49 = table
  L1_49 = L1_49.empty
  L1_49 = L1_49(A0_48.list or {})
  if L1_49 then
    L1_49 = {}
    return L1_49
  end
  L1_49 = A0_48.list
  L1_49 = #L1_49
  if L1_49 <= _UPVALUE0_ + 1 then
    L1_49 = A0_48.list
    return L1_49
  end
  L1_49 = {}
  if A0_48.tableIdx + _UPVALUE0_ <= #A0_48.list then
    for _FORV_5_ = A0_48.tableIdx, A0_48.tableIdx + _UPVALUE0_ do
      table.insert(L1_49, A0_48.list[_FORV_5_])
    end
    return L1_49
  end
  for _FORV_6_ = A0_48.tableIdx, #A0_48.list do
    table.insert(L1_49, A0_48.list[_FORV_6_])
  end
  for _FORV_6_ = 1, _UPVALUE0_ - (#A0_48.list - A0_48.tableIdx) do
    table.insert(L1_49, A0_48.list[_FORV_6_])
  end
  return L1_49
end
function prototype.updateRewardList(A0_50)
  A0_50.tableIdx = A0_50.tableIdx + 1
  A0_50.tableIdx = A0_50.tableIdx > #A0_50.list and 1 or A0_50.tableIdx
  A0_50.data = A0_50:getLstData()
  A0_50.tableViewControl:RequireUpdateWithoutAnimat()
end
function prototype.onConfirm(A0_51)
  A0_51:aniEnd()
end
function prototype.cellSizeForTable(A0_52, ...)
  return CCSizeMake(200, 70)
end
function prototype.tableCellAtIndex(A0_54, A1_55, A2_56, A3_57, A4_58)
  local L5_59
  if not A3_57 then
    L5_59 = CCTableViewCellEx
    L5_59 = L5_59.create
    L5_59 = L5_59(L5_59)
    A3_57 = L5_59
    L5_59 = Tw
    L5_59 = L5_59.Controller
    L5_59 = L5_59.load
    L5_59 = L5_59(L5_59, "BrokenEggItem", A0_54.rootNode)
    L5_59:Refrash(A0_54.data[A2_56 + 1])
    A3_57:addChild(L5_59, 0, 2)
  else
    L5_59 = A3_57.getChildByTag
    L5_59 = L5_59(A3_57, 2)
    L5_59 = L5_59.Refrash
    L5_59(L5_59, A0_54.data[A2_56 + 1])
  end
  return A3_57
end
function prototype.numberOfCellsInTableView(A0_60, A1_61)
  if table.empty(A0_60.data or {}) then
    return 0
  end
  return #A0_60.data
end
function prototype.tableCellTouched(A0_62, A1_63, A2_64)
end
function prototype.tablePageTurn(A0_65, A1_66)
  A0_65.tableViewControl:RequireUpdate()
end
