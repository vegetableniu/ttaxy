require("SceneHelper")
module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
function prototype:onEnter()
  self.curStep = 1
  local bg = "images/Richer/proBg.png"
  local pro = "images/Richer/proGreen.png"
  self.proRings:createProgress(bg, pro)
  self.ttfCoin:setStyle(kCCLabelTTFStyleOutline)
  self.ttfJade:setStyle(kCCLabelTTFStyleOutline)
  self:scrollViewCreate()
  Logic:Get("NewMonopoly"):On(Logic.NewMonopoly.EVT.PUSH_SCENE, self:Event("onRewardEnd"))
  Logic:Get("NewMonopoly"):On(Logic.NewMonopoly.EVT.CAST_DICE, self:Event("onDice"))
  Logic:Get("NewMonopoly"):On(Logic.NewMonopoly.EVT.DRAW_BOX_REWARD, self:Event("createRingProgress"))
  Logic:Get("NewMonopoly"):On(Logic.NewMonopoly.EVT.CURRENCY_CHANGED, self:Event("refreshCurrency"))
  Logic:Get("NewMonopoly"):On(Logic.NewMonopoly.EVT.ACROSS_DATE, self:Event("onBtnReturn"))
  Logic:Get("NewMonopoly"):On(Logic.NewMonopoly.EVT.SWITCH_DRAG, self:Event("onSwitchDrag"))
  self:onLoadNewMonopoly()
end
function prototype:scrollViewCreate()
  local container = Tw.Controller:load("PostCommonItem", self.rootNode)
  local scroll = CCScrollViewEx:create(CCSizeMake(370, 32))
  scroll:setDirection(kCCScrollViewDirectionHorizontal)
  scroll:setClippingToBounds(true)
  scroll:setTouchEnabled(false)
  scroll:setContainer(container)
  scroll:updateInset()
  self.scrollTag = scroll:getTag()
  self.nodAdv:addChild(scroll)
  local container = Tw.Controller:load("RicherValeMapItem", self.rootNode)
  container:setOwner(self)
  self.scroll = CCScrollViewEx:create(CCSizeMake(640, 855))
  self.scroll:setDirection(kCCScrollViewDirectionHorizontal)
  self.scroll:setClippingToBounds(false)
  self.scroll:setTouchEnabled(true)
  self.scroll:setContainer(container)
  self.scroll:updateInset()
  self.mapTag = self.scroll:getTag()
  self.nodMap:addChild(self.scroll)
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
function prototype:onBtnShow(sender, event)
  local iconType = {
    "SHOP",
    "SILVER_BOX",
    "BUFF",
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
  if iconType[idx] == "BUFF" then
    self:onSwitchDrag(false)
    SceneHelper:pushScene("RicherValeIcon", self.rootNode, nil, nil, true)
    return
  end
  Logic:Get("NewMonopoly"):SetShowRewardType(iconType[idx])
  SceneHelper:pushScene("RicherValeRewardShow", self.rootNode, nil, nil, true)
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
function prototype:onRewardEnd()
  self:setCoverEnabled(false)
  local info = Logic:Get("NewMonopoly"):GetMonoInfo()
  self:createRingProgress(true)
  if info.currFloor == "valentine" then
    return
  end
  local leaderId = Logic:Get("Hero"):GetLeaderId()
  local heroInfo = Logic:Get("Hero"):GetHeroInfoById(leaderId)
  local cardNode = Logic:Get("HeroCardInfo"):GetSprCard(heroInfo.baseId)
  local texture, textureRect = Logic:Get("HeroCardInfo"):GetCardTexture(cardNode)
  local function endFunc()
    SceneHelper:pushScene("RicherValeNormal", self.rootNode)
    SceneHelper:removeScene("RicherValeMap")
  end
  self:runBuffAni("UI/uilove04", texture, textureRect, endFunc)
end
function prototype:setCoverEnabled(bEnabled)
  self.btnCover:setEnabled(bEnabled)
end
function prototype:onLoadNewMonopoly()
  self:refreshCurrency()
  self:createRingProgress()
  self:refreshPost()
end
function prototype:onDice()
  self:refreshCurrency()
end
function prototype:onSwitchDrag(bAble)
  self.scroll:setTouchEnabled(bAble)
end
function prototype:refreshPost()
  local info = Logic:Get("NewMonopoly"):GetMonoInfo()
  local scroll = tolua.cast(self.nodAdv:getChildByTag(self.scrollTag), "CCScrollViewEx")
  if not scroll then
    return
  end
  local container = scroll:getContainer()
  local params = {
    sizeW = 370,
    sizeH = 15,
    strNum = 115107
  }
  container:initRewards(info.records, params)
end
function prototype:refreshCurrency()
  local money = Logic:Get("PlayerInfo"):GetPlayerAllJade()
  self.ttfJade:setString(money)
  local info = Logic:Get("NewMonopoly"):GetMonoInfo()
  self.ttfCoin:setString(info.currency)
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
    local needChangeBoxIcon = self:IsDrawBox(self.ringsRec[i].id) or info.floors.valentine.rings >= self.ringsRec[i].rings
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
    self.proRings:setValue(math.floor(info.floors.valentine.rings * 100 / maxRings), false, 0, 2000)
    return
  end
  self.proRings:setValue(math.floor(info.floors.valentine.rings * 100 / maxRings))
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
  local drawMap = table.invert(info.floors.valentine.drewBoxs)
  return drawMap[id] and true or false
end
function prototype:showBoxAni(iconType)
  local map = {SILVER_BOX = "UI/uikxz02", GOLD_BOX = "UI/uikxz"}
  if map[iconType] then
    local ani = Logic:Get("AniMgr"):NewCCB(map[iconType], self.rootNode, ccp(320, 480), 0, nil, 1)
    ani:RunAni(nil, nil, function()
      Logic:Get("NewMonopoly"):PromptReward()
    end)
    return
  end
  local leaderId = Logic:Get("Hero"):GetLeaderId()
  local heroInfo = Logic:Get("Hero"):GetHeroInfoById(leaderId)
  local cardNode = Logic:Get("HeroCardInfo"):GetSprCard(heroInfo.baseId)
  local texture, textureRect = Logic:Get("HeroCardInfo"):GetCardTexture(cardNode)
  if iconType == "CROSSING" then
    local logic = Logic:Get("NewMonopoly")
    local endFunc = bind(logic.PromptReward, logic)
    self:runBuffAni("UI/uilove03", texture, textureRect, endFunc)
    return
  end
  local info = Logic:Get("NewMonopoly"):GetMonoInfo()
  if self:isBuff(iconType) and info.currBuff and 0 >= info.buffTimes then
    local buffInfo = KFDBGetRecord("PositionBuffSetting", info.currBuff)
    local isGoodBuff = buffInfo.isGoodBuff == "true"
    local aniName = isGoodBuff and "UI/uilove02" or "UI/uilove01"
    local logic = Logic:Get("NewMonopoly")
    local endFunc = bind(logic.PromptReward, logic)
    self:runBuffAni(aniName, texture, textureRect, endFunc)
    return
  end
  Logic:Get("NewMonopoly"):PromptReward()
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
function prototype:isBuff(iconType)
  local typeMap = Enum({
    "HOVER",
    "LOSE",
    "SLOW",
    "TOXICOSIS",
    "GOSSIP",
    "REDOUBLE_DICE",
    "DOUBLE_REWARD",
    "FAST",
    "RAMDOM",
    "FORWARD",
    "BACK",
    "LUCKY"
  })
  return typeMap[iconType] and true or false
end
