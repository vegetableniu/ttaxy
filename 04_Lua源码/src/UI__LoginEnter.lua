local L0_0
L0_0 = module
L0_0((...), package.seeall)
L0_0 = require
L0_0("SceneHelper")
L0_0 = require
L0_0("TableViewEx")
L0_0 = require
L0_0("Logic.SureConfirm")
L0_0 = Tw
L0_0 = L0_0.Controller
L0_0 = L0_0.prototype
L0_0 = L0_0.extend
L0_0 = L0_0(L0_0)
prototype = L0_0
L0_0 = 540
function prototype.initialize(A0_1, ...)
  super.initialize(A0_1, ...)
  Logic:Get("Login"):On(Logic.Login.EVT.SET_LOGIN_NOTICE, A0_1:Event("setLoginNotice"))
  Logic:Get("Account"):On(Logic.Account.EVT.GET_SERVERSTART, A0_1:Event("onGetServerSatrt"))
  Logic:Get("Account"):On(Logic.Account.EVT.LOGIN_SUCCEED, A0_1:Event("onLoginSucceed"))
  Logic:Get("Login"):On(Logic.Login.EVT.SERVER_CHANGE, A0_1:Event("onServerChanged"))
  Logic:Get("Account"):On(Logic.Account.EVT.LOGOUT, A0_1:Event("onLogout"))
  Logic:Get("Login"):On(Logic.Login.EVT.RESET_LOGIN_BTN, A0_1:Event("onResetLoginBtn"))
end
function prototype.dispose(A0_3, ...)
  super.dispose(A0_3)
end
function prototype.onEnter(A0_5, A1_6, A2_7)
  local L3_8, L4_9, L5_10, L6_11, L7_12
  L3_8 = Logic
  L4_9 = L3_8
  L3_8 = L3_8.Get
  L5_10 = "Account"
  L3_8 = L3_8(L4_9, L5_10)
  L4_9 = L3_8
  L3_8 = L3_8.inquireServerInfo
  L3_8(L4_9)
  L3_8 = Logic
  L4_9 = L3_8
  L3_8 = L3_8.Get
  L5_10 = "BGSound"
  L3_8 = L3_8(L4_9, L5_10)
  L4_9 = L3_8
  L3_8 = L3_8.PlayServerMusic
  L3_8(L4_9)
  A0_5.showArea = false
  A0_5.areaIndex = nil
  A0_5.needAnonymityLogin = false
  L3_8 = CCSprite
  L4_9 = L3_8
  L3_8 = L3_8.create
  L5_10 = _UPVALUE0_
  L3_8 = L3_8(L4_9, L5_10)
  if nil ~= L3_8 then
    L5_10 = L3_8
    L4_9 = L3_8.getTextureRect
    L4_9 = L4_9(L5_10)
    if nil ~= L4_9 then
      L5_10 = L4_9.size
      if nil ~= L5_10 then
        L5_10 = A0_5.btnEnter
        L6_11 = L5_10
        L5_10 = L5_10.setPreferredSize
        L7_12 = L4_9.size
        L5_10(L6_11, L7_12)
      end
    end
  end
  L4_9 = Logic
  L5_10 = L4_9
  L4_9 = L4_9.Get
  L6_11 = "Login"
  L4_9 = L4_9(L5_10, L6_11)
  L5_10 = L4_9
  L4_9 = L4_9.ReadRecordServerIdx
  L4_9(L5_10)
  L4_9 = Logic
  L5_10 = L4_9
  L4_9 = L4_9.Get
  L6_11 = "Login"
  L4_9 = L4_9(L5_10, L6_11)
  L5_10 = L4_9
  L4_9 = L4_9.GetServerInfoByIdx
  L6_11 = 1
  L4_9 = L4_9(L5_10, L6_11)
  L5_10 = Logic
  L6_11 = L5_10
  L5_10 = L5_10.Get
  L7_12 = "Login"
  L5_10 = L5_10(L6_11, L7_12)
  L6_11 = L5_10
  L5_10 = L5_10.GetServerInfo
  L7_12 = 1
  L5_10 = L5_10(L6_11, L7_12)
  L6_11 = Logic
  L7_12 = L6_11
  L6_11 = L6_11.Get
  L6_11 = L6_11(L7_12, "Login")
  L7_12 = L6_11
  L6_11 = L6_11.GetRecordServerByIdx
  L6_11 = L6_11(L7_12, 1)
  if L6_11 then
    L7_12 = tonumber
    L7_12 = L7_12(L6_11.aa)
  else
    L7_12 = L7_12 or nil
  end
  A0_5.server = L7_12 and Logic:Get("Login"):GetServerInfo(L7_12) and (L7_12 and Logic:Get("Login"):GetServerInfo(L7_12)).server or nil ~= L5_10 and L5_10.server or nil ~= L4_9 and L4_9.server or 1
  A0_5:selServer(A0_5.server)
  Logic:Get("Login"):initLoggedServer()
  A0_5:createServerLst()
  Logic:Get("Login"):SetSelectServer(A0_5.server)
  A0_5:AutoLogin()
  A0_5:ShowAccount()
  A0_5.imgAreaBg:setVisible(false)
  A0_5:RefrashSelServer()
  A0_5.staCurrentArea:setStyle(kCCLabelTTFStyleOutline)
  A0_5.staCurrentState:setStyle(kCCLabelTTFStyleOutline)
  A0_5.bgClicked:setEnabled(false)
  if CTwUtil:GetPlatform() == CTwUtil.E_TP_ANDROID and not CheckDeviceIsSupportETC1() then
    log4misc:warn("This device is not support ETC1 texture format")
  end
  Logic:Get("Login"):setCallBoardImg(false)
  Logic:Get("Login"):openCallboard()
  if not Logic:Get("System"):IsOperator("ifreeteam") and not Logic:Get("System"):IsOperator("tstore") or not not (1 == Logic:Get("System"):GetSysVariableMisc("AGREEMENT")) then
    return
  end
  SceneHelper:pushPrompt("Agreement", nil, A0_5.rootNode)
