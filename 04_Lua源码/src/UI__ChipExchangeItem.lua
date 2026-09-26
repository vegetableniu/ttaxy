module((...), package.seeall)
require("SceneHelper")
local NO_FABAO_ICON_PAHT = "images/public/clarity05.png"
prototype = Tw.Controller.prototype:extend()
function prototype:initialize()
  super.initialize(self)
end
function prototype:onEnter()
  super.onEnter(self)
end
function prototype:onBtnSelect()
end
function prototype:onBtnExchange(sender, event)
  local total = #Logic:Get("Talisman"):GetAllfabaos()
  local npctol = Logic:Get("Talisman"):GetTalismanSize()
  if total >= npctol then
    Prompt:Tip(112015)
    return
  end
  local frag = Logic:Get("Talisman"):GetFragment()
  local leiBi = Logic:Get("Talisman"):GetLeiBi()
  local costsData = {
    FRAGMENT = {
      currency = frag,
      typeStr = TwGetStr(103134),
      failStr = TwGetStr(112018)
    },
    LIEBI = {
      currency = leiBi,
      typeStr = TwGetStr(112054),
      failStr = TwGetStr(112055)
    }
  }
  local costData = costsData[self.data.costType] or {}
  if (costData.currency or 0) < self.data.fragment then
    Prompt:Fail(costData.failStr or "")
    return
  end
  Prompt:Confirm(self, "", TwGetStr(105917, self.data.fragment, costData.typeStr or "", self.data.name), self.onConfirmExchange, Prompt.PROMPT_TYPE.SELECT)
end
function prototype:onConfirmExchange()
  MsgTalisman:Post("EXCHANGE_TALISMAN", {
    id = self.data.id
  })
end
function prototype:ReFrashInfo(info)
  if info == nil or table.empty(info) then
    return
  end
  self.data = info
  self.btnExchange:setVisible(true)
  self.ccbIcon:ReFreshByGift(info)
  self.staName:setStyle(kCCLabelTTFStyleOutline)
  self.staName:setString(info.name)
  local color = Logic:Get("Gift"):GetColorByGift(info)
  self.staName:setColor(color)
  self.staTip:setStyle(kCCLabelTTFStyleOutline)
  self.staTip:setString(info.fragment)
  if self.staLevel then
    self.staLevel:create(0, "YELLOW_E_NUM")
    self.staLevel:setAlign("LEFT", "CENTER")
    self.staLevel:setValue(info.level or 1)
    self.staLevel:setVisible(true)
  end
  self:changeCostFntAndIcon()
end
function prototype:changeCostFntAndIcon()
  local costPaths = {
    FRAGMENT = {
      "images/Talisman/fntFragCost.png",
      "images/Talisman/btmfbsps.png"
    },
    LIEBI = {
      "images/Talisman/fntLieCost.png",
      "images/Talisman/leiBiIcon.png"
    }
  }
  if not costPaths[self.data.costType] then
    return
  end
  local spr = CCSprite:create(costPaths[self.data.costType][1])
  if spr then
    self.sprCostType:setDisplayFrame(spr:displayFrame())
  end
  spr = CCSprite:create(costPaths[self.data.costType][2])
  if spr then
    self.sprIcon:setDisplayFrame(spr:displayFrame())
  end
  local posX = self.staTip:getPositionX() + self.staTip:getContentSize().width + 5
  self.sprIcon:setPositionX(posX)
end
