local NetMsg = Singleton(NetMsg)
module(...)
NetMsg:Setup(...)
mod = 28
cmd = {
  EXCHANGE = {
    1,
    {id = int},
    {
      code = int,
      content = "com.eyu.mt.module.cost.model.CostAndReward"
    }
  },
  GET_PROGRESS = {
    2,
    {type = string},
    {
      code = int,
      content = map(string, double)
    }
  }
}
types = {
  ["facade.TargetResult"] = const({
    CURRENCY_CONSUME_NOT_ENOUGH = -4,
    EXCHANGE_LEVEL_LIMIT = -3,
    TARGET_NOT_OPEN = -2,
    ARGUMENT_ILLEGAL = -1
  }),
  ["model.TargetType"] = enum({
    [0] = "BUY_POINT_NUM",
    [1] = "BUY_ENERGY_NUM",
    [2] = "BUY_PVP_NUM",
    [3] = "LOTTERY_NUM",
    [4] = "CONSUME_NUM",
    [5] = "CROSS_BATTLE_NUM",
    [6] = "DEFY_MATCH_NUM",
    [7] = "HERO_RANKUP_NUM",
    [8] = "BUY_NORMAL_SOUL_STONE",
    [9] = "BUY_PRIMARY_SOUL_STONE",
    [10] = "BUY_MIDDLE_SOUL_STONE",
    [11] = "BUY_SENIOR_SOUL_STONE",
    [12] = "DUMPLING",
    [13] = "OPEN_BOX_",
    [14] = "OPEN_BOX_",
    [15] = "OPEN_BOX_",
    [16] = "CURRENCY_COST_TIMES",
    [17] = "FOOTBALL_TIMES",
    [18] = "HERO",
    [19] = "PASS_ELITE_TIMES",
    [20] = "ATTACK_DEMOG_TIMES",
    [21] = "DEMOG_FEAT_NUM",
    [22] = "PVP_CHALLEGE_TIMES",
    [23] = "INJECT_ARTIFACT_TIMES",
    [24] = "MENPAI_PRAY",
    [25] = "TALISMAN_LOOK_FOR",
    [26] = "NEWMONOPOLY_DICE",
    [27] = "NEWMONOPOLY_SPEICAL_DICE"
  })
}
NetMsg:Import(...)
