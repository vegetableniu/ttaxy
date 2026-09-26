-- ============================================================
-- LocalServer : 本地离线伪服务端（由 09_脚本/17_gen_localserver.py 生成）
-- 注入到 script/base/NetMsg.dat，拦截 NetMsg:Send，直接本地应答
-- ============================================================
local LS = {}
LS.enabled = true

-- 伪造的区服列表（对应 login:InitServerLst 期望的 JSON）
LS.SERVER_JSON = [[{"list": [{"id": "1", "name": "本地单机", "ip": "127.0.0.1", "port": "9001", "area": "1", "areaName": "本地区", "flag": "1", "status": 1, "lv": 1, "recommend": 1, "hot": 1, "new": 1, "openTime": "2013-01-01 00:00:00"}]}]]

-- 玩家固定数据
LS.PLAYER_NAME = "本地玩家"
LS.ACCOUNT = "localuser"
LS.SESSION = "localsession0001"

local T = {}
T["facade.AccountResult"] = {["arg"]="x", ["args"]="x"}
T["facade.ActionPointResult"] = {["arg"]="x", ["args"]="x"}
T["facade.ActivitychargeResult"] = {["arg"]="x", ["args"]="x"}
T["facade.ArenaResult"] = {["arg"]="x", ["args"]="x"}
T["facade.BeeEffGeeResult"] = {["arg"]="x", ["args"]="x"}
T["facade.BlessingResult"] = {["arg"]="x", ["args"]="x"}
T["facade.BoxResult"] = {["arg"]="x", ["args"]="x"}
T["facade.ChargeRankResult"] = {["arg"]="x", ["args"]="x"}
T["facade.ChargereturnResult"] = {["arg"]="x", ["args"]="x"}
T["facade.ChatResult"] = {["arg"]="x", ["args"]="x"}
T["facade.CheapBuyResult"] = {["arg"]="x", ["args"]="x"}
T["facade.ChristmasResult"] = {["arg"]="x", ["args"]="x"}
T["facade.CommonResult"] = {["arg"]="x", ["args"]="x"}
T["facade.ConsumeRankResult"] = {["arg"]="x", ["args"]="x"}
T["facade.CostResult"] = {["arg"]="x", ["args"]="x"}
T["facade.CultivateResult"] = {["arg"]="x", ["args"]="x"}
T["facade.CultivateShopResult"] = {["arg"]="x", ["args"]="x"}
T["facade.CurrencyResult"] = {["arg"]="x", ["args"]="x"}
T["facade.DemogResult"] = {["arg"]="x", ["args"]="x"}
T["facade.DepositResult"] = {["arg"]="x", ["args"]="x"}
T["facade.DumplingResult"] = {["arg"]="x", ["args"]="x"}
T["facade.EggResult"] = {["arg"]="x", ["args"]="x"}
T["facade.EliteResult"] = {["arg"]="x", ["args"]="x"}
T["facade.EmailResult"] = {["arg"]="x", ["args"]="x"}
T["facade.EmblemResult"] = {["arg"]="x", ["args"]="x"}
T["facade.EquipResult"] = {["arg"]="x", ["args"]="x"}
T["facade.EquipgiftResult"] = {["arg"]="x", ["args"]="x"}
T["facade.ExchangeResult"] = {["arg"]="x", ["args"]="x"}
T["facade.ExchangeshopResult"] = {["arg"]="x", ["args"]="x"}
T["facade.ExploreResult"] = {["arg"]="x", ["args"]="x"}
T["facade.FightResult"] = {["arg"]="x", ["args"]="x"}
T["facade.FoolsDayResult"] = {["arg"]="x", ["args"]="x"}
T["facade.FootballResult"] = {["arg"]="x", ["args"]="x"}
T["facade.GemroomResult"] = {["arg"]="x", ["args"]="x"}
T["facade.GiftResult"] = {["arg"]="x", ["args"]="x"}
T["facade.GodRewardResult"] = {["arg"]="x", ["args"]="x"}
T["facade.GroupActivityResult"] = {["arg"]="x", ["args"]="x"}
T["facade.GroupbuyResult"] = {["arg"]="x", ["args"]="x"}
T["facade.HeroResult"] = {["arg"]="x", ["args"]="x"}
T["facade.InviteResult"] = {["arg"]="x", ["args"]="x"}
T["facade.ItemResult"] = {["arg"]="x", ["args"]="x"}
T["facade.JuhuasuanResult"] = {["arg"]="x", ["args"]="x"}
T["facade.KingsoftResult"] = {["arg"]="x", ["args"]="x"}
T["facade.MenpaiResult"] = {["arg"]="x", ["args"]="x"}
T["facade.MonopolyResult"] = {["arg"]="x", ["args"]="x"}
T["facade.MoonResult"] = {["arg"]="x", ["args"]="x"}
T["facade.NewMonopolyResult"] = {["arg"]="x", ["args"]="x"}
T["facade.PlatformResult"] = {["arg"]="x", ["args"]="x"}
T["facade.PlayerResult"] = {["arg"]="x", ["args"]="x"}
T["facade.PreciousroomResult"] = {["arg"]="x", ["args"]="x"}
T["facade.PvpResult"] = {["arg"]="x", ["args"]="x"}
T["facade.QingmingResult"] = {["arg"]="x", ["args"]="x"}
T["facade.RaffleResult"] = {["arg"]="x", ["args"]="x"}
T["facade.RebirthResults"] = {["arg"]="x", ["args"]="x"}
T["facade.RecycleResult"] = {["arg"]="x", ["args"]="x"}
T["facade.RewardResult"] = {["arg"]="x", ["args"]="x"}
T["facade.SecretshopResult"] = {["arg"]="x", ["args"]="x"}
T["facade.SequenceConstant"] = {["arg"]="x", ["args"]="x"}
T["facade.SingleResults"] = {["arg"]="x", ["args"]="x"}
T["facade.SlotResult"] = {["arg"]="x", ["args"]="x"}
T["facade.SocialityResult"] = {["arg"]="x", ["args"]="x"}
T["facade.SuperGiftResult"] = {["arg"]="x", ["args"]="x"}
T["facade.SweetHouseResult"] = {["arg"]="x", ["args"]="x"}
T["facade.TalismanResult"] = {["arg"]="x", ["args"]="x"}
T["facade.TargetResult"] = {["arg"]="x", ["args"]="x"}
T["facade.TencentResult"] = {["arg"]="x", ["args"]="x"}
T["facade.TipsResult"] = {["arg"]="x", ["args"]="x"}
T["facade.TreasureResult"] = {["arg"]="x", ["args"]="x"}
T["facade.TreasureroomResult"] = {["arg"]="x", ["args"]="x"}
T["facade.TurkeyResult"] = {["arg"]="x", ["args"]="x"}
T["facade.WorldChatResult"] = {["arg"]="x", ["args"]="x"}
T["manager.GiftReward"] = {["content"]="s", ["type"]="o:model.GiftRewardType"}
T["manager.GlobalDescription"] = {["conditions"]="s", ["info"]="s", ["name"]="s", ["onlineTimes"]="i", ["onlineType"]="o:model.OnlineType", ["prev"]="s", ["showId"]="s", ["showType"]="s", ["sort"]="i"}
T["manager.Item"] = {["amount"]="i", ["baseId"]="i", ["content"]="s", ["id"]="i", ["owner"]="i", ["type"]="o:model.ItemType"}
T["manager.PointValue"] = {["exchangeCount"]="i", ["exchangeTime"]="d", ["extraTime"]="d", ["point"]="i", ["refreshTime"]="d"}
T["manager.ShortMessage"] = {["code"]="s", ["hasPass"]="b", ["id"]="i", ["phone"]="s", ["sendAt"]="d"}
T["manager.UserDescription"] = {["info"]="s", ["name"]="s", ["showId"]="s", ["showType"]="s", ["sort"]="i"}
T["model.AccountPost"] = {["arg"]="x", ["args"]="x"}
T["model.AccountState"] = {["arg"]="x", ["args"]="x"}
T["model.AccountVo"] = {["createdOn"]="d", ["dayByContinuous"]="i", ["dayByTotal"]="i", ["id"]="i", ["loginOn"]="d", ["logoutOn"]="d", ["name"]="s", ["online"]="b", ["post"]="i", ["state"]="o:model.AccountState", ["timeByDay"]="i", ["timeByTotal"]="i"}
T["model.AchieveRewardVO"] = {["rewardResult"]="a:o:model.RewardResult", ["status"]="i"}
T["model.ActionPointVo"] = {["points"]="m:o:manager.PointValue"}
T["model.ActiveBattleVo"] = {["id"]="s", ["startTime"]="d", ["stopTime"]="d"}
T["model.ActiveVo"] = {["activeCounts"]="m:m:i", ["actives"]="a:o:model.ActiveBattleVo"}
T["model.ActivityMoneyVo"] = {["exchangeTimes"]="m:i", ["tokenCoin"]="i"}
T["model.ActivityType"] = {["arg"]="x", ["args"]="x"}
T["model.ActivityVo"] = {["activityType"]="s", ["desc"]="s", ["endTime"]="d", ["gifts"]="a:o:model.GlobalGiftVo", ["icon"]="s", ["id"]="s", ["level"]="i", ["lockKey"]="s", ["mallId"]="i", ["name"]="s", ["show"]="b", ["showTemplete"]="s", ["startTime"]="d"}
T["model.ActivitychargeVo"] = {["charge"]="i", ["draw"]="a:i"}
T["model.AddtionType"] = {["arg"]="x", ["args"]="x"}
T["model.AllRankVO"] = {["activeId"]="s", ["damageRank"]="i", ["damageRankList"]="a:o:model.RankVO", ["featRank"]="i", ["featRankList"]="a:o:model.RankVO"}
T["model.ApplyMenpaiInfoPageVo"] = {["count"]="i", ["data"]="a:o:model.ApplyMenpaiInfoVo", ["firstBid"]="i", ["firstMenpai"]="i", ["ownBid"]="i", ["page"]="i", ["size"]="i"}
T["model.ApplyMenpaiInfoVo"] = {["bossName"]="s", ["count"]="i", ["createTime"]="d", ["declaration"]="s", ["exp"]="i", ["id"]="i", ["joinState"]="o:model.JoinState", ["level"]="i", ["maxCount"]="i", ["name"]="s", ["rank"]="i", ["todayBid"]="i", ["yesterdayBid"]="i"}
T["model.Attachment"] = {["charge"]="i", ["chargeTypes"]="a:o:model.CurrencyType", ["rewards"]="a:o:model.AttachmentReward"}
T["model.AttachmentState"] = {["arg"]="x", ["args"]="x"}
T["model.AttackVO"] = {["allOut"]="b", ["costResult"]="a:o:model.CostResult", ["damage"]="i", ["enemyNum"]="i", ["feat"]="i", ["groupNum"]="i", ["killed"]="b", ["luckHeros"]="a:i", ["rankList"]="a:o:model.TotalDamageRankVo", ["reports"]="a:x", ["shared"]="b"}
T["model.AttackVo"] = {["currenttHp"]="i", ["demage"]="i", ["groupNum"]="i", ["reports"]="a:x", ["rewardResult"]="a:o:model.RewardResult", ["totalHp"]="i", ["win"]="b"}
T["model.AttackedRecordVO"] = {["id"]="i", ["name"]="s", ["newRank"]="i", ["oldRank"]="i", ["win"]="b"}
T["model.BasicUser"] = {["baseId"]="i", ["fightScore"]="i", ["level"]="i", ["name"]="s", ["playerId"]="i", ["skill"]="i"}
T["model.BasicUserPageVo"] = {["count"]="i", ["data"]="a:o:model.BasicUser", ["page"]="i", ["size"]="i"}
T["model.BattleInfo"] = {["attackerHps"]="m:i", ["defenderHps"]="m:i", ["rounds"]="m:i", ["times"]="m:i"}
T["model.BattleResult"] = {["arg"]="x", ["args"]="x"}
T["model.BattleType"] = {["arg"]="x", ["args"]="x"}
T["model.BattlesTimesVo"] = {["battleBuys"]="m:m:i", ["battleCounts"]="m:m:i"}
T["model.BeeEffGeeVo"] = {["level"]="i", ["middleSoulStone"]="i", ["normalSoulStone"]="i", ["primarySoulStone"]="i", ["progress"]="i", ["seniorSoulStone"]="i"}
T["model.BlessingVo"] = {["charge"]="i", ["rank"]="i", ["times"]="i", ["totalTimes"]="i"}
T["model.BoxVo"] = {["coinNum"]="i", ["costOpenTimes"]="m:i", ["keys"]="m:i"}
T["model.BuyEnergyVO"] = {["buyTimes"]="i", ["costResults"]="a:o:model.CostResult", ["energy"]="i"}
T["model.BuyEquipgiftVo"] = {["costResults"]="a:o:model.CostResult", ["randomRewardResults"]="a:o:model.RewardResult", ["rewardResults"]="a:o:model.RewardResult"}
T["model.BuyGoodsResult"] = {["costResults"]="a:o:model.CostResult", ["currency"]="i", ["rewardResults"]="a:o:model.RewardResult"}
T["model.BuyGoodsVo"] = {["boughtGoods"]="m:i", ["costResults"]="a:o:model.CostResult", ["currency"]="i", ["rewardResults"]="a:o:model.RewardResult"}
T["model.BuyMoonResultVo"] = {["costs"]="a:o:model.CostResult", ["curCount"]="m:i"}
T["model.BuyNPCExpVO"] = {["costResults"]="a:o:model.CostResult", ["npcCurrentInfo"]="o:model.NPCCurrentInfo"}
T["model.BuyOpenBetaGoodsResultVO"] = {["buyGoods"]="m:i", ["costResults"]="a:o:model.CostResult", ["fixedRewardResults"]="a:o:model.RewardResult", ["randomRewardResults"]="a:o:model.RewardResult"}
T["model.BuyPackVo"] = {["costs"]="a:o:model.CostResult", ["extendCount"]="i", ["extendLimit"]="i"}
T["model.BuyResult"] = {["costAndReward"]="o:model.CostAndReward", ["showList"]="a:o:model.SuperGiftVo"}
T["model.BuySoulstoneVo"] = {["costResults"]="a:o:model.CostResult", ["rewardResults"]="a:o:model.RewardResult"}
T["model.BuyTalismanPackSpaceVo"] = {["extendLimit"]="i", ["vcoinCost"]="a:o:model.CostResult"}
T["model.BuyTaskVo"] = {["costResults"]="a:o:model.CostResult", ["todayBuyCompleteCount"]="i", ["totalCompleteCount"]="i"}
T["model.BuyTimesVO"] = {["costResults"]="a:o:model.CostResult", ["hasBuyTimes"]="i", ["times"]="i"}
T["model.BuyTimesVo"] = {["times"]="i", ["todayTimes"]="i"}
T["model.BuyVo"] = {["costAndReward"]="o:model.CostAndReward", ["info"]="o:model.InfoVo"}
T["model.CastDiceVo"] = {["actStep"]="i", ["costResults"]="a:o:model.CostResult", ["forkSnares"]="a:i", ["newMonopolyVo"]="o:model.NewMonopolyVo", ["rewardResults"]="a:o:model.RewardResult", ["snares"]="a:i", ["steps"]="a:i"}
T["model.ChargeAddType"] = {["arg"]="x", ["args"]="x"}
T["model.ChargereturnVo"] = {["charge"]="i", ["day"]="s", ["drawRecord"]="a:s"}
T["model.CheckApplyUserVo"] = {["baseId"]="i", ["fightScore"]="i", ["level"]="i", ["name"]="s", ["playerId"]="i"}
T["model.ClientState"] = {["draws"]="a:s", ["shows"]="a:s"}
T["model.CommendVo"] = {["artifactLevel"]="i", ["baseId"]="i", ["cultivateVo"]="o:model.HeroCultivateVo", ["equips"]="a:o:model.EquipVo", ["friend"]="b", ["heroLevel"]="i", ["id"]="i", ["level"]="i", ["name"]="s", ["powerSkill"]="i", ["pvpDesId"]="i", ["talisman"]="a:o:model.TalismanVo", ["used"]="b", ["userBuffs"]="a:s"}
T["model.CompleteTaskVo"] = {["completeTasks"]="a:i", ["costResults"]="a:o:model.CostResult"}
T["model.ComposeVo"] = {["baseid"]="i", ["fragments"]="i", ["id"]="i"}
T["model.CompoundElixirVo"] = {["costResults"]="a:o:model.CostResult", ["materials"]="m:i"}
T["model.ConsumeActiveRankVO"] = {["consume"]="i", ["id"]="i", ["leaderBaseId"]="i", ["leaderLevel"]="i", ["name"]="s", ["rank"]="i"}
T["model.ContributeMenpaiVo"] = {["costReward"]="o:model.CostAndReward", ["exp"]="i", ["money"]="i", ["rewardExp"]="i"}
T["model.CookCoolTimeVo"] = {["baseId"]="i", ["coolTime"]="d"}
T["model.CookVo"] = {["coolTime"]="d", ["costs"]="a:o:model.CostResult", ["type"]="i"}
T["model.CostAndReward"] = {["costs"]="a:o:model.CostResult", ["rewards"]="a:o:model.RewardResult"}
T["model.CostRefreshVo"] = {["costResults"]="a:o:model.CostResult", ["nextTime"]="d", ["times"]="i", ["treasures"]="m:i"}
T["model.CostResult"] = {["amount"]="i", ["code"]="i", ["contents"]="o", ["type"]="o:model.CostType"}
T["model.CostType"] = {["arg"]="x", ["args"]="x"}
T["model.CountryFightReportVo"] = {["fightJoinedVo"]="o:model.CountryFigthJoinedVo", ["fightReport"]="a:a:o:model.FightRecord", ["winMenpaiId"]="i"}
T["model.CountryFighter"] = {["firstBid"]="i", ["firstMenpai"]="i", ["firstMenpaiNames"]="s", ["id"]="i", ["secBid"]="i", ["secMenpai"]="i", ["secMenpaiNames"]="s"}
T["model.CountryFigthJoinedVo"] = {["country"]="i", ["joined"]="b", ["ownMenpaiId"]="i", ["ownMenpaiName"]="s", ["ownTeam"]="a:o:model.MenpaiPartnerVo", ["targetMenpaiId"]="i", ["targetMenpaiName"]="s", ["targetTeam"]="a:o:model.MenpaiPartnerVo"}
T["model.CountryHoldVo"] = {["bid"]="i", ["id"]="i", ["menpaiInfo"]="o:model.ApplyMenpaiInfoVo", ["nextBidDate"]="d"}
T["model.CountryItemVo"] = {["data"]="o", ["state"]="o:model.CountryState"}
T["model.CountryState"] = {["arg"]="x", ["args"]="x"}
T["model.CountryType"] = {["arg"]="x", ["args"]="x"}
T["model.CountryVo"] = {["countryDatas"]="a:o:model.CountryItemVo", ["ownData"]="o", ["state"]="o:model.CountryState"}
T["model.CrossingVo"] = {["costResults"]="a:o:model.CostResult", ["reports"]="a:x", ["targetGroupNum"]="i", ["win"]="b"}
T["model.CultivateShopVo"] = {["autoRefreshDate"]="d", ["costRefreshTimes"]="i", ["exchanges"]="a:i", ["onItems"]="m:i"}
T["model.CultivateVo"] = {["elixires"]="m:i", ["materials"]="m:i"}
T["model.Currency"] = {["alter"]="i", ["current"]="i", ["type"]="o:model.CurrencyType"}
T["model.CurrencyType"] = {["arg"]="x", ["args"]="x"}
T["model.DailyCheckResultVO"] = {["checkedIds"]="a:i", ["continueDays"]="i", ["rewardResults"]="a:o:model.RewardResult", ["segment"]="i"}
T["model.DailyCheckVO"] = {["checkedIds"]="a:i", ["continueDays"]="i", ["isFirst"]="b", ["refreshTime"]="d", ["segment"]="i"}
T["model.DeductReward"] = {["costs"]="a:o:model.CostResult", ["rewards"]="a:o:model.Reward"}
T["model.DefyResultVO"] = {["coolDown"]="i", ["costAndReward"]="o:model.CostAndReward", ["groupNum"]="i", ["leaderBaseId"]="i", ["matchList"]="a:o:model.MatchPlayerVO", ["oldRank"]="i", ["reports"]="a:x", ["targetArtifactLevel"]="i", ["targetGroupNum"]="i", ["virtualId"]="i", ["virtualName"]="s", ["win"]="b"}
T["model.DemogActiveInfoVO"] = {["activeId"]="s", ["drawReward"]="a:i", ["endTime"]="i", ["exchangeMap"]="m:i", ["feat"]="i", ["fragment"]="i", ["hasReward"]="b", ["lastAttackDrawNum"]="i", ["pointValue"]="o:manager.PointValue", ["rank"]="i", ["rankGroupId"]="i"}
T["model.DemogAppearVO"] = {["activeId"]="s", ["battleId"]="s", ["currentHp"]="i", ["drawReward"]="a:i", ["escapeTime"]="i", ["feat"]="i", ["id"]="i", ["lastAttackDrawNum"]="i", ["level"]="i", ["pointValue"]="o:manager.PointValue", ["rank"]="i", ["summoner"]="i", ["summonerName"]="s", ["totalHp"]="i"}
T["model.DemogKilledRewardVO"] = {["feat"]="i", ["rank"]="i", ["rewardResults"]="a:o:model.RewardResult"}
T["model.DemogListVO"] = {["demogList"]="a:o:model.DemogVO", ["killedDemogList"]="a:o:model.KilledDemogVO"}
T["model.DemogPageVo"] = {["attackCooltime"]="d", ["count"]="i", ["data"]="a:o:model.DemogVo", ["page"]="i", ["size"]="i"}
T["model.DemogType"] = {["arg"]="x", ["args"]="x"}
T["model.DemogVO"] = {["attacked"]="b", ["battleId"]="s", ["currentHp"]="i", ["escapeTime"]="i", ["id"]="i", ["level"]="i", ["summoner"]="i", ["summonerName"]="s", ["totalHp"]="i"}
T["model.DemogVo"] = {["canReward"]="b", ["configId"]="s", ["demogId"]="i", ["escapeTime"]="d", ["hp"]="i", ["nameCall"]="s", ["totalHp"]="i"}
T["model.DepositResultVO"] = {["costResults"]="a:o:model.CostResult", ["depositVO"]="o:model.DepositVO"}
T["model.DepositVO"] = {["activeCharge"]="i", ["activeConsume"]="i", ["amount"]="i", ["depositDay"]="i", ["depositEndSeconds"]="i"}
T["model.DeviceType"] = {["arg"]="x", ["args"]="x"}
T["model.DiceVo"] = {["costResults"]="a:o:model.CostResult", ["monopolyVo"]="o:model.MonopolyVo", ["rewardResults"]="a:o:model.RewardResult"}
T["model.DrawBoxRewardVo"] = {["drewBoxs"]="a:i", ["rewardResults"]="a:o:model.RewardResult"}
T["model.DrawSpringVo"] = {["endCoolDate"]="d", ["rewardResults"]="a:o:model.RewardResult"}
T["model.DrawTaskRewardVo"] = {["costResults"]="a:o:model.CostResult", ["executeHeros"]="a:i", ["executes"]="a:o:model.ExecuteTaskItemVo", ["rewardResults"]="a:o:model.RewardResult", ["success"]="b"}
T["model.EachSmashVo"] = {["rewardId"]="s", ["rewardResults"]="a:o:model.RewardResult", ["smashType"]="o:model.SmashType"}
T["model.EatVo"] = {["costAndReward"]="o:model.CostAndReward", ["records"]="a:o:model.TurkeyRewardRecord"}
T["model.EggRewardVo"] = {["id"]="i", ["name"]="s", ["reward"]="s", ["rewardResults"]="a:o:model.RewardResult", ["time"]="d", ["tmp"]="s"}
T["model.EggVo"] = {["costSmashCount"]="i", ["eggRewardVos"]="a:o:model.EggRewardVo", ["freeSmashCount"]="i", ["hammer"]="i", ["hammerSmashCount"]="i", ["todaySmash"]="i", ["topRewardVo"]="o:model.TopRewardVo", ["totalCurrency"]="i"}
T["model.EliteAttackVo"] = {["battleId"]="s", ["costAndReward"]="o:model.CostAndReward", ["finished"]="b", ["groupNum"]="i", ["hasDemog"]="b", ["triggers"]="a:o:model.EliteTriggerVo"}
T["model.EliteProgressVo"] = {["activeBuys"]="m:m:i", ["activeCounts"]="m:m:i", ["battles"]="a:s", ["campaigns"]="a:s"}
T["model.EliteRecordItem"] = {["fightScore"]="i", ["groups"]="a:o:model.RankGroupVo", ["id"]="i", ["lostHp"]="i", ["name"]="s", ["round"]="i", ["time"]="d"}
T["model.EliteTriggerVo"] = {["coins"]="i", ["drops"]="a:a:o:model.RewardType", ["enemyNum"]="i", ["index"]="i", ["reports"]="a:x", ["success"]="b"}
T["model.EnterVo"] = {["battleId"]="s", ["remains"]="i", ["totalEnemies"]="i"}
T["model.EquipLotteryVo"] = {["current"]="i", ["resetDate"]="d", ["result"]="o:model.CostAndReward", ["usedFreeTimes"]="i"}
T["model.EquipPackSpaceVo"] = {["extendCount"]="i", ["extendLimit"]="i", ["fragments"]="m:i", ["materials"]="m:i", ["usedSpace"]="i"}
T["model.EquipVo"] = {["baseId"]="i", ["equipHero"]="i", ["id"]="i", ["owner"]="i", ["position"]="i"}
T["model.ExchangeInfo"] = {["buyTimes"]="m:i", ["sweets"]="m:i"}
T["model.ExchangePostVo"] = {["name"]="s", ["rewards"]="a:o:model.MoonRewardResult"}
T["model.ExchangeVO"] = {["fragment"]="i", ["liebi"]="i", ["rewardResult"]="a:o:model.RewardResult"}
T["model.ExchangeVo"] = {["costResults"]="a:o:model.CostResult", ["gotTreasures"]="a:i", ["rewardResults"]="a:o:model.RewardResult", ["roomCurrency"]="i", ["treasures"]="m:i"}
T["model.ExchangeshopVo"] = {["exhangeTimes"]="m:i", ["gotTreasures"]="a:i", ["refreshTimes"]="i", ["time"]="d", ["treasures"]="m:i"}
T["model.ExecuteTaskItemVo"] = {["decreaseCD"]="i", ["endAt"]="d", ["exceTimes"]="i", ["fightScore"]="i", ["friendCards"]="a:o:model.HireCardVo", ["id"]="i", ["point"]="i", ["rate"]="i", ["reward"]="i", ["selfCards"]="a:o:model.HireCardVo", ["star"]="i", ["successItems"]="a:o:model.TaskSuccessItem", ["virtualCards"]="a:i"}
T["model.ExecuteTaskVo"] = {["costResults"]="a:o:model.CostResult", ["executeHeros"]="a:i", ["executes"]="a:o:model.ExecuteTaskItemVo", ["hireFriendTimes"]="i", ["hireVirtualTimes"]="i", ["releases"]="a:o:model.ReleaseTaskItemVo"}
T["model.ExitVo"] = {["costAndReward"]="o:model.CostAndReward", ["failedTimes"]="i", ["hasDemog"]="b"}
T["model.ExploreVo"] = {["costFinishTimes"]="i", ["costRefreshTimes"]="i", ["executeHeros"]="a:i", ["executes"]="a:o:model.ExecuteTaskItemVo", ["exp"]="i", ["hireFriendTimes"]="i", ["hireVirtualTimes"]="i", ["level"]="i", ["nextRefresh"]="d", ["releases"]="a:o:model.ReleaseTaskItemVo"}
T["model.FightRecord"] = {["demage"]="a:i", ["fighers"]="a:i", ["originalHp"]="a:i", ["roundDemage"]="a:a:i", ["startHp"]="a:i", ["winCount"]="m:i", ["won"]="o:model.BattleResult"}
T["model.FightReport"] = {["json"]="s", ["reports"]="x"}
T["model.FlopVo"] = {["card"]="i", ["costAndReward"]="o:model.CostAndReward", ["levelSegment"]="i", ["resetTimes"]="i"}
T["model.FriendLeaderVo"] = {["artifactLevel"]="i", ["baseId"]="i", ["cultivateVo"]="o:model.HeroCultivateVo", ["equips"]="a:o:model.EquipVo", ["heroId"]="i", ["heroLevel"]="i", ["id"]="i", ["level"]="i", ["name"]="s", ["powerSkill"]="i", ["pvpDesId"]="i", ["score"]="i", ["talisman"]="a:o:model.TalismanVo", ["userBuffs"]="a:s"}
T["model.FriendPackVo"] = {["apply"]="b", ["extendCount"]="i", ["extendLimit"]="i", ["friends"]="a:i"}
T["model.FriendVo"] = {["artifactLevel"]="i", ["baseId"]="i", ["cultivateVo"]="o:model.HeroCultivateVo", ["equips"]="a:o:model.EquipVo", ["heroLevel"]="i", ["id"]="i", ["level"]="i", ["loginOn"]="d", ["name"]="s", ["online"]="b", ["powerSkill"]="i", ["pvpDesId"]="i", ["score"]="i", ["talisman"]="a:o:model.TalismanVo", ["userBuffs"]="a:s", ["vip"]="b"}
T["model.GemroomVo"] = {["coolState"]="b", ["coolTime"]="d", ["gotTreasures"]="a:i", ["refreshTimes"]="i", ["treasures"]="m:i"}
T["model.GetFeatRewardVo"] = {["rewardFeats"]="a:i", ["rewardResults"]="a:o:model.RewardResult"}
T["model.GetRewardType"] = {["arg"]="x", ["args"]="x"}
T["model.GetRewardVo"] = {["rewardResults"]="a:o:model.RewardResult", ["targetValues"]="m:i", ["tasks"]="a:i"}
T["model.GetTaskRewardVo"] = {["freeTimes"]="i", ["rewardResults"]="a:o:model.RewardResult", ["tasks"]="a:i"}
T["model.GiftOperation"] = {["arg"]="x", ["args"]="x"}
T["model.GiftRewardType"] = {["arg"]="x", ["args"]="x"}
T["model.GiveUpTaskVo"] = {["freeTimes"]="i", ["progress"]="m:i", ["tasks"]="a:i"}
T["model.GiveUpVo"] = {["pickUpTasks"]="a:i", ["targetValues"]="m:i", ["tasks"]="a:i"}
T["model.GlobalDrawVo"] = {["logs"]="m:d", ["owner"]="i"}
T["model.GlobalGiftType"] = {["arg"]="x", ["args"]="x"}
T["model.GlobalGiftVo"] = {["actitityId"]="s", ["canDraw"]="b", ["canShow"]="b", ["description"]="o:manager.GlobalDescription", ["drawTime"]="d", ["endTime"]="d", ["id"]="s", ["leftDays"]="i", ["repeat"]="b", ["reward"]="o:manager.GiftReward", ["startTime"]="d", ["type"]="o:model.GlobalGiftType"}
T["model.GodRewardVo"] = {["buyTimes"]="i", ["feats"]="i", ["freeTimes"]="i", ["progress"]="m:i", ["rewardFeats"]="a:i", ["rewardTasks"]="a:i", ["tasks"]="a:i"}
T["model.GoodsType"] = {["arg"]="x", ["args"]="x"}
T["model.GroupTarget"] = {["id"]="s", ["type"]="o:model.TargetType"}
T["model.HeroCultivateVo"] = {["alterValues"]="m:o", ["elixirs"]="m:i", ["id"]="i", ["state"]="i"}
T["model.HeroGroupInfoVo"] = {["curGroupId"]="i", ["groups"]="a:o:model.HeroGroupVo"}
T["model.HeroGroupVO"] = {["embattles"]="a:o:model.LineupHeroVO", ["groupId"]="i", ["leaderBaseId"]="i", ["leaderLevel"]="i"}
T["model.HeroGroupVo"] = {["embattles"]="a:a:i", ["groupId"]="i", ["leaderId"]="i"}
T["model.HeroGrowVo"] = {["costs"]="a:o:model.CostResult", ["hero"]="o:model.HeroVo"}
T["model.HeroPackVo"] = {["extendCount"]="i", ["extendLimit"]="i", ["heros"]="a:o:model.HeroVo", ["leader"]="i", ["score"]="a:i"}
T["model.HeroTalismanVo"] = {["baseId"]="i", ["id"]="i", ["talismanVos"]="a:o:model.TalismanVo"}
T["model.HeroVo"] = {["baseId"]="i", ["exp"]="i", ["id"]="i", ["level"]="i", ["locked"]="b", ["powerSkill"]="i", ["skillExp"]="i"}
T["model.HireCardVo"] = {["baseId"]="i", ["id"]="i", ["owner"]="i", ["score"]="i"}
T["model.IncomeRate"] = {["arg"]="x", ["args"]="x"}
T["model.InfoVo"] = {["cards"]="m:i", ["levelSegment"]="i", ["resetTimes"]="i"}
T["model.InitiativeShareVo"] = {["lotteryTimes"]="i", ["rewardResults"]="a:o:model.RewardResult"}
T["model.InjectSoulRepeatedlyVo"] = {["costResult"]="a:o:model.CostResult", ["critNum"]="i", ["haveInjected"]="i", ["level"]="i", ["middleSoulStone"]="i", ["primarySoulStone"]="i", ["progress"]="i", ["seniorSoulStone"]="i", ["soulStoneNumber"]="i", ["stopType"]="o:model.MultiInjectStopType"}
T["model.InjectSoulstoneVo"] = {["costResult"]="a:o:model.CostResult", ["critNum"]="i", ["level"]="i", ["number"]="i", ["progress"]="i", ["stoneType"]="o:model.SoulStoneType"}
T["model.IntegralRankVO"] = {["integral"]="i", ["leaderBaseId"]="i", ["level"]="i", ["rank"]="i", ["userName"]="s"}
T["model.IntegralRewardVO"] = {["hasDrawList"]="a:i", ["integral"]="i", ["leaveBuyTimes"]="i", ["rewardList"]="a:i", ["times"]="i"}
T["model.InviteMenpaiInfoPageVo"] = {["count"]="i", ["data"]="a:o:model.InviteMenpaiInfoVo", ["page"]="i", ["size"]="i"}
T["model.InviteMenpaiInfoVo"] = {["count"]="i", ["declaration"]="s", ["exp"]="i", ["id"]="i", ["inviteBaseId"]="i", ["inviteId"]="i", ["inviteJob"]="o:model.JobType", ["inviteName"]="s", ["joinState"]="o:model.JoinState", ["level"]="i", ["maxCount"]="i", ["name"]="s"}
T["model.InviteVO"] = {["inviteCode"]="s", ["inviteNum"]="i", ["isAddCode"]="b", ["rewardList"]="a:i"}
T["model.ItemExchangeVo"] = {["autoRefreshDate"]="d", ["costResults"]="a:o:model.CostResult", ["exchanges"]="a:i", ["onItems"]="m:i", ["rewardResults"]="a:o:model.RewardResult"}
T["model.ItemType"] = {["arg"]="x", ["args"]="x"}
T["model.JiBaiPageVo"] = {["jibaiCount"]="i", ["jiping"]="i", ["pondId"]="i", ["score"]="i"}
T["model.JiBaiVo"] = {["pageVo"]="o:model.JiBaiPageVo", ["rewards"]="a:o:model.RewardResult"}
T["model.JobAuth"] = {["arg"]="x", ["args"]="x"}
T["model.JobType"] = {["arg"]="x", ["args"]="x"}
T["model.JoinState"] = {["arg"]="x", ["args"]="x"}
T["model.JuhuansuanVo"] = {["buyedRecords"]="a:s", ["canBuy"]="a:s", ["canShow"]="a:s"}
T["model.KeyType"] = {["arg"]="x", ["args"]="x"}
T["model.KilledDemogVO"] = {["battleId"]="s", ["id"]="i", ["killFeat"]="i", ["lastAttackRewards"]="a:o:model.Reward", ["level"]="i", ["maxDamageRewards"]="a:o:model.Reward", ["summonRewards"]="a:o:model.Reward", ["summonerName"]="s"}
T["model.LineupCompareVO"] = {["enemy"]="o:model.LineupVO", ["own"]="o:model.LineupVO"}
T["model.LineupHeroVO"] = {["baseId"]="i", ["cultivateVo"]="o:model.HeroCultivateVo", ["equipVos"]="a:o:model.EquipVo", ["level"]="i", ["talismanVos"]="a:o:model.TalismanVo"}
T["model.LineupVO"] = {["artifactLevel"]="i", ["battleEffect"]="i", ["buffs"]="a:s", ["groups"]="a:o:model.HeroGroupVO", ["level"]="i", ["name"]="s"}
T["model.LoadRewardInfoVo"] = {["baseRewardIds"]="a:i", ["chargeCount"]="i", ["monthPlayers"]="i", ["weekPlayers"]="i"}
T["model.LoginInfoVo"] = {["account"]="o:model.AccountVo", ["actionPoint"]="o:model.ActionPointVo", ["activeProgress"]="a:s", ["activitys"]="o:model.ValidActivityVo", ["arenaMatchList"]="o:model.MatchPlayerListVO", ["artifactLevel"]="i", ["asset"]="i", ["buffs"]="a:s", ["buyEquipPackCount"]="i", ["buyEquipSpace"]="i", ["chargeRankCanDraw"]="b", ["commendFriend"]="a:o:model.CommendVo", ["consumeRankCanDraw"]="b", ["dailyCheckInfo"]="o:model.DailyCheckVO", ["demogActiveId"]="s", ["demogFeat"]="i", ["demogRank"]="o:model.AllRankVO", ["dumplingCoolTime"]="d", ["eliteBattleIds"]="a:s", ["emblemAchieveList"]="a:i", ["equipVos"]="a:o:model.EquipVo", ["exploreExecuteTasks"]="m:d", ["friendPack"]="o:model.FriendPackVo", ["groupVo"]="o:model.HeroGroupInfoVo", ["hasAchieve"]="b", ["hasNewMail"]="b", ["hasReward"]="b", ["heroCultivateVos"]="a:o:model.HeroCultivateVo", ["heros"]="o:model.HeroPackVo", ["items"]="a:o:manager.Item", ["lastPraiseTime"]="d", ["lotteryLevel"]="i", ["lotteryRecord"]="m:o", ["menpaiLoginVo"]="o:model.MenpaiLoginVo", ["platformInfo"]="o:model.PlatformInfo", ["player"]="o:model.PlayerVo", ["program"]="i", ["progressVo"]="o:model.ProgressVo", ["resetPlayerName"]="b", ["state"]="i", ["systemTime"]="d", ["talismanPackExtendCount"]="i", ["talismanVos"]="a:o:model.TalismanVo", ["targetProgress"]="m:i", ["teamInfoVo"]="o:model.TeamInfoVo", ["treasurePack"]="o:model.TreasurePackVo", ["validGiftVo"]="o:model.ValidGiftVo", ["vip"]="o:model.VipInfo", ["wallet"]="o:model.WalletVo"}
T["model.LookForResult"] = {["costs"]="a:o:model.CostResult", ["rank"]="i", ["treasures"]="a:i"}
T["model.LotteryListVO"] = {["activity"]="s", ["activityCharge"]="i", ["baseId"]="i", ["battle"]="s", ["cardID"]="s", ["cardLevel"]="s", ["cardTip"]="s", ["cardType"]="s", ["cooldownHours"]="i", ["current"]="i", ["desInPage"]="s", ["description"]="s", ["eliteBattle"]="s", ["endLevel"]="i", ["endTime"]="d", ["id"]="i", ["kind"]="s", ["level"]="i", ["limits"]="i", ["lotteryType"]="s", ["path"]="s", ["playerActivityCharge"]="i", ["prices"]="s", ["probability"]="s", ["resetDate"]="d", ["salePrices"]="a:i", ["show"]="b", ["showTemplete"]="s", ["sort"]="i", ["sortType"]="s", ["startTime"]="d", ["title"]="s", ["type"]="s", ["usedFreeTimes"]="i", ["vip"]="b", ["week"]="b", ["weight"]="i"}
T["model.LotteryVo"] = {["appearPosition"]="i", ["costResults"]="a:o:model.CostResult", ["positionRewards"]="m:i", ["records"]="a:o:model.SlotRecordVo", ["rewardResults"]="a:o:model.RewardResult"}
T["model.MailBoxVo"] = {["lastSentTime"]="d", ["receives"]="a:o:model.MailVo", ["sends"]="a:o:model.MailVo", ["sentSize"]="i"}
T["model.MailState"] = {["arg"]="x", ["args"]="x"}
T["model.MailType"] = {["arg"]="x", ["args"]="x"}
T["model.MailVo"] = {["attachment"]="o:model.Attachment", ["baseId"]="i", ["content"]="s", ["createTime"]="d", ["destoryTime"]="d", ["drawed"]="b", ["groupTarget"]="o:model.GroupTarget", ["id"]="i", ["mailState"]="i", ["mailType"]="o:model.MailType", ["readed"]="b", ["receiver"]="s", ["sender"]="s", ["senderId"]="i", ["system"]="b", ["template"]="i", ["title"]="s"}
T["model.MatchPlayerListVO"] = {["battleEffect"]="i", ["coolState"]="b", ["coolTime"]="i", ["hasBuyTimes"]="i", ["integral"]="i", ["leaveBuyTimes"]="i", ["playerList"]="a:o:model.MatchPlayerVO", ["rank"]="i", ["times"]="i", ["totalIntegral"]="i"}
T["model.MatchPlayerVO"] = {["battleScore"]="i", ["desId"]="i", ["id"]="i", ["leaderBaseId"]="i", ["level"]="i", ["name"]="s", ["rank"]="i", ["virtual"]="b"}
T["model.MaterialType"] = {["arg"]="x", ["args"]="x"}
T["model.MenpaiBidResultVo"] = {["bid"]="i", ["currentMoney"]="i", ["totalBid"]="i"}
T["model.MenpaiBidVo"] = {["country"]="i", ["hasBid"]="i"}
T["model.MenpaiFightVo"] = {["fightCountry"]="i", ["hasJoin"]="b", ["totalJoinedCount"]="i"}
T["model.MenpaiGoodsInfoVo"] = {["goods"]="a:o:model.MenpaiGoodsItemVo", ["id"]="i", ["money"]="i"}
T["model.MenpaiGoodsItemVo"] = {["exchange"]="i", ["id"]="i"}
T["model.MenpaiInfoVo"] = {["aplypNum"]="i", ["bossName"]="s", ["canPrayTime"]="i", ["count"]="i", ["declaration"]="s", ["endGrabRight"]="d", ["exp"]="i", ["hasGrabed"]="b", ["holdRewardDate"]="d", ["id"]="i", ["job"]="o:model.JobType", ["joinBidDate"]="a:d", ["joinFightDate"]="a:d", ["level"]="i", ["money"]="i", ["name"]="s", ["post"]="s", ["prayTimes"]="i", ["reportDate"]="a:d"}
T["model.MenpaiLoginVo"] = {["country"]="i", ["holdRewardDate"]="d", ["job"]="o:model.JobType", ["joinBidDate"]="a:d", ["joinFightDate"]="a:d", ["joined"]="b", ["menpaiId"]="i", ["needRename"]="b", ["prayTime"]="i", ["reportDate"]="a:d"}
T["model.MenpaiPartnerPageVo"] = {["count"]="i", ["data"]="a:o:model.MenpaiPartnerVo", ["page"]="i", ["size"]="i"}
T["model.MenpaiPartnerVo"] = {["artifactLevel"]="i", ["baseId"]="i", ["contribute"]="i", ["cultivateVo"]="o:model.HeroCultivateVo", ["equips"]="a:o:model.EquipVo", ["fightScore"]="i", ["job"]="o:model.JobType", ["lastLogin"]="d", ["level"]="i", ["name"]="s", ["online"]="b", ["playerId"]="i", ["skill"]="i", ["taiTalismans"]="a:o:model.TalismanVo", ["userBuffs"]="a:s"}
T["model.MonopolyFloor"] = {["drewBoxs"]="a:i", ["fork"]="b", ["forkPositions"]="m:i", ["forkpos"]="i", ["goldForkPositions"]="a:i", ["goldPositions"]="a:i", ["goneForkPositions"]="a:i", ["gonePositions"]="a:i", ["pos"]="i", ["positions"]="m:i", ["rings"]="i"}
T["model.MonopolyRewardRecord"] = {["content"]="s", ["name"]="s", ["rewardResults"]="a:o:model.MonopolyRewardResult"}
T["model.MonopolyTaskVo"] = {["costResults"]="a:o:model.CostResult", ["rewardResults"]="a:o:model.RewardResult", ["stepCompleted"]="b", ["taskProgress"]="m:i", ["tasks"]="a:i"}
T["model.MonopolyVo"] = {["boughts"]="a:i", ["completTask"]="b", ["currDiceTimes"]="i", ["currSpecialDiceTimes"]="i", ["currency"]="i", ["dice"]="i", ["drewBox"]="a:i", ["drewTaskReward"]="b", ["goldBoxPosition"]="i", ["gonePositions"]="a:i", ["position"]="i", ["records"]="a:o:model.MonopolyRewardRecord", ["rings"]="i", ["shop"]="a:i", ["specialDice"]="i", ["task"]="i", ["taskProgress"]="i", ["tasks"]="a:i"}
T["model.MoonComposeVo"] = {["composeCount"]="i", ["curCount"]="m:i"}
T["model.MoonExchangeVo"] = {["costResults"]="a:o:model.CostResult", ["curCount"]="m:i", ["rewardResults"]="a:o:model.RewardResult"}
T["model.MoonType"] = {["arg"]="x", ["args"]="x"}
T["model.MoonVo"] = {["count"]="m:i", ["post"]="a:o:model.ExchangePostVo"}
T["model.MultiInjectStopType"] = {["arg"]="x", ["args"]="x"}
T["model.NPCCurrentInfo"] = {["exp"]="i", ["level"]="i"}
T["model.NewMonopolyRewardRecord"] = {["content"]="s", ["name"]="s", ["rewardResults"]="a:o:model.NewMonopolyRewardResult"}
T["model.NewMonopolyVo"] = {["boughtGoods"]="m:i", ["buffTimes"]="i", ["cast"]="i", ["costCast"]="i", ["costSpecialCast"]="i", ["costSubstitute"]="i", ["currBuff"]="s", ["currFloor"]="s", ["currency"]="i", ["floors"]="m:o:model.MonopolyFloor", ["goodsItems"]="a:i", ["records"]="a:o:model.NewMonopolyRewardRecord", ["rewardTasks"]="a:i", ["specialCast"]="i", ["stepCompleted"]="b", ["substitute"]="i", ["taskProgress"]="m:i", ["tasks"]="a:i"}
T["model.OnlineType"] = {["arg"]="x", ["args"]="x"}
T["model.OpenBoxByCostVo"] = {["costOpenTimes"]="m:i", ["costResults"]="a:o:model.CostResult", ["rewardResults"]="a:o:model.RewardResult"}
T["model.OpenBoxByKeyVo"] = {["keys"]="m:i", ["rewardResults"]="a:o:model.RewardResult"}
T["model.OpenDragonKingVo"] = {["rank"]="i", ["vcoinCost"]="a:o:model.CostResult"}
T["model.OpenVo"] = {["completeCount"]="i", ["completeTasks"]="a:i", ["coolState"]="b", ["coolTime"]="d", ["gottask"]="a:i", ["pickUpTasks"]="a:i", ["refreshCount"]="i", ["targetValues"]="m:i", ["tasks"]="a:i", ["todayBuyCompleteCount"]="i", ["totalCompleteCount"]="i"}
T["model.OrderVo"] = {["addition"]="s", ["money"]="i", ["serial"]="i", ["uniPayOrder"]="s", ["url"]="s"}
T["model.OtherChargeInfo"] = {["id"]="i", ["leaderBaseId"]="i", ["name"]="s", ["playerLevel"]="i", ["rank"]="i", ["score"]="i"}
T["model.OtherConsumeInfo"] = {["id"]="i", ["leaderBaseId"]="i", ["name"]="s", ["playerLevel"]="i", ["rank"]="i", ["score"]="i"}
T["model.OtherQingmingInfo"] = {["id"]="i", ["leaderBaseId"]="i", ["name"]="s", ["playerLevel"]="i", ["rank"]="i", ["score"]="i"}
T["model.PickUpTaskVo"] = {["pickUpTasks"]="a:i", ["totalCompleteCount"]="i"}
T["model.PitchInfo"] = {["buyBalls"]="i", ["level"]="i", ["point"]="i", ["resetTimes"]="i", ["shootData"]="m:o:model.ShootData", ["usedFreeBalls"]="i"}
T["model.PlatformInfo"] = {["firstShare"]="b", ["initiativeCount"]="i", ["passiveCount"]="i"}
T["model.PlayerState"] = {["arg"]="x", ["args"]="x"}
T["model.PlayerVo"] = {["baseId"]="i", ["exp"]="i", ["id"]="i", ["leadership"]="i", ["level"]="i", ["name"]="s", ["pvpDesId"]="i", ["rank"]="i", ["rename"]="b"}
T["model.PointInfo"] = {["point"]="i", ["refreshTime"]="d"}
T["model.PointType"] = {["arg"]="x", ["args"]="x"}
T["model.PositionActionType"] = {["arg"]="x", ["args"]="x"}
T["model.PositionBuffType"] = {["arg"]="x", ["args"]="x"}
T["model.PositionType"] = {["arg"]="x", ["args"]="x"}
T["model.PostVo"] = {["channel"]="i", ["content"]="m:o", ["id"]="i"}
T["model.PraiseRankVO"] = {["rankList"]="a:o:model.RankVO", ["rewardResults"]="a:o:model.RewardResult"}
T["model.PrayVo"] = {["canPrayTime"]="i", ["costs"]="a:o:model.CostResult", ["prayTime"]="i", ["rewards"]="a:o:model.RewardResult"}
T["model.PreciousroomVo"] = {["gotTreasures"]="a:i", ["refreshTimes"]="i", ["time"]="d", ["treasures"]="m:i"}
T["model.ProgressClaimVo"] = {["rewards"]="a:o:model.RewardResult", ["state"]="o:model.ProgressRewardVo"}
T["model.ProgressRewardTierVo"] = {["amount"]="i", ["category"]="s", ["claimed"]="b", ["code"]="i", ["reached"]="b", ["rewardName"]="s", ["rewardType"]="s", ["threshold"]="i"}
T["model.ProgressRewardVo"] = {["level"]="i", ["levelTiers"]="a:o:model.ProgressRewardTierVo", ["loginDays"]="i", ["loginTiers"]="a:o:model.ProgressRewardTierVo", ["powerTiers"]="a:o:model.ProgressRewardTierVo", ["teamPower"]="i"}
T["model.ProgressVo"] = {["battles"]="a:s", ["campaigns"]="a:s", ["current"]="o:model.ResumeVo", ["dailyCounts"]="m:i"}
T["model.PvpInfoVO"] = {["attacked"]="b", ["attackedRecord"]="a:o:model.AttackedRecordVO", ["coolDown"]="i", ["matchList"]="a:o:model.MatchPlayerVO", ["winRanks"]="a:i"}
T["model.PvpRankVO"] = {["artifactLevel"]="i", ["battleScore"]="i", ["cultivateVo"]="o:model.HeroCultivateVo", ["desId"]="i", ["id"]="i", ["leaderBaseId"]="i", ["leaderEquip"]="a:o:model.EquipVo", ["leaderLevel"]="i", ["leaderTalisman"]="a:o:model.TalismanVo", ["level"]="i", ["name"]="s", ["rank"]="i", ["userBuffs"]="a:s", ["vip"]="b"}
T["model.QuickVo"] = {["assistant"]="o:model.CommendVo", ["battleId"]="s", ["exitVo"]="o:model.ExitVo", ["failed"]="b", ["finished"]="b"}
T["model.RaffleRewardVo"] = {["awards"]="a:s", ["costResults"]="a:o:model.CostResult", ["resetTime"]="d", ["reward"]="s", ["rewardResults"]="a:o:model.RewardResult"}
T["model.RaffleVo"] = {["awards"]="a:s", ["count"]="i", ["raffleCount"]="i", ["resetTime"]="d"}
T["model.RankGroupInfoVo"] = {["curGroupId"]="i", ["groups"]="a:o:model.RankGroupVo"}
T["model.RankGroupVo"] = {["artifactLevel"]="i", ["embattles"]="a:a:o:model.RankHeroVo", ["groupId"]="i", ["leaderBaseId"]="i", ["userBuff"]="a:s"}
T["model.RankHeroVo"] = {["baseId"]="i", ["cultivateVo"]="o:model.HeroCultivateVo", ["equips"]="a:o:model.EquipVo", ["leader"]="b", ["level"]="i", ["powerSkill"]="i", ["talisman"]="a:o:model.TalismanVo"}
T["model.RankVO"] = {["artifactLevel"]="i", ["canPraise"]="b", ["id"]="i", ["leaderBaseId"]="i", ["leaderCultivateVo"]="o:model.HeroCultivateVo", ["leaderEquip"]="a:o:model.EquipVo", ["leaderLevel"]="i", ["leaderTalisman"]="a:o:model.TalismanVo", ["level"]="i", ["name"]="s", ["powerSkill"]="i", ["praiseNum"]="i", ["rank"]="i", ["rankValue"]="i", ["userBuffs"]="a:s", ["vip"]="b"}
T["model.RankVo"] = {["baseId"]="i", ["id"]="i", ["level"]="i", ["name"]="s", ["palyerLevel"]="i", ["progress"]="i", ["rank"]="i", ["time"]="i"}
T["model.ReCultivateVo"] = {["costResults"]="a:o:model.CostResult", ["rewardResults"]="a:o:model.RewardResult"}
T["model.RebirthAttackVo"] = {["battleId"]="s", ["costAndReward"]="o:model.CostAndReward", ["finished"]="b", ["groupNum"]="i", ["hasDemog"]="b", ["triggers"]="a:o:model.RebirthTriggerVo"}
T["model.RebirthProgressVo"] = {["activeBuys"]="m:i", ["activeCounts"]="m:i", ["battles"]="a:s", ["buyCount"]="i"}
T["model.RebirthTriggerVo"] = {["coins"]="i", ["drops"]="a:a:o:model.RewardType", ["enemyNum"]="i", ["index"]="i", ["reports"]="a:x", ["success"]="b"}
T["model.ReceiveResult"] = {["rewards"]="a:o:model.RewardResult", ["solds"]="i"}
T["model.RecentLotteryResult"] = {["configId"]="i", ["userName"]="s"}
T["model.RecordItem"] = {["fightScore"]="i", ["groups"]="a:o:model.RankGroupVo", ["id"]="i", ["lostHp"]="i", ["name"]="s", ["round"]="i", ["time"]="d"}
T["model.RecycleCurrencyType"] = {["arg"]="x", ["args"]="x"}
T["model.RecycleThings"] = {["equipIds"]="a:i", ["heroIds"]="a:i", ["talismanIds"]="a:i"}
T["model.RecycleType"] = {["arg"]="x", ["args"]="x"}
T["model.RedCardExchangeVo"] = {["costAndReward"]="o:model.CostAndReward", ["exchangeRecord"]="m:i"}
T["model.RefreshActivityVo"] = {["coolState"]="b", ["coolTime"]="d", ["costResults"]="a:o:model.CostResult", ["tasks"]="a:i"}
T["model.RefreshTaskVo"] = {["buyTimes"]="i", ["costResults"]="a:o:model.CostResult", ["freeTimes"]="i", ["tasks"]="a:i"}
T["model.RefreshVo"] = {["costResults"]="a:o:model.CostResult", ["currency"]="i", ["nextTime"]="d", ["times"]="i", ["treasures"]="m:i"}
T["model.ReleaseTaskItemVo"] = {["cardCount"]="i", ["decreaseCD"]="i", ["exceTimes"]="i", ["id"]="i", ["point"]="i", ["rate"]="i", ["reward"]="i", ["star"]="i", ["successItems"]="a:o:model.TaskSuccessItem"}
T["model.ResetVo"] = {["awards"]="a:s", ["costResults"]="a:o:model.CostResult", ["count"]="i", ["resetTime"]="d"}
T["model.ResumeVo"] = {["assistant"]="o:model.CommendVo", ["battleId"]="s", ["coins"]="i", ["equips"]="i", ["failed"]="b", ["finished"]="b", ["fragments"]="i", ["heros"]="i", ["remains"]="i", ["totalEnemies"]="i"}
T["model.Reward"] = {["amount"]="i", ["code"]="i", ["content"]="s", ["type"]="o:model.RewardType"}
T["model.RewardResult"] = {["additionRate"]="m:i", ["amount"]="i", ["code"]="i", ["contents"]="o", ["mail"]="b", ["type"]="o:model.RewardType"}
T["model.RewardType"] = {["arg"]="x", ["args"]="x"}
T["model.RouletteLotteryVO"] = {["id"]="i", ["nextLevel"]="i", ["rewardResults"]="a:o:model.RewardResult"}
T["model.SecretshopVo"] = {["currency"]="i", ["gotTreasures"]="a:i", ["refreshTimes"]="i", ["time"]="d", ["treasures"]="m:i"}
T["model.SelectSubstitueVo"] = {["buffTimes"]="i", ["costResults"]="a:o:model.CostResult", ["costSubstitute"]="i", ["currBuff"]="s", ["stepCompleted"]="b", ["substitute"]="i"}
T["model.SerialResultVo"] = {["check"]="b", ["giftId"]="s", ["giftName"]="s", ["reward"]="a:o:model.RewardResult", ["url"]="s"}
T["model.ShootData"] = {["hits"]="i", ["rate"]="i", ["times"]="i"}
T["model.ShootVo"] = {["costResults"]="a:o:model.CostResult", ["rewardResults"]="a:o:model.RewardResult"}
T["model.ShopCostRefreshVo"] = {["costRefreshTimes"]="i", ["costResults"]="a:o:model.CostResult", ["exchanges"]="a:i", ["onItems"]="m:i"}
T["model.ShowType"] = {["arg"]="x", ["args"]="x"}
T["model.SlotRecordVo"] = {["id"]="i", ["name"]="s", ["rewardId"]="s", ["rewardResults"]="a:o:model.SlotRewardResult", ["time"]="d"}
T["model.SlotVo"] = {["buyTimes"]="i", ["costtimes"]="i", ["freetimes"]="i", ["positionRewards"]="m:i", ["records"]="a:o:model.SlotRecordVo"}
T["model.SmashType"] = {["arg"]="x", ["args"]="x"}
T["model.SmashVo"] = {["costResult"]="a:o:model.CostResult", ["costSmashCount"]="i", ["eachSmashVOs"]="m:o:model.EachSmashVo", ["eggRewardVos"]="a:o:model.EggRewardVo", ["freeSmashCount"]="i", ["hammer"]="i", ["hammerSmashCount"]="i", ["todaySmash"]="i", ["topRewardVo"]="o:model.TopRewardVo", ["totalCurrency"]="i"}
T["model.SocialityVo"] = {["applys"]="a:o:model.FriendVo", ["extendCount"]="i", ["extendLimit"]="i", ["friends"]="a:o:model.FriendVo", ["gifts"]="a:i", ["recvs"]="a:i", ["sends"]="a:i"}
T["model.SoulStoneType"] = {["arg"]="x", ["args"]="x"}
T["model.SoulstoneExchangeVo"] = {["cost"]="i", ["costType"]="o:model.SoulStoneType", ["rewardResults"]="a:o:model.RewardResult"}
T["model.SpRecordVo"] = {["comment"]="i", ["register"]="i"}
T["model.SummonDemogVo"] = {["baseId"]="i", ["costAndReward"]="o:model.CostAndReward", ["currencyHp"]="i", ["demogId"]="i", ["escapeTime"]="d", ["totalHp"]="i"}
T["model.SuperGiftVo"] = {["buyCount"]="i", ["id"]="i", ["totalLeft"]="i"}
T["model.SwapResult"] = {["costResults"]="a:o:model.CostResult", ["heroVo"]="o:model.HeroVo"}
T["model.SweetExchangeVo"] = {["costResults"]="a:o:model.CostResult", ["exchange"]="a:i", ["onItems"]="m:i", ["rewardResults"]="a:o:model.RewardResult", ["sweets"]="m:i"}
T["model.SweetHouseVo"] = {["authoRefreshDate"]="d", ["costRefreshTimes"]="i", ["exchange"]="a:i", ["onItems"]="m:i", ["sweets"]="m:i"}
T["model.TalismanCostType"] = {["arg"]="x", ["args"]="x"}
T["model.TalismanPackVo"] = {["extendLimit"]="i", ["fragment"]="i", ["id"]="i", ["liebi"]="i", ["used"]="i"}
T["model.TalismanTmpPackVo"] = {["openDragonCount"]="i", ["rank"]="i", ["treasures"]="a:i"}
T["model.TalismanVo"] = {["advanceProgress"]="i", ["baseId"]="i", ["equipHero"]="i", ["exp"]="i", ["id"]="i", ["level"]="i"}
T["model.TargetType"] = {["arg"]="x", ["args"]="x"}
T["model.TaskSuccessItem"] = {["amount"]="i", ["items"]="a:i", ["rate"]="i"}
T["model.TeamEquipInfo"] = {["equipId"]="i", ["heroId"]="i", ["position"]="i"}
T["model.TeamInfoVo"] = {["teamLeaders"]="m:a:i", ["teams"]="m:a:a:a:i"}
T["model.TeamTalismanInfo"] = {["heroId"]="i", ["talismanId"]="a:i"}
T["model.Tips"] = {["content"]="m:o", ["created"]="d", ["id"]="i"}
T["model.TokenCoinExchangeVO"] = {["rewardResult"]="a:o:model.RewardResult", ["tokenCoin"]="i"}
T["model.TopRewardVo"] = {["id"]="i", ["name"]="s", ["rewardResults"]="a:o:model.RewardResult", ["tmp"]="s"}
T["model.TotalDamageRankVo"] = {["damage"]="i", ["id"]="i", ["name"]="s", ["rank"]="i"}
T["model.TreasurePackVo"] = {["rank"]="i", ["treasures"]="a:i"}
T["model.TreasureroomVo"] = {["gotTreasures"]="a:i", ["refreshTimes"]="i", ["roomCurrency"]="i", ["time"]="d", ["treasures"]="m:i"}
T["model.TriggerVo"] = {["coins"]="i", ["drops"]="a:a:o:model.RewardType", ["finished"]="b", ["index"]="i", ["reports"]="x", ["success"]="b"}
T["model.TurkeyRewardRecord"] = {["name"]="s", ["rewardResults"]="a:o:model.TurkeyRewardResult"}
T["model.TurkeyVo"] = {["materials"]="m:i", ["records"]="a:o:model.TurkeyRewardRecord", ["times"]="i", ["turkeys"]="i"}
T["model.UnitRace"] = {["arg"]="x", ["args"]="x"}
T["model.UpNPCLevelVo"] = {["npcCurrentInfo"]="o:model.NPCCurrentInfo", ["releases"]="a:o:model.ReleaseTaskItemVo"}
T["model.UpgradeVo"] = {["costResults"]="a:o:model.CostResult", ["equipVo"]="o:model.EquipVo", ["materials"]="m:i"}
T["model.UserChargeVo"] = {["closeTime"]="d", ["drawedIds"]="a:i", ["nearList"]="a:o:model.OtherChargeInfo", ["rank"]="i", ["score"]="i", ["topList"]="a:o:model.OtherChargeInfo", ["topName"]="s", ["topScore"]="i"}
T["model.UserConsumeVo"] = {["closeTime"]="d", ["drawedIds"]="a:i", ["nearList"]="a:o:model.OtherConsumeInfo", ["rank"]="i", ["score"]="i", ["topList"]="a:o:model.OtherConsumeInfo", ["topName"]="s", ["topScore"]="i"}
T["model.UserGiftVo"] = {["description"]="o:manager.UserDescription", ["id"]="i", ["reward"]="o:manager.GiftReward"}
T["model.UserMessagePageVo"] = {["count"]="i", ["data"]="a:o:model.UserMessageVo", ["page"]="i", ["size"]="i"}
T["model.UserMessageVo"] = {["baseId"]="i", ["date"]="d", ["level"]="i", ["message"]="s", ["name"]="s", ["playerId"]="i", ["skill"]="i"}
T["model.UserQingmingVo"] = {["closeTime"]="d", ["nearList"]="a:o:model.OtherQingmingInfo", ["rank"]="i", ["score"]="i", ["topList"]="a:o:model.OtherQingmingInfo", ["topName"]="s", ["topScore"]="i"}
T["model.ValidActivityVo"] = {["activitys"]="a:o:model.ActivityVo", ["logs"]="m:d"}
T["model.ValidGiftVo"] = {["drawVo"]="o:model.GlobalDrawVo", ["globals"]="a:o:model.GlobalGiftVo", ["spRecord"]="o:model.SpRecordVo", ["users"]="a:o:model.UserGiftVo"}
T["model.VipInfo"] = {["lastChargeDate"]="d", ["monsth"]="b", ["monsthTime"]="d", ["vip"]="b", ["vipTime"]="d", ["week"]="b", ["weekTime"]="d"}
T["model.WalletVo"] = {["copper"]="i", ["coupon"]="i", ["exploit"]="i", ["fragment"]="i", ["friendship"]="i", ["gift"]="i", ["gold"]="i", ["inter"]="i", ["orange"]="i", ["purple"]="i", ["stageCharges"]="m:i", ["stone"]="i", ["totalCharge"]="i"}
T["model.WechatRouletteInfo"] = {["common"]="a:o:model.WechatRouletteRecord", ["fcode"]="a:o:model.WechatRouletteRecord", ["lotteryTimes"]="i"}
T["model.WechatRouletteRecord"] = {["configId"]="i", ["userName"]="s"}
T["model.WechatRouletteVO"] = {["id"]="i", ["rewardResults"]="a:o:model.RewardResult"}
T["model.WithdrawVO"] = {["baseMoney"]="i", ["depositVO"]="o:model.DepositVO", ["income"]="i", ["rewardResults"]="a:o:model.RewardResult"}
T["model.WorldChatMessageVo"] = {["baseId"]="i", ["date"]="d", ["id"]="i", ["level"]="i", ["message"]="s", ["name"]="s", ["playerId"]="i", ["skill"]="i"}
T["model.reward.CurrentInfo"] = {["exp"]="i", ["level"]="i"}
T["model.reward.ItemInfo"] = {["amount"]="i", ["baseId"]="i", ["content"]="s", ["id"]="i", ["itemType"]="o:model.ItemType", ["type"]="o:model.reward.ItemInfoType"}
T["model.reward.ItemInfoType"] = {["arg"]="x", ["args"]="x"}
T["module.BuyGoodsVo"] = {["costs"]="a:o:model.CostResult", ["id"]="i", ["rewards"]="a:o:model.RewardResult"}
T["module.GoodsBuyInfoVo"] = {["drawed"]="a:i", ["id"]="i"}
T["resource.BaseType"] = {["arg"]="x", ["args"]="x"}
T["reward.RewardTestResult"] = {["arg"]="x", ["args"]="x"}

