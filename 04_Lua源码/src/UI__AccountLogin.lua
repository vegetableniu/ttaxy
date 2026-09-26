local L0_0
L0_0 = module
L0_0((...), package.seeall)
L0_0 = Tw
L0_0 = L0_0.Controller
L0_0 = L0_0.prototype
L0_0 = L0_0.extend
L0_0 = L0_0(L0_0)
prototype = L0_0
L0_0 = 6
function prototype.initialize(A0_1, ...)
  super.initialize(A0_1, ...)
  Logic:Get("Account"):On(Logic.Account.EVT.LOGIN_SUCCEED, A0_1:Event("onLoginSucceed"))
end
function prototype.dispose(A0_3, ...)
  A0_3:clearAccountExtras()
  super.dispose(A0_3)
end
function prototype.onEnter(A0_5)
  local L1_6
  L1_6 = A0_5.admin
  L1_6 = L1_6.setString
  L1_6(L1_6, TwGetStr(103118))
  L1_6 = A0_5.passward
  L1_6 = L1_6.setString
  L1_6(L1_6, TwGetStr(103119))
  L1_6 = A0_5.ttfRegist
  L1_6 = L1_6.setString
  L1_6(L1_6, TwGetStr(103121))
  L1_6 = A0_5.ttfLogin
  L1_6 = L1_6.setString
  L1_6(L1_6, TwGetStr(103122))
  L1_6 = A0_5.edtPass
  L1_6 = L1_6.setPasswordMode
  L1_6(L1_6, true)
  L1_6 = A0_5.edtAccount
  L1_6 = L1_6.setFontSize
  L1_6(L1_6, _UPVALUE0_)
  L1_6 = A0_5.edtPass
  L1_6 = L1_6.setFontSize
  L1_6(L1_6, _UPVALUE0_)
  L1_6 = A0_5.ttfForgetPsw
  L1_6 = L1_6.setString
  L1_6(L1_6, TwGetStr(108020))
  L1_6 = A0_5.ttfUser
  L1_6 = L1_6.setString
  L1_6(L1_6, TwGetStr(10127))
  L1_6 = Logic
  L1_6 = L1_6.Get
  L1_6 = L1_6(L1_6, "System")
  L1_6 = L1_6.isOtherAccount
  L1_6 = L1_6(L1_6)
  if L1_6 then
    L1_6 = A0_5.showOtherAccount
    L1_6(A0_5, true)
    L1_6 = A0_5.ttfOtherAccount
    L1_6 = L1_6.setString
    L1_6(L1_6, TwGetStr(108024))
  else
    L1_6 = A0_5.showOtherAccount
    L1_6(A0_5, false)
  end
  L1_6 = IsDevMode
  L1_6 = L1_6()
  if not L1_6 then
    L1_6 = A0_5.edtAccount
    L1_6 = L1_6.setMaxLens
    L1_6(L1_6, _UPVALUE1_)
  end
  L1_6 = A0_5.edtPass
  L1_6 = L1_6.setMaxLens
  L1_6(L1_6, _UPVALUE1_)
  L1_6 = IsDevMode
  L1_6 = L1_6()
  if L1_6 then
    L1_6 = A0_5.edtAccount
    L1_6 = L1_6.setString
    L1_6(L1_6, "")
    L1_6 = A0_5.edtPass
    L1_6 = L1_6.setString
    L1_6(L1_6, "")
  end
  L1_6 = Logic
  L1_6 = L1_6.Get
  L1_6 = L1_6(L1_6, "Account")
  L1_6 = L1_6.TakeSecondaryReturnAccount
  L1_6 = L1_6(L1_6)
  if L1_6 and L1_6 ~= "" then
    A0_5.edtAccount:setString(L1_6)
    A0_5.edtPass:setString("")
  end
  A0_5:createAccountDrop()
end
function prototype.accountFieldNode(A0_7)
  local L1_8
  L1_8 = A0_7.edtAccount
  L1_8 = L1_8.rootNode
  L1_8 = L1_8 or A0_7.edtAccount
  return L1_8
