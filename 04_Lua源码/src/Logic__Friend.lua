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
L0_0.FRIEND_CHANGE = 1
L0_0.MUTUAL_CHANGE = 2
L0_0.FRIENDMAIN_CHANGE = 3
L0_0.NEW_FRIEND = 4
EVT = L0_0
L0_0 = {}
L0_0.FRIEND = 1
L0_0.OTHER = 2
L0_0.FRIENDADD = 3
FRIEND_ITEM_TYPE = L0_0
L0_0 = 20
PAGE_MAX_LISTNUM = L0_0
L0_0 = 3
function class.initialize(A0_1)
  super.initialize(A0_1)
  Logic:Get("MsgAssist"):RecordErrorMsg("MsgSociality", _UPVALUE0_, _UPVALUE1_)
  MsgSociality:On("GET_SOCIALITY", A0_1:Event("OnMsgGetFriend"), true)
  MsgSociality:On("APPLY_FRIEND", A0_1:Event("OnMsgAddFriend"), false)
  MsgSociality:On("REMOVE_FRIEND", A0_1:Event("OnMsgRemoveFriend"), true)
  MsgSociality:On("APPLY_CONFIRM", A0_1:Event("OnMsgHandleAskInfo"), false)
  MsgSociality:On("SEND_POINT", A0_1:Event("OnMsgSendPhysical"), true)
  MsgSociality:On("RECV_POINT", A0_1:Event("OnMsgRecvPhysical"), true)
  MsgSociality:On("COMMEND_FRIEND", A0_1:Event("OnMsgCommendFriend"), true)
  Singleton(NetMgr):On(NetMgr.EVT.FRIEND, A0_1:Event("OnNetNewFrien"))
  Singleton(NetMgr):On(NetMgr.EVT.FRIEND_GIFT, A0_1:Event("OnNetNewFriendGift"))
  A0_1.friendInfo = {}
  A0_1.askFriend = {}
  A0_1.checkedId = 0
  A0_1.recvPhysical = {}
  A0_1.presend = {}
  A0_1.recved = {}
  A0_1.removeFriendId = 0
  A0_1.bAgree = false
  A0_1.handleAskHero = 0
  A0_1.buyNum = 0
  A0_1.commendFriend = {}
  A0_1.allFriendId = {}
  A0_1.loginFriendInfo = {}
  A0_1.bPrompt = false
  A0_1.getHelperTime = 0
  A0_1.getFriendTime = 0
  A0_1.hasDemog = false
end
function class.OnNetNewFrien(A0_2)
  A0_2:SetFriendPrompt(true)
end
function class.OnNetNewFriendGift(A0_3)
  A0_3:SetFriendPrompt(true)
end
function class.SetFriendPrompt(A0_4, A1_5)
  A0_4.bPrompt = A1_5
  A0_4:FireEvent(EVT.NEW_FRIEND)
end
function class.InspectNewFriend(A0_6)
  local L1_7
  L1_7 = false
  if A0_6.askFriend and not table.empty(A0_6.askFriend) then
    L1_7 = true
  end
  A0_6:SetFriendPrompt(L1_7)
end
function class.GetFriendPrompt(A0_8)
  local L1_9
  L1_9 = A0_8.bPrompt
  return L1_9
end
function class.InitFriendInfo(A0_10, A1_11)
  if A1_11 == nil or table.empty(A1_11) then
    return
  end
  A0_10.allFriendId = A1_11.friends
  A0_10.buyNum = A1_11.extendCount
  A0_10:SetFriendPrompt(A1_11.apply)
end
function class.SendMsgAddFriend(A0_12, A1_13, A2_14)
  MsgSociality:Post("APPLY_FRIEND", {name = A1_13})
  A0_12.isPrompt = A2_14
  A0_12.hasDemog = Logic:Get("Devil"):GetHasDemog()