local CMD = {}
CMD[0] = {[-1]={"PUSH_SYSTEM_TIME","i"}, [1]={"REQUEST_DESCRIPTION","x"}, [2]={"SYSTEM_TIME","d"}, [3]={"MD5_DESCRIPTION","s"}}
CMD[10] = {[1]={"CREATE","i"}, [2]={"LOGIN","s"}, [3]={"RELOGIN","i"}, [4]={"CHECK_ACCOUNT","b"}, [5]={"CHECK_FATIGUE_STATE","i"}, [6]={"UPDATE_INCOME_RATE","i"}, [7]={"LOGIN_INFO","o:model.LoginInfoVo"}, [8]={"RENAME","i"}, [9]={"LOGIN_COMPLETE","i"}, [10]={"UPDATE_PUSH","i"}, [11]={"PUSH_STATE","b"}}
CMD[11] = {[1]={"LOTTERY","o:model.CostAndReward"}, [2]={"WALLET","o:model.WalletVo"}, [3]={"VIP","o:model.VipInfo"}, [4]={"ORDER","o:model.OrderVo"}, [8]={"RESETNAME","i"}, [9]={"ROULETTE_LOTTERY","o:model.RouletteLotteryVO"}, [10]={"ROULETTE_LOTTERY_RESULTS","a:o:model.RecentLotteryResult"}, [11]={"GET_LOTTERY_LIST","a:o:model.LotteryListVO"}, [12]={"DAILY_CHECK_INFO","o:model.DailyCheckVO"}, [13]={"DAILY_CHECK_IN","o:model.DailyCheckResultVO"}, [14]={"GET_BUFFS","a:s"}, [15]={"GET_ACTIVITY_MONEY","o:model.ActivityMoneyVo"}, [16]={"TOKEN_COIN_EXCHANGE","o:model.TokenCoinExchangeVO"}, [17]={"GET_CONSUME_RANK","a:o:model.ConsumeActiveRankVO"}, [18]={"GET_OPEN_BETA_GOODS_INFO","m:i"}, [19]={"BUY_OPEN_BETA_GOODS","o:model.BuyOpenBetaGoodsResultVO"}, [20]={"EQUIP_LOTTERY","o:model.EquipLotteryVo"}}
CMD[12] = {[1]={"GET_ITEMS","a:o:manager.Item"}, [2]={"COMPOSE_ITEM","o:model.CostAndReward"}, [3]={"SELL_ITEM","o:model.CostAndReward"}, [4]={"SELL_ITEMS","o:model.CostAndReward"}, [5]={"SWAP","o:model.SwapResult"}}
CMD[13] = {[1]={"ALL_HEROS","o:model.HeroPackVo"}, [2]={"HERO_CURRENT","a:a:i"}, [3]={"EMBATTLE","i"}, [4]={"SWALLOW","o:model.HeroGrowVo"}, [5]={"RANK_UP","o:model.HeroGrowVo"}, [6]={"BUY_PACK","o:model.BuyPackVo"}, [7]={"SELL_HERO","o:model.CostAndReward"}, [8]={"CHANGE_LEADER","a:a:i"}, [9]={"CRUSH_HERO","o:model.CostAndReward"}, [10]={"LOCK","i"}, [11]={"SKILL_UP","o:model.HeroGrowVo"}, [12]={"CURRENT_SCORE","a:i"}, [13]={"HERO_GROUPS","o:model.HeroGroupInfoVo"}, [14]={"SWITCH_HERO_GROUP","i"}, [15]={"EMBATTLE_GROUP","i"}, [16]={"RANK_UP_BY_GOLD","o:model.HeroGrowVo"}, [17]={"SPLIT_HERO","o:model.CostAndReward"}, [18]={"BUY_PACK_BY_COUPON","o:model.BuyPackVo"}, [19]={"GET_RED_CARD_EXCHANGE_INFO","m:i"}, [20]={"RED_CARD_EXCHANGE","o:model.RedCardExchangeVo"}, [21]={"SWITCH_GROUP","b"}, [22]={"UPDATE_TEAM","i"}, [23]={"USE_TEAM","i"}, [24]={"UPDATE_TEAM_NAME","i"}, [25]={"GET_TEAM_INFO","o:model.TeamInfoVo"}, [26]={"COST_RANK_UP","o:model.CostAndReward"}}
CMD[14] = {[1]={"INFO","o:model.TreasurePackVo"}, [2]={"LOOKFOR","o:model.LookForResult"}, [3]={"AUTO_LOOKFOR","a:o:model.LookForResult"}, [4]={"RECEIVE","o:model.ReceiveResult"}}
CMD[15] = {[1]={"GET_POSTS","a:o:model.PostVo"}}
CMD[16] = {[1]={"ALL_GIFTS","o:model.ValidGiftVo"}, [2]={"DRAW_GLOBAL","a:o:model.RewardResult"}, [3]={"DRAW_SERIAL","o:model.SerialResultVo"}, [4]={"DRAW_USER","a:o:model.RewardResult"}, [5]={"HAS_REWARD","b"}, [6]={"SP_RECORD","x"}, [7]={"DRAW_SP_REGISTER","x"}, [8]={"DRAW_SP_COMMENT","x"}, [9]={"GET_ACTIVITYS","o:model.ValidActivityVo"}, [10]={"DRAW_ACTIVITY","a:o:model.RewardResult"}, [11]={"PROGRESS_REWARDS","o:model.ProgressRewardVo"}, [12]={"CLAIM_PROGRESS","o:model.ProgressClaimVo"}}
CMD[17] = {[1]={"GET_MAILBOX","o:model.MailBoxVo"}, [2]={"SEND_USERMAIL","b"}, [3]={"SEND_GROUPMAIL","i"}, [4]={"DRAW_USER","a:o:model.RewardResult"}, [5]={"DRAW_SYSTEM","i"}, [6]={"READ_MAIL","b"}, [7]={"REMOVE_MAIL","b"}, [8]={"HAS_NEW","b"}, [9]={"REMOVE_ALL_MAIL","a:o:model.RewardResult"}}
CMD[19] = {[1]={"GET_SOCIALITY","o:model.SocialityVo"}, [2]={"APPLY_FRIEND","i"}, [3]={"REMOVE_FRIEND","i"}, [4]={"APPLY_CONFIRM","a:o:model.FriendVo"}, [5]={"COMMEND_FRIEND","a:o:model.CommendVo"}, [6]={"BUY_PACK","o:model.BuyPackVo"}, [7]={"SEND_POINT","i"}, [8]={"RECV_POINT","a:o:model.RewardResult"}, [9]={"LIST_APPLYS","a:o:model.FriendVo"}, [10]={"LIST_GIFTS","a:i"}, [11]={"ASK_FOR_POINT","i"}, [12]={"COMAND_ASK_FOR_LIST","a:i"}}
CMD[21] = {[1]={"BUY_SINGLE","o:model.CostAndReward"}, [2]={"CURRENT_POINT","o:model.ActionPointVo"}}
CMD[22] = {[1]={"PROGRESS","o:model.ProgressVo"}, [2]={"ENTER","o:model.EnterVo"}, [3]={"RESUME","o:model.ResumeVo"}, [4]={"TRIGGER","o:model.TriggerVo"}, [5]={"EXIT","o:model.ExitVo"}, [6]={"ACTIVES","o:model.ActiveVo"}, [7]={"DAILYCOUNT","m:i"}, [8]={"QUICK_BATTLE","o:model.QuickVo"}, [9]={"MULTI_ACTION","a:o:model.TriggerVo"}, [10]={"QUICK_ADVANCE","o:model.QuickVo"}, [11]={"FIRST_RECORD","a:o:model.RecordItem"}, [12]={"BEST_RECORD","a:o:model.RecordItem"}}
CMD[23] = {[1]={"COMMOND_GET_ACHIEVE_LIST","a:i"}, [2]={"COMMOND_DRAW_CHAPTER","o:model.AchieveRewardVO"}, [3]={"COMMOND_DRAW","o:model.AchieveRewardVO"}}
CMD[24] = {[1]={"MATCH_LIST","o:model.MatchPlayerListVO"}, [2]={"DEFY_MATCH","o:model.DefyResultVO"}, [3]={"MANUAL_REFRESH_LIST","o:model.MatchPlayerListVO"}, [4]={"INTEGRAL_EXCHANGE","o:model.ExchangeVO"}, [5]={"LINEUP_COMPARE","o:model.LineupCompareVO"}, [6]={"CLEAR_COOL_TIME","a:o:model.CostResult"}, [7]={"GET_RANK_LIST","a:o:model.IntegralRankVO"}, [8]={"BUY_DEFY_TIMES","o:model.BuyTimesVO"}}
CMD[25] = {[1]={"CHAECK_INVITE_CODE","b"}, [2]={"REWARD_LIST","o:model.InviteVO"}, [3]={"ADD_INVITE_CODE","i"}}
CMD[26] = {[1]={"ACTIVE_INFO","o:model.DemogActiveInfoVO"}, [2]={"DEMOG_LIST","o:model.DemogListVO"}, [3]={"ATTACK_DEMOG","o:model.AttackVO"}, [4]={"TOTAL_DAMAGE_RANK","a:o:model.TotalDamageRankVo"}, [5]={"INVITE_FRIEND_ATTACK","i"}, [6]={"MAX_DAMAGE_RANK","a:o:model.RankVO"}, [7]={"FEAT_RANK","a:o:model.RankVO"}, [8]={"BUY_ENERGY","o:model.CostAndReward"}, [9]={"RANK_GROUP_INFO","o:model.RankGroupInfoVo"}, [10]={"DRAW_FEAT_REWARD","a:o:model.RewardResult"}, [11]={"FRAGMENT_EXCHANGE","o:model.ExchangeVO"}, [12]={"GET_ACTIVE_ID","s"}, [13]={"DRAW_KILLED_DEMOG_REWARD","o:model.DemogKilledRewardVO"}, [14]={"REFRESH_DEMOG","o:model.DemogAppearVO"}, [15]={"ALL_RANK","o:model.AllRankVO"}, [16]={"PRAISE_RANK","o:model.PraiseRankVO"}, [17]={"RED_CARD_COMPOSE","o:model.CostAndReward"}}
CMD[27] = {[1]={"PROGRESS","o:model.RebirthProgressVo"}, [2]={"MULTI_ACTION","o:model.RebirthAttackVo"}, [3]={"BUY_TIMES","o:model.BuyTimesVO"}, [4]={"RECORD","a:o:model.RecordItem"}, [5]={"QUICK_BATTLE","o:model.RebirthAttackVo"}, [6]={"QUICK_ADVANCE","o:model.RebirthAttackVo"}, [7]={"QUICK_CAMPAIGN","o:model.CostAndReward"}}
CMD[28] = {[1]={"EXCHANGE","o:model.CostAndReward"}, [2]={"GET_PROGRESS","m:i"}}
CMD[29] = {[1]={"GET_PVP_INFO","o:model.PvpInfoVO"}, [2]={"DEFY_MATCH","o:model.DefyResultVO"}, [3]={"GET_RANK_LIST","a:o:model.PvpRankVO"}, [4]={"LINEUP_COMPARE","o:model.LineupCompareVO"}, [5]={"CLEAR_COOL_DOWN","a:o:model.CostResult"}}
CMD[30] = {[1]={"DRAW_PRAISE_REWARD","i"}, [2]={"INITIATIVE_SHARE","o:model.InitiativeShareVo"}, [3]={"PASSIVE_SHARE","i"}, [4]={"GET_COMMON_INFO","o:model.WechatRouletteInfo"}, [5]={"ROULETTE","o:model.WechatRouletteVO"}}
CMD[31] = {[1]={"GET_DEPOSIT_INFO","o:model.DepositVO"}, [2]={"DEPOSIT","o:model.DepositResultVO"}, [3]={"WITHDRAW","o:model.WithdrawVO"}}
CMD[40] = {[-1]={"PUSH_TIPS","i"}, [1]={"GET_OFFLINE","a:o:model.Tips"}}
CMD[44] = {[1]={"SEND","i"}, [2]={"VERIFY","a:o:model.RewardResult"}}
CMD[45] = {[1]={"ENTER","o:model.BeeEffGeeVo"}, [2]={"INJECT_SOULSTONE","i"}, [3]={"BUY_INJECT_SOULSTONE","i"}, [4]={"BUY_SOULSTONE","o:model.BuySoulstoneVo"}, [5]={"GET_RANK_LIST","a:o:model.RankVo"}, [6]={"INJECT_SOUL_ONCE","o:model.InjectSoulstoneVo"}, [7]={"INJECT_SOUL_REPEATEDLY","o:model.InjectSoulRepeatedlyVo"}, [8]={"SOUL_STONE_EXCHANGE","o:model.SoulstoneExchangeVo"}, [9]={"SOUL_STONE_EXCHANGE_BY_TYPE","o:model.SoulstoneExchangeVo"}}
CMD[46] = {[1]={"GET_REWARD","a:o:model.RewardResult"}, [2]={"LOAD_REWARD_INFO","o:model.LoadRewardInfoVo"}}
CMD[47] = {[1]={"JOIN_MENPAI","o:model.ApplyMenpaiInfoVo"}, [2]={"GET_SELEF_MENPAI","o:model.MenpaiInfoVo"}, [3]={"GET_MENPAI_LIST","o:model.ApplyMenpaiInfoPageVo"}, [4]={"GET_PARTNER_LIST","o:model.MenpaiPartnerPageVo"}, [5]={"INVITE_PARTNER","o:model.JoinState"}, [6]={"LIST_APPLY_USER","o:model.BasicUserPageVo"}, [7]={"CHECK_USER","i"}, [8]={"LIST_INVITE_MENPAI","o:model.InviteMenpaiInfoPageVo"}, [9]={"CHECK_INVITE_MENPAI","o:model.MenpaiInfoVo"}, [10]={"CHANGE_POST","i"}, [11]={"GIVE_MESSAGE","i"}, [12]={"LIST_MESSAGE","o:model.UserMessagePageVo"}, [13]={"UPDATE_DECLARATION","i"}, [14]={"CONTRIBUTE_MENPAI","o:model.ContributeMenpaiVo"}, [15]={"BID_RANK","i"}, [16]={"KICK_USER","i"}, [17]={"CREATE_MENPAI","a:o:model.CostResult"}, [18]={"SET_MEMBER_JOB","i"}, [19]={"TRANSFER_BOSS","i"}, [20]={"GRAB_TIGHT","d"}, [21]={"STOP_GRAB_RIGHT","i"}, [22]={"SPRING_DRINK","i"}, [23]={"PRAY","o:model.PrayVo"}, [26]={"QUIT_MENPAI","i"}, [27]={"SUMMON_DEMOG","o:model.SummonDemogVo"}, [28]={"LIST_DEMOG","o:model.DemogPageVo"}, [29]={"CLEAR_COOLTIME","a:o:model.CostResult"}, [30]={"ATTACK_DEMOG","o:model.AttackVo"}, [31]={"DRAW_REWARD","a:o:model.RewardResult"}, [32]={"SINGLE_PARTNER","o:model.MenpaiPartnerVo"}, [33]={"DISBAND_MENPAI","i"}, [34]={"CANCEL_APPLY","o:model.ApplyMenpaiInfoVo"}, [35]={"COUNTRY_DATA","o:model.CountryVo"}, [37]={"BID_FOR_COUNTRY","o:model.MenpaiBidResultVo"}, [38]={"COUNTRY_FIGHT_JOINED","o:model.CountryFigthJoinedVo"}, [39]={"COUNTRY_FIGHT_RESULT","o:model.CountryFightReportVo"}, [40]={"GET_GOODS","o:model.MenpaiGoodsInfoVo"}, [41]={"EXCHAGE_GOODS","o:model.CostAndReward"}, [43]={"QUIT_COUNTRY_FIGHT","o:model.CountryFigthJoinedVo"}, [44]={"MENPAI_RENAME","i"}}
CMD[48] = {[1]={"OPEN","o:model.OpenVo"}, [2]={"FREE_REFRESH_ACTIVITY","o:model.RefreshActivityVo"}, [3]={"REFRESH_ACTIVITY","o:model.RefreshActivityVo"}, [4]={"BUY_TASK","o:model.BuyTaskVo"}, [5]={"IMMEDIATELY_COMPLETE_TASK","o:model.CompleteTaskVo"}, [6]={"GET_REWARD","o:model.GetRewardVo"}, [7]={"ADVANCED_REFRESH_ACTIVITY","o:model.RefreshActivityVo"}, [8]={"PICK_UP_TASK","o:model.PickUpTaskVo"}, [9]={"GIVE_UP","o:model.GiveUpVo"}, [10]={"CLEAR_COOL_TIME","a:o:model.CostResult"}}
CMD[49] = {[1]={"LOAD_ALL_HERO_TALISMAN","a:o:model.HeroTalismanVo"}, [2]={"LOAD_ALL_TALISMAN","a:o:model.TalismanVo"}, [3]={"EQUIP_TALISMAN","a:i"}, [4]={"UNEQUIP_TALISMAN","a:i"}, [5]={"EXCHANGE_TALISMAN","o:model.ExchangeVO"}, [6]={"LOAD_TALISMAN","o:model.TalismanVo"}, [7]={"UPGRADE_TALISMAN","o:model.TalismanVo"}, [8]={"GET_FRAGMENT","o:model.TalismanPackVo"}, [9]={"CELL_TALISMAN","a:o:model.RewardResult"}, [10]={"GET_TALISMAN_TMP_PACK_INFO","o:model.TalismanTmpPackVo"}, [11]={"LOOKFOR","o:model.LookForResult"}, [12]={"AUTO_LOOKFOR","a:o:model.LookForResult"}, [13]={"RECEIVE","o:model.ReceiveResult"}, [14]={"OPEN_DRAGON_KING","o:model.OpenDragonKingVo"}, [15]={"BUY_TALISMAN_PACK_SPACE","o:model.BuyTalismanPackSpaceVo"}, [16]={"GET_GAINED_REWARDS","m:a:s"}, [17]={"GAIN_REWARD","a:o:model.RewardResult"}, [18]={"REPLACE_HERO_TALISMANS","a:i"}, [19]={"BUY_TALISMAN_PACK_SPACE_BY_COUPON","o:model.BuyTalismanPackSpaceVo"}, [20]={"CONVERT_TALISMAN","o:model.TalismanVo"}, [21]={"ADVANCE_TALISMAN","o:model.TalismanVo"}, [22]={"ADVANCE_SWALLOW_TALISMAN","o:model.TalismanVo"}}
CMD[50] = {[1]={"COOK_COOLTIME","o:model.CookCoolTimeVo"}, [2]={"DUMPLING_STATE","i"}, [3]={"COOK","o:model.CookVo"}, [4]={"GET_COOK_REWARD","a:o:model.RewardResult"}, [5]={"CLEAR_COOL_TIME","a:o:model.CostResult"}}
CMD[51] = {[1]={"PLAYER_BUY_INFO","a:o:module.GoodsBuyInfoVo"}, [2]={"BUY_GOODS","o:module.BuyGoodsVo"}, [3]={"DRAW_REWARD","a:o:model.RewardResult"}}
CMD[52] = {[1]={"LOAD_EGG_INFO","o:model.EggVo"}, [2]={"SMASH","o:model.SmashVo"}}
CMD[53] = {[1]={"LOAD_TREASUREROOM","o:model.TreasureroomVo"}, [2]={"REFRESH","o:model.CostRefreshVo"}, [3]={"EXCHANGE","o:model.ExchangeVo"}}
CMD[54] = {[1]={"OPEN_BOX_BY_KEY","o:model.OpenBoxByKeyVo"}, [2]={"OPEN_BOX_BY_CURRENCY","o:model.OpenBoxByCostVo"}, [3]={"LOAD_BOX_INFO","o:model.BoxVo"}}
CMD[55] = {[1]={"GET_INFO","o:model.UserConsumeVo"}, [2]={"DRAW_SCORE_REWARD","a:o:model.RewardResult"}}
CMD[56] = {[1]={"LOAD_ALL_EQUIPS","i"}, [2]={"EQUIP","o:model.EquipVo"}, [3]={"COMPOSE","o:model.ComposeVo"}, [4]={"MELT","a:o:model.RewardResult"}, [5]={"BUY_EQUIP_PACK_SPACE","a:o:model.CostResult"}, [6]={"LOAD_EQUIP_PACK","o:model.EquipPackSpaceVo"}, [7]={"UNEQUIP_POSITION","b"}, [8]={"UPGRADE","o:model.UpgradeVo"}, [9]={"BUY_EQUIP_PACK_SPACE_BY_COUPON","a:o:model.CostResult"}}
CMD[57] = {[1]={"LOAD_SECRETSHOP","o:model.SecretshopVo"}, [2]={"REFRESH","o:model.RefreshVo"}, [3]={"EXCHANGE","o:model.ExchangeVo"}}
CMD[58] = {[1]={"LOAD_RAFFLE","o:model.RaffleVo"}, [2]={"REFRESH","o:model.ResetVo"}, [3]={"RAFFLE","o:model.RaffleRewardVo"}}
CMD[59] = {[1]={"GET_INFO","o:model.UserChargeVo"}, [2]={"DRAW_SCORE_REWARD","a:o:model.RewardResult"}}
CMD[60] = {[1]={"INFO","o:model.InfoVo"}, [2]={"FLOP","o:model.FlopVo"}, [3]={"RESET","o:model.ResetVo"}}
CMD[61] = {[1]={"PROGRESS","o:model.EliteProgressVo"}, [2]={"MULTI_ACTION","o:model.EliteAttackVo"}, [6]={"BUY_TIMES","o:model.BuyTimesVO"}, [7]={"RECORD","a:o:model.EliteRecordItem"}, [8]={"GET_BATTLES_TIMES","o:model.BattlesTimesVo"}, [9]={"QUICK_ADVANCE","o:model.QuickVo"}, [10]={"FIRST_RECORD","a:o:model.EliteRecordItem"}}
CMD[62] = {[1]={"GET_INFO","o:model.UserQingmingVo"}, [2]={"JIBAI","o:model.JiBaiVo"}, [3]={"GET_JIBAI_PAGE","o:model.JiBaiPageVo"}}
CMD[63] = {[1]={"GET_INFO","o:model.JuhuansuanVo"}, [2]={"BUY_GOODS","o:model.CostAndReward"}}
CMD[64] = {[1]={"INFO","o:model.InfoVo"}, [2]={"BUY","o:model.BuyVo"}}
CMD[65] = {[1]={"LOAD_EQUIP_GIFT","m:o:model.BuyTimesVo"}, [2]={"BUY_EQUIP_GIFT","o:model.BuyEquipgiftVo"}}
CMD[66] = {[1]={"LOAD_PITCH","o:model.PitchInfo"}, [2]={"SHOOT","a:o:model.RewardResult"}, [3]={"SHOOT_BY_CURRENCY","o:model.ShootVo"}}
CMD[67] = {[1]={"GET_INFO","a:o:model.SuperGiftVo"}, [2]={"BUY_GOODS","o:model.BuyResult"}}
CMD[68] = {[1]={"UPLOAD_API_ARGS","i"}, [2]={"QUERY_BALANCE","o:model.WalletVo"}}
CMD[69] = {[1]={"INFO","o:model.BlessingVo"}, [2]={"LOTTERY","o:model.LotteryVo"}}
CMD[70] = {[1]={"LOAD_GEM_ROOM","o:model.GemroomVo"}, [2]={"REFRESH","o:model.RefreshVo"}, [3]={"EXCHANGE","o:model.ExchangeVo"}, [4]={"CLEAR_COOL_TIME","a:o:model.CostResult"}}
CMD[73] = {[1]={"GET_INFO","o:model.GodRewardVo"}, [2]={"REFRESH_TASK","o:model.RefreshTaskVo"}, [3]={"BUY_REFRESH_TASK","o:model.RefreshTaskVo"}, [4]={"ACCEPT_TASK","m:i"}, [5]={"GIVE_UP_TASK","o:model.GiveUpTaskVo"}, [6]={"GET_TASK_REWARD","o:model.GetTaskRewardVo"}, [7]={"GET_FEAT_REWARD","o:model.GetFeatRewardVo"}}
CMD[74] = {[1]={"MOON_INFO","o:model.MoonVo"}, [2]={"COMPOSE_MOON","o:model.MoonComposeVo"}, [3]={"BUY_MOON","o:model.BuyMoonResultVo"}, [4]={"EXHCNAGE","o:model.MoonExchangeVo"}}
CMD[75] = {[1]={"LOAD_MONOPOLY","o:model.MonopolyVo"}, [2]={"DICE","o:model.DiceVo"}, [3]={"ADVANCE_DICE","o:model.DiceVo"}, [4]={"DRAW_TASK_REWARD","a:o:model.RewardResult"}, [5]={"GIVEUP_TASK","b"}, [6]={"BUY_GOODS","o:model.BuyGoodsResult"}, [7]={"DRAW_BOX_REWARD","a:o:model.RewardResult"}, [8]={"COST_DICE","o:model.DiceVo"}, [9]={"COST_ADVANCE_DICE","o:model.DiceVo"}, [10]={"PICKUP_TASK","b"}, [11]={"COMPLET_TASK","a:o:model.CostResult"}}
CMD[76] = {[1]={"LOAD_INFO","o:model.CultivateVo"}, [2]={"COMPOUND_ELIXIR","o:model.CompoundElixirVo"}, [3]={"SWALLOW_ELIXIR","m:i"}, [4]={"RE_CULTIVATE","o:model.ReCultivateVo"}, [5]={"HERO_CROSSING","o:model.CrossingVo"}}
CMD[78] = {[1]={"LOAD_INFO","o:model.SlotVo"}, [2]={"LOTTERY","o:model.LotteryVo"}}
CMD[79] = {[1]={"GET_INFO","o:model.SweetHouseVo"}, [2]={"COST_REFRESH","o:model.CostRefreshVo"}, [3]={"SWEET_EXCHANGE","o:model.SweetExchangeVo"}}
CMD[80] = {[1]={"LOAD_INFO","o:model.ExchangeInfo"}, [2]={"LOAD_EXCHANGE","o:model.ExchangeVo"}}
CMD[81] = {[1]={"GET_INFO","o:model.CultivateShopVo"}, [2]={"COST_REFRESH","o:model.ShopCostRefreshVo"}, [3]={"SHOP_EXCHANGE","o:model.ItemExchangeVo"}}
CMD[82] = {[1]={"LOAD_TURKEY","o:model.TurkeyVo"}, [2]={"BUY_MATERIAL","o:model.CostAndReward"}, [3]={"MAKE_TURKEY","o:model.CostAndReward"}, [4]={"MAKE_TURKEY_BY_CURRENCY","o:model.CostAndReward"}, [5]={"EAT_TURKEY","o:model.EatVo"}}
CMD[83] = {[1]={"LOAD_CHARGERETURN","o:model.ChargereturnVo"}, [2]={"DRAW_REWARD","a:o:model.RewardResult"}}
CMD[84] = {[1]={"RECYCLE","o:model.CostAndReward"}}
CMD[85] = {[1]={"LOAD_SHOP","o:model.ExchangeshopVo"}, [2]={"REFRESH","o:model.RefreshVo"}, [3]={"EXCHANGE","o:model.ExchangeVo"}}
CMD[86] = {[1]={"LOAD_EXPLORE_INFO","o:model.ExploreVo"}, [2]={"COST_REFRESH_RELEASE","o:model.CostRefreshVo"}, [3]={"EXECUTE_TASK","o:model.ExecuteTaskVo"}, [4]={"IMMEDIATE_FINISH","o:model.DrawTaskRewardVo"}, [5]={"GET_FRIEND_CARDS","a:o:model.FriendLeaderVo"}, [6]={"DRAW_TASK_REWARD","o:model.DrawTaskRewardVo"}, [7]={"UP_NPC_LEVEL","o:model.UpNPCLevelVo"}, [8]={"OWNER_FIGHT_SCORE","m:i"}, [9]={"BUY_NPC_EXP","o:model.BuyNPCExpVO"}}
CMD[87] = {[1]={"LOAD_NEWMONOPOLY","o:model.NewMonopolyVo"}, [2]={"CAST_DICE","o:model.CastDiceVo"}, [3]={"COST_CAST_DICE","o:model.CastDiceVo"}, [4]={"CAST_SPEICAL_DICE","o:model.CastDiceVo"}, [5]={"COST_CAST_SPEICAL_DICE","o:model.CastDiceVo"}, [6]={"ACCEPT_TASK","o:model.MonopolyTaskVo"}, [7]={"GIVE_UP_TASK","o:model.MonopolyTaskVo"}, [8]={"COMPLETE_TASK","o:model.MonopolyTaskVo"}, [9]={"DRAW_TASK_REWARD","o:model.MonopolyTaskVo"}, [10]={"BUG_GOODS","o:model.BuyGoodsVo"}, [11]={"SELECT_ROUTE","i"}, [12]={"SELECT_SUBSTITUE","o:model.SelectSubstitueVo"}, [13]={"DRAW_BOX_REWARD","o:model.DrawBoxRewardVo"}}
CMD[90] = {[1]={"LOAD_INFO","o:model.ActivitychargeVo"}, [2]={"DRAW","a:o:model.RewardResult"}}
CMD[91] = {[1]={"LOAD_SHOP","o:model.PreciousroomVo"}, [2]={"EXCHANGE","o:model.ExchangeVo"}, [3]={"REFRESH","o:model.RefreshVo"}}
CMD[92] = {[1]={"GET_LIST","a:o:model.WorldChatMessageVo"}, [2]={"SEND","o:model.WorldChatMessageVo"}}
CMD[158] = {[1]={"ENEMY_ENEMY","o:model.FightReport"}, [2]={"PLAYER_ENEMY","o:model.FightReport"}, [3]={"PLAYER_PLAYER","o:model.FightReport"}, [4]={"COUNT_ENEMY_ENEMY","o:model.BattleInfo"}, [5]={"COUNT_PLAYER_ENEMY","o:model.BattleInfo"}, [6]={"COUNT_PLAYER_PLAYER","o:model.BattleInfo"}}
CMD[159] = {[1]={"TEST_REWARD","a:o:model.Reward"}, [2]={"TEST_REWARD_REPEAT","m:o"}}

