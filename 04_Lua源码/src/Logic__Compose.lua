local L0_0
L0_0 = module
L0_0((...), package.seeall)
L0_0 = require
L0_0("MsgItem")
L0_0 = require
L0_0("SceneHelper")
L0_0 = require
L0_0("Logic")
L0_0 = Enum
L0_0 = L0_0({
  "REFRESH_ITEM",
  "NEW_COMPOSE",
  "REFRESH_CONFIG",
  "REFRESH_SELL_ITEMS",
  "SELECT_CARD",
  "SWAP",
  "SPLIT"
})
EVT = L0_0
L0_0 = Enum
L0_0 = L0_0({"BIG", "MIDDLE"})
ITEMIMG_SIZE = L0_0
L0_0 = TypeDef
L0_0 = L0_0("com.eyu.mt.module.fight.model.UnitRace")
UNITRACE = L0_0
L0_0 = Enum
L0_0 = L0_0(TypeDef("com.eyu.mt.module.item.facade.ItemResult"))
COST_TYPE = TypeDef("com.eyu.mt.module.item.model.ItemType")
TYPE_INFO_TYPE = TypeDef("com.eyu.mt.module.item.model.reward.ItemInfoType")
MAX_LIST = 20
class = Logic.class:subclass()
function class.initialize(A0_1)
  super.initialize(A0_1)
  A0_1.arrItemIndexOfId = {}
  A0_1.arrItem = {}
  A0_1.costAndReward = {}
  A0_1.casualGoods = {}
  A0_1.selllCosAndRew = {}
  A0_1.arrItemId = {}
  A0_1.saleCompsoeList = {}
  A0_1.hasComposeB = false
  Logic:Get("MsgAssist"):RecordErrorMsg("MsgItem", _UPVALUE0_, _UPVALUE1_)
  MsgItem:On("GET_ITEMS", A0_1:Event("OnGetItems"), true)
  MsgItem:On("COMPOSE_ITEM", A0_1:Event("OnComPoseItem"), true)
  MsgItem:On("SELL_ITEM", A0_1:Event("OnSellItem"), true)
  MsgItem:On("SELL_ITEMS", A0_1:Event("OnSellItems"), true)
  A0_1.selectCard = nil
  A0_1.targetCard = nil
  A0_1.unitRace = UNITRACE.XIAN
  A0_1.splitCard = {}
  A0_1.rewardCards = {}
  MsgItem:On("SWAP", A0_1:Event("OnSwap"))
  MsgHero:On("SPLIT_HERO", A0_1:Event("OnSplitHero"))
end
function class.PostSellItems(A0_2, A1_3)
  MsgItem:Post("SELL_ITEMS", A1_3)
end
function class.OnSellItems(A0_4, A1_5, A2_6)
  if A1_5 == 0 then
    A0_4:ClearSaleComposeList()
    Logic:Get("Cost"):AddCosts(A2_6.costs)
    Logic:Get("Reward"):AddRewards(A2_6.rewards)
    A0_4:FireEvent(EVT.REFRESH_SELL_ITEMS)
  end
end
function class.PostSellItem(A0_7, A1_8, A2_9)
  MsgItem:Post("SELL_ITEM", {amount = A1_8, itemId = A2_9})
end
function class.OnSellItem(A0_10, A1_11, A2_12)
  if A1_11 == 0 then
    A0_10.selllCosAndRew = A2_12
    Logic:Get("Cost"):AddCosts(A2_12.costs)
    Logic:Get("Reward"):AddRewards(A2_12.rewards)
  end
  A0_10:FireEvent(EVT.REFRESH_ITEM)
end
function class.PostGetItems(A0_13)
  MsgItem:Post("GET_ITEMS", {})
end
function class.OnGetItems(A0_14, A1_15, A2_16)
  if A1_15 == 0 then
    A0_14:ConversionIndex(A2_16)
    A0_14:IsHasCompose()
    A0_14:FireEvent(EVT.REFRESH_ITEM)
  end
end
function class.GetArrItem(A0_17)
  local L1_18
end
function class.ConversionIndex(A0_19, A1_20)
  A0_19.arrItemIndexOfId = {}
  for _FORV_5_, _FORV_6_ in ipairs(A1_20) do
    A0_19.arrItemIndexOfId[_FORV_6_.id] = A1_20[_FORV_5_]
  end
end
function class.GetArrItemIndexOfId(A0_21)
  local L1_22
  L1_22 = A0_21.arrItemIndexOfId
  return L1_22
