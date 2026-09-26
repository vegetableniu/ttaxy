module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
require("SceneHelper")
local ITEM_HEIGHT = 40
local ITEM_WIDTH = 180
function prototype:initialize(...)
  super.initialize(self)
  self.rewardNum = 0
  self.range = 0.06
  self.totoleRange = 40
  self.subScene = {}
end
function prototype:onEnter()
  self.ICONBG = {
    "iconBg1",
    "iconBg2",
    "iconBg3",
    "iconBg4",
    "iconBg5",
    "iconBg6",
    "iconBg7",
    "iconBg8"
  }
  self.AWARDDICON = {
    "rewardIcon1",
    "rewardIcon2",
    "rewardIcon3",
    "rewardIcon4",
    "rewardIcon5",
    "rewardIcon6",
    "rewardIcon7",
    "rewardIcon8"
  }
  self.AWARDNUM = {
    "staAwardNum1",
    "staAwardNum2",
    "staAwardNum3",
    "staAwardNum4",
    "staAwardNum5",
    "staAwardNum6",
    "staAwardNum7",
    "staAwardNum8"
  }
  self.drawAwardInfo = {}
  local spr = CCSprite:create("images/Draw/turntableBg.png")
  if spr then
    self.imgBg:setDisplayFrame(spr:displayFrame())
  end
  self.imgBg:setScale(1.25)
  self.drawLevel = Logic:Get("Draw"):getNextDrawLevel()
  for i = 1, KFDBGetRecordAmt("RouletteLotteryConfig") do
    local rec = KFDBGetRecordByIdx("RouletteLotteryConfig", i)
    if rec and self.drawLevel == rec.level then
      if rec.showType and rec.showType == "REAL_GOODS" and (Logic:Get("System"):IsOperator("movefun") or Logic:Get("System"):IsOperator("appstore")) then
        rec.showId = "3"
        rec.showType = "GOLD"
        rec.rewardNum = "50"
      end
      table.insert(self.drawAwardInfo, rec)
    end
  end
  Logic:Get("Main"):SetFuncVisible(false)
  self:setAwardIconImage()
  Logic:Get("Draw"):On(Logic.Draw.EVT.DRAW_RESULT, self:Event("StartLuck"))
  Logic:Get("Draw"):On(Logic.Draw.EVT.DRAW_FAILED, self:Event("onDrawFailed"))
  self:showOtherPlayerDrawInfo()
end
function prototype:onExit()
  Logic:Get("Main"):SetFuncVisible(true)
end
function prototype:onBtnStartDraw()
  MsgPlayer:Post("ROULETTE_LOTTERY")
end
function prototype:onBtnHeroImage(sender, event)
  for i = 1, 8 do
    local str = string.format("btnImage%d", i)
    if sender == self[str] then
      self:createHero(i)
      break
    end
  end
end
function prototype:createHero(index)
  if self.drawAwardInfo == nil or next(self.drawAwardInfo) == nil then
    return
  end
  if self.drawAwardInfo[index].showType == "HERO" then
    Logic:Get("HeroCardInfo"):OpenHeroInfoById(self.drawAwardInfo[index].showId)
  end
end
function prototype:onDrawFailed(code)
  if code == -10 then
    local str = TwGetStr(108013)
    Prompt:Confirm(self, "", str, self.removeDrawMain, Prompt.PROMPT_TYPE.CONFIRM)
  end
end
function prototype:removeDrawMain()
  SceneHelper:removeScene("DrawMain")
