module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
require("SceneHelper")
function prototype.onEnter(A0_0)
  local L1_1
end
function prototype.onBtnSelect(A0_2, A1_3, A2_4)
  if nil == Logic:Get("Login"):GetServerInfoByIdx(A0_2.idxServer) or nil == Logic:Get("Login"):GetServerInfoByIdx(A0_2.idxServer).server then
    return
  end
  Logic:Get("Login"):SetSelectServer(Logic:Get("Login"):GetServerInfoByIdx(A0_2.idxServer).server)
end
function prototype.refresh(A0_5, A1_6)
  A0_5:clear()
  if A1_6 <= Logic:Get("Login"):GetLoggeServerdAmount() then
    if not Logic:Get("Login"):GetLoggedServerByIdx(A1_6).server then
      A0_5.sprBg:setVisible(true)
      A0_5.sprAllServer:setVisible(Logic:Get("Login"):GetLoggedServerByIdx(A1_6).isShowAllServer)
      A0_5.sprLoggedServer:setVisible(not Logic:Get("Login"):GetLoggedServerByIdx(A1_6).isShowAllServer)
      A0_5.idxServer = 0
      return
    end
    A0_5.idxServer = Logic:Get("Login"):GetServerIdxByServer(Logic:Get("Login"):GetLoggedServerByIdx(A1_6).server)
  else
    A0_5.idxServer = A1_6 - Logic:Get("Login"):GetLoggeServerdAmount()
  end
  A0_5.staServerName:setStyle(kCCLabelTTFStyleOutline)
  A0_5.staFBS:setStyle(kCCLabelTTFStyleOutline)
  A0_5.sprLine:setVisible(true)
  A0_5:refreshData()
end
function prototype.refreshData(A0_7)
  local L1_8, L2_9, L3_10, L4_11, L5_12, L6_13, L7_14
  L1_8 = Logic
  L2_9 = L1_8
  L1_8 = L1_8.Get
  L3_10 = "Login"
  L1_8 = L1_8(L2_9, L3_10)
  L2_9 = L1_8
  L1_8 = L1_8.GetServerInfoByIdx
  L3_10 = A0_7.idxServer
  L1_8 = L1_8(L2_9, L3_10)
  L2_9 = Logic
  L3_10 = L2_9
  L2_9 = L2_9.Get
  L4_11 = "Login"
  L2_9 = L2_9(L3_10, L4_11)
  L3_10 = L2_9
  L2_9 = L2_9.GetSelextServer
  L2_9 = L2_9(L3_10)
  if L1_8 then
    L3_10 = L1_8.server
    if nil ~= L3_10 then
      L3_10 = A0_7.staServerName
      L4_11 = L3_10
      L3_10 = L3_10.setString
      L5_12 = L1_8.name
      L5_12 = L5_12 or ""
      L3_10(L4_11, L5_12)
      L3_10 = false
      L4_11 = L1_8.server
      if L4_11 == L2_9 then
        L3_10 = true
      end
      L4_11 = A0_7.imgSelect
      L5_12 = L4_11
      L4_11 = L4_11.setVisible
      L6_13 = L3_10
      L4_11(L5_12, L6_13)
    end
  end
  L3_10 = Logic
  L4_11 = L3_10
  L3_10 = L3_10.Get
  L5_12 = "Account"
  L3_10 = L3_10(L4_11, L5_12)
  L4_11 = L3_10
  L3_10 = L3_10.GetServerFPSById
  L5_12 = L1_8.server
  L3_10 = L3_10(L4_11, L5_12)
  L4_11 = ""
  L5_12 = 0
  L6_13 = false
  if L3_10 then
    L7_14 = tonumber
    L7_14 = L7_14(L3_10)
    if L7_14 then
      L7_14 = tonumber
      L7_14 = L7_14(L3_10)
      L3_10 = L7_14
      if -10 == L3_10 then
        L5_12 = 102207
        L4_11 = "\231\187\180\230\138\164\228\184\173"
        L6_13 = true
      elseif -1 == L3_10 then
        L5_12 = 102218
        L6_13 = true
      elseif L3_10 >= 0 and L3_10 < 10 then
        L5_12 = 102208
      elseif L3_10 >= 10 and L3_10 < 25 then
        L5_12 = 102209
      elseif L3_10 >= 25 then
        L5_12 = 102211
      end
    end
  end
  if L6_13 then
    L7_14 = ccc3
    L7_14 = L7_14(128, 128, 128)
  elseif not L7_14 then
    L7_14 = ccc3
    L7_14 = L7_14(0, 255, 0)
  end
  A0_7.staServerName:setColor(L7_14)
  A0_7.staFBS:setColor(L7_14)
  A0_7.staFBS:setString(L4_11 ~= "" and L4_11 or L5_12 > 0 and TwGetStr(L5_12) or "")
end
function prototype.clear(A0_15)
  A0_15.staFBS:setString("")
  A0_15.staServerName:setString("")
  A0_15.imgSelect:setVisible(false)
  A0_15.sprAllServer:setVisible(false)
  A0_15.sprLoggedServer:setVisible(false)
  A0_15.sprLine:setVisible(false)
  A0_15.sprBg:setVisible(false)
end
