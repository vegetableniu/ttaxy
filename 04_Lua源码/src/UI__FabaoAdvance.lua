local L0_0
L0_0 = module
L0_0((...), package.seeall)
L0_0 = require
L0_0("SceneHelper")
L0_0 = require
L0_0("BtnPosition")
L0_0 = require
L0_0 = L0_0("FabaoTranslate")
prototype = BtnPosition.prototype:extend()
function prototype.initialize(A0_1)
  super.initialize(A0_1)
end
function prototype.onNodeLoaded(A0_2, A1_3, A2_4)
end
function prototype.onEnter(A0_5)
  super.onEnter(A0_5)
  Logic:Get("Talisman").advanceMode = true
  Logic:Get("Talisman").convertMode = false
  if A0_5.imgFabao then
    A0_5.imgFabao:setVisible(true)
  end
  A0_5:setupAdvanceCaptions()
  A0_5:bindSlotPicks()
  A0_5:clearSlots()
  A0_5:refreshState()
  MsgTalisman:Post("LOAD_ALL_TALISMAN", {})
  Logic:Get("Compose"):On(Logic.Compose.EVT.SELECT_CARD, A0_5:Event("onSelectCard"))
  Logic:Get("Talisman"):On(Logic.Talisman.EVT.OPT_SWALLOWFABAO_SET, A0_5:Event("OnOptSwallowSet"))
  Logic:Get("Talisman"):On(Logic.Talisman.EVT.OPT_UPGRADEFABAO_SET, A0_5:Event("OnOptUpgradeFabao"))
  Logic:Get("Talisman"):On(Logic.Talisman.EVT.CHANGE_UPDATE_STATE, A0_5:Event("OnAdvanceDone"))
end
function collectBySize(A0_6, A1_7, A2_8)
  local L3_9, L4_10
  L3_9 = {}
  if A0_6 == nil then
    return L3_9
  end
  function L4_10(A0_11)
    if A0_11 == nil then
      return
    end
    if A0_11.getContentSize and A0_11:getContentSize() then
      if math.abs(((A0_11.getContentSize and A0_11:getContentSize()).width or 0) - _UPVALUE0_) < 2 then
        if 2 > math.abs(((A0_11.getContentSize and A0_11:getContentSize()).height or 0) - _UPVALUE1_) then
          table.insert(_UPVALUE2_, {
            node = A0_11,
            x = A0_11.convertToWorldSpace and A0_11:convertToWorldSpace(ccp(((A0_11.getContentSize and A0_11:getContentSize()).width or 0) / 2, ((A0_11.getContentSize and A0_11:getContentSize()).height or 0) / 2)) and (A0_11.convertToWorldSpace and A0_11:convertToWorldSpace(ccp(((A0_11.getContentSize and A0_11:getContentSize()).width or 0) / 2, ((A0_11.getContentSize and A0_11:getContentSize()).height or 0) / 2))).x or 0,
            y = A0_11.convertToWorldSpace and A0_11:convertToWorldSpace(ccp(((A0_11.getContentSize and A0_11:getContentSize()).width or 0) / 2, ((A0_11.getContentSize and A0_11:getContentSize()).height or 0) / 2)) and (A0_11.convertToWorldSpace and A0_11:convertToWorldSpace(ccp(((A0_11.getContentSize and A0_11:getContentSize()).width or 0) / 2, ((A0_11.getContentSize and A0_11:getContentSize()).height or 0) / 2))).y or 0
          })
        end
      end
    end
    if A0_11.getChildren and A0_11:getChildren() and (A0_11.getChildren and A0_11:getChildren()).count then
      for _FORV_6_ = 1, (A0_11.getChildren and A0_11:getChildren()):count() do
        _UPVALUE3_(tolua.cast((A0_11.getChildren and A0_11:getChildren()):objectAtIndex(_FORV_6_ - 1), "CCNode"))
      end
    end
  end
  L4_10(A0_6)
  return L3_9
