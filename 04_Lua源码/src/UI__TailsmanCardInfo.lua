local L0_0
L0_0 = module
L0_0((...), package.seeall)
L0_0 = require
L0_0("SceneHelper")
L0_0 = Tw
L0_0 = L0_0.Controller
L0_0 = L0_0.prototype
L0_0 = L0_0.extend
L0_0 = L0_0(L0_0)
prototype = L0_0
L0_0 = 108
function prototype.onEnter(A0_1)
  local L1_2
end
function prototype.ReFrashHeroInfo(A0_3, A1_4)
  local L2_5, L3_6, L4_7, L5_8, L6_9, L7_10, L8_11, L9_12
  if not A1_4 then
    return
  end
  L2_5 = KFDBGetRecord
  L3_6 = "TalismanSetting"
  L4_7 = A1_4.baseId
  L2_5 = L2_5(L3_6, L4_7)
  L3_6 = Logic
  L4_7 = L3_6
  L3_6 = L3_6.Get
  L5_8 = "HeroCardInfo"
  L3_6 = L3_6(L4_7, L5_8)
  L4_7 = L3_6
  L3_6 = L3_6.kdbBaseHero
  L5_8 = L2_5.baseId
  L3_6 = L3_6(L4_7, L5_8)
  if L3_6 == nil then
    return
  end
  L4_7 = A1_4.fra
  if L4_7 ~= nil then
    L4_7 = TwGetStr
    L5_8 = 103134
    L4_7 = L4_7(L5_8)
    L5_8 = A0_3.name
    L6_9 = L5_8
    L5_8 = L5_8.setString
    L7_10 = A1_4.itemName
    L7_10 = L7_10 or ""
    L5_8(L6_9, L7_10)
  else
    L4_7 = A0_3.name
    L5_8 = L4_7
    L4_7 = L4_7.setString
    L6_9 = L3_6.name
    L6_9 = L6_9 or ""
    L4_7(L5_8, L6_9)
  end
  L4_7 = Logic
  L5_8 = L4_7
  L4_7 = L4_7.Get
  L6_9 = "Hero"
  L4_7 = L4_7(L5_8, L6_9)
  L5_8 = L4_7
  L4_7 = L4_7.getColorByBaseId
  L6_9 = L2_5.baseId
  L4_7 = L4_7(L5_8, L6_9)
  L5_8 = A0_3.name
  L6_9 = L5_8
  L5_8 = L5_8.setColor
  L7_10 = L4_7
  L5_8(L6_9, L7_10)
  L5_8 = A0_3.labLevel
  L6_9 = L5_8
  L5_8 = L5_8.create
  L5_8(L6_9)
  L5_8 = A0_3.labLevel
  L6_9 = L5_8
  L5_8 = L5_8.setValue
  L7_10 = A1_4.level
  L7_10 = L7_10 or 0
  L5_8(L6_9, L7_10)
  L5_8 = ""
  L6_9 = A1_4.baseId
  if L6_9 ~= nil then
    L6_9 = A1_4.level
  elseif L6_9 == nil then
    return
  end
  L6_9 = A1_4.baseId
  L7_10 = "_"
  L8_11 = A1_4.level
  L6_9 = L6_9 .. L7_10 .. L8_11
  L7_10 = KFDBGetRecord
  L8_11 = "TalismanLevelSetting"
  L9_12 = L6_9
  L7_10 = L7_10(L8_11, L9_12)
  if L7_10 == nil then
    return
  end
  A0_3.fdb_tailsmanInfo = L7_10
  L8_11 = A0_3.type_ttf
  L9_12 = L8_11
  L8_11 = L8_11.setFontSize
  L8_11(L9_12, 18)
  L8_11 = A0_3.type_ttf
  L9_12 = L8_11
  L8_11 = L8_11.setColor
  L8_11(L9_12, ccColor3B(0, 255, 0))
  L8_11 = A0_3.type_ttf
  L9_12 = L8_11
  L8_11 = L8_11.setString
  L8_11(L9_12, A0_3:pvpTypeLine(L2_5.TalismanType or "", tonumber(A1_4.baseId)))
  L8_11 = A0_3.type_ttf
  L9_12 = L8_11
  L8_11 = L8_11.setStyle
  L8_11(L9_12, kCCLabelTTFStyleOutline)
  L9_12 = A0_3
  L8_11 = A0_3.showProps
  L8_11(L9_12)
  L8_11 = A0_3.ttf_Get
  L9_12 = L8_11
  L8_11 = L8_11.setString
  L8_11(L9_12, ReplaceStringTab(L3_6.gain or ""))
  L8_11 = A0_3.ttf_Get
  L9_12 = L8_11
  L8_11 = L8_11.setStyle
  L8_11(L9_12, kCCLabelTTFStyleOutline)
  L8_11 = A0_3.ttf_limit_value
  L9_12 = L8_11
  L8_11 = L8_11.setColor
  L8_11(L9_12, ccColor3B(0, 255, 0))
  L8_11 = tonumber
  L9_12 = A1_4.baseId
  L8_11 = L8_11(L9_12)
  if L8_11 and L8_11 >= 701 and L8_11 <= 716 then
    L9_12 = A0_3.ttf_limit_value
    L9_12 = L9_12.setString
    L9_12(L9_12, "\228\187\133\231\186\162\229\141\161\229\143\175\232\163\133\229\164\135")
  else
    L9_12 = A0_3.ttf_limit_value
    L9_12 = L9_12.setString
    L9_12(L9_12, TwGetStr(112049, L2_5.minStarLevel))
  end
  L9_12 = L3_6.description
  L9_12 = L9_12 or ""
  L9_12 = ReplaceStringTab(L9_12)
  A0_3.ttf_des:setStyle(kCCLabelTTFStyleOutline)
  A0_3.ttf_des:setDimensions(CCSize(550, 0))
  A0_3.ttf_des:setString(L9_12 or "")
  A0_3:createHeroCard(L2_5.baseId, L2_5.fra)
  A0_3:createPfs(A1_4.baseId)
