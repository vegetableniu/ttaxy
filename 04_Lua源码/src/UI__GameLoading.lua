module((...), package.seeall)
require("Login")
prototype = Tw.Controller.prototype:extend()
function prototype.initialize(A0_0, ...)
  local L3_2, L4_3
  L3_2 = super
  L3_2 = L3_2.initialize
  L4_3 = A0_0
  L3_2(L4_3, ...)
end
function prototype.onEnter(A0_4)
  local L1_5
  L1_5 = Logic
  L1_5 = L1_5.Get
  L1_5 = L1_5(L1_5, "Login")
  L1_5 = L1_5.On
  L1_5(L1_5, Logic.Login.EVT.GAME_STAGECHANGE, A0_4:Event("onGameStageChange"))
  L1_5 = Logic
  L1_5 = L1_5.Get
  L1_5 = L1_5(L1_5, "System")
  L1_5 = L1_5.IsChannel
  L1_5 = L1_5(L1_5, "appstoreJS")
  if L1_5 then
    L1_5 = Logic
    L1_5 = L1_5.Get
    L1_5 = L1_5(L1_5, "AniMgr")
    L1_5 = L1_5.RunCCBAni
    L1_5(L1_5, "UI/UIdljm1_22", A0_4.m_pCAniBg)
  else
    L1_5 = Logic
    L1_5 = L1_5.Get
    L1_5 = L1_5(L1_5, "AniMgr")
    L1_5 = L1_5.RunCCBAni
    L1_5(L1_5, "UI/UIdljm", A0_4.m_pCAniBg)
  end
  L1_5 = CEnvRoot
  L1_5 = L1_5.GetSingleton
  L1_5 = L1_5(L1_5)
  L1_5 = L1_5.GetVersionName
  L1_5 = L1_5(L1_5)
  if nil == L1_5 or L1_5 == "" then
    L1_5 = "1.0.6.2"
  end
  if Logic:Get("System"):IsOperator("ifreeteam") or Logic:Get("System"):IsOperator("tstore") then
    A0_4.staVersion:setPosition(ccp(14, 30))
  end
  A0_4.staVersion:setString(TwGetStr(104263, L1_5))
  A0_4.staPrompt:setStyle(kCCLabelTTFStyleOutline)
  A0_4.staPrompt:setFontSize(20)
  A0_4.staPrompt:setString(TwGetStr(10162))
  A0_4:onGameStageChange()
end
function prototype.onGameStageChange(A0_6)
  if (Logic:Get("Login"):GetLoadingStage() or Logic.Login.LOAD_STAGE.AUTOPATCH) == A0_6.gameStage then
    return
  end
  if (Logic:Get("Login"):GetLoadingStage() or Logic.Login.LOAD_STAGE.AUTOPATCH) == Logic.Login.LOAD_STAGE.AUTOPATCH then
    SceneHelper:pushScene("AutoPatch")
  elseif (Logic:Get("Login"):GetLoadingStage() or Logic.Login.LOAD_STAGE.AUTOPATCH) == Logic.Login.LOAD_STAGE.ACCOUNT then
    if Logic:Get("System"):IsSelfAccUI() or Logic:Get("System"):IsSelfAccLogin() then
      SceneHelper:pushMoveScene("AccountLogin")
    else
      Logic:Get("EnvLogic"):Login()
    end
  else
    SceneHelper:pushMoveScene("LoginEnter")
  end
  A0_6.gameStage = Logic:Get("Login"):GetLoadingStage() or Logic.Login.LOAD_STAGE.AUTOPATCH
end
