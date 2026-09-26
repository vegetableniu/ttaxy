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
L0_0 = 520
function prototype.onEnter(A0_1)
  local L1_2
  L1_2 = super
  L1_2 = L1_2.onEnter
  L1_2(A0_1)
  L1_2 = Logic
  L1_2 = L1_2.Get
  L1_2 = L1_2(L1_2, "Friend")
  L1_2 = L1_2.On
  L1_2(L1_2, Logic.Friend.EVT.FRIEND_CHANGE, A0_1:Event("RefrashFriendInfo"))
  L1_2 = Logic
  L1_2 = L1_2.Get
  L1_2 = L1_2(L1_2, "Friend")
  L1_2 = L1_2.On
  L1_2(L1_2, Logic.Friend.EVT.FRIENDMAIN_CHANGE, A0_1:Event("RequireInfo"))
  L1_2 = Logic
  L1_2 = L1_2.Get
  L1_2 = L1_2(L1_2, "Friend")
  L1_2 = L1_2.SendMsgGetMyFriend
  L1_2(L1_2)
  L1_2 = Logic
  L1_2 = L1_2.Get
  L1_2 = L1_2(L1_2, "Friend")
  L1_2 = L1_2.SetFriendPrompt
  L1_2(L1_2, false)
  A0_1.friendOnFriend = true
  L1_2 = {}
  A0_1.friendInfo = L1_2
  A0_1.curNum = 0
  L1_2 = _UPVALUE0_
  A0_1.maxNum = L1_2
  L1_2 = {
    "images/font/myfriend.png",
    "images/font/addfriend.png"
  }
  A0_1.imgTitle = L1_2
  A0_1.curPage = 1
  L1_2 = Logic
  L1_2 = L1_2.Get
  L1_2 = L1_2(L1_2, "WeChat")
  L1_2 = L1_2.IsOpenWeChatShare
  L1_2 = L1_2(L1_2)
  if L1_2 then
    L1_2 = Logic
    L1_2 = L1_2.Get
    L1_2 = L1_2(L1_2, "System")
    L1_2 = L1_2.IsOpenFaceBook
    L1_2 = L1_2(L1_2)
    if not L1_2 then
      L1_2 = "images/WeChat/share.png"
      if CCSprite:create(L1_2) then
        A0_1.sprLeft:setDisplayFrame(CCSprite:create(L1_2):displayFrame())
      end
    end
  end
  L1_2 = {}
  A0_1.data = L1_2
  L1_2 = TableViewEx
  L1_2 = L1_2.prototype
  L1_2 = L1_2.createList
  L1_2 = L1_2(L1_2, A0_1, A0_1.m_pCList, 1)
  A0_1.tableViewControl = L1_2
  L1_2 = A0_1.m_pCList
  L1_2 = L1_2.addChild
  L1_2(L1_2, A0_1.tableViewControl.tableView)
  L1_2 = A0_1.RefrashFriendInfo
  L1_2(A0_1)
end
function prototype.RequireInfo(A0_3)
  A0_3:InitInfo()
  A0_3:ShowOtherInfo()
  A0_3.tableViewControl:RequireUpdateWithoutAnimat(A0_3.maxPage, TableViewEx.RESET_POS_TYPE.RESET_OLD_POS)
end
function prototype.RefrashFriendInfo(A0_4)
  A0_4:InitInfo()
  A0_4:ShowOtherInfo()
  A0_4.tableViewControl:RequireUpdate(A0_4.maxPage, true, TableViewEx.RESET_POS_TYPE.RESET_OLD_POS)
