local L0_0
L0_0 = module
L0_0((...), package.seeall)
L0_0 = require
L0_0("Logic")
L0_0 = Logic
L0_0 = L0_0.class
L0_0 = L0_0.subclass
L0_0 = L0_0(L0_0)
class = L0_0
L0_0 = Enum
L0_0 = L0_0({
  "ALL_FABAOS",
  "ALL_FRAGMENTS",
  "GET_FRAGMENT_EVT",
  "GET_NOT_HERO_FABAO",
  "GET_ALL_HERO_FABAO",
  "RETURN_BACK",
  "OPT_UPGRADEFABAO_SET",
  "FABAO_CHANGE",
  "RECEIVE_THE_REQ_FABAO",
  "CHANGE_UPDATE_STATE",
  "CHANGE_IMG_FABAO",
  "CHANGE_IMG_GREEN",
  "CLEAR_IMG_GREEN",
  "UPDATE_FABAO_SELECT",
  "HAD_SELECT_PUT_ON_FABAO",
  "HAN_SELECT_SWALL_FABAO",
  "SELL_FABAO",
  "OPT_FABAO_SALE",
  "LOCK_FABAO_LIST",
  "UNLOCK_FABAO_LIST",
  "OPT_FABAO_SWALLOW",
  "OPT_SWALLOWFABAO_SET",
  "REFRESH_OPEN_DRAGON_KING",
  "CONFIG_SELE_TREASURE_BTN",
  "OPT_UPGRADE_FABAO",
  "SELEL_EQUIP_FABAO"
})
EVT = L0_0
L0_0 = 20
MAX_FABAO_PER_PAGE = L0_0
L0_0 = 5
MAX_FABAO_SWALL_PER_PAGE = L0_0
L0_0 = 6
MAXSWALLOW_NUM = L0_0
L0_0 = TypeDef
L0_0 = L0_0("com.eyu.mt.module.talisman.facade.TalismanResult")
function class.initialize(A0_1)
  super.initialize(A0_1)
  A0_1.getfabaotype = 0
  A0_1.allfabaos = {}
  A0_1.resfabaos = {}
  A0_1.selecthero = nil
  A0_1.selectfabaoids = {}
  A0_1.swallfabaos = {}
  A0_1.salefabaoids = {}
  A0_1.beforeUpdate = {}
  A0_1.buyTalismanPack = 0
  A0_1.packSize = 0
  A0_1.allherotalismanVos = {}
  A0_1.checkstae = 0
  A0_1.sales = {}
  A0_1.liebi = 0
  Logic:Get("MsgAssist"):RecordErrorMsg("MsgTalisman", _UPVALUE0_, _UPVALUE1_)
  MsgTalisman:On("LOAD_ALL_HERO_TALISMAN", A0_1:Event("OnLoadAllHeroTalisman"))
  MsgTalisman:On("LOAD_ALL_TALISMAN", A0_1:Event("OnLoadAllTalisman"))
  MsgTalisman:On("EQUIP_TALISMAN", A0_1:Event("OnEquipTalisman"))
  MsgTalisman:On("UNEQUIP_TALISMAN", A0_1:Event("OnUnequipTalismal"))
  MsgTalisman:On("EXCHANGE_TALISMAN", A0_1:Event("OnExchangeTalisman"))
  MsgTalisman:On("LOAD_TALISMAN", A0_1:Event("OnLoadTalisman"))
  MsgTalisman:On("GET_TALISMAN_TMP_PACK_INFO", A0_1:Event("OnTalismanTmpPackInfo"))
  MsgTalisman:On("UPGRADE_TALISMAN", A0_1:Event("OnUpgradeTalisman"))
  MsgTalisman:On("GET_FRAGMENT", A0_1:Event("OnGetFragment"))
  MsgTalisman:On("CELL_TALISMAN", A0_1:Event("OnSellTalisman"))
  MsgTalisman:On("BUY_TALISMAN_PACK_SPACE", A0_1:Event("OnBuyTalismanPackSpace"))
  MsgTalisman:On("OPEN_DRAGON_KING", A0_1:Event("OnOpenDragonKing"))
  MsgTalisman:On("REPLACE_HERO_TALISMANS", A0_1:Event("OnReplaceHeroTalismans"))
  MsgTalisman:On("BUY_TALISMAN_PACK_SPACE_BY_COUPON", A0_1:Event("OnBuyTalismanPackSpaceByCoupon"))
  MsgTalisman:On("CONVERT_TALISMAN", A0_1:Event("OnConvertTalisman"))
  MsgTalisman:On("ADVANCE_TALISMAN", A0_1:Event("OnAdvanceTalisman"))
  MsgTalisman:On("ADVANCE_SWALLOW_TALISMAN", A0_1:Event("OnAdvanceSwallowTalisman"))
end
function class.OnLoadAllHeroTalisman(A0_2, A1_3, A2_4)
  local L3_5
  A0_2.allherotalismanVos = A2_4
  L3_5 = A0_2.GetSelectImgGreen
  L3_5 = L3_5(A0_2)
  if L3_5 then
    A0_2:FireEvent(EVT.CHANGE_IMG_FABAO)
    A0_2:FireEvent(EVT.CHANGE_IMG_GREEN, L3_5)
  end
end
function class.OnLoadAllTalisman(A0_6, A1_7, A2_8)
  if A1_7 == 0 then
    A0_6.TalismanVos = A2_8
    A0_6.tails_Key_ids = {}
    for _FORV_6_, _FORV_7_ in pairs(A0_6.TalismanVos) do
      A0_6.tails_Key_ids[_FORV_7_.id] = _FORV_7_
    end
    if A0_6.TalismanVos then
      A0_6.allfabaos = A0_6.TalismanVos
      A0_6.resfabaos = {}
      for _FORV_6_ = 1, #A0_6.TalismanVos do
        if A0_6.TalismanVos[_FORV_6_].equipHero == nil then
          table.insert(A0_6.resfabaos, A0_6.TalismanVos[_FORV_6_])
        end
      end
      if _FOR_ == 1 then
        A0_6:FireEvent(EVT.GET_NOT_HERO_FABAO)
        A0_6.getfabaotype = 2
      elseif A0_6.getfabaotype == 0 then
        A0_6:FireEvent(EVT.GET_ALL_HERO_FABAO)
        A0_6.getfabaotype = 2
      end
    end
  end
