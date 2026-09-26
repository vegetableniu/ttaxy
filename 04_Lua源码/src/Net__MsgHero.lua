local NetMsg = Singleton(NetMsg)
module(...)
NetMsg:Setup(...)
mod = 13
cmd = {
  ALL_HEROS = {
    1,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.hero.model.HeroPackVo"
    }
  },
  HERO_CURRENT = {
    2,
    {
      groupId = int,
      heros = array(long)
    },
    {
      code = int,
      content = array(array(long))
    }
  },
  EMBATTLE = {
    3,
    {
      src = array(int),
      tar = array(int)
    },
    {code = int, content = int}
  },
  SWALLOW = {
    4,
    {
      src = long,
      tar = array(long)
    },
    {
      code = int,
      content = "com.eyu.mt.module.hero.model.HeroGrowVo"
    }
  },
  RANK_UP = {
    5,
    {
      src = long,
      tar = array(long)
    },
    {
      code = int,
      content = "com.eyu.mt.module.hero.model.HeroGrowVo"
    }
  },
  BUY_PACK = {
    6,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.hero.model.BuyPackVo"
    }
  },
  SELL_HERO = {
    7,
    {
      tar = array(long)
    },
    {
      code = int,
      content = "com.eyu.mt.module.cost.model.CostAndReward"
    }
  },
  CHANGE_LEADER = {
    8,
    {groupId = int, src = long},
    {
      code = int,
      content = array(array(long))
    }
  },
  CRUSH_HERO = {
    9,
    {
      tar = array(long)
    },
    {
      code = int,
      content = "com.eyu.mt.module.cost.model.CostAndReward"
    }
  },
  LOCK = {
    10,
    {lock = bool, src = long},
    {code = int, content = int}
  },
  SKILL_UP = {
    11,
    {
      src = long,
      tar = array(long)
    },
    {
      code = int,
      content = "com.eyu.mt.module.hero.model.HeroGrowVo"
    }
  },
  CURRENT_SCORE = {
    12,
    {},
    {
      code = int,
      content = array(int)
    }
  },
  HERO_GROUPS = {
    13,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.hero.model.HeroGroupInfoVo"
    }
  },
  SWITCH_HERO_GROUP = {
    14,
    {groupId = int},
    {code = int, content = long}
  },
  EMBATTLE_GROUP = {
    15,
    {
      embattle = array(array(long)),
      groupId = int
    },
    {code = int, content = int}
  },
  RANK_UP_BY_GOLD = {
    16,
    {src = long},
    {
      code = int,
      content = "com.eyu.mt.module.hero.model.HeroGrowVo"
    }
  },
  SPLIT_HERO = {
    17,
    {tar = long},
    {
      code = int,
      content = "com.eyu.mt.module.cost.model.CostAndReward"
    }
  },
  BUY_PACK_BY_COUPON = {
    18,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.hero.model.BuyPackVo"
    }
  },
  GET_RED_CARD_EXCHANGE_INFO = {
    19,
    {},
    {
      code = int,
      content = map(int, int)
    }
  },
  RED_CARD_EXCHANGE = {
    20,
    {
      configId = int,
      costHeroIds = array(long)
    },
    {
      code = int,
      content = "com.eyu.mt.module.hero.model.RedCardExchangeVo"
    }
  },
  SWITCH_GROUP = {
    21,
    {},
    {code = int, content = bool}
  },
  UPDATE_TEAM = {
    22,
    {
      leaders = array(long),
      name = string,
      teams = array(array(array(long)))
    },
    {code = int, content = int}
  },
  USE_TEAM = {
    23,
    {
      name = string,
      teamEquipInfos = array("com.eyu.mt.module.hero.model.TeamEquipInfo"),
      teamTalismanInfos = array("com.eyu.mt.module.hero.model.TeamTalismanInfo")
    },
    {code = int, content = int}
  },
  UPDATE_TEAM_NAME = {
    24,
    {newName = string, oldName = string},
    {code = int, content = int}
  },
  GET_TEAM_INFO = {
    25,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.hero.model.TeamInfoVo"
    }
  },
  COST_RANK_UP = {
    26,
    {
      configId = int,
      heroIds = array(long)
    },
    {
      code = int,
      content = "com.eyu.mt.module.cost.model.CostAndReward"
    }
  }
}
types = {
  ["facade.HeroResult"] = const({
    ERROR_MATERIALS = -70,
    NOT_ENOUGHT_COSTITEM = -69,
    NO_HERO_COST_RANK_UP_CONFIG = -68,
    TEAM_NAME_LENGTH_LIMIT = -67,
    EQUIPED_POSITION_LIMIT = -66,
    NO_RELATIVE_EQUIP = -65,
    OTHER_EQUIPED = -64,
    EXIST_MUTUAL_RACE = -63,
    UNIT_TYPE_NOT_MATCH = -62,
    TALISMAN_LEVEL_IS_NOT_ALLOW_TO_BE_EUQIPED = -61,
    PLAYER_LEVEL_IS_NOT_REACH_CONDITION = -60,
    HERO_STAR_IS_NOT_REACH_CONDITION = -59,
    TALISMAN_IS_NOT_CAN_BE_EUQIPED = -58,
    NO_RELATIVE_TALISMAN = -57,
    MAX_EQUIPED_COUNT = -56,
    EQUIP_TWO_PLACE = -55,
    HERO_NOT_IN_EMBATTLE = -54,
    ERROR_PARAMETER = -53,
    TEAM_LEADER_NOT_EXIST = -52,
    TEAM_NOT_EXIST = -51,
    ONLY_HERO_CARD_CAN_BEEN_IN_EMBATTLE = -50,
    TEAM_NAME_REPEAT = -49,
    REPEAT_FRIEDN_POSITION = -48,
    REPEAT_HERO = -47,
    MUST_SET_FRIEND_POSITION = -46,
    ERROR_GROUP_LEADER = -45,
    ERROR_EMBATTLES = -44,
    ERROR_GROUP_NUM = -43,
    TEAM_NAME_ILLEGAL = -42,
    EMPTY_NAME = -41,
    CAN_NOT_DELETE_HERO = -40,
    RED_CARD_MAX_EXCHANGE_LIMIT = -30,
    RED_CARD_STAR_LIMIT = -29,
    RED_CARD_NOT_MATCH = -28,
    RED_CARD_EXCHANGE_NOT_OPEN = -27,
    SPLIT_HERO_PACKSIZE_FULL = -26,
    SPLIT_HERO_CONFIG_ERROR = -25,
    SPLIT_HERO_CURRENCY_NOT_ENOUGH = -24,
    HERO_GOLD_RANK_UP_NOT_OPEN = -23,
    HERO_GOLD_RANK_UP_LIMIT = -22,
    HERO_MUTEX_LIMIT = -21,
    MUST_SET_LEADER = -20,
    HERO_IN_GROUP = -19,
    HERO_GROUP_NOT_FOUND = -18,
    HERO_NOT_ENOUGH = -17,
    SKILL_MAX_LEVEL = -16,
    HERO_LOCKED = -15,
    BUY_LIMIT = -14,
    HERO_IN_CURRENT = -13,
    ITEM_NOT_FOUND = -12,
    SKILL_NOT_FOUND = -11,
    BLOCK_BY_LIMIT = -8,
    CANT_RANK_UP = -7,
    BLOCK_BY_LEVEL = -6,
    INVALID_OPERATE = -5,
    NOT_ENOUGHT_LEADERSHIP = -3,
    HERO_NOT_FOUND = -2,
    ARGUMENT_ILLEGAL = -1
  }),
  ["model.BuyPackVo"] = {
    costs = array("com.eyu.mt.module.cost.model.CostResult"),
    extendCount = int,
    extendLimit = int
  },
  ["model.HeroGroupInfoVo"] = {
    curGroupId = int,
    groups = array("com.eyu.mt.module.hero.model.HeroGroupVo")
  },
  ["model.HeroGroupVo"] = {
    embattles = array(array(long)),
    groupId = int,
    leaderId = long
  },
  ["model.HeroGrowVo"] = {
    costs = array("com.eyu.mt.module.cost.model.CostResult"),
    hero = "com.eyu.mt.module.hero.model.HeroVo"
  },
  ["model.HeroPackVo"] = {
    extendCount = int,
    extendLimit = int,
    heros = array("com.eyu.mt.module.hero.model.HeroVo"),
    leader = long,
    score = array(int)
  },
  ["model.HeroVo"] = {
    baseId = int,
    exp = int,
    id = long,
    level = int,
    locked = bool,
    powerSkill = int,
    skillExp = int
  },
  ["model.RankGroupInfoVo"] = {
    curGroupId = int,
    groups = array("com.eyu.mt.module.hero.model.RankGroupVo")
  },
  ["model.RankGroupVo"] = {
    artifactLevel = int,
    embattles = array(array("com.eyu.mt.module.hero.model.RankHeroVo")),
    groupId = int,
    leaderBaseId = int,
    userBuff = array(string)
  },
  ["model.RankHeroVo"] = {
    baseId = int,
    cultivateVo = "com.eyu.mt.module.cultivate.model.HeroCultivateVo",
    equips = array("com.eyu.mt.module.equip.model.EquipVo"),
    leader = bool,
    level = int,
    powerSkill = int,
    talisman = array("com.eyu.mt.module.talisman.model.TalismanVo")
  },
  ["model.RedCardExchangeVo"] = {
    costAndReward = "com.eyu.mt.module.cost.model.CostAndReward",
    exchangeRecord = map(int, int)
  },
  ["model.TeamEquipInfo"] = {
    equipId = long,
    heroId = long,
    position = int
  },
  ["model.TeamInfoVo"] = {
    teamLeaders = map(string, array(long)),
    teams = map(string, array(array(array(long))))
  },
  ["model.TeamTalismanInfo"] = {
    heroId = long,
    talismanId = array(long)
  }
}
NetMsg:Import(...)
