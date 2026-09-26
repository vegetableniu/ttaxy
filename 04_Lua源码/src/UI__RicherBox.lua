require("SceneHelper")
module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
function prototype:onEnter()
  self.boxData = Logic:Get("Monopoly"):GetBoxData()
  self.ttfRings:setString(TwGetStr(115077, self.boxData.rings))
  local info = Logic:Get("Monopoly"):GetMonoInfo()
  local canDrawReward = info.rings >= self.boxData.rings
  self.btnDrawReward:setEnabled(canDrawReward)
  if not canDrawReward then
    local path = "images/Richer/fntDrawRewardDis.png"
    local spr = CCSprite:create(path)
    if spr then
      self.sprDraw:setDisplayFrame(spr:displayFrame())
    end
  end
  self:initRewards()
  Logic:Get("Monopoly"):On(Logic.Monopoly.EVT.DRAW_BOX_REWARD, self:Event("onBtnClose"))
end
function prototype:initRewards()
  local positions = {
    {320},
    {260, 380},
    {
      320,
      160,
      480
    },
    {
      140,
      260,
      380,
      500
    }
  }
  local levels = json.decode(self.boxData.levels) or {}
  local idx = 1
  local playerLv = Logic:Get("PlayerInfo"):GetPlayerLevel()
  for i, level in ipairs(levels) do
    if level >= playerLv then
      idx = i
      break
    end
  end
  local rewardNames = json.decode(self.boxData.boxRewards)[idx] or {}
  local showTypes = json.decode(self.boxData.showTypes)[idx] or {}
  local showIds = json.decode(self.boxData.showIds)[idx] or {}
  local amounts = json.decode(self.boxData.amounts)[idx] or {}
  for i = 1, 4 do
    local nod = "nodReward" .. i
    local ttf = "ttfReward" .. i
    local ccb = "ccbReward" .. i
    if showTypes[i] then
      local data = {}
      data.showType = showTypes[i]
      data.showId = showIds[i]
      data.amount = amounts[i]
      self:refreshIcon(self[ccb], data)
      local color = Logic:Get("Gift"):GetColorByGift(data)
      self[ttf]:setStyle(kCCLabelTTFStyleOutline)
      self[ttf]:setColor(color)
      self[ttf]:setString(rewardNames[i] or "")
      self[nod]:setPositionX(positions[#showTypes][i])
    else
      self[nod]:setVisible(false)
    end
  end
end
function prototype:refreshIcon(node, data)
  if node == nil then
    return
  end
  node:ReFreshByGift(data)
end
function prototype:onBtnBg()
end
function prototype:onBtnDrawReward()
  Logic:Get("Monopoly"):PostDrawBoxReward(self.boxData.id)
end
function prototype:onBtnClose()
  SceneHelper:popScene()
end
