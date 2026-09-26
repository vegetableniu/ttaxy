module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
local DEFAULT_PATH = "images/public/clarity80.png"
function prototype:onEnter()
end
function prototype:refreshInfo(info)
  if not info or not info.cards then
    return
  end
  local str = ""
  local nameStrNum = 111351
  local othersStrNum = 111351
  local _, finishCombo = Logic:Get("FoolsDay"):getFinishCombos()
  if self:isFinish(finishCombo, info) then
    othersStrNum = 111349
  end
  for i = 1, #info.cards do
    local name = Logic:Get("Hero"):GetHeroInfoByBaseId(tonumber(info.cards[i])).name
    if Logic:Get("FoolsDay"):isCheck(tonumber(info.cards[i])) then
      nameStrNum = 111348
    else
      nameStrNum = 111351
    end
    str = str .. TwGetStr(nameStrNum, name)
    if i < #info.cards then
      str = str .. TwGetStr(othersStrNum, "&nbsp;+&nbsp;")
    else
      str = str .. TwGetStr(othersStrNum, "&nbsp;=&nbsp;")
      str = str .. TwGetStr(othersStrNum, info.desc)
    end
  end
  self.ttfDesc:setString(str)
end
function prototype:isFinish(tabs, info)
  if not tabs or table.empty(tabs) then
    return false
  end
  for i, v in pairs(tabs) do
    if v.levelSegment == info.levelSegment and v.id == info.id then
      return true
    end
  end
  return false
end
