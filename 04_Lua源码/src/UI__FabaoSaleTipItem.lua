module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
require("SceneHelper")
COLOR = {
  [1] = {
    255,
    255,
    255
  },
  [2] = {
    76,
    171,
    5
  },
  [3] = {
    0,
    74,
    150
  },
  [4] = {
    206,
    36,
    242
  },
  [5] = {
    255,
    255,
    0
  }
}
function prototype:onEnter()
end
function prototype:ReFrashReward(heroInfo)
  if heroInfo == nil then
    return
  end
  if heroInfo.rank == nil then
    return
  end
  if heroInfo.rank > 5 then
    heroInfo.rank = 5
  end
  if COLOR[heroInfo.rank] then
    local color = Logic:Get("Lottery"):GetHeroRankColor3(heroInfo.rank)
    self.ttfName:setColor(color)
  end
  self.ttfName:setString(heroInfo.name)
  self.ttfName:setStyle(kCCLabelTTFStyleOutline)
  if heroInfo.num ~= 0 then
    self.ttfNum:setString(TwGetStr(101201, heroInfo.num))
  end
end