end
function class.GetArrItemOfId(A0_23)
  local L1_24
  L1_24 = A0_23.arrItemId
  return L1_24
end
function class.GetSaleArrItemOfId(A0_25)
  local L1_26, L2_27, L4_28, L5_29
  L1_26 = {}
  for _FORV_5_ = 1, #L4_28 do
    if A0_25.arrItemId[_FORV_5_] ~= nil and A0_25.arrItemIndexOfId[A0_25.arrItemId[_FORV_5_]] ~= nil and A0_25:kdbItemConfig(A0_25.arrItemIndexOfId[A0_25.arrItemId[_FORV_5_]].baseId) and A0_25:kdbItemConfig(A0_25.arrItemIndexOfId[A0_25.arrItemId[_FORV_5_]].baseId).sell ~= nil and tonumber(A0_25:kdbItemConfig(A0_25.arrItemIndexOfId[A0_25.arrItemId[_FORV_5_]].baseId).sell) == 1 then
      table.insert(L1_26, A0_25.arrItemId[_FORV_5_])
    end
  end
  return L1_26
end
function class.GetGoodsByType(A0_30, A1_31)
  A0_30.casualGoods = {}
  A0_30.arrItemId = {}
  if A1_31 == "ITEM" then
    A0_30:SetItem()
  elseif A1_31 == "EQUIP" then
    A0_30:SetEquip()
  elseif A1_31 == "FRAGMENT" then
    A0_30:SetFragment()
  end
end
function class.SetItem(A0_32)
  local L1_33, L2_34, L3_35, L4_36
  for L4_36, _FORV_5_ in L1_33(L2_34) do
    if _FORV_5_.type == COST_TYPE.ITEM then
      A0_32.casualGoods[L4_36] = _FORV_5_
      table.insert(A0_32.arrItemId, L4_36)
    end
  end
end
function class.SetEquip(A0_37)
  local L1_38, L2_39, L3_40, L4_41
  for L4_41, _FORV_5_ in L1_38(L2_39) do
    if _FORV_5_.type == COST_TYPE.EQUIP then
      A0_37.casualGoods[L4_41] = _FORV_5_
      table.insert(A0_37.arrItemId, L4_41)
    end
  end
end
function class.SetFragment(A0_42)
  local L1_43, L2_44, L3_45, L4_46, L5_47, L6_48, L7_49, L8_50
  for L4_46, L5_47 in L1_43(L2_44) do
    if L6_48 == L7_49 then
      L6_48[L4_46] = L5_47
      L8_50 = L4_46
      L6_48(L7_49, L8_50)
    end
  end
  if L2_44 then
  end
  for L5_47, L6_48 in L2_44(L3_45) do
    L8_50 = COST_TYPE
    L8_50 = L8_50.FRAGMENT
    if L7_49 == L8_50 then
      if L7_49 == nil then
        L8_50 = L7_49
        L8_50 = L7_49
        if L7_49 == nil then
          L8_50 = L6_48.baseId
          if L8_50 ~= nil then
            L8_50 = log4misc
            L8_50 = L8_50.warn
            L8_50(L8_50, "Compose:" .. L6_48.baseId)
          else
            L8_50 = log4misc
            L8_50 = L8_50.warn
            L8_50(L8_50, "Compose:v.baseId is nil")
          end
          return
        end
        L8_50 = string
        L8_50 = L8_50.lower
        L8_50 = L8_50("FRAGMENT")
        L8_50 = L1_43[L8_50]
        if L8_50 >= tonumber(L7_49.extendMax) then
          L8_50 = tonumber
          L8_50 = L8_50(L7_49.extendMax)
        elseif not L8_50 then
          L8_50 = string
          L8_50 = L8_50.lower
          L8_50 = L8_50("FRAGMENT")
          L8_50 = L1_43[L8_50]
        end
        L6_48.canCom = L6_48.amount + L8_50 >= tonumber(L7_49.amount) and 0 or 1
      end
    end
  end
  if L3_45 then
    for L8_50 = 1, L4_46 do
      if KFDBGetRecordByIdx("RedCardComposeConfig", L8_50) and tonumber(L2_44) >= tonumber(KFDBGetRecordByIdx("RedCardComposeConfig", L8_50).level) then
        KFDBGetRecordByIdx("RedCardComposeConfig", L8_50).redId = "red" .. KFDBGetRecordByIdx("RedCardComposeConfig", L8_50).id
        KFDBGetRecordByIdx("RedCardComposeConfig", L8_50).canCom = L1_43[string.lower("FRAGMENT")] >= tonumber(KFDBGetRecordByIdx("RedCardComposeConfig", L8_50).fragment) and 0 or 1
        A0_42.arrItemIndexOfId[KFDBGetRecordByIdx("RedCardComposeConfig", L8_50).redId] = KFDBGetRecordByIdx("RedCardComposeConfig", L8_50)
        A0_42.casualGoods[KFDBGetRecordByIdx("RedCardComposeConfig", L8_50).redId] = KFDBGetRecordByIdx("RedCardComposeConfig", L8_50)
        table.insert(A0_42.arrItemId, KFDBGetRecordByIdx("RedCardComposeConfig", L8_50).redId)
      end
    end
  end
  if not L4_46 then
    L4_46(L5_47, L6_48)
  end
