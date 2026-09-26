module((...), package.seeall)
require("MsgItem")
require("SceneHelper")
require("Logic")
class = Logic.class:subclass()
function class:initialize()
  super.initialize(self)
end