end
function prototype.showProps(A0_13)
  local L1_14, L2_15, L3_16, L4_17, L5_18, L6_19, L7_20, L8_21, L9_22, L10_23, L11_24
  L1_14 = A0_13.fdb_tailsmanInfo
  if not L1_14 then
    return
  end
  L1_14 = A0_13.fdb_tailsmanInfo
  L2_15 = json
  L2_15 = L2_15.decode
  L3_16 = L1_14.alters
  L3_16 = L3_16 or "[]"
  L2_15 = L2_15(L3_16)
  L3_16 = A0_13.ToSortedArray
  L3_16 = L3_16(L4_17, L5_18)
  for L7_20, L8_21 in L4_17(L5_18) do
    L9_22 = string
    L9_22 = L9_22.format
    L10_23 = "spr%d"
    L11_24 = L7_20
    L9_22 = L9_22(L10_23, L11_24)
    L10_23 = Logic
    L11_24 = L10_23
    L10_23 = L10_23.Get
    L10_23 = L10_23(L11_24, "Armor")
    L11_24 = L10_23
    L10_23 = L10_23.getPropertySpr
    L10_23 = L10_23(L11_24, L8_21.key)
    L11_24 = A0_13[L9_22]
    if L11_24 and L10_23 then
      L11_24 = A0_13[L9_22]
      L11_24 = L11_24.setDisplayFrame
      L11_24(L11_24, L10_23:displayFrame())
    end
    L11_24 = string
    L11_24 = L11_24.format
    L11_24 = L11_24("ttf%d", L7_20)
    L9_22 = L11_24
    L11_24 = A0_13[L9_22]
    if L11_24 then
      L11_24 = ""
      if tonumber(L8_21.value) <= 1 then
        L8_21.value = tonumber(L8_21.value) * 100
        L11_24 = "%"
      end
      A0_13[L9_22]:setString("+" .. L8_21.value .. L11_24)
      A0_13[L9_22]:setStyle(kCCLabelTTFStyleOutline)
    end
  end
