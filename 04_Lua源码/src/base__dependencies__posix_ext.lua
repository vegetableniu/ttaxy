module("posix", package.seeall)
function system(file, ...)
  local pid = fork()
  if pid == 0 then
    return execp(file, ...)
  else
    local pid, reason, status = wait(pid)
    return status, reason
  end
end
function euidaccess(file, mode)
  local pid = getpid()
  if pid.uid == pid.euid and pid.gid == pid.egid then
    return access(file, mode)
  end
  local stats = stat(file)
  if not stats then
    return
  end
  if pid.euid == 0 and (not string.match(mode, "x") or string.match(stats.st_mode, "x")) then
    return 0
  end
  mode = string.gsub(mode, "[^rwx]", "")
  if mode == "" then
    return 0
  end
  local granted = stats.st_mode:sub(1, 3)
  if pid.euid == stats.st_uid then
    granted = stats.st_mode:sub(7, 9)
  elseif pid.egid == stats.st_gid or set.new(getgroups()):member(stats.st_gid) then
    granted = stats.st_mode:sub(4, 6)
  end
  granted = string.gsub(granted, "[^rwx]", "")
  if string.gsub("[^" .. granted .. "]", mode) == "" then
    return 0
  end
  set_errno(EACCESS)
end
