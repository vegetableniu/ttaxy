local L0_0
L0_0 = module
L0_0((...), package.seeall)
L0_0 = {}
L0_0.SPEED1 = 1.6
L0_0.SPEED2 = 6
L0_0.SPEED3 = 12
ACC_SPEED = L0_0
L0_0 = "battleAcc"
VAR_NAME = L0_0
function L0_0()
  if Logic:Get("System"):GetMisc(VAR_NAME) ~= nil then
    ACC_SPEED.SPEED1 = Logic:Get("System"):GetMisc(VAR_NAME).speed1 or ACC_SPEED.SPEED1
  end
end
L0_0()
FRAME_SEC = 0.03333333333333333
IMG_PATH = "images/BattleShow/"
EFF_PATH = "data/BattleShow/"
ANI_TIMEOUT = 10000
LAYER_LEVEL = {
  BKG = -1,
  HERO = 1,
  BUFF = 2,
  EFF = 3,
  FORE = 4
}
FONT = {
  CRIT = "particles/fonts/crit.fnt",
  HEAL = "particles/fonts/heal.fnt",
  HURT = "particles/fonts/hurt.fnt"
}
FONT_SIZE = {H = 100, W = 30}
RANK_COLOR = {
  [1] = {
    255,
    255,
    255
  },
  [2] = {
    0,
    255,
    0
  },
  [3] = {
    102,
    204,
    255
  },
  [4] = {
    206,
    36,
    242
  },
  [5] = {
    255,
    255,
    0
  },
  [6] = {
    255,
    139,
    0
  },
  [7] = {
    255,
    0,
    0
  }
}
EFFECT_TAG_BG = {CASCADEOPACITY = 100, PARTICAL_ALIVE = 400}
Role = Enum({
  "MAJOR",
  "MINOR",
  "BOSS"
})
REPROT_VALUE = Enum({
  [0] = "SHIELD",
  [1] = "HP"
})
REPROT_BUFF = Enum({
  [0] = "REMOVE",
  [1] = "ADD",
  [2] = "ACTIVE",
  [3] = "IMMUNE"
})
STATUS = Enum({
  "DEAD",
  "LIVE",
  "REBORN"
})
OUTPUT_IMG = {
  CRIT = "data/output/crit.png",
  DODGE = "data/output/dodge.png",
  RESTRAIN = "data/output/restrain.png",
  LAST = "data/output/ALL_ATTACK.png"
}
DROP_IMG = {
  CARD = IMG_PATH .. "card",
  EQUIP = IMG_PATH .. "equip",
  FRAME = IMG_PATH .. "frame"
}
IMG_SRC = {
  DEAD = "hero_dead.png",
  MULTIPLY = "images/Effect/UIMS/x.png"
}
BATTLE_ROUND = {
  [1] = "images/Effect/UIzdks/UIzdks4.png",
  [2] = "images/Effect/UIzdks/UIzdks5.png",
  [3] = "images/Effect/UIzdks/UIzdks3.png"
}
ACC_IMG = {
  [ACC_SPEED.SPEED1] = IMG_PATH .. "x1.png",
  [ACC_SPEED.SPEED2] = IMG_PATH .. "x2.png",
  [ACC_SPEED.SPEED3] = IMG_PATH .. "x3.png"
}
DEFAULT_BG = "data/bg/11_2.png"
DEFAULT_BOSS_BG = "data/bg/11_3.png"
DEFAULT_INIT_BG = "data/bg/11_1.png"
ANI = {
  BATTLE_WIN = "UI/uizdsl",
  BATTLE_LOSE = "UI/uizdsb",
  BATTLE_AGAIN = "UI/uizdsl02",
  BATTLE_ROUND = "UI/UIzdks",
  BATTLE_BOSS = "UI/UIBOSScm",
  MEM_DEAD = "Animation/BattleMemDeadAni",
  ENEMY_DEAD = "Actuation/die",
  ENEMY_CARD = "UI/uidl",
  ENEMY_EQUIP = "UI/uidl",
  ENEMY_FRAME = "UI/uidl",
  ENEMY_SOUL = "UI/uidl",
  ENEMY_COIN = "UI/uiyb",
  MEM_REBORN = "Hit/revive",
  EM_SHINE = "Animation/EmAni",
  MEM_MOVE = "Actuation/Move",
  COMB_UP = "UI/UIZH01",
  COMB_TIP = "UI/UIZH02",
  COMB_ACT = "UI/UIZH03",
  HIGHLIGHT = "Animation/uixl",
  MOVE_ANI = "UI/UIqjz",
  TIP_BLINK = "UI/UIMS01X",
  TIP_FIRE = "UI/UIMS02X",
  CLOUD_DEMOG = "UI/UIZH02",
  FRIEND_TIP = "UI/UIFriTip",
  BIG_HARM = "Hit/hit01"
}
COMB_PATH = "data/output/"
CARD_SZ = {width = 178, height = 165}
BOSS_POS = {SCALE = 1.3}
DEMOG_SHOW_EFFECT = {
  ALL_ATTACK = "ALL_ATTACK",
  DEVIL_RESTRAIN = "DEVIL_RESTRAIN"
}
TIP_SHWO_EFFECT = {RELIEF = "RELIEF"}
MOVE_BTN_IMG1 = IMG_PATH .. "battle_next.png"
MOVE_BTN_IMG2 = IMG_PATH .. "battle_next2.png"
DOWNLOAD_PRO_BG = "images/public/progress_blood_bg.png"
DOWNLOAD_PRO_FRONT = "images/public/progress_ft2.png"
TRANSITION_BG = "images/public/progress_blood_bg2.png"
SHILED_PRO_BG = "images/public/progress_blood_bg.png"
SHILED_PRO_FRONT = "images/public/progress_ft.png"
SHILED_TRANSITION_BG = "images/public/progress_blood_bg2.png"
TOL_ROUDNS = 20
TOL_BTL = 3
HERO_TAG = 10
HERO_NAME_TAG = 11
HIGHLIGHT_TAG = 12
NODE_TIPS_TAG = 13
BUFF_TAG = 14
function GetConfig(A0_1)
  local L1_2
  L1_2 = 0
  if KFDBGetRecord("BattleShowConfig", A0_1) then
    if string.match(KFDBGetRecord("BattleShowConfig", A0_1).content, "^%[.-%]$") then
      L1_2 = math.random(json.decode(KFDBGetRecord("BattleShowConfig", A0_1).content)[1], json.decode(KFDBGetRecord("BattleShowConfig", A0_1).content)[2])
    else
      L1_2 = tonumber(KFDBGetRecord("BattleShowConfig", A0_1).content)
    end
  end
  return L1_2
