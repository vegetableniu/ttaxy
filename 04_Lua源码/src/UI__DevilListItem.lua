module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
function prototype:initialize(...)
  super.initialize(self, ...)
  self.data = {}
  self.leftTimePos = {}
end
function prototype:dispose(...)
  super.dispose(self)
end
function prototype:onEnter()
end
function prototype:onNodeLoaded(node, loader)
  self.leftTimePos.x = self.ttfLeftTime:getPositionX()
  self.leftTimePos.y = self.ttfLeftTime:getPositionY()
end
function prototype:Refrash(data)
  if data == nil then
    return
  end
  self.data = data
  if self.data.baseId then
    local iconPath = Logic:Get("Hero"):GetHeroImage(self.data.baseId)
    if iconPath then
      local spriteIcon = CCSprite:create(iconPath)
      if spriteIcon then
        self.sprHeroIcon:setDisplayFrame(spriteIcon:displayFrame())
      end
    end
    local strBg, strStar = Logic:Get("Hero"):GetHeroBgImage(self.data.baseId)
    if strBg then
      local spriteBg = CCSprite:create(strBg)
      if spriteBg then
        self.sprHeroBg:setDisplayFrame(spriteBg:displayFrame())
      end
    end
    Logic:Get("HeroCardInfo"):AddShanCardSmall(self.sprHeroIcon, self.data.baseId)
  end
  self.ttfDevilName:setString(self.data.name or "")
  self.ttfName:setString(data.summonerName or "")
  self.ttfLeftTime:setPosition(ccp(self.leftTimePos.x, self.leftTimePos.y))
  if self.data.attacked ~= nil then
    self.sprBeAtt:setVisible(false)
  end
  local currTime = Logic:Get("System"):GetTime()
  self.diffTime = Logic:Get("System"):DiffTime(data.loseTime or currTime)
  if self.diffTime > 0 then
    self.sprFight:setVisible(true)
    self.sprReward:setVisible(false)
    self.sprWin:setVisible(false)
    if data.waitTime then
      local str = ""
      if data.waitTime.hour and 0 < data.waitTime.hour then
        str = str .. TwGetStr(100045, data.waitTime.hour)
      end
      if data.waitTime.min and 0 < data.waitTime.min then
        str = str .. TwGetStr(100046, data.waitTime.min)
      end
      str = str .. TwGetStr(105507, data.waitTime.sec or 0)
      self.ttfLeftTime:setString(str)
    end
  else
    self.sprFight:setVisible(false)
    self.sprBeAtt:setVisible(false)
    if data.killed then
      self.sprReward:setVisible(true)
      self.sprWin:setVisible(true)
      self.ttfLeftTime:setString(TwGetStr(105597))
    else
      self.sprReward:setVisible(false)
      self.sprWin:setVisible(false)
      local x = self.sprFight:getPositionX() + 70
      local y = self.sprFight:getPositionY() - 15
      self.ttfLeftTime:setPosition(ccp(x, y))
      self.ttfLeftTime:setString(TwGetStr(105523))
    end
  end
  if data.level and 0 <= data.level then
    self.nodeLv:create(0, "YELLOW_E_NUM")
    self.nodeLv:setAlign("LEFT", "CENTER")
    self.nodeLv:setValue(data.level)
  end
  self.nodeLife:create(0, "YELLOW_E_NUM")
  self.nodeLife:setAlign("LEFT", "CENTER")
  if data.currentHp and 0 <= data.currentHp then
    self.nodeLife:setValue(data.currentHp)
  end
end
function prototype:onBtnBgClicked(sender, event)
  if self.data.killed then
    local str = ""
    if self.data.killFeat and self.data.killFeat > 0 then
      str = str .. TwGetStr(105560, self.data.killFeat) .. "\n"
    end
    if self.data.maxDamageRewards and not table.empty(self.data.maxDamageRewards) then
      str = str .. TwGetStr(105561) .. Logic:Get("Reward"):RewardTreaTip(self.data.maxDamageRewards[1]) .. "\n"
    end
    if self.data.summonRewards and not table.empty(self.data.summonRewards) then
      str = str .. TwGetStr(105562) .. Logic:Get("Reward"):RewardTreaTip(self.data.summonRewards[1]) .. "\n"
    end
    local lastAttDrawNum = Logic:Get("Devil"):GetLastAttackDrawNum() or 0
    local rec = KFDBGetRecord("ConfigValue", "DEMOG:LAST_ATTACK_REWARD_NUM")
    local maxDrawNum = rec and tonumber(rec.content) or 0
    if maxDrawNum > 0 then
      if lastAttDrawNum < maxDrawNum then
        if self.data.lastAttackRewards and not table.empty(self.data.lastAttackRewards) then
          str = str .. TwGetStr(105586) .. Logic:Get("Reward"):RewardTreaTip(self.data.lastAttackRewards[1]) .. "\n"
        end
      else
        str = str .. TwGetStr(105587) .. "\n"
      end
    end
    Logic:Get("SureConfirm").btnText.ok = TwGetStr(105564)
    Prompt:Confirm(self, 105563, str, self.OnGetReward)
    return
  end
  if 0 < self.diffTime then
    Logic:Get("Devil"):setEnterType(Logic.Devil.ENTER_TYPE.DEVIL_LIST)
    Logic:Get("Devil"):setDavilData(self.data)
    SceneHelper:pushScene("DevilInfo", self.rootNode)
  end
end
function prototype:onBtnIconClicked(sender, event)
  Logic:Get("HeroCardInfo"):OpenHeroInfoById(self.data.baseId)
end
function prototype:OnGetReward()
  Logic:Get("Devil"):PostDrawKilledDemogReward(self.data.id)
end
