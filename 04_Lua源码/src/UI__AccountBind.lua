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
  Logic:Get("Account"):On(Logic.Account.EVT.BIND_ACCOUNT, A0_1:Event("onBindSucceed"))
  Logic:Get("Account"):On(Logic.Account.EVT.SECONDARY_PASSWORD_SUCCEED, A0_1:Event("onSecondaryPasswordSucceed"))
end
function prototype.dispose(A0_3, ...)
  super.dispose(A0_3)
end
function prototype.onEnter(A0_5)
  A0_5.secondaryMode, A0_5.secondaryAccount = Logic:Get("Account"):GetSecondaryFlow()
  if A0_5.secondaryMode then
    Logic:Get("Account"):ConfigureSecondaryView(A0_5)
    return
  end
  A0_5.admin:setString(TwGetStr(103118))
  A0_5.passward:setString(TwGetStr(103119))
  A0_5.staComPass:setString(TwGetStr(103120))
  A0_5.staRegist:setString(TwGetStr(103121))
  A0_5.staReturn:setString(TwGetStr(103124))
  A0_5.staPrompt:setString(TwGetStr(103123))
  A0_5.edtPassword:setPasswordMode(true)
  A0_5.edtCheckPass:setPasswordMode(true)
  A0_5.edtAccount:setFontSize(_UPVALUE0_)
  A0_5.edtPassword:setFontSize(_UPVALUE0_)
  A0_5.edtCheckPass:setFontSize(_UPVALUE0_)
  A0_5.edtPassword:setPasswordMode(true)
  A0_5.edtCheckPass:setPasswordMode(true)
  A0_5.edtAccount:setFontSize(_UPVALUE0_)
  A0_5.edtPassword:setFontSize(_UPVALUE0_)
  A0_5.edtCheckPass:setFontSize(_UPVALUE0_)
  A0_5.edtAccount:setMaxLens(_UPVALUE1_)
  A0_5.edtPassword:setMaxLens(_UPVALUE1_)
  A0_5.edtCheckPass:setMaxLens(_UPVALUE1_)
  A0_5.accounOld = Logic:Get("Account"):GetAccName()
end
function prototype.checkInput(A0_6)
  local L1_7, L2_8, L3_9, L4_10, L5_11, L6_12
  L1_7 = IsDevMode
  L1_7 = L1_7()
  L2_8 = A0_6.edtAccount
  L3_9 = L2_8
  L2_8 = L2_8.getString
  L2_8 = L2_8(L3_9)
  if nil == L2_8 or "" == L2_8 then
    L3_9 = Prompt
    L4_10 = L3_9
    L3_9 = L3_9.Fail
    L5_11 = 10065
    L3_9(L4_10, L5_11)
    L3_9 = false
    return L3_9
  end
  L3_9 = getStrShowWidth
  L4_10 = L2_8
  L3_9 = L3_9(L4_10)
  L4_10 = _UPVALUE0_
  if not (L3_9 < L4_10) then
    L4_10 = _UPVALUE1_
  elseif L3_9 > L4_10 then
    L4_10 = Prompt
    L5_11 = L4_10
    L4_10 = L4_10.Fail
    L6_12 = 10102
    L4_10(L5_11, L6_12)
    L4_10 = false
    return L4_10
  end
  L4_10 = string
  L4_10 = L4_10.find
  L5_11 = L2_8
  L6_12 = "[^%w]"
  L4_10 = L4_10(L5_11, L6_12)
  if L4_10 then
    L4_10 = Prompt
    L5_11 = L4_10
    L4_10 = L4_10.Fail
    L6_12 = 10100
    L4_10(L5_11, L6_12)
    L4_10 = false
    return L4_10
  end
  L4_10 = getCodePointAmount
  L5_11 = L2_8
  L4_10 = L4_10(L5_11)
  L5_11 = string
  L5_11 = L5_11.len
  L6_12 = L2_8
  L5_11 = L5_11(L6_12)
  if L4_10 ~= L5_11 then
    L4_10 = Prompt
    L5_11 = L4_10
    L4_10 = L4_10.Fail
    L6_12 = 102212
    L4_10(L5_11, L6_12)
    L4_10 = false
    return L4_10
  end
  L4_10 = A0_6.edtPassword
  L5_11 = L4_10
  L4_10 = L4_10.getString
  L4_10 = L4_10(L5_11)
  if not L1_7 and (nil == L4_10 or "" == L4_10) then
    L5_11 = Prompt
    L6_12 = L5_11
    L5_11 = L5_11.Fail
    L5_11(L6_12, 10066)
    L5_11 = false
    return L5_11
  end
  if not L1_7 then
    L5_11 = getStrShowWidth
    L6_12 = L4_10
    L5_11 = L5_11(L6_12)
    L6_12 = _UPVALUE2_
    if L5_11 < L6_12 then
      L5_11 = Prompt
      L6_12 = L5_11
      L5_11 = L5_11.Fail
      L5_11(L6_12, 10069)
      L5_11 = false
      return L5_11
    end
  end
  L5_11 = string
  L5_11 = L5_11.find
  L6_12 = L4_10
  L5_11 = L5_11(L6_12, "[^%w]")
  if L5_11 then
    L5_11 = Prompt
    L6_12 = L5_11
    L5_11 = L5_11.Fail
    L5_11(L6_12, 10103)
    L5_11 = false
    return L5_11
  end
  L5_11 = A0_6.edtCheckPass
  L6_12 = L5_11
  L5_11 = L5_11.getString
  L5_11 = L5_11(L6_12)
  if L4_10 ~= L5_11 then
    L6_12 = Prompt
    L6_12 = L6_12.Fail
    L6_12(L6_12, 10091)
    L6_12 = false
    return L6_12
  end
  L6_12 = Logic
  L6_12 = L6_12.Get
  L6_12 = L6_12(L6_12, "Account")
  L6_12 = L6_12.SetNickName
  L6_12(L6_12, L2_8)
  L6_12 = Logic
  L6_12 = L6_12.Get
  L6_12 = L6_12(L6_12, "Account")
  L6_12 = L6_12.SetAccName
  L6_12(L6_12, L2_8)
  L6_12 = CMd5
  L6_12 = L6_12(L4_10)
  L6_12 = L6_12.GetResult
  L6_12 = L6_12(L6_12)
  Logic:Get("Account"):SetPassword(L6_12)
  return true
