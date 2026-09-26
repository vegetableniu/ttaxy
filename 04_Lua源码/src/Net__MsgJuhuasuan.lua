local NetMsg = Singleton(NetMsg)
module(...)
NetMsg:Setup(...)
mod = 63
cmd = {
  GET_INFO = {
    1,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.juhuasuan.model.JuhuansuanVo"
    }
  },
  BUY_GOODS = {
    2,
    {goodsId = string},
    {
      code = int,
      content = "com.eyu.mt.module.cost.model.CostAndReward"
    }
  }
}
types = {
  ["facade.JuhuasuanResult"] = const({
    GOODS_VERSION_WRONG = -5,
    GOODS_QUALIFICATION = -4,
    GOODS_ALREADY_BUY = -3,
    CURRENCY_NOT_ENCOUGH = -2,
    ACTIVITY_CLOSED = -1
  }),
  ["model.JuhuansuanVo"] = {
    buyedRecords = array(string),
    canBuy = array(string),
    canShow = array(string)
  }
}
NetMsg:Import(...)