end
function prototype.setupAdvanceCaptions(A0_12)
  local L1_13
  L1_13 = A0_12.advanceCaptions
  if L1_13 then
    return
  end
  A0_12.advanceCaptions = true
  L1_13 = A0_12.layer
  L1_13 = L1_13 or A0_12.rootNode
  for _FORV_6_ = 1, #collectBySize(L1_13, 131, 35) do
    if collectBySize(L1_13, 131, 35)[_FORV_6_].y > 400 then
      A0_12:putGoldOnSprite(collectBySize(L1_13, 131, 35)[_FORV_6_].node, "\230\179\149\229\174\157\232\191\155\233\152\182", 34)
    else
      A0_12:putGoldOnSprite(collectBySize(L1_13, 131, 35)[_FORV_6_].node, "\230\179\149\229\174\157\229\144\158\229\153\172", 28)
    end
  end
  for _FORV_7_ = 1, #collectBySize(L1_13, 123, 35) do
    A0_12:putGoldOnSprite(collectBySize(L1_13, 123, 35)[_FORV_7_].node, "\230\179\149\229\174\157\232\191\155\233\152\182", 28)
  end
end
function prototype.putGoldOnSprite(A0_14, A1_15, A2_16, A3_17)
  local L4_18, L5_19, L6_20, L7_21, L8_22, L9_23
  if A1_15 == nil then
    return
  end
  L5_19 = A1_15
  L4_18 = A1_15.setVisible
  L6_20 = false
  L4_18(L5_19, L6_20)
  L4_18 = A1_15.getParent
  if L4_18 then
    L5_19 = A1_15
    L4_18 = A1_15.getParent
    L4_18 = L4_18(L5_19)
  elseif not L4_18 then
    L4_18 = A0_14.layer
    L4_18 = L4_18 or A0_14.rootNode
  end
  if L4_18 == nil then
    return
  end
  L5_19 = A1_15.getPositionLua
  if L5_19 then
    L6_20 = A1_15
    L5_19 = A1_15.getPositionLua
    L5_19 = L5_19(L6_20)
  elseif not L5_19 then
    L5_19 = ccp
    L6_20 = 0
    L7_21 = 0
    L5_19 = L5_19(L6_20, L7_21)
  end
  L6_20 = A1_15.getContentSize
  if L6_20 then
    L7_21 = A1_15
    L6_20 = A1_15.getContentSize
    L6_20 = L6_20(L7_21)
  elseif not L6_20 then
    L6_20 = {}
    L6_20.width = 0
    L6_20.height = 0
  end
  L7_21 = 0.5
  L8_22 = 0.5
  L9_23 = A1_15.getAnchorPoint
  if L9_23 then
    L9_23 = A1_15.getAnchorPoint
    L9_23 = L9_23(A1_15)
    if L9_23 then
      L7_21 = L9_23.x or L7_21
      L8_22 = L9_23.y or L8_22
    end
  end
  L9_23 = CCLabelTTF
  L9_23 = L9_23.create
  L9_23 = L9_23(L9_23)
  L9_23:setString(A2_16)
  L9_23:setFontSize(A3_17 or 28)
  L9_23:setColor(ccc3(255, 220, 80))
  L9_23:setStyle(kCCLabelTTFStyleOutline, ccc3(0, 0, 0))
  L9_23:setAnchorPoint(ccp(0.5, 0.5))
  L9_23:setPosition(ccp(L5_19.x + (0.5 - L7_21) * (L6_20.width or 0), L5_19.y + (0.5 - L8_22) * (L6_20.height or 0)))
  L4_18:addChild(L9_23, 80)
end
function prototype.onExit(A0_24)
  Logic:Get("Talisman").advanceMode = false
  Logic:Get("Talisman").convertMode = false
  Logic:Get("Talisman").upgradeFabao = nil
  Logic:Get("Talisman"):ClearSwallFabaos()
end
function prototype.slotCount(A0_25)
  local L1_26
  L1_26 = Logic
  L1_26 = L1_26.Talisman
  L1_26 = L1_26.MAXSWALLOW_NUM
  L1_26 = L1_26 or 6
  return L1_26
end
function prototype.bindSlotPicks(A0_27)
  local L1_28, L2_29, L3_30, L4_31
  for L4_31 = 1, L2_29(L3_30) do
    if A0_27[string.format("ccbFabao%d", L4_31)] then
      A0_27[string.format("ccbFabao%d", L4_31)].onBtnFabao = function()
        _UPVALUE0_:openMaterialSlot()
      end
    end
  end
end
function prototype.openMaterialSlot(A0_32)
  if Logic:Get("Talisman"):GetUpgradeFabao() == nil then
    Prompt:Tip("\232\175\183\233\128\137\230\139\169\230\169\153\232\137\178\230\179\149\229\174\157")
    return
  end
  if (Logic:Get("Talisman"):GetUpgradeFabao().level or 0) < 10 then
    Prompt:Fail("10\231\186\167\230\179\149\229\174\157\230\137\141\232\131\189\229\144\158\229\153\172")
    return
  end
  _UPVALUE0_.SetPickMode("advanceMaterial")
  SceneHelper:pushScene("FabaoTransSelect", A0_32.rootNode)
