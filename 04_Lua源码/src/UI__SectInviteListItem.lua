module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
local JobType = TypeDef("com.eyu.mt.module.menpai.model.JobType")
function prototype:onEnter()
  self.labShow1:setStyle(kCCLabelTTFStyleOutline)
  self.labShow2:setStyle(kCCLabelTTFStyleOutline)
  self.labShow3:setStyle(kCCLabelTTFStyleOutline)
  self.labShow4:setStyle(kCCLabelTTFStyleOutline)
end
function prototype:refreshInfo(info)
  self.info = info
  local job = ""
  if info.inviteJob == JobType.BOSS then
    job = TwGetStr(110138)
  elseif info.inviteJob == JobType.ELDER then
    job = TwGetStr(110139)
  elseif info.inviteJob == JobType.MEMBER then
    job = TwGetStr(110140)
    self.sprJoin:setVisible(false)
    self.sprApply:setVisible(true)
  end
  self.labShow1:setString(info.name)
  local xPos = self.labShow1:getPositionX()
  local size = self.labShow1:getContentSize()
  local yPos = self.labShow2:getPositionY()
  self.labShow2:setPosition(ccp(xPos + size.width, yPos))
  self.labShow2:setString(TwGetStr(110123, job))
  self.labShow3:setString(info.inviteName)
  self.labShow4:setString(TwGetStr(110124))
end
function prototype:onBtnAgree()
  if self.info.inviteJob == JobType.MEMBER then
    Logic:Get("Sect"):PostJoinMenpai(self.info.id)
    return
  end
  Logic:Get("Sect"):PostCheckInviteMenpai(true, self.info.inviteId)
end
function prototype:onBtnIgnore()
  Logic:Get("Sect"):PostCheckInviteMenpai(false, self.info.inviteId)
end
