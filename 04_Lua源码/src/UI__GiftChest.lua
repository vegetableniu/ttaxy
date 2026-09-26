module((...), package.seeall)
require("SceneHelper")
require("BtnPosition")
prototype = BtnPosition.prototype:extend()
local STR = {
  TwGetStr(110613),
  TwGetStr(110614),
  TwGetStr(110615)
}
function prototype:initialize(...)
  super.initialize(self, ...)
end
function prototype:dispose(...)
  super.dispose(self)
end
function prototype:onEnter()
  super.onEnter(self)
  local KEY_TYPES = 3
  for i = 1, KEY_TYPES do
    local str = string.format("ttfKey%d", i)
    if self[str] then
      self[str]:setStyle(kCCLabelTTFStyleOutline)
    end
    str = string.format("ttfName%d", i)
    if self[str] then
      self[str]:setStyle(kCCLabelTTFStyleOutline)
    end
  end
  for i = 1, KEY_TYPES do
    local str = string.format("ttfName%d", i)
    if self[str] then
      self[str]:setString(STR[i])
      local color = Logic:Get("Lottery"):GetHeroRankColor3(i + 1)
      self[str]:setColor(color)
    end
  end
  local ID = 1023
  local rec = KFDBGetRecord("LanguageSetting", ID) or {}
  local str = ReplaceStringTab(rec.content)
  self.ttfDesr:setString(str)
  self.ttfDesr:setHorizontalAlignment(kCCVerticalTextAlignmentCenter)
  self.ttfCount:setStyle(kCCLabelTTFStyleOutline)
  self.ttfCount:setString(TwGetStr(105924, TwGetStr(110602)))
  self.activity = Logic:Get("Gift"):GetActivityByType("OPEN_BOX")
  if not table.empty(self.activity or {}) then
    self.ttfTitle:setStyle(kCCLabelTTFStyleOutline)
    self.ttfTitle:setString(self.activity[1].name or "")
  end
  Logic:Get("Box"):PostLoadBoxInfo()
  Logic:Get("Box"):On(Logic.Box.EVT.LOAD_BOX_INFO, self:Event("onLoadBoxInfo"))
  Logic:Get("Box"):On(Logic.Box.EVT.OPEN_BOX_BY_KEY, self:Event("onOpenBoxByKey"))
  Logic:Get("Mall"):On(Logic.Mall.EVT.GET_LOTTERY_LIST, self:Event("onGetMallList"))
end
function prototype:onBtnReturn(sender, event)
  SceneHelper:runWithScene("GiftActivityList", self.rootNode)
end
function prototype:onBtnMall(sender, event)
  MsgPlayer:Post("GET_LOTTERY_LIST")
end
function prototype:onBtnChest(sender, event)
  local key = 0
  local BTN_NUM = 3
  for i = 1, BTN_NUM do
    local str = string.format("btnChest%d", i)
    if self[str] == sender then
      local _, keyIdx = Logic:Get("Box"):GetKeyNumById(i)
      key = keyIdx
      break
    end
  end
  self.key = key
  local keyNum = Logic:Get("Box"):GetKeyNumById(key)
  if keyNum > 0 then
    Logic:Get("Box"):PostOpenBoxByKey(key)
    return
  end
  if Logic:Get("Box"):IsOverOpenTime(key) then
    Prompt:Fail(TwGetStr(110612))
    return
  end
  local jade = Logic:Get("PlayerInfo"):GetPlayerAllJade()
  local cost = Logic:Get("Box"):GetCostByType(key)
  if jade < cost then
    Logic:Get("Main"):PromptCharge()
    return
  end
  local PROMPT_TYPE = {
    "OPEN_BOX_GREEN",
    "OPEN_BOX_BLUE",
    "OPEN_BOX_PURPLE"
  }
  Prompt:ConfirmRecord(self, "", TwGetStr(110608, cost), self.PostJadeOpenBox, Prompt.PROMPT_TYPE.SELECT, nil, PROMPT_TYPE[key])
end
function prototype:PostJadeOpenBox()
  Logic:Get("Box"):PostOpenBoxByCurrency(self.key)
end
function prototype:onLoadBoxInfo()
  local KEY_TYPES = 3
  for i = 1, KEY_TYPES do
    local num, key = Logic:Get("Box"):GetKeyNumById(i)
    local str = string.format("ttfKey%d", key)
    if self[str] then
      self[str]:setString("X" .. num)
    end
  end
  local tokenCoin = Logic:Get("PlayerInfo"):GetTokenCoin()
  self.ttfPoint:setString(tokenCoin)
  local sprIntegralX = self.ttfPoint:getPositionX() + self.ttfPoint:getContentSize().width + self.sprIntegral:getContentSize().width
  self.sprIntegral:setPositionX(sprIntegralX)
end
function prototype:onOpenBoxByKey()
  self:onLoadBoxInfo()
end
function prototype:onGetMallList()
  if table.empty(self.activity or {}) then
    return
  end
  Logic:Get("Mall"):initItemData()
  local data = Logic:Get("Mall"):GetTabData()
  local tokenCoinData
  for _, v in pairs(data) do
    if v.id == self.activity[1].mallId then
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