end
function prototype.clearSlots(A0_33, A1_34)
  local L2_35, L3_36, L4_37, L5_38
  for L5_38 = 1, L3_36(L4_37) do
    if A0_33[string.format("ccbFabao%d", L5_38)] then
      if A0_33[string.format("ccbFabao%d", L5_38)].imgAdd then
        A0_33[string.format("ccbFabao%d", L5_38)].imgAdd:setVisible(A1_34 == true)
      end
      if A0_33[string.format("ccbFabao%d", L5_38)].btnFabao then
        A0_33[string.format("ccbFabao%d", L5_38)].btnFabao:setEnabled(false)
        A0_33[string.format("ccbFabao%d", L5_38)].btnFabao:setBackgroundSpriteForState(CCScale9Sprite:create(_UPVALUE0_), CCControlStateNormal)
        A0_33[string.format("ccbFabao%d", L5_38)].btnFabao:setBackgroundSpriteForState(CCScale9Sprite:create(_UPVALUE0_), CCControlStateHighlighted)
        A0_33[string.format("ccbFabao%d", L5_38)].btnFabao:setBackgroundSpriteForState(CCScale9Sprite:create(_UPVALUE0_), CCControlStateDisabled)
      end
      if A0_33[string.format("ccbFabao%d", L5_38)].btnBg then
        A0_33[string.format("ccbFabao%d", L5_38)].btnBg:setVisible(true)
      end
    end
  end
end
function prototype.enableSlots(A0_39, A1_40)
  local L2_41, L3_42, L4_43, L5_44
  for L5_44 = 1, L3_42(L4_43) do
    if A0_39[string.format("ccbFabao%d", L5_44)] and A0_39[string.format("ccbFabao%d", L5_44)].btnFabao then
      A0_39[string.format("ccbFabao%d", L5_44)].btnFabao:setEnabled(A1_40 == true)
    end
  end
end
function prototype.showSourceCard(A0_45, A1_46)
  local L2_47, L3_48, L4_49
  L2_47 = A0_45.btnFabao
  if L2_47 == nil then
    return
  end
  L2_47 = A0_45.btnFabao
  L3_48 = L2_47
  L2_47 = L2_47.getChildByTag
  L4_49 = 0
  L2_47 = L2_47(L3_48, L4_49)
  if L2_47 then
    L3_48 = A0_45.btnFabao
    L4_49 = L3_48
    L3_48 = L3_48.removeChild
    L3_48(L4_49, L2_47, true)
  end
  L3_48 = displayBaseIdOf
  L4_49 = A1_46
  L3_48 = L3_48(L4_49)
  if L3_48 == nil then
    return
  end
  L4_49 = A0_45.imgFabao
  if L4_49 then
    L4_49 = A0_45.imgFabao
    L4_49 = L4_49.setVisible
    L4_49(L4_49, false)
  end
  L4_49 = Logic
  L4_49 = L4_49.Get
  L4_49 = L4_49(L4_49, "HeroCardInfo")
  L4_49 = L4_49.createHeroCard
  L4_49 = L4_49(L4_49, L3_48, 200, nil, nil, nil, nil, true)
  if L4_49 then
    A0_45.btnFabao:addChild(L4_49, 0, 0)
    L4_49:setPosition(ccp(A0_45.btnFabao:getContentSize().width / 2, A0_45.btnFabao:getContentSize().height / 2))
  end
end
function displayBaseIdOf(A0_50)
  if A0_50 and _UPVALUE0_.GetSpec(A0_50.settingId or A0_50.baseId) then
    return (A0_50 and _UPVALUE0_.GetSpec(A0_50.settingId or A0_50.baseId)).displayBaseId
  end
  return A0_50 and KFDBGetRecord("TalismanSetting", A0_50.baseId) and (A0_50 and KFDBGetRecord("TalismanSetting", A0_50.baseId)).baseId or A0_50 and (A0_50.displayBaseId or A0_50.baseId)
