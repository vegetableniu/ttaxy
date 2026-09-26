module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
local ACCOUNT_MIN = 6
local ACCOUNT_MAX = 12
local PASSWORD_MIN = 6
local NAME_FONT_SIZE = 26
local NUM_MIN, NUM_MAX = 48, 57
local STR1_MIN, STR1_MAX = 65, 90
local STR2_MIN, STR2_MAX = 97, 122
function prototype:initialize(...)
  super.initialize(self, ...)
  Logic:Get("Account"):On(Logic.Account.EVT.LOGIN_SUCCEED, self:Event("onLoginSucceed"))
end
function prototype:dispose(...)
  super.dispose(self)
end
function prototype:onEnter()
  self.admin:setString(TwGetStr(103118))
  self.passward:setString(TwGetStr(103119))
  self.staComPass:setString(TwGetStr(103120))
  self.staRegist:setString(TwGetStr(103121))
  self.staLogin:setString(TwGetStr(103122))
  self.staPrompt:setString(TwGetStr(103123))
  self.ttfEmail:setString(TwGetStr(102215))
  self.edtPass:setPasswordMode(true)
  self.edtComPass:setPasswordMode(true)
  self.edtName:setFontSize(NAME_FONT_SIZE)
  self.edtPass:setFontSize(NAME_FONT_SIZE)
  self.edtComPass:setFontSize(NAME_FONT_SIZE)
  self.edtEmail:setFontSize(NAME_FONT_SIZE)
  if not IsDevMode() then
    self.edtName:setMaxLens(ACCOUNT_MAX)
  end
  self.edtPass:setMaxLens(ACCOUNT_MAX)
  self.edtComPass:setMaxLens(ACCOUNT_MAX)
  self.staPrompt:setVisible(false)
  if IsDevMode() then
    self.edtName:setString("")
    self.edtPass:setString("")
  end
  self.onLogin = true
  self.imgComPass:setVisible(false)
  self.staComPass:setVisible(false)
  self.edtComPass:setVisible(false)
  self.imgEmail:setVisible(false)
  self.ttfEmail:setVisible(false)
  self.edtEmail:setVisible(false)
end
function prototype:checkInput()
  local isDevMode = IsDevMode()
  local account = self.edtName:getString()
  if nil == account or "" == account then
    Prompt:Fail(10065)
    return false
  end
  local strLen = getStrShowWidth(account)
  if not isDevMode and strLen < ACCOUNT_MIN or strLen > ACCOUNT_MAX then
    Prompt:Fail(10102)
    return false
  end
  if string.find(account, "[^%w]") then
    Prompt:Fail(10100)
    return false
  end
  if getCodePointAmount(account) ~= string.len(account) then
    Prompt:Fail(102212)
    return false
  end
  local pass = self.edtPass:getString()
  if not isDevMode and (nil == pass or "" == pass) then
    Prompt:Fail(10066)
    return false
  end
  if not isDevMode and getStrShowWidth(pass) < PASSWORD_MIN then
    Prompt:Fail(10069)
    return false
  end
  if string.find(pass, "[^%w]") then
    Prompt:Fail(10103)
    return false
  end
  Logic:Get("Account"):SetNickName(account)
  Logic:Get("Account"):SetAccName(account)
  pass = CMd5(pass):GetResult()
  Logic:Get("Account"):SetPassword(pass)
  local email = self.edtEmail:getString()
  Logic:Get("Account"):SetEmail(email)
  return true
end
function prototype:onLoginClk()
  if IsDevMode() and self.onLogin then
    do
      local account = self.edtName:getString()
      local succ, msg = pcall(function()
        account = base64.decode(account)
        account = json.decode(account)
      end)
      if not account then
        succ, msg = pcall(function()
          account = json.decode(self.edtName:getString())
        end)
      end
      if succ and type(account) == "table" then
        Logic:Get("Account"):SuperLogin(account)
        return
      end
    end
  end
  if not self:checkInput() then
    return
  end
  if self.onLogin then
    if Logic:Get("System"):IsSelfAccLogin() then
      Logic:Get("Account"):Login()
    else
      Logic:Get("EnvLogic"):Login(self.edtName:getString(), self.edtPass:getString())
    end
    return
  end
  if self.edtComPass:getString() ~= self.edtPass:getString() then
    Prompt:Fail(10091)
    return
  end
  if Logic:Get("System"):IsSelfAccLogin() then
    Logic:Get("Account"):Regist()
  else
    Logic:Get("EnvLogic"):Regist(self.edtName:getString(), self.edtPass:getString(), self.edtEmail:getString())
  end
end
function prototype:onRegistClk()
  self:SwapInterface()
end
function prototype:SwapInterface()
  self.onLogin = not self.onLogin
  self.imgComPass:setVisible(not self.onLogin)
  self.staComPass:setVisible(not self.onLogin)
  self.edtComPass:setVisible(not self.onLogin)
  self.edtName:setString("")
  self.edtPass:setString("")
  self.edtComPass:setString("")
  local iCloseRanName = Logic:Get("System"):GetMisc("closeRandomName") or 0
  if iCloseRanName > 0 then
    self.imgEmail:setVisible(not self.onLogin)
    self.ttfEmail:setVisible(not self.onLogin)
    self.edtEmail:setVisible(not self.onLogin)
    self.edtEmail:setString("")
  end
  local sprite = ""
  if self.onLogin then
    sprite = CCSprite:create("images/Login/accountLogin.png")
  else
    sprite = CCSprite:create("images/Login/accountRegister.png")
  end
  if sprite and sprite ~= "" then
    self.fontLogin:setDisplayFrame(sprite:displayFrame())
  end
  local leftStr = TwGetStr(102200)
  local rightStr = TwGetStr(102202)
  if not self.onLogin then
    leftStr = TwGetStr(102201)
    rightStr = TwGetStr(102200)
  end
  self.staRegist:setString(leftStr)
  self.staLogin:setString(rightStr)
  self.staPrompt:setVisible(not self.onLogin)
end
function prototype:onBackClk()
  if self.onLogin then
    Logic:Get("Account"):SetAutoLogin(false)
    Logic:Get("Login"):removeAni(self.rootNode, "Account", Logic.Login.LOAD_STAGE.ENTERGAME)
  else
    self:SwapInterface()
  end
end
function prototype:onLoginSucceed()
  Logic:Get("Account"):SetAutoLogin(false)
  Logic:Get("Login"):removeAni(self.rootNode, "Account", Logic.Login.LOAD_STAGE.ENTERGAME)
end
