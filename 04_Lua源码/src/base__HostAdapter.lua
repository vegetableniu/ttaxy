local L0_0, L1_1, L2_2, L3_3, L4_4, L5_5, L6_6, L7_7, L8_8, L9_9, L10_10, L11_11, L12_12, L13_13, L14_14, L15_15, L16_16
L0_0 = CNetMgr
L1_1 = CNetMgrSendMsg
L0_0.SendMsg = L1_1
L0_0 = CTwFilePack
L1_1 = CTwFilePackOpen
L0_0.Open = L1_1
L0_0 = Tw
L0_0 = L0_0.Zlib
L1_1 = TwZlibDeflate
L0_0.Deflate = L1_1
L0_0 = Tw
L0_0 = L0_0.Zlib
L1_1 = TwZlibInflate
L0_0.Inflate = L1_1
L0_0 = Tw
L0_0 = L0_0.QuickLZ
L1_1 = TwQuickLZDeflate
L0_0.Deflate = L1_1
L0_0 = Tw
L0_0 = L0_0.QuickLZ
L1_1 = TwQuickLZInflate
L0_0.Inflate = L1_1
L0_0 = CTwUtil
L1_1 = CTwUtilEncrypt
L0_0.Encrypt = L1_1
L0_0 = CTwUtil
L1_1 = CTwUtilDecrypt
L0_0.Decrypt = L1_1
L0_0 = TwGetStr
function L1_1(A0_17, ...)
  local L2_19
  L2_19 = _UPVALUE0_
  L2_19 = L2_19(A0_17)
  L2_19 = ReplaceStringTab(L2_19)
  if select("#", ...) == 0 then
    return L2_19
  end
  return string.format(L2_19, ...)
end
TwGetStr = L1_1
L1_1 = CCSequence
L1_1 = L1_1.create
L2_2 = CCSequence
function L3_3(...)
  local L1_21
  L1_21 = _UPVALUE0_
  L1_21 = L1_21(...)
  return tolua.cast(L1_21, "CCSequence")
end
L2_2.create = L3_3
L2_2 = ccColor3B
function L3_3(A0_22, A1_23, A2_24)
  if A0_22 and A1_23 and A2_24 then
    _UPVALUE0_().r = A0_22
    _UPVALUE0_().g = A1_23
    _UPVALUE0_().b = A2_24
  end
  return (_UPVALUE0_())
end
ccColor3B = L3_3
L3_3 = CCControlButton
L3_3 = L3_3.setTitleForState
L4_4 = CCControlButton
function L5_5(A0_25, A1_26, ...)
  local L3_28, L4_29
  L3_28 = _UPVALUE0_
  L4_29 = A0_25
  L3_28(L4_29, CCString:create(A1_26 or ""), ...)
end
L4_4.setTitleForState = L5_5
L4_4 = CCControlButton
L4_4 = L4_4.getTitleForState
L5_5 = CCControlButton
function L6_6(...)
  return _UPVALUE0_(...):getCString() or ""
end
L5_5.getTitleForState = L6_6
L5_5 = CCLabelAtlas
L5_5 = L5_5.getString
L6_6 = CCLabelAtlas
function L7_7(...)
  local L2_32
  L2_32 = _UPVALUE0_
  L2_32 = L2_32(...)
  L2_32 = L2_32 or ""
  return L2_32
end
L6_6.getString = L7_7
L6_6 = CCLabelAtlas
L6_6 = L6_6.setString
L7_7 = CCLabelAtlas
function L8_8(A0_33, A1_34, ...)
  local L3_36, L4_37, L5_38, L6_39
  L3_36 = _UPVALUE0_
  L4_37 = A0_33
  L5_38 = A1_34 or ""
  L6_39 = ...
  L3_36(L4_37, L5_38, L6_39)
end
L7_7.setString = L8_8
L7_7 = CCLabelBMFont
L7_7 = L7_7.getString
L8_8 = CCLabelBMFont
function L9_9(...)
  local L2_41
  L2_41 = _UPVALUE0_
  L2_41 = L2_41(...)
  L2_41 = L2_41 or ""
  return L2_41
