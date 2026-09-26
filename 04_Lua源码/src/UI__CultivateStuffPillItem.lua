module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
function prototype:onEnter(...)
  self.ttfName:setStyle(kCCLabelTTFStyleOutline)
  self.ttfAlter:setStyle(kCCLabelTTFStyleOutline)
end
function prototype:refresh(baseId)
  if not baseId then
    return
  end
  self:refreshIcon(baseId)
  self:refreshDesc(baseId)
end
function prototype:refreshIcon(baseId)
  local gift = {}
  gift.showType = "CULTIVATE_ELIXIR"
  gift.showId = baseId
  self.ccbIcon:ReFreshByGift(gift)
end
function prototype:refreshDesc(baseId)
  local rec = Logic:Get("Cultivate"):GetPillInfoByBaseId(baseId)
  self.ttfName:setString(rec.name or "")
  local spr = Logic:Get("Cultivate"):GetTypeImage(rec.type)
  if spr then
    self.sprType:setDisplayFrame(spr:displayFrame())
  end
  local tAlters = json.decode(rec.alters or "") or {}
  for k, v in pairs(tAlters) do
    local spr = Logic:Get("Cultivate"):getPropertySpr(k)
    if spr then
      self.sprAlter:setDisplayFrame(spr:displayFrame())
    end
    v = tonumber(v)
    local value = v < 10 and v ~= 0 and 100 * v .. "%" or v
    self.ttfAlter:setString("+" .. value)
  end
end
