module("package", package.seeall)
dirsep, pathsep, path_mark, execdir, igmark = string.match(package.config, [[
^([^
]+)
([^
]+)
([^
]+)
([^
]+)
([^
]+)]])
