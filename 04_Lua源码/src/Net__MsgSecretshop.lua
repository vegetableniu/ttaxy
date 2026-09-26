local NetMsg = Singleton(NetMsg)
module(...)
NetMsg:Setup(...)
mod = 57
cmd = {
  LOAD_SECRETSHOP = {
    1,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.secretshop.model.SecretshopVo"
    }
  },
  REFRESH = {
    2,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.secretshop.model.RefreshVo"
    }
  },
  EXCHANGE = {
    3,
    {position = int},
    {
      code = int,
      content = "com.eyu.mt.module.secretshop.model.ExchangeVo"
    }
  }
}
types = {
  ["facade.SecretshopResult"] = const({
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
    roomCurrency = int,
    treasures = map(int, int)
  },
  ["model.RefreshVo"] = {
    costResults = array("com.eyu.mt.module.cost.model.CostResult"),
    currency = int,
    nextTime = date,
    times = int,
    treasures = map(int, int)
  },
  ["model.SecretshopVo"] = {
    currency = int,
    gotTreasures = array(int),
    refreshTimes = int,
    time = date,
    treasures = map(int, int)
  }
}
NetMsg:Import(...)
