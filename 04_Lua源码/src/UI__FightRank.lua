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
L0_0 = "images/Fight/fontRankReward1.png"
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
  SceneHelper:runWithScene("FightPvp", A0_7.rootNode)
  do return end
  Logic:Get("Fight"):On(Logic.Fight.EVT.UPDATE_RANK_LIST, A0_7:Event("updateRankList"))
  A0_7.data = {}
  A0_7.nodeX = A0_7.lstRank:getPositionX()
  A0_7.nodeY = A0_7.lstRank:getPositionY()
  A0_7.nodeWidth = A0_7.lstRank:getContentSize().width
  A0_7.nodeHeight = A0_7.lstRank:getContentSize().height
  A0_7.rankType = Logic:Get("Fight"):GetRankType()
  if A0_7.rankType == Logic.Fight.RANK_TYPE.ALL_RANK then
    A0_7:loadAllRank()
  elseif A0_7.rankType == Logic.Fight.RANK_TYPE.MY_RANK then
    A0_7:loadMyRank()
  elseif A0_7.rankType == Logic.Fight.RANK_TYPE.RANK_REWARD then
    A0_7:loadRankReward()
  end
  A0_7.tableViewControl = TableViewEx.prototype:createList(A0_7, A0_7.lstRank, 1)
  A0_7.tableViewControl.tableView:setDirection(kCCScrollViewDirectionVertical)
  A0_7.lstRank:addChild(A0_7.tableViewControl.tableView)
  A0_7.tableViewControl.tableView:runUIAnimat()
  MsgArena:Post("GET_RANK_LIST")
end
function prototype.onExit(A0_8)
  Logic:Get("Fight"):clearRankList()
end
function prototype.onNodeLoaded(A0_9, A1_10, A2_11)
end
function prototype.loadAllRank(A0_12)
  local L1_13
  L1_13 = A0_12.sprBg
  L1_13 = L1_13.setVisible
  L1_13(L1_13, false)
  L1_13 = A0_12.sprRewardTitle2
  L1_13 = L1_13.setVisible
  L1_13(L1_13, false)
  L1_13 = A0_12.lstRank
  L1_13 = L1_13.setPosition
  L1_13(L1_13, ccp(A0_12.nodeX, A0_12.nodeY))
  L1_13 = A0_12.lstRank
  L1_13 = L1_13.setContentSize
  L1_13(L1_13, CCSizeMake(A0_12.nodeWidth, A0_12.nodeHeight))
  L1_13 = CCSprite
  L1_13 = L1_13.create
  L1_13 = L1_13(L1_13, _UPVALUE0_)
  if L1_13 then
    A0_12.sprLeftBtn:setDisplayFrame(L1_13:displayFrame())
  end
  L1_13 = CCSprite:create(_UPVALUE1_)
  if L1_13 then
    A0_12.sprRightBtn:setDisplayFrame(L1_13:displayFrame())
  end
  A0_12.data = Logic:Get("Fight"):GetAllRankList()
end
function prototype.loadMyRank(A0_14)
  local L1_15
  L1_15 = A0_14.sprBg
  L1_15 = L1_15.setVisible
  L1_15(L1_15, false)
  L1_15 = A0_14.sprRewardTitle2
  L1_15 = L1_15.setVisible
  L1_15(L1_15, false)
  L1_15 = A0_14.lstRank
  L1_15 = L1_15.setPosition
  L1_15(L1_15, ccp(A0_14.nodeX, A0_14.nodeY))
  L1_15 = A0_14.lstRank
  L1_15 = L1_15.setContentSize
  L1_15(L1_15, CCSizeMake(A0_14.nodeWidth, A0_14.nodeHeight))
  L1_15 = CCSprite
  L1_15 = L1_15.create
  L1_15 = L1_15(L1_15, _UPVALUE0_)
  if L1_15 then
    A0_14.sprLeftBtn:setDisplayFrame(L1_15:displayFrame())
  end
  L1_15 = CCSprite:create(_UPVALUE1_)
  if L1_15 then
    A0_14.sprRightBtn:setDisplayFrame(L1_15:displayFrame())
  end
  A0_14.data = Logic:Get("Fight"):GetMyRankList()