end
function class.IsVisibleRedCard(A0_51)
  local L1_52
  L1_52 = A0_51.Redbool
  return L1_52
end
function class.SetRedVisible(A0_53, A1_54)
  if A1_54 ~= nil then
    A0_53.Redbool = A1_54
  else
    A0_53.Redbool = not Logic:Get("Lock"):GetStatusByLockId(Logic.Lock.LOCK_ID.RED_CARD_COMPOSE)
  end
end
function class.GetGoodsByIdx(A0_55, A1_56)
  return A0_55.casualGoods[A1_56]
end
function class.GetCasualGoodsAmount(A0_57)
  return #A0_57.casualGoods
end
function class.GetCasualGoods(A0_58)
  local L1_59
  L1_59 = A0_58.casualGoods
  return L1_59
end
function class.PostComPoseItem(A0_60, A1_61)
  MsgItem:Post("COMPOSE_ITEM", {
    extend = A0_60.extend,
    itemId = A1_61
  })
end
function class.OnComPoseItem(A0_62, A1_63, A2_64)
  if A1_63 == 0 then
    A0_62.costAndReward = A2_64
    Logic:Get("Cost"):AddCosts(A2_64.costs)
    Logic:Get("Reward"):AddRewards(A2_64.rewards)
    Logic:Get("Facebook"):ShareFriend("Compose", A2_64.rewards)
    Logic:Get("WeChat"):Compose(A2_64.rewards)
    A0_62:FireEvent(EVT.REFRESH_ITEM)
  end
end
function class.SetEtend(A0_65, A1_66)
  A0_65.extend = A1_66
end
function class.GetEtend(A0_67)
  local L1_68
  L1_68 = A0_67.extend
  return L1_68
end
function class.UpdataItem(A0_69, A1_70)
  A0_69:UpdataItemCosAndRew(A1_70)
  A0_69:IsHasCompose()
  A0_69:FireEvent(EVT.NEW_COMPOSE)
end
function class.UpdataItemCosAndRew(A0_71, A1_72)
  local L2_73, L4_74, L5_75, L6_76, L7_77, L8_78, L9_79
  if A1_72 == nil then
    return
  end
  for L6_76 = 1, #L4_74 do
    L7_77 = A1_72.contents
    L7_77 = L7_77[L6_76]
    L7_77 = L7_77.type
    L8_78 = TYPE_INFO_TYPE
    L8_78 = L8_78.ADD
    if L7_77 == L8_78 then
      L7_77 = A0_71.arrItemIndexOfId
      L8_78 = A1_72.contents
      L8_78 = L8_78[L6_76]
      L8_78 = L8_78.id
      L9_79 = {}
      L9_79.type = A1_72.contents[L6_76].itemType
      L9_79.amount = A1_72.contents[L6_76].amount
      L9_79.id = A1_72.contents[L6_76].id
      L9_79.baseId = A1_72.contents[L6_76].baseId
      L7_77[L8_78] = L9_79
    else
      L7_77 = A1_72.contents
      L7_77 = L7_77[L6_76]
      L7_77 = L7_77.type
      L8_78 = TYPE_INFO_TYPE
      L8_78 = L8_78.ALTER
      if L7_77 == L8_78 then
        L7_77 = A0_71.arrItemIndexOfId
        L8_78 = A1_72.contents
        L8_78 = L8_78[L6_76]
        L8_78 = L8_78.id
        L7_77 = L7_77[L8_78]
        if L7_77 == nil then
          break
        end
        L7_77 = A0_71.arrItemIndexOfId
        L8_78 = A1_72.contents
        L8_78 = L8_78[L6_76]
        L8_78 = L8_78.id
        L7_77 = L7_77[L8_78]
        L8_78 = A0_71.arrItemIndexOfId
        L9_79 = A1_72.contents
        L9_79 = L9_79[L6_76]
        L9_79 = L9_79.id
        L8_78 = L8_78[L9_79]
        L8_78 = L8_78.amount
        L9_79 = A1_72.amount
        L8_78 = L8_78 + L9_79
        L7_77.amount = L8_78
      else
        L7_77 = A1_72.contents
        L7_77 = L7_77[L6_76]
        L7_77 = L7_77.type
        L8_78 = TYPE_INFO_TYPE
        L8_78 = L8_78.REMOVE
        if L7_77 == L8_78 then
          L7_77 = A0_71.arrItemIndexOfId
          L8_78 = A1_72.contents
          L8_78 = L8_78[L6_76]
          L8_78 = L8_78.id
          L7_77[L8_78] = nil
        end
      end
    end
  end