end
function class.OnEquipTalisman(A0_9, A1_10, A2_11)
  local L3_12, L4_13, L5_14, L6_15, L7_16, L8_17, L9_18, L10_19, L11_20
  for L6_15, L7_16 in L3_12(L4_13) do
    for L11_20, _FORV_12_ in L8_17(L9_18) do
      if A0_9.allfabaos[L11_20].id == L7_16 then
        A0_9.allfabaos[L11_20].equipHero = A0_9.selecthero.id
      end
    end
  end
  for L6_15, L7_16 in L3_12(L4_13) do
    for L11_20, _FORV_12_ in L8_17(L9_18) do
      if A0_9.resfabaos[L11_20].id == L7_16 then
        table.remove(A0_9.resfabaos, L11_20)
      end
    end
  end
  for L6_15, L7_16 in L3_12(L4_13) do
    if L8_17 == L9_18 then
      for L11_20, _FORV_12_ in L8_17(L9_18) do
        for _FORV_16_, _FORV_17_ in ipairs(A0_9.allfabaos) do
          if _FORV_12_ == A0_9.allfabaos[_FORV_16_].id then
            table.insert(A0_9.allherotalismanVos[L6_15].talismanVos, A0_9.allfabaos[_FORV_16_])
          end
        end
      end
    end
  end
  A0_9.TalismanVos = L3_12
  L3_12(L4_13, L5_14)
end
function class.OnSellTalisman(A0_21, A1_22, A2_23)
  local L3_24, L4_25, L5_26, L6_27, L7_28
  for L6_27, L7_28 in L3_24(L4_25) do
    A0_21:UpDataTailsmans_Dele(L7_28)
  end
  L3_24(L4_25, L5_26)
  L3_24(L4_25, L5_26)
end
function class.OnUnequipTalismal(A0_29, A1_30, A2_31)
  local L3_32, L4_33, L5_34, L6_35, L7_36, L8_37, L9_38, L10_39, L11_40, L12_41, L13_42, L14_43, L15_44, L16_45
  for L6_35, L7_36 in L3_32(L4_33) do
    if L8_37 == L9_38 then
      for L11_40, L12_41 in L8_37(L9_38) do
        for L16_45, _FORV_17_ in L13_42(L14_43) do
          if L12_41 == L7_36.talismanVos[L16_45].id then
            table.remove(A0_29.allherotalismanVos[L6_35].talismanVos, L16_45)
          end
        end
      end
    end
  end
  for L6_35, L7_36 in L3_32(L4_33) do
    for L11_40, L12_41 in L8_37(L9_38) do
      if L7_36 == L13_42 then
        L13_42(L14_43, L15_44)
      end
    end
  end
  if L3_32 then
    for L6_35, L7_36 in L3_32(L4_33) do
      for L11_40, L12_41 in L8_37(L9_38) do
        if L13_42 == L7_36 then
          L13_42.equipHero = nil
          if L13_42 == 0 then
            L14_43(L15_44)
          end
        end
      end
    end
  end
  L3_32(L4_33)
  L3_32(L4_33, L5_34)
end
function class.OnExchangeTalisman(A0_46, A1_47, A2_48)
  local L3_49
  L3_49 = A2_48.fragment
  A0_46.fragment = L3_49
  L3_49 = A2_48.liebi
  A0_46.liebi = L3_49
  L3_49 = A2_48.rewardResult
  A0_46.rewardResult = L3_49
  L3_49 = A0_46.FireEvent
  L3_49(A0_46, EVT.GET_FRAGMENT_EVT)
  L3_49 = Logic
  L3_49 = L3_49.Get
  L3_49 = L3_49(L3_49, "WeChat")
  L3_49 = L3_49.Tailisman
  L3_49(L3_49, A2_48.rewardResult)
  L3_49 = Logic
  L3_49 = L3_49.Get
  L3_49 = L3_49(L3_49, "Reward")
  L3_49 = L3_49.AddRewards
  L3_49(L3_49, A2_48.rewardResult)
  L3_49 = Logic
  L3_49 = L3_49.Get
  L3_49 = L3_49(L3_49, "Reward")
  L3_49 = L3_49.AddRewardsTip
  L3_49 = L3_49(L3_49, A2_48.rewardResult)
  Prompt:Tip(L3_49)
end
function class.OnLoadTalisman(A0_50, A1_51, A2_52)
  A0_50:FireEvent(EVT.RECEIVE_THE_REQ_FABAO, A2_52)
end
function class.OnUpgradeTalisman(A0_53, A1_54, A2_55)
  for _FORV_6_, _FORV_7_ in ipairs(A0_53.swallfabaos) do
    A0_53:UpDataTailsmans_Dele(_FORV_7_.id)
  end
  A0_53.beforeUpdate = A0_53.upgradeFabao
  A0_53.upgradeFabao = A2_55
  A0_53:UpDataTailsmans(A2_55)
  A0_53:FireEvent(EVT.CHANGE_UPDATE_STATE, A2_55)
end
function class.OnConvertTalisman(A0_56, A1_57, A2_58)
  local L3_59, L4_60, L5_61, L6_62, L7_63
  if A1_57 ~= 0 or A2_58 == nil then
    return
  end
  for L6_62, L7_63 in L3_59(L4_60) do
    A0_56:UpDataTailsmans_Dele(L7_63)
  end
  A0_56.pendingConvertIds = L3_59
  L3_59(L4_60, L5_61)
  L6_62 = A2_58
  L3_59(L4_60, L5_61, L6_62)
  L6_62 = {}
  L6_62.type = 0
  L6_62.code = 0
  L6_62.amount = -10000000
  L6_62 = true
  L3_59(L4_60, L5_61, L6_62)
end
function class.OnAdvanceTalisman(A0_64, A1_65, A2_66)
  if A1_65 ~= 0 or A2_66 == nil then
    return
  end
  A0_64:OnUpgradeTalisman(A1_65, A2_66)
  A0_64:ClearSwallFabaos()