end
function prototype.onBtnAccountBind(A0_13)
  local L1_14
  L1_14 = A0_13.secondaryMode
  if L1_14 then
    L1_14 = A0_13.edtCheckPass
    L1_14 = L1_14.getString
    L1_14 = L1_14(L1_14)
    L1_14 = L1_14 or ""
    if not A0_13.secondarySubmit then
      A0_13.secondarySubmit = {
        A0_13.edtAccount:getString() or "",
        A0_13.edtPassword:getString() or "",
        L1_14
      }
      A0_13.staComPass:setString(A0_13.secondaryMode == "bind" and "\229\134\141\230\172\161\232\190\147\229\133\165\228\186\140\231\186\167\229\175\134\231\160\129" or "\229\134\141\230\172\161\232\190\147\229\133\165\230\150\176\231\153\187\229\189\149\229\175\134\231\160\129")
      A0_13.staRegist:setString("\231\161\174\232\174\164")
      A0_13.edtCheckPass:setString("")
      Prompt:Msg("\232\175\183\229\134\141\232\190\147\229\133\165\228\184\128\230\172\161\232\191\155\232\161\140\231\161\174\232\174\164\227\128\130")
    elseif L1_14 ~= A0_13.secondarySubmit[3] then
      A0_13.edtCheckPass:setString("")
      Prompt:Fail("\228\184\164\230\172\161\232\190\147\229\133\165\228\184\141\228\184\128\232\135\180\239\188\140\232\175\183\233\135\141\230\150\176\231\161\174\232\174\164\227\128\130")
    else
      A0_13.secondarySubmit = nil
      Logic:Get("Account"):SubmitSecondary(A0_13.secondaryMode, A0_13.secondarySubmit[1], A0_13.secondarySubmit[2], A0_13.secondarySubmit[3])
    end
    return
  end
  L1_14 = Logic
  L1_14 = L1_14.Get
  L1_14 = L1_14(L1_14, "Account")
  L1_14 = L1_14.GetAccName
  L1_14 = L1_14(L1_14)
  if not A0_13:checkInput() then
    return
  end
  if Logic:Get("System"):IsSelfAccLogin() then
    Logic:Get("Account"):BindAccount(A0_13.accounOld)
  else
    Logic:Get("EnvLogic"):BindAccount(A0_13.edtAccount:getString(), A0_13.edtPassword:getString(), L1_14, Logic:Get("Login"):GetLoginInfo().server)
  end
end
function prototype.onSecondaryPasswordSucceed(A0_15, A1_16, A2_17)
  local L3_18
  L3_18 = A0_15.secondaryMode
  if A1_16 ~= L3_18 then
    return
  end
  L3_18 = A0_15.edtAccount
  L3_18 = L3_18.getString
  L3_18 = L3_18(L3_18)
  L3_18 = L3_18 or ""
  Prompt:Msg(A2_17)
  Logic:Get("Account"):FinishSecondaryFlow(L3_18)
  SceneHelper:removeScene("AccountBind")
  SceneHelper:pushMoveScene("AccountLogin")
end
function prototype.onBindSucceed(A0_19)
  SceneHelper:runWithScene("Home", A0_19.rootNode)
  Prompt:Msg(102205)
end
function prototype.onBtnReturn(A0_20, A1_21, A2_22)
  local L3_23
  L3_23 = A0_20.secondaryMode
  if L3_23 then
    L3_23 = A0_20.edtAccount
    L3_23 = L3_23.getString
    L3_23 = L3_23(L3_23)
    if not L3_23 then
      L3_23 = A0_20.secondaryAccount
      L3_23 = L3_23 or ""
    end
    Logic:Get("Account"):FinishSecondaryFlow(L3_23)
    SceneHelper:removeScene("AccountBind")
    SceneHelper:pushMoveScene("AccountLogin")
    return
  end
  L3_23 = SceneHelper
  L3_23 = L3_23.runWithScene
  L3_23(L3_23, "Strage", A0_20.rootNode)
end
