local L0_0
L0_0 = require
L0_0("NetMsg")
L0_0 = module
L0_0((...), package.seeall)
L0_0 = nil
EVT = Enum({
  "CONN",
  "FAILED",
  "CLOSE",
  "LOGIN",
  "SESSION_TIMEOUT",
  "ERROR",
  "EMAIL",
  "ANNOUCEMENT",
  "FRIEND",
  "CHARGE",
  "NEW_GIFT",
  "NEW_EMBLEM_ACHIEVE",
  "VERSION_CHANGE",
  "VIP_CHANGE",
  "POINT_EXTRA",
  "FIGHT_POINT",
  "NEW_ARENA_INTEGRAL",
  "NEW_DEMOG",
  "DEMOG_ACTIVE_OPEN",
  "FRIEND_GIFT",
  "NEW_ACTIVITY",
  "NEW_DAY",
  "MENPAI_DEMOG",
  "TASK_COMPLETE",
  "CONSUME_RANK_SCORE_REWARD",
  "GIFT_SP_COMMENT_CLOSED",
  "MENPAI_COUNTRY_FIGHT",
  "TENCENT_NEED_LOGIN",
  "GOD_TASK_COMPLETE",
  "MONOPOLY_TASK_COMPLETE",
  "NEW_MONOPOLY_TASK_COMPLETE"
})
objectlua.Object:subclass():include(Events.Tracer)
objectlua.Object:subclass().initialize = function(A0_1)
  super.initialize(A0_1)
  Events.Tracer.initialize(A0_1)
  A0_1.eventSet = Events.EventSet:new()
  A0_1.active = false
  A0_1.connected = false
  A0_1.waitingResponse = false
  A0_1.order = 0
  A0_1.session = nil
  A0_1.sendQueue = {}
  A0_1.recoveryPaused = false
  A0_1.netType = NETWORK_NONE
end
objectlua.Object:subclass().dispose = function(A0_2)
  A0_2.eventSet:dispose()
  Events.Tracer.dispose(A0_2)
  super.dispose(A0_2)
end
objectlua.Object:subclass().SetNetType = function(A0_3, A1_4)
  A0_3.netType = A1_4 or NETWORK_NONE
end
objectlua.Object:subclass().GetNetType = function(A0_5)
  local L1_6
  L1_6 = A0_5.netType
  return L1_6
end
objectlua.Object:subclass().SetUrlAndPort = function(A0_7, A1_8, A2_9)
  A0_7.connUrl = A1_8
  A0_7.connPort = A2_9
end
objectlua.Object:subclass().Connect = function(A0_10, A1_11, A2_12)
  log4msg:info("Connect to %s:%d", A1_11, A2_12)
  A0_10.active = true
  A0_10.connected = false
  A0_10:fireEvent(EVT.CONN)
  Singleton(Timer):After(10000, A0_10:Event("TIMER_CONN", function()
    _UPVALUE0_:networkFailed("Connect")
  end))
  A0_10.connUrl = A1_11
  A0_10.connPort = A2_12
  CNetMgr:GetSingleton():Connect(A1_11, A2_12)
end
objectlua.Object:subclass().Disconnect = function(A0_13)
  if not A0_13.active then
    return
  end
  log4msg:info("Disconnect")
  A0_13.active = false
  A0_13.connected = false
  A0_13.waitingResponse = false
  A0_13:EventTracer():Cancel("TIMER_CONN")
  A0_13:EventTracer():Cancel("TIMER_RECV")
  A0_13:clearSendQueue()
  CNetMgr:GetSingleton():Disconnect()
  A0_13:fireEvent(EVT.CLOSE)
