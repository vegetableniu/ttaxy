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
L0_0 = 90
ADVANCE_UNLOCK_LEVEL = L0_0
L0_0 = {}
L0_0[501] = {
  family = 1,
  name = "\228\184\131\229\183\167\231\142\178\231\143\145\229\161\148",
  newBaseId = 601,
  newName = "\231\156\159\229\133\131\232\138\173\232\149\137\230\137\135",
  oldDisplayBaseId = 674,
  newDisplayBaseId = 665
}
L0_0[502] = {
  family = 2,
  name = "\229\164\170\228\185\153\230\183\183\229\164\169\231\187\171",
  newBaseId = 602,
  newName = "\228\184\131\229\174\157\229\166\153\230\160\145",
  oldDisplayBaseId = 664,
  newDisplayBaseId = 663
}
L0_0[503] = {
  family = 3,
  name = "\228\185\157\233\190\153\231\165\158\231\129\171\231\189\169",
  newBaseId = 603,
  newName = "\230\184\133\229\135\128\231\144\137\231\146\131\231\147\182",
  oldDisplayBaseId = 661,
  newDisplayBaseId = 662
}
L0_0[521] = {
  family = 4,
  name = "\228\185\190\229\157\164\230\137\147\231\165\158\233\158\173",
  newBaseId = 604,
  newName = "\228\186\148\231\129\171\228\184\131\231\166\189\230\137\135",
  oldDisplayBaseId = 673,
  newDisplayBaseId = 676
}
L0_0[522] = {
  family = 5,
  name = "\230\183\183\229\133\131\231\143\141\231\143\160\228\188\158",
  newBaseId = 605,
  newName = "\233\163\158\233\190\153\229\174\157\230\157\150",
  oldDisplayBaseId = 672,
  newDisplayBaseId = 666
}
L0_0[523] = {
  family = 6,
  name = "\231\142\137\232\153\154\230\157\143\233\187\132\230\151\151",
  newBaseId = 606,
  newName = "\233\152\180\233\152\179\228\186\140\230\176\148\231\147\182",
  oldDisplayBaseId = 671,
  newDisplayBaseId = 675
}
SPECS = L0_0
L0_0 = {}
L0_0[501] = {progress = 3600, materialProgress = 1200}
L0_0[502] = {progress = 3600, materialProgress = 1200}
L0_0[503] = {progress = 3600, materialProgress = 1200}
L0_0[521] = {progress = 4800, materialProgress = 2000}
L0_0[522] = {progress = 4800, materialProgress = 2000}
L0_0[523] = {progress = 4800, materialProgress = 2000}
L0_0[601] = {progress = 3600, materialProgress = 1200}
L0_0[602] = {progress = 3600, materialProgress = 1200}
L0_0[603] = {progress = 3600, materialProgress = 1200}
L0_0[604] = {progress = 4800, materialProgress = 2000}
L0_0[605] = {progress = 4800, materialProgress = 2000}
L0_0[606] = {progress = 4800, materialProgress = 2000}
ADVANCE_TARGETS = L0_0
L0_0 = {}
L0_0[501] = 701
L0_0[502] = 702
L0_0[503] = 703
L0_0[521] = 704
L0_0[522] = 705
L0_0[523] = 706
L0_0[601] = 711
L0_0[602] = 712
L0_0[603] = 713
L0_0[604] = 714
L0_0[605] = 715
L0_0[606] = 716
ADVANCE_RED = L0_0
L0_0 = 697
BROKEN_WEAPON_ID = L0_0
L0_0 = 100
BROKEN_WEAPON_PROGRESS = L0_0
L0_0 = "images/public/clarity05.png"
function GetSpec(A0_1)
  local L1_2, L2_3, L3_4, L4_5, L5_6, L6_7
  L1_2 = tonumber
  L1_2 = L1_2(L2_3)
  for L5_6, L6_7 in L2_3(L3_4) do
    if L1_2 == L5_6 or L1_2 == L6_7.newBaseId then
      for _FORV_11_, _FORV_12_ in pairs(L6_7) do
        ({})[_FORV_11_] = _FORV_12_
      end
      ;({}).baseId = L1_2
      ;({}).isOld = L1_2 == L5_6
      ;({}).displayBaseId = ({}).isOld and L6_7.oldDisplayBaseId or L6_7.newDisplayBaseId
      ;({}).displayName = ({}).isOld and L6_7.name or L6_7.newName
      return {}
    end
  end
  return L2_3
end
function GetPickMode()
  local L0_8, L1_9
  L0_8 = _UPVALUE0_
  return L0_8
end
function GetPickSlot()
  local L0_10, L1_11
  L0_10 = _UPVALUE0_
  return L0_10
end
function FindPlaqueTitleSprite(A0_12)
  local L1_13, L2_14, L3_15, L4_16
  L1_13 = A0_12 and (L1_13 or A0_12.rootNode)
  if L1_13 == nil then
    L2_14 = nil
    return L2_14
  end
  L2_14, L3_15 = nil, nil
  function L4_16(A0_17)
    if A0_17 == nil then
      return
    end
    if A0_17.getContentSize and A0_17:getContentSize() then
      if math.abs(((A0_17.getContentSize and A0_17:getContentSize()).width or 0) - 131) < 2 then
        if 2 > math.abs(((A0_17.getContentSize and A0_17:getContentSize()).height or 0) - 35) then
          if _UPVALUE0_ == nil or (A0_17.convertToWorldSpace and A0_17:convertToWorldSpace(ccp(((A0_17.getContentSize and A0_17:getContentSize()).width or 0) / 2, ((A0_17.getContentSize and A0_17:getContentSize()).height or 0) / 2)) and (A0_17.convertToWorldSpace and A0_17:convertToWorldSpace(ccp(((A0_17.getContentSize and A0_17:getContentSize()).width or 0) / 2, ((A0_17.getContentSize and A0_17:getContentSize()).height or 0) / 2))).y or A0_17.getPositionY and A0_17:getPositionY() or 0) > _UPVALUE1_ then
            _UPVALUE1_, _UPVALUE0_ = A0_17.convertToWorldSpace and A0_17:convertToWorldSpace(ccp(((A0_17.getContentSize and A0_17:getContentSize()).width or 0) / 2, ((A0_17.getContentSize and A0_17:getContentSize()).height or 0) / 2)) and (A0_17.convertToWorldSpace and A0_17:convertToWorldSpace(ccp(((A0_17.getContentSize and A0_17:getContentSize()).width or 0) / 2, ((A0_17.getContentSize and A0_17:getContentSize()).height or 0) / 2))).y or A0_17.getPositionY and A0_17:getPositionY() or 0, A0_17
          end
        end
      end
    end
    if A0_17.getChildren and A0_17:getChildren() and (A0_17.getChildren and A0_17:getChildren()).count then
      for _FORV_6_ = 1, (A0_17.getChildren and A0_17:getChildren()):count() do
        _UPVALUE2_(tolua.cast((A0_17.getChildren and A0_17:getChildren()):objectAtIndex(_FORV_6_ - 1), "CCNode"))
      end
    end
  end
  L4_16(L1_13)
  return L2_14
