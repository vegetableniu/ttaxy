require("SceneHelper")
module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
function prototype:initialize()
  super.initialize(self)
end
function prototype:onEnter()
  self:initMultiple()
  self:scrollViewCreate()
  self.ttfLeftTimes:setStyle(kCCLabelTTFStyleOutline)
  self.isLottery = false
  self.ttfJade:setStyle(kCCLabelTTFStyleOutline)
  Logic:Get("Slot"):On(Logic.Slot.EVT.LOAD_INFO, self:Event("onLoadInfo"))
  Logic:Get("Slot"):On(Logic.Slot.EVT.LOTTERY, self:Event("onLottery"))
  Logic:Get("Mall"):On(Logic.Mall.EVT.GET_LOTTERY_LIST, self:Event("onGetMallList"))
  Logic:Get("Slot"):PostLoadInfo()
end
function prototype:scrollViewCreate()
  local container = Tw.Controller:load("PostCommonItem", self.rootNode)
  local scroll = CCScrollViewEx:create(CCSizeMake(430, 32))
  scroll:setDirection(kCCScrollViewDirectionHorizontal)
  scroll:setClippingToBounds(true)
  scroll:setTouchEnabled(false)
  scroll:setContainer(container)
  scroll:updateInset()
  self.scrollTag = scroll:getTag()
  self.nodAdv:addChild(scroll)
end
function prototype:initMultiple()
  local rec = KFDBGetRecord("ConfigValue", "SLOT:MULTIPLE") or {}
  local multiples = json.decode(rec.content or "[]")
  self.multMap = {}
  for pos, v in ipairs(multiples) do
    if table.empty(self.multMap[v] or {}) then
      self.multMap[v] = {}
    end
    table.insert(self.multMap[v], pos)
  end
  local labs = list.map(function(index)
    return self["labTimes" .. index]
  end, table.indices(list.rep({0}, 12)))
  for i, singleLab in ipairs(labs) do
    singleLab:create(multiples[i] or 0, "BLUE_NUM")
    singleLab:setAlign("LEFT", "CENTER")
  end
end
function prototype:onBtnReturn(sender, event)
  SceneHelper:runWithScene("GiftActivityList", self.rootNode)
end
function prototype:onBtnShop(sender, event)
  MsgPlayer:Post("GET_LOTTERY_LIST")
end
function prototype:onBtnLottery(sender, event)
  if self.isLottery then
    self:stopLottery()
    return
  end
  self:lottery()
end
function prototype:lottery()
  local freetimes, costtimes = self:getLeftTimes()
  if freetimes > 0 then
    Logic:Get("Slot"):PostLottery(false)
    return
  end
  if costtimes <= 0 then
    Prompt:Fail(TwGetStr(115103))
    return
  end
  local rec = KFDBGetRecord("ConfigValue", "SLOT:TIMES_COST") or {}
  local tabCosts = json.decode(rec.content or "[]")
  local info = Logic:Get("Slot"):GetSlotInfo()
  local idx = info.costtimes + 1
  if idx > #tabCosts then
    idx = #tabCosts or idx
  end
  self.currCost = tabCosts[idx] or 0
  Prompt:Confirm(self, "", TwGetStr(115105, self.currCost), self.PostJadeLottery, Prompt.PROMPT_TYPE.SELECT)
end
function prototype:PostJadeLottery()
  if not Logic:Get("PlayerInfo"):IsMoneyEnough(self.currCost) then
    Logic:Get("Main"):PromptCharge()
    return
  end
  Logic:Get("Slot"):PostLottery(true)
end
function prototype:onLoadInfo()
  self:refreshGoods()
  self:refreshPost()
  self:refreshTimes()
  self:refreshCurrency()
end
function prototype:refreshTimes()
  local leftFreeTimes = self:getLeftTimes()
  self.ttfLeftTimes:setString(leftFreeTimes)
end
function prototype:refreshPost()
  local info = Logic:Get("Slot"):GetSlotInfo()
  local scroll = tolua.cast(self.nodAdv:getChildByTag(self.scrollTag), "CCScrollViewEx")
  if not scroll then
    return
  end
  local container = scroll:getContainer()
  local params = {
    sizeW = 430,
    sizeH = 15,
    strNum = 115107
  }
  container:initRewards(info.records, params)
end
function prototype:refreshCurrency()
  local money = Logic:Get("PlayerInfo"):GetPlayerAllJade()
  self.ttfJade:setString(money)
end
function prototype:onLottery()
  self:runLotteryAni()
end
function prototype:onGetMallList()
  local giftInfo = Logic:Get("Gift"):GetActivityGift()
  Logic:Get("Mall"):initItemData()
  local data = Logic:Get("Mall"):GetTabData()
  local tokenCoinData
  for _, v in pairs(data) do
    if v.id == giftInfo.mallId then
      tokenCoinData = v
      break
    end
  end
  if tokenCoinData then
    Logic:Get("Mall"):SetTokenCoinData(tokenCoinData)
    SceneHelper:pushScene("MallExchange", self.rootNode)
    return
  end
  Prompt:Fail(TwGetStr(105285))
