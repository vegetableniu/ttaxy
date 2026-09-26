module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
require("SceneHelper")
require("Logic.Friend")
function prototype.onEnter(A0_0)
  if not A0_0:EventTracer():Exist("RefrashDatat") then
    Logic:Get("Friend"):On(Logic.Friend.EVT.MUTUAL_CHANGE, A0_0:Event("RefrashMutual"))
  end
  A0_0:RefrashMutual()
end
function prototype.RefrashMutual(A0_1)
  A0_1:SetAllBtnEnableFalse()
  A0_1.checkedFriend = Logic:Get("Friend"):GetFriendById(Logic:Get("Friend"):GetCheckedFriendId())
  if A0_1.checkedFriend == nil or next(A0_1.checkedFriend) == nil then
    return false
  end
  A0_1.btnDelete:setEnabled(true)
  A0_1.btnSendMsg:setEnabled(true)
  A0_1.btnInviteSect:setEnabled(true)
  A0_1.staInviteSect:setString(TwGetStr(110137))
  A0_1.staSendMsg:setString(TwGetStr(101031))
  A0_1.staDelete:setString(TwGetStr(101032))
  A0_1.staToRecv:setString(TwGetStr(101010))
  A0_1.staToSend:setString(TwGetStr(101008))
  if Logic:Get("Lock"):checkStatusById("MENPAI") then
    A0_1.staInviteSect:setString("")
    A0_1.btnInviteSect:setEnabled(false)
  end
  if Logic:Get("Sect"):getSectId() == ID[-1] or not Logic:Get("Sect"):checkAuth(Logic:Get("Sect"):GetJob(), "INVITE") then
    A0_1.btnInviteSect:setEnabled(false)
    A0_1.staInviteSect:setColor(ccColor3B(128, 128, 128))
  end
  if Logic:Get("Friend"):IsRecvPhysicalById(A0_1.checkedFriend.id) then
    A0_1.btnToRecv:setEnabled(true)
    if Logic:Get("Friend"):IsRecved(A0_1.checkedFriend.id) then
      A0_1.staToRecv:setString(TwGetStr(101011))
      A0_1.staToRecv:setColor(ccColor3B(128, 128, 128))
      A0_1.btnToRecv:setEnabled(false)
    end
  elseif Logic:Get("Friend"):IsRecved(A0_1.checkedFriend.id) then
    A0_1.staToRecv:setString(TwGetStr(101011))
    A0_1.staToRecv:setColor(ccColor3B(128, 128, 128))
    A0_1.btnToRecv:setEnabled(false)
  else
    A0_1.staToRecv:setColor(ccColor3B(128, 128, 128))
    A0_1.btnToRecv:setEnabled(false)
  end
  if not Logic:Get("Friend"):IsPresend(Logic:Get("Friend"):GetCheckedFriendId()) then
    A0_1.btnToSend:setEnabled(true)
  else
    A0_1.staToSend:setString(TwGetStr(101009))
    A0_1.staToSend:setColor(ccColor3B(128, 128, 128))
    A0_1.btnToSend:setEnabled(false)
  end
  A0_1.staName:setStyle(kCCLabelTTFStyleOutline)
  A0_1.staName:setColor(ccColor3B(187, 255, 0))
  A0_1.staName:setString(A0_1.checkedFriend.name or "")
  if A0_1.checkedFriend.score ~= nil then
    A0_1.staScore:create(A0_1.checkedFriend.score)
  end
  A0_1.m_pHeroIcon:ReFrashHeroInfo(A0_1.checkedFriend.baseId, false, "HERO")
end
function prototype.onBtnToSend(A0_2, A1_3, A2_4)
  if A0_2.checkedFriend ~= nil and next(A0_2.checkedFriend) ~= nil then
    Logic:Get("Friend"):SendMsgPhysical(A0_2.checkedFriend.id)
  end
end
function prototype.onBtnToRecv(A0_5, A1_6, A2_7)
  Logic:Get("BGSound"):PlayEffect("audio/getpower.mp3")
  if A0_5.checkedFriend ~= nil and next(A0_5.checkedFriend) ~= nil then
    Logic:Get("Friend"):MsgRecvPhysical(A0_5.checkedFriend.id)
  end
end
function prototype.onBtnSendMsg(A0_8, A1_9, A2_10)
  Logic:Get("Email"):SetReply(A0_8.checkedFriend.name)
  SceneHelper:removePrompt(A0_8.rootNode)
  SceneHelper:pushPrompt("SendEmail", A0_8.rootNode)
end
function prototype.onBtnInviteSect(A0_11, A1_12, A2_13)
  if A0_11.checkedFriend ~= nil and next(A0_11.checkedFriend) ~= nil then
    Logic:Get("Sect"):PostInvitePartner(A0_11.checkedFriend.id)
  end
end
function prototype.onConf(A0_14)
  Logic:Get("Friend"):SendMsgRemoveFriend(A0_14.checkedFriend.id)
end
function prototype.onBtnDelete(A0_15, A1_16, A2_17)
  if A0_15.checkedFriend and A0_15.checkedFriend.id then
    SceneHelper:removePrompt(A0_15.rootNode)
    Prompt:Confirm(A0_15, 103001, 101017, A0_15.onConf, Prompt.PROMPT_TYPE.SELECT)
  end
end
function prototype.onBtnClose(A0_18, A1_19, A2_20)
  SceneHelper:removePrompt(A0_18.rootNode)
end
function prototype.SetAllBtnEnableFalse(A0_21)
  A0_21.btnToSend:setEnabled(true)
  A0_21.btnToRecv:setEnabled(true)
  A0_21.btnSendMsg:setEnabled(true)
  A0_21.btnDelete:setEnabled(true)
  A0_21.staToSend:setColor(ccColor3B(255, 255, 255))
  A0_21.staToRecv:setColor(ccColor3B(255, 255, 255))
end
