local NetMsg = Singleton(NetMsg)
module(...)
NetMsg:Setup(...)
mod = 87
cmd = {
  LOAD_NEWMONOPOLY = {
    1,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.newmonopoly.model.NewMonopolyVo"
    }
  },
  CAST_DICE = {
    2,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.newmonopoly.model.CastDiceVo"
    }
  },
  COST_CAST_DICE = {
    3,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.newmonopoly.model.CastDiceVo"
    }
  },
  CAST_SPEICAL_DICE = {
    4,
    {int},
    {
      code = int,
      content = "com.eyu.mt.module.newmonopoly.model.CastDiceVo"
    }
  },
  COST_CAST_SPEICAL_DICE = {
    5,
    {int},
    {
      code = int,
      content = "com.eyu.mt.module.newmonopoly.model.CastDiceVo"
    }
  },
  ACCEPT_TASK = {
    6,
    {int},
    {
      code = int,
      content = "com.eyu.mt.module.newmonopoly.model.MonopolyTaskVo"
    }
  },
  GIVE_UP_TASK = {
    7,
    {int},
    {
      code = int,
      content = "com.eyu.mt.module.newmonopoly.model.MonopolyTaskVo"
    }
  },
  COMPLETE_TASK = {
    8,
    {int},
    {
      code = int,
      content = "com.eyu.mt.module.newmonopoly.model.MonopolyTaskVo"
    }
  },
  DRAW_TASK_REWARD = {
    9,
    {int},
    {
      code = int,
      content = "com.eyu.mt.module.newmonopoly.model.MonopolyTaskVo"
    }
  },
  BUG_GOODS = {
    10,
    {cost = bool, goodsId = int},
    {
      code = int,
      content = "com.eyu.mt.module.newmonopoly.model.BuyGoodsVo"
    }
  },
  SELECT_ROUTE = {
    11,
    {bool},
    {code = int, content = int}
  },
  SELECT_SUBSTITUE = {
    12,
    {cost = bool, substitute = bool},
    {
      code = int,
      content = "com.eyu.mt.module.newmonopoly.model.SelectSubstitueVo"
    }
  },
  DRAW_BOX_REWARD = {
    13,
    {int},
    {
      code = int,
      content = "com.eyu.mt.module.newmonopoly.model.DrawBoxRewardVo"
    }
  }
}
types = {
  ["facade.NewMonopolyResult"] = const({
    CAST_SPEICAL_DICE_VAIN = -26,
    MONOPOLY_SUBSTITUE_NOT_ENOUGH = -25,
    FLOOR_ON_FORK = -24,
    COST_CAST_NOT_NEED = -23,
    BUFF_NOT_EXIST = -22,
    DAILY_RESET = -21,
    RINGS_BOX_CAN_NOT_DRAW = -19,
    RINGS_BOX_NOT_FOUND = -18,
    RINGS_BOX_HAD_DRAW = -17,
    POSITION_NOT_FORK_START = -16,
    FLOOR_IS_NOT_FORK = -15,
    MONOPOLY_CURRENCY_NOT_ENOUGH = -14,
    BUY_GOODS_TIME_LIMIT = -13,
    GOODS_NOT_FOUND = -12,
    TASK_NOT_COMPLETED = -11,
    TASK_NOT_ACCEPTED = -10,
    TASK_HAS_COMPLETED = -9,
    TASK_HAS_GOT_REWARDED = -8,
    TASK_HAS_ACCEPTED = -7,
    TASK_ACCEPT_AMOUNT_LIMIT = -6,
    TASK_NOT_FOUND = -5,
    COST_NOT_ENOUGH = -4,
    CAST_DICE_LIMIT = -3,
    CAST_DICE_TIME_LIMIT = -2,
    ACTIVITY_NOT_OPEN = -1
  }),
  ["model.BuyGoodsVo"] = {
    boughtGoods = map(int, int),
    costResults = array("com.eyu.mt.module.cost.model.CostResult"),
    currency = int,
    rewardResults = array("com.eyu.mt.module.reward.model.RewardResult")
  },
  ["model.CastDiceVo"] = {
    actStep = int,
    costResults = array("com.eyu.mt.module.cost.model.CostResult"),
    forkSnares = array(int),
    newMonopolyVo = "com.eyu.mt.module.newmonopoly.model.NewMonopolyVo",
    rewardResults = array("com.eyu.mt.module.reward.model.RewardResult"),
    snares = array(int),
    steps = array(int)
  },
  ["model.DrawBoxRewardVo"] = {
    drewBoxs = array(int),
    rewardResults = array("com.eyu.mt.module.reward.model.RewardResult")
  },
  ["model.MonopolyFloor"] = {
    drewBoxs = array(int),
    fork = bool,
    forkPositions = map(int, int),
    forkpos = int,
    goldForkPositions = array(int),
    goldPositions = array(int),
    goneForkPositions = array(int),
    gonePositions = array(int),
    pos = int,
    positions = map(int, int),
    rings = int
  },
  ["model.MonopolyTaskVo"] = {
    costResults = array("com.eyu.mt.module.cost.model.CostResult"),
    rewardResults = array("com.eyu.mt.module.reward.model.RewardResult"),
    stepCompleted = bool,
    taskProgress = map(int, double),
    tasks = array(int)
  },
  ["model.NewMonopolyRewardRecord"] = {
    content = string,
    name = string,
    rewardResults = array("com.eyu.mt.module.newmonopoly.model.NewMonopolyRewardResult")
  },
  ["model.NewMonopolyRewardResult"] = {},
  ["model.NewMonopolyVo"] = {
    boughtGoods = map(int, int),
    buffTimes = int,
    cast = int,
    costCast = int,
    costSpecialCast = int,
    costSubstitute = int,
    currBuff = string,
    currFloor = string,
    currency = int,
    floors = map(string, "com.eyu.mt.module.newmonopoly.model.MonopolyFloor"),
    goodsItems = array(int),
    records = array("com.eyu.mt.module.newmonopoly.model.NewMonopolyRewardRecord"),
    rewardTasks = array(int),
    specialCast = int,
    stepCompleted = bool,
    substitute = int,
    taskProgress = map(int, double),
    tasks = array(int)
  },
  ["model.PositionActionType"] = enum({
    [0] = "TASK",
    [1] = "SILVER_BOX",
    [2] = "SHOP",
    [3] = "DICE",
    [4] = "SPECIAL_DICE",
    [5] = "TRANSFER",
    [6] = "BUFF",
    [7] = "CROSSING",
    [8] = "SNARE"
  }),
  ["model.PositionBuffType"] = enum({
    [0] = "HOVER",
    [1] = "LOSE",
    [2] = "SLOW",
    [3] = "FAST",
    [4] = "TOXICOSIS",
    [5] = "LUCKY",
    [6] = "GOSSIP",
    [7] = "REDOUBLE_DICE",
    [8] = "DOUBLE_REWARD",
    [9] = "RAMDOM"
  }),
  ["model.SelectSubstitueVo"] = {
    buffTimes = int,
    costResults = array("com.eyu.mt.module.cost.model.CostResult"),
    costSubstitute = int,
    currBuff = string,
    stepCompleted = bool,
    substitute = int
  }
}
NetMsg:Import(...)
