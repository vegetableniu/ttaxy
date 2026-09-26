local L0_0
L0_0 = module
L0_0((...), package.seeall)
L0_0 = require
L0_0("SceneHelper")
L0_0 = require
L0_0("TableViewEx")
L0_0 = require
L0_0("BtnPosition")
L0_0 = require
L0_0 = L0_0("UI.FabaoHome")
prototype = BtnPosition.prototype:extend()
function prototype.initialize(A0_1)
  super.initialize(A0_1)
end
function prototype.onEnter(A0_2)
  local L1_3, L2_4, L3_5, L4_6
  L1_3(L2_4)
  L1_3 = L1_3 == true
  A0_2.advanceMode = L1_3
  L1_3 = L1_3 == true
  A0_2.convertMode = L1_3
  L1_3(L2_4, L3_5)
  L1_3(L2_4, L3_5)
  for L4_6 = 1, L2_4.MAXSWALLOW_NUM do
    if A0_2[string.format("ccbFabao%d", L4_6)] then
      A0_2[string.format("ccbFabao%d", L4_6)].imgAdd:setVisible(false)
      A0_2[string.format("ccbFabao%d", L4_6)].btnFabao:setEnabled(false)
      A0_2[string.format("ccbFabao%d", L4_6)].btnBg:setVisible(true)
    end
  end
  L1_3(L2_4)
  L4_6 = A0_2.Event
  L4_6 = L4_6(A0_2, "OnReceiveTheReqFabao")
  L1_3(L2_4, L3_5, L4_6, L4_6(A0_2, "OnReceiveTheReqFabao"))
  L4_6 = A0_2.Event
  L4_6 = L4_6(A0_2, "onChangeUpdateState")
  L1_3(L2_4, L3_5, L4_6, L4_6(A0_2, "onChangeUpdateState"))
  L4_6 = A0_2.Event
  L4_6 = L4_6(A0_2, "OnOptUpgradeFabao")
  L1_3(L2_4, L3_5, L4_6, L4_6(A0_2, "OnOptUpgradeFabao"))
  L4_6 = A0_2.Event
  L4_6 = L4_6(A0_2, "OnOptSwallowSet")
  L1_3(L2_4, L3_5, L4_6, L4_6(A0_2, "OnOptSwallowSet"))
  if L1_3 then
    L1_3(L2_4)
  elseif L1_3 then
    L1_3(L2_4)
  end
end
function prototype.setButtonTitle(A0_7, A1_8, A2_9)
  local L3_10, L4_11, L5_12, L6_13, L7_14
  if A1_8 == nil then
    return
  end
  for L6_13, L7_14 in L3_10(L4_11) do
    A1_8:setTitleForState(A2_9, L7_14)
  end
end
function prototype.getAdvanceRoot(A0_15)
  return A0_15.rootNode or A0_15.layer
end
function prototype.removeAdvanceNode(A0_16, A1_17)
  if A0_16:getAdvanceRoot() then
    A0_16:getAdvanceRoot():removeChildByTag(A1_17, true)
  end
end
function prototype.addAdvanceLabel(A0_18, A1_19, A2_20, A3_21, A4_22, A5_23)
  local L6_24, L7_25
  L7_25 = A0_18
  L6_24 = A0_18.getAdvanceRoot
  L6_24 = L6_24(L7_25)
  if L6_24 == nil then
    L7_25 = nil
    return L7_25
  end
  L7_25 = L6_24.removeChildByTag
  L7_25(L6_24, A1_19, true)
  L7_25 = CCLabelTTF
  L7_25 = L7_25.create
  L7_25 = L7_25(L7_25)
  L7_25:setString(A2_20 or "")
  L7_25:setFontSize(A4_22 or 22)
  L7_25:setColor(A5_23 or ccc3(255, 230, 90))
  L7_25:setStyle(kCCLabelTTFStyleOutline, ccc3(0, 0, 0))
  L7_25:setAnchorPoint(ccp(0.5, 0.5))
  L7_25:setPosition(A3_21)
  L6_24:addChild(L7_25, 50, A1_19)
  return L7_25
end
function prototype.setupAdvanceUi(A0_26)
  A0_26:setButtonTitle(A0_26.btnUpgrade, "\233\128\137\230\139\169\232\191\155\233\152\182\230\157\144\230\150\153")
  A0_26:setButtonTitle(A0_26.btnFabao, "\233\128\137\230\139\169\230\169\153\232\137\178\230\179\149\229\174\157")
  if A0_26.btnAutoSwall then
    A0_26:setButtonTitle(A0_26.btnAutoSwall, "\230\179\149\229\174\157\232\191\155\233\152\182")
  end
  if A0_26:getAdvanceRoot() and A0_26:getAdvanceRoot():getContentSize() then
    if A0_26:getAdvanceRoot():getContentSize().width > 0 then
    end
    if 0 < A0_26:getAdvanceRoot():getContentSize().height then
    end
  end
  A0_26:addAdvanceLabel(_UPVALUE0_, "\230\179\149\229\174\157\232\191\155\233\152\182", ccp((A0_26:getAdvanceRoot():getContentSize().width or 720) * 0.5, (A0_26:getAdvanceRoot():getContentSize().height or 800) - 58), 34, ccc3(255, 220, 80))
  A0_26:addAdvanceLabel(_UPVALUE1_, "\231\180\171\230\179\149\229\174\157+10    \228\190\191\229\174\156\230\169\153\232\137\178+1200    \229\133\182\228\187\150\230\169\153\232\137\178+2000", ccp((A0_26:getAdvanceRoot():getContentSize().width or 720) * 0.5, 78), 17, ccc3(210, 235, 210))
  A0_26:refreshAdvancePreview()
  A0_26:refreshAdvanceState()
end
function prototype.setupConvertUi(A0_27)
  A0_27:setButtonTitle(A0_27.btnUpgrade, "\233\128\137\230\139\169\230\151\167\230\179\149\229\174\157")
  A0_27:setButtonTitle(A0_27.btnFabao, "\233\128\137\230\139\169\230\151\167\230\179\149\229\174\157")
  if A0_27.btnAutoSwall then
    A0_27:setButtonTitle(A0_27.btnAutoSwall, "\230\179\149\229\174\157\232\189\172\230\141\162")
  end
  if A0_27:getAdvanceRoot() and A0_27:getAdvanceRoot():getContentSize() then
    if A0_27:getAdvanceRoot():getContentSize().width > 0 then
    end
    if 0 < A0_27:getAdvanceRoot():getContentSize().height then
    end
  end
  A0_27:addAdvanceLabel(_UPVALUE0_, "\230\179\149\229\174\157\232\189\172\230\141\162", ccp((A0_27:getAdvanceRoot():getContentSize().width or 720) * 0.5, (A0_27:getAdvanceRoot():getContentSize().height or 800) - 58), 34, ccc3(255, 220, 80))
  A0_27:addAdvanceLabel(_UPVALUE1_, "\230\151\167\230\169\153\232\137\178/\231\186\162\232\137\178 \226\134\146 \229\175\185\229\186\148\230\150\176\230\179\149\229\174\157    \230\182\136\232\128\1512\228\184\170\229\175\185\229\186\148\230\151\167\230\169\153\232\137\178\230\179\149\229\174\157", ccp((A0_27:getAdvanceRoot():getContentSize().width or 720) * 0.5, 78), 17, ccc3(210, 235, 210))
  A0_27:refreshConvertPreview()
end
function prototype.refreshAdvancePreview(A0_28)
  local L1_29, L2_30, L3_31, L4_32
  L1_29 = A0_28.advanceMode
  if not L1_29 then
    return
  end
  L2_30 = A0_28
  L1_29 = A0_28.getAdvanceRoot
  L1_29 = L1_29(L2_30)
  if L1_29 == nil then
    return
  end
  L3_31 = L1_29
  L2_30 = L1_29.removeChildByTag
  L4_32 = _UPVALUE0_
  L2_30(L3_31, L4_32, true)
  L3_31 = L1_29
  L2_30 = L1_29.removeChildByTag
  L4_32 = _UPVALUE1_
  L2_30(L3_31, L4_32, true)
  L3_31 = L1_29
  L2_30 = L1_29.removeChildByTag
  L4_32 = _UPVALUE2_
  L2_30(L3_31, L4_32, true)
  L2_30 = A0_28.updateFabao
  if not L2_30 then
    L2_30 = Logic
    L3_31 = L2_30
    L2_30 = L2_30.Get
    L4_32 = "Talisman"
    L2_30 = L2_30(L3_31, L4_32)
    L3_31 = L2_30
    L2_30 = L2_30.GetUpgradeFabao
    L2_30 = L2_30(L3_31)
  end
  L3_31 = L2_30 and L3_31(L4_32)
  if not L3_31 then
    return
  end
  L4_32 = Logic
  L4_32 = L4_32.Get
  L4_32 = L4_32(L4_32, "HeroCardInfo")
  L4_32 = L4_32.createHeroCard
  L4_32 = L4_32(L4_32, L3_31.displayBaseId, 190)
  if L4_32 == nil then
    return
  end
  if L1_29:getContentSize() then
    if L1_29:getContentSize().width > 0 then
    end
    if 0 < L1_29:getContentSize().height then
    end
  end
  L4_32:setAnchorPoint(ccp(0.5, 0.5))
  L4_32:setPosition(ccp((L1_29:getContentSize().width or 720) * 0.73, A0_28.btnFabao:getPosition().y))
  L1_29:addChild(L4_32, 10, _UPVALUE0_)
  A0_28:addAdvanceLabel(_UPVALUE1_, L3_31.name, ccp((L1_29:getContentSize().width or 720) * 0.73, A0_28.btnFabao:getPosition().y - 118), 22, ccc3(255, 220, 80))
  A0_28:addAdvanceLabel(_UPVALUE2_, L3_31.typeName .. "  1\230\152\159", ccp((L1_29:getContentSize().width or 720) * 0.73, A0_28.btnFabao:getPosition().y - 145), 18, ccc3(255, 245, 190))
  if not A0_28.advanceOriginalBtnPosition then
    A0_28.advanceOriginalBtnPosition = A0_28.btnFabao:getPosition()
  end
  A0_28.btnFabao:setPosition(ccp((L1_29:getContentSize().width or 720) * 0.27, A0_28.advanceOriginalBtnPosition.y))
