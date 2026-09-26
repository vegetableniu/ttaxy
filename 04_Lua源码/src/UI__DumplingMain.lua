module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
local PROG_BG_PATH = "images/public/progress_bg.png"
local CURR_PROG_PATH = "images/public/progress_ft2.png"
function prototype:initialize(...)
  super.initialize(self, ...)
end
function prototype:dispose(...)
  super.dispose(self)
end
function prototype:onEnter()
  self.labTime:setStyle(kCCLabelTTFStyleOutline)
  self.m_pDuration:createProgress(PROG_BG_PATH, CURR_PROG_PATH)
  self.m_pDuration:setVisible(true)
  self.minutes = 0
  local giftInfo = Logic:Get("Gift"):GetActivityGift()
  self.title_ttf:setColor(ccc3(255, 183, 18))
  self.title_ttf:setString(giftInfo.name)
  self.title_ttf:setStyle(kCCLabelTTFStyleOutline)
  self:setClearState(false)
  Logic:Get("Dumpling"):startTimer()
  Logic:Get("Dumpling"):PostGetCoolTime()
  Logic:Get("Dumpling"):On(Logic.Dumpling.EVT.GET_COOLTIME_OK, self:Event("refresh"))
  Logic:Get("Dumpling"):On(Logic.Dumpling.EVT.TIMER_EVENT, self:Event("refreshCookDumplingTime"))
  Logic:Get("Dumpling"):On(Logic.Dumpling.EVT.COOKING_FINISHED, self:Event("finishCooking"))
  Logic:Get("Mall"):On(Logic.Mall.EVT.GET_LOTTERY_LIST, self:Event("onGetMallList"))
  local rec = KFDBGetRecord("LanguageSetting", 1013)
  if rec and rec.content then
    self.labTips:setString(ReplaceStringTab(rec.content or ""))
  end
  if Logic:Get("Dumpling"):getBeginCookingFlag() then
    self:cooking()
  else
    local state = Logic:Get("Dumpling"):getDumplingState()
    if Logic.Dumpling.DUMPLING_STATE.COOKING == state then
      self.sprBoilTop:setVisible(false)
      self:aniEnd()
    elseif Logic.Dumpling.DUMPLING_STATE.FINISHED == state then
      self:finishCooking()
    end
  end
end
function prototype:refresh(info)
  self.sprFlag:removeAllChildrenWithCleanup(true)
  self.sprFlag:setVisible(false)
  local state = Logic:Get("Dumpling"):getDumplingState()
  if Logic.Dumpling.DUMPLING_STATE.NONE == state then
    self:clearArt(1)
    self.sprCook:setVisible(true)
    self.sprReward:setVisible(false)
    self.btnChoose:setVisible(true)
  elseif Logic.Dumpling.DUMPLING_STATE.COOKING == state then
    self.sprReward:setVisible(false)
    self.sprCook:setVisible(false)
    self.btnChoose:setVisible(false)
  elseif Logic.Dumpling.DUMPLING_STATE.FINISHED == state then
    self:clearArt(3)
    self.sprCook:setVisible(false)
    self.sprReward:setVisible(true)
    self.btnChoose:setVisible(true)
  end
  if not info then
    return
  end
  if not info.coolTime then
    self.labTime:setString("--:--:--")
    self:setClearState(false)
    self.m_pDuration:setValue(0)
    return
  end
  local coolTime = info.coolTime
  local diffTime = Logic:Get("System"):DiffTime(coolTime / 1000)
  local surplusTime = Logic:Get("System"):SecToDay(diffTime)
  if surplusTime and diffTime > 0 then
    self:setClearState(true)
    local str = string.format("%02d:%02d:%02d", surplusTime.hour or 0, surplusTime.min or 0, surplusTime.sec or 0)
    self.minutes = math.ceil(diffTime / 60)
    self.labTime:setString(str)
    local time = Logic:Get("Dumpling"):getRewardsInfo(info.baseId)
    time = time and time.coolTime * 60 or 1
    local percent = math.floor(diffTime * 100 / time)
    self.m_pDuration:setValue(percent)
  else
    self.labTime:setString("--:--:--")
    self:setClearState(false)
    self.m_pDuration:setValue(0)
  end
end
function prototype:cooking()
  Logic:Get("Dumpling"):setBeginCookingFlag(false)
  self.sprBoilTop:setVisible(false)
  if self.ani1 == nil then
    self.ani1 = Logic:Get("AniMgr"):NewCCB("UI/UIZJ_1", self, ccp(318, 461))
  end
  self.ani1:RunAni(nil, nil, bind(self.aniEnd, self))
end
function prototype:aniEnd()
  if self.ani2 == nil then
    self.ani2 = Logic:Get("AniMgr"):NewCCB("UI/UIZJ_2", self, ccp(318, 461))
  end
  if self.ani1 ~= nil then
    self.ani1:RemoveAnimation()
    self.ani1 = nil
  end