end
function class.GetItemsFrame(A0_80, A1_81)
  local L2_82, L3_83
  L2_82 = 7
  if A1_81 == nil or A1_81 > L2_82 then
    L3_83 = string
    L3_83 = L3_83.format
    L3_83 = L3_83("data/MiddleBg/%d.png", L2_82)
    return (CCSprite:create(L3_83))
  end
  L3_83 = string
  L3_83 = L3_83.format
  L3_83 = L3_83("data/MiddleBg/%d.png", A1_81)
  return (CCSprite:create(L3_83))
end
function class.GetFraImg(A0_84, A1_85)
  local L2_86
  L2_86 = A0_84.GetItemImg
  L2_86 = L2_86(A0_84, A1_85)
  return (CCSprite:create(L2_86))
end
function class.GetJigsawImg(A0_87)
  return (CCSprite:create("images/HeroCardInfo/composeItem.png"))
end
function class.kdbItemConfig(A0_88, A1_89)
  if A1_89 == nil then
  end
  return (KFDBGetRecord("ItemConfig", A1_89))
end
function class.IsStaminaSaleFragment(A0_90, A1_91)
  return tonumber(A1_91 or 0) == 6593
end
function class.SaleMoneyIconPath(A0_92, A1_93)
  local L2_94
  if A1_93 then
    L2_94 = "images/Other/actionSale.png"
    return L2_94
  end
  L2_94 = "images/public/gold.png"
  return L2_94
end
function class.ApplySaleMoneyIcon(A0_95, A1_96, A2_97)
  if A1_96 == nil then
    return
  end
  if A1_96._saleIconFitW == nil then
    A1_96._saleIconFitW = A1_96:getContentSize().width
    A1_96._saleIconFitH = A1_96:getContentSize().height
    A1_96._saleIconFitSX = A1_96:getScaleX()
    A1_96._saleIconFitSY = A1_96:getScaleY()
  end
  if CCSprite:create(A0_95:SaleMoneyIconPath(A2_97)) == nil then
    return
  end
  A1_96:setDisplayFrame(CCSprite:create(A0_95:SaleMoneyIconPath(A2_97)):displayFrame())
  if A1_96:getContentSize().width > 0 and A1_96:getContentSize().height > 0 and A1_96._saleIconFitW > 0 and A1_96._saleIconFitH > 0 then
    A1_96:setScaleX(math.min(A1_96._saleIconFitW / A1_96:getContentSize().width, A1_96._saleIconFitH / A1_96:getContentSize().height) * A1_96._saleIconFitSX)
    A1_96:setScaleY(math.min(A1_96._saleIconFitW / A1_96:getContentSize().width, A1_96._saleIconFitH / A1_96:getContentSize().height) * A1_96._saleIconFitSY)
  end
end
function class.SaleCurrencyTotals(A0_98, A1_99, A2_100)
  local L3_101, L4_102, L5_103
  L3_101 = 0
  L4_102 = 0
  L5_103 = 0
  for _FORV_9_, _FORV_10_ in pairs(A1_99 or {}) do
    if A2_100 and A2_100[_FORV_9_] ~= nil and A0_98:kdbItemConfig(A2_100[_FORV_9_].baseId) ~= nil then
      if A0_98:IsStaminaSaleFragment(A2_100[_FORV_9_].baseId or A0_98:kdbItemConfig(A2_100[_FORV_9_].baseId).baseId) then
        L4_102 = L4_102 + tonumber(A0_98:kdbItemConfig(A2_100[_FORV_9_].baseId).sellPrice or 0) * (A2_100[_FORV_9_].amount or 0)
      else
        L3_101 = L3_101 + tonumber(A0_98:kdbItemConfig(A2_100[_FORV_9_].baseId).sellPrice or 0) * (A2_100[_FORV_9_].amount or 0)
      end
      L5_103 = L5_103 + 1
    end
  end
  return L3_101, L4_102, L5_103
