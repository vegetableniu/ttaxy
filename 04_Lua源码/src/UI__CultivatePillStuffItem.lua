module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
function prototype:onEnter(...)
  self.ttfName:setStyle(kCCLabelTTFStyleOutline)
  self.ttfAmount:setStyle(kCCLabelTTFStyleOutline)
end
function prototype:refresh(baseId, amount)
  self:refreshIcon(baseId)
  self:refreshDesc(baseId, amount)
end
function prototype:refreshIcon(baseId)
  local gift = {}
  gift.showType = "CULTIVATE_MATERIAL"
  gift.showId = baseId
  self.ccbIcon:ReFreshByGift(gift)
end
function prototype:refreshDesc(baseId, amount)
  local rec = Logic:Get("Cultivate"):GetStuffInfoByBaseId(baseId)
  self.ttfName:setString(rec.name or "")
  self.ttfAmount:setString(amount or "-")
end