end
L8_8.getString = L9_9
L8_8 = CCLabelBMFont
L8_8 = L8_8.setString
L9_9 = CCLabelBMFont
function L10_10(A0_42, A1_43, ...)
  local L3_45, L4_46, L5_47, L6_48
  L3_45 = _UPVALUE0_
  L4_46 = A0_42
  L5_47 = A1_43 or ""
  L6_48 = ...
  L3_45(L4_46, L5_47, L6_48)
end
L9_9.setString = L10_10
L9_9 = CCLabelBMFont
L9_9 = L9_9.setCString
L10_10 = CCLabelBMFont
function L11_11(A0_49, A1_50, ...)
  local L3_52, L4_53, L5_54, L6_55
  L3_52 = _UPVALUE0_
  L4_53 = A0_49
  L5_54 = A1_50 or ""
  L6_55 = ...
  L3_52(L4_53, L5_54, L6_55)
end
L10_10.setCString = L11_11
L10_10 = CCLabelTTF
L10_10 = L10_10.getString
L11_11 = CCLabelTTF
function L12_12(...)
  local L2_57
  L2_57 = _UPVALUE0_
  L2_57 = L2_57(...)
  L2_57 = L2_57 or ""
  return L2_57
end
L11_11.getString = L12_12
L11_11 = CCLabelTTF
L11_11 = L11_11.setString
L12_12 = CCLabelTTF
function L13_13(A0_58, A1_59, ...)
  assert(tolua.type(A0_58) == "CCLabelTTF")
  _UPVALUE0_(A0_58, A1_59 or "", ...)
end
L12_12.setString = L13_13
L12_12 = CCTextFieldTTF
L12_12 = L12_12.getString
L13_13 = CCTextFieldTTF
function L14_14(...)
  local L2_62
  L2_62 = _UPVALUE0_
  L2_62 = L2_62(...)
  L2_62 = L2_62 or ""
  return L2_62
end
L13_13.getString = L14_14
L13_13 = CCTextFieldTTF
L13_13 = L13_13.setString
L14_14 = CCTextFieldTTF
function L15_15(A0_63, A1_64, ...)
  local L3_66, L4_67, L5_68, L6_69
  L3_66 = _UPVALUE0_
  L4_67 = A0_63
  L5_68 = A1_64 or ""
  L6_69 = ...
  L3_66(L4_67, L5_68, L6_69)
end
L14_14.setString = L15_15
L14_14 = CCTextFieldTTF
L14_14 = L14_14.textFieldWithPlaceHolder
L15_15 = CCTextFieldTTF
function L16_16(A0_70, A1_71, ...)
  local L3_73, L4_74, L5_75, L6_76
  L3_73 = _UPVALUE0_
  L4_74 = A0_70
  L5_75 = A1_71 or ""
  L6_76 = ...
  return L3_73(L4_74, L5_75, L6_76)
end
L15_15.textFieldWithPlaceHolder = L16_16
L15_15 = CCScale9Sprite
L15_15 = L15_15.create
L16_16 = CCScale9Sprite
function L16_16.create(A0_77, A1_78)
  if CCSprite:create(A1_78) == nil then
    return nil
  end
  return CCScale9Sprite:createWithSpriteFrame(CCSprite:create(A1_78):displayFrame())
end
L16_16 = cjson
L16_16 = L16_16.decode
function cjson.decode(A0_79)
  if not pcall(_UPVALUE0_, A0_79) then
    return nil
  end
  return pcall(_UPVALUE0_, A0_79)
end
require("std")
require("LuaXml")
json = cjson
require("utils")
require("GameLogger")
require("StrictCheck")
require("Tw.Controller")
require("TwSharedPtr")
require("Events")
require("ANI")
require("Logic")
require("Console")
require("NetMgr")
require("GameRoot")
require("NetModules")
require("Prompt")
require("NetHttp")
require("test")
function __G__TRACKBACK__(A0_80)
  log4cocos2d:warn(A0_80)
  return A0_80
