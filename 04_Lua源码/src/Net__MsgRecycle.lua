local NetMsg = Singleton(NetMsg)
module(...)
NetMsg:Setup(...)
mod = 84
cmd = {
  RECYCLE = {
    1,
    {
      cost = bool,
      recycleThings = "com.eyu.mt.module.recycle.model.RecycleThings"
    },
    {
      code = int,
      content = "com.eyu.mt.module.cost.model.CostAndReward"
    }
  }
}
types = {
  ["facade.RecycleResult"] = const({
    HERO_IS_IN_USE = -13,
    ACTIVITY_IS_NOT_OPEN = -12,
    PLEASE_SELECT_THINGS_TO_RECYCLE = -11,
    CURRENCY_IS_NNOT_ENOUGH = -10,
    EQUIP_IS_EQUIPED = -9,
    EQUIP_NOT_FOUND = -8,
    TALISMAN_IS_EQUIPED = -7,
    TALISMAN_NOT_FOUND = -6,
    CAN_NOT_RECYCLE = -5,
    HERO_LOCKED = -4,
    HERO_IN_GROUP = -3,
    HERO_NOT_FOUND = -2,
    REPEAT_ID = -1
  }),
  ["model.RecycleCurrencyType"] = enum({
    [0] = "PURPLE",
    [1] = "ORANGE"
  }),
  ["model.RecycleThings"] = {
    equipIds = array(long),
    heroIds = array(long),
    talismanIds = array(long)
  },
  ["model.RecycleType"] = enum({
    [0] = "CARD_TYPE",
    [1] = "HERO_ID",
    [2] = "TALISMAN_ID",
    [3] = "EQUIP_ID"
  })
}
NetMsg:Import(...)