end
function MakeID(A0_3)
  A0_3 = tonumber(A0_3)
  assert(A0_3 ~= nil)
  A0_3 = A0_3 - 1
  if A0_3 < 6 then
    return "A" .. A0_3
  end
  return "D" .. A0_3
end
function SetCardScale(A0_4, A1_5)
  local L2_6, L3_7
  A1_5 = A1_5 or CARD_SZ
  L3_7 = A0_4
  L2_6 = A0_4.getContentSize
  L2_6 = L2_6(L3_7)
  L3_7 = A1_5.height
  L3_7 = L3_7 / L2_6.height
  A0_4:setScale(L3_7)
end
CStatus = objectlua.Object:subclass()
function CStatus.initialize(A0_8, A1_9)
  super.initialize(A0_8)
  A0_8.status = A1_9
end
CStatus.SKILL_STATUS = Enum({
  [0] = "NORMAL",
  [1] = "DODGE",
  [2] = "CRIT",
  [4] = "WRECK",
  [8] = "FAIL",
  [16] = "RESTRAIN",
  [32] = "LAST",
  [64] = "BIG"
})
function CStatus.IsStatus(A0_10, A1_11)
  if A0_10:IsNil() then
    return false
  end
  return A0_10:GetType(A1_11) == bit.band(A0_10.status, A0_10:GetType(A1_11))
end
function CStatus.RemoveStatus(A0_12, A1_13)
  if A0_12:IsNil() then
    return false
  end
  return CStatus:new(bit.band(A0_12.status, bit.bnot(A0_12:GetType(A1_13))))
end
function CStatus.IsNil(A0_14)
  return A0_14.status == nil
end
function CStatus.GetType(A0_15, A1_16)
  A1_16 = A0_15.SKILL_STATUS[A1_16]
  assert(A1_16 ~= nil, "Error Status Type Name!")
  return A1_16
end
function CStatus.Set(A0_17, A1_18)
  A0_17.status = A0_17:GetType(A1_18)
end
function ForeachChildByTag(A0_19, A1_20, A2_21, A3_22)
  local L4_23, L5_24
  L4_23 = assert
  L5_24 = type
  L5_24 = L5_24(A3_22)
  L5_24 = L5_24 == "function"
  L4_23(L5_24)
  L4_23 = A1_20
  while true do
    L5_24 = A0_19.getChildByTag
    L5_24 = L5_24(A0_19, L4_23)
    if nil == L5_24 then
      break
    end
    L4_23 = L4_23 + 1
    if tolua.type(L5_24) == A2_21 then
      L5_24 = tolua.cast(L5_24, A2_21)
    end
    A3_22(L5_24, A2_21, A0_19, L4_23)
  end
end