end
function prototype.loadRankReward(A0_16)
  local L1_17, L2_18, L3_19, L4_20, L5_21, L6_22, L7_23, L8_24, L9_25, L10_26
  L1_17 = A0_16.sprBg
  L2_18 = L1_17
  L1_17 = L1_17.setVisible
  L3_19 = true
  L1_17(L2_18, L3_19)
  L1_17 = A0_16.sprRewardTitle2
  L2_18 = L1_17
  L1_17 = L1_17.setVisible
  L3_19 = true
  L1_17(L2_18, L3_19)
  L1_17 = A0_16.nodeX
  L1_17 = L1_17 + 50
  L2_18 = A0_16.nodeY
  L2_18 = L2_18 - 200
  L3_19 = A0_16.nodeWidth
  L4_20 = A0_16.nodeHeight
  L4_20 = L4_20 - 200
  L5_21 = CCSprite
  L5_21 = L5_21.create
  L5_21 = L5_21(L6_22, L7_23)
  if L5_21 then
    L9_25 = L5_21
    L10_26 = L8_24(L9_25)
    L6_22(L7_23, L8_24, L9_25, L10_26, L8_24(L9_25))
  end
  L5_21 = L6_22
  if L5_21 then
    L9_25 = L5_21
    L10_26 = L8_24(L9_25)
    L6_22(L7_23, L8_24, L9_25, L10_26, L8_24(L9_25))
  end
  L9_25 = L1_17
  L10_26 = L2_18
  L10_26 = L8_24(L9_25, L10_26)
  L6_22(L7_23, L8_24, L9_25, L10_26, L8_24(L9_25, L10_26))
  L9_25 = L3_19
  L10_26 = L4_20
  L10_26 = L8_24(L9_25, L10_26)
  L6_22(L7_23, L8_24, L9_25, L10_26, L8_24(L9_25, L10_26))
  A0_16.data = L6_22
  for L9_25 = 1, L7_23(L8_24) do
    L10_26 = KFDBGetRecordByIdx
    L10_26 = L10_26("IntegralRankReward", L9_25)
    if L10_26 then
      table.insert(A0_16.data, L10_26)
    end
  end
end
function prototype.onBtnReturn(A0_27, A1_28, A2_29)
  SceneHelper:runWithScene("FightPvp", A0_27.rootNode)
end
function prototype.onBtnFeatsRank(A0_30, A1_31, A2_32)
  if A0_30.rankType == Logic.Fight.RANK_TYPE.ALL_RANK then
    Logic:Get("Fight"):SetRankType(Logic.Fight.RANK_TYPE.RANK_REWARD)
    A0_30.rankType = Logic.Fight.RANK_TYPE.RANK_REWARD
  elseif A0_30.rankType == Logic.Fight.RANK_TYPE.MY_RANK then
    Logic:Get("Fight"):SetRankType(Logic.Fight.RANK_TYPE.RANK_REWARD)
    A0_30.rankType = Logic.Fight.RANK_TYPE.RANK_REWARD
  elseif A0_30.rankType == Logic.Fight.RANK_TYPE.RANK_REWARD then
    Logic:Get("Fight"):SetRankType(Logic.Fight.RANK_TYPE.ALL_RANK)
    A0_30.rankType = Logic.Fight.RANK_TYPE.ALL_RANK
  end
  A0_30:updateRankList()
