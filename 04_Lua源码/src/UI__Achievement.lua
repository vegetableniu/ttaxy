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
  Logic:Get("Achievement"):On(Logic.Achievement.EVT.GET_CHAPTER, A0_1:Event("RefrashAchievement"))
  Logic:Get("Achievement"):On(Logic.Achievement.EVT.DRAW_CHANGE, A0_1:Event("refrashDrawChange"))
  Logic:Get("DramaControl"):On(Logic.DramaControl.EVT.COVER, A0_1:Event("FineZiXiaItem"))
  A0_1.achieveType = {}
  A0_1.curPage = _UPVALUE0_
  A0_1.maxPage = 1
  A0_1.pageNum = 1
  A0_1.update = false
  A0_1.maxPage = KFDBGetRecordAmt("ChapterAchieveConfig")
  A0_1.tableViewControl = TableViewEx.prototype:createList(A0_1, A0_1.m_pCList, A0_1.curPage)
  A0_1.m_pCList:addChild(A0_1.tableViewControl.tableView)
  Logic:Get("Achievement"):SendMsgGetMyAchieve()
  A0_1:RefrashAchievement()
end
function prototype.getChapterCount(A0_2)
  local L1_3, L2_4, L3_5, L4_6, L5_7
  L1_3 = ""
  L2_4 = math
  L2_4 = L2_4.modf
  L3_5 = A0_2.curPage
  L3_5 = L3_5 / 10
  L3_5 = L2_4(L3_5)
  L3_5 = L3_5 * 10
  L4_6 = ""
  L5_7 = ""
  if L2_4 ~= 0 then
    L4_6 = TwGetStr(102140 + L2_4)
  end
  if L3_5 ~= 0 then
    L5_7 = TwGetStr(102130 + L3_5)
  end
  if A0_2.curPage == 10 then
    L1_3 = L4_6 .. TwGetStr(102145)
  else
    L1_3 = L4_6 .. L5_7
  end
  return L1_3
end
function prototype.getChapterName(A0_8, A1_9)
  local L2_10, L3_11
  L2_10 = ""
  if A1_9 == nil then
    return L2_10
  end
  L3_11 = A0_8.getChapterCount
  L3_11 = L3_11(A0_8)
  L2_10 = TwGetStr(102126, L3_11) .. A1_9.name
  return L2_10
end
function prototype.MsgCallBackChange(A0_12)
  local L1_13, L2_14
  L1_13 = KFDBGetRecord
  L2_14 = "ChapterAchieveConfig"
  L1_13 = L1_13(L2_14, A0_12.curPage)
  L2_14 = A0_12.getChapterName
  L2_14 = L2_14(A0_12, L1_13)
  A0_12.achieveInfo = Logic:Get("Achievement"):GetAchimentByChapter(A0_12.curPage)
  table.sort(A0_12.achieveInfo, _UPVALUE0_)
  A0_12.update = true
  A0_12.staChapter:setString(L2_14)
  A0_12.pageNum = Logic:Get("Achievement"):GetChapterAll(A0_12.curPage) or L1_13.totol or 0
end
function prototype.RefrashAchievement(A0_15)
  local L1_16
  L1_16 = Logic
  L1_16 = L1_16.Get
  L1_16 = L1_16(L1_16, "Achievement")
  L1_16 = L1_16.GetHasNewAchieve
  L1_16 = L1_16(L1_16)
  if L1_16 and not table.empty(L1_16) then
    for _FORV_5_, _FORV_6_ in pairs(L1_16) do
      if _FORV_6_ then
        A0_15.curPage = _FORV_5_
        break
      end
    end
  end
  A0_15:MsgCallBackChange()
  A0_15.tableViewControl:RequireUpdate(A0_15.maxPage)
end
function prototype.refrashDrawChange(A0_17)
  local L1_18
  L1_18 = A0_17.MsgCallBackChange
  L1_18(A0_17)
  L1_18 = A0_17.tableViewControl
  L1_18 = L1_18.RequireUpdateWithoutAnimat
  L1_18(L1_18, A0_17.maxPage)
  L1_18 = Logic
  L1_18 = L1_18.Get
  L1_18 = L1_18(L1_18, "Achievement")
  L1_18 = L1_18.isGuideAchieve
  L1_18 = L1_18(L1_18)
  if L1_18 then
    L1_18 = A0_17.getTableViewOffset
    L1_18 = L1_18(A0_17)
    if L1_18 ~= nil then
      A0_17.tableViewControl.tableView:setTableViewOffset(L1_18)
    end
    Logic:Get("Achievement"):setGuideAchieve(false)
    Logic:Get("Guide"):check()
  end
