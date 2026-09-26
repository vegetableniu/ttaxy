module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
require("SceneHelper")
BTN_ON_PICTURE = "images/public/selcet2.png"
BTN_OFF_PICTURE = "images/public/selcet1.png"
function prototype.initialize(A0_0)
  super.initialize(A0_0)
end
function prototype.onNodeLoaded(A0_1, A1_2, A2_3)
end
function prototype.onBtnReturn(A0_4, A1_5, A2_6)
  SceneHelper:popScene()
end
function prototype.onBtnBackgroundMusic(A0_7, A1_8, A2_9)
  local L3_10
  L3_10 = CVariableSystem
  L3_10 = L3_10.GetSingleton
  L3_10 = L3_10(L3_10)
  L3_10 = L3_10.GetSysVariable
  L3_10 = L3_10(L3_10, GV_CLOSE_MUSIC)
  L3_10 = "1" ~= L3_10
  CVariableSystem:GetSingleton():SetSysVariable(GV_CLOSE_MUSIC, L3_10 and 1 or 0)
  CVariableSystem:GetSingleton():SetSysVariable(GV_CLOSE_SOUND, L3_10 and 1 or 0)
  Logic:Get("System"):SaveSysVariable()
  Logic:Get("BGSound"):ResetBGMusic(L3_10)
  A0_7:RefreshMusic()
end
function prototype.onBtnScreenLock(A0_11, A1_12, A2_13)
  CVariableSystem:GetSingleton():SetSysVariable(GV_KEEP_SCREEN_ON, "1" ~= CVariableSystem:GetSingleton():GetSysVariable(GV_KEEP_SCREEN_ON) and 1 or 0)
  CVariableSystem:GetSingleton():SaveSysVariable()
  Logic:Get("EnvLogic"):SetKeepScreenOnState("1" ~= CVariableSystem:GetSingleton():GetSysVariable(GV_KEEP_SCREEN_ON) and 0 or 1)
  A0_11:RefreshScreenLock()
end
function prototype.onBtnPush(A0_14, A1_15, A2_16)
  Logic:Get("System"):SetSysVariableMisc("GV_PLAY_UPGRADE_ANI", Logic:Get("System"):IsUpgradeAniEnabled() and "0" or "1")
  A0_14:RefreshPush(Logic:Get("System"):IsUpgradeAniEnabled())
end
function prototype.RefreshMusic(A0_17)
  local L1_18, L2_19
  L1_18 = CVariableSystem
  L2_19 = L1_18
  L1_18 = L1_18.GetSingleton
  L1_18 = L1_18(L2_19)
  L2_19 = L1_18
  L1_18 = L1_18.GetSysVariable
  L1_18 = L1_18(L2_19, GV_CLOSE_MUSIC)
  L1_18 = "1" == L1_18
  L2_19 = CCScale9Sprite
  L2_19 = L2_19.create
  L2_19 = L2_19(L2_19, L1_18 and BTN_OFF_PICTURE or BTN_ON_PICTURE)
  if nil == L2_19 then
    return
  end
  A0_17.btnBackgroundMusic:setBackgroundSpriteForState(L2_19, CCControlStateNormal)
end
function prototype.RefreshScreenLock(A0_20)
  local L1_21, L2_22, L3_23
  L1_21 = CVariableSystem
  L2_22 = L1_21
  L1_21 = L1_21.GetSingleton
  L1_21 = L1_21(L2_22)
  L2_22 = L1_21
  L1_21 = L1_21.GetSysVariable
  L3_23 = GV_KEEP_SCREEN_ON
  L1_21 = L1_21(L2_22, L3_23)
  L2_22 = "" == L1_21 or "1" == L1_21
  L3_23 = CCScale9Sprite
  L3_23 = L3_23.create
  L3_23 = L3_23(L3_23, L2_22 and BTN_ON_PICTURE or BTN_OFF_PICTURE)
  if nil == L3_23 then
    return
  end
  A0_20.btnScreenLock:setBackgroundSpriteForState(L3_23, CCControlStateNormal)
end
function prototype.RefreshPush(A0_24, A1_25)
  local L2_26
  L2_26 = CCScale9Sprite
  L2_26 = L2_26.create
  L2_26 = L2_26(L2_26, A1_25 and BTN_ON_PICTURE or BTN_OFF_PICTURE)
  if nil == L2_26 then
    return
  end
  A0_24.btnPush:setBackgroundSpriteForState(L2_26, CCControlStateNormal)
  L2_26 = CCScale9Sprite:create(A1_25 and BTN_ON_PICTURE or BTN_OFF_PICTURE)
  if nil == L2_26 then
    return
  end
  A0_24.btnPush:setBackgroundSpriteForState(L2_26, CCControlStateHighlighted)
end
function prototype.updatePush(A0_27)
  local L1_28
end
function prototype.onEnter(A0_29)
  A0_29.setSystemTitle:setString(TwGetStr(103133))
  A0_29.sound:setString(TwGetStr(103131))
  A0_29.sleep:setString(TwGetStr(103132))
  A0_29.push:setString("\229\141\135\231\186\167\229\138\168\231\148\187")
  A0_29.appId:setVisible(Logic:Get("System"):IsOperator("ilovewebgame"))
  A0_29.appId:setString(TwGetStr(10155) .. (Logic:Get("System"):GetKorAppUserId() or ""))
  A0_29.closeTitle:setStyle(kCCLabelTTFStyleOutline, ccc3(0, 0, 0))
  A0_29.setSystemTitle:setStyle(kCCLabelTTFStyleOutline, ccc3(0, 0, 0))
  A0_29.setSystemTitle:setColor(ccColor3B(187, 255, 0))
  A0_29:RefreshMusic()
  A0_29:RefreshScreenLock()
  A0_29:RefreshPush(Logic:Get("System"):IsUpgradeAniEnabled())
end