end
function prototype.onBtnMyRank(A0_33, A1_34, A2_35)
  local L3_36
  L3_36 = A0_33.rankType
  if L3_36 == Logic.Fight.RANK_TYPE.ALL_RANK then
    L3_36 = Logic
    L3_36 = L3_36.Get
    L3_36 = L3_36(L3_36, "Fight")
    L3_36 = L3_36.GetMyRankList
    L3_36 = L3_36(L3_36)
    if L3_36 == nil or table.empty(L3_36) then
      Prompt:Fail(TwGetStr(105529))
      return
    end
    Logic:Get("Fight"):SetRankType(Logic.Fight.RANK_TYPE.MY_RANK)
    A0_33.rankType = Logic.Fight.RANK_TYPE.MY_RANK
  else
    L3_36 = A0_33.rankType
    if L3_36 == Logic.Fight.RANK_TYPE.MY_RANK then
      L3_36 = Logic
      L3_36 = L3_36.Get
      L3_36 = L3_36(L3_36, "Fight")
      L3_36 = L3_36.SetRankType
      L3_36(L3_36, Logic.Fight.RANK_TYPE.ALL_RANK)
      L3_36 = Logic
      L3_36 = L3_36.Fight
      L3_36 = L3_36.RANK_TYPE
      L3_36 = L3_36.ALL_RANK
      A0_33.rankType = L3_36
    else
      L3_36 = A0_33.rankType
      if L3_36 == Logic.Fight.RANK_TYPE.RANK_REWARD then
        L3_36 = Logic
        L3_36 = L3_36.Get
        L3_36 = L3_36(L3_36, "Fight")
        L3_36 = L3_36.GetMyRankList
        L3_36 = L3_36(L3_36)
        if L3_36 == nil or table.empty(L3_36) then
          Prompt:Fail(TwGetStr(105529))
          return
        end
        Logic:Get("Fight"):SetRankType(Logic.Fight.RANK_TYPE.MY_RANK)
        A0_33.rankType = Logic.Fight.RANK_TYPE.MY_RANK
      end
    end
  end
  L3_36 = A0_33.updateRankList
  L3_36(A0_33)
end
function prototype.cellSizeForTable(A0_37, ...)
  if A0_37.rankType == Logic.Fight.RANK_TYPE.RANK_REWARD then
    return CCSizeMake(563, 40)
  else
    return CCSizeMake(563, 120)
  end
end
function prototype.tableCellAtIndex(A0_39, A1_40, A2_41, A3_42, A4_43)
  local L5_44
  if not A3_42 then
    L5_44 = CCTableViewCellEx
    L5_44 = L5_44.create
    L5_44 = L5_44(L5_44)
    A3_42 = L5_44
    L5_44 = Tw
    L5_44 = L5_44.Controller
    L5_44 = L5_44.load
    L5_44 = L5_44(L5_44, "FightRankItem", A0_39.rootNode)
    L5_44:RefreshRewardInfo(A0_39.data[A2_41 + 1])
    A3_42:addChild(L5_44, 0, 2)
  else
    L5_44 = A3_42.getChildByTag
    L5_44 = L5_44(A3_42, 2)
    L5_44 = L5_44.RefreshRewardInfo
    L5_44(L5_44, A0_39.data[A2_41 + 1])
  end
  return A3_42
end
function prototype.numberOfCellsInTableView(A0_45, A1_46)
  if A0_45.data == nil or table.empty(A0_45.data) then
    return 0
  end
  return #A0_45.data
end
function prototype.tableCellTouched(A0_47, A1_48, A2_49)
end
function prototype.tablePageTurn(A0_50, A1_51)
  A0_50.tableViewControl:RequireUpdate()
end
function prototype.updateRankList(A0_52)
  if A0_52.rankType == Logic.Fight.RANK_TYPE.ALL_RANK then
    A0_52:loadAllRank()
  elseif A0_52.rankType == Logic.Fight.RANK_TYPE.MY_RANK then
    A0_52:loadMyRank()
  elseif A0_52.rankType == Logic.Fight.RANK_TYPE.RANK_REWARD then
    A0_52:loadRankReward()
  end
  A0_52.tableViewControl:RequireUpdate()
end
