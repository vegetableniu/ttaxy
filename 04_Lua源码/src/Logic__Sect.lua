local L0_0
L0_0 = module
L0_0((...), package.seeall)
L0_0 = require
L0_0("utf8")
L0_0 = require
L0_0("Logic")
L0_0 = Logic
L0_0 = L0_0.class
L0_0 = L0_0.subclass
L0_0 = L0_0(L0_0)
class = L0_0
L0_0 = Enum
L0_0 = L0_0({
  "GET_MENPAI_LIST_OK",
  "LIST_INVITE_MENPAI_OK",
  "CREATMENPAI_OK",
  "LIST_APPLY_USER_OK",
  "CHECK_USER_OK",
  "APPLY_OR_NOT_OK",
  "CHECK_INVITE_MENPAI_OK",
  "LIST_MESSAGE_OK",
  "GIVE_MESSAGE_OK",
  "CHANGE_POST_OK",
  "UPDATE_DECLARATION_OK",
  "BIDRANK_FINISHED",
  "EXITSECTBID",
  "GRAB_TIGHT_OK",
  "STOP_GRAB_TIGHT_OK",
  "PRAY_OK",
  "MAMMON_NEW",
  "GET_PARTNER_LIST",
  "GRANT_FINISHED",
  "DEMISE_FINISHED",
  "KICKUSER_FINISHED",
  "CONTRIBUTE_FINISHED",
  "CONTRIBUTE_TIMES_RET",
  "SPRING_DRINK_FINISHED",
  "REFRESH_GOON_WIDGET",
  "REFRESH_CARD_LIST",
  "SECT_MONEY_CHANGED",
  "RENAME_SUCCESSED",
  "RENAME_ERROR",
  "ON_SUMMON_DEMOG",
  "ON_LIST_DEMOG",
  "ON_CLEAR_COOLTIME",
  "ON_ATTACK_DEMOG",
  "ON_DRAW_REWARD",
  "UPDATE_ENERGY_TIME",
  "GET_DEMOG_REWARD_OK",
  "HAS_NEW_DEMOG",
  "COUNTRY_HOLD_LIST",
  "COUNTRY_BID_INFO",
  "COUNTRY_FIGHT_INFO",
  "COUNTRY_BID_FINISH",
  "COUNTRY_FIGHT_JOIN",
  "COUNTRY_FIGHT_HAS_JOINED",
  "GET_GOODS_LIST",
  "START_BATTLE",
  "COUNTRY_FIGHT_QUIT",
  "COUNTRY_FIGTH_END",
  "CAN_JOIN_FIGHT",
  "SET_TABLEVIEW_TOUCH",
  "FIGHT_CHAT",
  "CLOSE_FIGHT",
  "REFRESH_FIGHT_LIST",
  "COUNTRY_BID_END",
  "REFRESH_JOINT_COUNT",
  "REFRESH_COUNTRY_INFO"
})
EVT = L0_0
L0_0 = TypeDef
L0_0 = L0_0("com.eyu.mt.module.menpai.model.JobType")
JobType = L0_0
L0_0 = TypeDef
L0_0 = L0_0("com.eyu.mt.module.menpai.model.JoinState")
JoinState = L0_0
L0_0 = TypeDef
L0_0 = L0_0("com.eyu.mt.module.menpai.facade.MenpaiResult")
NAME_LENGTH_MIN = 4
NAME_LENGTH_MAX = 12
function class.initialize(A0_1)
  super.initialize(A0_1)
  A0_1.SectInfo = {}
  A0_1.FromHome = false
  A0_1.FromMain = false
  A0_1.FromDemogList = false
  A0_1.SectId = ID[-1]
  A0_1.inviteNum = 0
  A0_1.prevApplyNum = 0
  A0_1.checkState = false
  A0_1.memberData = {}
  A0_1.memberList = {}
  A0_1.content = 0
  A0_1.playerId = 0
  A0_1.grantPost = -1
  A0_1.grabOverDate = 0
  A0_1.restOfDonate = 2
  A0_1.contributeContent = {}
  A0_1.viplevel = 0
  A0_1.refreshTime = 0
  A0_1.jobSettings = {}
  A0_1.bFromFriend = false
  A0_1.changeJobType = nil
  A0_1.lastWordRefreshTime = nil
  A0_1.summonInfo = {}
  A0_1.demogListInfo = {}
  A0_1.demogReward = {}
  A0_1.attackInfo = {}
  A0_1.checkDemogInfo = {}
  A0_1.bFromDemog = false
  A0_1.checkedCardId = nil
  A0_1.checkedBaseId = nil
  A0_1.hasNewDemog = false
  A0_1.callFlag = false
  A0_1.countryHold = {}
  A0_1.joinBidDate = {}
  A0_1.joinFightDate = {}
  A0_1.joinBidInfo = {}
  A0_1.joinFightInfo = {}
  A0_1.countryId = 0
  A0_1.countryFightJoinedInfo = {}
  A0_1.goodsList = {}
  A0_1.countryFightResult = {}
  A0_1.reportDate = {}
  A0_1.isJoined = false
  A0_1.canJoin = false
  A0_1.isChat = false
  A0_1.chat = {}
  A0_1.bSuccess = false
  A0_1.goodsExchangCount = 0
  A0_1.holdRewardDate = nil
  A0_1.countryFightId = 0
  A0_1.countryInfo = {}
  A0_1.firstMenpai = nil
  Logic:Get("MsgAssist"):RecordErrorMsg("MsgMenpai", _UPVALUE0_, _UPVALUE1_)
  MsgMenpai:On("JOIN_MENPAI", A0_1:Event("OnJoinMenpai"), false)
  MsgMenpai:On("GET_SELEF_MENPAI", A0_1:Event("OnGetSelefMenpai"), false)
  MsgMenpai:On("GET_MENPAI_LIST", A0_1:Event("OnGetMenpaiList"))
  MsgMenpai:On("GET_PARTNER_LIST", A0_1:Event("OnGetPartnerList"), false)
  MsgMenpai:On("INVITE_PARTNER", A0_1:Event("OnInvitePartner"), false)
  MsgMenpai:On("LIST_APPLY_USER", A0_1:Event("OnListApplyUser"), false)
  MsgMenpai:On("CHECK_USER", A0_1:Event("OnCheckUser"), false)
  MsgMenpai:On("LIST_INVITE_MENPAI", A0_1:Event("OnListInviteMenpai"), false)
  MsgMenpai:On("CHECK_INVITE_MENPAI", A0_1:Event("OnCheckInviteMenpai"))
  MsgMenpai:On("CHANGE_POST", A0_1:Event("OnChangePost"), false)
  MsgMenpai:On("GIVE_MESSAGE", A0_1:Event("OnGiveMessage"), false)
  MsgMenpai:On("LIST_MESSAGE", A0_1:Event("OnListMessage"), false)
  MsgMenpai:On("UPDATE_DECLARATION", A0_1:Event("OnUpdataDeclaration"), false)
  MsgMenpai:On("CONTRIBUTE_MENPAI", A0_1:Event("OnContributeMenpai"), false)
  MsgMenpai:On("BID_RANK", A0_1:Event("OnBidRank"))
  MsgMenpai:On("KICK_USER", A0_1:Event("OnKickUser"))
  MsgMenpai:On("CREATE_MENPAI", A0_1:Event("OnCreateMenpai"), false)
  MsgMenpai:On("SET_MEMBER_JOB", A0_1:Event("OnSetMemberJob"))
  MsgMenpai:On("TRANSFER_BOSS", A0_1:Event("OnTransferBoss"))
  MsgMenpai:On("GRAB_TIGHT", A0_1:Event("OnGrabTight"), false)
  MsgMenpai:On("STOP_GRAB_RIGHT", A0_1:Event("OnStopGrabRight"))
  MsgMenpai:On("SPRING_DRINK", A0_1:Event("OnSpringDrink"), false)
  MsgMenpai:On("PRAY", A0_1:Event("OnPray"), false)
  MsgMenpai:On("QUIT_MENPAI", A0_1:Event("OnQuitMenpai"), false)
  MsgMenpai:On("CANCEL_APPLY", A0_1:Event("OnCancelApply"), false)
  MsgMenpai:On("SUMMON_DEMOG", A0_1:Event("OnSummonDemog"))
  MsgMenpai:On("LIST_DEMOG", A0_1:Event("OnListDemog"))
  MsgMenpai:On("CLEAR_COOLTIME", A0_1:Event("OnClearCoolTime"))
  MsgMenpai:On("ATTACK_DEMOG", A0_1:Event("OnAttackDemog"))
  MsgMenpai:On("DRAW_REWARD", A0_1:Event("OnDrawReward"))
  MsgMenpai:On("BID_FOR_COUNTRY", A0_1:Event("OnBidForCountry"), false)
  MsgMenpai:On("COUNTRY_FIGHT_JOINED", A0_1:Event("OnCountryFightJoined"), false)
  MsgMenpai:On("COUNTRY_FIGHT_RESULT", A0_1:Event("OnCountryFightResult"), false)
  MsgMenpai:On("GET_GOODS", A0_1:Event("OnGetGoods"))
  MsgMenpai:On("EXCHAGE_GOODS", A0_1:Event("OnExchageGoods"))
  MsgMenpai:On("QUIT_COUNTRY_FIGHT", A0_1:Event("OnQuitCountryFight"))
  MsgMenpai:On("COUNTRY_DATA", A0_1:Event("OnCountryData"))
  MsgMenpai:On("MENPAI_RENAME", A0_1:Event("OnMenpaiRename"), false)
  Singleton(NetMgr):On(NetMgr.EVT.MENPAI_DEMOG, A0_1:Event("OnMenpaiDemog"))
  Singleton(NetMgr):On(NetMgr.EVT.MENPAI_COUNTRY_FIGHT, A0_1:Event("OnMenpaiCountryFight"))
end
function class.dispose(A0_2)
  super.dispose(A0_2)
