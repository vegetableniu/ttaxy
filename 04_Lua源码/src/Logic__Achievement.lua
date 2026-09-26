require("Logic")
module((...), package.seeall)
class = Logic.class:subclass()
EVT = {
  GET_CHAPTER = 1,
  DRAW_CHANGE = 2,
  NEW_ACHIEVE = 3
}
local BITS = 2
local TYPENUM = 3
local ACHIEVE_MAX = 16
local ID_SET = 100
DRAW_TYPE = {
  NOT_FOUND = 0,
  STARTED = 1,
  CAN_DRAW = 2,
  COMPLETED = 3
}
PROMPT_STR = {
  TwGetStr(102124),
  TwGetStr(102123),
  "",
  TwGetStr(102125)
}
local MSG_RESULT = Enum(TypeDef("com.eyu.mt.module.emblem.facade.EmblemResult"))
local MSG_RESULT_STR = {
  ACHIEVE_CANNOT_DRAW = 102150,
  ACHIEVE_NOT_EXIST = 102151,
  CHAPTER_NOT_EXIST = 102152,
  SPACE_NOT_ENOUGH = 102153
}
function class:initialize()
  super.initialize(self)
  self.taskArray = {}
  self.drawChapter = 1
  self.drawAchieve = 1
  self.achievementIdTab = {}
  self.hasAchieve = {}
  self.bPrompt = false
  self.buff = {}
  Logic:Get("MsgAssist"):RecordErrorMsg("MsgEmblem", MSG_RESULT, MSG_RESULT_STR)
  MsgEmblem:On("COMMOND_GET_ACHIEVE_LIST", self:Event("OnMsgGetMyAchieve"))
  MsgEmblem:On("COMMOND_DRAW_CHAPTER", self:Event("OnDrawChapter"))
  MsgEmblem:On("COMMOND_DRAW", self:Event("OnMsgAchieveRewards"))
  Singleton(NetMgr):On(NetMgr.EVT.NEW_EMBLEM_ACHIEVE, self:Event("OnNetNewAchieve"))
end
function class:NewAchievePrompt(bPrompt)
  if self.bPrompt == bPrompt then
    return
  end
  self.bPrompt = bPrompt
  self:FireEvent(EVT.NEW_ACHIEVE)
end
function class:GetAchievePro()
  return self.bPrompt
end
function class:SendMsgGetMyAchieve()
  MsgEmblem:Post("COMMOND_GET_ACHIEVE_LIST")
end
function class:setAchieve(data)
  for k, v in pairs(data) do
    self.taskArray[k] = {}
    for i = 1, 32 / BITS do
      local bt = bit.rshift(v, BITS * (i - 1))
      table.insert(self.taskArray[k], bit.band(bt, TYPENUM))
    end
  end
  self:TableSort()
  self:AchieveChaneg()
  self:FireEvent(EVT.GET_CHAPTER)
end
function class:OnMsgGetMyAchieve(code, content)
  if code ~= 0 or content == nil then
    return
  end
  self:setAchieve(content)