end
function prototype.fieldMetrics(A0_9)
  local L1_10, L2_11, L3_12, L4_13, L5_14, L6_15, L7_16, L8_17, L9_18, L10_19, L11_20
  L2_11 = A0_9
  L1_10 = A0_9.accountFieldNode
  L1_10 = L1_10(L2_11)
  L3_12 = L1_10
  L2_11 = L1_10.getParent
  L2_11 = L2_11(L3_12)
  L4_13 = L1_10
  L3_12 = L1_10.getPositionLua
  L3_12 = L3_12(L4_13)
  L5_14 = L1_10
  L4_13 = L1_10.getContentSize
  L4_13 = L4_13(L5_14)
  L6_15 = L1_10
  L5_14 = L1_10.getAnchorPoint
  L5_14 = L5_14(L6_15)
  L6_15 = L1_10.isIgnoreAnchorPointForPosition
  if L6_15 then
    L7_16 = L1_10
    L6_15 = L1_10.isIgnoreAnchorPointForPosition
    L6_15 = L6_15(L7_16)
    if L6_15 then
      L6_15 = ccp
      L7_16 = 0
      L8_17 = 0
      L6_15 = L6_15(L7_16, L8_17)
      L5_14 = L6_15
    end
  end
  L6_15 = L3_12.x
  L7_16 = L4_13.width
  L8_17 = L5_14.x
  L7_16 = L7_16 * L8_17
  L6_15 = L6_15 - L7_16
  L7_16 = L3_12.y
  L8_17 = L4_13.height
  L9_18 = L5_14.y
  L8_17 = L8_17 * L9_18
  L7_16 = L7_16 - L8_17
  L8_17 = L6_15 - 13
  L9_18 = L7_16 + 13.5
  L10_19 = 342
  L11_20 = 45
  return L1_10, L2_11, L8_17, L9_18, L10_19, L11_20
end
function prototype.savedAccounts(A0_21)
  local L1_22, L2_23, L3_24, L4_25, L5_26, L6_27, L7_28, L8_29, L9_30
  L1_22 = {}
  L2_23 = {}
  L3_24 = CVariableSystem
  L4_25 = L3_24
  L3_24 = L3_24.GetSingleton
  L3_24 = L3_24(L4_25)
  L4_25 = L3_24
  L3_24 = L3_24.GetSysVariable
  L5_26 = GV_DOCPATH
  L3_24 = L3_24(L4_25, L5_26)
  L3_24 = L3_24 or ""
  L4_25 = io
  L4_25 = L4_25.open
  L5_26 = L3_24
  L5_26 = L5_26 .. L6_27
  L4_25 = L4_25(L5_26, L6_27)
  if not L4_25 then
    return L1_22
  end
  L5_26 = L4_25.read
  L5_26 = L5_26(L6_27, L7_28)
  L5_26 = L5_26 or ""
  L6_27(L7_28)
  for L9_30 in L6_27(L7_28, L8_29) do
    if L9_30 ~= "" and not L2_23[L9_30] then
      L2_23[L9_30] = true
      table.insert(L1_22, L9_30)
    end
  end
  return L1_22
end
function prototype.persistSavedAccounts(A0_31, A1_32)
  local L2_33
  L2_33 = CVariableSystem
  L2_33 = L2_33.GetSingleton
  L2_33 = L2_33(L2_33)
  L2_33 = L2_33.GetSysVariable
  L2_33 = L2_33(L2_33, GV_DOCPATH)
  L2_33 = L2_33 or ""
  if not io.open(L2_33 .. _UPVALUE0_, "w") then
    return
  end
  io.open(L2_33 .. _UPVALUE0_, "w"):write(table.concat(A1_32, ","))
  io.open(L2_33 .. _UPVALUE0_, "w"):close()