end
function prototype:showOtherPlayerDrawInfo()
  local otherPlayerDrawInfo = Logic:Get("Draw"):getOtherPlayerDrawResult()
  if otherPlayerDrawInfo == nil or next(otherPlayerDrawInfo) == nil then
    self.imgTip:setVisible(false)
    return
  end
  local hitIpadInfo = {}
  local drawInfo = {}
  for i = #otherPlayerDrawInfo, 1, -1 do
    local rewardInfo = KFDBGetRecordByIdx("RouletteLotteryConfig", otherPlayerDrawInfo[i].configId)
    if rewardInfo.showType == "REAL_GOODS" then
      if not Logic:Get("System"):IsOperator("movefun") and not Logic:Get("System"):IsOperator("appstore") then
        table.insert(hitIpadInfo, otherPlayerDrawInfo[i])
      end
    else
      table.insert(drawInfo, otherPlayerDrawInfo[i])
    end
  end
  self:startPlayerNameMove(hitIpadInfo)
  for i = 1, #drawInfo do
    table.insert(self.subScene, Tw.Controller:load("DrawMainItem", self.rootNode))
  end
  local x = self.subScene[1]:getPositionX()
  local y = self.subScene[1]:getPositionY()
  for i = 1, #drawInfo do
    if #hitIpadInfo ~= 0 and i > 4 or i > 5 then
      break
    end
    if self.subScene[i] then
      if #hitIpadInfo == 0 then
        self.subScene[i]:setPosition(ccp(x, y + (5 - i) * ITEM_HEIGHT))
      else
        self.subScene[i]:setPosition(ccp(x, y + (4 - i) * ITEM_HEIGHT))
      end
      self.showDrawResult:addChild(self.subScene[i])
      self.subScene[i]:RefrashOtherDraw(drawInfo[i])
    end
  end
end
function prototype:startPlayerNameMove(playerInfo)
  local x = 0
  local y = 0
  local playerTemp = playerInfo
  if playerTemp == nil or next(playerTemp) == nil then
    self.imgTip:setVisible(false)
    return
  end
  local player = tree.clone(playerTemp)
  if #playerTemp ~= 1 then
    for i = 1, #playerTemp do
      table.insert(player, playerTemp[i])
    end
  end
  for i = 1, #player do
    local str = string.format("subScene%d", i)
    self[str] = Tw.Controller:load("DrawMainItem", self.rootNode)
  end
  local container = CCNode:create()
  container:setContentSize(CCSizeMake(ITEM_WIDTH, 40))
  self.groupWidth = 0
  local currX = 10
  local lastWidth = 0
  for i = 1, #player do
    local str = string.format("subScene%d", i)
    if self[str] then
      self[str].ttfName:setString(player[i].userName)
      self[str].ttfName:setStyle(kCCLabelTTFStyleOutline)
      local width = self[str].ttfName:getContentSize().width
      if i == 1 then
        lastWidth = width
      else
        currX = currX + lastWidth + 20
        lastWidth = width
      end
      self[str]:setPosition(ccp(currX, y))
      if i <= #player / 2 then
        self.groupWidth = self.groupWidth + width + 20
      end
      container:addChild(self[str])
    end
  end
  local scroll = CCScrollViewEx:create(CCSizeMake(ITEM_WIDTH, 40))
  scroll:setDirection(kCCScrollViewDirectionHorizontal)
  scroll:setClippingToBounds(true)
  scroll:setTouchEnabled(false)
  scroll:setContainer(container)
  scroll:updateInset()
  self.scrollTag = scroll:getTag()
  self.moveNode:addChild(scroll)
  if #playerTemp <= 1 then
    return
  end
  self:moveItem()
end
function prototype:moveItem()
  local scroll = tolua.cast(self.moveNode:getChildByTag(self.scrollTag), "CCScrollViewEx")
  if scroll == nil then
    return
  end
  local container = scroll:getContainer()
  local arr1 = CCArray:create()
  arr1:addObject(CCCallFuncN:create(function()
    if scroll:getContentOffset().x <= -self.groupWidth then
      container:setPositionX(0)
    else
      container:setPositionX(container:getPositionX() - 0.5)
    end
  end))
  container:runAction(CCRepeatForever:create(CCSequence:create(arr1)))