end
function class.OnAdvanceSwallowTalisman(A0_67, A1_68, A2_69)
  if A1_68 ~= 0 or A2_69 == nil then
    return
  end
  for _FORV_6_, _FORV_7_ in ipairs(A0_67.swallfabaos or {}) do
    if _FORV_7_ and _FORV_7_.id then
      A0_67:UpDataTailsmans_Dele(_FORV_7_.id)
    end
  end
  A0_67:ClearSwallFabaos()
  A0_67.upgradeFabao = A2_69
  A0_67:UpDataTailsmans(A2_69)
  A0_67:FireEvent(EVT.CHANGE_UPDATE_STATE, A2_69)
end
function class.OnBuyTalismanPackSpace(A0_70, A1_71, A2_72)
  local L3_73
  L3_73 = KFDBGetRecord
  L3_73 = L3_73("ConfigValue", "TALISMAN:PACK_CAPACITY")
  A0_70.packSize = tonumber(L3_73.content) + A2_72.extendLimit
  L3_73 = KFDBGetRecord("ConfigValue", "TALISMAN:BUY_PACK_CAPACITY_VALUE")
  A0_70.buyTalismanPack = A2_72.extendLimit / tonumber(L3_73.content)
  Logic:Get("Cost"):AddCosts(A2_72.vcoinCost)
  Prompt:Msg(TwGetStr(105207))
end
function class.OnOpenDragonKing(A0_74, A1_75, A2_76)
  A0_74.openDragonCount = A0_74.openDragonCount + 1
  Logic:Get("FabaoLookFor"):SetFabaoRank(A2_76.rank)
  Logic:Get("Cost"):AddCosts(A2_76.vcoinCost)
  A0_74:FireEvent(EVT.REFRESH_OPEN_DRAGON_KING)
end
function class.OnGetFragment(A0_77, A1_78, A2_79)
  A0_77.fragment = A2_79.fragment
  A0_77.liebi = A2_79.liebi
  A0_77.fabaoPackAdd = A2_79.extendLimit
  A0_77:FireEvent(EVT.GET_FRAGMENT_EVT)
end
function class.OnTalismanTmpPackInfo(A0_80, A1_81, A2_82)
  local L3_83
  L3_83 = A2_82.openDragonCount
  A0_80.openDragonCount = L3_83
  L3_83 = A2_82.rank
  A0_80.rank = L3_83
  L3_83 = A2_82.treasures
  A0_80.treasures = L3_83
end
function class.PostBuyPack(A0_84)
  MsgTalisman:Post("BUY_TALISMAN_PACK_SPACE")
end
function class.PostSellFabao(A0_85, A1_86)
  MsgTalisman:Post("CELL_TALISMAN", {talismanIds = A1_86})
end
function class.Post_REPLACE_HERO_TALISMANS(A0_87, A1_88, A2_89)
  MsgTalisman:Post("REPLACE_HERO_TALISMANS", {heroId = A1_88, talismanIds = A2_89})
end
function class.PostBuyPackByCoupon(A0_90)
  MsgTalisman:Post("BUY_TALISMAN_PACK_SPACE_BY_COUPON")
end
function class.onChangeImgFabao(A0_91)
  if A0_91:GetSelectImgGreen() then
    A0_91:FireEvent(EVT.CHANGE_IMG_FABAO)
  end
end
function class.setCheckState(A0_92, A1_93)
  A0_92.checkstae = A1_93
end
function class.SetUpgradeFabao(A0_94, A1_95)
  if A1_95 then
    A0_94.upgradeFabao = A1_95
    A0_94:FireEvent(EVT.OPT_UPGRADEFABAO_SET)
  end
end
function class.GetDragonCount(A0_96)
  return A0_96.openDragonCount or 0
end
function class.GetTheDragonMaxTimes(A0_97)
  local L1_98, L2_99, L3_100, L4_101, L5_102, L6_103
  L1_98 = 0
  L2_99 = Logic
  L2_99 = L2_99.Get
  L2_99 = L2_99(L3_100, L4_101)
  L2_99 = L2_99.GetPlayerMoney
  L2_99 = L2_99(L3_100)
  for L6_103 = 1, L4_101(L5_102) do
    if KFDBGetRecordByIdx("Charge2Times", L6_103) and KFDBGetRecordByIdx("Charge2Times", L6_103).type == "TALISMAN_OPEN_DRAGON_KING" and L2_99.totalCharge >= KFDBGetRecordByIdx("Charge2Times", L6_103).chargeAmount and L1_98 < KFDBGetRecordByIdx("Charge2Times", L6_103).addTimes then
      L1_98 = KFDBGetRecordByIdx("Charge2Times", L6_103).addTimes
    end
  end
  return L1_98
end
function class.IsInMaxLevel(A0_104, A1_105)
  if KFDBGetRecord("TalismanSetting", A1_105.baseId) and A1_105.level < KFDBGetRecord("TalismanSetting", A1_105.baseId).maxLevel then
    return false
  end
  return true
end
function class.GetUpgradeFabao(A0_106)
  local L1_107
  L1_107 = A0_106.upgradeFabao
  return L1_107
end
function class.GetTemFabaos(A0_108)
  local L1_109
  L1_109 = A0_108.temfabaos
  return L1_109
end
function class.SetTemFabaos(A0_110, A1_111)
  if A1_111 and A0_110.temfabaos then
    table.insert(A0_110.temfabaos, A1_111)
    A0_110:FireEvent(EVT.OPT_FABAO_SWALLOW)
  end
end
function class.DeleteTemFabao(A0_112, A1_113)
  local L2_114, L3_115, L4_116, L5_117
  if A1_113 then
  elseif not L2_114 then
    return
  end
  for L5_117 = 1, #L3_115 do
    if A1_113 == A0_112.temfabaos[L5_117] then
      table.remove(A0_112.temfabaos, L5_117)
      A0_112:FireEvent(EVT.OPT_FABAO_SWALLOW)
      break
    end
  end
end
function class.AllTemFabaoExp(A0_118)
  local L1_119, L2_120, L3_121, L4_122, L5_123, L6_124
  L1_119 = 0
  if L2_120 ~= nil then
    if L2_120 ~= 0 then
      for L5_123, L6_124 in L2_120(L3_121) do
        if L6_124 then
          L1_119 = L1_119 + A0_118:GetFabaoSwallowExp(L6_124)
        end
      end
    end
  end
  return L1_119
