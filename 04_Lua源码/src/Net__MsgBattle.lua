module(...)
Singleton(NetMsg):Setup(...)
mod = 22
cmd = {
  PROGRESS = {
    1,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.battle.model.ProgressVo"
    }
  },
  ENTER = {
    2,
    {
      battleId = string,
      embattle = array(array(long)),
      friend = long
    },
    {
      code = int,
      content = "com.eyu.mt.module.battle.model.EnterVo"
    }
  },
  RESUME = {
    3,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.battle.model.ResumeVo"
    }
  },
  TRIGGER = {
    4,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.battle.model.TriggerVo"
    }
  },
  EXIT = {
    5,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.battle.model.ExitVo"
    }
  },
  ACTIVES = {
    6,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.battle.model.ActiveVo"
    }
  },
  DAILYCOUNT = {
    7,
    {},
    {
      code = int,
      content = map(string, int)
    }
  },
  QUICK_BATTLE = {
    8,
    {
      battleId = string,
      embattle = array(array(long)),
      friend = long,
      requestId = string
    },
    {
      code = int,
      content = "com.eyu.mt.module.battle.model.QuickVo"
    }
  },
  MULTI_ACTION = {
    9,
    {
      battleId = string,
      embattle = array(array(long)),
      friend = long
    },
    {
      code = int,
      content = array("com.eyu.mt.module.battle.model.TriggerVo")
    }
  },
  QUICK_ADVANCE = {
    10,
    {
      battleId = string,
      friend = long,
      requestId = string
    },
    {
      code = int,
      content = "com.eyu.mt.module.battle.model.QuickVo"
    }
  },
  FIRST_RECORD = {
    11,
    {battleId = string},
    {
      code = int,
      content = array("com.eyu.mt.module.rebirth.model.RecordItem")
    }
  },
  BEST_RECORD = {
    12,
    {battleId = string},
    {
      code = int,
      content = array("com.eyu.mt.module.rebirth.model.RecordItem")
    }
  }
}
types = {
  ["facade.SingleResults"] = const({
    BATTLE_FINISHED = -28,
    EMBATTLE_ERROR = -27,
    NOT_ALLOW = -26,
    HERO_LEADER_LIMIT = -25,
    ENTER_TIMES_LIMIT = -24,
    HERO_PACK_FULL = -23,
    ENTER_NOT_ENOUGH = -22,
    ACTIVITY_INVAILD = -21,
    HOOK_NOT_FINISHED = -20,
    HOOK_NOT_START = -19,
    INVALID_TIMES = -18,
    BLOCK_BY_PROGRESS = -17,
    INVALID_CAMPAIGN_ID = -16,
    BLOCK_BY_LEVEL = -15,
    BATTLE_NOT_FINISHED = -14,
    INVALID_CHEST_IDX = -13,
    BATTLE_CANNOT_FINISH = -12,
    CHARGE_FAIL = -11,
    BUY_TIMES_NOT_ENOUGH = -10,
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
  ["model.ActiveBattleVo"] = {
    id = string,
    startTime = date,
    stopTime = date
  },
  ["model.ActiveVo"] = {
    activeCounts = map(string, map(string, int)),
    actives = array("com.eyu.mt.module.battle.model.ActiveBattleVo")
  },
  ["model.EnterVo"] = {
    battleId = string,
    remains = int,
    totalEnemies = int
  },
  ["model.ExitVo"] = {
    costAndReward = "com.eyu.mt.module.cost.model.CostAndReward",
    failedTimes = int,
    hasDemog = bool
  },
  ["model.ProgressVo"] = {
    battles = array(string),
    campaigns = array(string),
    current = "com.eyu.mt.module.battle.model.ResumeVo",
    dailyCounts = map(string, int)
  },
  ["model.QuickVo"] = {
    assistant = "com.eyu.mt.module.sociality.model.CommendVo",
    battleId = string,
    exitVo = "com.eyu.mt.module.battle.model.ExitVo",
    failed = bool,
    finished = bool
  },
  ["model.ResumeVo"] = {
    assistant = "com.eyu.mt.module.sociality.model.CommendVo",
    battleId = string,
    coins = int,
    equips = int,
    failed = bool,
    finished = bool,
    fragments = int,
    heros = int,
    remains = int,
    totalEnemies = int
  },
  ["model.TriggerVo"] = {
    coins = int,
    drops = array(array("com.eyu.mt.module.reward.model.RewardType")),
    finished = bool,
    index = int,
    reports = bytearray,
    success = bool
  }
}
Singleton(NetMsg):Import(...)
