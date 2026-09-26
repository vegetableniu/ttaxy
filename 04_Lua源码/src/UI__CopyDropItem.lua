module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
local ITEM_MAX = 5
local ITEM_SPACE = 80
function prototype:initialize(...)
  super.initialize(self, ...)
end
function prototype:dispose(...)
  super.dispose(self)
end
function prototype:onEnter()
end
function prototype:showDropItemInfo(info)
  if info and not table.empty(info) then
    self.staCopyName:setStyle(kCCLabelTTFStyleOutline)
    self.staCopyName:setString(info.name or "")
  end
  for i = 1, ITEM_MAX do
    local pnlHero = "m_pCHeroIcon" .. i
    local frament = "imgFrament" .. i
    self[pnlHero]:setVisible(false)
    self[frament]:setVisible(false)
  end
  local pnlHeroId = {}
  local imgFrament = {}
  local canSpot = 0
  local itemType = {}
  if info and not table.empty(info) and info.itemDrop then
    local tab = json.decode(info.itemDrop)
    for k, v in pairs(tab) do
      local num = 0
      if v.type == "HERO" or v.type == "TREASURE" or v.type == "SKILL_CARD" or v.type == "COIN_CARD" or v.type == "EXP_CARD" then
        canSpot = canSpot + 1
        pnlHeroId[canSpot] = v.code
        itemType[canSpot] = v.type
      elseif v.type == "FRAGMENT" then
        canSpot = canSpot + 1
        pnlHeroId[canSpot] = v.code
        imgFrament[canSpot] = true
        itemType[canSpot] = v.type
      end
    end
  end
  for i = 1, ITEM_MAX do
    local pnlHero = "m_pCHeroIcon" .. i
    local fraImg = "imgFrament" .. i
    if pnlHeroId[i] then
      self[pnlHero]:ReFrashHeroInfo(pnlHeroId[i], true, itemType[i])
      self[pnlHero]:setVisible(true)
    end
    if imgFrament[i] then
      local sprite = Logic:Get("Compose"):GetJigsawImg()
      if sprite then
        self[fraImg]:setVisible(true)
        self[fraImg]:setDisplayFrame(sprite:displayFrame())
      end
    end
  end
end
