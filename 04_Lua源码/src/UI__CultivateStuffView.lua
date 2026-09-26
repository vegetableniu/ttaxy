module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
local DROP_GAP = 0
function prototype:onEnter(...)
  self.totalHeight = 0
  self.pillHeight = 0
  self.dropHeight = 0
  self.sprBgPill:setAnchorPoint(ccp(0.5, 1))
end
function prototype:refresh(baseId)
  if not baseId then
    return
  end
  self:refreshDrops(baseId)
  self:adaptPos()
end
function prototype:refreshDrops(baseId)
  local rec = Logic:Get("Cultivate"):GetStuffInfoByBaseId(baseId)
  local tDrops = json.decode(rec.dropIds or "") or {}
  local posY = -65
  local height = 0
  local count = 0
  for i, v in ipairs(tDrops) do
    local ccbItem = Tw.Controller:load("CultivateStuffDropItem", self.rootNode)
    if ccbItem then
      local bFirstItem = i == 1
      ccbItem:refresh(v, bFirstItem)
      ccbItem:setPosition(ccp(0, posY))
      self.nodeDrop:addChild(ccbItem)
    end
    posY = posY - 65
    height = height + 65
    count = count + 1
    if count >= 3 then
      break
    end
  end
  self.dropHeight = height
  if height == 0 then
    self.dropHeight = -DROP_GAP
    self.nodeDrop:setVisible(false)
    return
  end
end
function prototype:adaptPos()
  self.totalHeight = self.dropHeight + DROP_GAP
  self.nodeDrop:setPositionY(self.totalHeight - DROP_GAP)
  local oldSize = self.layer:getContentSize()
  self.layer:setContentSize(CCSizeMake(oldSize.width, self.totalHeight))
end
function prototype:getSize()
  return self.layer:getContentSize()
end
