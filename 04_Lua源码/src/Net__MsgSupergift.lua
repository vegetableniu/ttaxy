local NetMsg = Singleton(NetMsg)
module(...)
NetMsg:Setup(...)
mod = 67
cmd = {
  GET_INFO = {
    1,
    {int},
    {
      code = int,
      content = array("com.eyu.mt.module.supergift.model.SuperGiftVo")
    }
  },
  BUY_GOODS = {
    2,
    {goodsId = int, mallId = int},
    {
      code = int,
      content = "com.eyu.mt.module.supergift.model.BuyResult"
    }
  }
}
types = {
  ["facade.SuperGiftResult"] = const({
    USER_LEVEL_ERROR = -7,
    CURRENCY_NOT_ENOUGH = -6,
    SELL_OUT = -5,
    BUY_LIMIT = -4,
    NOT_ON_SELL = -3,
    GOODS_CONFIGE_WRONG = -2,
    MALL_CLOSED = -1
  }),
  ["model.BuyResult"] = {
    costAndReward = "com.eyu.mt.module.cost.model.CostAndReward",
    showList = array("com.eyu.mt.module.supergift.model.SuperGiftVo")
  },
  ["model.SuperGiftVo"] = {
    buyCount = int,
    id = int,
    totalLeft = int
  }
}
NetMsg:Import(...)