end
function BannerTitlePosition(A0_18)
  local L1_19, L2_20
  L1_19 = FindPlaqueTitleSprite
  L2_20 = A0_18
  L1_19 = L1_19(L2_20)
  L1_19 = L1_19 or A0_18 and A0_18.mainTitleSprite
  if L1_19 then
    L2_20 = L1_19.getParent
    if L2_20 then
      L2_20 = L1_19.getParent
      L2_20 = L2_20(L1_19)
    end
  else
    L2_20 = L2_20 or A0_18 and (L2_20 or A0_18.rootNode)
  end
  if L2_20 == nil then
    return nil, nil
  end
  if L1_19 then
    L1_19:setVisible(false)
    return _UPVALUE0_(L1_19, ccp(360, 742))
  end
  return L2_20, ccp((L2_20.getContentSize and L2_20:getContentSize() and (L2_20.getContentSize and L2_20:getContentSize()).width or 720) / 2, 742)
end
function PlaySuccessAni(A0_21, A1_22, A2_23, A3_24, A4_25)
  local L5_26, L6_27, L7_28, L8_29, L9_30, L10_31, L11_32, L12_33, L13_34, L14_35, L15_36, L16_37
  L5_26 = Logic
  L6_27 = L5_26
  L5_26 = L5_26.Get
  L7_28 = "System"
  L5_26 = L5_26(L6_27, L7_28)
  L6_27 = L5_26
  L5_26 = L5_26.IsUpgradeAniEnabled
  L5_26 = L5_26(L6_27)
  if not L5_26 then
    if A4_25 then
      L5_26 = A4_25
      L5_26()
    end
    return
  end
  L5_26 = SceneHelper
  L6_27 = L5_26
  L5_26 = L5_26.getRootLayer
  L5_26 = L5_26(L6_27)
  L6_27 = Logic
  L7_28 = L6_27
  L6_27 = L6_27.Get
  L8_29 = "AniMgr"
  L6_27 = L6_27(L7_28, L8_29)
  L7_28 = L6_27
  L6_27 = L6_27.NewCCB
  L8_29 = "UI/uiyxsj"
  L9_30 = L5_26
  L6_27 = L6_27(L7_28, L8_29, L9_30, L10_31, L11_32)
  if L6_27 == nil then
    if A4_25 then
      L7_28 = A4_25
      L7_28()
    end
    return
  end
  function L7_28(A0_38)
    return _UPVALUE0_:GetChild(A0_38)
  end
  function L8_29(A0_39, A1_40)
    if _UPVALUE0_(A0_39) then
      _UPVALUE0_(A0_39):setVisible(A1_40)
    end
  end
  function L9_30(A0_41, A1_42)
    local L2_43, L3_44, L4_45, L5_46, L6_47, L7_48, L8_49
    L2_43 = _UPVALUE0_
    L3_44 = A0_41
    L2_43 = L2_43(L3_44)
    if L2_43 == nil or A1_42 == nil then
      return
    end
    L3_44 = Logic
    L4_45 = L3_44
    L3_44 = L3_44.Get
    L5_46 = "HeroCardInfo"
    L3_44 = L3_44(L4_45, L5_46)
    L4_45 = L3_44
    L3_44 = L3_44.createHeroCardForByFight
    L5_46 = A1_42
    L6_47 = true
    L3_44 = L3_44(L4_45, L5_46, L6_47)
    if not L3_44 then
      L3_44 = Logic
      L4_45 = L3_44
      L3_44 = L3_44.Get
      L5_46 = "HeroCardInfo"
      L3_44 = L3_44(L4_45, L5_46)
      L4_45 = L3_44
      L3_44 = L3_44.createHeroCard
      L5_46 = A1_42
      L6_47 = 200
      L3_44 = L3_44(L4_45, L5_46, L6_47)
    end
    if L3_44 == nil then
      return
    end
    L4_45 = Logic
    L5_46 = L4_45
    L4_45 = L4_45.Get
    L6_47 = "HeroCardInfo"
    L4_45 = L4_45(L5_46, L6_47)
    L5_46 = L4_45
    L4_45 = L4_45.GetCardTexture
    L6_47 = L3_44
    L8_49 = L2_43
    L7_48 = L2_43.getContentSize
    L8_49 = L7_48(L8_49)
    L5_46 = L4_45(L5_46, L6_47, L7_48, L8_49)
    L7_48 = L2_43
    L6_47 = L2_43.setTexture
    L8_49 = L4_45
    L6_47(L7_48, L8_49)
    L7_48 = L2_43
    L6_47 = L2_43.setTextureRect
    L8_49 = L5_46
    L6_47(L7_48, L8_49)
  end
  L10_31(L11_32, L12_33)
  L12_33 = A1_22 or A0_21
  L10_31(L11_32, L12_33)
  for L13_34 = 1, 6 do
    L14_35 = string
    L14_35 = L14_35.format
    L15_36 = "imgHero%d"
    L16_37 = L13_34
    L14_35 = L14_35(L15_36, L16_37)
    L15_36 = L7_28
    L16_37 = L14_35
    L15_36 = L15_36(L16_37)
    if L15_36 then
      L16_37 = A2_23 and A2_23[L13_34]
      if L16_37 then
        L15_36:setVisible(true)
        L9_30(L14_35, _UPVALUE0_(L16_37))
      else
        L15_36:setVisible(false)
      end
    end
  end
  L14_35 = "staAttack"
  L15_36 = "imgLifeTip"
  L16_37 = "staLife"
  for L14_35, L15_36 in L11_32(L12_33) do
    L16_37 = L8_29
    L16_37(L15_36, false)
  end
  L11_32(L12_33, L13_34)
  L11_32(L12_33, L13_34)
  if L11_32 then
    L14_35 = false
    L12_33(L13_34, L14_35)
  end
  function L14_35()
    if _UPVALUE0_ then
      return
    end
    _UPVALUE0_ = true
    _UPVALUE1_:RemoveAnimation()
    Logic:Get("BGSound"):stopAllEffect()
    Logic:Get("BGSound"):PlayBGMusic()
    if _UPVALUE2_ then
      _UPVALUE2_()
    end
  end
  function L15_36()
    _UPVALUE0_()
  end
  L12_33.onClose = L15_36
  L16_37 = L6_27
  L15_36 = L6_27.SetCloseCallback
  L15_36(L16_37, L12_33, L12_33.onClose)
  L16_37 = L6_27
  L15_36 = L6_27.SetWaitSignByDefaultAniName
  L15_36(L16_37, function()
    local L0_50, L1_51, L2_52, L3_53, L4_54, L5_55, L6_56, L7_57, L8_58, L9_59
    L0_50 = Logic
    L1_51 = L0_50
    L0_50 = L0_50.Get
    L2_52 = "BGSound"
    L0_50 = L0_50(L1_51, L2_52)
    L1_51 = L0_50
    L0_50 = L0_50.PlayEffect
    L2_52 = "audio/heroupgrade.mp3"
    L0_50(L1_51, L2_52)
    L0_50 = _UPVALUE0_
    L1_51 = "imgGai"
    L2_52 = false
    L0_50(L1_51, L2_52)
    L0_50 = _UPVALUE0_
    L1_51 = "imgBody"
    L2_52 = false
    L0_50(L1_51, L2_52)
    L0_50 = _UPVALUE1_
    if L0_50 then
      L0_50 = tonumber
      L1_51 = _UPVALUE1_
      L1_51 = L1_51.settingId
      L0_50 = L0_50(L1_51)
    end
    L1_51 = _UPVALUE1_
    if L1_51 then
      L1_51 = tonumber
      L2_52 = _UPVALUE1_
      L2_52 = L2_52.level
      L1_51 = L1_51(L2_52)
    else
      L1_51 = L1_51 or 1
    end
    L2_52 = _UPVALUE1_
    if L2_52 then
      L2_52 = tonumber
      L3_53 = _UPVALUE1_
      L3_53 = L3_53.life
      L2_52 = L2_52(L3_53)
    end
    L3_53 = _UPVALUE1_
    if L3_53 then
      L3_53 = tonumber
      L3_53 = L3_53(L4_54)
    end
    if (L2_52 == nil or L3_53 == nil) and L0_50 then
      L5_55.settingId = L0_50
      L5_55.baseId = L0_50
      L5_55.level = L1_51
      L3_53 = L5_55
      L2_52 = L4_54
    end
    L2_52 = L2_52 or 0
    L3_53 = L3_53 or 0
    for L7_57, L8_58 in L4_54(L5_55) do
      L9_59 = _UPVALUE0_
      L9_59(L8_58, true)
    end
    L7_57 = "staLife"
    if L4_54 then
      L7_57 = L4_54.create
      if L7_57 then
        L8_58 = L4_54
        L7_57 = L4_54.create
        L9_59 = L1_51
        L7_57(L8_58, L9_59)
      end
    elseif L4_54 then
      L7_57 = L4_54.setString
      if L7_57 then
        L8_58 = L4_54
        L7_57 = L4_54.setString
        L9_59 = tostring
        L9_59 = L9_59(L1_51)
        L7_57(L8_58, L9_59, L9_59(L1_51))
      end
    end
    if L5_55 then
      L7_57 = L5_55.create
      if L7_57 then
        L8_58 = L5_55
        L7_57 = L5_55.create
        L9_59 = L3_53
        L7_57(L8_58, L9_59)
      end
    elseif L5_55 then
      L7_57 = L5_55.setString
      if L7_57 then
        L8_58 = L5_55
        L7_57 = L5_55.setString
        L9_59 = tostring
        L9_59 = L9_59(L3_53)
        L7_57(L8_58, L9_59, L9_59(L3_53))
      end
    end
    if L6_56 then
      L7_57 = L6_56.create
      if L7_57 then
        L8_58 = L6_56
        L7_57 = L6_56.create
        L9_59 = L2_52
        L7_57(L8_58, L9_59)
      end
    elseif L6_56 then
      L7_57 = L6_56.setString
      if L7_57 then
        L8_58 = L6_56
        L7_57 = L6_56.setString
        L9_59 = tostring
        L9_59 = L9_59(L2_52)
        L7_57(L8_58, L9_59, L9_59(L2_52))
      end
    end
    L7_57 = _UPVALUE4_
    if L7_57 then
      L7_57 = _UPVALUE4_
      L8_58 = L7_57
      L7_57 = L7_57.setEnabled
      L9_59 = true
      L7_57(L8_58, L9_59)
    end
    L7_57 = _UPVALUE3_
    L8_58 = "ttfGoOn"
    L7_57 = L7_57(L8_58)
    L8_58 = CCSprite
    L9_59 = L8_58
    L8_58 = L8_58.create
    L8_58 = L8_58(L9_59, "images/font/click_go_on.png")
    if L8_58 ~= nil then
      L9_59 = _UPVALUE5_
      L9_59 = L9_59.GetLayer
      if L9_59 then
        L9_59 = _UPVALUE5_
        L9_59 = L9_59.GetLayer
        L9_59 = L9_59(L9_59)
        L9_59 = L9_59.addChild
        L9_59(L9_59, L8_58, 0, 10)
        L9_59 = Logic
        L9_59 = L9_59.Get
        L9_59 = L9_59(L9_59, "Gift")
        L9_59 = L9_59.fadetoSpr
        L9_59 = L9_59(L9_59)
        L8_58:runAction(CCRepeatForever:create(L9_59))
        if L7_57 then
          L8_58:setPosition(L7_57:getPosition())
          L7_57:setVisible(false)
        end
      end
    elseif L7_57 then
      L9_59 = L7_57.setString
      if L9_59 then
        L9_59 = L7_57.setString
        L9_59(L7_57, "\231\130\185\229\135\187\231\187\167\231\187\173")
      end
    end
  end, 5000)
  L16_37 = L6_27
  L15_36 = L6_27.RunAnimationWithoutWait
  L15_36(L16_37)