end
function prototype.AutoLogin(A0_13)
  local L1_14, L2_15
  L1_14 = Logic
  L2_15 = L1_14
  L1_14 = L1_14.Get
  L1_14 = L1_14(L2_15, "Login")
  L2_15 = L1_14
  L1_14 = L1_14.ReadRecordServerIdx
  L1_14(L2_15)
  L1_14 = Logic
  L2_15 = L1_14
  L1_14 = L1_14.Get
  L1_14 = L1_14(L2_15, "System")
  L2_15 = L1_14
  L1_14 = L1_14.IsCloseAutoLogin
  L1_14 = L1_14(L2_15)
  if L1_14 then
    return
  end
  L1_14 = Logic
  L2_15 = L1_14
  L1_14 = L1_14.Get
  L1_14 = L1_14(L2_15, "Account")
  L2_15 = L1_14
  L1_14 = L1_14.GetAutoLogin
  L1_14 = L1_14(L2_15)
  if not L1_14 then
    return
  end
  L1_14 = Logic
  L2_15 = L1_14
  L1_14 = L1_14.Get
  L1_14 = L1_14(L2_15, "Login")
  L2_15 = L1_14
  L1_14 = L1_14.GetRecordServerByIdx
  L1_14 = L1_14(L2_15, 1)
  if nil == L1_14 then
    return
  end
  L2_15 = Logic
  L2_15 = L2_15.Get
  L2_15 = L2_15(L2_15, "System")
  L2_15 = L2_15.IsSelfAccLogin
  L2_15 = L2_15(L2_15)
  if not L2_15 then
    L2_15 = Logic
    L2_15 = L2_15.Get
    L2_15 = L2_15(L2_15, "System")
    L2_15 = L2_15.IsSelfAccUI
    L2_15 = L2_15(L2_15)
    if not L2_15 then
      L2_15 = {}
      L2_15.AutoLogin = true
      Logic:Get("EnvLogic"):Login(nil, nil, json.encode(L2_15))
    end
    return
  end
  L2_15 = L1_14.bb
  if L2_15 then
    L2_15 = L1_14.bb
    if L2_15 ~= "" then
      L2_15 = L1_14.dd
      if L2_15 then
        A0_13.needAnonymityLogin = true
      else
        L2_15 = Logic
        L2_15 = L2_15.Get
        L2_15 = L2_15(L2_15, "Account")
        L2_15 = L2_15.SetNickName
        L2_15(L2_15, L1_14.bb)
        L2_15 = Logic
        L2_15 = L2_15.Get
        L2_15 = L2_15(L2_15, "Account")
        L2_15 = L2_15.SetAccName
        L2_15(L2_15, L1_14.bb)
        L2_15 = Logic
        L2_15 = L2_15.Get
        L2_15 = L2_15(L2_15, "Account")
        L2_15 = L2_15.SetPassword
        L2_15(L2_15, L1_14.cc)
        L2_15 = Logic
        L2_15 = L2_15.Get
        L2_15 = L2_15(L2_15, "Account")
        L2_15 = L2_15.Login
        L2_15(L2_15, false)
        L2_15 = L1_14.nickName
        if nil ~= L2_15 then
          L2_15 = Logic
          L2_15 = L2_15.Get
          L2_15 = L2_15(L2_15, "Account")
          L2_15 = L2_15.SetNickName
          L2_15(L2_15, L1_14.nickName)
        end
      end
    end
  end
