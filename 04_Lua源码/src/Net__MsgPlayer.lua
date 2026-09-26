module(...)
Singleton(NetMsg):Setup(...)
mod = 11
cmd = {
  LOTTERY = {
    1,
    {id = int, time = int},
    {
      code = int,
      content = "com.eyu.mt.module.cost.model.CostAndReward"
    }
  },
  WALLET = {
    2,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.account.model.WalletVo"
    }
  },
  VIP = {
    3,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.vip.model.VipInfo"
    }
  },
  ORDER = {
    4,
    {
      amount = int,
      channel = string,
      goods = string,
      imei = string,
      mac = string,
      version = string
    },
    {
      code = int,
      content = "com.eyu.mt.module.player.model.OrderVo"
    }
  },
  RESETNAME = {
    8,
    {string},
    {code = int, content = int}
  },
  ROULETTE_LOTTERY = {
    9,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.player.model.RouletteLotteryVO"
    }
  },
  ROULETTE_LOTTERY_RESULTS = {
    10,
    {},
    {
      code = int,
      content = array("com.eyu.mt.module.player.model.RecentLotteryResult")
    }
  },
  GET_LOTTERY_LIST = {
    11,
    {},
    {
      code = int,
      content = array("com.eyu.mt.module.player.model.LotteryListVO")
    }
  },
  DAILY_CHECK_INFO = {
    12,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.player.model.DailyCheckVO"
    }
  },
  DAILY_CHECK_IN = {
    13,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.player.model.DailyCheckResultVO"
    }
  },
  GET_BUFFS = {
    14,
    {},
    {
      code = int,
      content = array(string)
    }
  },
  GET_ACTIVITY_MONEY = {
    15,
    {mallId = int},
    {
      code = int,
      content = "com.eyu.mt.module.player.model.ActivityMoneyVo"
    }
  },
  TOKEN_COIN_EXCHANGE = {
    16,
    {id = int, num = int},
    {
      code = int,
      content = "com.eyu.mt.module.player.model.TokenCoinExchangeVO"
    }
  },
  GET_CONSUME_RANK = {
    17,
    {},
    {
      code = int,
      content = array("com.eyu.mt.module.player.model.ConsumeActiveRankVO")
    }
  },
  GET_OPEN_BETA_GOODS_INFO = {
    18,
    {},
    {
      code = int,
      content = map(int, int)
    }
  },
  BUY_OPEN_BETA_GOODS = {
    19,
    {goodsId = int},
    {
      code = int,
      content = "com.eyu.mt.module.player.model.BuyOpenBetaGoodsResultVO"
    }
  },
  EQUIP_LOTTERY = {
    20,
    {
      free = bool,
      id = int,
      time = int
    },
    {
      code = int,
      content = "com.eyu.mt.module.player.model.EquipLotteryVo"
    }
  }
}
types = {
  ["facade.PlayerResult"] = const({
    EXCHANGE_TIMES_LIMIT = -21,
    NOT_FREE_LOTTERY_TIME = -20,
    OPEN_BETA_GOODS_LOCKED = -19,
    OPEN_BETA_GOODS_BUY_NUM_LIMIT = -18,
    ADDTION_INVALID_GOODS = -17,
    CONSUME_ACTIVE_NOT_OPEN = -16,
    TOKEN_COIN_NOT_ENOUGH = -15,
    TOKEN_COIN_ACTIVE_NOT_OPEN = -14,
    TODAY_HAS_CHECKED = -13,
    LOTTERY_INVALID = -12,
    LOTTERY_TIMES_LIMIT = -11,
    ROULETTE_LOTTERY_LEVEL_LIMIT = -10,
    CARD_PACK_FULL = -9,
    BLOCK_BY_LEVEL = -8,
    BLOCK_BY_LOTTERY = -7,
    INVALID_REWARD = -6,
    CLIENT_IS_DRAW = -5,
    HAS_BEEN_SELECT_COUNTRY = -4,
    NOT_ENOUGH_LEVEL = -3,
    BLOCK_BY_EXCHANGE_TIMES = -2,
    ARGUMENT_ILLEGAL = -1
  }),
  ["model.ActivityMoneyVo"] = {
    exchangeTimes = map(int, int),
    tokenCoin = int
  },
  ["model.BuyOpenBetaGoodsResultVO"] = {
    buyGoods = map(int, int),
    costResults = array("com.eyu.mt.module.cost.model.CostResult"),
    fixedRewardResults = array("com.eyu.mt.module.reward.model.RewardResult"),
    randomRewardResults = array("com.eyu.mt.module.reward.model.RewardResult")
  },
  ["model.ConsumeActiveRankVO"] = {
    consume = long,
    id = long,
    leaderBaseId = int,
    leaderLevel = int,
    name = string,
    rank = int
  },
  ["model.DailyCheckResultVO"] = {
    checkedIds = array(int),
    continueDays = int,
    rewardResults = array("com.eyu.mt.module.reward.model.RewardResult"),
    segment = int
  },
  ["model.DailyCheckVO"] = {
    checkedIds = array(int),
    continueDays = int,
    isFirst = bool,
    refreshTime = date,
    segment = int
  },
  ["model.EquipLotteryVo"] = {
    current = int,
    resetDate = date,
    result = "com.eyu.mt.module.cost.model.CostAndReward",
    usedFreeTimes = int
  },
  ["model.LotteryListVO"] = {
    activity = string,
    activityCharge = int,
    baseId = int,
    battle = string,
    cardID = string,
    cardLevel = string,
    cardTip = string,
    cardType = string,
    cooldownHours = int,
    current = int,
    desInPage = string,
    description = string,
    eliteBattle = string,
    endLevel = int,
    endTime = date,
    id = int,
    kind = string,
    level = int,
    limits = int,
    lotteryType = string,
    path = string,
    playerActivityCharge = int,
    prices = string,
    probability = string,
    resetDate = date,
    salePrices = array(int),
    show = bool,
    showTemplete = string,
    sort = int,
    sortType = string,
    startTime = date,
    title = string,
    type = string,
    usedFreeTimes = int,
    vip = bool,
    week = bool,
    weight = int
  },
  ["model.OrderVo"] = {
    addition = string,
    money = int,
    serial = int,
    uniPayOrder = string,
    url = string
  },
  ["model.PlayerState"] = const({IDLE = 0, SINGLE_BATTLE = 1}),
  ["model.PlayerVo"] = {
    baseId = int,
    exp = long,
    id = long,
    leadership = int,
    level = int,
    name = string,
    pvpDesId = int,
    rank = int,
    rename = bool
  },
  ["model.RecentLotteryResult"] = {configId = int, userName = string},
  ["model.RouletteLotteryVO"] = {
    id = int,
    nextLevel = int,
    rewardResults = array("com.eyu.mt.module.reward.model.RewardResult")
  },
  ["model.TokenCoinExchangeVO"] = {
    rewardResult = array("com.eyu.mt.module.reward.model.RewardResult"),
    tokenCoin = int
  },
  ["model.reward.CurrentInfo"] = {exp = long, level = int}
}
Singleton(NetMsg):Import(...)
