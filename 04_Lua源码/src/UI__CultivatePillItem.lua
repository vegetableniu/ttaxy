module((...), package.seeall)
require("SceneHelper")
prototype = BtnPosition.prototype:extend()
function prototype:onEnter(...)
  self.ttfName:setStyle(kCCLabelTTFStyleOutline)
  self.ttfAlter1:setStyle(kCCLabelTTFStyleOutline)
  self.ttfAlter2:setStyle(kCCLabelTTFStyleOutline)
  self.ttfAmount:setStyle(kCCLabelTTFStyleOutline)
  self.ttfState:setStyle(kCCLabelTTFStyleOutline)
end
function prototype:refresh(data)
  if not data then
    return
  end
  self.data = data
  self:refreshIcon(data)
  self:refreshDesc(data)
end
function prototype:refreshIcon(data)
  local gift = {}
  gift.showType = data.stuff and "CULTIVATE_MATERIAL" or "CULTIVATE_ELIXIR"
  gift.showId = data.baseId
  local index = 1
  self.ccbIcon:ReFreshByGift(gift)
  if not data.stuff then
    local rec = Logic:Get("Cultivate"):GetPillInfoByBaseId(data.baseId)
    local spr = Logic:Get("Cultivate"):GetTypeImage(rec.type)
    if spr then
      self.sprType:setDisplayFrame(spr:displayFrame())
    end
    local tAlters = json.decode(rec.alters or "") or {}
    for k, v in pairs(tAlters) do
      local sprAlter = string.format("sprAlter%d", index)
      local ttfAlter = string.format("ttfAlter%d", index)
      local spr = Logic:Get("Cultivate"):getPropertySpr(k)
      if spr and self[sprAlter] then
        self[sprAlter]:setDisplayFrame(spr:displayFrame())
      end
      v = tonumber(v)
      local value = v < 10 and v ~= 0 and 100 * v .. "%" or v
      if self[ttfAlter] then
        self[ttfAlter]:setString("+" .. value)
      end
      index = index + 1
    end
  end
  self.nodeAlter1:setVisible(data.stuff ~= true)
  self.nodeAlter2:setVisible(data.stuff ~= true)
  self.sprType:setVisible(data.stuff ~= true)
  self.sprUse:setVisible(data.stuff ~= true)
  if index > 2 then
    self.nodeAlter1:setVisible(true)
    self.nodeAlter2:setVisible(true)
    self.nodeAlter1:setPosition(ccp(135, 42))
    self.nodeAlter2:setPosition(ccp(245, 42))
    return
  end
  self.nodeAlter2:setVisible(false)
  self.nodeAlter1:setPosition(ccp(177, 42))
end
function prototype:refreshDesc(data)
  local rec = {}
  local strState = ""
  if data.stuff then
    rec = Logic:Get("Cultivate"):GetStuffInfoByBaseId(data.baseId)
    strState = ""
  else
    rec = Logic:Get("Cultivate"):GetPillInfoByBaseId(data.baseId)
    strState = Logic:Get("Cultivate"):GetStateNameByBaseId(data.baseId)
  end
  self.rec = rec
  self.ttfName:setString(rec.name or "")
  self.ttfAmount:setString(data.amount or "-")
  self.ttfState:setString(strState or "")
end
function prototype:onBtnIcon(...)
  if not self.data then
    return
  end
  Logic:Get("Cultivate"):OpenPillDetail(self.data.baseId)
end