end
function class.OnReset(A0_3)
  local L1_4
end
function class.PostJoinMenpai(A0_5, A1_6)
  if A1_6 == nil then
    return
  end
  MsgMenpai:Post("JOIN_MENPAI", {menpai = A1_6})
end
function class.PostGetSelefMenpai(A0_7)
  A0_7.silentSelfRefresh = false
  MsgMenpai:Post("GET_SELEF_MENPAI")
end
function class.PostRefreshSelfMenpai(A0_8)
  A0_8.silentSelfRefresh = true
  MsgMenpai:Post("GET_SELEF_MENPAI")
end
function class.PostGetMenpaiList(A0_9, A1_10, A2_11)
  if A2_11 == nil then
    return
  end
  MsgMenpai:Post("GET_MENPAI_LIST", {key = A1_10, page = A2_11})
end
function class.PostGetPartnerList(A0_12, A1_13)
  MsgMenpai:Post("GET_PARTNER_LIST", {page = A1_13})
end
function class.PostInvitePartner(A0_14, A1_15)
  if A1_15 == nil then
    return
  end
  MsgMenpai:Post("INVITE_PARTNER", {partner = A1_15})
end
function class.PostListApplyUser(A0_16, A1_17)
  if A1_17 == nil then
    return
  end
  MsgMenpai:Post("LIST_APPLY_USER", {page = A1_17})
end
function class.PostCheckUser(A0_18, A1_19, A2_20)
  if A2_20 == nil then
    return
  end
  A0_18.checkState = A1_19
  MsgMenpai:Post("CHECK_USER", {accept = A1_19, applyId = A2_20})
end
function class.PostListInviteMenpai(A0_21, A1_22)
  if A1_22 == nil then
    return
  end
  MsgMenpai:Post("LIST_INVITE_MENPAI", {page = A1_22})
end
function class.PostCheckInviteMenpai(A0_23, A1_24, A2_25)
  if A2_25 == nil then
    return
  end
  MsgMenpai:Post("CHECK_INVITE_MENPAI", {accept = A1_24, inivteId = A2_25})
end
function class.PostChangePost(A0_26, A1_27)
  if A1_27 == nil then
    return
  end
  MsgMenpai:Post("CHANGE_POST", {post = A1_27})
end
function class.PostGiveMessage(A0_28, A1_29)
  if A1_29 == nil then
    return
  end
  MsgMenpai:Post("GIVE_MESSAGE", {message = A1_29})
end
function class.PostListMessage(A0_30, A1_31)
  if A1_31 == nil then
    return
  end
  MsgMenpai:Post("LIST_MESSAGE", {page = A1_31})
end
function class.PostUpdataDeclaration(A0_32, A1_33)
  if A1_33 == nil then
    return
  end
  MsgMenpai:Post("UPDATE_DECLARATION", {declaration = A1_33})
end
function class.PostContributeMenpai(A0_34, A1_35)
  MsgMenpai:Post("CONTRIBUTE_MENPAI", {count = A1_35})
end
function class.PostBidRank(A0_36, A1_37)
  if A1_37 == nil then
    return
  end
  MsgMenpai:Post("BID_RANK", {count = A1_37})
end
function class.PostKickUser(A0_38, A1_39)
  if A1_39 == nil then
    return
  end
  MsgMenpai:Post("KICK_USER", {player = A1_39})
end
function class.PostCreateMenpai(A0_40, A1_41)
  if A1_41 == nil then
    return
  end
  MsgMenpai:Post("CREATE_MENPAI", {name = A1_41})
end
function class.PostSetMemberJob(A0_42, A1_43, A2_44)
  if A1_43 == nil or A2_44 == nil then
    return
  end
  A0_42.changeJobType = A1_43
  MsgMenpai:Post("SET_MEMBER_JOB", {jobType = A1_43, partner = A2_44})
end
function class.PostTransferBoss(A0_45, A1_46)
  if A1_46 == nil then
    return
  end
  MsgMenpai:Post("TRANSFER_BOSS", {partner = A1_46})
end
function class.PostGrabTight(A0_47)
  MsgMenpai:Post("GRAB_TIGHT")
end
function class.PostStopGrabRight(A0_48)
  MsgMenpai:Post("STOP_GRAB_RIGHT")
end
function class.PostSpringDrink(A0_49)
  MsgMenpai:Post("SPRING_DRINK")
end
function class.PostPray(A0_50, A1_51)
  MsgMenpai:Post("PRAY", {time = A1_51})
end
function class.PostPrayEnd(A0_52)
  MsgMenpai:Post("PRAY_END")
end
function class.PostContributeTimes(A0_53)
  MsgMenpai:Post("CONTRIBUTE_TIMES")
end
function class.PostQuitMenpai(A0_54)
  MsgMenpai:Post("QUIT_MENPAI")
end
function class.PostSummonDemog(A0_55, A1_56)
  if A1_56 == nil then
    return
  end
  MsgMenpai:Post("SUMMON_DEMOG", {cost = A1_56})
end
function class.PostListDemog(A0_57, A1_58)
  if A1_58 == nil then
    return
  end
  MsgMenpai:Post("LIST_DEMOG", {page = A1_58})
end
function class.PostClearCoolTime(A0_59)
  MsgMenpai:Post("CLEAR_COOLTIME")
end
function class.PostAttackDemog(A0_60, A1_61, A2_62)
  if A1_61 == nil then
    return
  end
  MsgMenpai:Post("ATTACK_DEMOG", {demogId = A1_61, embattle = A2_62})
end
function class.PostDrawReward(A0_63, A1_64)
  if A1_64 == nil then
    return
  end
  MsgMenpai:Post("DRAW_REWARD", {demogId = A1_64})
end
function class.PostCancelJoinMenpai(A0_65, A1_66)
  if A1_66 == nil then
    return
  end
  MsgMenpai:Post("CANCEL_APPLY", {menpai = A1_66})
end
function class.OnJoinMenpai(A0_67, A1_68, A2_69)
  if A1_68 ~= 0 then
    if A1_68 == _UPVALUE0_.MENPAI_JOINED or A1_68 == _UPVALUE0_.MENPAI_USER_MENPAI_EXIST or A1_68 == _UPVALUE0_.MENPAI_JOINED_OTHER then
      Prompt:Confirm(A0_67, "", TwGetStr(110173), A0_67.PostGetSelefMenpai, Prompt.PROMPT_TYPE.CONFIRM)
      return
    end
    if A1_68 == _UPVALUE0_.MENPAI_NOT_FOUND then
      Prompt:Confirm(A0_67, "", TwGetStr(110279), nil, Prompt.PROMPT_TYPE.CONFIRM)
      A0_67:PostGetMenpaiList(nil, 1)
      return
    end
    if A1_68 == _UPVALUE0_.APPLY_COUNT_LIMIT then
      Prompt:Confirm(A0_67, "", TwGetStr(110051), nil, Prompt.PROMPT_TYPE.CONFIRM)
      return
    end
    Logic:Get("MsgAssist"):OnMsgResult("MsgMenpai", A1_68)
    return
  end
  if A2_69.joinState == JoinState.JOINED then
    Prompt:Confirm(A0_67, "", TwGetStr(110112), A0_67.PostGetSelefMenpai, Prompt.PROMPT_TYPE.CONFIRM)
  end
  A0_67:FireEvent(EVT.APPLY_OR_NOT_OK, A2_69)
end
function class.OnGetSelefMenpai(A0_70, A1_71, A2_72)
  if A1_71 ~= 0 then
    if A0_70.silentSelfRefresh then
      A0_70.silentSelfRefresh = false
      return
    end
    A0_70:manageErr(A1_71)
    return
  end
  if not A2_72 then
    return
  end
  if not table.empty(A0_70.SectInfo) and A0_70.SectInfo.aplypNum then
    A0_70.prevApplyNum = A0_70.SectInfo.aplypNum or 0
  end
  A0_70.SectInfo = A2_72
  A0_70.SectId = A2_72.id
  A0_70.inviteNum = 0
  A0_70.joinBidDate = A2_72.joinBidDate
  A0_70.joinFightDate = A2_72.joinFightDate
  A0_70.reportDate = A2_72.reportDate
  if A0_70.silentSelfRefresh then
    A0_70.silentSelfRefresh = false
    return
  end
  A0_70.holdRewardDate = A2_72.holdRewardDate
  if A0_70.bFromFriend then
    A0_70.bFromFriend = false
    return
  end
  SceneHelper:runWithScene("SectMain")
end
function class.OnGetMenpaiList(A0_73, A1_74, A2_75)
  if A1_74 ~= 0 then
    return
  end
  A0_73.firstMenpai = A2_75.firstMenpai
  A0_73:FireEvent(EVT.GET_MENPAI_LIST_OK, A2_75)
end
function class.OnGetPartnerList(A0_76, A1_77, A2_78)
  if A1_77 ~= 0 then
    A0_76:manageErr(A1_77)
    return
  end
  if not A2_78 then
    return
  end
  A0_76.SectInfo.count = A2_78.count
  A0_76.memberList = A2_78
  if A0_76.memberList ~= nil and not table.empty(A0_76.memberList.data) then
    for _FORV_6_, _FORV_7_ in ipairs(A0_76.memberList) do
      if _FORV_7_.playerId == Logic:Get("PlayerInfo"):GetPlayerId() then
        A0_76.SectInfo.job = _FORV_7_.job
        break
      end
    end
  end
  A0_76:FireEvent(EVT.GET_PARTNER_LIST)
end
function class.OnInvitePartner(A0_79, A1_80, A2_81)
  if A1_80 ~= 0 then
    A0_79:manageErr(A1_80)
    return
  end
  Prompt:Tip(TwGetStr(110141))
end
function class.OnListApplyUser(A0_82, A1_83, A2_84)
  if A1_83 ~= 0 then
    A0_82:manageErr(A1_83)
    return
  end
  if not A2_84 then
    return
  end
  A0_82:FireEvent(EVT.LIST_APPLY_USER_OK, A2_84)
  A0_82.SectInfo.aplypNum = A2_84.count
  A0_82.prevApplyNum = A2_84.count