end
function prototype:finishCooking()
  self.sprBoilTop:setVisible(false)
  if self.ani1 ~= nil then
    self.ani1:RemoveAnimation()
    self.ani1 = nil
  end
  if self.ani2 ~= nil then
    self.ani2:RemoveAnimation()
    self.ani2 = nil
  end
  if self.ani3 == nil then
    self.ani3 = Logic:Get("AniMgr"):NewCCB("UI/UIZJ_3", self, ccp(318, 468))
  end
  self.ani3:RunAni(nil, nil, bind(self.clearArt, self))
  self.sprFlag:removeAllChildrenWithCleanup(true)
  Logic:Get("AniMgr"):RunCCBAni("UI/uinew", self.sprFlag, nil, 1, nil, nil, nil, -1)
  self.sprFlag:setVisible(true)
end
function prototype:clearArt(num)
  if num == nil then
    self.sprBoilTop:setVisible(true)
  end
  num = num or 0
  if self.ani1 ~= nil and num ~= 1 then
    self.sprBoilTop:setVisible(true)
    self.ani1:RemoveAnimation()
    self.ani1 = nil
  end
  if self.ani2 ~= nil and num ~= 3 then
    self.sprBoilTop:setVisible(true)
    self.ani2:RemoveAnimation()
    self.ani2 = nil
  end
  if self.ani3 ~= nil and num ~= 3 then
    self.sprBoilTop:setVisible(true)
    self.ani3:RemoveAnimation()
    self.ani3 = nil
  end
end
function prototype:refreshCookDumplingTime()
  local info = Logic:Get("Dumpling"):getCookingDumpling()
  if not info or table.empty(info) or not info.coolTime then
    self:setClearState(false)
    self.sprCook:setVisible(true)
    self.btnChoose:setVisible(true)
    self.sprReward:setVisible(false)
    return
  end
  local coolTime = info.coolTime
  local diffTime = Logic:Get("System"):DiffTime(coolTime / 1000)
  local surplusTime = Logic:Get("System"):SecToDay(diffTime)
  if surplusTime and diffTime > 0 then
    self:setClearState(true)
    self.btnChoose:setVisible(false)
    local str = string.format("%02d:%02d:%02d", surplusTime.hour or 0, surplusTime.min or 0, surplusTime.sec or 0)
    self.minutes = math.ceil(diffTime / 60)
    self.labTime:setString(str)
    local time = Logic:Get("Dumpling"):getRewardsInfo(info.baseId)
    time = time and time.coolTime and time.coolTime * 60 or 21600
    local percent = math.floor(diffTime * 100 / time)
    self.m_pDuration:setValue(percent)
  else
    self.labTime:setString("--:--:--")
    self:setClearState(false)
    self.sprCook:setVisible(false)
    self.btnChoose:setVisible(true)
    self.sprReward:setVisible(true)
    self.m_pDuration:setValue(0)
  end
end
function prototype:onReturnBtnClicked(sender, event)
  SceneHelper:runWithScene("GiftActivityList", self.rootNode)
end
function prototype:onFinishBtnClicked(sender, event)
  local rec = KFDBGetRecord("ConfigValue", "DUMPLING:COOLTIME_COST_COUNT")
  local unitprice = rec and tonumber(rec.content) or 0
  local wallet = Logic:Get("PlayerInfo"):GetPlayerMoney()
  local xianyu = wallet.gift + wallet.inter + wallet.gold
  if xianyu < self.minutes * unitprice then
    Logic:Get("SureConfirm").btnText.ok = TwGetStr(104003)
    Prompt:Confirm(Logic:Get("Main"), "", 105316, Logic:Get("Main").GotoRecharge, Prompt.PROMPT_TYPE.SELECT)
    return
  end
  Prompt:ConfirmRecord(self, "", TwGetStr(111011, math.ceil(self.minutes * unitprice)), self.clearCoolTime, Prompt.PROMPT_TYPE.SELECT, nil, Logic.SureConfirm.RECORD_TYPE.DUMPLING_CLEAR_COOLTIME)
end
function prototype:clearCoolTime()
  Logic:Get("Dumpling"):PostClearCoolTime()
end
function prototype:onChooseBtnClicked(sender, event)
  local state = Logic:Get("Dumpling"):getDumplingState()
  if Logic.Dumpling.DUMPLING_STATE.NONE == state then
    SceneHelper:runWithScene("DumplingSelect", self.rootNode)
  elseif Logic.Dumpling.DUMPLING_STATE.FINISHED == state then
    Logic:Get("Dumpling"):PostGetCookReward()
  end
end
function prototype:onStoreBtnClicked(sender, event)
  MsgPlayer:Post("GET_LOTTERY_LIST")
end
function prototype:setClearState(flag)
  self.sprDuration:setVisible(flag)
  self.labTime:setVisible(flag)
  self.sprFinish:setVisible(flag)
  self.btnFinish:setVisible(flag)
  self.m_pDuration:setVisible(flag)
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
