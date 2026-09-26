local NetMsg = Singleton(NetMsg)
module(...)
NetMsg:Setup(...)
mod = 76
cmd = {
  LOAD_INFO = {
    1,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.cultivate.model.CultivateVo"
    }
  },
  COMPOUND_ELIXIR = {
    2,
    {id = int},
    {
      code = int,
      content = "com.eyu.mt.module.cultivate.model.CompoundElixirVo"
    }
  },
  SWALLOW_ELIXIR = {
    3,
    {
      elixirId = int,
      heroId = long,
      position = int
    },
    {
      code = int,
      content = map(int, int)
    }
  },
  RE_CULTIVATE = {
    4,
    {cost = bool, heroId = long},
    {
      code = int,
      content = "com.eyu.mt.module.cultivate.model.ReCultivateVo"
    }
  },
  HERO_CROSSING = {
    5,
    {
      embattle = array(array(string)),
      heroId = long
    },
    {
      code = int,
      content = "com.eyu.mt.module.cultivate.model.CrossingVo"
    }
  }
}
types = {
  ["facade.CultivateResult"] = const({
    HERO_CROSSING_LIMIT = -16,
    HERO_CULTIVATE_STATE_LIMIT = -15,
    HERO_STAR_IS_NOT_ENOUGH = -14,
    EMBATTLE_IS_NOT_CORRECT = -13,
    THE_HERO_HAD_NOT_SWALLOW_ALL_ELIXIR = -12,
    THE_HERO_CULTIVATE_STATE_HAD_BEEN_MAX = -11,
    HERO_RANK_IS_NOT_ENOUGH = -10,
    CURRENCY_IS_NOT_ENOUGH = -9,
    THE_HERO_HAD_NOT_CULTIVATE = -8,
    ELIXIR_IS_NOT_ENOUGH = -7,
    THE_HERO_POSITION_HAD_SWALLOW_ELIXIR = -6,
    THE_HERO_CAN_NOT_SWALLOW_THIS_ELIXIR_IN_THIS_POSITION = -5,
    HERO_IS_NOT_EXIST = -4,
    MATERIALS_NOT_ENOUGH = -3,
    THE_ELIXIR_CAN_NOT_COMPOUND = -2,
    NOT_RELATIVE_ELIXIR = -1
  }),
  ["model.CompoundElixirVo"] = {
    costResults = array("com.eyu.mt.module.cost.model.CostResult"),
    materials = map(int, int)
  },
  ["model.CrossingVo"] = {
    costResults = array("com.eyu.mt.module.cost.model.CostResult"),
    reports = array(bytearray),
    targetGroupNum = int,
    win = bool
  },
  ["model.CultivateVo"] = {
    elixires = map(int, int),
    materials = map(int, int)
  },
  ["model.HeroCultivateVo"] = {
    alterValues = map(string, object),
    elixirs = map(int, int),
    id = long,
    state = int
  },
  ["model.ReCultivateVo"] = {
    costResults = array("com.eyu.mt.module.cost.model.CostResult"),
    rewardResults = array("com.eyu.mt.module.reward.model.RewardResult")
  }
}
NetMsg:Import(...)