end
function class.FormatSaleTotal(A0_104, A1_105, A2_106)
  if A2_106 > 0 and A1_105 > 0 then
    return tostring(A1_105) .. "\233\147\156\229\184\129+" .. tostring(A2_106) .. "\228\189\147\229\138\155"
  elseif A2_106 > 0 then
    return tostring(A2_106) .. "\228\189\147\229\138\155"
  end
  return tostring(A1_105)
end
function class.kdbComposeConfig(A0_107, A1_108)
  if A1_108 == nil then
    return
  end
  if KFDBGetRecord("ComposeConfig", A1_108) == nil then
    if A1_108 ~= nil then
      log4misc:warn("compose,func:kdbComposeConfig:baseId" .. A1_108)
    else
      log4misc:warn("compose,func:kdbComposeConfig:baseId is nil")
    end
  end
  return (KFDBGetRecord("ComposeConfig", A1_108))
end
function class.createProgress(A0_109, A1_110)
  local L2_111
  L2_111 = ""
  if A1_110 then
    L2_111 = "images/HeroCardInfo/fin_compose.png"
  else
    L2_111 = "images/HeroCardInfo/can_compose.png"
  end
  CCSprite:create(L2_111):setAnchorPoint(CCPoint(0, 0))
  return (CCSprite:create(L2_111))
end
function class.GetItemImg(A0_112, A1_113, A2_114)
  local L3_115
  L3_115 = A2_114 or L3_115.MIDDLE
  if not A0_112:kdbItemConfig(A1_113) then
    return "images/HeroCardInfo/composeItem.png"
  end
  if L3_115 == ITEMIMG_SIZE.MIDDLE then
    if A0_112:kdbItemConfig(A1_113).baseId == nil or A0_112:kdbItemConfig(A1_113).baseId == 0 then
      return "images/HeroCardInfo/composeItem.png"
    else
      if Logic:Get("Hero"):GetHeroImage(A0_112:kdbItemConfig(A1_113).baseId) == nil then
        return "images/HeroCardInfo/composeItem.png"
      end
      return (Logic:Get("Hero"):GetHeroImage(A0_112:kdbItemConfig(A1_113).baseId))
    end
  elseif L3_115 == ITEMIMG_SIZE.BIG then
    if A0_112:kdbItemConfig(A1_113).baseId == nil or A0_112:kdbItemConfig(A1_113).baseId == 0 then
      return "images/HeroCardInfo/compose.png"
    else
      if Logic:Get("Hero"):GetHeroImage(A0_112:kdbItemConfig(A1_113).baseId, Logic.Hero.HEROIMG_SIZE.BIG) == nil then
        return "images/HeroCardInfo/compose.png"
      end
      return (Logic:Get("Hero"):GetHeroImage(A0_112:kdbItemConfig(A1_113).baseId, Logic.Hero.HEROIMG_SIZE.BIG))
    end
  end
end
function class.GetStaHero(A0_116, A1_117)
  for _FORV_7_ = 1, #Logic:Get("Hero"):GetAllFightHero() do
    if Logic:Get("Hero"):GetAllFightHero()[_FORV_7_] == A1_117.id then
      return "images/HeroCardInfo/fighting.png", false
    end
  end
  if _FOR_ == Logic:Get("Hero"):GetLeaderId() then
    return "images/HeroCardInfo/fighting.png", false
  end
  if A1_117.locked then
    return "images/HeroCardInfo/protecting.png", false
  else
    return "images/HeroCardInfo/btn_reolve.png", true
  end
end
function class.sortResolveHero(A0_118)
  local L1_119
end
function class.IsHasCompose(A0_120)
  for _FORV_5_, _FORV_6_ in pairs(A0_120.arrItemIndexOfId) do
    if _FORV_6_.type == COST_TYPE.FRAGMENT then
      if Logic:Get("Compose"):kdbComposeConfig(_FORV_6_.baseId) == nil then
        if _FORV_6_.baseId ~= nil then
          log4misc:warn("Compose:" .. _FORV_6_.baseId)
        else
          log4misc:warn("Compose:v.baseId is nil")
        end
        return
      end
      if not (Logic:Get("PlayerInfo"):GetPlayerMoney()[string.lower("FRAGMENT")] >= tonumber(Logic:Get("Compose"):kdbComposeConfig(_FORV_6_.baseId).extendMax)) or not tonumber(Logic:Get("Compose"):kdbComposeConfig(_FORV_6_.baseId).extendMax) then
      end
      _FORV_6_.canCom = _FORV_6_.amount + Logic:Get("PlayerInfo"):GetPlayerMoney()[string.lower("FRAGMENT")] >= tonumber(Logic:Get("Compose"):kdbComposeConfig(_FORV_6_.baseId).amount)
      if _FORV_6_.canCom and not SceneHelper:isExistScene("Compose") then
        A0_120.hasComposeB = true
      end
    end
  end
