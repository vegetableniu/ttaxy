module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
require("SceneHelper")
function prototype:Clear()
  local strBgLead = "data/MiddleBg/1.png"
  local frameBgLead = CCSprite:create(strBgLead)
  if frameBgLead then
    self.imgBgLead:setDisplayFrame(frameBgLead:displayFrame())
    Logic:Get("HeroCardInfo"):ClearShanCardSmall(self.imgBgLead)
    for i = 1, 4 do
      local strBgView = string.format("imgBg%d", i)
      self[strBgView]:setDisplayFrame(frameBgLead:displayFrame())
      Logic:Get("HeroCardInfo"):ClearShanCardSmall(self[strBgView])
    end
  end
  local strHeroLead = "images/public/clarity05.png"
  local frameHeroLead = CCSprite:create(strHeroLead)
  if frameHeroLead then
    self.imgHeroLead:setDisplayFrame(frameHeroLead:displayFrame())
    for i = 1, 4 do
      local strHeroView = string.format("imgHero%d", i)
      self[strHeroView]:setDisplayFrame(frameHeroLead:displayFrame())
    end
  end
  self.imgLvTipLead:setVisible(false)
  for i = 1, 4 do
    local strTipView = string.format("imgLvTip%d", i)
    self[strTipView]:setVisible(false)
  end
  self.staCurrent:setString(TwGetStr(104261))
  self.staChoice:setString(TwGetStr(104262))
  for i = 1, 5 do
    local str = string.format("imgAdd%d", i)
    if self[str] then
      self[str]:setVisible(true)
    end
  end
end
function prototype:CurrentGroup(group)
  self.data = {}
  self.data.heros = group
  if group.leaderId then
    local leaderInfo = Logic:Get("Hero"):GetHeroInfoById(group.leaderId)
    if leaderInfo and leaderInfo.baseId then
      local hero = Logic:Get("Hero"):GetHeroInfoByBaseId(leaderInfo.baseId)
      if hero then
        local strBg = Logic:Get("Hero"):GetHeroBgImage(leaderInfo.baseId, Logic.Hero.HEROIMG_SIZE.MIDDLE, true)
        if strBg then
          local frame = CCSprite:create(strBg)
          if frame then
            self.imgBgLead:setDisplayFrame(frame:displayFrame())
            Logic:Get("HeroCardInfo"):AddShanCardSmall(self.imgBgLead, leaderInfo.baseId)
          end
        end
        local strPath = Logic:Get("Hero"):GetHeroImage(leaderInfo.baseId)
        if strPath then
          local frame = CCSprite:create(strPath)
          if frame then
            self.imgHeroLead:setDisplayFrame(frame:displayFrame())
          end
        end
      end
    end
    if leaderInfo and leaderInfo.level then
      self.imgLvTipLead:setVisible(true)
      self.staLevelLead:create()
      self.staLevelLead:setValue(leaderInfo.level)
    end
    self.imgAdd1:setVisible(false)
  end
  local heros = {}
  for i = 1, #group.embattles do
    for j = 1, #group.embattles[i] do
      if group.embattles[i][j] ~= group.leaderId and group.embattles[i][j] ~= ID[-1] and group.embattles[i][j] ~= ID[0] then
        table.insert(heros, group.embattles[i][j])
      end
    end
  end
  local herosInfo = Logic:Get("Hero"):GetHeroInfosByIds(heros)
  for i = 1, 4 do
    local strBgView = string.format("imgBg%d", i)
    local strHeroView = string.format("imgHero%d", i)
    local strTipView = string.format("imgLvTip%d", i)
    local strLevelView = string.format("staLevel%d", i)
    local strAdd = string.format("imgAdd%d", i + 1)
    if herosInfo[i] and herosInfo[i].baseId then
      local strBg = Logic:Get("Hero"):GetHeroBgImage(herosInfo[i].baseId, Logic.Hero.HEROIMG_SIZE.MIDDLE)
      if strBg then
        local frame = CCSprite:create(strBg)
        if frame then
          self[strBgView]:setDisplayFrame(frame:displayFrame())
          Logic:Get("HeroCardInfo"):AddShanCardSmall(self[strBgView], herosInfo[i].baseId)
        end
      end
      local strPath = Logic:Get("Hero"):GetHeroImage(herosInfo[i].baseId)
      if strPath then
        local frame = CCSprite:create(strPath)
        if frame then
          self[strHeroView]:setDisplayFrame(frame:displayFrame())
        end
      end
      self[strTipView]:setVisible(true)
      self[strLevelView]:setVisible(true)
      self[strLevelView]:create()
      self[strLevelView]:setValue(herosInfo[i].level)
      if self[strAdd] then
        self[strAdd]:setVisible(false)
      end
    else
      local strBg = "data/MiddleBg/1.png"
      local frame = CCSprite:create(strBg)
      if frame then
        self[strBgView]:setDisplayFrame(frame:displayFrame())
      end
      local strPath = "images/public/clarity05.png"
      local frame = CCSprite:create(strPath)
      if frame then
        self[strHeroView]:setDisplayFrame(frame:displayFrame())
      end
      self[strTipView]:setVisible(false)
      self[strLevelView]:setVisible(false)
    end
  end
  self.fourthStatus = Logic:Get("Lock"):GetStatusByLockId(Logic.Lock.LOCK_ID.FOURTH_HERO)
  if self.fourthStatus then
    local strLock = "images/Main/heroLock.png"
    local frame = CCSprite:create(strLock)
    if frame then
      self.imgHero3:setDisplayFrame(frame:displayFrame())
    end
    self.imgAdd4:setVisible(false)
  end
  self.fifthStatus = Logic:Get("Lock"):GetStatusByLockId(Logic.Lock.LOCK_ID.FIFTH_HERO)
  if self.fifthStatus then
    local strLock = "images/Main/heroLock.png"
    local frame = CCSprite:create(strLock)
    if frame then
      self.imgHero4:setDisplayFrame(frame:displayFrame())
    end
    self.imgAdd5:setVisible(false)
  end
