module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
local materialId = {1, 2}
function prototype:onEnter()
  self:AddClicked(self.sprTip1)
  self.id = materialId[1]
  local rec = KFDBGetRecord("ConfigValue", "TURKEY:BUY_MATERIALS_COUNT") or {}
  self.buyCnt = json.decode(rec.content or "[]") or {}
  self:createLabel()
  Logic:Get("ThanksgivingDay"):On(Logic.ThanksgivingDay.EVT.REFRESH_INFO, self:Event("onRefreshInfo"))
end
function prototype:onMenuClose(sender, event)
end
function prototype:onBtnSure(sender, event)
  local rec = KFDBGetRecord("TurkeyMaterial", self.id)
  local cost = rec and rec.price or 0
  local cnt = self.buyCnt[tostring(self.id)] or 0
  local totalCost = cnt * cost
  local playerMoney = Logic:Get("PlayerInfo"):GetPlayerAllJade()
  if totalCost > playerMoney then
    Logic:Get("Main"):PromptCharge()
    SceneHelper:removePrompt(self.rootNode)
    return
  end
  Logic:Get("ThanksgivingDay"):PostBuyMaterial(cnt, self.id)
end
function prototype:onBtnCancelClicked(sender, event)
  SceneHelper:removePrompt(self.rootNode)
end
function prototype:onBtnTipClicked(sender, event)
  local MAX_BTN = 2
  for i = 1, MAX_BTN do
    local btn = "btnTip" .. i
    if self[btn] == sender then
      self.id = materialId[i]
      break
    end
  end
  self:AddClicked(self["sprTip" .. self.id])
end
function prototype:createLabel()
  for k, v in pairs(self.buyCnt) do
    local node = "nodMaterial" .. materialId[tonumber(k)]
    local nodCost = "nodCost" .. materialId[tonumber(k)]
    local cnt = v or 0
    local rec = KFDBGetRecord("TurkeyMaterial", materialId[tonumber(k)])
    local cost = rec and rec.price or 0
    if self[node] then
      self[node]:create(0, "GREEN_NUM")
      self[node]:setAlign("LEFT", "CENTER")
      self[node]:setValue(cnt)
    end
    if self[nodCost] then
      self[nodCost]:create(0, "GREEN_NUM")
      self[nodCost]:setAlign("LEFT", "CENTER")
      self[nodCost]:setValue(cost * cnt)
    end
  end
end
function prototype:AddClicked(node)
  local normalPath = "images/public/selcet1.png"
  local selectPath = "images/public/selcet2.png"
  local MAX_CLICK = 2
  for i = 1, MAX_CLICK do
    local spr = "sprTip" .. i
    local path = self[spr] == node and selectPath or normalPath
    local sprite = CCSprite:create(path)
    if sprite then
      self[spr]:setDisplayFrame(sprite:displayFrame())
    end
  end
end
function prototype:onRefreshInfo()
  SceneHelper:removePrompt(self.rootNode)
end
