module("std", package.seeall)
for _, m in ipairs(require("modules")) do
  require(m)
end
