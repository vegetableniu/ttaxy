module((...), package.seeall)
require("Logic")
require("protocol")
require("SceneHelper")
require("Progress")
local CCBAni = require("BattleShow.CCBAnimation")
class = Logic.class:subclass()
local battle = objectlua.Object:subclass()
battle:include(Events.Tracer)
JobType = TypeDef("com.eyu.mt.module.menpai.model.JobType")
function class:saveReport(reports, bSave)
  if bSave then
    local name = Logic:Get("Account"):GetAccName()
    local path = "docDir/" .. name .. os.time() .. ".txt"
    local file = io.open(path, "wb+")
    file:write(json.encode(reports))
    file:close()
  else
    local file = io.open("docDir/qin00251397200715.txt", "rb")
    reports = file:read("*a")
    reports = json.decode(reports)
    file:close()
  end
  return reports
end
function class:start(...)
  self.battleFiled:cleanupWaiter()
  self.battleFiled:start(...)
end
function class:enter(...)
  if self.battleFiled ~= nil then
    self.battleFiled:cleanup()
  end
  self.battleFiled = battle:new(...)
end
function class:refresh(...)
  self.battleFiled:refresh(...)
end
function class:exit(...)
  self.battleFiled:exit(...)
  self.battleFiled:cleanup()
  self.battleFiled = nil
end
function class:finish(...)
  self.battleFiled:finish(...)
end
function class:isBattleIn()
  return self.battleFiled:isBattleIn()
end
function battle:initialize(layer, sprBg)
  super.initialize(self)
  Events.Tracer.initialize(self)
  self:createStageLayer(layer)
  self.sprBg = sprBg
  self:initData()
  self:createWaiter()
end
function battle:dispose(...)
  Events.Tracer.dispose(self)
  super.dispose(self)
end
function battle:cleanup()
  self:cleanupWaiter()
  if self.layer ~= nil then
    self.layer:removeFromParentAndCleanup(true)
  end
  if self.effectLayer ~= nil then
    self.effectLayer:removeFromParentAndCleanup(true)
  end
  self.effectLayer = nil
  self.layer = nil
  self.sprBg = nil
  self:dispose()
end
function battle:initData()
  self.owner = {
    units = {},
    queue = {},
    rounds = {
      {},
      {},
      {}
    },
    onField = {},
    prog = {}
  }
  self.target = {
    units = {},
    queue = {},
    rounds = {
      {},
      {},
      {}
    },
    onField = {},
    prog = {}
  }
  self.isStart = false
end
function battle:createPlayerUnits(owners, targets)
  for i, owner in ipairs(owners or {}) do
    local nodeInfo = self:createPlayerUnit(self.layer)
    self:setViewNodeInfo(nodeInfo, owner)
    self.owner.units[owner.playerId] = nodeInfo.viewNode
    self.owner.prog[owner.playerId] = nodeInfo.prgBlood
    nodeInfo.viewNode:setPosition(800, 400)
    nodeInfo.viewNode:runAction(CCScaleTo:create(0.65, 0.65))
  end
  for i, target in ipairs(targets or {}) do
    local nodeInfo = self:createPlayerUnit(self.layer)
    self:setViewNodeInfo(nodeInfo, target)
    self.target.units[target.playerId] = nodeInfo.viewNode
    self.target.prog[target.playerId] = nodeInfo.prgBlood
    nodeInfo.viewNode:setPosition(800, 400)
    nodeInfo.viewNode:runAction(CCScaleTo:create(0.65, 0.65))
  end
  self:createPlayersNode(self.layer)
