require("SceneHelper")
module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
function prototype:onEnter()
end
function prototype:refreshItem(data)
  self:refreshBuffIcon(data)
  self.ttfDesr:setString(ReplaceStringTab(data.desr or ""))
end
function prototype:refreshBuffIcon(data)
  local typeMap = {
    NONE = "images/public/clarity05.png",
    GONE = "images/Richer/heart.png",
    TASK = "images/Richer/taskIcon.png",
    SHOP = "images/Richer/valeShop.png",
    SILVER_BOX = "images/Richer/greenBox.png",
    CROSSING = "images/Richer/crossing.png",
    GOLD_BOX = "images/Richer/goldBoxOpen.png",
    HOVER = "images/Richer/hover.png",
    LOSE = "images/Richer/lose.png",
    SLOW = "images/Richer/slow.png",
    TOXICOSIS = "images/Richer/toxicosis.png",
    GOSSIP = "images/Richer/gossip.png",
    REDOUBLE_DICE = "images/Richer/redoubleDice.png",
    DOUBLE_REWARD = "images/Richer/doubleReward.png",
    FAST = "images/Richer/fast.png",
    RAMDOM = "images/Richer/random.png",
    FORWARD = "images/Richer/trapForward.png",
    BACK = "images/Richer/trapBack.png",
    TRANSFER = "images/Richer/transfer.png",
    LUCKY = "images/Richer/lucky.png"
  }
  if not typeMap[data.id] then
    return
  end
  local spr = CCSprite:create(typeMap[data.id])
  if spr then
    self.sprBuffIcon:setDisplayFrame(spr:displayFrame())
  end
end
