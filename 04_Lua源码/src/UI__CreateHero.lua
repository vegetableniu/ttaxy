module((...), package.seeall)
require("SceneHelper")
prototype = Tw.Controller.prototype:extend()
local ZHIZUNBAO = 0
local ZIXIA = 1
local PATH = "images/CreateHero/uixjjsjm22.png"
local ANI = {
  SELECT_BAO = "UI/uicjjszzb",
  SELECT_XI = "UI/uicjjszzx",
  CHANGE_TO_BAO = "UI/uicjjszzxhp",
  CHANGE_TO_XI = "UI/uicjjszzbhp"
}
function prototype:initialize(...)
  super.initialize(self, ...)
  math.randomseed(os.time())
  local ranSelect = math.random(1000) % 2
  self.select = ranSelect
end
function prototype:dispose(...)
  super.dispose(self)
end
function prototype:onEnter()
  self.inputName:setFontSize(35)
  self.inputName:setClear(true)
  self.inputName:setMaxLens(Logic.CreateHero.NAME_LENGTH_MAX)
  self.ttfDecr:setStyle(kCCLabelTTFStyleOutline)
  self.ttfEnter:setStyle(kCCLabelTTFStyleOutline)
  self.ttfEnter:setString(TwGetStr(105005))
  if self.select == ZHIZUNBAO then
    self.ttfDecr:setString(TwGetStr(105008))
  elseif self.select == ZIXIA then
    self.ttfDecr:setString(TwGetStr(105009))
  end
  self:randName()
  if self.select == ZHIZUNBAO then
    self.ani1 = Logic:Get("AniMgr"):RunCCBAni(ANI.SELECT_BAO, self.aniNode, ccp(320, 490), 1)
  elseif self.select == ZIXIA then
    self.ani1 = Logic:Get("AniMgr"):RunCCBAni(ANI.SELECT_XI, self.aniNode, ccp(320, 490), 1)
  end
  local bCloseRanName = Logic:Get("System"):GetMisc("closeRandomName") or 0
  if bCloseRanName > 0 then
    self.btnRename:setVisible(false)
  end
  Logic:Get("CreateHero"):PrepareEnd()
end
function prototype:onNodeLoaded(node, loader)
end
function prototype:onBtnRenameClicked(sender, event)
  self:randName()
end
function prototype:onBtnEnterClicked(sender, event)
  local UniqueId = Logic:Get("System"):GetUniqueId()
  CUMengAgent:OnEvent("CreateHero", UniqueId)
  local name = self.inputName:getString()
  if name and "" ~= name then
    local flag = Logic:Get("CreateHero"):checkName(name)
    if not flag then
      self.inputName:setString("")
      return
    end
    local account = Logic:Get("Login"):GetAccountStr()
    local heroSelected = self.select
    local baseIdArray = Logic:Get("CreateHero"):GetCreateHeroIds()
    if heroSelected < 0 or heroSelected > #baseIdArray then
      heroSelected = ZHIZUNBAO
    end
    local device = Logic:Get("System"):GetUniqueId()
    if Logic:Get("System"):IsOperator("appstore") then
      local deviceData = {
        idfa = Logic:Get("System"):GetIdfa() or "",
        uuid = Logic:Get("System"):GetUniqueId() or "",
        mac = Logic:Get("System"):GetMacAddr() or ""
      }
      device = json.encode(deviceData)
    end
    local channelTab = Logic:Get("System"):GetOperator("channel") or {}
    local channel = 0
    if channelTab ~= nil and not table.empty(channelTab) then
      local platform = CTwUtil:GetPlatform()
      if CTwUtil.E_TP_MAC == platform then
        channel = channelTab.ios or 0
      end
      if CTwUtil.E_TP_ANDROID == platform then
        channel = channelTab.ard or 0
      end
    end
    local md5Code
    local purchaseCode = Logic:Get("System"):GetMisc("purchaseCode")
    local drawedAppstore = Logic:Get("System"):GetSysVariableMisc("GV_DRAWED_APPSTORE")
    if Logic:Get("System"):IsOperator("appstore") and purchaseCode ~= nil and drawedAppstore == nil then
      md5Code = CMd5(account .. purchaseCode):GetResult()
      Logic:Get("System"):SetSysVariableMisc("GV_DRAWED_APPSTORE", 1)
    end
    Logic:Get("Login"):CreateRole({
      account = account,
      channel = channel,
      device = device,
      name = name,
      select = heroSelected,
      invite = "",
      purchaseCode = md5Code
    })
  else
    Prompt:Fail(TwGetStr(10054))
  end
end
function prototype:onBtnChangeClicked(sender, event)
  if self.ani1 ~= nil then
    self.ttfDecr:setString("")
    self.btnChange:setEnabled(false)
    local ani
    if self.select == ZHIZUNBAO then
      self.select = ZIXIA
      ani = ANI.CHANGE_TO_XI
    else
      self.select = ZHIZUNBAO
      ani = ANI.CHANGE_TO_BAO
    end
    self.ani1:RemoveAnimation()
    self.ani1 = Logic:Get("AniMgr"):RunCCBAni(ani, self.aniNode, ccp(320, 490), 1, true, bind(self.changeMoiveEnd, self))
  end
end
function prototype:randName()
  local bCloseRanName = Logic:Get("System"):GetMisc("closeRandomName") or 0
  if bCloseRanName <= 0 then
    local randName = Logic:Get("CreateHero"):GetRename(self.select)
    if randName and "" ~= randName then
      self.inputName:setString(randName)
    end
  end
end
function prototype:changeMoiveEnd()
  if self.ani1 ~= nil then
    self.btnChange:setEnabled(true)
    local ani
    if self.select == ZHIZUNBAO then
      ani = ANI.SELECT_BAO
      self.ttfDecr:setString(TwGetStr(105008))
    else
      ani = ANI.SELECT_XI
      self.ttfDecr:setString(TwGetStr(105009))
    end
    self.ani1:RemoveAnimation()
    self.ani1 = Logic:Get("AniMgr"):RunCCBAni(ani, self.aniNode, ccp(320, 490), 1)
  end
end