end
function prototype:onBtnLeader(sender, event)
  if event == CCControlEventTouchUpInside then
    Logic:Get("Devil"):SetChangeType(Logic.Hero.EVT.LEADER_CHANGE)
    Logic:Get("Devil"):SetChangeGroup(self.data)
    SceneHelper:pushScene("DevilTeamerSelect", self.rootNode)
  end
end
function prototype:onBtnTeamer(sender, event)
  if sender == self.btnHero4 and self.fourthStatus then
    if event == CCControlEventTouchDown then
      Logic:Get("Lock"):showLockTip(Logic.Lock.LOCK_ID.FOURTH_HERO)
    end
    Logic:Get("Lock"):closeLockTip(event)
    return
  end
  if sender == self.btnHero5 and self.fifthStatus then
    if event == CCControlEventTouchDown then
      local level, copyName = Logic:Get("Lock"):GetOpenLevelAndBattle(Logic.Lock.LOCK_ID.FIFTH_HERO)
      local str = TwGetStr(105403, level) .. "\n" .. TwGetStr(105404)
      Prompt:PopTip(str)
    end
    Logic:Get("Lock"):closeLockTip(event)
    return
  end
  if event == CCControlEventTouchUpInside then
    if self.data.heros.leaderId == ID[-1] then
      Logic:Get("Devil"):SetChangeType(Logic.Hero.EVT.LEADER_CHANGE)
    else
      Logic:Get("Devil"):SetChangeType(Logic.Hero.EVT.HERO_CURRENT)
    end
    Logic:Get("Devil"):SetChangeGroup(self.data)
    SceneHelper:pushScene("DevilTeamerSelect", self.rootNode)
  end
end
