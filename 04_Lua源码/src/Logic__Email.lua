local L0_0
L0_0 = require
L0_0("Logic")
L0_0 = module
L0_0((...), package.seeall)
L0_0 = Logic
L0_0 = L0_0.class
L0_0 = L0_0.subclass
L0_0 = L0_0(L0_0)
class = L0_0
L0_0 = {}
L0_0.EMAIL_GET = 1
L0_0.EMAIL_CHANGE = 2
L0_0.EMAIL_NEWMAIL = 3
EVT = L0_0
L0_0 = Enum
L0_0 = L0_0(TypeDef("com.eyu.mt.module.email.facade.EmailResult"))
function class.initialize(A0_1)
  super.initialize(A0_1)
  Logic:Get("MsgAssist"):RecordErrorMsg("MsgEmail", _UPVALUE0_, _UPVALUE1_)
  MsgEmail:On("GET_MAILBOX", A0_1:Event("OnMsgGetMail"))
  MsgEmail:On("SEND_USERMAIL", A0_1:Event("onMsgSendEmail"))
  MsgEmail:On("READ_MAIL", A0_1:Event("onMsgReadEmail"))
  MsgEmail:On("REMOVE_MAIL", A0_1:Event("OnMsgRemoveEmail"))
  MsgEmail:On("DRAW_USER", A0_1:Event("OnMsgDrawReward"))
  MsgEmail:On("REMOVE_ALL_MAIL", A0_1:Event("OnRemoveAllMail"))
  Singleton(NetMgr):On(NetMgr.EVT.EMAIL, A0_1:Event("OnNetNewEmail"))
  A0_1.clientEmail = {}
  A0_1.myMail = {}
  A0_1.reply = {}
  A0_1.readEmail = {}
  A0_1.haveNewMail = false
  A0_1.addClientEmail = true
end
function class.OnNetNewEmail(A0_2)
  A0_2:SetNewMailPro(true)
end
function class.SetNewMailPro(A0_3, A1_4)
  A0_3.haveNewMail = A1_4
  A0_3:FireEvent(EVT.EMAIL_NEWMAIL)
end
function class.GetNewMailPro(A0_5)
  local L1_6
  L1_6 = A0_5.haveNewMail
  return L1_6
end
function class.InspectNewEmail(A0_7)
  local L1_8
  L1_8 = false
  for _FORV_5_, _FORV_6_ in pairs(A0_7.myMail) do
    if not _FORV_6_.readed then
      L1_8 = true
    end
  end
  A0_7:SetNewMailPro(L1_8)
end
function class.SendMsgGetEmail(A0_9)
  MsgEmail:Post("GET_MAILBOX")
end
function class.OnMsgGetMail(A0_10, A1_11, A2_12)
  for _FORV_6_ = 1, #A2_12.receives do
    if A2_12.receives[_FORV_6_].attachment then
      if A2_12.receives[_FORV_6_].readed == false then
        A2_12.receives[_FORV_6_].sort = 0
      elseif A2_12.receives[_FORV_6_].drawed == false then
        A2_12.receives[_FORV_6_].sort = 1
      elseif A2_12.receives[_FORV_6_].drawed == true then
        A2_12.receives[_FORV_6_].sort = 3
      end
    elseif A2_12.receives[_FORV_6_].readed == false then
      A2_12.receives[_FORV_6_].sort = 2
    else
      A2_12.receives[_FORV_6_].sort = 3
    end
  end
  if not _FOR_.empty(A2_12.receives) then
    table.sort(A2_12.receives, function(A0_13, A1_14)
      local L2_15, L3_16
      L2_15 = A0_13.sort
      L3_16 = A1_14.sort
      if L2_15 == L3_16 then
        L2_15 = A0_13.createTime
        L3_16 = A1_14.createTime
        L2_15 = L2_15 > L3_16
        return L2_15
      else
        L2_15 = A0_13.sort
        L3_16 = A1_14.sort
        L2_15 = L2_15 < L3_16
        return L2_15
      end
    end)
  end
  A0_10.addClientEmail = true
  A0_10.myMail = A2_12.receives
  A0_10:InspectNewEmail()
  A0_10:FireEvent(EVT.EMAIL_GET)
end
function class.GetMyEmail(A0_17)
  if A0_17.addClientEmail == true and A0_17.clientEmail ~= nil and not table.empty(A0_17.clientEmail) then
    table.insert(A0_17.myMail, A0_17.clientEmail)
    A0_17.addClientEmail = false
    if not table.empty(A0_17.myMail) then
      table.sort(A0_17.myMail, function(A0_18, A1_19)
        local L2_20, L3_21
        L2_20 = A0_18.sort
        L3_21 = A1_19.sort
        if L2_20 == L3_21 then
          L2_20 = A0_18.createTime
          L3_21 = A1_19.createTime
          L2_20 = L2_20 > L3_21
          return L2_20
        else
          L2_20 = A0_18.sort
          L3_21 = A1_19.sort
          L2_20 = L2_20 < L3_21
          return L2_20
        end
      end)
    end
  end
  return A0_17.myMail