end
function prototype.saveCurrentAccount(A0_34)
  local L1_35, L2_36, L3_37, L4_38, L5_39, L6_40, L7_41
  L1_35 = A0_34.edtAccount
  L2_36 = L1_35
  L1_35 = L1_35.getString
  L1_35 = L1_35(L2_36)
  if nil == L1_35 or "" == L1_35 then
    L2_36 = Prompt
    L3_37 = L2_36
    L2_36 = L2_36.Fail
    L2_36(L3_37, L4_38)
    return
  end
  L2_36 = getStrShowWidth
  L3_37 = L1_35
  L2_36 = L2_36(L3_37)
  L3_37 = IsDevMode
  L3_37 = L3_37()
  if not L3_37 then
    L3_37 = _UPVALUE0_
    if not (L2_36 < L3_37) then
      L3_37 = _UPVALUE1_
    elseif L2_36 > L3_37 then
      L3_37 = Prompt
      L3_37 = L3_37.Fail
      L3_37(L4_38, L5_39)
      return
    end
  end
  L3_37 = string
  L3_37 = L3_37.find
  L3_37 = L3_37(L4_38, L5_39)
  if L3_37 then
    L3_37 = Prompt
    L3_37 = L3_37.Fail
    L3_37(L4_38, L5_39)
    return
  end
  L3_37 = A0_34.savedAccounts
  L3_37 = L3_37(L4_38)
  for L7_41 = #L3_37, 1, -1 do
    if L3_37[L7_41] == L1_35 then
      table.remove(L3_37, L7_41)
    end
  end
  L7_41 = L1_35
  L4_38(L5_39, L6_40, L7_41)
  while true do
    if L4_38 > L5_39 then
      L4_38(L5_39)
    end
  end
  L4_38(L5_39, L6_40)
  L4_38(L5_39)
  L4_38(L5_39, L6_40)
end
function prototype.deleteSavedAccount(A0_42, A1_43)
  local L2_44, L3_45, L4_46, L5_47, L6_48
  L2_44 = A0_42.savedAccounts
  L2_44 = L2_44(L3_45)
  for L6_48 = #L2_44, 1, -1 do
    if L2_44[L6_48] == A1_43 then
      table.remove(L2_44, L6_48)
    end
  end
  L3_45(L4_46, L5_47)
  L3_45(L4_46)
  if L3_45 > 0 then
    L3_45(L4_46)
  end
end
function prototype.clearAccountExtras(A0_49)
  A0_49:hideAccountList()
  if A0_49.accountDropLayer then
    A0_49.accountDropLayer:removeFromParentAndCleanup(true)
    A0_49.accountDropLayer = nil
  end
  if A0_49.accountSaveLayer then
    A0_49.accountSaveLayer:removeFromParentAndCleanup(true)
    A0_49.accountSaveLayer = nil
  end
