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
  super.dispose(A0_3)
end
function prototype.createPasswordEdit(A0_5)
  local L1_6, L2_7, L3_8
  L1_6 = A0_5.edtPassword
  if L1_6 then
    return
  end
  L1_6 = CCSprite
  L2_7 = L1_6
  L1_6 = L1_6.create
  L3_8 = "images/Login/edit_kuang.png"
  L1_6 = L1_6(L2_7, L3_8)
  L3_8 = L1_6
  L2_7 = L1_6.setPosition
  L2_7(L3_8, CCPoint(292, 655))
  L3_8 = L1_6
  L2_7 = L1_6.setScaleX
  L2_7(L3_8, 1.2)
  L2_7 = A0_5.rootNode
  L3_8 = L2_7
  L2_7 = L2_7.addChild
  L2_7(L3_8, L1_6, 1)
  L2_7 = CCLabelTTF
  L3_8 = L2_7
  L2_7 = L2_7.create
  L2_7 = L2_7(L3_8, "\229\175\134\231\160\129", "Helvetica", 35)
  L3_8 = L2_7.setColor
  L3_8(L2_7, ccc3(0, 0, 0))
  L3_8 = L2_7.setScale
  L3_8(L2_7, 1.35)
  L3_8 = L2_7.setAnchorPoint
  L3_8(L2_7, CCPoint(1, 0.5))
  L3_8 = L2_7.setPosition
  L3_8(L2_7, CCPoint(114, 651))
  L3_8 = A0_5.rootNode
  L3_8 = L3_8.addChild
  L3_8(L3_8, L2_7, 2)
  L3_8 = CCNode
  L3_8 = L3_8.create
  L3_8 = L3_8(L3_8)
  L3_8:setContentSize(CCSize(280, 50))
  L3_8:setAnchorPoint(CCPoint(0, 0))
  L3_8:setPosition(CCPoint(133, 616))
  A0_5.rootNode:addChild(L3_8, 2)
  A0_5.edtPassword = require("Edit").prototype:new()
  A0_5.edtPassword.rootNode = L3_8
  A0_5.edtPassword:onEnter()
  A0_5.edtPassword:setFontSize(_UPVALUE0_)
  A0_5.edtPassword:setPlaceHolder("<\232\175\183\232\190\147\229\133\165\229\175\134\231\160\129>")
  A0_5.edtPassword:setPasswordMode(true)
  A0_5.edtPassword:setMaxLens(_UPVALUE1_)
end
function prototype.onEnter(A0_9)
  A0_9.ttfAdmin:setString("\230\179\168\229\134\140\231\160\129")
  A0_9.ttfAdmin:setFontSize(28)
  A0_9.ttfAdmin:setPosition(CCPoint(118, 807))
  A0_9.ttfPass:setString("\232\180\166\229\143\183")
  A0_9.ttfOk:setString(TwGetStr(103002))
  A0_9.ttfLoginTip:setString(TwGetStr(108021))
  A0_9.ttfAutoCreate:setString(TwGetStr(108025))
  A0_9.edtAccount:setFontSize(_UPVALUE0_)
  A0_9.edtAccount:setMaxLens(32)
  A0_9.edtAccount:setPlaceHolder("<\232\175\183\232\190\147\229\133\165\230\179\168\229\134\140\231\160\129\239\188\136\229\191\133\229\161\171\239\188\137>")
  A0_9.edtPass:setPasswordMode(false)
  A0_9.edtPass:setFontSize(_UPVALUE0_)
  A0_9.edtPass:setPlaceHolder(TwGetStr(108022))
  A0_9.edtPass:setMaxLens(_UPVALUE1_)
  A0_9.btnAutogeneration:setPosition(CCPoint(522, 731))
  A0_9.ttfAutoCreate:setPosition(CCPoint(522, 731))
  A0_9.btnRegist:setPosition(CCPoint(320, 540))
  A0_9.ttfOk:setPosition(CCPoint(320, 540))
  A0_9:createPasswordEdit()
  A0_9.nodAgreement:setVisible(false)
  A0_9.bAgree = true
