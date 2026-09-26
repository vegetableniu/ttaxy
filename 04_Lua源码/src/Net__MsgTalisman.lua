module(...)
Singleton(NetMsg):Setup(...)
mod = 49
cmd = {
  LOAD_ALL_HERO_TALISMAN = {
    1,
    {},
    {
      code = int,
      content = array("com.eyu.mt.module.talisman.model.HeroTalismanVo")
    }
  },
  LOAD_ALL_TALISMAN = {
    2,
    {},
    {
      code = int,
      content = array("com.eyu.mt.module.talisman.model.TalismanVo")
    }
  },
  EQUIP_TALISMAN = {
    3,
    {
      heroId = long,
      talismanIds = array(long)
    },
    {
      code = int,
      content = array(long)
    }
  },
  UNEQUIP_TALISMAN = {
    4,
    {
      heroId = long,
      talismanIds = array(long)
    },
    {
      code = int,
      content = array(long)
    }
  },
  EXCHANGE_TALISMAN = {
    5,
    {id = int},
    {
      code = int,
      content = "com.eyu.mt.module.talisman.model.ExchangeVO"
    }
  },
  LOAD_TALISMAN = {
    6,
    {id = long},
    {
      code = int,
      content = "com.eyu.mt.module.talisman.model.TalismanVo"
    }
  },
  UPGRADE_TALISMAN = {
    7,
    {
      talismanId = long,
      talismanIds = array(long)
    },
    {
      code = int,
      content = "com.eyu.mt.module.talisman.model.TalismanVo"
    }
  },
  GET_FRAGMENT = {
    8,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.talisman.model.TalismanPackVo"
    }
  },
  CELL_TALISMAN = {
    9,
    {
      talismanIds = array(long)
    },
    {
      code = int,
      content = array("com.eyu.mt.module.reward.model.RewardResult")
    }
  },
  GET_TALISMAN_TMP_PACK_INFO = {
    10,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.talisman.model.TalismanTmpPackVo"
    }
  },
  LOOKFOR = {
    11,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.talisman.model.LookForResult"
    }
  },
  AUTO_LOOKFOR = {
    12,
    {},
    {
      code = int,
      content = array("com.eyu.mt.module.talisman.model.LookForResult")
    }
  },
  RECEIVE = {
    13,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.talisman.model.ReceiveResult"
    }
  },
  OPEN_DRAGON_KING = {
    14,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.talisman.model.OpenDragonKingVo"
    }
  },
  BUY_TALISMAN_PACK_SPACE = {
    15,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.talisman.model.BuyTalismanPackSpaceVo"
    }
  },
  GET_GAINED_REWARDS = {
    16,
    {},
    {
      code = int,
      content = map(string, array(string))
    }
  },
  GAIN_REWARD = {
    17,
    {activityType = string, goalRewardId = string},
    {
      code = int,
      content = array("com.eyu.mt.module.reward.model.RewardResult")
    }
  },
  REPLACE_HERO_TALISMANS = {
    18,
    {
      heroId = long,
      talismanIds = array(long)
    },
    {
      code = int,
      content = array(long)
    }
  },
  BUY_TALISMAN_PACK_SPACE_BY_COUPON = {
    19,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.talisman.model.BuyTalismanPackSpaceVo"
    }
  },
  CONVERT_TALISMAN = {
    20,
    {
      talismanId = long,
      talismanIds = array(long)
    },
    {
      code = int,
      content = "com.eyu.mt.module.talisman.model.TalismanVo"
    }
  },
  ADVANCE_TALISMAN = {
    21,
    {
      talismanId = long,
      talismanIds = array(long)
    },
    {
      code = int,
      content = "com.eyu.mt.module.talisman.model.TalismanVo"
    }
  },
  ADVANCE_SWALLOW_TALISMAN = {
    22,
    {
      talismanId = long,
      talismanIds = array(long)
    },
    {
      code = int,
      content = "com.eyu.mt.module.talisman.model.TalismanVo"
    }
  }
}
types = {
  ["facade.TalismanResult"] = const({
    HERO_STAR_IS_NOT_REACH_CONDITION = -34,
    ALREADY_GAIN_THE_REWARD = -33,
    NOT_REACH_THE_CONDITION = -32,
    GOALREWARD_IS_NOT_EXIST = -31,
    ACTIVITY_IS_NOT_OPEN = -30,
    NO_RELATIVE_HERO = -29,
    NOT_FOUNT_PLAYER_LEVEL_SECTION = -28,
    NOT_REACH_THE_CHARGE_CONDITION = -27,
    CAN_NOT_BEEN_SWALLOW = -26,
    MORE_THAN_MAX_UPGRADE_MATERIAL_COUNT = -25,
    EXIST_MUTUAL_RACE = -24,
    PLAYER_LEVEL_IS_NOT_REACH_CONDITION = -23,
    TALISMAN_IS_NOT_CAN_BE_EUQIPED = -22,
    TALISMAN_LEVEL_IS_NOT_ALLOW_TO_BE_EUQIPED = -21,
    BUY_TALISMAN_PACK_CAPACITY_TIMES_IS_MAX = -20,
    ERROR_VALUE = -19,
    TALISMAN_PACK_CAPACITY_IS_NOT_ENOUGH = -18,
    CURRENCY_NOT_ENOUGH = -17,
    TALISMAN_TMP_PACK_EMPTY = -16,
    TALISMAN_TMP_PACK_FULL = -15,
    MUST_VIP = -14,
    ALREADY_MAX_LEVEL = -13,
    TALISMAN_PACK_IS_USED_UP = -12,
    EXCHANGE_CHARGE_LIMIT = -11,
    EXCHANGE_LEVEL_LIMIT = -10,
    FRAGMENT_NOT_ENOUGH = -9,
    NO_RELATIVE_TALISMAN = -8,
    UNIT_TYPE_NOT_MATCH = -7,
    OTHER_EQUIPED = -6,
    NONE_EQUIPED = -5,
    ALREADY_EQUIPED = -4,
    MAX_EQUIPED_COUNT = -3,
    GREATER_THAN_MAX_LEVEL = -2,
    LESS_THAN_ZERO = -1
  }),
  ["model.BuyTalismanPackSpaceVo"] = {
    extendLimit = int,
    vcoinCost = array("com.eyu.mt.module.cost.model.CostResult")
  },
  ["model.ExchangeVO"] = {
    fragment = int,
    liebi = int,
    rewardResult = array("com.eyu.mt.module.reward.model.RewardResult")
  },
  ["model.HeroTalismanVo"] = {
    baseId = int,
    id = long,
    talismanVos = array("com.eyu.mt.module.talisman.model.TalismanVo")
  },
  ["model.LookForResult"] = {
    costs = array("com.eyu.mt.module.cost.model.CostResult"),
    rank = int,
    treasures = array(int)
  },
  ["model.OpenDragonKingVo"] = {
    rank = int,
    vcoinCost = array("com.eyu.mt.module.cost.model.CostResult")
  },
  ["model.ReceiveResult"] = {
    rewards = array("com.eyu.mt.module.reward.model.RewardResult"),
    solds = int
  },
  ["model.TalismanCostType"] = enum({
    [0] = "FRAGMENT",
    [1] = "LIEBI"
  }),
  ["model.TalismanPackVo"] = {
    extendLimit = int,
    fragment = int,
    id = long,
    liebi = int,
    used = int
  },
  ["model.TalismanTmpPackVo"] = {
    openDragonCount = int,
    rank = int,
    treasures = array(int)
  },
  ["model.TalismanVo"] = {
    baseId = int,
    equipHero = long,
    exp = int,
    id = long,
    level = int,
    advanceProgress = int
  }
}
Singleton(NetMsg):Import(...)
