module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
require("SceneHelper")
function prototype:onEnter()
  self:clear()
  Logic:Get("SmeltResourceShop"):FireEvent(Logic.SmeltResourceShop.EVT.SET_TABLEVIEW_TOUCH, false)
  local goodsId = Logic:Get("SmeltResourceShop"):getGoodsId()
  if goodsId == nil then
    return
  end
  local info = KFDBGetRecord("ExchRewardCost", goodsId)
  if info == nil then
    return
  end
  self:createImg(info)
  local rec = json.decode(info.boxGoods or "[]") or {}
  for k, v in pairs(rec or {}) do
    local ccb = string.format("ccbIcon%d", k)
    if v.amount == nil then
      v.amount = ""
    end
    if self[ccb] then
      self[ccb]:setVisible(true)
      self[ccb]:ReFreshByGift(v, true)
    end
  end
end
function prototype:onExit()
  Logic:Get("SmeltResourceShop"):FireEvent(Logic.SmeltResourceShop.EVT.SET_TABLEVIEW_TOUCH, true)
end
function prototype:clear()
  for i = 1, 5 do
    local ccb = string.format("ccbIcon%d", i)
    if self[ccb] then
      self[ccb]:setVisible(false)
    end
  end
end
function prototype:createImg(data)
  local titlePath = ""
  local tipPath = ""
  if data.showType == "BOX_1" then
    titlePath = "images/smelt/box_1_title.png"
    tipPath = "images/smelt/box_1_tip.png"
  end
  if data.showType == "BOX_2" then
    titlePath = "images/smelt/box_2_title.png"
    tipPath = "images/smelt/box_2_tip.png"
  end
  local spr = CCSprite:create(titlePath)
  if spr then
    self.sprTitle:setDisplayFrame(spr:displayFrame())
  end
  local sprTip = CCSprite:create(tipPath)
  if sprTip then
    self.sprTip:setDisplayFrame(sprTip:displayFrame())
  end
end
function prototype:onBtnClose()
  SceneHelper:removeScene("SmeltResourceShowGood")
end
