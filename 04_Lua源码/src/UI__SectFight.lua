module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
local CHAT_SPEED = 100
function prototype:initialize(...)
  super.initialize(self, ...)
  self.winRankInfoOld = {}
  self.ownTeam = {}
  self.targetTeam = {}
  self.isJoin = false
  self.ownMenpaiName = ""
  self.targetMenpaiName = ""
  self.nextTime = 0
  self.ownerCount = 0
  self.targetCount = 0
  self.btnTime = 0
end
function prototype:onEnter()
  self.ttfOwnName:setStyle(kCCLabelTTFStyleOutline)
  self.ttfEnemyName:setStyle(kCCLabelTTFStyleOutline)
  self.ttfOwnJoinCount:setStyle(kCCLabelTTFStyleOutline)
  self.ttfJoinCount:setStyle(kCCLabelTTFStyleOutline)
  Logic:Get("Sect"):On(Logic.Sect.EVT.FIGHT_CHAT, self:Event("OnFightChat"))
  Logic:Get("Sect"):On(Logic.Sect.EVT.START_BATTLE, self:Event("OnStartBattleShow"))
  Logic:Get("Sect"):On(Logic.Sect.EVT.COUNTRY_FIGHT_QUIT, self:Event("OnQuitFight"))
  Logic:Get("Sect"):On(Logic.Sect.EVT.CLOSE_FIGHT, self:Event("OnClose"))
  Logic:Get("Sect"):On(Logic.Sect.EVT.REFRESH_FIGHT_LIST, self:Event("OnRefresh"))
  Logic:Get("Sect"):On(Logic.Sect.EVT.REFRESH_JOINT_COUNT, self:Event("OnRefreshJoinCount"))
  self.countryFigthInfo = Logic:Get("Sect"):GetCountryFightJoinedInfo() or {}
  self:onTimer()
  if not self.eventTracer:Exist("onTimer") then
    Singleton(Timer):Repeat(1000, self:Event("onTimer"))
  end
  if table.empty(self.countryFigthInfo) then
    return
  end
  Logic:Get("Sect"):setEnterBattle(true)
  if not self.countryFigthInfo.joined then
    self.nodeExit:setVisible(true)
    self.nodeBtn:setVisible(false)
  end
  self:getTeamList()
  Logic:Get("MenpaiBattle"):enter(self.MenpaiBattle, self.sprBg)
  self:OnRefresh()
end
function prototype:onExit(...)
  Logic:Get("MenpaiBattle"):exit()
  Logic:Get("Sect"):setEnterBattle(false)
  Logic:Get("Sect"):initChat()
  if SceneHelper:isExistPrompt("SectWord") then
    SceneHelper:removePrompt(nil, "SectWord")
  end
  if SceneHelper:isExistPrompt("SectFightMember") then
    SceneHelper:removePrompt(nil, "SectFightMember")
  end
end
function prototype:OnClose()
  self.btnClose:setEnabled(true)
end
function prototype:getTeamList()
  if not self.eventTracer:Exist("onTeamTimer") then
    Singleton(Timer):Repeat(10000, self:Event("onTeamTimer"))
  end
  self.nextTime = Logic:Get("System"):GetTime()
end
function prototype:onTeamTimer()
  if SceneHelper:isExistPrompt("SureConfirm") then
    return
  end
  if SceneHelper:isExistPrompt("SectWord") then
    return
  end
  local joinFightDate = Logic:Get("Sect"):GetJoinFightDate()
  if joinFightDate == nil then
    return
  end
  local diffTime = Logic:Get("System"):DiffTime(joinFightDate[2] / 1000)
  if diffTime <= 60 then
    return
  end
  local curTime = Logic:Get("System"):GetTime()
  if 60 < curTime - self.nextTime then
    Logic:Get("Sect"):PostCountryFightJoined(false, self.countryFigthInfo.country)
    self.nextTime = curTime
  end
end
function prototype:OnRefresh()
  self.countryFigthInfo = Logic:Get("Sect"):GetCountryFightJoinedInfo() or {}
  if table.empty(self.countryFigthInfo) then
    return
  end
  if Logic:Get("MenpaiBattle"):isBattleIn() then
    return
  end
  self.isJoin = self.joined
  self.ownTeam = self.countryFigthInfo.ownTeam
  self.targetTeam = self.countryFigthInfo.targetTeam
  self.targetTeam = self.countryFigthInfo.targetTeam
  self.ownMenpaiName = self.countryFigthInfo.ownMenpaiName
  self.targetMenpaiName = self.countryFigthInfo.targetMenpaiName
  self:waittineBattle()
  self:setStr()
  self.btnClose:setEnabled(false)
