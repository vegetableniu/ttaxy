require("SceneHelper")
require("BtnPosition")
module((...), package.seeall)
prototype = BtnPosition.prototype:extend()
function prototype:onEnter()
  super.onEnter(self)
  local rec = KFDBGetRecord("ConfigValue", "ACTIVITYCHARGE:CHARGE_DATA") or {}
  local showInfo = json.decode(rec.content or {})
  self.labPrice:create(showInfo.price or 0, "YELLOW_E_NUM")
  self.labPrice:setAlign("RIGHT", "CENTER")
  self.labGetJade:create(showInfo.buyJade or 0, "PINK_NUM")
  self.labGetJade:setAlign("CENTER", "CENTER")
  self.labGiveJade:create(showInfo.giveJade or 0, "LARGE_NUM")
  self.labGiveJade:setAlign("CENTER", "CENTER")
  local monthsTime = Logic:Get("PlayerInfo"):getMonsthTime()
  local diffTime = Logic:Get("System"):DiffTime(monthsTime / 1000)
  self.nodBuy:setVisible(diffTime < 0)
  self.nodLeftDay:setVisible(diffTime >= 0)
  if diffTime >= 0 then
    local secDay = Logic:Get("System"):SecToDay(diffTime)
    local str = TwGetStr(111043, secDay.day or 0)
    self.ttfLeftDay:setString(str)
    self.ttfLeftDay:setStyle(kCCLabelTTFStyleOutline)
  end
end
function prototype:onBtnReturn(sender, event)
  SceneHelper:runWithScene("GiftActivityList", self.rootNode)
end
function prototype:onBtnRight(sender, event)
end
function prototype:onBtnBuy(sender, event)
  Logic:Get("Main"):GotoRecharge()
end
