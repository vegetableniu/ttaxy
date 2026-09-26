module((...), package.seeall)
require("GameStage")
class = GameStage.class:subclass()
function class:initialize()
  super.initialize(self)
end
function class:OnStageActive()
  Logic:Get("CreateHero"):Create()
end
function class:OnStageClose()
end