end
function class.OnCheckUser(A0_85, A1_86, A2_87)
  if A1_86 ~= 0 then
    if A1_86 == _UPVALUE0_.MENPAI_CHECK_DENY then
      if A0_85.checkState then
        Prompt:Confirm(A0_85, "", TwGetStr(110109), nil, Prompt.PROMPT_TYPE.CONFIRM)
      else
        Prompt:Confirm(A0_85, "", TwGetStr(110252), nil, Prompt.PROMPT_TYPE.CONFIRM)
      end
      A0_85:FireEvent(EVT.CHECK_USER_OK, A2_87)
      return
    end
    if A1_86 == _UPVALUE0_.MENPAI_JOINED_OTHER then
      A0_85:FireEvent(EVT.CHECK_USER_OK, A2_87)
      if not A0_85.checkState then
        return
      end
    end
    if A1_86 == _UPVALUE0_.MENPAI_MEMBER_COUNT_LIMIT then
      Prompt:Confirm(A0_85, "", TwGetStr(110276), nil, Prompt.PROMPT_TYPE.CONFIRM)
      A0_85:FireEvent(EVT.CHECK_USER_OK, A2_87)
      return
    end
    A0_85:manageErr(A1_86)
    return
  end
  A0_85:FireEvent(EVT.CHECK_USER_OK, A2_87)
end
function class.OnListInviteMenpai(A0_88, A1_89, A2_90)
  if A1_89 ~= 0 then
    return
  end
  if not A2_90 then
    return
  end
  A0_88.inviteNum = A2_90.count
  A0_88:FireEvent(EVT.LIST_INVITE_MENPAI_OK, A2_90)
end
function class.OnCheckInviteMenpai(A0_91, A1_92, A2_93)
  if A1_92 ~= 0 then
    return
  end
  if A2_93 then
    A0_91.SectInfo = A2_93
    A0_91.SectId = A2_93.id
    A0_91.inviteNum = 0
    SceneHelper:runWithScene("SectMain")
    return
  end
  A0_91:FireEvent(EVT.CHECK_INVITE_MENPAI_OK, A2_93)
end
function class.OnChangePost(A0_94, A1_95, A2_96)
  if A1_95 ~= 0 then
    A0_94:manageErr(A1_95)
    return
  end
  A0_94:FireEvent(EVT.CHANGE_POST_OK, A2_96)
end
function class.OnGiveMessage(A0_97, A1_98, A2_99)
  if A1_98 ~= 0 then
    A0_97:manageErr(A1_98)
    return
  end
  A0_97:FireEvent(EVT.GIVE_MESSAGE_OK, A2_99)
end
function class.OnListMessage(A0_100, A1_101, A2_102)
  if A1_101 ~= 0 then
    A0_100:manageErr(A1_101)
    return
  end
  A0_100:FireEvent(EVT.LIST_MESSAGE_OK, A2_102)
end
function class.OnUpdataDeclaration(A0_103, A1_104, A2_105)
  if A1_104 ~= 0 then
    A0_103:manageErr(A1_104)
    return
  end
  A0_103:FireEvent(EVT.UPDATE_DECLARATION_OK, A2_105)
end
function class.OnContributeMenpai(A0_106, A1_107, A2_108)
  if A1_107 ~= 0 then
    A0_106:manageErr(A1_107)
    return
  end
  if not A2_108 then
    return
  end
  A0_106.SectInfo.money = A2_108.money
  Logic:Get("Cost"):AddCosts(A2_108.costReward.costs)
  Logic:Get("Reward"):AddRewards(A2_108.costReward.rewards)
  A0_106.contributeContent = A2_108
  A0_106:UpdateSectInfo(A2_108.exp)
  A0_106:FireEvent(EVT.CONTRIBUTE_FINISHED)
  A0_106:FireEvent(EVT.REFRESH_GOON_WIDGET)
  A0_106:FireEvent(EVT.SECT_MONEY_CHANGED, A2_108.money)
end
function class.OnBidRank(A0_109, A1_110, A2_111)
  if A1_110 ~= 0 then
    return
  end
  A0_109.SectInfo.money = A2_111
  A0_109:FireEvent(EVT.BIDRANK_FINISHED)
end
function class.OnKickUser(A0_112, A1_113, A2_114)
  local L3_115, L4_116, L5_117, L6_118
  if A1_113 ~= 0 then
    return
  end
  for L6_118, _FORV_7_ in L3_115(L4_116) do
    if _FORV_7_.playerId == A0_112.memberData.playerId then
      table.remove(A0_112.memberList.data, L6_118)
      break
    end
  end
  L3_115(L4_116, L5_117)
end
function class.OnCreateMenpai(A0_119, A1_120, A2_121)
  if A1_120 ~= 0 then
    if A1_120 == _UPVALUE0_.MENPAI_JOINED then
      Prompt:Confirm(A0_119, "", TwGetStr(110275), A0_119.PostGetSelefMenpai, Prompt.PROMPT_TYPE.CONFIRM)
      return
    end
    Logic:Get("MsgAssist"):OnMsgResult("MsgMenpai", A1_120)
    return
  end
  Logic:Get("Cost"):AddCosts(A2_121)
  A0_119:PostGetSelefMenpai()
  A0_119:FireEvent(EVT.CREATMENPAI_OK)
end
function class.OnSetMemberJob(A0_122, A1_123, A2_124)
  if A1_123 ~= 0 then
    A0_122:manageErr(A1_123)
    return
  end
  A0_122.cont = A2_124
  A0_122.memberData.job = Logic.Sect.JobType[A0_122.changeJobType]
  for _FORV_6_, _FORV_7_ in ipairs(A0_122.memberList) do
    if _FORV_7_.playerId == A0_122.memberData.playerId then
      A0_122.memberList[_FORV_6_] = A0_122.memberData
      break
    end
  end
  A0_122:FireEvent(EVT.GRANT_FINISHED)
end
function class.OnTransferBoss(A0_125, A1_126, A2_127)
  if A1_126 ~= 0 then
    return
  end
  A0_125.cont = A2_127
  A0_125.SectInfo.job, A0_125.memberData.job = A0_125.memberData.job, A0_125.SectInfo.job
  for _FORV_6_, _FORV_7_ in ipairs(A0_125.memberList.data) do
    if 0 == 2 then
      break
    end
    if _FORV_7_.playerId == A0_125.memberData.playerId then
      A0_125.memberList.data[_FORV_6_] = A0_125.memberData
    end
    if _FORV_7_.playerId == Logic:Get("PlayerInfo"):GetPlayerId() then
      A0_125.memberList.data[_FORV_6_].job = A0_125.SectInfo.job
    end
  end
  A0_125:FireEvent(EVT.DEMISE_FINISHED)
end
function class.OnGrabTight(A0_128, A1_129, A2_130)
  if A1_129 ~= 0 then
    A0_128:manageErr(A1_129)
    return
  end
  A0_128.grabOverDate = A2_130
  A0_128.SectInfo.endGrabRight = A2_130
  Prompt:Confirm(A0_128, "", TwGetStr(110081), nil, Prompt.PROMPT_TYPE.CONFIRM)
  A0_128.SectInfo.hasGrabed = true
  A0_128:FireEvent(EVT.GRAB_TIGHT_OK)
end
function class.OnStopGrabRight(A0_131, A1_132, A2_133)
  if A1_132 ~= 0 then
    return
  end
  A0_131.cont = A2_133
  A0_131.SectInfo.endGrabRight = nil
  A0_131.SectInfo.post = A0_131:getStopGrabCall()
  A0_131:FireEvent(EVT.STOP_GRAB_TIGHT_OK)
end
function class.OnSpringDrink(A0_134, A1_135, A2_136)
  if A1_135 ~= 0 then
    A0_134:manageErr(A1_135)
    return
  end
  if not A2_136 then
    return
  end
  Logic:Get("Reward"):AddRewards(A2_136.rewardResults)
  A0_134.SectInfo.coolTime = A2_136.endCoolDate
  A0_134:FireEvent(EVT.SPRING_DRINK_FINISHED, A2_136)
end
function class.OnPray(A0_137, A1_138, A2_139)
  if A1_138 ~= 0 then
    A0_137:manageErr(A1_138)
    return
  end
  if not A2_139 then
    return
  end
  A0_137.SectInfo.canPrayTime = A2_139.canPrayTime
  A0_137.SectInfo.prayTimes = A2_139.prayTime
  Logic:Get("Cost"):AddCosts(A2_139.costs)
  Logic:Get("Reward"):AddRewards(A2_139.rewards)
  A0_137:FireEvent(EVT.PRAY_OK, A2_139)
end
function class.OnQuitMenpai(A0_140, A1_141, A2_142)
  if A1_141 ~= 0 then
    A0_140:manageErr(A1_141)
    return
  end
  A0_140.SectInfo = {}
  A0_140.FromHome = false
  A0_140.FromMain = false
  A0_140.SectId = ID[-1]
  A0_140.inviteNum = 0
  A0_140:jumpToSectListAdd()
end
function class.OnSummonDemog(A0_143, A1_144, A2_145)
  if A1_144 ~= 0 then
    A0_143:manageErr(A1_144)
    return
  end
  Logic:Get("Cost"):AddCosts(A2_145.costAndReward.costs)
  Logic:Get("Reward"):AddRewards(A2_145.costAndReward.rewards)
  A0_143.summonInfo = A2_145
  A0_143:FireEvent(EVT.ON_SUMMON_DEMOG, A2_145.costAndReward.rewards)
end
function class.OnListDemog(A0_146, A1_147, A2_148)
  if A1_147 ~= 0 then
    A0_146:manageErr(A1_147)
    return
  end
  A0_146.demogListInfo = A2_148
  A0_146:FireEvent(EVT.ON_LIST_DEMOG, A2_148)
