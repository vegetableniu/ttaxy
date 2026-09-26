local L0_0
L0_0 = module
L0_0((...), package.seeall)
L0_0 = require
L0_0("SceneHelper")
L0_0 = "images/public/clarity05.png"
prototype = Tw.Controller.prototype:extend()
function prototype.initialize(A0_1)
  super.initialize(A0_1)
end
function prototype.onEnter(A0_2)
  super.onEnter(A0_2)
end
function prototype.onBtnImage(A0_3)
  if A0_3.fabao then
    Logic:Get("HeroCardInfo"):OpenTailsman(A0_3.fabao)
  end
end
function prototype.onBtnSelect(A0_4)
  if Logic:Get("Guide"):isActive("TalismanEquip", "SelectFabao") then
    A0_4.btnFabao:setEnabled(true)
    Logic:Get("Guide"):done("TalismanEquip", "SelectFabao")
  end
  if A0_4.fabao.equipHero and A0_4.fabao.equipHero ~= Logic:Get("Talisman"):GetSelectHero().id then
    Prompt:Confirm(A0_4, "", 108851, A0_4.post, Prompt.PROMPT_TYPE.SELECT)
    return
  end
  A0_4:post()
end
function prototype.post(A0_5)
  local L1_6, L2_7, L3_8
  L1_6 = Logic
  L2_7 = L1_6
  L1_6 = L1_6.Get
  L3_8 = "Talisman"
  L1_6 = L1_6(L2_7, L3_8)
  L2_7 = L1_6
  L1_6 = L1_6.GetSelectHero
  L1_6 = L1_6(L2_7)
  L2_7 = {}
  L3_8 = A0_5.fabao
  L3_8 = L3_8.id
  if A0_5.fabao.equipHero ~= L1_6.id then
    table.insert(L2_7, L3_8)
  end
  for _FORV_9_, _FORV_10_ in pairs(Logic:Get("Talisman"):GetHeroEquipTailsmanByHeroId(L1_6.id) or {}) do
    if _FORV_10_.id ~= A0_5.fabao.id and KFDBGetRecord("TalismanSetting", _FORV_10_.baseId).position ~= KFDBGetRecord("TalismanSetting", A0_5.fabao.baseId).position then
      table.insert(L2_7, _FORV_10_.id)
    end
  end
  MsgTalisman:Post("REPLACE_HERO_TALISMANS", {
    heroId = L1_6.id,
    talismanIds = L2_7
  })
  Logic:Get("Talisman"):FireEvent(Logic.Talisman.EVT.CONFIG_SELE_TREASURE_BTN)
end
function prototype.createImg(A0_9, A1_10)
  local L2_11, L3_12, L4_13, L5_14
  L2_11 = Logic
  L3_12 = L2_11
  L2_11 = L2_11.Get
  L4_13 = "Gift"
  L2_11 = L2_11(L3_12, L4_13)
  L3_12 = L2_11
  L2_11 = L2_11.createImg
  L4_13 = A1_10
  L2_11 = L2_11(L3_12, L4_13)
  if L2_11 ~= nil then
    L3_12 = A0_9.iconBg
    L4_13 = L3_12
    L3_12 = L3_12.setDisplayFrame
    L5_14 = L2_11.displayFrame
    L5_14 = L5_14(L2_11)
    L3_12(L4_13, L5_14, L5_14(L2_11))
    L3_12 = Logic
    L4_13 = L3_12
    L3_12 = L3_12.Get
    L5_14 = "Gift"
    L3_12 = L3_12(L4_13, L5_14)
    L4_13 = L3_12
    L3_12 = L3_12.createGoodsImg
    L5_14 = A1_10
    L3_12 = L3_12(L4_13, L5_14)
    if L3_12 ~= nil then
      L4_13 = Logic
      L5_14 = L4_13
      L4_13 = L4_13.Get
      L4_13 = L4_13(L5_14, "HeroCardInfo")
      L5_14 = L4_13
      L4_13 = L4_13.GetCardTexture
      L5_14 = L4_13(L5_14, L3_12)
      A0_9.iconImage:setTexture(L4_13)
      A0_9.iconImage:setTextureRect(L5_14)
    end
  end
  L3_12 = Logic
  L4_13 = L3_12
  L3_12 = L3_12.Get
  L5_14 = "HeroCardInfo"
  L3_12 = L3_12(L4_13, L5_14)
  L4_13 = L3_12
  L3_12 = L3_12.AddShanCardSmall
  L5_14 = A0_9.iconBg
  L3_12(L4_13, L5_14, A0_9.data.showId)
