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
  if A0_3.data then
    require("FabaoTranslate").OpenTalismanDetail(A0_3.data)
  end
end
function prototype.onBtnSelect(A0_4)
  if A0_4.data == nil then
    return
  end
  require("FabaoTranslate").SetSelect(A0_4.data)
  Logic:Get("Compose"):SetSelectCard(A0_4.data)
  Logic:Get("Compose"):FireEvent(Logic.Compose.EVT.SELECT_CARD)
end
function prototype.clear(A0_5)
  A0_5.btnSelect:setEnabled(true)
  if CCSprite:create("images/public/selcet1.png") and A0_5.imgCanSelect then
    A0_5.imgCanSelect:setDisplayFrame(CCSprite:create("images/public/selcet1.png"):displayFrame())
    A0_5.imgCanSelect:setVisible(true)
  end
end
function prototype.lifeAttack(A0_6, A1_7)
  local L2_8, L3_9, L4_10, L5_11, L6_12, L7_13
  L2_8 = A1_7.settingId
  L2_8 = L2_8 or A1_7.baseId
  L3_9 = KFDBGetRecord
  L4_10 = "TalismanSetting"
  L5_11 = L2_8
  L3_9 = L3_9(L4_10, L5_11)
  L4_10 = A1_7.baseId
  if L3_9 then
    L5_11 = L3_9.baseId
    if L5_11 then
      L4_10 = L3_9.baseId
    end
  end
  L5_11, L6_12 = nil, nil
  if L3_9 then
    L7_13 = tostring
    L7_13 = L7_13(L2_8 .. "_" .. (A1_7.level or 1))
    L5_11 = Logic:Get("Talisman"):GetTaIlsmanLife(L7_13)
    L6_12 = Logic:Get("Talisman"):GetTaIlsmanAttack(L7_13)
  end
  if (L5_11 == nil or L5_11 == 0) and L4_10 then
    L7_13 = Logic
    L7_13 = L7_13.Get
    L7_13 = L7_13(L7_13, "Hero")
    L7_13 = L7_13.GetHeroLifeAndAttack
    L6_12, L7_13 = L7_13, L7_13(L7_13, L4_10, A1_7.level or 1)
    L5_11 = L7_13
  end
  L7_13 = L5_11
  return L7_13, L6_12, L4_10