-- ================= 游戏状态与持久化 =================
-- 完整玩家数据存到 local_save.txt（JSON）
LS.STARTER_HEROS = { 1001, 1002, 1021, 1042, 1061, 1143 }
-- 敌方怪物池（关卡怪物 baseId：铁甲牛妖/小蜘怪/蛤蟆精/白骨近卫/幽魂侍女/夜叉鬼/小萌牛/牛头勇士）
LS.MONSTER_POOL = { 11, 21, 31, 41, 51, 61, 71, 81 }
-- AI 陪玩（好友援军）：玩家可选一个 AI 英雄作为第 6 名上阵援军
LS.AI_FRIENDS = { 1163, 1183, 1203, 1223, 1407, 1367 }  -- 哪吒/红孩儿/牛魔王/铁扇公主/二郎神/观音
-- 阵位随等级解锁：初始 3 个，13 级第 4 个，40 级第 5 个（第 6 个为好友援军槽）
LS.FORMATION_BASE = 3
-- 抽卡可获得的英雄池（各角色 1 星基础形态 baseId）
LS.DRAW_HEROS = { 1001, 1002, 1021, 1042, 1061, 1081, 1102, 1143, 1163, 1183, 1203, 1223, 1367, 1407, 1487, 1783, 2603, 2623, 3303, 3603 }
-- 置 true 时登录即预通关所有主线章节，全部关卡/功能开放（调试用）
LS.UNLOCK_ALL = true