end
function prototype.clear(A0_15)
  A0_15.choice = false
  A0_15.btnSelect:setEnabled(true)
  A0_15.staName:setString("")
  A0_15.staStatus:setString("")
  A0_15.staTip:setString("")
  A0_15.imgCanSelect:setDisplayFrame(CCSprite:create("images/public/selcet1.png"):displayFrame())
  A0_15.staStr:setString("")
  if CCSprite:create(_UPVALUE0_) then
    A0_15.imgFabao:setDisplayFrame(CCSprite:create(_UPVALUE0_):displayFrame())
    A0_15.imgkuang1:setDisplayFrame(CCSprite:create(_UPVALUE0_):displayFrame())
  end
end
function prototype.ReFrashInfo(A0_16, A1_17)
  local L2_18, L3_19, L4_20, L5_21, L6_22, L7_23, L8_24, L9_25, L10_26, L11_27
  L3_19 = A0_16
  L2_18 = A0_16.clear
  L2_18(L3_19)
  if A1_17 ~= nil then
    L2_18 = table
    L2_18 = L2_18.empty
    L3_19 = A1_17
    L2_18 = L2_18(L3_19)
  elseif L2_18 then
    return
  end
  L2_18 = KFDBGetRecord
  L3_19 = "TalismanSetting"
  L4_20 = A1_17.baseId
  L2_18 = L2_18(L3_19, L4_20)
  if L2_18 == nil then
    return
  end
  L3_19 = A0_16.btnSelect
  L4_20 = L3_19
  L3_19 = L3_19.setEnabled
  L5_21 = true
  L3_19(L4_20, L5_21)
  A0_16.fabao = A1_17
  L3_19 = Logic
  L4_20 = L3_19
  L3_19 = L3_19.Get
  L5_21 = "Hero"
  L3_19 = L3_19(L4_20, L5_21)
  L4_20 = L3_19
  L3_19 = L3_19.GetHeroInfoByBaseId
  L5_21 = L2_18.baseId
  L3_19 = L3_19(L4_20, L5_21)
  L4_20 = Logic
  L5_21 = L4_20
  L4_20 = L4_20.Get
  L6_22 = "Hero"
  L4_20 = L4_20(L5_21, L6_22)
  L5_21 = L4_20
  L4_20 = L4_20.GetHeroImage
  L6_22 = L2_18.baseId
  L4_20 = L4_20(L5_21, L6_22)
  if L4_20 then
    L5_21 = CCSprite
    L6_22 = L5_21
    L5_21 = L5_21.create
    L7_23 = L4_20
    L5_21 = L5_21(L6_22, L7_23)
    if L5_21 then
      L6_22 = A0_16.imgFabao
      L7_23 = L6_22
      L6_22 = L6_22.setDisplayFrame
      L9_25 = L5_21
      L8_24 = L5_21.displayFrame
      L11_27 = L8_24(L9_25)
      L6_22(L7_23, L8_24, L9_25, L10_26, L11_27, L8_24(L9_25))
    end
  end
  L5_21 = Logic
  L6_22 = L5_21
  L5_21 = L5_21.Get
  L7_23 = "Hero"
  L5_21 = L5_21(L6_22, L7_23)
  L6_22 = L5_21
  L5_21 = L5_21.GetHeroBgImage
  L7_23 = L2_18.baseId
  L5_21 = L5_21(L6_22, L7_23)
  if L5_21 then
    L6_22 = CCSprite
    L7_23 = L6_22
    L6_22 = L6_22.create
    L8_24 = L5_21
    L6_22 = L6_22(L7_23, L8_24)
    if L6_22 then
      L7_23 = A0_16.imgkuang1
      L8_24 = L7_23
      L7_23 = L7_23.setDisplayFrame
      L10_26 = L6_22
      L9_25 = L6_22.displayFrame
      L11_27 = L9_25(L10_26)
      L7_23(L8_24, L9_25, L10_26, L11_27, L9_25(L10_26))
    end
  end
  L6_22 = A0_16.staName
  L7_23 = L6_22
  L6_22 = L6_22.setString
  L8_24 = L3_19.name
  L6_22(L7_23, L8_24)
  L6_22 = A0_16.staLevel
  L7_23 = L6_22
  L6_22 = L6_22.create
  L8_24 = 0
  L9_25 = "YELLOW_E_NUM"
  L6_22(L7_23, L8_24, L9_25)
  L6_22 = A0_16.staLevel
  L7_23 = L6_22
  L6_22 = L6_22.setAlign
  L8_24 = "LEFT"
  L9_25 = "CENTER"
  L6_22(L7_23, L8_24, L9_25)
  L6_22 = A0_16.staLevel
  L7_23 = L6_22
  L6_22 = L6_22.setValue
  L8_24 = A1_17.level
  L8_24 = L8_24 or 1
  L6_22(L7_23, L8_24)
  L6_22 = tostring
  L7_23 = A1_17.baseId
  L8_24 = "_"
  L9_25 = A1_17.level
  L7_23 = L7_23 .. L8_24 .. L9_25
  L6_22 = L6_22(L7_23)
  L7_23 = Logic
  L8_24 = L7_23
  L7_23 = L7_23.Get
  L9_25 = "Talisman"
  L7_23 = L7_23(L8_24, L9_25)
  L8_24 = L7_23
  L7_23 = L7_23.GetTaIlsmanLife
  L9_25 = L6_22
  L7_23 = L7_23(L8_24, L9_25)
  if L7_23 then
    L8_24 = L2_18.race
    if L8_24 ~= "EXP_1" then
      L8_24 = A0_16.imgLife
      L9_25 = L8_24
      L8_24 = L8_24.setVisible
      L10_26 = true
      L8_24(L9_25, L10_26)
      L8_24 = A0_16.staLife
      L9_25 = L8_24
      L8_24 = L8_24.setVisible
      L10_26 = true
      L8_24(L9_25, L10_26)
      L8_24 = A0_16.staLife
      L9_25 = L8_24
      L8_24 = L8_24.setString
      L10_26 = L7_23
      L8_24(L9_25, L10_26)
      L8_24 = A0_16.staLife
      L9_25 = L8_24
      L8_24 = L8_24.setStyle
      L10_26 = kCCLabelTTFStyleOutline
      L8_24(L9_25, L10_26)
    end
  else
    L8_24 = A0_16.imgLife
    L9_25 = L8_24
    L8_24 = L8_24.setVisible
    L10_26 = false
    L8_24(L9_25, L10_26)
    L8_24 = A0_16.staLife
    L9_25 = L8_24
    L8_24 = L8_24.setVisible
    L10_26 = false
    L8_24(L9_25, L10_26)
  end
  L8_24 = Logic
  L9_25 = L8_24
  L8_24 = L8_24.Get
  L10_26 = "Talisman"
  L8_24 = L8_24(L9_25, L10_26)
  L9_25 = L8_24
  L8_24 = L8_24.GetTaIlsmanAttack
  L10_26 = L6_22
  L8_24 = L8_24(L9_25, L10_26)
  if L8_24 then
    L9_25 = L2_18.race
    if L9_25 ~= "EXP_1" then
      L9_25 = A0_16.imgAttack
      L10_26 = L9_25
      L9_25 = L9_25.setVisible
      L11_27 = true
      L9_25(L10_26, L11_27)
      L9_25 = A0_16.staAttack
      L10_26 = L9_25
      L9_25 = L9_25.setVisible
      L11_27 = true
      L9_25(L10_26, L11_27)
      L9_25 = A0_16.staAttack
      L10_26 = L9_25
      L9_25 = L9_25.setString
      L11_27 = L8_24
      L9_25(L10_26, L11_27)
      L9_25 = A0_16.staAttack
      L10_26 = L9_25
      L9_25 = L9_25.setStyle
      L11_27 = kCCLabelTTFStyleOutline
      L9_25(L10_26, L11_27)
    end
  else
    L9_25 = A0_16.imgAttack
    L10_26 = L9_25
    L9_25 = L9_25.setVisible
    L11_27 = false
    L9_25(L10_26, L11_27)
    L9_25 = A0_16.staAttack
    L10_26 = L9_25
    L9_25 = L9_25.setVisible
    L11_27 = false
    L9_25(L10_26, L11_27)
  end
  L9_25 = A0_16.staStatus
  L10_26 = L9_25
  L9_25 = L9_25.setStyle
  L11_27 = kCCLabelTTFStyleOutline
  L9_25(L10_26, L11_27)
  L9_25 = A0_16.staStatus
  L10_26 = L9_25
  L9_25 = L9_25.setColor
  L11_27 = ccc3
  L11_27 = L11_27(0, 255, 0)
  L9_25(L10_26, L11_27, L11_27(0, 255, 0))
  L10_26 = A0_16
  L9_25 = A0_16.setBtnItemImg
  L11_27 = 1
  L9_25(L10_26, L11_27, 2, 3)
  L9_25 = A1_17.pfs
  if not L9_25 then
    L9_25 = A0_16.staStatus
    L10_26 = L9_25
    L9_25 = L9_25.setColor
    L11_27 = ccc3
    L11_27 = L11_27(255, 0, 0)
    L9_25(L10_26, L11_27, L11_27(255, 0, 0))
    L9_25 = A0_16.staStatus
    L10_26 = L9_25
    L9_25 = L9_25.setString
    L11_27 = TwGetStr
    L11_27 = L11_27(112020)
    L9_25(L10_26, L11_27, L11_27(112020))
    L9_25 = A0_16.btnSelect
    L10_26 = L9_25
    L9_25 = L9_25.setEnabled
    L11_27 = false
    L9_25(L10_26, L11_27)
  end
  L9_25 = A1_17.hasEquip
  if L9_25 then
    L9_25 = A0_16.staTip
    L10_26 = L9_25
    L9_25 = L9_25.setStyle
    L11_27 = kCCLabelTTFStyleOutline
    L9_25(L10_26, L11_27)
    L9_25 = A0_16.staTip
    L10_26 = L9_25
    L9_25 = L9_25.setColor
    L11_27 = ccc3
    L11_27 = L11_27(0, 255, 0)
    L9_25(L10_26, L11_27, L11_27(0, 255, 0))
    L9_25 = A0_16.staTip
    L10_26 = L9_25
    L9_25 = L9_25.setString
    L11_27 = TwGetStr
    L11_27 = L11_27(112038)
    L9_25(L10_26, L11_27, L11_27(112038))
    A0_16.choice = true
    L10_26 = A0_16
    L9_25 = A0_16.setBtnItemImg
    L11_27 = 4
    L9_25(L10_26, L11_27, 4, 1)
  end
  L9_25 = A1_17.equipHero
  if L9_25 then
    L9_25 = A1_17.hasEquip
    if not L9_25 then
      L9_25 = Logic
      L10_26 = L9_25
      L9_25 = L9_25.Get
      L11_27 = "Hero"
      L9_25 = L9_25(L10_26, L11_27)
      L10_26 = L9_25
      L9_25 = L9_25.GetHeroInfoById
      L11_27 = A1_17.equipHero
      L9_25 = L9_25(L10_26, L11_27)
      L10_26 = Logic
      L11_27 = L10_26
      L10_26 = L10_26.Get
      L10_26 = L10_26(L11_27, "Hero")
      L11_27 = L10_26
      L10_26 = L10_26.GetHeroInfoByBaseId
      L10_26 = L10_26(L11_27, L9_25.baseId)
      L11_27 = Logic
      L11_27 = L11_27.Get
      L11_27 = L11_27(L11_27, "Hero")
      L11_27 = L11_27.getColorByBaseId
      L11_27 = L11_27(L11_27, L9_25.baseId)
      if L11_27 then
        A0_16.staStatus:setColor(L11_27)
      end
      A0_16.staStatus:setString(L10_26.name)
    end
  end
  L9_25 = A1_17.canStar
  if not L9_25 then
    L9_25 = A1_17.pfs
    if L9_25 then
      L9_25 = A0_16.staStatus
      L10_26 = L9_25
      L9_25 = L9_25.setColor
      L11_27 = ccc3
      L11_27 = L11_27(255, 0, 0)
      L9_25(L10_26, L11_27, L11_27(255, 0, 0))
      L9_25 = tonumber
      L10_26 = L2_18.id
      L10_26 = L10_26 or A1_17.baseId
      L9_25 = L9_25(L10_26)
      if L9_25 and L9_25 >= 701 and L9_25 <= 716 then
        L10_26 = A0_16.staStatus
        L11_27 = L10_26
        L10_26 = L10_26.setString
        L10_26(L11_27, "\228\187\133\231\186\162\229\141\161\229\143\175\232\163\133\229\164\135")
      else
        L10_26 = A0_16.staStatus
        L11_27 = L10_26
        L10_26 = L10_26.setString
        L10_26(L11_27, TwGetStr(103406, L2_18.minStarLevel))
      end
      L10_26 = A0_16.btnSelect
      L11_27 = L10_26
      L10_26 = L10_26.setEnabled
      L10_26(L11_27, false)
    end
  end
  L9_25 = A1_17.canStar
  if L9_25 then
    L9_25 = A1_17.equipHero
    if not L9_25 then
      L10_26 = A0_16
      L9_25 = A0_16.setBtnItemImg
      L11_27 = 4
      L9_25(L10_26, L11_27, 4, 1)
    end
  end
  L9_25 = 1
  L10_26 = Logic
  L11_27 = L10_26
  L10_26 = L10_26.Get
  L10_26 = L10_26(L11_27, "Lock")
  L11_27 = L10_26
  L10_26 = L10_26.GetStatusByLockId
  L10_26 = L10_26(L11_27, Logic.Lock.LOCK_ID.TALISMAN_EQUIP_2_LOCK)
  if not L10_26 then
    L9_25 = 2
  end
  L11_27 = Logic
  L11_27 = L11_27.Get
  L11_27 = L11_27(L11_27, "Talisman")
  L11_27 = L11_27.GetEquipTail_IDS
  L11_27 = L11_27(L11_27)
  for _FORV_16_, _FORV_17_ in pairs(L11_27) do
  end
  if A1_17.canEquip then
  end
  if A0_16.choice then
    if CCSprite:create("images/public/selcet2.png") then
      A0_16.imgCanSelect:setDisplayFrame(CCSprite:create("images/public/selcet2.png"):displayFrame())
    end
  elseif CCSprite:create("images/public/selcet1.png") then
    A0_16.imgCanSelect:setDisplayFrame(CCSprite:create("images/public/selcet1.png"):displayFrame())
  end
end
function prototype.setBtnItemImg(A0_28, A1_29, A2_30, A3_31)
  local L4_32
  L4_32 = {
    "images/public/btnHeroFrameNormal.png",
    "images/public/btnHeroFrameSelect.png",
    "images/public/btnHeroFrameDisable.png",
    "images/Equip/btnEquipNor.png"
  }
  A0_28.btnSelect:setBackgroundSpriteForState(CCScale9Sprite:create(L4_32[A1_29]), CCControlStateNormal)
  A0_28.btnSelect:setBackgroundSpriteForState(CCScale9Sprite:create(L4_32[A2_30]), CCControlStateHighlighted)
  A0_28.btnSelect:setBackgroundSpriteForState(CCScale9Sprite:create(L4_32[A3_31]), CCControlStateDisabled)
end
function prototype.updateGuide(A0_33)
  if Logic:Get("Guide"):isActive("TalismanEquip", "SelectFabao") then
    A0_33.btnFabao:setEnabled(false)
    Logic:Get("Guide"):lockTouch(A0_33.btnSelect)
  end
end
