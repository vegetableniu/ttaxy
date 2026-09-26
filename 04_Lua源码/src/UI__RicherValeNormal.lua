require("SceneHelper")
module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
function prototype:onEnter()
  self.curStep = 1
  local bg = "images/Richer/proBg.png"
  local pro = "images/Richer/proGreen.png"
  self.proRings:createProgress(bg, pro)
  self.ttfLeftAdvDice:setStyle(kCCLabelTTFStyleOutline)
  self.ttfLeftDice:setStyle(kCCLabelTTFStyleOutline)
  self.ttfCoin:setStyle(kCCLabelTTFStyleOutline)
  self.ttfJade:setStyle(kCCLabelTTFStyleOutline)
  self:scrollViewCreate()
  Logic:Get("NewMonopoly"):On(Logic.NewMonopoly.EVT.CAST_DICE, self:Event("onDice"))
  Logic:Get("NewMonopoly"):On(Logic.NewMonopoly.EVT.DRAW_BOX_REWARD, self:Event("createRingProgress"))
  Logic:Get("NewMonopoly"):On(Logic.NewMonopoly.EVT.PUSH_SCENE, self:Event("onRewardEnd"))
  Logic:Get("NewMonopoly"):On(Logic.NewMonopoly.EVT.CURRENCY_CHANGED, self:Event("refreshCurrency"))
  Logic:Get("NewMonopoly"):On(Logic.NewMonopoly.EVT.ACROSS_DATE, self:Event("onBtnReturn"))
  self:onLoadNewMonopoly()
end
function prototype:scrollViewCreate()
  local container = Tw.Controller:load("RicherPostItem", self.rootNode)
  local scroll = CCScrollViewEx:create(CCSizeMake(430, 32))
  scroll:setDirection(kCCScrollViewDirectionHorizontal)
  scroll:setClippingToBounds(true)
  scroll:setTouchEnabled(false)
  scroll:setContainer(container)
  scroll:updateInset()
  self.scrollTag = scroll:getTag()
  self.nodAdv:addChild(scroll)
end
function prototype:onBtnBg(sender, event)
end
function prototype:onBtnCover()
end
function prototype:onBtnReturn(sender, event)
  SceneHelper:runWithScene("GiftActivityList", self.rootNode)
end
function prototype:onBtnStrategy(sender, event)
  SceneHelper:pushScene("RicherStrategy", self.rootNode, nil, nil, true)
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
function prototype:onBtnShow(sender, event)
  local iconType = {
    "SHOP",
    "TASK",
    "SILVER_BOX",
    "GOLD_BOX"
  }
  local idx = 0
  local showBtns = 4
  for i = 1, showBtns do
    local btn = "btnShow" .. i
    if sender == self[btn] then
      idx = i
      break
    end
  end
  Logic:Get("NewMonopoly"):SetShowRewardType(iconType[idx])
  SceneHelper:pushScene("RicherValeRewardShow", self.rootNode, nil, nil, true)
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
function prototype:onBtnBox(sender, event)
  local idx
  for i = 1, 4 do
    local btn = "btnBox" .. i
    if sender == self[btn] then
      idx = i
      break
    end
  end
  if self:IsDrawBox(self.ringsRec[idx].id) then
    return
  end
  Logic:Get("NewMonopoly"):SetBoxData(self.ringsRec[idx])
  SceneHelper:pushScene("RicherValeBox", self.rootNode, nil, nil, true)
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
end
function prototype:onLoadNewMonopoly()
  self:refreshCurrency()
  self:refreshChest()
  self:createRingProgress()
  self:createMapIcon()
  self:refreshPost()
  self:onBtnChest()
end
function prototype:refreshPost()
  local info = Logic:Get("NewMonopoly"):GetMonoInfo()
  local scroll = tolua.cast(self.nodAdv:getChildByTag(self.scrollTag), "CCScrollViewEx")
  if not scroll then
    return
  end
  local container = scroll:getContainer()
  container:initRewards(info.records)
end
function prototype:refreshCurrency()
  local money = Logic:Get("PlayerInfo"):GetPlayerAllJade()
  self.ttfJade:setString(money)
  local info = Logic:Get("NewMonopoly"):GetMonoInfo()
  self.ttfCoin:setString(info.currency)
  self.ttfLeftDice:setString(info.cast)
  self.ttfLeftAdvDice:setString(info.specialCast)