end
function prototype.ReFrashInfo(A0_14, A1_15)
  local L2_16, L3_17, L4_18, L5_19, L6_20, L7_21, L8_22, L9_23
  L3_17 = A0_14
  L2_16 = A0_14.clear
  L2_16(L3_17)
  if A1_15 ~= nil then
    L2_16 = table
    L2_16 = L2_16.empty
    L3_17 = A1_15
    L2_16 = L2_16(L3_17)
  elseif L2_16 then
    return
  end
  A0_14.data = A1_15
  L3_17 = A0_14
  L2_16 = A0_14.lifeAttack
  L4_18 = A1_15
  L4_18 = L2_16(L3_17, L4_18)
  L5_19 = CCSprite
  L6_20 = L5_19
  L5_19 = L5_19.create
  L7_21 = _UPVALUE0_
  L5_19 = L5_19(L6_20, L7_21)
  if L5_19 then
    L6_20 = A0_14.imgFabao
    L7_21 = L6_20
    L6_20 = L6_20.setDisplayFrame
    L9_23 = L5_19
    L8_22 = L5_19.displayFrame
    L9_23 = L8_22(L9_23)
    L6_20(L7_21, L8_22, L9_23, L8_22(L9_23))
    L6_20 = A0_14.imgkuang1
    L7_21 = L6_20
    L6_20 = L6_20.setDisplayFrame
    L9_23 = L5_19
    L8_22 = L5_19.displayFrame
    L9_23 = L8_22(L9_23)
    L6_20(L7_21, L8_22, L9_23, L8_22(L9_23))
  end
  L6_20 = L4_18 and L6_20(L7_21, L8_22)
  if L6_20 then
    L7_21 = CCSprite
    L8_22 = L7_21
    L7_21 = L7_21.create
    L9_23 = L6_20
    L7_21 = L7_21(L8_22, L9_23)
    if L7_21 then
      L8_22 = A0_14.imgFabao
      L9_23 = L8_22
      L8_22 = L8_22.setDisplayFrame
      L8_22(L9_23, L7_21:displayFrame())
    end
  end
  L7_21 = L4_18 and L7_21(L8_22, L9_23)
  if L7_21 then
    L8_22 = CCSprite
    L9_23 = L8_22
    L8_22 = L8_22.create
    L8_22 = L8_22(L9_23, L7_21)
    if L8_22 then
      L9_23 = A0_14.imgkuang1
      L9_23 = L9_23.setDisplayFrame
      L9_23(L9_23, L8_22:displayFrame())
    end
  end
  L8_22 = A0_14.staTip
  if L8_22 then
    L8_22 = A0_14.staTip
    L9_23 = L8_22
    L8_22 = L8_22.setVisible
    L8_22(L9_23, false)
  end
  if L2_16 and L2_16 ~= 0 then
    L8_22 = A0_14.imgLife
    L9_23 = L8_22
    L8_22 = L8_22.setVisible
    L8_22(L9_23, true)
    L8_22 = A0_14.staHeart
    L9_23 = L8_22
    L8_22 = L8_22.setVisible
    L8_22(L9_23, true)
    L8_22 = A0_14.staHeart
    L9_23 = L8_22
    L8_22 = L8_22.setString
    L8_22(L9_23, tostring(L2_16))
    L8_22 = A0_14.staHeart
    L9_23 = L8_22
    L8_22 = L8_22.setStyle
    L8_22(L9_23, kCCLabelTTFStyleOutline)
  else
    L8_22 = A0_14.imgLife
    L9_23 = L8_22
    L8_22 = L8_22.setVisible
    L8_22(L9_23, false)
    L8_22 = A0_14.staHeart
    L9_23 = L8_22
    L8_22 = L8_22.setVisible
    L8_22(L9_23, false)
  end
  if L3_17 and L3_17 ~= 0 then
    L8_22 = A0_14.imgAttack
    L9_23 = L8_22
    L8_22 = L8_22.setVisible
    L8_22(L9_23, true)
    L8_22 = A0_14.staAttack
    L9_23 = L8_22
    L8_22 = L8_22.setVisible
    L8_22(L9_23, true)
    L8_22 = A0_14.staAttack
    L9_23 = L8_22
    L8_22 = L8_22.setString
    L8_22(L9_23, tostring(L3_17))
    L8_22 = A0_14.staAttack
    L9_23 = L8_22
    L8_22 = L8_22.setStyle
    L8_22(L9_23, kCCLabelTTFStyleOutline)
  else
    L8_22 = A0_14.imgAttack
    L9_23 = L8_22
    L8_22 = L8_22.setVisible
    L8_22(L9_23, false)
    L8_22 = A0_14.staAttack
    L9_23 = L8_22
    L8_22 = L8_22.setVisible
    L8_22(L9_23, false)
  end
  L8_22 = A0_14.staName
  L9_23 = L8_22
  L8_22 = L8_22.setString
  L8_22(L9_23, A1_15.name or "")
  L8_22 = A0_14.staLevel
  L9_23 = L8_22
  L8_22 = L8_22.create
  L8_22(L9_23, 0, "YELLOW_E_NUM")
  L8_22 = A0_14.staLevel
  L9_23 = L8_22
  L8_22 = L8_22.setAlign
  L8_22(L9_23, "LEFT", "CENTER")
  L8_22 = A0_14.staLevel
  L9_23 = L8_22
  L8_22 = L8_22.setValue
  L8_22(L9_23, A1_15.level or 1)
  L8_22 = false
  L9_23 = Logic
  L9_23 = L9_23.Get
  L9_23 = L9_23(L9_23, "Talisman")
  L9_23 = L9_23.advanceMode
  if L9_23 == true then
    L9_23 = Logic
    L9_23 = L9_23.Get
    L9_23 = L9_23(L9_23, "Talisman")
    L9_23 = L9_23.GetSwallFabaos
    L9_23 = L9_23(L9_23)
    L9_23 = L9_23 or {}
    for _FORV_13_, _FORV_14_ in ipairs(L9_23) do
      if _FORV_14_ and _FORV_14_.id == A1_15.id then
        L8_22 = true
        break
      end
    end
  else
    L9_23 = require
    L9_23 = L9_23("FabaoTranslate")
    L9_23 = L9_23.GetSelect
    L9_23 = L9_23()
    L8_22 = L9_23 and A1_15.id == L9_23.id
  end
  if L8_22 then
    L9_23 = CCSprite
    L9_23 = L9_23.create
    L9_23 = L9_23(L9_23, "images/public/selcet2.png")
    if L9_23 and A0_14.imgCanSelect then
      A0_14.imgCanSelect:setDisplayFrame(L9_23:displayFrame())
    end
  end
end
