require("Logic")
require("utf8")
module((...), package.seeall)
class = Logic.class:subclass()
EVT = Enum({"LIST_OK", "SEND_OK"})
WORD_LIMIT = 72
COOLDOWN = 10
POLL_MS = 3000
function class.initialize(A0_0)
  super.initialize(A0_0)
  A0_0.lastSendAt = 0
  MsgWorldchat:On("GET_LIST", A0_0:Event("OnList"), false)
  MsgWorldchat:On("SEND", A0_0:Event("OnSend"), false)
end
function class.PostList(A0_1, A1_2)
  MsgWorldchat:Post("GET_LIST", {
    afterId = A1_2 or 0
  })
end
function class.PostSend(A0_3, A1_4)
  if A1_4 == nil then
    return false
  end
  MsgWorldchat:Post("SEND", {content = A1_4})
  return true
end
function class.OnList(A0_5, A1_6, A2_7)
  A0_5:FireEvent(EVT.LIST_OK, A1_6, A2_7)
end
function class.OnSend(A0_8, A1_9, A2_10)
  if A1_9 == 0 then
    A0_8.lastSendAt = Logic:Get("System"):GetTime()
  end
  A0_8:FireEvent(EVT.SEND_OK, A1_9, A2_10)
end
function class.CooldownLeft(A0_11)
  if A0_11.lastSendAt + COOLDOWN - Logic:Get("System"):GetTime() < 0 then
    return 0
  end
  return A0_11.lastSendAt + COOLDOWN - Logic:Get("System"):GetTime()
end
function class.MaskContent(A0_12, A1_13)
  return Logic:Get("Sect"):checkString(A1_13)
end