end
function class.OnClearCoolTime(A0_149, A1_150, A2_151)
  if A1_150 ~= 0 then
    A0_149:manageErr(A1_150)
    return
  end
  Logic:Get("Cost"):AddCosts(A2_151)
  A0_149:setAttackDemogCoolTime(0)
  A0_149:FireEvent(EVT.ON_CLEAR_COOLTIME)
end
function class.OnAttackDemog(A0_152, A1_153, A2_154)
  if A1_153 ~= 0 then
    A0_152:manageErr(A1_153)
    return
  end
  A0_152.attackInfo = A2_154
  A0_152.bFromDemog = false
  Logic:Get("Reward"):AddRewards(A2_154.rewardResult)
  Logic:Get("BattleShow"):CleanUp()
  Logic:Get("BattleShow"):SetEnemyCount(1, 3)
  Logic:Get("BattleShow"):SetEnterBattle(true)
  Logic:Get("BattleShow"):SetTotleMultiFightWaves(A2_154.groupNum)
  Logic:Get("BattleShow"):SetMultiFightWaves(A2_154.groupNum, 1)
  Logic:Get("BattleShow"):SaveMultiFightReport(A2_154.reports)
  Logic:Get("BattleShow"):StartMultiFightReport()
  Logic:Get("BattleShow"):SetResultUI("SectDemogResult")
end
function class.OnDrawReward(A0_155, A1_156, A2_157)
  local L3_158
  if A1_156 ~= 0 then
    L3_158 = A0_155.manageErr
    L3_158(A0_155, A1_156)
    return
  end
  A0_155.demogReward = A2_157
  L3_158 = Logic
  L3_158 = L3_158.Get
  L3_158 = L3_158(L3_158, "Reward")
  L3_158 = L3_158.AddRewards
  L3_158(L3_158, A2_157)
  L3_158 = TwGetStr
  L3_158 = L3_158(110079)
  for _FORV_7_ = 1, #A2_157 do
    L3_158 = L3_158 .. Logic:Get("Reward"):RewardTreaTip(A2_157[_FORV_7_])
    if _FORV_7_ < #A2_157 then
      L3_158 = L3_158 .. ","
    else
      L3_158 = L3_158 .. "\n"
    end
  end
  _FOR_:Confirm(nil, 110072, L3_158, nil, Prompt.PROMPT_TYPE.CONFIRM)
  A0_155:FireEvent(EVT.GET_DEMOG_REWARD_OK)
end
function class.OnCancelApply(A0_159, A1_160, A2_161)
  if A1_160 ~= 0 then
    if A1_160 == _UPVALUE0_.MENPAI_JOINED or A1_160 == _UPVALUE0_.MENPAI_USER_MENPAI_EXIST or A1_160 == _UPVALUE0_.MENPAI_JOINED_OTHER then
      Prompt:Confirm(A0_159, "", TwGetStr(110173), A0_159.PostGetSelefMenpai, Prompt.PROMPT_TYPE.CONFIRM)
      return
    end
    if A1_160 == _UPVALUE0_.MENPAI_NOT_FOUND then
      Prompt:Confirm(A0_159, "", TwGetStr(110279), nil, Prompt.PROMPT_TYPE.CONFIRM)
      A0_159:PostGetMenpaiList(nil, 1)
      return
    end
    Logic:Get("MsgAssist"):OnMsgResult("MsgMenpai", A1_160)
    return
  end
  A0_159:FireEvent(EVT.APPLY_OR_NOT_OK, A2_161)
end
function class.OnMenpaiDemog(A0_162)
  A0_162.hasNewDemog = true
  A0_162:FireEvent(EVT.HAS_NEW_DEMOG)
end
function class.isNewDemog(A0_163)
  local L1_164
  L1_164 = A0_163.hasNewDemog
  return L1_164
end
function class.setNewDemogFlag(A0_165, A1_166)
  A0_165.hasNewDemog = A1_166
end
function class.GetFirstMenpai(A0_167)
  local L1_168
  L1_168 = A0_167.firstMenpai
  return L1_168
end
function class.checkName(A0_169, A1_170)
  local L2_171, L3_172, L4_173, L5_174, L6_175, L7_176, L8_177
  if A1_170 and "" == A1_170 then
    L2_171 = Prompt
    L3_172 = L2_171
    L2_171 = L2_171.Fail
    L4_173 = TwGetStr
    L8_177 = L4_173(L5_174)
    L2_171(L3_172, L4_173, L5_174, L6_175, L7_176, L8_177, L4_173(L5_174))
    L2_171 = false
    return L2_171
  end
  L2_171 = getStrShowWidth
  L3_172 = A1_170
  L2_171 = L2_171(L3_172)
  L3_172 = NAME_LENGTH_MIN
  if L2_171 < L3_172 then
    L3_172 = Prompt
    L4_173 = L3_172
    L3_172 = L3_172.Fail
    L8_177 = L5_174(L6_175, L7_176)
    L3_172(L4_173, L5_174, L6_175, L7_176, L8_177, L5_174(L6_175, L7_176))
    L3_172 = false
    return L3_172
  else
    L3_172 = NAME_LENGTH_MAX
    if L2_171 > L3_172 then
      L3_172 = Prompt
      L4_173 = L3_172
      L3_172 = L3_172.Fail
      L8_177 = L5_174(L6_175, L7_176)
      L3_172(L4_173, L5_174, L6_175, L7_176, L8_177, L5_174(L6_175, L7_176))
      L3_172 = false
      return L3_172
    else
      L4_173 = A0_169
      L3_172 = A0_169.checkSpecial
      L3_172 = L3_172(L4_173, L5_174)
      if not L3_172 then
        L4_173 = Prompt
        L4_173 = L4_173.Fail
        L4_173(L5_174, L6_175)
        L4_173 = false
        return L4_173
      end
      L4_173 = nil
      for L8_177 = 1, L6_175(L7_176) do
        L4_173 = string.find(A1_170, KFDBGetRecordByIdx("RegisterForbidden", L8_177).name)
        if L4_173 ~= nil then
          break
        end
      end
      if nil ~= L4_173 then
        L5_174(L6_175, L7_176)
        return L5_174
      end
    end
  end
  L3_172 = true
  return L3_172
end
function class.checkSpecial(A0_178, A1_179)
  if not utf8.isBMPOnly(A1_179) then
    return false
  end
  return string.find(getSubANSIString(A1_179), "[%c%p%s]") == nil
end
function class.checkString(A0_180, A1_181)
  local L2_182, L3_183, L4_184, L5_185, L6_186
  L2_182 = utf8
  L2_182 = L2_182.bmpOnly
  L2_182 = L2_182(L3_183)
  for L6_186 = 1, L4_184(L5_185) do
    L2_182 = string.gsub(L2_182, KFDBGetRecordByIdx("RegisterForbidden", L6_186).name, function(A0_187)
      local L1_188
      L1_188 = getStrShowWidth
      L1_188 = L1_188(A0_187)
      return string.rep("*", L1_188)
    end)
  end
  return L2_182
end
function class.checkGold(A0_189)
  return Logic:Get("PlayerInfo"):GetPlayerAllJade() >= (KFDBGetRecord("ConfigValue", "MENPAI:CREATE_COST_XIANYU_COUNT") and tonumber(KFDBGetRecord("ConfigValue", "MENPAI:CREATE_COST_XIANYU_COUNT").content) or 0)
end
function class.checkLevel(A0_190)
  return Logic:Get("PlayerInfo"):GetPlayerLevel() >= (KFDBGetRecord("ConfigValue", "MENPAI:CREATE_LEVEL_LIMIT") and tonumber(KFDBGetRecord("ConfigValue", "MENPAI:CREATE_LEVEL_LIMIT").content) or 0)
end
function class.getCall(A0_191)
  local L1_192, L2_193, L3_194, L4_195, L5_196
  L1_192 = KFDBGetRecord
  L2_193 = "ConfigValue"
  L3_194 = "MENPAI:MENPAI_GRAB_RIGHT_POST"
  L1_192 = L1_192(L2_193, L3_194)
  if L1_192 then
    L2_193 = L1_192.content
  else
    L1_192 = L2_193 or ""
  end
  L2_193 = KFDBGetRecord
  L3_194 = "LanguageSetting"
  L4_195 = L1_192
  L2_193 = L2_193(L3_194, L4_195)
  if L2_193 then
    L3_194 = L2_193.content
  else
    L2_193 = L3_194 or ""
  end
  L3_194 = A0_191.SectInfo
  L3_194 = L3_194.endGrabRight
  L4_195 = Logic
  L5_196 = L4_195
  L4_195 = L4_195.Get
  L4_195 = L4_195(L5_196, "System")
  L5_196 = L4_195
  L4_195 = L4_195.GetTimeDate
  L4_195 = L4_195(L5_196, L3_194 / 1000)
  L5_196 = string
  L5_196 = L5_196.format
  L5_196 = L5_196("%02d/%02d %02d:%02d:%02d", L4_195.day, L4_195.month, L4_195.hour, L4_195.min, L4_195.sec)
  L2_193 = L2_193:gsub("{TIME}", L5_196)
  return L2_193
end
function class.getStopGrabCall(A0_197)
  local L1_198, L2_199, L3_200
  L1_198 = KFDBGetRecord
  L2_199 = "ConfigValue"
  L3_200 = "MENPAI:MENPAI_GRAB_RIGHT_POST_STOP"
  L1_198 = L1_198(L2_199, L3_200)
  if L1_198 then
    L2_199 = L1_198.content
  else
    L1_198 = L2_199 or ""
  end
  L2_199 = KFDBGetRecord
  L3_200 = "LanguageSetting"
  L2_199 = L2_199(L3_200, L1_198)
  if L2_199 then
    L3_200 = L2_199.content
  else
    L2_199 = L3_200 or ""
  end
  L3_200 = Logic
  L3_200 = L3_200.Get
  L3_200 = L3_200(L3_200, "PlayerInfo")
  L3_200 = L3_200.GetPlayerName
  L3_200 = L3_200(L3_200)
  L2_199 = L2_199:gsub("{NAME}", L3_200)
  return L2_199
