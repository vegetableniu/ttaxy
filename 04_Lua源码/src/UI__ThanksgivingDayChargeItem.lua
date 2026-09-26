module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
local itemPath = {
  nor = "images/public/btn_short_nor.png",
  dis = "images/public/btn_short_dis.png"
}
local flagePath = {
  can = "images/groupChase/canGet.png",
  has = "images/groupChase/hasGet.png",
  other = "images/public/clarity05.png"
}
local materialPath = {
  "images/Thanksgiving/fruits.png",
  "images/Thanksgiving/chicken.png"
}
function prototype:onEnter()
end
function prototype:refreshInfo(data, index)
  if data == nil then
    return
  end
  self.data = data
  self.index = index
  self.sprDesc:setVisible(false)
  if data.vip == "true" or data.vip == "TRUE" then
    self.data.monVip = true
    self.data.weekVip = false
    self:setVipAndWeekInfo()
    return
  end
  if data.week == "true" or data.week == "TRUE" then
    self.data.monVip = false
    self.data.weekVip = true
    self:setVipAndWeekInfo()
    return
  end
  self:setChargeInfo()
end
function prototype:setVipAndWeekInfo()
  self.nodeVip:setVisible(true)
  self.nodeCharge:setVisible(false)
  self.sprFlage:setVisible(true)
  self.nodMaterial1:create(0, "GREEN_NUM")
  self.nodMaterial1:setAlign("LEFT", "CENTER")
  self.nodMaterial2:create(0, "GREEN_NUM")
  self.nodMaterial2:setAlign("LEFT", "CENTER")
  local reward = Logic:Get("Reward"):kdbRewardConfig(self.data.rewardId)
  for k, v in pairs(reward.fixed or {}) do
    local nodMaterial = string.format("nodMaterial%d", v.code)
    if self[nodMaterial] then
      self[nodMaterial]:setValue(v.amount or 0)
    end
  end
  local isMonVip = Logic:Get("PlayerInfo"):hasMonthVipFunc()
  local isWeekVip = Logic:Get("PlayerInfo"):IsWeekVip()
  local hasDraw = Logic:Get("Chargereturn"):isDraw(self.data.id)
  if self.data.monVip then
    self.data.canDraw = isMonVip
  end
  if self.data.weekVip then
    self.data.canDraw = isWeekVip
  end
  self.data.hasDraw = hasDraw
  self:setFlage()
  self:createGoodsImg()
end
function prototype:createGoodsImg()
  local strGoods = ""
  if self.data.monVip then
    strGoods = "images/Other/monVip.png"
  end
  if self.data.weekVip then
    strGoods = "images/Other/weekVip.png"
  end
  if self.index == 2 then
    self.sprDesc:setVisible(true)
  end
  local ccSprite = CCSprite:create(strGoods)
  if ccSprite then
    self.sprVip:setDisplayFrame(ccSprite:displayFrame())
  end
end
function prototype:setChargeInfo(...)
  self.nodeVip:setVisible(false)
  self.nodeCharge:setVisible(true)
  self.sprFlage:setVisible(true)
  self.nodFruits:create(0, "GREEN_NUM")
  self.nodFruits:setAlign("LEFT", "CENTER")
  self.nodProgress:create(0, "GREEN_NUM")
  self.nodProgress:setAlign("LEFT", "CENTER")
  local reward = Logic:Get("Reward"):kdbRewardConfig(self.data.rewardId)
  self.nodFruits:setValue(reward.fixed[1].amount)
  self.nodProgress:setValue(self.data.hasCharge .. "/" .. self.data.charge)
  local sprite = CCSprite:create(itemPath.nor)
  if sprite then
    self.sprItemBg:setDisplayFrame(sprite:displayFrame())
  end
  local path = materialPath[reward.fixed[1].code] or materialPath[2]
  local spr = CCSprite:create(path)
  if spr then
    self.sprMaterial:setDisplayFrame(spr:displayFrame())
  end
  self.data.hasDraw = Logic:Get("Chargereturn"):isDraw(self.data.id)
  if self.data.hasCharge >= self.data.charge then
    self.data.canDraw = true
  else
    self.data.canDraw = false
  end
  self:setFlage()
  if self.data.canDraw or self.data.hasDraw then
    return
  end
  self.sprFlage:setVisible(false)
  local sprite = CCSprite:create(itemPath.dis)
  if sprite then
    self.sprItemBg:setDisplayFrame(sprite:displayFrame())
  end
end
function prototype:setFlage()
  local imgPath = flagePath.other
  if self.data.canDraw then
    imgPath = flagePath.can
  end
  if self.data.hasDraw then
    imgPath = flagePath.has
  end
  local sprite = CCSprite:create(imgPath)
  if sprite then
    self.sprFlage:setDisplayFrame(sprite:displayFrame())
  end
end
function prototype:onBtnDraw()
  if not self.data.hasDraw and self.data.canDraw then
    Logic:Get("Chargereturn"):PostDrawReward(self.data.id)
  end
end