end
function prototype.ShowAccount(A0_16)
  local L1_17, L2_18, L3_19
  L1_17 = Logic
  L2_18 = L1_17
  L1_17 = L1_17.Get
  L3_19 = "Account"
  L1_17 = L1_17(L2_18, L3_19)
  L2_18 = L1_17
  L1_17 = L1_17.GetUserId
  L1_17 = L1_17(L2_18)
  L2_18 = nil ~= L1_17 and "" ~= L1_17
  L3_19 = Logic
  L3_19 = L3_19.Get
  L3_19 = L3_19(L3_19, "Account")
  L3_19 = L3_19.GetNickName
  L3_19 = L3_19(L3_19)
  L3_19 = L3_19 or ""
  A0_16.imgAccountBg:setVisible(L2_18 and "" ~= L3_19 and not Logic:Get("Account"):GetIsVisitorType())
  A0_16.staAccount:setVisible(L2_18 and "" ~= L3_19 and not Logic:Get("Account"):GetIsVisitorType())
  A0_16.staAccount:setString(L3_19)
  A0_16.btnSwap:setVisible(L2_18 and not (Logic:Get("System"):IsCloseAutoLogin() and not Logic:Get("System"):IsAnonymityLogin()))
  A0_16.btnLogin:setVisible(not (Logic:Get("System"):IsCloseAutoLogin() and not Logic:Get("System"):IsAnonymityLogin()) and not L2_18)
end
function prototype.RefrashSelServer(A0_20)
  local L1_21, L2_22, L3_23, L4_24, L5_25, L6_26
  L1_21 = Logic
  L2_22 = L1_21
  L1_21 = L1_21.Get
  L3_23 = "Login"
  L1_21 = L1_21(L2_22, L3_23)
  L2_22 = L1_21
  L1_21 = L1_21.GetSelextServer
  L1_21 = L1_21(L2_22)
  A0_20.server = L1_21
  L1_21 = Logic
  L2_22 = L1_21
  L1_21 = L1_21.Get
  L3_23 = "Login"
  L1_21 = L1_21(L2_22, L3_23)
  L2_22 = L1_21
  L1_21 = L1_21.GetServerInfo
  L3_23 = A0_20.server
  L1_21 = L1_21(L2_22, L3_23)
  L2_22 = A0_20.staCurrentArea
  L3_23 = L2_22
  L2_22 = L2_22.setString
  if L1_21 then
    L4_24 = L1_21.name
  else
    L4_24 = L4_24 or ""
  end
  L2_22(L3_23, L4_24)
  L2_22 = Logic
  L3_23 = L2_22
  L2_22 = L2_22.Get
  L4_24 = "Account"
  L2_22 = L2_22(L3_23, L4_24)
  L3_23 = L2_22
  L2_22 = L2_22.GetServerFPSById
  L4_24 = A0_20.server
  L2_22 = L2_22(L3_23, L4_24)
  L3_23 = ""
  L4_24 = 0
  L5_25 = false
  if L2_22 then
    L6_26 = tonumber
    L6_26 = L6_26(L2_22)
    if L6_26 then
      L6_26 = tonumber
      L6_26 = L6_26(L2_22)
      L2_22 = L6_26
      if -10 == L2_22 then
        L4_24 = 102207
        L3_23 = "\231\187\180\230\138\164\228\184\173"
        L5_25 = true
      elseif -1 == L2_22 then
        L4_24 = 102218
        L5_25 = true
      elseif L2_22 >= 0 and L2_22 < 10 then
        L4_24 = 102208
      elseif L2_22 >= 10 and L2_22 < 25 then
        L4_24 = 102209
      elseif L2_22 >= 25 then
        L4_24 = 102211
      end
    end
  end
  if L5_25 then
    L6_26 = ccc3
    L6_26 = L6_26(128, 128, 128)
  elseif not L6_26 then
    L6_26 = ccc3
    L6_26 = L6_26(0, 255, 0)
  end
  A0_20.staCurrentArea:setColor(L6_26)
  A0_20.staCurrentState:setColor(L6_26)
  A0_20.staCurrentState:setString(L3_23 ~= "" and L3_23 or L4_24 > 0 and TwGetStr(L4_24) or "")
