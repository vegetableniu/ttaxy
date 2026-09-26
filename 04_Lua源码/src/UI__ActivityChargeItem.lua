module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
local CLARITY_PATH = "images/public/clarity05.png"
function prototype:onEnter()
  self.ttfChargeAmount:setStyle(kCCLabelTTFStyleOutline)
end
function prototype:onBtnBuy(sender, event)
  local chargeInfo = Logic:Get("ActivityCharge"):GetChargeInfo()
  if chargeInfo.charge < self.data.charge then
    Logic:Get("Main"):GotoRecharge()
    return
  end
  Logic:Get("ActivityCharge"):postDraw(self.data.id)
end
function prototype:Refrash(data)
  if table.empty(data or {}) then
    return
  end
  self.data = data
  local chargeInfo = Logic:Get("ActivityCharge"):GetChargeInfo()
  local chargeAmount = data.charge or 0
  self.ttfChargeAmount:setString(chargeInfo.charge .. "/" .. chargeAmount)
  local ccbs = list.map(function(index)
    return self["ccbReward" .. index]
  end, table.indices(list.rep({0}, 4)))
  for i, ccb in ipairs(ccbs) do
    if data.showTypes[i] then
      local showData = {}
      showData.showType = data.showTypes[i]
      showData.showId = data.showIds[i]
      showData.amount = data.amounts[i]
      ccb:setVisible(true)
      ccb:ReFreshByGift(showData)
    else
      ccb:setVisible(false)
    end
  end
  local hasDraw = Logic:Get("ActivityCharge"):HasDrawReward(self.data.id)
  self.nodBtn:setVisible(not hasDraw)
  self.sprHasDraw:setVisible(hasDraw)
  local gochargePath = "images/newfont/fntGo2Charge.png"
  local drawPath = "images/Explore/fntDraw.png"
  local path = chargeAmount > chargeInfo.charge and gochargePath or drawPath
  local spr = CCSprite:create(path)
  if spr then
    self.sprBtnFont:setDisplayFrame(spr:displayFrame())
  end
end
