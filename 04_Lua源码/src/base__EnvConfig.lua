g_fdbInfo = GetFdbInfoFinder()
local getHostType = function(var, isIdx)
  if var == "uint" then
    return T_UINT
  end
  if var == "int" then
    return T_INT
  end
  if var == "double" then
    return T_DOUBLE
  end
  if var == "int64" then
    return T_INT64
  end
  if var == "string" then
    return T_LPCSTR
  end
  if type(var) == "string" then
    return T_LPCSTR
  end
  if type(var) == "number" then
    return isIdx and T_UINT or T_DOUBLE
  end
  assert(false)
end
function DEF(head, ...)
  local info = KFDBInfoFinderImpl.FILE_STRUCT()
  for i, v in ipairs({
    ...
  }) do
    if v.value == nil then
      break
    end
    local name = v.index or v.field
    local isIdx = v.index ~= nil
    g_fdbInfo:AddField(info, getHostType(v.value, isIdx), name, isIdx)
    g_fdbInfo:SetFieldDesc(info, v.desc)
  end
  if head.file == "" then
    head.file = head.type
  end
  g_fdbInfo:AddStruct(head.type, info)
  g_fdbInfo:AddFile(head.file, head.desc, head.type)
end