end
function OnSysStartup()
  math.randomseed(TimeGetTime())
  CCLabelTTF:setDefaultFontName(CTwUtil:GetSingleton():GetDefaultFontName())
  CCLabelTTF:setDefaultFontSize(CTwUtil:GetSingleton():GetFontSize())
  Singleton(GameRoot):OnSysStartup()
end
function OnSysShutdown()
  Singleton(GameRoot):OnSysShutdown()
  Singleton(GameRoot):dispose()
  Singleton(Timer):dispose()
end
function OnMemoryLow()
  Singleton(GameRoot):OnMemoryLow()
end
function OnPackageUpdateFinish()
  Logic:Get("AutoPatch"):StartQuery()
end
function OnLogin(A0_81, A1_82)
  local L2_83, L3_84, L4_85, L5_86, L6_87, L7_88, L8_89, L9_90, L10_91, L11_92, L12_93, L13_94
  if 0 ~= A0_81 or nil == A1_82 then
    return
  end
  L2_83 = nil
  L3_84 = pcall
  function L4_85()
    _UPVALUE0_ = json.decode(_UPVALUE1_)
  end
  L4_85 = L3_84(L4_85)
  L5_86 = ""
  L6_87 = ""
  L7_88 = ""
  L8_89 = false
  L9_90 = false
  L10_91 = ""
  L11_92 = ""
  L12_93 = ""
  if L3_84 then
    L13_94 = type
    L13_94 = L13_94(L2_83)
    if L13_94 == "table" then
      L13_94 = L2_83.checkSidFunc
      if nil ~= L13_94 then
        L13_94 = type
        L13_94 = L13_94(L2_83.checkSidFunc)
        if L13_94 == "string" then
          L13_94 = L2_83.checkSidFuncParam
          if nil ~= L13_94 then
            L13_94 = type
            L13_94 = L13_94(L2_83.checkSidFuncParam)
            if L13_94 then
              L13_94 = Logic
              L13_94 = L13_94.Get
              L13_94 = L13_94(L13_94, "Sdk")
              L13_94[L2_83.checkSidFunc](L13_94, L2_83.checkSidFuncParam)
              return
            end
          end
        end
      end
      L13_94 = L2_83.userName
      L5_86 = L13_94 or L13_94
      L13_94 = L2_83.userId
      L6_87 = L13_94 or ""
      L13_94 = L2_83.anonymity
      L8_89 = nil ~= L13_94 and L2_83.anonymity
      L13_94 = L2_83.type
      L9_90 = "bindAccount" == L13_94
      L13_94 = L2_83.password
      L7_88 = L13_94 or ""
      L13_94 = L2_83.oldUser
      L10_91 = L13_94 or ""
      L13_94 = L2_83.extParam
      L11_92 = L13_94 or ""
      L12_93 = L2_83.tencentLoginRet
    end
  else
    L5_86 = ""
    L6_87 = A1_82
  end
  L13_94 = Logic
  L13_94 = L13_94.Get
  L13_94 = L13_94(L13_94, "Account")
  L13_94 = L13_94.SetNickName
  L13_94(L13_94, L5_86)
  L13_94 = Logic
  L13_94 = L13_94.Get
  L13_94 = L13_94(L13_94, "Account")
  L13_94 = L13_94.SetAccName
  L13_94(L13_94, L6_87)
  L13_94 = Logic
  L13_94 = L13_94.Get
  L13_94 = L13_94(L13_94, "Account")
  L13_94 = L13_94.SetExt
  L13_94(L13_94, L11_92)
  L13_94 = Logic
  L13_94 = L13_94.Get
  L13_94 = L13_94(L13_94, "Account")
  L13_94 = L13_94.SetTencentLoginRet
  L13_94(L13_94, L12_93)
  if nil == L7_88 or "" == L7_88 then
    L13_94 = CMd5
    L13_94 = L13_94(L6_87)
    L13_94 = L13_94.GetResult
    L13_94 = L13_94(L13_94)
    L7_88 = L13_94
  end
  L13_94 = Logic
  L13_94 = L13_94.Get
  L13_94 = L13_94(L13_94, "Account")
  L13_94 = L13_94.SetPassword
  L13_94(L13_94, L7_88)
  if L9_90 then
    L13_94 = Logic
    L13_94 = L13_94.Get
    L13_94 = L13_94(L13_94, "Account")
    L13_94 = L13_94.BindAccount
    L13_94(L13_94, L10_91)
  else
    L13_94 = Logic
    L13_94 = L13_94.Get
    L13_94 = L13_94(L13_94, "Account")
    L13_94 = L13_94.CheckUser
    L13_94(L13_94, L8_89)
  end