end
function prototype.refreshConvertPreview(A0_33)
  local L1_34, L2_35, L3_36, L4_37
  L1_34 = A0_33.convertMode
  if not L1_34 then
    return
  end
  L2_35 = A0_33
  L1_34 = A0_33.getAdvanceRoot
  L1_34 = L1_34(L2_35)
  L2_35 = A0_33.updateFabao
  if not L2_35 then
    L2_35 = Logic
    L3_36 = L2_35
    L2_35 = L2_35.Get
    L4_37 = "Talisman"
    L2_35 = L2_35(L3_36, L4_37)
    L3_36 = L2_35
    L2_35 = L2_35.GetUpgradeFabao
    L2_35 = L2_35(L3_36)
  end
  L3_36 = L2_35 and L3_36(L4_37)
  if L1_34 == nil or L3_36 == nil then
    return
  end
  L4_37 = L1_34.removeChildByTag
  L4_37(L1_34, _UPVALUE1_, true)
  L4_37 = L1_34.removeChildByTag
  L4_37(L1_34, _UPVALUE2_, true)
  L4_37 = L1_34.removeChildByTag
  L4_37(L1_34, _UPVALUE3_, true)
  L4_37 = Logic
  L4_37 = L4_37.Get
  L4_37 = L4_37(L4_37, "HeroCardInfo")
  L4_37 = L4_37.createHeroCard
  L4_37 = L4_37(L4_37, L3_36.newDisplayBaseId, 190)
  if L1_34:getContentSize() then
    if L1_34:getContentSize().width > 0 then
    end
    if 0 < L1_34:getContentSize().height then
    end
  end
  if L4_37 then
    L4_37:setAnchorPoint(ccp(0.5, 0.5))
    L4_37:setPosition(ccp((L1_34:getContentSize().width or 720) * 0.73, A0_33.btnFabao:getPosition().y))
    L1_34:addChild(L4_37, 10, _UPVALUE1_)
  end
  A0_33:addAdvanceLabel(_UPVALUE2_, L3_36.newName, ccp((L1_34:getContentSize().width or 720) * 0.73, A0_33.btnFabao:getPosition().y - 118), 22, ccc3(255, 220, 80))
  A0_33:addAdvanceLabel(_UPVALUE3_, "\229\133\141\231\150\171\229\133\139\229\136\182\239\188\136\228\187\133PVP\231\148\159\230\149\136\239\188\137", ccp((L1_34:getContentSize().width or 720) * 0.73, A0_33.btnFabao:getPosition().y - 145), 18, ccc3(255, 245, 190))
end
function prototype.getAdvanceProgress(A0_38)
  local L1_39, L2_40, L3_41, L4_42, L5_43, L6_44, L7_45
  L1_39 = 0
  L2_40 = Logic
  L2_40 = L2_40.Get
  L2_40 = L2_40(L3_41, L4_42)
  L2_40 = L2_40.GetSwallFabaos
  L2_40 = L2_40(L3_41)
  L2_40 = L2_40 or {}
  for L6_44, L7_45 in L3_41(L4_42) do
    L1_39 = L1_39 + _UPVALUE0_(L7_45)
  end
  if L3_41 then
  else
  end
  if L4_42 > 0 and L1_39 > L4_42 then
    L1_39 = L4_42
  end
  L6_44 = L4_42
  return L5_43, L6_44
end
function prototype.refreshAdvanceState(A0_46)
  local L1_47, L2_48, L3_49
  L1_47 = A0_46.advanceMode
  if not L1_47 then
    return
  end
  L2_48 = A0_46
  L1_47 = A0_46.getAdvanceProgress
  L2_48 = L1_47(L2_48)
  A0_46.advanceProgress = L1_47
  A0_46.advanceRequirement = L2_48
  L3_49 = A0_46.staStatus
  if L3_49 then
    L3_49 = A0_46.staStatus
    L3_49 = L3_49.setVisible
    L3_49(L3_49, true)
    L3_49 = A0_46.staStatus
    L3_49 = L3_49.setStyle
    L3_49(L3_49, kCCLabelTTFStyleOutline)
    L3_49 = A0_46.staStatus
    L3_49 = L3_49.setString
    L3_49(L3_49, string.format("\232\191\155\229\186\166\239\188\154%d/%d", L1_47, L2_48))
  end
  L3_49 = A0_46.prgTest
  if L3_49 then
    L3_49 = A0_46.prgTest
    L3_49 = L3_49.createProgress
    L3_49(L3_49, _UPVALUE0_, _UPVALUE1_, _UPVALUE2_)
    if L2_48 > 0 then
      L3_49 = 100 * L1_47
      L3_49 = L3_49 / L2_48
    else
      L3_49 = L3_49 or 0
    end
    A0_46.prgTest:setVisible(true)
    A0_46.prgTest:setValue(L3_49, false, false, 0, 2000)
  end
  L3_49 = A0_46.updateFabao
  L3_49 = L3_49 ~= nil and L3_49 >= 10 and L2_48 > 0 and L2_48 <= L1_47
  if A0_46.btnUpgrade then
    A0_46.btnUpgrade:setEnabled(A0_46.updateFabao ~= nil)
  end
  if A0_46.btnAutoSwall then
    A0_46.btnAutoSwall:setEnabled(L3_49)
  end
end
function prototype.OnOptUpgradeFabao(A0_50)
  local L1_51, L2_52, L3_53, L4_54, L5_55
  L1_51 = Logic
  L2_52 = L1_51
  L1_51 = L1_51.Get
  L3_53 = "Talisman"
  L1_51 = L1_51(L2_52, L3_53)
  L2_52 = L1_51
  L1_51 = L1_51.GetUpgradeFabao
  L1_51 = L1_51(L2_52)
  if L1_51 then
    L2_52 = A0_50.imgFabao
    L3_53 = L2_52
    L2_52 = L2_52.setVisible
    L4_54 = false
    L2_52(L3_53, L4_54)
    L2_52 = A0_50.btnUpgrade
    L3_53 = L2_52
    L2_52 = L2_52.setEnabled
    L4_54 = true
    L2_52(L3_53, L4_54)
    L2_52 = A0_50.ccbInfoView
    L3_53 = L2_52
    L2_52 = L2_52.setVisible
    L4_54 = true
    L2_52(L3_53, L4_54)
    L2_52 = A0_50.btnFabao
    L3_53 = L2_52
    L2_52 = L2_52.getChildByTag
    L4_54 = 0
    L2_52 = L2_52(L3_53, L4_54)
    if L2_52 then
      L3_53 = A0_50.btnFabao
      L4_54 = L3_53
      L3_53 = L3_53.removeChild
      L5_55 = L2_52
      L3_53(L4_54, L5_55, true)
    end
    A0_50.updateFabao = L1_51
    if L1_51 then
      L3_53 = L1_51.baseId
      if L3_53 then
        L3_53 = KFDBGetRecord
        L4_54 = "TalismanSetting"
        L5_55 = L1_51.baseId
        L3_53 = L3_53(L4_54, L5_55)
        if L3_53 then
          L4_54 = L3_53.baseId
        else
          L4_54 = L4_54 or L1_51.displayBaseId
        end
        if L4_54 ~= nil then
          L5_55 = A0_50.imgFabao
          if L5_55 then
            L5_55 = Logic
            L5_55 = L5_55.Get
            L5_55 = L5_55(L5_55, "HeroCardInfo")
            L5_55 = L5_55.createHeroCard
            L5_55 = L5_55(L5_55, L4_54, 200, nil, nil, nil, nil, true)
            A0_50.btnFabao:addChild(L5_55, 0, 0)
            L5_55:setPosition(ccp(A0_50.btnFabao:getContentSize().width / 2, A0_50.btnFabao:getContentSize().height / 2))
          end
        end
      end
    end
    L3_53 = Logic
    L4_54 = L3_53
    L3_53 = L3_53.Get
    L5_55 = "Talisman"
    L3_53 = L3_53(L4_54, L5_55)
    L4_54 = L3_53
    L3_53 = L3_53.GetSwallFabaos
    L3_53 = L3_53(L4_54)
    A0_50.updateSwalls = L3_53
    L3_53 = Logic
    L4_54 = L3_53
    L3_53 = L3_53.Get
    L5_55 = "Talisman"
    L3_53 = L3_53(L4_54, L5_55)
    L3_53 = L3_53.localAcceptance
    if L3_53 then
      L3_53 = A0_50.ccbInfoView
      L4_54 = L3_53
      L3_53 = L3_53.setVisible
      L5_55 = false
      L3_53(L4_54, L5_55)
    else
      L3_53 = A0_50.ccbInfoView
      L4_54 = L3_53
      L3_53 = L3_53.RefreshInfo
      L5_55 = false
      L3_53(L4_54, L5_55)
    end
    L3_53 = A0_50.advanceMode
    if L3_53 then
      L4_54 = A0_50
      L3_53 = A0_50.refreshAdvancePreview
      L3_53(L4_54)
      L4_54 = A0_50
      L3_53 = A0_50.refreshAdvanceState
      L3_53(L4_54)
    else
      L3_53 = A0_50.convertMode
      if L3_53 then
        L4_54 = A0_50
        L3_53 = A0_50.refreshConvertPreview
        L3_53(L4_54)
      end
    end
    L4_54 = A0_50
    L3_53 = A0_50.onChangeProess
    L5_55 = L1_51
    L3_53(L4_54, L5_55)
    L3_53 = A0_50.prgTest
    L4_54 = L3_53
    L3_53 = L3_53.setVisible
    L5_55 = true
    L3_53(L4_54, L5_55)
    L4_54 = A0_50
    L3_53 = A0_50.clearccbstate
    L3_53(L4_54)
  end
  L3_53 = A0_50
  L2_52 = A0_50.onChangeShowState
  L2_52(L3_53)
