module((...), package.seeall)
require("utf8")
require("Logic")
require("xlsdatacount")
class = Logic.class:subclass()
local TYPE = {
  SUR = 1,
  MALE = 2,
  FEMALE = 3,
  LAST = 4
}
NAME_LENGTH_MIN = 4
NAME_LENGTH_MAX = 12
local CREATE_HERO_IMG = {
  "images/Effect/uijsxz/bg.png",
  "images/Effect/uijsxz/bgbg.png",
  "images/Effect/uijsxz/blue.png",
  "images/Effect/uijsxz/herobg.png",
  "images/Effect/uijsxz/herozs.png",
  "images/Effect/uijsxz/herozzb.png",
  "images/Effect/uijsxz/kuang.png",
  "images/Effect/uijsxz/lcardzs.png",
  "images/Effect/uijsxz/lcardzzb.png",
  "images/Effect/uijsxz/namezs.png",
  "images/Effect/uijsxz/namezzb.png",
  "images/Effect/uijsxz/talkzs.png",
  "images/Effect/uijsxz/talkzzb.png",
  "images/Effect/uijsxz/text_input.png",
  "images/Effect/uijsxz/yellow.png",
  "images/Effect/uijsxz/yw.png",
  "images/CreateHero/bg_below.png",
  "images/CreateHero/uixjjsjm22.png"
}
function class:initialize()
  super.initialize(self)
end
function class:Create()
  self:PrepareBegin()
  Singleton(Timer):After(100, self:Event("DelayCreate", function()
    self:Prepare()
    self:CreateHeroMovie()
  end))
end
function class:PrepareBegin()
  Logic:Get("Login"):OpenNetConnTip(true)
end
function class:PrepareEnd()
  Logic:Get("Login"):CloseNetConnTip()
end
function class:Prepare()
  math.randomseed(os.time())
  self.heroSelected = 0
  self.createHeroIds = {
    [1] = 1001,
    [2] = 1021
  }
  self:preloadTexture()
  self.curMovieStep = 1
  self.movieLst = {}
  table.insert(self.movieLst, {
    time = 4000,
    ccb = "CreateHeroMovie1"
  })
  table.insert(self.movieLst, {
    time = 10000,
    ccb = "CreateHeroMovie2"
  })
  table.insert(self.movieLst, {
    time = 3000,
    ccb = "CreateHeroMovie3"
  })
  table.insert(self.movieLst, {
    time = 3000,
    ccb = "CreateHeroMovie4"
  })
  table.insert(self.movieLst, {
    time = 3000,
    ccb = "CreateHeroMovie5"
  })
end
function class:preloadTexture()
  local paths = {}
  local info = Logic:Get("Battle"):GetBattleInfoById("CN01BN01")
  if info then
    table.insert(paths, info.mapInit or "")
    table.insert(paths, info.mapBg or "")
    table.insert(paths, info.mapBoss or "")
  end
  for _, v in pairs(CREATE_HERO_IMG) do
    table.insert(paths, v or "")
  end
  if not table.empty(paths) then
    local texturePreloader = Tw.TexturePreloader:getInstance()
    self.files = texturePreloader:loadAsync(paths)
  end
end
function class:GetHeroSelected()
  return self.heroSelected
end
function class:SetHeroSelected(selected)
  if selected then
    self.heroSelected = selected
  end
end
function class:GetCreateHeroIds()
  return self.createHeroIds
end
function class:checkName(name)
  if name and "" == name then
    Prompt:Fail(TwGetStr(10054))
    return false
  end
  local length = getStrShowWidth(name)
  if length < NAME_LENGTH_MIN then
    Prompt:Fail(TwGetStr(10073, NAME_LENGTH_MIN))
    return false
  elseif length > NAME_LENGTH_MAX then
    Prompt:Fail(TwGetStr(10074, NAME_LENGTH_MAX))
    return false
  else
    local flag = self:checkSpecial(name)
    if not flag then
      Prompt:Fail(10075)
      return false
    end
    local result
    for i = 1, KFDBGetRecordAmt("RegisterForbidden") do
      local rec = KFDBGetRecordByIdx("RegisterForbidden", i)
      result = string.find(name, rec.name)
      if result ~= nil then
        break
      end
    end
    if nil ~= result then
      Prompt:Fail(10029)
      return false
    end
  end
  return true
end
function class:checkSpecial(str)
  if not utf8.isBMPOnly(str) then
    return false
  end
  return string.find(getSubANSIString(str), "[%c%p%s]") == nil
end
function class:CreateHeroMovie()
  Logic:Get("BGSound"):PlayBGMusic()
  SceneHelper:transition("CreateHeroMoive")
end
function class:OnNextMovie()
  local info = self.movieLst[self.curMovieStep]
  if nil == info then
    self:CreateHeroMovieEnd()
    return
  end
  SceneHelper:transition(info.ccb)
  if not self.eventTracer:Exist("OnNextMovie") then
    Singleton(Timer):Repeat(info.time, self:Event("OnNextMovie"), 1)
    self.curMovieStep = self.curMovieStep + 1
  end
end
function class:CreateHeroMovieEnd()
  SceneHelper:transition("CreateHero")
end
function class:GetRename(heroSelected)
  local sur = self:GetByType(TYPE.SUR)
  local name = self:GetByType(TYPE.MALE)
  return sur .. name
end
function class:GetByType(nameType)
  if nameType <= 0 then
    return ""
  end
  if nameType > #RandName_XlsSheetDataCount then
    return ""
  end
  local ranIdx = math.random(RandName_XlsSheetDataCount[nameType])
  local actIdx = 0
  for i = 1, nameType - 1 do
    actIdx = actIdx + RandName_XlsSheetDataCount[i]
  end
  actIdx = actIdx + ranIdx
  local rec = KFDBGetRecordByIdx("RandName", actIdx)
  if rec then
    return rec.value
  end
  return ""
end