end
function class.GetHasCompose(A0_121)
  local L1_122
  L1_122 = false
  return L1_122
end
function class.SetHasCompsoeB(A0_123, A1_124)
  A0_123.hasComposeB = A1_124
  A0_123:FireEvent(EVT.NEW_COMPOSE)
end
function class.SetSaleComposeList(A0_125, A1_126, A2_127)
  A0_125.saleCompsoeList[A1_126] = A2_127
end
function class.GetSaleComposeList(A0_128)
  local L1_129
  L1_129 = A0_128.saleCompsoeList
  return L1_129
end
function class.ClearSaleComposeList(A0_130)
  A0_130.saleCompsoeList = {}
end
function class.FireEnvenConfig(A0_131)
  A0_131:FireEvent(EVT.REFRESH_CONFIG)
end
function class.SetSelectCard(A0_132, A1_133)
  A0_132.selectCard = A1_133
end
function class.GetSelectCard(A0_134)
  local L1_135
  L1_135 = A0_134.selectCard
  return L1_135
end
function class.SetTargetCard(A0_136, A1_137)
  A0_136.targetCard = A1_137
end
function class.GetTargetCard(A0_138)
  local L1_139
  L1_139 = A0_138.targetCard
  return L1_139
end
function class.SetUnitRace(A0_140, A1_141)
  A0_140.unitRace = A1_141
end
function class.GetUnitRace(A0_142)
  local L1_143
  L1_143 = A0_142.unitRace
  return L1_143
end
function class.SetSplitCard(A0_144, A1_145)
  A0_144.splitCard = A1_145
end
function class.GetSplitCard(A0_146)
  local L1_147
  L1_147 = A0_146.splitCard
  return L1_147
end
function class.GetRewardCards(A0_148)
  local L1_149
  L1_149 = A0_148.rewardCards
  return L1_149
end
function class.GetTranslateCards(A0_150)
  local L1_151, L2_152, L3_153, L4_154, L5_155, L6_156, L7_157, L8_158, L9_159
  L1_151 = {}
  L3_153 = A0_150
  L2_152 = A0_150.GetSelectCard
  L2_152 = L2_152(L3_153)
  L3_153 = Logic
  L3_153 = L3_153.Get
  L3_153 = L3_153(L4_154, L5_155)
  L3_153 = L3_153.GetUnbattlingHero
  L3_153 = L3_153(L4_154, L5_155, L6_156)
  L5_155 = L3_153 or {}
  for L7_157, L8_158 in L4_154(L5_155) do
    L9_159 = Logic
    L9_159 = L9_159.Get
    L9_159 = L9_159(L9_159, "Hero")
    L9_159 = L9_159.GetHeroInfoById
    L9_159 = L9_159(L9_159, L8_158)
    if not table.empty(L9_159 or {}) and KFDBGetRecord("SwapCardSetting", L9_159.baseId) then
      if L2_152 and L2_152.id == L8_158 then
        L9_159.sort = 1
      else
        L9_159.sort = 2
      end
      if L9_159.locked then
        L9_159.sort = 4
      end
      table.insert(L1_151, L9_159)
    end
  end
  for L8_158 = #L4_154, 1, -1 do
    L9_159 = Logic
    L9_159 = L9_159.Get
    L9_159 = L9_159(L9_159, "Hero")
    L9_159 = L9_159.GetHeroInfoById
    L9_159 = L9_159(L9_159, L4_154[L8_158])
    if not table.empty(L9_159 or {}) and KFDBGetRecord("SwapCardSetting", L9_159.baseId) then
      L9_159.sort = 3
      table.insert(L1_151, 1, L9_159)
    end
  end
  if not L6_156 then
    L8_158 = L5_155
    L6_156(L7_157, L8_158)
  end
  return L1_151
