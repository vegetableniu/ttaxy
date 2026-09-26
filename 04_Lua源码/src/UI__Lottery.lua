module((...), package.seeall)
require("SceneHelper")
require("BtnPosition")
prototype = BtnPosition.prototype:extend()
CURRENCY_TYPE = TypeDef("com.eyu.mt.module.currency.model.CurrencyType")
local maxTip = 6
function prototype:initialize(...)
  super.initialize(self, ...)
  self.from = nil
  self.drawType = nil
  self.costTab = {}
  self.drawData = nil
end
function prototype:dispose(...)
  super.dispose(self)
end
function prototype:onEnter()
  super.onEnter(self)
  self.drawData = Logic:Get("Lottery"):GetDrawData()
  self.ttfLast:setStyle(kCCLabelTTFStyleOutline)
  for i = 1, maxTip do
    local strTip = string.format("ttfTip%d", i)
    local strNum = string.format("ttfNum%d", i)
    if self[strTip] then
      self[strTip]:setStyle(kCCLabelTTFStyleOutline)
    end
    if self[strNum] then
      self[strNum]:setStyle(kCCLabelTTFStyleOutline)
    end
  end
  self.ttfTipTen:setStyle(kCCLabelTTFStyleOutline)
  if self.drawData.titlePath and self.drawData.titlePath ~= "" then
    local spr = CCSprite:create(self.drawData.titlePath)
    if spr == nil then
      return
    end
    self.sprTitle:setDisplayFrame(spr:displayFrame())
  end
  self:resetDescription()
  Logic:Get("Lottery"):On(Logic.Lottery.EVT.DRAW_SUCCESSED, self:Event("onDrawSuccussed"))
  Logic:Get("Lottery"):On(Logic.Lottery.EVT.DRAW_FAILED, self:Event("onDrawFailed"))
  Logic:Get("Lottery"):On(Logic.Lottery.EVT.REFRESH_DESCRIPTION, self:Event("resetDescription"))
  if Logic:Get("Guide"):isActive("Lottery", "SelectTimes") then
    Logic:Get("Lottery"):setGuideLottery(true)
    Logic:Get("Lottery"):setGuideLotterEvo(true)
    Logic:Get("Guide"):lockTouch(self.btnDrawOnce)
  end
  self.ani = Logic:Get("AniMgr"):NewCCB("UI/UIcz02", self.sprRight, ccp(35, 19), 0, nil, nil)
  if self.ani then
    self.ani:RunAni()
  end
end
function prototype:onExit()
  Logic:Get("Lottery"):SetFrom(Logic.Lottery.FROM_MALL)
end
function prototype:onNodeLoaded(node, loader)
end
function prototype:onBtnRecharge(sender, event)
  Logic:Get("Main"):GotoRecharge()
end
function prototype:onBtnBackCliecked(sender, event)
  local from = Logic:Get("Lottery"):GetFrom()
  if from == Logic.Lottery.FROM_DEVIL then
    SceneHelper:runWithScene("DevilMain", self.rootNode)
  else
    SceneHelper:runWithScene("Mall", self.rootNode)
  end
end
function prototype:onDrawOnceClicked(sender, event)
  if self.drawType == nil then
    return
  end
  local money = Logic:Get("PlayerInfo"):GetPlayerMoney().friendship
  if self.costTab[1] and money < self.costTab[1] then
    Prompt:Fail(TwGetStr(105235))
    return
  end
  Logic:Get("Lottery"):SetDrawType(self.drawType)
  Logic:Get("Lottery"):PostLottery(1)
end
function prototype:onDrawTenClicked(sender, event)
  if self.drawType == nil then
    return
  end
  local money = Logic:Get("PlayerInfo"):GetPlayerMoney().friendship
  if self.costTab[2] and money < self.costTab[2] then
    Prompt:Fail(TwGetStr(105235))
    return
  end
  Logic:Get("Lottery"):SetDrawType(self.drawType)
  Logic:Get("Lottery"):PostLottery(10)
end
function prototype:resetDescription()
  if self.drawData == nil or table.empty(self.drawData) then
    return
  end
  self.drawType = CURRENCY_TYPE.FRIENDSHIP
  local cost, friendship = Logic:Get("Lottery"):GetFriendCostAndPoints()
  if cost and friendship then
    self.costTab = cost or {}
    self:friendDraw(cost[1] or 0, friendship)
  end
end
function prototype:friendDraw(cost, friendship)
  local costStr = tostring(cost)
  local friendshipStr = tostring(friendship)
  local times = 0
  if cost > 0 then
    times = math.floor(friendship / cost)
  end
  local tipFrontStr = TwGetStr(105221)
  local tipBackStr = TwGetStr(105222)
  self:formatDesctrion(self.ttfText1, tipFrontStr, cost, tipBackStr)
  tipFrontStr = TwGetStr(105223)
  self:formatDesctrion(self.ttfText2, tipFrontStr, friendship)
  tipFrontStr = TwGetStr(105224)
  tipBackStr = TwGetStr(105225)
  self:formatDesctrion(self.ttfText3, tipFrontStr, times, tipBackStr)
end
function prototype:formatDesctrion(node, strFront, strNum, strBack)
  local strWhiteFormat = "<font SIZE='28' color='#ffffff' >%s</font>"
  local strGreenFormat = "<font SIZE='28' color='#00F979' >%s</font>"
  local strNewFront = string.format(strWhiteFormat, strFront or "")
  local strNewNum = string.format(strGreenFormat, strNum or "")
  local strNewBack = string.format(strWhiteFormat, strBack or "")
  local strFinal = strNewFront .. strNewNum .. strNewBack
  if node then
    node:setString(strFinal)
  end
end
function prototype:onDrawSuccussed()
  SceneHelper:removeScene("LotteryResult")
  SceneHelper:pushScene("LotteryResult", self.rootNode)
end
function prototype:onDrawFailed(errCode)
  if errCode == -105 then
    if self.drawType == CURRENCY_TYPE.FRIENDSHIP then
      Prompt:Fail(TwGetStr(105235))
    elseif self.drawType == CURRENCY_TYPE.GOLD then
      Logic:Get("SureConfirm").btnText.ok = TwGetStr(104003)
      Prompt:Confirm(Logic:Get("Main"), "", 105316, Logic:Get("Main").GotoRecharge, Prompt.PROMPT_TYPE.SELECT)
    end
  elseif errCode == -8 then
    Prompt:Fail(TwGetStr(100022))
  else
    Prompt:Fail(tostring(errCode))
  end
end