end
function class.OnMsgAddFriend(A0_15, A1_16, A2_17)
  if nil ~= Logic:Get("FriendInvite"):isSend() and Logic:Get("FriendInvite"):isSend() then
    Logic:Get("FriendInvite"):setSend(false)
    if A1_16 == 0 then
      Logic:Get("FriendInvite"):InviteSuccess()
    else
      Logic:Get("FriendInvite"):InviteFail()
    end
    return
  end
  if A1_16 == 0 and A0_15.isPrompt then
    Prompt:Msg(101012)
    return
  end
  if not A0_15.hasDemog then
    Logic:Get("MsgAssist"):OnMsgResult("MsgSociality", A1_16)
  end
  A0_15.hasDemog = false
end
function class.AddFriend(A0_18, A1_19)
  if A1_19 == nil or next(A1_19) == nil then
    return
  end
  if A0_18.friendInfo then
    table.insert(A0_18.friendInfo, A1_19)
  end
  A0_18:AddFriendId(A1_19.id)
end
function class.SendMsgRemoveFriend(A0_20, A1_21)
  MsgSociality:Post("REMOVE_FRIEND", {friendId = A1_21})
  A0_20.removeFriendId = A1_21
end
function class.OnMsgRemoveFriend(A0_22, A1_23, A2_24)
  if A1_23 == 0 and A0_22.removeFriendId ~= 0 then
    A0_22:DeleteFriendById(A0_22.removeFriendId)
    A0_22.removeFriendId = 0
  end
end
function class.DeleteFriendById(A0_25, A1_26)
  local L2_27, L3_28, L4_29, L5_30
  if L2_27 == nil then
    return
  end
  for L5_30, _FORV_6_ in L2_27(L3_28) do
    if _FORV_6_.id == A1_26 then
      table.remove(A0_25.friendInfo, L5_30)
      break
    end
  end
  L2_27(L3_28, L4_29)
  L2_27(L3_28, L4_29)
end
function class.GetFriendById(A0_31, A1_32)
  for _FORV_5_, _FORV_6_ in pairs(A0_31.friendInfo) do
    if _FORV_6_.id == A1_32 then
      return _FORV_6_
    end
  end
  return nil
end
function class.SendMsgGetMyFriend(A0_33)
  MsgSociality:Post("GET_SOCIALITY")
end
function class.OnMsgGetFriend(A0_34, A1_35, A2_36)
  if A1_35 == 0 then
    if A2_36 == nil then
      return
    end
    A0_34.friendInfo = A2_36.friends
    A0_34:UpdataFriendID(A0_34.friendInfo)
    A0_34.askFriend = A2_36.applys
    A0_34.recved = A2_36.recvs
    A0_34.presend = A2_36.sends
    A0_34.recvPhysical = A2_36.gifts
    A0_34.getFriendTime = Logic:Get("System"):GetTime()
    A0_34:FireEvent(EVT.FRIEND_CHANGE)
  end
end
function class.GetFriendInfo(A0_37)
  local L1_38
  L1_38 = A0_37.friendInfo
  return L1_38
end
function class.GetRefrashTime(A0_39)
  local L1_40
  L1_40 = A0_39.getFriendTime
  return L1_40
end
function class.AddFriendId(A0_41, A1_42)
  for _FORV_6_, _FORV_7_ in pairs(A0_41.allFriendId) do
  end
  if not true then
    table.insert(A0_41.allFriendId, A1_42)
  end
end
function class.DeleteFriendId(A0_43, A1_44)
  local L2_45, L3_46, L4_47, L5_48
  if L2_45 == nil then
    return
  end
  for L5_48, _FORV_6_ in L2_45(L3_46) do
    if _FORV_6_ == A1_44 then
      table.remove(A0_43.allFriendId, L5_48)
      break
    end
  end
end
function class.UpdataFriendID(A0_49, A1_50)
  A0_49.allFriendId = {}
  for _FORV_5_, _FORV_6_ in pairs(A1_50) do
    table.insert(A0_49.allFriendId, _FORV_6_.id)
  end
end
function class.GetAllFriendId(A0_51)
  local L1_52
  L1_52 = A0_51.allFriendId
  return L1_52
