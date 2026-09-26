module((...), package.seeall)
require("SceneHelper")
require("TableViewEx")
require("BtnPosition")
prototype = BtnPosition.prototype:extend()
function prototype.initialize(A0_0)
  super.initialize(A0_0)
end
function prototype.onEnter(A0_1)
  super.onEnter(A0_1)
  A0_1:oncreatetabelview()
  Logic:Get("Talisman"):On(Logic.Talisman.EVT.GET_ALL_HERO_FABAO, A0_1:Event("onGetAllHeroFabao"))
  Logic:Get("Talisman"):On(Logic.Talisman.EVT.RETURN_BACK, A0_1:Event("ontoArtifact"))
  Logic:Get("Talisman"):On(Logic.Talisman.EVT.OPT_UPGRADEFABAO_SET, A0_1:Event("onUpdateFabaoSelect"))
  Logic:Get("Talisman"):On(Logic.Talisman.EVT.HAD_SELECT_PUT_ON_FABAO, A0_1:Event("onHadSelectPutonFabao"))
end
function prototype.oncreatetabelview(A0_2)
  local L1_3, L2_4
  L1_3 = {}
  L2_4 = Logic
  L2_4 = L2_4.Get
  L2_4 = L2_4(L2_4, "Talisman")
  L2_4 = L2_4.getOpenStyle
  L2_4 = L2_4(L2_4)
  if L2_4 then
    L2_4 = Logic
    L2_4 = L2_4.Get
    L2_4 = L2_4(L2_4, "Talisman")
    L2_4 = L2_4.getCanUpgradeFabao
    L2_4 = L2_4(L2_4)
    L1_3 = L2_4
  else
    L2_4 = Logic
    L2_4 = L2_4.Get
    L2_4 = L2_4(L2_4, "Talisman")
    L2_4 = L2_4.getAlltailsmanByCheck
    L2_4 = L2_4(L2_4)
    L1_3 = L2_4
  end
  if L1_3 then
    A0_2.Fabaos = L1_3
    A0_2.data = L1_3
    L2_4 = math
    L2_4 = L2_4.ceil
    L2_4 = L2_4(#L1_3 / Logic.Talisman.MAX_FABAO_PER_PAGE)
    A0_2.page = L2_4
    L2_4 = A0_2.page
    if L2_4 == 0 then
      L2_4 = 1
    else
      L2_4 = L2_4 or A0_2.page
    end
    A0_2.page = L2_4
    L2_4 = TableViewEx
    L2_4 = L2_4.prototype
    L2_4 = L2_4.createList
    L2_4 = L2_4(L2_4, A0_2, A0_2.lstFabao, A0_2.page)
    A0_2.tableViewControl = L2_4
    L2_4 = A0_2.lstFabao
    L2_4 = L2_4.addChild
    L2_4(L2_4, A0_2.tableViewControl.tableView)
  end
  L2_4 = Logic
  L2_4 = L2_4.Get
  L2_4 = L2_4(L2_4, "Talisman")
  L2_4 = L2_4.getOpenStyle
  L2_4 = L2_4(L2_4)
  if not L2_4 then
    L2_4 = Logic
    L2_4 = L2_4.Get
    L2_4 = L2_4(L2_4, "Talisman")
    L2_4 = L2_4.GetTalismanSize
    L2_4 = L2_4(L2_4)
    A0_2.staFabaoNum:setString(TwGetStr(104153, #(Logic:Get("Talisman"):GetCanSaleTailsman() or {}), L2_4))
  else
    L2_4 = A0_2.imgNumBg
    L2_4 = L2_4.setVisible
    L2_4(L2_4, false)
  end
end
function prototype.onGetAllHeroFabao(A0_5)
  local L1_6
  L1_6 = {}
  if Logic:Get("Talisman"):getOpenStyle() then
    L1_6 = Logic:Get("Talisman"):getCanUpgradeFabao()
  else
    L1_6 = Logic:Get("Talisman"):getAlltailsmanByCheck()
  end
  if L1_6 then
    A0_5.Fabaos = L1_6
  end
end
function prototype.onHadSelectPutonFabao(A0_7, A1_8)
end
function prototype.onBtnReturn(A0_9)
  SceneHelper:popScene()
end
function prototype.onBtnEnter(A0_10)
  Logic:Get("Talisman"):ClearSelectFabao()
  SceneHelper:runWithScene("FabaoSaleSelect", A0_10.rootNode)
end
function prototype.ontoArtifact(A0_11)
  SceneHelper:runWithScene("Artifact", A0_11.rootNode)
end
function prototype.onBtnLeft(A0_12)
  if A0_12.tableViewControl ~= nil then
    A0_12.tableViewControl:TurnPage(-1)
  end
end
function prototype.onBtnRight(A0_13)
  if A0_13.tableViewControl ~= nil then
    A0_13.tableViewControl:TurnPage(1)
  end
end
function prototype.onNoShowFabaos(A0_14, A1_15)
  local L2_16, L3_17, L4_18, L5_19, L6_20, L7_21, L8_22
  L2_16 = Logic
  L3_17 = L2_16
  L2_16 = L2_16.Get
  L2_16 = L2_16(L3_17, L4_18)
  L3_17 = L2_16
  L2_16 = L2_16.GetSelectHero
  L2_16 = L2_16(L3_17)
  L3_17 = {}
  if A1_15 then
    if L4_18 ~= 0 then
      for L7_21, L8_22 in L4_18(L5_19) do
        if Logic:Get("Hero"):GetHeroInfosByIds({
          L8_22.equipHero
        }) and #Logic:Get("Hero"):GetHeroInfosByIds({
          L8_22.equipHero
        }) == 0 and L8_22 then
          table.insert(L3_17, L8_22)
        elseif #Logic:Get("Hero"):GetHeroInfosByIds({
          L8_22.equipHero
        }) ~= 0 and #Logic:Get("Hero"):GetHeroInfosByIds({
          L8_22.equipHero
        })[1] and Logic:Get("Hero"):GetHeroInfosByIds({
          L8_22.equipHero
        })[1].baseId == L2_16.baseId and L8_22 then
          table.insert(L3_17, L8_22)
        end
      end
    end
  end
  return L3_17
