require("GameRoot")
require("NetHttp")
require("Tw.TexturePreloader")
require("SceneHelper")
module((...), package.seeall)
class = GameRoot.class:subclass()
function class:initialize(...)
  super.initialize(self)
  self.lastOperate = os.time()
  self.maxLeaveTime = 18000
  self:SetupNetHttp()
  self.texturePreloader = Tw.TexturePreloader.class:new()
end
function class:dispose()
  self.texturePreloader:dispose()
  super.dispose(self)
end
function class:OnStartup()
  super.OnStartup(self)
  CCDirector:sharedDirector():setProjection(kCCDirectorProjection2D)
  if IsDevMode() then
  end
  Singleton(GameStage):ChgStage(IsDevMode() and "AutoPatch" or "AutoPatch")
end
function class:OnShutdown()
  super.OnShutdown(self)
end
function class:CheckOperate()
  if Singleton(GameStage):IsStage("Normal") and os.time() - self.lastOperate > self.maxLeaveTime then
    Singleton(GameStage):ChgStage("AutoPatch")
  end
  self.lastOperate = os.time()
end
function class:OnTick()
end
function class:isBattleShow()
  if SceneHelper:isExistScene("BattleShow") then
    return true
  else
    return false
  end
end
function class:SetupNetHttp()
  local Listener = NetHttp.Listener:subclass()
  function Listener:Block(block)
    if block then
      SceneHelper:pushPrompt("NetConnTip")
    else
      SceneHelper:removePrompt(nil, "NetConnTip")
    end
  end
  Singleton(NetHttp):setListener(Listener:new())
end
