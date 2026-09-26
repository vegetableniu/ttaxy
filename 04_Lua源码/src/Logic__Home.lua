local L0_0
L0_0 = module
L0_0((...), package.seeall)
L0_0 = Logic
L0_0 = L0_0.class
L0_0 = L0_0.subclass
L0_0 = L0_0(L0_0)
class = L0_0
L0_0 = {}
ITEM_BG_IMG = L0_0
L0_0 = ITEM_BG_IMG
L0_0.btnCard = {
  normal = "images/Main/btnPackNormal.png",
  select = "images/Main/btnPackSelect.png",
  disable = "images/Main/btnPackNormal.png"
}
L0_0 = ITEM_BG_IMG
L0_0.btnSkill = {
  normal = "images/Main/btnSkillNormal.png",
  select = "images/Main/btnSkillSelect.png",
  disable = "images/Main/btnSkillLock.png"
}
L0_0 = ITEM_BG_IMG
L0_0.btnAchievement = {
  normal = "images/Main/btnStrategyNormal.png",
  select = "images/Main/btnStrategySelect.png",
  disable = "images/Main/btnStrategyLock.png"
}
L0_0 = ITEM_BG_IMG
L0_0.btnCompose = {
  normal = "images/Main/btnFragmentNormal.png",
  select = "images/Main/btnFragmentSelect.png",
  disable = "images/Main/btnFragmentNormal.png"
}
L0_0 = ITEM_BG_IMG
L0_0.btnDevil = {
  normal = "images/Main/btnDevilNormal.png",
  select = "images/Main/btnDevilSelect.png",
  disable = "images/Main/btnDevilLock.png"
}
L0_0 = ITEM_BG_IMG
L0_0.btnActivity = {
  normal = "images/Main/btnActivityNormal.png",
  select = "images/Main/btnActivitySelect.png",
  disable = "images/Main/btnActivityLock.png"
}
L0_0 = ITEM_BG_IMG
L0_0.btnReward = {
  normal = "images/Main/btnFriendNormal.png",
  select = "images/Main/btnFriendSelect.png",
  disable = "images/Main/btnFriendNormal.png"
}
L0_0 = ITEM_BG_IMG
L0_0.btnChat = {
  normal = "images/Main/btnChatNormal.png",
  select = "images/Main/btnChatSelect.png",
  disable = "images/Main/btnChatLock.png"
}
L0_0 = ITEM_BG_IMG
L0_0.btnSystem = {
  normal = "images/Main/btnSystemNormal.png",
  select = "images/Main/btnSystemSelect.png",
  disable = "images/Main/btnSystemNormal.png"
}
L0_0 = ITEM_BG_IMG
L0_0.btnPvp = {
  normal = "images/Main/btnPvpNormal.png",
  select = "images/Main/btnPvpSelect.png",
  disable = "images/Main/btnPvpNormal.png"
}
L0_0 = ITEM_BG_IMG
L0_0.btnArtifact = {
  normal = "images/Main/btnArtifactNormal.png",
  select = "images/Main/btnArtifactSelect.png",
  disable = "images/Main/btnArtifactNormal.png"
}
L0_0 = ITEM_BG_IMG
L0_0.btnBang = {
  normal = "images/Main/Bang_nor.png",
  select = "images/Main/Bang_sele.png",
  disable = "images/Main/Bang_dis.png"
}
L0_0 = ITEM_BG_IMG
L0_0.btnTail = {
  normal = "images/Main/btmfabaonom.png",
  select = "images/Main/btmfabaoon.png",
  disable = "images/Main/btmfabaodis.png"
}
L0_0 = ITEM_BG_IMG
L0_0.btnArmor = {
  normal = "images/Main/btnArmorNormal.png",
  select = "images/Main/btnArmorSelect.png",
  disable = "images/Main/btnArmorLock.png"
}
L0_0 = ITEM_BG_IMG
L0_0.btnCultivate = {
  normal = "images/Main/btnCultivateNormal.png",
  select = "images/Main/btnCultivateSelect.png",
  disable = "images/Main/btnCultivateLock.png"
}
L0_0 = ITEM_BG_IMG
L0_0.btnSoaring = {
  normal = "images/Main/btnSoaringNormal.png",
  select = "images/Main/btnSoaringSelect.png",
  disable = "images/Main/btnSoaringLock.png"
}
L0_0 = {
  "btnCard",
  "btnSkill",
  "btnAchievement",
  "btnCompose",
  "btnDevil",
  "btnActivity",
  "btnReward",
  "btnSystem"
}
CCB_BTN = L0_0
L0_0 = {}
L0_0[1] = {
  [1] = {
    "btnCard",
    "btnSkill",
    "btnAchievement",
    "btnBang",
    "btnDevil",
    "btnActivity",
    "btnChat",
    "btnArmor"
  },
  [2] = {
    "btnCompose",
    "btnReward",
    "btnSystem"
  }
}
L0_0[2] = {
  [1] = {
    "btnCard",
    "btnSkill",
    "btnArmor",
    "btnBang",
    "btnDevil",
    "btnActivity",
    "btnChat",
    "btnArtifact"
  },
  [2] = {
    "btnCompose",
    "btnTail",
    "btnAchievement",
    "btnReward",
    "btnSystem"
  }
}
L0_0[3] = {
  [1] = {
    "btnCard",
    "btnSkill",
    "btnArmor",
    "btnBang",
    "btnDevil",
    "btnActivity",
    "btnChat",
    "btnArtifact"
  },
  [2] = {
    "btnAchievement",
    "btnPvp",
    "btnCompose",
    "btnTail",
    "btnReward",
    "btnSoaring",
    "btnCultivate",
    "btnSystem"
  }
}
function class.initialize(A0_1)
  super.initialize(A0_1)
