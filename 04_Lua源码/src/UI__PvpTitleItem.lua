module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
CLARITY_PATH = "images/public/clarity05.png"
function prototype:initialize(...)
  super.initialize(self, ...)
end
function prototype:dispose(...)
  super.dispose(self)
end
function prototype:onEnter()
  self.ttfRank:setStyle(kCCLabelTTFStyleOutline)
  self.ttfAct:setStyle(kCCLabelTTFStyleOutline)
end
function prototype:onNodeLoaded(node, loader)
end
function prototype:RefreshTitleInfo(info)
  if info == nil then
    return
  end
  self.ttfDesr:setString("")
  local rec = KFDBGetRecord("RankRewardConfig", info.rankID)
  if rec and rec.icoPath ~= "" then
    local spr = CCSprite:create(rec.logoPath)
    if spr then
      self.sprTitle1:setDisplayFrame(spr:displayFrame())
    end
    spr = CCSprite:create(rec.icoPath)
    if spr then
      self.sprTitle2:setDisplayFrame(spr:displayFrame())
    end
  end
  if info.highRank == info.lowRank then
    self.ttfRank:setString(TwGetStr(105512, info.highRank or 0))
  else
    self.ttfRank:setString(TwGetStr(105517, info.lowRank or 0, info.highRank or 0))
  end
  self.ttfAct:setString(info.buffID or "")
  if info.id == 5 then
    self.ttfDesr:setString(TwGetStr(105806))
  end
end
