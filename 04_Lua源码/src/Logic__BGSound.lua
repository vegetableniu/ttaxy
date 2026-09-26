module((...), package.seeall)
class = Logic.class:subclass()
function class:initialize()
  super.initialize(self)
  self.music = {
    BG = "audio/bg_001.mp3",
    BATTLE = "audio/battle_001.mp3",
    LOGIN = "audio/login.mp3"
  }
end
function class:dispose()
  super.dispose(self)
end
function class:PlayEffect(file)
  local isClose = "1" == CVariableSystem:GetSingleton():GetSysVariable(GV_CLOSE_SOUND)
  if isClose then
    return
  end
  if nil == file or "" == file then
    return
  end
  file = self:GetFullPath(file)
  SimpleAudioEngine:sharedEngine():playEffect(file)
end
function class:stopAllEffect()
  SimpleAudioEngine:sharedEngine():stopAllEffects()
end
function class:PlayServerMusic()
  if Logic:Get("System"):IsCloseServerMusic() then
    return
  end
  self:SwitchMusic(self.music.LOGIN)
end
function class:StopServerMusic()
  self:StopMusic(self.music.LOGIN)
end
function class:PlayBGMusic()
  self:SwitchMusic(self.music.BG)
end
function class:StopBGMusic()
  self:StopMusic(self.music.BG)
end
function class:PlayBattleMusic()
  self.preBattleFile = self.curFile
  self:SwitchMusic(self.music.BATTLE)
end
function class:StopBattleMusic()
  if nil ~= self.preBattleFile then
    self:SwitchMusic(self.preBattleFile)
    return
  end
  self:StopMusic(self.music.BATTLE)
end
function class:SwitchMusic(file, loop)
  if nil == loop then
    loop = true or loop
  end
  local isClose = "1" == CVariableSystem:GetSingleton():GetSysVariable(GV_CLOSE_MUSIC)
  if isClose then
    return
  end
  if nil == file or "" == file then
    return
  end
  file = self:GetFullPath(file)
  if self.curFile ~= nil and self.curFile ~= "" and self.curFile ~= file then
    if not self:EventTracer():Exist("FADE_CLOSE") then
      Singleton(Timer):Repeat(50, self:Event("FADE_CLOSE", "OnFadeClose"))
    end
    self.nextFile = {file = file, loop = loop}
    return
  end
  if self.curFile == file then
    return
  end
  SimpleAudioEngine:sharedEngine():playBackgroundMusic(file, loop)
  self.curFile = file
end
function class:StopMusic(file)
  if nil == file or "" == file then
    return
  end
  file = self:GetFullPath(file)
  if file ~= self.curFile then
    return
  end
  self.curFile = ""
  SimpleAudioEngine:sharedEngine():stopBackgroundMusic()
end
function class:PauseBGMusic()
  self:PauseMusic(self.music.BG)
end
function class:ResumeBGMusic()
  self:ResumeMusic(self.music.BG)
end
function class:PauseMusic(file)
  if nil == file or "" == file then
    return
  end
  file = self:GetFullPath(file)
  if file ~= self.curFile then
    return
  end
  SimpleAudioEngine:sharedEngine():pauseBackgroundMusic()
end
function class:ResumeMusic(file)
  if nil == file or "" == file then
    return
  end
  file = self:GetFullPath(file)
  if file ~= self.curFile then
    return
  end
  SimpleAudioEngine:sharedEngine():resumeBackgroundMusic()
end
function class:ResetBGMusic(isClose)
  if isClose then
    self:StopMusic(self.curFile)
  else
    self:PlayBGMusic()
  end
end
function class:OnFadeClose()
  local volume = SimpleAudioEngine:sharedEngine():getBackgroundMusicVolume()
  volume = volume - 5
  if not (volume > 0) or not volume then
    volume = 0
  end
  SimpleAudioEngine:sharedEngine():setBackgroundMusicVolume(volume)
  if volume == 0 then
    self:OnFadeCloseFinish()
  end
end
function class:OnFadeCloseFinish()
  self:EventTracer():Cancel("FADE_CLOSE")
  SimpleAudioEngine:sharedEngine():stopBackgroundMusic()
  if nil ~= self.nextFile and nil ~= self.nextFile.file then
    SimpleAudioEngine:sharedEngine():playBackgroundMusic(self.nextFile.file, self.nextFile.loop)
    if not self:EventTracer():Exist("FADE_OPEN") then
      Singleton(Timer):Repeat(50, self:Event("FADE_OPEN", "OnFadeOpen"))
    end
    self.curFile = self.nextFile.file
    self.nextFile = nil
  end
end
function class:OnFadeOpen()
  local volume = SimpleAudioEngine:sharedEngine():getBackgroundMusicVolume()
  volume = volume + 2
  if volume >= 100 then
    volume = 100 or volume
  end
  SimpleAudioEngine:sharedEngine():setBackgroundMusicVolume(volume)
  if volume == 100 then
    self:EventTracer():Cancel("FADE_OPEN")
  end
end
function class:StopMusic()
  self.curFile = ""
  SimpleAudioEngine:sharedEngine():stopBackgroundMusic()
end
function class:GetFullPath(filePath)
  local path = CVariableSystem:GetSingleton():GetSysVariable(GV_PATCHPATH)
  local fullPath = filePath
  if nil == string.find(filePath, path) then
    fullPath = path .. filePath
  end
  local file = io.open(fullPath)
  if nil == file then
    fullPath = string.sub(fullPath, string.len(path) + 1, string.len(fullPath))
    local path = CVariableSystem:GetSingleton():GetSysVariable(GV_RESPATH)
    fullPath = CVariableSystem:GetSingleton():GetSysVariable(GV_RESPATH) .. fullPath
  end
  return fullPath
end