end
function class.GetTargetList(A0_160)
  local L1_161, L2_162, L3_163, L4_164, L5_165, L6_166, L7_167, L8_168, L9_169, L10_170
  L1_161 = {}
  L2_162 = table
  L2_162 = L2_162.empty
  L3_163 = A0_160.selectCard
  L3_163 = L3_163 or {}
  L2_162 = L2_162(L3_163)
  if L2_162 then
    return L1_161
  end
  L2_162 = KFDBGetRecord
  L3_163 = "SwapCardSetting"
  L4_164 = A0_160.selectCard
  L4_164 = L4_164.baseId
  L2_162 = L2_162(L3_163, L4_164)
  if L2_162 == nil then
    return L1_161
  end
  L3_163 = {}
  L4_164 = UNITRACE
  L4_164 = L4_164.XIAN
  L3_163[L4_164] = L5_165
  L4_164 = UNITRACE
  L4_164 = L4_164.YAO
  L3_163[L4_164] = L5_165
  L4_164 = UNITRACE
  L4_164 = L4_164.LING
  L3_163[L4_164] = L5_165
  L4_164 = json
  L4_164 = L4_164.decode
  L4_164 = L4_164(L5_165)
  L6_166 = L4_164 or {}
  for L8_168, L9_169 in L5_165(L6_166) do
    L10_170 = {}
    L10_170.baseId = L9_169
    L10_170.level = A0_160.selectCard.level
    L10_170.powerSkill = A0_160:GetTargetSkillById(A0_160.selectCard.powerSkill, KFDBGetRecord("BaseHero", L10_170.baseId).powerSkill)
    L10_170.id = A0_160.selectCard.id
    L10_170.idx = L8_168
    if A0_160.targetCard and L10_170.baseId == A0_160.targetCard.baseId then
      L10_170.sort = 1
    else
      L10_170.sort = 2
    end
    table.insert(L1_161, L10_170)
  end
  L8_168 = L5_165
  L6_166(L7_167, L8_168)
  return L1_161
end
function class.GetTargetSkillById(A0_171, A1_172, A2_173)
  local L3_174, L4_175, L5_176
  if not A1_172 or not A2_173 then
    return A2_173
  end
  L3_174 = KFDBGetRecord
  L4_175 = "SkillConfig"
  L5_176 = A1_172
  L3_174 = L3_174(L4_175, L5_176)
  L4_175 = KFDBGetRecord
  L5_176 = "SkillConfig"
  L4_175 = L4_175(L5_176, A2_173)
  if not L3_174 or not L4_175 then
    return A2_173
  end
  L5_176 = L3_174.level
  if L5_176 < L4_175.level then
    return A2_173
  end
  L5_176 = L4_175
  while true do
    if L5_176.next == -1 or not (L5_176.level < L3_174.level) or not KFDBGetRecord("SkillConfig", L5_176.next) then
      break
    end
    L5_176 = KFDBGetRecord("SkillConfig", L5_176.next)
  end
  return L5_176.id
end
function class.GetChangeCost(A0_177)
  if not table.empty(A0_177.selectCard or {}) then
  elseif table.empty(A0_177.targetCard or {}) then
    return 0, 0
  end
  if KFDBGetRecord("SwapCardSetting", A0_177.selectCard.baseId) == nil then
    return 0, 0
  end
  return json.decode(({
    [UNITRACE.XIAN] = {
      KFDBGetRecord("SwapCardSetting", A0_177.selectCard.baseId).xianFragments,
      KFDBGetRecord("SwapCardSetting", A0_177.selectCard.baseId).xianCosts
    },
    [UNITRACE.YAO] = {
      KFDBGetRecord("SwapCardSetting", A0_177.selectCard.baseId).yaoFragments,
      KFDBGetRecord("SwapCardSetting", A0_177.selectCard.baseId).yaoCosts
    },
    [UNITRACE.LING] = {
      KFDBGetRecord("SwapCardSetting", A0_177.selectCard.baseId).lingFragments,
      KFDBGetRecord("SwapCardSetting", A0_177.selectCard.baseId).lingCosts
    }
  })[A0_177.unitRace][1] or "[]")[A0_177.targetCard.idx], json.decode(({
    [UNITRACE.XIAN] = {
      KFDBGetRecord("SwapCardSetting", A0_177.selectCard.baseId).xianFragments,
      KFDBGetRecord("SwapCardSetting", A0_177.selectCard.baseId).xianCosts
    },
    [UNITRACE.YAO] = {
      KFDBGetRecord("SwapCardSetting", A0_177.selectCard.baseId).yaoFragments,
      KFDBGetRecord("SwapCardSetting", A0_177.selectCard.baseId).yaoCosts
    },
    [UNITRACE.LING] = {
      KFDBGetRecord("SwapCardSetting", A0_177.selectCard.baseId).lingFragments,
      KFDBGetRecord("SwapCardSetting", A0_177.selectCard.baseId).lingCosts
    }
  })[A0_177.unitRace][2] or "[]")[A0_177.targetCard.idx]