end
function class.GetBtnPos(A0_2, A1_3)
  local L2_4, L3_5, L4_6, L5_7, L6_8, L7_9, L8_10, L9_11, L10_12
  L2_4 = A0_2.GetBtnItem
  L2_4 = L2_4(L3_5)
  for L6_8 = 1, #L2_4 do
    for L10_12 = 1, #L8_10 do
      if L2_4[L6_8][L10_12] == A1_3 then
        return L6_8, L10_12, CCB_BTN[L10_12]
      end
    end
  end
  return L3_5, L4_6
end
function class.GetBtnItem(A0_13)
  return _UPVALUE0_[A0_13:GetLvLView()]
end
function class.GetLvLView(A0_14)
  if Logic:Get("Lock"):checkStatusById("PVP_NEW") == false then
  elseif Logic:Get("Lock"):checkStatusById("BEEEFFGEE") == false then
  else
  end
  return 1
end
function class.GetBtnImg(A0_15, A1_16)
  return ITEM_BG_IMG[A1_16]
end
function class.GetBtnObj(A0_17, A1_18)
  local L2_19, L3_20
  L2_19 = {}
  L3_20 = {}
  L3_20.name = "btnCard"
  L3_20.img = ITEM_BG_IMG.btnCard
  L3_20.func = bind(A0_17.onBtnHero, A0_17)
  L2_19.btnCard = L3_20
  L3_20 = {}
  L3_20.name = "btnSkill"
  L3_20.img = ITEM_BG_IMG.btnSkill
  L3_20.func = bind(A0_17.onBtnSkillCollege, A0_17)
  L2_19.btnSkill = L3_20
  L3_20 = {}
  L3_20.name = "btnAchievement"
  L3_20.img = ITEM_BG_IMG.btnAchievement
  L3_20.func = bind(A0_17.onBtnPic, A0_17)
  L2_19.btnAchievement = L3_20
  L3_20 = {}
  L3_20.name = "btnCompose"
  L3_20.img = ITEM_BG_IMG.btnCompose
  L3_20.func = bind(A0_17.onBtnFragment, A0_17)
  L2_19.btnCompose = L3_20
  L3_20 = {}
  L3_20.name = "btnDevil"
  L3_20.img = ITEM_BG_IMG.btnDevil
  L3_20.func = bind(A0_17.onBtnDevil, A0_17)
  L2_19.btnDevil = L3_20
  L3_20 = {}
  L3_20.name = "btnActivity"
  L3_20.img = ITEM_BG_IMG.btnActivity
  L3_20.func = bind(A0_17.onBtnActivity, A0_17)
  L2_19.btnActivity = L3_20
  L3_20 = {}
  L3_20.name = "btnChat"
  L3_20.img = ITEM_BG_IMG.btnChat
  L3_20.func = bind(A0_17.onBtnChat, A0_17)
  L2_19.btnChat = L3_20
  L3_20 = {}
  L3_20.name = "btnReward"
  L3_20.img = ITEM_BG_IMG.btnReward
  L3_20.func = bind(A0_17.onBtnFriend, A0_17)
  L2_19.btnReward = L3_20
  L3_20 = {}
  L3_20.name = "btnSystem"
  L3_20.img = ITEM_BG_IMG.btnSystem
  L3_20.func = bind(A0_17.onBtnSystem, A0_17)
  L2_19.btnSystem = L3_20
  L3_20 = {}
  L3_20.name = "btnPvp"
  L3_20.img = ITEM_BG_IMG.btnPvp
  L3_20.func = bind(A0_17.onBtnPvp, A0_17)
  L2_19.btnPvp = L3_20
  L3_20 = {}
  L3_20.name = "btnArtifact"
  L3_20.img = ITEM_BG_IMG.btnArtifact
  L3_20.func = bind(A0_17.onBtnArtifact, A0_17)
  L2_19.btnArtifact = L3_20
  L3_20 = {}
  L3_20.name = "btnBang"
  L3_20.img = ITEM_BG_IMG.btnBang
  L3_20.func = bind(A0_17.onbtnBang, A0_17)
  L2_19.btnBang = L3_20
  L3_20 = {}
  L3_20.name = "btnTail"
  L3_20.img = ITEM_BG_IMG.btnTail
  L3_20.func = bind(A0_17.onbtnTail, A0_17)
  L2_19.btnTail = L3_20
  L3_20 = {}
  L3_20.name = "btnArmor"
  L3_20.img = ITEM_BG_IMG.btnArmor
  L3_20.func = bind(A0_17.onBtnArmor, A0_17)
  L2_19.btnArmor = L3_20
  L3_20 = {}
  L3_20.name = "btnCultivate"
  L3_20.img = ITEM_BG_IMG.btnCultivate
  L3_20.func = bind(A0_17.onBtnCultivate, A0_17)
  L2_19.btnCultivate = L3_20
  L3_20 = {}
  L3_20.name = "btnSoaring"
  L3_20.img = ITEM_BG_IMG.btnSoaring
  L3_20.func = bind(A0_17.onBtnSoaring, A0_17)
  L2_19.btnSoaring = L3_20
  L3_20 = L2_19[A1_18]
  return L3_20