end
function prototype.createAccountDrop(A0_50)
  local L1_51, L2_52, L3_53, L4_54, L5_55, L6_56, L7_57, L8_58, L9_59, L10_60
  L2_52 = A0_50
  L1_51 = A0_50.clearAccountExtras
  L1_51(L2_52)
  L2_52 = A0_50
  L1_51 = A0_50.fieldMetrics
  L6_56 = L1_51(L2_52)
  L7_57 = CCLayer
  L8_58 = L7_57
  L7_57 = L7_57.create
  L7_57 = L7_57(L8_58)
  L9_59 = L7_57
  L8_58 = L7_57.setContentSize
  L10_60 = CCSize
  L10_60 = L10_60(_UPVALUE0_, L6_56)
  L8_58(L9_59, L10_60, L10_60(_UPVALUE0_, L6_56))
  L9_59 = L7_57
  L8_58 = L7_57.setAnchorPoint
  L10_60 = ccp
  L10_60 = L10_60(0, 0)
  L8_58(L9_59, L10_60, L10_60(0, 0))
  L9_59 = L7_57
  L8_58 = L7_57.setPosition
  L10_60 = ccp
  L10_60 = L10_60(L3_53 + L5_55 + _UPVALUE1_, L4_54)
  L8_58(L9_59, L10_60, L10_60(L3_53 + L5_55 + _UPVALUE1_, L4_54))
  L8_58 = CCLabelTTF
  L9_59 = L8_58
  L8_58 = L8_58.create
  L10_60 = "\228\191\157\229\173\152"
  L8_58 = L8_58(L9_59, L10_60, "Helvetica", 22)
  L10_60 = L8_58
  L9_59 = L8_58.setColor
  L9_59(L10_60, ccc3(180, 40, 40))
  L10_60 = L8_58
  L9_59 = L8_58.setAnchorPoint
  L9_59(L10_60, ccp(0.5, 0.5))
  L10_60 = L8_58
  L9_59 = L8_58.setPosition
  L9_59(L10_60, ccp(_UPVALUE0_ * 0.5, L6_56 * 0.5))
  L10_60 = L7_57
  L9_59 = L7_57.addChild
  L9_59(L10_60, L8_58)
  L10_60 = L2_52
  L9_59 = L2_52.addChild
  L9_59(L10_60, L7_57, 81)
  A0_50.accountSaveLayer = L7_57
  L10_60 = L7_57
  L9_59 = L7_57.registerScriptTouchHandler
  L9_59(L10_60, bind(A0_50.onAccountSaveTouch, A0_50), false, -64, true)
  L10_60 = L7_57
  L9_59 = L7_57.setTouchEnabled
  L9_59(L10_60, true)
  L10_60 = A0_50
  L9_59 = A0_50.savedAccounts
  L9_59 = L9_59(L10_60)
  L9_59 = #L9_59
  if L9_59 == 0 then
    return
  end
  L9_59 = CCLayer
  L10_60 = L9_59
  L9_59 = L9_59.create
  L9_59 = L9_59(L10_60)
  L10_60 = L9_59.setContentSize
  L10_60(L9_59, CCSize(_UPVALUE2_, L6_56))
  L10_60 = L9_59.setAnchorPoint
  L10_60(L9_59, ccp(0, 0))
  L10_60 = L9_59.setPosition
  L10_60(L9_59, ccp(L3_53 + L5_55 - _UPVALUE2_, L4_54))
  L10_60 = CCLabelTTF
  L10_60 = L10_60.create
  L10_60 = L10_60(L10_60, "\226\150\188", "Helvetica", 18)
  L10_60:setColor(ccc3(255, 232, 176))
  L10_60:setAnchorPoint(ccp(0.5, 0.5))
  L10_60:setPosition(ccp(_UPVALUE2_ * 0.5, L6_56 * 0.5))
  L9_59:addChild(L10_60)
  L2_52:addChild(L9_59, 80)
  A0_50.accountDropLayer = L9_59
  L9_59:registerScriptTouchHandler(bind(A0_50.onAccountDropTouch, A0_50), false, -64, true)
  L9_59:setTouchEnabled(true)
end
function prototype.hideAccountList(A0_61)
  if A0_61.accountListLayer then
    A0_61.accountListLayer:removeFromParentAndCleanup(true)
    A0_61.accountListLayer = nil
  end
  A0_61.accountListNames = nil