end
objectlua.Object:subclass().queue = function(A0_14, A1_15, A2_16, A3_17, A4_18)
  local L5_19, L6_20
  L5_19 = A0_14.recoveryPaused
  if L5_19 and not A4_18 then
    L5_19 = log4msg
    L6_20 = L5_19
    L5_19 = L5_19.warn
    L5_19(L6_20, "Drop request while login recovery is active [%d-%d]", A1_15, A2_16)
    L5_19 = false
    return L5_19
  end
  L5_19 = A0_14.session
  if L5_19 == nil and not A4_18 then
    L6_20 = A0_14
    L5_19 = A0_14.fireEvent
    L5_19(L6_20, EVT.LOGIN)
    return
  end
  L5_19 = A0_14.active
  if not L5_19 then
    L6_20 = A0_14
    L5_19 = A0_14.Connect
    L5_19(L6_20, A0_14.connUrl, A0_14.connPort)
  end
  L5_19 = A0_14.session
  if L5_19 == nil and not A4_18 then
    L6_20 = A0_14
    L5_19 = A0_14.fireEvent
    L5_19(L6_20, EVT.LOGIN)
  end
  L5_19 = log4msg
  L6_20 = L5_19
  L5_19 = L5_19.info
  L5_19(L6_20, "Queue [%d-%d]", A1_15, A2_16)
  L5_19 = table
  L5_19 = L5_19.insert
  L6_20 = A0_14.sendQueue
  L5_19(L6_20, {
    login = A4_18,
    mod = A1_15,
    cmd = A2_16,
    data = A3_17
  })
  if A4_18 then
    L5_19 = list
    L5_19 = L5_19.filter
    function L6_20(A0_21)
      local L1_22
      L1_22 = A0_21.login
      return L1_22
    end
    L5_19 = L5_19(L6_20, A0_14.sendQueue)
    L6_20 = list
    L6_20 = L6_20.filter
    L6_20 = L6_20(function(A0_23)
      return not A0_23.login
    end, A0_14.sendQueue)
    A0_14.sendQueue = list.concat(L5_19, L6_20)
  end
  L5_19 = A0_14.connected
  if L5_19 then
    L5_19 = A0_14.waitingResponse
    if not L5_19 then
      L6_20 = A0_14
      L5_19 = A0_14.sendNext
      L5_19(L6_20)
    end
  end
  L5_19 = true
  return L5_19
end
objectlua.Object:subclass().BeginRecovery = function(A0_24)
  if A0_24.recoveryPaused then
    return
  end
  A0_24.recoveryPaused = true
  A0_24:SetSessionID(nil)
  A0_24:clearSendQueue()
  log4msg:warn("Pause normal requests for login recovery.")
end
objectlua.Object:subclass().EndRecovery = function(A0_25)
  A0_25.recoveryPaused = false
  log4msg:info("Resume normal requests after login recovery.")
end
objectlua.Object:subclass().SetSessionID = function(A0_26, A1_27)
  log4msg:info("Session ID: %s", A1_27 or "<nil>")
  A0_26.session = A1_27
  if A0_26.session == nil then
    A0_26.order = 0
  end
end
objectlua.Object:subclass().On = function(A0_28, A1_29, A2_30)
  A0_28.eventSet:bind(A2_30, A1_29)
end
objectlua.Object:subclass().fireEvent = function(A0_31, A1_32, ...)
  local L4_34, L5_35, L6_36
  L4_34 = A0_31.eventSet
  L5_35 = L4_34
  L4_34 = L4_34.fire
  L6_36 = A1_32
  L4_34(L5_35, L6_36, ...)
end
objectlua.Object:subclass().clearSendQueue = function(A0_37)
  A0_37.sendQueue = {}
end
objectlua.Object:subclass().OnNetworkConnect = function(A0_38, A1_39)
  if not A1_39 then
    A0_38:networkFailed("Connect")
    return
  end
  log4msg:info("Connect succeed.")
  A0_38.connected = true
  A0_38:EventTracer():Cancel("TIMER_CONN")
  A0_38:sendNext()
end
objectlua.Object:subclass().OnNetworkClosed = function(A0_40)
  if not A0_40.active then
    return
  end
  A0_40.connected = false
  A0_40.waitingResponse = false
  log4msg:warn("Network closed unexpectedly.")
  A0_40:networkFailed("Closed")
end
objectlua.Object:subclass().sendNext = function(A0_41)
  local L1_42, L2_43
  L1_42 = A0_41.connected
  if L1_42 then
    L1_42 = A0_41.waitingResponse
  elseif L1_42 then
    L1_42 = false
    return L1_42
  end
  L1_42 = table
  L1_42 = L1_42.empty
  L2_43 = A0_41.sendQueue
  L1_42 = L1_42(L2_43)
  if L1_42 then
    L1_42 = false
    return L1_42
  end
  L1_42 = A0_41.sendQueue
  L1_42 = L1_42[1]
  L2_43 = table
  L2_43 = L2_43.remove
  L2_43(A0_41.sendQueue, 1)
  A0_41.waitingResponse = true
  L2_43 = A0_41.doSend
  L2_43(A0_41, L1_42.mod, L1_42.cmd, L1_42.data)
  L2_43 = 15000
  if L1_42.mod == 10 and L1_42.cmd == 7 then
    L2_43 = 60000
  end
  Singleton(Timer):After(L2_43, A0_41:Event("TIMER_RECV", function()
    _UPVALUE0_:networkFailed("Recv")
  end))
  return true
