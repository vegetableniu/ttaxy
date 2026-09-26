module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
local path_dis = "images/public/btn_long_disable.png"
function prototype:onEnter(...)
  self.ttfName:setStyle(kCCLabelTTFStyleOutline)
  self.ttfPoint:setStyle(kCCLabelTTFStyleOutline)
  self.ttfTimes:setStyle(kCCLabelTTFStyleOutline)
  Logic:Get("Elite"):On(Logic.Elite.EVT.BUY_TIMES, self:Event("OnBTBuyTimes"))
  Logic:Get("Mall"):On(Logic.Mall.EVT.BUY_SUCCESSED, self:Event("OnBTBuyPoints"))
  Logic:Get("Elite"):initBattleList("PILL")
  local battleId = Logic:Get("Elite"):GetBattleId()
  self.id = battleId
  self:refreshCtrl(battleId)
  self:refreshView(battleId)
  self:checkBtnStatus()
end
function prototype:refreshCtrl(battleId)
  local rec = Logic:Get("Battle"):GetBattleInfoById(battleId) or {}
  self.rec = rec
  self.ttfName:setString(rec.name or "")
  self.ttfPoint:setString(rec.cost or "-")
  self.dailyCount = Logic:Get("Elite"):GetCountByBattleId(battleId)
  local times = self.dailyCount
  if times > 8 then
    times = 8
  end
  self.times = times
  self.bmTimes:setString(times)
  self.ttfTimes:setString(string.format("(%d/%d)", times or 0, rec.dailyCount or 0))
  self.nodeBuy:setVisible(times <= 0)
  self.nodeSkip:setVisible(times > 0)
  local bClear = Logic:Get("Elite"):IsClearBattle(battleId)
  local bClearPrev = Logic:Get("Elite"):isClearPrevBattle(battleId, "PILL")
  self.bOpen = bClearPrev
  self.sprNew:setVisible(not bClear)
  self.sprClear:setVisible(bClear)
  if not bClear then
    self.nodeFight:setPositionX(320)
    self.nodeBuy:setVisible(false)
    self.nodeSkip:setVisible(false)
  end
end
function prototype:refreshView(battleId)
  local posX = 0
  local count = 0
  local drops = json.decode(self.rec.itemDrop or "") or {}
  if #drops == 0 then
    self.nodeDrop:setVisible(false)
    self:adaptHeight()
  end
  for _, v in ipairs(drops) do
    local ccbIcon = Tw.Controller:load("CardIcon", self.rootNode)
    if ccbIcon then
      local gift = {}
      gift.showType = v.type
      gift.showId = v.code
      gift.amount = v.amount
      ccbIcon:ReFreshByGift(gift)
      ccbIcon:setScale(0.8)
      ccbIcon:setAnchorPoint(ccp(0, 0))
      ccbIcon:setPosition(ccp(posX, 0))
      self.nodeView:addChild(ccbIcon)
    end
    posX = posX + 100
    count = count + 1
    if count >= 5 then
      break
    end
  end
end
function prototype:checkBtnStatus()
  if not self.bOpen then
    self.btnFight:setBackgroundSpriteForState(CCScale9Sprite:create(path_dis), CCControlStateNormal)
    self.btnFight:setBackgroundSpriteForState(CCScale9Sprite:create(path_dis), CCControlStateHighlighted)
  end
end
function prototype:adaptHeight(...)
  self.nodeHead:setPositionY(-30)
  self.nodeTimes:setPositionY(60)
  self.nodeSkip:setPositionY(20)
  self.nodeBuy:setPositionY(20)
  self.nodeFight:setPositionY(20)
end
function prototype:onBtnFight(...)
  if self.bOpen then
    local isBagFull = Logic:Get("Hero"):IsBagEnough()
    if isBagFull then
      SceneHelper:pushPrompt("BattleTip")
      return
    end
    local phyInfo = Logic:Get("PlayerInfo"):GetPlayerPhysical()
    local phyPoint = not phyInfo and 0 or phyInfo.point
    if phyPoint < tonumber(self.rec.cost) then
      Logic:Get("Mall"):BuyPoints()
      return
    end
    local level = Logic:Get("PlayerInfo"):GetPlayerLevel()
    if level < tonumber(self.rec.level) then
      Prompt:Tip(106012)
      return
    end
    if 0 >= self.dailyCount then
      local str = TwGetStr(114119)
      self.buyTimeCost = self:getBuyCost()
      local descStr = str .. "\n" .. TwGetStr(114120, self.buyTimeCost)
      Prompt:Confirm(self, "", descStr, self.onConfirmBuy, Prompt.PROMPT_TYPE.SELECT)
      return
    end
    Logic:Get("Battle"):SetEmBattleType(Logic.Battle.BATTLE_TYPE.PILL)
    Logic:Get("Cultivate"):SetBtlBtnVisible(false)
    Logic:Get("Cultivate"):SetEmbattleFromCultivate(true)
    SceneHelper:pushScene("EmbattleGroup")
  else
    Prompt:Tip(114106)
  end
end
function prototype:onBtnBuy(...)
  self.buyTimeCost = self:getBuyCost()
  local descStr = TwGetStr(114120, self.buyTimeCost)
  Prompt:Confirm(self, "", descStr, self.onConfirmBuy, Prompt.PROMPT_TYPE.SELECT)
end
function prototype:onBtnSkip(...)
  if self.times <= 0 then
    self:onBtnBuy()
    return
  end
  local phyInfo = Logic:Get("PlayerInfo"):GetPlayerPhysical()
  local phyPoint = not phyInfo and 0 or phyInfo.point
  if phyPoint < tonumber(self.rec.cost) * self.times then
    Logic:Get("Mall"):BuyPoints()
    return
  end
  Logic:Get("Elite"):PostQuickAdvance(self.times)
end
function prototype:onBtnClose(...)
  Logic:Get("Cultivate"):SetBtlScrollEnabled(true)
  SceneHelper:removeScene("CultivateBattleTip")
end
function prototype:onConfirmBuy()
  local jade = Logic:Get("PlayerInfo"):GetPlayerAllJade()
  if jade < self.buyTimeCost then
    Logic:Get("Main"):PromptCharge()
    return
  end
  Logic:Get("Elite"):PostBuyTimes()
end
function prototype:OnBTBuyTimes(...)
  Logic:Get("Elite"):initBattleList("PILL")
  self:refreshCtrl(self.id)
end
function prototype:OnBTBuyPoints(...)
  Logic:Get("Elite"):initBattleList("PILL")
  self:refreshCtrl(self.id)
end
function prototype:getBuyCost(...)
  local extraTimes = Logic:Get("Box"):GetMaxOpenTime("CULTIVATE") or 0
  local maxBuyTimes = self.rec.buyLimit + extraTimes
  local battleBuyTimes = Logic:Get("Elite"):GetBuyTimesById(self.rec.id)
  local idx = battleBuyTimes + 1
  local costTab = json.decode(self.rec.buyTimesCost or "") or {}
  if idx > #costTab then
    idx = #costTab or idx
  end
  return costTab[idx] or 0
end