end
function DisplayBaseIdOf(A0_60)
  return _UPVALUE0_(A0_60)
end
function RedDisplayBaseId(A0_61)
  local L1_62
  L1_62 = ADVANCE_RED
  L1_62 = L1_62[tonumber(A0_61)]
  if L1_62 == nil then
    return nil
  end
  return KFDBGetRecord("TalismanSetting", L1_62) and KFDBGetRecord("TalismanSetting", L1_62).baseId or L1_62
end
function OpenTalismanDetail(A0_63)
  local L1_64
  if A0_63 == nil then
    return
  end
  L1_64 = A0_63.settingId
  L1_64 = L1_64 or A0_63.baseId
  Logic:Get("HeroCardInfo"):OpenTailsman({
    id = A0_63.id,
    baseId = L1_64,
    level = A0_63.level or 1,
    exp = A0_63.exp or 0
  })
end
function GetSelect()
  local L0_65
  L0_65 = _UPVALUE0_
  if L0_65 == "material" then
    L0_65 = _UPVALUE1_
    L0_65 = L0_65[_UPVALUE2_]
    return L0_65
  end
  L0_65 = _UPVALUE0_
  if L0_65 ~= "advanceMaterial" then
    L0_65 = _UPVALUE0_
  elseif L0_65 == "advanceSource" then
    L0_65 = _UPVALUE3_
    return L0_65
  end
  L0_65 = _UPVALUE4_
  return L0_65