end
function prototype.createPfs(A0_25, A1_26)
  local L2_27, L3_28, L4_29, L5_30, L6_31, L7_32, L8_33
  for L5_30 = 1, 8 do
    L7_32 = "spr_pfs_%d"
    L8_33 = L5_30
    L7_32 = A0_25[L6_31]
    L8_33 = L7_32
    L7_32 = L7_32.setVisible
    L7_32(L8_33, false)
  end
  if L4_29 >= 14 then
    L7_32 = true
    L5_30(L6_31, L7_32)
    L7_32 = L4_29
    L7_32 = L6_31
    L8_33 = L5_30.displayFrame
    L8_33 = L8_33(L5_30)
    L6_31(L7_32, L8_33, L8_33(L5_30))
    return
  end
  for L7_32 = 1, #L3_28 do
    L8_33 = string
    L8_33 = L8_33.format
    L8_33 = L8_33("data/profession/%s.png", L3_28[L7_32])
    if A0_25[string.format("spr_pfs_%d", L7_32)] then
      A0_25[string.format("spr_pfs_%d", L7_32)]:setVisible(true)
      A0_25[string.format("spr_pfs_%d", L7_32)]:setDisplayFrame(CCSprite:create(L8_33):displayFrame())
    end
  end
end
function prototype.createHeroCard(A0_34, A1_35, A2_36)
  local L3_37
  if A1_35 == nil then
    return
  end
  L3_37 = Logic
  L3_37 = L3_37.Get
  L3_37 = L3_37(L3_37, "HeroCardInfo")
  L3_37 = L3_37.createHeroCard
  L3_37 = L3_37(L3_37, A1_35, nil, A2_36, nil, nil, nil, true)
  if L3_37 == nil then
    return
  end
  L3_37:setScale(1 * (_UPVALUE0_ / L3_37:getContentSize().width))
  L3_37:setAnchorPoint(CCPoint(0.5, 0.5))
  A0_34.layer:addChild(L3_37)
  L3_37:setPosition(A0_34.head:getPosition())
end
function prototype.ToSortedArray(A0_38, A1_39)
  local L2_40, L3_41
  if A1_39 then
    L2_40 = table
    L2_40 = L2_40.empty
    L3_41 = A1_39
    L2_40 = L2_40(L3_41)
  elseif L2_40 then
    L2_40 = {}
    return L2_40
  end
  L2_40 = Enum
  L3_41 = {
    "PCT_ATTACK",
    "ATTACK",
    "PCT_LIFE",
    "LIFE",
    "RATE_CRIT",
    "RATE_HURT_CRIT",
    "RATE_HIT",
    "RATE_HARM_P",
    "RATE_HARM_M",
    "RATE_UNHARM_M",
    "RATE_UNHARM_P",
    "RATE_UNCRIT",
    "RATE_UNHURT_CRIT",
    "RATE_DODGY"
  }
  L2_40 = L2_40(L3_41)
  L3_41 = {}
  for _FORV_7_, _FORV_8_ in pairs(A1_39) do
    table.insert(L3_41, {key = _FORV_7_, value = _FORV_8_})
  end
  table.sort(L3_41, function(A0_42, A1_43)
    local L2_44, L3_45
    L2_44 = _UPVALUE0_
    L3_45 = A0_42.key
    L2_44 = L2_44[L3_45]
    L3_45 = _UPVALUE0_
    L3_45 = L3_45[A1_43.key]
    L2_44 = L2_44 < L3_45
    return L2_44
  end)
  return L3_41
end
function prototype.pvpAffixText(A0_46, A1_47)
  local L2_48
  L2_48 = _UPVALUE0_
  L2_48 = L2_48[A1_47]
  if L2_48 then
    L2_48 = "20%\230\138\151\230\154\180\229\135\187 20%\229\133\141\228\188\164\239\188\136PVP\231\148\159\230\149\136\239\188\137"
    return L2_48
  end
  L2_48 = _UPVALUE1_
  L2_48 = L2_48[A1_47]
  if L2_48 then
    L2_48 = "\229\133\141\231\150\171\229\133\139\229\136\182\239\188\136PVP\231\148\159\230\149\136\239\188\137"
    return L2_48
  end
  L2_48 = ""
  return L2_48
end
function prototype.pvpTypeLine(A0_49, A1_50, A2_51)
  local L3_52
  L3_52 = A0_49.pvpAffixText
  L3_52 = L3_52(A0_49, A2_51)
  if L3_52 == "" then
    return A1_50 or ""
  end
  if A1_50 == nil or A1_50 == "" then
    return L3_52
  end
  return A1_50 .. "  " .. L3_52
end
