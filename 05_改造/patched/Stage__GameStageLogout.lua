module((...), package.seeall)
require("GameStage")
class = GameStage.class:subclass()
function class:initialize(bAutoEnter)
  super.initialize(self)
  self.bAutoEnter = bAutoEnter
end
function class:OnStageActive()
  local serverLst = Logic:Get("Login"):GetServerLst()
  Logic:Reset()
  Logic:Get("Login"):SetServerLst(serverLst)
  Logic:Get("Login"):ReadRecordServerIdx()
  Logic:Get("Account"):SetAutoLogin(self.bAutoEnter)
  Logic:Get("Login"):SetLoadingStage(Logic.Login.LOAD_STAGE.ENTERGAME)
  SceneHelper:replaceScene("GameLoading")
  if _G.__LocalServer and _G.__LocalServer.enabled then
    log4misc:warn("[PATCH] Logout: schedule autoLogin")
    Logic:Get("Login"):SetSelectServer(1)
    Singleton(Timer):After(2000, self:Event("OFFLINE_LOGIN", function()
      log4misc:warn("[PATCH] Logout: timer autoLogin")
      _G.__LocalServer.autoLogin()
    end))
  end
end
function class:OnStageClose()
  self.bAutoEnter = nil
end