end
function prototype.InitInfo(A0_5)
  local L1_6
  L1_6 = A0_5.friendOnFriend
  if L1_6 then
    L1_6 = Logic
    L1_6 = L1_6.Get
    L1_6 = L1_6(L1_6, "Friend")
    L1_6 = L1_6.GetFriendInfo
    L1_6 = L1_6(L1_6)
    A0_5.friendInfo = L1_6
    L1_6 = table
    L1_6 = L1_6.sort
    L1_6(A0_5.friendInfo, _UPVALUE0_)
  else
    L1_6 = Logic
    L1_6 = L1_6.Get
    L1_6 = L1_6(L1_6, "Friend")
    L1_6 = L1_6.GetAskFriend
    L1_6 = L1_6(L1_6)
    A0_5.friendInfo = L1_6
    L1_6 = table
    L1_6 = L1_6.sort
    L1_6(A0_5.friendInfo, _UPVALUE1_)
  end
  L1_6 = Logic
  L1_6 = L1_6.Get
  L1_6 = L1_6(L1_6, "Friend")
  L1_6 = L1_6.GetLstDateOrPage
  A0_5.maxPage, L1_6 = L1_6, L1_6(L1_6, A0_5.friendInfo)
  A0_5.data = L1_6
  L1_6 = false
  if A0_5.maxPage > 1 then
    L1_6 = true
  end
  A0_5.imgPageLeft:setVisible(L1_6)
  A0_5.imgPageRight:setVisible(L1_6)
  if Logic:Get("Friend"):GetAllFriendId() == nil then
    A0_5.curNum = A0_5.friendInfo and #A0_5.friendInfo or 0
  else
    A0_5.curNum = #Logic:Get("Friend"):GetAllFriendId() or 0
  end
  A0_5.maxNum = Logic:Get("Friend"):GetFriendMax() or _UPVALUE2_