local function defaultState()
  return {
    account = LS.ACCOUNT,
    roleName = LS.PLAYER_NAME or "本地玩家",
    roleCreated = true,
    player = { level = 1000, exp = 0 },
    physical = { point = 999, refreshTime = os.time() * 1000 },
    wallet = { copper = 9999999, gold = 999999, gift = 999999, stone = 999999, inter = 999999, friendship = 999999, fragment = 999999, coupon = 999999, exploit = 999999, orange = 999999, purple = 999999 },
    heroes = {},
    group = { curGroupId = 1, groups = { { groupId = 1, leaderId = 0, embattles = {} } } },
    battles = {},
    campaigns = {},
    dailyCounts = {},
    nextHeroId = 100001,
  }
end
LS.state = defaultState()

function LS.stateFile()
  local doc = CVariableSystem:GetSingleton():GetSysVariable(GV_DOCPATH)
  if doc == nil then return nil end
  return doc .. "local_save.txt"
end
function LS.saveState()
  local f = LS.stateFile()
  if f == nil then return end
  local ok, h = pcall(io.open, f, "w")
  if not ok or h == nil then return end
  h:write(json.encode(LS.state))
  io.close(h)
end
function LS.loadState()
  local f = LS.stateFile()
  if f == nil then return end
  local h = io.open(f, "r")
  if h == nil then return end
  local s = h:read("*a")
  io.close(h)
  if s and #s > 0 then
    local ok, t = pcall(function() return json.decode(s) end)
    if ok and type(t) == "table" then
      LS.state = t
    end
  end
