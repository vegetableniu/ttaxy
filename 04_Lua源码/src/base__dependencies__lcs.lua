module("lcs", package.seeall)
local commonSubseqs = function(a, b)
  local l, m, n = {}, #a, #b
  for i = m + 1, 1, -1 do
    l[i] = {}
    for j = n + 1, 1, -1 do
      if i > m or j > n then
        l[i][j] = 0
      elseif a[i] == b[j] then
        l[i][j] = 1 + l[i + 1][j + 1]
      else
        l[i][j] = math.max(l[i + 1][j], l[i][j + 1])
      end
    end
  end
  return l, m, n
end
function longestCommonSubseq(a, b, s)
  local l, m, n = commonSubseqs(a, b)
  local i, j = 1, 1
  local f = getmetatable(s).__append
  while m >= i and n >= j do
    if a[i] == b[j] then
      s = f(s, a[i])
      i = i + 1
      j = j + 1
    elseif l[i + 1][j] >= l[i][j + 1] then
      i = i + 1
    else
      j = j + 1
    end
  end
  return s
end
