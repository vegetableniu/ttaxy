local NetMsg = Singleton(NetMsg)
module(...)
NetMsg:Setup(...)
mod = 79
cmd = {
  GET_INFO = {
    1,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.sweethouse.model.SweetHouseVo"
    }
  },
  COST_REFRESH = {
    2,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.sweethouse.model.CostRefreshVo"
    }
  },
  SWEET_EXCHANGE = {
    3,
    {itemId = int, position = int},
    {
      code = int,
      content = "com.eyu.mt.module.sweethouse.model.SweetExchangeVo"
    }
  }
}
types = {
  ["facade.SweetHouseResult"] = const({
    COST_NOT_ENOUGH = -7,
    ITEM_HAS_EXCHENGED = -6,
    ITEM_NOT_FOUND = -5,
    ON_LINE_IS_EXPIRE = -4,
    SWEET_NOT_ENOUGH = -3,
    SWEET_INVALID_TYPE = -2,
    ACTIVITY_NOT_OPEN = -1
  }),
  ["model.CostRefreshVo"] = {
    authoRefreshDate = date,
    costRefreshTimes = int,
    costResults = array("com.eyu.mt.module.cost.model.CostResult"),
    exchange = array(int),
    onItems = map(int, int)
  },
  ["model.SweetExchangeVo"] = {
    costResults = array("com.eyu.mt.module.cost.model.CostResult"),
    exchange = array(int),
    onItems = map(int, int),
    rewardResults = array("com.eyu.mt.module.reward.model.RewardResult"),
    sweets = map(int, int)
  },
  ["model.SweetHouseVo"] = {
    authoRefreshDate = date,
    costRefreshTimes = int,
    exchange = array(int),
    onItems = map(int, int),
    sweets = map(int, int)
  }
}
NetMsg:Import(...)
