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
  A0_2.staHeart:setStyle(kCCLabelTTFStyleOutline)
  A0_2.staAttack:setStyle(kCCLabelTTFStyleOutline)
  A0_2.staPercent:setStyle(kCCLabelTTFStyleOutline)
end
function prototype.onBtnImage(A0_3)
  if not A0_3.fabao then
    return
  end
  if Logic:Get("Talisman").localAcceptance then
    Logic:Get("HeroCardInfo"):OpenTailsman(A0_3.fabao)
    return
  end
  if KFDBGetRecord("TalismanSetting", A0_3.fabao.baseId) ~= nil and KFDBGetRecord("TalismanSetting", A0_3.fabao.baseId).baseId ~= nil then
    Logic:Get("HeroCardInfo"):OpenTailsman(A0_3.fabao)
  end
end
function prototype.onBtnSelect(A0_4)
  local L1_5
  L1_5 = Logic
  L1_5 = L1_5.Get
  L1_5 = L1_5(L1_5, "Talisman")
  L1_5 = L1_5.advanceMode
  if L1_5 == true then
    L1_5 = require
    L1_5 = L1_5("FabaoTranslate")
    L1_5 = L1_5.GetMaterialProgress
    L1_5 = L1_5(A0_4.fabao)
    if (A0_4.fabao and A0_4.fabao.progressValue or L1_5) <= 0 then
      Prompt:Tip("\228\187\133\229\143\175\229\144\158\229\153\172\230\151\167\230\169\153\232\137\178\230\179\149\229\174\157")
      return
    end
  end
  L1_5 = CCSprite
  L1_5 = L1_5.create
  L1_5 = L1_5(L1_5, "images/public/selcet1.png")
  if Logic:Get("Talisman"):IsInTemFabao(A0_4.fabao) == false then
    L1_5 = CCSprite:create("images/public/selcet2.png")
    if L1_5 then
      A0_4.imgSelect:setDisplayFrame(L1_5:displayFrame())
    end
    Logic:Get("Talisman"):SetTemFabaos(A0_4.fabao)
  else
    L1_5 = CCSprite:create("images/public/selcet1.png")
    if L1_5 then
      A0_4.imgSelect:setDisplayFrame(L1_5:displayFrame())
    end
    Logic:Get("Talisman"):DeleteTemFabao(A0_4.fabao)
    if #Logic:Get("Talisman"):GetTemFabaos() == 0 then
      Logic:Get("Talisman"):HanSelectSwallFabao(0)
    else
      Logic:Get("Talisman"):HanSelectSwallFabao(1)
    end
  end
end
function prototype.onFabaoImage(A0_6)
  Logic:Get("HeroCardInfo"):OpenHeroInfo(A0_6.hero)
end
function prototype.clear(A0_7)
  A0_7.btnSelect:setEnabled(true)
  A0_7.staName:setString("")
  A0_7.staPercent:setString("")
  A0_7.imgSelect:setDisplayFrame(CCSprite:create("images/public/selcet1.png"):displayFrame())