end

-- 自动登录：先把 Login.objLoginInfo 需要的字段补齐，再调 HostAdapter.OnLogin
-- 幂等：EnvLogic:Login 和 GameStageLogout 的定时器都可能触发，只允许登录一次
function LS.autoLogin()
  if LS.loggedIn then
    return
  end
  LS.loggedIn = true
  local login = Logic:Get("Login")
  local info = login:GetLoginInfo()
  if type(info) ~= "table" then info = {} end
  local opId = tonumber(Logic:Get("System"):GetOperatorId()) or 24
  info.account = LS.state.account
  info.operator = opId
  info.server = 1
  info.addr = "127.0.0.1"
  info.port = 9001
  info.originUserId = LS.state.account
  info.sign = "localsign"
  info.time = os.time()
  info.name = LS.state.roleName
  -- The original HTTP server-info response normally initializes NetMgr.
  -- Offline login bypasses that HTTP request, so point the unchanged TCP
  -- transport at the local endpoint before the first PostPrior call.
  Singleton(NetMgr):SetUrlAndPort(info.addr, info.port)
  local acc = string.format('{"userId":"%s","userName":"%s","anonymity":false,"type":"login"}',
                            LS.state.account, LS.state.roleName)
  log4misc:warn("[LocalServer] autoLogin account=" .. LS.state.account .. " op=" .. tostring(opId))
  if _G.OnLogin then
    _G.OnLogin(0, acc)
  else
    log4misc:warn("[LocalServer] OnLogin not found!")
  end