end
function SetPickMode(A0_66, A1_67)
  local L2_68
  L2_68 = A0_66 or "source"
  _UPVALUE0_ = L2_68
  L2_68 = A1_67 or 1
  _UPVALUE1_ = L2_68
end
function SetSelect(A0_69)
  local L1_70
  _UPVALUE0_ = A0_69
  L1_70 = _UPVALUE1_
  if L1_70 == "material" then
    L1_70 = _UPVALUE2_
    L1_70[_UPVALUE3_] = A0_69
  else
    L1_70 = _UPVALUE1_
    if L1_70 == "advanceMaterial" then
      _UPVALUE0_ = A0_69
    else
      L1_70 = _UPVALUE1_
      if L1_70 ~= "advanceSource" then
        _UPVALUE4_ = A0_69
        L1_70 = {
          nil,
          nil,
          nil,
          nil,
          nil
        }
        _UPVALUE2_ = L1_70
      end
    end
  end
end
function ClearSelect()
  local L0_71
  _UPVALUE0_ = L0_71
  L0_71 = {
    nil,
    nil,
    nil,
    nil,
    nil
  }
  _UPVALUE1_ = L0_71
  L0_71 = "source"
  _UPVALUE2_ = L0_71
  L0_71 = 1
  _UPVALUE3_ = L0_71
end
function GetMaterialProgress(A0_72)
  if A0_72 == nil or A0_72.advanced == true then
    return 0
  end
  if tonumber(A0_72.settingId or A0_72.baseId) == BROKEN_WEAPON_ID then
    return BROKEN_WEAPON_PROGRESS
  end
  if tonumber(A0_72.settingId or A0_72.baseId) == 501 or tonumber(A0_72.settingId or A0_72.baseId) == 502 or tonumber(A0_72.settingId or A0_72.baseId) == 503 then
    return 1200
  end
  if tonumber(A0_72.settingId or A0_72.baseId) == 521 or tonumber(A0_72.settingId or A0_72.baseId) == 522 or tonumber(A0_72.settingId or A0_72.baseId) == 523 then
    return 2000
  end
  return 0
end
function GetAdvanceSwallowList()
  local L0_73, L1_74, L2_75, L3_76, L4_77, L5_78, L6_79, L7_80, L8_81
  L0_73 = {}
  L1_74 = Logic
  L2_75 = L1_74
  L1_74 = L1_74.Get
  L3_76 = "Talisman"
  L1_74 = L1_74(L2_75, L3_76)
  L3_76 = L1_74
  L2_75 = L1_74.GetUpgradeFabao
  L2_75 = L2_75(L3_76)
  L3_76 = L2_75 and L2_75.id
  for L7_80, L8_81 in L4_77(L5_78) do
    if L8_81.equipHero == nil and L8_81.id ~= L3_76 and GetMaterialProgress(L8_81) > 0 then
      L8_81.progressValue = GetMaterialProgress(L8_81)
      table.insert(L0_73, L8_81)
    end
  end
  return L0_73
end
function GetAdvanceRequirement(A0_82)
  local L1_83
  L1_83 = ADVANCE_TARGETS
  L1_83 = L1_83[tonumber(A0_82)]
  return L1_83 and L1_83.progress or 0
end
function GetLifeAttack(A0_84)
  local L1_85, L2_86
  if A0_84 == nil then
    L1_85 = 0
    L2_86 = 0
    return L1_85, L2_86
  end
  L1_85 = A0_84.settingId
  L1_85 = L1_85 or A0_84.baseId
  L2_86 = tostring
  L2_86 = L2_86(L1_85 .. "_" .. (A0_84.level or 1))
  return Logic:Get("Talisman"):GetTaIlsmanLife(L2_86) or 0, Logic:Get("Talisman"):GetTaIlsmanAttack(L2_86) or 0
end
function GetAdvanceSourceList()
  local L0_87, L1_88, L2_89, L3_90, L4_91, L5_92, L6_93
  L0_87 = {}
  L1_88 = Logic
  L1_88 = L1_88.Get
  L1_88 = L1_88(L2_89, L3_90)
  for L5_92, L6_93 in L2_89(L3_90) do
    if L6_93.equipHero == nil and ADVANCE_TARGETS[tonumber(L6_93.baseId)] and L6_93.advanced ~= true and (L6_93.quality == nil or L6_93.quality == "orange") then
      if (L6_93.level or 0) >= 10 then
        table.insert(L0_87, _UPVALUE0_(L6_93))
      end
    end
  end
  return L0_87