end
function prototype.ShowOtherInfo(A0_7)
  local L1_8, L2_9
  L1_8 = A0_7.staFriendMax
  L2_9 = L1_8
  L1_8 = L1_8.setVisible
  L1_8(L2_9, false)
  L1_8 = A0_7.staCurFriendMax
  L2_9 = L1_8
  L1_8 = L1_8.setVisible
  L1_8(L2_9, false)
  L1_8 = A0_7.btnSeek
  L2_9 = L1_8
  L1_8 = L1_8.setVisible
  L1_8(L2_9, false)
  L1_8 = A0_7.edtFriendName
  L2_9 = L1_8
  L1_8 = L1_8.setVisible
  L1_8(L2_9, false)
  L1_8 = A0_7.edtFriendName
  L2_9 = L1_8
  L1_8 = L1_8.setMaxLens
  L1_8(L2_9, _UPVALUE0_)
  L1_8 = A0_7.staInviteNum
  L2_9 = L1_8
  L1_8 = L1_8.setVisible
  L1_8(L2_9, false)
  L1_8 = A0_7.imgNew
  L2_9 = L1_8
  L1_8 = L1_8.setVisible
  L1_8(L2_9, false)
  L1_8 = A0_7.imgAdd
  L2_9 = L1_8
  L1_8 = L1_8.setVisible
  L1_8(L2_9, false)
  L1_8 = A0_7.btnAddFriend
  L2_9 = L1_8
  L1_8 = L1_8.setVisible
  L1_8(L2_9, false)
  L1_8 = _UPVALUE1_
  L2_9 = A0_7.friendOnFriend
  if L2_9 then
    L2_9 = A0_7.imgAdd
    L2_9 = L2_9.setVisible
    L2_9(L2_9, true)
    L2_9 = A0_7.btnAddFriend
    L2_9 = L2_9.setVisible
    L2_9(L2_9, true)
    L2_9 = A0_7.staFriendEnter
    L2_9 = L2_9.setString
    L2_9(L2_9, TwGetStr(101028))
    L2_9 = A0_7.staFriendMax
    L2_9 = L2_9.setVisible
    L2_9(L2_9, true)
    L2_9 = A0_7.staFriendMax
    L2_9 = L2_9.setString
    L2_9(L2_9, string.format("%d/%d", A0_7.curNum, A0_7.maxNum))
    L2_9 = Logic
    L2_9 = L2_9.Get
    L2_9 = L2_9(L2_9, "Friend")
    L2_9 = L2_9.GetAskFriend
    L2_9 = L2_9(L2_9)
    if L2_9 and not table.empty(L2_9) then
      A0_7.imgNew:setVisible(true)
      A0_7.staInviteNum:setVisible(true)
      A0_7.staInviteNum:setString(#L2_9)
    end
  else
    L1_8 = _UPVALUE2_
    L2_9 = A0_7.staFriendEnter
    L2_9 = L2_9.setString
    L2_9(L2_9, TwGetStr(101029))
    L2_9 = A0_7.staCurFriendMax
    L2_9 = L2_9.setVisible
    L2_9(L2_9, true)
    L2_9 = A0_7.staCurFriendMax
    L2_9 = L2_9.setString
    L2_9(L2_9, TwGetStr(101030, A0_7.curNum, A0_7.maxNum))
    L2_9 = A0_7.btnSeek
    L2_9 = L2_9.setVisible
    L2_9(L2_9, true)
    L2_9 = A0_7.edtFriendName
    L2_9 = L2_9.setVisible
    L2_9(L2_9, true)
    L2_9 = A0_7.edtFriendName
    L2_9 = L2_9.setFontSize
    L2_9(L2_9, _UPVALUE3_)
  end
  if not (L1_8 <= 0) then
    L2_9 = A0_7.imgTitle
    L2_9 = #L2_9
  elseif L1_8 > L2_9 then
    return
  end
  L2_9 = CCSprite
  L2_9 = L2_9.create
  L2_9 = L2_9(L2_9, A0_7.imgTitle[L1_8])
  if L2_9 then
    A0_7.sprTitle:setDisplayFrame(L2_9:displayFrame())
  end
end
function prototype.OnBtnAddFriend(A0_10, A1_11, A2_12)
  A0_10.friendOnFriend = false
  A0_10.tableViewControl:TurnPageTo(1)
  A0_10:RefrashFriendInfo()
  A0_10.tableViewControl.tableView:resetOffsetPositon()
end
function prototype.onBtnReturn(A0_13, A1_14, A2_15)
  if Logic:Get("WeChat"):IsOpenWeChatShare() and not Logic:Get("System"):IsOpenFaceBook() then
    Logic:Get("WeChat"):SetShowPrompt(true)
    Logic:Get("WeChat"):OpenWeChat()
    return
  end
  if A0_13.friendOnFriend then
    SceneHelper:runWithScene("Home", A0_13.rootNode)
  else
    A0_13.friendOnFriend = true
    A0_13.tableViewControl:TurnPageTo(1)
    A0_13:RefrashFriendInfo()
    A0_13.tableViewControl.tableView:resetOffsetPositon()
  end
end
function prototype.onBtnSeekFriend(A0_16, A1_17, A2_18)
  if A0_16.edtFriendName:getString() and A0_16.edtFriendName:getString() ~= "" then
    if A0_16.edtFriendName:getString() == Logic:Get("PlayerInfo"):GetPlayerName() then
      Prompt:Fail(101171)
    elseif A0_16.curNum < A0_16.maxNum then
      Logic:Get("Friend"):SendMsgAddFriend(A0_16.edtFriendName:getString(), true)
    else
      Prompt:Fail(101052)
    end
  else
    Prompt:Fail(101014)
  end
end
function prototype.onBtnInvite(A0_19, A1_20, A2_21)
  SceneHelper:runWithScene("FriendInvite", A0_19.rootNode)
end
function prototype.cellSizeForTable(A0_22, ...)
  return CCSizeMake(_UPVALUE0_, _UPVALUE1_)
end
function prototype.tableCellAtIndex(A0_24, A1_25, A2_26, A3_27, A4_28)
  local L5_29
  if not A3_27 then
    L5_29 = CCTableViewCellEx
    L5_29 = L5_29.create
    L5_29 = L5_29(L5_29)
    A3_27 = L5_29
    L5_29 = nil
    L5_29 = Tw.Controller:load("FriendItem", A0_24.rootNode)
    if A0_24.friendOnFriend then
      L5_29:ReFrashHeroInfo(A0_24.data[A4_28][A2_26 + 1])
    else
      L5_29:ReFrashHeroInfo(A0_24.data[A4_28][A2_26 + 1], Logic.Friend.FRIEND_ITEM_TYPE.FRIENDADD)
    end
    A3_27:addChild(L5_29, 0, 2)
  else
    L5_29 = A0_24.friendOnFriend
    if L5_29 then
      L5_29 = A3_27.getChildByTag
      L5_29 = L5_29(A3_27, 2)
      L5_29 = L5_29.ReFrashHeroInfo
      L5_29(L5_29, A0_24.data[A4_28][A2_26 + 1])
    else
      L5_29 = A3_27.getChildByTag
      L5_29 = L5_29(A3_27, 2)
      L5_29 = L5_29.ReFrashHeroInfo
      L5_29(L5_29, A0_24.data[A4_28][A2_26 + 1], Logic.Friend.FRIEND_ITEM_TYPE.FRIENDADD)
    end
  end
  return A3_27
end
function prototype.numberOfCellsInTableView(A0_30, A1_31)
  A0_30.staPageNum:setString(string.format("%d/%d", A1_31 or _UPVALUE0_, A0_30.maxPage or _UPVALUE0_))
  if A0_30.data and A0_30.data[A1_31] and next(A0_30.data[A1_31]) ~= nil then
    return #A0_30.data[A1_31]
  else
    return 0
  end
end
function prototype.tableCellTouched(A0_32, A1_33, A2_34)
end
function prototype.tablePageTurn(A0_35, A1_36)
  A0_35.tableViewControl:RequireUpdate()
end
function prototype.showWeChatTip(A0_37, A1_38)
  local L2_39, L3_40, L4_41, L5_42
  L2_39 = A0_37.ani
  if L2_39 then
    L2_39 = A0_37.ani
    L3_40 = L2_39
    L2_39 = L2_39.RemoveAnimation
    L2_39(L3_40)
    A0_37.ani = nil
  end
  L2_39 = A0_37.rootNode
  L3_40 = L2_39
  L2_39 = L2_39.getChildByTag
  L4_41 = 10
  L2_39 = L2_39(L3_40, L4_41)
  if L2_39 then
    L3_40 = A0_37.rootNode
    L4_41 = L3_40
    L3_40 = L3_40.removeChildByTag
    L5_42 = 10
    L3_40(L4_41, L5_42, true)
  end
  if not A1_38 then
    return
  end
  L3_40 = A0_37.sprLeft
  L4_41 = L3_40
  L3_40 = L3_40.getPositionX
  L3_40 = L3_40(L4_41)
  L3_40 = L3_40 + 40
  L4_41 = A0_37.sprLeft
  L5_42 = L4_41
  L4_41 = L4_41.getPositionY
  L4_41 = L4_41(L5_42)
  L4_41 = L4_41 + 20
  L5_42 = Logic
  L5_42 = L5_42.Get
  L5_42 = L5_42(L5_42, "AniMgr")
  L5_42 = L5_42.RunCCBAni
  L5_42 = L5_42(L5_42, "UI/uinew", A0_37.rootNode, ccp(L3_40, L4_41), 0.7)
  A0_37.ani = L5_42
  L5_42 = CCSprite
  L5_42 = L5_42.create
  L5_42 = L5_42(L5_42, "images/public/tip.png")
  A0_37.rootNode:addChild(L5_42, 0, 10)
  L5_42:setAnchorPoint(CCPoint(0.5, 0.5))
  L5_42:setPosition(ccp(L3_40, L4_41))
  L5_42:setScale(0.7)
end
