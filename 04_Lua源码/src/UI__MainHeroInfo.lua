module((...), package.seeall)
require("Logic.PlayerInfo")
prototype = Tw.Controller.prototype:extend()
local DOWNLOAD_PRO_BG = "images/public/exp_bg.png"
local DOWNLOAD_PRO_FRONT1 = "images/public/exp_mid.png"
local DOWNLOAD_PRO_FRONT2 = "images/public/exp_pro.png"
local INIT_NEEDTIM = 5
local SEC_SCALE = 1000
function prototype:onEnter()
  Logic:Get("Guide"):On(Logic.Guide.EVT.STEP, self:Event("updataGuide"))
  if not self:EventTracer():Exist("RefrashDatat") then
    Logic:Get("PlayerInfo"):On(Logic.PlayerInfo.EVT.DATA_CHANGE, self:Event("RefrashDatat"))
  end
  self.waiting = false
  self.waitNeed = INIT_NEEDTIM
  self.laseRefrashTime = 0
  local time = KFDBGetRecord("ConfigValue", "POINT:SINGLE_INCREASE_INTERVAL")
  if time and time.content then
    self.waitNeed = tonumber(time.content) * 60
  end
  local add = KFDBGetRecord("ConfigValue", "POINT:SINGLE_INCREASE_COUNT")
  self.addPhysical = tonumber(add.content)
  self.scheduler = CCDirector:sharedDirector():getScheduler()
  self.m_pCProExp:createProgress(DOWNLOAD_PRO_BG, DOWNLOAD_PRO_FRONT1)
  self.m_pCProPhysical:createProgress(DOWNLOAD_PRO_BG, DOWNLOAD_PRO_FRONT2)
  self.labMoney:create()
  self.labJode:create(0, "GREEN_NUM")
  self.labLevel:create()
  self.labPhysical:create(0, "GREEN_NUM")
  self:RefrashDatat()
  self:RewardTip()
  Logic:Get("Gift"):On(Logic.Gift.EVT.REFRESH_GIFT, self:Event("RewardTip"))
  Logic:Get("PlayerInfo"):On(Logic.PlayerInfo.EVT.CHANK_VIP, self:Event("OnGetVip"))
  Logic:Get("Pvp"):On(Logic.Pvp.EVT.GET_PVP_INFO, self:Event("onGetPvpInfo"))
  self:updataGuide()
end
function prototype:OnGetVip()
  local monbVip = Logic:Get("PlayerInfo"):hasMonthVipFunc()
  local strMon = "images/Main/mon_hui.png"
  if monbVip then
    strMon = "images/Main/mon_nor.png"
  end
  local sprMonVip = CCSprite:create(strMon)
  self.imgHeroVip:setDisplayFrame(sprMonVip:displayFrame())
  local weekbVip = Logic:Get("PlayerInfo"):IsWeekVip()
  local strWeek = "images/Main/week_hui.png"
  if weekbVip then
    strWeek = "images/Main/week_nor.png"
  end
  local sprWeekVip = CCSprite:create(strWeek)
  self.imgVipWeek:setDisplayFrame(sprWeekVip:displayFrame())
end
function prototype:onRoleInfoButtonClicked(sender, event)
  if event == CCControlEventTouchDown then
    SceneHelper:removePrompt(nil, "PlayerInfoPrompt")
    SceneHelper:pushPrompt("PlayerInfoPrompt")
    return
  end
  if event == CCControlEventTouchDragInside then
    return
  end
  SceneHelper:removePrompt(nil, "PlayerInfoPrompt")
end
function prototype:RefrashDatat()
  self.playerInfo = Logic:Get("PlayerInfo"):GetPlayerAllInfo()
  self:setPlayerInfo()
  if Logic:Get("PhoneFee"):CanShowChargeFee() then
    SceneHelper:pushPrompt("GiveCallFee", self.rootNode)
  end
  Logic:Get("PhoneFee"):SetCharge(false)
