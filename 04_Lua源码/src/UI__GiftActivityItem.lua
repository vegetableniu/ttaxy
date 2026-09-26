module((...), package.seeall)
prototype = Tw.Controller.prototype:extend()
require("SceneHelper")
function prototype.onEnter(A0_0)
  local L1_1
end
function prototype.ReFrashReward(A0_2, A1_3, A2_4)
  local L3_5, L4_6, L5_7, L6_8, L7_9
  L3_5 = CCSprite
  L4_6 = L3_5
  L3_5 = L3_5.create
  L5_7 = "images/public/clarity80.png"
  L3_5 = L3_5(L4_6, L5_7)
  if L3_5 ~= nil then
    L4_6 = A0_2.titleSpr
    L5_7 = L4_6
    L4_6 = L4_6.setDisplayFrame
    L7_9 = L3_5
    L6_8 = L3_5.displayFrame
    L7_9 = L6_8(L7_9)
    L4_6(L5_7, L6_8, L7_9, L6_8(L7_9))
  end
  if A1_3 == nil then
    return
  end
  A0_2.giftInfo = A1_3
  L4_6 = A0_2.today
  L5_7 = L4_6
  L4_6 = L4_6.setVisible
  L6_8 = false
  L4_6(L5_7, L6_8)
  L4_6 = A0_2.giftInfo
  L4_6 = L4_6.activityType
  if L4_6 == "CONSUME_RANK" then
    L4_6 = A0_2.today
    L5_7 = L4_6
    L4_6 = L4_6.setVisible
    L6_8 = true
    L4_6(L5_7, L6_8)
  end
  L5_7 = A0_2
  L4_6 = A0_2.TipGift
  L4_6(L5_7)
  L4_6 = A1_3.icon
  if L4_6 then
    L4_6 = A0_2.btnGo
    L5_7 = L4_6
    L4_6 = L4_6.setBackgroundSpriteForState
    L6_8 = CCScale9Sprite
    L7_9 = L6_8
    L6_8 = L6_8.create
    L6_8 = L6_8(L7_9, A1_3.icon)
    L7_9 = CCControlStateNormal
    L4_6(L5_7, L6_8, L7_9)
    L4_6 = A0_2.btnGo
    L5_7 = L4_6
    L4_6 = L4_6.setBackgroundSpriteForState
    L6_8 = CCScale9Sprite
    L7_9 = L6_8
    L6_8 = L6_8.create
    L6_8 = L6_8(L7_9, A1_3.icon)
    L7_9 = CCControlStateHighlighted
    L4_6(L5_7, L6_8, L7_9)
    L4_6 = A0_2.btnGo
    L5_7 = L4_6
    L4_6 = L4_6.setBackgroundSpriteForState
    L6_8 = CCScale9Sprite
    L7_9 = L6_8
    L6_8 = L6_8.create
    L6_8 = L6_8(L7_9, A1_3.icon)
    L7_9 = CCControlStateDisabled
    L4_6(L5_7, L6_8, L7_9)
  end
  L4_6 = A0_2.title_ttf
  L5_7 = L4_6
  L4_6 = L4_6.setColor
  L6_8 = ccc3
  L7_9 = 255
  L7_9 = L6_8(L7_9, 183, 18)
  L4_6(L5_7, L6_8, L7_9, L6_8(L7_9, 183, 18))
  L4_6 = A0_2.title_ttf
  L5_7 = L4_6
  L4_6 = L4_6.setString
  L6_8 = A1_3.name
  L4_6(L5_7, L6_8)
  L4_6 = A0_2.title_ttf
  L5_7 = L4_6
  L4_6 = L4_6.setStyle
  L6_8 = kCCLabelTTFStyleOutline
  L4_6(L5_7, L6_8)
  L4_6 = A0_2.ttfTime
  L5_7 = L4_6
  L4_6 = L4_6.setStyle
  L6_8 = kCCLabelTTFStyleOutline
  L4_6(L5_7, L6_8)
  L4_6 = A0_2.giftInfo
  L4_6 = L4_6.progressBanner
  if L4_6 then
    L4_6 = A0_2.ttfTime
    L5_7 = L4_6
    L4_6 = L4_6.setString
    L6_8 = "\230\176\184\228\185\133\230\156\137\230\149\136"
    L4_6(L5_7, L6_8)
    return
  end
  L4_6 = Logic
  L5_7 = L4_6
  L4_6 = L4_6.Get
  L6_8 = "System"
  L4_6 = L4_6(L5_7, L6_8)
  L5_7 = L4_6
  L4_6 = L4_6.SecToDay
  L6_8 = Logic
  L7_9 = L6_8
  L6_8 = L6_8.Get
  L6_8 = L6_8(L7_9, "System")
  L7_9 = L6_8
  L6_8 = L6_8.DiffTime
  L7_9 = L6_8(L7_9, A0_2.giftInfo.endTime / 1000, A0_2.giftInfo.startTime / 1000)
  L4_6 = L4_6(L5_7, L6_8, L7_9, L6_8(L7_9, A0_2.giftInfo.endTime / 1000, A0_2.giftInfo.startTime / 1000))
  L5_7 = L4_6.day
  if L5_7 <= 365 then
    L5_7 = TwGetStr
    L6_8 = 103088
    L5_7 = L5_7(L6_8)
    L6_8 = Logic
    L7_9 = L6_8
    L6_8 = L6_8.Get
    L6_8 = L6_8(L7_9, "System")
    L7_9 = L6_8
    L6_8 = L6_8.GetTimeStr
    L6_8 = L6_8(L7_9, L5_7, A1_3.startTime / 1000)
    L7_9 = Logic
    L7_9 = L7_9.Get
    L7_9 = L7_9(L7_9, "System")
    L7_9 = L7_9.GetTimeStr
    L7_9 = L7_9(L7_9, L5_7, A1_3.endTime / 1000)
    if Logic:Get("System"):GetTimeStr("%X", A1_3.endTime / 1000) ~= nil and L7_9 ~= nil and Logic:Get("System"):GetTimeStr("%X", A1_3.endTime / 1000) == "00:00:00" then
      L7_9 = Logic:Get("System"):GetTimeStr(L5_7, A1_3.endTime / 1000 - 20)
    end
    if L6_8 == nil or L7_9 == nil then
      A0_2.ttfTime:setString(TwGetStr(103095))
    else
      A0_2.ttfTime:setString(L6_8 .. "-" .. L7_9)
    end
  else
    L5_7 = A0_2.ttfTime
    L6_8 = L5_7
    L5_7 = L5_7.setString
    L7_9 = TwGetStr
    L7_9 = L7_9(103095)
    L5_7(L6_8, L7_9, L7_9(103095))
  end
