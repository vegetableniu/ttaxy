module(...)
Singleton(NetMsg):Setup(...)
mod = 159
cmd = {
  TEST_REWARD = {
    1,
    {reward = string},
    {
      code = int,
      content = array("com.eyu.mt.module.reward.model.Reward")
    }
  },
  TEST_REWARD_REPEAT = {
    2,
    {num = int, reward = string},
    {
      code = int,
      content = map(string, object)
    }
  }
}
types = {
  ["facade.RewardResult"] = const({
    TREASURE_SPACE_FULL = -204,
    INVALID_AMOUNT = -203,
    INVALID_CODE = -202,
    INVALID_REWARD = -201,
    SPACE_NOT_ENOUGH = -200
  }),
  ["model.AddtionType"] = enum({
    [0] = "LIMIT",
    [1] = "VIP",
    [2] = "FRIEND_LINESS",
    [3] = "FRIEND_COUNT",
    [4] = "WORLDLEVEL",
    [5] = "ACTIVITY",
    [6] = "CORPS_MEMBER",
    [7] = "CORPS_TECHNOLOGY_JADA",
    [8] = "CORPS_TECHNOLOGY_EXP",
    [9] = "CORPS_TECHNOLOGY_COPPER",
    [10] = "MENPAI_EXP_ADD",
    [11] = "MENPAI_COUNTRY_HOLD",
    [12] = "MERGER_DEMOG_FEAT_RANK",
    [13] = "MERGER_DEMOG_DAMAGE_RANK",
    [14] = "MERGER_MENPAI_COUNTRY",
    [15] = "MERGER_COUNTRY_HOLD",
    [16] = "MERGER_SINGLE_ADD",
    [17] = "MERGER_ELITE_ADD"
  }),
  ["model.Reward"] = {
    amount = int,
    code = int,
    content = string,
    type = "com.eyu.mt.module.reward.model.RewardType"
  },
  ["model.RewardResult"] = {
    additionRate = map(string, int),
    amount = int,
    code = int,
    contents = object,
    mail = bool,
    type = "com.eyu.mt.module.reward.model.RewardType"
  },
  ["model.RewardType"] = enum({
    [0] = "EXP",
    [1] = "CURRENCY",
    [2] = "ITEM",
    [3] = "EQUIP",
    [4] = "FRAGMENT",
    [5] = "HERO",
    [6] = "EXP_CARD",
    [7] = "COIN_CARD",
    [8] = "TREASURE",
    [9] = "ACTION_POINT",
    [10] = "VIP_TIME",
    [11] = "BUFF",
    [12] = "LEADERSHIP",
    [13] = "DEMOG_FRAGMENT",
    [14] = "REAL_GOODS",
    [15] = "SOUL_STONE",
    [16] = "TOKEN_COIN",
    [17] = "ARENA_INTEGRAL",
    [18] = "TALISMAN_FRAGMENT",
    [19] = "TALISMAN",
    [20] = "MENPAI_EXP",
    [21] = "EGG_HAMMER",
    [22] = "BOX_KEY",
    [23] = "TREASURE_ROOM_CURRENCY",
    [24] = "JIPING",
    [25] = "MENPAI_MONEY",
    [26] = "SECRETSHOP_CURRENCY",
    [27] = "EQUIPMENT",
    [28] = "EQUIPMENT_FRAGMENT",
    [29] = "EQUIPMENT_MATERIAL",
    [30] = "FOOTBALL",
    [31] = "MOON",
    [32] = "MONOPOLY",
    [33] = "TALISMAN_LIEBI",
    [34] = "SLOT_LOTTERY_TIMES",
    [35] = "SWEET",
    [36] = "CULTIVATE_ELIXIR",
    [37] = "CULTIVATE_MATERIAL",
    [38] = "TURKEY",
    [39] = "EXPLORE_NPC_EXP",
    [40] = "NEW_MONOPOLY",
    [41] = "SPRING"
  }),
  ["reward.RewardTestResult"] = const({REWARD_NOT_EXIST = -1})
}
Singleton(NetMsg):Import(...)
