require("SceneHelper")
module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
function prototype:onEnter()
  self.curStep = 1
  self.curRings = 0
  local bg = "images/Richer/proBg.png"
  local pro = "images/Richer/proGreen.png"
  self.ttfLeftAdvDice:setStyle(kCCLabelTTFStyleOutline)
  self.ttfLeftDice:setStyle(kCCLabelTTFStyleOutline)
  self.ttfLeftBuff:setStyle(kCCLabelTTFStyleOutline)
  self.rootNode:setTouchEnabled(true)
  self.rootNode:registerScriptTouchHandler(bind(self.onTouch, self))
  Logic:Get("NewMonopoly"):On(Logic.NewMonopoly.EVT.CAST_DICE, self:Event("onDice"))
  Logic:Get("NewMonopoly"):On(Logic.NewMonopoly.EVT.PUSH_SCENE, self:Event("onRewardEnd"))
  Logic:Get("NewMonopoly"):On(Logic.NewMonopoly.EVT.CURRENCY_CHANGED, self:Event("refreshCurrency"))
  Logic:Get("NewMonopoly"):On(Logic.NewMonopoly.EVT.SELECT_SUBSTITUE, self:Event("selectSubstitue"))
  self:onLoadNewMonopoly()
end
function prototype:setOwner(owner)
  self.owner = owner
end
function prototype:IsCrossStart()
  local info = Logic:Get("NewMonopoly"):GetMonoInfo()
  return info.floors.valentine.rings - self.curRings > 0
end
function prototype:onBtnDice(sender, event)
  local info = Logic:Get("NewMonopoly"):GetMonoInfo()
  if not table.empty(info.taskProgress or {}) then
    Prompt:Confirm(self, "", TwGetStr(115083), self.onBtnChest, Prompt.PROMPT_TYPE.COMFIRM)
    return
  end
  if info.cast > 0 then
    Logic:Get("NewMonopoly"):PostCastDice()
    return
  end
  local costRec = KFDBGetRecord("ConfigValue", "NEWMONOPOLY:COST_CAST_DICE_COMSUMES") or {}
  local costs = json.decode(costRec.content or "[]") or {}
  local idx = info.costCast + 1
  if idx > #costs then
    idx = #costs or idx
  end
  self.currCost = costs[idx] or 0
  Prompt:Confirm(self, "", TwGetStr(115071, self.currCost), self.promptDice, Prompt.PROMPT_TYPE.SELECT)
end
function prototype:promptDice()
  if not Logic:Get("PlayerInfo"):IsMoneyEnough(self.currCost) then
    Logic:Get("Main"):PromptCharge()
    return
  end
  Logic:Get("NewMonopoly"):PostCostCastDice()
end
function prototype:onBtnAdvDice(sender, event)
  local info = Logic:Get("NewMonopoly"):GetMonoInfo()
  if not table.empty(info.taskProgress or {}) then
    Prompt:Confirm(self, "", TwGetStr(115083), self.onBtnChest, Prompt.PROMPT_TYPE.COMFIRM)
    return
  end
  SceneHelper:pushPrompt("RicherValeAdvDice", self.rootNode)
end
function prototype:onBtnChest(sender, event)
  local info = Logic:Get("NewMonopoly"):GetMonoInfo()
  if not table.empty(info.goodsItems or {}) then
    SceneHelper:pushScene("RicherValeShop", self.rootNode, nil, nil, true)
    return
  end
  if not table.empty(info.tasks or {}) then
    SceneHelper:pushPrompt("RicherValeTask", self.rootNode)
    return
  end
  if info.stepCompleted then
    return
  end
  if not info.floors.valentine.fork and self.map[self.curStep].type == "CROSSING" then
    SceneHelper:pushScene("RicherValeRouteTip", self.rootNode, nil, nil, true)
    return
  end
  local buffRec = KFDBGetRecord("PositionBuffSetting", info.currBuff or "")
  if buffRec and info.buffTimes < buffRec.validTimes then
    SceneHelper:pushScene("RicherValeBuffTip", self.rootNode, nil, nil, true)
    return
  end
