local NetMsg = Singleton(NetMsg)
module(...)
NetMsg:Setup(...)
mod = 85
cmd = {
  LOAD_SHOP = {
    1,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.exchangeshop.model.ExchangeshopVo"
    }
  },
  REFRESH = {
    2,
    {currency = bool},
    {
      code = int,
      content = "com.eyu.mt.module.exchangeshop.model.RefreshVo"
    }
  },
  EXCHANGE = {
    3,
    {position = int},
    {
      code = int,
      content = "com.eyu.mt.module.exchangeshop.model.ExchangeVo"
    }
  }
}
types = {
  ["facade.ExchangeshopResult"] = const({
    EXCHANGE_TIMES_LIMIT = -10,
    ACTIVITY_IS_NOT_OPEN = -9,
    CANNOT_USE_COST_ITEM_REFRESH = -8,
    CANNOT_USE_CURRENCY_REFRESH = -7,
    GOOD_IS_EXPIRE = -6,
    COST_REFRESH_TIMES_LIMIT = -5,
    POSITION_TREASURE_HAD_BEEN_GOT = -4,
    NO_RELATIVE_POSITION_TREASURE = -3,
    ACTIVITY_NOT_OPEN = -2,
    CURRENCY_IS_NOT_ENOUGH = -1
  }),
  ["model.ExchangeVo"] = {
    costResults = array("com.eyu.mt.module.cost.model.CostResult"),
    gotTreasures = array(int),
    rewardResults = array("com.eyu.mt.module.reward.model.RewardResult"),
    treasures = map(int, int)
  },
  ["model.ExchangeshopVo"] = {
    exhangeTimes = map(int, int),
    gotTreasures = array(int),
    refreshTimes = int,
    time = date,
    treasures = map(int, int)
  },
  ["model.RefreshVo"] = {
    costResults = array("com.eyu.mt.module.cost.model.CostResult"),
    nextTime = date,
    times = int,
    treasures = map(int, int)
  }
}
NetMsg:Import(...)