end
function prototype.checkInput(A0_10)
  local L1_11, L2_12, L3_13, L4_14, L5_15
  L1_11 = IsDevMode
  L1_11 = L1_11()
  L2_12 = string
  L2_12 = L2_12.gsub
  L3_13 = A0_10.edtAccount
  L4_14 = L3_13
  L3_13 = L3_13.getString
  L3_13 = L3_13(L4_14)
  L3_13 = L3_13 or ""
  L4_14 = "%s"
  L5_15 = ""
  L2_12 = L2_12(L3_13, L4_14, L5_15)
  L3_13 = string
  L3_13 = L3_13.gsub
  L4_14 = A0_10.edtPass
  L5_15 = L4_14
  L4_14 = L4_14.getString
  L4_14 = L4_14(L5_15)
  L4_14 = L4_14 or ""
  L5_15 = "%s"
  L3_13 = L3_13(L4_14, L5_15, "")
  if nil == L3_13 or "" == L3_13 then
    L4_14 = Prompt
    L5_15 = L4_14
    L4_14 = L4_14.Fail
    L4_14(L5_15, 10065)
    L4_14 = false
    return L4_14
  end
  L4_14 = getStrShowWidth
  L5_15 = L3_13
  L4_14 = L4_14(L5_15)
  if not L1_11 then
    L5_15 = _UPVALUE0_
  else
    if not (L4_14 < L5_15) then
      L5_15 = _UPVALUE1_
  end
  elseif L4_14 > L5_15 then
    L5_15 = Prompt
    L5_15 = L5_15.Fail
    L5_15(L5_15, 10102)
    L5_15 = false
    return L5_15
  end
  L5_15 = string
  L5_15 = L5_15.find
  L5_15 = L5_15(L3_13, "[^%w]")
  if L5_15 then
    L5_15 = Prompt
    L5_15 = L5_15.Fail
    L5_15(L5_15, 10100)
    L5_15 = false
    return L5_15
  end
  L5_15 = getCodePointAmount
  L5_15 = L5_15(L3_13)
  if L5_15 ~= string.len(L3_13) then
    L5_15 = Prompt
    L5_15 = L5_15.Fail
    L5_15(L5_15, 102212)
    L5_15 = false
    return L5_15
  end
  if L2_12 ~= "" then
    L5_15 = string
    L5_15 = L5_15.find
    L5_15 = L5_15(L2_12, "[^%w%-]")
    if L5_15 then
      L5_15 = Prompt
      L5_15 = L5_15.Fail
      L5_15(L5_15, "\230\179\168\229\134\140\231\160\129\230\160\188\229\188\143\228\184\141\230\173\163\231\161\174\227\128\130")
      L5_15 = false
      return L5_15
    end
  end
  L5_15 = A0_10.edtPassword
  if L5_15 then
    L5_15 = A0_10.edtPassword
    L5_15 = L5_15.getString
    L5_15 = L5_15(L5_15)
  else
    L5_15 = L5_15 or ""
  end
  if not L1_11 and (nil == L5_15 or "" == L5_15) then
    Prompt:Fail(10066)
    return false
  end
  if not L1_11 and getStrShowWidth(L5_15) < _UPVALUE2_ then
    Prompt:Fail(10069)
    return false
  end
  if string.find(L5_15, "[^%w]") then
    Prompt:Fail(10103)
    return false
  end
  Logic:Get("Account"):SetInviteCode(L2_12)
  Logic:Get("Account"):SetNickName(L3_13)
  Logic:Get("Account"):SetAccName(L3_13)
  L5_15 = CMd5(L5_15):GetResult()
  Logic:Get("Account"):SetPassword(L5_15)
  return true
end
function prototype.onBtnRegist(A0_16)
  if not A0_16:checkInput() then
    return
  end
  if Logic:Get("System"):IsSelfAccLogin() then
    Logic:Get("Account"):Regist()
  else
    Logic:Get("EnvLogic"):Regist(A0_16.edtPass:getString(), A0_16.edtPassword:getString())
  end
end
function prototype.onBtnAutogeneration(A0_17)
  local L1_18
  L1_18 = tostring
  L1_18 = L1_18(os.time())
  L1_18 = L1_18 or ""
  L1_18 = "ey" .. string.sub(L1_18, 3, -1)
  A0_17.edtPass:setString(L1_18)
end
function prototype.onBtnGotoLogin(A0_19)
  SceneHelper:removeScene("AccountRegist")
  SceneHelper:pushMoveScene("AccountLogin")
end
function prototype.onBackClk(A0_20)
  SceneHelper:removeScene("AccountRegist")
  SceneHelper:pushMoveScene("AccountLogin")
end
function prototype.onLoginSucceed(A0_21)
  Logic:Get("Account"):SetAutoLogin(false)
  Logic:Get("Login"):removeAni(A0_21.rootNode, "AccountRegist", Logic.Login.LOAD_STAGE.ENTERGAME)
end
function prototype.onExit(A0_22)
  if A0_22.edtPassword then
    A0_22.edtPassword:onExit()
  end
end
function prototype.onBtnClick(A0_23)
  A0_23.bAgree = not A0_23.bAgree
  A0_23:displayClick()
end
function prototype.onBtnLink(A0_24)
  local L1_25
  L1_25 = Logic
  L1_25 = L1_25.Get
  L1_25 = L1_25(L1_25, "System")
  L1_25 = L1_25.GetUserAgreement
  L1_25 = L1_25(L1_25)
  if L1_25 then
    Logic:Get("EnvLogic"):OpenUrl(L1_25)
  end
end
function prototype.displayClick(A0_26)
  local L1_27
  L1_27 = ""
  if A0_26.bAgree then
    L1_27 = "images/public/selcet2.png"
  else
    L1_27 = "images/public/selcet1.png"
  end
  if CCSprite:create(L1_27) then
    A0_26.sprSelect:setDisplayFrame(CCSprite:create(L1_27):displayFrame())
  end
end