end
function prototype:onBtnBuff(sender, event)
  local info = Logic:Get("NewMonopoly"):GetMonoInfo()
  local buffRec = KFDBGetRecord("PositionBuffSetting", info.currBuff or "")
  if buffRec and info.buffTimes < buffRec.validTimes then
    SceneHelper:pushScene("RicherValeBuffTip", self.rootNode, nil, nil, true)
  end
end
function prototype:selectSubstitue()
  self:refreshCurrency()
  self:refreshBuff()
end
function prototype:onLoadNewMonopoly()
  local info = Logic:Get("NewMonopoly"):GetMonoInfo()
  self.maxLattice = #info.floors.valentine.positions
  self:refreshCurrency()
  self:refreshChest()
  self:createMapIcon()
  self:refreshBuff()
  self:onBtnChest()
end
function prototype:refreshCurrency()
  local info = Logic:Get("NewMonopoly"):GetMonoInfo()
  self.ttfLeftDice:setString(info.cast)
  self.ttfLeftAdvDice:setString(info.specialCast)
end
function prototype:refreshChest()
  local info = Logic:Get("NewMonopoly"):GetMonoInfo()
  local pos = info.floors.valentine.pos <= 0 and self.maxLattice + info.floors.valentine.pos or info.floors.valentine.pos
  self.curStep = pos
  self.curRings = info.floors.valentine.rings
  self.curForkStep = info.floors.valentine.forkpos
  local node = ""
  if info.floors.valentine.fork and 0 < self.curForkStep and self.curForkStep <= 5 then
    node = "sprFork" .. self.curForkStep
  else
    node = "sprPoint" .. self.curStep
  end
  local posX = self[node]:getPositionX()
  local posY = self[node]:getPositionY()
  self.nodChest:setVisible(true)
  self.nodChest:setPosition(ccp(posX, posY))
  local leaderId = Logic:Get("Hero"):GetLeaderId()
  local heroInfo = Logic:Get("Hero"):GetHeroInfoById(leaderId)
  local heroImg = Logic:Get("Hero"):GetHeroImage(heroInfo.baseId)
  local heroBg = Logic:Get("Hero"):GetHeroBgImage(heroInfo.baseId)
  local spr = CCSprite:create(heroBg)
  if spr then
    self.sprBg:setDisplayFrame(spr:displayFrame())
  end
  spr = CCSprite:create(heroImg)
  if spr then
    self.sprHero:setDisplayFrame(spr:displayFrame())
  end
  local x = self.sprBg:getContentSize().width / 2
  local y = self.sprBg:getContentSize().height / 2 - 15
  local iconAni = Logic:Get("AniMgr"):NewCCB("UI/uitouziTX", self.sprBg, ccp(x, y), 0, nil, 1)
  iconAni:RunAni()
end
function prototype:refreshBuff()
  local info = Logic:Get("NewMonopoly"):GetMonoInfo()
  local buffRec = KFDBGetRecord("PositionBuffSetting", info.currBuff or "")
  if buffRec and info.buffTimes < buffRec.validTimes then
    self.sprBuffBg:setVisible(false)
    self.nodLeftBuff:setVisible(true)
    self.ttfLeftBuff:setString(buffRec.validTimes - info.buffTimes)
    self:createNodeImg(self.sprCurrBuff, buffRec.type)
    return
  end
  self.nodLeftBuff:setVisible(false)
  self.sprBuffBg:setVisible(true)
  self:createNodeImg(self.sprCurrBuff, "NONE")