end
function class.onBtnHero(A0_21, A1_22, A2_23)
  if A2_23 == CCControlEventTouchUpInside then
    Logic:Get("Main"):CuMengMain("onBtnHero")
    SceneHelper:runWithScene("Hero")
    Logic:Get("PlayerInfo"):FireEvent(Logic.PlayerInfo.EVT.CHECK_MAINBTN_STATE, false)
  end
end
function class.onBtnSkillCollege(A0_24, A1_25, A2_26)
  local L3_27, L4_28, L5_29, L6_30, L7_31
  L3_27 = Logic
  L4_28 = L3_27
  L3_27 = L3_27.Get
  L5_29 = "Main"
  L3_27 = L3_27(L4_28, L5_29)
  L4_28 = L3_27
  L3_27 = L3_27.CuMengMain
  L5_29 = "onBtnSkillCollege"
  L3_27(L4_28, L5_29)
  L3_27 = Logic
  L4_28 = L3_27
  L3_27 = L3_27.Get
  L5_29 = "Lock"
  L3_27 = L3_27(L4_28, L5_29)
  L4_28 = L3_27
  L3_27 = L3_27.GetStatusByLockId
  L5_29 = Logic
  L5_29 = L5_29.Lock
  L5_29 = L5_29.LOCK_ID
  L5_29 = L5_29.SKILL
  L3_27 = L3_27(L4_28, L5_29)
  A0_24.skillStatus = L3_27
  L3_27 = A0_24.skillStatus
  if L3_27 then
    L3_27 = CCControlEventTouchDown
    if A2_26 == L3_27 then
      L3_27 = Logic
      L4_28 = L3_27
      L3_27 = L3_27.Get
      L5_29 = "Lock"
      L3_27 = L3_27(L4_28, L5_29)
      L4_28 = L3_27
      L3_27 = L3_27.GetOpenLevelAndBattle
      L5_29 = Logic
      L5_29 = L5_29.Lock
      L5_29 = L5_29.LOCK_ID
      L5_29 = L5_29.SKILL
      L4_28 = L3_27(L4_28, L5_29)
      L6_30 = A0_24
      L5_29 = A0_24.showLockTip
      L7_31 = L3_27
      L5_29(L6_30, L7_31, L4_28)
    end
    L4_28 = A0_24
    L3_27 = A0_24.closeLockTip
    L5_29 = A2_26
    L3_27(L4_28, L5_29)
    return
  end
  L3_27 = CCControlEventTouchUpInside
  if A2_26 == L3_27 then
    L3_27 = SceneHelper
    L4_28 = L3_27
    L3_27 = L3_27.runWithScene
    L5_29 = "Treasure"
    L3_27(L4_28, L5_29)
    L3_27 = Logic
    L4_28 = L3_27
    L3_27 = L3_27.Get
    L5_29 = "Guide"
    L3_27 = L3_27(L4_28, L5_29)
    L4_28 = L3_27
    L3_27 = L3_27.done
    L5_29 = "Treasure"
    L6_30 = "Start"
    L3_27(L4_28, L5_29, L6_30)
    L3_27 = Logic
    L4_28 = L3_27
    L3_27 = L3_27.Get
    L5_29 = "PlayerInfo"
    L3_27 = L3_27(L4_28, L5_29)
    L4_28 = L3_27
    L3_27 = L3_27.FireEvent
    L5_29 = Logic
    L5_29 = L5_29.PlayerInfo
    L5_29 = L5_29.EVT
    L5_29 = L5_29.CHECK_MAINBTN_STATE
    L6_30 = false
    L3_27(L4_28, L5_29, L6_30)
  end