end
objectlua.Object:subclass().doSend = function(A0_44, A1_45, A2_46, A3_47)
  local L4_48, L5_49, L6_50, L7_51, L8_52, L9_53
  A3_47 = A3_47 or ""
  L4_48 = strbuf
  L4_48 = L4_48.new
  L4_48 = L4_48()
  L5_49 = L4_48
  L6_50 = struct
  L6_50 = L6_50.pack
  L7_51 = ">!1I1"
  L8_52 = 0
  L6_50 = L6_50(L7_51, L8_52)
  L4_48 = L5_49 .. L6_50
  L5_49 = L4_48
  L6_50 = struct
  L6_50 = L6_50.pack
  L7_51 = ">!1I4"
  L8_52 = 0
  L6_50 = L6_50(L7_51, L8_52)
  L4_48 = L5_49 .. L6_50
  L5_49 = L4_48
  L6_50 = struct
  L6_50 = L6_50.pack
  L7_51 = ">!1I8"
  L8_52 = A0_44.order
  L6_50 = L6_50(L7_51, L8_52)
  L4_48 = L5_49 .. L6_50
  L5_49 = L4_48
  L6_50 = struct
  L6_50 = L6_50.pack
  L7_51 = ">!1I8"
  L8_52 = 0
  L6_50 = L6_50(L7_51, L8_52)
  L4_48 = L5_49 .. L6_50
  L5_49 = L4_48
  L6_50 = struct
  L6_50 = L6_50.pack
  L7_51 = ">!1i4"
  L8_52 = A2_46
  L6_50 = L6_50(L7_51, L8_52)
  L4_48 = L5_49 .. L6_50
  L5_49 = L4_48
  L6_50 = struct
  L6_50 = L6_50.pack
  L7_51 = ">!1I1"
  L8_52 = A1_45
  L6_50 = L6_50(L7_51, L8_52)
  L4_48 = L5_49 .. L6_50
  L5_49 = tostring
  L6_50 = L4_48
  L5_49 = L5_49(L6_50)
  L4_48 = L5_49
  L5_49 = ">!1I4"
  L6_50 = struct
  L6_50 = L6_50.pack
  L7_51 = L5_49
  L8_52 = struct
  L8_52 = L8_52.size
  L9_53 = L5_49
  L8_52 = L8_52(L9_53)
  L9_53 = #L4_48
  L8_52 = L8_52 + L9_53
  L6_50 = L6_50(L7_51, L8_52)
  L7_51 = L4_48
  L4_48 = L6_50 .. L7_51
  L6_50 = A3_47
  L7_51 = ">!1I4"
  L8_52 = struct
  L8_52 = L8_52.pack
  L9_53 = L7_51
  L8_52 = L8_52(L9_53, struct.size(L7_51) + #L6_50)
  L9_53 = L4_48
  L9_53 = L9_53 .. L8_52 .. L6_50
  if A0_44.session then
    L9_53 = L9_53 .. A0_44.session
  end
  log4msg:info("Send [%d-%d]", A1_45, A2_46)
  CNetMgr:GetSingleton():SendMsg(L9_53)
end
objectlua.Object:subclass().OnNetworkRead = function(A0_54, A1_55)
  local L2_56, L3_57, L4_58, L5_59, L6_60
  L2_56 = A0_54.active
  if not L2_56 then
    return
  end
  L2_56 = 1
  L3_57 = {}
  L4_58 = struct
  L4_58 = L4_58.unpack
  L5_59 = ">!1I4"
  L6_60 = A1_55
  L5_59 = L4_58(L5_59, L6_60, L2_56)
  L2_56 = L5_59
  L3_57.size = L4_58
  L4_58 = struct
  L4_58 = L4_58.unpack
  L5_59 = ">!1I1"
  L6_60 = A1_55
  L5_59 = L4_58(L5_59, L6_60, L2_56)
  L2_56 = L5_59
  L3_57.encoding = L4_58
  L4_58 = struct
  L4_58 = L4_58.unpack
  L5_59 = ">!1I4"
  L6_60 = A1_55
  L5_59 = L4_58(L5_59, L6_60, L2_56)
  L2_56 = L5_59
  L3_57.status = L4_58
  L4_58 = struct
  L4_58 = L4_58.unpack
  L5_59 = ">!1I8"
  L6_60 = A1_55
  L5_59 = L4_58(L5_59, L6_60, L2_56)
  L2_56 = L5_59
  L3_57.order = L4_58
  L4_58 = struct
  L4_58 = L4_58.unpack
  L5_59 = ">!1I8"
  L6_60 = A1_55
  L5_59 = L4_58(L5_59, L6_60, L2_56)
  L2_56 = L5_59
  L3_57.session = L4_58
  L4_58 = struct
  L4_58 = L4_58.unpack
  L5_59 = ">!1i4"
  L6_60 = A1_55
  L5_59 = L4_58(L5_59, L6_60, L2_56)
  L2_56 = L5_59
  L3_57.cmd = L4_58
  L4_58 = struct
  L4_58 = L4_58.unpack
  L5_59 = ">!1I"
  L6_60 = L3_57.size
  L6_60 = L6_60 + 1
  L6_60 = L6_60 - L2_56
  L5_59 = L5_59 .. L6_60
  L6_60 = A1_55
  L5_59 = L4_58(L5_59, L6_60, L2_56)
  L2_56 = L5_59
  L3_57.mod = L4_58
  L4_58 = 4
  L5_59 = {}
  L6_60 = struct
  L6_60 = L6_60.unpack
  L2_56, L6_60 = ">!1I" .. L4_58, L6_60(">!1I" .. L4_58, A1_55, L2_56)
  L5_59.size = L6_60
  L6_60 = L5_59.size
  if L4_58 < L6_60 then
    L6_60 = struct
    L6_60 = L6_60.unpack
    L2_56, L6_60 = ">!1c" .. L5_59.size - L4_58, L6_60(">!1c" .. L5_59.size - L4_58, A1_55, L2_56)
    L5_59.content = L6_60
  end
  L6_60 = _UPVALUE0_
  L6_60 = L6_60.checkStatus
  L6_60 = L6_60(L6_60, L3_57.status, "compress")
  if L6_60 then
    L6_60 = L5_59.content
    if nil ~= L6_60 then
      L6_60 = L5_59.content
      L6_60 = #L6_60
      L5_59.content = Tw.QuickLZ.Inflate(L5_59.content)
    end
  end
  L6_60 = string
  L6_60 = L6_60.sub
  L6_60 = L6_60(A1_55, L2_56)
  A0_54:onReceived(L3_57, L5_59, L6_60)
end
objectlua.Object:subclass().onReceived = function(A0_61, A1_62, A2_63, A3_64)
  local L4_65, L5_66
  L4_65 = A0_61.il
  if not L4_65 then
    L4_65 = {}
    L4_65.lastTime = 0
    L4_65.times = 0
    L5_66 = {}
    L4_65.history = L5_66
  end
  A0_61.il = L4_65
  L4_65 = TimeGetTime
  L4_65 = L4_65()
  L5_66 = A0_61.order
  if L5_66 == 0 then
    L5_66 = A0_61.il
    L5_66 = L5_66.lastTime
    L5_66 = L4_65 - L5_66
    if L5_66 < 5000 then
      L5_66 = A0_61.il
      L5_66.times = A0_61.il.times + 1
    else
      L5_66 = A0_61.il
      L5_66.times = 0
    end
    L5_66 = A0_61.il
    L5_66.lastTime = L4_65
  end
  L5_66 = A0_61.il
  L5_66 = L5_66.times
  if L5_66 > 9 then
    L5_66 = log4msg
    L5_66 = L5_66.warn
    L5_66(L5_66, "Infinite login: %s", table.concat(A0_61.il.history))
    A0_61.il = nil
    return
  end
  L5_66 = A0_61.il
  L5_66 = L5_66.times
  if L5_66 > 5 then
    L5_66 = string
    L5_66 = L5_66.format
    L5_66 = L5_66("[#%d:%d-%d]", A0_61.order, A1_62.mod, A1_62.cmd)
    table.insert(A0_61.il.history, L5_66)
  end
  L5_66 = A0_61.il
  L5_66 = L5_66.times
  if L5_66 > 5 then
    L5_66 = A0_61.il
    L5_66 = L5_66.lastTime
    L5_66 = L4_65 - L5_66
    if L5_66 > 10000 then
      A0_61.il = nil
    end
  end
  L5_66 = log4msg
  L5_66 = L5_66.info
  L5_66(L5_66, "Recv [%d-%d]", A1_62.mod, A1_62.cmd)
  L5_66 = A0_61.order
  L5_66 = L5_66 + 1
  A0_61.order = L5_66
  L5_66 = A0_61.EventTracer
  L5_66 = L5_66(A0_61)
  L5_66 = L5_66.Cancel
  L5_66(L5_66, "TIMER_RECV")
  A0_61.waitingResponse = false
  L5_66 = xpcall
  L5_66(function()
    _UPVALUE0_:Process(_UPVALUE1_, _UPVALUE2_, _UPVALUE3_)
  end, function(A0_67)
    log4misc:warn(A0_67)
    return A0_67
  end)
  L5_66 = A0_61.sendNext
  L5_66(A0_61)
end
objectlua.Object:subclass().Process = function(A0_68, A1_69, A2_70, A3_71)
  local L4_72
  L4_72 = A0_68.ProcessError
  L4_72 = L4_72(A0_68, A1_69.status, A1_69.mod, A1_69.cmd)
  if L4_72 then
    return
  end
  L4_72 = {}
  L4_72.raw = _UPVALUE0_:checkStatus(A1_69.status, "raw")
  L4_72.mod = A1_69.mod
  L4_72.cmd = A1_69.cmd
  L4_72.content = A2_70.content
  L4_72.attachment = A3_71
  Singleton(NetMsg):OnReceived(L4_72)
  A0_68:ProcessAttachment(A3_71)
  A0_68:EventTracer():Cancel("TIMER_SESSION")
  Singleton(Timer):After(3300000, A0_68:Event("TIMER_SESSION", function()
    _UPVALUE0_:SetSessionID(nil)
  end))
end
objectlua.Object:subclass().ProcessError = function(A0_73, A1_74, A2_75, A3_76)
  if not _UPVALUE0_:checkStatus(A1_74, "error") then
    return false
  end
  if _UPVALUE0_:checkStatus(A1_74, "exception_identity") then
    A0_73:SetSessionID(nil)
    A0_73:clearSendQueue()
    A0_73:fireEvent(EVT.SESSION_TIMEOUT)
    return true
  end
  if _UPVALUE0_:checkStatus(A1_74, "exception_order") then
    A0_73:SetSessionID(nil)
    A0_73:clearSendQueue()
    A0_73:fireEvent(EVT.LOGIN)
    return true
  end
  A0_73:fireEvent(EVT.ERROR, A2_75, A3_76)
  return true
end
objectlua.Object:subclass().ProcessAttachment = function(A0_77, A1_78, A2_79)
  local L3_80
  L3_80 = #A1_78
  if L3_80 == 0 then
    return
  end
  L3_80 = struct
  L3_80 = L3_80.unpack
  L3_80 = L3_80(">!1I4", A1_78)
  for _FORV_7_, _FORV_8_ in ipairs(_UPVALUE0_) do
    if _FORV_8_.b == bit.band(_FORV_8_.b, L3_80) then
      A0_77:fireEvent(_FORV_8_.e, A2_79)
    end
  end
end
objectlua.Object:subclass().networkFailed = function(A0_81, A1_82)
  if not A0_81.active then
    return
  end
  log4msg:info("%s failed.", A1_82)
  A0_81:Disconnect()
  A0_81:fireEvent(EVT.FAILED)
end
instance = objectlua.Object:subclass():new()
L0_0 = {}
L0_0.status = {
  response = bit.lshift(1, 0),
  compress = bit.lshift(1, 1),
  forward = bit.lshift(1, 2),
  attach = bit.lshift(1, 3),
  raw = bit.lshift(1, 4),
  error = bit.lshift(1, 16),
  commmand_not_found = bit.lshift(1, 17),
  exception_decode = bit.lshift(1, 18),
  exception_encode = bit.lshift(1, 19),
  exception_parameter = bit.lshift(1, 20),
  exception_processing = bit.lshift(1, 21),
  exception_identity = bit.lshift(1, 22),
  exception_order = bit.lshift(1, 23),
  exception_unknown = bit.lshift(1, 25)
}
function L0_0.checkStatus(A0_83, A1_84, A2_85)
  return bit.band(A1_84, A0_83.status[A2_85]) == A0_83.status[A2_85]
end
