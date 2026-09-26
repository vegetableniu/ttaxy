local NetMsg = Singleton(NetMsg)
module(...)
NetMsg:Setup(...)
mod = 82
cmd = {
  LOAD_TURKEY = {
    1,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.turkey.model.TurkeyVo"
    }
  },
  BUY_MATERIAL = {
    2,
    {count = int, materialType = int},
    {
      code = int,
      content = "com.eyu.mt.module.cost.model.CostAndReward"
    }
  },
  MAKE_TURKEY = {
    3,
    {count = int},
    {
      code = int,
      content = "com.eyu.mt.module.cost.model.CostAndReward"
    }
  },
  MAKE_TURKEY_BY_CURRENCY = {
    4,
    {count = int},
    {
      code = int,
      content = "com.eyu.mt.module.cost.model.CostAndReward"
    }
  },
  EAT_TURKEY = {
    5,
    {count = int},
    {
      code = int,
      content = "com.eyu.mt.module.turkey.model.EatVo"
    }
  }
}
types = {
  ["facade.TurkeyResult"] = const({
    ERROR_COUNT = -7,
    CURRENCY_IS_NOT_ENOUGH = -6,
    TURKEY_MATERIAL_NOT_EXIST = -5,
    ACTIVITY_IS_NOT_OOPEN = -4,
    MATERIALS_NOT_ENOUGH = -3,
    TURKEY_NOT_ENOUGH = -2,
    TURKEY_OR_MATERIALS_NOT_ENOUGH = -1
  }),
  ["model.EatVo"] = {
    costAndReward = "com.eyu.mt.module.cost.model.CostAndReward",
    records = array("com.eyu.mt.module.turkey.model.TurkeyRewardRecord")
  },
  ["model.TurkeyRewardRecord"] = {
    name = string,
    rewardResults = array("com.eyu.mt.module.turkey.model.TurkeyRewardResult")
  },
  ["model.TurkeyRewardResult"] = {},
  ["model.TurkeyVo"] = {
    materials = map(int, int),
    records = array("com.eyu.mt.module.turkey.model.TurkeyRewardRecord"),
    times = int,
    turkeys = int
  }
}
NetMsg:Import(...)