end
function prototype:waittineBattle()
  Logic:Get("MenpaiBattle"):refresh(self.ownTeam, self.targetTeam)
end
function prototype:OnStartBattleShow()
  self.countryFigthInfo = Logic:Get("Sect"):GetCountryFightJoinedInfo() or {}
  local report = Logic:Get("Sect"):getCountryFightResult() or {}
  if table.empty(self.countryFigthInfo) then
    return
  end
  if table.empty(report) then
    return
  end
  self.ownTeam = self.countryFigthInfo.ownTeam
  self.targetTeam = self.countryFigthInfo.targetTeam
  self.ownMenpaiName = self.countryFigthInfo.ownMenpaiName
  self.targetMenpaiName = self.countryFigthInfo.targetMenpaiName
  report.winMenpaiId = report.winMenpaiId == self.countryFigthInfo.ownMenpaiId and "owner" or "target"
  self.report = report
  self.nodeOne:setVisible(false)
  self.nodeBtn:setVisible(false)
  self.nodeExit:setVisible(true)
  self:setStr()
  self:startBattle()
  self:removeOpenScene()
end
function prototype:startBattle()
  Logic:Get("MenpaiBattle"):start(self.ownTeam, self.targetTeam, self.report)
end
function prototype:OnFightChat()
  local chat = Logic:Get("Sect"):getChat()
  if chat then
    self:fightChat(chat)
  end
end
function prototype:OnRefreshJoinCount(flage)
  if flage == "owner" then
    self.ownerCount = self.ownerCount - 1
    self.ttfOwnJoinCount:setString(self.ownerCount)
  end
  if flage == "target" then
    self.targetCount = self.targetCount - 1
    self.ttfJoinCount:setString(self.targetCount)
  end
end
function prototype:setStr()
  if table.empty(self.ownTeam or {}) then
    self.ttfOwnJoinCount:setString(0)
  else
    self.ownerCount = #self.ownTeam
    self.ttfOwnJoinCount:setString(self.ownerCount)
  end
  if table.empty(self.targetTeam or {}) then
    self.ttfJoinCount:setString(0)
  else
    self.targetCount = #self.targetTeam
    self.ttfJoinCount:setString(self.targetCount)
  end
  if self.targetMenpaiName == nil or self.targetMenpaiName == "" then
    self.ttfEnemyName:setString("--")
    self.ttfOwnName:setString(self.ownMenpaiName)
    return
  end
  if self.ownMenpaiName == nil or self.ownMenpaiName == "" then
    self.ttfEnemyName:setString(self.targetMenpaiName)
    self.ttfOwnName:setString("")
    return
  end
  self.ttfOwnName:setString(self.ownMenpaiName)
  self.ttfEnemyName:setString(self.targetMenpaiName)
end
function prototype:OnBtnSectMember(sender, event)
  if SceneHelper:isExistPrompt("SectWord") then
    SceneHelper:removePrompt(nil, "SectWord")
  end
  if not SceneHelper:isExistPrompt("SectFightMember") then
    SceneHelper:pushPrompt("SectFightMember", self.rootNode)
  end
end
function prototype:onQuit()
  MsgMenpai:Post("QUIT_COUNTRY_FIGHT")
end
function prototype:onBtnQuit(sender, event)
  Prompt:Confirm(self, "", TwGetStr(108140), self.onQuit, Prompt.PROMPT_TYPE.SELECT)
end
function prototype:onBtnChat(sender, event)
  Logic:Get("Sect"):setEnterWord(true)
  if SceneHelper:isExistPrompt("SectFightMember") then
    SceneHelper:removePrompt(nil, "SectFightMember")
  end
  if not SceneHelper:isExistPrompt("SectWord") then
    SceneHelper:pushPrompt("SectWord", self.rootNode)
  end
end
function prototype:onBtnMinimality(sender, event)
  Prompt:ConfirmRecord(self, "", TwGetStr(108148), self.removeSectFight, Prompt.PROMPT_TYPE.SELECT, nil, Logic.SureConfirm.RECORD_TYPE.CLOSE_SECT_FIGHT)
end
function prototype:onBtnClose()
  SceneHelper:removeScene("SectFight", self.rootNode)
  SceneHelper:pushScene("SectFightMain", self.rootNode)
end
function prototype:onBtnStart(sender, event)
  local sysTime = Logic:Get("System"):GetTime()
  if sysTime - self.btnTime > 1 then
    self:getReprot()
    self.btnTime = sysTime
  end
