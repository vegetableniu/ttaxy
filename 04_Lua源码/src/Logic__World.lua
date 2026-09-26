module((...), package.seeall)
require("Logic")
require("Logic.Battle")
require("Logic.DramaTalk")
require("Logic.DramaControl")
class = Logic.class:subclass()
function class:initialize()
  super.initialize(self)
  Logic:Get("Login"):On(Login.EVT.LOGIN_COMPLETE, self:Event("OnLoginComplete"))
  self.continueMove = {}
end
function class:dispose()
  super.dispose(self)
end
function class:Enter()
end
function class:OnLoginComplete()
  Logic:Get("DramaTalk"):OnEnterWorld()
  Logic:Get("DramaControl"):OnEnterWorld()
  Logic:Get("Battle"):OnEnterWorld()
  Logic:Get("Chat"):OnEnterWorld()
  Logic:Get("Lock"):OnEnterWorld()
end
function class:Close()
end
function class:ChangeGameViewSize(w, h)
end
function class:OnOperateEvent(args)
  return false
end