end
function class.SendeMailToOther(A0_22, A1_23)
  MsgEmail:Post("SEND_USERMAIL", {
    content = A1_23.content,
    target = A1_23.target,
    title = A1_23.title
  })
end
function class.onMsgSendEmail(A0_24, A1_25, A2_26)
  A0_24.reply = ""
  Prompt:Msg(101103)
end
function class.SetReply(A0_27, A1_28)
  A0_27.reply = A1_28
end
function class.GetReply(A0_29)
  local L1_30
  L1_30 = A0_29.reply
  return L1_30
end
function class.SendMsgReadEmail(A0_31, A1_32, A2_33)
  MsgEmail:Post("READ_MAIL", {mailId = A1_32, target = A2_33})
end
function class.onMsgReadEmail(A0_34, A1_35, A2_36)
  if A0_34.readEmail then
    A0_34.readEmail.readed = true
    A0_34:ChangeMailById(A0_34.readEmail.id, A0_34.readEmail)
  end
end
function class.SetReadEmail(A0_37, A1_38)
  A0_37.readEmail = A1_38
end
function class.GetReadEmail(A0_39)
  local L1_40
  L1_40 = A0_39.readEmail
  return L1_40
end
function class.ChangeMailById(A0_41, A1_42, A2_43)
  for _FORV_6_ = 1, #A0_41.myMail do
    if A0_41.myMail[_FORV_6_].id == A1_42 then
      A0_41.myMail[_FORV_6_] = A2_43
    end
    if A0_41.myMail[_FORV_6_].attachment then
      if A0_41.myMail[_FORV_6_].readed == false then
        A0_41.myMail[_FORV_6_].sort = 0
      elseif A0_41.myMail[_FORV_6_].drawed == false then
        A0_41.myMail[_FORV_6_].sort = 1
      elseif A0_41.myMail[_FORV_6_].drawed == true then
        A0_41.myMail[_FORV_6_].sort = 3
      end
    elseif A0_41.myMail[_FORV_6_].readed == false then
      A0_41.myMail[_FORV_6_].sort = 2
    else
      A0_41.myMail[_FORV_6_].sort = 3
    end
  end
  if not _FOR_.empty(A0_41.myMail) then
    table.sort(A0_41.myMail, function(A0_44, A1_45)
      local L2_46, L3_47
      L2_46 = A0_44.sort
      L3_47 = A1_45.sort
      if L2_46 == L3_47 then
        L2_46 = A0_44.createTime
        L3_47 = A1_45.createTime
        L2_46 = L2_46 > L3_47
        return L2_46
      else
        L2_46 = A0_44.sort
        L3_47 = A1_45.sort
        L2_46 = L2_46 < L3_47
        return L2_46
      end
    end)
  end
  A0_41:InspectNewEmail()
  A0_41:FireEvent(EVT.EMAIL_CHANGE)
end
function class.GetMailById(A0_48, A1_49)
  for _FORV_5_, _FORV_6_ in pairs(A0_48.myMail) do
    if A1_49 == _FORV_6_.id then
      return _FORV_6_
    end
  end
  return nil
end
function class.SendEmailDelete(A0_50, A1_51)
  MsgEmail:Post("REMOVE_MAIL", {targets = A1_51})
end
function class.OnMsgRemoveEmail(A0_52, A1_53, A2_54)
  local L3_55, L4_56, L5_57, L6_58
  for L6_58, _FORV_7_ in L3_55(L4_56) do
    if _FORV_7_.id == A0_52.readEmail.id then
      table.remove(A0_52.myMail, L6_58)
      A0_52.readEmail = {}
      break
    end
  end
  L3_55(L4_56)
  L3_55(L4_56, L5_57)
end
function class.SendMsgGetReward(A0_59, A1_60, A2_61)
  MsgEmail:Post("DRAW_USER", {mailId = A1_60, target = A2_61})
end
function class.CanNotDrawActionMail(A0_62, A1_63)
  local L2_64, L3_65, L4_66, L5_67, L6_68, L7_69
  L2_64 = table
  L2_64 = L2_64.empty
  L2_64 = L2_64(L3_65)
  if L2_64 then
    L2_64 = false
    return L2_64
  end
  L2_64 = false
  for L6_68, L7_69 in L3_65(L4_66) do
    if Logic:Get("Reward"):IsActionPoint(L7_69) then
      L2_64 = true
      break
    end
  end
  L3_65 = L2_64 and L3_65(L4_66)
  return L3_65
end
function class.OnMsgDrawReward(A0_70, A1_71, A2_72)
  Logic:Get("Reward"):AddRewards(A2_72, true)
  A0_70.readEmail.drawed = true
  A0_70:ChangeMailById(A0_70.readEmail.id, A0_70.readEmail)