end
function prototype:createMapIcon(bMapOnly)
  local info = Logic:Get("NewMonopoly"):GetMonoInfo()
  self.map = self:createMapData(bMapOnly, info.floors.valentine.positions, info.floors.valentine.goldPositions, info.floors.valentine.gonePositions)
  self.fork = self:createMapData(bMapOnly, info.floors.valentine.forkPositions, info.floors.valentine.goldForkPositions, info.floors.valentine.goneForkPositions)
  for pos, rec in ipairs(self.map) do
    local spr = "sprIcon" .. pos
    local num = "sprNum" .. pos
    if self[spr] then
      self:createNodeImg(self[spr], rec.type)
    end
    self[num]:setVisible(false)
    if rec.type == "FORWARD" or rec.type == "BACK" then
      local steps = math.abs(tonumber(rec.addition))
      self[num]:setVisible(true)
      self:createTrapSteps(self[num], rec.type, steps)
    end
  end
  for pos, rec in ipairs(self.fork) do
    local spr = "sprForkIcon" .. pos
    local num = "sprForkNum" .. pos
    if self[spr] then
      self:createNodeImg(self[spr], rec.type)
    end
    self[num]:setVisible(false)
    if rec.type == "FORWARD" or rec.type == "BACK" then
      local steps = math.abs(tonumber(rec.addition))
      self[num]:setVisible(true)
      self:createTrapSteps(self[num], rec.type, steps)
    end
  end
end
function prototype:createMapData(bMapOnly, pos, goldPos, gonePos)
  local goldPositions = table.invert(goldPos)
  local gonePositions = table.invert(gonePos)
  local map = {}
  for i, id in ipairs(pos) do
    local rec = KFDBGetRecord("PositionPointSetting", id)
    if goldPositions[i] then
      rec.type = "GOLD_BOX"
    end
    if rec.type == "BUFF" then
      local buff = KFDBGetRecord("PositionBuffSetting", rec.addition) or {}
      rec.type = buff.type or "NONE"
    end
    if rec.type == "SNARE" then
      rec.type = tonumber(rec.addition) >= 0 and "FORWARD" or "BACK"
    end
    if not bMapOnly and gonePositions[i] and rec.isRepeat == "false" then
      rec.type = "GONE"
    end
    table.insert(map, rec)
  end
  return map
end
function prototype:createNodeImg(sprNode, iconType)
  local typeMap = {
    NONE = "images/public/clarity05.png",
    GONE = "images/Richer/heart.png",
    TASK = "images/Richer/taskIcon.png",
    SHOP = "images/Richer/valeShop.png",
    SILVER_BOX = "images/Richer/greenBox.png",
    CROSSING = "images/Richer/crossing.png",
    GOLD_BOX = "images/Richer/goldBoxOpen.png",
    HOVER = "images/Richer/hover.png",
    LOSE = "images/Richer/lose.png",
    SLOW = "images/Richer/slow.png",
    TOXICOSIS = "images/Richer/toxicosis.png",
    GOSSIP = "images/Richer/gossip.png",
    REDOUBLE_DICE = "images/Richer/redoubleDice.png",
    DOUBLE_REWARD = "images/Richer/doubleReward.png",
    FAST = "images/Richer/fast.png",
    RAMDOM = "images/Richer/random.png",
    FORWARD = "images/Richer/trapForward.png",
    BACK = "images/Richer/trapBack.png",
    TRANSFER = "images/Richer/transfer.png",
    LUCKY = "images/Richer/lucky.png"
  }
  local tag = 2
  sprNode:setScale(1)
  local node = sprNode:getParent():getChildByTag(tag)
  if node then
    sprNode:getParent():removeChildByTag(tag, true)
  end
  if typeMap[iconType] then
    local spr = CCSprite:create(typeMap[iconType])
    if spr then
      sprNode:setDisplayFrame(spr:displayFrame())
    end
    return
  end
  local diceData = {}
  diceData.tag = tag
  diceData.sprNode = sprNode
  if iconType == "DICE" then
    diceData.path = "images/Richer/dice.png"
    diceData.diceOnePath = "images/Richer/dice1.png"
    diceData.nodeScale = 0.7
    diceData.diceScale = 1
    self:createMapDice(diceData)
    return
  end
  if iconType == "SPECIAL_DICE" then
    diceData.path = "images/Richer/advDice.png"
    diceData.diceOnePath = "images/Richer/advDice1.png"
    diceData.nodeScale = 1
    diceData.diceScale = 0.65
    self:createMapDice(diceData)
    return
  end