end
function class.GetSplitCards(A0_178)
  local L1_179, L2_180, L3_181, L4_182, L5_183, L6_184, L7_185, L8_186
  L1_179 = {}
  L2_180 = Logic
  L2_180 = L2_180.Get
  L2_180 = L2_180(L3_181, L4_182)
  L2_180 = L2_180.GetUnbattlingHero
  L2_180 = L2_180(L3_181, L4_182, L5_183)
  L4_182 = L2_180 or {}
  for L6_184, L7_185 in L3_181(L4_182) do
    L8_186 = Logic
    L8_186 = L8_186.Get
    L8_186 = L8_186(L8_186, "Hero")
    L8_186 = L8_186.GetHeroInfoById
    L8_186 = L8_186(L8_186, L7_185)
    if not table.empty(L8_186 or {}) and Logic:Get("Hero"):GetHeroInfoByBaseId(L8_186.baseId) and Logic:Get("Hero"):GetHeroInfoByBaseId(L8_186.baseId).splitId ~= "" and Logic:Get("Hero"):GetHeroInfoByBaseId(L8_186.baseId).splitId ~= "{}" then
      if L8_186.locked then
        L8_186.sort = 3
      else
        L8_186.sort = 1
      end
      table.insert(L1_179, L8_186)
    end
  end
  for L7_185 = #L3_181, 1, -1 do
    L8_186 = Logic
    L8_186 = L8_186.Get
    L8_186 = L8_186(L8_186, "Hero")
    L8_186 = L8_186.GetHeroInfoById
    L8_186 = L8_186(L8_186, L3_181[L7_185])
    if not table.empty(L8_186 or {}) and Logic:Get("Hero"):GetHeroInfoByBaseId(L8_186.baseId) and Logic:Get("Hero"):GetHeroInfoByBaseId(L8_186.baseId).splitId ~= "" and Logic:Get("Hero"):GetHeroInfoByBaseId(L8_186.baseId).splitId ~= "{}" then
      L8_186.sort = 2
      table.insert(L1_179, L8_186)
    end
  end
  if not L5_183 then
    L7_185 = L4_182
    L5_183(L6_184, L7_185)
  end
  return L1_179
end
function class.PostSwap(A0_187)
  if not table.empty(A0_187.selectCard or {}) then
  elseif table.empty(A0_187.targetCard or {}) then
    return
  end
  MsgItem:Post("SWAP", {
    cardId = A0_187.selectCard.id,
    desBaseId = A0_187.targetCard.baseId,
    unitRace = A0_187.unitRace
  })
end
function class.PostSplit(A0_188, A1_189)
  if not A1_189 then
    return
  end
  MsgHero:Post("SPLIT_HERO", {tar = A1_189})
end
function class.OnSwap(A0_190, A1_191, A2_192)
  if A1_191 ~= 0 then
    return
  end
  Logic:Get("Cost"):AddCosts(A2_192.costResults)
  Logic:Get("Hero"):AddCard(A2_192.heroVo)
  A0_190:FireEvent(EVT.SWAP)
end
function class.OnSplitHero(A0_193, A1_194, A2_195)
  local L3_196
  if A1_194 ~= 0 then
    return
  end
  L3_196 = Logic
  L3_196 = L3_196.Get
  L3_196 = L3_196(L3_196, "Cost")
  L3_196 = L3_196.CostAndReward
  L3_196(L3_196, A2_195)
  L3_196 = Logic
  L3_196 = L3_196.Get
  L3_196 = L3_196(L3_196, "Lottery")
  L3_196 = L3_196.formatRewardData
  L3_196 = L3_196(L3_196, A2_195.rewards)
  A0_193.rewardCards = L3_196
  L3_196 = A2_195.rewards
  A0_193.rewards = L3_196
  function L3_196(A0_197, A1_198)
    return A0_197.rewardType < A1_198.rewardType
  end
  table.sort(A0_193.rewardCards, L3_196)
  A0_193:FireEvent(EVT.SPLIT)
end
function class.PromptRewards(A0_199)
  local L1_200
  L1_200 = Logic
  L1_200 = L1_200.Get
  L1_200 = L1_200(L1_200, "Reward")
  L1_200 = L1_200.AddDupiCardTip
  L1_200 = L1_200(L1_200, A0_199.rewards)
  Prompt:Msg(L1_200)
end
