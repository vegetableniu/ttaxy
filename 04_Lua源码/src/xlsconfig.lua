DEF({
  type = "PassiveConduct",
  file = "",
  desc = "\230\138\128\232\131\189"
}, {
  index = "id",
  value = "string",
  desc = "\230\138\128\232\131\189\230\160\135\232\175\134"
}, {
  field = "style",
  value = "string",
  desc = "\231\177\187\229\158\139"
}, {
  field = "path",
  value = "string",
  desc = "\232\183\175\229\190\132"
}, {})
DEF({
  type = "BuffConduct",
  file = "",
  desc = "\230\138\128\232\131\189"
}, {
  index = "id",
  value = "string",
  desc = "\230\138\128\232\131\189\230\160\135\232\175\134"
}, {
  field = "style",
  value = "string",
  desc = "\231\177\187\229\158\139"
}, {
  field = "level",
  value = "int",
  desc = "\229\177\130\230\172\161"
}, {
  field = "Add",
  value = "string",
  desc = ""
}, {
  field = "Remove",
  value = "string",
  desc = ""
}, {
  field = "Active",
  value = "string",
  desc = ""
}, {
  field = "Cancel",
  value = "string",
  desc = ""
}, {})
DEF({
  type = "PassiveConfig",
  file = "",
  desc = "\232\162\171\229\138\168\230\149\136\230\158\156"
}, {
  index = "id",
  value = "string",
  desc = "\230\160\135\232\175\134"
}, {
  field = "type",
  value = "string",
  desc = "\231\177\187\229\158\139"
}, {
  field = "name",
  value = "string",
  desc = "\230\138\128\232\131\189\229\144\141"
}, {
  field = "desc",
  value = "string",
  desc = "\229\164\135\230\179\168"
}, {
  field = "icon",
  value = "string",
  desc = "\230\138\128\232\131\189\229\155\190\230\160\135"
}, {})
DEF({
  type = "BuffConfig",
  file = "",
  desc = "\232\162\171\229\138\168BUFF"
}, {
  index = "id",
  value = "string",
  desc = "\230\160\135\232\175\134"
}, {
  field = "type",
  value = "string",
  desc = "\231\177\187\229\158\139"
}, {
  field = "state",
  value = "string",
  desc = "\231\138\182\230\128\129"
}, {
  field = "link",
  value = "string",
  desc = "\229\184\184\233\169\187BUFF\231\154\132\229\138\168\231\148\187\232\161\168\231\142\176"
}, {})
DEF({
  type = "AchieveConfig",
  file = "",
  desc = "\233\153\141\233\173\148\229\189\149\231\171\160\232\138\130\229\134\133\230\136\144\229\176\177"
}, {
  index = "id",
  value = "int",
  desc = "\230\160\135\232\175\134"
}, {
  field = "achieveId",
  value = "int",
  desc = "\230\136\144\229\176\177id"
}, {
  field = "chapterId",
  value = "int",
  desc = "\230\137\128\229\177\158\231\171\160\232\138\130id"
}, {
  field = "cardId",
  value = "int",
  desc = "hero\229\141\161\231\137\140id"
}, {
  field = "sameNameId",
  value = "int",
  desc = "\229\141\161\231\137\140\229\144\140\229\144\141id"
}, {
  field = "reachType",
  value = "string",
  desc = "\232\190\190\230\136\144\231\177\187\229\158\139"
}, {
  field = "value",
  value = "int",
  desc = "\232\190\190\230\136\144\229\128\188"
}, {
  field = "recommend",
  value = "int",
  desc = "\230\152\175\229\144\166\230\142\168\232\141\144\229\141\161"
}, {
  field = "name",
  value = "string",
  desc = "\230\136\144\229\176\177\229\144\141"
}, {
  field = "rewardId",
  value = "string",
  desc = "\229\165\150\229\138\177id"
}, {
  field = "desc",
  value = "string",
  desc = "\230\136\144\229\176\177\232\175\180\230\152\142"
}, {})
DEF({
  type = "ActivityList",
  file = "",
  desc = "Sheet1"
}, {
  field = "id",
  value = "string",
  desc = "\230\180\187\229\138\168"
}, {
  field = "ActivityName",
  value = "string",
  desc = "\230\180\187\229\138\168\229\144\141\231\167\176"
}, {
  field = "ActivityTime",
  value = "string",
  desc = "\230\140\129\231\187\173\230\151\182\233\151\180"
}, {
  field = "ItemDrop",
  value = "string",
  desc = "\232\142\183\229\190\151\229\165\150\229\138\177"
}, {})
DEF({
  type = "AurasSetting",
  file = "",
  desc = "\231\167\141\230\151\143\229\133\137\231\142\175"
}, {
  index = "id",
  value = "int",
  desc = "\230\160\135\232\175\134"
}, {
  field = "target",
  value = "string",
  desc = "\231\148\159\230\149\136\231\155\174\230\160\135"
}, {
  field = "unit",
  value = "string",
  desc = "\231\148\159\230\149\136\231\155\174\230\160\135"
}, {
  field = "showEffect",
  value = "string",
  desc = "\230\152\190\231\164\186\230\149\136\230\158\156"
}, {})
DEF({
  type = "BaseHero",
  file = "",
  desc = "\231\153\189\229\141\161"
}, {
  index = "id",
  value = "int",
  desc = "\230\160\135\232\175\134"
}, {
  field = "sameNameId",
  value = "int",
  desc = "\229\144\140\229\144\141id"
}, {
  field = "model",
  value = "int",
  desc = "\230\168\161\229\158\139"
}, {
  field = "name",
  value = "string",
  desc = "\229\144\141\231\167\176"
}, {
  field = "card",
  value = "string",
  desc = "\229\141\161\231\137\140\231\177\187\229\158\139"
}, {
  field = "type",
  value = "string",
  desc = "\229\133\181\231\167\141"
}, {
  field = "race",
  value = "string",
  desc = "\231\167\141\230\151\143"
}, {
  field = "sex",
  value = "string",
  desc = "\230\128\167\229\136\171"
}, {
  field = "shine",
  value = "int",
  desc = "\233\151\170\229\141\161"
}, {
  field = "star",
  value = "int",
  desc = "\230\152\159\231\186\167"
}, {
  field = "rank",
  value = "int",
  desc = "\229\147\129\232\180\168"
}, {
  field = "leadership",
  value = "int",
  desc = "\233\162\134\229\175\188\229\138\155"
}, {
  field = "mutexs",
  value = "string",
  desc = "\229\144\140\230\151\182\228\184\138\233\152\181\228\186\146\230\150\165\231\187\132"
}, {
  field = "limits",
  value = "int",
  desc = "\229\144\140\230\151\182\228\184\138\233\152\181\228\186\146\230\150\165\230\149\176\233\135\143"
}, {
  field = "level",
  value = "int",
  desc = "\231\173\137\231\186\167\228\184\138\233\153\144"
}, {
  field = "nextId",
  value = "int",
  desc = "\232\191\155\229\140\150\230\160\135\232\175\134"
}, {
  field = "nextDesc",
  value = "string",
  desc = "\229\141\135\230\152\159\230\143\143\232\191\176"
}, {
  field = "fragment",
  value = "int",
  desc = "\229\136\134\232\167\163\228\184\135\232\131\189\231\162\142\231\137\135"
}, {
  field = "baseCoins",
  value = "int",
  desc = "\229\135\186\229\148\174\229\159\186\231\161\128\229\128\188"
}, {
  field = "growCoins",
  value = "double",
  desc = "\230\175\143\231\186\167\229\135\186\229\148\174\229\162\158\233\135\143"
}, {
  field = "baseExp",
  value = "int",
  desc = "\229\144\158\229\153\172\229\159\186\231\161\128\231\187\143\233\170\140"
}, {
  field = "growExp",
  value = "double",
  desc = "\229\144\158\229\153\172\230\175\143\231\186\167\231\187\143\233\170\140"
}, {
  field = "expRate",
  value = "double",
  desc = "\231\187\143\233\170\140\229\141\135\231\186\167\230\175\148\231\142\135"
}, {
  field = "coinRate",
  value = "double",
  desc = "\229\141\135\231\186\167\230\182\136\232\128\151\233\147\156\229\184\129\230\175\148\231\142\135"
}, {
  field = "costHeros",
  value = "string",
  desc = "\229\141\135\233\152\182\233\156\128\232\166\129\230\173\166\229\176\134"
}, {
  field = "costCoins",
  value = "int",
  desc = "\229\141\135\233\152\182\233\147\156\229\184\129"
}, {
  field = "costGold",
  value = "int",
  desc = "\228\187\153\231\142\137\229\141\135\233\152\182\230\137\128\233\156\128\228\187\153\231\142\137"
}, {
  field = "initValues",
  value = "string",
  desc = "\229\136\157\229\167\139\229\177\158\230\128\167"
}, {
  field = "initGrows",
  value = "string",
  desc = "\229\136\157\229\167\139\230\136\144\233\149\191\231\142\135"
}, {
  field = "initRates",
  value = "string",
  desc = "\229\136\157\229\167\139\230\175\148\231\142\135\229\128\188"
}, {
  field = "auras",
  value = "int",
  desc = "\229\133\137\231\142\175BUFF"
}, {
  field = "normalSkill",
  value = "string",
  desc = "\230\153\174\233\128\154\230\138\128\232\131\189"
}, {
  field = "powerSkill",
  value = "string",
  desc = "\229\191\133\230\157\128\230\138\128"
}, {
  field = "passives",
  value = "string",
  desc = "\232\162\171\229\138\168\230\138\128\232\131\189BUFF"
}, {
  field = "skillname_3",
  value = "string",
  desc = "\232\162\171\229\138\168\230\138\128\232\131\189\229\144\141\231\167\176"
}, {
  field = "skilldesc_3",
  value = "string",
  desc = "\232\162\171\229\138\168\230\138\128\232\131\189\232\175\180\230\152\142"
}, {
  field = "description",
  value = "string",
  desc = "\230\143\143\232\191\176"
}, {
  field = "gain",
  value = "string",
  desc = "\232\142\183\229\143\150\233\128\148\229\190\132"
}, {
  field = "funcFlag",
  value = "int",
  desc = "\229\138\159\232\131\189\230\160\135\229\191\151\228\189\141"
}, {
  field = "splitId",
  value = "string",
  desc = "\230\139\134\229\136\134\230\160\135\232\175\134"
}, {
  field = "splitCostAmount",
  value = "int",
  desc = "\230\139\134\229\136\134\230\137\163\232\180\185\230\149\176\233\135\143"
}, {
  field = "weaponSet",
  value = "string",
  desc = "\229\143\175\232\163\133\229\164\135\231\154\132\230\173\166\229\153\168\233\155\134"
}, {
  field = "armorSet",
  value = "string",
  desc = "\229\143\175\232\163\133\229\164\135\231\154\132\230\138\164\231\148\178\233\155\134"
}, {
  field = "comDesc",
  value = "string",
  desc = "\230\138\128\232\131\189\231\187\132\229\144\136\230\143\143\232\191\176"
}, {
  field = "comName",
  value = "string",
  desc = "\231\187\132\229\144\136\230\138\128\232\131\189\229\144\141\231\167\176"
}, {})
DEF({
  type = "BattleInfoConfig",
  file = "",
  desc = "\230\153\174\233\128\154"
}, {
  index = "id",
  value = "string",
  desc = "\230\160\135\232\175\134"
}, {
  field = "name",
  value = "string",
  desc = "\229\144\141\231\167\176"
}, {
  field = "campaignId",
  value = "string",
  desc = "\230\137\128\229\177\158\230\136\152\229\189\185"
}, {
  field = "prevId",
  value = "string",
  desc = "\229\137\141\231\189\174\230\160\135\232\175\134"
}, {
  field = "sort",
  value = "int",
  desc = "\230\142\146\229\186\143"
}, {
  field = "level",
  value = "int",
  desc = "\232\191\155\229\133\165\231\173\137\231\186\167"
}, {
  field = "cultivateState",
  value = "string",
  desc = "\230\137\128\233\156\128\228\191\174\232\161\140\229\162\131\231\149\140"
}, {
  field = "demogFirst",
  value = "string",
  desc = "\233\166\150\230\172\161\233\128\154\229\133\179\229\135\186\231\142\176\233\173\148\231\165\158"
}, {
  field = "enemies",
  value = "int",
  desc = "\230\149\140\229\134\155\230\149\176\233\135\143"
}, {
  field = "last",
  value = "string",
  desc = "\230\152\175\229\144\166\230\136\152\229\189\185\231\187\136\231\130\185"
}, {
  field = "cost",
  value = "int",
  desc = "\230\182\136\232\128\151\228\189\147\229\138\155"
}, {
  field = "dailyCount",
  value = "int",
  desc = "\230\175\143\230\151\165\232\191\155\229\133\165\230\172\161\230\149\176"
}, {
  field = "buyLimit",
  value = "int",
  desc = "\232\180\173\228\185\176\230\172\161\230\149\176\228\184\138\233\153\144"
}, {
  field = "buyTimesCost",
  value = "string",
  desc = "\232\180\173\228\185\176\230\182\136\232\128\151"
}, {
  field = "buffDesc",
  value = "string",
  desc = "BUFF\230\143\143\232\191\176"
}, {
  field = "itemDrop",
  value = "string",
  desc = "\231\137\169\229\147\129\230\142\137\232\144\189"
}, {
  field = "mapInit",
  value = "string",
  desc = "\229\136\157\229\167\139\232\131\140\230\153\175"
}, {
  field = "mapBg",
  value = "string",
  desc = "\229\156\176\229\155\190\232\131\140\230\153\175"
}, {
  field = "mapBoss",
  value = "string",
  desc = "BOSS\232\131\140\230\153\175"
}, {
  field = "bossNode",
  value = "int",
  desc = "BOSS\232\138\130\231\130\185"
}, {
  field = "position",
  value = "string",
  desc = "\232\138\130\231\130\185\229\157\144\230\160\135"
}, {})
DEF({
  type = "BattleShowConfig",
  file = "",
  desc = "\230\136\152\230\150\151\232\161\168\231\142\176\233\133\141\231\189\174"
}, {
  index = "id",
  value = "string",
  desc = "\230\160\135\232\175\134"
}, {
  field = "content",
  value = "string",
  desc = "\229\143\130\230\149\176"
}, {})
DEF({
  type = "BuyReTimesCost",
  file = "",
  desc = "\229\133\133\229\128\188\231\148\168\230\136\183\230\149\176"
}, {
  index = "id",
  value = "int",
  desc = "\229\136\183\230\150\176\230\172\161\230\149\176"
}, {
  field = "cost",
  value = "int",
  desc = "\230\182\136\232\128\151\228\187\153\231\142\137"
}, {})
DEF({
  type = "BuffEffect",
  file = "",
  desc = "\228\188\143\233\173\148\229\189\149\229\177\158\230\128\167"
}, {
  index = "id",
  value = "string",
  desc = "\230\160\135\232\175\134"
}, {
  field = "target",
  value = "string",
  desc = "\231\148\159\230\149\136\231\155\174\230\160\135"
}, {
  field = "unit",
  value = "string",
  desc = "\231\148\159\230\149\136\231\155\174\230\160\135"
}, {
  field = "alters",
  value = "string",
  desc = "\230\149\136\230\158\156"
}, {
  field = "skill_name",
  value = "string",
  desc = "\230\138\128\232\131\189\229\144\141\231\167\176"
}, {
  field = "skill_desc",
  value = "string",
  desc = "\230\138\128\232\131\189\232\175\180\230\152\142"
}, {})
DEF({
  type = "CampaignConfig",
  file = "",
  desc = "\230\153\174\233\128\154"
}, {
  index = "id",
  value = "string",
  desc = "\230\160\135\232\175\134"
}, {
  field = "name",
  value = "string",
  desc = "\229\144\141\231\167\176"
}, {
  field = "type",
  value = "string",
  desc = "\229\137\175\230\156\172\231\177\187\229\158\139"
}, {
  field = "prevId",
  value = "string",
  desc = "\229\137\141\231\189\174\230\160\135\232\175\134"
}, {
  field = "prevShowId",
  value = "string",
  desc = "\229\137\141\231\189\174\230\152\190\231\164\186"
}, {
  field = "prevBattle",
  value = "string",
  desc = "\229\137\141\231\189\174\229\137\175\230\156\172\231\130\185"
}, {
  field = "prevActivity",
  value = "string",
  desc = "\229\137\141\231\189\174\230\180\187\229\138\168\231\130\185"
}, {
  field = "sort",
  value = "int",
  desc = "\230\142\146\229\186\143"
}, {
  field = "level",
  value = "int",
  desc = "\231\173\137\231\186\167\233\153\144\229\136\182"
}, {
  field = "dailyCount",
  value = "int",
  desc = "\230\175\143\230\151\165\232\191\155\229\133\165\230\172\161\230\149\176"
}, {
  field = "introduction",
  value = "string",
  desc = "\232\175\180\230\152\142\230\150\135\229\173\151"
}, {
  field = "intro_title",
  value = "string",
  desc = "\232\175\180\230\152\142\230\150\135\229\173\151\230\160\135\233\162\152"
}, {
  field = "isTipWhenOpen",
  value = "int",
  desc = "\230\152\175\229\144\166\229\188\128\229\144\175\230\151\182\230\143\144\231\164\186"
}, {
  field = "chapterDesc",
  value = "string",
  desc = "\231\171\160\232\138\130\230\143\143\232\191\176"
}, {
  field = "imgBg",
  value = "string",
  desc = "Item\232\131\140\230\153\175\232\183\175\229\190\132"
}, {
  field = "imgTitle",
  value = "string",
  desc = "\230\160\135\233\162\152\229\155\190\231\137\135\232\183\175\229\190\132"
}, {})
DEF({
  type = "ChapterAchieveConfig",
  file = "",
  desc = "\233\153\141\233\173\148\229\189\149\231\171\160\232\138\130"
}, {
  index = "id",
  value = "int",
  desc = "\231\171\160\232\138\130ID"
}, {
  field = "reachType",
  value = "string",
  desc = "\232\190\190\230\136\144\231\177\187\229\158\139"
}, {
  field = "reachNum",
  value = "int",
  desc = "\232\190\190\230\136\144\230\149\176\233\135\143"
}, {
  field = "name",
  value = "string",
  desc = "\231\171\160\232\138\130\229\144\141\229\173\151"
}, {
  field = "recommendNum",
  value = "int",
  desc = "\230\142\168\232\141\144\229\141\161\228\184\170\230\149\176"
}, {
  field = "totol",
  value = "int",
  desc = "\230\136\144\229\176\177\228\184\170\230\149\176"
}, {
  field = "achievement",
  value = "string",
  desc = "\231\171\160\232\138\130\229\174\140\230\136\144\230\136\144\229\176\177"
}, {
  field = "rewardId",
  value = "string",
  desc = "\231\171\160\232\138\130\229\165\150\229\138\177Id"
}, {
  field = "desc",
  value = "string",
  desc = "\231\171\160\232\138\130\232\175\180\230\152\142"
}, {})
DEF({
  type = "LanguageSetting",
  file = "",
  desc = "\228\184\173\230\150\135"
}, {
  index = "id",
  value = "int",
  desc = "\230\160\135\232\175\134"
}, {
  field = "content",
  value = "string",
  desc = "\229\134\133\229\174\185"
}, {})
DEF({
  type = "Charge2Times",
  file = "",
  desc = "\231\171\158\230\138\128\229\156\186"
}, {
  index = "id",
  value = "int",
  desc = "\230\160\135\232\175\134"
}, {
  field = "type",
  value = "string",
  desc = "\229\162\158\229\138\160\231\177\187\229\158\139"
}, {
  field = "chargeAmount",
  value = "int",
  desc = "\229\133\133\229\128\188\233\162\157\229\186\166"
}, {
  field = "addTimes",
  value = "int",
  desc = "\229\162\158\229\138\160\232\180\173\228\185\176\230\172\161\230\149\176"
}, {})
DEF({
  type = "ChargeGoods",
  file = "",
  desc = "\229\133\133\229\128\188"
}, {
  index = "id",
  value = "string",
  desc = "ID"
}, {
  field = "reward",
  value = "string",
  desc = "\229\133\133\229\128\188\232\142\183\229\190\151"
}, {
  field = "firstReward",
  value = "string",
  desc = "\233\166\150\230\172\161\229\133\133\229\128\188\232\142\183\229\190\151"
}, {
  field = "price",
  value = "int",
  desc = "\229\141\149\228\187\183\239\188\136\229\136\134\239\188\137"
}, {
  field = "discount",
  value = "int",
  desc = "\230\138\152\230\137\163\228\187\183(\229\136\134)"
}, {
  field = "name",
  value = "string",
  desc = "\229\144\141\231\167\176"
}, {
  field = "isapp",
  value = "int",
  desc = "\230\152\175\229\144\166app"
}, {
  field = "appsecret",
  value = "string",
  desc = ""
}, {
  field = "desc",
  value = "string",
  desc = "\229\133\133\229\128\188\232\175\180\230\152\142"
}, {
  field = "firstDesc",
  value = "string",
  desc = "\233\166\150\230\172\161\229\133\133\229\128\188\232\175\180\230\152\142"
}, {
  field = "typeCard",
  value = "int",
  desc = "\231\177\187\229\158\139"
}, {
  field = "sort",
  value = "int",
  desc = "\230\142\146\229\186\143"
}, {
  field = "activeCharge",
  value = "string",
  desc = "\230\180\187\229\138\168\228\187\153\231\142\137"
}, {
  field = "activeGift",
  value = "string",
  desc = "\230\180\187\229\138\168\232\181\160\233\128\129"
}, {
  field = "activeGiftRate",
  value = "string",
  desc = "\230\180\187\229\138\168\232\191\148\229\136\169"
}, {
  field = "extension",
  value = "string",
  desc = "\230\137\169\229\177\149\229\173\151\230\174\181"
}, {})
DEF({
  type = "ChatConfig",
  file = "",
  desc = "\230\156\172\229\156\176\229\133\172\229\145\138"
}, {
  index = "id",
  value = "int",
  desc = "\230\160\135\232\175\134"
}, {
  field = "content",
  value = "string",
  desc = "\229\133\172\229\145\138\229\134\133\229\174\185"
}, {})
DEF({
  type = "ComposeConfig",
  file = "",
  desc = "\232\139\177\233\155\132\229\144\136\230\136\144"
}, {
  index = "id",
  value = "int",
  desc = "\230\160\135\232\175\134"
}, {
  field = "rewardId",
  value = "string",
  desc = "\229\165\150\229\138\177\230\160\135\232\175\134"
}, {
  field = "amount",
  value = "int",
  desc = "\230\182\136\232\128\151\230\149\176\233\135\143"
}, {
  field = "costType",
  value = "string",
  desc = "\230\182\136\232\180\185\231\177\187\229\158\139"
}, {
  field = "cost",
  value = "int",
  desc = "\230\182\136\232\180\185\230\149\176\233\135\143"
}, {
  field = "extendMax",
  value = "int",
  desc = "\230\156\128\229\164\167\232\161\165\232\182\179\230\149\176\233\135\143"
}, {
  field = "extendCost",
  value = "int",
  desc = "\232\161\165\232\182\179\230\149\176\233\135\143\230\182\136\232\128\151"
}, {
  field = "extendType",
  value = "string",
  desc = "\232\161\165\232\182\179\230\149\176\233\135\143\230\182\136\232\128\151"
}, {})
DEF({
  type = "ConfigValue",
  file = "",
  desc = "\230\173\166\229\176\134\233\129\147\229\133\183"
}, {
  index = "id",
  value = "string",
  desc = "\230\160\135\232\175\134"
}, {
  field = "content",
  value = "string",
  desc = "\229\134\133\229\174\185"
}, {})
DEF({
  type = "DamageRankReward",
  file = "",
  desc = "\229\141\149\230\172\161\230\156\128\233\171\152\228\188\164\229\174\179\230\142\146\229\144\141\229\165\150\229\138\177"
}, {
  index = "id",
  value = "int",
  desc = "\230\160\135\232\175\134"
}, {
  field = "activeId",
  value = "string",
  desc = "\230\180\187\229\138\168id"
}, {
  field = "name",
  value = "string",
  desc = "\229\165\150\229\138\177\229\144\141\229\173\151"
}, {
  field = "lowRank",
  value = "int",
  desc = "\230\156\128\228\189\142\229\144\141\230\172\161"
}, {
  field = "topRank",
  value = "int",
  desc = "\230\156\128\233\171\152\229\144\141\230\172\161"
}, {
  field = "showType",
  value = "string",
  desc = "\229\165\150\229\138\177\231\177\187\229\158\139"
}, {
  field = "showId",
  value = "int",
  desc = "\229\165\150\229\138\177\230\160\135\232\175\134"
}, {
  field = "rewardId",
  value = "string",
  desc = "\229\165\150\229\138\177id"
}, {})
DEF({
  type = "DemogActiveConfig",
  file = "",
  desc = "\233\173\148\231\165\158\230\180\187\229\138\168\230\151\182\233\151\180"
}, {
  index = "id",
  value = "string",
  desc = "\230\160\135\232\175\134"
}, {
  field = "type",
  value = "string",
  desc = "\230\180\187\229\138\168\231\177\187\229\158\139"
}, {
  field = "name",
  value = "string",
  desc = "\230\180\187\229\138\168\229\144\141\229\173\151"
}, {
  field = "showLevel",
  value = "string",
  desc = "\230\152\190\231\164\186\231\173\137\231\186\167\230\174\181"
}, {
  field = "luckHeros",
  value = "string",
  desc = "\229\133\139\230\152\159\229\141\161"
}, {
  field = "lottery",
  value = "string",
  desc = "\230\138\189\229\165\150\229\165\150\230\177\160"
}, {
  field = "desc",
  value = "string",
  desc = "\230\143\143\232\191\176"
}, {
  field = "playerLv",
  value = "string",
  desc = "\231\142\169\229\174\182\231\173\137\231\186\167"
}, {})
DEF({
  type = "DemogBattleConfig",
  file = "",
  desc = "\233\173\148\231\165\158"
}, {
  index = "id",
  value = "string",
  desc = "\230\160\135\232\175\134"
}, {
  field = "baseId",
  value = "int",
  desc = "\229\159\186\231\161\128id"
}, {})
DEF({
  type = "DramaConfig",
  file = "",
  desc = "\229\137\167\230\131\133\230\157\161\228\187\182"
}, {
  index = "id",
  value = "int",
  desc = "\230\160\135\232\175\134"
}, {
  field = "type",
  value = "string",
  desc = "\232\167\166\229\143\145\231\177\187\229\158\139"
}, {
  field = "battleId",
  value = "string",
  desc = "\230\136\152\230\150\151ID"
}, {
  field = "process",
  value = "string",
  desc = "\228\187\187\229\138\161\232\191\155\229\186\166"
}, {
  field = "file",
  value = "string",
  desc = "\233\133\141\231\189\174\230\150\135\228\187\182"
}, {})
DEF({
  type = "DramaContent",
  file = "",
  desc = "\229\137\167\230\131\133\229\175\185\232\175\157"
}, {
  index = "id",
  value = "int",
  desc = "\230\160\135\232\175\134"
}, {
  field = "content",
  value = "string",
  desc = "\229\144\141\231\167\176"
}, {})
DEF({
  type = "TaskSetting",
  file = "",
  desc = "\228\187\187\229\138\161(\233\135\145\229\184\129\231\137\136\230\156\172)"
}, {
  index = "id",
  value = "int",
  desc = "\230\160\135\232\175\134"
}, {
  field = "levelId",
  value = "int",
  desc = "\231\173\137\231\186\167\230\174\181id"
}, {
  field = "star",
  value = "int",
  desc = "\230\152\159\231\186\167"
}, {
  field = "targetType",
  value = "string",
  desc = "\228\187\187\229\138\161\231\155\174\230\160\135\231\177\187\229\158\139"
}, {
  field = "target",
  value = "int",
  desc = "\231\155\174\230\160\135\229\128\188"
}, {
  field = "rewardId",
  value = "string",
  desc = "\229\174\140\230\136\144\229\165\150\229\138\177"
}, {
  field = "freeRate",
  value = "int",
  desc = "\229\133\141\232\180\185\229\136\183\230\150\176\230\166\130\231\142\135"
}, {
  field = "costRate",
  value = "int",
  desc = "\228\187\153\231\142\137\229\136\183\230\150\176\230\166\130\231\142\135"
}, {
  field = "completeCost",
  value = "int",
  desc = "\231\171\139\229\141\179\229\174\140\230\136\144\230\182\136\232\128\151\228\187\153\231\142\137\230\149\176"
}, {
  field = "showtype",
  value = "string",
  desc = "\229\165\150\229\138\177\231\177\187\229\158\139"
}, {
  field = "showid",
  value = "string",
  desc = "\229\165\150\229\138\177\230\160\135\232\175\134"
}, {
  field = "sort",
  value = "int",
  desc = "\230\142\146\229\186\143"
}, {
  field = "name",
  value = "string",
  desc = "\231\164\188\229\140\133\229\144\141\229\173\151"
}, {
  field = "desc",
  value = "string",
  desc = "\232\175\180\230\152\142"
}, {})
DEF({
  type = "FeatRankReward",
  file = "",
  desc = "\229\138\159\229\139\139\230\142\146\229\144\141\229\165\150\229\138\177"
}, {
  index = "id",
  value = "int",
  desc = "\230\160\135\232\175\134"
}, {
  field = "activeId",
  value = "string",
  desc = "\230\180\187\229\138\168id"
}, {
  field = "topRank",
  value = "int",
  desc = "\230\156\128\233\171\152\229\144\141\230\172\161"
}, {
  field = "lowRank",
  value = "int",
  desc = "\230\156\128\228\189\142\229\144\141\230\172\161"
}, {
  field = "name",
  value = "string",
  desc = "\229\165\150\229\138\177\229\144\141\229\173\151"
}, {
  field = "group",
  value = "string",
  desc = "\231\187\132\229\136\171"
}, {
  field = "showType",
  value = "string",
  desc = "\229\165\150\229\138\177\231\177\187\229\158\139"
}, {
  field = "showId",
  value = "int",
  desc = "\229\165\150\229\138\177\230\160\135\232\175\134"
}, {
  field = "rewardId",
  value = "string",
  desc = "\229\165\150\229\138\177id"
}, {})
DEF({
  type = "FeatReward",
  file = "",
  desc = "\229\138\159\229\139\139\229\165\150\229\138\177"
}, {
  index = "id",
  value = "int",
  desc = "\230\160\135\232\175\134"
}, {
  field = "activeId",
  value = "string",
  desc = "\230\180\187\229\138\168id"
}, {
  field = "minLevel",
  value = "int",
  desc = "\229\143\175\228\187\165\233\162\134\229\143\150\231\154\132\230\156\128\229\176\143\231\173\137\231\186\167"
}, {
  field = "maxLevel",
  value = "int",
  desc = "\229\143\175\228\187\165\233\162\134\229\143\150\231\154\132\230\156\128\229\164\167\231\173\137\231\186\167"
}, {
  field = "name",
  value = "string",
  desc = "\229\165\150\229\138\177\229\144\141\229\173\151"
}, {
  field = "showType",
  value = "string",
  desc = "\229\165\150\229\138\177\231\177\187\229\158\139"
}, {
  field = "showId",
  value = "int",
  desc = "\229\165\150\229\138\177\230\160\135\232\175\134"
}, {
  field = "feat",
  value = "int",
  desc = "\229\138\159\229\139\139"
}, {
  field = "rewardId",
  value = "string",
  desc = "\229\165\150\229\138\177id"
}, {})
DEF({
  type = "FragmentExchange",
  file = "",
  desc = "\233\173\148\231\165\158\231\162\142\231\137\135\229\133\145\230\141\162"
}, {
  index = "id",
  value = "int",
  desc = "\230\160\135\232\175\134"
}, {
  field = "heroId",
  value = "int",
  desc = "\230\173\166\229\176\134id"
}, {
  field = "fragment",
  value = "int",
  desc = "\231\162\142\231\137\135\230\149\176\233\135\143"
}, {
  field = "costItems",
  value = "string",
  desc = "\229\133\182\228\187\150\230\182\136\232\128\151"
}, {
  field = "isLimit",
  value = "string",
  desc = "\230\152\175\229\144\166\233\153\144\232\180\173"
}, {
  field = "limit",
  value = "int",
  desc = "\229\133\145\230\141\162\230\172\161\230\149\176\233\153\144\229\136\182"
}, {
  field = "activeId",
  value = "string",
  desc = "\230\137\128\229\177\158\230\180\187\229\138\168id"
}, {
  field = "level",
  value = "int",
  desc = "\229\133\145\230\141\162\230\137\128\233\156\128\231\173\137\231\186\167"
}, {
  field = "mutexId",
  value = "string",
  desc = "\228\186\146\230\150\165ID"
}, {
  field = "desc",
  value = "string",
  desc = "\230\143\143\232\191\176"
}, {
  field = "sort",
  value = "int",
  desc = "\230\142\146\229\186\143\229\173\151\230\174\181"
}, {})
DEF({
  type = "Guide",
  file = "",
  desc = "Sheet1"
}, {
  index = "id",
  value = "string",
  desc = "\229\188\149\229\175\188"
}, {
  field = "GuideCondition",
  value = "string",
  desc = "\229\188\149\229\175\188\230\157\161\228\187\182"
}, {})
DEF({
  type = "HeroLevelConfig",
  file = "",
  desc = "\230\173\166\229\176\134\233\133\141\231\189\174"
}, {
  index = "id",
  value = "int",
  desc = "\230\160\135\232\175\134"
}, {
  field = "exp",
  value = "int",
  desc = "\229\141\135\231\186\167\229\159\186\231\161\128\231\187\143\233\170\140"
}, {})
DEF({
  type = "IntegralExchange",
  file = "",
  desc = "\231\167\175\229\136\134\229\165\150\229\138\177"
}, {
  index = "id",
  value = "int",
  desc = "\230\160\135\232\175\134"
}, {
  field = "name",
  value = "string",
  desc = "\229\165\150\229\138\177\229\144\141\229\173\151"
}, {
  field = "showType",
  value = "string",
  desc = "\229\165\150\229\138\177\231\177\187\229\158\139"
}, {
  field = "showId",
  value = "int",
  desc = "\229\165\150\229\138\177\230\160\135\232\175\134"
}, {
  field = "integral",
  value = "int",
  desc = "\230\182\136\232\128\151\231\167\175\229\136\134"
}, {
  field = "minLevel",
  value = "int",
  desc = "\229\133\145\230\141\162\230\156\128\229\176\143\231\173\137\231\186\167"
}, {
  field = "maxLevel",
  value = "int",
  desc = "\229\133\145\230\141\162\230\156\128\229\164\167\231\173\137\231\186\167"
}, {
  field = "chargeAmount",
  value = "int",
  desc = "\230\137\128\233\156\128\229\133\133\229\128\188\233\162\157\229\186\166"
}, {
  field = "rewardId",
  value = "string",
  desc = "\229\165\150\229\138\177id"
}, {})
DEF({
  type = "IntegralRankReward",
  file = "",
  desc = "\231\167\175\229\136\134\230\142\146\229\144\141\229\165\150\229\138\177"
}, {
  index = "id",
  value = "int",
  desc = "\230\160\135\232\175\134"
}, {
  field = "topRank",
  value = "int",
  desc = "\230\156\128\233\171\152\229\144\141\230\172\161"
}, {
  field = "lowRank",
  value = "int",
  desc = "\230\156\128\228\189\142\229\144\141\230\172\161"
}, {
  field = "rewardId",
  value = "string",
  desc = "\229\165\150\229\138\177id"
}, {
  field = "name",
  value = "string",
  desc = "\229\165\150\229\138\177\229\144\141\229\173\151"
}, {
  field = "showType",
  value = "string",
  desc = "\229\165\150\229\138\177\231\177\187\229\158\139"
}, {
  field = "showId",
  value = "int",
  desc = "\229\165\150\229\138\177\230\160\135\232\175\134"
}, {})
DEF({
  type = "IntegralReward",
  file = "",
  desc = "\231\167\175\229\136\134\229\165\150\229\138\177"
}, {
  index = "id",
  value = "int",
  desc = "\230\160\135\232\175\134"
}, {
  field = "name",
  value = "string",
  desc = "\229\165\150\229\138\177\229\144\141\229\173\151"
}, {
  field = "showType",
  value = "string",
  desc = "\229\165\150\229\138\177\231\177\187\229\158\139"
}, {
  field = "showId",
  value = "int",
  desc = "\229\165\150\229\138\177\230\160\135\232\175\134"
}, {
  field = "minLevel",
  value = "int",
  desc = "\231\173\137\231\186\167\228\184\139\233\153\144"
}, {
  field = "maxLevel",
  value = "int",
  desc = "\231\173\137\231\186\167\228\184\138\233\153\144"
}, {
  field = "integral",
  value = "int",
  desc = "\231\167\175\229\136\134"
}, {
  field = "rewardId",
  value = "string",
  desc = "\229\165\150\229\138\177id"
}, {})
DEF({
  type = "InviteRewardConfig",
  file = "",
  desc = "\233\130\128\232\175\183\229\165\189\229\143\139\229\165\150\229\138\177"
}, {
  index = "id",
  value = "int",
  desc = "\230\160\135\232\175\134"
}, {
  field = "inviteNum",
  value = "int",
  desc = "\233\130\128\232\175\183\231\142\169\229\174\182\230\149\176\233\135\143"
}, {
  field = "inviteLevel",
  value = "int",
  desc = "\233\130\128\232\175\183\231\142\169\229\174\182\231\173\137\231\186\167"
}, {
  field = "reachType",
  value = "string",
  desc = "\232\190\190\230\136\144\231\177\187\229\158\139"
}, {
  field = "rewardId",
  value = "string",
  desc = "\229\165\150\229\138\177id"
}, {
  field = "rewardInfo",
  value = "string",
  desc = "\229\165\150\229\138\177\229\134\133\229\174\185"
}, {})
DEF({
  type = "ItemConfig",
  file = "",
  desc = "\232\147\157\229\141\161"
}, {
  index = "id",
  value = "int",
  desc = "\230\160\135\232\175\134"
}, {
  field = "name",
  value = "string",
  desc = "\229\144\141\229\173\151"
}, {
  field = "type",
  value = "string",
  desc = "\231\177\187\229\158\139"
}, {
  field = "useLevel",
  value = "int",
  desc = "\228\189\191\231\148\168\231\173\137\231\186\167"
}, {
  field = "quality",
  value = "int",
  desc = "\229\147\129\232\180\168"
}, {
  field = "stackLimit",
  value = "int",
  desc = "\229\160\134\229\143\160\228\184\138\233\153\144"
}, {
  field = "sellPrice",
  value = "int",
  desc = "\229\135\186\229\148\174\228\187\183\230\160\188"
}, {
  field = "baseId",
  value = "int",
  desc = "\230\173\166\229\176\134"
}, {
  field = "sort",
  value = "int",
  desc = "\230\142\146\229\186\143"
}, {
  field = "sortType",
  value = "int",
  desc = "\230\142\146\229\186\143\231\177\187\229\158\139"
}, {
  field = "sell",
  value = "int",
  desc = "\230\152\175\229\144\166\229\143\175\228\187\165\229\135\186\229\148\174"
}, {})
DEF({
  type = "LevelConfig",
  file = "",
  desc = "\231\173\137\231\186\167\233\133\141\231\189\174\228\191\161\230\129\175"
}, {
  index = "id",
  value = "int",
  desc = "\231\173\137\231\186\167"
}, {
  field = "exp",
  value = "double",
  desc = "\229\141\135\231\186\167\231\187\143\233\170\140"
}, {
  field = "packSize",
  value = "int",
  desc = "\230\173\166\229\176\134\232\131\140\229\140\133"
}, {
  field = "leadership",
  value = "int",
  desc = "\233\162\134\229\175\188\229\138\155"
}, {
  field = "friends",
  value = "int",
  desc = "\229\165\189\229\143\139\228\184\138\233\153\144"
}, {
  field = "addPoints",
  value = "int",
  desc = "\229\141\135\231\186\167\229\162\158\229\138\160\228\189\147\229\138\155"
}, {
  field = "star",
  value = "string",
  desc = "\230\152\159\231\186\167"
}, {
  field = "integral",
  value = "string",
  desc = "\231\171\158\230\138\128\229\156\186\231\167\175\229\136\134"
}, {
  field = "baseFeat",
  value = "int",
  desc = "\233\173\148\231\165\158\229\138\159\229\139\139"
}, {
  field = "dailyCheckSegment",
  value = "int",
  desc = "\231\173\190\229\136\176\231\173\137\231\186\167\230\174\181"
}, {
  field = "contriRewardRate",
  value = "string",
  desc = "\230\141\144\231\140\174\229\165\150\229\138\177\228\184\142\233\151\168\230\180\190\231\173\137\231\186\167\229\165\150\229\138\177\231\179\187\230\149\176"
}, {
  field = "contriRewardRate",
  value = "string",
  desc = "\230\141\144\231\140\174\229\165\150\229\138\177\228\184\142\233\151\168\230\180\190\231\173\137\231\186\167\229\165\150\229\138\177\228\184\170\228\186\186\229\138\159\229\139\139\231\179\187\230\149\176"
}, {
  field = "prayCost",
  value = "string",
  desc = "\230\139\156\232\180\162\231\165\158\230\172\161\230\149\176\228\184\142\232\138\177\232\180\185\228\187\153\231\142\137"
}, {
  field = "prayReward",
  value = "string",
  desc = "\230\139\156\232\180\162\231\165\158\232\191\148\233\147\156\229\184\129\230\149\176\233\135\143"
}, {
  field = "countryHoldReward",
  value = "string",
  desc = "\229\159\142\230\177\160\229\141\160\233\162\134\229\165\150\229\138\177"
}, {})
DEF({
  type = "Lock",
  file = "",
  desc = "\233\148\129"
}, {
  index = "id",
  value = "string",
  desc = "\229\134\133\229\174\185"
}, {
  field = "level",
  value = "int",
  desc = "\231\173\137\231\186\167"
}, {
  field = "campaign",
  value = "string",
  desc = "\233\128\154\229\133\179\230\136\152\229\189\185"
}, {
  field = "battle",
  value = "string",
  desc = "\233\128\154\229\133\179\229\137\175\230\156\172"
}, {
  field = "activeBattle",
  value = "string",
  desc = "\233\128\154\229\133\179\230\180\187\229\138\168\229\137\175\230\156\172"
}, {
  field = "eliteCampaign",
  value = "string",
  desc = "\231\178\190\232\139\177\229\137\175\230\156\172\230\136\152\229\189\185"
}, {
  field = "eliteBattle",
  value = "string",
  desc = "\231\178\190\232\139\177\229\137\175\230\156\172\231\130\185"
}, {
  field = "week",
  value = "string",
  desc = "\229\145\168\229\141\161VIP"
}, {
  field = "vip",
  value = "string",
  desc = "\230\156\136\229\141\161VIP"
}, {
  field = "charge",
  value = "int",
  desc = "\229\133\133\229\128\188\233\162\157\229\186\166"
}, {
  field = "lotteryName",
  value = "string",
  desc = "\229\165\150\230\177\160\229\144\141\229\173\151"
}, {})
DEF({
  type = "MailTemplate",
  file = "",
  desc = "Sheet1"
}, {
  index = "id",
  value = "int",
  desc = "\230\160\135\232\175\134"
}, {
  field = "type",
  value = "string",
  desc = "\231\177\187\229\158\139"
}, {
  field = "title",
  value = "string",
  desc = "\230\160\135\233\162\152"
}, {
  field = "content",
  value = "string",
  desc = "\229\134\133\229\174\185"
}, {})
DEF({
  type = "Post",
  file = "",
  desc = "\231\179\187\231\187\159\228\187\165\229\143\138\229\133\182\228\187\150"
}, {
  index = "id",
  value = "string",
  desc = "\230\160\135\232\175\134"
}, {
  field = "channel",
  value = "string",
  desc = "\228\184\139\232\161\140\233\162\145\233\129\147"
}, {
  field = "show",
  value = "string",
  desc = "\230\152\190\231\164\186\233\162\145\233\129\147"
}, {
  field = "template",
  value = "string",
  desc = "\230\168\161\230\157\191\229\134\133\229\174\185"
}, {
  field = "delay",
  value = "string",
  desc = "\230\152\190\231\164\186\230\151\182\233\151\180"
}, {
  field = "pic",
  value = "string",
  desc = "\229\155\190\231\137\135\232\183\175\229\190\132"
}, {})
DEF({
  type = "RandName",
  file = "",
  desc = "\229\167\147"
}, {
  field = "id",
  value = "int",
  desc = "\230\160\135\232\175\134"
}, {
  field = "type",
  value = "int",
  desc = "\231\177\187\229\158\139:1-\229\167\147;2-\231\148\183\229\144\141;3-\229\165\179\229\144\141"
}, {
  field = "value",
  value = "string",
  desc = "\229\173\151\231\172\166\228\184\178\229\128\188,\230\132\143\228\185\137\228\190\157type\232\128\140\229\174\154"
}, {})
DEF({
  type = "RankConfig",
  file = "",
  desc = "\233\133\141\231\189\174\232\140\131\228\190\139"
}, {
  index = "id",
  value = "int",
  desc = "\230\160\135\232\175\134"
}, {
  field = "costs",
  value = "int",
  desc = "\229\175\187\229\174\157\233\147\156\229\184\129"
}, {
  field = "npcname",
  value = "string",
  desc = "NPC\229\144\141\229\173\151"
}, {})
DEF({
  type = "RegisterForbidden",
  file = "",
  desc = "\232\191\135\230\187\164\229\144\141\229\173\151"
}, {
  index = "id",
  value = "string",
  desc = "\230\160\135\232\175\134"
}, {
  field = "name",
  value = "string",
  desc = "\229\144\141\229\173\151"
}, {})
DEF({
  type = "RewardConfig",
  file = "",
  desc = "\229\184\144\229\143\183\229\136\157\229\167\139\229\140\150\230\149\176\230\141\174"
}, {
  index = "id",
  value = "string",
  desc = "\230\160\135\232\175\134"
}, {
  field = "fixed",
  value = "string",
  desc = "\229\155\186\229\174\154\229\134\133\229\174\185"
}, {})
DEF({
  type = "RoleSkin",
  file = "",
  desc = "\230\173\166\229\176\134\229\141\161"
}, {
  index = "id",
  value = "int",
  desc = "\230\160\135\232\175\134"
}, {
  field = "MiddleCard",
  value = "string",
  desc = "\228\184\173\229\164\180\229\131\143"
}, {
  field = "BigCard",
  value = "string",
  desc = "\229\164\167\229\164\180\229\131\143"
}, {})
DEF({
  type = "RouletteLotteryConfig",
  file = "",
  desc = "\232\189\174\231\155\152\230\138\189\229\165\150"
}, {
  index = "id",
  value = "int",
  desc = "ID"
}, {
  field = "number",
  value = "int",
  desc = "\232\189\172\231\155\152\230\160\188\230\149\176"
}, {
  field = "level",
  value = "int",
  desc = "\230\138\189\229\165\150\231\173\137\231\186\167"
}, {
  field = "showType",
  value = "string",
  desc = "\229\165\150\229\138\177\231\177\187\229\158\139"
}, {
  field = "rewardId",
  value = "string",
  desc = "\229\165\150\229\138\177ID"
}, {
  field = "showId",
  value = "string",
  desc = "\229\165\150\229\138\177\230\160\135\232\175\134"
}, {
  field = "rewardName",
  value = "string",
  desc = "\229\165\150\229\138\177\229\144\141\229\173\151"
}, {
  field = "rewardNum",
  value = "string",
  desc = "\229\165\150\229\138\177\230\149\176\233\135\143"
}, {})
DEF({
  type = "SkillConfig",
  file = "",
  desc = "\230\153\174\233\128\154\230\138\128\232\131\189"
}, {
  index = "id",
  value = "int",
  desc = "\230\160\135\232\175\134"
}, {
  field = "skillname",
  value = "string",
  desc = "\230\138\128\232\131\189\229\144\141\231\167\176"
}, {
  field = "isMasterSkill",
  value = "string",
  desc = "\230\152\175\229\144\166\229\191\133\230\157\128\230\138\128(\229\173\152\229\156\168\229\161\171true)"
}, {
  field = "level",
  value = "int",
  desc = "\229\189\147\229\137\141\231\173\137\231\186\167"
}, {
  field = "maxlev",
  value = "int",
  desc = "\230\156\128\229\164\167\231\173\137\231\186\167"
}, {
  field = "state",
  value = "string",
  desc = "\229\136\157\229\167\139\229\140\150\231\138\182\230\128\129"
}, {
  field = "skillRate",
  value = "double",
  desc = "\230\136\152\230\150\151\229\138\155\231\179\187\230\149\176"
}, {
  field = "next",
  value = "int",
  desc = "\228\184\139\228\184\128\231\186\167\230\138\128\232\131\189"
}, {
  field = "exps",
  value = "int",
  desc = "\230\138\128\232\131\189\229\141\135\231\186\167\231\187\143\233\170\140"
}, {
  field = "maxExps",
  value = "int",
  desc = "\230\187\161\231\186\167\231\187\143\233\170\140"
}, {
  field = "costItems",
  value = "string",
  desc = "\229\141\135\231\186\167\229\141\161\231\137\140"
}, {
  field = "costCoins",
  value = "int",
  desc = "\230\175\143\229\188\160\229\141\161\231\137\140\233\147\156\229\184\129"
}, {
  field = "conduct",
  value = "int",
  desc = "\230\138\128\232\131\189\232\161\168\231\142\176\230\149\136\230\158\156"
}, {
  field = "skilldesc",
  value = "string",
  desc = "\230\138\128\232\131\189\232\175\180\230\152\142"
}, {
  field = "effectdesc",
  value = "string",
  desc = "\230\138\128\232\131\189\233\135\138\230\148\190\230\143\143\232\191\176"
}, {})
DEF({
  type = "RebirthActivePath",
  file = "",
  desc = "\230\180\187\229\138\168"
}, {
  index = "id",
  value = "string",
  desc = "\230\160\135\232\175\134"
}, {
  field = "namePath",
  value = "string",
  desc = "\229\144\141\229\173\151\232\183\175\229\190\132"
}, {})
DEF({
  type = "HeroRankUpActivity",
  file = "",
  desc = "\230\180\187\229\138\168"
}, {
  index = "id",
  value = "string",
  desc = "\230\160\135\232\175\134"
}, {
  field = "desc",
  value = "string",
  desc = "\230\143\143\232\191\176"
}, {})
DEF({
  type = "RedCardComposeConfig",
  file = "",
  desc = "\231\186\162\229\141\161\229\144\136\230\136\144"
}, {
  index = "id",
  value = "int",
  desc = "\230\160\135\232\175\134"
}, {
  field = "activeId",
  value = "int",
  desc = "\230\180\187\229\138\168ID"
}, {
  field = "rewardId",
  value = "string",
  desc = "\229\165\150\229\138\177ID"
}, {
  field = "fragment",
  value = "string",
  desc = "\231\162\142\231\137\135\230\149\176\233\135\143"
}, {
  field = "costType",
  value = "string",
  desc = "\230\182\136\232\180\185\231\177\187\229\158\139"
}, {
  field = "cost",
  value = "int",
  desc = "\230\182\136\232\180\185\230\149\176\233\135\143"
}, {
  field = "baseId",
  value = "int",
  desc = "\232\139\177\233\155\132ID"
}, {
  field = "level",
  value = "int",
  desc = "\229\188\128\229\144\175\231\173\137\231\186\167"
}, {
  field = "redType",
  value = "int",
  desc = "\231\186\162\229\141\161\231\177\187\229\158\139"
}, {
  field = "sort",
  value = "int",
  desc = "\230\142\146\229\186\143"
}, {})
DEF({
  type = "DailyCheckConfig",
  file = "",
  desc = "\230\175\143\230\151\165\231\173\190\229\136\176\233\133\141\231\189\174\228\191\161\230\129\175"
}, {
  index = "id",
  value = "int",
  desc = "\230\160\135\232\175\134ID"
}, {
  field = "showType",
  value = "string",
  desc = "\229\165\150\229\138\177\231\177\187\229\158\139"
}, {
  field = "showId",
  value = "int",
  desc = "\229\165\150\229\138\177\230\160\135\232\175\134"
}, {
  field = "amount",
  value = "int",
  desc = "\230\149\176\233\135\143"
}, {
  field = "levelSegment",
  value = "int",
  desc = "\231\173\190\229\136\176\231\173\137\231\186\167\230\174\181"
}, {
  field = "continueDay",
  value = "int",
  desc = "\232\191\158\231\187\173\231\153\187\229\189\149\229\164\169\230\149\176"
}, {
  field = "rewardType",
  value = "string",
  desc = "\229\165\150\229\138\177\231\177\187\229\158\139"
}, {})
DEF({
  type = "RankRewardConfig",
  file = "",
  desc = "\230\142\146\229\144\141\229\165\150\229\138\177\233\133\141\231\189\174"
}, {
  index = "id",
  value = "int",
  desc = "\230\160\135\232\175\134"
}, {
  field = "topRank",
  value = "int",
  desc = "\230\156\128\233\171\152\229\144\141\230\172\161"
}, {
  field = "lowRank",
  value = "int",
  desc = "\230\156\128\228\189\142\229\144\141\230\172\161"
}, {
  field = "desId",
  value = "int",
  desc = "\231\167\176\229\143\183ID"
}, {
  field = "name",
  value = "string",
  desc = "\229\165\150\229\138\177\229\144\141\229\173\151"
}, {
  field = "showType",
  value = "string",
  desc = "\229\165\150\229\138\177\231\177\187\229\158\139"
}, {
  field = "showId",
  value = "int",
  desc = "\229\165\150\229\138\177\230\160\135\232\175\134"
}, {
  field = "icoPath",
  value = "string",
  desc = "\231\167\176\229\143\183ICO"
}, {
  field = "logoPath",
  value = "string",
  desc = "\231\167\176\229\143\183\229\176\143logo"
}, {})
DEF({
  type = "PVPBuff",
  file = "",
  desc = "PVPBuff"
}, {
  index = "id",
  value = "int",
  desc = "\230\160\135\232\175\134"
}, {
  field = "rankID",
  value = "int",
  desc = "\230\156\128\233\171\152\229\144\141\230\172\161"
}, {
  field = "lowRank",
  value = "int",
  desc = "\230\156\128\228\189\142\229\144\141\230\172\161"
}, {
  field = "highRank",
  value = "int",
  desc = "\230\156\128\233\171\152\229\144\141\230\172\161"
}, {
  field = "buffID",
  value = "string",
  desc = "BUFF\229\144\141\229\173\151"
}, {})
DEF({
  type = "ArtifactLevelSetting",
  file = "",
  desc = "\233\153\132\229\138\160\229\177\158\230\128\167\233\133\141\231\189\174\228\191\161\230\129\175"
}, {
  index = "id",
  value = "string",
  desc = "\230\160\135\232\175\134"
}, {
  field = "alters",
  value = "string",
  desc = "\233\153\132\229\138\160\231\154\132\229\177\158\230\128\167"
}, {
  field = "desr",
  value = "string",
  desc = "\229\189\147\229\137\141\233\152\182\230\174\181\230\143\143\232\191\176\233\152\182"
}, {
  field = "desrNext",
  value = "string",
  desc = "\228\184\139\233\152\182\229\162\158\229\138\160\229\177\158\230\128\167"
}, {})
DEF({
  type = "BeeEffGeeLevelSetting",
  file = "",
  desc = "\228\184\142\231\165\158\229\153\168\233\152\182\230\149\176(\231\173\137\231\186\167)\231\155\184\229\133\179\231\154\132\233\133\141\231\189\174\228\191\161\230\129\175"
}, {
  index = "id",
  value = "int",
  desc = "\231\165\158\229\153\168\231\173\137\231\186\167"
}, {
  field = "progress",
  value = "int",
  desc = "\229\141\135\233\152\182\232\191\155\229\186\166\229\128\188"
}, {
  field = "normalProgressFactor",
  value = "double",
  desc = "\230\173\163\229\184\184\232\191\155\229\186\166\231\179\187\230\149\176"
}, {
  field = "stoneType",
  value = "string",
  desc = "\230\179\168\233\173\130\230\151\182\228\188\152\229\133\136\228\189\191\231\148\168\231\154\132\229\166\150\233\173\130\231\159\179\231\177\187\229\158\139"
}, {
  field = "imgLv",
  value = "int",
  desc = "\232\145\171\232\138\166\229\155\190\231\137\135\231\173\137\231\186\167"
}, {})
DEF({
  type = "SoulstonePackageSetting",
  file = "",
  desc = "Sheet1"
}, {
  index = "id",
  value = "int",
  desc = "\230\149\176\233\135\143"
}, {
  field = "soulStoneType",
  value = "string",
  desc = "\229\166\150\233\173\130\231\159\179\231\177\187\229\158\139"
}, {
  field = "targetProgress",
  value = "int",
  desc = "\230\137\128\230\183\187\229\138\160\231\154\132\231\155\174\230\160\135\232\191\155\229\186\166\229\128\188"
}, {
  field = "cost",
  value = "int",
  desc = "\229\142\159\228\187\183"
}, {
  field = "onSaleCost",
  value = "int",
  desc = "\230\137\147\230\138\152\228\187\183\230\160\188"
}, {
  field = "stoneCount",
  value = "int",
  desc = "\232\180\173\228\185\176\231\154\132\230\149\176\233\135\143"
}, {
  field = "mallId",
  value = "int",
  desc = "\229\149\134\229\159\142id"
}, {
  field = "giftCount",
  value = "int",
  desc = "\232\181\160\233\128\129\230\149\176\233\135\143"
}, {})
DEF({
  type = "TokenCoinConfig",
  file = "",
  desc = "\231\133\174\233\165\186\229\173\144"
}, {
  index = "id",
  value = "int",
  desc = "\230\160\135\232\175\134ID"
}, {
  field = "name",
  value = "string",
  desc = "\229\165\150\229\138\177\229\144\141\229\173\151"
}, {
  field = "showType",
  value = "string",
  desc = "\229\165\150\229\138\177\231\177\187\229\158\139"
}, {
  field = "showId",
  value = "int",
  desc = "\229\165\150\229\138\177\230\160\135\232\175\134"
}, {
  field = "costTokenCoin",
  value = "int",
  desc = "\230\137\128\233\156\128\230\180\187\229\138\168\228\187\163\229\184\129"
}, {
  field = "minLevel",
  value = "int",
  desc = "\229\133\145\230\141\162\230\156\128\228\189\142\231\173\137\231\186\167"
}, {
  field = "maxLevel",
  value = "int",
  desc = "\229\133\145\230\141\162\230\156\128\233\171\152\231\173\137\231\186\167"
}, {
  field = "mallId",
  value = "int",
  desc = "\230\137\128\229\177\158\229\149\134\229\159\142ID"
}, {
  field = "sort",
  value = "int",
  desc = "\230\142\146\229\186\143\229\173\151\230\174\181"
}, {
  field = "limit",
  value = "int",
  desc = "\230\180\187\229\138\168\230\156\159\233\151\180\229\133\145\230\141\162\230\172\161\230\149\176\228\184\138\233\153\144"
}, {})
DEF({
  type = "StoneExchangePackage",
  file = "",
  desc = "\229\166\150\233\173\130\231\159\179\229\133\145\230\141\162\229\165\151\233\164\144"
}, {
  index = "id",
  value = "int",
  desc = "\230\160\135\232\175\134"
}, {
  field = "name",
  value = "string",
  desc = "\229\165\150\229\138\177\229\144\141\229\173\151"
}, {
  field = "showType",
  value = "string",
  desc = "\229\165\150\229\138\177\231\177\187\229\158\139"
}, {
  field = "showId",
  value = "int",
  desc = "\229\165\150\229\138\177\230\160\135\232\175\134"
}, {
  field = "costStoneType",
  value = "string",
  desc = "\229\166\150\233\173\130\231\159\179\231\177\187\229\158\139"
}, {
  field = "costNum",
  value = "int",
  desc = "\230\182\136\232\128\151\231\154\132\229\166\150\233\173\130\231\159\179\230\149\176\233\135\143"
}, {})
DEF({
  type = "FirstDailyCheckConfig",
  file = "",
  desc = "\233\166\150\230\172\1617\229\164\169\231\173\190\229\136\176\233\133\141\231\189\174"
}, {
  index = "id",
  value = "int",
  desc = "\230\160\135\232\175\134ID"
}, {
  field = "showType",
  value = "string",
  desc = "\229\165\150\229\138\177\231\177\187\229\158\139"
}, {
  field = "showId",
  value = "int",
  desc = "\229\165\150\229\138\177\230\160\135\232\175\134"
}, {
  field = "amount",
  value = "int",
  desc = "\230\149\176\233\135\143"
}, {
  field = "levelSegment",
  value = "int",
  desc = "\231\173\190\229\136\176\231\173\137\231\186\167\230\174\181"
}, {
  field = "continueDay",
  value = "int",
  desc = "\232\191\158\231\187\173\231\153\187\229\189\149\229\164\169\230\149\176"
}, {
  field = "rewardType",
  value = "string",
  desc = "\229\165\150\229\138\177\231\177\187\229\158\139"
}, {})
DEF({
  type = "GroupbuyRewardSetting",
  file = "",
  desc = "\229\133\133\229\128\188\231\148\168\230\136\183\230\149\176"
}, {
  index = "id",
  value = "int",
  desc = "\230\160\135\232\175\134"
}, {
  field = "type",
  value = "string",
  desc = "\231\177\187\229\158\139"
}, {
  field = "count",
  value = "int",
  desc = "\229\145\168\229\141\161\228\186\186\230\149\176"
}, {
  field = "userType",
  value = "string",
  desc = "\233\162\134\229\143\150\230\157\161\228\187\182"
}, {
  field = "rewardId",
  value = "string",
  desc = "\231\148\168\230\136\183\229\165\150\229\138\177id"
}, {
  field = "showtype",
  value = "string",
  desc = "\229\165\150\229\138\177\231\177\187\229\158\139"
}, {
  field = "showid",
  value = "string",
  desc = "\229\165\150\229\138\177\230\160\135\232\175\134"
}, {
  field = "sort",
  value = "int",
  desc = "\230\142\146\229\186\143"
}, {
  field = "name",
  value = "string",
  desc = "\231\164\188\229\140\133\229\144\141\229\173\151"
}, {
  field = "desc",
  value = "string",
  desc = "\232\175\180\230\152\142"
}, {})
DEF({
  type = "OpenBetaGoodsConfig",
  file = "",
  desc = "\229\133\172\230\181\139\232\182\133\229\128\188\229\149\134\229\147\129"
}, {
  index = "id",
  value = "int",
  desc = "ID"
}, {
  field = "name",
  value = "string",
  desc = "\231\164\188\229\140\133\229\144\141\229\173\151"
}, {
  field = "showTypes",
  value = "string",
  desc = "\229\165\150\229\138\177\231\177\187\229\158\139"
}, {
  field = "showIds",
  value = "string",
  desc = "\229\165\150\229\138\177\230\160\135\232\175\134"
}, {
  field = "counts",
  value = "string",
  desc = "\229\165\150\229\138\177\230\149\176\233\135\143"
}, {
  field = "fullPrice",
  value = "string",
  desc = "\229\142\159\228\187\183"
}, {
  field = "sort",
  value = "int",
  desc = "\230\142\146\229\186\143"
}, {
  field = "mallId",
  value = "int",
  desc = "\229\149\134\229\159\142ID"
}, {
  field = "limit",
  value = "int",
  desc = "\230\175\143\230\151\165\233\153\144\232\180\173\230\172\161\230\149\176"
}, {
  field = "price",
  value = "string",
  desc = "\230\175\143\230\172\161\232\180\173\228\185\176\228\187\183\230\160\188"
}, {
  field = "lockKey",
  value = "string",
  desc = "\229\138\159\232\131\189\233\148\129"
}, {
  field = "desc",
  value = "string",
  desc = "\230\138\189\229\165\150\230\143\143\232\191\176"
}, {
  field = "discount",
  value = "int",
  desc = "\230\138\152\230\137\163"
}, {})
DEF({
  type = "SwapCardSetting",
  file = "",
  desc = "\229\174\157\231\174\177\233\146\165\229\140\153"
}, {
  index = "id",
  value = "int",
  desc = "\229\141\161\231\137\140baseId"
}, {
  field = "yaoFragments",
  value = "string",
  desc = "\229\133\145\230\141\162\229\166\150\230\151\143\229\141\161\231\137\140\230\182\136\232\128\151\231\154\132\228\184\135\232\131\189\231\162\142\231\137\135"
}, {
  field = "yaoCosts",
  value = "string",
  desc = "\229\133\145\230\141\162\229\166\150\230\151\143\229\141\161\231\137\140\230\182\136\232\128\151"
}, {
  field = "yaoIds",
  value = "string",
  desc = "\229\143\175\228\187\165\229\133\145\230\141\162\231\154\132\229\166\150\230\151\143\229\141\161\231\137\140id"
}, {
  field = "xianFragments",
  value = "string",
  desc = "\229\133\145\230\141\162\228\187\153\230\151\143\229\141\161\231\137\140\230\182\136\232\128\151\231\154\132\228\184\135\232\131\189\231\162\142\231\137\135"
}, {
  field = "xianCosts",
  value = "string",
  desc = "\229\133\145\230\141\162\228\187\153\230\151\143\229\141\161\231\137\140\230\182\136\232\128\151"
}, {
  field = "xianIds",
  value = "string",
  desc = "\229\143\175\228\187\165\229\133\145\230\141\162\231\154\132\228\187\153\230\151\143\229\141\161\231\137\140id"
}, {
  field = "lingFragments",
  value = "string",
  desc = "\229\133\145\230\141\162\231\129\181\230\151\143\229\141\161\231\137\140\230\182\136\232\128\151\231\154\132\228\184\135\232\131\189\231\162\142\231\137\135"
}, {
  field = "lingCosts",
  value = "string",
  desc = "\229\133\145\230\141\162\231\129\181\230\151\143\229\141\161\231\137\140\230\182\136\232\128\151"
}, {
  field = "lingIds",
  value = "string",
  desc = "\229\143\175\228\187\165\229\133\145\230\141\162\231\154\132\231\129\181\230\151\143\229\141\161\231\137\140id"
}, {})
DEF({
  type = "DemogConfig",
  file = "",
  desc = "\233\172\188\231\142\139"
}, {
  index = "id",
  value = "string",
  desc = "\230\160\135\232\175\134"
}, {
  field = "star",
  value = "int",
  desc = "\229\143\172\229\148\164\233\172\188\231\172\166\230\152\159\233\152\182"
}, {
  field = "menpaiLevel",
  value = "int",
  desc = "\233\151\168\230\180\190\231\173\137\231\186\167"
}, {
  field = "baseId",
  value = "int",
  desc = "\229\159\186\231\161\128id"
}, {
  field = "demogType",
  value = "string",
  desc = "\233\172\188\231\142\139\231\177\187\229\158\139"
}, {
  field = "maxRewardCount",
  value = "string",
  desc = "\230\156\128\229\164\167\230\148\187\229\135\187\229\165\150\229\138\177\230\149\176\233\135\143"
}, {
  field = "showTypeId",
  value = "string",
  desc = "\229\165\150\229\138\177\231\177\187\229\158\139"
}, {
  field = "showIds",
  value = "string",
  desc = "\229\165\150\229\138\177\230\160\135\232\175\134"
}, {
  field = "counts",
  value = "string",
  desc = "\229\165\150\229\138\177\230\149\176\233\135\143"
}, {
  field = "demogLevel",
  value = "int",
  desc = "\233\173\148\231\165\158\231\173\137\231\186\167"
}, {})
DEF({
  type = "MenpaiLevelConfig",
  file = "",
  desc = "MemberCountLimit"
}, {
  index = "level",
  value = "int",
  desc = "\231\173\137\231\186\167"
}, {
  field = "id",
  value = "int",
  desc = "\229\148\175\228\184\128\230\160\135\232\175\134"
}, {
  field = "count",
  value = "int",
  desc = "\228\186\186\230\149\176"
}, {
  field = "needExp",
  value = "int",
  desc = "\229\141\135\231\186\167\233\156\128\232\166\129\231\187\143\233\170\140"
}, {
  field = "elderCount",
  value = "int",
  desc = "\233\149\191\232\128\129\230\156\128\229\164\167\230\149\176\233\135\143"
}, {
  field = "applyCount",
  value = "int",
  desc = "\230\156\128\229\164\167\231\148\179\232\175\183\230\149\176\233\135\143"
}, {
  field = "openFunctions",
  value = "string",
  desc = "\232\175\165\233\151\168\230\180\190\231\173\137\231\186\167\229\188\128\230\148\190\229\138\159\232\131\189"
}, {
  field = "expRate",
  value = "double",
  desc = "\232\167\146\232\137\178\231\187\143\233\170\140\229\138\160\230\136\144"
}, {
  field = "godDesc",
  value = "string",
  desc = "\230\139\156\232\180\162\231\165\158\229\165\150\229\138\177\230\143\143\232\191\176"
}, {})
DEF({
  type = "JobAuthSetting",
  file = "",
  desc = "\233\172\188\231\142\139"
}, {
  index = "job",
  value = "string",
  desc = "\232\129\140\228\189\141"
}, {
  field = "id",
  value = "int",
  desc = "\229\148\175\228\184\128\230\160\135\232\175\134"
}, {
  field = "auths",
  value = "string",
  desc = "\230\157\131\233\153\144\233\155\134\229\144\136"
}, {})
DEF({
  type = "BuyPackCostSetting",
  file = "",
  desc = "TalismanSetting"
}, {
  index = "id",
  value = "int",
  desc = "\232\180\173\228\185\176\230\172\161\230\149\176"
}, {
  field = "cost",
  value = "int",
  desc = "\232\180\173\228\185\176\228\187\183\230\160\188"
}, {})
DEF({
  type = "FragmentExSetting",
  file = "",
  desc = "\231\162\142\231\137\135\229\133\145\230\141\162"
}, {
  index = "id",
  value = "int",
  desc = "\230\160\135\232\175\134"
}, {
  field = "name",
  value = "string",
  desc = "\229\165\150\229\138\177\229\144\141\229\173\151"
}, {
  field = "showType",
  value = "string",
  desc = "\229\165\150\229\138\177\231\177\187\229\158\139"
}, {
  field = "showId",
  value = "int",
  desc = "\229\165\150\229\138\177\230\160\135\232\175\134"
}, {
  field = "TalismanID",
  value = "int",
  desc = "\230\179\149\229\174\157ID"
}, {
  field = "fragment",
  value = "int",
  desc = "\230\182\136\232\128\151\231\162\142\231\137\135"
}, {
  field = "costType",
  value = "string",
  desc = "\231\162\142\231\137\135\231\177\187\229\158\139"
}, {
  field = "minLevel",
  value = "int",
  desc = "\229\133\145\230\141\162\230\156\128\229\176\143\231\173\137\231\186\167"
}, {
  field = "maxLevel",
  value = "int",
  desc = "\229\133\145\230\141\162\230\156\128\229\164\167\231\173\137\231\186\167"
}, {
  field = "chargeAmount",
  value = "int",
  desc = "\230\137\128\233\156\128\229\133\133\229\128\188\233\162\157\229\186\166"
}, {
  field = "rewardId",
  value = "string",
  desc = "\229\165\150\229\138\177id"
}, {
  field = "sort",
  value = "int",
  desc = "\230\142\146\229\186\143"
}, {})
DEF({
  type = "TalismanLevelSetting",
  file = "",
  desc = "TalismanLevelSetting"
}, {
  index = "id",
  value = "string",
  desc = "\230\160\135\232\175\134"
}, {
  field = "name",
  value = "string",
  desc = "\230\179\149\229\174\157\229\144\141\229\173\151"
}, {
  field = "exp",
  value = "int",
  desc = "\229\141\135\231\186\167\230\137\128\233\156\128\231\187\143\233\170\140"
}, {
  field = "accumulateExp",
  value = "int",
  desc = "\229\136\154\229\165\189\232\190\190\229\136\176\229\189\147\229\137\141\233\152\182\231\154\132\231\180\175\231\167\175\231\187\143\233\170\140"
}, {
  field = "factor",
  value = "double",
  desc = "\229\144\158\229\153\172\231\187\143\233\170\140\231\179\187\230\149\176"
}, {
  field = "alters",
  value = "string",
  desc = "\233\153\132\229\138\160\231\154\132\229\177\158\230\128\167"
}, {
  field = "price",
  value = "int",
  desc = "\229\135\186\229\148\174\228\187\183\230\160\188(\229\133\131\229\174\157)"
}, {
  field = "AttType1",
  value = "string",
  desc = "\229\177\158\230\128\167"
}, {
  field = "AttValue1",
  value = "string",
  desc = "\229\177\158\230\128\167\229\128\188"
}, {
  field = "AttType2",
  value = "string",
  desc = "\229\177\158\230\128\167"
}, {
  field = "AttValue2",
  value = "string",
  desc = "\229\177\158\230\128\167\229\128\188"
}, {
  field = "AttType3",
  value = "string",
  desc = "\229\177\158\230\128\167"
}, {
  field = "AttValue3",
  value = "string",
  desc = "\229\177\158\230\128\167\229\128\188"
}, {
  field = "AttType4",
  value = "string",
  desc = "\229\177\158\230\128\167"
}, {
  field = "AttValue4",
  value = "string",
  desc = "\229\177\158\230\128\167\229\128\188"
}, {
  field = "funcFlag",
  value = "int",
  desc = "\229\138\159\232\131\189\230\160\135\229\191\151\228\189\141"
}, {})
DEF({
  type = "TalismanSetting",
  file = "",
  desc = "TalismanSetting"
}, {
  index = "id",
  value = "int",
  desc = "\230\160\135\232\175\134"
}, {
  field = "type",
  value = "string",
  desc = "\230\179\149\229\174\157\231\177\187\229\158\139"
}, {
  field = "race",
  value = "string",
  desc = "\230\179\149\229\174\157\231\167\141\231\177\187"
}, {
  field = "TalismanType",
  value = "string",
  desc = "\230\179\149\229\174\157\231\177\187\229\158\139"
}, {
  field = "activityType",
  value = "string",
  desc = "\230\180\187\229\138\168\231\177\187\229\158\139"
}, {
  field = "price",
  value = "int",
  desc = "\229\135\186\229\148\174\228\187\183\230\160\188"
}, {
  field = "baseId",
  value = "int",
  desc = "\231\137\169\229\147\129id"
}, {
  field = "initLevel",
  value = "int",
  desc = "\229\136\157\229\167\139\231\173\137\231\186\167"
}, {
  field = "maxLevel",
  value = "int",
  desc = "\230\156\128\229\164\167\231\173\137\231\186\167"
}, {
  field = "minEquipLevel",
  value = "int",
  desc = "\229\143\175\228\187\165\231\148\168\228\186\142\232\163\133\229\164\135\231\154\132\230\156\128\229\176\143\231\173\137\231\186\167"
}, {
  field = "maxEquipLevel",
  value = "int",
  desc = "\229\143\175\228\187\165\231\148\168\228\186\142\232\163\133\229\164\135\231\154\132\230\156\128\229\164\167\231\173\137\231\186\167"
}, {
  field = "minPlayerLevel",
  value = "int",
  desc = "\230\179\149\229\174\157\232\142\183\229\143\150\231\154\132\230\156\128\229\176\143\232\167\146\232\137\178\231\173\137\231\186\167\233\153\144\229\136\182"
}, {
  field = "maxPlayerLevel",
  value = "int",
  desc = "\230\179\149\229\174\157\232\142\183\229\143\150\231\154\132\230\156\128\229\164\167\232\167\146\232\137\178\231\173\137\231\186\167\233\153\144\229\136\182"
}, {
  field = "minStarLevel",
  value = "int",
  desc = "\229\143\175\228\187\165\232\163\133\229\164\135\231\154\132\229\141\161\231\137\140\231\154\132\230\156\128\229\176\143\231\173\137\231\186\167"
}, {
  field = "maxStarLevel",
  value = "int",
  desc = "\229\143\175\228\187\165\232\163\133\229\164\135\231\154\132\229\141\161\231\137\140\231\154\132\230\156\128\229\164\167\231\173\137\231\186\167"
}, {
  field = "canEquip",
  value = "string",
  desc = "\230\152\175\229\144\166\229\143\175\228\187\165\232\163\133\229\164\135"
}, {
  field = "canSwallow",
  value = "string",
  desc = "\230\152\175\229\144\166\229\143\175\228\187\165\229\144\158\229\153\172"
}, {
  field = "mutualRaces",
  value = "string",
  desc = "\232\163\133\229\164\135\228\186\146\230\150\165\231\167\141\231\177\187"
}, {
  field = "equipTypes",
  value = "string",
  desc = "\229\143\175\232\163\133\229\164\135\231\154\132\232\129\140\228\184\154"
}, {
  field = "postId",
  value = "int",
  desc = "\229\133\172\229\145\138id"
}, {
  field = "position",
  value = "int",
  desc = "\229\143\175\228\187\165\232\163\133\229\164\135\231\154\132\229\173\148\228\189\141"
}, {})
DEF({
  type = "TaSearchRankConfig",
  file = "",
  desc = "\233\133\141\231\189\174"
}, {
  index = "id",
  value = "string",
  desc = "\230\160\135\232\175\134"
}, {
  field = "costTypes",
  value = "string",
  desc = "\233\147\182\228\184\164\229\175\187\229\174\157\230\182\136\232\128\151\231\177\187\229\158\139"
}, {
  field = "costs",
  value = "int",
  desc = "\229\175\187\229\174\157\233\147\156\229\184\129"
}, {
  field = "npcname",
  value = "string",
  desc = "NPC\229\144\141\229\173\151"
}, {
  field = "updateDesr",
  value = "string",
  desc = "\229\141\135\231\186\167\230\143\144\231\164\186"
}, {})
DEF({
  type = "TaSearchRankTreasure",
  file = "",
  desc = "\233\133\141\231\189\174\232\140\131\228\190\139"
}, {
  index = "id",
  value = "string",
  desc = "\230\160\135\232\175\134"
}, {})
DEF({
  type = "EquipLockSetting",
  file = "",
  desc = "EquipLockSetting"
}, {
  index = "id",
  value = "int",
  desc = "\230\179\149\229\174\157\232\163\133\229\164\135\228\184\170\230\149\176"
}, {
  field = "lockKey",
  value = "string",
  desc = "\233\148\129\233\133\141\231\189\174"
}, {})
DEF({
  type = "DumplingSetting",
  file = "",
  desc = "DumplingSetting"
}, {
  index = "id",
  value = "int",
  desc = "\233\165\186\229\173\144\231\177\187\229\158\139"
}, {
  field = "coolTime",
  value = "int",
  desc = "\230\136\144\231\134\159\229\134\183\229\141\180\230\151\182\233\151\180"
}, {
  field = "reward",
  value = "string",
  desc = "\229\165\150\229\138\177id"
}, {
  field = "baseId",
  value = "int",
  desc = "\233\165\186\229\173\144\230\160\135\232\175\134"
}, {
  field = "showTypeId",
  value = "string",
  desc = "\229\165\150\229\138\177\231\177\187\229\158\139"
}, {
  field = "showIds",
  value = "string",
  desc = "\229\165\150\229\138\177\230\160\135\232\175\134"
}, {
  field = "counts",
  value = "string",
  desc = "\229\165\150\229\138\177\230\149\176\233\135\143"
}, {})
DEF({
  type = "GroupSetting",
  file = "",
  desc = "GroupSetting"
}, {
  index = "id",
  value = "int",
  desc = "\231\137\169\229\147\129id"
}, {
  field = "goods",
  value = "string",
  desc = "\231\137\169\229\147\129"
}, {
  field = "costTypes",
  value = "string",
  desc = "\232\180\173\228\185\176\233\146\177\229\184\129\231\177\187\229\158\139"
}, {
  field = "original",
  value = "int",
  desc = "\229\142\159\228\187\183"
}, {
  field = "now",
  value = "int",
  desc = "\231\142\176\228\187\183"
}, {
  field = "startTime",
  value = "string",
  desc = "\229\188\128\229\167\139\230\151\182\233\151\180"
}, {
  field = "endTime",
  value = "string",
  desc = "\231\187\147\230\157\159\230\151\182\233\151\180"
}, {
  field = "rewards",
  value = "string",
  desc = "\229\165\150\229\138\177\228\186\186\230\149\176\230\174\181"
}, {
  field = "buyCounts",
  value = "string",
  desc = "\232\180\173\228\185\176\228\186\186\230\149\176"
}, {
  field = "showTypeId",
  value = "string",
  desc = "\229\165\150\229\138\177\231\177\187\229\158\139"
}, {
  field = "showIds",
  value = "string",
  desc = "\229\165\150\229\138\177\230\160\135\232\175\134"
}, {
  field = "counts",
  value = "string",
  desc = "\229\165\150\229\138\177\230\149\176\233\135\143"
}, {
  field = "goodsShowTypeId",
  value = "string",
  desc = "\231\164\188\229\140\133\229\134\133\231\137\169\229\147\129\231\177\187\229\158\139"
}, {
  field = "goodsShowIds",
  value = "string",
  desc = "\231\164\188\229\140\133\229\134\133\231\137\169\229\147\129\230\160\135\232\175\134"
}, {
  field = "goodsShowCounts",
  value = "string",
  desc = "\231\164\188\229\140\133\229\134\133\231\137\169\229\147\129\230\149\176\233\135\143"
}, {})
DEF({
  type = "TodayTimesSetting",
  file = "",
  desc = "TodayTimesSetting"
}, {
  index = "id",
  value = "string",
  desc = "\230\172\161\230\149\176"
}, {
  field = "cost",
  value = "int",
  desc = "\231\160\184\232\155\139\230\182\136\232\128\151\229\128\188"
}, {})
DEF({
  type = "SmashReward",
  file = "",
  desc = "SmashSetting"
}, {
  index = "id",
  value = "int",
  desc = "\230\160\135\232\175\134"
}, {
  field = "showType",
  value = "string",
  desc = "\230\152\190\231\164\186\231\177\187\229\158\139"
}, {
  field = "showId",
  value = "int",
  desc = "\230\152\190\231\164\186Id"
}, {
  field = "amount",
  value = "string",
  desc = "\230\149\176\233\135\143"
}, {})
DEF({
  type = "ArtifactUpgradeActivity",
  file = "",
  desc = "\231\165\158\229\153\168\229\141\135\231\186\167\230\180\187\229\138\168"
}, {
  index = "id",
  value = "string",
  desc = "\230\160\135\232\175\134"
}, {
  field = "activityId",
  value = "string",
  desc = "\230\137\128\229\177\158\230\180\187\229\138\168ID"
}, {
  field = "targetLevel",
  value = "string",
  desc = "\231\155\174\230\160\135\233\152\182\230\174\181"
}, {
  field = "showtype",
  value = "string",
  desc = "\230\152\190\231\164\186\231\177\187\229\158\139"
}, {
  field = "showid",
  value = "int",
  desc = "\230\152\190\231\164\186ID"
}, {
  field = "content",
  value = "string",
  desc = "\229\165\150\229\138\177\229\134\133\229\174\185"
}, {})
DEF({
  type = "DepositRateConfig",
  file = "",
  desc = "\229\136\169\231\142\135\233\133\141\231\189\174"
}, {
  index = "id",
  value = "int",
  desc = "\230\160\135\232\175\134"
}, {
  field = "rate",
  value = "int",
  desc = "\232\191\148\232\191\152\230\175\148\231\142\135(\231\153\190\229\136\134\230\175\148)"
}, {})
DEF({
  type = "CapitalConfig",
  file = "",
  desc = "\230\156\172\233\135\145\233\133\141\231\189\174"
}, {
  index = "id",
  value = "int",
  desc = "\230\160\135\232\175\134"
}, {
  field = "amount",
  value = "int",
  desc = "\230\156\172\233\135\145\230\149\176\233\135\143"
}, {})
DEF({
  type = "ScoreReward",
  file = "",
  desc = "\230\182\136\232\180\185\230\142\146\229\144\141\229\165\150\229\138\177\233\133\141\231\189\174"
}, {
  index = "id",
  value = "int",
  desc = "\230\160\135\232\175\134"
}, {
  field = "activityId",
  value = "string",
  desc = "\230\137\128\229\177\158\230\180\187\229\138\168"
}, {
  field = "needScore",
  value = "int",
  desc = "\230\137\128\233\156\128\230\182\136\232\180\185\231\167\175\229\136\134"
}, {
  field = "rewardId",
  value = "int",
  desc = "\229\165\150\229\138\177ID"
}, {
  field = "showType",
  value = "string",
  desc = "\229\165\150\229\138\177\231\177\187\229\158\139"
}, {
  field = "showId",
  value = "int",
  desc = "\229\165\150\229\138\177\230\160\135\232\175\134"
}, {
  field = "descCondition",
  value = "string",
  desc = "\229\165\150\229\138\177\230\143\143\232\191\176"
}, {})
DEF({
  type = "ScoreRankReward",
  file = "",
  desc = "\231\167\175\229\136\134\230\142\146\229\144\141\229\165\150\229\138\177"
}, {
  index = "id",
  value = "int",
  desc = "\230\160\135\232\175\134"
}, {
  field = "activityId",
  value = "string",
  desc = "\230\137\128\229\177\158\230\180\187\229\138\168"
}, {
  field = "topRank",
  value = "int",
  desc = "\230\156\128\233\171\152\229\144\141\230\172\161"
}, {
  field = "lowRank",
  value = "int",
  desc = "\230\156\128\228\189\142\229\144\141\230\172\161"
}, {
  field = "consumeLimit",
  value = "int",
  desc = "\230\156\128\228\189\142\231\167\175\229\136\134\233\153\144\229\136\182"
}, {
  field = "rewardId",
  value = "string",
  desc = "\229\165\150\229\138\177id"
}, {
  field = "name",
  value = "string",
  desc = "\229\165\150\229\138\177\229\144\141\229\173\151"
}, {
  field = "showType",
  value = "string",
  desc = "\229\165\150\229\138\177\231\177\187\229\158\139"
}, {
  field = "showId",
  value = "int",
  desc = "\229\165\150\229\138\177\230\160\135\232\175\134"
}, {
  field = "rewardShow",
  value = "string",
  desc = "\229\165\150\229\138\177\229\177\149\231\164\186"
}, {})
DEF({
  type = "BoxCostSetting",
  file = "",
  desc = "BoxSetting"
}, {
  index = "id",
  value = "string",
  desc = "\230\172\161\230\149\176"
}, {
  field = "cost",
  value = "int",
  desc = "\228\187\153\231\142\137\229\188\128\231\174\177\230\182\136\232\128\151\229\128\188"
}, {})
DEF({
  type = "BoxSetting",
  file = "",
  desc = "BoxSetting"
}, {
  index = "id",
  value = "string",
  desc = "\230\172\161\230\149\176"
}, {
  field = "keyType",
  value = "string",
  desc = "\228\187\153\231\142\137\229\188\128\231\174\177\230\182\136\232\128\151\231\177\187\229\158\139"
}, {})
DEF({
  type = "OpenTimesSetting",
  file = "",
  desc = "OpenTimesSetting"
}, {
  index = "id",
  value = "int",
  desc = "\230\172\161\230\149\176"
}, {
  field = "chargeAddType",
  value = "string",
  desc = "\230\182\136\232\128\151\231\177\187\229\158\139"
}, {})
DEF({
  type = "RewCostSetting",
  file = "",
  desc = "RewCostSetting"
}, {
  index = "id",
  value = "int",
  desc = "id"
}, {
  field = "costTypes",
  value = "string",
  desc = "\230\182\136\232\128\151\231\177\187\229\158\139"
}, {
  field = "cost",
  value = "int",
  desc = "\230\182\136\232\128\151\229\128\188"
}, {
  field = "name",
  value = "string",
  desc = "\229\133\145\230\141\162\229\144\141\231\167\176"
}, {
  field = "showType",
  value = "string",
  desc = "\229\165\150\229\138\177\231\177\187\229\158\139"
}, {
  field = "showId",
  value = "int",
  desc = "\229\165\150\229\138\177\230\160\135\232\175\134"
}, {
  field = "amount",
  value = "string",
  desc = "\230\149\176\233\135\143"
}, {
  field = "rare",
  value = "string",
  desc = "\230\152\175\229\144\166\231\143\141\229\147\129"
}, {
  field = "costStr",
  value = "string",
  desc = "\230\182\136\232\128\151\230\152\190\231\164\186"
}, {})
DEF({
  type = "CostSetting",
  file = "",
  desc = "CostSetting"
}, {
  index = "id",
  value = "int",
  desc = "\230\172\161\230\149\176"
}, {
  field = "cost",
  value = "int",
  desc = "\230\182\136\232\128\151\229\128\188"
}, {})
DEF({
  type = "TreasureShow",
  file = "",
  desc = "RewCostSetting"
}, {
  index = "id",
  value = "int",
  desc = "id"
}, {
  field = "showType",
  value = "string",
  desc = "\229\165\150\229\138\177\231\177\187\229\158\139"
}, {
  field = "showId",
  value = "int",
  desc = "\229\165\150\229\138\177\230\160\135\232\175\134"
}, {
  field = "amount",
  value = "string",
  desc = "\230\149\176\233\135\143"
}, {})
DEF({
  type = "ResetSetting",
  file = "",
  desc = "ResetSetting"
}, {
  index = "id",
  value = "int",
  desc = "\230\137\139\229\138\168\233\135\141\231\189\174\230\172\161\230\149\176"
}, {
  field = "costs",
  value = "string",
  desc = "\230\182\136\232\128\151\229\128\188"
}, {
  field = "levels",
  value = "string",
  desc = "\231\142\169\229\174\182\231\173\137\231\186\167\230\174\181"
}, {})
DEF({
  type = "RaffleShow",
  file = "",
  desc = "RaffleShow"
}, {
  index = "id",
  value = "int",
  desc = "id"
}, {
  field = "showType",
  value = "string",
  desc = "\229\165\150\229\138\177\231\177\187\229\158\139"
}, {
  field = "showId",
  value = "int",
  desc = "\229\165\150\229\138\177\230\160\135\232\175\134"
}, {
  field = "amount",
  value = "string",
  desc = "\230\149\176\233\135\143"
}, {
  field = "minLevel",
  value = "int",
  desc = "\230\156\128\228\189\142\231\173\137\231\186\167"
}, {
  field = "maxLevel",
  value = "int",
  desc = "\230\156\128\233\171\152\231\173\137\231\186\167"
}, {})
DEF({
  type = "RaffleRewards",
  file = "",
  desc = "RaffleRewards"
}, {
  index = "id",
  value = "string",
  desc = "id"
}, {
  field = "showType",
  value = "string",
  desc = "\229\165\150\229\138\177\231\177\187\229\158\139"
}, {
  field = "showId",
  value = "int",
  desc = "\229\165\150\229\138\177\230\160\135\232\175\134"
}, {
  field = "amount",
  value = "string",
  desc = "\230\149\176\233\135\143"
}, {
  field = "rare",
  value = "string",
  desc = "\230\152\175\229\144\166\231\143\141\229\147\129"
}, {})
DEF({
  type = "RaffleCost",
  file = "",
  desc = "RaffleCost"
}, {
  index = "id",
  value = "int",
  desc = "\230\138\189\229\143\150\230\172\161\230\149\176"
}, {
  field = "levels",
  value = "string",
  desc = "\231\142\169\229\174\182\231\173\137\231\186\167\230\174\181"
}, {
  field = "costs",
  value = "string",
  desc = "\230\182\136\232\128\151\229\128\188"
}, {})
DEF({
  type = "WechatRoulette",
  file = "",
  desc = "\232\189\174\231\155\152\230\138\189\229\165\150"
}, {
  index = "id",
  value = "int",
  desc = "ID"
}, {
  field = "position",
  value = "int",
  desc = "\232\189\172\231\155\152\230\160\188\230\149\176"
}, {
  field = "showType",
  value = "string",
  desc = "\229\165\150\229\138\177\231\177\187\229\158\139"
}, {
  field = "showId",
  value = "string",
  desc = "\229\165\150\229\138\177\230\160\135\232\175\134"
}, {
  field = "name",
  value = "string",
  desc = "\229\165\150\229\138\177\229\144\141\229\173\151"
}, {
  field = "amount",
  value = "string",
  desc = "\229\165\150\229\138\177\230\149\176\233\135\143"
}, {
  field = "operator",
  value = "int",
  desc = "\232\191\144\232\144\165\229\149\134\229\143\183\231\160\129"
}, {})
DEF({
  type = "QingmingReward",
  file = "",
  desc = "QingmingReward"
}, {
  index = "id",
  value = "int",
  desc = "\230\160\135\232\175\134"
}, {
  field = "lowLevel",
  value = "int",
  desc = "\230\156\128\228\189\142\231\173\137\231\186\167"
}, {
  field = "highLevel",
  value = "int",
  desc = "\230\156\128\233\171\152\231\173\137\231\186\167"
}, {
  field = "pondId",
  value = "int",
  desc = "\230\137\128\229\177\158\229\165\150\230\177\160id"
}, {
  field = "showType",
  value = "string",
  desc = "\229\165\150\229\138\177\231\177\187\229\158\139"
}, {
  field = "showId",
  value = "int",
  desc = "\229\165\150\229\138\177\230\160\135\232\175\134"
}, {
  field = "amount",
  value = "string",
  desc = "\230\149\176\233\135\143"
}, {
  field = "sort",
  value = "int",
  desc = "\230\142\146\229\186\143"
}, {})
DEF({
  type = "QingmingRank",
  file = "",
  desc = "QingmingRank"
}, {
  index = "id",
  value = "int",
  desc = "\230\160\135\232\175\134"
}, {
  field = "topRank",
  value = "int",
  desc = "\230\156\128\233\171\152\229\144\141\230\172\161"
}, {
  field = "lowRank",
  value = "int",
  desc = "\230\156\128\228\189\142\229\144\141\230\172\161"
}, {
  field = "name",
  value = "string",
  desc = "\229\165\150\229\138\177\229\144\141\229\173\151"
}, {
  field = "showType",
  value = "string",
  desc = "\229\165\150\229\138\177\231\177\187\229\158\139"
}, {
  field = "showId",
  value = "int",
  desc = "\229\165\150\229\138\177\230\160\135\232\175\134"
}, {})
DEF({
  type = "QingmingPond",
  file = "",
  desc = "QingmingPond"
}, {
  index = "id",
  value = "int",
  desc = "\230\160\135\232\175\134"
}, {
  field = "scores",
  value = "string",
  desc = "\231\165\173\230\139\156\230\137\128\232\142\183\231\167\175\229\136\134"
}, {
  field = "jipingCosts",
  value = "string",
  desc = "\231\165\173\230\139\156\230\137\128\233\156\128\231\165\173\229\147\129"
}, {
  field = "jibaiCounts",
  value = "string",
  desc = "\231\165\173\230\139\156\230\172\161\230\149\176\229\136\134\230\174\181"
}, {})
DEF({
  type = "FoolsdayShow",
  file = "",
  desc = "FoolsdayShow"
}, {
  index = "id",
  value = "int",
  desc = "id"
}, {
  field = "showType",
  value = "string",
  desc = "\229\165\150\229\138\177\231\177\187\229\158\139"
}, {
  field = "showId",
  value = "int",
  desc = "\229\165\150\229\138\177\230\160\135\232\175\134"
}, {
  field = "amount",
  value = "string",
  desc = "\230\149\176\233\135\143"
}, {
  field = "minLevel",
  value = "int",
  desc = "\230\156\128\228\189\142\231\173\137\231\186\167"
}, {
  field = "maxLevel",
  value = "int",
  desc = "\230\156\128\233\171\152\231\173\137\231\186\167"
}, {})
DEF({
  type = "FlopCostSetting",
  file = "",
  desc = "\230\132\154\228\186\186\232\138\130\231\191\187\231\137\140\230\137\163\232\180\185"
}, {
  index = "id",
  value = "int",
  desc = "\230\160\135\232\175\134"
}, {
  field = "levelSegment",
  value = "int",
  desc = "\231\173\137\231\186\167\230\174\181"
}, {
  field = "times",
  value = "int",
  desc = "\230\172\161\230\149\176"
}, {
  field = "cost",
  value = "int",
  desc = "\230\137\163\232\180\185"
}, {})
DEF({
  type = "FlopResetSetting",
  file = "",
  desc = "\230\132\154\228\186\186\232\138\130\233\135\141\231\189\174\230\137\163\232\180\185"
}, {
  index = "id",
  value = "int",
  desc = "\230\160\135\232\175\134"
}, {
  field = "levelSegment",
  value = "int",
  desc = "\231\173\137\231\186\167\230\174\181"
}, {
  field = "times",
  value = "int",
  desc = "\233\135\141\231\189\174\230\172\161\230\149\176"
}, {
  field = "cost",
  value = "int",
  desc = "\230\137\163\232\180\185"
}, {})
DEF({
  type = "FlopRewardSetting",
  file = "",
  desc = "\230\132\154\228\186\186\232\138\130\231\191\187\231\137\140\229\165\150\229\138\177"
}, {
  index = "id",
  value = "int",
  desc = "\230\160\135\232\175\134"
}, {
  field = "levelSegment",
  value = "int",
  desc = "\231\173\137\231\186\167\230\174\181"
}, {
  field = "cards",
  value = "string",
  desc = "\229\141\161\231\137\135\231\187\132\229\144\136"
}, {
  field = "desc",
  value = "string",
  desc = "\229\165\150\229\138\177\230\143\143\232\191\176"
}, {})
DEF({
  type = "CountrySetting",
  file = "",
  desc = "\229\159\142\230\177\160"
}, {
  index = "id",
  value = "int",
  desc = "\229\148\175\228\184\128\230\160\135\232\175\134"
}, {
  field = "type",
  value = "string",
  desc = "\229\159\142\230\177\160\231\177\187\229\158\139"
}, {
  field = "count",
  value = "int",
  desc = "\230\156\128\228\189\142\230\152\190\231\164\186\230\175\148\231\142\135"
}, {
  field = "minBid",
  value = "int",
  desc = "\230\156\128\228\189\142\231\171\158\228\187\183"
}, {
  field = "imgCity",
  value = "string",
  desc = "\229\159\142\230\177\160\229\155\190\231\137\135\232\183\175\229\190\132"
}, {
  field = "imgDisCity",
  value = "string",
  desc = "\229\159\142\230\177\160\231\129\176\230\128\129\229\155\190\231\137\135\232\183\175\229\190\132"
}, {
  field = "imgCityName",
  value = "string",
  desc = "\229\159\142\230\177\160\229\144\141\229\173\151\229\155\190\231\137\135\232\183\175\229\190\132"
}, {
  field = "holdReward",
  value = "string",
  desc = "\229\141\160\233\162\134\229\165\150\229\138\177"
}, {
  field = "position",
  value = "string",
  desc = "\229\159\142\230\177\160\228\189\141\231\189\174"
}, {})
DEF({
  type = "GoodsSetting",
  file = "",
  desc = "\229\134\155\229\155\162\229\149\134\229\186\151\231\137\169\229\147\129"
}, {
  index = "id",
  value = "int",
  desc = "\229\148\175\228\184\128\230\160\135\232\175\134"
}, {
  field = "sort",
  value = "int",
  desc = "\230\142\146\229\186\143"
}, {
  field = "type",
  value = "string",
  desc = "\231\137\169\229\147\129\231\177\187\229\158\139"
}, {
  field = "need",
  value = "int",
  desc = "\233\156\128\232\166\129\229\138\159\229\139\139"
}, {
  field = "exchange",
  value = "int",
  desc = "\229\143\175\229\133\145\230\141\162\230\172\161\230\149\176"
}, {
  field = "showId",
  value = "int",
  desc = "\229\165\150\229\138\177\230\160\135\232\175\134"
}, {
  field = "showType",
  value = "string",
  desc = "\229\165\150\229\138\177\231\177\187\229\158\139"
}, {
  field = "amount",
  value = "string",
  desc = "\229\165\150\229\138\177\230\149\176\233\135\143"
}, {
  field = "desc",
  value = "string",
  desc = "\229\165\150\229\138\177\230\143\143\232\191\176"
}, {
  field = "playerLevel",
  value = "int",
  desc = "\231\142\169\229\174\182\231\173\137\231\186\167"
}, {})
DEF({
  type = "JuGoods",
  file = "",
  desc = "\232\129\154\229\136\146\231\174\151\229\149\134\229\147\129"
}, {
  index = "id",
  value = "string",
  desc = "\230\160\135\232\175\134"
}, {
  field = "duration",
  value = "int",
  desc = "\230\140\129\231\187\173\230\151\182\233\151\180 \229\141\149\228\189\141\229\164\169"
}, {
  field = "costs",
  value = "int",
  desc = "\230\137\163\232\180\185\230\149\176\233\135\143"
}, {
  field = "name",
  value = "string",
  desc = "\232\180\167\229\147\129\229\144\141\231\167\176"
}, {
  field = "feedBack",
  value = "string",
  desc = "\230\175\143\230\151\165\232\191\148\229\155\158"
}, {
  field = "showType",
  value = "string",
  desc = "\229\165\150\229\138\177\231\177\187\229\158\139"
}, {
  field = "showId",
  value = "int",
  desc = "\229\165\150\229\138\177\230\160\135\232\175\134"
}, {
  field = "amount",
  value = "string",
  desc = "\230\149\176\233\135\143"
}, {
  field = "level",
  value = "int",
  desc = "\232\180\173\228\185\176\231\173\137\231\186\167"
}, {
  field = "vip",
  value = "string",
  desc = "\232\180\173\228\185\176\231\148\168\230\136\183"
}, {
  field = "sort",
  value = "int",
  desc = "\230\142\146\229\186\143\229\173\151\230\174\181"
}, {})
DEF({
  type = "BaseEquip",
  file = "",
  desc = "BaseEquip"
}, {
  index = "id",
  value = "int",
  desc = "\230\160\135\232\175\134"
}, {
  field = "nextId",
  value = "int",
  desc = "\228\184\139\228\184\128\231\186\167id"
}, {
  field = "modelId",
  value = "int",
  desc = "\230\168\161\229\158\139id"
}, {
  field = "name",
  value = "string",
  desc = "\229\144\141\229\173\151"
}, {
  field = "rank",
  value = "int",
  desc = "\229\147\129\233\152\182"
}, {
  field = "materials",
  value = "string",
  desc = "\229\141\135\231\186\167(\233\152\182)\230\157\144\230\150\153"
}, {
  field = "cost",
  value = "int",
  desc = "\229\141\135\231\186\167\230\182\136\232\128\151(\230\184\184\230\136\143\229\184\129)"
}, {
  field = "star",
  value = "int",
  desc = "\230\152\159\231\186\167"
}, {
  field = "level",
  value = "int",
  desc = "\231\173\137\231\186\167"
}, {
  field = "positions",
  value = "string",
  desc = "\229\143\175\228\187\165\232\163\133\229\164\135\231\154\132\229\173\148\228\189\141"
}, {
  field = "autoSelect",
  value = "int",
  desc = "\230\152\175\229\144\166\229\143\175\232\135\170\229\138\168\231\173\155\233\128\137"
}, {
  field = "fragmentCode",
  value = "int",
  desc = "\229\144\136\230\136\144\231\162\142\231\137\135\230\160\135\232\175\134"
}, {
  field = "fragments",
  value = "int",
  desc = "\229\144\136\230\136\144\231\162\142\231\137\135\230\149\176\233\135\143"
}, {
  field = "equipTypes",
  value = "string",
  desc = "\229\143\175\228\187\165\232\163\133\229\164\135\231\154\132\229\141\161\231\137\140\232\129\140\228\184\154"
}, {
  field = "alters",
  value = "string",
  desc = "\233\153\132\229\138\160\231\154\132\229\177\158\230\128\167"
}, {
  field = "copy",
  value = "string",
  desc = "\232\142\183\229\143\150\233\128\148\229\190\132(\228\186\167\229\135\186\232\163\133\229\164\135\229\137\175\230\156\172id\233\155\134)"
}, {
  field = "gain",
  value = "string",
  desc = "\232\142\183\229\143\150\233\128\148\229\190\132"
}, {
  field = "battle",
  value = "string",
  desc = "\230\136\152\229\189\185\229\144\141\231\167\176"
}, {
  field = "flashFlag",
  value = "int",
  desc = "\233\151\170\229\141\161\230\160\135\229\191\151"
}, {
  field = "desc",
  value = "string",
  desc = "\230\143\143\232\191\176"
}, {
  field = "disabledModelId",
  value = "int",
  desc = "\231\129\176\230\128\129\230\168\161\229\158\139id"
}, {})
DEF({
  type = "RewardCost",
  file = "",
  desc = "RewardCost"
}, {
  index = "id",
  value = "int",
  desc = "id"
}, {
  field = "costTypes",
  value = "string",
  desc = "\230\182\136\232\128\151\231\177\187\229\158\139"
}, {
  field = "cost",
  value = "int",
  desc = "\230\182\136\232\128\151\229\128\188"
}, {
  field = "name",
  value = "string",
  desc = "\229\133\145\230\141\162\229\144\141\231\167\176"
}, {
  field = "showType",
  value = "string",
  desc = "\229\165\150\229\138\177\231\177\187\229\158\139"
}, {
  field = "showId",
  value = "int",
  desc = "\229\165\150\229\138\177\230\160\135\232\175\134"
}, {
  field = "amount",
  value = "string",
  desc = "\230\149\176\233\135\143"
}, {
  field = "rare",
  value = "string",
  desc = "\230\152\175\229\144\166\231\143\141\229\147\129"
}, {
  field = "costStr",
  value = "string",
  desc = "\230\182\136\232\128\151\230\152\190\231\164\186"
}, {})
DEF({
  type = "PackExtendCost",
  file = "",
  desc = "PackExtendCost"
}, {
  index = "id",
  value = "int",
  desc = "\230\160\135\232\175\134"
}, {
  field = "cost",
  value = "int",
  desc = "\230\182\136\232\128\151\229\128\188"
}, {})
DEF({
  type = "SecretRefCost",
  file = "",
  desc = "SecretRefCost"
}, {
  index = "id",
  value = "int",
  desc = "\230\172\161\230\149\176"
}, {
  field = "cost",
  value = "int",
  desc = "\230\182\136\232\128\151\229\128\188"
}, {})
DEF({
  type = "EquipBuff",
  file = "",
  desc = "\231\190\129\231\187\138\229\177\158\230\128\167"
}, {
  index = "id",
  value = "string",
  desc = "\229\141\161\231\137\140ID_\232\163\133\229\164\135ID"
}, {
  field = "beforeId",
  value = "string",
  desc = "\232\166\129\232\174\161\231\174\151\231\154\132\228\184\138\228\184\128\228\184\170id"
}, {
  field = "alters",
  value = "string",
  desc = "\233\153\132\229\138\160\231\154\132\229\177\158\230\128\167"
}, {})
DEF({
  type = "EquipLottery",
  file = "",
  desc = "EquipLottery"
}, {
  index = "id",
  value = "int",
  desc = "\230\160\135\232\175\134"
}, {
  field = "resetTimesHours",
  value = "int",
  desc = "\229\133\141\232\180\185\230\172\161\230\149\176\233\135\141\231\189\174\231\155\184\233\154\148\229\176\143\230\151\182"
}, {
  field = "resetTimes",
  value = "int",
  desc = "\233\135\141\231\189\174\231\154\132\229\133\141\232\180\185\230\172\161\230\149\176"
}, {
  field = "mustOutTimes",
  value = "int",
  desc = "\229\191\133\229\135\186\231\155\184\233\154\148\230\172\161\230\149\176"
}, {
  field = "cost",
  value = "string",
  desc = "\230\152\175\229\144\166\229\133\129\232\174\184\228\187\153\231\142\137\230\138\189"
}, {})
DEF({
  type = "CheapBuySetting",
  file = "",
  desc = "\232\182\138\228\185\176\232\182\138\228\190\191\229\174\156"
}, {
  index = "id",
  value = "int",
  desc = "\230\160\135\232\175\134"
}, {
  field = "mallId",
  value = "int",
  desc = "\229\149\134\229\159\142id"
}, {
  field = "next",
  value = "int",
  desc = "\228\184\139\228\184\128\228\184\170\231\164\188\229\140\133id"
}, {
  field = "charge",
  value = "int",
  desc = "\230\137\128\233\156\128\233\135\141\231\189\174\233\162\157\229\186\166"
}, {
  field = "level",
  value = "int",
  desc = "\233\156\128\232\166\129\231\154\132\231\173\137\231\186\167"
}, {
  field = "cost",
  value = "int",
  desc = "\230\137\163\232\180\185\230\182\136\232\128\151\229\128\188"
}, {
  field = "name",
  value = "string",
  desc = "\231\164\188\229\140\133\229\144\141\229\173\151"
}, {
  field = "showTypes",
  value = "string",
  desc = "\229\165\150\229\138\177\231\177\187\229\158\139"
}, {
  field = "showIds",
  value = "string",
  desc = "\229\165\150\229\138\177\230\160\135\232\175\134"
}, {
  field = "counts",
  value = "string",
  desc = "\229\165\150\229\138\177\230\149\176\233\135\143"
}, {
  field = "sort",
  value = "int",
  desc = "\230\142\146\229\186\143"
}, {})
DEF({
  type = "SuperGoods",
  file = "",
  desc = "\232\182\133\229\128\188\231\164\188\229\140\133\229\149\134\229\147\129"
}, {
  index = "id",
  value = "int",
  desc = "\230\160\135\232\175\134"
}, {
  field = "mallId",
  value = "int",
  desc = "\230\137\128\229\177\158\229\149\134\229\147\129\230\157\161\231\155\174id"
}, {
  field = "start",
  value = "string",
  desc = "\229\188\128\229\167\139\230\151\182\233\151\180"
}, {
  field = "endTime",
  value = "string",
  desc = "\231\187\147\230\157\159\230\151\182\233\151\180"
}, {
  field = "total",
  value = "int",
  desc = "\229\135\186\229\148\174\230\128\187\230\149\176"
}, {
  field = "single",
  value = "int",
  desc = "\229\141\149\228\186\186\232\180\173\228\185\176\228\184\170\230\149\176"
}, {
  field = "cost",
  value = "int",
  desc = "\228\187\153\231\142\137\228\187\183\230\160\188"
}, {
  field = "original",
  value = "int",
  desc = "\229\142\159\228\187\183"
}, {
  field = "showType",
  value = "string",
  desc = "\229\165\150\229\138\177\231\177\187\229\158\139"
}, {
  field = "showId",
  value = "string",
  desc = "\229\165\150\229\138\177\230\160\135\232\175\134"
}, {
  field = "desc",
  value = "string",
  desc = "\229\165\150\229\138\177\230\143\143\232\191\176"
}, {
  field = "count",
  value = "string",
  desc = "\229\165\150\229\138\177\230\149\176\233\135\143"
}, {
  field = "sort",
  value = "int",
  desc = "\230\142\146\229\186\143"
}, {})
DEF({
  type = "ActivityGoods",
  file = "",
  desc = "ActivityGoods"
}, {
  index = "id",
  value = "string",
  desc = "\230\180\187\229\138\168id"
}, {
  field = "goods",
  value = "string",
  desc = "\229\149\134\229\147\129"
}, {
  field = "condition",
  value = "string",
  desc = "\229\149\134\229\147\129\232\180\173\228\185\176\230\157\161\228\187\182"
}, {})
DEF({
  type = "GiftGoods",
  file = "",
  desc = "GiftGoods"
}, {
  index = "id",
  value = "int",
  desc = "\230\180\187\229\138\168id"
}, {
  field = "cost",
  value = "int",
  desc = "\232\180\173\228\185\176\230\182\136\232\128\151"
}, {
  field = "buyLimit",
  value = "int",
  desc = "\230\175\143\229\164\169\232\180\173\228\185\176\230\172\161\230\149\176\233\153\144\229\136\182"
}, {
  field = "totalbuyLimit",
  value = "int",
  desc = "\230\128\187\229\133\177\231\154\132\232\180\173\228\185\176\230\172\161\230\149\176\233\153\144\229\136\182"
}, {
  field = "showTypeId",
  value = "string",
  desc = "\229\149\134\229\147\129\231\177\187\229\158\139"
}, {
  field = "showIds",
  value = "string",
  desc = "\229\149\134\229\147\129\230\160\135\232\175\134"
}, {
  field = "counts",
  value = "string",
  desc = "\229\149\134\229\147\129\230\149\176\233\135\143"
}, {
  field = "rare",
  value = "string",
  desc = "\232\180\181\233\135\141\231\137\169\229\147\129\230\160\135\232\175\134"
}, {})
DEF({
  type = "PointPosition",
  file = "",
  desc = "PointPosition"
}, {
  index = "id",
  value = "string",
  desc = "\229\133\179\229\141\161_\228\189\141\231\189\174"
}, {
  field = "mustHitTimes",
  value = "int",
  desc = "\229\191\133\228\184\173\231\155\184\233\154\148\230\172\161\230\149\176"
}, {})
DEF({
  type = "FootballPoints",
  file = "",
  desc = "FootballPoints"
}, {
  index = "id",
  value = "int",
  desc = "\229\133\179\229\141\161id"
}, {
  field = "nextId",
  value = "int",
  desc = "\228\184\139\228\184\128\229\133\179"
}, {
  field = "hits",
  value = "int",
  desc = "\233\128\154\232\191\135\230\137\128\233\156\128\229\176\132\228\184\173\230\172\161\230\149\176"
}, {
  field = "freeBalls",
  value = "int",
  desc = "\229\133\141\232\180\185\231\154\132\232\182\179\231\144\131\230\160\188\229\188\143"
}, {})
DEF({
  type = "BallReward",
  file = "",
  desc = "BallReward"
}, {
  index = "id",
  value = "string",
  desc = "\229\133\179\229\141\161_\228\189\141\231\189\174_\232\191\155\231\144\131\230\172\161\230\149\176"
}, {
  field = "levels",
  value = "string",
  desc = "\231\173\137\231\186\167\230\174\181"
}, {
  field = "showTypeId",
  value = "string",
  desc = "\229\149\134\229\147\129\231\177\187\229\158\139"
}, {
  field = "showIds",
  value = "string",
  desc = "\229\149\134\229\147\129\230\160\135\232\175\134"
}, {
  field = "counts",
  value = "string",
  desc = "\229\149\134\229\147\129\230\149\176\233\135\143"
}, {})
DEF({
  type = "RewardRank",
  file = "",
  desc = "RewardRank"
}, {
  index = "id",
  value = "int",
  desc = "\230\160\135\232\175\134"
}, {
  field = "nextId",
  value = "int",
  desc = "\228\184\139\228\184\128\231\186\167id"
}, {
  field = "times",
  value = "int",
  desc = "\229\141\135\231\186\167\230\137\128\233\156\128\230\139\156\229\164\169\229\174\152\230\172\161\230\149\176"
}, {
  field = "cost",
  value = "int",
  desc = "\230\139\156\229\164\169\229\174\152\230\137\163\232\180\185"
}, {
  field = "levels",
  value = "string",
  desc = "\233\129\147\229\133\183\233\154\143\230\156\186\229\165\150\229\138\177\231\173\137\231\186\167\230\174\181"
}, {
  field = "money",
  value = "int",
  desc = "\230\137\128\233\156\128\229\133\133\229\128\188\228\187\153\231\142\137\233\135\145\233\162\157"
}, {
  field = "showTypes",
  value = "string",
  desc = "\230\152\190\231\164\186\231\177\187\229\158\139"
}, {
  field = "showIds",
  value = "string",
  desc = "\230\152\190\231\164\186id"
}, {
  field = "amounts",
  value = "string",
  desc = "\230\149\176\233\135\143"
}, {})
DEF({
  type = "RedCardExchange",
  file = "",
  desc = "\231\186\162\229\141\161\229\144\136\230\136\144"
}, {
  index = "id",
  value = "int",
  desc = "\230\160\135\232\175\134"
}, {
  field = "activityId",
  value = "string",
  desc = "\230\180\187\229\138\168id"
}, {
  field = "heroId",
  value = "int",
  desc = "\231\155\174\230\160\135\229\141\161\231\137\140ID"
}, {
  field = "costSameNameId",
  value = "string",
  desc = "\230\182\136\232\128\151\229\141\161\231\137\140\229\144\140\229\144\141ID"
}, {
  field = "costMinStar",
  value = "string",
  desc = "\230\182\136\232\128\151\229\141\161\231\137\140\230\156\128\228\189\142\230\152\159\231\186\167"
}, {
  field = "playerLevel",
  value = "int",
  desc = "\229\133\145\230\141\162\230\137\128\233\156\128\231\142\169\229\174\182\231\173\137\231\186\167"
}, {
  field = "maxExchangeNum",
  value = "int",
  desc = "\230\156\128\229\164\167\229\133\145\230\141\162\230\149\176\233\135\143"
}, {})
DEF({
  type = "GemRewardCost",
  file = "",
  desc = "GemRewardCost"
}, {
  index = "id",
  value = "int",
  desc = "id"
}, {
  field = "costTypes",
  value = "string",
  desc = "\230\182\136\232\128\151\231\177\187\229\158\139"
}, {
  field = "cost",
  value = "int",
  desc = "\230\182\136\232\128\151\229\128\188"
}, {
  field = "name",
  value = "string",
  desc = "\229\133\145\230\141\162\229\144\141\231\167\176"
}, {
  field = "showType",
  value = "string",
  desc = "\229\165\150\229\138\177\231\177\187\229\158\139"
}, {
  field = "showId",
  value = "int",
  desc = "\229\165\150\229\138\177\230\160\135\232\175\134"
}, {
  field = "amount",
  value = "string",
  desc = "\230\149\176\233\135\143"
}, {
  field = "rare",
  value = "string",
  desc = "\230\152\175\229\144\166\231\143\141\229\147\129"
}, {
  field = "costStr",
  value = "string",
  desc = "\230\182\136\232\128\151\230\152\190\231\164\186"
}, {})
DEF({
  type = "PrRewardCost",
  file = "",
  desc = "\228\187\153\230\151\143\229\174\157\229\186\151"
}, {
  index = "id",
  value = "int",
  desc = "id"
}, {
  field = "costTypes",
  value = "string",
  desc = "\230\182\136\232\128\151\231\177\187\229\158\139"
}, {
  field = "cost",
  value = "int",
  desc = "\230\182\136\232\128\151\229\128\188"
}, {
  field = "name",
  value = "string",
  desc = "\229\133\145\230\141\162\229\144\141\231\167\176"
}, {
  field = "showType",
  value = "string",
  desc = "\229\165\150\229\138\177\231\177\187\229\158\139"
}, {
  field = "showId",
  value = "int",
  desc = "\229\165\150\229\138\177\230\160\135\232\175\134"
}, {
  field = "amount",
  value = "string",
  desc = "\230\149\176\233\135\143"
}, {
  field = "discount",
  value = "int",
  desc = "\230\138\152\230\137\163"
}, {
  field = "costStr",
  value = "string",
  desc = "\230\182\136\232\128\151\230\152\190\231\164\186"
}, {})
DEF({
  type = "PreciousShow",
  file = "",
  desc = "\228\187\153\230\151\143\229\174\157\229\186\151"
}, {
  index = "id",
  value = "int",
  desc = "id"
}, {
  field = "showType",
  value = "string",
  desc = "\229\165\150\229\138\177\231\177\187\229\158\139"
}, {
  field = "showId",
  value = "int",
  desc = "\229\165\150\229\138\177\230\160\135\232\175\134"
}, {
  field = "amount",
  value = "string",
  desc = "\230\149\176\233\135\143"
}, {
  field = "mallId",
  value = "int",
  desc = "\229\149\134\229\159\142id"
}, {
  field = "name",
  value = "string",
  desc = "\229\149\134\229\147\129\229\144\141\231\167\176"
}, {})
DEF({
  type = "GodTaskSetting",
  file = "",
  desc = "\229\164\169\229\186\173\232\181\143\233\135\145\228\187\164"
}, {
  index = "id",
  value = "int",
  desc = "\230\160\135\232\175\134"
}, {
  field = "targetType",
  value = "string",
  desc = "\228\187\187\229\138\161\231\155\174\230\160\135\231\177\187\229\158\139"
}, {
  field = "target",
  value = "int",
  desc = "\231\155\174\230\160\135\229\128\188"
}, {
  field = "feats",
  value = "int",
  desc = "\229\174\140\230\136\144\228\187\187\229\138\161\229\138\159\231\187\169"
}, {
  field = "showType",
  value = "string",
  desc = "\229\165\150\229\138\177\231\177\187\229\158\139"
}, {
  field = "showId",
  value = "string",
  desc = "\229\165\150\229\138\177\230\160\135\232\175\134"
}, {
  field = "sort",
  value = "int",
  desc = "\230\142\146\229\186\143"
}, {
  field = "name",
  value = "string",
  desc = "\231\164\188\229\140\133\229\144\141\229\173\151"
}, {
  field = "desc",
  value = "string",
  desc = "\232\175\180\230\152\142"
}, {})
DEF({
  type = "GodFeatSetting",
  file = "",
  desc = "\229\164\169\229\186\173\232\181\143\233\135\145\228\187\164\229\138\159\231\187\169\229\165\150\229\138\177"
}, {
  index = "id",
  value = "int",
  desc = "\230\160\135\232\175\134"
}, {
  field = "feats",
  value = "int",
  desc = "\230\137\128\233\156\128\229\138\159\231\187\169\229\128\188"
}, {
  field = "showType",
  value = "string",
  desc = "\229\165\150\229\138\177\231\177\187\229\158\139"
}, {
  field = "showId",
  value = "int",
  desc = "\229\165\150\229\138\177\230\160\135\232\175\134"
}, {
  field = "amount",
  value = "string",
  desc = "\230\149\176\233\135\143"
}, {
  field = "desc",
  value = "string",
  desc = "\229\165\150\229\138\177\230\143\143\232\191\176"
}, {})
DEF({
  type = "MoonExSetting",
  file = "",
  desc = "\229\134\155\229\155\162\229\149\134\229\186\151\231\137\169\229\147\129"
}, {
  index = "id",
  value = "int",
  desc = "id"
}, {
  field = "group",
  value = "int",
  desc = "\229\136\134\231\187\132"
}, {
  field = "costs",
  value = "string",
  desc = "\230\182\136\232\128\151"
}, {
  field = "count",
  value = "int",
  desc = "\230\149\176\233\135\143"
}, {
  field = "packDesr",
  value = "string",
  desc = "\231\164\188\229\140\133\230\143\143\232\191\176"
}, {})
DEF({
  type = "MonopolyTask",
  file = "",
  desc = "MonopolyTask"
}, {
  index = "id",
  value = "int",
  desc = "\230\160\135\232\175\134"
}, {
  field = "targetType",
  value = "string",
  desc = "\228\187\187\229\138\161\231\155\174\230\160\135\231\177\187\229\158\139"
}, {
  field = "target",
  value = "int",
  desc = "\231\155\174\230\160\135\229\128\188"
}, {
  field = "completeCost",
  value = "int",
  desc = "\231\171\139\229\141\179\229\174\140\230\136\144\230\182\136\232\128\151"
}, {
  field = "showTypes",
  value = "string",
  desc = "\229\165\150\229\138\177\231\177\187\229\158\139"
}, {
  field = "showIds",
  value = "string",
  desc = "\229\165\150\229\138\177\230\160\135\232\175\134"
}, {
  field = "amounts",
  value = "string",
  desc = "\230\149\176\233\135\143"
}, {
  field = "bestReward",
  value = "string",
  desc = "\230\156\128\229\165\189\229\165\150\229\138\177"
}, {
  field = "name",
  value = "string",
  desc = "\231\164\188\229\140\133\229\144\141\229\173\151"
}, {
  field = "desc",
  value = "string",
  desc = "\232\175\180\230\152\142"
}, {})
DEF({
  type = "MonopolyGoods",
  file = "",
  desc = "MonopolyGoods"
}, {
  index = "id",
  value = "int",
  desc = "id"
}, {
  field = "cost",
  value = "int",
  desc = "\228\187\163\229\184\129\230\182\136\232\128\151\229\128\188"
}, {
  field = "tokenToCurrency",
  value = "int",
  desc = "\230\175\143\228\184\128\228\184\170\228\187\163\229\184\129\229\128\188\229\164\154\229\176\145\230\184\184\230\136\143\229\184\129"
}, {
  field = "sort",
  value = "int",
  desc = ""
}, {
  field = "name",
  value = "string",
  desc = "\229\133\145\230\141\162\229\144\141\231\167\176"
}, {
  field = "showType",
  value = "string",
  desc = "\229\165\150\229\138\177\231\177\187\229\158\139"
}, {
  field = "showId",
  value = "int",
  desc = "\229\165\150\229\138\177\230\160\135\232\175\134"
}, {
  field = "amount",
  value = "string",
  desc = "\230\149\176\233\135\143"
}, {})
DEF({
  type = "PositionValueType",
  file = "",
  desc = "PositionValueType"
}, {
  index = "id",
  value = "int",
  desc = "\228\189\141\231\189\174"
}, {
  field = "positionTypes",
  value = "string",
  desc = "\231\137\169\229\147\129\231\177\187\229\158\139"
}, {})
DEF({
  type = "RingBox",
  file = "",
  desc = "RingBox"
}, {
  index = "id",
  value = "int",
  desc = "id"
}, {
  field = "rings",
  value = "int",
  desc = "\230\137\128\233\156\128\231\142\175\230\149\176"
}, {
  field = "levels",
  value = "string",
  desc = "\231\173\137\231\186\167\230\174\181\233\133\141\231\189\174"
}, {
  field = "boxRewards",
  value = "string",
  desc = "\229\174\157\231\174\177\229\165\150\229\138\177\229\144\141\231\167\176"
}, {
  field = "showTypes",
  value = "string",
  desc = "\229\165\150\229\138\177\231\177\187\229\158\139"
}, {
  field = "showIds",
  value = "string",
  desc = "\229\165\150\229\138\177\230\160\135\232\175\134"
}, {
  field = "amounts",
  value = "string",
  desc = "\230\149\176\233\135\143"
}, {})
DEF({
  type = "MonopolyShow",
  file = "",
  desc = "\229\174\157\231\137\169\229\177\149\231\164\186"
}, {
  index = "id",
  value = "int",
  desc = "id"
}, {
  field = "showType",
  value = "string",
  desc = "\229\165\150\229\138\177\231\177\187\229\158\139"
}, {
  field = "showId",
  value = "int",
  desc = "\229\165\150\229\138\177\230\160\135\232\175\134"
}, {
  field = "amount",
  value = "string",
  desc = "\230\149\176\233\135\143"
}, {
  field = "iconType",
  value = "string",
  desc = "\229\155\190\230\160\135\231\177\187\229\158\139"
}, {
  field = "name",
  value = "string",
  desc = "\229\149\134\229\147\129\229\144\141\231\167\176"
}, {})
DEF({
  type = "SlotReward",
  file = "",
  desc = "ElixirMaterial"
}, {
  index = "id",
  value = "int",
  desc = "\229\165\150\229\138\177\230\160\135\232\175\134"
}, {
  field = "times",
  value = "int",
  desc = "\230\137\128\229\135\186\231\142\176\231\154\132\229\128\141\230\149\176"
}, {
  field = "showType",
  value = "string",
  desc = "\229\165\150\229\138\177\231\177\187\229\158\139"
}, {
  field = "showId",
  value = "int",
  desc = "\229\165\150\229\138\177\230\160\135\232\175\134"
}, {
  field = "amount",
  value = "string",
  desc = "\230\149\176\233\135\143"
}, {})
DEF({
  type = "ExchangeSetting",
  file = "",
  desc = "ExchangeSetting"
}, {
  index = "id",
  value = "int",
  desc = "\230\160\135\232\175\134"
}, {
  field = "activity",
  value = "string",
  desc = "\230\137\128\229\177\158\230\180\187\229\138\168id"
}, {
  field = "rewardId",
  value = "string",
  desc = "\229\165\150\229\138\177\228\191\161\230\129\175"
}, {
  field = "costItems",
  value = "string",
  desc = "\230\137\163\232\180\185\228\191\161\230\129\175"
}, {
  field = "costSameNameId",
  value = "string",
  desc = "\229\133\182\228\187\150\231\154\132\229\141\161\231\137\140\229\144\140\229\144\141id"
}, {
  field = "costMinStar",
  value = "string",
  desc = "\230\182\136\232\128\151\229\141\161\231\137\140\230\156\128\228\189\142\230\152\159\231\186\167"
}, {
  field = "limit",
  value = "int",
  desc = "\229\133\145\230\141\162\230\172\161\230\149\176\228\184\138\233\153\144"
}, {})
DEF({
  type = "SweetHouseItemSetting",
  file = "",
  desc = "SweetHouseItemSetting"
}, {
  index = "id",
  value = "int",
  desc = "id"
}, {
  field = "sweetType",
  value = "int",
  desc = "\231\179\150\230\158\156\231\177\187\229\158\139"
}, {
  field = "costTypes",
  value = "string",
  desc = "\230\182\136\232\128\151\231\177\187\229\158\139"
}, {
  field = "cost",
  value = "int",
  desc = "\230\182\136\232\128\151\229\128\188"
}, {
  field = "name",
  value = "string",
  desc = "\229\133\145\230\141\162\229\144\141\231\167\176"
}, {
  field = "showType",
  value = "string",
  desc = "\229\165\150\229\138\177\231\177\187\229\158\139"
}, {
  field = "showId",
  value = "int",
  desc = "\229\165\150\229\138\177\230\160\135\232\175\134"
}, {
  field = "amount",
  value = "string",
  desc = "\230\149\176\233\135\143"
}, {
  field = "rare",
  value = "string",
  desc = "\230\152\175\229\144\166\231\143\141\229\147\129"
}, {
  field = "costStr",
  value = "string",
  desc = "\230\182\136\232\128\151\230\152\190\231\164\186"
}, {})
DEF({
  type = "CultivateState",
  file = "",
  desc = "CultivateState"
}, {
  index = "id",
  value = "int",
  desc = "\229\162\131\231\149\140"
}, {
  field = "nextId",
  value = "int",
  desc = "\228\184\139\228\184\128\228\184\170\229\162\131\231\149\140"
}, {
  field = "lock",
  value = "string",
  desc = "\230\184\161\229\138\171\233\148\129"
}, {
  field = "cost",
  value = "int",
  desc = "\230\184\161\229\138\171\230\136\144\229\138\159\230\182\136\232\128\151"
}, {
  field = "desc",
  value = "string",
  desc = "\229\162\131\231\149\140\230\143\143\232\191\176"
}, {
  field = "name",
  value = "string",
  desc = "\229\162\131\231\149\140\229\144\141\231\167\176"
}, {
  field = "costStr",
  value = "string",
  desc = "\229\144\136\230\136\144\230\137\128\230\182\136\232\128\151\231\154\132\230\184\184\230\136\143\229\184\129"
}, {})
DEF({
  type = "ElixirMaterial",
  file = "",
  desc = "ElixirMaterial"
}, {
  index = "id",
  value = "int",
  desc = "\230\157\144\230\150\153\230\160\135\232\175\134"
}, {
  field = "level",
  value = "int",
  desc = "\231\173\137\231\186\167"
}, {
  field = "name",
  value = "string",
  desc = "\229\144\141\229\173\151"
}, {
  field = "desc",
  value = "string",
  desc = "\230\143\143\232\191\176"
}, {
  field = "modelId",
  value = "int",
  desc = "\230\168\161\229\158\139"
}, {
  field = "dropIds",
  value = "string",
  desc = "\230\157\144\230\150\153\230\142\137\232\144\189\229\137\175\230\156\172\231\130\185"
}, {
  field = "rank",
  value = "int",
  desc = "\230\157\144\230\150\153\229\147\129\232\180\168"
}, {})
DEF({
  type = "ElixirSetting",
  file = "",
  desc = "ElixirSetting"
}, {
  index = "id",
  value = "int",
  desc = "\228\187\153\228\184\185\230\160\135\232\175\134"
}, {
  field = "state",
  value = "int",
  desc = "\229\162\131\231\149\140"
}, {
  field = "materials",
  value = "string",
  desc = "\229\144\136\230\136\144\230\137\128\233\156\128\230\157\144\230\150\153"
}, {
  field = "cost",
  value = "int",
  desc = "\229\144\136\230\136\144\230\137\128\230\182\136\232\128\151\231\154\132\230\184\184\230\136\143\229\184\129"
}, {
  field = "alters",
  value = "string",
  desc = "\233\153\132\229\138\160\231\154\132\229\177\158\230\128\167"
}, {
  field = "modelId",
  value = "int",
  desc = "\230\168\161\229\158\139"
}, {
  field = "decs",
  value = "string",
  desc = "\230\143\143\232\191\176"
}, {
  field = "name",
  value = "string",
  desc = "\229\144\141\229\173\151"
}, {
  field = "rank",
  value = "int",
  desc = "\228\184\185\232\141\175\229\147\129\232\180\168"
}, {
  field = "type",
  value = "int",
  desc = "\228\184\185\232\141\175\231\177\187\229\136\171"
}, {
  field = "disabledModelId",
  value = "int",
  desc = "\231\129\176\230\128\129\230\168\161\229\158\139id"
}, {
  field = "costStr",
  value = "string",
  desc = "\229\144\136\230\136\144\230\137\128\230\182\136\232\128\151\231\154\132\230\184\184\230\136\143\229\184\129"
}, {})
DEF({
  type = "HeroCrossing",
  file = "",
  desc = "HeroCrossing"
}, {
  index = "id",
  value = "string",
  desc = "\229\141\161\231\137\140id_\229\162\131\231\149\140"
}, {
  field = "myFighter",
  value = "string",
  desc = "\230\184\161\229\138\171\229\136\157\229\167\139\229\184\131\233\152\181"
}, {
  field = "virtualPlayer",
  value = "int",
  desc = "\230\149\140\230\150\185\229\129\135\228\186\186"
}, {
  field = "alters",
  value = "string",
  desc = "\230\184\161\229\138\171\230\136\144\229\138\159\230\183\187\229\138\160\231\154\132\229\177\158\230\128\167"
}, {
  field = "dramaId",
  value = "int",
  desc = "\230\184\161\229\138\171\229\137\167\230\131\133"
}, {})
DEF({
  type = "HeroMaxState",
  file = "",
  desc = "HeroMaxState"
}, {
  index = "id",
  value = "string",
  desc = "\229\141\161\231\137\140\229\147\129\232\180\168_\230\152\159\231\186\167"
}, {
  field = "maxState",
  value = "int",
  desc = "\230\156\128\233\171\152\229\162\131\231\149\140"
}, {})
DEF({
  type = "UnitTypeElixir",
  file = "",
  desc = "UnitTypeElixir"
}, {
  index = "id",
  value = "string",
  desc = "\229\141\161\231\137\140\232\129\140\228\184\154_\229\162\131\231\149\140"
}, {
  field = "elixirs",
  value = "string",
  desc = "\229\143\175\228\187\165\229\144\158\229\153\172\231\154\132\228\184\185\232\141\175,\230\160\188\229\188\143{\"\228\189\141\231\189\174\":\228\187\153\228\184\185id}"
}, {
  field = "alters",
  value = "string",
  desc = "\229\144\158\229\153\172\232\175\165\229\162\131\231\149\140\228\184\185\232\141\175\230\191\128\230\180\187\231\154\132\233\162\157\229\164\150\231\154\132\229\177\158\230\128\167"
}, {
  field = "reCultivateCostTypes",
  value = "string",
  desc = "\233\135\141\228\191\174\230\182\136\232\128\151\231\177\187\229\158\139"
}, {
  field = "myFighter",
  value = "string",
  desc = "\230\184\161\229\138\171\229\136\157\229\167\139\229\184\131\233\152\181"
}, {
  field = "virtualPlayer",
  value = "int",
  desc = "\230\149\140\230\150\185\229\129\135\228\186\186"
}, {
  field = "crossingAlters",
  value = "string",
  desc = "\230\184\161\229\138\171\230\136\144\229\138\159\230\183\187\229\138\160\231\154\132\229\177\158\230\128\167"
}, {
  field = "dramaId",
  value = "int",
  desc = "\230\184\161\229\138\171\229\137\167\230\131\133"
}, {})
DEF({
  type = "VirtualCultivatePlayer",
  file = "",
  desc = "\232\153\154\230\139\159\231\142\169\229\174\1821"
}, {
  index = "id",
  value = "int",
  desc = "\230\160\135\232\175\134"
}, {
  field = "leaderBaseId",
  value = "int",
  desc = "\233\152\159\233\149\191\229\159\186\231\161\128id"
}, {
  field = "enemiesId",
  value = "string",
  desc = "\229\141\161\231\187\132"
}, {})
DEF({
  type = "EnemyFighterClient",
  file = "",
  desc = "\230\184\161\229\138\171\230\136\152\230\150\151\229\183\177\230\150\185"
}, {
  index = "id",
  value = "string",
  desc = "\230\160\135\232\175\134"
}, {
  field = "enemies",
  value = "string",
  desc = "\230\128\170\231\137\169\230\160\135\232\175\134"
}, {})
DEF({
  type = "EnemyUnitClient",
  file = "",
  desc = "\230\184\161\229\138\171\229\183\177\230\150\185\229\129\135\228\186\186"
}, {
  index = "id",
  value = "string",
  desc = "\230\160\135\232\175\134"
}, {
  field = "level",
  value = "int",
  desc = "\231\173\137\231\186\167"
}, {
  field = "model",
  value = "string",
  desc = "\230\168\161\229\158\139\228\191\161\230\129\175"
}, {
  field = "values",
  value = "string",
  desc = "\229\177\158\230\128\167\230\149\176\229\128\188"
}, {
  field = "rates",
  value = "string",
  desc = "\230\175\148\231\142\135\230\149\176\229\128\188"
}, {
  field = "auras",
  value = "string",
  desc = "\229\133\137\231\142\175\230\138\128\232\131\189"
}, {
  field = "restraint",
  value = "string",
  desc = "\231\167\141\230\151\143\229\133\139\229\136\182"
}, {
  field = "skills",
  value = "string",
  desc = "\230\138\128\232\131\189\230\148\187\229\135\187"
}, {})
DEF({
  type = "ShopSetting",
  file = "",
  desc = "ShopSetting"
}, {
  index = "id",
  value = "int",
  desc = "\229\149\134\229\186\151\233\152\182\231\186\167"
}, {
  field = "lock",
  value = "string",
  desc = "\229\149\134\229\186\151\229\188\128\229\144\175\233\148\129"
}, {
  field = "desc",
  value = "string",
  desc = "\229\162\131\231\149\140\230\143\143\232\191\176"
}, {
  field = "bgPath",
  value = "string",
  desc = "\229\149\134\229\186\151\230\157\161\232\131\140\230\153\175\232\183\175\229\190\132"
}, {
  field = "titlePath",
  value = "string",
  desc = "\230\160\135\233\162\152\232\183\175\229\190\132"
}, {})
DEF({
  type = "ShopItemSetting",
  file = "",
  desc = "ShopItemSetting"
}, {
  index = "id",
  value = "int",
  desc = "id"
}, {
  field = "costTypes",
  value = "string",
  desc = "\230\182\136\232\128\151\231\177\187\229\158\139"
}, {
  field = "cost",
  value = "int",
  desc = "\230\182\136\232\128\151\229\128\188"
}, {
  field = "name",
  value = "string",
  desc = "\229\133\145\230\141\162\229\144\141\231\167\176"
}, {
  field = "showType",
  value = "string",
  desc = "\229\165\150\229\138\177\231\177\187\229\158\139"
}, {
  field = "showId",
  value = "int",
  desc = "\229\165\150\229\138\177\230\160\135\232\175\134"
}, {
  field = "amount",
  value = "string",
  desc = "\230\149\176\233\135\143"
}, {
  field = "costStr",
  value = "string",
  desc = "\230\182\136\232\128\151\230\152\190\231\164\186"
}, {})
DEF({
  type = "TurkeyMaterial",
  file = "",
  desc = "TurkeyMaterial"
}, {
  index = "id",
  value = "int",
  desc = "\230\157\144\230\150\153\230\160\135\232\175\134"
}, {
  field = "price",
  value = "int",
  desc = "\228\187\183\230\160\188"
}, {
  field = "desc",
  value = "string",
  desc = "\232\175\180\230\152\142"
}, {})
DEF({
  type = "DateReturn",
  file = "",
  desc = "DateReturn"
}, {
  index = "id",
  value = "string",
  desc = "\230\160\135\232\175\134"
}, {
  field = "vip",
  value = "string",
  desc = "\230\152\175\229\144\166\233\156\128\232\166\129\230\152\175VIP\231\148\168\230\136\183(\230\156\136\229\141\161)"
}, {
  field = "week",
  value = "string",
  desc = "\230\152\175\229\144\166\233\156\128\232\166\129\230\152\175\229\145\168\229\141\161\231\148\168\230\136\183"
}, {
  field = "charge",
  value = "int",
  desc = "\230\137\128\233\156\128\229\133\133\229\128\188\233\162\157\229\186\166(\233\135\145\229\184\129)"
}, {
  field = "date",
  value = "string",
  desc = "\229\165\150\229\138\177\230\137\128\229\177\158\230\151\165\230\156\159\239\188\140\230\160\188\229\188\143yyyy-MM-dd"
}, {
  field = "rewardId",
  value = "string",
  desc = "\229\165\150\229\138\177id"
}, {
  field = "sort",
  value = "int",
  desc = "\230\142\146\229\186\143"
}, {})
DEF({
  type = "ExchangeRefCost",
  file = "",
  desc = "ExchangeRefCost"
}, {
  index = "id",
  value = "int",
  desc = "\230\172\161\230\149\176"
}, {
  field = "currencyTypes",
  value = "string",
  desc = "\230\182\136\232\128\151\231\177\187\229\158\139"
}, {
  field = "cost",
  value = "int",
  desc = "\230\182\136\232\128\151\229\128\188"
}, {
  field = "costItems",
  value = "string",
  desc = "\229\133\182\228\187\150\230\182\136\232\128\151"
}, {})
DEF({
  type = "ExchRewardCost",
  file = "",
  desc = "ExchRewardCost"
}, {
  index = "id",
  value = "int",
  desc = "id"
}, {
  field = "costTypes",
  value = "string",
  desc = "\230\182\136\232\128\151\231\177\187\229\158\139"
}, {
  field = "cost",
  value = "int",
  desc = "\230\182\136\232\128\151\229\128\188"
}, {
  field = "otherCost",
  value = "string",
  desc = "\229\133\182\228\187\150\230\182\136\232\128\151"
}, {
  field = "limit",
  value = "int",
  desc = "\230\175\143\229\164\169\229\133\145\230\141\162\230\172\161\230\149\176\228\184\138\233\153\144"
}, {
  field = "name",
  value = "string",
  desc = "\229\133\145\230\141\162\229\144\141\231\167\176"
}, {
  field = "showType",
  value = "string",
  desc = "\229\165\150\229\138\177\231\177\187\229\158\139"
}, {
  field = "showId",
  value = "int",
  desc = "\229\165\150\229\138\177\230\160\135\232\175\134"
}, {
  field = "amount",
  value = "string",
  desc = "\230\149\176\233\135\143"
}, {
  field = "rare",
  value = "string",
  desc = "\230\152\175\229\144\166\231\143\141\229\147\129"
}, {
  field = "costStr",
  value = "string",
  desc = "\230\182\136\232\128\151\230\152\190\231\164\186"
}, {
  field = "boxGoods",
  value = "string",
  desc = "\231\174\177\229\173\144\230\152\190\231\164\186\231\137\169\229\147\129"
}, {})
DEF({
  type = "RecycleSetting",
  file = "",
  desc = "RecycleSetting"
}, {
  index = "id",
  value = "string",
  desc = "id"
}, {
  field = "pool",
  value = "int",
  desc = "\230\137\128\229\177\158\231\134\148\231\130\188\230\177\160"
}, {
  field = "levels",
  value = "string",
  desc = "\231\173\137\231\186\167\230\174\181"
}, {
  field = "rates",
  value = "string",
  desc = "\233\187\152\232\174\164\229\155\158\230\148\182\231\153\190\229\136\134\231\153\190"
}, {
  field = "costs",
  value = "string",
  desc = "\230\182\136\232\128\151\229\128\188"
}, {
  field = "fixCounts",
  value = "string",
  desc = "\229\155\186\229\174\154\229\165\150\229\138\177\230\149\176\233\135\143"
}, {
  field = "randomCounts",
  value = "string",
  desc = "\233\154\143\230\156\186\229\165\150\229\138\177\230\149\176\233\135\143"
}, {
  field = "goldCounts",
  value = "string",
  desc = "\228\187\153\231\142\137\229\165\150\229\138\177\230\149\176\233\135\143"
}, {})
DEF({
  type = "TaskSuccessItemConfig",
  file = "",
  desc = "\229\141\161\231\137\140-\229\147\129\232\180\168"
}, {
  index = "id",
  value = "int",
  desc = "id"
}, {
  field = "content",
  value = "string",
  desc = "\230\136\144\229\138\159\230\157\161\228\187\182"
}, {
  field = "desr",
  value = "string",
  desc = "\230\157\161\228\187\182\230\143\143\232\191\176"
}, {})
DEF({
  type = "TaskPointCDConfig",
  file = "",
  desc = "TaskPointCDConfig"
}, {
  index = "id",
  value = "string",
  desc = "\230\160\135\232\175\134"
}, {
  field = "cards",
  value = "string",
  desc = "\229\141\161\231\137\140\231\187\132\229\144\136"
}, {
  field = "placeIcon",
  value = "string",
  desc = "\229\156\176\231\130\185\229\164\180\229\131\143"
}, {
  field = "desr",
  value = "string",
  desc = "\229\135\143CD\228\187\187\229\138\161\230\143\143\232\191\176"
}, {})
DEF({
  type = "TaskRewardConfig",
  file = "",
  desc = "TaskRewardConfig"
}, {
  index = "id",
  value = "int",
  desc = "\230\160\135\232\175\134"
}, {
  field = "baseShowTypes",
  value = "string",
  desc = "\229\159\186\231\161\128\229\165\150\229\138\177ShowTypes"
}, {
  field = "baseShowIds",
  value = "string",
  desc = "\229\159\186\231\161\128\229\165\150\229\138\177ShowIds"
}, {
  field = "baseAmounts",
  value = "string",
  desc = "\229\159\186\231\161\128\229\165\150\229\138\177ShowAmounts"
}, {
  field = "successShowTypes",
  value = "string",
  desc = "\230\136\144\229\138\159\229\165\150\229\138\177ShowTypes"
}, {
  field = "successShowIds",
  value = "string",
  desc = "\230\136\144\229\138\159\229\165\150\229\138\177ShowIds"
}, {
  field = "successAmounts",
  value = "string",
  desc = "\230\136\144\229\138\159\229\165\150\229\138\177ShowAmounts"
}, {})
DEF({
  type = "TaskPlace",
  file = "",
  desc = "TaskPlace"
}, {
  index = "id",
  value = "string",
  desc = "\230\160\135\232\175\134"
}, {
  field = "taskName",
  value = "string",
  desc = "\228\187\187\229\138\161\229\144\141\231\167\176"
}, {
  field = "taskDesr",
  value = "string",
  desc = "\228\187\187\229\138\161\231\174\128\228\187\139"
}, {
  field = "placeIcon",
  value = "string",
  desc = "\229\156\176\231\130\185\229\164\180\229\131\143"
}, {
  field = "bossBaseId",
  value = "int",
  desc = "bossBaseId"
}, {})
DEF({
  type = "NPCLevelConfig",
  file = "",
  desc = "NPCLevelConfig"
}, {
  index = "id",
  value = "int",
  desc = "\231\173\137\231\186\167"
}, {
  field = "exp",
  value = "double",
  desc = "\229\141\135\231\186\167\231\187\143\233\170\140"
}, {
  field = "levelLimit",
  value = "int",
  desc = "\228\184\187\232\167\146\231\173\137\231\186\167\232\166\129\230\177\130"
}, {
  field = "taskLimit",
  value = "int",
  desc = "\229\143\145\229\184\131\228\187\187\229\138\161\230\149\176\233\135\143"
}, {
  field = "conExecLimit",
  value = "int",
  desc = "\229\144\140\230\151\182\230\137\167\232\161\140\228\187\187\229\138\161\230\149\176\233\135\143"
}, {
  field = "nextCondition",
  value = "string",
  desc = "\228\184\139\228\184\128\231\186\167\231\154\132\230\157\161\228\187\182"
}, {
  field = "nextFunction",
  value = "string",
  desc = "\228\184\139\228\184\128\231\186\167\231\154\132\229\138\159\232\131\189"
}, {
  field = "showTypes",
  value = "string",
  desc = "\229\177\149\231\164\186\229\165\150\229\138\177ShowTypes"
}, {
  field = "showIds",
  value = "string",
  desc = "\229\177\149\231\164\186\229\165\150\229\138\177ShowIds"
}, {
  field = "amounts",
  value = "string",
  desc = "\229\177\149\231\164\186\229\165\150\229\138\177ShowAmounts"
}, {
  field = "guideName",
  value = "string",
  desc = "NPC\229\144\141\229\173\151"
}, {})
DEF({
  type = "ExploreVirtualCard",
  file = "",
  desc = "ExploreVirtualCard"
}, {
  index = "id",
  value = "int",
  desc = "\230\160\135\232\175\134"
}, {
  field = "star",
  value = "int",
  desc = "\230\152\159\231\186\167"
}, {
  field = "costs",
  value = "string",
  desc = "\233\155\135\228\189\163\230\182\136\232\128\151\229\128\188"
}, {
  field = "rate",
  value = "int",
  desc = "\230\143\144\233\171\152\230\136\144\229\138\159\231\142\135"
}, {
  field = "fightScore",
  value = "int",
  desc = "\230\136\152\230\150\151\229\138\155"
}, {
  field = "iconPath",
  value = "string",
  desc = "\229\164\180\229\131\143\232\183\175\229\190\132"
}, {
  field = "iconRank",
  value = "int",
  desc = "\229\164\180\229\131\143\229\147\129\232\180\168"
}, {
  field = "level",
  value = "int",
  desc = "\231\173\137\231\186\167"
}, {
  field = "name",
  value = "string",
  desc = "\229\144\141\229\173\151"
}, {})
DEF({
  type = "TaskStarConfig",
  file = "",
  desc = "TaskConfig"
}, {
  index = "id",
  value = "int",
  desc = "\230\160\135\232\175\134"
}, {
  field = "hireFriendLimit",
  value = "int",
  desc = "\233\155\135\228\189\163\229\165\189\229\143\139\229\141\161\231\137\140\229\188\160\230\149\176\228\184\138\233\153\144"
}, {
  field = "hireVirtualLimit",
  value = "int",
  desc = "\233\155\135\228\189\163\231\179\187\231\187\159\229\141\161\231\137\140\229\188\160\230\149\176\228\184\138\233\153\144"
}, {
  field = "hireFriendCostTypes",
  value = "string",
  desc = "\233\155\135\228\189\163\229\165\189\229\143\139\229\141\161\231\137\140\230\182\136\232\128\151\231\177\187\229\158\139"
}, {
  field = "hireFriendCosts",
  value = "int",
  desc = "\233\155\135\228\189\163\229\165\189\229\143\139\229\141\161\231\137\140\230\182\136\232\128\151\229\128\188"
}, {
  field = "baseFinishCost",
  value = "double",
  desc = "\230\137\167\232\161\140\228\187\187\229\138\161\231\167\146CD\230\182\136\232\128\151\229\159\186\231\161\128\229\128\188"
}, {})
DEF({
  type = "MoGoodsItemSetting",
  file = "",
  desc = "MoGoodsItemSetting"
}, {
  index = "id",
  value = "int",
  desc = "MonopolyGoodsItemSetting"
}, {
  field = "cost",
  value = "int",
  desc = "\228\187\163\229\184\129\230\182\136\232\128\151\229\128\188"
}, {
  field = "buyLimit",
  value = "int",
  desc = "\232\180\173\228\185\176\230\172\161\230\149\176\233\153\144\229\136\182"
}, {
  field = "sort",
  value = "int",
  desc = ""
}, {
  field = "name",
  value = "string",
  desc = "\229\133\145\230\141\162\229\144\141\231\167\176"
}, {
  field = "showType",
  value = "string",
  desc = "\229\165\150\229\138\177\231\177\187\229\158\139"
}, {
  field = "showId",
  value = "int",
  desc = "\229\165\150\229\138\177\230\160\135\232\175\134"
}, {
  field = "amount",
  value = "string",
  desc = "\230\149\176\233\135\143"
}, {})
DEF({
  type = "RingsBoxRewardSetting",
  file = "",
  desc = "RingsBoxRewardSetting"
}, {
  index = "id",
  value = "int",
  desc = "id"
}, {
  field = "floor",
  value = "string",
  desc = "\229\156\176\229\155\190\230\160\135\232\175\134"
}, {
  field = "rings",
  value = "int",
  desc = "\230\137\128\233\156\128\231\142\175\230\149\176"
}, {
  field = "levels",
  value = "string",
  desc = "\231\173\137\231\186\167\230\174\181\233\133\141\231\189\174"
}, {
  field = "boxRewards",
  value = "string",
  desc = "\229\174\157\231\174\177\229\165\150\229\138\177\229\144\141\231\167\176"
}, {
  field = "showTypes",
  value = "string",
  desc = "\229\165\150\229\138\177\231\177\187\229\158\139"
}, {
  field = "showIds",
  value = "string",
  desc = "\229\165\150\229\138\177\230\160\135\232\175\134"
}, {
  field = "amounts",
  value = "string",
  desc = "\230\149\176\233\135\143"
}, {})
DEF({
  type = "PositionPointSetting",
  file = "",
  desc = "\230\131\133\228\186\186\232\138\130\229\156\176\229\155\190"
}, {
  index = "id",
  value = "int",
  desc = "\228\189\141\231\189\174"
}, {
  field = "type",
  value = "string",
  desc = "\231\137\169\229\147\129\231\177\187\229\158\139"
}, {
  field = "addition",
  value = "string",
  desc = "\233\153\132\229\138\160\228\191\161\230\129\175"
}, {
  field = "isRepeat",
  value = "string",
  desc = "\229\143\175\229\144\166\233\135\141\229\164\141\230\137\167\232\161\140\232\161\140\229\138\168"
}, {})
DEF({
  type = "MoTaskSetting",
  file = "",
  desc = "MoTaskSetting"
}, {
  index = "id",
  value = "int",
  desc = "\230\160\135\232\175\134"
}, {
  field = "targetType",
  value = "string",
  desc = "\228\187\187\229\138\161\231\155\174\230\160\135\231\177\187\229\158\139"
}, {
  field = "target",
  value = "int",
  desc = "\231\155\174\230\160\135\229\128\188"
}, {
  field = "completeCost",
  value = "int",
  desc = "\231\171\139\229\141\179\229\174\140\230\136\144\230\182\136\232\128\151"
}, {
  field = "showTypes",
  value = "string",
  desc = "\229\165\150\229\138\177\231\177\187\229\158\139"
}, {
  field = "showIds",
  value = "string",
  desc = "\229\165\150\229\138\177\230\160\135\232\175\134"
}, {
  field = "amounts",
  value = "string",
  desc = "\230\149\176\233\135\143"
}, {
  field = "bestReward",
  value = "string",
  desc = "\230\156\128\229\165\189\229\165\150\229\138\177"
}, {
  field = "name",
  value = "string",
  desc = "\231\164\188\229\140\133\229\144\141\229\173\151"
}, {
  field = "desc",
  value = "string",
  desc = "\232\175\180\230\152\142"
}, {})
DEF({
  type = "PositionBuffSetting",
  file = "",
  desc = "PositionBuffSetting"
}, {
  index = "id",
  value = "string",
  desc = "\230\160\135\232\175\134"
}, {
  field = "type",
  value = "string",
  desc = "buff\231\177\187\229\158\139"
}, {
  field = "validTimes",
  value = "int",
  desc = "\230\156\137\230\149\136\230\172\161\230\149\176"
}, {
  field = "desr",
  value = "string",
  desc = "\230\143\143\232\191\176"
}, {
  field = "isGoodBuff",
  value = "string",
  desc = "\230\152\175\229\144\166\232\137\175\230\128\167\229\162\158\231\155\138"
}, {})
DEF({
  type = "MoRingsSetting",
  file = "",
  desc = "MoRingsSetting"
}, {
  index = "id",
  value = "string",
  desc = "\230\160\135\232\175\134"
}, {
  field = "forkStart",
  value = "int",
  desc = "\229\136\134\229\178\148\232\183\175\229\133\165\229\143\163\228\189\141\231\189\174\231\130\185"
}, {
  field = "forkEnd",
  value = "int",
  desc = "\229\136\134\229\178\148\232\183\175\231\187\147\230\157\159\228\189\141\231\189\174\231\130\185"
}, {})
DEF({
  type = "MoShow",
  file = "",
  desc = "\229\174\157\231\137\169\229\177\149\231\164\186"
}, {
  index = "id",
  value = "int",
  desc = "id"
}, {
  field = "floor",
  value = "string",
  desc = "\229\156\176\229\155\190"
}, {
  field = "showType",
  value = "string",
  desc = "\229\165\150\229\138\177\231\177\187\229\158\139"
}, {
  field = "showId",
  value = "int",
  desc = "\229\165\150\229\138\177\230\160\135\232\175\134"
}, {
  field = "amount",
  value = "string",
  desc = "\230\149\176\233\135\143"
}, {
  field = "iconType",
  value = "string",
  desc = "\229\155\190\230\160\135\231\177\187\229\158\139"
}, {
  field = "name",
  value = "string",
  desc = "\229\149\134\229\147\129\229\144\141\231\167\176"
}, {})
DEF({
  type = "MoBuffIcon",
  file = "",
  desc = "\229\174\157\231\137\169\229\177\149\231\164\186"
}, {
  index = "id",
  value = "string",
  desc = "\229\155\190\230\160\135\231\177\187\229\158\139"
}, {
  field = "desr",
  value = "string",
  desc = "\230\143\143\232\191\176"
}, {
  field = "sort",
  value = "int",
  desc = "\230\142\146\229\186\143\229\173\151\230\174\181"
}, {})
DEF({
  type = "ChargeReward",
  file = "",
  desc = "ChargeReward"
}, {
  index = "id",
  value = "int",
  desc = "\230\160\135\232\175\134"
}, {
  field = "activityId",
  value = "string",
  desc = "\230\137\128\229\177\158\230\180\187\229\138\168"
}, {
  field = "charge",
  value = "int",
  desc = "\230\137\128\233\156\128\229\133\133\229\128\188\233\135\145\229\184\129"
}, {
  field = "rewardId",
  value = "int",
  desc = "\229\165\150\229\138\177ID"
}, {
  field = "showTypes",
  value = "string",
  desc = "\229\165\150\229\138\177\231\177\187\229\158\139"
}, {
  field = "showIds",
  value = "string",
  desc = "\229\165\150\229\138\177\230\160\135\232\175\134"
}, {
  field = "amounts",
  value = "string",
  desc = "\229\165\150\229\138\177\230\149\176\233\135\143"
}, {
  field = "sort",
  value = "int",
  desc = "\230\142\146\229\186\143\229\173\151\230\174\181"
}, {})
DEF({
  type = "HeroCostRankUp",
  file = "",
  desc = "HeroCostRankUp"
}, {
  index = "id",
  value = "int",
  desc = "\229\141\161\231\137\140id"
}, {
  field = "rewardId",
  value = "string",
  desc = "\229\165\150\229\138\177\228\191\161\230\129\175"
}, {
  field = "costItems",
  value = "string",
  desc = "\230\137\163\232\180\185\228\191\161\230\129\175"
}, {
  field = "costSameNameId",
  value = "string",
  desc = "\229\133\182\228\187\150\231\154\132\229\141\161\231\137\140\229\144\140\229\144\141id"
}, {
  field = "costMinStar",
  value = "string",
  desc = "\230\182\136\232\128\151\229\141\161\231\137\140\230\156\128\228\189\142\230\152\159\231\186\167"
}, {
  field = "costMinLevel",
  value = "string",
  desc = "\230\182\136\232\128\151\229\141\161\231\137\140\230\156\128\228\189\142\231\173\137\231\186\167"
}, {
  field = "sort",
  value = "int",
  desc = "\230\142\146\229\186\143\229\173\151\230\174\181"
}, {})
