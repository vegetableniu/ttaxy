module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
function prototype:onEnter(...)
end
function prototype:refresh(data)
  if not data then
    return
  end
  self.data = data
  self:refreshNode(data)
  self:adaptSize()
end
function prototype:refreshNode(data)
  local height = 0
  local camps = data
  for i = 1, #camps do
    local node = self.layer:getChildByTag(i)
    if node then
      node:refresh(camps[i], i)
    else
      local node = Tw.Controller:load("CultivateCampaignNode")
      local pos = self:getPos(i)
      node:setPosition(ccp(pos.x, pos.y))
      self.maxY = pos.y + 100
      node:refresh(camps[i], i)
      self.nodeCamp:addChild(node, i, i)
    end
  end
end
function prototype:getPos(index)
  local addY = 125
  local x = index % 2 == 1 and 200 or 0
  local y = addY * (index - 1)
  return {x = x, y = y}
end
function prototype:getNodePos(index)
  if not index then
    return
  end
  local pos = self:getPos(index)
  return ccp(pos.x, pos.y)
end
function prototype:adaptSize()
  if not self.maxY then
    return
  end
  local oldSize = self.layer:getContentSize()
  self.layer:setContentSize(CCSizeMake(oldSize.width, self.maxY + 220))
end
