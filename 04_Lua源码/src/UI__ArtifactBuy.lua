module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
local path = "images/public/selcet2.png"
function prototype:onEnter()
  self:AddClicked(self.sprTip1)
  self.idx = 1
  self.data = {}
  local mallData = Logic:Get("Mall"):GetSoulStoneData()
  self.ttfTitle:setStyle(kCCLabelTTFStyleOutline)
  self.ttfTitle:setString(mallData.title or "")
  for i = 1, KFDBGetRecordAmt("SoulstonePackageSetting") do
    local rec = KFDBGetRecordByIdx("SoulstonePackageSetting", i)
    if rec and rec.mallId == mallData.id then
      table.insert(self.data, rec)
    end
  end
  local sort = function(a, b)
    return a.stoneCount < b.stoneCount
  end
  table.sort(self.data, sort)
  local giftActivityInfo = Logic:Get("Gift"):GetActivityByType("SOUL_STONE_SALE")
  local isOpen = false
  if not table.empty(giftActivityInfo) and giftActivityInfo[1].mallId == mallData.id then
    isOpen = true
  end
  for i, v in ipairs(self.data) do
    local str = string.format("ttfTip%d", i)
    local strCost = string.format("ttfNoDis%d", i)
    local strSendNum = string.format("ttfSendNum%d", i)
    if self[str] then
      local strType = Logic:Get("Artifact"):GetStrByType(v.soulStoneType)
      self[str]:setString(strType .. ":" .. v.stoneCount)
    end
    if self[strCost] then
      self[strCost]:setString(TwGetStr(104280) .. v.cost)
    end
    if self[strSendNum] and isOpen then
      self[strSendNum]:setString(TwGetStr(108040, v.giftCount))
    end
  end
end
function prototype:onMenuClose(sender, event)
end
function prototype:onBtnSure(sender, event)
  if self.data[self.idx] == nil then
    return
  end
  local playerMoney = Logic:Get("PlayerInfo"):GetPlayerAllJade()
  if playerMoney < self.data[self.idx].cost then
    Logic:Get("SureConfirm").btnText.ok = TwGetStr(104003)
    Prompt:Confirm(Logic:Get("Main"), "", 105316, Logic:Get("Main").GotoRecharge, Prompt.PROMPT_TYPE.SELECT)
    SceneHelper:removePrompt(self.rootNode)
    return
  end
  Logic:Get("Artifact"):PostBuySoulStone(self.data[self.idx].id)
  SceneHelper:removePrompt(self.rootNode)
end
function prototype:onBtnCancelClicked(sender, event)
  SceneHelper:removePrompt(self.rootNode)
end
function prototype:onBtnTipClicked(sender, event)
  if sender == self.btnTip1 then
    self:AddClicked(self.sprTip1)
    self.idx = 1
  elseif sender == self.btnTip2 then
    self:AddClicked(self.sprTip2)
    self.idx = 2
  elseif sender == self.btnTip3 then
    self:AddClicked(self.sprTip3)
    self.idx = 3
  end
end
function prototype:AddClicked(node)
  if node == nil then
    return
  end
  local lockChild = self.layer:getChildByTag(100)
  if lockChild ~= nil then
    self.layer:removeChildByTag(100, true)
  end
  local spr = CCSprite:create(path)
  if spr then
    spr:setAnchorPoint(CCPoint(0.5, 0.5))
    local x = node:getPositionX()
    local y = node:getPositionY()
    spr:setPosition(ccp(x, y))
    self.layer:addChild(spr, 10, 100)
  end
end
function prototype:onBuySuccess()
  SceneHelper:removePrompt(self.rootNode)
end