end
function prototype.refreshState(A0_51)
  local L1_52, L2_53, L3_54, L4_55, L5_56, L6_57, L7_58, L8_59, L9_60
  L1_52 = Logic
  L2_53 = L1_52
  L1_52 = L1_52.Get
  L3_54 = "Talisman"
  L1_52 = L1_52(L2_53, L3_54)
  L3_54 = L1_52
  L2_53 = L1_52.GetUpgradeFabao
  L2_53 = L2_53(L3_54)
  if L2_53 then
    L3_54 = L2_53.advanceProgress
    L3_54 = L3_54 or 0
  else
    L3_54 = L3_54 or 0
  end
  L4_55 = Logic
  L4_55 = L4_55.Get
  L4_55 = L4_55(L5_56, L6_57)
  L4_55 = L4_55.GetSwallFabaos
  L4_55 = L4_55(L5_56)
  L4_55 = L4_55 or {}
  for L8_59 = 1, L6_57(L7_58) do
    L9_60 = L4_55[L8_59]
    if L9_60 then
      L3_54 = L3_54 + _UPVALUE0_.GetMaterialProgress(L9_60)
    end
  end
  if L2_53 then
  else
  end
  if L5_56 > 0 and L3_54 > L5_56 then
    L3_54 = L5_56
  end
  if L6_57 then
    L8_59 = kCCLabelTTFStyleOutline
    L6_57(L7_58, L8_59)
    L8_59 = true
    L6_57(L7_58, L8_59)
    if L5_56 > 0 then
      L8_59 = string
      L8_59 = L8_59.format
      L9_60 = "%d/%d"
      L9_60 = L8_59(L9_60, L3_54, L5_56)
      L6_57(L7_58, L8_59, L9_60, L8_59(L9_60, L3_54, L5_56))
    else
      L8_59 = "0/0"
      L6_57(L7_58, L8_59)
    end
  end
  if L6_57 then
    L8_59 = _UPVALUE1_
    L9_60 = _UPVALUE2_
    L6_57(L7_58, L8_59, L9_60, _UPVALUE3_)
    if L5_56 > 0 then
    else
    end
    L8_59 = L7_58
    L9_60 = true
    L7_58(L8_59, L9_60)
    L8_59 = L7_58
    L9_60 = L6_57
    L7_58(L8_59, L9_60, false, false, 0, 2000)
  end
  L8_59 = ""
  if L2_53 then
    L9_60 = tostring
    L9_60 = L9_60(L2_53.level or 1)
    L8_59 = L9_60
    L9_60 = _UPVALUE0_
    L9_60 = L9_60.GetLifeAttack
    L9_60 = L9_60(L2_53)
  end
  L9_60 = A0_51.setStat
  L9_60(A0_51, A0_51.lranktitle, L8_59)
  L9_60 = A0_51.setStat
  L9_60(A0_51, A0_51.lhealthtitle, L6_57)
  L9_60 = A0_51.setStat
  L9_60(A0_51, A0_51.lfighttitle, L7_58)
  L9_60 = A0_51.btnUpgrade
  if L9_60 then
    L9_60 = A0_51.btnUpgrade
    L9_60 = L9_60.setEnabled
    L9_60(L9_60, L2_53 ~= nil)
  end
  L9_60 = A0_51.btnAutoSwall
  if L9_60 then
    L9_60 = A0_51.btnAutoSwall
    L9_60 = L9_60.setEnabled
    L9_60(L9_60, L2_53 ~= nil)
  end
  L9_60 = A0_51.ccbInfoView
  if L9_60 then
    if L2_53 then
      L9_60 = A0_51.ccbInfoView
      L9_60 = L9_60.setVisible
      L9_60(L9_60, true)
      L9_60 = A0_51.ccbInfoView
      L9_60 = L9_60.RefreshInfo
      L9_60(L9_60, false)
    else
      L9_60 = A0_51.ccbInfoView
      L9_60 = L9_60.setVisible
      L9_60(L9_60, false)
    end
  end
end
function prototype.setStat(A0_61, A1_62, A2_63)
  if A1_62 == nil then
    return
  end
  if A1_62.setString then
    A1_62:setString(tostring(A2_63 or ""))
    if A1_62.setStyle then
      A1_62:setStyle(kCCLabelTTFStyleOutline)
    end
  elseif A1_62.setValue then
    if A1_62.create then
      A1_62:create()
    end
    A1_62:setValue(tonumber(A2_63) or 0)
  end
end
function prototype.OnAdvanceDone(A0_64)
  A0_64:playPendingAni()
  A0_64:OnOptUpgradeFabao()