end
function GetSelectList()
  local L0_94, L1_95, L2_96, L3_97, L4_98, L5_99, L6_100, L7_101, L8_102
  L0_94 = Logic
  L1_95 = L0_94
  L0_94 = L0_94.Get
  L0_94 = L0_94(L1_95, L2_96)
  L1_95 = L0_94.advanceMode
  if L1_95 == true then
    L1_95 = _UPVALUE0_
    if L1_95 ~= "advanceSource" then
      L1_95 = "advanceMaterial"
      _UPVALUE0_ = L1_95
    end
  end
  L1_95 = _UPVALUE0_
  if L1_95 == "advanceSource" then
    L1_95 = GetAdvanceSourceList
    return L1_95()
  end
  L1_95 = {}
  if L2_96 == "advanceMaterial" then
    for L7_101, L8_102 in L4_98(L5_99) do
      if L8_102 and L8_102.id then
        L2_96[L8_102.id] = true
      end
    end
    L8_102 = L5_99()
    for L7_101, L8_102 in L4_98(L5_99, L6_100, L7_101, L8_102, L5_99()) do
      if L8_102 and not L2_96[L8_102.id] then
        table.insert(L1_95, _UPVALUE1_(L8_102))
      end
    end
    return L1_95
  end
  if L2_96 == "material" then
    if L2_96 == nil then
      return L1_95
    end
    if L4_98 then
      L3_97[L4_98] = true
    end
    for L7_101 = 1, 2 do
      L8_102 = _UPVALUE3_
      if L7_101 ~= L8_102 then
        L8_102 = _UPVALUE4_
        L8_102 = L8_102[L7_101]
        if L8_102 then
          L8_102 = _UPVALUE4_
          L8_102 = L8_102[L7_101]
          L8_102 = L8_102.id
          L3_97[L8_102] = true
        end
      end
    end
    for L7_101, L8_102 in L4_98(L5_99) do
      if L8_102.equipHero == nil and not L3_97[L8_102.id] and GetSpec(L8_102.baseId) and GetSpec(L8_102.baseId).isOld and GetSpec(L8_102.baseId).family == L2_96.family then
        if (L8_102.quality or "orange") == "orange" then
          table.insert(L1_95, _UPVALUE1_(L8_102))
        end
      end
    end
    return L1_95
  end
  for L5_99, L6_100 in L2_96(L3_97) do
    L7_101 = GetSpec
    L8_102 = L6_100.baseId
    L7_101 = L7_101(L8_102)
    L8_102 = L6_100.equipHero
    if L8_102 == nil and L7_101 then
      L8_102 = L7_101.isOld
      if L8_102 then
        L8_102 = _UPVALUE1_
        L8_102 = L8_102(L6_100)
        L8_102.sort = _UPVALUE2_ and _UPVALUE2_.id == L6_100.id and 1 or 2
        table.insert(L1_95, L8_102)
      end
    end
  end
  L2_96(L3_97, L4_98)
  return L1_95
end
function FindMaterials(A0_103)
  local L1_104, L2_105, L3_106, L4_107, L5_108, L6_109, L7_110, L8_111
  L1_104 = {}
  L2_105 = A0_103 and L2_105(L3_106)
  if L2_105 == nil then
    return L1_104
  end
  L3_106 = Logic
  L3_106 = L3_106.Get
  L3_106 = L3_106(L4_107, L5_108)
  for L7_110, L8_111 in L4_107(L5_108) do
    if #L1_104 < 2 and L8_111.equipHero == nil and L8_111.id ~= A0_103.id and GetSpec(L8_111.baseId) and GetSpec(L8_111.baseId).isOld and GetSpec(L8_111.baseId).family == L2_105.family then
      if (L8_111.quality or "orange") == "orange" then
        table.insert(L1_104, _UPVALUE0_(L8_111))
      end
    end
  end
  return L1_104
end
function prototype.initialize(A0_112)
  super.initialize(A0_112)
end
function prototype.onNodeLoaded(A0_113, A1_114, A2_115)
end
function prototype.bindAnimationMgr(A0_116)
  local L1_117
  L1_117 = true
  return L1_117
end
function prototype.completedAnimationSequenceNamed(A0_118, A1_119)
end
function prototype.onEnter(A0_120)
  super.onEnter(A0_120)
  if A0_120.imgArrowHead then
    A0_120.imgArrowHead:setVisible(false)
  end
  A0_120:setupConvertUi()
  Logic:Get("Compose"):On(Logic.Compose.EVT.SELECT_CARD, A0_120:Event("onSelectCard"))
  Logic:Get("Talisman"):On(Logic.Talisman.EVT.CHANGE_UPDATE_STATE, A0_120:Event("onConvertDone"))
  A0_120:refreshConvert()
end
function prototype.onConvertDone(A0_121)
  local L1_122
  function L1_122()
    ClearSelect()
    _UPVALUE0_:refreshConvert()
  end
  if A0_121.pendingConvertAni then
    A0_121.pendingConvertAni = nil
    PlaySuccessAni(A0_121.pendingConvertAni.inBaseId, A0_121.pendingConvertAni.outBaseId, A0_121.pendingConvertAni.materials, {
      settingId = A0_121.pendingConvertAni.settingId,
      level = A0_121.pendingConvertAni.level or 1,
      life = GetLifeAttack({
        settingId = A0_121.pendingConvertAni.settingId,
        baseId = A0_121.pendingConvertAni.settingId,
        level = A0_121.pendingConvertAni.level or 1
      })
    }, L1_122)
    return
  end
  L1_122()
end
function prototype.onExit(A0_123)
  ClearSelect()
  Logic:Get("Compose"):SetSelectCard(nil)
  Logic:Get("Compose"):SetTargetCard(nil)