end
function prototype.toggleAccountList(A0_62)
  local L1_63, L2_64, L3_65, L4_66, L5_67, L6_68, L7_69, L8_70, L9_71, L10_72, L11_73, L12_74, L13_75, L14_76, L15_77, L16_78, L17_79
  L1_63 = A0_62.accountListLayer
  if L1_63 then
    L2_64 = A0_62
    L1_63 = A0_62.hideAccountList
    L1_63(L2_64)
    return
  end
  L2_64 = A0_62
  L1_63 = A0_62.savedAccounts
  L1_63 = L1_63(L2_64)
  L2_64 = #L1_63
  if L2_64 == 0 then
    return
  end
  L3_65 = A0_62
  L2_64 = A0_62.fieldMetrics
  L7_69 = L2_64(L3_65)
  L8_70 = 40
  L9_71 = #L1_63
  L9_71 = L8_70 * L9_71
  L10_72 = CCLayerColor
  L10_72 = L10_72.create
  L14_76 = 52
  L15_77 = 28
  L16_78 = 250
  L14_76 = L9_71
  L10_72 = L10_72(L11_73, L12_74, L13_75, L14_76)
  L14_76 = L4_66
  L15_77 = L5_67 - L9_71
  L15_77 = L15_77 - 2
  L17_79 = L13_75(L14_76, L15_77)
  L11_73(L12_74, L13_75, L14_76, L15_77, L16_78, L17_79, L13_75(L14_76, L15_77))
  for L14_76, L15_77 in L11_73(L12_74) do
    L16_78 = CCLabelTTF
    L17_79 = L16_78
    L16_78 = L16_78.create
    L16_78 = L16_78(L17_79, L15_77, "Helvetica", 22)
    L17_79 = L16_78.setColor
    L17_79(L16_78, ccc3(255, 232, 176))
    L17_79 = L16_78.setAnchorPoint
    L17_79(L16_78, ccp(0, 0.5))
    L17_79 = L16_78.setPosition
    L17_79(L16_78, ccp(16, L9_71 - (L14_76 - 0.5) * L8_70))
    L17_79 = L10_72.addChild
    L17_79(L10_72, L16_78)
    L17_79 = CCLabelTTF
    L17_79 = L17_79.create
    L17_79 = L17_79(L17_79, "X", "Helvetica", 22)
    L17_79:setColor(ccc3(255, 90, 90))
    L17_79:setAnchorPoint(ccp(0.5, 0.5))
    L17_79:setPosition(ccp(L6_68 - _UPVALUE0_ * 0.5, L9_71 - (L14_76 - 0.5) * L8_70))
    L10_72:addChild(L17_79)
  end
  L14_76 = 90
  L11_73(L12_74, L13_75, L14_76)
  A0_62.accountListLayer = L10_72
  A0_62.accountListNames = L1_63
  A0_62.accountListRowH = L8_70
  L14_76 = A0_62.onAccountListTouch
  L15_77 = A0_62
  L14_76 = false
  L15_77 = -80
  L16_78 = true
  L11_73(L12_74, L13_75, L14_76, L15_77, L16_78)
  L11_73(L12_74, L13_75)
end
function prototype.touchInNode(A0_80, A1_81, A2_82, A3_83)
  if not A1_81 then
    return false
  end
  if A1_81:isIgnoreAnchorPointForPosition() then
    A1_81:getAnchorPoint().x = 0
    A1_81:getAnchorPoint().y = 0
  end
  return A1_81:getPositionLua().x - A1_81:getContentSize().width * A1_81:getAnchorPoint().x <= A1_81:getParent():convertToNodeSpace(ccp(A2_82, A3_83)).x and A1_81:getParent():convertToNodeSpace(ccp(A2_82, A3_83)).x <= A1_81:getPositionLua().x - A1_81:getContentSize().width * A1_81:getAnchorPoint().x + A1_81:getContentSize().width and A1_81:getPositionLua().y - A1_81:getContentSize().height * A1_81:getAnchorPoint().y <= A1_81:getParent():convertToNodeSpace(ccp(A2_82, A3_83)).y and A1_81:getParent():convertToNodeSpace(ccp(A2_82, A3_83)).y <= A1_81:getPositionLua().y - A1_81:getContentSize().height * A1_81:getAnchorPoint().y + A1_81:getContentSize().height
end
function prototype.onAccountSaveTouch(A0_84, A1_85, A2_86, A3_87)
  if A1_85 ~= CCTOUCHBEGAN then
    return false
  end
  if not A0_84:touchInNode(A0_84.accountSaveLayer, A2_86, A3_87) then
    return false
  end
  A0_84:hideAccountList()
  A0_84:saveCurrentAccount()
  return true
end
function prototype.onAccountDropTouch(A0_88, A1_89, A2_90, A3_91)
  if A1_89 ~= CCTOUCHBEGAN then
    return false
  end
  if not A0_88:touchInNode(A0_88.accountDropLayer, A2_90, A3_91) then
    if A0_88.accountListLayer and not A0_88:touchInNode(A0_88.accountListLayer, A2_90, A3_91) and not A0_88:touchInNode(A0_88.accountSaveLayer, A2_90, A3_91) then
      A0_88:hideAccountList()
    end
    return false
  end
  A0_88:toggleAccountList()
  return true
