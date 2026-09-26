local Base = require("BattleShow.Output.Base")
module((...), package.seeall)
local internal = {}
class = Base.class:subclass()
local imgAni = "ui"
function class:initialize(scene, actionMgr, value, ciritical, fatal)
  local str = tostring(value)
  local map = internal.TITLE_MAP
  super.initialize(self, scene, actionMgr, str, map, imgAni)
end
function class:dispose()
  super.dispose(self)
end
internal.TITLE_MAP = {
  ["0"] = "Num0",
  ["1"] = "Num1",
  ["2"] = "Num2",
  ["3"] = "Num3",
  ["4"] = "Num4",
  ["5"] = "Num5",
  ["6"] = "Num6",
  ["7"] = "Num7",
  ["8"] = "Num8",
  ["9"] = "Num9",
  ["-"] = "Num-"
}
