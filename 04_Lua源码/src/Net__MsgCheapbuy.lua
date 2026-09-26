local NetMsg = Singleton(NetMsg)
module(...)
NetMsg:Setup(...)
mod = 64
cmd = {
  INFO = {
    1,
    {mallId = int},
    {
      code = int,
      content = "com.eyu.mt.module.cheapbuy.model.InfoVo"
    }
  },
  BUY = {
    2,
    {id = int},
    {
      code = int,
      content = "com.eyu.mt.module.cheapbuy.model.BuyVo"
    }
  }
}
types = {
  ["facade.CheapBuyResult"] = const({
    CHARGE_NOT_ENOUGH = -6,
    GOODS_NOT_EXIST = -5,
    LEVEL_ERROR = -4,
    GIFT_ERROR = -3,
    MALL_IS_NOT_OPEN = -2,
    CURRENCY_IS_NOT_ENOUGH = -1
  }),
  ["model.BuyVo"] = {
    costAndReward = "com.eyu.mt.module.cost.model.CostAndReward",
    info = "com.eyu.mt.module.cheapbuy.model.InfoVo"
  },
  ["model.InfoVo"] = {
    buyIds = array(int),
    charge = int,
    id = int
  }
}
NetMsg:Import(...)