end
function class.getExpPer(A0_201)
  local L1_202
  L1_202 = KFDBGetRecord
  L1_202 = L1_202("MenpaiLevelConfig", tostring(A0_201.SectInfo.level + 1))
  L1_202 = L1_202 and tonumber(L1_202.needExp)
  if not L1_202 then
    return 100
  end
  return math.ceil(100 * (A0_201.SectInfo.exp - (KFDBGetRecord("MenpaiLevelConfig", tostring(A0_201.SectInfo.level)) and tonumber(KFDBGetRecord("MenpaiLevelConfig", tostring(A0_201.SectInfo.level)).needExp) or 100)) / (L1_202 - (KFDBGetRecord("MenpaiLevelConfig", tostring(A0_201.SectInfo.level)) and tonumber(KFDBGetRecord("MenpaiLevelConfig", tostring(A0_201.SectInfo.level)).needExp) or 100)))
end
function class.getSectInfo(A0_203)
  local L1_204
  L1_204 = A0_203.SectInfo
  return L1_204
end
function class.getSectId(A0_205)
  local L1_206
  L1_206 = A0_205.SectId
  return L1_206
end
function class.isSameMenpai(A0_207, A1_208, A2_209)
  if type(A1_208) == "table" then
    A1_208 = A1_208.Value or A1_208.value
  end
  if type(A2_209) == "table" then
    A2_209 = A2_209.Value or A2_209.value
  end
  if A1_208 == nil or A2_209 == nil or A1_208 == ID[-1] or A2_209 == ID[-1] then
    return false
  end
  if A1_208 == A2_209 then
    return true
  end
  if type(A1_208) == "string" and type(A2_209) == "string" then
    return Id2Str(A1_208) ~= nil and Id2Str(A1_208) == Id2Str(A2_209)
  end
  if type(A1_208) == "string" then
    return Id2Str(A1_208) ~= nil and Id2Str(A1_208) == tostring(A2_209)
  end
  if type(A2_209) == "string" then
    return Id2Str(A2_209) ~= nil and Id2Str(A2_209) == tostring(A1_208)
  end
  return false
end
function class.setSectId(A0_210, A1_211)
  local L2_212
  L2_212 = ID
  L2_212 = L2_212[-1]
  if A1_211 ~= L2_212 then
    A0_210.SectId = A1_211
  end
end
function class.setSectCall(A0_213, A1_214)
  A0_213.SectInfo.post = A1_214
end
function class.setSectDecl(A0_215, A1_216)
  A0_215.SectInfo.declaration = A1_216
end
function class.isGrabRight(A0_217)
  local L1_218
  L1_218 = A0_217.SectInfo
  if L1_218 then
    L1_218 = A0_217.SectInfo
    L1_218 = L1_218.endGrabRight
    L1_218 = L1_218 ~= nil
    return L1_218
  end
end
function class.getSpringCoolTime(A0_219)
  return A0_219.SectInfo.coolTime
end
function class.setIsFromHome(A0_220, A1_221)
  A0_220.FromHome = A1_221
end
function class.isFromHome(A0_222)
  local L1_223
  L1_223 = A0_222.FromHome
  return L1_223
end
function class.setIsFromMain(A0_224, A1_225)
  A0_224.FromMain = A1_225
end
function class.isFromMain(A0_226)
  local L1_227
  L1_227 = A0_226.FromMain
  return L1_227
end
function class.getInviteNum(A0_228)
  local L1_229
  L1_229 = A0_228.inviteNum
  return L1_229
end
function class.ExitSectBid(A0_230)
  A0_230:FireEvent(EVT.EXITSECTBID)
end
function class.SetMemberData(A0_231, A1_232)
  A0_231.memberData = A1_232
end
function class.GetMemberData(A0_233)
  local L1_234
  L1_234 = A0_233.memberData
  return L1_234
end
function class.SetMemberList(A0_235, A1_236)
  A0_235.memberList = A1_236
end
function class.GetMemberList(A0_237)
  local L1_238
  L1_238 = A0_237.memberList
  return L1_238
end
function class.GetPlayerId(A0_239)
  local L1_240
  L1_240 = A0_239.playerId
  return L1_240
end
function class.SetGrantPost(A0_241, A1_242)
  A0_241.grantPost = A1_242
end
function class.GetGrantPost(A0_243)
  local L1_244
  L1_244 = A0_243.grantPost
  return L1_244
end
function class.SetJob(A0_245, A1_246)
  A0_245.SectInfo.job = A1_246
end
function class.GetJob(A0_247)
  return A0_247.SectInfo.job
end
function class.GetGrabOverDate(A0_248)
  local L1_249
  L1_249 = A0_248.grabOverDate
  return L1_249
end
function class.GetContributeContent(A0_250)
  local L1_251
  L1_251 = A0_250.contributeContent
  return L1_251
end
function class.GetRefreshTime(A0_252)
  local L1_253, L2_254
  L1_253 = A0_252.SectInfo
  L1_253 = L1_253.coolTime
  L2_254 = Logic
  L2_254 = L2_254.Get
  L2_254 = L2_254(L2_254, "System")
  L2_254 = L2_254.DiffTime
  L2_254 = L2_254(L2_254, L1_253 / 1000)
  if L2_254 > 0 then
    return (string.format("%02d:%02d:%02d", Logic:Get("System"):SecToDay(L2_254).hour, Logic:Get("System"):SecToDay(L2_254).min, Logic:Get("System"):SecToDay(L2_254).sec))
  end
  return 0
end
function class.GetSummonInfo(A0_255)
  local L1_256
  L1_256 = A0_255.summonInfo
  return L1_256
end
function class.GetDemogListInfo(A0_257)
  local L1_258
  L1_258 = A0_257.demogListInfo
  return L1_258
end
function class.GetAttackInfo(A0_259)
  local L1_260
  L1_260 = A0_259.attackInfo
  return L1_260
end
function class.GetCardInfoByBaseId(A0_261, A1_262)
  local L2_263, L3_264, L4_265, L5_266
  for L5_266 = 1, L3_264(L4_265) do
    if KFDBGetRecord("BaseHero", L5_266) and A1_262 == KFDBGetRecord("BaseHero", L5_266).id then
      return (KFDBGetRecord("BaseHero", L5_266))
    end
  end
  return L2_263
end
function class.GetDemogCardIdByName(A0_267, A1_268)
  if A0_267:GetMenpaiCardInfo() then
    for _FORV_6_ = 1, #A0_267:GetMenpaiCardInfo() do
      if Logic:Get("Hero"):GetHeroInfoByBaseId(A0_267:GetMenpaiCardInfo()[_FORV_6_].baseId).name == A1_268 then
        return A0_267:GetMenpaiCardInfo()[_FORV_6_].id, A0_267:GetMenpaiCardInfo()[_FORV_6_].baseId
      end
    end
  end
end
function class.GetBaseIdByConfig(A0_269, A1_270)
  if KFDBGetRecord("DemogConfig", A1_270) then
    return KFDBGetRecord("DemogConfig", A1_270).baseId
  end
end
function class.SetCheckedDemogInfo(A0_271, A1_272)
  A0_271.checkDemogInfo = A1_272
end
function class.GetCheckedDemogInfo(A0_273)
  local L1_274
  L1_274 = A0_273.checkDemogInfo
  return L1_274
end
function class.SetFromDemog(A0_275, A1_276)
  A0_275.bFromDemog = A1_276
end
function class.IsFromDemog(A0_277)
  local L1_278
  L1_278 = A0_277.bFromDemog
  return L1_278
end
function class.checkNumber(A0_279, A1_280)
  if string.find(A1_280, "%D") then
    return -1
  end
  if Logic:Get("PlayerInfo"):GetPlayerMoney().gift + Logic:Get("PlayerInfo"):GetPlayerMoney().inter + Logic:Get("PlayerInfo"):GetPlayerMoney().gold < tonumber(A1_280) then
    return -2
  end
  if tonumber(A1_280) > (KFDBGetRecord("MenpaiLevelConfig", KFDBGetRecordAmt("MenpaiLevelConfig")) and KFDBGetRecord("MenpaiLevelConfig", KFDBGetRecordAmt("MenpaiLevelConfig")).needExp or 0) / (KFDBGetRecord("ConfigValue", "MENPAI:MENPAI_EXP_COUNT") and tonumber(KFDBGetRecord("ConfigValue", "MENPAI:MENPAI_EXP_COUNT").content) or 1) then
    return -3
  end
  return tonumber(A1_280)
end
function class.GetNeedExp(A0_281)
  if Logic:Get("Sect"):getSectInfo().level < KFDBGetRecordAmt("MenpaiLevelConfig") and KFDBGetRecord("MenpaiLevelConfig", Logic:Get("Sect"):getSectInfo().level + 1) and KFDBGetRecord("MenpaiLevelConfig", Logic:Get("Sect"):getSectInfo().level + 1).needExp then
  end
  return KFDBGetRecord("MenpaiLevelConfig", Logic:Get("Sect"):getSectInfo().level + 1).needExp - Logic:Get("Sect"):getSectInfo().exp
end
function class.GetSectLevelExp(A0_282, A1_283)
  if KFDBGetRecord("MenpaiLevelConfig", A1_283) and KFDBGetRecord("MenpaiLevelConfig", A1_283).needExp then
    return KFDBGetRecord("MenpaiLevelConfig", A1_283).needExp
  end
  return -1
end
function class.UpdateSectInfo(A0_284, A1_285)
  local L2_286
  L2_286 = A0_284.SectInfo
  if L2_286 then
    L2_286 = A0_284.SectInfo
    L2_286.exp = A1_285
    L2_286 = A0_284.SectInfo
    L2_286 = L2_286.level
    L2_286 = L2_286 + 1
    while true do
      if A0_284:GetSectLevelExp(L2_286) == -1 then
        break
      end
      if A0_284:GetSectLevelExp(L2_286) <= A0_284.SectInfo.exp then
        A0_284.SectInfo.level = L2_286
        L2_286 = L2_286 + 1
      else
        return
      end
    end
  end