end
function OnLogout()
  if Singleton(GameStage):IsStage("Normal") or Singleton(GameStage):IsStage("CreateHero") then
    Singleton(GameStage):ChgStage("Logout", false)
  else
    Logic:Get("Account"):FireEvent(Logic.Account.EVT.LOGOUT)
  end
end
function OnServerLst(A0_95)
  local L1_96, L2_97, L3_98, L4_99
  L1_96 = {}
  L2_97 = pcall
  function L3_98()
    _UPVALUE0_ = json.decode(_UPVALUE1_)
  end
  L3_98 = L2_97(L3_98)
  if not L2_97 then
    L4_99 = Prompt
    L4_99 = L4_99.Select
    L4_99(L4_99, self, "", 10117, AutoPatch.OnConfirmReGetServerLst)
    return
  end
  if nil ~= L1_96 then
    L4_99 = L1_96.convertServerFunc
    if nil ~= L4_99 then
      L4_99 = type
      L4_99 = L4_99(L1_96.convertServerFunc)
      if L4_99 == "string" then
        L4_99 = L1_96.list
        if nil ~= L4_99 then
          L4_99 = Logic
          L4_99 = L4_99.Get
          L4_99 = L4_99(L4_99, "Sdk")
          A0_95 = L4_99[L1_96.convertServerFunc](L4_99, L1_96.list)
        end
      end
    end
  end
  L4_99 = Logic
  L4_99 = L4_99.Get
  L4_99 = L4_99(L4_99, "Login")
  L4_99 = L4_99.InitServerLst
  L4_99 = L4_99(L4_99, A0_95)
  if not L4_99 then
    L4_99 = Prompt
    L4_99 = L4_99.Select
    L4_99(L4_99, self, "", 10117, AutoPatch.OnConfirmReGetServerLst)
    return
  end
  L4_99 = Logic
  L4_99 = L4_99.Get
  L4_99 = L4_99(L4_99, "AutoPatch")
  L4_99 = L4_99.FireEvent
  L4_99(L4_99, Logic.AutoPatch.EVT.ENTER_SELSERVER)
end
function OnEnterBackground()
  Logic:Get("SureConfirm"):clearAllFrame()
end
function OnEnterForeground()
  if "1" == CVariableSystem:GetSingleton():GetSysVariable(GV_CLOSE_SOUND) then
    SimpleAudioEngine:sharedEngine():pauseBackgroundMusic()
  end
  if Singleton(GameStage):IsStage("Normal") then
    Logic:Get("EnvLogic"):PopAdvert()
  end
  if Singleton(GameStage):IsStage("Normal") and not Logic:Get("Guide"):isGuiding() and not Logic:Get("DramaControl"):getIsInDramaing() and not Logic:Get("BattleShow"):IsEnterBattle() and not Logic:Get("Sect"):IsEnterSectBattle() then
    if not Logic:Get("PlayerInfo"):IsDrawTodayReward() then
      Logic:Get("PlayerInfo"):FireEvent(Logic.PlayerInfo.EVT.SHOW_DAILY)
    end
    if Logic:Get("Devil"):getActiveId() ~= nil and tonumber(Logic:Get("System"):GetTimeStr("%H")) >= 9 then
      Logic:Get("Devil"):PostAllRank()
    end
  end
end
function StartIndicatorView()
  SceneHelper:pushPrompt("NetConnTip")
end
function StopIndicatorView()
  SceneHelper:removePrompt(nil, "NetConnTip")
end
function CloseCallboard()
  SceneHelper:removePrompt(nil, "Callboard")