end
function prototype:setAwardIconImage()
  if self.drawAwardInfo == nil or next(self.drawAwardInfo) == nil then
    return
  end
  for k, v in pairs(self.drawAwardInfo) do
    local spr = Logic:Get("Gift"):createImg(v)
    if spr ~= nil then
      self[self.ICONBG[k]]:setDisplayFrame(spr:displayFrame())
      local strGoods = Logic:Get("Gift"):createGoodsImg(v)
      if strGoods ~= nil then
        local texture, textureRect = Logic:Get("HeroCardInfo"):GetCardTexture(strGoods)
        self[self.AWARDDICON[k]]:setTexture(texture)
        self[self.AWARDDICON[k]]:setTextureRect(textureRect)
      end
    end
    self[self.AWARDNUM[k]]:setStyle(kCCLabelTTFStyleOutline)
    if v.rewardNum and v.rewardNum ~= "1" then
      self[self.AWARDNUM[k]]:setString(v.rewardNum)
    end
    Logic:Get("HeroCardInfo"):AddShanCardSmall(self[self.ICONBG[k]], v.showId, nil, nil, true)
  end
end
function prototype:StartLuck()
  self.ani = Logic:Get("AniMgr"):NewCCB("UI/UIdzp", self.drawNode, ccp(0, -65), 0, nil, nil)
  if self.ani then
    self.ani:RunAni(nil, nil, nil)
  end
  local drawId = Logic:Get("Draw"):getDrawResultId()
  local awardInfo = {}
  if drawId then
    awardInfo = KFDBGetRecordByIdx("RouletteLotteryConfig", drawId)
  end
  if awardInfo ~= nil and next(awardInfo) ~= nil then
    self.rewardNum = awardInfo.number
  end
  self.btnStartDraw:setEnabled(false)
  self:rotate()
end
function prototype:LuckDraw()
  self.ani:RemoveAnimation()
  local node = {}
  for i = 1, 3 do
    if i ~= 3 then
      local strNode = string.format("imageNode%d", self.rewardNum * 3 - i)
      table.insert(node, strNode)
    else
      local strNode = string.format("imageNode%d", self.rewardNum * 3)
      table.insert(node, strNode)
    end
  end
  local ani1 = Logic:Get("AniMgr"):NewCCB("UI/UIdzp02", self[node[1]])
  if ani1 then
    ani1:RunAni(nil, nil, nil)
  end
  local ani2 = Logic:Get("AniMgr"):NewCCB("UI/UIdzp02", self[node[2]])
  if ani2 then
    ani2:RunAni(nil, nil, nil)
  end
  local ani3 = Logic:Get("AniMgr"):NewCCB("UI/UIdzp02", self[node[3]])
  if ani3 then
    ani3:RunAni(nil, nil, nil)
  end
  local arrAction = CCArray:create()
  arrAction:addObject(CCDelayTime:create(2))
  arrAction:addObject(CCCallFuncN:create(function()
    SceneHelper:removeScene("DrawMain")
    SceneHelper:pushScene("DrawResult", nil, self.mainScene)
  end))
  self.rootNode:runAction(CCSequence:create(arrAction))
end
function prototype:rotate()
  self.times = self.times or 1
  if self.times > 16 and self.times <= 24 then
    self.range = self.range + 0.008
  elseif self.times > 24 and self.times <= 32 then
    self.range = self.range + 0.018
  elseif self.times > 32 and self.times <= 40 then
    if self.rewardNum <= 4 then
      self.range = self.range + 0.08
    else
      self.range = self.range + 0.01
    end
  elseif self.times > self.totoleRange then
    if self.rewardNum <= 4 then
      self.range = self.range + 0.21
    else
      self.range = self.range + 0.1
    end
  end
  local array = CCArray:create()
  array:addObject(CCRotateBy:create(self.range / math.pow(1, self.times), 45))
  array:addObject(CCCallFuncN:create(function()
    self.times = self.times + 1
    if self.times < self.totoleRange + self.rewardNum then
      self:rotate()
    else
      self:LuckDraw()
    end
  end))
  self.arrowMove:runAction(CCSequence:create(array))
  local arrAction = CCArray:create()
  arrAction:addObject(CCDelayTime:create(self.range / (math.pow(1, self.times) * 2)))
  arrAction:addObject(CCCallFuncN:create(function()
    self.movePoint:setRotation(self.movePoint:getRotation() + 45)
  end))
  self.rootNode:runAction(CCSequence:create(arrAction))
end
