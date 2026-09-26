module((...), package.seeall)
require("Logic")
local Define = require("BattleShow.BattleDefine")
local SaveReport = function(reports, bSave, fileName)
  local path = CVariableSystem:GetSingleton():GetSysVariable(GV_DOCPATH)
  if bSave then
    local file = io.open(path .. fileName, "wb+")
    file:write(reports)
    file:close()
  else
    local file = io.open(path .. fileName, "rb")
    reports = file:read("*a")
    file:close()
  end
  return reports
end
local parser = {}
function parser:Init(buffer)
  local stop = #buffer
  self.buffer = buffer
  self.cursor = 1
  self.stop = stop
  self.report = {}
  self:parse()
end
function parser:parse()
  self:readAttackers()
  self:readDefenders()
  self:readRounds()
  self:readResult()
  assert(self:eof())
end
function parser:eof()
  return self.cursor == self.stop
end
function parser:check(bytes)
  assert(self.cursor + bytes <= self.stop)
end
function parser:peekInt(bytes)
  self:check(bytes)
  return struct.unpack(">i" .. bytes, self.buffer, self.cursor)
end
function parser:readInt(bytes)
  self:check(bytes)
  local i = 0
  i, self.cursor = struct.unpack(">i" .. bytes, self.buffer, self.cursor)
  return i
end
function parser:readUInt(bytes)
  self:check(bytes)
  local i = 0
  i, self.cursor = struct.unpack(">I" .. bytes, self.buffer, self.cursor)
  return i
end
function parser:readDelimiter()
  local delimiter = -1
  if self:peekInt(1) ~= delimiter then
    return false
  end
  self:readInt(1)
  return true
end
function parser:readAttackers()
  self.report.attackers = self:readTeam()
end
function parser:readDefenders()
  self.report.defenders = self:readTeam()
end
function parser:readTeam()
  local team = {
    units = {},
    combs = {}
  }
  while not self:readDelimiter() do
    table.insert(team.units, self:readUnit())
  end
  for i = 1, self:readInt(1) do
    table.insert(team.combs, self:readInt(2))
  end
  return team
end
function parser:getFmtId(id)
  if not (id < 6) or not ("A" .. id) then
  end
  return "D" .. id
end
function parser:readUnit()
  local unit = {}
  unit.baseId = self:readInt(1)
  unit.model = self:readUInt(2)
  unit.role = self:readInt(1)
  unit.class = self:readInt(1)
  unit.hp = self:readInt(4)
  unit.hpMax = self:readInt(4)
  unit.id = self:getFmtId(unit.baseId)
  local skillCmbs = self:readInt(1)
  unit.skillBegin = bit.rshift(bit.band(skillCmbs, 240), 4)
  unit.skillRound = bit.band(skillCmbs, 15)
  return unit
end
function parser:readRoundInfo()
  local infos = {}
  while not self:readDelimiter() do
    local info = {}
    info.id = self:readInt(1)
    info.value = self:readValue()
    info.buffs = self:readBuff()
    info.passives = self:readPassives()
    info.target = self:getFmtId(info.id)
    table.insert(infos, info)
  end
  return infos
end
function parser:readRounds()
  self.report.rounds = {}
  while not self:eof() do
    local round = {}
    round.starts = self:readRoundInfo()
    while not self:readDelimiter() do
      table.insert(round, self:readAction())
    end
    round.ends = self:readRoundInfo()
    round.cdInfos = self:readCdInfo()
    table.insert(self.report.rounds, round)
  end
end
function parser:readCdInfo()
  local cdInfos = {}
  for i = 1, self:readInt(2) do
    local info = {}
    info.target = self:getFmtId(self:readInt(1))
    local cds = {}
    for j = 1, self:readInt(1) do
      local cd = {}
      cd.skill = self:readInt(2)
      cd.cd = self:readInt(1)
      table.insert(cds, cd)
    end
    info.cds = cds
    table.insert(cdInfos, info)
  end
  self:readDelimiter()
  return cdInfos
end
function parser:readAction()
  local action = {}
  action.id = self:readInt(1)
  action.skill = self:readInt(2)
  action.owner = self:getFmtId(action.id)
  local function GetTarget()
    local target = {}
    target.id = self:readInt(1)
    target.state = self:readInt(1)
    target.value = self:readValue()
    target.buffs = self:readBuff()
    target.passives = self:readPassives()
    target.target = self:getFmtId(target.id)
    return target
  end
  action.targets = {}
  for i = 1, self:readInt(1) do
    table.insert(action.targets, GetTarget())
  end
  if self:readInt(1) ~= 0 then
    action.startPassives = GetTarget()
  end
  return action
end
function parser:readValue()
  local values = {}
  for i = 1, self:readInt(1) do
    local value = {}
    value.type = self:readInt(1)
    value.content = self:readInt(4)
    table.insert(values, value)
  end
  return values
end
function parser:readBuff()
  local buffs = {}
  for i = 1, self:readInt(1) do
    local buff = {}
    buff.id = self:readInt(2)
    buff.type = self:readInt(1)
    buff.value = self:readValue()
    table.insert(buffs, buff)
  end
  return buffs
end
function parser:readPassives()
  local passes = {}
  for i = 1, self:readInt(1) do
    local pass = {}
    pass.id = self:readInt(2)
    pass.value = self:readValue()
    table.insert(passes, pass)
  end
  return passes
end
function parser:readResult()
  self.report.result = string.byte(self.buffer, #self.buffer)
end
function parser:getReport()
  return self.report
end
class = objectlua.Object:subclass()
function class:initialize(reports)
  super.initialize(self)
  parser:Init(reports)
  self.reports = parser:getReport()
end
function class:ShowTargetHpList(id)
  local memInfo = self:GetUnitInfo(id)
  local str = string.format("%s--hp:%d,hpMax:%d", id, memInfo.hp, memInfo.hpMax)
  log4battle:debug(str)
  local hp = memInfo.hpMax
  local function ForeachTaget(action)
    for _, info in ipairs(action.targets) do
      if info.id == id then
        local reduceHp = info.value[1] and info.value[1].content or 0
        hp = hp + reduceHp
        log4battle:debug("reduceHp:" .. reduceHp .. "--remainHp:" .. hp)
        log4battle:debug(action)
      end
    end
  end
  for rts, round in ipairs(self:GetRounds()) do
    for _, action in ipairs(round) do
      ForeachTaget(action)
    end
  end
end
function class:GetUnitInfo(id)
  for _, info in ipairs(self.reports.attackers.units) do
    if info.id == parser:getFmtId(id) then
      return info
    end
  end
  for _, info in ipairs(self.reports.defenders.units) do
    if info.id == parser:getFmtId(id) then
      return info
    end
  end
  return nil
end
function class:GetAttackerCombs()
  return self.reports.attackers.combs
end
function class:GetDefenderCombs()
  return self.reports.defenders.combs
end
function class:GetAttackers()
  return self.reports.attackers.units
end
function class:GetDefenders()
  return self.reports.defenders.units
end
function class:GetResult()
  local brslt = self.reports.result
  return brslt == 1 or brslt == 4
end
function class:GetRounds()
  return self.reports.rounds
end