end
function class.ClearSwallFabaos(A0_125)
  A0_125.swallfabaos = {}
end
function class.CopySwallFabaos(A0_126)
  local L1_127, L2_128, L3_129, L4_130, L5_131
  A0_126.temfabaos = L1_127
  if L1_127 then
    if L1_127 ~= 0 then
      for L4_130, L5_131 in L1_127(L2_128) do
        table.insert(A0_126.temfabaos, L5_131)
      end
    end
  end
end
function class.IsInTemFabao(A0_132, A1_133)
  local L4_134, L7_135
  if A1_133 then
    if L4_134 then
      for _FORV_5_ = 1, #L7_135 do
        if A1_133.id == A0_132.temfabaos[_FORV_5_].id then
          return true
        end
      end
    end
  end
  return L4_134
end
function class.SetSwallFabaos(A0_136)
  local L1_137, L2_138, L3_139, L4_140, L5_141
  A0_136.swallfabaos = L1_137
  if L1_137 then
    if L1_137 ~= 0 then
      for L4_140, L5_141 in L1_137(L2_138) do
        table.insert(A0_136.swallfabaos, L5_141)
      end
    end
  end
end
function class.GetSwallFabaos(A0_142)
  local L1_143
  L1_143 = A0_142.swallfabaos
  return L1_143
end
function class.SetSaleFabaoids(A0_144, A1_145)
  if A1_145 and A0_144.salefabaoids then
    table.insert(A0_144.salefabaoids, A1_145)
  end
end
function class.DeleteSaleFabaoid(A0_146, A1_147)
  local L2_148, L3_149, L4_150, L5_151
  if A1_147 then
    if L2_148 then
      for L5_151 = 1, #L3_149 do
        if A1_147 == A0_146.salefabaoids[L5_151] then
          table.remove(A0_146.salefabaoids, L5_151)
        end
      end
    end
  end
end
function class.IsInSaleFabaoids(A0_152, A1_153)
  local L4_154, L6_155
  if A1_153 then
    if L4_154 then
      for _FORV_5_ = 1, #L6_155 do
        if A1_153 == A0_152.salefabaoids[_FORV_5_] then
          return true
        end
      end
    end
  end
  return L4_154
end
function class.clearSaleFabaoids(A0_156)
  A0_156.salefabaoids = {}
end
function class.setSaleFabaoids(A0_157, A1_158)
  A0_157.salefabaoids = {}
  if A1_158 then
    for _FORV_5_, _FORV_6_ in ipairs(A1_158) do
      table.insert(A0_157.salefabaoids, _FORV_6_.id)
    end
  end
end
function class.AddSaleFabao(A0_159, A1_160, A2_161)
  if not A1_160 then
    return
  end
  A0_159.sales[A1_160] = true
  if not A2_161 then
    A0_159:FireEvent(EVT.OPT_FABAO_SALE)
  end
end
function class.RemoveSaleFabao(A0_162, A1_163, A2_164)
  if not A1_163 then
    return
  end
  A0_162.sales[A1_163] = nil
  if not A2_164 then
    A0_162:FireEvent(EVT.OPT_FABAO_SALE)
  end
end
function class.ClearSaleFabao(A0_165)
  A0_165.sales = {}
end
function class.GetSaleFabao(A0_166)
  local L1_167
  L1_167 = A0_166.sales
  return L1_167
end
function class.onGetUpgradeExp(A0_168, A1_169)
  local L2_170
  if A1_169 ~= nil then
    L2_170 = A1_169.exp
  elseif L2_170 == nil then
    L2_170 = -1
    return L2_170
  end
  L2_170 = A1_169.baseId
  L2_170 = L2_170 .. "_" .. A1_169.level
  if KFDBGetRecord("TalismanLevelSetting", L2_170) == nil or KFDBGetRecord("TalismanLevelSetting", L2_170).exp == nil then
    return -2
  end
  return KFDBGetRecord("TalismanLevelSetting", L2_170).exp
end
function class.SetTotalSwallFabaos(A0_171, A1_172)
  A0_171.swallfabaos = A1_172
end
function class.upgradeFabaoFullExp(A0_173, A1_174)
  local L2_175, L3_176, L4_177, L5_178, L6_179, L7_180, L8_181, L9_182, L10_183
  L2_175 = 0
  if A1_174 == nil then
    return L2_175
  end
  L3_176 = A1_174.level
  if L3_176 then
    L3_176 = A1_174.level
    if L3_176 <= 0 then
      return
    end
  end
  L3_176 = KFDBGetRecord
  L4_177 = "TalismanSetting"
  L5_178 = A1_174.baseId
  L3_176 = L3_176(L4_177, L5_178)
  if L3_176 then
    L4_177 = tonumber
    L5_178 = L3_176.maxLevel
    L4_177 = L4_177(L5_178)
  else
    L4_177 = L4_177 or 0
  end
  L5_178 = 0
  for L9_182 = A1_174.level, L4_177 do
    L10_183 = tostring
    L10_183 = L10_183(A1_174.baseId)
    L10_183 = L10_183 .. "_" .. tostring(L9_182)
    L3_176 = KFDBGetRecord("TalismanLevelSetting", L10_183)
    if L3_176 and L3_176.exp then
      L5_178 = L5_178 + L3_176.exp
    end
  end
  L5_178 = L5_178 - L6_179
  return L5_178