end
function prototype.onUpdateFabaoSelect(A0_23)
  A0_23.tableViewControl:RequireUpdateWithoutAnimat()
end
function prototype.cellSizeForTable(A0_24, ...)
  return CCSizeMake(563, 117)
end
function prototype.tableCellAtIndex(A0_26, A1_27, A2_28, A3_29, A4_30)
  local L5_31
  if not A3_29 then
    L5_31 = CCTableViewCellEx
    L5_31 = L5_31.create
    L5_31 = L5_31(L5_31)
    A3_29 = L5_31
    L5_31 = Tw
    L5_31 = L5_31.Controller
    L5_31 = L5_31.load
    L5_31 = L5_31(L5_31, "FabaoUpgradeSelectItem", A0_26.rootNode)
    L5_31:ReFrashInfo(A0_26.data[(A4_30 - 1) * Logic.Talisman.MAX_FABAO_PER_PAGE + A2_28 + 1])
    A3_29:addChild(L5_31, 0, 2)
  else
    L5_31 = A3_29.getChildByTag
    L5_31 = L5_31(A3_29, 2)
    L5_31 = L5_31.ReFrashInfo
    L5_31(L5_31, A0_26.data[(A4_30 - 1) * Logic.Talisman.MAX_FABAO_PER_PAGE + A2_28 + 1])
  end
  return A3_29
end
function prototype.numberOfCellsInTableView(A0_32, A1_33)
  local L2_34, L3_35
  L2_34 = A0_32.staPage
  L3_35 = L2_34
  L2_34 = L2_34.setString
  L2_34(L3_35, string.format("%d/%d", A1_33 or 1, A0_32.page or 1))
  L2_34 = A0_32.page
  if L2_34 == A1_33 then
    L2_34 = A0_32.Fabaos
    L2_34 = #L2_34
    L3_35 = A0_32.page
    L3_35 = L3_35 - 1
    L3_35 = L3_35 * Logic.Talisman.MAX_FABAO_PER_PAGE
    L2_34 = L2_34 - L3_35
    return L2_34
  else
    L2_34 = Logic
    L2_34 = L2_34.Talisman
    L2_34 = L2_34.MAX_FABAO_PER_PAGE
    return L2_34
  end
end
function prototype.tableCellTouched(A0_36, A1_37, A2_38)
end
function prototype.tablePageTurn(A0_39, A1_40)
  A0_39.tableViewControl:RequireUpdate()
end