end
function class.onBtnPic(A0_32, A1_33, A2_34)
  local L3_35, L4_36, L5_37, L6_38, L7_39
  L3_35 = Logic
  L4_36 = L3_35
  L3_35 = L3_35.Get
  L5_37 = "Main"
  L3_35 = L3_35(L4_36, L5_37)
  L4_36 = L3_35
  L3_35 = L3_35.CuMengMain
  L5_37 = "onBtnPic"
  L3_35(L4_36, L5_37)
  L3_35 = Logic
  L4_36 = L3_35
  L3_35 = L3_35.Get
  L5_37 = "Lock"
  L3_35 = L3_35(L4_36, L5_37)
  L4_36 = L3_35
  L3_35 = L3_35.GetStatusByLockId
  L5_37 = Logic
  L5_37 = L5_37.Lock
  L5_37 = L5_37.LOCK_ID
  L5_37 = L5_37.ACHIEVEMENT
  L3_35 = L3_35(L4_36, L5_37)
  A0_32.achStatus = L3_35
  L3_35 = A0_32.achStatus
  if L3_35 then
    L3_35 = CCControlEventTouchDown
    if A2_34 == L3_35 then
      L3_35 = Logic
      L4_36 = L3_35
      L3_35 = L3_35.Get
      L5_37 = "Lock"
      L3_35 = L3_35(L4_36, L5_37)
      L4_36 = L3_35
      L3_35 = L3_35.GetOpenLevelAndBattle
      L5_37 = Logic
      L5_37 = L5_37.Lock
      L5_37 = L5_37.LOCK_ID
      L5_37 = L5_37.ACHIEVEMENT
      L4_36 = L3_35(L4_36, L5_37)
      L6_38 = A0_32
      L5_37 = A0_32.showLockTip
      L7_39 = L3_35
      L5_37(L6_38, L7_39, L4_36)
    end
    L4_36 = A0_32
    L3_35 = A0_32.closeLockTip
    L5_37 = A2_34
    L3_35(L4_36, L5_37)
    return
  end
  L3_35 = CCControlEventTouchUpInside
  if A2_34 == L3_35 then
    L3_35 = SceneHelper
    L4_36 = L3_35
    L3_35 = L3_35.runWithScene
    L5_37 = "Achievement"
    L6_38 = A0_32.rootNode
    L3_35(L4_36, L5_37, L6_38)
    L3_35 = Logic
    L4_36 = L3_35
    L3_35 = L3_35.Get
    L5_37 = "Guide"
    L3_35 = L3_35(L4_36, L5_37)
    L4_36 = L3_35
    L3_35 = L3_35.done
    L5_37 = "Achievement"
    L6_38 = "Start"
    L3_35(L4_36, L5_37, L6_38)
    L3_35 = Logic
    L4_36 = L3_35
    L3_35 = L3_35.Get
    L5_37 = "PlayerInfo"
    L3_35 = L3_35(L4_36, L5_37)
    L4_36 = L3_35
    L3_35 = L3_35.FireEvent
    L5_37 = Logic
    L5_37 = L5_37.PlayerInfo
    L5_37 = L5_37.EVT
    L5_37 = L5_37.CHECK_MAINBTN_STATE
    L6_38 = false
    L3_35(L4_36, L5_37, L6_38)
  end
