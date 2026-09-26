local NetMsg = Singleton(NetMsg)
module(...)
NetMsg:Setup(...)
mod = 27
cmd = {
  PROGRESS = {
    1,
    {campaignId = string},
    {
      code = int,
      content = "com.eyu.mt.module.rebirth.model.RebirthProgressVo"
    }
  },
  MULTI_ACTION = {
    2,
    {
      battleId = string,
      embattle = array(array(array(long)))
    },
    {
      code = int,
      content = "com.eyu.mt.module.rebirth.model.RebirthAttackVo"
    }
  },
  BUY_TIMES = {
    3,
    {battleId = string},
    {
      code = int,
      content = "com.eyu.mt.module.arena.model.BuyTimesVO"
    }
  },
  RECORD = {
    4,
    {battleId = string},
    {
      code = int,
      content = array("com.eyu.mt.module.rebirth.model.RecordItem")
    }
  },
  QUICK_BATTLE = {
    5,
    {
      battleId = string,
      embattle = array(array(array(long)))
    },
    {
      code = int,
      content = "com.eyu.mt.module.rebirth.model.RebirthAttackVo"
    }
  },
  QUICK_ADVANCE = {
    6,
    {battleId = string},
    {
      code = int,
      content = "com.eyu.mt.module.rebirth.model.RebirthAttackVo"
    }
  },
  QUICK_CAMPAIGN = {
    7,
    {campaignId = string},
    {
      code = int,
      content = "com.eyu.mt.module.cost.model.CostAndReward"
    }
  }
}
types = {
  ["facade.RebirthResults"] = const({
    BUY_TIME_LIMIT = -29,
    BATTLE_FINISHED = -28,
    EMBATTLE_ERROR = -27,
    NOT_ALLOW = -26,
    HERO_LEADER_LIMIT = -25,
    ENTER_TIMES_LIMIT = -24,
    HERO_PACK_FULL = -23,
    ENTER_NOT_ENOUGH = -22,
    ACTIVITY_INVAILD = -21,
    INVALID_TIMES = -18,
    BLOCK_BY_PROGRESS = -17,
    INVALID_CAMPAIGN_ID = -16,
    BLOCK_BY_LEVEL = -15,
    BATTLE_NOT_FINISHED = -14,
    INVALID_CHEST_IDX = -13,
    BATTLE_CANNOT_FINISH = -12,
    CHARGE_FAIL = -11,
    BLOCK_BY_COOLTIME = -9,
    INVALID_MOVE = -8,
    POINT_NOT_FOUND = -7,
    BLOCK_BY_DEAD = -6,
    BATTLE_NOT_ENTER = -5,
    BATTLE_NOT_FOUND = -4,
    ENTER_NOT_ALLOW = -3,
    PREV_BATTLE_UNFINISHED = -2,
    INVALID_BATTLE_ID = -1,
    SUCCESS = 0
  }),
  ["model.RebirthAttackVo"] = {
    battleId = string,
    costAndReward = "com.eyu.mt.module.cost.model.CostAndReward",
    finished = bool,
    groupNum = int,
    hasDemog = bool,
    triggers = array("com.eyu.mt.module.rebirth.model.RebirthTriggerVo")
  },
  ["model.RebirthProgressVo"] = {
    activeBuys = map(string, int),
    activeCounts = map(string, int),
    battles = array(string),
    buyCount = int
  },
  ["model.RebirthTriggerVo"] = {
    coins = int,
    drops = array(array("com.eyu.mt.module.reward.model.RewardType")),
    enemyNum = int,
    index = int,
    reports = array(bytearray),
    success = bool
  },
  ["model.RecordItem"] = {
    fightScore = int,
    groups = array("com.eyu.mt.module.hero.model.RankGroupVo"),
    id = long,
    lostHp = int,
    name = string,
    round = int,
    time = date
  }
}
NetMsg:Import(...)
