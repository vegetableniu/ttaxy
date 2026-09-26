module("bin", package.seeall)
function le_to_number(s)
  local res = 0
  for i = #s, 1, -1 do
    res = res * 256 + string.byte(s, i)
  end
  return res
end
function le_to_hex(s)
  local res = ""
  for i = 1, #s do
    res = res .. string.format("%.2x", string.byte(s, i))
  end
  return res
end