end
function prototype.onbtnGo(A0_10, A1_11, A2_12)
  local L3_13, L4_14, L5_15
  L3_13 = CCControlEventTouchUpInside
  if A2_12 ~= L3_13 then
    return
  end
  L3_13 = A0_10.giftInfo
  L3_13 = L3_13.progressBanner
  if L3_13 then
    L3_13 = Logic
    L4_14 = L3_13
    L3_13 = L3_13.Get
    L5_15 = "Gift"
    L3_13 = L3_13(L4_14, L5_15)
    L4_14 = L3_13
    L3_13 = L3_13.OpenProgress
    L5_15 = A0_10.giftInfo
    L5_15 = L5_15.activityType
    L3_13(L4_14, L5_15)
    return
  end
  L3_13 = Logic
  L4_14 = L3_13
  L3_13 = L3_13.Get
  L5_15 = "PlayerInfo"
  L3_13 = L3_13(L4_14, L5_15)
  L4_14 = L3_13
  L3_13 = L3_13.GetPlayerLevel
  L3_13 = L3_13(L4_14)
  L3_13 = L3_13 or 1
  L4_14 = A0_10.giftInfo
  L4_14 = L4_14.activityType
  L4_14 = L4_14 == "SLOT"
  L5_15 = tonumber
  L5_15 = L5_15(A0_10.giftInfo.level)
  L5_15 = L5_15 or 40
  if L4_14 and L5_15 > tonumber(L3_13) then
    Prompt:Tip(TwGetStr(105402, L5_15))
    return
  end
  if (A0_10.giftInfo.activityType == "BANSHU_ARTIFACT_SOUL" or A0_10.giftInfo.activityType == "ARTIFACT_RANK" or A0_10.giftInfo.id == "ArtifactUpgrade1" or A0_10.giftInfo.id == "ArtifactUpgrade2") and L3_13 < 55 then
    Prompt:Tip("55\231\186\167\230\137\141\229\143\175\228\187\165\232\191\155\229\133\165\231\165\158\229\153\168\230\180\187\229\138\168")
    return
  end
  Logic:Get("Gift"):SetActivityGift(A0_10.giftInfo)
  if A0_10.giftInfo.activityType == nil then
    if table.empty(A0_10.giftInfo.gifts) then
      Prompt:Tip(103351)
      return
    end
    SceneHelper:runWithScene("GiftActivityReward", A0_10.rootNode)
    return
  end
  if A0_10.giftInfo.activityType == "VIP_WEEK" or A0_10.giftInfo.activityType == "VIP_MONTH" or A0_10.giftInfo.activityType == "VIP_VALUE_MONTH" or A0_10.giftInfo.activityType == "VIP_YEAR" then
    if table.empty(A0_10.giftInfo.gifts) then
      Prompt:Tip(103351)
      return
    end
    SceneHelper:runWithScene("GiftActivityRewardVip", A0_10.rootNode)
    return
  end
  if A0_10.giftInfo.activityType == "CHRISTMAS" then
    Logic:Get("ChristmasActivity"):OpenChristmas()
    return
  end
  if A0_10.giftInfo.activityType == "OLD_USER_CHARGE_TREBLE" or A0_10.giftInfo.activityType == "NEW_USER_CHARGE_TREBLE" then
    Logic:Get("Main"):GotoRecharge()
    return
  end
  if A0_10.giftInfo.activityType == "OPEN_BOX" then
    SceneHelper:pushScene("GiftChest", A0_10.rootNode)
    return
  end
  if A0_10.giftInfo.activityType == "NEW_MONOPOLY" then
    Logic:Get("NewMonopoly"):PostLoadNewMonopoly()
    return
  end
  if A0_10.giftInfo.activityType == "EQUIP_GIFT" then
    Logic:Get("EquipGift"):setActivityInfo(A0_10.giftInfo.id, A0_10.giftInfo.name, A0_10.giftInfo.endTime)
    Logic:Get("EquipGift"):setFromMallFlag(false)
    if A0_10.giftInfo.showTemplete == "EQUIP_GIFT" then
      SceneHelper:runWithScene("ArmorGift", A0_10.rootNode)
    elseif A0_10.giftInfo.showTemplete == "EQUIP_MATERIAL" then
      SceneHelper:runWithScene("ArmorMaterialGift", A0_10.rootNode)
    end
    return
  end
  if A0_10.giftInfo.activityType == "FOOTBALL" then
    SceneHelper:pushScene("GiftFootball", A0_10.rootNode)
    return
  end
  if A0_10.giftInfo.activityType == "MONOPOLY" then
    SceneHelper:pushScene("Richer", A0_10.rootNode)
    return
  end
  if A0_10.giftInfo.activityType == "SMASH_EGG" then
    if A0_10.giftInfo.showTemplete == "egg" then
      SceneHelper:runWithScene(({
        HERO_RANK_UP = "GiftActivityInfo",
        HERO_GOLD_RANK_UP = "GiftActivityInfoXian",
        ARTIFACT_RANK = "GiftActivityInfoArtRank",
        TOKEN_COIN = "GiftActivityExchange",
        CONSUME_RANK = "GiftActivityInfoCostRank",
        ARTIFACT_UPGRADE = "GiftActivityInfoUpArt",
        GROUP_BUY = "GiftActivityGroup",
        DAILY_CHECK = "GiftActivityLogin",
        DUMPLING = "DumplingMain",
        SMASH_EGG = "BrokenEgg",
        FAKE_GROUP_BUY = "GroupPurchase",
        DEPOSIT_START = "WealthAndTreasure",
        DEPOSIT_DRAW = "WealthAndTreasure",
        SOUL_STONE_SALE = "GiftActivityInfoBuySoulAd",
        CHARGE = "GiftActivityReward",
        NEW_CONSUME_RANK = "GiftActivityInfoConsume",
        TREASURE_ROOM = "GiftTreasure",
        RAFFLE = "CircleLottery",
        QINGMING = "GiftTombSweeping",
        QINGMING_RANK = "GiftCommonConsume",
        FOOLSDAY = "FoolsDayActivity",
        JUHUASUAN = "GiftHuaSuan",
        SECRETSHOP = "MysticShop",
        BLESSING = "GiftBless",
        RED_CARD_EXCHANGE = "ExchangeMain",
        GEM_ROOM = "GiftGemroom",
        BANSHU_ARTIFACT_SOUL = "Artifact",
        GOD_REWARD = "GiftTask",
        MOON = "MoonCake",
        MOON_SHARE = "MoonCakeExchange",
        SPRING = "Moon",
        SPRING_SHARE = "MoonExchange",
        FIRE_WORKS = "FireWorks",
        EXCHANGE = "GiftHallowmasExchange",
        SWEET_HOUSE = "GiftHallowmasShop",
        TURKEY = "ThanksgivingDay",
        CHARGE_RETURN = "ThanksgivingDayCharge",
        EXCHANGE_SHOP = "SmeltResourceShop",
        RECYCLE = "SmeltResource",
        ACTIVITY_CHARGE = "ActivityCharge",
        MONTHS = "ActivityMonths"
      }).SMASH_EGG, A0_10.rootNode)
    elseif A0_10.giftInfo.showTemplete == "fire" then
      SceneHelper:runWithScene(({
        HERO_RANK_UP = "GiftActivityInfo",
        HERO_GOLD_RANK_UP = "GiftActivityInfoXian",
        ARTIFACT_RANK = "GiftActivityInfoArtRank",
        TOKEN_COIN = "GiftActivityExchange",
        CONSUME_RANK = "GiftActivityInfoCostRank",
        ARTIFACT_UPGRADE = "GiftActivityInfoUpArt",
        GROUP_BUY = "GiftActivityGroup",
        DAILY_CHECK = "GiftActivityLogin",
        DUMPLING = "DumplingMain",
        SMASH_EGG = "BrokenEgg",
        FAKE_GROUP_BUY = "GroupPurchase",
        DEPOSIT_START = "WealthAndTreasure",
        DEPOSIT_DRAW = "WealthAndTreasure",
        SOUL_STONE_SALE = "GiftActivityInfoBuySoulAd",
        CHARGE = "GiftActivityReward",
        NEW_CONSUME_RANK = "GiftActivityInfoConsume",
        TREASURE_ROOM = "GiftTreasure",
        RAFFLE = "CircleLottery",
        QINGMING = "GiftTombSweeping",
        QINGMING_RANK = "GiftCommonConsume",
        FOOLSDAY = "FoolsDayActivity",
        JUHUASUAN = "GiftHuaSuan",
        SECRETSHOP = "MysticShop",
        BLESSING = "GiftBless",
        RED_CARD_EXCHANGE = "ExchangeMain",
        GEM_ROOM = "GiftGemroom",
        BANSHU_ARTIFACT_SOUL = "Artifact",
        GOD_REWARD = "GiftTask",
        MOON = "MoonCake",
        MOON_SHARE = "MoonCakeExchange",
        SPRING = "Moon",
        SPRING_SHARE = "MoonExchange",
        FIRE_WORKS = "FireWorks",
        EXCHANGE = "GiftHallowmasExchange",
        SWEET_HOUSE = "GiftHallowmasShop",
        TURKEY = "ThanksgivingDay",
        CHARGE_RETURN = "ThanksgivingDayCharge",
        EXCHANGE_SHOP = "SmeltResourceShop",
        RECYCLE = "SmeltResource",
        ACTIVITY_CHARGE = "ActivityCharge",
        MONTHS = "ActivityMonths"
      }).FIRE_WORKS, A0_10.rootNode)
    end
    return
  end
  if ({
    SLOT = "SlotLottery",
    EXPLORE = "ExploreMain"
  })[A0_10.giftInfo.activityType] then
    SceneHelper:pushScene(({
      SLOT = "SlotLottery",
      EXPLORE = "ExploreMain"
    })[A0_10.giftInfo.activityType], A0_10.rootNode)
    return
  end
  if ({
    HERO_RANK_UP = "GiftActivityInfo",
    HERO_GOLD_RANK_UP = "GiftActivityInfoXian",
    ARTIFACT_RANK = "GiftActivityInfoArtRank",
    TOKEN_COIN = "GiftActivityExchange",
    CONSUME_RANK = "GiftActivityInfoCostRank",
    ARTIFACT_UPGRADE = "GiftActivityInfoUpArt",
    GROUP_BUY = "GiftActivityGroup",
    DAILY_CHECK = "GiftActivityLogin",
    DUMPLING = "DumplingMain",
    SMASH_EGG = "BrokenEgg",
    FAKE_GROUP_BUY = "GroupPurchase",
    DEPOSIT_START = "WealthAndTreasure",
    DEPOSIT_DRAW = "WealthAndTreasure",
    SOUL_STONE_SALE = "GiftActivityInfoBuySoulAd",
    CHARGE = "GiftActivityReward",
    NEW_CONSUME_RANK = "GiftActivityInfoConsume",
    TREASURE_ROOM = "GiftTreasure",
    RAFFLE = "CircleLottery",
    QINGMING = "GiftTombSweeping",
    QINGMING_RANK = "GiftCommonConsume",
    FOOLSDAY = "FoolsDayActivity",
    JUHUASUAN = "GiftHuaSuan",
    SECRETSHOP = "MysticShop",
    BLESSING = "GiftBless",
    RED_CARD_EXCHANGE = "ExchangeMain",
    GEM_ROOM = "GiftGemroom",
    BANSHU_ARTIFACT_SOUL = "Artifact",
    GOD_REWARD = "GiftTask",
    MOON = "MoonCake",
    MOON_SHARE = "MoonCakeExchange",
    SPRING = "Moon",
    SPRING_SHARE = "MoonExchange",
    FIRE_WORKS = "FireWorks",
    EXCHANGE = "GiftHallowmasExchange",
    SWEET_HOUSE = "GiftHallowmasShop",
    TURKEY = "ThanksgivingDay",
    CHARGE_RETURN = "ThanksgivingDayCharge",
    EXCHANGE_SHOP = "SmeltResourceShop",
    RECYCLE = "SmeltResource",
    ACTIVITY_CHARGE = "ActivityCharge",
    MONTHS = "ActivityMonths"
  })[A0_10.giftInfo.activityType] then
    SceneHelper:runWithScene(({
      HERO_RANK_UP = "GiftActivityInfo",
      HERO_GOLD_RANK_UP = "GiftActivityInfoXian",
      ARTIFACT_RANK = "GiftActivityInfoArtRank",
      TOKEN_COIN = "GiftActivityExchange",
      CONSUME_RANK = "GiftActivityInfoCostRank",
      ARTIFACT_UPGRADE = "GiftActivityInfoUpArt",
      GROUP_BUY = "GiftActivityGroup",
      DAILY_CHECK = "GiftActivityLogin",
      DUMPLING = "DumplingMain",
      SMASH_EGG = "BrokenEgg",
      FAKE_GROUP_BUY = "GroupPurchase",
      DEPOSIT_START = "WealthAndTreasure",
      DEPOSIT_DRAW = "WealthAndTreasure",
      SOUL_STONE_SALE = "GiftActivityInfoBuySoulAd",
      CHARGE = "GiftActivityReward",
      NEW_CONSUME_RANK = "GiftActivityInfoConsume",
      TREASURE_ROOM = "GiftTreasure",
      RAFFLE = "CircleLottery",
      QINGMING = "GiftTombSweeping",
      QINGMING_RANK = "GiftCommonConsume",
      FOOLSDAY = "FoolsDayActivity",
      JUHUASUAN = "GiftHuaSuan",
      SECRETSHOP = "MysticShop",
      BLESSING = "GiftBless",
      RED_CARD_EXCHANGE = "ExchangeMain",
      GEM_ROOM = "GiftGemroom",
      BANSHU_ARTIFACT_SOUL = "Artifact",
      GOD_REWARD = "GiftTask",
      MOON = "MoonCake",
      MOON_SHARE = "MoonCakeExchange",
      SPRING = "Moon",
      SPRING_SHARE = "MoonExchange",
      FIRE_WORKS = "FireWorks",
      EXCHANGE = "GiftHallowmasExchange",
      SWEET_HOUSE = "GiftHallowmasShop",
      TURKEY = "ThanksgivingDay",
      CHARGE_RETURN = "ThanksgivingDayCharge",
      EXCHANGE_SHOP = "SmeltResourceShop",
      RECYCLE = "SmeltResource",
      ACTIVITY_CHARGE = "ActivityCharge",
      MONTHS = "ActivityMonths"
    })[A0_10.giftInfo.activityType], A0_10.rootNode)
  end
