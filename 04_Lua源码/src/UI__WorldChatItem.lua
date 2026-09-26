local L0_0
L0_0 = module
L0_0((...), package.seeall)
L0_0 = Tw
L0_0 = L0_0.Controller
L0_0 = L0_0.prototype
L0_0 = L0_0.extend
L0_0 = L0_0(L0_0)
prototype = L0_0
L0_0 = 10
function prototype.onEnter(A0_1)
  local L1_2
end
function prototype.refreshInfo(A0_3, A1_4, A2_5)
  local L3_6, L4_7, L5_8, L6_9, L7_10, L8_11, L9_12, L10_13, L11_14, L12_15, L13_16, L14_17, L15_18, L16_19, L17_20, L18_21
  A0_3.info = A1_4
  A0_3.height = 0
  L3_6 = 0
  L4_7 = 0
  L5_8 = 0
  L6_9 = 0
  L7_10 = _UPVALUE0_
  L8_11 = A1_4.baseId
  L7_10 = L7_10(L8_11)
  A1_4.baseId = L7_10
  L7_10 = _UPVALUE0_
  L8_11 = A1_4.level
  L7_10 = L7_10(L8_11)
  A1_4.level = L7_10
  L7_10 = _UPVALUE0_
  L8_11 = A1_4.playerId
  L7_10 = L7_10(L8_11)
  A1_4.playerId = L7_10
  L7_10 = Logic
  L8_11 = L7_10
  L7_10 = L7_10.Get
  L9_12 = "Hero"
  L7_10 = L7_10(L8_11, L9_12)
  L8_11 = L7_10
  L7_10 = L7_10.GetHeroImage
  L9_12 = A1_4.baseId
  L7_10 = L7_10(L8_11, L9_12)
  L8_11 = CCSprite
  L9_12 = L8_11
  L8_11 = L8_11.create
  L10_13 = L7_10
  L8_11 = L8_11(L9_12, L10_13)
  if L8_11 then
    L9_12 = A0_3.fighterIcon
    L10_13 = L9_12
    L9_12 = L9_12.setDisplayFrame
    L12_15 = L8_11
    L11_14 = L8_11.displayFrame
    L18_21 = L11_14(L12_15)
    L9_12(L10_13, L11_14, L12_15, L13_16, L14_17, L15_18, L16_19, L17_20, L18_21, L11_14(L12_15))
  end
  L9_12 = Logic
  L10_13 = L9_12
  L9_12 = L9_12.Get
  L11_14 = "Hero"
  L9_12 = L9_12(L10_13, L11_14)
  L10_13 = L9_12
  L9_12 = L9_12.GetHeroBgImage
  L11_14 = A1_4.baseId
  L9_12 = L9_12(L10_13, L11_14)
  L10_13 = CCSprite
  L11_14 = L10_13
  L10_13 = L10_13.create
  L12_15 = L9_12
  L10_13 = L10_13(L11_14, L12_15)
  if L10_13 then
    L11_14 = A0_3.spriteRank
    L12_15 = L11_14
    L11_14 = L11_14.setDisplayFrame
    L14_17 = L10_13
    L13_16 = L10_13.displayFrame
    L18_21 = L13_16(L14_17)
    L11_14(L12_15, L13_16, L14_17, L15_18, L16_19, L17_20, L18_21, L13_16(L14_17))
  end
  L11_14 = Logic
  L12_15 = L11_14
  L11_14 = L11_14.Get
  L13_16 = "HeroCardInfo"
  L11_14 = L11_14(L12_15, L13_16)
  L12_15 = L11_14
  L11_14 = L11_14.AddShanCardSmall
  L13_16 = A0_3.fighterIcon
  L14_17 = A1_4.baseId
  L11_14(L12_15, L13_16, L14_17)
  L11_14 = A0_3.spriteRank
  L12_15 = L11_14
  L11_14 = L11_14.getContentSize
  L11_14 = L11_14(L12_15)
  L3_6 = L11_14.height
  L11_14 = A0_3.nodeLevel
  L12_15 = L11_14
  L11_14 = L11_14.create
  L13_16 = 0
  L14_17 = "YELLOW_E_NUM"
  L11_14(L12_15, L13_16, L14_17)
  L11_14 = A0_3.nodeLevel
  L12_15 = L11_14
  L11_14 = L11_14.setAlign
  L13_16 = "LEFT"
  L14_17 = "CENTER"
  L11_14(L12_15, L13_16, L14_17)
  L11_14 = A0_3.nodeLevel
  L12_15 = L11_14
  L11_14 = L11_14.setValue
  L13_16 = A1_4.level
  L11_14(L12_15, L13_16)
  L11_14 = A1_4.playerId
  L12_15 = Logic
  L13_16 = L12_15
  L12_15 = L12_15.Get
  L14_17 = "PlayerInfo"
  L12_15 = L12_15(L13_16, L14_17)
  L13_16 = L12_15
  L12_15 = L12_15.GetPlayerId
  L12_15 = L12_15(L13_16)
  if L11_14 == L12_15 then
    L11_14 = A0_3.staName
    L12_15 = L11_14
    L11_14 = L11_14.setColor
    L13_16 = ccColor3B
    L14_17 = 0
    L15_18 = 255
    L16_19 = 0
    L18_21 = L13_16(L14_17, L15_18, L16_19)
    L11_14(L12_15, L13_16, L14_17, L15_18, L16_19, L17_20, L18_21, L13_16(L14_17, L15_18, L16_19))
  else
    L11_14 = A0_3.staName
    L12_15 = L11_14
    L11_14 = L11_14.setColor
    L13_16 = ccColor3B
    L14_17 = 157
    L15_18 = 235
    L16_19 = 226
    L18_21 = L13_16(L14_17, L15_18, L16_19)
    L11_14(L12_15, L13_16, L14_17, L15_18, L16_19, L17_20, L18_21, L13_16(L14_17, L15_18, L16_19))
  end
  L11_14 = A0_3.staName
  L12_15 = L11_14
  L11_14 = L11_14.setString
  L13_16 = A1_4.name
  L11_14(L12_15, L13_16)
  L11_14 = A0_3.staName
  L12_15 = L11_14
  L11_14 = L11_14.getContentSize
  L11_14 = L11_14(L12_15)
  L4_7 = L11_14.height
  L11_14 = _UPVALUE0_
  L12_15 = A1_4.date
  L11_14 = L11_14(L12_15)
  L12_15 = Logic
  L13_16 = L12_15
  L12_15 = L12_15.Get
  L14_17 = "System"
  L12_15 = L12_15(L13_16, L14_17)
  L13_16 = L12_15
  L12_15 = L12_15.GetTimeDate
  L14_17 = L11_14 or 0
  L14_17 = L14_17 / 1000
  L12_15 = L12_15(L13_16, L14_17)
  if L12_15 then
    L13_16 = string
    L13_16 = L13_16.format
    L14_17 = "%02d/%02d %02d:%02d:%02d"
    L15_18 = L12_15.month
    L16_19 = L12_15.day
    L17_20 = L12_15.hour
    L18_21 = L12_15.min
    L13_16 = L13_16(L14_17, L15_18, L16_19, L17_20, L18_21, L12_15.sec)
    L14_17 = A0_3.staDate
    L15_18 = L14_17
    L14_17 = L14_17.setString
    L16_19 = L13_16
    L14_17(L15_18, L16_19)
  end
  L13_16 = A0_3.staDate
  L14_17 = L13_16
  L13_16 = L13_16.getContentSize
  L13_16 = L13_16(L14_17)
  L5_8 = L13_16.height
  L13_16 = A0_3.staShow
  L14_17 = L13_16
  L13_16 = L13_16.getPositionX
  L13_16 = L13_16(L14_17)
  L13_16 = A2_5 - L13_16
  L14_17 = _UPVALUE1_
  L13_16 = L13_16 - L14_17
  L14_17 = _UPVALUE2_
  L13_16 = L13_16 - L14_17
  L14_17 = A0_3.staShow
  L15_18 = L14_17
  L14_17 = L14_17.setString
  L16_19 = A1_4.message
  L14_17(L15_18, L16_19)
  L14_17 = A0_3.staShow
  L15_18 = L14_17
  L14_17 = L14_17.getContentSize
  L14_17 = L14_17(L15_18)
  L14_17 = L14_17.width
  if L13_16 < L14_17 then
    L14_17 = A0_3.staShow
    L15_18 = L14_17
    L14_17 = L14_17.setDimensions
    L16_19 = CCSize
    L17_20 = L13_16
    L18_21 = 0
    L18_21 = L16_19(L17_20, L18_21)
    L14_17(L15_18, L16_19, L17_20, L18_21, L16_19(L17_20, L18_21))
  end
  L14_17 = A0_3.staShow
  L15_18 = L14_17
  L14_17 = L14_17.getContentSize
  L14_17 = L14_17(L15_18)
  L14_17 = L14_17.height
  L15_18 = _UPVALUE1_
  L15_18 = 3 * L15_18
  L6_9 = L14_17 + L15_18
  L14_17 = L4_7 > L5_8 and L4_7 or L5_8
  L15_18 = L14_17 + L6_9
  L16_19 = _UPVALUE1_
  L14_17 = L15_18 + L16_19
  L15_18 = L3_6 < L14_17 and L14_17 or L3_6
  A0_3.height = L15_18
  L15_18 = A0_3.spriteRank
  L16_19 = L15_18
  L15_18 = L15_18.getPositionX
  L15_18 = L15_18(L16_19)
  L16_19 = A0_3.spriteRank
  L17_20 = L16_19
  L16_19 = L16_19.getPositionY
  L16_19 = L16_19(L17_20)
  L17_20 = nil
  L18_21 = A0_3.spriteRank
  L18_21 = L18_21.setPosition
  L18_21(L18_21, ccp(L15_18, A0_3.height))
  L18_21 = A0_3.fighterIcon
  L18_21 = L18_21.getPositionX
  L18_21 = L18_21(L18_21)
  L15_18 = L18_21
  L18_21 = A0_3.height
  L18_21 = L18_21 - L16_19
  L17_20 = L18_21 + A0_3.fighterIcon:getPositionY()
  L18_21 = A0_3.fighterIcon
  L18_21 = L18_21.setPosition
  L18_21(L18_21, ccp(L15_18, L17_20))
  L18_21 = A0_3.speLevel
  L18_21 = L18_21.getPositionX
  L18_21 = L18_21(L18_21)
  L15_18 = L18_21
  L18_21 = A0_3.height
  L18_21 = L18_21 - L16_19
  L17_20 = L18_21 + A0_3.speLevel:getPositionY()
  L18_21 = A0_3.speLevel
  L18_21 = L18_21.setPosition
  L18_21(L18_21, ccp(L15_18, L17_20))
  L18_21 = A0_3.nodeLevel
  L18_21 = L18_21.getPositionX
  L18_21 = L18_21(L18_21)
  L15_18 = L18_21
  L18_21 = A0_3.height
  L18_21 = L18_21 - L16_19
  L17_20 = L18_21 + A0_3.nodeLevel:getPositionY()
  L18_21 = A0_3.nodeLevel
  L18_21 = L18_21.setPosition
  L18_21(L18_21, ccp(L15_18, L17_20))
  L18_21 = A0_3.btnHeroImage
  L18_21 = L18_21.getPositionX
  L18_21 = L18_21(L18_21)
  L15_18 = L18_21
  L18_21 = A0_3.btnHeroImage
  L18_21 = L18_21.setPosition
  L18_21(L18_21, ccp(L15_18, A0_3.height))
  L18_21 = A0_3.staName
  L18_21 = L18_21.getPositionX
  L18_21 = L18_21(L18_21)
  L15_18 = L18_21
  L18_21 = A0_3.staName
  L18_21 = L18_21.setPosition
  L18_21(L18_21, ccp(L15_18, A0_3.height - _UPVALUE1_ / 2))
  L18_21 = A0_3.staDate
  L18_21 = L18_21.getPositionX
  L18_21 = L18_21(L18_21)
  L15_18 = L18_21
  L18_21 = A0_3.staDate
  L18_21 = L18_21.setPosition
  L18_21(L18_21, ccp(L15_18, A0_3.height - _UPVALUE1_ / 2))
  L18_21 = A0_3.staShow
  L18_21 = L18_21.getPositionX
  L18_21 = L18_21(L18_21)
  L18_21 = L18_21 - A0_3.spdBg:getPositionX()
  L18_21 = L18_21 + A0_3.spdBg:getContentSize().width / 2
  L18_21 = L18_21 + A0_3.staShow:getContentSize().width + _UPVALUE2_
  if not (L18_21 > 90) or not L18_21 then
    L18_21 = 90
  end
  A0_3.spdBg:setContentSize(CCSize(L18_21, L6_9))
  L15_18 = A0_3.staShow:getPositionX() + A0_3.spdBg:getContentSize().width / 2 - _UPVALUE2_
  L17_20 = L4_7 > L5_8 and L4_7 or L5_8
  L17_20 = A0_3.height - L17_20 - _UPVALUE1_
  A0_3.spdBg:setPosition(ccp(L15_18, L17_20 - A0_3.spdBg:getContentSize().height / 2))
  A0_3.sprTale:setPosition(ccp(A0_3.sprTale:getPositionX(), L17_20 - A0_3.spdBg:getContentSize().height / 2))
  L15_18 = A0_3.staShow:getPositionX()
  A0_3.staShow:setPosition(ccp(L15_18, L17_20 - A0_3.spdBg:getContentSize().height / 2 + A0_3.staShow:getContentSize().height / 2))
end
function prototype.getContentSizeH(A0_22)
  local L1_23
  L1_23 = A0_22.height
  return L1_23
end
function prototype.onBtnHeroImage(A0_24, A1_25, A2_26)
  local L3_27
  L3_27 = A0_24.info
  if L3_27 == nil then
    return
  end
  L3_27 = {}
  L3_27.level = A0_24.info.level or 1
  L3_27.baseId = A0_24.info.baseId or 1
  L3_27.powerSkill = tonumber(A0_24.info.skill) or 1
  Logic:Get("HeroCardInfo"):OpenHeroInfoByNparma(L3_27)
end