end
function Transmit(A0_100, A1_101, A2_102)
  local L3_103
  if pcall(function()
    _UPVALUE0_ = json.decode(_UPVALUE1_)
  end) and type(L3_103) == "table" and L3_103.korAppUserId ~= nil then
    Logic:Get("System"):SetKorAppUserId(L3_103.korAppUserId)
  end
end
function OnDeviceToken(A0_104, A1_105)
  Logic:Get("System"):SetDeviceToken(A0_104, A1_105)
end
function OnKeyboardInput(A0_106)
  local L1_107, L2_108, L3_109, L4_110, L5_111, L6_112, L7_113, L8_114, L9_115, L10_116, L11_117, L12_118, L13_119, L14_120, L15_121
  L1_107 = CCDirector
  L2_108 = L1_107
  L1_107 = L1_107.sharedDirector
  L1_107 = L1_107(L2_108)
  L2_108 = L1_107
  L1_107 = L1_107.getOpenGLView
  L1_107 = L1_107(L2_108)
  L3_109 = L1_107
  L2_108 = L1_107.getDesignResolutionSize
  L2_108 = L2_108(L3_109)
  L4_110 = L1_107
  L3_109 = L1_107.getFrameSize
  L3_109 = L3_109(L4_110)
  L4_110 = L2_108.width
  L5_111 = L3_109.width
  L4_110 = L4_110 / L5_111
  L5_111 = L2_108.height
  L6_112 = L3_109.height
  L5_111 = L5_111 / L6_112
  L6_112 = math
  L6_112 = L6_112.max
  L7_113 = L4_110
  L8_114 = L5_111
  L6_112 = L6_112(L7_113, L8_114)
  L7_113 = math
  L7_113 = L7_113.min
  L8_114 = L4_110
  L9_115 = L5_111
  L7_113 = L7_113(L8_114, L9_115)
  L8_114 = L7_113 / L6_112
  L9_115 = CCDirector
  L10_116 = L9_115
  L9_115 = L9_115.sharedDirector
  L9_115 = L9_115(L10_116)
  L10_116 = L9_115
  L9_115 = L9_115.getRunningScene
  L9_115 = L9_115(L10_116)
  L10_116 = L9_115
  L9_115 = L9_115.getChildByTag
  L11_117 = 999
  L9_115 = L9_115(L10_116, L11_117)
  L10_116 = L9_115
  L9_115 = L9_115.getChildByTag
  L11_117 = 999
  L9_115 = L9_115(L10_116, L11_117)
  if L9_115 == nil then
    return
  end
  L10_116 = Logic
  L11_117 = L10_116
  L10_116 = L10_116.Get
  L12_118 = "ControlsInfo"
  L10_116 = L10_116(L11_117, L12_118)
  L10_116 = L10_116.y
  if L10_116 ~= nil then
    L10_116 = Logic
    L11_117 = L10_116
    L10_116 = L10_116.Get
    L12_118 = "ControlsInfo"
    L10_116 = L10_116(L11_117, L12_118)
    L10_116 = L10_116.height
  elseif L10_116 == nil then
    return
  end
  L10_116 = L2_108.height
  L10_116 = L10_116 * 0.5
  L10_116 = L10_116 * L8_114
  if A0_106 ~= 0 then
    L11_117 = Logic
    L12_118 = L11_117
    L11_117 = L11_117.Get
    L13_119 = "ControlsInfo"
    L11_117 = L11_117(L12_118, L13_119)
    L11_117 = L11_117.y
    if L10_116 < L11_117 then
      return
    end
  end
  L11_117 = 0
  if A0_106 == -1 then
    L12_118 = math
    L12_118 = L12_118.max
    L13_119 = L2_108.height
    L13_119 = L13_119 * 0.6
    L13_119 = L13_119 * L8_114
    L14_120 = Logic
    L15_121 = L14_120
    L14_120 = L14_120.Get
    L14_120 = L14_120(L15_121, "ControlsInfo")
    L14_120 = L14_120.y
    L13_119 = L13_119 - L14_120
    L14_120 = 0
    L12_118 = L12_118(L13_119, L14_120)
    L11_117 = L12_118
  else
    L12_118 = math
    L12_118 = L12_118.max
    L13_119 = L2_108.height
    L14_120 = L3_109.height
    L14_120 = A0_106 / L14_120
    L13_119 = L13_119 * L14_120
    L14_120 = Logic
    L15_121 = L14_120
    L14_120 = L14_120.Get
    L14_120 = L14_120(L15_121, "ControlsInfo")
    L14_120 = L14_120.y
    L13_119 = L13_119 - L14_120
    L14_120 = 0
    L12_118 = L12_118(L13_119, L14_120)
    L11_117 = L12_118
  end
  L12_118 = Logic
  L13_119 = L12_118
  L12_118 = L12_118.Get
  L14_120 = "ControlsInfo"
  L12_118 = L12_118(L13_119, L14_120)
  L12_118 = L12_118.y
  L13_119 = Logic
  L14_120 = L13_119
  L13_119 = L13_119.Get
  L15_121 = "ControlsInfo"
  L13_119 = L13_119(L14_120, L15_121)
  L13_119 = L13_119.height
  L12_118 = L12_118 + L13_119
  L13_119 = L12_118 + L11_117
  L14_120 = L2_108.height
  if L13_119 > L14_120 then
    L13_119 = L2_108.height
    L11_117 = L13_119 - L12_118
  end
  L13_119 = CCArray
  L14_120 = L13_119
  L13_119 = L13_119.create
  L13_119 = L13_119(L14_120)
  L15_121 = L13_119
  L14_120 = L13_119.addObject
  L14_120(L15_121, CCMoveTo:create(0.15, ccp(0, A0_106 == 0 and 0 or L11_117)))
  L14_120 = CCSequence
  L15_121 = L14_120
  L14_120 = L14_120.create
  L14_120 = L14_120(L15_121, L13_119)
  L15_121 = CCRepeat
  L15_121 = L15_121.create
  L15_121 = L15_121(L15_121, L14_120, 1)
  L9_115:runAction(L15_121)
