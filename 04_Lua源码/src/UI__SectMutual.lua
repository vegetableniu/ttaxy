module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
require("TableViewEx")
require("SceneHelper")
local MEMBER_TYPE = TypeDef("com.eyu.mt.module.menpai.model.JobType")
function prototype:onEnter()
  self.memberData = Logic:Get("Sect"):GetMemberData()
  self:refresh(self.memberData)
end
function prototype:refresh(data)
  if data ~= nil then
    self.memberData = data
    self.nodeLv:create(0, "YELLOW_E_NUM")
    self.nodeLv:setAlign("LEFT", "CENTER")
    self.nodeLv:setValue(data.level)
    local spr = Logic:Get("Hero"):GetHeroImage(data.baseId)
    local img = CCSprite:create(spr)
    if img ~= nil then
      self.imgHero:setDisplayFrame(img:displayFrame())
    end
    Logic:Get("HeroCardInfo"):AddShanCardSmall(self.imgHero, data.baseId)
    local imgBg = Logic:Get("Hero"):GetHeroBgImage(data.baseId)
    local sprBg = CCSprite:create(imgBg)
    self.imgBg:setDisplayFrame(sprBg:displayFrame())
    if data.job == MEMBER_TYPE.BOSS then
      self.strPost:setString(TwGetStr(110010))
      self.labelGrant:setString("")
      self.btnGrant:setEnabled(false)
    elseif data.job == MEMBER_TYPE.ELDER then
      self.strPost:setString(TwGetStr(110011))
    elseif data.job == MEMBER_TYPE.MEMBER then
      self.strPost:setString(TwGetStr(110012))
    else
      self.strPost:setString(TwGetStr(110013))
    end
    local selfjob = Logic:Get("Sect"):GetJob()
    if selfjob == MEMBER_TYPE.BOSS then
      self.labelGrant:setString(TwGetStr(110003))
      self.labelDeSz:setString(TwGetStr(110004))
      self.labelKick:setString(TwGetStr(110008))
    else
      if data.job == MEMBER_TYPE.BOSS then
        self.labelDeSz:setString(TwGetStr(110005))
      else
        self.btnDeSz:setEnabled(false)
      end
      self.btnGrant:setEnabled(false)
      self.btnKick:setEnabled(false)
    end
    local id = Logic:Get("PlayerInfo"):GetPlayerId()
    if data.playerId == id then
      self.labelGrant:setString("")
      self.labelDeSz:setString("")
      self.labelKick:setString("")
      self.btnGrant:setEnabled(false)
      self.btnDeSz:setEnabled(false)
      self.btnKick:setEnabled(false)
    end
    self.strName:setString(data.name)
    self.strPower:create(0, "YELLOW_E_NUM")
    self.strPower:setAlign("LEFT", "CENTER")
    self.strPower:setValue(data.fightScore)
    self.strContrb:create(0, "YELLOW_E_NUM")
    self.strContrb:setAlign("LEFT", "CENTER")
    self.strContrb:setValue(data.contribute)
    self.labelAddFriend:setString(TwGetStr(110006))
    self.labelSendMsg:setString(TwGetStr(110007))
  end
end
function prototype:onBtnGrant(sender, event)
  SceneHelper:pushPrompt("GrantItem", self.rootNode)
end
function prototype:onBtnDeSz(sender, event)
  local str = self.labelDeSz:getString()
  if str == TwGetStr(110004) then
    Prompt:Confirm(self, "", TwGetStr(110175, self.memberData.name), self.DeSz, Prompt.PROMPT_TYPE.SELECT)
    return
  elseif str == TwGetStr(110005) then
    local overDate = Logic:Get("Sect"):GetGrabOverDate()
    local curDate = Logic:Get("System"):GetTime()
    if overDate == nil or overDate < curDate then
      Logic:Get("Sect"):PostGrabTight()
    else
      Prompt:Confirm(self, 110005, 110033, nil, Prompt.PROMPT_TYPE.CONFIRM)
    end
  end
  SceneHelper:removePrompt(self.rootNode)
end
function prototype:onBtnAddFriend(sender, event)
  local friendInfo = Logic:Get("Friend"):GetFriendInfo()
  local num = #friendInfo or 0
  local maxNum = Logic:Get("Friend"):GetFriendMax() or 1
  Logic:Get("Friend"):SendMsgAddFriend(self.memberData.name, true)
end
function prototype:onBtnSendMsg(sender, event)
  Logic:Get("Email"):SetReply(self.memberData.name)
  SceneHelper:removePrompt(self.rootNode)
  SceneHelper:pushPrompt("SendEmail", self.rootNode)
end
function prototype:onBtnKick(sender, event)
  Prompt:Confirm(self, "", TwGetStr(110176, self.memberData.name), self.kickMember, Prompt.PROMPT_TYPE.SELECT)
end
function prototype:onBtnClose(sender, event)
  SceneHelper:removePrompt(self.rootNode, "SectMutual")
end
function prototype:DeSz()
  Logic:Get("Sect"):PostTransferBoss(self.memberData.playerId)
  SceneHelper:removePrompt(self.rootNode)
end
function prototype:kickMember()
  Logic:Get("Sect"):PostKickUser(self.memberData.playerId)
  SceneHelper:removePrompt(self.rootNode)
end
