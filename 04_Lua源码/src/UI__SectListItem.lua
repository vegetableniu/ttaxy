module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
local JoinState = TypeDef("com.eyu.mt.module.menpai.model.JoinState")
function prototype:onEnter()
  self.staName:setStyle(kCCLabelTTFStyleOutline)
  self.staMemCount:setStyle(kCCLabelTTFStyleOutline)
  self.staDeclCen:setStyle(kCCLabelTTFStyleOutline)
  self.labRange:setStyle(kCCLabelTTFStyleOutline)
  self.labSectHost:setStyle(kCCLabelTTFStyleOutline)
  self.staDeclCen:setDimensions(CCSize(420, 0))
end
function prototype:refreshInfo(info, isHideApply)
  self:clear()
  self.info = info
  self.sprBg:setVisible(false)
  self.sprFirst:setVisible(false)
  self.staName:setString(info.name)
  self.staDeclCen:setString(info.declaration)
  self.Level:create(0, "YELLOW_E_NUM")
  self.Level:setAlign("LEFT", "CENTER")
  self.Level:setValue(info.level)
  self.staMemCount:setString(string.format("%d/%d", info.count, info.maxCount))
  self.labSectHost:setString(TwGetStr(110048, info.bossName))
  if info.rank == 1 then
    self.ani = Logic:Get("AniMgr"):NewCCB("UI/uiz01", self.aniNode, ccp(162, -145))
    self.ani:RunAni()
    self.sprBg:setVisible(true)
    self.sprFirst:setVisible(true)
    self.labRange:setString("")
  else
    if info.rank == 2 then
      self.labRange:setColor(ccColor3B(38, 192, 255))
    elseif info.rank == 3 then
      self.labRange:setColor(ccColor3B(0, 249, 0))
    else
      self.labRange:setColor(ccColor3B(255, 255, 255))
    end
    self.labRange:setString(TwGetStr(110122, info.rank))
  end
  if isHideApply then
    self.btnCancel:setVisible(false)
    self.ttfCancel:setVisible(false)
    self.btnApply:setVisible(false)
    self.ttfApply:setVisible(false)
    return
  end
  if info.joinState == JoinState.APPLY or info.joinState == JoinState.JOINED or info.joinState == JoinState.INVITE then
    self.btnCancel:setVisible(true)
    self.ttfCancel:setVisible(true)
    self.btnApply:setVisible(false)
    self.ttfApply:setVisible(false)
  else
    self.btnApply:setVisible(true)
    self.ttfApply:setVisible(true)
    self.btnCancel:setVisible(false)
    self.ttfCancel:setVisible(false)
  end
end
function prototype:onBtnApply()
  Prompt:Confirm(self, "", TwGetStr(110104, self.info.name), self.SendApply, Prompt.PROMPT_TYPE.SELECT)
end
function prototype:onBtnCancel()
  Prompt:Confirm(self, "", TwGetStr(110164), self.SendCancelJoin, Prompt.PROMPT_TYPE.SELECT)
end
function prototype:SendApply()
  Logic:Get("Sect"):PostJoinMenpai(self.info.id)
end
function prototype:SendCancelJoin()
  Logic:Get("Sect"):PostCancelJoinMenpai(self.info.id)
end
function prototype:clear()
  self.staName:setString("")
  self.staMemCount:setString("")
  self.staDeclCen:setString("")
  self.labRange:setString("")
  self.labSectHost:setString("")
  self.labRange:setColor(ccColor3B(255, 255, 255))
  if self.ani then
    self.ani:RemoveAnimation()
  end
end
