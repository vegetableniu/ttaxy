require("Scene")
module((...), package.seeall)
class = objectlua.Object:subclass()
function class:initialize(view)
  super.initialize(self)
  local scene = Scene.Scene.class:new(Scene.Define.MODE.HORIZONTAL)
  local wrapper = StubViewTargetScene(scene:Mgr())
  view:SetTarget(wrapper)
  self.wrapper = wrapper
  self.mgr = scene:Mgr()
  self.action = scene:ActionMgr()
  self.mgr:SetScale(CTwUIRender:GetSingleton():GetZoomScale())
end
function class:dispose()
  super.dispose(self)
end
