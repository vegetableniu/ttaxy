module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
local MAX_ITEM_COUNT = 5
function prototype:initialize(...)
  super.initialize(self, ...)
end
function prototype:dispose(...)
  super.dispose(self)
end
function prototype:onEnter()
end
function prototype:onNodeLoaded(node, loader)
end
function prototype:ReFrashFighterInfo(data)
  if data == nil then
    return
  end
  local i = 1
  while i <= MAX_ITEM_COUNT do
    local str = string.format("ccbPlayer%d", i)
    if self[str] then
      self[str]:setVisible(false)
    end
    str = string.format("ccbEnemy%d", i)
    if self[str] then
      self[str]:setVisible(false)
    end
    i = i + 1
  end
  local idx = 2
  local setLeader = false
  if data.player then
    for _, v in pairs(data.player.embattles or {}) do
      if v.baseId ~= data.player.leaderBaseId then
        local str = string.format("ccbPlayer%d", idx)
        self[str]:initData(v, true)
        self[str]:setVisible(true)
        idx = idx + 1
      elseif data.player.leaderLevel == v.level and not setLeader then
        self.ccbPlayer1:initData(v, true)
        self.ccbPlayer1:setVisible(true)
        setLeader = true
      else
        local str = string.format("ccbPlayer%d", idx)
        self[str]:initData(v, true)
        self[str]:setVisible(true)
        idx = idx + 1
      end
    end
  end
  idx = 2
  setLeader = false
  if data.enemy then
    for _, v in pairs(data.enemy.embattles or {}) do
      if v.baseId ~= data.enemy.leaderBaseId then
        local str = string.format("ccbEnemy%d", idx)
        self[str]:initData(v)
        self[str]:setVisible(true)
        idx = idx + 1
      elseif data.enemy.leaderLevel == v.level and not setLeader then
        self.ccbEnemy1:initData(v)
        self.ccbEnemy1:setVisible(true)
        setLeader = true
      else
        local str = string.format("ccbEnemy%d", idx)
        self[str]:initData(v)
        self[str]:setVisible(true)
        idx = idx + 1
      end
    end
  end
end