end
function prototype.OnOptSwallowSet(A0_56)
  local L1_57, L2_58, L3_59, L4_60, L5_61, L6_62, L7_63, L8_64, L9_65, L10_66
  L1_57 = Logic
  L1_57 = L1_57.Get
  L1_57 = L1_57(L2_58, L3_59)
  L1_57 = L1_57.GetSwallFabaos
  L1_57 = L1_57(L2_58)
  if not L1_57 then
    return
  end
  if L2_58 then
    A0_56.swallow = L1_57
    A0_56.swallowExp = 0
    L2_58(L3_59, L4_60)
    for L5_61 = 1, L3_59.MAXSWALLOW_NUM do
      L7_63 = "ccbFabao%d"
      L8_64 = L5_61
      L7_63 = L1_57[L5_61]
      if L7_63 then
        L8_64 = A0_56[L6_62]
        L8_64 = L8_64.imgAdd
        L9_65 = L8_64
        L8_64 = L8_64.setVisible
        L10_66 = false
        L8_64(L9_65, L10_66)
        L8_64 = L7_63.displayBaseId
        L9_65 = L8_64 and L9_65(L10_66, L8_64)
        if L9_65 then
          L10_66 = A0_56[L6_62]
          L10_66 = L10_66.btnFabao
          L10_66 = L10_66.setBackgroundSpriteForState
          L10_66(L10_66, CCScale9Sprite:create(L9_65), CCControlStateNormal)
          L10_66 = A0_56[L6_62]
          L10_66 = L10_66.btnFabao
          L10_66 = L10_66.setBackgroundSpriteForState
          L10_66(L10_66, CCScale9Sprite:create(L9_65), CCControlStateHighlighted)
          L10_66 = A0_56[L6_62]
          L10_66 = L10_66.btnFabao
          L10_66 = L10_66.setBackgroundSpriteForState
          L10_66(L10_66, CCScale9Sprite:create(L9_65), CCControlStateDisabled)
        end
        L10_66 = A0_56.swallowExp
        L10_66 = L10_66 + (L7_63.progressValue or 0)
        A0_56.swallowExp = L10_66
      else
        L8_64 = A0_56[L6_62]
        L8_64 = L8_64.imgAdd
        L9_65 = L8_64
        L8_64 = L8_64.setVisible
        L10_66 = true
        L8_64(L9_65, L10_66)
      end
    end
    if L2_58 then
      L2_58(L3_59)
    end
    return
  end
  L2_58(L3_59, L4_60)
  for L6_62, L7_63 in L3_59(L4_60) do
    if L7_63 then
      L8_64 = KFDBGetRecord
      L9_65 = "TalismanSetting"
      L10_66 = L7_63.baseId
      L8_64 = L8_64(L9_65, L10_66)
      if L8_64 then
        L9_65 = Logic
        L10_66 = L9_65
        L9_65 = L9_65.Get
        L9_65 = L9_65(L10_66, "Hero")
        L10_66 = L9_65
        L9_65 = L9_65.GetHeroInfoByBaseId
        L9_65 = L9_65(L10_66, L8_64.baseId)
        if L9_65 then
          L10_66 = table
          L10_66 = L10_66.insert
          L10_66(L2_58, L9_65)
        end
      end
    end
  end
  A0_56.swallow = L2_58
  for L7_63 = 1, L5_61.MAXSWALLOW_NUM do
    L8_64 = L2_58[L7_63]
    if L8_64 then
      L8_64 = L2_58[L7_63]
      L8_64 = L8_64.id
      if L8_64 then
        L8_64 = string
        L8_64 = L8_64.format
        L9_65 = "ccbFabao%d"
        L10_66 = L7_63
        L8_64 = L8_64(L9_65, L10_66)
        L9_65 = A0_56[L8_64]
        L9_65 = L9_65.imgAdd
        L10_66 = L9_65
        L9_65 = L9_65.setVisible
        L9_65(L10_66, false)
        L9_65 = Logic
        L10_66 = L9_65
        L9_65 = L9_65.Get
        L9_65 = L9_65(L10_66, "Hero")
        L10_66 = L9_65
        L9_65 = L9_65.GetHeroImage
        L9_65 = L9_65(L10_66, L2_58[L7_63].id)
        if L9_65 then
          L10_66 = A0_56[L8_64]
          L10_66 = L10_66.btnFabao
          L10_66 = L10_66.setBackgroundSpriteForState
          L10_66(L10_66, CCScale9Sprite:create(L9_65), CCControlStateNormal)
          L10_66 = A0_56[L8_64]
          L10_66 = L10_66.btnFabao
          L10_66 = L10_66.setBackgroundSpriteForState
          L10_66(L10_66, CCScale9Sprite:create(L9_65), CCControlStateHighlighted)
          L10_66 = A0_56[L8_64]
          L10_66 = L10_66.btnFabao
          L10_66 = L10_66.setBackgroundSpriteForState
          L10_66(L10_66, CCScale9Sprite:create(L9_65), CCControlStateDisabled)
        end
        L10_66 = Logic
        L10_66 = L10_66.Get
        L10_66 = L10_66(L10_66, "Hero")
        L10_66 = L10_66.GetHeroBgImage
        L10_66 = L10_66(L10_66, L2_58[L7_63].id)
        if L10_66 then
          A0_56[L8_64].btnBg:setBackgroundSpriteForState(CCScale9Sprite:create(L10_66), CCControlStateNormal)
          A0_56[L8_64].btnBg:setBackgroundSpriteForState(CCScale9Sprite:create(L10_66), CCControlStateHighlighted)
          A0_56[L8_64].btnBg:setBackgroundSpriteForState(CCScale9Sprite:create(L10_66), CCControlStateDisabled)
        end
        A0_56.swallowExp = Logic:Get("Talisman"):AllSwallowFabaoExp()
      end
    else
      L8_64 = string
      L8_64 = L8_64.format
      L9_65 = "ccbFabao%d"
      L10_66 = L7_63
      L8_64 = L8_64(L9_65, L10_66)
      L9_65 = A0_56[L8_64]
      L9_65 = L9_65.imgAdd
      L10_66 = L9_65
      L9_65 = L9_65.setVisible
      L9_65(L10_66, true)
      L9_65 = "images/public/clarity05.png"
      if L9_65 then
        L10_66 = A0_56[L8_64]
        L10_66 = L10_66.btnFabao
        L10_66 = L10_66.setBackgroundSpriteForState
        L10_66(L10_66, CCScale9Sprite:create(L9_65), CCControlStateNormal)
        L10_66 = A0_56[L8_64]
        L10_66 = L10_66.btnFabao
        L10_66 = L10_66.setBackgroundSpriteForState
        L10_66(L10_66, CCScale9Sprite:create(L9_65), CCControlStateHighlighted)
        L10_66 = A0_56[L8_64]
        L10_66 = L10_66.btnFabao
        L10_66 = L10_66.setBackgroundSpriteForState
        L10_66(L10_66, CCScale9Sprite:create(L9_65), CCControlStateDisabled)
      end
      L10_66 = "images/public/clarity05.png"
      A0_56[L8_64].btnBg:setBackgroundSpriteForState(CCScale9Sprite:create(L10_66), CCControlStateNormal)
      A0_56[L8_64].btnBg:setBackgroundSpriteForState(CCScale9Sprite:create(L10_66), CCControlStateHighlighted)
      A0_56[L8_64].btnBg:setBackgroundSpriteForState(CCScale9Sprite:create(L10_66), CCControlStateDisabled)
    end
  end
  if L4_60 then
    L4_60(L5_61)
    return
  end
  L7_63 = "Talisman"
  L7_63 = L4_60
  L7_63 = L6_62
  L8_64 = "Talisman"
  L7_63 = L6_62
  L8_64 = L4_60
  if L6_62 == -1 then
    return
  end
  L7_63 = A0_56.prgTest
  L8_64 = L7_63
  L7_63 = L7_63.setVisible
  L9_65 = true
  L10_66 = true
  L7_63(L8_64, L9_65, L10_66)
  L7_63 = A0_56.prgTest
  L8_64 = L7_63
  L7_63 = L7_63.setValue
  L9_65 = L4_60.exp
  L9_65 = 100 * L9_65
  L9_65 = L9_65 / L6_62
  L10_66 = false
  L7_63(L8_64, L9_65, L10_66, false, 0, 2000)
  L7_63 = Logic
  L8_64 = L7_63
  L7_63 = L7_63.Get
  L9_65 = "Talisman"
  L7_63 = L7_63(L8_64, L9_65)
  L8_64 = L7_63
  L7_63 = L7_63.AllSwallowFabaoExp
  L7_63 = L7_63(L8_64)
  L8_64 = L7_63 / L6_62
  if L8_64 > 1 or L6_62 == -2 then
    L8_64 = A0_56.prgTest
    L9_65 = L8_64
    L8_64 = L8_64.setValue
    L10_66 = 100
    L8_64(L9_65, L10_66, true, false, 0, 2000)
    L8_64 = A0_56.prgTest
    L9_65 = L8_64
    L8_64 = L8_64.twinkleProgress
    L10_66 = true
    L8_64(L9_65, L10_66, 500)
    L8_64 = A0_56.ccbInfoView
    if L8_64 then
      L8_64 = A0_56.ccbInfoView
      L9_65 = L8_64
      L8_64 = L8_64.RefreshInfo
      L10_66 = true
      L8_64(L9_65, L10_66, L5_61)
    end
  else
    L8_64 = A0_56.prgTest
    L9_65 = L8_64
    L8_64 = L8_64.setValue
    L10_66 = L4_60.exp
    L10_66 = L10_66 + L7_63
    L10_66 = 100 * L10_66
    L10_66 = L10_66 / L6_62
    L8_64(L9_65, L10_66, true, false, 0, 2000)
    L8_64 = A0_56.prgTest
    L9_65 = L8_64
    L8_64 = L8_64.twinkleProgress
    L10_66 = true
    L8_64(L9_65, L10_66, 500)
    L8_64 = A0_56.ccbInfoView
    if L8_64 then
      L8_64 = A0_56.ccbInfoView
      L9_65 = L8_64
      L8_64 = L8_64.RefreshInfo
      L10_66 = true
      L8_64(L9_65, L10_66, L5_61)
    end
  end
end
function prototype.onBtnReturn(A0_67)
  Logic:Get("Talisman"):ClearSwallFabaos()
  Logic:Get("Talisman").advanceMode = false
  Logic:Get("Talisman").convertMode = false
  SceneHelper:runWithScene("FabaoHome", A0_67.rootNode)
end
function prototype.SetLv(A0_68, A1_69, A2_70)
  local L3_71
  L3_71 = A0_68.showlevel
  L3_71 = L3_71 + 1
  A0_68.showlevel = L3_71
end
function prototype.onChangeProess(A0_72, A1_73)
  if A0_72.advanceMode then
    A0_72:refreshAdvanceState()
    return
  end
  if A0_72.convertMode then
    A0_72:refreshConvertPreview()
    return
  end
  if A1_73 then
    if Logic:Get("Talisman"):onGetUpgradeExp(A0_72.updateFabao) == -1 then
      return
    end
    if A0_72.prgTest then
      A0_72.prgTest:createProgress(_UPVALUE0_, _UPVALUE1_, _UPVALUE2_)
      if Logic:Get("Talisman"):onGetUpgradeExp(A0_72.updateFabao) == -2 then
        A0_72.prgTest:setValue(100, false, false, 0, 2000)
      elseif A1_73.exp ~= nil and Logic:Get("Talisman"):onGetUpgradeExp(A0_72.updateFabao) > 0 then
        if A0_72.updateSwalls == nil then
          A0_72.prgTest:setValue(100 * A1_73.exp / Logic:Get("Talisman"):onGetUpgradeExp(A0_72.updateFabao), false, false, 0, 2000)
        elseif Logic:Get("Talisman"):AllSwallowFabaoExp() then
          A0_72.prgTest:setVisible(true, true)
          A0_72.prgTest:setValue(100 * A1_73.exp / Logic:Get("Talisman"):onGetUpgradeExp(A0_72.updateFabao), false, false, 0, 2000)
          A0_72.prgTest:setValue(100 * (A1_73.exp + Logic:Get("Talisman"):AllSwallowFabaoExp()) / Logic:Get("Talisman"):onGetUpgradeExp(A0_72.updateFabao), true, false, 0, 2000)
          A0_72.prgTest:twinkleProgress(true, 500)
        end
      end
      A0_72.prgTest:setMoveCallBack(bind(A0_72.SetLv, A0_72))
    end
  end
end
function prototype.onBtnFabao(A0_74)
  Logic:Get("Talisman"):setOpenStyle(true)
  Logic:Get("Talisman"):setCheckState(1)
  SceneHelper:pushScene("FabaoUpgradeSelect", A0_74.rootNode)