end
function class.GetCardBaseIds(A0_287)
  local L1_288, L2_289, L3_290, L4_291, L5_292
  L1_288 = {}
  for L5_292 = 1, L3_290(L4_291) do
    if KFDBGetRecordByIdx("BaseHero", L5_292) and KFDBGetRecordByIdx("BaseHero", L5_292).card == "MENPAI_CARD" then
      table.insert(L1_288, KFDBGetRecordByIdx("BaseHero", L5_292).id)
    end
  end
  L2_289(L3_290)
  return L1_288
end
function class.GetMenpaiCardInfo(A0_293)
  local L1_294
  L1_294 = Logic
  L1_294 = L1_294.Get
  L1_294 = L1_294(L1_294, "Hero")
  L1_294 = L1_294.GetMenpaiCard
  L1_294 = L1_294(L1_294)
  return (Logic:Get("Hero"):GetHeroInfosByIds(L1_294))
end
function class.SetCheckedId(A0_295, A1_296, A2_297)
  A0_295.checkedCardId = A1_296
  A0_295.checkedBaseId = A2_297
end
function class.GetCheckedId(A0_298)
  local L1_299, L2_300
  L1_299 = A0_298.checkedCardId
  L2_300 = A0_298.checkedBaseId
  return L1_299, L2_300
end
function class.GetCardMixList(A0_301)
  local L1_302, L2_303
  L1_302 = {}
  L2_303 = A0_301.GetMenpaiCardInfo
  L2_303 = L2_303(A0_301)
  if not table.empty(L2_303) and A0_301.checkedCardId then
    for _FORV_6_ = 1, #L2_303 do
      if not L2_303[_FORV_6_].locked and L2_303[_FORV_6_].baseId == A0_301.checkedBaseId then
        table.insert(L1_302, L2_303[_FORV_6_].id)
      end
    end
  end
  return L1_302
end
function class.PostRankUp(A0_304, A1_305)
  local L2_306, L3_307, L4_308, L5_309, L6_310, L7_311, L8_312, L9_313, L10_314, L11_315, L12_316
  L2_306 = {}
  L3_307 = Logic
  L4_308 = L3_307
  L3_307 = L3_307.Get
  L5_309 = "Sect"
  L3_307 = L3_307(L4_308, L5_309)
  L4_308 = L3_307
  L3_307 = L3_307.GetCardMixList
  L3_307 = L3_307(L4_308)
  L4_308 = Logic
  L5_309 = L4_308
  L4_308 = L4_308.Get
  L6_310 = "Hero"
  L4_308 = L4_308(L5_309, L6_310)
  L5_309 = L4_308
  L4_308 = L4_308.GetHeroInfoById
  L6_310 = A1_305
  L4_308 = L4_308(L5_309, L6_310)
  L5_309 = Logic
  L6_310 = L5_309
  L5_309 = L5_309.Get
  L7_311 = "Hero"
  L5_309 = L5_309(L6_310, L7_311)
  L6_310 = L5_309
  L5_309 = L5_309.GetHeroInfoByBaseId
  L7_311 = L4_308.baseId
  L5_309 = L5_309(L6_310, L7_311)
  if L5_309 ~= nil then
    L6_310 = L5_309.costHeros
    if L6_310 ~= nil then
      L6_310 = L5_309.costHeros
    end
  elseif L6_310 == "" then
    return
  end
  L6_310 = json
  L6_310 = L6_310.decode
  L7_311 = L5_309.costHeros
  L6_310 = L6_310(L7_311)
  L7_311 = {}
  for L11_315, L12_316 in L8_312(L9_313) do
    for _FORV_16_ = 1, L12_316 do
      table.insert(L7_311, L11_315)
    end
  end
  for L11_315, L12_316 in L8_312(L9_313) do
    if A1_305 ~= L12_316 and #L2_306 < #L7_311 then
      table.insert(L2_306, L12_316)
    end
  end
  L11_315 = {}
  L11_315.src = A1_305
  L11_315.tar = L2_306
  L8_312(L9_313, L10_314, L11_315)
end
function class.checkCardEvolution(A0_317, A1_318)
  local L2_319, L3_320, L4_321, L5_322, L6_323, L7_324, L8_325, L9_326, L10_327
  L2_319 = KFDBGetRecord
  L3_320 = "BaseHero"
  L4_321 = A1_318
  L2_319 = L2_319(L3_320, L4_321)
  if L2_319 then
    L3_320 = L2_319.nextId
    if nil ~= L3_320 then
      L3_320 = L2_319.nextId
    end
  elseif L3_320 <= 0 then
    L3_320 = -1
    return L3_320
  end
  L3_320 = json
  L3_320 = L3_320.decode
  L4_321 = L2_319.costHeros
  L3_320 = L3_320(L4_321)
  L5_322 = A0_317
  L4_321 = A0_317.GetMenpaiCardInfo
  L4_321 = L4_321(L5_322)
  L5_322 = 0
  L6_323 = 0
  for L10_327, _FORV_11_ in L7_324(L8_325) do
    if L10_327 and L10_327 ~= 0 then
      L5_322 = _FORV_11_ + 1
      L6_323 = tonumber(L10_327)
    end
    for _FORV_15_ = 1, #L4_321 do
      if L4_321[_FORV_15_].baseId == L6_323 then
        L5_322 = L5_322 - 1
      end
      if L5_322 == 0 then
        return 0
      end
    end
  end
  return L7_324
end
function class.PostRefreshCardList(A0_328)
  A0_328:FireEvent(EVT.REFRESH_CARD_LIST)
end
function class.SetMixMenpaiCard(A0_329, A1_330)
  A0_329.bfromMix = A1_330
end
function class.IsMixMenaiCard(A0_331)
  local L1_332
  L1_332 = A0_331.bfromMix
  return L1_332
end
function class.UpdatePrayInfo(A0_333, A1_334)
  if not A0_333.prayTimes then
    A0_333.prayTimes = A1_334
  end
  if A0_333.prayTimes == 0 then
    A0_333:FireEvent(EVT.MAMMON_NEW)
  end
end
function class.IsPrayNew(A0_335)
  local L1_336
  L1_336 = A0_335.SectInfo
  L1_336 = L1_336.prayTimes
  if not L1_336 then
    L1_336 = A0_335.prayTimes
    L1_336 = L1_336 == 0
    return L1_336
  else
    L1_336 = A0_335.SectInfo
    L1_336 = L1_336.prayTimes
    L1_336 = L1_336 == 0
    return L1_336
  end
