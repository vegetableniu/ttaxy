module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
local SCROLL_WIDTH = 560
local SCROLL_HEIGHT = 180
function prototype:onEnter(...)
  self.ttfNum:setStyle(kCCLabelTTFStyleOutline)
  self.ttfDesc:setStyle(kCCLabelTTFStyleOutline)
  Logic:Get("BattleShow"):On(Logic.BattleShow.EVT.END, self:Event("OnCulBattleEnd"))
  Logic:Get("Cultivate"):On(Logic.Cultivate.EVT.STUFF_CHANGE, self:Event("OnStuffChange"))
  local baseId = Logic:Get("Cultivate"):GetCheckedStuff()
  local container = Tw.Controller:load("CultivateStuffView", self.rootNode)
  container:refresh(baseId)
  self:scrollViewWithContainer(container)
  self:refreshIcon(baseId)
end
function prototype:scrollViewWithContainer(container)
  local scroll = CCScrollViewEx:create(CCSizeMake(SCROLL_WIDTH, SCROLL_HEIGHT))
  scroll:setDirection(kCCScrollViewDirectionVertical)
  scroll:setClippingToBounds(true)
  scroll:setTouchEnabled(false)
  scroll:setContainer(container)
  scroll:updateInset()
  container:setPositionY(SCROLL_HEIGHT - container:getSize().height)
  self.nodeView:addChild(scroll)
  self.scroll = scroll
end
function prototype:refreshIcon(baseId)
  local gift = {}
  gift.showType = "CULTIVATE_MATERIAL"
  gift.showId = baseId
  self.ccbIcon:ReFreshByGift(gift)
  local rec = Logic:Get("Cultivate"):GetStuffInfoByBaseId(baseId)
  self.ttfName:setString(rec.name or "")
  local desc = ReplaceStringTab(rec.desc)
  self.ttfDesc:setString(desc or "")
  local num = Logic:Get("Cultivate"):GetStuffByBaseId(baseId)
  local strNum = TwGetStr(114111, num)
  self.ttfNum:setString(strNum or "-")
end
function prototype:onBtnClose(...)
  if SceneHelper:isExistScene("CultivateStuffInfo") then
    SceneHelper:removeScene("CultivateStuffInfo")
  else
    SceneHelper:removePrompt(self.rootNode)
  end
end
function prototype:OnCulBattleEnd(...)
  local baseId = Logic:Get("Cultivate"):GetCheckedStuff()
  self:refreshIcon(baseId)
  local info = Logic:Get("Cultivate"):GetCheckedStuffInfo()
  if not info or not info.amount then
    return
  end
  local stuffNum = Logic:Get("Cultivate"):GetStuffByBaseId(info.baseId)
  if stuffNum >= info.amount then
    SceneHelper:removeScene("CultivateStuffInfo")
  end
end
function prototype:OnStuffChange()
  local baseId = Logic:Get("Cultivate"):GetCheckedStuff()
  self:refreshIcon(baseId)
end