end
function class.onBtnFragment(A0_40, A1_41, A2_42)
  if A2_42 == CCControlEventTouchUpInside then
    Logic:Get("Main"):CuMengMain("onBtnFragment")
    SceneHelper:runWithScene("Compose")
    Logic:Get("PlayerInfo"):FireEvent(Logic.PlayerInfo.EVT.CHECK_MAINBTN_STATE, false)
  end
end
function class.onBtnActivity(A0_43, A1_44, A2_45)
  local L3_46, L4_47, L5_48, L6_49, L7_50
  L3_46 = Logic
  L4_47 = L3_46
  L3_46 = L3_46.Get
  L5_48 = "Main"
  L3_46 = L3_46(L4_47, L5_48)
  L4_47 = L3_46
  L3_46 = L3_46.CuMengMain
  L5_48 = "onBtnActivity"
  L3_46(L4_47, L5_48)
  L3_46 = Logic
  L4_47 = L3_46
  L3_46 = L3_46.Get
  L5_48 = "Lock"
  L3_46 = L3_46(L4_47, L5_48)
  L4_47 = L3_46
  L3_46 = L3_46.GetStatusByLockId
  L5_48 = Logic
  L5_48 = L5_48.Lock
  L5_48 = L5_48.LOCK_ID
  L5_48 = L5_48.ACTIVITY
  L3_46 = L3_46(L4_47, L5_48)
  A0_43.activityStatus = L3_46
  L3_46 = A0_43.activityStatus
  if L3_46 then
    L3_46 = CCControlEventTouchDown
    if A2_45 == L3_46 then
      L3_46 = Logic
      L4_47 = L3_46
      L3_46 = L3_46.Get
      L5_48 = "Lock"
      L3_46 = L3_46(L4_47, L5_48)
      L4_47 = L3_46
      L3_46 = L3_46.GetOpenLevelAndBattle
      L5_48 = Logic
      L5_48 = L5_48.Lock
      L5_48 = L5_48.LOCK_ID
      L5_48 = L5_48.ACTIVITY
      L4_47 = L3_46(L4_47, L5_48)
      L6_49 = A0_43
      L5_48 = A0_43.showLockTip
      L7_50 = L3_46
      L5_48(L6_49, L7_50, L4_47)
    end
    L4_47 = A0_43
    L3_46 = A0_43.closeLockTip
    L5_48 = A2_45
    L3_46(L4_47, L5_48)
    return
  end
  L3_46 = CCControlEventTouchUpInside
  if A2_45 == L3_46 then
    L3_46 = Logic
    L4_47 = L3_46
    L3_46 = L3_46.Get
    L5_48 = "Activity"
    L3_46 = L3_46(L4_47, L5_48)
    L4_47 = L3_46
    L3_46 = L3_46.PostActivesMsg
    L3_46(L4_47)
    L3_46 = Logic
    L4_47 = L3_46
    L3_46 = L3_46.Get
    L5_48 = "Guide"
    L3_46 = L3_46(L4_47, L5_48)
    L4_47 = L3_46
    L3_46 = L3_46.done
    L5_48 = "Activity"
    L6_49 = "Start"
    L3_46(L4_47, L5_48, L6_49)
    L3_46 = Logic
    L4_47 = L3_46
    L3_46 = L3_46.Get
    L5_48 = "PlayerInfo"
    L3_46 = L3_46(L4_47, L5_48)
    L4_47 = L3_46
    L3_46 = L3_46.FireEvent
    L5_48 = Logic
    L5_48 = L5_48.PlayerInfo
    L5_48 = L5_48.EVT
    L5_48 = L5_48.CHECK_MAINBTN_STATE
    L6_49 = false
    L3_46(L4_47, L5_48, L6_49)
  end