end
function prototype.onChangeShowState(A0_75)
  local L1_76, L2_77, L3_78, L4_79
  L1_76 = A0_75.advanceMode
  if L1_76 then
    L2_77 = A0_75
    L1_76 = A0_75.refreshAdvanceState
    L1_76(L2_77)
    return
  end
  L1_76 = A0_75.convertMode
  if L1_76 then
    L2_77 = A0_75
    L1_76 = A0_75.refreshConvertPreview
    L1_76(L2_77)
    return
  end
  L1_76 = Logic
  L2_77 = L1_76
  L1_76 = L1_76.Get
  L3_78 = "Talisman"
  L1_76 = L1_76(L2_77, L3_78)
  L2_77 = L1_76
  L1_76 = L1_76.GetUpgradeFabao
  L1_76 = L1_76(L2_77)
  if L1_76 then
    L2_77 = Logic
    L3_78 = L2_77
    L2_77 = L2_77.Get
    L4_79 = "Talisman"
    L2_77 = L2_77(L3_78, L4_79)
    L3_78 = L2_77
    L2_77 = L2_77.GetNextExpByIdAndlevel
    L4_79 = L1_76.baseId
    L2_77 = L2_77(L3_78, L4_79, L1_76.level)
    L3_78 = Logic
    L4_79 = L3_78
    L3_78 = L3_78.Get
    L3_78 = L3_78(L4_79, "Talisman")
    L4_79 = L3_78
    L3_78 = L3_78.GetSwallFabaos
    L3_78 = L3_78(L4_79)
    A0_75.updateSwalls = L3_78
    L3_78 = Logic
    L4_79 = L3_78
    L3_78 = L3_78.Get
    L3_78 = L3_78(L4_79, "Talisman")
    L4_79 = L3_78
    L3_78 = L3_78.GetNextExpByIdAndlevel
    L3_78 = L3_78(L4_79)
    L4_79 = string
    L4_79 = L4_79.format
    L4_79 = L4_79("%d/%d", L1_76.exp + L3_78, L2_77)
    if L4_79 then
      A0_75.staStatus:setStyle(kCCLabelTTFStyleOutline)
      A0_75.staStatus:setVisible(true)
      A0_75.staStatus:setString(L4_79)
    end
  end
end
function prototype.OnReceiveTheReqFabao(A0_80, A1_81, A2_82)
  local L3_83
  L3_83 = A2_82.content
  if L3_83 then
    L3_83 = A2_82.content
    A0_80.reqfabao = L3_83
  end
end
function prototype.onBtnUpgrade(A0_84)
  local L1_85, L2_86
  L1_85 = A0_84.convertMode
  if L1_85 then
    L2_86 = A0_84
    L1_85 = A0_84.onBtnFabao
    return L1_85(L2_86)
  end
  L1_85 = A0_84.advanceMode
  if L1_85 then
    L1_85 = Prompt
    L2_86 = L1_85
    L1_85 = L1_85.Tip
    L1_85(L2_86, "\232\175\183\231\130\185\229\135\187\230\157\144\230\150\153\228\189\141\230\137\139\229\138\168\233\128\137\230\139\169")
    return
  end
  L1_85 = Logic
  L2_86 = L1_85
  L1_85 = L1_85.Get
  L1_85 = L1_85(L2_86, "Talisman")
  L1_85 = L1_85.localAcceptance
  if L1_85 then
    return
  end
  L1_85 = A0_84.updateFabao
  if L1_85 == nil then
    L1_85 = Prompt
    L2_86 = L1_85
    L1_85 = L1_85.Tip
    L1_85(L2_86, 112042)
    return
  end
  L1_85 = Logic
  L2_86 = L1_85
  L1_85 = L1_85.Get
  L1_85 = L1_85(L2_86, "Talisman")
  L2_86 = L1_85
  L1_85 = L1_85.IsInMaxLevel
  L1_85 = L1_85(L2_86, A0_84.updateFabao)
  if L1_85 then
    L1_85 = A0_84.staStatus
    L2_86 = L1_85
    L1_85 = L1_85.setVisible
    L1_85(L2_86, false)
    L1_85 = Prompt
    L2_86 = L1_85
    L1_85 = L1_85.Tip
    L1_85(L2_86, 112039)
    return
  end
  L1_85 = Logic
  L2_86 = L1_85
  L1_85 = L1_85.Get
  L1_85 = L1_85(L2_86, "Talisman")
  L2_86 = L1_85
  L1_85 = L1_85.GetSwallFabaos
  L1_85 = L1_85(L2_86)
  if L1_85 ~= nil then
    L2_86 = #L1_85
  elseif L2_86 == 0 then
    L2_86 = Prompt
    L2_86 = L2_86.Tip
    L2_86(L2_86, TwGetStr(112041))
    return
  end
  L2_86 = {}
  for _FORV_6_, _FORV_7_ in ipairs(L1_85) do
    if _FORV_7_ and _FORV_7_.id then
      table.insert(L2_86, _FORV_7_.id)
    end
  end
  if L1_85 and A0_84.updateFabao.id then
    A0_84.showlevel = A0_84.updateFabao.level
    MsgTalisman:Post("UPGRADE_TALISMAN", {
      talismanId = A0_84.updateFabao.id,
      talismanIds = L2_86
    })
  end
end
function prototype.onAdvance(A0_87)
  if A0_87.updateFabao == nil then
    Prompt:Tip("\232\175\183\233\128\137\230\139\169\230\169\153\232\137\178\230\179\149\229\174\157")
    return
  end
  if not _UPVALUE0_(A0_87.updateFabao.baseId) then
    Prompt:Tip("\232\175\183\233\128\137\230\139\169\230\169\153\232\137\178\230\179\149\229\174\157")
    return
  end
  if (A0_87.updateFabao.level or 0) < 10 then
    Prompt:Tip("\230\169\153\232\137\178\230\179\149\229\174\157\232\190\190\229\136\17610\231\186\167\229\144\142\230\137\141\232\131\189\232\191\155\233\152\182")
    return
  end
  if A0_87:getAdvanceProgress() < A0_87:getAdvanceProgress() then
    Prompt:Tip("\232\191\155\229\186\166\230\156\170\230\187\161")
    return
  end
  A0_87:RunAdvanceAni()
end
function prototype.completeLocalConvert(A0_88)
  local L1_89, L2_90, L3_91, L4_92, L5_93, L6_94, L7_95, L8_96, L9_97
  L1_89 = Logic
  L2_90 = L1_89
  L1_89 = L1_89.Get
  L3_91 = "Talisman"
  L1_89 = L1_89(L2_90, L3_91)
  L2_90 = A0_88.updateFabao
  L3_91 = L2_90 and L3_91(L4_92)
  L4_92 = L1_89.localAcceptance
  if L4_92 and L2_90 and L3_91 then
    L4_92 = L2_90.isOld
  elseif L4_92 ~= true then
    L4_92 = nil
    return L4_92
  end
  L4_92 = {}
  for L8_96, L9_97 in L5_93(L6_94) do
    if #L4_92 < 2 and L9_97.id ~= L2_90.id and L9_97.isOld == true and L9_97.family == L2_90.family and L9_97.quality == "orange" then
      table.insert(L4_92, L9_97)
    end
  end
  if L5_93 < 2 then
    L5_93(L6_94, L7_95)
    return L5_93
  end
  for L8_96, L9_97 in L5_93(L6_94) do
    L1_89:UpDataTailsmans_Dele(L9_97.id)
  end
  L5_93.id = L6_94
  L5_93.baseId = L6_94
  L5_93.sourceBaseId = L6_94
  L5_93.sourceQuality = L6_94
  L5_93.displayBaseId = L6_94
  L5_93.name = L6_94
  L5_93.family = L6_94
  L5_93.isOld = false
  L5_93.quality = L6_94
  L5_93.statMultiplier = L6_94
  L5_93.level = L6_94
  L5_93.exp = L6_94
  L6_94 = L6_94 == true
  L5_93.advanced = L6_94
  L5_93.immuneCounter = true
  L8_96 = L5_93
  L6_94(L7_95, L8_96)
  L1_89.convertMode = false
  L1_89.advanceMode = false
  L6_94(L7_95)
  A0_88.updateFabao = L5_93
  A0_88.convertMode = false
  A0_88.localConvertResult = L5_93
  return L5_93
end
function prototype.onConvert(A0_98)
  local L1_99, L2_100, L3_101
  L1_99 = A0_98.updateFabao
  L2_100 = L1_99 and L2_100(L3_101)
  if L1_99 and L2_100 then
    L3_101 = L1_99.isOld
  elseif L3_101 ~= true then
    L3_101 = Prompt
    L3_101 = L3_101.Tip
    L3_101(L3_101, "\232\175\183\233\128\137\230\139\169\230\151\167\230\179\149\229\174\157")
    return
  end
  L3_101 = A0_98.completeLocalConvert
  L3_101 = L3_101(A0_98)
  if L3_101 then
    A0_98:showLocalConvertResult(L3_101)
  end
end
function prototype.onChangeUpdateState(A0_102, A1_103)
  if A1_103 == nil then
    return
  end
  A0_102.updateFabao = A1_103
  A0_102.updateSwalls = nil
  A0_102:onChangeShowState()
  A0_102:clearccbstate()
  A0_102.ccbInfoView:RefreshInfo(false)
  A0_102:RunAni()
end
function prototype.clearccbstate(A0_104)
  local L1_105, L2_106, L3_107, L4_108, L5_109, L6_110, L7_111
  for L4_108 = 1, L2_106.MAXSWALLOW_NUM do
    L5_109 = string
    L5_109 = L5_109.format
    L6_110 = "ccbFabao%d"
    L7_111 = L4_108
    L5_109 = L5_109(L6_110, L7_111)
    L6_110 = A0_104[L5_109]
    L6_110 = L6_110.btnFabao
    L7_111 = L6_110
    L6_110 = L6_110.setEnabled
    L6_110(L7_111, true)
    L6_110 = A0_104[L5_109]
    L6_110 = L6_110.btnBg
    L7_111 = L6_110
    L6_110 = L6_110.setVisible
    L6_110(L7_111, true)
    L6_110 = A0_104[L5_109]
    L6_110 = L6_110.imgAdd
    L7_111 = L6_110
    L6_110 = L6_110.setVisible
    L6_110(L7_111, true)
    L6_110 = "images/public/clarity05.png"
    if L6_110 then
      L7_111 = A0_104[L5_109]
      L7_111 = L7_111.btnFabao
      L7_111 = L7_111.setBackgroundSpriteForState
      L7_111(L7_111, CCScale9Sprite:create(L6_110), CCControlStateNormal)
      L7_111 = A0_104[L5_109]
      L7_111 = L7_111.btnFabao
      L7_111 = L7_111.setBackgroundSpriteForState
      L7_111(L7_111, CCScale9Sprite:create(L6_110), CCControlStateHighlighted)
      L7_111 = A0_104[L5_109]
      L7_111 = L7_111.btnFabao
      L7_111 = L7_111.setBackgroundSpriteForState
      L7_111(L7_111, CCScale9Sprite:create(L6_110), CCControlStateDisabled)
    end
    L7_111 = "images/public/clarity05.png"
    A0_104[L5_109].btnBg:setBackgroundSpriteForState(CCScale9Sprite:create(L7_111), CCControlStateNormal)
    A0_104[L5_109].btnBg:setBackgroundSpriteForState(CCScale9Sprite:create(L7_111), CCControlStateHighlighted)
    A0_104[L5_109].btnBg:setBackgroundSpriteForState(CCScale9Sprite:create(L7_111), CCControlStateDisabled)
  end