end
function prototype:getReprot()
  if self.eventTracer:Exist("onTeamTimer") then
    self:EventTracer():Cancel("onTeamTimer")
  end
  if self.countryFigthInfo and self.countryFigthInfo.country then
    Logic:Get("Sect"):setCountryIdOfReprot(self.countryFigthInfo.country)
    Logic:Get("Sect"):PostCountryFightResult()
  end
end
function prototype:onTimer()
  local joinFightDate = Logic:Get("Sect"):GetJoinFightDate()
  if joinFightDate == nil then
    return
  end
  local diffTime = Logic:Get("System"):DiffTime(joinFightDate[2] / 1000)
  local starTime = Logic:Get("System"):SecToDay(diffTime)
  if starTime and diffTime > 0 then
    local str = string.format("%02d:%02d", starTime.min or 0, starTime.sec or 0)
    self.nodeTime:setVisible(true)
    self.labTimeMin:create(0, "YELLOW_E_NUM")
    self.labTimeMin:setValue(TwGetStr(108131, starTime.min or 0))
    self.labTimeSec:create(0, "YELLOW_E_NUM")
    self.labTimeSec:setValue(TwGetStr(108131, starTime.sec or 0))
  else
    self.nodeTime:setVisible(false)
    if self:EventTracer():Exist("onTimer") then
      self:EventTracer():Cancel("onTimer")
      if not self.eventTracer:Exist("autoGetReport") then
        Singleton(Timer):After(2000, self:Event("autoGetReport"))
      end
    end
  end
end
function prototype:autoGetReport()
  self:getReprot()
  Logic:Get("Sect"):setBSuccess(false)
  if not self.eventTracer:Exist("onStart") then
    Singleton(Timer):After(5000, self:Event("onStart"))
  end
end
function prototype:onStart()
  if not Logic:Get("Sect"):getBSuccess() then
    self.nodeOne:setVisible(true)
  end
end
function prototype:fightChat(winInfo)
  local menpaiName = ""
  local name = ""
  if winInfo.camp == "owner" then
    menpaiName = self.ownMenpaiName
    for k, v in pairs(self.ownTeam) do
      if v.playerId == winInfo.playerId then
        name = v.name
        break
      end
    end
  else
    menpaiName = self.targetMenpaiName
    for k, v in pairs(self.targetTeam) do
      if v.playerId == winInfo.playerId then
        name = v.name
        break
      end
    end
  end
  local str = TwGetStr(108129, menpaiName, name, winInfo.count)
  self.staChat:setString(str)
  local sz = self.staChat:getContentSize()
  local pt = ccp(120, 300)
  local time = sz.width / CHAT_SPEED
  local action = {}
  local actionMoveTo = CCMoveTo:create(time, pt)
  table.insert(action, CCMoveTo:create(0, ccp(640, 300)))
  table.insert(action, actionMoveTo)
  table.insert(action, CCDelayTime:create(0.5))
  table.insert(action, CCMoveTo:create(0, ccp(640, 300)))
  table.insert(action, function()
    self:getNextChat()
  end)
  self.staChat:runAction(Logic:Get("AniMgr"):CreateSequence(action))
end
function prototype:getNextChat()
  Logic:Get("Sect"):removeChat()
  local chat = Logic:Get("Sect"):getChat()
  if chat then
    self:fightChat(chat)
  end
end
function prototype:winList(winRankInfo)
  local count = #self.winRankInfoOld or 0
  if winRankInfo == nil then
    return
  end
  self.winRank:setVisible(true)
  table.insert(self.winRankInfoOld, winRankInfo)
  if count == 3 then
    table.remove(self.winRankInfoOld, 1)
  end
  for i, v in ipairs(self.winRankInfoOld) do
    local nodeWin = string.format("winRank%d", i)
    local ttfWinName = string.format("winerName%d", i)
    local nodeWinCount = string.format("winCount%d", i)
    if self[nodeWin] then
      self[nodeWin]:setVisible(true)
    end
    if self[ttfWinName] then
      self[ttfWinName]:setString(tostring(v.name))
    end
    if self[nodeWinCount] then
      self[nodeWinCount]:setString(TwGetStr(108125, v.count))
    end
  end
end
function prototype:OnQuitFight()
  SceneHelper:removeScene("SectFight")
end
function prototype:removeOpenScene()
  if SceneHelper:isExistPrompt("SectWord") then
    SceneHelper:removePrompt(nil, "SectWord")
  end
  if SceneHelper:isExistPrompt("SectFightMember") then
    SceneHelper:removePrompt(nil, "SectFightMember")
  end
end
function prototype:removeSectFight()
  SceneHelper:removeScene("SectFight", self.rootNode)
  SceneHelper:pushScene("SectFightMain", self.rootNode)
end