end
function class.CanUpgradeTo(A0_184, A1_185)
  local L2_186, L3_187, L4_188, L5_189, L6_190, L7_191, L8_192, L9_193, L10_194, L11_195, L12_196, L13_197
  if A1_185 == nil then
    L2_186 = 0
    return L2_186
  end
  L3_187 = A0_184
  L2_186 = A0_184.AllSwallowFabaoExp
  L2_186 = L2_186(L3_187)
  L3_187 = A1_185.level
  if A1_185 then
    L4_188 = A1_185.level
    if L4_188 then
      L5_189 = A0_184
      L4_188 = A0_184.GetNextExpByIdAndlevel
      L6_190 = A1_185.baseId
      L7_191 = A1_185.level
      L4_188 = L4_188(L5_189, L6_190, L7_191)
      L5_189 = A1_185.exp
      L6_190 = A1_185.baseId
      L7_191 = "_"
      L8_192 = A1_185.level
      L6_190 = L6_190 .. L7_191 .. L8_192
      L7_191 = L4_188 - L5_189
      if L2_186 < L7_191 then
        L7_191 = A1_185.level
        return L7_191
      end
      L7_191 = KFDBGetRecord
      L8_192 = "TalismanSetting"
      L9_193 = A1_185.baseId
      L7_191 = L7_191(L8_192, L9_193)
      L8_192 = 0
      L9_193 = L5_189 + L2_186
      for L13_197 = A1_185.level, L7_191.maxLevel do
        if A0_184:GetNextExpByIdAndlevel(A1_185.baseId, L13_197) == 0 then
          break
        end
        L8_192 = L8_192 + A0_184:GetNextExpByIdAndlevel(A1_185.baseId, L13_197)
        if L2_186 >= L8_192 - L5_189 then
          L3_187 = L3_187 + 1
        else
          break
        end
      end
    end
  end
  return L3_187
end
function class.AllSwallowFabaoExp(A0_198)
  local L1_199, L2_200, L3_201, L4_202, L5_203, L6_204
  L1_199 = 0
  if L2_200 ~= nil then
    if L2_200 ~= 0 then
      for L5_203, L6_204 in L2_200(L3_201) do
        if L6_204 then
          L1_199 = L1_199 + A0_198:GetFabaoSwallowExp(L6_204)
        end
      end
    end
  end
  return L1_199
end
function class.GetFabaoSwallowExp(A0_205, A1_206)
  local L2_207
  if A1_206 ~= nil then
    L2_207 = A1_206.baseId
    if L2_207 ~= nil then
      L2_207 = A1_206.level
    end
  elseif L2_207 == nil then
    L2_207 = 0
    return L2_207
  end
  L2_207 = A1_206.baseId
  L2_207 = L2_207 .. "_" .. A1_206.level
  if L2_207 == nil then
    return 0
  end
  if KFDBGetRecord("TalismanLevelSetting", L2_207) == nil then
    return 0
  end
  return (A1_206.exp + KFDBGetRecord("TalismanLevelSetting", L2_207).accumulateExp) * KFDBGetRecord("TalismanLevelSetting", L2_207).factor
end
function class.HadPutoffAllFabao(A0_208, A1_209)
  A0_208:FireEvent(EVT.HAD_SELECT_PUT_ON_FABAO, A1_209)
end
function class.HanSelectSwallFabao(A0_210, A1_211)
  A0_210:FireEvent(EVT.HAN_SELECT_SWALL_FABAO, A1_211)
end
function class.GetSelectFabao(A0_212)
  local L1_213
  L1_213 = A0_212.selectfabaoids
  return L1_213
end
function class.ClearSelectFabao(A0_214)
  A0_214.selectfabaoids = {}
end
function class.SetSelectHero(A0_215, A1_216)
  if A1_216 then
    A0_215.selecthero = A1_216
  end
end
function class.GetSelectHero(A0_217)
  local L1_218
  L1_218 = A0_217.selecthero
  return L1_218
end
function class.ClearSelectHero(A0_219)
  local L1_220
  A0_219.selecthero = nil
end
function class.ChangeImgFabao(A0_221, A1_222)
  A0_221.selectimggreen = A1_222
  A0_221:FireEvent(EVT.CHANGE_IMG_FABAO)
end
function class.GetSelectImgGreen(A0_223)
  local L1_224
  L1_224 = A0_223.selectimggreen
  return L1_224
end
function class.GetFragment(A0_225)
  return A0_225.fragment or 0
end
function class.AddFragment(A0_226, A1_227)
  A0_226.fragment = (A0_226.fragment or 0) + (A1_227 or 0)
  A0_226:FireEvent(EVT.GET_FRAGMENT_EVT)
end
function class.GetLeiBi(A0_228)
  return A0_228.liebi or 0
end
function class.AddOneFabao(A0_229, A1_230)
  local L2_231, L3_232, L4_233, L5_234, L6_235
  for L5_234, L6_235 in L2_231(L3_232) do
    A0_229:UpDataTailsmans(L6_235)
  end
end
function class.GetAllfabaos(A0_236)
  local L1_237
  L1_237 = A0_236.TalismanVos
  return L1_237
end
function class.GetTheHeroFabaonum(A0_238, A1_239)
  local L2_240
  L2_240 = 0
  if A0_238.allherotalismanVos == nil then
    return L2_240
  end
  for _FORV_6_, _FORV_7_ in pairs(A0_238.allherotalismanVos) do
    if A1_239 == _FORV_7_.id then
      L2_240 = #_FORV_7_.talismanVos
    end
  end
  return L2_240
end
function class.GetTheFabao(A0_241, A1_242)
  if not A1_242 then
    return
  end
  for _FORV_5_, _FORV_6_ in pairs(A0_241.allfabaos) do
    if A1_242 == _FORV_6_.id then
      return _FORV_6_
    end
  end
end
function class.getOneFabaoSwallExp(A0_243, A1_244)
  local L2_245, L3_246
  if A1_244 then
    L2_245 = table
    L2_245 = L2_245.empty
    L3_246 = A1_244
    L2_245 = L2_245(L3_246)
  elseif L2_245 then
    L2_245 = 0
    return L2_245
  end
  L2_245 = A1_244.exp
  L2_245 = L2_245 or 0
  L3_246 = A1_244.level
  if L3_246 then
    L3_246 = tostring
    L3_246 = L3_246(A1_244.baseId)
    L3_246 = L3_246 .. "_" .. tostring(A1_244.level)
    if KFDBGetRecord("TalismanLevelSetting", L3_246) and KFDBGetRecord("TalismanLevelSetting", L3_246).accumulateExp then
      L2_245 = (L2_245 + KFDBGetRecord("TalismanLevelSetting", L3_246).accumulateExp) * KFDBGetRecord("TalismanLevelSetting", L3_246).factor
    end
  end
  return L2_245