end
function prototype.onAccountListTouch(A0_92, A1_93, A2_94, A3_95)
  local L4_96, L5_97, L6_98, L7_99, L8_100, L9_101
  L4_96 = CCTOUCHBEGAN
  if A1_93 ~= L4_96 then
    L4_96 = false
    return L4_96
  end
  L4_96 = A0_92.accountListLayer
  L5_97 = A0_92.accountListNames
  if not L4_96 or not L5_97 then
    L6_98 = false
    return L6_98
  end
  L7_99 = A0_92
  L6_98 = A0_92.touchInNode
  L8_100 = L4_96
  L9_101 = A2_94
  L6_98 = L6_98(L7_99, L8_100, L9_101, A3_95)
  if not L6_98 then
    L7_99 = A0_92
    L6_98 = A0_92.hideAccountList
    L6_98(L7_99)
    L6_98 = true
    return L6_98
  end
  L7_99 = L4_96
  L6_98 = L4_96.convertToNodeSpace
  L8_100 = ccp
  L9_101 = A2_94
  L9_101 = L8_100(L9_101, A3_95)
  L6_98 = L6_98(L7_99, L8_100, L9_101, L8_100(L9_101, A3_95))
  L8_100 = L4_96
  L7_99 = L4_96.getContentSize
  L7_99 = L7_99(L8_100)
  L8_100 = math
  L8_100 = L8_100.floor
  L9_101 = L7_99.height
  L9_101 = L9_101 - L6_98.y
  L9_101 = L9_101 / (A0_92.accountListRowH or 40)
  L8_100 = L8_100(L9_101)
  L8_100 = L8_100 + 1
  L9_101 = L5_97[L8_100]
  if L9_101 and L6_98.x >= L7_99.width - _UPVALUE0_ then
    A0_92:deleteSavedAccount(L9_101)
    return true
  end
  if L9_101 then
    A0_92.edtAccount:setString(L9_101)
    A0_92.edtPass:setString("")
  end
  A0_92:hideAccountList()
  return true
end
function prototype.showOtherAccount(A0_102, A1_103)
  A0_102.btnOtherAccount:setVisible(A1_103)
  A0_102.ttfOtherAccount:setVisible(A1_103)
end
function prototype.checkInput(A0_104)
  local L1_105, L2_106, L3_107, L4_108
  L1_105 = IsDevMode
  L1_105 = L1_105()
  L2_106 = A0_104.edtAccount
  L3_107 = L2_106
  L2_106 = L2_106.getString
  L2_106 = L2_106(L3_107)
  if nil == L2_106 or "" == L2_106 then
    L3_107 = Prompt
    L4_108 = L3_107
    L3_107 = L3_107.Fail
    L3_107(L4_108, 10065)
    L3_107 = false
    return L3_107
  end
  L3_107 = getStrShowWidth
  L4_108 = L2_106
  L3_107 = L3_107(L4_108)
  if not L1_105 then
    L4_108 = _UPVALUE0_
  else
    if not (L3_107 < L4_108) then
      L4_108 = _UPVALUE1_
  end
  elseif L3_107 > L4_108 then
    L4_108 = Prompt
    L4_108 = L4_108.Fail
    L4_108(L4_108, 10102)
    L4_108 = false
    return L4_108
  end
  L4_108 = string
  L4_108 = L4_108.find
  L4_108 = L4_108(L2_106, "[^%w]")
  if L4_108 then
    L4_108 = Prompt
    L4_108 = L4_108.Fail
    L4_108(L4_108, 10100)
    L4_108 = false
    return L4_108
  end
  L4_108 = getCodePointAmount
  L4_108 = L4_108(L2_106)
  if L4_108 ~= string.len(L2_106) then
    L4_108 = Prompt
    L4_108 = L4_108.Fail
    L4_108(L4_108, 102212)
    L4_108 = false
    return L4_108
  end
  L4_108 = A0_104.edtPass
  L4_108 = L4_108.getString
  L4_108 = L4_108(L4_108)
  if not L1_105 and (nil == L4_108 or "" == L4_108) then
    Prompt:Fail(10066)
    return false
  end
  if not L1_105 and getStrShowWidth(L4_108) < _UPVALUE2_ then
    Prompt:Fail(10069)
    return false
  end
  if string.find(L4_108, "[^%w]") then
    Prompt:Fail(10103)
    return false
  end
  Logic:Get("Account"):SetNickName(L2_106)
  Logic:Get("Account"):SetAccName(L2_106)
  L4_108 = CMd5(L4_108):GetResult()
  Logic:Get("Account"):SetPassword(L4_108)
  return true