end
function prototype:createMapDice(data)
  local spr = CCSprite:create(data.path)
  local sprDice = CCSprite:create(data.diceOnePath)
  sprDice:setAnchorPoint(ccp(0.5, 0.5))
  sprDice:setPosition(data.sprNode:getPosition())
  sprDice:setScale(data.diceScale)
  if spr then
    data.sprNode:setDisplayFrame(spr:displayFrame())
    data.sprNode:setScale(data.nodeScale)
    data.sprNode:getParent():addChild(sprDice, 0, data.tag)
  end
end
function prototype:createTrapSteps(sprNode, type, steps)
  local stepType = {
    FORWARD = "images/Richer/forward%d.png",
    BACK = "images/Richer/back%d.png"
  }
  if not stepType[type] then
    return
  end
  local spr = CCSprite:create(string.format(stepType[type], steps))
  if spr then
    sprNode:setDisplayFrame(spr:displayFrame())
  end
end
function prototype:IsDrawBox(id)
  local info = Logic:Get("Monopoly"):GetMonoInfo()
  local drawMap = table.invert(info.drewBox)
  return drawMap[id] and true or false
end
function prototype:onRewardEnd()
  self:createMapIcon()
  self:onBtnChest()
  self:refreshBuff()
  self:onTouch(CCTOUCHENDED)
end
function prototype:onDice(bAdvDice)
  local dice = Logic:Get("NewMonopoly"):GetDicePoints()
  local node = bAdvDice and self.nodAni2 or self.nodAni1
  node:removeAllChildrenWithCleanup(true)
  if bAdvDice then
    self.nodAdvDice:setVisible(false)
  else
    self.nodDice:setVisible(false)
  end
  self.owner:setCoverEnabled(true)
  self:runDiceAni(node, bAdvDice, dice)
end
function prototype:runDiceAni(node, bAdvDice, dice)
  for i, point in ipairs(dice) do
    local aniPath = bAdvDice and "UI/uitouzi03" or "UI/uitouzi"
    local pos = 1
    if #dice > 1 then
      pos = i == 2 and ccp(50, 0) or ccp(-10, 0)
    else
      pos = ccp(0, 0)
    end
    local ani = Logic:Get("AniMgr"):NewCCB(aniPath, node, pos, 0, nil, 1)
    local dicePath = bAdvDice and "images/Richer/advDice%d.png" or "images/Richer/dice%d.png"
    local path = string.format(dicePath, point)
    local spr = CCSprite:create(path)
    if spr then
      ani:GetChild("sprDice"):setDisplayFrame(spr:displayFrame())
    end
    if i == #dice then
      ani:RunAni(nil, nil, bind(self.aniEnd, self))
    else
      ani:RunAni()
    end
  end
end
function prototype:aniEnd()
  local moveStep = self:createMoveData()
  self:moveChest(moveStep)
end
function prototype:createMoveData()
  local bOnFork = Logic:Get("NewMonopoly"):isMoveOnFork()
  local moveData = {}
  if bOnFork then
    moveData = self:caluForkSteps()
    return moveData
  end
  moveData = self:caluNormalSteps()
  return moveData