end
function prototype.OnOptUpgradeFabao(A0_65)
  local L1_66
  L1_66 = Logic
  L1_66 = L1_66.Get
  L1_66 = L1_66(L1_66, "Talisman")
  L1_66 = L1_66.GetUpgradeFabao
  L1_66 = L1_66(L1_66)
  Logic:Get("Talisman"):ClearSwallFabaos()
  if L1_66 then
    A0_65:clearSlots(true)
    A0_65:showSourceCard(L1_66)
    A0_65:enableSlots(true)
  else
    A0_65:clearSlots(false)
    A0_65:enableSlots(false)
  end
  A0_65:refreshState()
end
function prototype.OnOptSwallowSet(A0_67)
  local L1_68, L2_69, L3_70, L4_71, L5_72, L6_73, L7_74, L8_75, L9_76
  L1_68 = Logic
  L1_68 = L1_68.Get
  L1_68 = L1_68(L2_69, L3_70)
  L1_68 = L1_68.GetSwallFabaos
  L1_68 = L1_68(L2_69)
  L1_68 = L1_68 or {}
  L5_72 = L4_71
  L6_73 = "Talisman"
  L5_72 = L4_71
  L4_71 = L4_71 ~= nil
  L2_69(L3_70, L4_71)
  L5_72 = L4_71
  L6_73 = "Talisman"
  L5_72 = L4_71
  L4_71 = L4_71 ~= nil
  L2_69(L3_70, L4_71)
  for L5_72 = 1, L3_70(L4_71) do
    L6_73 = string
    L6_73 = L6_73.format
    L7_74 = "ccbFabao%d"
    L8_75 = L5_72
    L6_73 = L6_73(L7_74, L8_75)
    L6_73 = A0_67[L6_73]
    L7_74 = L1_68[L5_72]
    if L6_73 and L7_74 then
      L8_75 = L6_73.imgAdd
      if L8_75 then
        L8_75 = L6_73.imgAdd
        L9_76 = L8_75
        L8_75 = L8_75.setVisible
        L8_75(L9_76, false)
      end
      L8_75 = displayBaseIdOf
      L9_76 = L7_74
      L8_75 = L8_75(L9_76)
      L9_76 = L8_75 and L9_76(L9_76, L8_75)
      if L9_76 and L6_73.btnFabao then
        L6_73.btnFabao:setBackgroundSpriteForState(CCScale9Sprite:create(L9_76), CCControlStateNormal)
        L6_73.btnFabao:setBackgroundSpriteForState(CCScale9Sprite:create(L9_76), CCControlStateHighlighted)
        L6_73.btnFabao:setBackgroundSpriteForState(CCScale9Sprite:create(L9_76), CCControlStateDisabled)
      end
    end
  end
  L2_69(L3_70)
end
function prototype.appendSwallow(A0_77, A1_78)
  if A1_78 == nil or A1_78.id == nil then
    return
  end
  Logic:Get("Talisman").swallfabaos = Logic:Get("Talisman").swallfabaos or {}
  for _FORV_6_, _FORV_7_ in ipairs(Logic:Get("Talisman").swallfabaos) do
    if _FORV_7_ and _FORV_7_.id == A1_78.id then
      return
    end
  end
  if #Logic:Get("Talisman").swallfabaos >= A0_77:slotCount() then
    return
  end
  table.insert(Logic:Get("Talisman").swallfabaos, A1_78)
end
function prototype.playPendingAni(A0_79)
  local L1_80
  L1_80 = A0_79.pendingAni
  if L1_80 == nil then
    return
  end
  A0_79.pendingAni = nil
  _UPVALUE0_.PlaySuccessAni(L1_80.inBaseId, L1_80.outBaseId, L1_80.materials, {
    settingId = L1_80.settingId,
    level = L1_80.level or 1
  })
end
function prototype.onSelectCard(A0_81)
  local L1_82, L2_83, L3_84, L4_85, L5_86, L6_87, L7_88, L8_89
  L1_82 = _UPVALUE0_
  L1_82 = L1_82.GetPickMode
  L1_82 = L1_82()
  L2_83 = _UPVALUE0_
  L2_83 = L2_83.GetSelect
  L2_83 = L2_83()
  if L2_83 == nil then
    return
  end
  L3_84 = Logic
  L3_84 = L3_84.Get
  L3_84 = L3_84(L4_85, L5_86)
  if L1_82 == "advanceMaterial" then
    L4_85(L5_86, L6_87)
    L4_85(L5_86)
    return
  end
  for L7_88, L8_89 in L4_85(L5_86) do
    if L8_89.id == L2_83.id then
      L3_84:ClearSwallFabaos()
      L3_84:SetUpgradeFabao(L8_89)
      A0_81:clearSlots(true)
      A0_81:enableSlots(true)
      A0_81:showSourceCard(L8_89)
      A0_81:refreshState()
      return
    end
  end