end
function prototype:setPlayerInfo()
  if self.playerInfo == nil or next(self.playerInfo) == nil then
    return
  end
  self.staPlayerName:setStyle(kCCLabelTTFStyleOutline)
  self.staPlayerPhysicalWaitTime:setStyle(kCCLabelTTFStyleOutline)
  self.staPlayerName:setString(self.playerInfo.name or "")
  self.labLevel:setValue(self.playerInfo.level or 0)
  self.physical = Logic:Get("PlayerInfo"):GetPlayerPhysical()
  self.labPhysical:setValue(TwGetStr(102002, self.physical.point or 0, Logic.PlayerInfo.PLAYER_MAX_PHYSICAL))
  local titleLogo = Logic:Get("Friend"):GetTitleByFightLogo(self.playerInfo.pvpDesId)
  self.titleImg:setDisplayFrame(titleLogo:displayFrame())
  if self.physical.point and self.physical.point < Logic.PlayerInfo.PLAYER_MAX_PHYSICAL then
    local timeChange = false
    if self.laseRefrashTime and self.laseRefrashTime ~= 0 then
      if self.laseRefrashTime ~= self.physical.refreshTime then
        self.laseRefrashTime = self.physical.refreshTime
        timeChange = true
      end
    else
      self.laseRefrashTime = self.physical.refreshTime
      timeChange = true
    end
    if timeChange then
      local wait = Logic:Get("System"):DiffTime(self.physical.refreshTime / SEC_SCALE)
      if wait < 0 then
        self.loseTim = Logic:Get("System"):GetTime() + self.waitNeed - math.abs(wait) % self.waitNeed
      else
        self.loseTim = Logic:Get("System"):GetTime() + wait or Logic:Get("System"):GetTime() + self.waitNeed
      end
    end
    if not self.waiting then
      self.waiting = true
      Singleton(Timer):Repeat(SEC_SCALE, self:Event("showPhyWaitTime"))
    end
  else
    self.waiting = false
    self:EventTracer():Cancel("showPhyWaitTime")
  end
  self.staPlayerPhysicalWaitTime:setVisible(self.waiting)
  self.imgWaitTip:setVisible(self.waiting)
  local wallet = Logic:Get("PlayerInfo"):GetPlayerMoney()
  local jade = Logic:Get("PlayerInfo"):GetPlayerAllJade()
  if wallet and not table.empty(wallet) then
    self.labMoney:setValue(wallet.copper or 0)
    self.labJode:setValue(jade or 0)
  end
  local logic = Logic:Get("PlayerInfo")
  if logic:GetUpgradeNeedByLevel(logic:GetPlayerLevel()) and 0 < logic:GetUpgradeNeedByLevel(logic:GetPlayerLevel()) and self.playerInfo.exp then
    self.m_pCProExp:setValue(100 * self.playerInfo.exp / logic:GetUpgradeNeedByLevel(logic:GetPlayerLevel()))
  end
  if self.physical.point and Logic.PlayerInfo.PLAYER_MAX_PHYSICAL and 0 < Logic.PlayerInfo.PLAYER_MAX_PHYSICAL then
    self.m_pCProPhysical:setValue(100 * self.physical.point / Logic.PlayerInfo.PLAYER_MAX_PHYSICAL)
  end
  local monbVip = Logic:Get("PlayerInfo"):hasMonthVipFunc()
  local strMon = "images/Main/mon_hui.png"
  if monbVip then
    strMon = "images/Main/mon_nor.png"
  end
  local sprMonVip = CCSprite:create(strMon)
  self.imgHeroVip:setDisplayFrame(sprMonVip:displayFrame())
  local weekbVip = Logic:Get("PlayerInfo"):IsWeekVip()
  local strWeek = "images/Main/week_hui.png"
  if weekbVip then
    strWeek = "images/Main/week_nor.png"
  end
  local sprWeekVip = CCSprite:create(strWeek)
  self.imgVipWeek:setDisplayFrame(sprWeekVip:displayFrame())
end
function prototype:showPhyWaitTime()
  local lose = Logic:Get("System"):DiffTime(self.loseTim)
  if lose <= 0 then
    self:EventTracer():Cancel("showPhyWaitTime")
    self.waiting = false
    local number = math.floor(math.abs(lose) / self.waitNeed)
    local has = math.floor(math.abs(lose) % self.waitNeed)
    self.physical.refreshTime = (Logic:Get("System"):GetTime() + self.waitNeed) * SEC_SCALE - has
    Logic:Get("PlayerInfo"):PlayerPhysical(self.addPhysical + number * self.addPhysical, Logic.PlayerInfo.PLAYER_DATA_CHANGE.ADD)
  end
  local waitTime = Logic:Get("System"):SecToDay(math.abs(lose % self.waitNeed))
  self.staPlayerPhysicalWaitTime:setString(TwGetStr(102003, waitTime.min or 0, waitTime.sec or 0))
end
function prototype:showRewardTip()
  local ccSprite = CCSprite:create("images/public/clarity80.png")
  self.layer:addChild(ccSprite, 0, 10)
  local x = self.btnReward:getPositionX() + 30
  local y = self.btnReward:getPositionY() + 24
  self.rewardSpr:setVisible(true)
  self.ani = Logic:Get("AniMgr"):RunCCBAni("UI/uinew", self, ccp(x, y), 0.7)
  local ccSprite = CCSprite:create("images/public/tip.png")
  self.rootNode:addChild(ccSprite, 0, 11)
  ccSprite:setAnchorPoint(CCPoint(0.5, 0.5))
  ccSprite:setPosition(ccp(x, y))
  ccSprite:setScale(0.8)
end
function prototype:RewardTip()
  local boolean = Logic:Get("Gift"):IsGiftDraw()
  if boolean then
    local tip = self.layer:getChildByTag(10)
    local playerLevel = Logic:Get("PlayerInfo"):GetPlayerLevel()
    if tip == nil and playerLevel > 10 then
      self:showRewardTip()
    end
  else
    if self.ani ~= nil then
      self.ani:RemoveAnimation()
    end
    self.rootNode:removeChildByTag(11, true)
    self.layer:removeChildByTag(10, true)
    self.rewardSpr:setVisible(true)
  end
end
function prototype:onBtnRewards(sender, event)
  Logic:Get("Guide"):done("DrawGift", "Start")
  Logic:Get("Guide"):done("EvolutionPrepare", "Start")
  Logic:Get("Guide"):done("FightDrawGiftLevelUp", "Start")
  SceneHelper:runWithScene("Gift", self.rootNode)
  Logic:Get("PlayerInfo"):FireEvent(Logic.PlayerInfo.EVT.CHECK_MAINBTN_STATE, false)
end
function prototype:updataGuide()
  Logic:Get("Guide"):lockTouch("DrawGift", "Start", self.btnReward)
  Logic:Get("Guide"):lockTouch("EvolutionPrepare", "Start", self.btnReward)
  Logic:Get("Guide"):lockTouch("FightDrawGiftLevelUp", "Start", self.btnReward)
end
function prototype:onGetPvpInfo()
  local player = Logic:Get("Pvp"):GetPlayer()
  local rec = Logic:Get("Pvp"):GetRecordByDesId(player.desId)
  if rec and rec.logoPath ~= "" then
    local spr = CCSprite:create(rec.logoPath)
    if spr then
      self.titleImg:setDisplayFrame(spr:displayFrame())
    end
  end
end