end
function class.FindFriendId(A0_53, A1_54)
  local L2_55
  L2_55 = false
  for _FORV_6_, _FORV_7_ in pairs(A0_53.allFriendId) do
    if _FORV_7_ == A1_54 then
      L2_55 = true
    end
  end
  return L2_55
end
function class.GetAskFriend(A0_56)
  local L1_57
  L1_57 = A0_56.askFriend
  return L1_57
end
function class.RemoveAskFriendById(A0_58, A1_59)
  local L2_60, L3_61, L4_62, L5_63
  if L2_60 == nil then
    return
  end
  for L5_63, _FORV_6_ in L2_60(L3_61) do
    if _FORV_6_.id == A1_59 then
      table.remove(A0_58.askFriend, L5_63)
      break
    end
  end
  L2_60(L3_61, L4_62)
end
function class.SetCheckedFriendId(A0_64, A1_65)
  A0_64.checkedId = A1_65
end
function class.GetCheckedFriendId(A0_66)
  local L1_67
  L1_67 = A0_66.checkedId
  return L1_67
end
function class.SendMsgHandleAskInfo(A0_68, A1_69, A2_70)
  MsgSociality:Post("APPLY_CONFIRM", {allow = A1_69, friendId = A2_70})
  A0_68.bAgree = A1_69
end
function class.OnMsgHandleAskInfo(A0_71, A1_72, A2_73)
  local L3_74, L4_75, L5_76, L6_77, L7_78
  L3_74(L4_75, L5_76)
  if A1_72 == 0 then
    if A2_73 == nil then
      return
    end
    for L6_77, L7_78 in L3_74(L4_75) do
      if A0_71.bAgree then
        A0_71:AddFriend(L7_78)
      end
      break
    end
  else
    L6_77 = A1_72
    L3_74(L4_75, L5_76, L6_77)
  end
  L3_74(L4_75, L5_76)
end
function class.SetHandleAsk(A0_79, A1_80)
  A0_79.handleAskHero = A1_80
end
function class.GetRecvPhysicalFriend(A0_81)
  local L1_82
  L1_82 = A0_81.recvPhysical
  return L1_82
end
function class.IsRecvPhysicalById(A0_83, A1_84)
  if A0_83.recvPhysical == nil then
    return false
  end
  for _FORV_5_, _FORV_6_ in pairs(A0_83.recvPhysical) do
    if _FORV_6_ == A1_84 then
      return true
    end
  end
  return false
end
function class.GetRecvedFriend(A0_85)
  local L1_86
  L1_86 = A0_85.recved
  return L1_86
end
function class.IsRecved(A0_87, A1_88)
  if A0_87.recved == nil or A1_88 == nil then
    return true
  end
  for _FORV_5_, _FORV_6_ in pairs(A0_87.recved) do
    if _FORV_6_ == A1_88 then
      return true
    end
  end
  return false
end
function class.AddRecved(A0_89, A1_90)
  if A0_89.recved == nil or A1_90 == nil then
    return
  end
  table.insert(A0_89.recved, A1_90)
  A0_89:FireEvent(EVT.MUTUAL_CHANGE)
  A0_89:FireEvent(EVT.FRIENDMAIN_CHANGE)
end
function class.AddPresend(A0_91, A1_92)
  if A0_91.presend == nil or A1_92 == nil then
    return
  end
  table.insert(A0_91.presend, A1_92)
  A0_91:FireEvent(EVT.FRIENDMAIN_CHANGE)
  A0_91:FireEvent(EVT.MUTUAL_CHANGE)
end
function class.GetPresend(A0_93)
  local L1_94
  L1_94 = A0_93.presend
  return L1_94
end
function class.IsPresend(A0_95, A1_96)
  if A0_95.presend == nil then
    return false
  end
  for _FORV_5_, _FORV_6_ in pairs(A0_95.presend) do
    if _FORV_6_ == A1_96 then
      return true
    end
  end
  return false
end
function class.SendMsgPhysical(A0_97, A1_98)
  MsgSociality:Post("SEND_POINT", {friendId = A1_98})
  A0_97.sendId = A1_98
