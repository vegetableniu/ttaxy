module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
function prototype:onEnter(...)
end
function prototype:refresh(data)
  if not data then
    return
  end
  self.data = table.clone(data) or {}
  self:refreshNode()
  self:adaptSize()
end
function prototype:refreshNode(...)
  local campId = Logic:Get("Elite"):GetCampaignId()
  local battles = self.data
  table.sort(battles, function(a, b)
    return a.sort < b.sort
  end)
  for i = 1, #battles do
    local node = self.layer:getChildByTag(i)
    if node then
      node:refresh(battles[i], i)
    else
      local node = Tw.Controller:load("CultivateBattleNode", self.rootNode)
      local pos = self:getPos(i)
      node:setPosition(ccp(pos.x, pos.y + 100))
      self.maxY = pos.y + 100
      node:refresh(battles[i], i)
      self.layer:addChild(node, #battles - i, i)
    end
  end
end
function prototype:getPos(index)
  local addY = 125
  local x = index % 2 == 1 and 230 or 0
  local y = addY * (index - 1)
  return {x = x, y = y}
end
function prototype:adaptSize()
  if not self.maxY then
    return
  end
  local oldSize = self.layer:getContentSize()
  self.layer:setContentSize(CCSizeMake(oldSize.width, self.maxY + 220))
end
function prototype:getNodePos(battleId)
  if not battleId then
    return
  end
  for i, v in ipairs(self.data) do
    if v.id == battleId then
      local pos = self:getPos(i)
      return ccp(pos.x, pos.y)
    end
  end
end