end
function prototype.setupConvertUi(A0_124)
  local L1_125, L2_126, L3_127, L4_128, L5_129, L6_130, L7_131
  L2_126 = A0_124
  L1_125 = A0_124.addConvertTitle
  L1_125(L2_126)
  L2_126 = A0_124
  L1_125 = A0_124.hideLeaderRow
  L1_125(L2_126)
  L1_125 = A0_124["cost:"]
  if L1_125 then
    L1_125 = A0_124["cost:"]
    L2_126 = L1_125
    L1_125 = L1_125.setVisible
    L1_125(L2_126, L3_127)
  end
  L1_125 = A0_124.costMoneyTitle
  if L1_125 then
    L1_125 = A0_124.costMoneyTitle
    L2_126 = L1_125
    L1_125 = L1_125.setVisible
    L1_125(L2_126, L3_127)
    L1_125 = A0_124.costMoneyTitle
    L2_126 = L1_125
    L1_125 = L1_125.setStyle
    L6_130 = 0
    L7_131 = 0
    L7_131 = L4_128(L5_129, L6_130, L7_131)
    L1_125(L2_126, L3_127, L4_128, L5_129, L6_130, L7_131, L4_128(L5_129, L6_130, L7_131))
    L1_125 = A0_124.costMoneyTitle
    L2_126 = L1_125
    L1_125 = L1_125.setString
    L7_131 = L3_127(L4_128)
    L1_125(L2_126, L3_127, L4_128, L5_129, L6_130, L7_131, L3_127(L4_128))
  end
  L1_125 = A0_124.costMoney
  if L1_125 then
    L1_125 = A0_124.costMoney
    L2_126 = L1_125
    L1_125 = L1_125.setVisible
    L1_125(L2_126, L3_127)
    L1_125 = A0_124.costMoney
    L2_126 = L1_125
    L1_125 = L1_125.setStyle
    L6_130 = 0
    L7_131 = 0
    L7_131 = L4_128(L5_129, L6_130, L7_131)
    L1_125(L2_126, L3_127, L4_128, L5_129, L6_130, L7_131, L4_128(L5_129, L6_130, L7_131))
    L1_125 = A0_124.costMoney
    L2_126 = L1_125
    L1_125 = L1_125.setString
    L1_125(L2_126, L3_127)
    L1_125 = A0_124.costMoney
    L2_126 = L1_125
    L1_125 = L1_125.setColor
    L6_130 = 0
    L7_131 = L3_127(L4_128, L5_129, L6_130)
    L1_125(L2_126, L3_127, L4_128, L5_129, L6_130, L7_131, L3_127(L4_128, L5_129, L6_130))
  end
  L1_125 = A0_124.evolutionFunctionSprite
  L1_125 = L1_125 or A0_124.btnEvolutionFunction
  L2_126 = Logic
  L2_126 = L2_126.Get
  L2_126 = L2_126(L3_127, L4_128)
  L2_126 = L2_126.GetPlayerLevel
  L2_126 = L2_126(L3_127)
  L2_126 = L2_126 or 1
  L2_126 = L2_126 >= L3_127
  if L3_127 then
    L3_127(L4_128, L5_129)
    L3_127(L4_128, L5_129)
  end
  if L3_127 then
    L3_127(L4_128, L5_129)
  end
  if L2_126 then
    L6_130 = "\230\179\149\229\174\157\232\191\155\233\152\182"
    L7_131 = 28
    L3_127(L4_128, L5_129, L6_130, L7_131, 80)
  end
  if L3_127 then
    L3_127(L4_128, L5_129)
  end
  if L3_127 then
    L3_127(L4_128, L5_129)
  end
  if L3_127 then
    L3_127(L4_128, L5_129)
  end
  for L6_130 = 1, 5 do
    L7_131 = L6_130 <= 2
    if A0_124[_UPVALUE0_[L6_130]] then
      A0_124[_UPVALUE0_[L6_130]]:setVisible(L7_131)
      A0_124[_UPVALUE0_[L6_130]]:setEnabled(false)
    end
    if A0_124[_UPVALUE1_[L6_130]] then
      A0_124[_UPVALUE1_[L6_130]]:setVisible(L7_131)
    end
    if A0_124[_UPVALUE2_[L6_130]] then
      A0_124[_UPVALUE2_[L6_130]]:setVisible(L7_131)
    end
    if A0_124[_UPVALUE3_[L6_130]] then
      A0_124[_UPVALUE3_[L6_130]]:setStyle(kCCLabelTTFStyleOutline, ccc3(0, 0, 0))
      A0_124[_UPVALUE3_[L6_130]]:setString("\230\157\144\230\150\153\228\184\141\232\182\179")
      A0_124[_UPVALUE3_[L6_130]]:setVisible(false)
    end
  end
  if L3_127 then
    L3_127(L4_128, L5_129)
  end
end
function prototype.hideLeaderRow(A0_132)
  local L1_133, L2_134
  L1_133 = A0_132.lLeaderTitle
  if L1_133 then
    L1_133 = A0_132.lLeaderTitle
    L2_134 = L1_133
    L1_133 = L1_133.setVisible
    L1_133(L2_134, false)
  end
  L1_133 = A0_132.rLeaderTitle
  if L1_133 then
    L1_133 = A0_132.rLeaderTitle
    L2_134 = L1_133
    L1_133 = L1_133.setVisible
    L1_133(L2_134, false)
  end
  L1_133 = A0_132.layer
  L1_133 = L1_133 or A0_132.rootNode
  if L1_133 == nil then
    return
  end
  function L2_134(A0_135)
    local L1_136, L2_137
    if A0_135 == nil then
      return
    end
    L1_136 = A0_135.getString
    if L1_136 then
      L1_136 = pcall
      L1_136 = L1_136(L2_137)
      if L1_136 and L2_137 and string.find(L2_137, "\231\187\159\229\190\161", 1, true) then
        A0_135:setVisible(false)
      end
    end
    L1_136 = A0_135.getChildren
    if L1_136 then
      L1_136 = A0_135.getChildren
      L1_136 = L1_136(L2_137)
    end
    if L1_136 then
      if L2_137 then
        for _FORV_5_ = 1, L1_136:count() do
          _UPVALUE0_(tolua.cast(L1_136:objectAtIndex(_FORV_5_ - 1), "CCNode"))
        end
      end
    end
  end
  L2_134(L1_133)
end
function prototype.putCaption(A0_138, A1_139, A2_140, A3_141)
  A0_138:putCaptionOnHost(A1_139, A2_140, A3_141, 40)
end
function prototype.putCaptionOnHost(A0_142, A1_143, A2_144, A3_145, A4_146)
  local L5_147, L6_148, L7_149
  if A1_143 == nil then
    return
  end
  L5_147 = A1_143.getParent
  if L5_147 then
    L6_148 = A1_143
    L5_147 = A1_143.getParent
    L5_147 = L5_147(L6_148)
  elseif not L5_147 then
    L5_147 = A0_142.layer
    L5_147 = L5_147 or A0_142.rootNode
  end
  if L5_147 == nil then
    return
  end
  L6_148 = A1_143.getPositionLua
  if L6_148 then
    L7_149 = A1_143
    L6_148 = A1_143.getPositionLua
    L6_148 = L6_148(L7_149)
  elseif not L6_148 then
    L6_148 = ccp
    L7_149 = 0
    L6_148 = L6_148(L7_149, 0)
  end
  L7_149 = CCLabelTTF
  L7_149 = L7_149.create
  L7_149 = L7_149(L7_149)
  L7_149:setString(A2_144)
  L7_149:setFontSize(A3_145 or 28)
  L7_149:setColor(ccc3(255, 220, 80))
  L7_149:setStyle(kCCLabelTTFStyleOutline, ccc3(0, 0, 0))
  L7_149:setAnchorPoint(ccp(0.5, 0.5))
  L7_149:setPosition(ccp(L6_148.x, L6_148.y))
  L5_147:addChild(L7_149, A4_146 or 80)
