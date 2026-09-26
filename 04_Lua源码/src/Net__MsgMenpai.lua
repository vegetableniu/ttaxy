local NetMsg = Singleton(NetMsg)
module(...)
NetMsg:Setup(...)
mod = 47
cmd = {
  JOIN_MENPAI = {
    1,
    {menpai = long},
    {
      code = int,
      content = "com.eyu.mt.module.menpai.model.ApplyMenpaiInfoVo"
    }
  },
  GET_SELEF_MENPAI = {
    2,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.menpai.model.MenpaiInfoVo"
    }
  },
  GET_MENPAI_LIST = {
    3,
    {key = string, page = int},
    {
      code = int,
      content = "com.eyu.mt.module.menpai.model.ApplyMenpaiInfoPageVo"
    }
  },
  GET_PARTNER_LIST = {
    4,
    {page = int},
    {
      code = int,
      content = "com.eyu.mt.module.menpai.model.MenpaiPartnerPageVo"
    }
  },
  INVITE_PARTNER = {
    5,
    {partner = long},
    {
      code = int,
      content = "com.eyu.mt.module.menpai.model.JoinState"
    }
  },
  LIST_APPLY_USER = {
    6,
    {page = int},
    {
      code = int,
      content = "com.eyu.mt.module.menpai.model.BasicUserPageVo"
    }
  },
  CHECK_USER = {
    7,
    {accept = bool, applyId = long},
    {code = int, content = int}
  },
  LIST_INVITE_MENPAI = {
    8,
    {page = int},
    {
      code = int,
      content = "com.eyu.mt.module.menpai.model.InviteMenpaiInfoPageVo"
    }
  },
  CHECK_INVITE_MENPAI = {
    9,
    {accept = bool, inivteId = long},
    {
      code = int,
      content = "com.eyu.mt.module.menpai.model.MenpaiInfoVo"
    }
  },
  CHANGE_POST = {
    10,
    {post = string},
    {code = int, content = int}
  },
  GIVE_MESSAGE = {
    11,
    {message = string},
    {code = int, content = int}
  },
  LIST_MESSAGE = {
    12,
    {page = int},
    {
      code = int,
      content = "com.eyu.mt.module.menpai.model.UserMessagePageVo"
    }
  },
  UPDATE_DECLARATION = {
    13,
    {declaration = string},
    {code = int, content = int}
  },
  CONTRIBUTE_MENPAI = {
    14,
    {count = int},
    {
      code = int,
      content = "com.eyu.mt.module.menpai.model.ContributeMenpaiVo"
    }
  },
  BID_RANK = {
    15,
    {count = int},
    {code = int, content = double}
  },
  KICK_USER = {
    16,
    {player = long},
    {code = int, content = int}
  },
  CREATE_MENPAI = {
    17,
    {name = string},
    {
      code = int,
      content = array("com.eyu.mt.module.cost.model.CostResult")
    }
  },
  SET_MEMBER_JOB = {
    18,
    {jobType = string, partner = long},
    {code = int, content = int}
  },
  TRANSFER_BOSS = {
    19,
    {partner = long},
    {code = int, content = int}
  },
  GRAB_TIGHT = {
    20,
    {},
    {code = int, content = date}
  },
  STOP_GRAB_RIGHT = {
    21,
    {},
    {code = int, content = int}
  },
  SPRING_DRINK = {
    22,
    {},
    {}
  },
  PRAY = {
    23,
    {time = int},
    {
      code = int,
      content = "com.eyu.mt.module.menpai.model.PrayVo"
    }
  },
  QUIT_MENPAI = {
    26,
    {},
    {code = int, content = int}
  },
  SUMMON_DEMOG = {
    27,
    {cost = long},
    {
      code = int,
      content = "com.eyu.mt.module.menpai.model.SummonDemogVo"
    }
  },
  LIST_DEMOG = {
    28,
    {page = int},
    {
      code = int,
      content = "com.eyu.mt.module.menpai.model.DemogPageVo"
    }
  },
  CLEAR_COOLTIME = {
    29,
    {},
    {
      code = int,
      content = array("com.eyu.mt.module.cost.model.CostResult")
    }
  },
  ATTACK_DEMOG = {
    30,
    {
      demogId = long,
      embattle = array(array(array(long)))
    },
    {
      code = int,
      content = "com.eyu.mt.module.menpai.model.AttackVo"
    }
  },
  DRAW_REWARD = {
    31,
    {demogId = long},
    {
      code = int,
      content = array("com.eyu.mt.module.reward.model.RewardResult")
    }
  },
  SINGLE_PARTNER = {
    32,
    {partnerId = long},
    {
      code = int,
      content = "com.eyu.mt.module.menpai.model.MenpaiPartnerVo"
    }
  },
  DISBAND_MENPAI = {
    33,
    {},
    {}
  },
  CANCEL_APPLY = {
    34,
    {menpai = long},
    {
      code = int,
      content = "com.eyu.mt.module.menpai.model.ApplyMenpaiInfoVo"
    }
  },
  COUNTRY_DATA = {
    35,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.menpai.model.CountryVo"
    }
  },
  BID_FOR_COUNTRY = {
    37,
    {count = int, country = int},
    {
      code = int,
      content = "com.eyu.mt.module.menpai.model.MenpaiBidResultVo"
    }
  },
  COUNTRY_FIGHT_JOINED = {
    38,
    {country = int, join = bool},
    {
      code = int,
      content = "com.eyu.mt.module.menpai.model.CountryFigthJoinedVo"
    }
  },
  COUNTRY_FIGHT_RESULT = {
    39,
    {country = int},
    {
      code = int,
      content = "com.eyu.mt.module.menpai.model.CountryFightReportVo"
    }
  },
  GET_GOODS = {
    40,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.menpai.model.MenpaiGoodsInfoVo"
    }
  },
  EXCHAGE_GOODS = {
    41,
    {goods = int, times = int},
    {
      code = int,
      content = "com.eyu.mt.module.cost.model.CostAndReward"
    }
  },
  QUIT_COUNTRY_FIGHT = {
    43,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.menpai.model.CountryFigthJoinedVo"
    }
  },
  MENPAI_RENAME = {
    44,
    {name = string},
    {code = int, content = int}
  }
}
types = {
  ["facade.MenpaiResult"] = const({
    CAN_NOT_DELETE_HERO = -83,
    QUIT_REJOIN_COOLTIME = -82,
    COUNTRY_HOLD = -81,
    COUNTRY_FIGHT_NOT_HAPPEN = -80,
    INVALID_COUNTRY = -79,
    NOT_JOIN_FIGHT = -78,
    EXCHANGE_TIME_LIMIT = -77,
    INVALID_GOODS = -76,
    MENPAI_MONEY_INCREASE_LIMIT = -75,
    MENPAI_MONEY_NOT_ENOUGH = -74,
    COUNTRY_FIGHT_FAIL = -73,
    FIGHT_JOIN_TIME_OUT = -72,
    BID_COUNTRY_TIMEOUT = -71,
    COUNTRY_FIGHT_NUMBER_LIMIT = -70,
    COUNTRY_FIGHT_FORBID = -69,
    BID_COUNTRY_LIMIT = -68,
    BID_COUNTRY_SINGLA = -67,
    CURRENCY_NOT_ENOUGH = -66,
    INVALID_CHARACTER = -65,
    BID_MAX_LIMIT = -64,
    CONTRIBUTE_MAX_LIMIT = -63,
    DEMOG_ALIVE = -62,
    MENPAI_DISBAND = -61,
    ATTACK_COOLTIME_PASS = -60,
    APPLY_MENPAI_COUNT_LIMIT = -59,
    APPLY_COUNT_LIMIT = -58,
    PLAYER_INFO_NOT_FOUND = -57,
    MENPAI_LEVEL_LIMIT = -56,
    ATTACK_DRAWED = -55,
    ATTACK_NOT_FOUND = -54,
    DEMOG_IS_ALIVE = -53,
    DEMOG_HAS_ESCAPED = -52,
    DEMOG_DIE = -51,
    MENPAI_ERROR = -50,
    ATTACK_DEMOG_COOLTIME_LIMIT = -49,
    HERO_GROUP_LEADER_LIMIT = -48,
    HERO_LEADER_LIMIT = -47,
    DEMOG_NOT_FOUND = -46,
    DEMOG_CARD_NOT_MATCH = -45,
    DEMOG_CARD_NOT_FOUND = -44,
    GRIB_IS_RUNNING = -43,
    GRIB_RIGHT_NOT_FOUND = -42,
    JOB_QUIT_FORBID = -41,
    GRAB_RIGHT_DOUBLE = -40,
    INVITE_USER_INFO_CHANGE = -39,
    MENPAI_INVITE_USER_MENPAI_NOT_FOUNT = -38,
    MENPAI_PRAY_DRAWED = -37,
    MENPAI_PRAY_NOT_FOUND = -36,
    MENPAI_PRAY_TIME_LIMMIT = -35,
    MENPAI_ACTION_POINT_COOLTIME = -34,
    MENPAI_POST_WORD_LIMIT = -33,
    MENPAI_MIN_BID_COUNT = -32,
    DECLARATION_WORLD_LIMIT = -31,
    MENPAI_JOB_SAME = -30,
    MENPAI_CHECK_DENY = -29,
    MENPAI_UPDATE_JOB_SELF = -28,
    MENPAI_BOSS_HARDWORKING = -27,
    MENPAI_BOSS_JOB = -26,
    MENPAI_TRANSFER_TIME_LIMIT = -25,
    MENPAI_GIVE_BOSS_ERROR = -24,
    MENPAI_AUTH_DENY = -23,
    MENPAI_NOT_SAME_MENPAI = -22,
    MENPAI_PARAMETER_ERROR = -21,
    MENPAI_BID_NOT_ENOUGH = -20,
    MENPAI_CREATE_NAME_UNIQUE = -19,
    MENPAI_CREATE_MENPAI_LEVEL_LIMIT = -18,
    MENPAI_CONTRIBUTE_ACTION_LIMIT = -17,
    MENPAI_MESSAGE_PUT_COOLTIME = -16,
    MENPAI_MESSAGE_WORD_LIMIT = -15,
    MENPAI_MESSAGE_COUNT_LIMIT = -14,
    MENPAI_INVITE_NOT_FOUND = -13,
    MENPAI_JOINED_OTHER = -12,
    MENPAI_ELDER_SIZE_LIMIT = -11,
    MENPAI_CREATE_NOT_ENOUGH = -10,
    MENPAI_INVITED = -9,
    MENPAI_NOT_JOIN = -8,
    MENPAI_USER_MENPAI_EXIST = -7,
    MENPAI_APPLEYED = -6,
    MENPAI_JOINED = -5,
    MENPAI_MEMBER_COUNT_LIMIT = -4,
    MENPAI_IS_EMPTY = -3,
    MENPAI_PAGE_PARAM_ERROR = -2,
    MENPAI_NOT_FOUND = -1
  }),
  ["model.ApplyMenpaiInfoPageVo"] = {
    count = int,
    data = array("com.eyu.mt.module.menpai.model.ApplyMenpaiInfoVo"),
    firstBid = long,
    firstMenpai = long,
    ownBid = long,
    page = int,
    size = int
  },
  ["model.ApplyMenpaiInfoVo"] = {
    bossName = string,
    count = int,
    createTime = date,
    declaration = string,
    exp = long,
    id = long,
    joinState = "com.eyu.mt.module.menpai.model.JoinState",
    level = int,
    maxCount = int,
    name = string,
    rank = int,
    todayBid = int,
    yesterdayBid = int
  },
  ["model.AttackVo"] = {
    currenttHp = long,
    demage = int,
    groupNum = int,
    reports = array(bytearray),
    rewardResult = array("com.eyu.mt.module.reward.model.RewardResult"),
    totalHp = long,
    win = bool
  },
  ["model.BasicUser"] = {
    baseId = int,
    fightScore = int,
    level = int,
    name = string,
    playerId = long,
    skill = int
  },
  ["model.BasicUserPageVo"] = {
    count = int,
    data = array("com.eyu.mt.module.menpai.model.BasicUser"),
    page = int,
    size = int
  },
  ["model.CheckApplyUserVo"] = {
    baseId = int,
    fightScore = int,
    level = int,
    name = string,
    playerId = long
  },
  ["model.ContributeMenpaiVo"] = {
    costReward = "com.eyu.mt.module.cost.model.CostAndReward",
    exp = long,
    money = long,
    rewardExp = int
  },
  ["model.CountryFightReportVo"] = {
    fightJoinedVo = "com.eyu.mt.module.menpai.model.CountryFigthJoinedVo",
    fightReport = array(array("com.eyu.mt.module.menpai.model.FightRecord")),
    winMenpaiId = long
  },
  ["model.CountryFighter"] = {
    firstBid = long,
    firstMenpai = long,
    firstMenpaiNames = string,
    id = int,
    secBid = long,
    secMenpai = long,
    secMenpaiNames = string
  },
  ["model.CountryFigthJoinedVo"] = {
    country = int,
    joined = bool,
    ownMenpaiId = long,
    ownMenpaiName = string,
    ownTeam = array("com.eyu.mt.module.menpai.model.MenpaiPartnerVo"),
    targetMenpaiId = long,
    targetMenpaiName = string,
    targetTeam = array("com.eyu.mt.module.menpai.model.MenpaiPartnerVo")
  },
  ["model.CountryHoldVo"] = {
    bid = long,
    id = int,
    menpaiInfo = "com.eyu.mt.module.menpai.model.ApplyMenpaiInfoVo",
    nextBidDate = date
  },
  ["model.CountryItemVo"] = {
    data = object,
    state = "com.eyu.mt.module.menpai.model.CountryState"
  },
  ["model.CountryState"] = enum({
    [0] = "BIDDING",
    [1] = "WIN_BID",
    [2] = "JOIN_FIGHT",
    [3] = "REPORT",
    [4] = "HOLD"
  }),
  ["model.CountryType"] = enum({
    [0] = "BIG",
    [1] = "SMALL"
  }),
  ["model.CountryVo"] = {
    countryDatas = array("com.eyu.mt.module.menpai.model.CountryItemVo"),
    ownData = object,
    state = "com.eyu.mt.module.menpai.model.CountryState"
  },
  ["model.DemogPageVo"] = {
    attackCooltime = date,
    count = int,
    data = array("com.eyu.mt.module.menpai.model.DemogVo"),
    page = int,
    size = int
  },
  ["model.DemogType"] = enum({
    [0] = "LOW",
    [1] = "MIDDLE"
  }),
  ["model.DemogVo"] = {
    canReward = bool,
    configId = string,
    demogId = long,
    escapeTime = date,
    hp = long,
    nameCall = string,
    totalHp = long
  },
  ["model.DrawSpringVo"] = {
    endCoolDate = date,
    rewardResults = array("com.eyu.mt.module.reward.model.RewardResult")
  },
  ["model.FightRecord"] = {
    demage = array(double),
    fighers = array(long),
    originalHp = array(double),
    roundDemage = array(array(double)),
    startHp = array(double),
    winCount = map(long, int),
    won = "com.eyu.mt.module.fight.model.BattleResult"
  },
  ["model.GoodsType"] = enum({
    [0] = "SPECIAL",
    [1] = "NORMAL"
  }),
  ["model.InviteMenpaiInfoPageVo"] = {
    count = int,
    data = array("com.eyu.mt.module.menpai.model.InviteMenpaiInfoVo"),
    page = int,
    size = int
  },
  ["model.InviteMenpaiInfoVo"] = {
    count = int,
    declaration = string,
    exp = long,
    id = long,
    inviteBaseId = long,
    inviteId = long,
    inviteJob = "com.eyu.mt.module.menpai.model.JobType",
    inviteName = string,
    joinState = "com.eyu.mt.module.menpai.model.JoinState",
    level = int,
    maxCount = int,
    name = string
  },
  ["model.JobAuth"] = enum({
    [0] = "INVITE",
    [1] = "LIST_APPLY",
    [2] = "CHECK_APPLY",
    [3] = "QUIT_MENPAI",
    [4] = "POST",
    [5] = "DECLARATION",
    [6] = "BID",
    [7] = "KICK_PLAYER",
    [8] = "SET_ELDER",
    [9] = "TRANSER_JOB",
    [10] = "STOP_GRAB_RIGHT",
    [11] = "FIGHT_BID"
  }),
  ["model.JobType"] = enum({
    [0] = "BOSS",
    [1] = "ELDER",
    [2] = "MEMBER",
    [3] = "STRANGE"
  }),
  ["model.JoinState"] = enum({
    [0] = "STRANGE",
    [1] = "APPLY",
    [2] = "INVITE",
    [3] = "JOINED"
  }),
  ["model.MenpaiBidResultVo"] = {
    bid = long,
    currentMoney = long,
    totalBid = long
  },
  ["model.MenpaiBidVo"] = {country = int, hasBid = long},
  ["model.MenpaiFightVo"] = {
    fightCountry = int,
    hasJoin = bool,
    totalJoinedCount = int
  },
  ["model.MenpaiGoodsInfoVo"] = {
    goods = array("com.eyu.mt.module.menpai.model.MenpaiGoodsItemVo"),
    id = long,
    money = long
  },
  ["model.MenpaiGoodsItemVo"] = {exchange = int, id = int},
  ["model.MenpaiInfoVo"] = {
    aplypNum = int,
    bossName = string,
    canPrayTime = int,
    count = int,
    declaration = string,
    endGrabRight = date,
    exp = long,
    hasGrabed = bool,
    holdRewardDate = date,
    id = long,
    job = "com.eyu.mt.module.menpai.model.JobType",
    joinBidDate = array(date),
    joinFightDate = array(date),
    level = int,
    money = long,
    name = string,
    post = string,
    prayTimes = int,
    reportDate = array(date)
  },
  ["model.MenpaiLoginVo"] = {
    country = int,
    holdRewardDate = date,
    job = "com.eyu.mt.module.menpai.model.JobType",
    joinBidDate = array(date),
    joinFightDate = array(date),
    joined = bool,
    menpaiId = long,
    needRename = bool,
    prayTime = int,
    reportDate = array(date)
  },
  ["model.MenpaiMoneyCostResult"] = {},
  ["model.MenpaiMoneyRewardResult"] = {},
  ["model.MenpaiPartnerPageVo"] = {
    count = int,
    data = array("com.eyu.mt.module.menpai.model.MenpaiPartnerVo"),
    page = int,
    size = int
  },
  ["model.MenpaiPartnerVo"] = {
    artifactLevel = int,
    baseId = int,
    contribute = long,
    cultivateVo = "com.eyu.mt.module.cultivate.model.HeroCultivateVo",
    equips = array("com.eyu.mt.module.equip.model.EquipVo"),
    fightScore = int,
    job = "com.eyu.mt.module.menpai.model.JobType",
    lastLogin = date,
    level = int,
    name = string,
    online = bool,
    playerId = long,
    skill = int,
    taiTalismans = array("com.eyu.mt.module.talisman.model.TalismanVo"),
    userBuffs = array(string)
  },
  ["model.PrayVo"] = {
    canPrayTime = int,
    costs = array("com.eyu.mt.module.cost.model.CostResult"),
    prayTime = int,
    rewards = array("com.eyu.mt.module.reward.model.RewardResult")
  },
  ["model.SummonDemogVo"] = {
    baseId = int,
    costAndReward = "com.eyu.mt.module.cost.model.CostAndReward",
    currencyHp = long,
    demogId = long,
    escapeTime = date,
    totalHp = long
  },
  ["model.UserMessagePageVo"] = {
    count = int,
    data = array("com.eyu.mt.module.menpai.model.UserMessageVo"),
    page = int,
    size = int
  },
  ["model.UserMessageVo"] = {
    baseId = int,
    date = date,
    level = int,
    message = string,
    name = string,
    playerId = long,
    skill = int
  }
}
NetMsg:Import(...)
