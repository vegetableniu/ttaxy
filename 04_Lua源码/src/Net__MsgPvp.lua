local NetMsg = Singleton(NetMsg)
module(...)
NetMsg:Setup(...)
mod = 29
cmd = {
  GET_PVP_INFO = {
    1,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.pvp.model.PvpInfoVO"
    }
  },
  DEFY_MATCH = {
    2,
    {
      embattle = array(array(array(long))),
      rank = int,
      targetId = long,
      targetRank = int
    },
    {
      code = int,
      content = "com.eyu.mt.module.pvp.model.DefyResultVO"
    }
  },
  GET_RANK_LIST = {
    3,
    {},
    {
      code = int,
      content = array("com.eyu.mt.module.pvp.model.PvpRankVO")
    }
  },
  LINEUP_COMPARE = {
    4,
    {id = long},
    {
      code = int,
      content = "com.eyu.mt.module.arena.model.LineupCompareVO"
    }
  },
  CLEAR_COOL_DOWN = {
    5,
    {},
    {
      code = int,
      content = array("com.eyu.mt.module.cost.model.CostResult")
    }
  }
}
types = {
  ["facade.PvpResult"] = const({
    COOL_DOWN_END = -10,
    CAN_NOT_DEFY_SELF = -9,
    ARGUMENT_ILLEGAL = -8,
    MATCH_PLAYER_NOT_EXIST = -7,
    EMBATTLE_ERROR = -6,
    RANK_CHANGED = -5,
    DEFY_COOL_DOWN = -4,
    HERO_GROUP_LEADER_LIMIT = -3,
    HERO_LEADER_LIMIT = -2,
    ACTION_POINT_NOT_ENOUGH = -1
  }),
  ["model.AttackedRecordVO"] = {
    id = long,
    name = string,
    newRank = int,
    oldRank = int,
    win = bool
  },
  ["model.DefyResultVO"] = {
    coolDown = int,
    costAndReward = "com.eyu.mt.module.cost.model.CostAndReward",
    groupNum = int,
    leaderBaseId = int,
    matchList = array("com.eyu.mt.module.pvp.model.MatchPlayerVO"),
    oldRank = int,
    reports = array(bytearray),
    targetArtifactLevel = int,
    targetGroupNum = int,
    virtualId = long,
    virtualName = string,
    win = bool
  },
  ["model.MatchPlayerVO"] = {
    battleScore = int,
    desId = int,
    id = long,
    leaderBaseId = int,
    level = int,
    name = string,
    rank = int,
    virtual = bool
  },
  ["model.PvpInfoVO"] = {
    attacked = bool,
    attackedRecord = array("com.eyu.mt.module.pvp.model.AttackedRecordVO"),
    coolDown = int,
    matchList = array("com.eyu.mt.module.pvp.model.MatchPlayerVO"),
    winRanks = array(int)
  },
  ["model.PvpRankVO"] = {
    artifactLevel = int,
    battleScore = int,
    cultivateVo = "com.eyu.mt.module.cultivate.model.HeroCultivateVo",
    desId = int,
    id = long,
    leaderBaseId = int,
    leaderEquip = array("com.eyu.mt.module.equip.model.EquipVo"),
    leaderLevel = int,
    leaderTalisman = array("com.eyu.mt.module.talisman.model.TalismanVo"),
    level = int,
    name = string,
    rank = int,
    userBuffs = array(string),
    vip = bool
  }
}
NetMsg:Import(...)