end
function class.onBtnChat(A0_51, A1_52, A2_53)
  if A0_51:showBtnTip("WORLD_CHAT", A2_53) then
    return
  end
  if A2_53 == CCControlEventTouchUpInside then
    SceneHelper:runWithScene("WorldChat", A0_51.rootNode)
    Logic:Get("PlayerInfo"):FireEvent(Logic.PlayerInfo.EVT.CHECK_MAINBTN_STATE, false)
  end
end
function class.onBtnFriend(A0_54, A1_55, A2_56)
  if A2_56 == CCControlEventTouchUpInside then
    Logic:Get("Main"):CuMengMain("onBtnFriend")
    SceneHelper:runWithScene("Friend")
    Logic:Get("PlayerInfo"):FireEvent(Logic.PlayerInfo.EVT.CHECK_MAINBTN_STATE, false)
  end
end
function class.onBtnDevil(A0_57, A1_58, A2_59)
  local L3_60, L4_61, L5_62, L6_63, L7_64
  L3_60 = Logic
  L4_61 = L3_60
  L3_60 = L3_60.Get
  L5_62 = "Lock"
  L3_60 = L3_60(L4_61, L5_62)
  L4_61 = L3_60
  L3_60 = L3_60.GetStatusByLockId
  L5_62 = Logic
  L5_62 = L5_62.Lock
  L5_62 = L5_62.LOCK_ID
  L5_62 = L5_62.DEMOG
  L3_60 = L3_60(L4_61, L5_62)
  A0_57.devilStatus = L3_60
  L3_60 = A0_57.devilStatus
  if L3_60 then
    L3_60 = CCControlEventTouchDown
    if A2_59 == L3_60 then
      L3_60 = Logic
      L4_61 = L3_60
      L3_60 = L3_60.Get
      L5_62 = "Lock"
      L3_60 = L3_60(L4_61, L5_62)
      L4_61 = L3_60
      L3_60 = L3_60.GetOpenLevelAndBattle
      L5_62 = Logic
      L5_62 = L5_62.Lock
      L5_62 = L5_62.LOCK_ID
      L5_62 = L5_62.DEMOG
      L4_61 = L3_60(L4_61, L5_62)
      L6_63 = A0_57
      L5_62 = A0_57.showLockTip
      L7_64 = L3_60
      L5_62(L6_63, L7_64, L4_61)
      L5_62 = Logic
      L6_63 = L5_62
      L5_62 = L5_62.Get
      L7_64 = "Main"
      L5_62 = L5_62(L6_63, L7_64)
      L6_63 = L5_62
      L5_62 = L5_62.CuMengMain
      L7_64 = "OnPushMainInfo"
      L5_62(L6_63, L7_64)
    end
    L4_61 = A0_57
    L3_60 = A0_57.closeLockTip
    L5_62 = A2_59
    L3_60(L4_61, L5_62)
    return
  end
  L3_60 = CCControlEventTouchUpInside
  if A2_59 == L3_60 then
    L3_60 = Logic
    L4_61 = L3_60
    L3_60 = L3_60.Get
    L5_62 = "Main"
    L3_60 = L3_60(L4_61, L5_62)
    L4_61 = L3_60
    L3_60 = L3_60.CuMengMain
    L5_62 = "OnPushMainInfo"
    L3_60(L4_61, L5_62)
    L3_60 = MsgDemog
    L4_61 = L3_60
    L3_60 = L3_60.Post
    L5_62 = "ACTIVE_INFO"
    L3_60(L4_61, L5_62)
  end
