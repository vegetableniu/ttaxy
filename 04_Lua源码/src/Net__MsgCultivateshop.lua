local NetMsg = Singleton(NetMsg)
module(...)
NetMsg:Setup(...)
mod = 81
cmd = {
  GET_INFO = {
    1,
    {int},
    {
      code = int,
      content = "com.eyu.mt.module.cultivateshop.model.CultivateShopVo"
    }
  },
  COST_REFRESH = {
    2,
    {int},
    {
      code = int,
      content = "com.eyu.mt.module.cultivateshop.model.ShopCostRefreshVo"
    }
  },
  SHOP_EXCHANGE = {
    3,
    {
      floor = int,
      itemId = int,
      position = int
    },
    {
      code = int,
      content = "com.eyu.mt.module.cultivateshop.model.ItemExchangeVo"
    }
  }
}
types = {
  ["facade.CultivateShopResult"] = const({
    BUY_REFRESH_TIMES_LIMIT = -6,
    COST_NOT_ENOUGH = -5,
    ITEM_HAS_EXCHENGED = -4,
    ITEM_NOT_FOUND = -3,
    ON_LINE_IS_EXPIRE = -2,
    ACTIVITY_NOT_OPEN = -1
  }),
  ["model.CultivateShopVo"] = {
    autoRefreshDate = date,
    costRefreshTimes = int,
    exchanges = array(int),
    onItems = map(int, int)
  },
  ["model.ItemExchangeVo"] = {
    autoRefreshDate = date,
    costResults = array("com.eyu.mt.module.cost.model.CostResult"),
    exchanges = array(int),
    onItems = map(int, int),
    rewardResults = array("com.eyu.mt.module.reward.model.RewardResult")
  },
  ["model.ShopCostRefreshVo"] = {
    costRefreshTimes = int,
    costResults = array("com.eyu.mt.module.cost.model.CostResult"),
    exchanges = array(int),
    onItems = map(int, int)
  }
}
NetMsg:Import(...)
