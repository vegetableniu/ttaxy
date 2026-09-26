local L0_0
L0_0 = module
L0_0((...), package.seeall)
L0_0 = require
L0_0("Logic.Battle")
L0_0 = require
L0_0("TableViewEx")
L0_0 = require
L0_0("BtnPosition")
L0_0 = Logic
L0_0 = L0_0.Battle
prototype = BtnPosition.prototype:extend()
function prototype.initialize(A0_1, ...)
  super.initialize(A0_1, ...)
  Logic:Get("Guide"):On(Logic.Guide.EVT.STEP, A0_1:Event("updateGuide"))
  Logic:Get("Battle"):On(_UPVALUE0_.EVT.CLICK_BATTLE_COPY_FRIEND_ITEM, A0_1:Event("onClickItem"))
  Logic:Get("Battle"):On(_UPVALUE0_.EVT.EMBATTLE_SCENE_RETURN, A0_1:Event("onEmbattleSceneReturn"))
  A0_1.curPage = 1
end
function prototype.dispose(A0_3, ...)
  super.dispose(A0_3)
end
function prototype.reOpen(A0_5)
  local L1_6
  L1_6 = CCArray
  L1_6 = L1_6.create
  L1_6 = L1_6(L1_6)
  L1_6:addObject(CCDelayTime:create(0.1))
  L1_6:addObject(CCCallFuncN:create(function()
    _UPVALUE0_.tableViewControl.tableView:runUIAnimat(true)
  end))
  A0_5.rootNode:runAction(CCSequence:create(L1_6))
end
function prototype.onEnter(A0_7)
  super.onEnter(A0_7)
  Logic:Get("Guide"):check()
  if 0 == Logic:Get("Friend"):GetCommendFriendNum() or not Logic:Get("Friend"):IsNeedBattleFriend() then
    SceneHelper:pushScene("Embattle", A0_7.rootNode)
    return
  end
  A0_7:createList()
  A0_7:refresh()
end
function prototype.onExit(A0_8)
  local L1_9
end
function prototype.refresh(A0_10)
  local L1_11, L2_12
  L2_12 = A0_10
  L1_11 = A0_10.getPageNum
  L1_11 = L1_11(L2_12)
  L2_12 = L1_11 > 1
  if A0_10.tableViewControl and A0_10.tableViewControl.tableView then
    A0_10.tableViewControl.tableView:setDirection(L2_12 and kCCScrollViewDirectionBoth or kCCScrollViewDirectionVertical)
  end
  if L2_12 then
    A0_10.staPage:setString(A0_10.curPage .. "/" .. L1_11)
  end
  A0_10.staPage:setVisible(L2_12)
  A0_10.imgPageBg:setVisible(L2_12)
  A0_10.imgLeft:setVisible(L2_12)
  A0_10.imgRight:setVisible(L2_12)
end
function prototype.createList(A0_13)
  A0_13.tableViewControl = TableViewEx.prototype:createList(A0_13, A0_13.lstItems, A0_13:getPageNum())
  A0_13.tableViewControl.tableView:setDirection(kCCScrollViewDirectionBoth)
  A0_13.tableViewControl:RequireUpdate()
  A0_13.lstItems:addChild(A0_13.tableViewControl.tableView)
end
function prototype.closeSceneDelay(A0_14, A1_15)
  local L2_16
  L2_16 = A0_14.tableViewControl
  if L2_16 then
    L2_16 = A0_14.tableViewControl
    L2_16 = L2_16.tableView
    if L2_16 then
      L2_16 = A0_14.tableViewControl
      L2_16 = L2_16.tableView
      L2_16 = L2_16.runUIAnimat
      L2_16(L2_16, false)
    end
  end
  L2_16 = CCArray
  L2_16 = L2_16.create
  L2_16 = L2_16(L2_16)
  L2_16:addObject(CCDelayTime:create(0.3))
  L2_16:addObject(CCCallFuncN:create(function()
    if _UPVALUE0_ then
      _UPVALUE0_()
    end
  end))
  A0_14.rootNode:runAction(CCSequence:create(L2_16))
end
function prototype.onReturnClicked(A0_17, A1_18, A2_19)
  A0_17:closeSceneDelay(function()
    SceneHelper:popScene()
    Logic:Get("Battle"):FireEvent(Logic.Battle.EVT.BATTLE_FRIEND_SCENE_RETURN)
  end)
end
function prototype.onClickItem(A0_20, A1_21)
  local L2_22, L3_23, L4_24, L5_25, L6_26, L7_27, L8_28, L9_29, L10_30, L11_31, L12_32
  L2_22 = Logic
  L3_23 = L2_22
  L2_22 = L2_22.Get
  L4_24 = "Hero"
  L2_22 = L2_22(L3_23, L4_24)
  L3_23 = L2_22
  L2_22 = L2_22.SetFriendInfo
  L4_24 = A1_21
  L2_22(L3_23, L4_24)
  L2_22 = Logic
  L3_23 = L2_22
  L2_22 = L2_22.Get
  L4_24 = "Hero"
  L2_22 = L2_22(L3_23, L4_24)
  L3_23 = L2_22
  L2_22 = L2_22.GetCurrentEmbattle
  L2_22 = L2_22(L3_23)
  if L2_22 ~= nil then
    L3_23, L4_24 = nil, nil
    for L8_28 = 1, #L2_22 do
      for L12_32 = 1, #L10_30 do
        if L2_22[L8_28][L12_32] == ID[-1] then
          if L3_23 == nil then
            L3_23 = {L8_28, L12_32}
          else
            L2_22[L8_28][L12_32] = ID[0]
            L4_24 = {L8_28, L12_32}
          end
        elseif L2_22[L8_28][L12_32] == ID[0] then
          L4_24 = {L8_28, L12_32}
        end
      end
    end
    if L3_23 == nil and L4_24 ~= nil then
      L5_25[L6_26] = L7_27
      L5_25(L6_26, L7_27)
    end
  end
  L4_24 = A0_20
  L3_23 = A0_20.closeSceneDelay
  L3_23(L4_24, L5_25)
