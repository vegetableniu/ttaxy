require("SceneHelper")
module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
function prototype:onEnter()
  self.ttfDesr:setStyle(kCCLabelTTFStyleOutline)
end
function prototype:showLine(bool)
  self.sprBg:setVisible(not bool)
  self.sprUnderLine:setVisible(bool)
end
function prototype:Refresh(data, idx)
  if table.empty(data or {}) or not idx then
    return
  end
  local bSelected = self:IsFit(idx)
  local desr = ""
  for i, id in ipairs(data.items) do
    local rec = KFDBGetRecord("TaskSuccessItemConfig", id) or {}
    desr = desr .. (rec.desr or "")
  end
  desr = desr .. TwGetStr(115230, data.rate or 0)
  self:refreshUI(bSelected, desr, idx)
end
function prototype:refreshReduseCd(data)
  if table.empty(data or {}) then
    return
  end
  local bSelected = self:IsFit(1)
  self:refreshUI(bSelected, data.desr or "", 1)
end
function prototype:refreshUI(bSelected, text, idx)
  self.ttfDesr:setString(text)
  local color = bSelected and ccc3(0, 255, 0) or ccc3(204, 210, 199)
  self.ttfDesr:setColor(color)
  local path = "images/Explore/star%d.png"
  local disablePath = "images/Explore/disableStar%d.png"
  local actPath = bSelected and path or disablePath
  local spr = CCSprite:create(string.format(actPath, idx))
  if spr then
    self.sprIdx:setDisplayFrame(spr:displayFrame())
  end
  local normalPath = "images/public/clarity05.png"
  local selectedPath = "images/Explore/selected.png"
  actPath = bSelected and selectedPath or normalPath
  local spr = CCSprite:create(actPath)
  if spr then
    self.sprSelected:setDisplayFrame(spr:displayFrame())
  end
end
function prototype:IsFit(idx)
  local tab = Logic:Get("Explore"):getFitIdx()
  return tab[idx] or false
end