end
function prototype.BtnTurnPage(A0_19)
  A0_19:MsgCallBackChange()
  A0_19.tableViewControl:RequireUpdate(A0_19.maxPage)
end
function prototype.onBtnFront(A0_20, A1_21, A2_22)
  if A0_20.curPage > 1 then
    A0_20.curPage = A0_20.curPage - 1
  else
    A0_20.curPage = A0_20.maxPage
  end
  A0_20:BtnTurnPage()
end
function prototype.onBtnNext(A0_23, A1_24, A2_25)
  if A0_23.curPage < A0_23.maxPage then
    A0_23.curPage = A0_23.curPage + 1
  else
    A0_23.curPage = 1
  end
  A0_23:BtnTurnPage()
end
function prototype.cellSizeForTable(A0_26, ...)
  return CCSizeMake(_UPVALUE0_, _UPVALUE1_)
end
function prototype.tableCellAtIndex(A0_28, A1_29, A2_30, A3_31, A4_32)
  local L5_33
  if not A3_31 then
    L5_33 = CCTableViewCellEx
    L5_33 = L5_33.create
    L5_33 = L5_33(L5_33)
    A3_31 = L5_33
    L5_33 = Tw
    L5_33 = L5_33.Controller
    L5_33 = L5_33.load
    L5_33 = L5_33(L5_33, "AchievementItem", A0_28.rootNode)
    L5_33:ReFrashAchievementInfo(A0_28.achieveInfo[A2_30 + 1])
    A3_31:addChild(L5_33, 0, 2)
  else
    L5_33 = A3_31.getChildByTag
    L5_33 = L5_33(A3_31, 2)
    L5_33 = L5_33.ReFrashAchievementInfo
    L5_33(L5_33, A0_28.achieveInfo[A2_30 + 1])
  end
  return A3_31
end
function prototype.actionFinish(A0_34, A1_35)
  local L2_36, L3_37, L4_38
  L2_36 = Logic
  L3_37 = L2_36
  L2_36 = L2_36.Get
  L4_38 = "Guide"
  L2_36 = L2_36(L3_37, L4_38)
  L3_37 = L2_36
  L2_36 = L2_36.isActive
  L4_38 = "Achievement"
  L2_36 = L2_36(L3_37, L4_38)
  if not L2_36 then
    return
  end
  L2_36 = nil
  L3_37 = Logic
  L4_38 = L3_37
  L3_37 = L3_37.Get
  L3_37 = L3_37(L4_38, "Achievement")
  L4_38 = Guide
  L4_38 = L4_38.Achievement
  L4_38 = L4_38.ID
  for _FORV_10_, _FORV_11_ in ipairs(A0_34.achieveInfo) do
    if L3_37:GetNeedInfoByIdx(L4_38) == _FORV_11_.index and L3_37:GetNeedInfoByIdx(L4_38) == _FORV_11_.chapter then
      L2_36 = _FORV_10_
      break
    end
  end
  if L2_36 == nil then
    return
  end
  if A1_35:cellAtIndex(L2_36 - 1) == nil then
    return
  end
  if A1_35:cellAtIndex(L2_36 - 1):getChildByTag(2) == nil then
    return
  end
  A1_35:cellAtIndex(L2_36 - 1):getChildByTag(2):updateGuide()
end
function prototype.FineZiXiaItem(A0_39)
  local L1_40
end
function prototype.getTableViewOffset(A0_41)
  local L1_42
  return L1_42
end
function prototype.numberOfCellsInTableView(A0_43, A1_44)
  local L2_45
  L2_45 = Logic
  L2_45 = L2_45.Get
  L2_45 = L2_45(L2_45, "Achievement")
  L2_45 = L2_45.GetMyAchieveInfo
  L2_45 = L2_45(L2_45)
  if L2_45 == nil or table.empty(L2_45) or not A0_43.update then
    return 0
  else
    return A0_43.pageNum + 1
  end
end
function prototype.tableCellTouched(A0_46, A1_47, A2_48)
end
function prototype.tablePageTurn(A0_49, A1_50, A2_51)
  if A2_51 == -1 then
    A0_49:onBtnFront()
  else
    A0_49:onBtnNext()
  end
end
