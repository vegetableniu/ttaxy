module((...), package.seeall)
require("AutoPatch")
local DOWNLOAD_PRO_BG = "images/Login/exp_bg.png"
local DOWNLOAD_PRO_FRONT = "images/Login/exp_pro.png"
prototype = Tw.Controller.prototype:extend()
local AUTO_PATCH_TIME = 100
function prototype:initialize(...)
  super.initialize(self, ...)
  Logic:Get("AutoPatch"):On(Logic.AutoPatch.EVT.ENTER_SELSERVER, self:Event("onEnterGame"))
end
function prototype:dispose(...)
  super.dispose(self)
end
function prototype:onEnter()
  local platform = CTwUtil:GetPlatform()
  if Logic:Get("System"):GetExeVer() < Logic.System.EXE_VERSION.INIT_SDK and CTwUtil.E_TP_ANDROID == platform and not Logic:Get("System"):IsOperator("17mogu") and not Logic:Get("System"):IsOperator("sogou") then
    Logic:Get("EnvLogic"):CheckPackageUpdate()
  else
    Logic:Get("AutoPatch"):StartQuery()
  end
  self.staDownload:setStyle(kCCLabelTTFStyleOutline)
  self.begDown = false
  self.tipTime = 0
  self.staMsg:setString(TwGetStr(10004))
  Singleton(Timer):Repeat(AUTO_PATCH_TIME, self:Event("REFRESH_TIMER", "Refresh"))
  self.proFile:createProgress(DOWNLOAD_PRO_BG, DOWNLOAD_PRO_FRONT)
  self.proDownload:createProgress(DOWNLOAD_PRO_BG, DOWNLOAD_PRO_FRONT)
  local hideAutoPatch = Logic:Get("System"):IsHideAutoPatch()
  self.staDownload:setVisible(not hideAutoPatch)
  self.staMsg:setVisible(not hideAutoPatch)
  self.proFile:setVisible(false)
  self.staFile:setVisible(not hideAutoPatch)
end
function prototype:RefreshTip()
  local strTip = TwGetStr(10004)
  self.tipTime = self.tipTime % 4
  for i = 1, self.tipTime do
    strTip = strTip .. "."
  end
  self.tipTime = self.tipTime + 1
  self.staMsg:setString(strTip)
end
function prototype:Refresh()
  local downInfo, curDown, totalDown, totalDownSize = Logic:Get("AutoPatch"):GetDownFileInfo()
  if nil == downInfo or nil == curDown or nil == totalDown then
    if not self.begDown then
      self:RefreshTip()
    end
    return
  end
  self.begDown = true
  if totalDownSize > 1048576 then
    self.staMsg:setString(TwGetStr(10151, totalDownSize / 1048576))
  else
    self.staMsg:setString("")
  end
  local downPrgValue = 100 * (curDown - 1 + downInfo.nRecvSize / downInfo.nTotalSize) / totalDown
  if downPrgValue >= 100 then
    self.proDownload:setValue(100)
    self.staDownload:setString(string.format("%d%%", 100))
    self.staMsg:setString(TwGetStr(10015))
  else
    self.proDownload:setValue(downPrgValue)
    self.staDownload:setString(string.format("%d%%", downPrgValue))
  end
end
function prototype:onEnterGame()
  Logic:Get("Account"):SetAutoLogin(true)
  SceneHelper:removeScene("AutoPatch")
  Logic:Get("Login"):SetLoadingStage(Logic.Login.LOAD_STAGE.ENTERGAME)
end