end

-- ================= 默认值生成器 =================
local function zero(spec, depth)
  depth = (depth or 0) + 1
  if depth > 6 or spec == nil then return 0 end
  local k = string.sub(spec, 1, 1)
  if k == 'i' then return 0
  elseif k == 's' then return ""
  elseif k == 'b' then return false
  elseif k == 'd' then return 0
  elseif k == 'e' then return 0
  elseif k == 'x' then return 0
  elseif k == 'a' then return {}
  elseif k == 'm' then return {}
  elseif k == 'o' then
    local tn = string.sub(spec, 3)
    local fields = T[tn]
    local r = {}
    if fields then
      for f, fs in pairs(fields) do r[f] = zero(fs, depth) end
    end
    return r
  end
  return 0
end
LS.zero = zero

-- 万能空对象（null object）：
-- schema 没覆盖到的字段用零值补不全，下游可能出现
--   data.activitys.drawVo        -> attempt to index a nil value
--   r.weekTime + 86400           -> attempt to perform arithmetic on a nil/table value
-- 单个 dummy 同时支持「无限索引」和「所有算术/拼接/比较元方法」，
-- 于是无论下游怎么取用都不会抛错，登录流程能一路走完。
local DUMMY = setmetatable({}, {
  __index = function(t, k) return t end,
  __newindex = function() end,
  __add = function() return 0 end,
  __sub = function() return 0 end,
  __mul = function() return 0 end,
  __div = function() return 0 end,
  __mod = function() return 0 end,
  __pow = function() return 0 end,
  __unm = function() return 0 end,
  __len = function() return 0 end,
  __concat = function(a, b)
    if type(a) == 'string' then return a end
    if type(b) == 'string' then return b end
    return ""
  end,
  __eq = function() return false end,
  __lt = function() return false end,
  __le = function() return false end,
  __call = function(t) return t end,
  __tostring = function() return "" end,
})
LS.DUMMY = DUMMY

-- 递归把每一层表都接上 dummy（schema 已给出的真实零值仍保留）
local function vivify(t)
  -- Preserve absent fields as nil. A truthy dummy changes game decisions
  -- (pending battles, guild membership, rename prompts and feature locks).
  return t
end
LS.vivify = vivify

-- 深合并：把 patch 覆盖到默认值上
local function merge(base, patch)
  if type(base) ~= 'table' or type(patch) ~= 'table' then return patch end
  for k, v in pairs(patch) do
    if type(v) == 'table' and type(base[k]) == 'table' then
      merge(base[k], v)
    else
      base[k] = v
    end
  end
  return base
end
LS.merge = merge