end
function prototype.onGetServerSatrt(A0_27)
  A0_27.tableViewControl:RequireUpdateWithoutAnimat(nil, true)
  A0_27:RefrashSelServer()
end
function prototype.onServerChanged(A0_28)
  A0_28.showArea = false
  A0_28.imgAreaBg:setVisible(false)
  A0_28.bgClicked:setEnabled(false)
  A0_28.tableViewControl:RequireUpdate(1)
  A0_28:RefrashSelServer()
  A0_28:btnCanUse(true)
end
function prototype.onLoginSucceed(A0_29)
  A0_29:ShowAccount()
  Logic:Get("Login"):initLoggedServer()
  A0_29.tableViewControl:RequireUpdate(1)
end
function prototype.btnCanUse(A0_30, A1_31)
  A0_30.btnEnter:setEnabled(A1_31)
  A0_30.btnSwap:setEnabled(A1_31)
  A0_30.btnSelArea:setEnabled(A1_31)
  A0_30.btnSelectIcon:setEnabled(A1_31)
end
function prototype.onResetLoginBtn(A0_32)
  A0_32:btnCanUse(true)
end
function prototype.onBtnSelectIcon(A0_33, A1_34, A2_35)
  Logic:Get("Account"):inquireServerInfo()
  A0_33:btnCanUse(false)
  A0_33.showArea = true
  A0_33.bgClicked:setEnabled(true)
  A0_33.imgAreaBg:setVisible(true)
  A0_33.tableViewControl:RequireUpdate(1)
end
function prototype.onBtnSelArea(A0_36, A1_37, A2_38)
  A0_36:btnCanUse(false)
  A0_36.showArea = true
  A0_36.bgClicked:setEnabled(true)
  A0_36.imgAreaBg:setVisible(true)
  A0_36.tableViewControl:RequireUpdate(1)
end
function prototype.actionFinish(A0_39)
  Logic:Get("Account"):inquireServerInfo()
end
function prototype.setLoginNotice(A0_40, A1_41)
  A0_40.staNotice:setString(A1_41)
end
function prototype.selServer(A0_42, A1_43)
  if nil == Logic:Get("Login"):GetServerInfo(A1_43) then
    return false
  end
  Logic:Get("Login"):GetLoginInfo().server = Logic:Get("Login"):GetServerInfo(A1_43).server
  Logic:Get("Login"):GetLoginInfo().addr = Logic:Get("Login"):GetServerInfo(A1_43).addr
  Logic:Get("Login"):GetLoginInfo().port = Logic:Get("Login"):GetServerInfo(A1_43).port
  Logic:Get("Login"):GetLoginInfo().name = Logic:Get("Login"):GetServerInfo(A1_43).name
  Logic:Get("Login"):GetLoginInfo().operator = Logic:Get("System"):GetOperatorId()
  Singleton(NetMgr):SetUrlAndPort(Logic:Get("Login"):GetLoginInfo().addr, Logic:Get("Login"):GetLoginInfo().port)