end
function prototype.filterUpdateFabao(A0_112)
  local L1_113, L2_114, L3_115, L4_116, L5_117, L6_118, L7_119
  L1_113 = {}
  L2_114 = Logic
  L2_114 = L2_114.Get
  L2_114 = L2_114(L3_115, L4_116)
  L2_114 = L2_114.canSwallFabao
  L2_114 = L2_114(L3_115)
  if L2_114 then
    if L3_115 == 0 then
      L6_118 = 112041
      L7_119 = L5_117(L6_118)
      L3_115(L4_116, L5_117, L6_118, L7_119, L5_117(L6_118))
      return L1_113
    end
  end
  for L6_118, L7_119 in L3_115(L4_116) do
    if L7_119.level < 2 and KFDBGetRecord("TalismanSetting", L7_119.baseId) and 2 >= Logic:Get("Hero"):GetHeroInfoByBaseId(KFDBGetRecord("TalismanSetting", L7_119.baseId).baseId).rank then
      table.insert(L1_113, L7_119)
    end
  end
  return L1_113
end
function prototype.autoSelectAdvanceMaterials(A0_120)
  local L1_121, L2_122, L3_123, L4_124, L5_125, L6_126, L7_127, L8_128, L9_129, L10_130, L11_131
  L1_121 = A0_120.updateFabao
  if L1_121 == nil then
    L2_122 = Prompt
    L3_123 = L2_122
    L2_122 = L2_122.Tip
    L4_124 = "\232\175\183\233\128\137\230\139\169\230\169\153\232\137\178\230\179\149\229\174\157"
    L2_122(L3_123, L4_124)
    return
  end
  L2_122 = _UPVALUE0_
  L3_123 = L1_121.baseId
  L2_122 = L2_122(L3_123)
  if L2_122 == nil then
    L3_123 = Prompt
    L4_124 = L3_123
    L3_123 = L3_123.Tip
    L5_125 = "\232\175\183\233\128\137\230\139\169\230\169\153\232\137\178\230\179\149\229\174\157"
    L3_123(L4_124, L5_125)
    return
  end
  L3_123 = L2_122.progress
  L4_124 = {}
  L5_125 = 0
  L6_126 = Logic
  L6_126 = L6_126.Get
  L6_126 = L6_126(L7_127, L8_128)
  L6_126 = L6_126.canSwallFabao
  L6_126 = L6_126(L7_127)
  L6_126 = L6_126 or {}
  if L7_127 then
    L7_127(L8_128, L9_129)
  end
  for L10_130, L11_131 in L7_127(L8_128) do
    if #L4_124 >= Logic.Talisman.MAXSWALLOW_NUM then
      break
    end
    if _UPVALUE1_(L11_131) > 0 then
      table.insert(L4_124, L11_131)
      L5_125 = L5_125 + _UPVALUE1_(L11_131)
      if L3_123 <= L5_125 then
        break
      end
    end
  end
  L7_127(L8_128, L9_129)
  L7_127(L8_128)
