require("Scene")
module((...), package.seeall)
class = objectlua.Object:subclass()
function class:initialize(view)
  super.initialize(self)
  self.scene = Scene.Scene.class:new(Scene.Define.MODE.HORIZONTAL)
  self.wrapper = StubViewTargetScene(self.scene:Mgr())
  view:SetTarget(self.wrapper)
end
function class:dispose()
  super.dispose(self)
end
function class:GetScene()
  return self.scene
end
function class:SetSpeed(rate)
  self.wrapper:SetSpeed(rate)
end
function class:GetSpeed(rate)
  return self.wrapper:GetSpeed()
end