end
function prototype.addConvertTitle(A0_150)
  local L1_151, L2_152, L3_153
  L1_151 = A0_150.convertTitle
  if L1_151 then
    return
  end
  L1_151 = BannerTitlePosition
  L2_152 = A0_150
  L2_152 = L1_151(L2_152)
  if L1_151 == nil or L2_152 == nil then
    return
  end
  L3_153 = CCLabelTTF
  L3_153 = L3_153.create
  L3_153 = L3_153(L3_153)
  L3_153:setString("\230\179\149\229\174\157\232\189\172\230\141\162")
  L3_153:setFontSize(34)
  L3_153:setColor(ccc3(255, 220, 80))
  L3_153:setStyle(kCCLabelTTFStyleOutline, ccc3(0, 0, 0))
  L3_153:setAnchorPoint(ccp(0.5, 0.5))
  L3_153:setPosition(L2_152)
  L1_151:addChild(L3_153, 40)
  A0_150.convertTitle = L3_153
end
function prototype.clearCard(A0_154, A1_155)
  local L2_156
  L2_156 = A0_154.layer
  L2_156 = L2_156 or A0_154
  if L2_156 then
    L2_156:removeChildByTag(A1_155, true)
  end
end
function prototype.showCard(A0_157, A1_158, A2_159, A3_160)
  local L4_161
  L4_161 = A0_157.clearCard
  L4_161(A0_157, A1_158)
  if A2_159 == nil or A3_160 == nil then
    return
  end
  L4_161 = Logic
  L4_161 = L4_161.Get
  L4_161 = L4_161(L4_161, "HeroCardInfo")
  L4_161 = L4_161.createHeroCard
  L4_161 = L4_161(L4_161, A2_159, 200)
  if L4_161 == nil then
    return
  end
  L4_161:setAnchorPoint(ccp(0.5, 0.5))
  L4_161:setPosition(A3_160:getPosition())
  ;(A0_157.layer or A0_157):addChild(L4_161, 0, A1_158)
end
function prototype.setSlotIcon(A0_162, A1_163, A2_164)
  local L3_165, L4_166, L5_167, L6_168, L7_169, L8_170
  if A1_163 > 2 then
    L3_165 = _UPVALUE0_
    L3_165 = L3_165[A1_163]
    L3_165 = A0_162[L3_165]
    if L3_165 then
      L3_165 = _UPVALUE0_
      L3_165 = L3_165[A1_163]
      L3_165 = A0_162[L3_165]
      L4_166 = L3_165
      L3_165 = L3_165.setVisible
      L5_167 = false
      L3_165(L4_166, L5_167)
    end
    L3_165 = _UPVALUE1_
    L3_165 = L3_165[A1_163]
    L3_165 = A0_162[L3_165]
    if L3_165 then
      L3_165 = _UPVALUE1_
      L3_165 = L3_165[A1_163]
      L3_165 = A0_162[L3_165]
      L4_166 = L3_165
      L3_165 = L3_165.setVisible
      L5_167 = false
      L3_165(L4_166, L5_167)
    end
    L3_165 = _UPVALUE2_
    L3_165 = L3_165[A1_163]
    L3_165 = A0_162[L3_165]
    if L3_165 then
      L3_165 = _UPVALUE2_
      L3_165 = L3_165[A1_163]
      L3_165 = A0_162[L3_165]
      L4_166 = L3_165
      L3_165 = L3_165.setVisible
      L5_167 = false
      L3_165(L4_166, L5_167)
    end
    L3_165 = _UPVALUE3_
    L3_165 = L3_165[A1_163]
    L3_165 = A0_162[L3_165]
    if L3_165 then
      L3_165 = _UPVALUE3_
      L3_165 = L3_165[A1_163]
      L3_165 = A0_162[L3_165]
      L4_166 = L3_165
      L3_165 = L3_165.setVisible
      L5_167 = false
      L3_165(L4_166, L5_167)
    end
    return
  end
  L3_165 = _UPVALUE1_
  L3_165 = L3_165[A1_163]
  L4_166 = _UPVALUE2_
  L4_166 = L4_166[A1_163]
  L5_167 = _UPVALUE3_
  L5_167 = L5_167[A1_163]
  if A2_164 then
    L6_168 = A2_164.baseId
  elseif not L6_168 then
    L6_168 = _UPVALUE4_
    if L6_168 then
      L6_168 = _UPVALUE4_
      L6_168 = L6_168.baseId
    end
  end
  L7_169 = _UPVALUE5_
  L8_170 = _UPVALUE5_
  if _UPVALUE4_ ~= nil and L6_168 then
    L7_169 = Logic:Get("Hero"):GetHeroImage(L6_168) or L7_169
    L8_170 = Logic:Get("Hero"):GetHeroBgImage(L6_168) or L8_170
  end
  if CCSprite:create(L7_169) and A0_162[L3_165] then
    A0_162[L3_165]:setVisible(true)
    A0_162[L3_165]:setDisplayFrame(CCSprite:create(L7_169):displayFrame())
    A0_162[L3_165]:setAnchorPoint(ccp(0.5, 0.5))
  end
  if CCSprite:create(L8_170) and A0_162[L4_166] then
    A0_162[L4_166]:setVisible(true)
    A0_162[L4_166]:setDisplayFrame(CCSprite:create(L8_170):displayFrame())
    A0_162[L4_166]:setAnchorPoint(ccp(0.5, 0.5))
  end
  if A0_162[L5_167] then
    A0_162[L5_167]:setVisible(_UPVALUE4_ ~= nil and A2_164 == nil)
  end
end
function prototype.setStat(A0_171, A1_172, A2_173)
  if A1_172 then
    A1_172:setStyle(kCCLabelTTFStyleOutline)
    A1_172:setString(A2_173 or "")
  end
