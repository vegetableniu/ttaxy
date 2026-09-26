module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
require("SceneHelper")
STATE_PATH = {
  UNSTART_IP = "images/Activity/unstart_up.png",
  PASS = "images/Activity/pass.png",
  PROGRESS = "images/Activity/progress.png"
}
local ALL_TITLE = {
  "activityTitle",
  "timeTitle",
  "surplusTime",
  "activityAward"
}
function prototype:initialize()
  super.initialize(self)
  self.titleinfo = {}
end
function prototype:onEnter()
  self:InitTitle()
end
function prototype:InitTitle()
  for i = 1, #ALL_TITLE do
    self[ALL_TITLE[i]]:setStyle(kCCLabelTTFStyleOutline, ccc3(0, 0, 0))
  end
end
function prototype:IsActivityOpen()
  return self.titleInfo.state == Logic.Activity.ACTIVE_STATE.IN
end
function prototype:compriseTimeToStr(time)
  if time == nil then
    return
  end
  local result = ""
  if time.day + time.hour > 0 then
    local hour = time.day * 24 + time.hour
    if 0 < time.min + time.sec then
      hour = hour + 1
    end
    result = tostring(hour) .. TwGetStr(106041)
  else
    local min = time.min
    if 0 <= time.sec then
      min = min + 1
    end
    result = tostring(min) .. TwGetStr(106042)
  end
  return result
end
function prototype:setStateImgByStr(str)
  local spr = CCSprite:create(str)
  self.openOrCloseSprite:setDisplayFrame(spr:displayFrame())
  self.openOrCloseSprite:setAnchorPoint(CCPoint(0.5, 0.5))
end
function prototype:ReFrashInfo(titleInfo, idx)
  self.index = idx
  if titleInfo == nil or next(titleInfo) == nil then
    return
  end
  self.titleInfo = titleInfo
  local bOpen = self:IsActivityOpen()
  local surplusTimes = bOpen and TwGetStr(106016) or TwGetStr(106017)
  local time = bOpen and self:compriseTimeToStr(titleInfo.stopTime) or self:compriseTimeToStr(titleInfo.startTime)
  self:setStrColor(bOpen)
  if not bOpen and not Logic:Get("Activity"):isOpenForLimit(titleInfo.activeId) then
    time = ""
    surplusTimes = ""
  end
  self.sprCampaignLock:setVisible(false)
  self:setStrInfo(titleInfo.name, surplusTimes, time, titleInfo.award)
  local stateImgPath = bOpen and STATE_PATH.PROGRESS or STATE_PATH.UNSTART_IP
  if bOpen ~= self.btnSelectActivity:isEnabled() then
    self.btnSelectActivity:setEnabled(bOpen)
  end
  local info = Logic:Get("Activity"):getCampaignInfo(self.titleInfo.activeId)
  if info ~= nil and next(info) ~= nil and Logic:Get("PlayerInfo"):GetPlayerLevel() < tonumber(info.level) then
    self.btnSelectActivity:setEnabled(false)
    self.sprCampaignLock:setVisible(true)
    self.levelLimit:setVisible(true)
    self.levelLimit:setStyle(kCCLabelTTFStyleOutline)
    self.levelLimit:setString(TwGetStr(106020, tonumber(info.level)))
  else
    self.levelLimit:setVisible(false)
  end
  if Logic:Get("Lock"):checkLock(nil, nil, info.prevBattle, nil, info.prevActivity) then
    self.activityAward:setColor(ccc3(255, 0, 0))
    self.btnSelectActivity:setEnabled(false)
    self.sprCampaignLock:setVisible(true)
  end
  if Logic:Get("Rebirth"):isFulledActive(self.titleInfo.activeId) then
    local sprNormal, sprSelect, sprLock
    sprNormal = CCScale9Sprite:create(info.imgBg)
    sprSelect = CCScale9Sprite:create(info.imgBg)
    sprLock = CCScale9Sprite:create(info.imgBg)
    if sprNormal and sprSelect then
      self.btnSelectActivity:setBackgroundSpriteForState(sprNormal, CCControlStateNormal)
      self.btnSelectActivity:setBackgroundSpriteForState(sprSelect, CCControlStateHighlighted)
      self.btnSelectActivity:setBackgroundSpriteForState(sprLock, CCControlStateDisabled)
    end
    local spr = CCSprite:create(info.imgTitle)
    if spr then
      self.sprTitle:setDisplayFrame(spr:displayFrame())
      self.activityTitle:setString("")
    end
    return
  end
  self:clearImg()
end
function prototype:clearImg()
  local sprNormal, sprSelect, sprLock
  sprNormal = CCScale9Sprite:create("images/public/btnHeroFrameNormal.png")
  sprSelect = CCScale9Sprite:create("images/public/btnHeroFrameSelect.png")
  sprLock = CCScale9Sprite:create("images/public/btnHeroFrameDisable.png")
  if sprNormal and sprSelect then
    self.btnSelectActivity:setBackgroundSpriteForState(sprNormal, CCControlStateNormal)
    self.btnSelectActivity:setBackgroundSpriteForState(sprSelect, CCControlStateHighlighted)
    self.btnSelectActivity:setBackgroundSpriteForState(sprLock, CCControlStateDisabled)
  end
  local spr = CCSprite:create("images/public/clarity05.png")
  if spr then
    self.sprTitle:setDisplayFrame(spr:displayFrame())
  end
end
function prototype:setStrColor(bOpen)
  self.activityAward:setColor(ccc3(106, 227, 255))
  if bOpen then
    self.timeTitle:setColor(ccc3(125, 255, 0))
    self.surplusTime:setColor(ccc3(255, 250, 226))
  else
    self.timeTitle:setColor(ccc3(168, 0, 0))
    self.surplusTime:setColor(ccc3(168, 0, 0))
  end
end
function prototype:setStrInfo(strname, strsurtimes, strtime, straward)
  self.activityTitle:setString(strname or "")
  self.timeTitle:setString(strtime or "")
  if strtime == nil or "" == strtime then
    self.surplusTime:setString("")
  else
    self.surplusTime:setString(strsurtimes)
  end
  self.activityAward:setString(straward or "")
end
function prototype:onBtnSelectActivity()
  if Logic:Get("Rebirth"):isRebirthActive(self.titleInfo.activeId) or Logic:Get("Rebirth"):isLimitedActive(self.titleInfo.activeId) or Logic:Get("Rebirth"):isFulledActive(self.titleInfo.activeId) then
    Logic:Get("Rebirth"):SetCampaignId(self.titleInfo.activeId)
    SceneHelper:runWithScene("Rebirth", self.rootNode)
    return
  end
  Logic:Get("Guide"):done("Activity", "SelectCampaign")
  local curActiveId = Logic:Get("Activity"):getcurActiveId(self.index + 1)
  Logic:Get("Activity"):setCurrentActivity(curActiveId)
  SceneHelper:pushScene("ActivityTemp", self.rootNode)
end
function prototype:updateGuide()
  local logicGuide = Logic:Get("Guide")
  if not logicGuide:isGuiding() then
    return false
  end
  if Logic:Get("Guide"):isActive("Activity", "SelectCampaign") then
    Logic:Get("Guide"):lockTouch(self.btnSelectActivity)
  end
end
