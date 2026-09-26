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
  if heroInfo.rank > 5 then
    heroInfo.rank = 5
  end
  self.ttfName:setColor(ccColor3B(unpack(COLOR[heroInfo.rank])))
  self.ttfName:setString(heroInfo.name)
  self.ttfName:setStyle(kCCLabelTTFStyleOutline)
  if heroInfo.star ~= 0 then
    self.ttfStar:setColor(ccColor3B(0, 0, 0))
    self.ttfStar:setString(TwGetStr(104160, heroInfo.star))
  end
  if heroInfo.num ~= 0 then
    self.ttfNum:setString(TwGetStr(101201, heroInfo.num))
  end
end