end
function OnAPPItemBuyed(A0_122)
  Logic:Get("Sdk"):OnAPPItemBuyed(A0_122)
end
function OnProcess()
  Singleton(GameRoot):OnTick()
end
function OnOperateEvent(A0_123, A1_124, A2_125)
  return Singleton(GameRoot):OnOperateEvent(A0_123, A1_124, A2_125)
end
function ChangeGameViewSize(A0_126, A1_127)
  return Singleton(GameRoot):ChangeGameViewSize(A0_126, A1_127)
end
function CheckOperate()
  Singleton(GameRoot):CheckOperate()
end
function CheckMemory()
  Singleton(GameRoot):CheckMemory()
end
function SetSdkFuncStatus(A0_128, A1_129)
  Logic:Get("Sdk"):SetSdkFuncStatus(A0_128, A1_129)
end
function SetFBShareRst(A0_130)
  Logic:Get("Sdk"):SetFBShareRst(A0_130)
end
function SetWeixinShareRst(A0_131)
  Logic:Get("Sdk"):SetWeixinShareRst(A0_131)
end
function OnSwitchConsole()
  DlgTmpl:Switch("Console")
end
function CheckNetworkStatus()
  CReflectSystem:GetSingleton():FireEvent(TwEvtArgs(REFLECT_EVENT_CHECK_NETWORK))
end
function OnAvaliableStorageSize(A0_132)
  Logic:Get("System"):SetAvaliableStorageSize(A0_132)
end
function OnNetworkStatusChanged(A0_133, A1_134)
  Singleton(NetMgr):SetNetType(A0_133)
end
function OnNetworkConnect(A0_135)
  Singleton(NetMgr):OnNetworkConnect(A0_135)
end
function OnNetworkRead(A0_136)
  Singleton(NetMgr):OnNetworkRead(A0_136)
end
function OnNetworkClosed()
  Singleton(NetMgr):OnNetworkClosed()
end
function OnHttpRespose(A0_137, A1_138)
  Singleton(NetHttp):OnRespose(A0_137, A1_138)
end
function OnHttpError(A0_139, A1_140)
  Singleton(NetHttp):OnError(A0_139, A1_140)
end
