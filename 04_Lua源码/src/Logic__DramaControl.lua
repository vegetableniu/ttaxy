module((...), package.seeall)
class = Logic.class:subclass()
EVT = Enum({
  "TALK",
  "END",
  "COVER",
  "COVER_UI"
})
local bRunOnce = true
function class:initialize()
  super.initialize(self)
  self.mapRunned = {}
  self.lstDrama = {}
  self.curIdx = 1
  self.inDramaing = false
  self.processTimer = nil
  self.continueFunc = nil
  self.visiBG = false
end
function class:dispose()
  super.dispose(self)
end
function class:OnEnterWorld()
  self:GetUserDrama()
end
function class:Run(file, continueFunc, cover)
  if nil == file or "" == file then
    return false
  end
  if bRunOnce then
    if self.mapRunned[file] then
      return false
    end
    self.mapRunned[file] = true
    self:SaveUserDrama()
  end
  if self.inDramaing then
    self:Stop()
  end
  local data = CTwFilePack.Open("db/drama/" .. file)
  if nil == data or "" == data then
    log4drama:debug("drama file not exist " .. file)
    return false
  end
  local dataDrama = json.decode(data)
  if nil == dataDrama or 0 == #dataDrama then
    return false
  end
  SceneHelper:pushPrompt("DramaTalk")
  self.lstDrama = dataDrama
  self.inDramaing = true
  self.continueFunc = continueFunc
  self:IsCover(cover)
  self:ProcessDrama()
  return true
end
function class:Stop()
  SceneHelper:removePrompt("DramaTalk")
  self.lstDrama = {}
  self.curIdx = 1
  self.inDramaing = false
  if self:EventTracer():Exist("ProcessDrama") then
    self:EventTracer():Cancel("ProcessDrama")
  end
  if nil ~= self.processTimer then
    Singleton(Timer):unbind(self.processTimer)
    self.processTimer = nil
  end
  self:FireEvent(EVT.END)
  if nil ~= self.continueFunc then
    self.continueFunc()
    self.continueFunc = nil
  end
end
function class:GetNextDrama()
  if nil == self.lstDrama or table.empty(self.lstDrama) then
    return nil
  end
  if self.curIdx > #self.lstDrama then
    return nil
  end
  local info = self.lstDrama[self.curIdx]
  self.curIdx = self.curIdx + 1
  return info
end
function class:ProcessDrama()
  self.processTimer = nil
  local info = self:GetNextDrama()
  if nil == info then
    self:Stop()
    return false
  end
  if info.autoNext and info.timeDelay > 0 then
    if self:EventTracer():Exist("ProcessDrama") then
      self:EventTracer():Cancel("ProcessDrama")
    end
    self.processTimer = Singleton(Timer):After(info.timeDelay, self:Event("ProcessDrama"))
  end
  self:FireEvent(EVT.TALK, info.headId, info.talk, info.isLeft)
  return true
end
function class:ClickNext()
  if nil ~= self.processTimer then
    Singleton(Timer):unbind(self.processTimer)
    self.processTimer = nil
  end
  return self:ProcessDrama()
end
function class:SaveUserDrama()
  if nil == self.mapRunned or table.empty(self.mapRunned) then
    return
  end
  local str = json.encode(self.mapRunned)
  CVariableSystem:GetSingleton():SetUsrVariable(UV_DRAMA, str)
  Logic:Get("System"):SaveUsrVariable()
end
function class:GetUserDrama()
  local str = CVariableSystem:GetSingleton():GetUsrVariable(UV_DRAMA)
  if str and #str > 0 then
    self.mapRunned = json.decode(str)
  end
end
function class:GetVisibleBG()
  return self.bgBool
end
function class:setVisibleBG(bgBool)
  self.bgBool = bgBool or nil
end
function class:IsCover(bool)
  if bool then
    self:FireEvent(EVT.COVER)
  end
end
function class:setCoverUI(node)
  if node then
    self:FireEvent(EVT.COVER_UI, node)
  end
end
function class:getIsInDramaing()
  return self.inDramaing
end