end
function class.onBtnSystem(A0_65, A1_66, A2_67)
  if A2_67 == CCControlEventTouchUpInside then
    SceneHelper:runWithScene("Strage")
  end
end
function class.onBtnPvp(A0_68, A1_69, A2_70)
  if A2_70 == CCControlEventTouchUpInside then
    SceneHelper:runWithScene("PvpMain")
  end
end
function class.onBtnArtifact(A0_71, A1_72, A2_73)
  if A2_73 == CCControlEventTouchUpInside then
    SceneHelper:runWithScene("Artifact", A0_71.rootNode)
  end
end
function class.onbtnBang(A0_74, A1_75, A2_76)
  local L3_77, L4_78, L5_79, L6_80, L7_81, L8_82
  L3_77 = Logic
  L4_78 = L3_77
  L3_77 = L3_77.Get
  L5_79 = "Lock"
  L3_77 = L3_77(L4_78, L5_79)
  L4_78 = L3_77
  L3_77 = L3_77.checkStatusById
  L5_79 = "MENPAI"
  L3_77 = L3_77(L4_78, L5_79)
  if L3_77 then
    L4_78 = CCControlEventTouchDown
    if A2_76 == L4_78 then
      L4_78 = Logic
      L5_79 = L4_78
      L4_78 = L4_78.Get
      L6_80 = "Lock"
      L4_78 = L4_78(L5_79, L6_80)
      L5_79 = L4_78
      L4_78 = L4_78.GetLevelAndBattleNames
      L6_80 = "MENPAI"
      L5_79 = L4_78(L5_79, L6_80)
      L7_81 = A0_74
      L6_80 = A0_74.showLockTip
      L8_82 = L4_78
      L6_80(L7_81, L8_82, L5_79)
    end
    L5_79 = A0_74
    L4_78 = A0_74.closeLockTip
    L6_80 = A2_76
    L4_78(L5_79, L6_80)
    return
  end
  L4_78 = CCControlEventTouchUpInside
  if A2_76 == L4_78 then
    L4_78 = Logic
    L5_79 = L4_78
    L4_78 = L4_78.Get
    L6_80 = "Sect"
    L4_78 = L4_78(L5_79, L6_80)
    L5_79 = L4_78
    L4_78 = L4_78.setIsFromHome
    L6_80 = true
    L4_78(L5_79, L6_80)
    L4_78 = Logic
    L5_79 = L4_78
    L4_78 = L4_78.Get
    L6_80 = "Sect"
    L4_78 = L4_78(L5_79, L6_80)
    L5_79 = L4_78
    L4_78 = L4_78.PostGetSelefMenpai
    L4_78(L5_79)
  end
