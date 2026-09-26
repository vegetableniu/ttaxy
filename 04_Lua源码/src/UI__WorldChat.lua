local L0_0
L0_0 = module
L0_0((...), package.seeall)
L0_0 = require
L0_0("SceneHelper")
L0_0 = require
L0_0("TableViewEx")
L0_0 = Tw
L0_0 = L0_0.Controller
L0_0 = L0_0.prototype
L0_0 = L0_0.extend
L0_0 = L0_0(L0_0)
prototype = L0_0
L0_0 = 570
function prototype.initialize(A0_1)
  super.initialize(A0_1)
  Logic:Get("WorldChat"):On(Logic.WorldChat.EVT.LIST_OK, A0_1:Event("onList"))
  Logic:Get("WorldChat"):On(Logic.WorldChat.EVT.SEND_OK, A0_1:Event("onSend"))
  A0_1.data = {}
  A0_1.hasItem = false
  A0_1.ItemHeight = 0
end
function prototype.dispose(A0_2, ...)
  if A0_2.eventTracer:Exist("onPoll") then
    A0_2.eventTracer:Cancel("onPoll")
  end
  if A0_2.eventTracer:Exist("onScrollBottom") then
    A0_2.eventTracer:Cancel("onScrollBottom")
  end
  super.dispose(...)
end
function prototype.onEnter(A0_4)
  super.onEnter(A0_4)
  _UPVALUE0_(A0_4.staPageNum)
  _UPVALUE0_(A0_4.imgPageLeft)
  _UPVALUE0_(A0_4.imgPageRight)
  _UPVALUE0_(A0_4.btnRefresh)
  if A0_4.btnRefresh then
    A0_4.btnRefresh:setEnabled(false)
  end
  A0_4.edtContent:setMaxLens(Logic.WorldChat.WORD_LIMIT)
  A0_4.edtContent:setFontSize(_UPVALUE1_)
  A0_4.edtContent:setMulLine(true)
  A0_4.edtContent:setTouchPriority(-255)
  A0_4.tableViewControl = TableViewEx.prototype:createList(A0_4, A0_4.m_pCList, 1)
  A0_4.m_pCList:addChild(A0_4.tableViewControl.tableView)
  Logic:Get("WorldChat"):PostList(0)
  if not A0_4.eventTracer:Exist("onPoll") then
    Singleton(Timer):Repeat(_UPVALUE2_, A0_4:Event("onPoll"))
  end
end
function prototype.onPoll(A0_5)
  Logic:Get("WorldChat"):PostList(0)
end
function prototype.onList(A0_6, A1_7, A2_8)
  if A1_7 ~= 0 then
    A0_6:showError(A1_7)
    return
  end
  A0_6:refresh(_UPVALUE0_(A2_8))
end
function prototype.onSend(A0_9, A1_10, A2_11)
  if A1_10 ~= 0 then
    A0_9:showError(A1_10)
    return
  end
  Logic:Get("WorldChat"):PostList(0)
end
function prototype.showError(A0_12, A1_13)
  local L2_14, L3_15
  L2_14 = type
  L3_15 = A1_13
  L2_14 = L2_14(L3_15)
  if L2_14 ~= "number" then
    return
  end
  if A1_13 == -2 then
    L2_14 = Prompt
    L3_15 = L2_14
    L2_14 = L2_14.Fail
    L2_14(L3_15, "\229\143\145\232\168\128\232\191\135\229\191\171\239\188\140\230\175\14310\231\167\146\229\143\170\232\131\189\229\143\145\228\184\128\229\143\165")
  elseif A1_13 == -11 then
    L2_14 = Logic
    L3_15 = L2_14
    L2_14 = L2_14.Get
    L2_14 = L2_14(L3_15, "Lock")
    L3_15 = L2_14
    L2_14 = L2_14.GetLevelAndBattleNames
    L3_15 = L2_14(L3_15, "WORLD_CHAT")
    Logic:Get("Home"):showLockTip(L2_14, L3_15)
  elseif A1_13 == -12 then
    L2_14 = Prompt
    L3_15 = L2_14
    L2_14 = L2_14.Fail
    L2_14(L3_15, TwGetStr(110133, Logic.WorldChat.WORD_LIMIT))
  elseif A1_13 == -8 then
    L2_14 = Prompt
    L3_15 = L2_14
    L2_14 = L2_14.Fail
    L2_14(L3_15, "\232\175\183\229\133\136\229\136\155\229\187\186\232\167\146\232\137\178")
  else
    L2_14 = Prompt
    L3_15 = L2_14
    L2_14 = L2_14.Fail
    L2_14(L3_15, "\229\143\145\233\128\129\229\164\177\232\180\165")
  end
end
function prototype.refresh(A0_16, A1_17)
  local L2_18
  if not A1_17 then
    return
  end
  L2_18 = ""
  for _FORV_6_ = 1, #A1_17 do
    L2_18 = L2_18 .. tostring(A1_17[_FORV_6_].name or "") .. "\t" .. tostring(A1_17[_FORV_6_].message or A1_17[_FORV_6_].content or "") .. "\n"
  end
  if L2_18 == _FOR_ then
    return
  end
  A0_16.listKey = L2_18
  A0_16:creteItem(A1_17)
  A0_16.tableViewControl:RequireUpdate(1, false)
  A0_16:scrollToBottom()
  if A0_16.eventTracer:Exist("onScrollBottom") then
    A0_16.eventTracer:Cancel("onScrollBottom")
  end
  Singleton(Timer):After(0, A0_16:Event("onScrollBottom"))
