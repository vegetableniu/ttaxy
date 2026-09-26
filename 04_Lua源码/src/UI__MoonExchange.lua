local L0_0
L0_0 = module
L0_0((...), package.seeall)
L0_0 = require
L0_0("SceneHelper")
L0_0 = require
L0_0("BtnPosition")
L0_0 = BtnPosition
L0_0 = L0_0.prototype
L0_0 = L0_0.extend
L0_0 = L0_0(L0_0)
prototype = L0_0
L0_0 = TypeDef
L0_0 = L0_0("com.eyu.mt.module.moon.model.MoonType")
function prototype.initialize(A0_1, ...)
  local L3_3, L4_4
  L3_3 = super
  L3_3 = L3_3.initialize
  L4_4 = A0_1
  L3_3(L4_4, ...)
end
function prototype.dispose(A0_5, ...)
  super.dispose(A0_5)
end
function prototype.onEnter(A0_7)
  super.onEnter(A0_7)
  A0_7.ttfTitle:setString(Logic:Get("Gift"):GetActivityGift().name)
  A0_7.ttfTitle:setStyle(kCCLabelTTFStyleOutline)
  A0_7:createLabel()
  A0_7:scrollViewCreate()
  A0_7:setAni()
  _UPVALUE0_():On(_UPVALUE1_().MOON_INFO, A0_7:Event("onMoonInfo"))
  _UPVALUE0_():On(_UPVALUE1_().EXHCNAGE, A0_7:Event("onExchange"))
  _UPVALUE0_():PostMoonInfo()
end
function prototype.onBtnRecharge(A0_8, A1_9, A2_10)
  Logic:Get("Main"):GotoRecharge()
end
function prototype.onBtnReturn(A0_11, A1_12, A2_13)
  SceneHelper:runWithScene("GiftActivityList", A0_11.rootNode)
end
function prototype.onBtnMakeMoon(A0_14, A1_15, A2_16)
  if table.empty(Logic:Get("Gift"):GetActivityByType("SPRING") or {}) then
    return
  end
  Logic:Get("Gift"):SetActivityGift(Logic:Get("Gift"):GetActivityByType("SPRING")[1])
  SceneHelper:runWithScene("Moon", A0_14.rootNode)
end
function prototype.onBtnExchange(A0_17, A1_18, A2_19)
  local L3_20, L4_21, L5_22, L6_23, L7_24, L8_25
  L3_20 = 4
  L4_21 = 0
  for L8_25 = 1, L3_20 do
    if A0_17["btnExchange" .. L8_25] == A1_18 then
      L4_21 = L8_25
      break
    end
  end
  L5_22(L6_23, L7_24)
  L8_25 = A0_17.rootNode
  L5_22(L6_23, L7_24, L8_25)
end
function prototype.onBtnHero(A0_26, A1_27, A2_28)
  local L3_29
  L3_29 = {}
  L3_29.exp = 0
  L3_29.id = 68719480211
  L3_29.level = 75
  L3_29.baseId = A0_26.currId or 1
  L3_29.powerSkill = 0
  Logic:Get("HeroCardInfo"):OpenHeroInfoByNparma(L3_29)
end
function prototype.setAni(A0_30)
  A0_30.showIds = json.decode((KFDBGetRecord("ConfigValue", "MOON:SHOW_BASEID") or {}).content or "[]") or {}
  A0_30.showIds = {6247, 6267}
  A0_30.currId = A0_30.showIds[1]
  if not A0_30.currId then
    return
  end
  if not A0_30.eventTracer:Exist("runAni") then
    Singleton(Timer):Repeat(2000, A0_30:Event("runAni"))
  end
  A0_30:runAni()
end
function prototype.runAni(A0_31)
  local L1_32, L2_33, L3_34, L4_35, L5_36
  L1_32 = A0_31.ani
  if L1_32 then
    L1_32 = A0_31.ani
    L2_33 = L1_32
    L1_32 = L1_32.RemoveAnimation
    L1_32(L2_33)
  end
  L1_32 = Logic
  L2_33 = L1_32
  L1_32 = L1_32.Get
  L3_34 = "AniMgr"
  L1_32 = L1_32(L2_33, L3_34)
  L2_33 = L1_32
  L1_32 = L1_32.NewCCB
  L3_34 = "UI/TURNCARD02"
  L4_35 = A0_31.nodAni
  L5_36 = ccp
  L5_36 = L5_36(0, 0)
  L1_32 = L1_32(L2_33, L3_34, L4_35, L5_36, 0, nil, nil)
  A0_31.ani = L1_32
  L1_32 = A0_31.ani
  L2_33 = L1_32
  L1_32 = L1_32.GetChild
  L3_34 = "sprFront"
  L1_32 = L1_32(L2_33, L3_34)
  L2_33 = A0_31.ani
  L3_34 = L2_33
  L2_33 = L2_33.GetChild
  L4_35 = "sprBack"
  L2_33 = L2_33(L3_34, L4_35)
  L3_34 = A0_31.showIds
  L3_34 = L3_34[1]
  L4_35 = A0_31.currId
  if L3_34 == L4_35 then
    L3_34 = A0_31.showIds
    L3_34 = L3_34[2]
  elseif not L3_34 then
    L3_34 = A0_31.showIds
    L3_34 = L3_34[1]
  end
  function L4_35(A0_37, A1_38)
    local L2_39, L3_40
    L2_39 = Logic
    L3_40 = L2_39
    L2_39 = L2_39.Get
    L2_39 = L2_39(L3_40, "HeroCardInfo")
    L3_40 = L2_39
    L2_39 = L2_39.GetSprCard
    L2_39 = L2_39(L3_40, A0_37)
    if L2_39 then
      L3_40 = Logic
      L3_40 = L3_40.Get
      L3_40 = L3_40(L3_40, "HeroCardInfo")
      L3_40 = L3_40.GetCardTexture
      L3_40 = L3_40(L3_40, L2_39)
      A1_38:setTexture(L3_40)
      A1_38:setTextureRect(L2_39:getTextureRect())
    end
  end
  L5_36 = L4_35
  L5_36(A0_31.currId, L1_32)
  L5_36 = L4_35
  L5_36(L3_34, L2_33)
  L5_36 = 200
  Logic:Get("HeroCardInfo"):AddShanCard(L1_32, A0_31.currId, L5_36)
  Logic:Get("HeroCardInfo"):AddShanCard(L2_33, L3_34, L5_36)
  if A0_31.ani then
    A0_31.ani:RunAni()
    A0_31.currId = L3_34
  end