end
function prototype.onLoginClk(A0_109)
  local L1_110, L2_111, L3_112
  L1_110 = IsDevMode
  L1_110 = L1_110()
  if L1_110 then
    L1_110 = A0_109.edtAccount
    L2_111 = L1_110
    L1_110 = L1_110.getString
    L1_110 = L1_110(L2_111)
    L2_111 = pcall
    function L3_112()
      _UPVALUE0_ = base64.decode(_UPVALUE0_)
      _UPVALUE0_ = json.decode(_UPVALUE0_)
    end
    L3_112 = L2_111(L3_112)
    if not L1_110 then
      L2_111, L3_112 = pcall(function()
        local L0_113
        L0_113 = json
        L0_113 = L0_113.decode
        L0_113 = L0_113(_UPVALUE1_.edtAccount:getString())
        _UPVALUE0_ = L0_113
      end)
    end
    if L2_111 and type(L1_110) == "table" then
      Logic:Get("Account"):SuperLogin(L1_110)
      return
    end
  end
  L2_111 = A0_109
  L1_110 = A0_109.checkInput
  L1_110 = L1_110(L2_111)
  if not L1_110 then
    return
  end
  L1_110 = Logic
  L2_111 = L1_110
  L1_110 = L1_110.Get
  L3_112 = "System"
  L1_110 = L1_110(L2_111, L3_112)
  L2_111 = L1_110
  L1_110 = L1_110.IsSelfAccLogin
  L1_110 = L1_110(L2_111)
  if L1_110 then
    L1_110 = Logic
    L2_111 = L1_110
    L1_110 = L1_110.Get
    L3_112 = "Account"
    L1_110 = L1_110(L2_111, L3_112)
    L2_111 = L1_110
    L1_110 = L1_110.Login
    L1_110(L2_111)
  else
    L1_110 = Logic
    L2_111 = L1_110
    L1_110 = L1_110.Get
    L3_112 = "EnvLogic"
    L1_110 = L1_110(L2_111, L3_112)
    L2_111 = L1_110
    L1_110 = L1_110.Login
    L3_112 = A0_109.edtAccount
    L3_112 = L3_112.getString
    L3_112 = L3_112(L3_112)
    L1_110(L2_111, L3_112, A0_109.edtPass:getString())
  end
  return
end
function prototype.onRegistClk(A0_114)
  SceneHelper:removeScene("AccountLogin")
  SceneHelper:pushMoveScene("AccountRegist")
end
function prototype.onBtnForgetPsw(A0_115)
  Logic:Get("Account"):SetSecondaryFlow("reset", A0_115.edtAccount:getString())
  SceneHelper:removeScene("AccountLogin")
  SceneHelper:pushMoveScene("AccountBind")
end
function prototype.onBtnUserCenter(A0_116)
  Logic:Get("Account"):SetSecondaryFlow("bind", A0_116.edtAccount:getString())
  SceneHelper:removeScene("AccountLogin")
  SceneHelper:pushMoveScene("AccountBind")
end
function prototype.onBackClk(A0_117)
  Logic:Get("Account"):SetAutoLogin(false)
  Logic:Get("Login"):removeAni(A0_117.rootNode, "AccountLogin", Logic.Login.LOAD_STAGE.ENTERGAME)
end
function prototype.onBtnOtherAccount(A0_118)
  Logic:Get("EnvLogic"):Login()
end
function prototype.onLoginSucceed(A0_119)
  Logic:Get("Account"):SetAutoLogin(false)
  Logic:Get("Login"):removeAni(A0_119.rootNode, "AccountLogin", Logic.Login.LOAD_STAGE.ENTERGAME)
end