end
function class.OnMsgSendPhysical(A0_99, A1_100, A2_101)
  if A1_100 == 0 then
    A0_99:AddPresend(A0_99.sendId)
    Prompt:Msg(TwGetStr(101034))
  end
end
function class.MsgRecvPhysical(A0_102, A1_103)
  MsgSociality:Post("RECV_POINT", {friendId = A1_103})
  A0_102.sendId = A1_103
end
function class.OnMsgRecvPhysical(A0_104, A1_105, A2_106)
  if A1_105 == 0 then
    if A2_106 == nil then
      return
    end
    Logic:Get("Reward"):AddRewards(A2_106)
    A0_104:AddRecved(A0_104.sendId)
    Logic:Get("SureConfirm"):SetBtnText({
      cancel = TwGetStr(101035),
      ok = TwGetStr(103003)
    })
    Prompt:Select(A0_104, "", TwGetStr(101022, 0 or 0), A0_104.SendsPhy, Prompt.PROMPT_TYPE.SELECT)
  end
end
function class.SendsPhy(A0_107, A1_108)
  if A1_108 == Logic.SureConfirm.RET.CANCEL then
    A0_107:SendMsgPhysical(A0_107.sendId)
  end
end
function class.GetDaySendMax(A0_109)
  if KFDBGetRecord("ConfigValue", "SOCIALITY:GIFT_SENDS") and KFDBGetRecord("ConfigValue", "SOCIALITY:GIFT_SENDS").content then
    return tonumber(KFDBGetRecord("ConfigValue", "SOCIALITY:GIFT_SENDS").content)
  else
    return 0
  end
end
function class.GetDayRecvMax(A0_110)
  if KFDBGetRecord("ConfigValue", "SOCIALITY:GIFT_RECVS") and KFDBGetRecord("ConfigValue", "SOCIALITY:GIFT_RECVS").content then
    return tonumber(KFDBGetRecord("ConfigValue", "SOCIALITY:GIFT_RECVS").content)
  else
    return 0
  end
end
function class.GetFriendMax(A0_111)
  local L1_112
  L1_112 = Logic
  L1_112 = L1_112.Get
  L1_112 = L1_112(L1_112, "PlayerInfo")
  L1_112 = L1_112.GetPlayerLevel
  L1_112 = L1_112(L1_112)
  if Logic:Get("PlayerInfo"):GetFdbInfoByLevel(L1_112) then
    if KFDBGetRecord("ConfigValue", "SOCIALITY:BUY_PACK_SIZE") and KFDBGetRecord("ConfigValue", "SOCIALITY:BUY_PACK_SIZE").content then
    end
  end
  return Logic:Get("PlayerInfo"):GetFdbInfoByLevel(L1_112).friends + A0_111.buyNum * tonumber(KFDBGetRecord("ConfigValue", "SOCIALITY:BUY_PACK_SIZE").content)
end
function class.GetFriendNextMax(A0_113, A1_114)
  if Logic:Get("PlayerInfo"):GetFdbInfoByLevel(A1_114 + 1) then
    if KFDBGetRecord("ConfigValue", "SOCIALITY:BUY_PACK_SIZE") and KFDBGetRecord("ConfigValue", "SOCIALITY:BUY_PACK_SIZE").content then
    end
  end
  return Logic:Get("PlayerInfo"):GetFdbInfoByLevel(A1_114 + 1).friends + A0_113.buyNum * tonumber(KFDBGetRecord("ConfigValue", "SOCIALITY:BUY_PACK_SIZE").content)
end
function class.SetBuyFriendNum(A0_115, A1_116)
  A0_115.buyNum = A1_116
end
function class.GetBuyFriendBagNum(A0_117)
  local L1_118
  L1_118 = A0_117.buyNum
  return L1_118
