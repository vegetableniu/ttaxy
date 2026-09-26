module(...)
Singleton(NetMsg):Setup(...)
mod = 10
cmd = {
  CREATE = {
    1,
    {
      account = string,
      channel = int,
      device = string,
      idfa = string,
      invite = string,
      key = string,
      name = string,
      origin = string,
      purchaseCode = string,
      select = int,
      timestamp = int
    },
    {code = int, content = int}
  },
  LOGIN = {
    2,
    {
      account = string,
      adult = bool,
      appId = string,
      channel = int,
      device = "com.eyu.mt.module.account.model.DeviceType",
      idfa = string,
      key = string,
      origin = string,
      timestamp = int,
      token = string
    },
    {code = int, content = string}
  },
  RELOGIN = {
    3,
    {
      account = string,
      key = string,
      timestamp = int
    },
    {code = int, content = int}
  },
  CHECK_ACCOUNT = {
    4,
    {
      account = string,
      key = string,
      timestamp = int
    },
    {code = int, content = bool}
  },
  CHECK_FATIGUE_STATE = {
    5,
    {},
    {}
  },
  UPDATE_INCOME_RATE = {
    6,
    {},
    {}
  },
  LOGIN_INFO = {
    7,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.account.model.LoginInfoVo"
    }
  },
  RENAME = {
    8,
    {name = string},
    {code = int, content = int}
  },
  LOGIN_COMPLETE = {
    9,
    {},
    {code = int, content = int}
  },
  UPDATE_PUSH = {
    10,
    {push = bool},
    {code = int, content = int}
  },
  PUSH_STATE = {
    11,
    {},
    {code = int, content = bool}
  }
}
types = {
  ["facade.AccountResult"] = const({
    ACCOUNT_IS_CLEAN = -11,
    UNREGISTABLE = -10,
    ACCOUNT_IS_BLOCK = -9,
    INIT_REWARD_ERROR = -8,
    INVAILD_ACCOUNT_NAME = -7,
    RELOGIN_FAIL = -6,
    ACCOUNT_NOT_FOUND = -5,
    LOGIN_KEY_ILLEGAL = -4,
    PLAYER_NAME_ILLEGAL = -3,
    PLAYER_ALREADY_EXISTS = -2,
    ACCOUNT_ALREADY_EXISTS = -1
  }),
  ["model.AccountPost"] = const({GM = 1, ZDY = 2}),
  ["model.AccountState"] = enum({
    [0] = "NORMAL",
    [1] = "BLOCK",
    [2] = "CLEAN"
  }),
  ["model.AccountVo"] = {
    createdOn = date,
    dayByContinuous = int,
    dayByTotal = int,
    id = long,
    loginOn = date,
    logoutOn = date,
    name = string,
    online = bool,
    post = int,
    state = "com.eyu.mt.module.account.model.AccountState",
    timeByDay = int,
    timeByTotal = int
  },
  ["model.DeviceType"] = enum({
    [0] = "IOS",
    [1] = "ANDROID",
    [2] = "WIN"
  }),
  ["model.FriendPackVo"] = {
    apply = bool,
    extendCount = int,
    extendLimit = int,
    friends = array(long)
  },
  ["model.IncomeRate"] = enum({
    [0] = "FULL",
    [1] = "HALF",
    [2] = "EMPTY"
  }),
  ["model.LoginInfoVo"] = {
    account = "com.eyu.mt.module.account.model.AccountVo",
    actionPoint = "com.eyu.mt.module.point.model.ActionPointVo",
    activeProgress = array(string),
    activitys = "com.eyu.mt.module.activity.model.ValidActivityVo",
    arenaMatchList = "com.eyu.mt.module.arena.model.MatchPlayerListVO",
    artifactLevel = int,
    asset = int,
    buffs = array(string),
    buyEquipPackCount = int,
    buyEquipSpace = int,
    chargeRankCanDraw = bool,
    commendFriend = array("com.eyu.mt.module.sociality.model.CommendVo"),
    consumeRankCanDraw = bool,
    dailyCheckInfo = "com.eyu.mt.module.player.model.DailyCheckVO",
    demogActiveId = string,
    demogFeat = long,
    demogRank = "com.eyu.mt.module.demog.model.AllRankVO",
    dumplingCoolTime = date,
    eliteBattleIds = array(string),
    emblemAchieveList = array(int),
    equipVos = array("com.eyu.mt.module.equip.model.EquipVo"),
    exploreExecuteTasks = map(long, date),
    friendPack = "com.eyu.mt.module.account.model.FriendPackVo",
    groupVo = "com.eyu.mt.module.hero.model.HeroGroupInfoVo",
    hasAchieve = bool,
    hasNewMail = bool,
    hasReward = bool,
    heroCultivateVos = array("com.eyu.mt.module.cultivate.model.HeroCultivateVo"),
    heros = "com.eyu.mt.module.hero.model.HeroPackVo",
    items = array("com.eyu.mt.module.item.manager.Item"),
    lastPraiseTime = date,
    lotteryLevel = int,
    lotteryRecord = map(string, object),
    menpaiLoginVo = "com.eyu.mt.module.menpai.model.MenpaiLoginVo",
    platformInfo = "com.eyu.mt.module.platform.model.PlatformInfo",
    player = "com.eyu.mt.module.player.model.PlayerVo",
    program = int,
    progressVo = "com.eyu.mt.module.battle.model.ProgressVo",
    resetPlayerName = bool,
    state = int,
    systemTime = date,
    talismanPackExtendCount = int,
    talismanVos = array("com.eyu.mt.module.talisman.model.TalismanVo"),
    targetProgress = map(string, double),
    teamInfoVo = "com.eyu.mt.module.hero.model.TeamInfoVo",
    treasurePack = "com.eyu.mt.module.treasure.model.TreasurePackVo",
    validGiftVo = "com.eyu.mt.module.gift.model.ValidGiftVo",
    vip = "com.eyu.mt.module.vip.model.VipInfo",
    wallet = "com.eyu.mt.module.account.model.WalletVo"
  },
  ["model.WalletVo"] = {
    copper = int,
    coupon = int,
    exploit = int,
    fragment = int,
    friendship = int,
    gift = int,
    gold = int,
    inter = int,
    orange = int,
    purple = int,
    stageCharges = map(string, int),
    stone = int,
    totalCharge = int
  }
}
Singleton(NetMsg):Import(...)
