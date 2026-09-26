local NetMsg = Singleton(NetMsg)
module(...)
NetMsg:Setup(...)
mod = 65
cmd = {
  LOAD_EQUIP_GIFT = {
    1,
    {activityId = string},
    {
      code = int,
      content = map(int, "com.eyu.mt.module.equipgift.model.BuyTimesVo")
    }
  },
  BUY_EQUIP_GIFT = {
    2,
    {activityId = string, goodsId = int},
    {
      code = int,
      content = "com.eyu.mt.module.equipgift.model.BuyEquipgiftVo"
    }
  }
}
types = {
  ["facade.EquipgiftResult"] = const({
    ACTIVITY_IS_NOT_OPEN = -4,
    CURRENCY_NOT_ENOUGH = -3,
    BUY_TIMES_LIMIT = -2,
    NO_RELATIVE_GOODS_ID = -1
  }),
  ["model.BuyEquipgiftVo"] = {
    costResults = array("com.eyu.mt.module.cost.model.CostResult"),
    randomRewardResults = array("com.eyu.mt.module.reward.model.RewardResult"),
    rewardResults = array("com.eyu.mt.module.reward.model.RewardResult")
  },
  ["model.BuyTimesVo"] = {times = int, todayTimes = int},
  ["model.ShowType"] = enum({
    [0] = "MALL",
    [1] = "ACTIVITY"
  })
}
NetMsg:Import(...)