end
function class.SendNewEmain(A0_73, A1_74, A2_75, A3_76, A4_77)
  local L5_78, L6_79, L7_80, L8_81, L9_82, L10_83
  L5_78 = Logic
  L6_79 = L5_78
  L5_78 = L5_78.Get
  L7_80 = "PlayerInfo"
  L5_78 = L5_78(L6_79, L7_80)
  L6_79 = L5_78
  L5_78 = L5_78.GetPlayerName
  L5_78 = L5_78(L6_79)
  L6_79 = Logic
  L7_80 = L6_79
  L6_79 = L6_79.Get
  L8_81 = "System"
  L6_79 = L6_79(L7_80, L8_81)
  L7_80 = L6_79
  L6_79 = L6_79.GetTime
  L6_79 = L6_79(L7_80)
  L6_79 = L6_79 * 1000
  A3_76 = A3_76 or L6_79
  L7_80 = KFDBGetRecord
  L8_81 = "MailTemplate"
  L9_82 = 70001
  L7_80 = L7_80(L8_81, L9_82)
  L8_81 = ""
  if L7_80 then
    L9_82 = table
    L9_82 = L9_82.empty
    L10_83 = L7_80
    L9_82 = L9_82(L10_83)
    if not L9_82 then
      L9_82 = L7_80.content
      L9_82 = L9_82 or ""
      A0_73.fdbStr = L9_82
      L9_82 = string
      L9_82 = L9_82.gsub
      L10_83 = A0_73.fdbStr
      L9_82 = L9_82(L10_83, "%$content%$", A1_74)
      L8_81 = L9_82
    end
  end
  L9_82 = {}
  L9_82.destoryTime = 2391889795000
  L10_83 = {}
  L10_83.id = 5201314
  L10_83.type = 0
  L9_82.groupTarget = L10_83
  L9_82.title = ""
  L9_82.id = 5201314
  L9_82.template = -1
  L9_82.system = true
  L9_82.drawed = true
  L9_82.senderId = -1
  L9_82.receiver = L5_78
  L9_82.readed = A2_75
  L9_82.createTime = A3_76
  L9_82.mailType = 1
  L9_82.content = L8_81
  L9_82.mailState = 8
  L9_82.client = true
  if A2_75 then
    L10_83 = 3
  else
    L10_83 = L10_83 or 2
  end
  L9_82.sort = L10_83
  A0_73.clientEmail = L9_82
  L9_82 = {}
  L9_82.readed = false
  L9_82.content = A4_77
  L9_82.time = A3_76
  L10_83 = json
  L10_83 = L10_83.encode
  L10_83 = L10_83(L9_82)
  Logic:Get("System"):SetUsrVariableMisc("UV_EMAIL", L10_83)
  table.insert(A0_73.myMail, A0_73.clientEmail)
  A0_73:SetNewMailPro(not A2_75)
  A0_73:FireEvent(EVT.EMAIL_GET)
end
function class.SetClientEmail(A0_84, A1_85)
  A0_84.clientEmail = A1_85
end
function class.PostRemoveAllMail(A0_86, A1_87)
  MsgEmail:Post("REMOVE_ALL_MAIL", {targets = A1_87})
end
function class.OnRemoveAllMail(A0_88, A1_89, A2_90)
  local L3_91, L4_92, L5_93
  if A1_89 == 0 then
    if A2_90 then
      L3_91 = Logic
      L4_92 = L3_91
      L3_91 = L3_91.Get
      L5_93 = "Reward"
      L3_91 = L3_91(L4_92, L5_93)
      L4_92 = L3_91
      L3_91 = L3_91.AddRewards
      L5_93 = A2_90
      L3_91(L4_92, L5_93)
      L3_91 = Logic
      L4_92 = L3_91
      L3_91 = L3_91.Get
      L5_93 = "Reward"
      L3_91 = L3_91(L4_92, L5_93)
      L4_92 = L3_91
      L3_91 = L3_91.AddDupiCardTip
      L5_93 = A2_90
      L4_92 = L3_91(L4_92, L5_93)
      L5_93 = {}
      L5_93.list = L4_92
      Prompt:TableViewConfirm(A0_88, L5_93)
    else
      L3_91 = Prompt
      L4_92 = L3_91
      L3_91 = L3_91.Fail
      L5_93 = TwGetStr
      L5_93 = L5_93(101113)
      L3_91(L4_92, L5_93, L5_93(101113))
    end
    L4_92 = A0_88
    L3_91 = A0_88.deleteClientEmail
    L3_91(L4_92)
    L4_92 = A0_88
    L3_91 = A0_88.SendMsgGetEmail
    L3_91(L4_92)
  end
end
function class.deleteClientEmail(A0_94)
  local L1_95
  L1_95 = Logic
  L1_95 = L1_95.Get
  L1_95 = L1_95(L1_95, "Email")
  L1_95 = L1_95.OnMsgRemoveEmail
  L1_95(L1_95, 0)
  L1_95 = A0_94.SetClientEmail
  L1_95(A0_94, {})
  L1_95 = json
  L1_95 = L1_95.encode
  L1_95 = L1_95({})
  Logic:Get("System"):SetUsrVariableMisc("UV_EMAIL", L1_95)
end
