module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
local MAX_ITEM = 5
function prototype:initialize(...)
  super.initialize(self, ...)
end
function prototype:dispose(...)
  super.dispose(self)
end
function prototype:onEnter()
  local rankData = Logic:Get("Devil"):getTotalDamageRank()
  for i = 1, MAX_ITEM do
    local data = rankData[i]
    local str = string.format("ccbRank%d", i)
    if data then
      self[str]:setInfo(data)
    else
      self[str]:setVisible(false)
    end
  end
  self.ccbMyRank:setColor(ccColor3B(0, 188, 5))
  local name = Logic:Get("PlayerInfo"):GetPlayerName()
  for _, v in pairs(rankData) do
    if v.name == name then
      self.ccbMyRank:setInfo(v)
      break
    end
  end
end
function prototype:onNodeLoaded(node, loader)
end
function prototype:onBtnSure(sender, event)
  SceneHelper:removePrompt(self.rootNode)
end
