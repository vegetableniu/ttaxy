local NetMsg = Singleton(NetMsg)
module(...)
NetMsg:Setup(...)
mod = 158
cmd = {
  ENEMY_ENEMY = {
    1,
    {attacker = string, defender = string},
    {
      code = int,
      content = "com.eyu.mt.test.fight.model.FightReport"
    }
  },
  PLAYER_ENEMY = {
    2,
    {enemy = string, player = string},
    {
      code = int,
      content = "com.eyu.mt.test.fight.model.FightReport"
    }
  },
  PLAYER_PLAYER = {
    3,
    {attacker = string, defender = string},
    {
      code = int,
      content = "com.eyu.mt.test.fight.model.FightReport"
    }
  },
  COUNT_ENEMY_ENEMY = {
    4,
    {
      attacker = string,
      defender = string,
      times = int
    },
    {
      code = int,
      content = "com.eyu.mt.test.fight.model.BattleInfo"
    }
  },
  COUNT_PLAYER_ENEMY = {
    5,
    {
      enemy = string,
      player = string,
      times = int
    },
    {
      code = int,
      content = "com.eyu.mt.test.fight.model.BattleInfo"
    }
  },
  COUNT_PLAYER_PLAYER = {
    6,
    {
      attacker = string,
      defender = string,
      times = int
    },
    {
      code = int,
      content = "com.eyu.mt.test.fight.model.BattleInfo"
    }
  }
}
types = {
  ["facade.FightResult"] = const({
    UNKNONW_ERROR = -255,
    INVALID_TIMES = -3,
    INVALID_PLAYER_ID = -2,
    INVALID_ENEMY_ID = -1,
    SUCCESS = 0
  }),
  ["model.BattleInfo"] = {
    attackerHps = map("com.eyu.mt.module.fight.model.BattleResult", double),
    defenderHps = map("com.eyu.mt.module.fight.model.BattleResult", double),
    rounds = map("com.eyu.mt.module.fight.model.BattleResult", double),
    times = map("com.eyu.mt.module.fight.model.BattleResult", int)
  },
  ["model.BattleResult"] = enum({
    [0] = "ATTACKER",
    [1] = "DEFENDER",
    [2] = "TIE",
    [3] = "ALL_DEAD"
  }),
  ["model.BattleType"] = enum({
    [0] = "MOCK",
    [1] = "TEST",
    [2] = "SINGLE",
    [3] = "ARENA",
    [4] = "DEMOG",
    [5] = "REBIRTH",
    [6] = "LIMITED",
    [7] = "FULLED",
    [8] = "PVP",
    [9] = "MENPAI",
    [10] = "MENPAI_COUNTRY",
    [11] = "ELITE",
    [12] = "CULTIVATE_CROSSING"
  }),
  ["model.FightReport"] = {json = string, reports = bytearray},
  ["model.UnitRace"] = enum({
    [0] = "YAO",
    [1] = "XIAN",
    [2] = "LING"
  })
}
NetMsg:Import(...)
