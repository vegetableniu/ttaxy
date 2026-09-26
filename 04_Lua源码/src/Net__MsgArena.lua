local NetMsg = Singleton(NetMsg)
module(...)
NetMsg:Setup(...)
mod = 24
cmd = {
  MATCH_LIST = {
    1,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.arena.model.MatchPlayerListVO"
    }
  },
  DEFY_MATCH = {
    2,
    {
      embattle = array(array(array(long))),
      id = long
    },
    {
      code = int,
      content = "com.eyu.mt.module.arena.model.DefyResultVO"
    }
  },
  MANUAL_REFRESH_LIST = {
    3,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.arena.model.MatchPlayerListVO"
    }
  },
  INTEGRAL_EXCHANGE = {
    4,
    {id = int},
    {
      code = int,
      content = "com.eyu.mt.module.arena.model.ExchangeVO"
    }
  },
  LINEUP_COMPARE = {
    5,
    {id = long},
    {
      code = int,
      content = "com.eyu.mt.module.arena.model.LineupCompareVO"
    }
  },
  CLEAR_COOL_TIME = {
    6,
    {},
    {
      code = int,
      content = array("com.eyu.mt.module.cost.model.CostResult")
    }
  },
  GET_RANK_LIST = {
    7,
    {},
    {
      code = int,
      content = array("com.eyu.mt.module.arena.model.IntegralRankVO")
    }
  },
  BUY_DEFY_TIMES = {
    8,
    {num = int},
    {
      code = int,
      content = "com.eyu.mt.module.arena.model.BuyTimesVO"
    }
  }
}
types = {
  ["facade.ArenaResult"] = const({
    HERO_GROUP_LEADER_LIMIT = -18,
    EXCHANGE_CHARGE_LIMIT = -17,
    DEFY_TIMES_NOT_ENOUGH = -16,
    EMBATTLE_ERROR = -15,
    HERO_LEADER_LIMIT = -14,
    NOT_FIRST_BATTLE = -13,
    EXCHANGE_LEVEL_LIMIT = -12,
    SPACE_NOT_ENOUGH = -11,
    INTEGRAL_REWARD_NOT_EXIST = -10,
    INTEGRAL_NOT_ENOUGH = -9,
    BLOCK_BY_LEVEL = -8,
    PLAYER_IS_KO = -7,
    NO_COOL_STATE = -6,
    REFRESH_COOL_STATE = -5,
    NEED_UPDATE_DATA = -4,
    BUY_TIMES_LIMITED = -3,
    MATCH_PLAYER_NOT_EXIST = -2,
    PONIT_NOT_ENOUGH = -1
  }),
  ["model.BuyTimesVO"] = {
    costResults = array("com.eyu.mt.module.cost.model.CostResult"),
    hasBuyTimes = int,
    times = int
  },
  ["model.DefyResultVO"] = {
    costResult = array("com.eyu.mt.module.cost.model.CostResult"),
    groupNum = int,
    integral = int,
    matchPlayerList = "com.eyu.mt.module.arena.model.MatchPlayerListVO",
    reports = array(bytearray),
    rewards = array("com.eyu.mt.module.reward.model.RewardResult"),
    success = bool,
    targetArtifactLevel = int,
    targetGroupNum = int
  },
  ["model.ExchangeVO"] = {
    rewardResult = array("com.eyu.mt.module.reward.model.RewardResult"),
    totalIntegral = int
  },
  ["model.HeroGroupVO"] = {
    embattles = array("com.eyu.mt.module.arena.model.LineupHeroVO"),
    groupId = int,
    leaderBaseId = int,
    leaderLevel = int
  },
  ["model.IntegralRankVO"] = {
    integral = long,
    leaderBaseId = int,
    level = int,
    rank = int,
    userName = string
  },
  ["model.IntegralRewardVO"] = {
    hasDrawList = array(int),
    integral = int,
    leaveBuyTimes = int,
    rewardList = array(int),
    times = int
  },
  ["model.LineupCompareVO"] = {
    enemy = "com.eyu.mt.module.arena.model.LineupVO",
    own = "com.eyu.mt.module.arena.model.LineupVO"
  },
  ["model.LineupHeroVO"] = {
    baseId = int,
    cultivateVo = "com.eyu.mt.module.cultivate.model.HeroCultivateVo",
    equipVos = array("com.eyu.mt.module.equip.model.EquipVo"),
    level = int,
    talismanVos = array("com.eyu.mt.module.talisman.model.TalismanVo")
  },
  ["model.LineupVO"] = {
    artifactLevel = int,
    battleEffect = int,
    buffs = array(string),
    groups = array("com.eyu.mt.module.arena.model.HeroGroupVO"),
    level = int,
    name = string
  },
  ["model.MatchPlayerListVO"] = {
    battleEffect = int,
    coolState = bool,
    coolTime = int,
    hasBuyTimes = int,
    integral = int,
    leaveBuyTimes = int,
    playerList = array("com.eyu.mt.module.arena.model.MatchPlayerVO"),
    rank = int,
    times = int,
    totalIntegral = int
  },
  ["model.MatchPlayerVO"] = {
    battleEffect = int,
    carry = bool,
    id = long,
    leaderBaseId = int,
    level = int,
    name = string,
    socialStatus = int,
    star = int,
    state = bool
  }
}
NetMsg:Import(...)
