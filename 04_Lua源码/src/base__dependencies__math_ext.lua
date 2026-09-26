module("math", package.seeall)
local _floor = floor
function floor(n, p)
  if p and p ~= 0 then
    local e = 10 ^ p
    return _floor(n * e) / e
  else
    return _floor(n)
  end
end
function round(n, p)
  local e = 10 ^ (p or 0)
  return _floor(n * e + 0.5) / e
end
