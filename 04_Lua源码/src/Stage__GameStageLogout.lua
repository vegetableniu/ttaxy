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
end
function class:OnStageClose()
  self.bAutoEnter = nil
end