end
function prototype.onBtnEnterGame(A0_44, A1_45, A2_46)
  local L3_47, L4_48, L5_49
  L4_48 = A0_44
  L3_47 = A0_44.selServer
  L5_49 = A0_44.server
  L3_47(L4_48, L5_49)
  L3_47 = Logic
  L4_48 = L3_47
  L3_47 = L3_47.Get
  L5_49 = "Account"
  L3_47 = L3_47(L4_48, L5_49)
  L4_48 = L3_47
  L3_47 = L3_47.GetServerFPSById
  L5_49 = A0_44.server
  L3_47 = L3_47(L4_48, L5_49)
  if L3_47 then
    L4_48 = tonumber
    L5_49 = L3_47
    L4_48 = L4_48(L5_49)
    if L4_48 then
      L4_48 = tonumber
      L5_49 = L3_47
      L4_48 = L4_48(L5_49)
      L3_47 = L4_48
      if -10 == L3_47 then
        L4_48 = Prompt
        L5_49 = L4_48
        L4_48 = L4_48.Fail
        L4_48(L5_49, "\230\156\141\229\138\161\229\153\168\231\187\180\230\138\164\228\184\173\239\188\140\232\175\183\231\168\141\229\144\142\231\153\187\229\189\149\227\128\130")
        L4_48 = Logic
        L5_49 = L4_48
        L4_48 = L4_48.Get
        L4_48 = L4_48(L5_49, "Account")
        L5_49 = L4_48
        L4_48 = L4_48.inquireServerInfo
        L4_48(L5_49)
        return
      end
      if -1 == L3_47 then
        L4_48 = Prompt
        L5_49 = L4_48
        L4_48 = L4_48.Confirm
        L4_48(L5_49, A0_44, 103001, 102219)
        L4_48 = Logic
        L5_49 = L4_48
        L4_48 = L4_48.Get
        L4_48 = L4_48(L5_49, "Account")
        L5_49 = L4_48
        L4_48 = L4_48.inquireServerInfo
        L4_48(L5_49)
        return
      end
    end
  end
  L4_48 = Logic
  L5_49 = L4_48
  L4_48 = L4_48.Get
  L4_48 = L4_48(L5_49, "System")
  L5_49 = L4_48
  L4_48 = L4_48.IsCloseAutoLogin
  L4_48 = L4_48(L5_49)
  if L4_48 then
    L4_48 = Logic
    L5_49 = L4_48
    L4_48 = L4_48.Get
    L4_48 = L4_48(L5_49, "System")
    L5_49 = L4_48
    L4_48 = L4_48.IsSelfAccUI
    L4_48 = L4_48(L5_49)
    if not L4_48 then
      L4_48 = Logic
      L5_49 = L4_48
      L4_48 = L4_48.Get
      L4_48 = L4_48(L5_49, "System")
      L5_49 = L4_48
      L4_48 = L4_48.IsSelfAccLogin
      L4_48 = L4_48(L5_49)
      if not L4_48 then
        L4_48 = Logic
        L5_49 = L4_48
        L4_48 = L4_48.Get
        L4_48 = L4_48(L5_49, "EnvLogic")
        L5_49 = L4_48
        L4_48 = L4_48.Login
        L4_48(L5_49)
        return
      end
    end
    L4_48 = Logic
    L5_49 = L4_48
    L4_48 = L4_48.Get
    L4_48 = L4_48(L5_49, "Login")
    L5_49 = L4_48
    L4_48 = L4_48.removeAni
    L4_48(L5_49, A0_44.rootNode, "LoginEnter", Logic.Login.LOAD_STAGE.ACCOUNT)
    return
  end
  L4_48 = Logic
  L5_49 = L4_48
  L4_48 = L4_48.Get
  L4_48 = L4_48(L5_49, "Account")
  L5_49 = L4_48
  L4_48 = L4_48.GetUserId
  L4_48 = L4_48(L5_49)
  if L4_48 then
    L4_48 = Logic
    L5_49 = L4_48
    L4_48 = L4_48.Get
    L4_48 = L4_48(L5_49, "Account")
    L5_49 = L4_48
    L4_48 = L4_48.GetUserId
    L4_48 = L4_48(L5_49)
    if L4_48 ~= "" then
      L4_48 = Logic
      L5_49 = L4_48
      L4_48 = L4_48.Get
      L4_48 = L4_48(L5_49, "Account")
      L5_49 = L4_48.HasFreshTicketForServer
      L5_49 = L5_49(L4_48, A0_44.server)
      if L5_49 then
        L5_49 = L4_48.QueryRole
        L5_49(L4_48)
      else
        L5_49 = L4_48.RefreshLoginTicket
        L5_49(L4_48, function(A0_50)
          if A0_50 then
            _UPVALUE0_:QueryRole()
          else
            _UPVALUE1_:btnCanUse(true)
          end
        end)
      end
      return
    end
  end
  L4_48 = Logic
  L5_49 = L4_48
  L4_48 = L4_48.Get
  L4_48 = L4_48(L5_49, "Account")
  L5_49 = L4_48
  L4_48 = L4_48.NeedAutoEnterGame
  L4_48(L5_49, false)
  L4_48 = Logic
  L5_49 = L4_48
  L4_48 = L4_48.Get
  L4_48 = L4_48(L5_49, "System")
  L5_49 = L4_48
  L4_48 = L4_48.IsAnonymityLogin
  L4_48 = L4_48(L5_49)
  if L4_48 then
    L4_48 = Logic
    L5_49 = L4_48
    L4_48 = L4_48.Get
    L4_48 = L4_48(L5_49, "System")
    L5_49 = L4_48
    L4_48 = L4_48.IsSelfAccLogin
    L4_48 = L4_48(L5_49)
    if L4_48 then
      L4_48 = Logic
      L5_49 = L4_48
      L4_48 = L4_48.Get
      L4_48 = L4_48(L5_49, "Account")
      L5_49 = L4_48
      L4_48 = L4_48.AnonymityLogin
      L4_48(L5_49)
      return
    end
    L4_48 = Logic
    L5_49 = L4_48
    L4_48 = L4_48.Get
    L4_48 = L4_48(L5_49, "System")
    L5_49 = L4_48
    L4_48 = L4_48.GetSysVariableMisc
    L4_48 = L4_48(L5_49, "AnonymityAcc")
    L5_49 = Logic
    L5_49 = L5_49.Get
    L5_49 = L5_49(L5_49, "System")
    L5_49 = L5_49.GetSysVariableMisc
    L5_49 = L5_49(L5_49, "AnonymityPwd")
    Logic:Get("EnvLogic"):AnonymityLogin(L4_48, L5_49)
  else
    L5_49 = A0_44
    L4_48 = A0_44.onBtnLogin
    L4_48(L5_49)
  end
