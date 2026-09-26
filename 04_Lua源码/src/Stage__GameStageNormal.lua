module((...), package.seeall)
require("GameStage")
require("NetMgr")
require("Logic.World")
require("Logic.Guide")
class = GameStage.class:subclass()
SOUND_MIN_VOLUME = 0
SOUND_MAX_VOLUME = 100
function class:initialize()
  super.initialize(self)
end
function class:OnStageActive()
  Logic:Get("System"):LoadUsrVariable()
  local sceneMain = SceneHelper:replaceScene("Root")
  if nil ~= sceneMain then
    SceneHelper:insertScene("Main", nil, sceneMain, Logic:Get("GameSetting"):GetLayerPriority("main"))
    SceneHelper:runWithScene("Home", nil, sceneMain)
  end
  Logic:Get("BattleShow"):SetMainScene(sceneMain)
  Logic:Get("World"):Enter()
  self:LoadMusicSetting()
  self:LoadScreenSetting()
  if not Logic:Get("BattleShow"):IsInBattleShow() then
    Logic:Get("BGSound"):PlayBGMusic()
  end
  Logic:Get("Guide"):On(Logic.Guide.EVT.ACTIVE, self:Event("GuideActive", function()
    SceneHelper:guideActive()
  end))
  Logic:Get("Guide"):On(Logic.Guide.EVT.DISMISS, self:Event("GuideDismiss", function()
    SceneHelper:guideDismiss()
  end))
  if Logic:Get("System"):IsOperator("ilovewebgame") then
    Logic:Get("EnvLogic"):EnterPlatform("intro")
  end
end
function class:OnStageClose()
  Logic:Get("World"):Close()
  Logic:Get("BGSound"):StopMusic()
  self:SaveMusicSetting()
  CVariableSystem:GetSingleton():Reset()
end
function class:OnOperateEvent(args)
  return Logic:Get("World"):OnOperateEvent(args)
end
function class:ChangeGameViewSize(w, h)
  Logic:Get("World"):ChangeGameViewSize(w, h)
end
function class:LoadScreenSetting()
  local val = CVariableSystem:GetSingleton():GetSysVariable(GV_KEEP_SCREEN_ON)
  if val == "" then
    CVariableSystem:GetSingleton():SetSysVariable(GV_KEEP_SCREEN_ON, 0)
    CVariableSystem:GetSingleton():SaveSysVariable()
  end
  if val == "1" then
    val = 0
  else
    val = 1
  end
  Logic:Get("EnvLogic"):SetKeepScreenOnState(val)
end
function class:LoadMusicSetting()
  local succ, val = CVariableSystem:GetSingleton():GetSysVariable(GV_CLOSE_SOUND, nil)
  local bsign = false
  if "0" == val or "" == val then
    bsign = false
  end
  if "1" == val then
    bsign = true
  end
  succ, val = CVariableSystem:GetSingleton():GetSysVariable(GV_CLOSE_MUSIC, nil)
  if "0" == val or "" == val then
    bsign = false
  end
  if "1" == val then
    bsign = true
  end
  succ, val = CVariableSystem:GetSingleton():GetSysVariable(GV_SOUNDVAL, nil)
  local nVolume
  if true == succ then
    nVolume = tonumber(val)
  elseif false == succ then
    nVolume = SOUND_MAX_VOLUME
  end
  nVolume = math.max(nVolume, SOUND_MIN_VOLUME)
  nVolume = math.min(nVolume, SOUND_MAX_VOLUME)
  CVariableSystem:GetSingleton():SetSysVariable(GV_SOUNDVAL, nVolume)
  succ, val = CVariableSystem:GetSingleton():GetSysVariable(GV_MUSICVAL, nil)
  if true == succ then
    nVolume = tonumber(val)
  elseif false == succ then
    nVolume = SOUND_MAX_VOLUME
  end
  nVolume = math.max(nVolume, SOUND_MIN_VOLUME)
  nVolume = math.min(nVolume, SOUND_MAX_VOLUME)
  CVariableSystem:GetSingleton():SetSysVariable(GV_MUSICVAL, nVolume)
end
function class:SaveMusicSetting()
  Logic:Get("System"):SaveUsrVariable()
end
