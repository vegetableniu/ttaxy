local NetMsg = Singleton(NetMsg)
module(...)
NetMsg:Setup(...)
mod = 74
cmd = {
  MOON_INFO = {
    1,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.moon.model.MoonVo"
    }
  },
  COMPOSE_MOON = {
    2,
    {count = int},
    {
      code = int,
      content = "com.eyu.mt.module.moon.model.MoonComposeVo"
    }
  },
  BUY_MOON = {
    3,
    {count = int, type = int},
    {
      code = int,
      content = "com.eyu.mt.module.moon.model.BuyMoonResultVo"
    }
  },
  EXHCNAGE = {
    4,
    {group = int},
    {
      code = int,
      content = "com.eyu.mt.module.moon.model.MoonExchangeVo"
    }
  }
}
types = {
  ["facade.MoonResult"] = const({
    ACTIVITY_NOT_OPEN = -6,
    EXCHANGE_COST_NOT_ENOUGH = -5,
    EXCHANGE_GOODS_NOT_FOUND = -4,
    CURRENCY_NOT_ENOUGH = -3,
    MATERIAL_NOT_ENOUGH = -2,
    PARAM_ERROR = -1
  }),
  ["model.BuyMoonResultVo"] = {
    costs = array("com.eyu.mt.module.cost.model.CostResult"),
    curCount = map("com.eyu.mt.module.moon.model.MoonType", int)
  },
  ["model.ExchangePostVo"] = {
    name = string,
    rewards = array("com.eyu.mt.module.moon.model.MoonRewardResult")
  },
  ["model.MoonComposeVo"] = {
    composeCount = int,
    curCount = map("com.eyu.mt.module.moon.model.MoonType", int)
  },
  ["model.MoonExchangeVo"] = {
    costResults = array("com.eyu.mt.module.cost.model.CostResult"),
    curCount = map("com.eyu.mt.module.moon.model.MoonType", int),
    rewardResults = array("com.eyu.mt.module.reward.model.RewardResult")
  },
  ["model.MoonRewardResult"] = {},
  ["model.MoonType"] = enum({
    [0] = "MOON",
    [1] = "HUA",
    [2] = "HAO",
    [3] = "YUE",
    [4] = "YUAN"
  }),
  ["model.MoonVo"] = {
    count = map("com.eyu.mt.module.moon.model.MoonType", int),
    post = array("com.eyu.mt.module.moon.model.ExchangePostVo")
  }
}
NetMsg:Import(...)