end
function prototype.onBtnSwap(A0_51, A1_52, A2_53)
  if Logic:Get("System"):IsCloseAutoLogin() then
    return
  end
  if nil ~= Logic:Get("Account"):GetUserId() and Logic:Get("Account"):GetUserId() ~= "" then
    if not Logic:Get("System"):IsSelfAccLogin() then
      Logic:Get("EnvLogic"):Logout()
    end
    A0_51:onLogout()
    return
  end
end
function prototype.onLogout(A0_54)
  Logic:Get("Account"):SetNickName("")
  Logic:Get("Account"):SetAccName("")
  Logic:Get("Account"):SetPassword("")
  Logic:Get("Account"):SetUserId("")
  A0_54:ShowAccount()
end
function prototype.onSelectLogin(A0_55)
  A0_55:onBtnLogin()
end
function prototype.onBtnLogin(A0_56)
  local L1_57, L2_58
  L1_57 = Logic
  L2_58 = L1_57
  L1_57 = L1_57.Get
  L1_57 = L1_57(L2_58, "Account")
  L2_58 = L1_57
  L1_57 = L1_57.NeedAutoEnterGame
  L1_57(L2_58, false)
  L2_58 = A0_56
  L1_57 = A0_56.selServer
  L1_57(L2_58, A0_56.server)
  L1_57 = Logic
  L2_58 = L1_57
  L1_57 = L1_57.Get
  L1_57 = L1_57(L2_58, "System")
  L2_58 = L1_57
  L1_57 = L1_57.IsCloseAutoLogin
  L1_57 = L1_57(L2_58)
  if L1_57 then
    L1_57 = Logic
    L2_58 = L1_57
    L1_57 = L1_57.Get
    L1_57 = L1_57(L2_58, "System")
    L2_58 = L1_57
    L1_57 = L1_57.IsAnonymityLogin
    L1_57 = L1_57(L2_58)
    if not L1_57 then
      return
    end
    L1_57 = Logic
    L2_58 = L1_57
    L1_57 = L1_57.Get
    L1_57 = L1_57(L2_58, "System")
    L2_58 = L1_57
    L1_57 = L1_57.IsSelfAccLogin
    L1_57 = L1_57(L2_58)
    if L1_57 then
      L1_57 = Logic
      L2_58 = L1_57
      L1_57 = L1_57.Get
      L1_57 = L1_57(L2_58, "Account")
      L2_58 = L1_57
      L1_57 = L1_57.AnonymityLogin
      L1_57(L2_58)
      return
    end
    L1_57 = Logic
    L2_58 = L1_57
    L1_57 = L1_57.Get
    L1_57 = L1_57(L2_58, "System")
    L2_58 = L1_57
    L1_57 = L1_57.GetSysVariableMisc
    L1_57 = L1_57(L2_58, "AnonymityAcc")
    L2_58 = Logic
    L2_58 = L2_58.Get
    L2_58 = L2_58(L2_58, "System")
    L2_58 = L2_58.GetSysVariableMisc
    L2_58 = L2_58(L2_58, "AnonymityPwd")
    Logic:Get("EnvLogic"):AnonymityLogin(L1_57, L2_58)
    return
  end
  L1_57 = Logic
  L2_58 = L1_57
  L1_57 = L1_57.Get
  L1_57 = L1_57(L2_58, "System")
  L2_58 = L1_57
  L1_57 = L1_57.IsSelfAccUI
  L1_57 = L1_57(L2_58)
  if not L1_57 then
    L1_57 = Logic
    L2_58 = L1_57
    L1_57 = L1_57.Get
    L1_57 = L1_57(L2_58, "System")
    L2_58 = L1_57
    L1_57 = L1_57.IsSelfAccLogin
    L1_57 = L1_57(L2_58)
    if not L1_57 then
      L1_57 = Logic
      L2_58 = L1_57
      L1_57 = L1_57.Get
      L1_57 = L1_57(L2_58, "EnvLogic")
      L2_58 = L1_57
      L1_57 = L1_57.Login
      L1_57(L2_58)
      return
    end
  end
  L1_57 = Logic
  L2_58 = L1_57
  L1_57 = L1_57.Get
  L1_57 = L1_57(L2_58, "Login")
  L2_58 = L1_57
  L1_57 = L1_57.removeAni
  L1_57(L2_58, A0_56.rootNode, "LoginEnter", Logic.Login.LOAD_STAGE.ACCOUNT)
