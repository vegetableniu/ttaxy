module((...), package.seeall)
require("SceneHelper")
require("TableViewEx")
require("BtnPosition")
prototype = BtnPosition.prototype:extend()
function prototype.initialize(A0_0)
  super.initialize(A0_0)
  Logic:Get("Talisman"):clearSaleFabaoids()
end
function prototype.onEnter(A0_1)
  local L1_2, L2_3, L3_4
  L1_2 = super
  L1_2 = L1_2.onEnter
  L2_3 = A0_1
  L1_2(L2_3)
  L1_2 = A0_1.pnlConfirm
  L2_3 = L1_2
  L1_2 = L1_2.setAnchorPoint
  L3_4 = CCPoint
  L3_4 = L3_4(0, 0)
  L1_2(L2_3, L3_4, L3_4(0, 0))
  A0_1.hasSaleFabao = false
  A0_1.isCheck = false
  L1_2 = {}
  A0_1.tempSaleFabao = L1_2
  L1_2 = Logic
  L2_3 = L1_2
  L1_2 = L1_2.Get
  L3_4 = "PlayerInfo"
  L1_2 = L1_2(L2_3, L3_4)
  L2_3 = L1_2
  L1_2 = L1_2.GetPlayerLevel
  L1_2 = L1_2(L2_3)
  L2_3 = KFDBGetRecord
  L3_4 = "ConfigValue"
  L2_3 = L2_3(L3_4, "HERO:HERO_SALE_CHECK_LIMIT")
  if L2_3 then
    L3_4 = tonumber
    L3_4 = L3_4(L2_3.content)
    if L1_2 < L3_4 then
      L3_4 = A0_1.btnAutoCheckSale
      L3_4 = L3_4.setEnabled
      L3_4(L3_4, false)
      L3_4 = A0_1.sprRight
      L3_4 = L3_4.setVisible
      L3_4(L3_4, false)
      L3_4 = A0_1.imgBtnRightBg
      L3_4 = L3_4.setVisible
      L3_4(L3_4, false)
    end
  end
  L3_4 = Logic
  L3_4 = L3_4.Get
  L3_4 = L3_4(L3_4, "Talisman")
  L3_4 = L3_4.GetCanSaleTailsman
  L3_4 = L3_4(L3_4)
  A0_1.fabaoPackSize = Logic:Get("Talisman"):GetTalismanSize()
  A0_1.staFabaoNum:setString(TwGetStr(104153, #L3_4 or 0, A0_1.fabaoPackSize))
  if L3_4 == nil or table.empty(L3_4) then
    A0_1.pnlConfirm:setVisible(false)
    return
  end
  A0_1.Fabaos = L3_4
  A0_1.page = math.ceil(#L3_4 / Logic.Talisman.MAX_FABAO_PER_PAGE)
  A0_1.page = A0_1.page == 0 and 1 or A0_1.page
  A0_1.tableViewControl = TableViewEx.prototype:createList(A0_1, A0_1.lstFabaos, A0_1.page)
  A0_1.tableViewControl.tableView:runUIAnimat()
  A0_1.lstFabaos:addChild(A0_1.tableViewControl.tableView)
  A0_1:setPnlConfirm()
  Logic:Get("Talisman"):On(Logic.Talisman.EVT.SELL_FABAO, A0_1:Event("onSellFabao"))
  Logic:Get("Talisman"):On(Logic.Talisman.EVT.OPT_FABAO_SALE, A0_1:Event("OnOptFabaoSale"))
  Logic:Get("Talisman"):On(Logic.Talisman.EVT.LOCK_FABAO_LIST, A0_1:Event("OnLockFabaoList"))
  Logic:Get("Talisman"):On(Logic.Talisman.EVT.UNLOCK_FABAO_LIST, A0_1:Event("OnUnlockFabaoList"))
end
function prototype.OnLockFabaoList(A0_5)
  A0_5.tableViewControl.tableView:setTouchEnabled(false)
  A0_5.tableViewControl.tableView:stopScrolling()
end
function prototype.OnUnlockFabaoList(A0_6)
  A0_6.tableViewControl.tableView:setTouchEnabled(true)
end
function prototype.onSellFabao(A0_7)
  if CCSprite:create("images/newfont/AutoCheck.png") then
    A0_7.sprRight:setDisplayFrame(CCSprite:create("images/newfont/AutoCheck.png"):displayFrame())
  end
  A0_7.isCheck = false
  if not Logic:Get("Talisman"):GetCanSaleTailsman() then
    return
  end
  A0_7.Fabaos = Logic:Get("Talisman"):GetCanSaleTailsman()
  A0_7.page = math.ceil(#Logic:Get("Talisman"):GetCanSaleTailsman() / Logic.Talisman.MAX_FABAO_PER_PAGE)
  A0_7.page = A0_7.page == 0 and 1 or A0_7.page
  A0_7.tableViewControl:RequireUpdate(A0_7.page)
  Logic:Get("Talisman"):ClearSaleFabao()
  A0_7.hasSaleFabao = false
  A0_7.pnlConfirm:setVisible(false)
  Logic:Get("Main"):SetFuncVisible(true)
  Prompt:Tip(104182)
  A0_7.staFabaoNum:setString(TwGetStr(104153, #Logic:Get("Talisman"):GetCanSaleTailsman() or 0, A0_7.fabaoPackSize))
end
function prototype.onExit(A0_8)
  Logic:Get("Talisman"):ClearSaleFabao()
  Logic:Get("Main"):SetFuncVisible(true)
end
function prototype.OnOptFabaoSale(A0_9)
  local L1_10, L2_11, L3_12, L4_13, L5_14, L6_15, L7_16, L8_17
  L1_10 = Logic
  L2_11 = L1_10
  L1_10 = L1_10.Get
  L1_10 = L1_10(L2_11, L3_12)
  L2_11 = L1_10
  L1_10 = L1_10.GetSaleFabao
  L1_10 = L1_10(L2_11)
  if not L1_10 then
    return
  end
  L2_11 = {}
  for L6_15, L7_16 in L3_12(L4_13) do
    L8_17 = Logic
    L8_17 = L8_17.Get
    L8_17 = L8_17(L8_17, "Talisman")
    L8_17 = L8_17.GetTheFabao
    L8_17 = L8_17(L8_17, L6_15)
    if L8_17 then
      table.insert(L2_11, L8_17)
      table.insert(A0_9.tempSaleFabao, L8_17)
    end
  end
  if L3_12 == 0 then
    if L3_12 then
      if L3_12 then
        A0_9.isCheck = false
        L3_12(L4_13)
        A0_9.hasSaleFabao = false
        A0_9.isCheck = false
      end
    end
    L7_16 = 0
    L8_17 = 0
    L3_12(L4_13, L5_14, L6_15, L7_16, L8_17)
  else
    for L7_16 = 1, #L2_11 do
      L8_17 = L2_11[L7_16]
      L8_17 = L8_17.baseId
      L8_17 = L8_17 .. "_" .. L2_11[L7_16].level
      if KFDBGetRecord("TalismanLevelSetting", L8_17) then
      end
    end
    L7_16 = true
    L8_17 = #L2_11
    L4_13(L5_14, L6_15, L7_16, L8_17, L3_12)
  end
end
function prototype.setPnlConfirm(A0_18, A1_19, A2_20, A3_21, A4_22)
  Logic:Get("Main"):SetFuncVisible(not A1_19)
  A0_18.pnlConfirm:setVisible(A1_19)
  A0_18.pnlConfirm.btnSale:setEnabled(A2_20)
  A0_18.pnlConfirm.staNum:setString(tostring(A3_21))
  A0_18.pnlConfirm.staTotal:setString(tostring(A4_22))
  A0_18.pnlConfirm.staNumTip:setStyle(kCCLabelTTFStyleOutline)
  A0_18.pnlConfirm.staNum:setStyle(kCCLabelTTFStyleOutline)
  A0_18.pnlConfirm.staTotalTip:setStyle(kCCLabelTTFStyleOutline)
  A0_18.pnlConfirm.staTotal:setStyle(kCCLabelTTFStyleOutline)
  A0_18.pnlConfirm.staNumTip:setString(TwGetStr(104266))
  A0_18.pnlConfirm.staTotalTip:setString(TwGetStr(104267))
end
function prototype.onBtnReturn(A0_23)
  Logic:Get("Talisman"):ClearSaleFabao()
  SceneHelper:runWithScene("FabaoHome", A0_23.rootNode)
end
function prototype.onBtnAutoCheckSale(A0_24)
  A0_24:filterSaleFabao()
  if not A0_24.hasSaleFabao then
    Prompt:Fail(TwGetStr(112048))
    return
  end
  if A0_24.isCheck then
    A0_24.hasSaleFabao = false
    A0_24:clearCheckFabao()
    A0_24:OnOptFabaoSale()
  end
  A0_24:setImgBtnRightBg()
  Logic:Get("Talisman"):setSaleFabaoids(A0_24.tempSaleFabao)
  A0_24.tableViewControl:RequireUpdateWithoutAnimat(A0_24.page)
end
function prototype.clearCheckFabao(A0_25)
  for _FORV_4_, _FORV_5_ in pairs(A0_25.tempSaleFabao) do
    Logic:Get("Talisman"):RemoveSaleFabao(_FORV_5_.id, true)
  end
  A0_25.tempSaleFabao = {}
end
function prototype.setImgBtnRightBg(A0_26)
  if A0_26.isCheck then
    if CCSprite:create("images/newfont/AutoCheck.png") then
      A0_26.sprRight:setDisplayFrame(CCSprite:create("images/newfont/AutoCheck.png"):displayFrame())
    end
    A0_26.isCheck = false
  else
    if CCSprite:create("images/newfont/Cancel.png") then
      A0_26.sprRight:setDisplayFrame(CCSprite:create("images/newfont/Cancel.png"):displayFrame())
    end
    A0_26.isCheck = true
  end
end
function prototype.filterSaleFabao(A0_27)
  local L1_28, L2_29, L3_30, L4_31, L5_32, L6_33, L7_34
  L1_28 = A0_27.Fabaos
  if L1_28 ~= nil then
    L1_28 = next
    L2_29 = A0_27.Fabaos
    L1_28 = L1_28(L2_29)
  elseif L1_28 == nil then
    return
  end
  L1_28 = Logic
  L2_29 = L1_28
  L1_28 = L1_28.Get
  L1_28 = L1_28(L2_29, L3_30)
  L2_29 = L1_28
  L1_28 = L1_28.GetSaleFabao
  L1_28 = L1_28(L2_29)
  L2_29 = {}
  for L6_33, L7_34 in L3_30(L4_31) do
    L2_29[L7_34.id] = true
  end
  for L6_33, L7_34 in L3_30(L4_31) do
    if KFDBGetRecord("TalismanSetting", L7_34.baseId) and Logic:Get("Hero"):GetHeroInfoByBaseId(KFDBGetRecord("TalismanSetting", L7_34.baseId).baseId) and (KFDBGetRecord("TalismanSetting", L7_34.baseId) and Logic:Get("Hero"):GetHeroInfoByBaseId(KFDBGetRecord("TalismanSetting", L7_34.baseId).baseId)).star == 2 and L7_34.equipHero == nil then
      Logic:Get("Talisman"):AddSaleFabao(L7_34.id, true)
      if not L2_29[L7_34.id] then
        table.insert(A0_27.tempSaleFabao, L7_34)
        L2_29[L7_34.id] = true
      end
      A0_27.hasSaleFabao = true
    end
  end
  L3_30(L4_31)
end
function prototype.onBtnLeft(A0_35)
  if A0_35.tableViewControl then
    A0_35.tableViewControl:TurnPage(-1)
  end
end
function prototype.onBtnRight(A0_36)
  if A0_36.tableViewControl then
    A0_36.tableViewControl:TurnPage(1)
  end
end
function prototype.cellSizeForTable(A0_37, ...)
  return CCSizeMake(563, 130)
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
    L5_44 = L5_44(L5_44, "FabaoSaleSelectItem", A0_39.rootNode)
    L5_44:ReFrashInfo(A0_39.Fabaos[(A4_43 - 1) * Logic.Talisman.MAX_FABAO_PER_PAGE + A2_41 + 1])
    A3_42:addChild(L5_44, 0, 2)
  else
    L5_44 = A3_42.getChildByTag
    L5_44 = L5_44(A3_42, 2)
    L5_44 = L5_44.ReFrashInfo
    L5_44(L5_44, A0_39.Fabaos[(A4_43 - 1) * Logic.Talisman.MAX_FABAO_PER_PAGE + A2_41 + 1])
  end
  return A3_42
end
function prototype.numberOfCellsInTableView(A0_45, A1_46)
  local L2_47, L3_48
  L2_47 = A0_45.staPage
  L3_48 = L2_47
  L2_47 = L2_47.setString
  L2_47(L3_48, string.format("%d/%d", A1_46 or 1, A0_45.page or 1))
  L2_47 = A0_45.page
  if L2_47 == A1_46 then
    L2_47 = A0_45.Fabaos
    if L2_47 then
      L2_47 = A0_45.Fabaos
      L2_47 = #L2_47
      L3_48 = A0_45.page
      L3_48 = L3_48 - 1
      L3_48 = L3_48 * Logic.Talisman.MAX_FABAO_PER_PAGE
      L2_47 = L2_47 - L3_48
      return L2_47
    end
  else
    L2_47 = Logic
    L2_47 = L2_47.Talisman
    L2_47 = L2_47.MAX_FABAO_PER_PAGE
    return L2_47
  end
end
function prototype.tableCellTouched(A0_49, A1_50, A2_51)
end
function prototype.tablePageTurn(A0_52, A1_53)
  A0_52.tableViewControl:RequireUpdate()
end
