module((...), package.seeall)
function byteCount(byte)
  assert(byte >= 0 and byte < 253)
  if byte < 192 then
    return 1
  end
  if byte < 224 then
    return 2
  end
  if byte < 240 then
    return 3
  end
  if byte < 248 then
    return 4
  end
  if byte < 252 then
    return 5
  end
  return 6
end
function iterator(s)
  local i = 1
  return function()
    if i <= #s then
      local amount = byteCount(string.byte(s, i))
      local sub = string.sub(s, i, i + amount - 1)
      i = i + amount
      return sub
    end
    return nil
  end
end
function isBMPOnly(s)
  for cp in iterator(s) do
    if byteCount(string.byte(cp)) > 3 then
      return false
    end
  end
  return true
end
function bmpOnly(s)
  return table.concat(list.filter(function(cp)
    return byteCount(string.byte(cp)) <= 3
  end, collect(iterator, s)))
end