end
function prototype.createLabel(A0_41)
  local L1_42, L2_43, L3_44, L4_45, L5_46, L6_47, L7_48, L8_49, L9_50, L10_51
  L2_43 = A0_41
  L1_42 = A0_41.createGroupList
  L1_42 = L1_42(L2_43)
  A0_41.groupList = L1_42
  L1_42 = 4
  L2_43 = "images/Moon/moonCake.png"
  for L6_47 = 1, L1_42 do
    L7_48 = string
    L7_48 = L7_48.format
    L8_49 = "nodCost%d"
    L9_50 = L6_47
    L7_48 = L7_48(L8_49, L9_50)
    L8_49 = string
    L8_49 = L8_49.format
    L9_50 = "imgCost%d"
    L10_51 = L6_47
    L8_49 = L8_49(L9_50, L10_51)
    L9_50 = json
    L9_50 = L9_50.decode
    L10_51 = A0_41.groupList
    L10_51 = L10_51[L6_47]
    L10_51 = L10_51.costs
    L10_51 = L10_51 or "[]"
    L9_50 = L9_50(L10_51)
    L9_50 = L9_50 or {}
    L10_51 = A0_41[L7_48]
    if L10_51 then
      L10_51 = A0_41[L7_48]
      L10_51 = L10_51.create
      L10_51(L10_51, 0, "GREEN_NUM")
      L10_51 = A0_41[L7_48]
      L10_51 = L10_51.setAlign
      L10_51(L10_51, "LEFT", "CENTER")
      L10_51 = 0
      if table.empty(L9_50) then
        L10_51 = A0_41.groupList[L6_47].count
        A0_41[L8_49]:setDisplayFrame(CCSprite:create(_UPVALUE0_):displayFrame())
        A0_41[L8_49]:setScale(0.8)
      else
        L10_51 = L9_50[1].amount
        A0_41[L8_49]:setDisplayFrame(CCSprite:create(L2_43):displayFrame())
        A0_41[L8_49]:setScale(1)
      end
      A0_41[L7_48]:setValue(L10_51)
    end
  end
  L6_47 = "GREEN_NUM"
  L3_44(L4_45, L5_46, L6_47)
  L6_47 = "CENTER"
  L3_44(L4_45, L5_46, L6_47)
end
function prototype.createGroupList(A0_52)
  local L1_53, L2_54, L3_55, L4_56, L5_57
  L1_53 = {}
  for L5_57 = 1, L3_55(L4_56) do
    if KFDBGetRecordByIdx("MoonExSetting", L5_57) and not L1_53[KFDBGetRecordByIdx("MoonExSetting", L5_57).group] then
      L1_53[KFDBGetRecordByIdx("MoonExSetting", L5_57).group] = KFDBGetRecordByIdx("MoonExSetting", L5_57)
    end
  end
  return L1_53
end
function prototype.scrollViewCreate(A0_58)
  local L1_59, L2_60
  L1_59 = Tw
  L1_59 = L1_59.Controller
  L2_60 = L1_59
  L1_59 = L1_59.load
  L1_59 = L1_59(L2_60, "MoonExchangeItem", A0_58.rootNode)
  L2_60 = CCScrollViewEx
  L2_60 = L2_60.create
  L2_60 = L2_60(L2_60, CCSizeMake(450, 32))
  L2_60:setDirection(kCCScrollViewDirectionHorizontal)
  L2_60:setClippingToBounds(true)
  L2_60:setTouchEnabled(false)
  L2_60:setContainer(L1_59)
  L2_60:updateInset()
  A0_58.scrollTag = L2_60:getTag()
  A0_58.nodAdv:addChild(L2_60)
end
function prototype.onMoonInfo(A0_61)
  A0_61:onExchange()
  if not tolua.cast(A0_61.nodAdv:getChildByTag(A0_61.scrollTag), "CCScrollViewEx") then
    return
  end
  tolua.cast(A0_61.nodAdv:getChildByTag(A0_61.scrollTag), "CCScrollViewEx"):getContainer():initRewards()
end
function prototype.onExchange(A0_62)
  A0_62.nodMoon:setValue(_UPVALUE0_():GetMoonCount()[_UPVALUE1_.MOON] or 0)
end