-- 把数字编码成协议 long 的字节串（客户端内部 long 就是这种字符串）
local function longid(n)
  n = tonumber(n) or 0
  local sign = n < 0
  n = math.abs(math.floor(n))
  local flag = sign and 0x1A or 0x12
  if n == 0 then return string.char(flag, 0x00) end
  local bytes = {}
  while n > 0 do
    table.insert(bytes, 1, n % 256)
    n = math.floor(n / 256)
  end
  return string.char(flag, 0x80 + #bytes) .. string.char(unpack(bytes))
end
LS.longid = longid

-- 调试：枚举关键配置表，把字段名 + 记录 dump 到文件（排查真实字段名/数据）
local function dumpConfig()
  local doc = LS.stateFile()
  if doc == nil then return end
  local path = string.gsub(doc, "local_save.txt$", "config_probe.txt")
  local ok, h = pcall(io.open, path, "w")
  if not ok or h == nil then
    log4misc:warn("[LocalServer] dumpConfig open fail: " .. tostring(path))
    return
  end
  local function dumpTable(name)
    local okamt, n = pcall(KFDBGetRecordAmt, name)
    h:write("=== " .. name .. " count=" .. tostring(n) .. " ok=" .. tostring(okamt) .. " ===\n")
    if not okamt or type(n) ~= "number" then
      h:write("  (cannot enumerate)\n")
      return
    end
    for i = 1, n do
      local okr, r = pcall(KFDBGetRecordByIdx, name, i)
      if okr and type(r) == "table" then
        local parts = {}
        local keys = {}
        for k in pairs(r) do table.insert(keys, tostring(k)) end
        table.sort(keys)
        if i <= 3 then
          for _, k in ipairs(keys) do
            table.insert(parts, k .. "=" .. tostring(r[k]))
          end
          h:write("  [" .. i .. "] " .. table.concat(parts, " | ") .. "\n")
        else
          h:write("  [" .. i .. "] id=" .. tostring(r.id) .. " name=" .. tostring(r.name) .. "\n")
        end
      end
    end
    h:write("\n")
  end
  dumpTable("BaseHero")
  dumpTable("CampaignConfig")
  dumpTable("BattleInfoConfig")
  dumpTable("SkillConfig")
  dumpTable("HeroLevelConfig")
  dumpTable("ComposeConfig")
  io.close(h)
  log4misc:warn("[LocalServer] dumpConfig wrote " .. path)
end
LS.dumpConfig = dumpConfig

-- ================= 显式处理器 =================
-- 每个处理器: function(req, mod, cmd) return content, attach end
LS.handlers = {}
local H = LS.handlers

-- ===== 工具 =====
local function inSet(lst, v)
  if type(lst) ~= "table" then return false end
  for _, x in ipairs(lst) do if x == v then return true end end
  return false
end

-- 把协议 long 字节串还原成数字
local function unlongid(s)
  if type(s) ~= "string" then return tonumber(s) or 0 end
  local b = { string.byte(s, 1, #s) }
  if #b < 2 then return tonumber(s) or 0 end
  local sign = (b[1] % 16 >= 8) and -1 or 1
  local val = 0
  for i = 3, #b do val = val * 256 + b[i] end
  return sign * val
end
LS.unlongid = unlongid

local function baseHero(baseId)
  local ok, r = pcall(KFDBGetRecord, "BaseHero", baseId)
  if ok and type(r) == "table" then return r end
  return nil
end
local function baseBattle(battleId)
  local ok, r = pcall(KFDBGetRecord, "BattleInfoConfig", battleId)
  if ok and type(r) == "table" then return r end
  return nil
end
local function getJson(str)
  if type(str) == "string" and str ~= "" then
    local ok, t = pcall(function() return json.decode(str) end)
    if ok and type(t) == "table" then return t end
  end
  return {}
end
local function heroStats(baseId, level)
  local info = baseHero(baseId)
  local iv, ig = {}, {}
  if info then
    iv = getJson(info.initValues)
    ig = getJson(info.initGrows)
  end
  local hp = math.floor((iv.LIFE or 100) + (level or 1) * (ig.LIFE or 10))
  local atk = math.floor((iv.ATTACK or 10) + (level or 1) * (ig.ATTACK or 2))
  return hp, atk
end
local function getHeroSwallowExp(baseId, level)
  local info = baseHero(baseId)
  if not info then return 0 end
  return math.floor((tonumber(info.baseExp) or 0) + (level or 1) * (tonumber(info.growExp) or 0))
end
local function getHeroNextExp(baseId, level)
  local lv = KFDBGetRecord("HeroLevelConfig", level)
  local info = baseHero(baseId)
  local base = (lv and tonumber(lv.exp)) or 100
  local rate = (info and tonumber(info.expRate)) or 1
  return math.floor(base * rate)
end

-- ===== 英雄/阵型 =====
local function heroById(id)
  for _, h in ipairs(LS.state.heroes) do
    if h.id == id then return h end
  end
  return nil
end
local function heroToClient(h)
  return {
    id = LS.longid(h.id),
    baseId = h.baseId,
    exp = h.exp or 0,
    level = h.level or 1,
    locked = h.locked or false,
    powerSkill = h.powerSkill or 0,
    skillExp = h.skillExp or 0,
  }
end
local function removeHero(id)
  for i = #LS.state.heroes, 1, -1 do
    if LS.state.heroes[i].id == id then
      table.remove(LS.state.heroes, i)
      break
    end
  end
  local g = LS.state.group and LS.state.group.groups and LS.state.group.groups[1]
  if g then
    for r = 1, #g.embattles do
      for c = 1, #g.embattles[r] do
        if g.embattles[r][c] == id then g.embattles[r][c] = 0 end
      end
    end
    if g.leaderId == id then
      g.leaderId = LS.state.heroes[1] and LS.state.heroes[1].id or 0
    end
  end
end

local function addNewHero(baseId)
  LS.state.nextHeroId = LS.state.nextHeroId or 100001
  local info = baseHero(baseId)
  local h = {
    id = LS.state.nextHeroId, baseId = baseId, level = 1, exp = 0,
    locked = false, powerSkill = (info and tonumber(info.powerSkill)) or 0, skillExp = 0,
  }
  LS.state.nextHeroId = LS.state.nextHeroId + 1
  table.insert(LS.state.heroes, h)
  LS.saveState()
  return h
end

local function ensureRoster()
  if LS.state.heroes and #LS.state.heroes > 0 then return end
  LS.state.heroes = {}
  LS.state.nextHeroId = LS.state.nextHeroId or 100001
  for i, baseId in ipairs(LS.DRAW_HEROS) do
    local info = baseHero(baseId)
    table.insert(LS.state.heroes, {
      id = LS.state.nextHeroId, baseId = baseId, level = 10, exp = 0,
      locked = false, powerSkill = (info and tonumber(info.powerSkill)) or 0, skillExp = 0,
    })
    LS.state.nextHeroId = LS.state.nextHeroId + 1
  end
  -- 默认阵型 3 行 x 2 列；只填等级解锁的阵位（初始 3 个），其余留空
  local function openSlots()
    local lv = LS.state.player and LS.state.player.level or 1
    local n = LS.FORMATION_BASE
    if lv >= 13 then n = n + 1 end
    if lv >= 40 then n = n + 1 end
    return n
  end
  local embattles = {}
  local idx = 1
  local maxOpen = openSlots()
  for r = 1, 3 do
    embattles[r] = {}
    for c = 1, 2 do
      local h = nil
      if idx <= maxOpen then h = LS.state.heroes[idx] end
      embattles[r][c] = h and h.id or 0
      idx = idx + 1
    end
  end
  LS.state.group = {
    curGroupId = 1,
    groups = { { groupId = 1, leaderId = LS.state.heroes[1].id, embattles = embattles } },
  }
  LS.saveState()
end

-- 测试模式：预通关所有主线章节，让全部关卡/功能开放
local function ensureFullUnlock()
  if LS.state.unlockedAll then return end
  LS.state.unlockedAll = true
  local n = KFDBGetRecordAmt("BattleInfoConfig")
  for i = 1, n do
    local r = KFDBGetRecordByIdx("BattleInfoConfig", i)
    if type(r) == "table" and r.id and not inSet(LS.state.battles, r.id) then
      table.insert(LS.state.battles, r.id)
    end
  end
  local nc = KFDBGetRecordAmt("CampaignConfig")
  for i = 1, nc do
    local r = KFDBGetRecordByIdx("CampaignConfig", i)
    if type(r) == "table" and r.id and r.type == "NORMAL" and not inSet(LS.state.campaigns, r.id) then
      table.insert(LS.state.campaigns, r.id)
    end
  end
  LS.saveState()
end

local function groupToClient()
  local g = LS.state.group or { curGroupId = 1, groups = {} }
  local groups = {}
  for i, grp in ipairs(g.groups or {}) do
    local emb = {}
    for r = 1, #grp.embattles do
      emb[r] = {}
      for c = 1, #grp.embattles[r] do
        local hid = grp.embattles[r][c]
        if hid and hid ~= 0 then emb[r][c] = LS.longid(hid) else emb[r][c] = ID[0] end
      end
    end
    table.insert(groups, {
      groupId = grp.groupId,
      leaderId = (grp.leaderId and grp.leaderId ~= 0) and LS.longid(grp.leaderId) or ID[0],
      embattles = emb,
    })
  end
  return { curGroupId = g.curGroupId or 1, groups = groups }
end
local function herosToClient()
  local lst = {}
  for _, h in ipairs(LS.state.heroes) do table.insert(lst, heroToClient(h)) end
  local leader = LS.state.heroes[1] and LS.state.heroes[1].id or 0
  return { extendCount = 6, extendLimit = 60, heros = lst, leader = LS.longid(leader), score = {} }
end
local function progressToClient()
  return {
    battles = LS.state.battles or {},
    campaigns = LS.state.campaigns or {},
    dailyCounts = LS.state.dailyCounts or {},
    current = nil,
  }
end

-- ===== 战斗战报 =====
local function pb(n) return string.char(n % 256) end
local function pu16(n) return string.char(math.floor(n / 256) % 256, n % 256) end
local function pi32(n)
  if n < 0 then n = n + 4294967296 end
  return string.char(math.floor(n / 16777216) % 256, math.floor(n / 65536) % 256, math.floor(n / 256) % 256, n % 256)
end
local function packUnit(slot, model, class, hp, hpMax)
  return pb(slot) .. pu16(model) .. pb(0) .. pb(class) .. pi32(hp) .. pi32(hpMax) .. pb(0x01)
end
local function packTeam(units)
  local s = ""
  for _, u in ipairs(units) do s = s .. packUnit(u.slot, u.model, u.class, u.hp0, u.hpMax) end
  return s .. pb(0xFF) .. pb(0)
end
local function packAction(actorSlot, skillId, targets)
  local s = pb(actorSlot) .. pu16(skillId) .. pb(#targets)
  for _, t in ipairs(targets) do
    -- Hakimi adds typed values, buffs, passives and a start-passive flag.
    s = s .. pb(t.slot) .. pb(t.state or 0) .. pb(1) .. pb(1)
          .. pi32(t.damage or 0) .. pb(0) .. pb(0)
  end
  return s .. pb(0)
end
local function firstAlive(units)
  for _, u in ipairs(units) do
    if u.hp > 0 then return u end
  end
  return nil
end

local function battleLevel(battleId)
  local binfo = baseBattle(battleId)
  if binfo and binfo.campaignId then
    local cn = string.match(tostring(binfo.campaignId), "CN(%d+)")
    if cn then return tonumber(cn) or 1 end
  end
  return 1
end

local function simulateBattle(battleId, reqEmbattle)
  local atkUnits, defUnits = {}, {}
  -- 己方：优先用客户端传来的实际阵型（玩家刚配置的），否则用本地存档
  local g = LS.state.group and LS.state.group.groups and LS.state.group.groups[LS.state.group.curGroupId or 1]
  local emb = (g and g.embattles) or {}
  if type(reqEmbattle) == "table" and #reqEmbattle > 0 then
    emb = {}
    for r = 1, #reqEmbattle do
      emb[r] = {}
      for c = 1, #(reqEmbattle[r] or {}) do
        emb[r][c] = unlongid(reqEmbattle[r][c])
      end
    end
  end
  local aslot = 0
  for r = 1, #emb do
    for c = 1, #emb[r] do
      local hid = emb[r][c]
      local h = (hid and hid > 0) and heroById(hid) or nil
      if h then
        local info = baseHero(h.baseId)
        local hp, atk = heroStats(h.baseId, h.level)
        table.insert(atkUnits, {
          slot = aslot, model = h.baseId, class = 1, hp0 = hp, hp = hp, hpMax = hp, atk = atk,
          skill = (info and tonumber(info.normalSkill)) or 101,
        })
      end
      aslot = aslot + 1
    end
  end
  -- 调试：打印上阵英雄
  do
    local parts = {}
    for _, u in ipairs(atkUnits) do table.insert(parts, tostring(u.model)) end
    log4misc:warn("[DBG] battle=" .. tostring(battleId) .. " atkCount=" .. #atkUnits .. " models=" .. table.concat(parts, ","))
  end
  -- 敌方
  local binfo = baseBattle(battleId)
  local enemies = (binfo and tonumber(binfo.enemies)) or 3
  local lvl = battleLevel(battleId)
  for i = 1, enemies do
    local mbid = LS.MONSTER_POOL[((i - 1) % #LS.MONSTER_POOL) + 1]
    local info = baseHero(mbid)
    local hp, atk = heroStats(mbid, lvl)
    table.insert(defUnits, {
      slot = 5 + i, model = mbid, class = (i == enemies) and 3 or 2,
      hp0 = hp, hp = hp, hpMax = hp, atk = atk,
      skill = (info and tonumber(info.normalSkill)) or 121,
    })
  end
  -- 模拟回合制
  local rounds = {}
  local win = false
  local TOL = 12
  for round = 1, TOL do
    local actions = {}
    for _, u in ipairs(atkUnits) do
      if u.hp > 0 then
        local tgt = firstAlive(defUnits)
        if tgt then
          local dmg = math.max(1, math.floor(u.atk * (0.9 + math.random() * 0.2)))
          tgt.hp = tgt.hp - dmg
          table.insert(actions, packAction(u.slot, u.skill, { { slot = tgt.slot, state = 0, damage = -dmg } }))
        end
      end
    end
    for _, u in ipairs(defUnits) do
      if u.hp > 0 then
        local tgt = firstAlive(atkUnits)
        if tgt then
          local dmg = math.max(1, math.floor(u.atk * (0.9 + math.random() * 0.2)))
          tgt.hp = tgt.hp - dmg
          table.insert(actions, packAction(u.slot, u.skill, { { slot = tgt.slot, state = 0, damage = -dmg } }))
        end
      end
    end
    -- Empty round-starts; actions; empty round-ends; zero cooldown records.
    table.insert(rounds, pb(0xFF) .. table.concat(actions) .. pb(0xFF)
                        .. pb(0xFF) .. pu16(0) .. pb(0xFF))
    local allDefDead, allAtkDead = true, true
    for _, u in ipairs(defUnits) do if u.hp > 0 then allDefDead = false end end
    for _, u in ipairs(atkUnits) do if u.hp > 0 then allAtkDead = false end end
    if allDefDead then win = true break end
    if allAtkDead then break end
  end
  local atkB, defB = {}, {}
  for _, u in ipairs(atkUnits) do table.insert(atkB, u) end
  for _, u in ipairs(defUnits) do table.insert(defB, u) end
  local report = packTeam(atkB) .. packTeam(defB) .. table.concat(rounds) .. pb(win and 1 or 0)
  return report, win
end

local function markBattleDone(battleId)
  if not inSet(LS.state.battles, battleId) then
    table.insert(LS.state.battles, battleId)
  end
  local binfo = baseBattle(battleId)
  if binfo and binfo.last == "true" and binfo.campaignId then
    if not inSet(LS.state.campaigns, binfo.campaignId) then
      table.insert(LS.state.campaigns, binfo.campaignId)
    end
  end
  LS.saveState()
end

local function addPlayerExp(battleId)
  local p = LS.state.player or {}
  p.level = p.level or 1
  p.exp = (p.exp or 0) + 5000
  -- 按 LevelConfig 累计经验升级
  while p.level < 100 do
    local nextcfg = KFDBGetRecord("LevelConfig", p.level + 1)
    local need = (nextcfg and tonumber(nextcfg.exp)) or math.huge
    if p.exp >= need then p.level = p.level + 1 else break end
  end
  LS.state.player = p
  return 5000, p.level, p.exp
end

-- ===== 账号 =====
H["10:4"] = function(req) return LS.state.roleCreated end
H["10:2"] = function(req) return LS.SESSION end
H["10:1"] = function(req)
  if type(req) == "table" and req.name then LS.state.roleName = req.name end
  LS.state.roleCreated = true
  LS.saveState()
  return 0
end
H["10:9"] = function(req) return 0 end

-- ===== 登录信息（进游戏关键包）=====
H["10:7"] = function(req)
  LS.init()
  local t = zero("o:model.LoginInfoVo")
  local st = LS.state
  t.account = t.account or {}
  t.account.id = 10001
  t.account.name = st.account
  t.account.state = 0
  t.account.online = true
  t.account.createdOn = os.time()
  t.account.loginOn = os.time()
  t.account.logoutOn = os.time()
  t.player = t.player or {}
  t.player.id = 10001
  t.player.name = st.roleName
  t.player.level = st.player.level or 1
  t.player.exp = st.player.exp or 0
  t.player.leadership = 100
  t.player.baseId = 1001
  t.player.rank = 0
  t.player.rename = false
  t.wallet = t.wallet or {}
  t.wallet.gold = st.wallet.gold or 0
  t.wallet.copper = st.wallet.copper or 0
  t.wallet.stone = st.wallet.stone or 0
  t.wallet.gift = st.wallet.gift or 0
  t.wallet.inter = st.wallet.inter or 0
  t.wallet.friendship = st.wallet.friendship or 0
  t.wallet.fragment = st.wallet.fragment or 0
  t.wallet.coupon = st.wallet.coupon or 0
  t.wallet.exploit = st.wallet.exploit or 0
  t.wallet.orange = st.wallet.orange or 0
  t.wallet.purple = st.wallet.purple or 0
  t.wallet.totalCharge = 0
  t.actionPoint = t.actionPoint or {}
  -- 注意：客户端按 points[0](体力/SINGLE) / points[1](精力/DEMOG) 读取，必须 0 基下标
  local phy = st.physical or { point = 999, refreshTime = os.time() * 1000 }
  local function mkPoint(p)
    return { point = p or 999, refreshTime = os.time() * 1000, exchangeCount = 0, exchangeTime = 0, extraTime = 0 }
  end
  t.actionPoint.points = {
    [0] = mkPoint(phy.point),
    [1] = mkPoint(999),
    [2] = mkPoint(999),
  }
  t.vip = t.vip or {}
  t.vip.vip = false
  t.vip.week = false
  t.vip.monsth = false
  t.vip.vipTime = 0
  t.vip.weekTime = 0
  t.vip.monsthTime = 0
  t.vip.lastChargeDate = 0
  t.systemTime = os.time() * 1000  -- date 类型以毫秒计，客户端 OnSystemTime 会 /1000
  t.hasNewMail = false
  t.hasReward = false
  t.hasAchieve = false
  t.lotteryLevel = 70  -- 转盘奖励等级：设到最大，避免每次登录强制弹转盘
  t.artifactLevel = 0
  for _, k in ipairs({"account", "player", "wallet", "vip", "actionPoint", "groupVo", "heros",
                      "treasurePack", "arenaMatchList", "demogRank", "talismanVos", "progressVo",
                      "items", "friendPack", "activitys", "validGiftVo", "emblemAchieveList",
                      "buffs", "commendFriend", "dailyCheckInfo", "lotteryRecord",
                      "targetProgress", "menpaiLoginVo", "teamInfoVo", "equipVos",
                      "heroCultivateVos", "eliteBattleIds", "activeProgress", "exploreExecuteTasks"}) do
    if type(t[k]) ~= "table" then t[k] = {} end
  end
  t.friendPack = { apply = false, extendCount = 0, extendLimit = 50, friends = {} }
  t.heros = herosToClient()
  t.groupVo = groupToClient()
  t.teamInfoVo = { teamLeaders = {}, teams = {} }
  t.progressVo = progressToClient()
  t.asset = Logic:Get("System"):GetServerVer()
  return vivify(t)
end

-- ===== 战斗 =====
H["22:1"] = function(req) return vivify(progressToClient()) end  -- PROGRESS
H["22:7"] = function(req) return vivify(LS.state.dailyCounts or {}) end  -- DAILYCOUNT

-- MULTI_ACTION：进关卡，回 array<TriggerVo>
H["22:9"] = function(req)
  req = type(req) == "table" and req or {}
  local battleId = req.battleId
  if not battleId then return vivify({}) end
  -- 持久化玩家刚配置的阵型
  if type(req.embattle) == "table" and #req.embattle > 0 then
    local g = LS.state.group and LS.state.group.groups and LS.state.group.groups[LS.state.group.curGroupId or 1]
    if g then
      g.embattles = {}
      for r = 1, #req.embattle do
        g.embattles[r] = {}
        for c = 1, #(req.embattle[r] or {}) do
          g.embattles[r][c] = unlongid(req.embattle[r][c])
        end
      end
      LS.saveState()
    end
  end
  local report, win = simulateBattle(battleId, req.embattle)
  local binfo = baseBattle(battleId)
  local drops = {}
  if binfo and win then drops = getJson(binfo.itemDrop) end
  local coins = 0
  if win then
    markBattleDone(battleId)
    coins = 100 + battleLevel(battleId) * 50
    if LS.state.dailyCounts[battleId] == nil then LS.state.dailyCounts[battleId] = 0 end
    LS.state.dailyCounts[battleId] = LS.state.dailyCounts[battleId] + 1
    LS.saveState()
  end
  -- 扣体力
  local cost = binfo and tonumber(binfo.cost) or 5
  local phy = LS.state.physical or { point = 999, refreshTime = os.time() * 1000 }
  phy.point = math.max(0, (phy.point or 999) - cost)
  phy.refreshTime = os.time() * 1000
  LS.state.physical = phy
  LS.lastBattle = { battleId = battleId, win = win, cost = cost }
  return vivify({ { reports = report, drops = {}, coins = coins, finished = true, success = win, index = 0 } })
end

-- EXIT：结算
H["22:5"] = function(req)
  local lb = LS.lastBattle
  local costs, rewards = {}, {}
  if lb then
    local phy = LS.state.physical or { point = 999, refreshTime = os.time() }
    table.insert(costs, { type = 4, code = 0, amount = -(lb.cost or 0), contents = { point = phy.point, refreshTime = phy.refreshTime } })
  end
  if lb and lb.win then
    local lvl = battleLevel(lb.battleId)
    local gain, plvl, pexp = addPlayerExp(lb.battleId)
    local coins = 100 + lvl * 50
    LS.state.wallet.copper = (LS.state.wallet.copper or 0) + coins
    LS.saveState()
    table.insert(rewards, { type = 1, code = 0, amount = coins, contents = {}, mail = false })
    table.insert(rewards, { type = 0, code = 0, amount = gain, contents = { level = plvl, exp = pexp }, mail = false })
  end
  LS.lastBattle = nil
  return vivify({ costAndReward = { costs = costs, rewards = rewards }, hasDemog = false, failedTimes = 0 })
end

-- ===== 门派（mod 47）=====
-- 离线没有门派，回一个"未加入"的空 MenpaiInfoVo，避免 Sect 逻辑对数组字段误判
H["47:2"] = function(req)
  return {
    id = 0, name = "", level = 1, count = 0, exp = 0, money = 0,
    declaration = "", post = "", bossName = "", job = 0,
    aplypNum = 0, canPrayTime = 0, prayTimes = 0, hasGrabed = false,
    holdRewardDate = 0, endGrabRight = 0,
    joinBidDate = {}, joinFightDate = {}, reportDate = {},
  }
end

-- ===== 英雄模块（mod 13）=====
H["13:1"] = function(req) return vivify(herosToClient()) end  -- ALL_HEROS
H["13:2"] = function(req)  -- HERO_CURRENT：选择队友后，把客户端选中的英雄写回阵型
  req = type(req) == "table" and req or {}
  local g = LS.state.group and LS.state.group.groups and LS.state.group.groups[1]
  if g and type(req.heros) == "table" then
    local ids = {}
    for _, v in ipairs(req.heros) do
      local id = unlongid(v)
      if id > 0 then table.insert(ids, id) end
    end
    -- 重排成 3 行 x 2 列
    g.embattles = {}
    local idx = 1
    for r = 1, 3 do
      g.embattles[r] = {}
      for c = 1, 2 do
        g.embattles[r][c] = ids[idx] or 0
        idx = idx + 1
      end
    end
    LS.saveState()
  end
  local emb = {}
  if g then
    for r = 1, #g.embattles do
      emb[r] = {}
      for c = 1, #g.embattles[r] do
        local hid = g.embattles[r][c]
        emb[r][c] = (hid and hid > 0) and LS.longid(hid) or ID[0]
      end
    end
  end
  return vivify(emb)
end
H["13:3"] = function(req)  -- EMBATTLE
  req = type(req) == "table" and req or {}
  local g = LS.state.group.groups[1]
  if g and type(req.embattles) == "table" then
    g.embattles = {}
    for r = 1, #req.embattles do
      g.embattles[r] = {}
      for c = 1, #req.embattles[r] do
        local v = req.embattles[r][c]
        g.embattles[r][c] = unlongid(v)
      end
    end
    LS.saveState()
  end
  return 0
end
H["13:4"] = function(req)  -- SWALLOW 升级
  req = type(req) == "table" and req or {}
  local srcId = unlongid(req.src)
  local src = heroById(srcId)
  if not src then return vivify({}) end
  local tar = type(req.tar) == "table" and req.tar or {}
  local totalExp = src.exp or 0
  local costs = {}
  for _, tid in ipairs(tar) do
    local tidNum = unlongid(tid)
    local fed = heroById(tidNum)
    if fed and fed.id ~= src.id then
      totalExp = totalExp + getHeroSwallowExp(fed.baseId, fed.level)
      removeHero(tidNum)
      table.insert(costs, { type = 5, code = 0, amount = -1, contents = { id = LS.longid(tidNum) } })
    end
  end
  local lvl = src.level or 1
  while lvl < 100 do
    local need = getHeroNextExp(src.baseId, lvl)
    if totalExp >= need then
      totalExp = totalExp - need
      lvl = lvl + 1
    else
      break
    end
  end
  src.level = lvl
  src.exp = totalExp
  LS.saveState()
  return vivify({ costs = costs, hero = heroToClient(src) })
end
H["13:5"] = function(req)  -- RANK_UP 升星
  req = type(req) == "table" and req or {}
  local srcId = unlongid(req.src)
  local src = heroById(srcId)
  if not src then return vivify({}) end
  local info = baseHero(src.baseId)
  local nextId = info and tonumber(info.nextId)
  local costs = {}
  if not nextId or nextId < 0 then
    return vivify({ costs = costs, hero = heroToClient(src) })
  end
  local tar = type(req.tar) == "table" and req.tar or {}
  for _, tid in ipairs(tar) do
    local tidNum = unlongid(tid)
    local fed = heroById(tidNum)
    if fed and fed.id ~= src.id then
      removeHero(tidNum)
      table.insert(costs, { type = 5, code = 0, amount = -1, contents = { id = LS.longid(tidNum) } })
    end
  end
  src.baseId = nextId
  src.level = 1
  src.exp = 0
  LS.saveState()
  return vivify({ costs = costs, hero = heroToClient(src) })
end
H["13:7"] = function(req)  -- SELL_HERO
  req = type(req) == "table" and req or {}
  local tar = type(req.tar) == "table" and req.tar or {}
  local totalCoins = 0
  local costs = {}
  for _, tid in ipairs(tar) do
    local tidNum = unlongid(tid)
    local h = heroById(tidNum)
    if h then
      local info = baseHero(h.baseId)
      totalCoins = totalCoins + (info and tonumber(info.baseCoins) or 100) + (h.level - 1) * (info and tonumber(info.growCoins) or 10)
      removeHero(tidNum)
      table.insert(costs, { type = 5, code = 0, amount = -1, contents = { id = LS.longid(tidNum) } })
    end
  end
  LS.state.wallet.copper = (LS.state.wallet.copper or 0) + totalCoins
  LS.saveState()
  local rewards = {}
  if totalCoins > 0 then table.insert(rewards, { type = 1, code = 0, amount = totalCoins, contents = {}, mail = false }) end
  return vivify({ costs = costs, rewards = rewards })
end
H["13:8"] = function(req)  -- CHANGE_LEADER
  req = type(req) == "table" and req or {}
  local g = LS.state.group.groups[1]
  if g and req.src then
    g.leaderId = unlongid(req.src)
    LS.saveState()
  end
  local emb = {}
  if g then
    for r = 1, #g.embattles do
      emb[r] = {}
      for c = 1, #g.embattles[r] do
        local hid = g.embattles[r][c]
        emb[r][c] = (hid and hid ~= 0) and LS.longid(hid) or ID[0]
      end
    end
  end
  return vivify(emb)
end
H["13:11"] = function(req)  -- SKILL_UP
  req = type(req) == "table" and req or {}
  local srcId = unlongid(req.src)
  local src = heroById(srcId)
  if not src then return vivify({}) end
  local tar = type(req.tar) == "table" and req.tar or {}
  local costs = {}
  for _, tid in ipairs(tar) do
    local tidNum = unlongid(tid)
    local fed = heroById(tidNum)
    if fed and fed.id ~= src.id then
      removeHero(tidNum)
      table.insert(costs, { type = 5, code = 0, amount = -1, contents = { id = LS.longid(tidNum) } })
    end
  end
  src.skillExp = (src.skillExp or 0) + 1
  LS.saveState()
  return vivify({ costs = costs, hero = heroToClient(src) })
end
H["13:12"] = function(req) return vivify({}) end  -- CURRENT_SCORE
H["13:13"] = function(req) return vivify(groupToClient()) end  -- HERO_GROUPS
H["13:14"] = function(req)  -- SWITCH_HERO_GROUP
  req = type(req) == "table" and req or {}
  LS.state.group.curGroupId = req.groupId or 1
  LS.saveState()
  return 0
end
H["13:15"] = function(req) return 0 end  -- EMBATTLE_GROUP

-- ===== 抽卡 / 商城 / 合成 =====
H["11:1"] = function(req)  -- LOTTERY 抽卡：扣元宝，得随机英雄
  req = type(req) == "table" and req or {}
  local times = tonumber(req.time) or 1
  local goldCost = 100 * times
  local st = LS.state
  if (st.wallet.gold or 0) < goldCost then
    return vivify({ costs = {}, rewards = {} })
  end
  st.wallet.gold = st.wallet.gold - goldCost
  local costs = { { type = 0, code = 1, amount = -goldCost, contents = {} } }  -- CURRENCY + GOLD
  local rewards = {}
  for i = 1, times do
    local baseId = LS.DRAW_HEROS[math.random(#LS.DRAW_HEROS)]
    local h = addNewHero(baseId)
    table.insert(rewards, { type = 5, code = baseId, amount = 1, contents = heroToClient(h), mail = false })
  end
  LS.saveState()
  return vivify({ costs = costs, rewards = rewards })
end
H["11:2"] = function(req)  -- WALLET
  local w = LS.state.wallet or {}
  return vivify({
    gold = w.gold or 0, copper = w.copper or 0, stone = w.stone or 0,
    gift = w.gift or 0, inter = w.inter or 0, friendship = w.friendship or 0,
    fragment = w.fragment or 0, coupon = w.coupon or 0, exploit = w.exploit or 0,
    orange = w.orange or 0, purple = w.purple or 0,
    totalCharge = 0, stageCharges = {},
  })
end
H["11:3"] = function(req)  -- VIP
  return vivify({ vip = false, vipTime = 0, week = false, weekTime = 0, monsth = false, monsthTime = 0, lastChargeDate = 0 })
end
H["11:9"] = function(req)  -- ROULETTE_LOTTERY 幸运转盘
  -- id 必须是 RouletteLotteryConfig 表的合法下标（用于展示奖励名）
  local cnt = KFDBGetRecordAmt("RouletteLotteryConfig")
  local idx = math.random(1, cnt > 0 and cnt or 1)
  local baseId = LS.DRAW_HEROS[math.random(#LS.DRAW_HEROS)]
  local h = addNewHero(baseId)
  return vivify({
    id = idx,
    nextLevel = -1,
    rewardResults = { { type = 5, code = baseId, amount = 1, contents = heroToClient(h), mail = false } },
  })
end
H["11:10"] = function(req) return vivify({}) end  -- ROULETTE_LOTTERY_RESULTS
H["11:11"] = function(req)  -- GET_LOTTERY_LIST：商城/抽卡的抽卡池列表
  local now = os.time() * 1000
  local pools = {
    { baseId = 1001, title = "英雄招募", desc = "招募一名随机英雄", cost = 100 },
    { baseId = 1002, title = "高级招募", desc = "招募高品质英雄", cost = 300 },
    { baseId = 1021, title = "神将招募", desc = "招募神级英雄", cost = 600 },
  }
  local lst = {}
  for i, p in ipairs(pools) do
    table.insert(lst, {
      id = 2000 + i, baseId = p.baseId,
      cardID = tostring(p.baseId), cardLevel = "1", cardTip = "", cardType = "HERO",
      cooldownHours = 48, current = 0, desInPage = "[]", description = p.desc,
      endLevel = 9999, endTime = now + 86400000 * 365, kind = "NORMAL",
      level = 1, limits = 0, lotteryType = "HERO", path = "",
      prices = json.encode({ { type = "CURRENCY", code = 1, amount = p.cost } }),
      probability = json.encode({ { baseId = p.baseId, weight = 100 } }),
      resetDate = now, salePrices = { p.cost }, show = true, showTemplete = "hero",
      sort = i, sortType = "NORMAL", startTime = now - 86400000, title = p.title,
      type = "HERO", usedFreeTimes = 0, vip = false, week = false, weight = 0,
      activity = "", activityCharge = 0, playerActivityCharge = 0, battle = "", eliteBattle = "",
    })
  end
  return vivify(lst)
end
H["12:1"] = function(req) return vivify({}) end  -- GET_ITEMS（背包道具，暂无）
H["12:2"] = function(req) return vivify({ costs = {}, rewards = {} }) end  -- COMPOSE_ITEM
H["51:1"] = function(req) return vivify({}) end  -- PLAYER_BUY_INFO 商城

-- ===== 初始化（延迟到登录时再执行，避免在 NetMsg 模块加载期调用 KFDB/日志）=====
function LS.init()
  if LS.inited then return end
  LS.inited = true
  LS.loadState()
  if type(LS.state) ~= "table" then LS.state = defaultState() end
  if not LS.state.wallet then LS.state.wallet = {} end
  if not LS.state.player then LS.state.player = { level = 1, exp = 0 } end
  if not LS.state.heroes then LS.state.heroes = {} end
  if not LS.state.battles then LS.state.battles = {} end
  if not LS.state.campaigns then LS.state.campaigns = {} end
  if not LS.state.dailyCounts then LS.state.dailyCounts = {} end
  if not LS.state.group then LS.state.group = { curGroupId = 1, groups = { { groupId = 1, leaderId = 0, embattles = {} } } } end
  if not LS.state.nextHeroId then LS.state.nextHeroId = 100001 end
  ensureRoster()
  if LS.UNLOCK_ALL then ensureFullUnlock() end
  LS.saveState()
  log4misc:warn("[LocalServer] init heroes=" .. #LS.state.heroes .. " battles=" .. #LS.state.battles .. " campaigns=" .. #LS.state.campaigns)
end

-- ================= 分发 =================
function LS.dispatch(mod, cmd, req)
  local key = tostring(mod) .. ":" .. tostring(cmd)
  log4misc:warn("[LocalServer] dispatch " .. key)
  local nm = Singleton(NetMsg)
  local evId = mod * 10000 + (cmd + 5000) % 10000
  local cnt = 0
  for _ in pairs(nm.eventSet.events) do cnt = cnt + 1 end
  log4misc:warn(string.format("[LocalServer] eventId=%d bound=%s total=%d",
    evId, tostring(nm.eventSet.events[evId] ~= nil), cnt))
  local ok, content
  local h = LS.handlers[key]
  if h then
    local succ, ret = pcall(h, req, mod, cmd)
    if succ then
      content = ret
      log4misc:warn("[LocalServer] handler " .. key .. " -> " .. tostring(ret))
    else
      log4misc:warn("[LocalServer] handler error " .. key .. ": " .. tostring(ret))
    end
  end
  if content == nil then
    local def = (CMD[mod] or {})[cmd]
    if def then
      content = zero(def[2])
      log4misc:info("[LocalServer] auto-answer %d-%d (%s)", mod, cmd, def[1])
    else
      content = 0
      log4misc:warn("[LocalServer] unknown msg %d-%d -> 0", mod, cmd)
    end
  end
  local ok2, err2 = xpcall(function()
    nm:OnReceived({
      raw = true,
      mod = mod,
      cmd = cmd,
      content = { code = 0, content = content },
      attachment = ""
    })
  end, function(e)
    return tostring(e) .. "\n" .. tostring(debug.traceback())
  end)
  if ok2 then
    log4misc:warn("[LocalServer] replied " .. key)
  else
    log4misc:warn("[LocalServer] OnReceived error " .. key .. ":\n" .. tostring(err2))
  end
  return true
end

-- 让外部（补丁）能拿到
_G.__LocalServer = LS