end
function class.showBtnTip(A0_83, A1_84, A2_85)
  local L3_86, L4_87, L5_88, L6_89, L7_90, L8_91
  L3_86 = Logic
  L4_87 = L3_86
  L3_86 = L3_86.Get
  L5_88 = "Lock"
  L3_86 = L3_86(L4_87, L5_88)
  L4_87 = L3_86
  L3_86 = L3_86.checkStatusById
  L5_88 = A1_84
  L3_86 = L3_86(L4_87, L5_88)
  if L3_86 then
    L4_87 = CCControlEventTouchDown
    if A2_85 == L4_87 then
      L4_87 = Logic
      L5_88 = L4_87
      L4_87 = L4_87.Get
      L6_89 = "Lock"
      L4_87 = L4_87(L5_88, L6_89)
      L5_88 = L4_87
      L4_87 = L4_87.GetLevelAndBattleNames
      L6_89 = A1_84
      L5_88 = L4_87(L5_88, L6_89)
      L7_90 = A0_83
      L6_89 = A0_83.showLockTip
      L8_91 = L4_87
      L6_89(L7_90, L8_91, L5_88)
    end
    L5_88 = A0_83
    L4_87 = A0_83.closeLockTip
    L6_89 = A2_85
    L4_87(L5_88, L6_89)
  end
  return L3_86
end
function class.showLockTip(A0_92, A1_93, A2_94)
  local L3_95
  if nil ~= A2_94 and "" ~= A2_94 then
    L3_95 = TwGetStr
    L3_95 = L3_95(105403, A1_93)
    L3_95 = L3_95 .. "\n" .. TwGetStr(105401, A2_94)
    Prompt:PopTip(L3_95)
  else
    L3_95 = Prompt
    L3_95 = L3_95.PopTip
    L3_95(L3_95, TwGetStr(105402, A1_93))
  end
end
function class.closeLockTip(A0_96, A1_97)
  if A1_97 == CCControlEventTouchUpOutside or A1_97 == CCControlEventTouchUpInside or A1_97 == CCControlEventTouchCancel then
    Logic:Get("SureConfirm"):FireEvent(Logic.SureConfirm.EVT.CLOSE_POPTIP)
  end
end
function class.onbtnTail(A0_98, A1_99, A2_100)
  if A0_98:showBtnTip("TALISMAN", A2_100) then
    return
  end
  if A2_100 == CCControlEventTouchUpInside then
    Logic:Get("Guide"):done("Talisman", "Start")
    SceneHelper:runWithScene("FabaoHome")
  end
end
function class.onBtnArmor(A0_101, A1_102, A2_103)
  if A0_101:showBtnTip("EQUIP", A2_103) then
    return
  end
  if A2_103 == CCControlEventTouchUpInside then
    Logic:Get("Armor"):setChooseHeroId(nil)
    Logic:Get("Guide"):done("EquipEquip", "Start")
    SceneHelper:runWithScene("ArmorMain")
  end
end
function class.onBtnCultivate(A0_104, A1_105, A2_106)
  if A0_104:showBtnTip("CULTIVATE", A2_106) then
    return
  end
  if A2_106 == CCControlEventTouchUpInside then
    SceneHelper:pushScene("CultivateCampaign")
  end
end
function class.onBtnSoaring(A0_107, A1_108, A2_109)
  if A0_107:showBtnTip("HERO_COST_RANK_UP", A2_109) then
    return
  end
  if A2_109 == CCControlEventTouchUpInside then
    SceneHelper:runWithScene("Soaring", A0_107.rootNode)
  end
end