end
function prototype.creteItem(A0_19, A1_20)
  local L2_21, L3_22, L4_23, L5_24, L6_25
  A0_19.ItemHeight = 0
  for L5_24 = 1, #A1_20 do
    L6_25 = A0_19.ItemHeight
    L6_25 = L6_25 + _UPVALUE0_
    A0_19.ItemHeight = L6_25
    L6_25 = Tw
    L6_25 = L6_25.Controller
    L6_25 = L6_25.load
    L6_25 = L6_25(L6_25, "SectWordItem", A0_19.rootNode)
    L6_25:refreshInfo(A1_20[L5_24], _UPVALUE1_)
    L6_25:setPosition(ccp(0, A0_19.ItemHeight))
    A0_19.ItemHeight = A0_19.ItemHeight + L6_25:getContentSizeH()
    table.insert(A0_19.data, L6_25)
  end
  if L2_21 == 0 then
    A0_19.hasItem = false
  else
    A0_19.ItemHeight = L2_21
    A0_19.hasItem = true
  end
end
function prototype.onScrollBottom(A0_26)
  A0_26:scrollToBottom()
end
function prototype.scrollToBottom(A0_27)
  local L1_28
  L1_28 = A0_27.tableViewControl
  if L1_28 then
    L1_28 = A0_27.tableViewControl
    L1_28 = L1_28.tableView
  end
  if L1_28 == nil or L1_28.maxContainerOffset == nil then
    return
  end
  if L1_28:maxContainerOffset() == nil then
    return
  end
  L1_28:setContentOffset(ccp(L1_28:maxContainerOffset().x or 0, L1_28:maxContainerOffset().y or 0), false)
end
function prototype.onBtnReturn(A0_29, A1_30, A2_31)
  SceneHelper:runWithScene("Home", A0_29.rootNode)
end
function prototype.OnBtnSend(A0_32, A1_33, A2_34)
  local L3_35
  L3_35 = A0_32.edtContent
  L3_35 = L3_35.getString
  L3_35 = L3_35(L3_35)
  if not L3_35 or L3_35:gsub("%s+", "%s") == "" then
    return
  end
  L3_35 = Logic:Get("WorldChat"):MaskContent(L3_35)
  A0_32.edtContent:setString(L3_35)
  if Logic.WorldChat.WORD_LIMIT < getCodePointAmount(L3_35) then
    Prompt:Fail(TwGetStr(110133, Logic.WorldChat.WORD_LIMIT))
    return
  end
  if Logic:Get("WorldChat"):CooldownLeft() > 0 then
    Prompt:Fail("\229\143\145\232\168\128\232\191\135\229\191\171\239\188\140\230\175\14310\231\167\146\229\143\170\232\131\189\229\143\145\228\184\128\229\143\165")
    return
  end
  if Logic:Get("WorldChat"):PostSend(L3_35) then
    A0_32.edtContent:setString("")
  end
end
function prototype.onPrevPageBtnClicked(A0_36, A1_37, A2_38)
end
function prototype.onNextPageBtnClicked(A0_39, A1_40, A2_41)
end
function prototype.onBtnRefresh(A0_42, A1_43, A2_44)
end
function prototype.cellSizeForTable(A0_45)
  return CCSizeMake(_UPVALUE0_, A0_45.ItemHeight or 0)
end
function prototype.tableCellAtIndex(A0_46, A1_47, A2_48, A3_49, A4_50)
  local L5_51, L6_52, L7_53, L8_54, L9_55, L10_56
  L5_51 = next
  L5_51 = L5_51(L6_52)
  if L5_51 == nil then
    return A3_49
  end
  if not A3_49 then
    L5_51 = CCTableViewCellEx
    L5_51 = L5_51.create
    L5_51 = L5_51(L6_52)
    A3_49 = L5_51
    L5_51 = CCNode
    L5_51 = L5_51.create
    L5_51 = L5_51(L6_52)
    for L9_55, L10_56 in L6_52(L7_53) do
      L5_51:addChild(L10_56)
    end
    L9_55 = 0
    L10_56 = 2
    L6_52(L7_53, L8_54, L9_55, L10_56)
    A0_46.data = L6_52
  else
    L5_51 = CCNode
    L5_51 = L5_51.create
    L5_51 = L5_51(L6_52)
    for L9_55, L10_56 in L6_52(L7_53) do
      L5_51:addChild(L10_56)
    end
    L9_55 = true
    L6_52(L7_53, L8_54, L9_55)
    L9_55 = 0
    L10_56 = 2
    L6_52(L7_53, L8_54, L9_55, L10_56)
    A0_46.data = L6_52
  end
  return A3_49
end
function prototype.numberOfCellsInTableView(A0_57, A1_58)
  if A0_57.hasItem then
    return 1
  end
  return 0
end
function prototype.tableCellTouched(A0_59, A1_60, A2_61)
end
function prototype.tablePageTurn(A0_62, A1_63)
end