end
function prototype:caluForkSteps()
  local info = Logic:Get("NewMonopoly"):GetMonoInfo()
  local moveStep = Logic:Get("NewMonopoly"):GetActStep()
  local mainPoint = "sprPoint"
  local forkPoint = "sprFork"
  local lastPoint = self.maxLattice
  local forkRec = {}
  local snares = Logic:Get("NewMonopoly"):GetSnares()
  local forkSnares = Logic:Get("NewMonopoly"):GetForkSnares()
  local moveResult = {}
  local bOnFork = true
  for i = 1, KFDBGetRecordAmt("MoRingsSetting") do
    local rec = KFDBGetRecordByIdx("MoRingsSetting", i)
    if rec.forkStart > 0 then
      forkRec = rec
      break
    end
  end
  local enterPoint = forkRec.forkStart
  local exitPoint = forkRec.forkEnd
  local snareMove = 0
  local last = 1
  local preSnarePoint = self.curForkStep
  for i, pos in ipairs(forkSnares) do
    local steps = pos - preSnarePoint
    local dir = steps > 0 and 1 or 0
    if steps < 0 then
      dir = -1 or dir
    end
    for i = 1, math.abs(steps) do
      local point = preSnarePoint + dir * i
      local pointName = forkPoint .. point
      if point <= 0 then
        pointName = mainPoint .. enterPoint - point
        bOnFork = false
      end
      if point > #info.floors.valentine.forkPositions then
        pointName = mainPoint .. exitPoint + point - #info.floors.valentine.forkPositions - 1
        bOnFork = false
      end
      table.insert(moveResult, pointName)
    end
    preSnarePoint = pos
    local rec = KFDBGetRecord("PositionPointSetting", info.floors.valentine.forkPositions[pos]) or {}
    snareMove = tonumber(rec.addition or 0)
  end
  for i, pos in ipairs(snares) do
    local steps = 0
    local dir = 0
    if pos < enterPoint then
      steps = enterPoint - pos + preSnarePoint - 1
      dir = -1
    end
    if pos > exitPoint then
      steps = pos - exitPoint + #info.floors.valentine.forkPositions - preSnarePoint + 1
      dir = 1
    end
    for i = 1, math.abs(steps) do
      local point = preSnarePoint + dir * i
      local pointName = forkPoint .. point
      if point <= 0 then
        pointName = mainPoint .. enterPoint - point
        bOnFork = false
      end
      if point > #info.floors.valentine.forkPositions then
        pointName = mainPoint .. exitPoint + point - #info.floors.valentine.forkPositions - 1
        bOnFork = false
      end
      table.insert(moveResult, pointName)
    end
    preSnarePoint = pos
    local rec = KFDBGetRecord("PositionPointSetting", info.floors.valentine.positions[pos]) or {}
    snareMove = tonumber(rec.addition or 0)
  end
  local lastMove = moveStep
  if not table.empty(snares) or not table.empty(forkSnares) then
    lastMove = snareMove
  end
  local dir = lastMove > 0 and 1 or 0
  if lastMove < 0 then
    dir = -1 or dir
  end
  for i = 1, math.abs(lastMove) do
    local point = preSnarePoint + dir * i
    local pointName = ""
    if point <= 0 then
      pointName = mainPoint .. enterPoint - point
    else
      pointName = forkPoint .. point
    end
    if bOnFork then
      if point > #info.floors.valentine.forkPositions then
        pointName = mainPoint .. exitPoint + point - #info.floors.valentine.forkPositions - 1
      else
        pointName = forkPoint .. point
      end
    else
      pointName = mainPoint .. (point <= 0 and lastPoint - point or point)
      pointName = mainPoint .. (lastPoint < point and point - lastPoint or point)
    end
    table.insert(moveResult, pointName)
  end
  if table.empty(moveResult) and moveStep == 0 then
    local step = bOnFork and forkPoint or mainPoint
    table.insert(moveResult, step .. self.curForkStep)
  end
  return moveResult