end
function battle:setViewNodeInfo(nodeInfo, player)
  local playerId = player.playerId
  local prgBlood = nodeInfo.prgBlood
  local node = nodeInfo.viewNode
  local sprHero = nodeInfo.sprHero
  local ttfName = nodeInfo.ttfName
  local sprCloud = nodeInfo.sprCloud
  local str = self:getImagePath(player.baseId)
  local spr = CCSprite:create(str)
  sprHero:setDisplayFrame(spr:displayFrame())
  local name = player.name
  if player.job == JobType.BOSS then
    name = TwGetStr(108137) .. player.name
  end
  if player.job == JobType.ELDER then
    name = TwGetStr(108138) .. player.name
  end
  ttfName:setString(name)
  local color = ccc3(255, 255, 255)
  if player.job == JobType.BOSS then
    color = ccc3(77, 173, 255)
  end
  if player.job == JobType.ELDER then
    color = ccc3(77, 173, 255)
  end
  if playerId == Logic:Get("PlayerInfo"):GetPlayerId() then
    color = ccc3(255, 0, 0)
  end
  ttfName:setColor(color)
  local str = "images/Corps/bangzhong.png"
  if player.job == JobType.BOSS then
    str = "images/Corps/bangzhu.png"
  end
  if player.job == JobType.ELDER then
    str = "images/Corps/zhanglao.png"
  end
  local spr = CCSprite:create(str)
  sprCloud:setDisplayFrame(spr:displayFrame())
  prgBlood:setValue(100)
  prgBlood:setVisible(false)
end
function battle:createPlayerUnit(layer)
  local viewNode = CCNode:create()
  layer:addChild(viewNode)
  local sprHero = CCSprite:create()
  viewNode:addChild(sprHero)
  local node = CCNode:create()
  node:setContentSize(CCSize(140, 20))
  node:setAnchorPoint(ccp(0.5, 0.5))
  local prgBlood = Progress.prototype:new()
  local back = "images/Corps/bloodback.png"
  local blood = "images/Corps/bloodred.png"
  prgBlood:createProgress(back, blood, node)
  viewNode:addChild(node)
  local x, y = node:getPosition()
  node:setPosition(ccp(x, y + 100))
  local ttfName = CCLabelTTF:create("", nil, 80)
  viewNode:addChild(ttfName)
  x, y = ttfName:getPosition()
  ttfName:setPosition(ccp(x, y + 120))
  ttfName:setFontSize(30)
  ttfName:setStyle(kCCLabelTTFStyleOutline, ccc3(0, 0, 0))
  local sprCloud = CCSprite:create()
  viewNode:addChild(sprCloud)
  sprCloud:setPosition(ccp(x, y - 90))
  return {
    viewNode = viewNode,
    prgBlood = prgBlood,
    sprHero = sprHero,
    ttfName = ttfName,
    sprCloud = sprCloud
  }
end
function battle:createPlayersNode(layer)
  self.ownerNode = CCNode:create()
  layer:addChild(self.ownerNode)
  self.targetNode = CCNode:create()
  layer:addChild(self.targetNode)
end
function battle:getImagePath(baseId)
  local imgPath = Logic:Get("Hero"):GetHeroImage(baseId, Logic.Hero.HEROIMG_SIZE.BIG)
  return imgPath
end
function battle:removeNodeTo(node, parent, object)
  if node:getParent() ~= parent then
    log4battle:warn("[removeNodeTo] error")
    return false
  end
  node:retain()
  node:autorelease()
  parent:removeChild(node, false)
  object:addChild(node)
  return true
end
function battle:isOwner(playId)
  if self.owner.units[playId] then
    return true
  end
  return false
end
function battle:inSequence(table, cell)
  for i, val in ipairs(table) do
    if val == cell then
      return true
    end
  end
  return false
end
function battle:setBattleRounds(reports)
  self.winMenpai = reports.winMenpaiId
  self.Rounds = reports.fightReport
  self:splitRounds(self.Rounds)
end
function battle:splitRounds(Rounds)
  for i, rounds in ipairs(Rounds) do
    for j = 1, 3 do
      self:splitRound(j, rounds[j])
    end
  end
  self:createPlayerQueue("owner")
  self:createPlayerQueue("target")
  self:insertNotOnShow(self.winMenpai)
