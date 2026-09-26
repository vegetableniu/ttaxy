module((...), package.seeall)
require("SceneHelper")
require("BtnPosition")
prototype = BtnPosition.prototype:extend()
function prototype:initialize(...)
  super.initialize(self, ...)
end
function prototype:dispose(...)
  super.dispose(self)
end
function prototype:onEnter()
  super.onEnter(self)
  local mallData = Logic:Get("Preciousroom"):GetMallData()
  local showData = {}
  for i = 1, KFDBGetRecordAmt("PreciousShow") do
    local rec = KFDBGetRecordByIdx("PreciousShow", i)
    if rec and rec.mallId == mallData.id then
      table.insert(showData, rec)
    end
  end
  local MAX_ITEM = 12
  for i = 1, MAX_ITEM do
    local str = string.format("ccbTrea%d", i)
    local nod = string.format("nodTrea%d", i)
    local name = string.format("ttfName%d", i)
    if showData[i] then
      self[str]:ReFreshByGift(showData[i])
      self[name]:setStyle(kCCLabelTTFStyleOutline)
      self[name]:setString(showData[i].name or "")
      local color = Logic:Get("Gift"):GetColorByGift(showData[i])
      self[name]:setColor(color)
    else
      self[nod]:setVisible(false)
    end
  end
end
function prototype:onExit()
end
function prototype:getColor(data)
  if data.showType == "HERO" then
    return Logic:Get("Hero"):getColorByBaseId(data.showId)
  end
  if data.showType == "TALISMAN" then
    local rec = KFDBGetRecord("TalismanSetting", data.showId)
    return Logic:Get("Hero"):getColorByBaseId(rec.baseId)
  end
  if data.showType == "EQUIPMENT" or data.showType == "EQUIPMENT_FRAGMENT" then
    return Logic:Get("Armor"):getColorByBaseId(data.showId)
  end
  return Logic:Get("Lottery"):GetHeroRankColor3(data.showId)
end
function prototype:onBtnReturn(sender, event)
  SceneHelper:runWithScene("MallRaceShop", self.rootNode)
end