end
function class.GetPrayCostAndReward(A0_337, A1_338, A2_339)
  local L3_340, L4_341, L5_342
  L3_340 = 0
  L4_341 = 0
  L5_342 = Logic
  L5_342 = L5_342.Get
  L5_342 = L5_342(L5_342, "PlayerInfo")
  L5_342 = L5_342.GetPlayerLevel
  L5_342 = L5_342(L5_342)
  if KFDBGetRecord("LevelConfig", L5_342) and KFDBGetRecord("LevelConfig", L5_342).prayCost and KFDBGetRecord("LevelConfig", L5_342).prayReward then
    if not A2_339 then
      L3_340 = json.decode(KFDBGetRecord("LevelConfig", L5_342).prayCost or "[]")[A1_338 + 1] or json.decode(KFDBGetRecord("LevelConfig", L5_342).prayCost or "[]")[#json.decode(KFDBGetRecord("LevelConfig", L5_342).prayCost or "[]")]
      L4_341 = json.decode(KFDBGetRecord("LevelConfig", L5_342).prayReward or "[]")[A1_338 + 1] or json.decode(KFDBGetRecord("LevelConfig", L5_342).prayReward or "[]")[#json.decode(KFDBGetRecord("LevelConfig", L5_342).prayReward or "[]")]
    else
      for _FORV_12_ = 1, 10 do
        L3_340 = L3_340 + (json.decode(KFDBGetRecord("LevelConfig", L5_342).prayCost or "[]")[A1_338 + _FORV_12_] or json.decode(KFDBGetRecord("LevelConfig", L5_342).prayCost or "[]")[#json.decode(KFDBGetRecord("LevelConfig", L5_342).prayCost or "[]")])
        L4_341 = L4_341 + (json.decode(KFDBGetRecord("LevelConfig", L5_342).prayReward or "[]")[A1_338 + _FORV_12_] or json.decode(KFDBGetRecord("LevelConfig", L5_342).prayReward or "[]")[#json.decode(KFDBGetRecord("LevelConfig", L5_342).prayReward or "[]")])
      end
    end
  end
  return L3_340, L4_341
end
function class.GetNameByPos(A0_343, A1_344)
  local L2_345
  A1_344 = A1_344 or "posType"
  L2_345 = {}
  L2_345.BOSS = 110138
  L2_345.ELDER = 110139
  L2_345.MEMBER = 110140
  L2_345.STRANGE = 110013
  if L2_345[A1_344] then
    return TwGetStr(L2_345[A1_344])
  else
    return ""
  end
end
function class.SetInfoFromLogin(A0_346, A1_347)
  if A1_347 and A1_347.menpaiId then
    if A1_347.menpaiId ~= ID[-1] then
      A0_346:setSectId(A1_347.menpaiId)
    end
    if A1_347.prayTime then
      A0_346:UpdatePrayInfo(A1_347.prayTime)
    end
    if A1_347.job then
      A0_346:SetJob(A1_347.job)
    end
    if A1_347.joinBidDate then
      A0_346.joinBidDate = A1_347.joinBidDate
    end
    if A1_347.joinFightDate then
      A0_346.joinFightDate = A1_347.joinFightDate
    end
    if A1_347.reportDate then
      A0_346.reportDate = A1_347.reportDate
    end
    if A1_347.country > 0 then
      A0_346.isJoined = true
    end
    A0_346.needRename = A1_347.needRename
  end
end
function class.getAttackDemogCoolTime(A0_348)
  local L1_349
  L1_349 = A0_348.demogListInfo
  if L1_349 then
    L1_349 = A0_348.demogListInfo
    L1_349 = L1_349.attackCooltime
  end
  return L1_349
end
function class.setAttackDemogCoolTime(A0_350, A1_351)
  local L2_352
  L2_352 = A0_350.demogListInfo
  if L2_352 then
    L2_352 = A0_350.demogListInfo
    L2_352.attackCooltime = A1_351
  end
end
function class.setFromDemogList(A0_353, A1_354)
  A0_353.FromDemogList = A1_354
end
function class.isFromDemogList(A0_355)
  local L1_356
  L1_356 = A0_355.FromDemogList
  return L1_356
end
function class.getJobSetting(A0_357)
  local L1_358, L2_359, L3_360, L4_361
  if L1_358 ~= nil then
  elseif L1_358 then
    for L4_361 = 1, L2_359(L3_360) do
      A0_357.jobSettings[KFDBGetRecordByIdx("JobAuthSetting", L4_361).job] = json.decode(KFDBGetRecordByIdx("JobAuthSetting", L4_361).auths == "" and "[]" or KFDBGetRecordByIdx("JobAuthSetting", L4_361).auths)
    end
  end
  return L1_358
end
function class.checkAuth(A0_362, A1_363, A2_364)
  if A1_363 == Logic.Sect.JobType.BOSS then
  elseif A1_363 == Logic.Sect.JobType.ELDER then
  elseif A1_363 == Logic.Sect.JobType.MEMBER then
  else
  end
  if not A0_362.jobSettings.STRANGE then
    return false
  end
  for _FORV_7_ = 1, #A0_362.jobSettings.STRANGE do
    if A0_362.jobSettings.STRANGE[_FORV_7_] == A2_364 then
      return true
    end
  end
  return _FOR_
end
function class.setFromFriend(A0_365, A1_366)
  A0_365.bFromFriend = A1_366
end
function class.manageErr(A0_367, A1_368)
  if A0_367.bFromFriend then
    A0_367.bFromFriend = false
    return
  end
  if A1_368 == _UPVALUE0_.MENPAI_NOT_FOUND or A1_368 == _UPVALUE0_.MENPAI_DISBAND or A1_368 == _UPVALUE0_.MENPAI_NOT_JOIN then
    if A0_367.FromHome then
      A0_367:jumpToSectListAdd()
      return
    end
    A0_367.SectInfo = {}
    A0_367.SectId = ID[-1]
    A0_367.FromHome = false
    A0_367.FromMain = false
    A0_367.inviteNum = 0
    Prompt:Confirm(A0_367, "", TwGetStr(110174), A0_367.jumpToSectListAdd, Prompt.PROMPT_TYPE.CONFIRM)
    return
  end
  if A1_368 == _UPVALUE0_.MENPAI_AUTH_DENY then
    Prompt:Confirm(A0_367, "", TwGetStr(110151), A0_367.PostGetSelefMenpai, Prompt.PROMPT_TYPE.CONFIRM)
    return
  end
  Logic:Get("MsgAssist"):OnMsgResult("MsgMenpai", A1_368)
end
function class.jumpToSectListAdd(A0_369)
  SceneHelper:runWithScene("SectListAdd")
end
function class.getGodRewardsDesc(A0_370)
  if A0_370.SectInfo == nil or A0_370.SectInfo.level == nil then
    return ""
  end
  return KFDBGetRecord("MenpaiLevelConfig", A0_370.SectInfo.level) == nil and "" or KFDBGetRecord("MenpaiLevelConfig", A0_370.SectInfo.level).godDesc
end
function class.setCallDemog(A0_371, A1_372)
  A0_371.callFlag = A1_372
end
function class.isCallDemog(A0_373)
  local L1_374
  L1_374 = A0_373.callFlag
  return L1_374
end
function class.setWordRefreshTime(A0_375, A1_376)
  A0_375.lastWordRefreshTime = A1_376
end
function class.getWordRefreshTime(A0_377)
  local L1_378
  L1_378 = A0_377.lastWordRefreshTime
  return L1_378
end
function class.IsNewApplyState(A0_379)
  local L1_380
  L1_380 = A0_379.SectInfo
  L1_380 = L1_380.aplypNum
  L1_380 = L1_380 ~= A0_379.prevApplyNum
  return L1_380
end
function class.postBidForCountry(A0_381, A1_382, A2_383)
  if A1_382 and A2_383 then
    MsgMenpai:Post("BID_FOR_COUNTRY", {count = A1_382, country = A2_383})
  end
end
function class.PostExchangeGoods(A0_384, A1_385, A2_386)
  if A1_385 then
    A0_384.goodsExchangId = A1_385
    A0_384.goodsExchangCount = A2_386
    MsgMenpai:Post("EXCHAGE_GOODS", {goods = A1_385, times = A2_386})
  end
end
function class.PostCountryHold(A0_387)
  A0_387:FireEvent(EVT.COUNTRY_FIGTH_END)
  MsgMenpai:Post("COUNTRY_DATA")
end
function class.PostCountryFightJoined(A0_388, A1_389, A2_390)
  if A2_390 then
    MsgMenpai:Post("COUNTRY_FIGHT_JOINED", {join = A1_389, country = A2_390})
  end
end
function class.PostCountryFightResult(A0_391)
  if A0_391.countryFightId ~= 0 then
    MsgMenpai:Post("COUNTRY_FIGHT_RESULT", {
      country = A0_391.countryFightId
    })
  end
end
function class.OnBidForCountry(A0_392, A1_393, A2_394)
  if A1_393 == 0 then
    A0_392.SectInfo.money = A2_394.currentMoney
    A0_392:FireEvent(EVT.SECT_MONEY_CHANGED, A2_394.currentMoney)
    A0_392:FireEvent(EVT.COUNTRY_BID_FINISH)
  elseif A1_393 == _UPVALUE0_.BID_COUNTRY_TIMEOUT then
    Prompt:Confirm(A0_392, "", TwGetStr(108094), A0_392.countryBidEnd, Prompt.PROMPT_TYPE.CONFIRM)
  else
    Logic:Get("MsgAssist"):OnMsgResult("MsgMenpai", A1_393)
  end
end
function class.OnCountryFightJoined(A0_395, A1_396, A2_397)
  if A1_396 == 0 then
    A0_395.countryFightJoinedInfo = A2_397
    A0_395:FireEvent(EVT.COUNTRY_FIGHT_JOIN)
    A0_395:FireEvent(EVT.COUNTRY_FIGHT_HAS_JOINED)
    A0_395:FireEvent(EVT.REFRESH_FIGHT_LIST)
  else
    if A1_396 == _UPVALUE0_.FIGHT_JOIN_TIME_OUT then
      Prompt:Confirm(A0_395, "", TwGetStr(108095), A0_395.PostCountryHold, Prompt.PROMPT_TYPE.CONFIRM)
      return
    end
    if A1_396 == _UPVALUE0_.COUNTRY_FIGHT_FORBID then
      Prompt:Confirm(A0_395, "", TwGetStr(108092), A0_395.PostCountryHold, Prompt.PROMPT_TYPE.CONFIRM)
      return
    end
    Logic:Get("MsgAssist"):OnMsgResult("MsgMenpai", A1_396)
  end
end
function class.OnCountryFightResult(A0_398, A1_399, A2_400)
  if A1_399 == 0 then
    if A2_400 == nil then
      return
    end
    A0_398:setBSuccess(true)
    A0_398.countryFightResult = A2_400
    A0_398.countryFightJoinedInfo = A2_400.fightJoinedVo
    A0_398:FireEvent(EVT.START_BATTLE)
  else
    if A1_399 == _UPVALUE0_.COUNTRY_FIGHT_NOT_HAPPEN then
      if A0_398:compareTime(A0_398.joinFightDate[1], A0_398.joinFightDate[2]) or A0_398:compareTime(A0_398.reportDate[1], A0_398.reportDate[2]) then
        Logic:Get("SureConfirm").btnText.ok = TwGetStr(108150)
        Prompt:Confirm(A0_398, "", TwGetStr(108149), A0_398.PostCountryFightResult, Prompt.PROMPT_TYPE.CONFIRM)
        return
      end
      if not A0_398:compareTime(A0_398.reportDate[1], A0_398.reportDate[2]) then
        Prompt:Confirm(Logic:Get("Main"), "", TwGetStr(108151), Logic:Get("Main").GotoHomePage, Prompt.PROMPT_TYPE.CONFIRM)
        return
      end
    end
    Logic:Get("MsgAssist"):OnMsgResult("MsgMenpai", A1_399)
  end
end
function class.OnGetGoods(A0_401, A1_402, A2_403)
  if A1_402 == 0 then
    A0_401.goodsList = A2_403
    A0_401:FireEvent(EVT.GET_GOODS_LIST)
  end
end
function class.OnExchageGoods(A0_404, A1_405, A2_406)
  local L3_407
  if A1_405 == 0 then
    L3_407 = tonumber
    L3_407 = L3_407(A2_406.costs[1].amount)
    A0_404.goodsExchangeMoney = L3_407
    L3_407 = A0_404.setFeatAndExchang
    L3_407(A0_404)
    L3_407 = Logic
    L3_407 = L3_407.Get
    L3_407 = L3_407(L3_407, "Reward")
    L3_407 = L3_407.AddRewards
    L3_407(L3_407, A2_406.rewards)
    L3_407 = Logic
    L3_407 = L3_407.Get
    L3_407 = L3_407(L3_407, "Reward")
    L3_407 = L3_407.AddRewardsTip
    L3_407 = L3_407(L3_407, A2_406.rewards)
    Prompt:Fail(L3_407)
    A0_404:FireEvent(EVT.GET_GOODS_LIST)
  end
end
function class.OnQuitCountryFight(A0_408, A1_409, A2_410)
  if A1_409 == 0 then
    A0_408:FireEvent(EVT.COUNTRY_FIGHT_QUIT)
  end
end
function class.OnMenpaiCountryFight(A0_411)
  A0_411.canJoin = true
  A0_411:FireEvent(EVT.CAN_JOIN_FIGHT)
end
function class.OnCountryData(A0_412, A1_413, A2_414)
  if A1_413 == 0 then
    if not A2_414 then
      return
    end
    A0_412.countryInfo = A2_414
    A0_412:openCountry()
    A0_412:FireEvent(EVT.REFRESH_COUNTRY_INFO)
  end
end
function class.OnMenpaiRename(A0_415, A1_416, A2_417)
  if A1_416 ~= 0 then
    A0_415:FireEvent(EVT.RENAME_ERROR)
    return
  end
  A0_415:FireEvent(EVT.RENAME_SUCCESSED)
end
function class.GetCountryHoldInfo(A0_418)
  local L1_419
  L1_419 = A0_418.countryHold
  return L1_419
end
function class.GetBidInfo(A0_420)
  local L1_421
  L1_421 = A0_420.joinBidInfo
  return L1_421
end
function class.GetFightInfo(A0_422)
  local L1_423
  L1_423 = A0_422.joinFightInfo
  return L1_423
end
function class.GetJoinBidDate(A0_424)
  local L1_425
  L1_425 = A0_424.joinBidDate
  return L1_425
end
function class.GetJoinFightDate(A0_426)
  local L1_427
  L1_427 = A0_426.joinFightDate
  return L1_427
end
function class.GetReportDate(A0_428)
  local L1_429
  L1_429 = A0_428.reportDate
  return L1_429
end
function class.compareTime(A0_430, A1_431, A2_432)
  if A1_431 == nil or A2_432 == nil then
    return
  end
  if Logic:Get("System"):DiffTime(A1_431 / 1000) <= 0 and Logic:Get("System"):DiffTime(A2_432 / 1000) >= 0 then
    return true
  end
  return false
end
function class.setCountryId(A0_433, A1_434)
  A0_433.countryId = A1_434
end
function class.getCountryId(A0_435)
  local L1_436
  L1_436 = A0_435.countryId
  return L1_436
end
function class.GetCountryFightJoinedInfo(A0_437)
  local L1_438
  L1_438 = A0_437.countryFightJoinedInfo
  return L1_438
end
function class.getGoodsList(A0_439)
  local L1_440
  L1_440 = A0_439.goodsList
  return L1_440
end
function class.getFeat(A0_441)
  return A0_441.goodsList.money
end
function class.setFeatAndExchang(A0_442)
  if A0_442.goodsList == nil then
    return
  end
  A0_442.goodsList.money = A0_442.goodsList.money - A0_442.goodsExchangeMoney
  for _FORV_4_, _FORV_5_ in ipairs(A0_442.goodsList.goods) do
    if _FORV_5_.id == A0_442.goodsExchangId then
      _FORV_5_.exchange = _FORV_5_.exchange + A0_442.goodsExchangCount
      break
    end
  end
end
function class.getCountryFightResult(A0_443)
  local L1_444
  L1_444 = A0_443.countryFightResult
  return L1_444
end
function class.fightMemberSort(A0_445, A1_446)
  if A1_446 == nil or table.empty(A1_446) then
    return
  end
  table.sort(A1_446, function(A0_447, A1_448)
    local L2_449, L3_450
    L2_449 = A0_447.job
    L3_450 = A1_448.job
    if L2_449 == L3_450 then
      L2_449 = A0_447.fightScore
      L3_450 = A1_448.fightScore
      L2_449 = L2_449 > L3_450
      return L2_449
    else
      L2_449 = A0_447.job
      L3_450 = A1_448.job
      L2_449 = L2_449 < L3_450
      return L2_449
    end
  end)
  return A1_446
end
function class.isJoinCountryFightTime(A0_451)
  if table.empty(A0_451.joinFightDate or {}) then
    return false
  end
  if A0_451:compareTime(A0_451.joinFightDate[1], A0_451.joinFightDate[2]) then
    if A0_451.isJoined then
      return true
    else
      return false
    end
  end
  return false
end
function class.canJoinCountryFight(A0_452)
  local L1_453
  L1_453 = A0_452.canJoin
  return L1_453
end
function class.setCanJoinState(A0_454, A1_455)
  A0_454.canJoin = A1_455
  A0_454:FireEvent(EVT.CAN_JOIN_FIGHT)
end
function class.setEnterWord(A0_456, A1_457)
  A0_456.enterWord = A1_457
end
function class.getEnterWord(A0_458)
  local L1_459
  L1_459 = A0_458.enterWord
  return L1_459
end
function class.fightWinChat(A0_460, A1_461)
  table.insert(A0_460.chat, A1_461)
  if not A0_460.isChat then
    A0_460:FireEvent(EVT.FIGHT_CHAT)
    A0_460.isChat = true
  end
end
function class.getChat(A0_462)
  local L1_463
  L1_463 = A0_462.chat
  L1_463 = L1_463[1]
  if L1_463 then
    L1_463 = A0_462.chat
    L1_463 = L1_463[1]
    return L1_463
  else
    A0_462.isChat = false
  end
end
function class.removeChat(A0_464)
  if A0_464.chat[1] then
    table.remove(A0_464.chat, 1)
  end
end
function class.initChat(A0_465)
  A0_465.chat = {}
  A0_465.isChat = false
end
function class.battleEnd(A0_466)
  A0_466:FireEvent(EVT.CLOSE_FIGHT)
end
function class.setCountryInfoAboutBid(A0_467, A1_468)
  A0_467.countryInfoOnBid = A1_468
end
function class.getCountryInfoAboutBid(A0_469)
  local L1_470
  L1_470 = A0_469.countryInfoOnBid
  return L1_470
end
function class.setBSuccess(A0_471, A1_472)
  A0_471.bSuccess = A1_472
end
function class.getBSuccess(A0_473)
  local L1_474
  L1_474 = A0_473.bSuccess
  return L1_474
end
function class.countryBidEnd(A0_475)
  A0_475:FireEvent(EVT.COUNTRY_BID_END)
end
function class.getHoldRewardDate(A0_476)
  local L1_477
  L1_477 = A0_476.holdRewardDate
  return L1_477
end
function class.refreshJoinCount(A0_478, A1_479)
  A0_478:FireEvent(EVT.REFRESH_JOINT_COUNT, A1_479)
end
function class.setCountryIdOfReprot(A0_480, A1_481)
  if A1_481 then
    A0_480.countryFightId = A1_481
  end
end
function class.setEnterBattle(A0_482, A1_483)
  A0_482.isEnterBattle = A1_483
end
function class.IsEnterSectBattle(A0_484)
  local L1_485
  L1_485 = A0_484.isEnterBattle
  return L1_485
end
function class.getCountryInfo(A0_486)
  local L1_487
  L1_487 = A0_486.countryInfo
  return L1_487
end
function class.countryFightTimer(A0_488)
  if table.empty(A0_488.countryInfo or {}) then
    return 0
  end
  return A0_488.countryInfo.state
end
function class.ownCountryInfo(A0_489)
  if table.empty(A0_489.countryInfo or {}) then
    return 0
  end
  return A0_489.countryInfo.ownData
end
function class.holdCountryCount(A0_490)
  local L1_491, L2_492
  L1_491 = 0
  L2_492 = table
  L2_492 = L2_492.empty
  L2_492 = L2_492(A0_490.countryInfo or {})
  if L2_492 then
    return L1_491
  end
  L2_492 = table
  L2_492 = L2_492.empty
  L2_492 = L2_492(A0_490.countryInfo.countryDatas or {})
  if L2_492 then
    return L1_491
  end
  L2_492 = A0_490.getSectId
  L2_492 = L2_492(A0_490)
  for _FORV_6_, _FORV_7_ in pairs(A0_490.countryInfo.countryDatas) do
    if _FORV_7_.data and _FORV_7_.data.menpaiInfo and A0_490:isSameMenpai(_FORV_7_.data.menpaiInfo.id, L2_492) then
      L1_491 = L1_491 + 1
    end
  end
  return L1_491
end
function class.isHoldThisCountry(A0_493, A1_494)
  local L2_495
  L2_495 = table
  L2_495 = L2_495.empty
  L2_495 = L2_495(A0_493.countryInfo or {})
  if not L2_495 then
    L2_495 = table
    L2_495 = L2_495.empty
    L2_495 = L2_495(A0_493.countryInfo.countryDatas or {})
  elseif L2_495 then
    L2_495 = false
    return L2_495
  end
  L2_495 = tonumber
  L2_495 = L2_495(A1_494)
  A1_494 = L2_495
  L2_495 = A0_493.getSectId
  L2_495 = L2_495(A0_493)
  for _FORV_6_, _FORV_7_ in pairs(A0_493.countryInfo.countryDatas) do
    if _FORV_7_.data and tonumber(_FORV_7_.data.id) == A1_494 and _FORV_7_.data.menpaiInfo and A0_493:isSameMenpai(_FORV_7_.data.menpaiInfo.id, L2_495) then
      return true
    end
  end
  return false
end
function class.isHoldCountry(A0_496)
  return A0_496:holdCountryCount() >= 2
end
function class.openCountry(A0_497)
  A0_497.openCountryMap = {}
  for _FORV_4_, _FORV_5_ in pairs(A0_497.countryInfo.countryDatas) do
    if _FORV_5_.data.id then
      A0_497.openCountryMap[KFDBGetRecord("CountrySetting", _FORV_5_.data.id).position] = true
    end
  end
end
function class.getOpenCountry(A0_498)
  local L1_499
  L1_499 = A0_498.openCountryMap
  return L1_499
end
function class.IsNeedRename(A0_500)
  local L1_501
  L1_501 = A0_500.needRename
  return L1_501
end