end
function prototype.TipGift(A0_16)
  if A0_16:IshasReward() then
    if A0_16.rootNode:getChildByTag(11) == nil then
      A0_16:showRewardTipActivity()
    end
  else
    if A0_16.ani ~= nil then
      A0_16.ani:RemoveAnimation()
    end
    A0_16.rootNode:removeChildByTag(11, true)
  end
end
function prototype.showRewardTipActivity(A0_17)
  local L1_18, L2_19, L3_20
  L1_18 = A0_17.imgCheck
  L2_19 = L1_18
  L1_18 = L1_18.getPositionX
  L1_18 = L1_18(L2_19)
  L1_18 = L1_18 + 30
  L2_19 = A0_17.imgCheck
  L3_20 = L2_19
  L2_19 = L2_19.getPositionY
  L2_19 = L2_19(L3_20)
  L2_19 = L2_19 + 24
  L3_20 = Logic
  L3_20 = L3_20.Get
  L3_20 = L3_20(L3_20, "AniMgr")
  L3_20 = L3_20.RunCCBAni
  L3_20 = L3_20(L3_20, "UI/uinew", A0_17, ccp(L1_18, L2_19), 0.7)
  A0_17.ani = L3_20
  L3_20 = CCSprite
  L3_20 = L3_20.create
  L3_20 = L3_20(L3_20, "images/public/tip.png")
  if L3_20 ~= nil then
    A0_17.rootNode:addChild(L3_20, 0, 11)
    L3_20:setAnchorPoint(CCPoint(0.5, 0.5))
    L3_20:setPosition(ccp(L1_18, L2_19))
    L3_20:setScale(0.8)
  end
