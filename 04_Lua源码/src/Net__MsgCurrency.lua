local NetMsg = Singleton(NetMsg)
module(...)
NetMsg:Setup(...)
types = {
  ["facade.CurrencyResult"] = const({
    EXCHANGE_NOT_ENOUGH = -108,
    HONOUR_NOT_ENOUGH = -107,
    DONATE_NOT_ENOUGH = -106,
    CURRENCY_NOT_ENOUGH = -105,
    JADE_NOT_ENOUGH = -104,
    INTER_NOT_ENOUGH = -103,
    GIFT_NOT_ENOUGH = -102,
    GOLD_NOT_ENOUGH = -101,
    COPPER_NOT_ENOUGH = -100
  }),
  ["model.Currency"] = {
    alter = int,
    current = int,
    type = "com.eyu.mt.module.currency.model.CurrencyType"
  },
  ["model.CurrencyType"] = enum({
    [0] = "COPPER",
    [1] = "GOLD",
    [2] = "GIFT",
    [3] = "INTER",
    [4] = "EXCHANGE",
    [5] = "FRIENDSHIP",
    [6] = "FRAGMENT",
    [7] = "STONE",
    [8] = "CONSUME",
    [9] = "COUPON",
    [10] = "PURPLE",
    [11] = "ORANGE",
    [12] = "EXPLOIT"
  })
}
NetMsg:Import(...)