end
function prototype.onEmbattleSceneReturn(A0_33)
  if 0 == Logic:Get("Friend"):GetCommendFriendNum() or not Logic:Get("Friend"):IsNeedBattleFriend() then
    SceneHelper:popScene()
    Logic:Get("Battle"):FireEvent(Logic.Battle.EVT.BATTLE_FRIEND_SCENE_RETURN)
  else
    A0_33:reOpen()
  end
end
function prototype.refreshLstItems(A0_34, A1_35, A2_36)
  if nil == Logic:Get("Friend"):GetCommendFriend() or nil == Logic:Get("Friend"):GetCommendFriend()[A2_36] then
    A1_35:setVisible(false)
    return
  end
  A1_35:setVisible(true)
  A1_35:ReFrashHeroInfo(Logic:Get("Friend"):GetCommendFriend()[A2_36], Logic.Friend.FRIEND_ITEM_TYPE.OTHER, A2_36)
end
function prototype.cellSizeForTable(A0_37, ...)
  return CCSizeMake(_UPVALUE0_, _UPVALUE1_)
end
function prototype.tableCellAtIndex(A0_39, A1_40, A2_41, A3_42, A4_43)
  local L5_44, L6_45, L7_46
  L5_44 = 1
  if A4_43 > 1 then
    L6_45 = A4_43 - 1
    L7_46 = _UPVALUE0_
    L6_45 = L6_45 * L7_46
    L6_45 = L6_45 + A2_41
    L6_45 = L6_45 + 1
  else
    L6_45 = L6_45 or A2_41 + 1
  end
  if not A3_42 then
    L7_46 = CCTableViewCellEx
    L7_46 = L7_46.create
    L7_46 = L7_46(L7_46)
    A3_42 = L7_46
    L7_46 = A0_39.createFriendCellItem
    L7_46(A0_39, L6_45, A3_42, L5_44)
  else
    L7_46 = A3_42.getChildByTag
    L7_46 = L7_46(A3_42, L5_44)
    if L7_46 then
      A0_39:refreshLstItems(L7_46, L6_45)
    end
  end
  return A3_42
end
function prototype.actionFinish(A0_47, A1_48)
  if not Logic:Get("Guide"):isGuiding() then
    return
  end
  if A1_48:cellAtIndex(0) == nil then
    return
  end
  if A1_48:cellAtIndex(0):getChildByTag(1) == nil then
    return
  end
  A1_48:cellAtIndex(0):getChildByTag(1):updateGuide()
end
function prototype.createFriendCellItem(A0_49, A1_50, A2_51, A3_52)
  local L4_53
  L4_53 = Tw
  L4_53 = L4_53.Controller
  L4_53 = L4_53.load
  L4_53 = L4_53(L4_53, "FriendItem", A0_49.rootNode)
  L4_53:setPosition(CCPoint((_UPVALUE0_ - _UPVALUE1_) / 2, 0))
  L4_53:setAnchorPoint(CCPointMake(0.5, 0.5))
  A2_51:addChild(L4_53, 0, A3_52)
  A0_49:refreshLstItems(L4_53, A1_50)
end
function prototype.numberOfCellsInTableView(A0_54, A1_55)
  local L2_56, L3_57
  L2_56 = Logic
  L3_57 = L2_56
  L2_56 = L2_56.Get
  L2_56 = L2_56(L3_57, "Friend")
  L3_57 = L2_56
  L2_56 = L2_56.GetCommendFriend
  L2_56 = L2_56(L3_57)
  if L2_56 then
    L3_57 = #L2_56
  else
    L3_57 = L3_57 or 0
  end
  return A0_54:getPageNum() > 1 and _UPVALUE0_ or L3_57
end
function prototype.tableCellTouched(A0_58, A1_59, A2_60)
end
function prototype.tablePageTurn(A0_61, A1_62)
  A0_61.curPage = A1_62
  if A0_61:getPageNum() > 1 then
    A0_61.tableViewControl:RequireUpdate()
  end
  A0_61:refresh()
end
function prototype.getPageNum(A0_63)
  local L1_64
  L1_64 = Logic
  L1_64 = L1_64.Get
  L1_64 = L1_64(L1_64, "Friend")
  L1_64 = L1_64.GetCommendFriend
  L1_64 = L1_64(L1_64)
  if nil == L1_64 or table.empty(L1_64) then
    return 1
  end
  if math.fmod(#L1_64, _UPVALUE0_) == 0 then
    return #L1_64 / _UPVALUE0_
  else
    return math.modf(#L1_64 / _UPVALUE0_) + 1
  end
end
function prototype.RefreshGuide(A0_65)
  if A0_65.tableViewControl ~= nil then
    A0_65.tableViewControl:RequireUpdateWithoutAnimat(1)
  end
end
function prototype.updateGuide(A0_66)
  if Logic:Get("Guide"):isActive("Partner", "Select") then
    Singleton(Timer):After(0, A0_66:Event("Delay", function()
      _UPVALUE0_:actionFinish(_UPVALUE0_.tableViewControl.tableView)
    end))
  end
end
