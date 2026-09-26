require("SceneHelper")
module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
function prototype:onEnter()
  self.ttfLineupName:setStyle(kCCLabelTTFStyleOutline)
end
function prototype:onBtnLineup(sender, event)
  self.owner:selectedItem(self.idx)
end
function prototype:onBtnChangeName(sender, event)
  Logic:Get("Lineup"):setOldName(self.data.name)
  SceneHelper:pushPrompt("LineupRename", self.rootNode)
end
function prototype:refreshItem(data, owner, idx)
  if table.empty(data or {}) then
    return
  end
  self.data = data
  self.owner = owner
  self.idx = idx
  self.ttfLineupName:setString(data.name or "")
  self:showSelected()
end
function prototype:showSelected()
  self.btnLineup:setEnabled(true)
  local normalPath = "images/public/selcet1.png"
  local selectedPath = "images/public/selcet2.png"
  local lockPath = "images/public/selcet3.png"
  local spr = CCSprite:create(normalPath)
  if spr then
    self.sprClick:setDisplayFrame(spr:displayFrame())
  end
  if self.owner:isSelected(self.idx) then
    local spr = CCSprite:create(selectedPath)
    if spr then
      self.sprClick:setDisplayFrame(spr:displayFrame())
    end
    return
  end
  if self.owner:isFull() then
    local spr = CCSprite:create(lockPath)
    if spr then
      self.sprClick:setDisplayFrame(spr:displayFrame())
    end
    self.btnLineup:setEnabled(false)
    return
  end
end