end
function prototype.refreshConvert(A0_174)
  local L1_175, L2_176, L3_177, L4_178
  L1_175(L2_176, L3_177)
  L1_175(L2_176, L3_177)
  for L4_178 = 1, 5 do
    A0_174:setSlotIcon(L4_178, _UPVALUE0_[L4_178])
  end
  L1_175(L2_176, L3_177, L4_178)
  L1_175(L2_176, L3_177, L4_178)
  L1_175(L2_176, L3_177, L4_178)
  L1_175(L2_176, L3_177, L4_178)
  L1_175(L2_176, L3_177, L4_178)
  L1_175(L2_176, L3_177, L4_178)
  if L1_175 then
    L1_175(L2_176, L3_177)
  end
  if L1_175 then
    L1_175(L2_176, L3_177)
  end
  if L1_175 then
    L1_175(L2_176, L3_177)
  end
  if L1_175 then
    L1_175(L2_176, L3_177)
  end
  if L1_175 == nil then
    if L1_175 then
      L1_175(L2_176, L3_177)
    end
    if L1_175 then
      L1_175(L2_176, L3_177)
    end
    for L4_178 = 1, 2 do
      if A0_174[_UPVALUE2_[L4_178]] then
        A0_174[_UPVALUE2_[L4_178]]:setEnabled(false)
      end
    end
    return
  end
  L2_176(L3_177, L4_178, _UPVALUE1_.baseId, A0_174.btnselecthero)
  if L1_175 then
    L2_176(L3_177, L4_178, L1_175.newDisplayBaseId, A0_174.btnright)
    if L2_176 then
      L2_176(L3_177, L4_178)
    end
  end
  if L2_176 then
    L2_176(L3_177, L4_178)
  end
  for _FORV_5_ = 1, 2 do
    if A0_174[_UPVALUE2_[_FORV_5_]] then
      A0_174[_UPVALUE2_[_FORV_5_]]:setEnabled(true)
    end
  end
  if L2_176 then
    L2_176(L3_177, L4_178)
  end
  if L2_176 then
    L2_176(L3_177, L4_178)
    L2_176(L3_177, L4_178, L4_178(30, 240, 0))
  end
  L4_178(A0_174, A0_174.lranktitle, tostring(_UPVALUE1_.level or 1))
  L4_178(A0_174, A0_174.lhealthtitle, tostring(L2_176 or ""))
  L4_178(A0_174, A0_174.lfighttitle, tostring(L3_177 or ""))
  if L1_175 then
    A0_174:setStat(A0_174.rranktitle, tostring(_UPVALUE1_.level or 1))
    A0_174:setStat(A0_174.rhealthtitle, tostring(L4_178 or ""))
    A0_174:setStat(A0_174.rfighttitle, tostring(L4_178({
      settingId = L1_175.newBaseId,
      baseId = L1_175.newBaseId,
      level = _UPVALUE1_.level or 1
    }) or ""))
  end
end
function prototype.onSelectCard(A0_179)
  A0_179:refreshConvert()
end
function prototype.openPick(A0_180, A1_181, A2_182)
  SetPickMode(A1_181, A2_182)
  SceneHelper:pushScene("FabaoTransSelect", A0_180.rootNode)
end
function prototype.onBtnReturn(A0_183, A1_184, A2_185)
  SceneHelper:runWithScene("ChipExchange", A0_183.rootNode)
end
function prototype.onBtnSelectHero(A0_186, A1_187, A2_188)
  A0_186:openPick("source", 1)
end
function prototype.openMaterial(A0_189, A1_190)
  if _UPVALUE0_ == nil then
    Prompt:Tip("\232\175\183\229\133\136\233\128\137\230\139\169\230\151\167\230\179\149\229\174\157")
    return
  end
  A0_189:openPick("material", A1_190)
end
function prototype.onBtnHelmet(A0_191, A1_192, A2_193)
  A0_191:openMaterial(1)
end
function prototype.onBtnArmour(A0_194, A1_195, A2_196)
  A0_194:openMaterial(2)
end
function prototype.onBtnGloves(A0_197, A1_198, A2_199)
  A0_197:openMaterial(3)
end
function prototype.onBtnTrousers(A0_200, A1_201, A2_202)
  A0_200:openMaterial(4)
end
function prototype.onBtnShose(A0_203, A1_204, A2_205)
  A0_203:openMaterial(5)
end
function prototype.onBtnRight(A0_206, A1_207, A2_208)
  if _UPVALUE0_ == nil then
    Prompt:Tip("\232\175\183\229\133\136\233\128\137\230\139\169\230\151\167\230\179\149\229\174\157")
    return
  end
  if GetSpec(_UPVALUE0_.settingId or _UPVALUE0_.baseId) == nil then
    return
  end
  OpenTalismanDetail({
    settingId = GetSpec(_UPVALUE0_.settingId or _UPVALUE0_.baseId).newBaseId,
    baseId = GetSpec(_UPVALUE0_.settingId or _UPVALUE0_.baseId).newBaseId,
    id = _UPVALUE0_.id,
    level = _UPVALUE0_.level or 1,
    exp = _UPVALUE0_.exp or 0
  })
end
function prototype.onBtnEvolutionFunction(A0_209, A1_210, A2_211)
  if (Logic:Get("PlayerInfo"):GetPlayerLevel() or 1) < ADVANCE_UNLOCK_LEVEL then
    Prompt:Tip(ADVANCE_UNLOCK_LEVEL .. "\231\186\167\229\188\128\230\148\190\230\179\149\229\174\157\232\191\155\233\152\182")
    return
  end
  SceneHelper:runWithScene("FabaoAdvance", A0_209.rootNode)
end
function prototype.onBtnBeginEvolution(A0_212, A1_213, A2_214)
  local L3_215, L4_216, L5_217
  L3_215 = _UPVALUE0_
  if L3_215 == nil then
    L3_215 = Prompt
    L4_216 = L3_215
    L3_215 = L3_215.Tip
    L3_215(L4_216, L5_217)
    return
  end
  L3_215 = GetSpec
  L4_216 = _UPVALUE0_
  L4_216 = L4_216.settingId
  L3_215 = L3_215(L4_216)
  if L3_215 ~= nil then
    L4_216 = L3_215.isOld
  elseif L4_216 ~= true then
    L4_216 = Prompt
    L4_216 = L4_216.Tip
    L4_216(L5_217, "\232\175\183\233\128\137\230\139\169\230\151\167\230\179\149\229\174\157")
    return
  end
  L4_216 = 0
  for _FORV_8_ = 1, 2 do
    if _UPVALUE1_[_FORV_8_] then
      L4_216 = L4_216 + 1
    end
  end
  if L4_216 < 2 then
    L5_217(L5_217, "\230\182\136\232\128\151\229\144\140\231\179\187\229\136\1512\228\184\170\230\151\167\230\169\153\232\137\178\230\179\149\229\174\157")
    return
  end
  for _FORV_9_ = 1, 2 do
    table.insert(L5_217, _UPVALUE1_[_FORV_9_].id)
  end
  _FOR_:Get("Talisman").pendingConvertIds = L5_217
  A0_212.pendingConvertAni = {
    inBaseId = L3_215.oldDisplayBaseId,
    outBaseId = L3_215.newDisplayBaseId,
    materials = {
      _UPVALUE1_[1],
      _UPVALUE1_[2]
    },
    settingId = L3_215.newBaseId,
    level = _UPVALUE0_.level or 1
  }
  MsgTalisman:Post("CONVERT_TALISMAN", {
    talismanId = _UPVALUE0_.id,
    talismanIds = L5_217
  })
end