end
function prototype.ReFrashInfo(A0_8, A1_9)
  local L2_10, L3_11, L4_12, L5_13, L6_14, L7_15, L8_16, L9_17, L10_18, L11_19, L12_20, L13_21, L14_22
  L3_11 = A0_8
  L2_10 = A0_8.clear
  L2_10(L3_11)
  if A1_9 ~= nil then
    L2_10 = table
    L2_10 = L2_10.empty
    L3_11 = A1_9
    L2_10 = L2_10(L3_11)
    if not L2_10 then
      L2_10 = A1_9.level
      if L2_10 ~= nil then
        L2_10 = A1_9.baseId
      end
    end
  elseif L2_10 == nil then
    return
  end
  L2_10 = Logic
  L3_11 = L2_10
  L2_10 = L2_10.Get
  L4_12 = "Talisman"
  L2_10 = L2_10(L3_11, L4_12)
  L3_11 = KFDBGetRecord
  L4_12 = "TalismanSetting"
  L5_13 = A1_9.baseId
  L3_11 = L3_11(L4_12, L5_13)
  L4_12 = L2_10.localAcceptance
  if L4_12 and L3_11 == nil then
    A0_8.fabao = A1_9
    L4_12 = A1_9.displayBaseId
    if L4_12 then
      L5_13 = Logic
      L6_14 = L5_13
      L5_13 = L5_13.Get
      L7_15 = "Hero"
      L5_13 = L5_13(L6_14, L7_15)
      L6_14 = L5_13
      L5_13 = L5_13.GetHeroImage
      L7_15 = L4_12
      L5_13 = L5_13(L6_14, L7_15)
      L6_14 = L5_13 and L6_14(L7_15, L8_16)
      if L6_14 then
        L7_15 = A0_8.imgFabao
        L8_16 = L7_15
        L7_15 = L7_15.setDisplayFrame
        L10_18 = L6_14
        L9_17 = L6_14.displayFrame
        L14_22 = L9_17(L10_18)
        L7_15(L8_16, L9_17, L10_18, L11_19, L12_20, L13_21, L14_22, L9_17(L10_18))
      end
      L7_15 = Logic
      L8_16 = L7_15
      L7_15 = L7_15.Get
      L9_17 = "Hero"
      L7_15 = L7_15(L8_16, L9_17)
      L8_16 = L7_15
      L7_15 = L7_15.GetHeroBgImage
      L9_17 = L4_12
      L7_15 = L7_15(L8_16, L9_17)
      L8_16 = L7_15 and L8_16(L9_17, L10_18)
      if L8_16 then
        L9_17 = A0_8.imgkuang
        L10_18 = L9_17
        L9_17 = L9_17.setDisplayFrame
        L12_20 = L8_16
        L11_19 = L8_16.displayFrame
        L14_22 = L11_19(L12_20)
        L9_17(L10_18, L11_19, L12_20, L13_21, L14_22, L11_19(L12_20))
      end
    end
    L5_13 = A0_8.staName
    L6_14 = L5_13
    L5_13 = L5_13.setString
    L7_15 = A1_9.name
    L7_15 = L7_15 or "\230\179\149\229\174\157"
    L5_13(L6_14, L7_15)
    L5_13 = A0_8.staLevel
    L6_14 = L5_13
    L5_13 = L5_13.create
    L7_15 = 0
    L8_16 = "YELLOW_E_NUM"
    L5_13(L6_14, L7_15, L8_16)
    L5_13 = A0_8.staLevel
    L6_14 = L5_13
    L5_13 = L5_13.setAlign
    L7_15 = "LEFT"
    L8_16 = "CENTER"
    L5_13(L6_14, L7_15, L8_16)
    L5_13 = A0_8.staLevel
    L6_14 = L5_13
    L5_13 = L5_13.setValue
    L7_15 = A1_9.level
    L7_15 = L7_15 or 1
    L5_13(L6_14, L7_15)
    L5_13 = A0_8.staPercent
    L6_14 = L5_13
    L5_13 = L5_13.setString
    L7_15 = "+"
    L8_16 = tostring
    L9_17 = A1_9.progressValue
    L9_17 = L9_17 or 0
    L8_16 = L8_16(L9_17)
    L9_17 = "\232\191\155\229\186\166"
    L7_15 = L7_15 .. L8_16 .. L9_17
    L5_13(L6_14, L7_15)
    L5_13 = A0_8.btnSelect
    L6_14 = L5_13
    L5_13 = L5_13.setEnabled
    L7_15 = true
    L5_13(L6_14, L7_15)
    return
  elseif L3_11 ~= nil then
    L4_12 = L3_11.baseId
  elseif L4_12 == nil then
    return
  end
  A0_8.fabao = A1_9
  L4_12 = CCSprite
  L5_13 = L4_12
  L4_12 = L4_12.create
  L6_14 = _UPVALUE0_
  L4_12 = L4_12(L5_13, L6_14)
  if L4_12 then
    L5_13 = A0_8.imgFabao
    L6_14 = L5_13
    L5_13 = L5_13.setDisplayFrame
    L8_16 = L4_12
    L7_15 = L4_12.displayFrame
    L14_22 = L7_15(L8_16)
    L5_13(L6_14, L7_15, L8_16, L9_17, L10_18, L11_19, L12_20, L13_21, L14_22, L7_15(L8_16))
    L5_13 = A0_8.imgkuang
    L6_14 = L5_13
    L5_13 = L5_13.setDisplayFrame
    L8_16 = L4_12
    L7_15 = L4_12.displayFrame
    L14_22 = L7_15(L8_16)
    L5_13(L6_14, L7_15, L8_16, L9_17, L10_18, L11_19, L12_20, L13_21, L14_22, L7_15(L8_16))
  end
  L5_13 = Logic
  L6_14 = L5_13
  L5_13 = L5_13.Get
  L7_15 = "Hero"
  L5_13 = L5_13(L6_14, L7_15)
  L6_14 = L5_13
  L5_13 = L5_13.GetHeroImage
  L7_15 = L3_11.baseId
  L5_13 = L5_13(L6_14, L7_15)
  L6_14 = CCSprite
  L7_15 = L6_14
  L6_14 = L6_14.create
  L8_16 = L5_13
  L6_14 = L6_14(L7_15, L8_16)
  if L6_14 then
    L7_15 = A0_8.imgFabao
    L8_16 = L7_15
    L7_15 = L7_15.setDisplayFrame
    L10_18 = L6_14
    L9_17 = L6_14.displayFrame
    L14_22 = L9_17(L10_18)
    L7_15(L8_16, L9_17, L10_18, L11_19, L12_20, L13_21, L14_22, L9_17(L10_18))
  end
  L7_15 = Logic
  L8_16 = L7_15
  L7_15 = L7_15.Get
  L9_17 = "Hero"
  L7_15 = L7_15(L8_16, L9_17)
  L8_16 = L7_15
  L7_15 = L7_15.GetHeroBgImage
  L9_17 = L3_11.baseId
  L7_15 = L7_15(L8_16, L9_17)
  L8_16 = CCSprite
  L9_17 = L8_16
  L8_16 = L8_16.create
  L10_18 = L7_15
  L8_16 = L8_16(L9_17, L10_18)
  if L8_16 then
    L9_17 = A0_8.imgkuang
    L10_18 = L9_17
    L9_17 = L9_17.setDisplayFrame
    L12_20 = L8_16
    L11_19 = L8_16.displayFrame
    L14_22 = L11_19(L12_20)
    L9_17(L10_18, L11_19, L12_20, L13_21, L14_22, L11_19(L12_20))
  end
  L9_17 = Logic
  L10_18 = L9_17
  L9_17 = L9_17.Get
  L11_19 = "Hero"
  L9_17 = L9_17(L10_18, L11_19)
  L10_18 = L9_17
  L9_17 = L9_17.GetHeroInfoByBaseId
  L11_19 = L3_11.baseId
  L9_17 = L9_17(L10_18, L11_19)
  L10_18 = A0_8.staName
  L11_19 = L10_18
  L10_18 = L10_18.setString
  L12_20 = L9_17.name
  L10_18(L11_19, L12_20)
  L10_18 = A0_8.staLevel
  L11_19 = L10_18
  L10_18 = L10_18.create
  L12_20 = 0
  L13_21 = "YELLOW_E_NUM"
  L10_18(L11_19, L12_20, L13_21)
  L10_18 = A0_8.staLevel
  L11_19 = L10_18
  L10_18 = L10_18.setAlign
  L12_20 = "LEFT"
  L13_21 = "CENTER"
  L10_18(L11_19, L12_20, L13_21)
  L10_18 = A0_8.staLevel
  L11_19 = L10_18
  L10_18 = L10_18.setValue
  L12_20 = A1_9.level
  L12_20 = L12_20 or 1
  L10_18(L11_19, L12_20)
  L10_18 = A1_9.baseId
  L11_19 = "_"
  L12_20 = A1_9.level
  L10_18 = L10_18 .. L11_19 .. L12_20
  L11_19 = Logic
  L12_20 = L11_19
  L11_19 = L11_19.Get
  L13_21 = "Talisman"
  L11_19 = L11_19(L12_20, L13_21)
  L12_20 = L11_19
  L11_19 = L11_19.GetTaIlsmanLife
  L13_21 = L10_18
  L11_19 = L11_19(L12_20, L13_21)
  if L11_19 then
    L12_20 = L3_11.race
    if L12_20 ~= "EXP_1" then
      L12_20 = A0_8.imgLife
      L13_21 = L12_20
      L12_20 = L12_20.setVisible
      L14_22 = true
      L12_20(L13_21, L14_22)
      L12_20 = A0_8.staHeart
      L13_21 = L12_20
      L12_20 = L12_20.setVisible
      L14_22 = true
      L12_20(L13_21, L14_22)
      L12_20 = A0_8.staHeart
      L13_21 = L12_20
      L12_20 = L12_20.setString
      L14_22 = L11_19
      L12_20(L13_21, L14_22)
    end
  else
    L12_20 = A0_8.imgLife
    L13_21 = L12_20
    L12_20 = L12_20.setVisible
    L14_22 = false
    L12_20(L13_21, L14_22)
    L12_20 = A0_8.staHeart
    L13_21 = L12_20
    L12_20 = L12_20.setVisible
    L14_22 = false
    L12_20(L13_21, L14_22)
  end
  L12_20 = Logic
  L13_21 = L12_20
  L12_20 = L12_20.Get
  L14_22 = "Talisman"
  L12_20 = L12_20(L13_21, L14_22)
  L13_21 = L12_20
  L12_20 = L12_20.GetTaIlsmanAttack
  L14_22 = L10_18
  L12_20 = L12_20(L13_21, L14_22)
  if L12_20 then
    L13_21 = L3_11.race
    if L13_21 ~= "EXP_1" then
      L13_21 = A0_8.imgAttack
      L14_22 = L13_21
      L13_21 = L13_21.setVisible
      L13_21(L14_22, true)
      L13_21 = A0_8.staAttack
      L14_22 = L13_21
      L13_21 = L13_21.setVisible
      L13_21(L14_22, true)
      L13_21 = A0_8.staAttack
      L14_22 = L13_21
      L13_21 = L13_21.setString
      L13_21(L14_22, L12_20)
    end
  else
    L13_21 = A0_8.imgAttack
    L14_22 = L13_21
    L13_21 = L13_21.setVisible
    L13_21(L14_22, false)
    L13_21 = A0_8.staAttack
    L14_22 = L13_21
    L13_21 = L13_21.setVisible
    L13_21(L14_22, false)
  end
  L13_21 = L2_10.advanceMode
  if L13_21 == true then
    L13_21 = require
    L14_22 = "FabaoTranslate"
    L13_21 = L13_21(L14_22)
    L13_21 = L13_21.GetMaterialProgress
    L14_22 = A1_9
    L13_21 = L13_21(L14_22)
    A1_9.progressValue = L13_21
    L14_22 = A0_8.staPercent
    L14_22 = L14_22.setString
    L14_22(L14_22, "+" .. tostring(L13_21) .. "\232\191\155\229\186\166")
  else
    L13_21 = KFDBGetRecord
    L14_22 = "TalismanLevelSetting"
    L13_21 = L13_21(L14_22, L10_18)
    if L13_21 ~= nil then
      L14_22 = L13_21.exp
    elseif L14_22 == nil then
      return
    end
    L14_22 = A1_9.exp
    L14_22 = L14_22 + L13_21.accumulateExp
    L14_22 = L14_22 * L13_21.factor
    A0_8.staPercent:setString(TwGetStr(112040, L14_22))
  end
  L13_21 = Logic
  L14_22 = L13_21
  L13_21 = L13_21.Get
  L13_21 = L13_21(L14_22, "Talisman")
  L14_22 = L13_21
  L13_21 = L13_21.GetUpgradeFabao
  L13_21 = L13_21(L14_22)
  if L13_21 then
    L14_22 = L13_21.id
    if L14_22 == A0_8.id then
      L14_22 = A0_8.btnSelect
      L14_22 = L14_22.setEnabled
      L14_22(L14_22, false)
      L14_22 = CCSprite
      L14_22 = L14_22.create
      L14_22 = L14_22(L14_22, "images/public/selcet3.png")
      if L14_22 then
        A0_8.imgSelect:setDisplayFrame(L14_22:displayFrame())
      end
      return
    end
  end
  L14_22 = Logic
  L14_22 = L14_22.Get
  L14_22 = L14_22(L14_22, "Talisman")
  L14_22 = L14_22.GetTemFabaos
  L14_22 = L14_22(L14_22)
  if Logic:Get("Talisman"):IsInTemFabao(A0_8.fabao) then
    if CCSprite:create("images/public/selcet2.png") then
      A0_8.imgSelect:setDisplayFrame(CCSprite:create("images/public/selcet2.png"):displayFrame())
    end
    A0_8.btnSelect:setEnabled(true)
  else
    if CCSprite:create("images/public/selcet1.png") then
      A0_8.imgSelect:setDisplayFrame(CCSprite:create("images/public/selcet1.png"):displayFrame())
    end
    A0_8.btnSelect:setEnabled(table.size(L14_22) < 6)
  end
end
function prototype.onWriteBand(A0_23, A1_24)
  local L2_25, L3_26, L4_27, L5_28
  if not A1_24 then
    return
  end
  for L5_28 = 1, #A1_24 do
    if A0_23[A1_24[L5_28]] then
      A0_23[A1_24[L5_28]]:setStyle(kCCLabelTTFStyleOutline)
    end
  end
end
