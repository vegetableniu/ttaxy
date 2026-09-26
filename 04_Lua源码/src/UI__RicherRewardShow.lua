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
  local iconType = Logic:Get("Monopoly"):GetShowRewardType()
  local showData = {}
  for i = 1, KFDBGetRecordAmt("MonopolyShow") do
    local rec = KFDBGetRecordByIdx("MonopolyShow", i)
    if rec and rec.iconType == iconType then
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
function prototype:onBtnBg()
end
function prototype:onBtnReturn(sender, event)
  SceneHelper:popScene()
end