end
function battle:createPlayerQueue(camp)
  local count = #self[camp].rounds
  local num = math.max(#self[camp].rounds[1], #self[camp].rounds[2], #self[camp].rounds[3])
  local dies = {
    true,
    true,
    true
  }
  for i = 1, num do
    for k, die in ipairs(dies) do
      local hit = self[camp].rounds[k][i]
      if die and hit and not self:inSequence(self[camp].queue, hit.playerId) then
        table.insert(self[camp].queue, hit.playerId)
      end
    end
    dies = {
      false,
      false,
      false
    }
    for j = 1, count do
      local hit = self[camp].rounds[j][i]
      if hit and (hit.finish or hit.winCount == 3) then
        dies[j] = true
      end
    end
  end
end
function battle:splitRound(id, round)
  local maxRound = 2
  if round == json.null or not round then
    for i = 1, maxRound do
      local hit = {}
      table.insert(self.owner.rounds[id], hit)
      table.insert(self.target.rounds[id], hit)
    end
    return
  end
  for i = 1, maxRound do
    local hit = {}
    local owner = self:isOwner(round.fighers[1]) and 1 or 2
    local target = self:isOwner(round.fighers[1]) and 2 or 1
    hit.playerId = round.fighers[owner]
    hit.originalHp = round.originalHp[owner]
    hit.startHp = round.startHp[owner]
    hit.hurt = round.demage[target] / 2
    hit.winCount = round.winCount[round.fighers[owner]]
    hit.won = self:isOwner(round.fighers[round.won + 1])
    if i == maxRound then
      hit.finish = true
    end
    table.insert(self.owner.rounds[id], hit)
    hit = {}
    hit.playerId = round.fighers[target]
    hit.originalHp = round.originalHp[target]
    hit.startHp = round.startHp[target]
    hit.hurt = round.demage[owner] / 2
    hit.winCount = round.winCount[round.fighers[target]]
    hit.won = not self:isOwner(round.fighers[round.won + 1])
    if i == maxRound then
      hit.finish = true
    end
    table.insert(self.target.rounds[id], hit)
  end
end
function battle:insertNotOnShow(camp)
  if table.empty(self[camp].queue) then
    for playerId, unit in pairs(self[camp].units) do
      table.insert(self[camp].queue, playerId)
    end
    return
  end
  for playerId, unit in pairs(self[camp].units) do
    for i, id in ipairs(self[camp].queue) do
      if playerId == id then
        break
      end
      if i == #self[camp].queue then
        table.insert(self[camp].queue, playerId)
      end
    end
  end
end
function battle:getNextRounds()
  local rounds = {
    owner = {},
    target = {}
  }
  for i, v in ipairs(self.owner.rounds) do
    rounds.owner[i] = self.owner.rounds[i][1]
    table.remove(self.owner.rounds[i], 1)
  end
  for i, v in ipairs(self.target.rounds) do
    rounds.target[i] = self.target.rounds[i][1]
    table.remove(self.target.rounds[i], 1)
  end
  return rounds
end
function battle:createWaiter()
  self.ownerWaiterNode = {}
  self.targetWaiterNode = {}
  for i = 1, 3 do
    self.ownerWaiterNode[i] = self:createPlayerUnit(self.layer)
    local viewNode = self.ownerWaiterNode[i].viewNode
    local x, y = self:getAwaitPosition("owner", i)
    viewNode:setPosition(ccp(x, y))
    local scaleTo = CCScaleTo:create(0.65, 0.65)
    viewNode:runAction(scaleTo)
    self.targetWaiterNode[i] = self:createPlayerUnit(self.layer)
    local viewNode = self.targetWaiterNode[i].viewNode
    local x, y = self:getAwaitPosition("target", i)
    viewNode:setPosition(ccp(x, y))
    local scaleTo = CCScaleTo:create(0.65, 0.65)
    viewNode:runAction(scaleTo)
  end
end
function battle:cleanupWaiter()
  for i, nodeInfo in ipairs(self.ownerWaiterNode or {}) do
    nodeInfo.viewNode:removeFromParentAndCleanup(true)
  end
  for i, nodeInfo in ipairs(self.targetWaiterNode or {}) do
    nodeInfo.viewNode:removeFromParentAndCleanup(true)
  end
  self.ownerWaiterNode = nil
  self.targetWaiterNode = nil
end
function battle:refresh(owners, targets)
  for i = 1, 3 do
    local nodeInfo = self.ownerWaiterNode[i]
    if owners and owners[i] then
      local player = owners[i]
      self:setViewNodeInfo(nodeInfo, player)
      nodeInfo.viewNode:setVisible(true)
      nodeInfo.viewNode:setScale(1)
      nodeInfo.viewNode:runAction(CCScaleTo:create(0.65, 0.65))
    else
      nodeInfo.viewNode:setVisible(false)
    end
  end
  for i = 1, 3 do
    local nodeInfo = self.targetWaiterNode[i]
    if targets and targets[i] then
      local player = targets[i]
      self:setViewNodeInfo(nodeInfo, player)
      nodeInfo.viewNode:setVisible(true)
      nodeInfo.viewNode:setScale(1)
      nodeInfo.viewNode:runAction(CCScaleTo:create(0.65, 0.65))
    else
      nodeInfo.viewNode:setVisible(false)
    end
  end
end
function battle:refreshPlayersAwait()
  for i = 1, 3 do
    if self.owner.queue[i] then
      self:resetPlayerAwait("owner", self.owner.units[self.owner.queue[i]], i)
    end
    if self.target.queue[i] then
      self:resetPlayerAwait("target", self.target.units[self.target.queue[i]], i)
    end
  end
end
function battle:resetPlayerAwait(camp, unit, pos)
  local x, y = self:getAwaitPosition(camp, pos)
  if not unit then
    log4battle:warn("not unit !!! pos = %d", pos)
    return
  end
  unit:setPosition(ccp(x, y))
end
function battle:playersMoveIn(rounds)
  for i, hit in pairs(rounds.owner) do
    if hit.playerId then
      self:playerMoveIn("owner", hit, i)
    end
  end
  for i, hit in pairs(rounds.target) do
    if hit.playerId then
      self:playerMoveIn("target", hit, i)
    end
  end
  self:setStartHp(rounds)
  self:playersDelayTime(1)
end
function battle:playerMoveIn(camp, hit, pos)
  local await, indexA = self:playerInAwait(camp, hit.playerId)
  local field, indexF = self:playerOnField(camp, hit.playerId)
  local x, y = self:getScenePosition(camp, pos)
  local moveTo = CCMoveTo:create(0.3, ccp(x, y))
  self[camp].units[hit.playerId]:runAction(moveTo)
  self[camp].prog[hit.playerId]:setVisible(true)
  if await then
    self:removeNodeTo(self[camp].units[hit.playerId], self.layer, self[camp .. "Node"])
    table.remove(self[camp].queue, indexA)
  end
  if field then
    self:removeNodeTo(self[camp].units[hit.playerId], self.layer, self[camp .. "Node"])
    self[camp].onField[indexF] = nil
  end
end
function battle:playerInAwait(camp, playerId)
  for i, id in ipairs(self[camp].queue) do
    if playerId == id then
      return true, i
    end
  end
  return false
end
function battle:playerOnField(camp, playerId)
  for i, id in pairs(self[camp].onField) do
    if playerId == id then
      return true, i
    end
  end
  return false
end
function battle:createActions(actions)
  local array = CCArray:create()
  for _, act in ipairs(actions) do
    local obj = act
    if type(act) == "function" then
      obj = CCCallFuncN:create(act)
    end
    array:addObject(obj)
  end
  return array
end
function battle:getAwaitPosition(camp, pos)
  local x = 130
  local y = camp == "owner" and 200 or 855
  local posX = x + 190 * (pos - 1)
  return posX, y
end
function battle:getScenePosition(camp, pos)
  local x = 140
  local y = camp == "owner" and 420 or 620
  local posX = x + 200 * (pos - 1)
  return posX, y
end
function battle:getHitPosition(pos)
  local x = 140 + 200 * (pos - 1)
  local y = 520
  return x, y
end
function battle:playersDelayTime(time)
  local seqActs = CCSequence:create(self:createActions({
    CCDelayTime:create(time),
    self.sync:Join()
  }))
  self.layer:runAction(seqActs)
  self.sync:Sync()
end
function battle:runHpAnimat(progHp, hpValue, sync)
  local waitSign = sync:Join()
  local prgValue = progHp:getValue()
  local allTime = 600
  local valTime = 50
  local hpStep = (prgValue - hpValue) / (allTime / valTime)
  local moveAction
  local function processMovie()
    prgValue = prgValue - hpStep
    prgValue = hpStep > 0 and (prgValue < hpValue and hpValue or prgValue) or prgValue > hpValue and hpValue or prgValue
    progHp:setValue(prgValue)
    if math.abs(prgValue - hpValue) < 1.0E-6 then
      progHp:stopAction(moveAction)
      waitSign()
    end
  end
  local arrAction = CCArray:create()
  arrAction:addObject(CCDelayTime:create(valTime / 1000))
  arrAction:addObject(CCCallFuncN:create(processMovie))
  local seq = CCSequence:create(arrAction)
  moveAction = CCRepeatForever:create(seq)
  progHp:runAction(moveAction)
end
function battle:playersBattle(rounds)
  local ownerX, ownerY = self.ownerNode:getPosition()
  local seqActs = CCSequence:create(self:createActions({
    CCMoveTo:create(0.4, ccp(ownerX, ownerY - 30)),
    CCMoveTo:create(0.05, ccp(ownerX, ownerY + 20)),
    self.sync:Join()
  }))
  self.ownerNode:runAction(seqActs)
  local targetX, targetY = self.targetNode:getPosition()
  local seqActs = CCSequence:create(self:createActions({
    CCMoveTo:create(0.4, ccp(targetX, targetY + 30)),
    CCMoveTo:create(0.05, ccp(targetX, targetY - 20)),
    self.sync:Join()
  }))
  self.targetNode:runAction(seqActs)
  self:playSound()
  self:runHitEffects(self.sync, rounds)
  local seqActs = CCSequence:create(self:createActions({
    CCMoveTo:create(0.05, ccp(ownerX, ownerY)),
    self.sync:Join()
  }))
  self.ownerNode:runAction(seqActs)
  local seqActs = CCSequence:create(self:createActions({
    CCMoveTo:create(0.05, ccp(targetX, targetY)),
    self.sync:Join()
  }))
  self.targetNode:runAction(seqActs)
  self.sync:Sync()
  self:setHurt(rounds)
end
function battle:setHurt(rounds)
  for i, hit in pairs(rounds.owner) do
    if hit.playerId then
      local prog = self.owner.prog[hit.playerId]
      local left = prog:getValue() / 100 * hit.originalHp
      self:runHpAnimat(prog, (left - hit.hurt) / hit.originalHp * 100, self.sync)
    end
  end
  for i, hit in pairs(rounds.target) do
    if hit.playerId then
      local prog = self.target.prog[hit.playerId]
      local left = prog:getValue() / 100 * hit.originalHp
      self:runHpAnimat(prog, (left - hit.hurt) / hit.originalHp * 100, self.sync)
    end
  end
  self.sync:Sync()
  self:playersDelayTime(0.5)
end
function battle:setStartHp(rounds)
  for i, hit in pairs(rounds.owner) do
    if hit.playerId then
      local prog = self.owner.prog[hit.playerId]
      self:runHpAnimat(prog, hit.startHp / hit.originalHp * 100, self.sync)
    end
  end
  for i, hit in pairs(rounds.target) do
    if hit.playerId then
      local prog = self.target.prog[hit.playerId]
      self:runHpAnimat(prog, hit.startHp / hit.originalHp * 100, self.sync)
    end
  end
  self.sync:Sync()
end
function battle:playersShock(sync, count, delay)
  local x, y = self.sprBg:getPosition()
  local waitSign = sync:Join()
  local array = CCArray:create()
  array:addObject(CCDelayTime:create(delay))
  for i = 1, count do
    array:addObject(CCMoveTo:create(0.05, ccp(x, y - 8)))
    array:addObject(CCMoveTo:create(0.05, ccp(x, y + 8)))
  end
  array:addObject(CCCallFuncN:create(function()
    self.sprBg:setPosition(ccp(x, y))
    waitSign()
  end))
  self.sprBg:runAction(CCSequence:create(array))
  self.sprBg:setPosition(ccp(x, y))
end
function battle:playersSwtich(oldRounds, rounds)
  if table.empty(oldRounds) then
    return
  end
  self:playersLeaveAway(oldRounds, rounds, "die")
  self:playersEffect(oldRounds, rounds)
  self:playersLeaveAway(oldRounds, rounds, "win")
end
function battle:playersEffect(oldRounds, rounds)
  local effects = {}
  for i, hit in pairs(oldRounds.owner) do
    local roundId = rounds.owner[i] and hit.playerId and rounds.owner[i].playerId or nil
    if hit.playerId ~= roundId then
      local effect = {}
      effect.camp = "owner"
      effect.hit = hit
      effect.pos = i
      table.insert(effects, effect)
    end
  end
  for i, hit in pairs(oldRounds.target) do
    local roundId = rounds.target[i] and hit.playerId and rounds.target[i].playerId or nil
    if hit.playerId ~= roundId then
      local effect = {}
      effect.camp = "target"
      effect.hit = hit
      effect.pos = i
      table.insert(effects, effect)
    end
  end
  self:runEffects(self.sync, effects)
end
function battle:playersLeaveAway(oldRounds, rounds, state)
  for i, hit in pairs(oldRounds.owner) do
    local roundId = rounds.owner[i] and hit.playerId and rounds.owner[i].playerId or nil
    if hit.playerId ~= roundId then
      self:playerLeaveAway("owner", hit, state, i)
    end
  end
  for i, hit in pairs(oldRounds.target) do
    local roundId = rounds.target[i] and hit.playerId and rounds.target[i].playerId or nil
    if hit.playerId ~= roundId then
      self:playerLeaveAway("target", hit, state, i)
    end
  end
end
function battle:playerLeaveAway(camp, hit, state, pos)
  if state == "die" then
    if not hit.won and hit.finish then
      self[camp].units[hit.playerId]:setVisible(false)
      Logic:Get("Sect"):refreshJoinCount(camp)
    end
    return
  end
  if state == "win" then
    if hit.winCount == 3 then
      Logic:Get("Sect"):fightWinChat({
        camp = camp,
        count = hit.winCount,
        playerId = hit.playerId
      })
      self[camp].units[hit.playerId]:setVisible(false)
      Logic:Get("Sect"):refreshJoinCount(camp)
    elseif not hit.won and hit.finish then
    else
      self[camp].onField[pos] = hit.playerId
      self:removeNodeTo(self[camp].units[hit.playerId], self[camp .. "Node"], self.layer)
    end
  end
end
function battle:checkSwitchTeams(oldRounds, rounds)
  if table.empty(oldRounds) then
    return true
  end
  for i, hit in pairs(oldRounds.owner) do
    if hit.finish then
      return true
    end
  end
  for i, hit in pairs(oldRounds.target) do
    if hit.finish then
      return true
    end
  end
  return false
end
function battle:playStartEffect()
  local x, y = self:getHitPosition(2)
  local aniFight = self:runFightEffect(self.sync, ccp(x, y))
  self:playersShock(self.sync, 10, 0.5)
  self.sync:Sync()
  aniFight:RemoveAnimation(true)
end
function battle:checkGameOver(rounds)
  if table.empty(rounds.owner) and table.empty(rounds.target) then
    return true
  end
  return false
end
function battle:playStart(owners, targets, report)
  Logic:Get("BGSound"):PlayBattleMusic()
  self.sync = Utils.Synchroniser:new()
  self:playStartEffect()
  self:createPlayerUnits(owners, targets)
  self:setBattleRounds(report)
end
function battle:playEnd()
  Logic:Get("BGSound"):StopBattleMusic()
  local x, y = self:getHitPosition(2)
  if self.winMenpai == "owner" then
    self:runResultWin(self.sync, ccp(x, y))
    Logic:Get("BGSound"):PlayEffect("audio/win.mp3")
  else
    self:runResultLose(self.sync, ccp(x, y))
    Logic:Get("BGSound"):PlayEffect("audio/lose.mp3")
  end
  self.sync:Sync()
  self:initData()
  self:finish()
end
function battle:playRounds()
  local first = true
  local oldRounds = {}
  while true do
    local rounds = self:getNextRounds()
    if first then
      self:refreshPlayersAwait(rounds)
      self:playersDelayTime(0.5)
    end
    if self:checkSwitchTeams(oldRounds, rounds) then
      self:playersSwtich(oldRounds, rounds)
      self:playersMoveIn(rounds)
      self:refreshPlayersAwait(rounds)
    end
    if self:checkGameOver(rounds) then
      break
    end
    self:playersBattle(rounds)
    oldRounds = rounds
    first = false
  end
end
function battle:createStageLayer(layer)
  self.rootLayer = layer
  self.effectLayer = CCNode:create()
  self.layer = CCNode:create()
  layer:addChild(self.layer)
  layer:addChild(self.effectLayer)
end
function battle:start(owners, targets, report)
  if not self.isStart then
    self.isStart = true
    Singleton(Timer):After(0, self:Event("MENPAI_WAIT", function()
      RunInCoroutine(function()
        self:playStart(owners, targets, report)
        self:playRounds()
        self:playEnd()
      end)
    end))
  end
end
function battle:exit()
  self:initData()
  Logic:Get("BGSound"):PlayBGMusic()
end
function battle:finish()
  Logic:Get("Sect"):battleEnd()
end
function battle:isBattleIn()
  return self.isStart
end
function battle:runHitEffects(sync, rounds)
  local animate = {}
  for i, hit in pairs(rounds.owner) do
    if hit.playerId then
      local x, y = self:getHitPosition(i)
      local ani = self:runHitEffect(sync, ccp(x, y))
      if ani then
        table.insert(animate, ani)
      end
    end
  end
  self:playersShock(self.sync, 3, 0)
  sync:Sync()
  for i, ani in ipairs(animate) do
    ani:RemoveAnimation(true)
  end
end
function battle:runHitEffect(sync, pos)
  local hitEffect = "UI/UIbangzhanzhuangji3"
  local aniHit = CCBAni.class:new(hitEffect, self.effectLayer, pos)
  aniHit:RunAnimation(nil, sync)
  return aniHit
end
function battle:runEffects(sync, effects)
  local animate = {}
  for i, effect in ipairs(effects) do
    local x, y = self:getScenePosition(effect.camp, effect.pos)
    if effect.hit.winCount == 3 then
      local ani = self:runWinEffect(sync, ccp(x, y))
      if ani then
        table.insert(animate, ani)
      end
    elseif not effect.hit.won and effect.hit.finish then
      local ani = self:runFailEffect(sync, ccp(x, y))
      if ani then
        table.insert(animate, ani)
      end
    end
  end
  sync:Sync()
  for i, ani in ipairs(animate) do
    ani:RemoveAnimation(true)
  end
end
function battle:runFailEffect(sync, pos)
  local failEffect = "Actuation/die"
  local aniFail = CCBAni.class:new(failEffect, self.effectLayer, pos)
  aniFail:RunAnimation(nil, sync)
  return aniFail
end
function battle:runWinEffect(sync, pos)
  local winEffect = "UI/08lianshengxiachang"
  local aniWin = CCBAni.class:new(winEffect, self.effectLayer, pos)
  aniWin:RunAnimation(nil, sync)
  return aniWin
end
function battle:runResultWin(sync, pos)
  local resultWin = "UI/02duoqushengli"
  local aniResultWin = CCBAni.class:new(resultWin, self.effectLayer, pos)
  aniResultWin:RunAnimation(nil, sync)
end
function battle:runResultLose(sync, pos)
  local resultLose = "UI/03duoqushibai"
  local aniResultLose = CCBAni.class:new(resultLose, self.effectLayer, pos)
  aniResultLose:RunAnimation(nil, sync)
end
function battle:runFightEffect(sync, pos)
  local fight = "UI/09kaizhan"
  local aniFight = CCBAni.class:new(fight, self.effectLayer, pos)
  aniFight:RunAnimation(nil, sync)
  return aniFight
end
function battle:playSound(sound)
  sound = "audio/effect/thunderbolt.mp3"
  Logic:Get("BGSound"):PlayEffect(sound)
end
