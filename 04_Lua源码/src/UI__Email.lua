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
L0_0 = 550
function prototype.onEnter(A0_1)
  super.onEnter(A0_1)
  Logic:Get("Email"):On(Logic.Email.EVT.EMAIL_GET, A0_1:Event("GetEmailInfo"))
  Logic:Get("Email"):On(Logic.Email.EVT.EMAIL_CHANGE, A0_1:Event("RefrashEmailInfo"))
  Logic:Get("Email"):SendMsgGetEmail()
  A0_1.tableViewControl = TableViewEx.prototype:createList(A0_1, A0_1.m_pCMailLst, 1)
  A0_1.m_pCMailLst:addChild(A0_1.tableViewControl.tableView)
  A0_1.imgPageLeft:setVisible(false)
  A0_1.imgPageRight:setVisible(false)
end
function prototype.onBtnReturn(A0_2, A1_3, A2_4)
  SceneHelper:runWithScene("Home", A0_2.rootNode)
end
function prototype.onBtnDeleteAllEmail(A0_5, A1_6, A2_7)
  if table.empty(A0_5.myMail or {}) then
    Prompt:Fail(TwGetStr(101112))
    return
  end
  Prompt:Confirm(A0_5, 103001, TwGetStr(101111), A0_5.onConfirm, Prompt.PROMPT_TYPE.SELECT)
end
function prototype.onConfirm(A0_8)
  local L1_9
  L1_9 = A0_8.deleteMap
  L1_9 = L1_9(A0_8)
  if table.empty(L1_9 or {}) then
    return
  end
  Logic:Get("Email"):PostRemoveAllMail(L1_9)
end
function prototype.deleteMap(A0_10)
  local L1_11, L2_12, L3_13, L4_14, L5_15, L6_16
  L1_11 = A0_10.myMail
  L1_11 = #L1_11
  if L1_11 == 1 then
    L1_11 = A0_10.myMail
    L1_11 = L1_11[1]
    L1_11 = L1_11.client
    if L1_11 then
      L1_11 = Logic
      L1_11 = L1_11.Get
      L1_11 = L1_11(L2_12, L3_13)
      L1_11 = L1_11.SetReadEmail
      L1_11(L2_12, L3_13)
      L1_11 = Logic
      L1_11 = L1_11.Get
      L1_11 = L1_11(L2_12, L3_13)
      L1_11 = L1_11.deleteClientEmail
      L1_11(L2_12)
      return
    end
  end
  L1_11 = {}
  for L5_15, L6_16 in L2_12(L3_13) do
    if L6_16.client then
      Logic:Get("Email"):SetReadEmail(L6_16)
    elseif table.empty(L6_16.attachment or {}) or L6_16.drawed == true then
      L1_11[L6_16.id] = A0_10:filterGroupTarget(L6_16)
    end
  end
  return L1_11
end
function prototype.filterGroupTarget(A0_17, A1_18)
  if table.empty(A1_18 or {}) then
    return nil
  end
  if table.empty(A1_18.attachment or {}) then
    return A1_18.groupTarget
  end
  return nil
end
function prototype.GetEmailInfo(A0_19)
  local L1_20
  L1_20 = Logic
  L1_20 = L1_20.Get
  L1_20 = L1_20(L1_20, "Email")
  L1_20 = L1_20.GetMyEmail
  L1_20 = L1_20(L1_20)
  A0_19.myMail = L1_20
  L1_20 = Logic
  L1_20 = L1_20.Get
  L1_20 = L1_20(L1_20, "Friend")
  L1_20 = L1_20.GetLstDateOrPage
  A0_19.pageMax, L1_20 = L1_20, L1_20(L1_20, A0_19.myMail)
  A0_19.data = L1_20
  L1_20 = false
  if A0_19.pageMax and A0_19.pageMax > 1 then
    L1_20 = true
  end
  A0_19.imgPageLeft:setVisible(L1_20)
  A0_19.imgPageRight:setVisible(L1_20)
  A0_19.tableViewControl:RequireUpdate(A0_19.pageMax)
end
function prototype.RefrashEmailInfo(A0_21)
  local L1_22
  L1_22 = Logic
  L1_22 = L1_22.Get
  L1_22 = L1_22(L1_22, "Email")
  L1_22 = L1_22.GetMyEmail
  L1_22 = L1_22(L1_22)
  A0_21.myMail = L1_22
  L1_22 = Logic
  L1_22 = L1_22.Get
  L1_22 = L1_22(L1_22, "Friend")
  L1_22 = L1_22.GetLstDateOrPage
  A0_21.pageMax, L1_22 = L1_22, L1_22(L1_22, A0_21.myMail)
  A0_21.data = L1_22
  L1_22 = false
  if A0_21.pageMax and A0_21.pageMax > 1 then
    L1_22 = true
  end
  A0_21.imgPageLeft:setVisible(L1_22)
  A0_21.imgPageRight:setVisible(L1_22)
  A0_21.tableViewControl:RequireUpdateWithoutAnimat(A0_21.pageMax, true)
end
function prototype.cellSizeForTable(A0_23, ...)
  return CCSizeMake(_UPVALUE0_, _UPVALUE1_)
end
function prototype.tableCellAtIndex(A0_25, A1_26, A2_27, A3_28, A4_29)
  local L5_30
  if not A3_28 then
    L5_30 = CCTableViewCellEx
    L5_30 = L5_30.create
    L5_30 = L5_30(L5_30)
    A3_28 = L5_30
    L5_30 = Tw
    L5_30 = L5_30.Controller
    L5_30 = L5_30.load
    L5_30 = L5_30(L5_30, "EmailItem", A0_25.rootNode)
    L5_30:ReFrashEmailItem(A0_25.data[A4_29][A2_27 + 1])
    A3_28:addChild(L5_30, 0, 2)
  else
    L5_30 = A3_28.getChildByTag
    L5_30 = L5_30(A3_28, 2)
    L5_30 = L5_30.ReFrashEmailItem
    L5_30(L5_30, A0_25.data[A4_29][A2_27 + 1])
  end
  return A3_28
end
function prototype.numberOfCellsInTableView(A0_31, A1_32)
  A0_31.staPageNum:setString(string.format("%d/%d", A1_32 or 1, A0_31.pageMax or 1))
  if A0_31.data and A0_31.data[A1_32] and next(A0_31.data[A1_32]) ~= nil then
    return #A0_31.data[A1_32]
  else
    return 0
  end
end
function prototype.tableCellTouched(A0_33, A1_34, A2_35)
end
function prototype.tablePageTurn(A0_36, A1_37)
  A0_36.tableViewControl:RequireUpdate()
end
