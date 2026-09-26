module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
function prototype:onEnter(...)
  for i = 1, 10 do
    local str = string.format("labText%d", i)
    if self[str] then
      self[str]:setStyle(kCCLabelTTFStyleOutline)
    end
  end
  self:setInfo()
end
function prototype:setInfo()
  local rec = KFDBGetRecord("LanguageSetting", 1001)
  self.labTitle:setString(rec and rec.content or "")
  for i = 1, 10 do
    rec = KFDBGetRecord("LanguageSetting", 1001 + i)
    local str = string.format("labText%d", i)
    if self[str] then
      self[str]:setString(rec and rec.content or "")
    end
  end
end
