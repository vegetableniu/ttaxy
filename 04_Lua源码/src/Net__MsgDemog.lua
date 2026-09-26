local NetMsg = Singleton(NetMsg)
module(...)
NetMsg:Setup(...)
mod = 26
cmd = {
  ACTIVE_INFO = {
    1,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.demog.model.DemogActiveInfoVO"
    }
  },
  DEMOG_LIST = {
    2,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.demog.model.DemogListVO"
    }
  },
  ATTACK_DEMOG = {
    3,
    {
      allOut = bool,
      demogId = long,
      embattle = array(array(array(long))),
      summoner = long
    },
    {
      code = int,
      content = "com.eyu.mt.module.demog.model.AttackVO"
    }
  },
  TOTAL_DAMAGE_RANK = {
    4,
    {demogId = long, summoner = long},
    {
      code = int,
      content = array("com.eyu.mt.module.demog.model.TotalDamageRankVo")
    }
  },
  INVITE_FRIEND_ATTACK = {
    5,
    {demogId = long},
    {code = int, content = long}
  },
  MAX_DAMAGE_RANK = {
    6,
    {},
    {
      code = int,
      content = array("com.eyu.mt.module.demog.model.RankVO")
    }
  },
  FEAT_RANK = {
    7,
    {},
    {
      code = int,
      content = array("com.eyu.mt.module.demog.model.RankVO")
    }
  },
  BUY_ENERGY = {
    8,
    {type = int},
    {
      code = int,
      content = "com.eyu.mt.module.cost.model.CostAndReward"
    }
  },
  RANK_GROUP_INFO = {
    9,
    {owner = long},
    {
      code = int,
      content = "com.eyu.mt.module.hero.model.RankGroupInfoVo"
    }
  },
  DRAW_FEAT_REWARD = {
    10,
    {
      ids = array(int)
    },
    {
      code = int,
      content = array("com.eyu.mt.module.reward.model.RewardResult")
    }
  },
  FRAGMENT_EXCHANGE = {
    11,
    {id = int},
    {
      code = int,
      content = "com.eyu.mt.module.demog.model.ExchangeVO"
    }
  },
  GET_ACTIVE_ID = {
    12,
    {},
    {code = int, content = string}
  },
  DRAW_KILLED_DEMOG_REWARD = {
    13,
    {demogId = long},
    {
      code = int,
      content = "com.eyu.mt.module.demog.model.DemogKilledRewardVO"
    }
  },
  REFRESH_DEMOG = {
    14,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.demog.model.DemogAppearVO"
    }
  },
  ALL_RANK = {
    15,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.demog.model.AllRankVO"
    }
  },
  PRAISE_RANK = {
    16,
    {id = long},
    {
      code = int,
      content = "com.eyu.mt.module.demog.model.PraiseRankVO"
    }
  },
  RED_CARD_COMPOSE = {
    17,
    {id = int},
    {
      code = int,
      content = "com.eyu.mt.module.cost.model.CostAndReward"
    }
  }
}
types = {
  ["facade.DemogResult"] = const({
    LEVEL_NOT_SUITABLE = -34,
    COST_ITEM_NOT_ENOUGH = -33,
    FEAT_REWARD_NOT_EXIST = -32,
    FEAT_REWARD_CAN_NOT_BE_NONE = -31,
    EXCHANGE_LEVEL_LIMIT = -30,
    CURRENCY_FRAGMENT_NOT_ENOUGH = -29,
    RED_CARD_COMPOSE_LIMIT = -28,
    PRAISE_NUM_LIMIT = -27,
    PRAISE_SELF_LIMIT = -26,
    RANK_NOT_TOP = -25,
    EMBATTLE_ERROR = -24,
    POINT_FULL_LIMIT = -23,
    HERO_GROUP_LEADER_LIMIT = -22,
    HERO_LEADER_LIMIT = -21,
    ARGUMENT_ILLEGAL = -20,
    DEMOG_KILLED_REWARD_NOT_FOUND = -19,
    FEAT_REWARD_RANK_LIMIT = -18,
    EXCHANGE_ACTIVE_LIMIT = -17,
    EXCHANGE_NUM_LIMIT = -16,
    SPACE_NOT_ENOUGH = -15,
    FRAGMENT_NOT_ENOUGH = -14,
    HAS_DRAW_FEAT_REWARD = -13,
    FEAT_NOT_ENOUGH = -12,
    PLAYER_NOT_FOUND = -11,
    BUY_TIMES_LIMIT = -10,
    INVALID_DEMOG = -9,
    ACTION_POINT_NOT_ENOUGH = -8,
    DEMOG_DEAD_OR_ESACAPED = -7,
    DEMOG_HAS_ESCAPED = -6,
    DEMOG_HAS_DEAD = -5,
    HAS_INVITED_ATTACK = -4,
    NOT_SUMMONER = -3,
    DEMOG_ACTIVE_NOT_OPEN = -2,
    DEMOG_BATTLE_CONFIG_NOT_FOUND = -1
  }),
  ["model.AllRankVO"] = {
    activeId = string,
    damageRank = int,
    damageRankList = array("com.eyu.mt.module.demog.model.RankVO"),
    featRank = int,
    featRankList = array("com.eyu.mt.module.demog.model.RankVO")
  },
  ["model.AttackVO"] = {
    allOut = bool,
    costResult = array("com.eyu.mt.module.cost.model.CostResult"),
    damage = long,
    enemyNum = int,
    feat = long,
    groupNum = int,
    killed = bool,
    luckHeros = array(int),
    rankList = array("com.eyu.mt.module.demog.model.TotalDamageRankVo"),
    reports = array(bytearray),
    shared = bool
  },
  ["model.BuyEnergyVO"] = {
    buyTimes = int,
    costResults = array("com.eyu.mt.module.cost.model.CostResult"),
    energy = int
  },
  ["model.DemogActiveInfoVO"] = {
    activeId = string,
    drawReward = array(int),
    endTime = int,
    exchangeMap = map(int, int),
    feat = long,
    fragment = int,
    hasReward = bool,
    lastAttackDrawNum = int,
    pointValue = "com.eyu.mt.module.point.manager.PointValue",
    rank = int,
    rankGroupId = int
  },
  ["model.DemogAppearVO"] = {
    activeId = string,
    battleId = string,
    currentHp = long,
    drawReward = array(int),
    escapeTime = int,
    feat = long,
    id = long,
    lastAttackDrawNum = int,
    level = int,
    pointValue = "com.eyu.mt.module.point.manager.PointValue",
    rank = int,
    summoner = long,
    summonerName = string,
    totalHp = long
  },
  ["model.DemogKilledRewardVO"] = {
    feat = int,
    rank = int,
    rewardResults = array("com.eyu.mt.module.reward.model.RewardResult")
  },
  ["model.DemogListVO"] = {
    demogList = array("com.eyu.mt.module.demog.model.DemogVO"),
    killedDemogList = array("com.eyu.mt.module.demog.model.KilledDemogVO")
  },
  ["model.DemogVO"] = {
    attacked = bool,
    battleId = string,
    currentHp = long,
    escapeTime = int,
    id = long,
    level = int,
    summoner = long,
    summonerName = string,
    totalHp = long
  },
  ["model.ExchangeVO"] = {
    configId = int,
    costResults = array("com.eyu.mt.module.cost.model.CostResult"),
    exchangeNum = int,
    fragment = int,
    rewardResult = array("com.eyu.mt.module.reward.model.RewardResult")
  },
  ["model.KilledDemogVO"] = {
    battleId = string,
    id = long,
    killFeat = int,
    lastAttackRewards = array("com.eyu.mt.module.reward.model.Reward"),
    level = int,
    maxDamageRewards = array("com.eyu.mt.module.reward.model.Reward"),
    summonRewards = array("com.eyu.mt.module.reward.model.Reward"),
    summonerName = string
  },
  ["model.PraiseRankVO"] = {
    rankList = array("com.eyu.mt.module.demog.model.RankVO"),
    rewardResults = array("com.eyu.mt.module.reward.model.RewardResult")
  },
  ["model.RankVO"] = {
    artifactLevel = int,
    canPraise = bool,
    id = long,
    leaderBaseId = int,
    leaderCultivateVo = "com.eyu.mt.module.cultivate.model.HeroCultivateVo",
    leaderEquip = array("com.eyu.mt.module.equip.model.EquipVo"),
    leaderLevel = int,
    leaderTalisman = array("com.eyu.mt.module.talisman.model.TalismanVo"),
    level = int,
    name = string,
    powerSkill = int,
    praiseNum = int,
    rank = int,
    rankValue = long,
    userBuffs = array(string),
    vip = bool
  },
  ["model.TotalDamageRankVo"] = {
    damage = long,
    id = long,
    name = string,
    rank = int
  }
}
NetMsg:Import(...)
