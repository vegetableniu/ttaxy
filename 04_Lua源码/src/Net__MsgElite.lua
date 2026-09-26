local NetMsg = Singleton(NetMsg)
module(...)
NetMsg:Setup(...)
mod = 61
cmd = {
  PROGRESS = {
    1,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.elite.model.EliteProgressVo"
    }
  },
  MULTI_ACTION = {
    2,
    {
      battleId = string,
      embattle = array(array(array(long))),
      quick = bool
    },
    {
      code = int,
      content = "com.eyu.mt.module.elite.model.EliteAttackVo"
    }
  },
  BUY_TIMES = {
    6,
    {battleId = string},
    {
      code = int,
      content = "com.eyu.mt.module.arena.model.BuyTimesVO"
    }
  },
  RECORD = {
    7,
    {battleId = string},
    {
      code = int,
      content = array("com.eyu.mt.module.elite.model.EliteRecordItem")
    }
  },
  GET_BATTLES_TIMES = {
    8,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.elite.model.BattlesTimesVo"
    }
  },
  QUICK_ADVANCE = {
    9,
    {advanceCount = int, battleId = string},
    {
      code = int,
      content = "com.eyu.mt.module.battle.model.QuickVo"
    }
  },
  FIRST_RECORD = {
    10,
    {battleId = string},
    {
      code = int,
      content = array("com.eyu.mt.module.elite.model.EliteRecordItem")
    }
  }
}
types = {
  ["facade.EliteResult"] = const({
    CULTIVATE_STATE_LIMIT = -24,
    ADVANCE_COUNT_LIMIT = -23,
    EQUIP_PACK_FULL = -22,
    PREVIOUS_GENERAL_BATTLE_LIMIT = -21,
    INVALID_MOVE = -20,
    HERO_LEADER_LIMIT = -19,
    HERO_PACK_FULL = -18,
    BLOCK_BY_LEVEL = -17,
    BLOCK_BY_COOLTIME = -16,
    PREV_BATTLE_UNFINISHED = -15,
    CURRENCY_NOT_ENOUGH = -14,
    BUY_TIME_LIMIT = -13,
    POINT_NOT_FOUND = -12,
    ENTER_NOT_ENOUGH = -11,
    BLOCK_BY_PROGRESS = -10,
    ACTIVITY_INVAILD = -9,
    NOT_ALLOW = -8,
    BATTLE_NOT_FINISHED = -7,
    BATTLE_FINISHED = -6,
    BLOCK_BY_DEAD = -5,
    BATTLE_NOT_ENTER = -4,
    INVALID_BATTLE_ID = -3,
    BATTLE_NOT_FOUND = -2,
    EMBATTLE_ERROR = -1
  }),
  ["model.BattlesTimesVo"] = {
    battleBuys = map(string, map(string, int)),
    battleCounts = map(string, map(string, int))
  },
  ["model.EliteAttackVo"] = {
    battleId = string,
    costAndReward = "com.eyu.mt.module.cost.model.CostAndReward",
    finished = bool,
    groupNum = int,
    hasDemog = bool,
    triggers = array("com.eyu.mt.module.elite.model.EliteTriggerVo")
  },
  ["model.EliteProgressVo"] = {
    activeBuys = map(string, map(string, int)),
    activeCounts = map(string, map(string, int)),
    battles = array(string),
    campaigns = array(string)
  },
  ["model.EliteRecordItem"] = {
    fightScore = int,
    groups = array("com.eyu.mt.module.hero.model.RankGroupVo"),
    id = long,
    lostHp = int,
    name = string,
    round = int,
    time = date
  },
  ["model.EliteTriggerVo"] = {
    coins = int,
    drops = array(array("com.eyu.mt.module.reward.model.RewardType")),
    enemyNum = int,
    index = int,
    reports = array(bytearray),
    success = bool
  }
}
NetMsg:Import(...)
