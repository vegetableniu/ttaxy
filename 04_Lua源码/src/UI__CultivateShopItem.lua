module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
function prototype:onEnter()
  self.ttfDesr:setStyle(kCCLabelTTFStyleOutline)
  self.ttfBattle:setStyle(kCCLabelTTFStyleOutline)
end
function prototype:refreshItem(data)
  if table.empty(data or {}) then
    return
  end
  self.data = data
  self.bLock = Logic:Get("Lock"):checkStatusById(self.data.lock)
  self.ttfDesr:setString(data.desc or "")
  local _, battle = Logic:Get("Lock"):GetOpenLevelAndEliteBattle(self.data.lock)
  local str = self.bLock and TwGetStr(115167, battle) or ""
  self.ttfBattle:setString(str)
  self:changeBgImg()
  self:showShopName()
end
function prototype:changeBgImg()
  local clarity = "images/public/clarity05.png"
  local normalPath = self.data.bgPath or clarity
  local matchStr = string.match(self.data.bgPath, "data/CultivateShop/(%w+).")
  local disablePath = string.gsub(self.data.bgPath, matchStr, matchStr .. "Disabled")
  local currPath = self.bLock and disablePath or normalPath
  local statues = {
    CCControlStateNormal,
    CCControlStateHighlighted,
    CCControlStateDisabled
  }
  for _, statue in ipairs(statues) do
    local spr = CCScale9Sprite:create(currPath)
    self.btnItem:setBackgroundSpriteForState(spr, statue)
  end
end
function prototype:showShopName()
  local clarity = "images/public/clarity05.png"
  local normalPath = self.data.titlePath or clarity
  local matchStr = string.match(normalPath, "data/CultivateShop/(%w+).")
  local disablePath = string.gsub(normalPath, matchStr, matchStr .. "Disabled")
  local currPath = self.bLock and disablePath or normalPath
  local spr = CCSprite:create(currPath)
  if spr then
    self.sprShopName:setDisplayFrame(spr:displayFrame())
  end
end
function prototype:onBtnItem(sender, event)
  if self.bLock then
    Prompt:Fail(115161)
    return
  end
  Logic:Get("CultivateShop"):setCurLevelData(self.data)
  SceneHelper:pushScene("CultivateExchange", self.rootNode)
end
