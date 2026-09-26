module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
require("SceneHelper")
local MEMBER_TYPE = TypeDef("com.eyu.mt.module.menpai.model.JobType")
function prototype:onEnter()
  self.ttfPost:setStyle(kCCLabelTTFStyleOutline)
  self.staOnline:setStyle(kCCLabelTTFStyleOutline)
end
function prototype:refresh(data)
  if data ~= nil then
    self:clear()
    self.data = data
    local img = Logic:Get("Hero"):GetHeroImage(data.baseId)
    local spr = CCSprite:create(img)
    self.imgHero:setDisplayFrame(spr:displayFrame())
    Logic:Get("HeroCardInfo"):AddShanCardSmall(self.imgHero, data.baseId)
    local imgBg = Logic:Get("Hero"):GetHeroBgImage(data.baseId)
    local sprBg = CCSprite:create(imgBg)
    self.imgBg:setDisplayFrame(sprBg:displayFrame())
    self.nodeLv:create(0, "YELLOW_E_NUM")
    self.nodeLv:setAlign("LEFT", "CENTER")
    self.nodeLv:setValue(data.level)
    local selfId = Logic:Get("PlayerInfo"):GetPlayerId()
    if selfId == nil or selfId == self.data.playerId then
      self.ttfName:setString(kCCLabelTTFStyleOutline)
      self.ttfName:setColor(ccColor3B(255, 0, 0))
    end
    self.ttfName:setString(data.name)
    self.numContrb:create(0, "YELLOW_E_NUM")
    self.numContrb:setAlign("LEFT", "CENTER")
    self.numContrb:setValue(data.contribute)
    self.numFight:create(0, "YELLOW_E_NUM")
    self.numFight:setAlign("LEFT", "CENTER")
    self.numFight:setValue(data.fightScore)
    if data.job == MEMBER_TYPE.BOSS then
      self.ttfPost:setString(TwGetStr(110010))
    elseif data.job == MEMBER_TYPE.ELDER then
      self.ttfPost:setString(TwGetStr(110011))
    elseif data.job == MEMBER_TYPE.MEMBER then
      self.ttfPost:setString(TwGetStr(110012))
    elseif data.job == MEMBER_TYPE.STRANGE then
      self.ttfPost:setString(TwGetStr(110013))
    end
    if data.online == true then
      local lastOnTime = Logic:Get("System"):DiffTime(Logic:Get("System"):GetTime(), data.lastLogin / 1000)
      local strRes = TwGetStr(101007)
      lastOnTime = Logic:Get("System"):SecToDay(lastOnTime)
      local number = 0
      local id = 101001
      if lastOnTime and 0 < lastOnTime.hour then
        strRes = TwGetStr(101006)
        number = lastOnTime.hour
        id = 101002
      elseif lastOnTime.min then
        if lastOnTime.sec and lastOnTime.sec ~= 0 then
          number = lastOnTime.min + 1
        else
          number = lastOnTime.min
        end
        id = 101001
      end
      self.staOnline:setString(TwGetStr(id, number))
      self.staOnline:setColor(ccc3(0, 255, 0))
    else
      local str = ""
      local lastOnTime = Logic:Get("System"):DiffTime(Logic:Get("System"):GetTime(), data.lastLogin / 1000)
      lastOnTime = Logic:Get("System"):SecToDay(lastOnTime)
      if 1 > lastOnTime.day then
        str = TwGetStr(103089)
      elseif lastOnTime.day >= 7 then
        str = TwGetStr(103091)
      else
        str = TwGetStr(103090, lastOnTime.day)
      end
      self.staOnline:setString(str)
      self.staOnline:setColor(ccc3(128, 128, 128))
    end
  end
end
function prototype:onItemBtn(sender, event)
  if self.data == nil then
    return
  end
  local selfId = Logic:Get("PlayerInfo"):GetPlayerId()
  if selfId == nil or selfId == self.data.playerId then
    return
  end
  Logic:Get("Sect"):SetMemberData(self.data)
  SceneHelper:pushPrompt("SectMutual", self.rootNode)
end
function prototype:onHeroBtn(sender, event)
  if self.data == nil then
    return
  end
  local heroInfo = {
    level = self.data.level or 1,
    baseId = self.data.baseId or 1,
    powerSkill = tonumber(self.data.skill) or 1,
    talisman = self.data.taiTalismans,
    equips = self.data.equips or {},
    userBuffs = self.data.userBuffs,
    artifactLevel = self.data.artifactLevel,
    cultivateVo = self.data.cultivateVo,
    otherPlayer = true
  }
  Logic:Get("HeroCardInfo"):PromptHeroInfoByNparma(heroInfo)
end
function prototype:clear()
  self.ttfName:setColor(ccColor3B(255, 255, 255))
  self.ttfPost:setString("")
  self.staOnline:setString("")
end