end
function prototype:getLeftTimes()
  local maxFreeTimes = Logic:Get("Egg"):GetCongifValueByKey("SLOT:FREE_TIMES")
  local maxJadeTimes = Logic:Get("Egg"):GetCongifValueByKey("SLOT:COST_LOTTERY_TIMES")
  local info = Logic:Get("Slot"):GetSlotInfo()
  local leftFreeTimes = (info.buyTimes or 0) + maxFreeTimes - (info.freetimes or 0)
  local leftJadeTimes = maxJadeTimes - (info.costtimes or 0)
  return leftFreeTimes, leftJadeTimes
end
function prototype:refreshGoods()
  self:initGoodsData()
  local ccbs = list.map(function(index)
    return self["ccbCard" .. index]
  end, table.indices(list.rep({0}, 12)))
  for i, ccb in ipairs(ccbs) do
    ccb:ReFreshByGift(self.goods[i])
  end
end
function prototype:initGoodsData()
  local info = Logic:Get("Slot"):GetSlotInfo()
  self.goods = {}
  for _, id in ipairs(info.positionRewards or {}) do
    local rec = KFDBGetRecord("SlotReward", id) or {}
    table.insert(self.goods, rec)
  end
end
function prototype:stopLottery()
  self.sprSuspendDis:setVisible(true)
  self.btnLottery:setEnabled(false)
  self.aniData.sprOut.rounds = 2
  self.aniData.sprIn.rounds = 3
  self.isLottery = false
end
function prototype:runLotteryAni()
  local target = Logic:Get("Slot"):GetAppearPosition()
  local idx = 1
  local ranMap = self.multMap[self.goods[target].times]
  if ranMap then
    idx = math.random(1, #ranMap)
  end
  if not table.empty(self.aniData or {}) then
    local spr = "sprOut" .. self.aniData.sprOut.currPos
    self[spr]:setVisible(false)
    spr = "sprIn" .. self.aniData.sprIn.currPos
    self[spr]:setVisible(false)
  end
  self.aniData = {}
  self.aniData.sprOut = {
    delay = 0.1,
    rounds = 4,
    currPos = 1,
    target = target
  }
  self.aniData.sprIn = {
    delay = 0.08,
    rounds = 7,
    currPos = 1,
    target = ranMap[idx] or 1
  }
  self.sprCover1:setVisible(true)
  self.sprCover2:setVisible(true)
  self.sprSuspend:setVisible(true)
  self.sprLottery:setVisible(false)
  self.btnReturn:setEnabled(false)
  self.btnShop:setEnabled(false)
  self.isLottery = true
  self:roundAni(self.sprCover1, self.aniData.sprOut, "sprOut")
  self:roundAni(self.sprCover2, self.aniData.sprIn, "sprIn")
end
function prototype:roundAni(node, data, currNode)
  local function moveFunc(node)
    local currPos = data.currPos
    local currSpr = currNode .. currPos
    local nextPos = currPos + 1 > 12 and 1 or currPos + 1
    local nextSpr = currNode .. nextPos
    self[currSpr]:setVisible(false)
    self[nextSpr]:setVisible(true)
    node:setRotation(data.currPos * 30)
    data.currPos = data.currPos + 1
    if data.currPos > 12 then
      data.rounds = data.rounds - 1
      data.delay = self.isLottery and data.delay or 0.2
      data.currPos = 1
    end
    if data.rounds == 0 and data.currPos == data.target then
      if currNode == "sprIn" then
        self:shiningAni()
      end
      if currNode == "sprOut" then
        self.btnLottery:setEnabled(false)
      end
      return
    end
    self:roundAni(node, data, currNode)
  end
  local action = {}
  table.insert(action, CCDelayTime:create(data.delay))
  table.insert(action, CCCallFuncN:create(moveFunc))
  node:runAction(Logic:Get("AniMgr"):CreateSequence(action))
end
function prototype:shiningAni()
  local fadeAni = function(action)
    for i = 1, 2 do
      table.insert(action, CCFadeOut:create(1))
      table.insert(action, CCFadeIn:create(1))
    end
  end
  local action = {}
  fadeAni(action)
  local idx = "sprOut" .. self.aniData.sprOut.currPos
  self[idx]:runAction(Logic:Get("AniMgr"):CreateSequence(action))
  action = {}
  fadeAni(action)
  table.insert(action, CCCallFuncN:create(function()
    self:aniEnd()
  end))
  idx = "sprIn" .. self.aniData.sprIn.currPos
  self[idx]:runAction(Logic:Get("AniMgr"):CreateSequence(action))
end
function prototype:aniEnd()
  self:refreshGoods()
  self:refreshTimes()
  self:refreshCurrency()
  self.sprCover1:setVisible(false)
  self.sprCover2:setVisible(false)
  self.sprSuspend:setVisible(false)
  self.sprSuspendDis:setVisible(false)
  self.sprLottery:setVisible(true)
  self.btnLottery:setEnabled(true)
  self.btnReturn:setEnabled(true)
  self.btnShop:setEnabled(true)
  self.isLottery = false
  Logic:Get("Slot"):PromptReward()
end
