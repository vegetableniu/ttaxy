module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
require("SceneHelper")
function prototype.onEnter(A0_0)
  local L1_1, L2_2, L3_3
  L1_1 = A0_0.nodInput
  L2_2 = L1_1
  L1_1 = L1_1.setPlaceHolder
  L3_3 = ""
  L1_1(L2_2, L3_3)
  L1_1 = A0_0.nodInput
  L2_2 = L1_1
  L1_1 = L1_1.setFontSize
  L3_3 = 24
  L1_1(L2_2, L3_3)
  L1_1 = A0_0.nodInput
  L2_2 = L1_1
  L1_1 = L1_1.setMaxLens
  L3_3 = 12
  L1_1(L2_2, L3_3)
  L1_1 = A0_0.nodInput
  L2_2 = L1_1
  L1_1 = L1_1.setTouchPriority
  L3_3 = -255
  L1_1(L2_2, L3_3)
  L1_1 = Logic
  L2_2 = L1_1
  L1_1 = L1_1.Get
  L3_3 = "Sect"
  L1_1 = L1_1(L2_2, L3_3)
  L2_2 = L1_1
  L1_1 = L1_1.On
  L3_3 = Logic
  L3_3 = L3_3.Sect
  L3_3 = L3_3.EVT
  L3_3 = L3_3.RENAME_SUCCESSED
  L1_1(L2_2, L3_3, A0_0:Event("onRenameSuccessed"))
  L1_1 = Logic
  L2_2 = L1_1
  L1_1 = L1_1.Get
  L3_3 = "Sect"
  L1_1 = L1_1(L2_2, L3_3)
  L2_2 = L1_1
  L1_1 = L1_1.On
  L3_3 = Logic
  L3_3 = L3_3.Sect
  L3_3 = L3_3.EVT
  L3_3 = L3_3.RENAME_ERROR
  L1_1(L2_2, L3_3, A0_0:Event("onError"))
  L1_1 = Logic
  L2_2 = L1_1
  L1_1 = L1_1.Get
  L3_3 = "PlayerInfo"
  L1_1 = L1_1(L2_2, L3_3)
  L2_2 = L1_1
  L1_1 = L1_1.On
  L3_3 = Logic
  L3_3 = L3_3.PlayerInfo
  L3_3 = L3_3.EVT
  L3_3 = L3_3.DATA_CHANGE
  L1_1(L2_2, L3_3, A0_0:Event("onDataChange"))
  L1_1 = {L2_2, L3_3}
  L2_2 = "images/Rename/fntChangPlayerName.png"
  L3_3 = "images/Rename/fntChangeMenpaiName.png"
  L2_2 = {
    L3_3,
    "images/Rename/fntMenpaiNameExist.png"
  }
  L3_3 = "images/Rename/fntPlayerNameExist.png"
  L3_3 = Logic
  L3_3 = L3_3.Get
  L3_3 = L3_3(L3_3, "PlayerInfo")
  L3_3 = L3_3.GetResetNameType
  L3_3 = L3_3(L3_3)
  A0_0.changeType = L3_3
  L3_3 = CCSprite
  L3_3 = L3_3.create
  L3_3 = L3_3(L3_3, L1_1[A0_0.changeType])
  if L3_3 then
    A0_0.sprTitle:setDisplayFrame(L3_3:displayFrame())
  end
  L3_3 = CCSprite:create(L2_2[A0_0.changeType])
  if L3_3 then
    A0_0.sprError:setDisplayFrame(L3_3:displayFrame())
  end
  if A0_0.changeType == Logic.PlayerInfo.CHANGE_NAME.PLAYER_NAME then
    A0_0.ttfDesr:setStyle(kCCLabelTTFStyleOutline)
    A0_0.ttfDesr:setString(TwGetStr(105010))
    return
  end
end
function prototype.onExit(A0_4)
  local L1_5
end
function prototype.onMenuClose(A0_6)
  local L1_7
end
function prototype.onBtnEnter(A0_8)
  if A0_8.changeType == Logic.PlayerInfo.CHANGE_NAME.PLAYER_NAME then
    A0_8:resetPlayerName()
    return
  end
  A0_8:resetMenpaiName()
end
function prototype.resetPlayerName(A0_9)
  local L1_10
  L1_10 = A0_9.nodInput
  L1_10 = L1_10.getString
  L1_10 = L1_10(L1_10)
  if not L1_10 or "" == L1_10 then
    Prompt:Fail(TwGetStr(10054))
    return
  end
  if not Logic:Get("CreateHero"):checkName(L1_10) then
    return
  end
  Logic:Get("PlayerInfo"):PostResetName(L1_10)
end
function prototype.resetMenpaiName(A0_11)
  local L1_12
  L1_12 = A0_11.nodInput
  L1_12 = L1_12.getString
  L1_12 = L1_12(L1_12)
  if not L1_12 or "" == L1_12 then
    Prompt:Fail(TwGetStr(110136))
    return
  end
  if not Logic:Get("Sect"):checkName(L1_12) then
    return
  end
  MsgMenpai:Post("MENPAI_RENAME", {name = L1_12})
end
function prototype.onBtnRandom(A0_13)
  A0_13.nodInput:setString(Logic:Get("CreateHero"):GetRename() or "")
end
function prototype.onDataChange(A0_14)
  SceneHelper:removePrompt(A0_14.rootNode)
  if Logic:Get("Sect"):IsNeedRename() then
    Logic:Get("PlayerInfo"):SetResetNameType(Logic.PlayerInfo.CHANGE_NAME.MENPAI_NAME)
    SceneHelper:pushPrompt("Rename", A0_14.rootNode)
  end
end
function prototype.onRenameSuccessed(A0_15)
  SceneHelper:removePrompt(A0_15.rootNode)
end
function prototype.onError(A0_16)
  A0_16.sprError:setVisible(true)
end
