local NetMsg = Singleton(NetMsg)
module(...)
NetMsg:Setup(...)
mod = 56
cmd = {
  LOAD_ALL_EQUIPS = {
    1,
    {},
    {}
  },
  EQUIP = {
    2,
    {
      hero = long,
      id = long,
      position = int
    },
    {
      code = int,
      content = "com.eyu.mt.module.equip.model.EquipVo"
    }
  },
  COMPOSE = {
    3,
    {baseId = int},
    {
      code = int,
      content = "com.eyu.mt.module.equip.model.ComposeVo"
    }
  },
  MELT = {
    4,
    {
      ids = array(long),
      materials = map("com.eyu.mt.module.equip.model.MaterialType", int)
    },
    {
      code = int,
      content = array("com.eyu.mt.module.reward.model.RewardResult")
    }
  },
  BUY_EQUIP_PACK_SPACE = {
    5,
    {},
    {
      code = int,
      content = array("com.eyu.mt.module.cost.model.CostResult")
    }
  },
  LOAD_EQUIP_PACK = {
    6,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.equip.model.EquipPackSpaceVo"
    }
  },
  UNEQUIP_POSITION = {
    7,
    {
      equipId = long,
      hero = long,
      position = int
    },
    {code = int, content = bool}
  },
  UPGRADE = {
    8,
    {id = long},
    {
      code = int,
      content = "com.eyu.mt.module.equip.model.UpgradeVo"
    }
  },
  BUY_EQUIP_PACK_SPACE_BY_COUPON = {
    9,
    {},
    {
      code = int,
      content = array("com.eyu.mt.module.cost.model.CostResult")
    }
  }
}
types = {
  ["facade.EquipResult"] = const({
    CAN_BE_COMPOSE = -20,
    NO_EQUIP_RELATIVE_EQUIP_OR_POSITION = -19,
    CAN_NOT_MELT_MATERIAL = -18,
    NO_RELATIVE_HERO = -17,
    NO_RELATIVE_EQUIP = -16,
    PACK_EXTEND_COUNT_LIMIT = -15,
    FRAGMENTS_IS_NOT_ENOUGH = -14,
    PLAYER_LEVEL_LIMIT = -13,
    EQUIP_PACK_IS_FULL = -12,
    BASE_EQUIP_IS_NOT_EXSIT = -11,
    CURRENCY_IS_NOT_ENOUGH = -10,
    MATERIAL_IS_NOT_ENOUGH = -9,
    CAN_NOT_UPGRADE = -8,
    UNIT_TYPE_LIMIT = -7,
    EQUIPED_POSITION_LIMIT = -6,
    MAX_EQUIPED = -5,
    EQUIP_OTHER_POSITION = -4,
    OTHER_EQUIPED = -3,
    NONE_EQUIPED = -2,
    ALREADY_EQUIPED = -1
  }),
  ["model.ComposeVo"] = {
    baseid = int,
    fragments = int,
    id = long
  },
  ["model.EquipPackSpaceVo"] = {
    extendCount = int,
    extendLimit = int,
    fragments = map(int, int),
    materials = map(int, int),
    usedSpace = int
  },
  ["model.EquipVo"] = {
    baseId = int,
    equipHero = long,
    id = long,
    owner = long,
    position = int
  },
  ["model.MaterialType"] = enum({
    [0] = "PURPLE",
    [1] = "ORANGE",
    [2] = "RED"
  }),
  ["model.UpgradeVo"] = {
    costResults = array("com.eyu.mt.module.cost.model.CostResult"),
    equipVo = "com.eyu.mt.module.equip.model.EquipVo",
    materials = map("com.eyu.mt.module.equip.model.MaterialType", int)
  }
}
NetMsg:Import(...)
