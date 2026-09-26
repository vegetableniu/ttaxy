local NetMsg = Singleton(NetMsg)
module(...)
NetMsg:Setup(...)
mod = 14
cmd = {
  INFO = {
    1,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.treasure.model.TreasurePackVo"
    }
  },
  LOOKFOR = {
    2,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.treasure.model.LookForResult"
    }
  },
  AUTO_LOOKFOR = {
    3,
    {},
    {
      code = int,
      content = array("com.eyu.mt.module.treasure.model.LookForResult")
    }
  },
  RECEIVE = {
    4,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.treasure.model.ReceiveResult"
    }
  }
}
types = {
  ["facade.TreasureResult"] = const({
    HERO_PACK_FULL = -4,
    MUST_VIP = -3,
    TREASURE_PACK_EMPTY = -2,
    TREASURE_PACK_FULL = -1
  }),
  ["model.LookForResult"] = {
    costs = array("com.eyu.mt.module.cost.model.CostResult"),
    rank = int,
    treasures = array(int)
  },
  ["model.ReceiveResult"] = {
    rewards = array("com.eyu.mt.module.reward.model.RewardResult"),
    solds = int
  },
  ["model.TreasurePackVo"] = {
    rank = int,
    treasures = array(int)
  }
}
NetMsg:Import(...)