end
function prototype:refreshChest()
  local info = Logic:Get("NewMonopoly"):GetMonoInfo()
  self.curStep = info.floors.xiyou.pos
  self.maxLattice = #info.floors.xiyou.positions
  local posX = self["sprPoint" .. self.curStep]:getPositionX()
  local posY = self["sprPoint" .. self.curStep]:getPositionY()
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
function prototype:createMapIcon(bMapOnly)
  local info = Logic:Get("NewMonopoly"):GetMonoInfo()
  self.map = self:createMapData(bMapOnly)
  for pos, iconType in ipairs(self.map) do
    local spr = "sprIcon" .. pos
    if self[spr] then
      self:createNodeImg(self[spr], iconType)
    end
  end
end
function prototype:createMapData(bMapOnly)
  local info = Logic:Get("NewMonopoly"):GetMonoInfo()
  local goldPositions = table.invert(info.floors.xiyou.goldPositions)
  local gonePositions = table.invert(info.floors.xiyou.gonePositions)
  local map = {}
  for i = 1, #info.floors.xiyou.positions do
    local id = info.floors.xiyou.positions[i]
    local rec = KFDBGetRecord("PositionPointSetting", id)
    local iconType = rec.type or "NONE"
    if goldPositions[i] then
      if not gonePositions[i] or not iconType then
        iconType = "GOLD_BOX"
      end
      iconType = bMapOnly and "GOLD_BOX" or iconType
    end
    table.insert(map, iconType)
  end
  return map
