module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
require("SceneHelper")
local NAME_FONT_SIZE = 30
local TYPE = Enum({
  "ENEMY_ENEMY",
  "PLAYER_ENEMY",
  "PLAYER_PLAYER",
  "PVP",
  "PVM",
  "MVM"
})
function prototype:onEnter()
  self.edtId1:setFontSize(NAME_FONT_SIZE)
  self.edtId2:setFontSize(NAME_FONT_SIZE)
  self.edtAttPer1:setFontSize(NAME_FONT_SIZE)
  self.edtDefPer1:setFontSize(NAME_FONT_SIZE)
  self.edtRound1:setFontSize(NAME_FONT_SIZE)
  self.edtDiff1:setFontSize(NAME_FONT_SIZE)
  self.edtAttPer2:setFontSize(NAME_FONT_SIZE)
  self.edtDefPer2:setFontSize(NAME_FONT_SIZE)
  self.edtRound2:setFontSize(NAME_FONT_SIZE)
  self.edtDiff2:setFontSize(NAME_FONT_SIZE)
  self.edtAttPer3:setFontSize(NAME_FONT_SIZE)
  self.edtDefPer3:setFontSize(NAME_FONT_SIZE)
  self.edtRound3:setFontSize(NAME_FONT_SIZE)
  self.edtDiff3:setFontSize(NAME_FONT_SIZE)
  self.edtAttPer4:setFontSize(NAME_FONT_SIZE)
  self.edtDefPer4:setFontSize(NAME_FONT_SIZE)
  self.edtRound4:setFontSize(NAME_FONT_SIZE)
  self.edtDiff4:setFontSize(NAME_FONT_SIZE)
  self.edtTimes:setFontSize(NAME_FONT_SIZE)
  self.edtTimes:setString("10")
  self.type = TYPE.ENEMY_ENEMY
  self.staType:setString("EnemyAttackEnemy")
  MsgFight:On("PLAYER_PLAYER", self:Event("OnPlayerAttackPlayer"))
  MsgFight:On("ENEMY_ENEMY", self:Event("OnEnemyAttackEnemy"))
  MsgFight:On("PLAYER_ENEMY", self:Event("OnPlayerAttackEnemy"))
  MsgFight:On("COUNT_ENEMY_ENEMY", self:Event("OnCountEnemyEnemy"))
  MsgFight:On("COUNT_PLAYER_ENEMY", self:Event("OnCountPlayerEnemy"))
  MsgFight:On("COUNT_PLAYER_PLAYER", self:Event("OnCountPlayerPlayer"))
end
function prototype:SaveReport(reports, bSave)
  local path = CVariableSystem:GetSingleton():GetSysVariable(GV_DOCPATH)
  if bSave then
    local file = io.open(path .. "battleJson.txt", "w+")
    file:write(reports)
    file:close()
  else
    local file = io.open(path .. "battleJson.txt", "r")
    reports = file:read("*a")
    file:close()
  end
  return reports
end
function prototype:OnCountEnemyEnemy(code, data)
  if not data then
    return
  end
  self:SetCountEditText(data)
end
function prototype:SetCountEditText(data)
  self.edtAttPer1:setString(data.attackerHps[0])
  self.edtAttPer2:setString(data.attackerHps[1])
  self.edtAttPer3:setString(data.attackerHps[2])
  self.edtAttPer4:setString(data.attackerHps[3])
  self.edtDefPer1:setString(data.defenderHps[0])
  self.edtDefPer2:setString(data.defenderHps[1])
  self.edtDefPer3:setString(data.defenderHps[2])
  self.edtDefPer4:setString(data.defenderHps[3])
  self.edtRound1:setString(data.rounds[0])
  self.edtRound2:setString(data.rounds[1])
  self.edtRound3:setString(data.rounds[2])
  self.edtRound4:setString(data.rounds[3])
  self.edtDiff1:setString(data.times[0])
  self.edtDiff2:setString(data.times[1])
  self.edtDiff3:setString(data.times[2])
  self.edtDiff4:setString(data.times[3])
end
function prototype:OnCountPlayerEnemy(code, data)
  if not data then
    return
  end
  self:SetCountEditText(data)
end
function prototype:OnCountPlayerPlayer(code, data)
  if not data then
    return
  end
  self:SetCountEditText(data)
end
function prototype:OnPlayerAttackPlayer(code, data)
  if not data then
    return
  end
  self:SaveReport(data.json, true)
  Logic:Get("BattleShow"):Start(data.reports)
end
function prototype:OnEnemyAttackEnemy(code, data)
  if not data then
    return
  end
  self:SaveReport(data.json, true)
  Logic:Get("BattleShow"):Start(data.reports)
end
function prototype:OnPlayerAttackEnemy(code, data)
  if not data then
    return
  end
  self:SaveReport(data.json, true)
  Logic:Get("BattleShow"):Start(data.reports)
end
function prototype:onBtnAtt1(...)
  self.type = TYPE.ENEMY_ENEMY
  self.staType:setString("EnemyAttackEnemy")
end
function prototype:onBtnAtt2(...)
  self.type = TYPE.PLAYER_ENEMY
  self.staType:setString("PlayerAttackEnemy")
end
function prototype:onBtnAtt3(...)
  self.type = TYPE.PLAYER_PLAYER
  self.staType:setString("PlayerAttackPlayer")
end
function prototype:onBtnPvp(...)
  self.type = TYPE.PVP
  self.staType:setString("CountEnemyEnemy")
end
function prototype:onBtnPvm(...)
  self.type = TYPE.PVM
  self.staType:setString("CountPlayerEnemy")
end
function prototype:onBtnMvm(...)
  self.type = TYPE.MVM
  self.staType:setString("CountPlayerPlayer")
end
function prototype:onBtnTest(...)
  local id1 = tostring(self.edtId1:getString())
  local id2 = tostring(self.edtId2:getString())
  Logic:Get("BattleShow"):SetBattleTest()
  local times = tonumber(self.edtTimes:getString())
  if self.type == TYPE.ENEMY_ENEMY then
    MsgFight:Post("ENEMY_ENEMY", {attacker = id1, defender = id2})
  elseif self.type == TYPE.PLAYER_ENEMY then
    MsgFight:Post("PLAYER_ENEMY", {player = id1, enemy = id2})
  elseif self.type == TYPE.PLAYER_PLAYER then
    MsgFight:Post("PLAYER_PLAYER", {attacker = id1, defender = id2})
  elseif self.type == TYPE.PVP then
    MsgFight:Post("COUNT_ENEMY_ENEMY", {
      attacker = id1,
      defender = id2,
      times = times
    })
  elseif self.type == TYPE.PVM then
    MsgFight:Post("COUNT_PLAYER_ENEMY", {
      player = id1,
      enemy = id2,
      times = times
    })
  elseif self.type == TYPE.MVM then
    MsgFight:Post("COUNT_PLAYER_PLAYER", {
      attacker = id1,
      defender = id2,
      times = times
    })
  end
end
