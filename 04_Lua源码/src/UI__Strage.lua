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
L0_0 = {
  {
    respath = "data/MiddleCard/7.png",
    title1 = 10133,
    subScene = ""
  },
  {
    respath = "data/MiddleCard/7.png",
    title1 = 10132,
    subScene = ""
  },
  {
    respath = "data/MiddleCard/7.png",
    title1 = 108005,
    subScene = "InputSerialNumber"
  },
  {
    respath = "data/MiddleCard/7.png",
    title1 = 106002,
    subScene = "SetSystem"
  },
  {
    respath = "data/MiddleCard/7.png",
    title1 = 106003,
    subScene = ""
  },
  {
    respath = "data/MiddleCard/7.png",
    title1 = 10129
  },
  {
    respath = "data/MiddleCard/7.png",
    title1 = 10130
  }
}
function prototype.onNodeLoaded(A0_1, A1_2, A2_3)
end
function prototype.cellSizeForTable(A0_4, ...)
  return CCSizeMake(550, 125)
end
function prototype.structureData(A0_6, A1_7)
  local L2_8, L3_9, L4_10, L5_11, L6_12
  L2_8 = {}
  for L6_12 = 1, 2 do
    if #A0_6.titleinfo < 2 * A1_7 + L6_12 then
      table.insert(L2_8, {})
    else
      table.insert(L2_8, A0_6.titleinfo[2 * A1_7 + L6_12])
    end
  end
  return L2_8
end
function prototype.tableCellAtIndex(A0_13, A1_14, A2_15, A3_16, A4_17)
  local L5_18, L6_19
  L6_19 = A0_13
  L5_18 = A0_13.structureData
  L5_18 = L5_18(L6_19, A2_15)
  if not A3_16 then
    L6_19 = CCTableViewCellEx
    L6_19 = L6_19.create
    L6_19 = L6_19(L6_19)
    A3_16 = L6_19
    L6_19 = Tw
    L6_19 = L6_19.Controller
    L6_19 = L6_19.load
    L6_19 = L6_19(L6_19, "StrageNode", A0_13.rootNode)
    L6_19:ReFrashHeroInfo(L5_18)
    A3_16:addChild(L6_19, 0, 2)
  else
    L6_19 = A3_16.getChildByTag
    L6_19 = L6_19(A3_16, 2)
    L6_19 = L6_19.ReFrashHeroInfo
    L6_19(L6_19, L5_18)
  end
  return A3_16
end
function prototype.numberOfCellsInTableView(A0_20, A1_21)
  return math.modf((#A0_20.data[A1_21] + 1) / 2)
end
function prototype.tableCellTouched(A0_22, A1_23, A2_24)
end
function prototype.tablePageTurn(A0_25, A1_26)
  A0_25.tableViewControl:RequireUpdate()
end
function prototype.onEnter(A0_27)
  local L1_28
  L1_28 = super
  L1_28 = L1_28.onEnter
  L1_28(A0_27)
  L1_28 = tree
  L1_28 = L1_28.clone
  L1_28 = L1_28(_UPVALUE0_)
  A0_27.lsttable = {}
  if Logic:Get("System"):GetMisc("forumAddress") == nil or Logic:Get("System"):GetMisc("forumAddress") == "" or Logic:Get("System"):IsOperator("gapp") then
    L1_28 = A0_27:removeItem(L1_28, 106004)
  end
  if Logic:Get("System"):GetMisc("sdkBBS") == nil or Logic:Get("System"):GetMisc("sdkBBS") == 0 or Logic:Get("System"):IsOperator("gapp") then
    L1_28 = A0_27:removeItem(L1_28, 10132)
  end
  if not Logic:Get("System"):IsChannel("mmdx") or Logic:Get("System"):IsOperator("gapp") then
    L1_28 = A0_27:removeItem(L1_28, 10163)
    L1_28 = A0_27:removeItem(L1_28, 10164)
  end
  if CTwUtil.E_TP_WIN32 ~= CTwUtil:GetPlatform() then
    L1_28 = A0_27:removeItem(L1_28, 104200)
  end
  if CTwUtil.E_TP_WIN32 ~= CTwUtil:GetPlatform() then
    L1_28 = A0_27:removeItem(L1_28, 106008)
  end
  if not Logic:Get("Login"):GetRecordServerByIdx(1).dd then
    L1_28 = A0_27:removeItem(L1_28, 102204)
  end
  if nil == Logic:Get("System"):GetOperator("userCenter") or 0 == Logic:Get("System"):GetOperator("userCenter") then
    L1_28 = A0_27:removeItem(L1_28, 10127)
  end
  if nil == Logic:Get("System"):GetMisc("accountManager") or 0 == Logic:Get("System"):GetMisc("accountManager") then
    L1_28 = A0_27:removeItem(L1_28, 10146)
  end
  if nil == Logic:Get("System"):GetOperator("webSite") or 0 == Logic:Get("System"):GetOperator("webSite") then
    L1_28 = A0_27:removeItem(L1_28, 10158)
  end
  if not Logic:Get("System"):IsCanDelAccount() or Logic:Get("Account"):GetIsVisitorType() then
    L1_28 = A0_27:removeItem(L1_28, 10130)
  end
  if Logic:Get("System"):IsOperator("appstore") then
    L1_28 = A0_27:removeItem(L1_28, 108005)
  end
  if not Logic:Get("Login"):isNeedCallBoard() or Logic:Get("System"):IsOperator("gapp") then
    L1_28 = A0_27:removeItem(L1_28, 106001)
  end
  if nil == Logic:Get("System"):GetMisc("perfectAccount") or 0 == Logic:Get("System"):GetMisc("perfectAccount") then
    L1_28 = A0_27:removeItem(L1_28, 10153)
  end
  if nil == Logic:Get("System"):GetMisc("feedbackProblem") or 0 == Logic:Get("System"):GetMisc("feedbackProblem") then
    L1_28 = A0_27:removeItem(L1_28, 10154)
  end
  if not Logic:Get("System"):IsOperator("movefun") then
    L1_28 = A0_27:removeItem(L1_28, 10134)
  end
  A0_27.titleinfo = L1_28
  if Logic:Get("System"):IsOperator("ilovewebgame") then
    A0_27.titleinfo = _UPVALUE1_
  end
  A0_27.data = {
    A0_27.titleinfo
  }
  A0_27.tableViewControl = TableViewEx.prototype:createList(A0_27, A0_27.lststrage, 1)
  A0_27.tableViewControl:RequireUpdate()
  A0_27.tableViewControl.tableView:setDirection(kCCScrollViewDirectionVertical)
  A0_27.lststrage:addChild(A0_27.tableViewControl.tableView)
end
function prototype.removeItem(A0_29, A1_30, A2_31)
  local L3_32, L4_33, L5_34, L6_35
  for L6_35 = 1, #A1_30 do
    if A1_30[L6_35].title1 == A2_31 then
      table.remove(A1_30, L6_35)
      break
    end
  end
  return A1_30
end