end
function prototype.onBgClicked(A0_59, A1_60, A2_61)
  A0_59.showArea = false
  A0_59.imgAreaBg:setVisible(false)
  A0_59.bgClicked:setEnabled(false)
  if nil ~= A0_59.tableViewControl then
    A0_59.tableViewControl:RequireUpdate(1)
  end
  A0_59:RefrashSelServer()
  A0_59:btnCanUse(true)
end
function prototype.createServerLst(A0_62)
  A0_62.tableViewControl = TableViewEx.prototype:createList(A0_62, A0_62.m_pCListSelArea, 1)
  A0_62.tableViewControl.tableView:setDirection(kCCScrollViewDirectionVertical)
  A0_62.m_pCListSelArea:addChild(A0_62.tableViewControl.tableView)
end
function prototype.cellSizeForTable(A0_63, ...)
  return CCSizeMake(_UPVALUE0_, _UPVALUE1_)
end
function prototype.tableCellAtIndex(A0_65, A1_66, A2_67, A3_68, A4_69)
  local L5_70, L6_71
  L5_70 = 1
  if not A3_68 then
    L6_71 = CCTableViewCellEx
    L6_71 = L6_71.create
    L6_71 = L6_71(L6_71)
    A3_68 = L6_71
    L6_71 = Tw
    L6_71 = L6_71.Controller
    L6_71 = L6_71.load
    L6_71 = L6_71(L6_71, "ServerItem", A0_65.rootNode)
    L6_71:refresh(A2_67 + 1)
    A3_68:addChild(L6_71, 0, L5_70)
  else
    L6_71 = A3_68.getChildByTag
    L6_71 = L6_71(A3_68, L5_70)
    L6_71 = L6_71.refresh
    L6_71(L6_71, A2_67 + 1)
  end
  return A3_68
end
function prototype.numberOfCellsInTableView(A0_72, A1_73)
  if not A0_72.showArea then
    return 0
  else
    return Logic:Get("Login"):GetServerAmount() + Logic:Get("Login"):GetLoggeServerdAmount()
  end
end
function prototype.tableCellTouched(A0_74, A1_75, A2_76)
end
function prototype.tablePageTurn(A0_77, A1_78)
  return
end
