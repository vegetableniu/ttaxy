require("SceneHelper")
module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
function prototype:onEnter()
end
function prototype:Refresh(data)
  if table.empty(data or {}) then
    return
  end
  local showTypes = json.decode(data.showTypes or "[]")
  local showIds = json.decode(data.showIds or "[]")
  local amounts = json.decode(data.amounts or "[]")
  local MAX_ITEM = 12
  for i = 1, MAX_ITEM do
    local str = string.format("ccbTrea%d", i)
    local showData = {}
    showData.showType = showTypes[i]
    showData.showId = showIds[i]
    showData.amount = amounts[i]
    if not table.empty(showData) then
      self[str]:ReFreshByGift(showData)
    else
      self[str]:setVisible(false)
    end
  end
end