end
function class:TableSort()
  if self.taskArray == nil or table.empty(self.taskArray) then
    return
  end
  for k, v in pairs(self.taskArray) do
    for i = 1, #v / 2 do
      local min = v[i]
      v[i] = v[#v - (i - 1)]
      v[#v - (i - 1)] = min
    end
  end
end
function class:GetMyAchieveInfo()
  return self.taskArray
end
function class:AchieveChaneg()
  if self.taskArray == nil or table.empty(self.taskArray) then
    return nil
  end
  self.hasAchieve = {}
  local bPrompt = false
  for k, v in pairs(self.taskArray) do
    local has = false
    if v and not table.empty(v) then
      for i = 1, #v do
        if v[i] == DRAW_TYPE.CAN_DRAW then
          has = true
          bPrompt = true
        end
      end
    end
    table.insert(self.hasAchieve, has)
  end
  self:NewAchievePrompt(bPrompt)
end
function class:OnNetNewAchieve()
  self:NewAchievePrompt(true)
  self:SendMsgGetMyAchieve()
end
function class:GetHasNewAchieve()
  return self.hasAchieve
end
function class:SendMsgDrawChapter(chapterId)
  MsgEmblem:Post("COMMOND_DRAW_CHAPTER", {id = chapterId})
  self.drawChapter = chapterId
end
function class:OnDrawChapter(code, content)
  if code == 0 and content ~= nil then
    self.taskArray[self.drawChapter][1] = DRAW_TYPE.COMPLETED
    self:AchieveChaneg()
    Logic:Get("Reward"):AddRewards(content.rewardResult, true)
    self:FireEvent(EVT.DRAW_CHANGE)
  end
end
function class:SendMsgDrawRewards(chapterId, id)
  MsgEmblem:Post("COMMOND_DRAW", {chapterId = chapterId, id = id})
  self.drawChapter = chapterId
  self.drawAchieve = id
end
function class:OnMsgAchieveRewards(code, content)
  if code == 0 and content ~= nil and not table.empty(content) then
    self.taskArray[self.drawChapter][self.drawAchieve + 1] = DRAW_TYPE.COMPLETED
    self:AchieveChaneg()
    Logic:Get("Reward"):AddRewards(content.rewardResult, true)
    self:FireEvent(EVT.DRAW_CHANGE)
  end
end
function class:GetAchievementState(chapterId, id)
  if chapterId == nil or self.taskArray == nil or self.taskArray[chapterId] == nil then
    return DRAW_TYPE.NOT_FOUND
  end
  if id and id < ACHIEVE_MAX then
    return self.taskArray[chapterId][id + 1] or DRAW_TYPE.NOT_FOUND
  else
    return self.taskArray[chapterId][1]
  end
end
function class:GetAchievementStateByKey(key)
  local info = KFDBGetRecord("AchieveConfig", key)
  if info == nil then
    return DRAW_TYPE.NOT_FOUND
  end
  return self:GetAchievementState(info.chapterId, info.achieveId)
end
function class:GetAchimentByChapter(chapterId)
  local achimentInfo = {
    heroIconId = 0,
    title = "",
    content = "",
    rewards = "",
    prograss = "",
    statu = DRAW_TYPE.NOT_FOUND,
    isChapter = false,
    chapter = 0,
    index = 0,
    sortIndex = 0,
    recommend = 0
  }
  local chapterInfo = KFDBGetRecord("ChapterAchieveConfig", chapterId)
  local initInfo = {}
  self.chapterAllInfo = {}
  if chapterInfo then
    initInfo = achimentInfo
    initInfo.title = chapterInfo.achievement
    initInfo.content = chapterInfo.desc
    initInfo.rewards = chapterInfo.rewardId
    if chapterInfo.reachType == "RECOMMEND" then
      initInfo.prograss = string.format("%d/%d", self:GetChapterProById(chapterId), chapterInfo.recommendNum)
    elseif chapterInfo.reachType == "SOME" then
      initInfo.prograss = string.format("%d/%d", self:GetChapterProById(chapterId), chapterInfo.reachNum)
    else
      initInfo.prograss = string.format("%d/%d", self:GetChapterProById(chapterId), chapterInfo.totol)
    end
    initInfo.statu = self:GetAchievementState(chapterId)
    initInfo.isChapter = true
    initInfo.chapter = chapterId
    if initInfo.statu == DRAW_TYPE.CAN_DRAW then
      initInfo.sortIndex = self:SetSortIndex(initInfo.statu)
    else
      initInfo.sortIndex = 4
    end
    initInfo.recommend = 0
    table.insert(self.chapterAllInfo, table.clone(initInfo))
    for i = 1, chapterInfo.totol do
      local achieve = self:GetFdbInfoByIdx(chapterId * ID_SET + i)
      initInfo = achimentInfo
      initInfo.heroIconId = achieve.cardId
      initInfo.title = achieve.name
      initInfo.content = achieve.desc
      initInfo.rewards = achieve.rewardId
      initInfo.prograss = string.format("%d/%d", 1, 1)
      initInfo.statu = self:GetAchievementState(chapterId, i)
      initInfo.chapter = chapterId
      initInfo.index = i
      initInfo.sortIndex = self:SetSortIndex(initInfo.statu)
      initInfo.recommend = achieve.recommend
      table.insert(self.chapterAllInfo, table.clone(initInfo))
    end
  end
  return self.chapterAllInfo
end
function class:SetSortIndex(statu)
  if statu == DRAW_TYPE.CAN_DRAW then
    return 0
  elseif statu == DRAW_TYPE.STARTED then
    return 1
  elseif statu == Logic.Achievement.DRAW_TYPE.NOT_FOUND then
    return 2
  else
    return 3
  end
end
function class:GetChapterProById(chapterId)
  local num = 0
  local chapterInfo = KFDBGetRecord("ChapterAchieveConfig", chapterId)
  if self.taskArray[chapterId] and not table.empty(self.taskArray[chapterId]) then
    for k, v in pairs(self.taskArray[chapterId]) do
      if (v == DRAW_TYPE.COMPLETED or v == DRAW_TYPE.CAN_DRAW) and k > 1 then
        if chapterInfo.reachType == "RECOMMEND" then
          local achieve = self:GetFdbInfoByIdx(chapterId * ID_SET + k - 1)
          if achieve and achieve.recommend == 1 then
            num = num + 1
          end
        else
          num = num + 1
        end
      end
    end
  end
  if chapterInfo.reachType == "RECOMMEND" then
    if chapterInfo and num >= chapterInfo.recommendNum and self.taskArray[chapterId][1] <= DRAW_TYPE.CAN_DRAW then
      self.taskArray[chapterId][1] = DRAW_TYPE.CAN_DRAW
    end
  elseif chapterInfo.reachType == "SOME" then
    if chapterInfo and num >= chapterInfo.reachNum and self.taskArray[chapterId][1] <= DRAW_TYPE.CAN_DRAW then
      self.taskArray[chapterId][1] = DRAW_TYPE.CAN_DRAW
    end
  elseif chapterInfo then
    if num >= (self:GetChapterAll(chapterId) or chapterInfo.totol) and self.taskArray[chapterId][1] <= DRAW_TYPE.CAN_DRAW then
      self.taskArray[chapterId][1] = DRAW_TYPE.CAN_DRAW
    end
  end
  if chapterInfo.reachType == "SOME" and chapterInfo and num >= chapterInfo.reachNum then
    num = chapterInfo.reachNum
  end
  return num
end
function class:GetAchievementPro(chapterId, id)
  local achieveInfo = self:GetFdbInfoByIdx(chapterId * ID_SET + id)
  if achieveInfo == nil or table.empty(achieveInfo) then
    return 0
  end
  local needNum = 1
  local level = 1
  if achieveInfo.reachType == "AMOUNT" then
    needNum = achieveInfo.value
  elseif achieveInfo.reachType == "LEVEL" then
    level = achieveInfo.value
  end
  local myAllHero = Logic:Get("Hero"):GetAllHeroInfo()
  local has = 0
  if myAllHero == nil or table.empty(myAllHero) or myAllHero.heros == nil or table.empty(myAllHero.heros) then
    return 0
  end
  for k, v in pairs(myAllHero.heros) do
    if v.baseId == achieveInfo.cardId then
      if achieveInfo.reachType == "AMOUNT" then
        has = has + 1
      elseif v.level == level then
        has = 1
      end
    end
  end
  return has
end
function class:GetAchievementNeedNub(chapterId, id)
  local achieveInfo = self:GetFdbInfoByIdx(chapterId * ID_SET + id)
  if achieveInfo == nil or table.empty(achieveInfo) then
    return 1
  end
  if achieveInfo.reachType == "AMOUNT" then
    return achieveInfo.value
  else
    return 1
  end
end
function class:GetChapterAll(chapter)
  local chapterInfo = KFDBGetRecord("ChapterAchieveConfig", chapter)
  local num = 0
  if chapterInfo then
    for i = 1, chapterInfo.totol do
      local key = chapter * ID_SET + i
      if self:GetFdbInfoByIdx(key) then
        num = num + 1
      end
    end
  end
  return num
end
function class:GetFdbInfoByIdx(key)
  return KFDBGetRecord("AchieveConfig", key)
end
function class:GetNeedInfoByIdx(key)
  if key and type(key) == "number" then
    return math.floor(key / ID_SET), key % ID_SET
  end
end
function class:onBuff(data)
  self.buff = data
end
function class:UpBuffByReward(buffId)
  if self.buff ~= nil and buffId ~= nil then
    table.insert(self.buff, buffId)
  end
end
function class:GetBuffs()
  return self.buff
end
function class:isGuideAchieve()
  return self.guideAchieve
end
function class:setGuideAchieve(bool)
  self.guideAchieve = bool
end