end
function class.getAutoSwallFabaos(A0_247)
  local L1_248, L2_249, L3_250, L4_251, L5_252, L6_253, L7_254, L8_255
  L2_249 = A0_247
  L1_248 = A0_247.canSwallFabao
  L1_248 = L1_248(L2_249)
  if L1_248 then
    L2_249 = table
    L2_249 = L2_249.empty
    L2_249 = L2_249(L3_250)
  elseif L2_249 then
    L2_249 = {}
    return L2_249
  end
  L2_249 = {}
  for L6_253, L7_254 in L3_250(L4_251) do
    L8_255 = tostring
    L8_255 = L8_255(L7_254.baseId)
    L8_255 = L8_255 .. "_" .. tostring(L7_254.level)
    if KFDBGetRecord("TalismanLevelSetting", L8_255) and KFDBGetRecord("TalismanLevelSetting", L8_255).funcFlag % 2 == 1 then
      L2_249[#L2_249 + 1] = L7_254
    end
  end
  L3_250(L4_251, L5_252)
  return L2_249
end
function class.SortFabaosByChoice(A0_256, A1_257)
  if not A1_257 then
    return
  end
  table.sort(A1_257, function(A0_258, A1_259)
    if not KFDBGetRecord("TalismanSetting", A0_258.baseId) or not KFDBGetRecord("TalismanSetting", A1_259.baseId) or not Logic:Get("Hero"):GetHeroInfoByBaseId(KFDBGetRecord("TalismanSetting", A0_258.baseId).baseId) or not Logic:Get("Hero"):GetHeroInfoByBaseId(KFDBGetRecord("TalismanSetting", A1_259.baseId).baseId) then
      return false
    end
    if KFDBGetRecord("TalismanSetting", A0_258.baseId).race ~= KFDBGetRecord("TalismanSetting", A1_259.baseId).race and (KFDBGetRecord("TalismanSetting", A0_258.baseId).race == "EXP_1" or KFDBGetRecord("TalismanSetting", A1_259.baseId).race == "EXP_1") then
      return KFDBGetRecord("TalismanSetting", A0_258.baseId).race == "EXP_1" and KFDBGetRecord("TalismanSetting", A1_259.baseId).race ~= "EXP_1"
    elseif Logic:Get("Hero"):GetHeroInfoByBaseId(KFDBGetRecord("TalismanSetting", A0_258.baseId).baseId).star == Logic:Get("Hero"):GetHeroInfoByBaseId(KFDBGetRecord("TalismanSetting", A1_259.baseId).baseId).star then
      if A0_258.level == A1_259.level then
        return A0_258.baseId > A1_259.baseId
      else
        return A0_258.level > A1_259.level
      end
    else
      return Logic:Get("Hero"):GetHeroInfoByBaseId(KFDBGetRecord("TalismanSetting", A0_258.baseId).baseId).star < Logic:Get("Hero"):GetHeroInfoByBaseId(KFDBGetRecord("TalismanSetting", A1_259.baseId).baseId).star
    end
  end)
end
function class.OnReplaceHeroTalismans(A0_260, A1_261, A2_262)
  for _FORV_7_, _FORV_8_ in pairs(A0_260.TalismanVos) do
    if _FORV_8_.equipHero == Logic:Get("Talisman"):GetSelectHero().id and A0_260.position == KFDBGetRecord("TalismanSetting", _FORV_8_.baseId).position then
      _FORV_8_.equipHero = nil
    end
  end
  for _FORV_7_, _FORV_8_ in pairs(A2_262) do
    A0_260.tails_Key_ids[_FORV_8_].equipHero = Logic:Get("Talisman"):GetSelectHero().id
  end
  A0_260:FireEvent(EVT.CHANGE_IMG_FABAO)
end
function class.GetTailsmans_KeyIds(A0_263)
  if A0_263.TalismanVos == nil then
    return
  end
  A0_263.tails_Key_ids = {}
  for _FORV_4_, _FORV_5_ in pairs(A0_263.TalismanVos) do
    if _FORV_5_.equipHero ~= nil and Logic:Get("Hero"):GetHeroInfoById(_FORV_5_.equipHero) == nil then
      _FORV_5_.equipHero = nil
    end
    A0_263.tails_Key_ids[_FORV_5_.id] = _FORV_5_
  end
  return A0_263.tails_Key_ids
end
function class.GetTailsmansByIds(A0_264, A1_265)
  if A1_265 == nil then
    return
  end
  return A0_264.tails_Key_ids[A1_265]
end
function class.UpDataTailsmans(A0_266, A1_267)
  local L2_268
  L2_268 = A0_266.tails_Key_ids
  L2_268[A1_267.id] = A1_267
  L2_268 = true
  for _FORV_6_ = 1, #A0_266.TalismanVos do
    if A0_266.TalismanVos[_FORV_6_].id == A1_267.id then
      A0_266.TalismanVos[_FORV_6_] = A1_267
      L2_268 = false
      return
    end
  end
  if L2_268 == true then
    table.insert(A0_266.TalismanVos, A1_267)
  end
end
function class.UpDataTailsmans_Dele(A0_269, A1_270)
  local L2_271, L3_272, L4_273, L5_274
  L2_271[A1_270] = nil
  for L5_274 = 1, #L3_272 do
    if A0_269.TalismanVos[L5_274].id == A1_270 then
      table.remove(A0_269.TalismanVos, L5_274)
      return
    end
  end
end
function class.IsEuqipMutual(A0_275, A1_276)
  local L2_277, L3_278, L4_279, L5_280, L6_281, L7_282, L8_283
  L2_277 = KFDBGetRecord
  L3_278 = "TalismanSetting"
  L2_277 = L2_277(L3_278, L4_279)
  L3_278 = A0_275.GetEquipTail_IDS
  L3_278 = L3_278(L4_279)
  for L7_282, L8_283 in L4_279(L5_280) do
    for _FORV_15_ = 1, #json.decode(KFDBGetRecord("TalismanSetting", A0_275:GetTailsmansByIds(L8_283).baseId).mutualRaces) do
      if L2_277.race == json.decode(KFDBGetRecord("TalismanSetting", A0_275:GetTailsmansByIds(L8_283).baseId).mutualRaces)[_FORV_15_] and A1_276.id ~= L8_283 then
        return true
      end
    end
  end
end
function class.GetTailsmanVoByHero(A0_284, A1_285)
  local L2_286, L3_287, L4_288, L5_289, L6_290, L7_291, L8_292, L9_293, L10_294
  L2_286 = A0_284.allfabaos
  if L2_286 == nil then
    L2_286 = {}
    return L2_286
  end
  L2_286 = Logic
  L3_287 = L2_286
  L2_286 = L2_286.Get
  L4_288 = "Talisman"
  L2_286 = L2_286(L3_287, L4_288)
  L3_287 = L2_286
  L2_286 = L2_286.GetSelectHero
  L2_286 = L2_286(L3_287)
  L3_287 = KFDBGetRecord
  L4_288 = "BaseHero"
  L5_289 = L2_286.baseId
  L3_287 = L3_287(L4_288, L5_289)
  L5_289 = A0_284
  L4_288 = A0_284.GetHeroEquipTailsmanByHeroId
  L4_288 = L4_288(L5_289, L6_290)
  if L3_287 == nil then
    return
  end
  L5_289 = {}
  A0_284.talisman_Ids = L5_289
  L5_289 = {}
  for L9_293, L10_294 in L6_290(L7_291) do
    L10_294.pfs = false
    L10_294.hasEquip = false
    L10_294.canStar = false
    L10_294.isMutual = false
    L10_294.canEquip = false
    for _FORV_16_ = 1, #json.decode(KFDBGetRecord("TalismanSetting", L10_294.baseId).equipTypes) do
      if json.decode(KFDBGetRecord("TalismanSetting", L10_294.baseId).equipTypes)[_FORV_16_] == L3_287.type then
        L10_294.pfs = true
      end
    end
    if L10_294.equipHero == L2_286.id then
      L10_294.pfs = true
      L10_294.hasEquip = true
      A0_284.talisman_Ids[L10_294.id] = L10_294.id
    end
    if tonumber(KFDBGetRecord("TalismanSetting", L10_294.baseId).id or L10_294.baseId) and tonumber(KFDBGetRecord("TalismanSetting", L10_294.baseId).id or L10_294.baseId) >= 701 and tonumber(KFDBGetRecord("TalismanSetting", L10_294.baseId).id or L10_294.baseId) <= 716 then
      L10_294.canStar = (tonumber(L3_287.rank) or 0) >= 7
    elseif L3_287.star >= KFDBGetRecord("TalismanSetting", L10_294.baseId).minStarLevel and L3_287.star <= KFDBGetRecord("TalismanSetting", L10_294.baseId).maxStarLevel then
      L10_294.canStar = true
    end
    if L10_294.pfs and L10_294.canStar then
      L10_294.canEquip = true
    end
    if L10_294.pfs and A1_285 == KFDBGetRecord("TalismanSetting", L10_294.baseId).position then
      table.insert(L5_289, L10_294)
    end
  end
  L6_290(L7_291, L8_292)
  return L5_289
end
function class.GetCanSaleTailsman(A0_295)
  local L1_296, L2_297, L3_298, L4_299, L5_300, L6_301
  L1_296 = {}
  for L5_300, L6_301 in L2_297(L3_298) do
    if L6_301.equipHero == nil then
      table.insert(L1_296, L6_301)
    end
  end
  L2_297(L3_298, L4_299)
  return L1_296
end
function class.getAlltailsmanByCheck(A0_302)
  if A0_302.TalismanVos == nil then
    return {}
  end
  table.sort(A0_302.TalismanVos, function(A0_303, A1_304)
    A0_303.sort = string.find(KFDBGetRecord("TalismanSetting", A0_303.baseId).race, "EXP") and 9 or 1
    A1_304.sort = string.find(KFDBGetRecord("TalismanSetting", A1_304.baseId).race, "EXP") and 9 or 1
    A0_303.sort = KFDBGetRecord("TalismanSetting", A0_303.baseId).type == "FRAGMENT" and 8 or 1
    A1_304.sort = KFDBGetRecord("TalismanSetting", A1_304.baseId).type == "FRAGMENT" and 8 or 1
    if Logic:Get("Hero"):GetHeroInfoByBaseId(KFDBGetRecord("TalismanSetting", A0_303.baseId).baseId) == nil or Logic:Get("Hero"):GetHeroInfoByBaseId(KFDBGetRecord("TalismanSetting", A1_304.baseId).baseId) == nil then
      return false
    end
    if A0_303.sort == A1_304.sort then
      if Logic:Get("Hero"):GetHeroInfoByBaseId(KFDBGetRecord("TalismanSetting", A0_303.baseId).baseId).rank == Logic:Get("Hero"):GetHeroInfoByBaseId(KFDBGetRecord("TalismanSetting", A1_304.baseId).baseId).rank then
        if A0_303.level == A1_304.level then
          return A0_303.baseId > A1_304.baseId
        else
          return A0_303.level > A1_304.level
        end
      else
        return Logic:Get("Hero"):GetHeroInfoByBaseId(KFDBGetRecord("TalismanSetting", A0_303.baseId).baseId).rank > Logic:Get("Hero"):GetHeroInfoByBaseId(KFDBGetRecord("TalismanSetting", A1_304.baseId).baseId).rank
      end
    else
      return A0_303.sort < A1_304.sort
    end
  end)
  return A0_302.TalismanVos
end
function class.GetHeroEquipTailsmanByHeroId(A0_305, A1_306)
  local L2_307, L3_308, L4_309, L5_310, L6_311, L7_312
  L2_307 = A0_305.TalismanVos
  if L2_307 == nil or A1_306 == nil then
    return
  end
  L2_307 = {}
  for L6_311, L7_312 in L3_308(L4_309) do
    if L7_312.equipHero ~= nil and L7_312.equipHero == A1_306 then
      table.insert(L2_307, L7_312)
    end
  end
  return L2_307
end
function class.GetTaIlsmanAlert(A0_313, A1_314)
  if KFDBGetRecord("TalismanLevelSetting", A1_314) == nil then
    return 0
  end
  return (json.decode(KFDBGetRecord("TalismanLevelSetting", A1_314).alters))
end
function class.GetTaIlsmanAttack(A0_315, A1_316)
  if KFDBGetRecord("TalismanLevelSetting", A1_316) == nil then
    return 0
  end
  return json.decode(KFDBGetRecord("TalismanLevelSetting", A1_316).alters).ATTACK
end
function class.GetTaIlsmanLife(A0_317, A1_318)
  if KFDBGetRecord("TalismanLevelSetting", A1_318) == nil then
    return 0
  end
  return json.decode(KFDBGetRecord("TalismanLevelSetting", A1_318).alters).LIFE
end
function class.GetTalismanPrice(A0_319, A1_320)
  if KFDBGetRecord("TalismanLevelSetting", A1_320) == nil then
    return 0
  end
  return KFDBGetRecord("TalismanLevelSetting", A1_320).price
end
function class.AddEquipTail_IDS(A0_321, A1_322)
  A0_321.talisman_Ids[A1_322] = A1_322
end
function class.DeleEquipTail_IDS(A0_323, A1_324)
  A0_323.talisman_Ids[A1_324] = nil
end
function class.GetEquipTail_IDS(A0_325)
  return A0_325.talisman_Ids or {}
end
function class.FireEvent_RefeshInfo(A0_326)
  A0_326:FireEvent(EVT.SELEL_EQUIP_FABAO)
end
function class.setOpenStyle(A0_327, A1_328)
  A0_327.openStyle = A1_328
end
function class.getOpenStyle(A0_329)
  local L1_330
  L1_330 = A0_329.openStyle
  return L1_330
end
function class.getCanUpgradeFabao(A0_331)
  local L1_332, L2_333, L3_334, L4_335, L5_336
  A0_331.canUpgradeFabao = L1_332
  for L4_335, L5_336 in L1_332(L2_333) do
    if KFDBGetRecord("TalismanSetting", L5_336.baseId).maxLevel > KFDBGetRecord("TalismanSetting", L5_336.baseId).initLevel then
      table.insert(A0_331.canUpgradeFabao, L5_336)
    end
  end
  L1_332(L2_333, L3_334)
  return L1_332
end
function class.canSwallFabao(A0_337)
  local L1_338, L2_339, L3_340, L4_341, L5_342, L6_343
  L1_338 = {}
  if L2_339 then
    if L2_339 then
      for L5_342, L6_343 in L2_339(L3_340) do
        if A0_337.upgradeFabao.id ~= L6_343.id and L6_343.equipHero == nil then
          table.insert(L1_338, L6_343)
        end
      end
    end
  end
  L2_339(L3_340, L4_341)
  return L1_338
end
function class.SetBeforeUpdate(A0_344, A1_345)
  A0_344.beforeUpdate = A1_345
end
function class.GetBeforeUpdate(A0_346)
  local L1_347
  L1_347 = A0_346.beforeUpdate
  return L1_347
end
function class.GetNextExpByIdAndlevel(A0_348, A1_349, A2_350)
  local L3_351
  if A1_349 == nil or A2_350 == nil then
    L3_351 = 0
    return L3_351
  end
  L3_351 = A1_349
  L3_351 = L3_351 .. "_" .. A2_350
  if table.empty(KFDBGetRecord("TalismanLevelSetting", L3_351) or {}) then
    return 0
  end
  return KFDBGetRecord("TalismanLevelSetting", L3_351).exp
end
function class.GetLifeAndAttack(A0_352, A1_353, A2_354)
  local L3_355
  if A1_353 == nil or A2_354 == nil then
    L3_355 = 0
    return L3_355, 0
  end
  L3_355 = A1_353
  L3_355 = L3_355 .. "_" .. A2_354
  if not KFDBGetRecord("TalismanLevelSetting", L3_355) or not KFDBGetRecord("TalismanLevelSetting", L3_355).alters or "" == KFDBGetRecord("TalismanLevelSetting", L3_355).alters then
    return 0, 0
  end
  return (json.decode(KFDBGetRecord("TalismanLevelSetting", L3_355).alters or "[]") or {}).LIFE or 0, (json.decode(KFDBGetRecord("TalismanLevelSetting", L3_355).alters or "[]") or {}).ATTACK or 0
end
function class.GetInfoByBaseId(A0_356, A1_357)
  return (KFDBGetRecord("TalismanSetting", A1_357))
end
function class.InitTalismanSize(A0_358, A1_359)
  local L2_360
  L2_360 = KFDBGetRecord
  L2_360 = L2_360("ConfigValue", "TALISMAN:PACK_CAPACITY")
  L2_360 = KFDBGetRecord("ConfigValue", "TALISMAN:BUY_PACK_CAPACITY_VALUE")
  A0_358.packSize = tonumber(L2_360.content) + A1_359 * tonumber(L2_360.content)
  A0_358.buyTalismanPack = A1_359 or 0
end
function class.GetTalismanSize(A0_361)
  local L1_362
  L1_362 = A0_361.packSize
  return L1_362
end
function class.GetBuyPackTimes(A0_363)
  local L1_364
  L1_364 = A0_363.buyTalismanPack
  return L1_364
end
function class.GetBuyPackCost(A0_365)
  local L1_366, L2_367
  L1_366 = KFDBGetRecord
  L2_367 = "BuyPackCostSetting"
  L1_366 = L1_366(L2_367, A0_365.buyTalismanPack + 1)
  if not L1_366 then
    L2_367 = KFDBGetRecordAmt
    L2_367 = L2_367("BuyPackCostSetting")
    return KFDBGetRecordByIdx("BuyPackCostSetting", L2_367).cost or 0
  end
  L2_367 = L1_366.cost
  return L2_367
end
function class.jumpToUpgrade(A0_368)
  SceneHelper:runWithScene("FabaoUpdate", A0_368.rootNode)
  A0_368:FireEvent(EVT.OPT_UPGRADE_FABAO)
end
function class.OnBuyTalismanPackSpaceByCoupon(A0_369, A1_370, A2_371)
  if A1_370 == 0 then
    A0_369:OnBuyTalismanPackSpace(A1_370, A2_371)
  end
end
function class.setTalismanPosition(A0_372, A1_373)
  A0_372.position = A1_373 or 1
end
function class.getTalismanPosition(A0_374)
  local L1_375
  L1_375 = A0_374.position
  return L1_375
end
