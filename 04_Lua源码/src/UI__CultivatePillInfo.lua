module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
local SCROLL_WIDTH = 560
local SCROLL_HEIGHT = 320
function prototype:onEnter(...)
  self.ttfNum:setStyle(kCCLabelTTFStyleOutline)
  self.ttfName:setStyle(kCCLabelTTFStyleOutline)
  local baseId = Logic:Get("Cultivate"):GetCheckedPill()
  self:refreshIcon(baseId)
  self:refreshDesc()
end
function prototype:refreshIcon(baseId)
  local gift = {}
  gift.showType = "CULTIVATE_ELIXIR"
  gift.showId = baseId
  self.ccbIcon:ReFreshByGift(gift)
  local rec = Logic:Get("Cultivate"):GetPillInfoByBaseId(baseId)
  self.rec = rec
  self.ttfName:setString(rec.name or "")
  local spr = Logic:Get("Cultivate"):GetTypeImage(rec.type)
  if spr then
    self.sprType:setDisplayFrame(spr:displayFrame())
  end
  local num = Logic:Get("Cultivate"):GetPillByBaseId(baseId)
  self.ttfNum:setString(num or "-")
  local tAlters = json.decode(rec.alters or "") or {}
  local index = 1
  for k, v in pairs(tAlters) do
    local sprAlter = string.format("sprAlter%d", index)
    local bmAlter = string.format("bmAlter%d", index)
    local spr = Logic:Get("Cultivate"):getPropertySpr(k)
    if spr and self[sprAlter] then
      self[sprAlter]:setDisplayFrame(spr:displayFrame())
    end
    local num = tonumber(v)
    local valuePct = num < 10 and num ~= 0 and 100 * num .. "%" or num
    if self[bmAlter] then
      self[bmAlter]:setString("+" .. valuePct)
    end
    index = index + 1
  end
  self.nodAttr1:setVisible(true)
  self.nodAttr2:setVisible(false)
  if index > 2 then
    self.nodAttr2:setVisible(true)
    self.nodAttr1:setPosition(ccp(225, 511))
    self.nodAttr2:setPosition(ccp(430, 511))
    return
  end
  self.nodAttr1:setPosition(ccp(330, 511))
end
function prototype:refreshDesc(...)
  local jobPath = string.format("images/Cultivate/job%d.png", self.rec.type)
  local sprite = CCSprite:create(jobPath or "images/public/clarity05.png")
  if sprite then
    self.sprJob:setDisplayFrame(sprite:displayFrame())
  end
  local strDesc = ReplaceStringTab(self.rec.decs)
  self.ttfDesc:setString(strDesc or "")
end
function prototype:onBtnClose(...)
  if SceneHelper:isExistScene("CultivatePillInfo") then
    SceneHelper:removeScene("CultivatePillInfo")
  else
    SceneHelper:removePrompt(self.rootNode)
  end
end