end
function prototype.onBtnAutoSwall(A0_132)
  local L1_133, L2_134, L3_135, L4_136, L5_137, L6_138, L7_139, L8_140, L9_141, L10_142, L11_143, L12_144, L13_145
  L1_133 = A0_132.convertMode
  if L1_133 then
    L2_134 = A0_132
    L1_133 = A0_132.onConvert
    return L1_133(L2_134)
  end
  L1_133 = A0_132.advanceMode
  if L1_133 then
    L2_134 = A0_132
    L1_133 = A0_132.onAdvance
    return L1_133(L2_134)
  end
  L1_133 = Logic
  L2_134 = L1_133
  L1_133 = L1_133.Get
  L3_135 = "Talisman"
  L1_133 = L1_133(L2_134, L3_135)
  L2_134 = L1_133
  L1_133 = L1_133.GetUpgradeFabao
  L1_133 = L1_133(L2_134)
  if L1_133 == nil then
    L2_134 = Prompt
    L3_135 = L2_134
    L2_134 = L2_134.Tip
    L4_136 = 112042
    L2_134(L3_135, L4_136)
    return
  end
  L2_134 = Logic
  L3_135 = L2_134
  L2_134 = L2_134.Get
  L4_136 = "Talisman"
  L2_134 = L2_134(L3_135, L4_136)
  L3_135 = L2_134
  L2_134 = L2_134.GetSwallFabaos
  L2_134 = L2_134(L3_135)
  if L2_134 then
    L3_135 = #L2_134
    if L3_135 == 6 then
      L3_135 = Prompt
      L4_136 = L3_135
      L3_135 = L3_135.Tip
      L13_145 = L5_137(L6_138)
      L3_135(L4_136, L5_137, L6_138, L7_139, L8_140, L9_141, L10_142, L11_143, L12_144, L13_145, L5_137(L6_138))
      return
    end
  end
  L3_135 = Logic
  L4_136 = L3_135
  L3_135 = L3_135.Get
  L3_135 = L3_135(L4_136, L5_137)
  L4_136 = L3_135
  L3_135 = L3_135.upgradeFabaoFullExp
  L3_135 = L3_135(L4_136, L5_137)
  if L3_135 == 0 then
    L4_136 = Prompt
    L4_136 = L4_136.Tip
    L4_136(L5_137, L6_138)
    return
  end
  L4_136 = 0
  if L2_134 then
    if not L5_137 then
      for L8_140, L9_141 in L5_137(L6_138) do
        L12_144 = "Talisman"
        L12_144 = L9_141
        L4_136 = L4_136 + L10_142
      end
    end
  end
  if L3_135 ~= 0 and L3_135 <= L4_136 then
    L8_140 = 104164
    L13_145 = L7_139(L8_140)
    L5_137(L6_138, L7_139, L8_140, L9_141, L10_142, L11_143, L12_144, L13_145, L7_139(L8_140))
    return
  end
  L8_140 = {}
  if L2_134 then
    if not L9_141 then
      for L12_144, L13_145 in L9_141(L10_142) do
        L7_139[L13_145.id] = 1
        L8_140[L12_144] = L13_145
      end
    end
  end
  if L5_137 then
    if not L9_141 then
      for L12_144, L13_145 in L9_141(L10_142) do
        if not L7_139[L13_145.id] then
          L7_139[L13_145.id] = 1
          L8_140[#L8_140 + 1] = L13_145
        end
        L4_136 = L4_136 + Logic:Get("Talisman"):getOneFabaoSwallExp(L13_145)
        if L3_135 <= L4_136 then
          break
        end
        if L6_138 == 6 then
          break
        end
      end
    end
  end
  if L8_140 then
    if not L9_141 then
      L9_141(L10_142, L11_143)
      L9_141(L10_142)
    end
  else
    L12_144 = 112053
    L13_145 = L11_143(L12_144)
    L9_141(L10_142, L11_143, L12_144, L13_145, L11_143(L12_144))
  end
end
function prototype.completeLocalAdvance(A0_146)
  local L1_147, L2_148, L3_149, L4_150, L5_151, L6_152, L7_153
  L1_147 = Logic
  L2_148 = L1_147
  L1_147 = L1_147.Get
  L3_149 = "Talisman"
  L1_147 = L1_147(L2_148, L3_149)
  L2_148 = L1_147.localAcceptance
  if L2_148 then
    L2_148 = A0_146.localAdvanceCompleted
  elseif L2_148 then
    L2_148 = A0_146.localAdvanceResult
    return L2_148
  end
  L2_148 = A0_146.updateFabao
  L3_149 = L2_148 and L3_149(L4_150)
  if not L3_149 then
    return
  end
  L5_151 = A0_146
  L4_150 = A0_146.getAdvanceProgress
  L5_151 = L4_150(L5_151)
  if L4_150 < L5_151 then
    return
  end
  L6_152 = _UPVALUE1_
  L6_152 = L6_152.GetLocalFabaoSpec
  L7_153 = L2_148.baseId
  L6_152 = L6_152(L7_153)
  L7_153 = {}
  L7_153.id = L2_148.id
  L7_153.baseId = L2_148.baseId
  L7_153.sourceBaseId = L2_148.baseId
  L7_153.redBaseId = L3_149.displayBaseId
  L7_153.displayBaseId = L6_152 and L6_152.displayBaseId or L3_149.displayBaseId
  L7_153.name = L6_152 and L6_152.displayName or L3_149.name
  L7_153.family = L2_148.family
  L7_153.isOld = L2_148.isOld
  L7_153.quality = "red"
  L7_153.statMultiplier = 1.5
  L7_153.immuneCounter = L2_148.immuneCounter == true
  L7_153.redStar = 1
  L7_153.level = 1
  L7_153.exp = 0
  L7_153.advanced = true
  for _FORV_11_, _FORV_12_ in ipairs(L1_147:GetSwallFabaos() or {}) do
    if _FORV_12_ and _FORV_12_.id then
      L1_147:UpDataTailsmans_Dele(_FORV_12_.id)
    end
  end
  L1_147:UpDataTailsmans(L7_153)
  L1_147.advanceMode = false
  L1_147.upgradeFabao = L7_153
  L1_147:ClearSwallFabaos()
  A0_146.updateFabao = L7_153
  A0_146.updateSwalls = {}
  A0_146.advanceMode = false
  A0_146.localAdvanceResult = L7_153
  A0_146.localAdvanceCompleted = true
  return L7_153
end
function prototype.hideAdvanceAnimationStats(A0_154)
  local L1_155, L2_156, L3_157, L4_158, L5_159, L6_160
  L1_155 = A0_154.ani
  if not L1_155 then
    return
  end
  L1_155 = {
    L2_156,
    L3_157,
    L4_158,
    L5_159,
    L6_160,
    "staLife",
    "imgBg1",
    "imgBg2",
    "imgBg3"
  }
  L5_159 = "staAttack"
  L6_160 = "imgLifeTip"
  for L5_159, L6_160 in L2_156(L3_157) do
    if A0_154.ani:GetChild(L6_160) then
      A0_154.ani:GetChild(L6_160):setVisible(false)
    end
  end
end
function prototype.showLocalAdvanceResult(A0_161, A1_162)
  local L2_163, L3_164
  if not A1_162 then
    return
  end
  L3_164 = A0_161
  L2_163 = A0_161.removeAdvanceNode
  L2_163(L3_164, _UPVALUE0_)
  L3_164 = A0_161
  L2_163 = A0_161.removeAdvanceNode
  L2_163(L3_164, _UPVALUE1_)
  L3_164 = A0_161
  L2_163 = A0_161.removeAdvanceNode
  L2_163(L3_164, _UPVALUE2_)
  L3_164 = A0_161
  L2_163 = A0_161.removeAdvanceNode
  L2_163(L3_164, _UPVALUE3_)
  L3_164 = A0_161
  L2_163 = A0_161.removeAdvanceNode
  L2_163(L3_164, _UPVALUE4_)
  L2_163 = A0_161.ccbInfoView
  if L2_163 then
    L2_163 = A0_161.ccbInfoView
    L3_164 = L2_163
    L2_163 = L2_163.setVisible
    L2_163(L3_164, false)
  end
  L2_163 = A0_161.prgTest
  if L2_163 then
    L2_163 = A0_161.prgTest
    L3_164 = L2_163
    L2_163 = L2_163.setVisible
    L2_163(L3_164, false)
  end
  L2_163 = A0_161.staStatus
  if L2_163 then
    L2_163 = A0_161.staStatus
    L3_164 = L2_163
    L2_163 = L2_163.setVisible
    L2_163(L3_164, true)
    L2_163 = A0_161.staStatus
    L3_164 = L2_163
    L2_163 = L2_163.setString
    L2_163(L3_164, "\229\183\178\232\191\155\233\152\182\239\188\154\231\186\162\232\137\1781\230\152\159")
  end
  L2_163 = A0_161.advanceOriginalBtnPosition
  if L2_163 then
    L2_163 = A0_161.btnFabao
    L3_164 = L2_163
    L2_163 = L2_163.setPosition
    L2_163(L3_164, A0_161.advanceOriginalBtnPosition)
  end
  L2_163 = A0_161.btnFabao
  L3_164 = L2_163
  L2_163 = L2_163.getChildByTag
  L2_163 = L2_163(L3_164, 0)
  if L2_163 then
    L3_164 = A0_161.btnFabao
    L3_164 = L3_164.removeChild
    L3_164(L3_164, L2_163, true)
  end
  L3_164 = Logic
  L3_164 = L3_164.Get
  L3_164 = L3_164(L3_164, "HeroCardInfo")
  L3_164 = L3_164.createHeroCard
  L3_164 = L3_164(L3_164, A1_162.displayBaseId or A1_162.redBaseId, 200)
  if L3_164 then
    A0_161.btnFabao:addChild(L3_164, 0, 0)
    L3_164:setPosition(ccp(A0_161.btnFabao:getContentSize().width / 2, A0_161.btnFabao:getContentSize().height / 2))
  end
  A0_161:setButtonTitle(A0_161.btnFabao, "\231\186\162\232\137\178\230\179\149\229\174\157")
  A0_161:setButtonTitle(A0_161.btnUpgrade, "\230\179\149\229\174\157\229\141\135\231\186\167")
  A0_161:setButtonTitle(A0_161.btnAutoSwall, "\232\135\170\229\138\168\231\173\155\233\128\137")
  A0_161.btnUpgrade:setEnabled(false)
  A0_161.btnAutoSwall:setEnabled(false)
end
function prototype.showLocalConvertResult(A0_165, A1_166)
  local L2_167, L3_168
  if not A1_166 then
    return
  end
  L3_168 = A0_165
  L2_167 = A0_165.removeAdvanceNode
  L2_167(L3_168, _UPVALUE0_)
  L3_168 = A0_165
  L2_167 = A0_165.removeAdvanceNode
  L2_167(L3_168, _UPVALUE1_)
  L3_168 = A0_165
  L2_167 = A0_165.removeAdvanceNode
  L2_167(L3_168, _UPVALUE2_)
  L3_168 = A0_165
  L2_167 = A0_165.removeAdvanceNode
  L2_167(L3_168, _UPVALUE3_)
  L3_168 = A0_165
  L2_167 = A0_165.removeAdvanceNode
  L2_167(L3_168, _UPVALUE4_)
  L2_167 = A0_165.ccbInfoView
  if L2_167 then
    L2_167 = A0_165.ccbInfoView
    L3_168 = L2_167
    L2_167 = L2_167.setVisible
    L2_167(L3_168, false)
  end
  L2_167 = A0_165.btnFabao
  L3_168 = L2_167
  L2_167 = L2_167.getChildByTag
  L2_167 = L2_167(L3_168, 0)
  if L2_167 then
    L3_168 = A0_165.btnFabao
    L3_168 = L3_168.removeChild
    L3_168(L3_168, L2_167, true)
  end
  L3_168 = Logic
  L3_168 = L3_168.Get
  L3_168 = L3_168(L3_168, "HeroCardInfo")
  L3_168 = L3_168.createHeroCard
  L3_168 = L3_168(L3_168, A1_166.displayBaseId, 200)
  if L3_168 then
    A0_165.btnFabao:addChild(L3_168, 0, 0)
    L3_168:setPosition(ccp(A0_165.btnFabao:getContentSize().width / 2, A0_165.btnFabao:getContentSize().height / 2))
  end
  A0_165:setButtonTitle(A0_165.btnFabao, "\229\183\178\232\189\172\230\141\162\239\188\154" .. tostring(A1_166.name or "\230\150\176\230\179\149\229\174\157"))
  A0_165:setButtonTitle(A0_165.btnUpgrade, "\230\179\149\229\174\157\232\191\155\233\152\182")
  A0_165:setButtonTitle(A0_165.btnAutoSwall, "\230\179\149\229\174\157\232\189\172\230\141\162")
  A0_165.btnUpgrade:setEnabled(false)
  A0_165.btnAutoSwall:setEnabled(false)
  if A0_165.staStatus then
    A0_165.staStatus:setVisible(true)
    A0_165.staStatus:setString("\232\189\172\230\141\162\230\136\144\229\138\159\239\188\154" .. tostring(A1_166.name or "\230\150\176\230\179\149\229\174\157"))
  end
end
function prototype.RunAdvanceAni(A0_169)
  local L1_170, L2_171, L3_172, L4_173, L5_174, L6_175, L7_176, L8_177
  L1_170 = SceneHelper
  L2_171 = L1_170
  L1_170 = L1_170.getRootLayer
  L1_170 = L1_170(L2_171)
  L2_171 = Logic
  L3_172 = L2_171
  L2_171 = L2_171.Get
  L4_173 = "AniMgr"
  L2_171 = L2_171(L3_172, L4_173)
  L3_172 = L2_171
  L2_171 = L2_171.NewCCB
  L4_173 = "UI/uiyxsj"
  L2_171 = L2_171(L3_172, L4_173, L5_174, L6_175, L7_176)
  A0_169.ani = L2_171
  A0_169.localAdvanceCompleted = false
  A0_169.localAdvanceResult = nil
  L2_171 = _UPVALUE0_
  L3_172 = A0_169.updateFabao
  L3_172 = L3_172.baseId
  L2_171 = L2_171(L3_172)
  function L3_172(A0_178, A1_179)
    local L2_180, L3_181, L4_182, L5_183, L6_184, L7_185, L8_186
    L2_180 = _UPVALUE0_
    L2_180 = L2_180.ani
    L3_181 = L2_180
    L2_180 = L2_180.GetChild
    L4_182 = A0_178
    L2_180 = L2_180(L3_181, L4_182)
    if L2_180 == nil then
      return
    end
    L3_181 = Logic
    L4_182 = L3_181
    L3_181 = L3_181.Get
    L5_183 = "HeroCardInfo"
    L3_181 = L3_181(L4_182, L5_183)
    L4_182 = L3_181
    L3_181 = L3_181.createHeroCardForByFight
    L5_183 = A1_179
    L6_184 = true
    L3_181 = L3_181(L4_182, L5_183, L6_184)
    if not L3_181 then
      L3_181 = Logic
      L4_182 = L3_181
      L3_181 = L3_181.Get
      L5_183 = "HeroCardInfo"
      L3_181 = L3_181(L4_182, L5_183)
      L4_182 = L3_181
      L3_181 = L3_181.createHeroCard
      L5_183 = A1_179
      L6_184 = 200
      L3_181 = L3_181(L4_182, L5_183, L6_184)
    end
    if L3_181 then
      L4_182 = Logic
      L5_183 = L4_182
      L4_182 = L4_182.Get
      L6_184 = "HeroCardInfo"
      L4_182 = L4_182(L5_183, L6_184)
      L5_183 = L4_182
      L4_182 = L4_182.GetCardTexture
      L6_184 = L3_181
      L8_186 = L2_180
      L7_185 = L2_180.getContentSize
      L8_186 = L7_185(L8_186)
      L5_183 = L4_182(L5_183, L6_184, L7_185, L8_186)
      L7_185 = L2_180
      L6_184 = L2_180.setTexture
      L8_186 = L4_182
      L6_184(L7_185, L8_186)
      L7_185 = L2_180
      L6_184 = L2_180.setTextureRect
      L8_186 = L5_183
      L6_184(L7_185, L8_186)
    end
  end
  L4_173 = KFDBGetRecord
  L4_173 = L4_173(L5_174, L6_175)
  if L4_173 then
  else
  end
  L5_174(L6_175, L7_176)
  L5_174(L6_175, L7_176)
  for L8_177 = 1, 6 do
    if A0_169.ani:GetChild(string.format("imgHero%d", L8_177)) then
      A0_169.ani:GetChild(string.format("imgHero%d", L8_177)):setVisible(false)
    end
  end
  L5_174(L6_175)
  L8_177 = A0_169.onBtnCloseAdvanceAni
  L5_174(L6_175, L7_176, L8_177)
  L5_174(L6_175, L7_176)
  L8_177 = 3500
  L5_174(L6_175, L7_176, L8_177)
  L5_174(L6_175)
end
function prototype.onBtnCloseAdvanceAni(A0_187)
  if not A0_187.localAdvanceCompleted then
    A0_187:completeLocalAdvance()
  end
  if A0_187.ani then
    A0_187.ani:RemoveAnimation()
  end
  Logic:Get("BGSound"):stopAllEffect()
  Logic:Get("BGSound"):PlayBGMusic()
  if A0_187.localAdvanceResult then
    A0_187:showLocalAdvanceResult(A0_187.localAdvanceResult)
  else
    Logic:Get("Talisman"):ClearSwallFabaos()
    A0_187:refreshAdvanceState()
  end
end
function prototype.RunAni(A0_188)
  local L1_189, L2_190, L3_191, L4_192, L5_193, L6_194, L7_195, L8_196, L9_197, L10_198, L11_199, L12_200, L13_201, L14_202, L15_203, L16_204
  L1_189 = Logic
  L2_190 = L1_189
  L1_189 = L1_189.Get
  L3_191 = "System"
  L1_189 = L1_189(L2_190, L3_191)
  L2_190 = L1_189
  L1_189 = L1_189.IsUpgradeAniEnabled
  L1_189 = L1_189(L2_190)
  if not L1_189 then
    L2_190 = A0_188
    L1_189 = A0_188.onBtnCloseAni
    L1_189(L2_190)
    return
  end
  L1_189 = SceneHelper
  L2_190 = L1_189
  L1_189 = L1_189.getRootLayer
  L1_189 = L1_189(L2_190)
  L2_190 = Logic
  L3_191 = L2_190
  L2_190 = L2_190.Get
  L4_192 = "AniMgr"
  L2_190 = L2_190(L3_191, L4_192)
  L3_191 = L2_190
  L2_190 = L2_190.NewCCB
  L4_192 = "UI/uiyxsj"
  L5_193 = L1_189
  L6_194 = nil
  L7_195 = 1
  L2_190 = L2_190(L3_191, L4_192, L5_193, L6_194, L7_195)
  A0_188.ani = L2_190
  L3_191 = A0_188
  L2_190 = A0_188.AniSetVisible
  L4_192 = false
  L2_190(L3_191, L4_192)
  L2_190 = Logic
  L3_191 = L2_190
  L2_190 = L2_190.Get
  L4_192 = "Talisman"
  L2_190 = L2_190(L3_191, L4_192)
  L3_191 = L2_190
  L2_190 = L2_190.GetBeforeUpdate
  L2_190 = L2_190(L3_191)
  L3_191 = Logic
  L4_192 = L3_191
  L3_191 = L3_191.Get
  L5_193 = "Talisman"
  L3_191 = L3_191(L4_192, L5_193)
  L4_192 = L3_191
  L3_191 = L3_191.GetInfoByBaseId
  L5_193 = L2_190.baseId
  L3_191 = L3_191(L4_192, L5_193)
  L4_192 = Logic
  L5_193 = L4_192
  L4_192 = L4_192.Get
  L6_194 = "Talisman"
  L4_192 = L4_192(L5_193, L6_194)
  L5_193 = L4_192
  L4_192 = L4_192.GetUpgradeFabao
  L4_192 = L4_192(L5_193)
  L5_193 = L2_190.level
  A0_188.bgLv = L5_193
  L5_193 = Logic
  L6_194 = L5_193
  L5_193 = L5_193.Get
  L7_195 = "HeroCardInfo"
  L5_193 = L5_193(L6_194, L7_195)
  L6_194 = L5_193
  L5_193 = L5_193.createHeroCardForByFight
  L7_195 = L3_191.baseId
  L8_196 = true
  L5_193 = L5_193(L6_194, L7_195, L8_196)
  L6_194 = Logic
  L7_195 = L6_194
  L6_194 = L6_194.Get
  L8_196 = "HeroCardInfo"
  L6_194 = L6_194(L7_195, L8_196)
  L7_195 = L6_194
  L6_194 = L6_194.GetCardTexture
  L8_196 = L5_193
  L16_204 = L9_197(L10_198)
  L7_195 = L6_194(L7_195, L8_196, L9_197, L10_198, L11_199, L12_200, L13_201, L14_202, L15_203, L16_204, L9_197(L10_198))
  L8_196 = A0_188.ani
  L8_196 = L8_196.GetChild
  L8_196 = L8_196(L9_197, L10_198)
  L8_196 = L8_196.setTexture
  L8_196(L9_197, L10_198)
  L8_196 = A0_188.ani
  L8_196 = L8_196.GetChild
  L8_196 = L8_196(L9_197, L10_198)
  L8_196 = L8_196.setTextureRect
  L8_196(L9_197, L10_198)
  L8_196 = Logic
  L8_196 = L8_196.Get
  L8_196 = L8_196(L9_197, L10_198)
  L8_196 = L8_196.GetSwallFabaos
  L8_196 = L8_196(L9_197)
  for L12_200 = 1, 6 do
    L13_201 = string
    L13_201 = L13_201.format
    L14_202 = "imgHero%d"
    L15_203 = L12_200
    L13_201 = L13_201(L14_202, L15_203)
    L14_202 = L8_196[L12_200]
    if L14_202 then
      L14_202 = A0_188.ani
      L15_203 = L14_202
      L14_202 = L14_202.GetChild
      L16_204 = L13_201
      L14_202 = L14_202(L15_203, L16_204)
      L15_203 = L14_202
      L14_202 = L14_202.setVisible
      L16_204 = true
      L14_202(L15_203, L16_204)
      L14_202 = Logic
      L15_203 = L14_202
      L14_202 = L14_202.Get
      L16_204 = "Talisman"
      L14_202 = L14_202(L15_203, L16_204)
      L15_203 = L14_202
      L14_202 = L14_202.GetInfoByBaseId
      L16_204 = L8_196[L12_200]
      L16_204 = L16_204.baseId
      L14_202 = L14_202(L15_203, L16_204)
      L3_191 = L14_202
      L14_202 = Logic
      L15_203 = L14_202
      L14_202 = L14_202.Get
      L16_204 = "HeroCardInfo"
      L14_202 = L14_202(L15_203, L16_204)
      L15_203 = L14_202
      L14_202 = L14_202.createHeroCardForByFight
      L16_204 = L3_191.baseId
      L14_202 = L14_202(L15_203, L16_204, true)
      L15_203 = Logic
      L16_204 = L15_203
      L15_203 = L15_203.Get
      L15_203 = L15_203(L16_204, "HeroCardInfo")
      L16_204 = L15_203
      L15_203 = L15_203.GetCardTexture
      L16_204 = L15_203(L16_204, L14_202, A0_188.ani:GetChild(L13_201):getContentSize())
      A0_188.ani:GetChild(L13_201):setTexture(L15_203)
      A0_188.ani:GetChild(L13_201):setTextureRect(L16_204)
    else
      L14_202 = A0_188.ani
      L15_203 = L14_202
      L14_202 = L14_202.GetChild
      L16_204 = L13_201
      L14_202 = L14_202(L15_203, L16_204)
      L15_203 = L14_202
      L14_202 = L14_202.setVisible
      L16_204 = false
      L14_202(L15_203, L16_204)
    end
  end
  L3_191 = L9_197
  L12_200 = true
  L12_200 = "HeroCardInfo"
  L12_200 = L9_197
  L14_202 = L9_197
  L13_201 = L9_197.getContentSize
  L16_204 = L13_201(L14_202)
  L12_200 = A0_188.ani
  L13_201 = L12_200
  L12_200 = L12_200.GetChild
  L14_202 = "imgOut"
  L12_200 = L12_200(L13_201, L14_202)
  L13_201 = L12_200
  L12_200 = L12_200.setTexture
  L14_202 = L10_198
  L12_200(L13_201, L14_202)
  L12_200 = A0_188.ani
  L13_201 = L12_200
  L12_200 = L12_200.GetChild
  L14_202 = "imgOut"
  L12_200 = L12_200(L13_201, L14_202)
  L13_201 = L12_200
  L12_200 = L12_200.setTextureRect
  L14_202 = L11_199
  L12_200(L13_201, L14_202)
  L12_200 = A0_188.ani
  L13_201 = L12_200
  L12_200 = L12_200.SetCloseCallback
  L14_202 = A0_188
  L15_203 = A0_188.onBtnCloseAni
  L12_200(L13_201, L14_202, L15_203)
  L12_200 = A0_188.ani
  L13_201 = L12_200
  L12_200 = L12_200.GetChild
  L14_202 = "btnClose"
  L12_200 = L12_200(L13_201, L14_202)
  L13_201 = L12_200
  L12_200 = L12_200.setEnabled
  L14_202 = false
  L12_200(L13_201, L14_202)
  L12_200 = A0_188.ani
  L13_201 = L12_200
  L12_200 = L12_200.SetWaitSignByDefaultAniName
  function L14_202()
    local L0_205, L1_206, L2_207, L3_208, L4_209, L5_210, L6_211, L7_212
    L0_205 = _UPVALUE0_
    L0_205 = L0_205.ani
    L1_206 = L0_205
    L0_205 = L0_205.GetChild
    L2_207 = "btnClose"
    L0_205 = L0_205(L1_206, L2_207)
    L1_206 = L0_205
    L0_205 = L0_205.setEnabled
    L2_207 = false
    L0_205(L1_206, L2_207)
    L0_205 = Logic
    L1_206 = L0_205
    L0_205 = L0_205.Get
    L2_207 = "BGSound"
    L0_205 = L0_205(L1_206, L2_207)
    L1_206 = L0_205
    L0_205 = L0_205.PlayEffect
    L2_207 = "audio/heroupgrade.mp3"
    L0_205(L1_206, L2_207)
    L0_205 = _UPVALUE0_
    L0_205 = L0_205.ani
    L1_206 = L0_205
    L0_205 = L0_205.GetChild
    L2_207 = "prgExp"
    L0_205 = L0_205(L1_206, L2_207)
    L1_206 = L0_205
    L0_205 = L0_205.createProgress
    L2_207 = _UPVALUE1_
    L3_208 = _UPVALUE2_
    L0_205(L1_206, L2_207, L3_208)
    L0_205 = _UPVALUE0_
    L1_206 = L0_205
    L0_205 = L0_205.AniSetVisible
    L2_207 = true
    L0_205(L1_206, L2_207)
    L0_205 = _UPVALUE0_
    L0_205 = L0_205.ani
    L1_206 = L0_205
    L0_205 = L0_205.GetChild
    L2_207 = "imgGai"
    L0_205 = L0_205(L1_206, L2_207)
    L1_206 = L0_205
    L0_205 = L0_205.setVisible
    L2_207 = false
    L0_205(L1_206, L2_207)
    L0_205 = _UPVALUE0_
    L0_205 = L0_205.ani
    L1_206 = L0_205
    L0_205 = L0_205.GetChild
    L2_207 = "imgBody"
    L0_205 = L0_205(L1_206, L2_207)
    L1_206 = L0_205
    L0_205 = L0_205.setVisible
    L2_207 = false
    L0_205(L1_206, L2_207)
    L0_205 = Logic
    L1_206 = L0_205
    L0_205 = L0_205.Get
    L2_207 = "Talisman"
    L0_205 = L0_205(L1_206, L2_207)
    L1_206 = L0_205
    L0_205 = L0_205.GetNextExpByIdAndlevel
    L2_207 = _UPVALUE3_
    L2_207 = L2_207.baseId
    L3_208 = _UPVALUE3_
    L3_208 = L3_208.level
    L0_205 = L0_205(L1_206, L2_207, L3_208)
    L1_206 = _UPVALUE0_
    L1_206 = L1_206.ani
    L2_207 = L1_206
    L1_206 = L1_206.GetChild
    L3_208 = "prgExp"
    L1_206 = L1_206(L2_207, L3_208)
    L2_207 = L1_206
    L1_206 = L1_206.setMoveCallBack
    L3_208 = bind
    L4_209 = _UPVALUE0_
    L4_209 = L4_209.SetAniLv
    L5_210 = _UPVALUE0_
    L7_212 = L3_208(L4_209, L5_210)
    L1_206(L2_207, L3_208, L4_209, L5_210, L6_211, L7_212, L3_208(L4_209, L5_210))
    L1_206 = _UPVALUE4_
    L1_206 = L1_206.level
    L2_207 = _UPVALUE3_
    L2_207 = L2_207.level
    if L1_206 <= L2_207 then
      L1_206 = Logic
      L2_207 = L1_206
      L1_206 = L1_206.Get
      L3_208 = "Talisman"
      L1_206 = L1_206(L2_207, L3_208)
      L2_207 = L1_206
      L1_206 = L1_206.GetLifeAndAttack
      L3_208 = _UPVALUE3_
      L3_208 = L3_208.baseId
      L4_209 = _UPVALUE3_
      L4_209 = L4_209.level
      L2_207 = L1_206(L2_207, L3_208, L4_209)
      L3_208 = _UPVALUE0_
      L3_208 = L3_208.ani
      L4_209 = L3_208
      L3_208 = L3_208.GetChild
      L5_210 = "staAttack"
      L3_208 = L3_208(L4_209, L5_210)
      L4_209 = L3_208
      L3_208 = L3_208.create
      L5_210 = L2_207
      L3_208(L4_209, L5_210)
      L3_208 = _UPVALUE0_
      L3_208 = L3_208.ani
      L4_209 = L3_208
      L3_208 = L3_208.GetChild
      L5_210 = "staLife"
      L3_208 = L3_208(L4_209, L5_210)
      L4_209 = L3_208
      L3_208 = L3_208.create
      L5_210 = L1_206
      L3_208(L4_209, L5_210)
      L3_208 = _UPVALUE0_
      L3_208 = L3_208.ani
      L4_209 = L3_208
      L3_208 = L3_208.GetChild
      L5_210 = "staLevel"
      L3_208 = L3_208(L4_209, L5_210)
      L4_209 = L3_208
      L3_208 = L3_208.create
      L5_210 = _UPVALUE0_
      L5_210 = L5_210.bgLv
      L3_208(L4_209, L5_210)
      L3_208 = _UPVALUE0_
      L3_208 = L3_208.ani
      L4_209 = L3_208
      L3_208 = L3_208.GetChild
      L5_210 = "prgExp"
      L3_208 = L3_208(L4_209, L5_210)
      L4_209 = L3_208
      L3_208 = L3_208.setValue
      L5_210 = _UPVALUE3_
      L5_210 = L5_210.exp
      L5_210 = 100 * L5_210
      L5_210 = L5_210 / L0_205
      L3_208(L4_209, L5_210)
      L3_208 = _UPVALUE0_
      L3_208 = L3_208.ani
      L4_209 = L3_208
      L3_208 = L3_208.GetChild
      L5_210 = "prgExp"
      L3_208 = L3_208(L4_209, L5_210)
      L4_209 = L3_208
      L3_208 = L3_208.setValue
      L5_210 = _UPVALUE4_
      L5_210 = L5_210.exp
      L5_210 = 100 * L5_210
      L5_210 = L5_210 / L0_205
      L6_211 = true
      L7_212 = 0
      L3_208(L4_209, L5_210, L6_211, L7_212, 1000)
    else
      L1_206 = _UPVALUE4_
      L1_206 = L1_206.level
      L2_207 = _UPVALUE3_
      L2_207 = L2_207.level
      L1_206 = L1_206 - L2_207
      L2_207 = Logic
      L3_208 = L2_207
      L2_207 = L2_207.Get
      L4_209 = "Talisman"
      L2_207 = L2_207(L3_208, L4_209)
      L3_208 = L2_207
      L2_207 = L2_207.GetLifeAndAttack
      L4_209 = _UPVALUE3_
      L4_209 = L4_209.baseId
      L5_210 = _UPVALUE3_
      L5_210 = L5_210.level
      L3_208 = L2_207(L3_208, L4_209, L5_210)
      L4_209 = Logic
      L5_210 = L4_209
      L4_209 = L4_209.Get
      L6_211 = "Talisman"
      L4_209 = L4_209(L5_210, L6_211)
      L5_210 = L4_209
      L4_209 = L4_209.GetLifeAndAttack
      L6_211 = _UPVALUE4_
      L6_211 = L6_211.baseId
      L7_212 = _UPVALUE4_
      L7_212 = L7_212.level
      L5_210 = L4_209(L5_210, L6_211, L7_212)
      L6_211 = Logic
      L7_212 = L6_211
      L6_211 = L6_211.Get
      L6_211 = L6_211(L7_212, "Talisman")
      L7_212 = L6_211
      L6_211 = L6_211.GetNextExpByIdAndlevel
      L6_211 = L6_211(L7_212, _UPVALUE4_.baseId, _UPVALUE4_.level)
      if L2_207 and L3_208 and L4_209 and L5_210 then
        L7_212 = _UPVALUE0_
        L7_212 = L7_212.ani
        L7_212 = L7_212.GetChild
        L7_212 = L7_212(L7_212, "staAttack")
        L7_212 = L7_212.create
        L7_212(L7_212, L3_208)
        L7_212 = _UPVALUE0_
        L7_212 = L7_212.ani
        L7_212 = L7_212.GetChild
        L7_212 = L7_212(L7_212, "staLife")
        L7_212 = L7_212.create
        L7_212(L7_212, L2_207)
        L7_212 = _UPVALUE0_
        L7_212 = L7_212.ani
        L7_212 = L7_212.GetChild
        L7_212 = L7_212(L7_212, "staLevel")
        L7_212 = L7_212.create
        L7_212(L7_212, _UPVALUE0_.bgLv)
        L7_212 = _UPVALUE0_
        L7_212 = L7_212.ani
        L7_212 = L7_212.GetChild
        L7_212 = L7_212(L7_212, "staAttack")
        L7_212 = L7_212.setValueAni
        L7_212(L7_212, L5_210, 2000)
        L7_212 = _UPVALUE0_
        L7_212 = L7_212.ani
        L7_212 = L7_212.GetChild
        L7_212 = L7_212(L7_212, "staLife")
        L7_212 = L7_212.setValueAni
        L7_212(L7_212, L4_209, 2000)
      end
      L7_212 = _UPVALUE0_
      L7_212 = L7_212.ani
      L7_212 = L7_212.GetChild
      L7_212 = L7_212(L7_212, "prgExp")
      L7_212 = L7_212.setValue
      L7_212(L7_212, 100 * _UPVALUE3_.exp / L0_205)
      if L6_211 == 0 then
        L7_212 = 0
      elseif not L7_212 then
        L7_212 = _UPVALUE4_
        L7_212 = L7_212.exp
        L7_212 = 100 * L7_212
        L7_212 = L7_212 / L6_211
      end
      _UPVALUE0_.ani:GetChild("prgExp"):setValue(L7_212, true, L1_206, 2000)
    end
    L1_206 = Logic
    L2_207 = L1_206
    L1_206 = L1_206.Get
    L3_208 = "HeroCardInfo"
    L1_206 = L1_206(L2_207, L3_208)
    L2_207 = L1_206
    L1_206 = L1_206.AddShanCard
    L3_208 = _UPVALUE0_
    L3_208 = L3_208.ani
    L4_209 = L3_208
    L3_208 = L3_208.GetChild
    L5_210 = "imgOut"
    L3_208 = L3_208(L4_209, L5_210)
    L4_209 = _UPVALUE3_
    L4_209 = L4_209.baseId
    L1_206(L2_207, L3_208, L4_209)
  end
  L15_203 = 5000
  L12_200(L13_201, L14_202, L15_203)
  L12_200 = A0_188.ani
  L13_201 = L12_200
  L12_200 = L12_200.RunAnimationWithoutWait
  L12_200(L13_201)
  if L4_192 then
    L12_200 = Logic
    L13_201 = L12_200
    L12_200 = L12_200.Get
    L14_202 = "Talisman"
    L12_200 = L12_200(L13_201, L14_202)
    L13_201 = L12_200
    L12_200 = L12_200.GetNextExpByIdAndlevel
    L14_202 = L4_192.baseId
    L15_203 = L4_192.level
    L12_200 = L12_200(L13_201, L14_202, L15_203)
    if L12_200 ~= 0 then
      L13_201 = A0_188.prgTest
      L14_202 = L13_201
      L13_201 = L13_201.setVisible
      L15_203 = false
      L16_204 = true
      L13_201(L14_202, L15_203, L16_204)
      L13_201 = A0_188.prgTest
      L14_202 = L13_201
      L13_201 = L13_201.setValue
      L15_203 = L4_192.exp
      L15_203 = 100 * L15_203
      L15_203 = L15_203 / L12_200
      L13_201(L14_202, L15_203)
    else
      L13_201 = A0_188.prgTest
      L14_202 = L13_201
      L13_201 = L13_201.setVisible
      L15_203 = false
      L16_204 = true
      L13_201(L14_202, L15_203, L16_204)
      L13_201 = A0_188.staStatus
      L14_202 = L13_201
      L13_201 = L13_201.setVisible
      L15_203 = false
      L13_201(L14_202, L15_203)
      L13_201 = A0_188.prgTest
      L14_202 = L13_201
      L13_201 = L13_201.setValue
      L15_203 = 0
      L13_201(L14_202, L15_203)
    end
  end
end
function prototype.AniSetVisible(A0_213, A1_214)
  A0_213.ani:GetChild("imgLevelTip"):setVisible(A1_214)
  A0_213.ani:GetChild("staLevel"):setVisible(A1_214)
  A0_213.ani:GetChild("imgAttackTip"):setVisible(A1_214)
  A0_213.ani:GetChild("staAttack"):setVisible(A1_214)
  A0_213.ani:GetChild("imgLifeTip"):setVisible(A1_214)
  A0_213.ani:GetChild("staLife"):setVisible(A1_214)
  A0_213.ani:GetChild("imgBg1"):setVisible(A1_214)
  A0_213.ani:GetChild("imgBg2"):setVisible(A1_214)
  A0_213.ani:GetChild("imgBg3"):setVisible(A1_214)
end
function prototype.onBtnCloseAni(A0_215)
  if A0_215.ani then
    A0_215.ani:RemoveAnimation()
    A0_215.ani = nil
  end
  Logic:Get("BGSound"):stopAllEffect()
  Logic:Get("BGSound"):PlayBGMusic()
  Logic:Get("Talisman"):ClearSwallFabaos()
  Logic:Get("Talisman"):SetBeforeUpdate(nil)
end
function prototype.aniFrontEnd(A0_216)
  local L1_217, L2_218
  L1_217 = A0_216.ani
  L2_218 = L1_217
  L1_217 = L1_217.GetChild
  L1_217 = L1_217(L2_218, "btnClose")
  L2_218 = L1_217
  L1_217 = L1_217.setEnabled
  L1_217(L2_218, true)
  L1_217 = CCSprite
  L2_218 = L1_217
  L1_217 = L1_217.create
  L1_217 = L1_217(L2_218, "images/font/click_go_on.png")
  if L1_217 ~= nil then
    L2_218 = A0_216.ani
    L2_218 = L2_218.GetLayer
    L2_218 = L2_218(L2_218)
    L2_218 = L2_218.addChild
    L2_218(L2_218, L1_217, 0, 10)
    L2_218 = Logic
    L2_218 = L2_218.Get
    L2_218 = L2_218(L2_218, "Gift")
    L2_218 = L2_218.fadetoSpr
    L2_218 = L2_218(L2_218)
    L1_217:runAction(CCRepeatForever:create(L2_218))
    L1_217:setPosition(A0_216.ani:GetChild("ttfGoOn"):getPosition())
  end
end
function prototype.SetAniLv(A0_219, A1_220, A2_221)
  if A2_221 == Progress.CALL_BACK_TYPE.MOVE_FINISH then
    A0_219.ani:GetChild("staLevel"):setValue(A0_219.bgLv)
    A0_219:aniFrontEnd()
  elseif A2_221 == Progress.CALL_BACK_TYPE.PASS_END and A0_219.bgLv then
    A0_219.ani:GetChild("staLevel"):setValue(A0_219.bgLv + 1)
    A0_219.bgLv = A0_219.bgLv + 1
  end
end