end
function prototype.IshasReward(A0_21)
  local L1_22
  L1_22 = A0_21.giftInfo
  L1_22 = L1_22.progressBanner
  if L1_22 then
    L1_22 = A0_21.giftInfo
    L1_22 = L1_22.canDraw
    return L1_22
  end
  L1_22 = Logic
  L1_22 = L1_22.Get
  L1_22 = L1_22(L1_22, "Gift")
  L1_22 = L1_22.GetCanShowActivityGift
  L1_22 = L1_22(L1_22)
  if not table.empty(L1_22) and A0_21.giftInfo.gifts ~= nil then
    for _FORV_5_, _FORV_6_ in pairs(A0_21.giftInfo.gifts) do
      if L1_22[_FORV_6_.id] ~= nil and L1_22[_FORV_6_.id].canDraw then
        return true
      end
    end
  end
  if Logic:Get("Groupbuy"):IsHasNewReward() and A0_21.giftInfo.activityType == "GROUP_BUY" then
    return true
  end
  if Logic:Get("ChristmasActivity"):getNewRewardFlag() and A0_21.giftInfo.activityType == "CHRISTMAS" then
    return true
  end
  if Logic:Get("Dumpling"):getTipFlag() and A0_21.giftInfo.activityType == "DUMPLING" then
    return true
  end
  if Logic:Get("Consume"):hasConsumeReward() and A0_21.giftInfo.activityType == "NEW_CONSUME_RANK" then
    return true
  end
  if Logic:Get("GodReward"):IsCompleteTask() and A0_21.giftInfo.activityType == "GOD_REWARD" then
    return true
  end
  if Logic:Get("Monopoly"):IsCompleteMonoTask() and A0_21.giftInfo.activityType == "MONOPOLY" then
    return true
  end
  if Logic:Get("Explore"):IsCompleteExplore() and A0_21.giftInfo.activityType == "EXPLORE" then
    return true
  end
  if Logic:Get("ActivityCharge"):hasNewReward() and A0_21.giftInfo.activityType == "ACTIVITY_CHARGE" then
    return true
  end
  if Logic:Get("NewMonopoly"):IsCompleteMonoTask() and A0_21.giftInfo.activityType == "NEW_MONOPOLY" then
    return true
  end
end
