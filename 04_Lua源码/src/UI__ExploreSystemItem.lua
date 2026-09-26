require("SceneHelper")
module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
function prototype:onEnter()
  self.ttfName:setStyle(kCCLabelTTFStyleOutline)
  self.ttfCost:setStyle(kCCLabelTTFStyleOutline)
  self.ttfRate:setStyle(kCCLabelTTFStyleOutline)
end
function prototype:onBtnBg(sender, event)
  self.owner:selectedCard(self.data.id, self.data)
end
function prototype:Refresh(data, owner)
  if table.empty(data or {}) then
    return
  end
  self.data = data
  self.owner = owner
  self.ccbHero:refreshIcon(data)
  self.ttfName:setString(data.name)
  self.ttfCost:setString(data.costs)
  self.ttfRate:setString(data.rate .. "%")
  self:showSelected()
end
function prototype:showSelected()
  self.btnBg:setEnabled(true)
  local normalPath = "images/public/selcet1.png"
  local selectedPath = "images/public/selcet2.png"
  local lockPath = "images/public/selcet3.png"
  local spr = CCSprite:create(normalPath)
  if spr then
    self.sprSelect:setDisplayFrame(spr:displayFrame())
  end
  if Logic:Get("Explore"):IsSelected(self.data.id) then
    local spr = CCSprite:create(selectedPath)
    if spr then
      self.sprSelect:setDisplayFrame(spr:displayFrame())
    end
    return
  end
  if Logic:Get("Explore"):IsCardFull() or Logic:Get("Explore"):IsSystemCardFull() then
    local spr = CCSprite:create(lockPath)
    if spr then
      self.sprSelect:setDisplayFrame(spr:displayFrame())
    end
    self.btnBg:setEnabled(false)
  end
end