end
function class.GetLstDateOrPage(A0_119, A1_120)
  local L2_121, L3_122, L4_123, L5_124, L6_125, L7_126, L8_127
  if A1_120 ~= nil then
    L2_121 = next
    L3_122 = A1_120
    L2_121 = L2_121(L3_122)
  elseif L2_121 == nil then
    L2_121 = {}
    L3_122 = {}
    L2_121[1] = L3_122
    L3_122 = 1
    return L2_121, L3_122
  end
  L2_121 = math
  L2_121 = L2_121.ceil
  L3_122 = #A1_120
  L3_122 = L3_122 / L4_123
  L2_121 = L2_121(L3_122)
  L3_122 = {}
  for L7_126 = 1, L2_121 do
    L8_127 = {}
    L3_122[L7_126] = L8_127
    L8_127 = PAGE_MAX_LISTNUM
    if #A1_120 - (L7_126 - 1) * PAGE_MAX_LISTNUM < PAGE_MAX_LISTNUM then
      L8_127 = #A1_120 - (L7_126 - 1) * PAGE_MAX_LISTNUM
    end
    for _FORV_12_ = 1, L8_127 do
      table.insert(L3_122[L7_126], A1_120[_FORV_12_ + (L7_126 - 1) * PAGE_MAX_LISTNUM])
    end
  end
  return L4_123, L5_124
end
function class.romoveCommendFriend(A0_128)
  local L1_129, L2_130, L3_131, L4_132, L5_133, L6_134
  L1_129 = {}
  if L2_130 then
    if not L2_130 then
      for L5_133, L6_134 in L2_130(L3_131) do
        if L6_134.baseId ~= 0 and L6_134.name ~= nil then
          table.insert(L1_129, L6_134)
        end
      end
    end
  end
  A0_128.commendFriend = L1_129
end
function class.setCommendFriend(A0_135, A1_136)
  local L2_137
  if nil ~= A1_136 then
    L2_137 = #A1_136
    if L2_137 > 0 then
      A0_135.commendFriend = A1_136
    end
  else
    L2_137 = {}
    A0_135.commendFriend = L2_137
  end
  L2_137 = Logic
  L2_137 = L2_137.Get
  L2_137 = L2_137(L2_137, "System")
  L2_137 = L2_137.GetTime
  L2_137 = L2_137(L2_137)
  A0_135.getHelperTime = L2_137
  function L2_137(A0_138, A1_139)
    local L2_140, L3_141
    if nil == A0_138 or nil == A1_139 then
      L2_140 = false
      return L2_140
    end
    L2_140 = A0_138.used
    L3_141 = A1_139.used
    if L2_140 ~= L3_141 then
      L2_140 = A0_138.used
      L2_140 = not L2_140
      return L2_140
    end
    L2_140 = A0_138.friend
    L3_141 = A1_139.friend
    if L2_140 == L3_141 then
      L2_140 = false
      return L2_140
    end
    L2_140 = A0_138.friend
    L2_140 = L2_140 == true
    return L2_140
  end
  table.sort(A0_135.commendFriend or {}, L2_137)
  A0_135:romoveCommendFriend()
  if Logic:Get("Battle"):GetEmBattleType() == Logic.Battle.BATTLE_TYPE.CAMPAIGN then
    Logic:Get("Battle"):FireEvent(Logic.Battle.EVT.OPEN_BATTLE_FRIEND)
  elseif Logic:Get("Battle"):GetEmBattleType() == Logic.Battle.BATTLE_TYPE.ACTIVE then
    Logic:Get("Activity"):FireEvent(Logic.Activity.EVT.OPEN_BATTLE_FRIEND)
  end
end
function class.OnMsgCommendFriend(A0_142, A1_143, A2_144)
  A0_142:setCommendFriend(A2_144)
end
function class.PostCommendFriendMsg(A0_145)
  MsgSociality:Post("COMMEND_FRIEND")
end
function class.GetCommendFriend(A0_146)
  local L1_147
  L1_147 = A0_146.commendFriend
  return L1_147
