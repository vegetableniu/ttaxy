module((...), package.seeall)
require("SceneHelper")
require("TableViewEx")
require("Logic.Compose")
require("BtnPosition")
prototype = BtnPosition.prototype:extend()
function prototype.onNodeLoaded(A0_0, A1_1, A2_2)
end
function prototype.onBtnReturn(A0_3)
  if A0_3.progressMode then
    A0_3.progressMode = nil
    A0_3:RefrashGiftInfo()
    return
  end
  SceneHelper:runWithScene("Home", A0_3.rootNode)
end
function prototype.onEnter(A0_4)
  local L1_5
  L1_5 = super
  L1_5 = L1_5.onEnter
  L1_5(A0_4)
  L1_5 = Logic
  L1_5 = L1_5.Get
  L1_5 = L1_5(L1_5, "Gift")
  L1_5 = L1_5.On
  L1_5(L1_5, Logic.Gift.EVT.REFRESH_GIFT, A0_4:Event("RefrashGiftInfo"))
  L1_5 = Logic
  L1_5 = L1_5.Get
  L1_5 = L1_5(L1_5, "Gift")
  L1_5 = L1_5.On
  L1_5(L1_5, Logic.Gift.EVT.OPEN_PROGRESS, A0_4:Event("OpenProgress"))
  L1_5 = Logic
  L1_5 = L1_5.Get
  L1_5 = L1_5(L1_5, "Groupbuy")
  L1_5 = L1_5.On
  L1_5(L1_5, Logic.Groupbuy.EVT.REFRESH_TIP_NEW_REWARD, A0_4:Event("GroupTip"))
  L1_5 = Logic
  L1_5 = L1_5.Get
  L1_5 = L1_5(L1_5, "Gift")
  L1_5 = L1_5.PostAllGift
  L1_5(L1_5)
  L1_5 = Logic
  L1_5 = L1_5.Get
  L1_5 = L1_5(L1_5, "Gift")
  L1_5 = L1_5.PostProgressRewards
  L1_5(L1_5)
  L1_5 = Logic
  L1_5 = L1_5.Get
  L1_5 = L1_5(L1_5, "Gift")
  L1_5 = L1_5.SetGiftInfoType
  L1_5(L1_5, "Gift")
  L1_5 = Logic
  L1_5 = L1_5.Get
  L1_5 = L1_5(L1_5, "Groupbuy")
  L1_5 = L1_5.PostLoadRewardInfo
  L1_5(L1_5)
  L1_5 = {}
  A0_4.allGiftIdTable = L1_5
  L1_5 = table
  L1_5 = L1_5.empty
  L1_5 = L1_5(A0_4.allGiftIdTable)
  if L1_5 then
    L1_5 = A0_4.ttfPage
    L1_5 = L1_5.setString
    L1_5(L1_5, 1 .. "/" .. 1)
  end
  L1_5 = {}
  A0_4.allGift = L1_5
  L1_5 = math
  L1_5 = L1_5.ceil
  L1_5 = L1_5(#A0_4.allGiftIdTable / Logic.Compose.MAX_LIST)
  A0_4.page = L1_5
  L1_5 = TableViewEx
  L1_5 = L1_5.prototype
  L1_5 = L1_5.createList
  L1_5 = L1_5(L1_5, A0_4, A0_4.m_pCList, A0_4.page)
  A0_4.tableViewControl = L1_5
  L1_5 = A0_4.getTableViewOffset
  L1_5 = L1_5(A0_4)
  if L1_5 then
    A0_4.tableViewControl.tableView:setTableViewOffset(L1_5)
  end
  A0_4.tableViewControl.tableView:runUIAnimat()
  A0_4.m_pCList:addChild(A0_4.tableViewControl.tableView)
end
function prototype.TipGift(A0_6)
  if Logic:Get("Gift"):IsInitDraw() then
    if A0_6.layer:getChildByTag(11) == nil then
      A0_6:showRewardTipVip()
    end
  else
    if A0_6.aniVip ~= nil then
      A0_6.aniVip:RemoveAnimation()
    end
    A0_6.rootNode:removeChildByTag(11, true)
  end
  if Logic:Get("Gift"):IsAcitivityDraw() then
    if A0_6.layer:getChildByTag(12) == nil then
      A0_6:showRewardTipActivity()
    end
  else
    if A0_6.ani ~= nil then
      A0_6.ani:RemoveAnimation()
    end
    A0_6.rootNode:removeChildByTag(12, true)
  end
end
function prototype.GroupTip(A0_7)
  if Logic:Get("Gift"):IsAcitivityDraw() or Logic:Get("Groupbuy"):IsHasNewReward() then
    if A0_7.layer:getChildByTag(12) == nil then
      A0_7:showRewardTipActivity()
    end
  else
    if A0_7.ani ~= nil then
      A0_7.ani:RemoveAnimation()
    end
    A0_7.rootNode:removeChildByTag(12, true)
  end
end
function prototype.showRewardTipActivity(A0_8)
  local L1_9, L2_10, L3_11
  L1_9 = A0_8.btnActivityGet
  L2_10 = L1_9
  L1_9 = L1_9.getPositionX
  L1_9 = L1_9(L2_10)
  L1_9 = L1_9 + 30
  L2_10 = A0_8.btnActivityGet
  L3_11 = L2_10
  L2_10 = L2_10.getPositionY
  L2_10 = L2_10(L3_11)
  L2_10 = L2_10 + 36
  L3_11 = Logic
  L3_11 = L3_11.Get
  L3_11 = L3_11(L3_11, "AniMgr")
  L3_11 = L3_11.RunCCBAni
  L3_11 = L3_11(L3_11, "UI/uinew", A0_8, ccp(L1_9, L2_10), 0.7)
  A0_8.ani = L3_11
  L3_11 = CCSprite
  L3_11 = L3_11.create
  L3_11 = L3_11(L3_11, "images/public/tip.png")
  if L3_11 ~= nil then
    A0_8.rootNode:addChild(L3_11, 0, 12)
    L3_11:setAnchorPoint(CCPoint(0.5, 0.5))
    L3_11:setPosition(ccp(L1_9, L2_10))
    L3_11:setScale(0.8)
  end
end
function prototype.showRewardTipVip(A0_12)
  local L1_13, L2_14, L3_15
  L1_13 = A0_12.btnVipGet
  L2_14 = L1_13
  L1_13 = L1_13.getPositionX
  L1_13 = L1_13(L2_14)
  L1_13 = L1_13 + 30
  L2_14 = A0_12.btnVipGet
  L3_15 = L2_14
  L2_14 = L2_14.getPositionY
  L2_14 = L2_14(L3_15)
  L2_14 = L2_14 + 36
  L3_15 = Logic
  L3_15 = L3_15.Get
  L3_15 = L3_15(L3_15, "AniMgr")
  L3_15 = L3_15.RunCCBAni
  L3_15 = L3_15(L3_15, "UI/uinew", A0_12, ccp(L1_13, L2_14), 0.7)
  A0_12.aniVip = L3_15
  L3_15 = CCSprite
  L3_15 = L3_15.create
  L3_15 = L3_15(L3_15, "images/public/tip.png")
  if L3_15 ~= nil then
    A0_12.rootNode:addChild(L3_15, 0, 11)
    L3_15:setAnchorPoint(CCPoint(0.5, 0.5))
    L3_15:setPosition(ccp(L1_13, L2_14))
    L3_15:setScale(0.8)
  end
end
function prototype.RefrashGiftInfo(A0_16)
  local L1_17, L2_18, L3_19, L4_20, L5_21, L6_22
  L1_17 = Logic
  L1_17 = L1_17.Get
  L1_17 = L1_17(L2_18, L3_19)
  L1_17 = L1_17.HasRewardGift
  L1_17(L2_18, L3_19, L4_20)
  L1_17 = Logic
  L1_17 = L1_17.Get
  L1_17 = L1_17(L2_18, L3_19)
  L1_17 = L1_17.GetCanShowGif
  L1_17 = L1_17(L2_18)
  A0_16.allGiftIdTable = L2_18
  for L5_21, L6_22 in L2_18(L3_19) do
    table.insert(A0_16.allGiftIdTable, L6_22)
  end
  if L2_18 then
    A0_16.allGiftIdTable = L3_19
    L1_17 = L2_18
  else
    L4_20 = L1_17 or {}
    for L6_22, _FORV_7_ in L3_19(L4_20) do
      L2_18[L6_22] = _FORV_7_
    end
    L1_17 = L2_18
    L6_22 = "Gift"
    L6_22 = "POWER"
    L6_22 = L5_21
    L6_22 = L5_21
    L6_22 = L3_19.id
    L1_17[L6_22] = L3_19
    L6_22 = L4_20.id
    L1_17[L6_22] = L4_20
    L6_22 = L5_21.id
    L1_17[L6_22] = L5_21
    L6_22 = table
    L6_22 = L6_22.insert
    L6_22(A0_16.allGiftIdTable, 1, L4_20.id)
    L6_22 = table
    L6_22 = L6_22.insert
    L6_22(A0_16.allGiftIdTable, 1, L3_19.id)
    L6_22 = table
    L6_22 = L6_22.insert
    L6_22(A0_16.allGiftIdTable, 1, L5_21.id)
  end
  L2_18(L3_19)
  A0_16.allGift = L1_17
  A0_16.page = L2_18
  L2_18(L3_19, L4_20)
end
function prototype.OpenProgress(A0_23, A1_24)
  A0_23.progressMode = A1_24
  A0_23:RefrashGiftInfo()
end
function prototype.cellSizeForTable(A0_25, A1_26, A2_27, ...)
  if A0_25.progressMode then
    return CCSizeMake(588, 164)
  end
  if A0_25.allGiftIdTable[(A2_27 or 0) + 1] and A0_25.allGift[A0_25.allGiftIdTable[(A2_27 or 0) + 1]] and A0_25.allGift[A0_25.allGiftIdTable[(A2_27 or 0) + 1]].progressBanner then
    return CCSizeMake(588, 124)
  end
  return CCSizeMake(588, 164)
end
function prototype.tableCellAtIndex(A0_29, A1_30, A2_31, A3_32, A4_33)
  local L5_34, L6_35, L7_36, L8_37, L9_38, L10_39
  L5_34 = A2_31 + 1
  L6_35 = A4_33 - 1
  L7_36 = Logic
  L7_36 = L7_36.Compose
  L7_36 = L7_36.MAX_LIST
  L6_35 = L6_35 * L7_36
  L6_35 = L5_34 + L6_35
  L7_36 = A0_29.allGiftIdTable
  L7_36 = L7_36[L6_35]
  L8_37 = A0_29.allGift
  L8_37 = L8_37[L7_36]
  if L8_37 then
    L8_37 = A0_29.allGift
    L8_37 = L8_37[L7_36]
    L8_37 = L8_37.progressBanner
  end
  if L8_37 then
    L9_38 = 3
  else
    L9_38 = L9_38 or 2
  end
  if A3_32 then
    L10_39 = A3_32.getChildByTag
    L10_39 = L10_39(A3_32, L9_38)
    if L10_39 == nil then
      L10_39 = A3_32.removeAllChildrenWithCleanup
      L10_39(A3_32, true)
    end
  end
  if not A3_32 then
    L10_39 = CCTableViewCellEx
    L10_39 = L10_39.create
    L10_39 = L10_39(L10_39)
    A3_32 = L10_39
  end
  L10_39 = A3_32.getChildByTag
  L10_39 = L10_39(A3_32, L9_38)
  if L10_39 == nil then
    L10_39 = Tw.Controller:load(L8_37 and "GiftActivityItem" or "GiftItem", A0_29.rootNode)
    L10_39:ReFrashReward(A0_29.allGift[L7_36], A2_31)
    A3_32:addChild(L10_39, 0, L9_38)
  else
    L10_39:ReFrashReward(A0_29.allGift[L7_36], A2_31)
  end
  return A3_32
end
function prototype.numberOfCellsInTableView(A0_40, A1_41)
  if A0_40.page == 0 then
    A0_40.page = 1
  end
  A0_40.ttfPage:setString(A1_41 .. "/" .. A0_40.page)
  if #A0_40.allGiftIdTable == 0 then
    return 0
  end
  if A0_40.page == A1_41 then
    return #A0_40.allGiftIdTable - (A0_40.page - 1) * Logic.Hero.MAX_HEROS_PER_PAGE
  else
    return Logic.Compose.MAX_LIST
  end
end
function prototype.tableCellTouched(A0_42, A1_43, A2_44)
end
function prototype.tablePageTurn(A0_45, A1_46)
  A0_45.tableViewControl:RequireUpdate()
end
function prototype.actionFinish(A0_47, A1_48)
  if not Logic:Get("Guide"):isGuiding() then
    return
  end
  if A0_47:getTableViewOffset() == nil then
    return
  end
  if A1_48:cellAtIndex(A0_47:getTableViewOffset() - 1) == nil then
    return
  end
  if A1_48:cellAtIndex(A0_47:getTableViewOffset() - 1):getChildByTag(2) == nil then
    return
  end
  A1_48:cellAtIndex(A0_47:getTableViewOffset() - 1):getChildByTag(2):updateGuide()
end
function prototype.onBtnLeft(A0_49)
  if A0_49.tableViewControl ~= nil then
    A0_49.tableViewControl:TurnPage(-1)
  end
end
function prototype.onBtnRight(A0_50)
  if A0_50.tableViewControl ~= nil then
    A0_50.tableViewControl:TurnPage(1)
  end
end
function prototype.onbtnOpenVip(A0_51)
  SceneHelper:runWithScene("GiftCharge", A0_51.rootNode)
end
function prototype.onbtnOpenActivity(A0_52)
  SceneHelper:runWithScene("GiftActivityList", A0_52.rootNode)
end
function prototype.getTableViewOffset(A0_53)
  local L1_54, L2_55
  L1_54 = Logic
  L2_55 = L1_54
  L1_54 = L1_54.Get
  L1_54 = L1_54(L2_55, "Gift")
  L2_55 = Logic
  L2_55 = L2_55.Get
  L2_55 = L2_55(L2_55, "Guide")
  L2_55 = L2_55.isActive
  L2_55 = L2_55(L2_55, "DrawGift", "Draw")
  if L2_55 then
    L2_55 = Guide
    L2_55 = L2_55.DrawGift
    L2_55 = L2_55.MATERIAL
    for _FORV_6_, _FORV_7_ in ipairs(A0_53.allGiftIdTable) do
      if L1_54:Test(A0_53.allGift[_FORV_7_], "HERO", L2_55) then
        return _FORV_6_
      end
    end
  end
  L2_55 = Logic
  L2_55 = L2_55.Get
  L2_55 = L2_55(L2_55, "Guide")
  L2_55 = L2_55.isActive
  L2_55 = L2_55(L2_55, "EvolutionPrepare", "Draw")
  if L2_55 then
    L2_55 = Guide
    L2_55 = L2_55.EvolutionPrepare
    L2_55 = L2_55.MATERIAL
    for _FORV_6_, _FORV_7_ in ipairs(A0_53.allGiftIdTable) do
      if L1_54:Test(A0_53.allGift[_FORV_7_], "HERO", L2_55) then
        return _FORV_6_
      end
    end
  end
  L2_55 = Logic
  L2_55 = L2_55.Get
  L2_55 = L2_55(L2_55, "Guide")
  L2_55 = L2_55.isActive
  L2_55 = L2_55(L2_55, "FightDrawGiftLevelUp", "Draw")
  if L2_55 then
    L2_55 = Guide
    L2_55 = L2_55.FightDrawGiftLevelUp
    L2_55 = L2_55.MATERIAL
    for _FORV_6_, _FORV_7_ in ipairs(A0_53.allGiftIdTable) do
      if L1_54:Test(A0_53.allGift[_FORV_7_], "HERO", L2_55) then
        return _FORV_6_
      end
    end
  end
  L2_55 = nil
  return L2_55
end
