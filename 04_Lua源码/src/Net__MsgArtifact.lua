local NetMsg = Singleton(NetMsg)
module(...)
NetMsg:Setup(...)
mod = 45
cmd = {
  ENTER = {
    1,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.artifact.model.BeeEffGeeVo"
    }
  },
  INJECT_SOULSTONE = {
    2,
    {},
    {}
  },
  BUY_INJECT_SOULSTONE = {
    3,
    {},
    {}
  },
  BUY_SOULSTONE = {
    4,
    {id = int},
    {
      code = int,
      content = "com.eyu.mt.module.artifact.model.BuySoulstoneVo"
    }
  },
  GET_RANK_LIST = {
    5,
    {},
    {
      code = int,
      content = array("com.eyu.mt.module.artifact.model.RankVo")
    }
  },
  INJECT_SOUL_ONCE = {
    6,
    {autoBuy = bool},
    {
      code = int,
      content = "com.eyu.mt.module.artifact.model.InjectSoulstoneVo"
    }
  },
  INJECT_SOUL_REPEATEDLY = {
    7,
    {autoBuy = bool},
    {
      code = int,
      content = "com.eyu.mt.module.artifact.model.InjectSoulRepeatedlyVo"
    }
  },
  SOUL_STONE_EXCHANGE = {
    8,
    {id = int},
    {
      code = int,
      content = "com.eyu.mt.module.artifact.model.SoulstoneExchangeVo"
    }
  },
  SOUL_STONE_EXCHANGE_BY_TYPE = {
    9,
    {count = int, id = int},
    {
      code = int,
      content = "com.eyu.mt.module.artifact.model.SoulstoneExchangeVo"
    }
  }
}
types = {
  ["facade.BeeEffGeeResult"] = const({
    EXCHANGE_TIMES_MUST_GREATER_THAN_ZERO = -608,
    SOUL_STONE_EXCHANGE_LIMIT = -607,
    NOT_ENOUGH_SOUL_STONE_REDUCE = -606,
    CURRENCY_NOT_ENOUGH = -605,
    NO_SOULSTONE_PACKAGE = -604,
    NULL_VALUE = -603,
    LESS_THAN_ZERO = -602,
    GREATER_THAN_MAX_LEVEL = -601,
    ALREADY_MAX_LEVEL = -600
  }),
  ["model.BeeEffGeeVo"] = {
    level = int,
    middleSoulStone = int,
    normalSoulStone = int,
    primarySoulStone = int,
    progress = int,
    seniorSoulStone = int
  },
  ["model.BuySoulstoneVo"] = {
    costResults = array("com.eyu.mt.module.cost.model.CostResult"),
    rewardResults = array("com.eyu.mt.module.reward.model.RewardResult")
  },
  ["model.InjectSoulRepeatedlyVo"] = {
    costResult = array("com.eyu.mt.module.cost.model.CostResult"),
    critNum = int,
    haveInjected = int,
    level = int,
    middleSoulStone = int,
    primarySoulStone = int,
    progress = int,
    seniorSoulStone = int,
    soulStoneNumber = int,
    stopType = "com.eyu.mt.module.artifact.model.MultiInjectStopType"
  },
  ["model.InjectSoulstoneVo"] = {
    costResult = array("com.eyu.mt.module.cost.model.CostResult"),
    critNum = int,
    level = int,
    number = int,
    progress = int,
    stoneType = "com.eyu.mt.module.artifact.model.SoulStoneType"
  },
  ["model.MultiInjectStopType"] = enum({
    [0] = "MAX_LEVEL",
    [1] = "NO_ENOUGH_CURRENCY",
    [2] = "SUCCESS",
    [3] = "NO_ENOUGH_SOUL_STONE"
  }),
  ["model.RankVo"] = {
    baseId = int,
    id = long,
    level = int,
    name = string,
    palyerLevel = int,
    progress = int,
    rank = int,
    time = long
  },
  ["model.SoulStoneType"] = enum({
    [0] = "NORMAL",
    [1] = "PRIMARY",
    [2] = "MIDDLE",
    [3] = "SENIOR"
  }),
  ["model.SoulstoneExchangeVo"] = {
    cost = int,
    costType = "com.eyu.mt.module.artifact.model.SoulStoneType",
    rewardResults = array("com.eyu.mt.module.reward.model.RewardResult")
  }
}
NetMsg:Import(...)