end
function class.GetCommendFriendNum(A0_148)
  local L1_149
  L1_149 = A0_148.commendFriend
  if L1_149 then
    L1_149 = A0_148.commendFriend
    L1_149 = #L1_149
  else
    L1_149 = L1_149 or 0
  end
  return L1_149
end
function class.DeleteCommendFriend(A0_150, A1_151)
  local L2_152, L3_153, L4_154, L5_155
  if nil == A1_151 then
    return
  end
  for L5_155, _FORV_6_ in L2_152(L3_153) do
    if _FORV_6_.id == A1_151 then
      table.remove(A0_150.commendFriend, L5_155)
      return
    end
  end
end
function class.IsNeedBattleFriend(A0_156)
  if Logic:Get("Guide"):isDone("Partner") then
    return true
  end
  if not Logic:Get("Guide"):isActive("Partner") then
    return false
  end
  if Logic:Get("Battle"):GetCurSelBattleId() ~= Guide.Partner.BATTLE then
    return false
  end
  return true
end
function class.IsNeedGetNewCommendFriend(A0_157)
  local L1_158
  L1_158 = Logic
  L1_158 = L1_158.Get
  L1_158 = L1_158(L1_158, "Guide")
  L1_158 = L1_158.isGuiding
  L1_158 = L1_158(L1_158)
  if L1_158 then
    L1_158 = false
    return L1_158
  end
  L1_158 = A0_157.GetCommendFriend
  L1_158 = L1_158(A0_157)
  if table.empty(L1_158) or #L1_158 <= _UPVALUE0_ or Logic:Get("System"):DiffTime(Logic:Get("System"):GetTime(), A0_157.getHelperTime) > _UPVALUE1_ then
    A0_157:PostCommendFriendMsg()
    return true
  end
  return false
end
function class.ChangedFriendUsed(A0_159, A1_160)
  if A1_160 == nil then
    return
  end
  if A0_159.commendFriend == nil or table.empty(A0_159.commendFriend) then
    return
  end
  for _FORV_5_ = 1, #A0_159.commendFriend do
    if A0_159.commendFriend[_FORV_5_].id == A1_160 then
      A0_159.commendFriend[_FORV_5_].used = true
    end
  end
end
function class.IsFriendFull(A0_161)
  if Logic:Get("Friend"):GetAllFriendId() == nil then
  else
  end
  return (A0_161:GetFriendMax() or 1) <= (#Logic:Get("Friend"):GetAllFriendId() or 0)
end
function class.GetTitleByFight(A0_162, A1_163)
  local L2_164, L3_165
  L2_164 = "images/public/clarity80.png"
  L3_165 = CCSprite
  L3_165 = L3_165.create
  L3_165 = L3_165(L3_165, L2_164)
  if A1_163 == nil or tonumber(A1_163) <= 0 then
    return L3_165
  end
  if Logic:Get("Pvp"):GetRecordByDesId(A1_163) ~= nil and Logic:Get("Pvp"):GetRecordByDesId(A1_163).icoPath ~= nil and Logic:Get("Pvp"):GetRecordByDesId(A1_163).icoPath ~= "" then
    L2_164 = Logic:Get("Pvp"):GetRecordByDesId(A1_163).icoPath
  end
  L3_165 = CCSprite:create(L2_164)
  return L3_165
end
function class.GetTitleByFightLogo(A0_166, A1_167)
  local L2_168, L3_169
  L2_168 = "images/public/clarity80.png"
  L3_169 = CCSprite
  L3_169 = L3_169.create
  L3_169 = L3_169(L3_169, L2_168)
  if A1_167 == nil or tonumber(A1_167) <= 0 then
    return L3_169
  end
  if Logic:Get("Pvp"):GetRecordByDesId(A1_167) ~= nil and Logic:Get("Pvp"):GetRecordByDesId(A1_167).logoPath ~= nil and Logic:Get("Pvp"):GetRecordByDesId(A1_167).logoPath ~= "" then
    L2_168 = Logic:Get("Pvp"):GetRecordByDesId(A1_167).logoPath
  end
  L3_169 = CCSprite:create(L2_168)
  return L3_169
end