end
function prototype:createNodeImg(sprNode, iconType)
  local typeMap = {
    NONE = "images/public/clarity05.png",
    TASK = "images/Richer/taskIcon.png",
    SHOP = "images/Richer/shopIcon.png",
    SILVER_BOX = "images/Richer/greenBox.png",
    GOLD_BOX = "images/Richer/goldBoxOpen.png",
    TRANSFER = "images/Richer/transfer.png"
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
function prototype:createRingProgress(needAni)
  local bNeedAni = needAni or false
  local maxBox = 4
  self:createRingsData()
  local info = Logic:Get("NewMonopoly"):GetMonoInfo()
  local openBoxMap = {
    "images/Richer/greenBoxOpen.png",
    "images/Richer/blueBoxOpen.png",
    "images/Richer/purpleBoxOpen.png",
    "images/Richer/goldBoxOpen.png"
  }
  local emptyBoxMap = {
    "images/Richer/greenBoxEmpty.png",
    "images/Richer/blueBoxEmpty.png",
    "images/Richer/purpleBoxEmpty.png",
    "images/Richer/goldBoxEmpty.png"
  }
  local maxRings = self.ringsRec[#self.ringsRec].rings
  for i = 1, maxBox do
    local spr = "sprBox" .. i
    local ttf = "ttfBox" .. i
    local nod = "nodBox" .. i
    local needChangeBoxIcon = self:IsDrawBox(self.ringsRec[i].id) or info.floors.xiyou.rings >= self.ringsRec[i].rings
    if self[spr] and needChangeBoxIcon then
      local path = self:IsDrawBox(self.ringsRec[i].id) and emptyBoxMap[i] or openBoxMap[i]
      local ccsprite = CCSprite:create(path)
      if spr then
        self[spr]:setDisplayFrame(ccsprite:displayFrame())
      end
    end
    if self[ttf] then
      self[ttf]:setStyle(kCCLabelTTFStyleOutline)
      self[ttf]:setString(TwGetStr(115079, self.ringsRec[i].rings or 0))
    end
    if self[nod] then
      self[nod]:setVisible(true)
      local precent = self.ringsRec[i].rings / maxRings
      if precent == 100 then
      end
      local width = self.proRings:getContentSize().width * precent
      local posX = self.proRings:getPositionX() + width
      self[nod]:setPositionX(posX)
    end
  end
  if bNeedAni then
    self.proRings:setValue(math.floor(info.floors.xiyou.rings * 100 / maxRings), false, 0, 2000)
    return
  end
  self.proRings:setValue(math.floor(info.floors.xiyou.rings * 100 / maxRings))
end
function prototype:createRingsData()
  local info = Logic:Get("NewMonopoly"):GetMonoInfo()
  self.ringsRec = {}
  for i = 1, KFDBGetRecordAmt("RingsBoxRewardSetting") do
    local singleRec = KFDBGetRecordByIdx("RingsBoxRewardSetting", i)
    if singleRec.floor == info.currFloor then
      table.insert(self.ringsRec, singleRec)
    end
  end
  table.sort(self.ringsRec, function(left, right)
    return left.rings < right.rings
  end)
end
function prototype:IsDrawBox(id)
  local info = Logic:Get("NewMonopoly"):GetMonoInfo()
  local drawMap = table.invert(info.floors.xiyou.drewBoxs)
  return drawMap[id] and true or false
end
function prototype:onRewardEnd()
  self:onBtnChest()
  self.btnCover:setEnabled(false)
  self:createMapIcon()
  local info = Logic:Get("NewMonopoly"):GetMonoInfo()
  if info.currFloor == "xiyou" then
    return
  end
  local leaderId = Logic:Get("Hero"):GetLeaderId()
  local heroInfo = Logic:Get("Hero"):GetHeroInfoById(leaderId)
  local cardNode = Logic:Get("HeroCardInfo"):GetSprCard(heroInfo.baseId)
  local texture, textureRect = Logic:Get("HeroCardInfo"):GetCardTexture(cardNode)
  local function endFunc()
    SceneHelper:pushScene("RicherValeMap", self.rootNode)
    SceneHelper:removeScene("RicherValeNormal")
  end
  self:runBuffAni("UI/uilove04", texture, textureRect, endFunc)
end
function prototype:onDice(bAdvDice)
  local info = Logic:Get("NewMonopoly"):GetMonoInfo()
  local steps = Logic:Get("NewMonopoly"):GetDicePoints()
  local moveStep = Logic:Get("NewMonopoly"):GetActStep()
  local ani = bAdvDice and self.advDiceTurnAni or self.norDiceTurnAni
  local node = bAdvDice and self.nodAni2 or self.nodAni1
  node:removeAllChildrenWithCleanup(true)
  if bAdvDice then
    self.nodAdvDice:setVisible(false)
  else
    self.nodDice:setVisible(false)
  end
  self.btnCover:setEnabled(true)
  self:runAni(ani, moveStep, node, bAdvDice)
end
function prototype:runAni(ani, moveStep, node, bAdvDice)
  local aniPath = bAdvDice and "UI/uitouzi03" or "UI/uitouzi"
  ani = Logic:Get("AniMgr"):NewCCB(aniPath, node, ccp(0, 0), 0, nil, 1)
  local dicePath = bAdvDice and "images/Richer/advDice%d.png" or "images/Richer/dice%d.png"
  local path = string.format(dicePath, moveStep)
  local spr = CCSprite:create(path)
  if spr then
    ani:GetChild("sprDice"):setDisplayFrame(spr:displayFrame())
  end
  ani:RunAni(nil, nil, bind(self.aniEnd, self, moveStep))
end
function prototype:aniEnd(moveStep)
  self:moveChest(moveStep)
end
function prototype:moveChest(steps)
  local arr = CCArray:create()
  for i = 1, steps do
    local steps = self.curStep + 1
    if steps > self.maxLattice then
      steps = 1 or steps
    end
    local spr = "sprPoint" .. steps
    if self[spr] then
      local posX = self[spr]:getPositionX()
      local posY = self[spr]:getPositionY()
      local moveTo = CCJumpTo:create(0.3, ccp(posX, posY), 20, 1)
      local delay = CCDelayTime:create(0.1)
      arr:addObject(moveTo)
      arr:addObject(delay)
      self.curStep = self.curStep + 1
      self.curStep = self.curStep > self.maxLattice and 1 or self.curStep
      if self.curStep == 1 then
        local startAni = CCCallFuncN:create(function()
          local ani = Logic:Get("AniMgr"):NewCCB("UI/uiyh", self.rootNode, ccp(320, 480), 0, nil, 1)
          ani:RunAni()
          self:createRingProgress(true)
          self:createMapIcon(true)
        end)
        arr:addObject(startAni)
        arr:addObject(CCDelayTime:create(0.5))
      end
    end
  end
  local func = CCCallFuncN:create(function()
    self:refreshCurrency()
    self:showBoxAni()
  end)
  arr:addObject(func)
  self.nodChest:runAction(CCSequence:create(arr))
end
function prototype:showBoxAni()
  local map = {SILVER_BOX = "UI/uikxz02", GOLD_BOX = "UI/uikxz"}
  local iconType = self.map[self.curStep]
  if not map[iconType] then
    Logic:Get("NewMonopoly"):PromptReward()
    return
  end
  local ani = Logic:Get("AniMgr"):NewCCB(map[iconType], self.rootNode, ccp(320, 480), 0, nil, 1)
  ani:RunAni(nil, nil, function()
    Logic:Get("NewMonopoly"):PromptReward()
  end)
end
function prototype:runBuffAni(aniName, texture, textureRect, endFunc)
  local ani = Logic:Get("AniMgr"):NewCCB(aniName, self.rootNode, ccp(320, 480), 0, nil, 1)
  ani:GetChild("sprCard"):setTexture(texture)
  ani:GetChild("sprCard"):setTextureRect(textureRect)
  ani:RunAni(nil, nil, function()
    ani:RemoveAnimation()
    if endFunc then
      endFunc()
    end
  end)
end
