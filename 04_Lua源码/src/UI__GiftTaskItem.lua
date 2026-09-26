module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
function prototype:onEnter()
end
function prototype:refreshInfo(data)
  if table.empty(data) then
    return
  end
  self.data = data
  self:refreshBaseInfo(data)
end
function prototype:refreshLastGift(data)
  self:refreshInfo(data)
  self.nodTaskFeat:setPositionY(-7)
  self.ccbIcon:setScale(0.8)
  self.ccbIcon:setPositionY(121)
end
function prototype:refreshBaseInfo(data)
  self.ccbIcon:ReFreshByGift(data)
  self.nodFeat:create(0, "YELLOW_E_NUM")
  self.nodFeat:setAlign("RIGHT", "CENTER")
  self.nodFeat:setValue(data.feats)
  self:createGetImg()
end
function prototype:createGetImg()
  self.sprGetReward:setVisible(true)
  if Logic:Get("GodReward"):IsDrawFeatReward(self.data.id) then
    self:changeFinImg("images/GodReward/getReward.png")
    self.btnFeatReward:setEnabled(false)
    return
  end
  local feats = Logic:Get("GodReward"):GetFeats()
  if feats >= self.data.feats then
    self:changeFinImg("images/GodReward/clickGet.png")
    self.btnFeatReward:setEnabled(true)
    return
  end
  self:changeFinImg("images/public/clarity05.png")
  self.btnFeatReward:setEnabled(false)
end
function prototype:changeFinImg(path)
  local spr = CCSprite:create(path)
  if spr then
    self.sprGetReward:setDisplayFrame(spr:displayFrame())
  end
end
function prototype:onBtnFeatReward(sender, event)
  Logic:Get("GodReward"):PostGetFeatReward(self.data.id)
end
