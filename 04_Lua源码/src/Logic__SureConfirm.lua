module((...), package.seeall)
class = Logic.class:subclass()
EVT = Enum({
  "CLOSE_POPTIP"
})
RET = Enum({"OK", "CANCEL"})
RECORD_TYPE = {
  CHRIST_REFRESH = "CHRIST_REFRESH",
  CHRIST_ADV_REFRESH = "CHRIST_ADV_REFRESH",
  ADV_LOOK_FOR = "ADV_LOOK_FOR",
  SECT_MAMMON = "SECT_MAMMON",
  DUMPLING_CLEAR_COOLTIME = "DUMPLING_CLEAR_COOLTIME",
  SMASH_EGG_ONCE = "SMASH_EGG_ONCE",
  SMASH_EGG_TENTH = "SMASH_EGG_TENTH",
  SMASH_EGG_FIFTY = "SMASH_EGG_FIFTY",
  OPEN_BOX_GREEN = "OPEN_BOX_GREEN",
  OPEN_BOX_BLUE = "OPEN_BOX_BLUE",
  OPEN_BOX_PURPLE = "OPEN_BOX_PURPLE",
  TREASUREROOM_REFRESH = "TREASUREROOM_REFRESH",
  RAFFLE_RESET = "RAFFLE_RESET",
  RAFFLE = "RAFFLE",
  FLOP = "FLOP",
  FOOLSDAY_RESET = "FOOLSDAY_RESET",
  CLOSE_SECT_FIGHT = "CLOSE_SECT_FIGHT",
  MYSTIC_SHOP = "MYSTIC_SHOP",
  SHOOT = "SHOOT",
  GEMROOM_REFRESH = "GEMROOM_REFRESH",
  MOON_1 = "MOON_1",
  MOON_10 = "MOON_10",
  CULT_EXCHANGE = "CULT_EXCHANGE",
  CULT_REFRESH = "CULT_REFRESH",
  MAKET_URKEY = "MAKET_URKEY",
  EAT_URKEY = "EAT_URKEY"
}
function class:initialize()
  super.initialize(self)
  self.confirm = {}
  self.btnText = {}
  self.popTip = {}
  self.comment = false
  self.promptFlag = false
  self.openRecordFrameList = {}
  self.curFrame = ""
end
function class:SetConfirm(...)
  self.confirm = (...)
end
function class:GetConfirm()
  return self.confirm
end
function class:SetBtnText(...)
  self.btnText = (...)
end
function class:GetBtnText()
  return self.btnText
end
function class:SetConfirmNil()
  self.confirm = {}
  self.fontSize = 25
end
function class:OpenConfirm()
end
function class:SetAni(bool)
  self.ani = bool
end
function class:GetAniBool()
  return self.ani
end
function class:SetPopTip(...)
  self.popTip = (...)
end
function class:GetPopTip()
  return self.popTip
end
function class:SetPopTipColor(color)
  self.popTipColor = color or ccColor3B(255, 0, 0)
end
function class:GetPopTipColor()
  return self.popTipColor or ccColor3B(255, 0, 0)
end
function class:SetCommentTip(boolean)
  self.comment = boolean
end
function class:GetComment()
  if Logic:Get("System"):IsChannel("taiwsqios") then
    return false
  end
  return self.comment
end
function class:SetMonVipShow(boolean)
  self.showVip = boolean
end
function class:GetMonVipShow()
  return self.showVip
end
function class:getPromptFlag()
  return self.promptFlag
end
function class:setPromptFlag(flag)
  self.promptFlag = flag
end
function class:setCurFrame(str)
  self.curFrame = str
end
function class:clearAllFrame()
  self.openRecordFrameList = {}
end
function class:getCurFramePromptFlag()
  return self.openRecordFrameList[self.curFrame]
end
function class:getPromptFlagByFrame(frame)
  if nil == self.openRecordFrameList[frame] then
    return false
  end
  return self.openRecordFrameList[frame]
end
function class:setCurFramePromptFlag(flag)
  self.openRecordFrameList[self.curFrame] = flag
end
function class:clear()
  Logic:Get("SureConfirm"):SetBtnText({
    ok = TwGetStr(103002),
    cancel = TwGetStr(103003)
  })
  Logic:Get("SureConfirm"):SetAni(false)
  Logic:Get("SureConfirm"):setCurFrame("")
end
function class:setFontSize(fontSize)
  self.fontSize = fontSize
end
function class:getFontSize()
  return self.fontSize
end