end
function prototype:caluNormalSteps()
  local info = Logic:Get("NewMonopoly"):GetMonoInfo()
  local moveStep = Logic:Get("NewMonopoly"):GetActStep()
  local snares = Logic:Get("NewMonopoly"):GetSnares()
  local mainPoint = "sprPoint"
  local snareMove = 0
  local lastPoint = self.maxLattice
  local moveResult = {}
  local preSnarePoint = self.curStep
  for i, pos in ipairs(snares) do
    local movePos = self:IsCrossStart() and lastPoint + pos or pos
    local steps = movePos - preSnarePoint
    local dir = steps > 0 and 1 or 0
    if steps < 0 then
      dir = -1 or dir
    end
    for i = 1, math.abs(steps) do
      local point = preSnarePoint + dir * i
      local pointName = ""
      if point <= 0 then
        pointName = mainPoint .. lastPoint - point
      else
        pointName = mainPoint .. point
      end
      if lastPoint < point then
        pointName = mainPoint .. point - lastPoint
      else
        pointName = mainPoint .. point
      end
      table.insert(moveResult, pointName)
    end
    preSnarePoint = movePos
    local rec = KFDBGetRecord("PositionPointSetting", info.floors.valentine.positions[pos]) or {}
    snareMove = tonumber(rec.addition or "0")
  end
  local lastMove = table.empty(snares) and moveStep or snareMove
  local dir = lastMove > 0 and 1 or 0
  if lastMove < 0 then
    dir = -1 or dir
  end
  for i = 1, math.abs(lastMove) do
    local point = preSnarePoint + dir * i
    local pointName = ""
    if point <= 0 then
      pointName = mainPoint .. lastPoint - point
    else
      pointName = mainPoint .. point
    end
    if lastPoint < point then
      pointName = mainPoint .. point - lastPoint
    else
      pointName = mainPoint .. point
    end
    table.insert(moveResult, pointName)
  end
  if table.empty(moveResult) and moveStep == 0 then
    table.insert(moveResult, mainPoint .. self.curStep)
  end
  return moveResult
end
function prototype:moveChest(steps)
  if table.empty(steps or {}) then
    return
  end
  local arr = CCArray:create()
  local rootNodeArray = CCArray:create()
  for i, spr in ipairs(steps) do
    if self[spr] then
      local posX = self[spr]:getPositionX()
      local posY = self[spr]:getPositionY()
      local moveTo = CCJumpTo:create(0.3, ccp(posX, posY), 20, 1)
      local delay = CCDelayTime:create(0.1)
      arr:addObject(moveTo)
      arr:addObject(delay)
      local screens = 320 - posX
      if screens <= -960 then
        screens = -960 or screens
      end
      if screens >= 0 then
        screens = 0 or screens
      end
      local rootMoveTo = CCMoveTo:create(0.3, ccp(screens, 0))
      rootNodeArray:addObject(rootMoveTo)
      rootNodeArray:addObject(delay)
      if spr == "sprPoint1" and self:IsCrossStart() then
        local startAni = CCCallFuncN:create(function()
          local ani = Logic:Get("AniMgr"):NewCCB("UI/uiyh", self.rootNode, ccp(320, 480), 0, nil, 1)
          ani:RunAni()
          self:createMapIcon(true)
        end)
        arr:addObject(startAni)
        arr:addObject(CCDelayTime:create(0.5))
      end
    end
  end
  local func = CCCallFuncN:create(function()
    local info = Logic:Get("NewMonopoly"):GetMonoInfo()
    local pos = info.floors.valentine.pos <= 0 and self.maxLattice + info.floors.valentine.pos or info.floors.valentine.pos
    self.curStep = pos
    self.curRings = info.floors.valentine.rings
    self.curForkStep = info.floors.valentine.forkpos
    self:refreshCurrency()
    local iconType = ""
    if info.floors.valentine.fork then
      iconType = self.fork[self.curForkStep] and self.fork[self.curForkStep].type or "NONE"
    else
      iconType = self.map[self.curStep].type
    end
    self.owner:showBoxAni(iconType)
  end)
  arr:addObject(func)
  self.nodChest:runAction(CCSequence:create(arr))
  self.rootNode:runAction(CCSequence:create(rootNodeArray))
end
function prototype:onTouch(eventType)
  if eventType == CCTOUCHENDED then
    local layerX = self.rootNode:getPositionX()
    if layerX > 0 then
      layerX = 0 or layerX
    end
    local posY = self.nodAllDice:getPositionY()
    local posX = math.abs(layerX) + 320
    if posX >= 1150 then
      posX = 1150 or posX
    end
    if posX <= 0 then
      posX = 310 or posX
    end
    local moveTo = CCMoveTo:create(0.3, ccp(posX, posY))
    self.nodAllDice:runAction(moveTo)
  end
  return true
end