end
function prototype.onBtnReturn(A0_90)
  SceneHelper:runWithScene("FabaoTranslate", A0_90.rootNode)
end
function prototype.onBtnFabao(A0_91)
  _UPVALUE0_.SetPickMode("advanceSource", 1)
  SceneHelper:pushScene("FabaoTransSelect", A0_91.rootNode)
end
function prototype.onBtnUpgrade(A0_92)
  local L1_93, L2_94
  L1_93 = Logic
  L2_94 = L1_93
  L1_93 = L1_93.Get
  L1_93 = L1_93(L2_94, "Talisman")
  L2_94 = L1_93
  L1_93 = L1_93.GetUpgradeFabao
  L1_93 = L1_93(L2_94)
  if L1_93 == nil then
    L2_94 = Prompt
    L2_94 = L2_94.Tip
    L2_94(L2_94, "\232\175\183\233\128\137\230\139\169\230\169\153\232\137\178\230\179\149\229\174\157")
    return
  end
  L2_94 = L1_93.level
  L2_94 = L2_94 or 0
  if L2_94 < 10 then
    L2_94 = Prompt
    L2_94 = L2_94.Fail
    L2_94(L2_94, "10\231\186\167\230\179\149\229\174\157\230\137\141\232\131\189\229\144\158\229\153\172")
    return
  end
  L2_94 = {}
  for _FORV_7_ = 1, A0_92:slotCount() do
    if (Logic:Get("Talisman"):GetSwallFabaos() or {})[_FORV_7_] and (Logic:Get("Talisman"):GetSwallFabaos() or {})[_FORV_7_].id then
      table.insert(L2_94, (Logic:Get("Talisman"):GetSwallFabaos() or {})[_FORV_7_].id)
    end
  end
  if _FOR_ == 0 then
    Prompt:Tip("\232\175\183\233\128\137\230\139\169\229\144\158\229\153\172\230\157\144\230\150\153")
    return
  end
  A0_92.pendingAni = {
    inBaseId = displayBaseIdOf(L1_93),
    outBaseId = displayBaseIdOf(L1_93),
    materials = {
      (Logic:Get("Talisman"):GetSwallFabaos() or {})[1],
      (Logic:Get("Talisman"):GetSwallFabaos() or {})[2],
      (Logic:Get("Talisman"):GetSwallFabaos() or {})[3],
      (Logic:Get("Talisman"):GetSwallFabaos() or {})[4],
      (Logic:Get("Talisman"):GetSwallFabaos() or {})[5],
      (Logic:Get("Talisman"):GetSwallFabaos() or {})[6]
    },
    settingId = L1_93.settingId or L1_93.baseId,
    level = L1_93.level or 1
  }
  MsgTalisman:Post("ADVANCE_SWALLOW_TALISMAN", {
    talismanId = L1_93.id,
    talismanIds = L2_94
  })
end
function prototype.onBtnAutoSwall(A0_95)
  local L1_96, L2_97
  L1_96 = Logic
  L2_97 = L1_96
  L1_96 = L1_96.Get
  L1_96 = L1_96(L2_97, "Talisman")
  L2_97 = L1_96.GetUpgradeFabao
  L2_97 = L2_97(L1_96)
  if L2_97 == nil then
    Prompt:Tip("\232\175\183\233\128\137\230\139\169\230\169\153\232\137\178\230\179\149\229\174\157")
    return
  end
  if (L2_97.level or 0) < 10 or 0 >= _UPVALUE0_.GetAdvanceRequirement(L2_97.baseId) or (L2_97.advanceProgress or 0) < _UPVALUE0_.GetAdvanceRequirement(L2_97.baseId) then
    Prompt:Fail("10\231\186\167\230\187\161\229\144\158\229\153\172\230\179\149\229\174\157\230\137\141\232\131\189\232\191\155\233\152\182")
    return
  end
  A0_95.pendingAni = {
    inBaseId = displayBaseIdOf(L2_97),
    outBaseId = _UPVALUE0_.RedDisplayBaseId(L2_97.baseId),
    materials = {},
    settingId = _UPVALUE0_.ADVANCE_RED[tonumber(L2_97.baseId)],
    level = 1
  }
  MsgTalisman:Post("ADVANCE_TALISMAN", {
    talismanId = L2_97.id,
    talismanIds = {}
  })
end
