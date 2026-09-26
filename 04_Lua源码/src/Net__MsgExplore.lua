local NetMsg = Singleton(NetMsg)
module(...)
NetMsg:Setup(...)
mod = 86
cmd = {
  LOAD_EXPLORE_INFO = {
    1,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.explore.model.ExploreVo"
    }
  },
  COST_REFRESH_RELEASE = {
    2,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.explore.model.CostRefreshVo"
    }
  },
  EXECUTE_TASK = {
    3,
    {
      friends = array("com.eyu.mt.module.explore.model.HireCardVo"),
      rate = int,
      selfs = array("com.eyu.mt.module.explore.model.HireCardVo"),
      taskId = long,
      virtuals = array(int)
    },
    {
      code = int,
      content = "com.eyu.mt.module.explore.model.ExecuteTaskVo"
    }
  },
  IMMEDIATE_FINISH = {
    4,
    {long},
    {
      code = int,
      content = "com.eyu.mt.module.explore.model.DrawTaskRewardVo"
    }
  },
  GET_FRIEND_CARDS = {
    5,
    {},
    {
      code = int,
      content = array("com.eyu.mt.module.explore.model.FriendLeaderVo")
    }
  },
  DRAW_TASK_REWARD = {
    6,
    {long},
    {
      code = int,
      content = "com.eyu.mt.module.explore.model.DrawTaskRewardVo"
    }
  },
  UP_NPC_LEVEL = {
    7,
    {},
    {
      code = int,
      content = "com.eyu.mt.module.explore.model.UpNPCLevelVo"
    }
  },
  OWNER_FIGHT_SCORE = {
    8,
    {
      array(long)
    },
    {
      code = int,
      content = map(long, int)
    }
  },
  BUY_NPC_EXP = {
    9,
    {int},
    {
      code = int,
      content = "com.eyu.mt.module.explore.model.BuyNPCExpVO"
    }
  }
}
types = {
  ["facade.ExploreResult"] = const({
    EXECUTING_HERO_NOT_FIGHTER = -31,
    EXECUTE_SELECT_LIMIT = -30,
    TASK_REFRESH_FAILED = -29,
    EXECUTING_SMAE_NAME_HERO = -28,
    BUY_EXP_INVAILD = -27,
    BUY_EXP_LIMIT = -26,
    NPC_EXP_ENOUGH = -25,
    EXECUTING_OTHER_TASK = -24,
    OWNER_HERO_NOT_FOUND = -23,
    INVAILD_HIRE_FRIEND = -22,
    NPC_LIMIT_LIMIT = -21,
    NPC_EXP_NOT_ENOUGH = -20,
    EXECUTING_REPEAT_HERO = -19,
    EXECUTING_HERO_STAR_LIMIT = -18,
    COST_FINISH_TIMES_LIMIT = -17,
    TASK_EXECUTE_CD = -16,
    TASK_HAS_NOT_EXECUTE = -15,
    INVAILD_HIRE_VIRTUAL = -14,
    TASK_HIRE_VIRTUAL_LIMIT = -13,
    TASK_HIRE_FRIEND_LIMIT = -12,
    HIRE_VIRTUAL_LIMIT = -11,
    HIRE_FRIEND_LIMIT = -10,
    INVAILD_EXECUTE_CARD_COUNT = -9,
    EXECUTE_CON_COUNT_LIMIT = -8,
    INVAILD_RATE = -7,
    HIRE_CARD_OVERDUE = -6,
    TASK_NOT_FOUND = -5,
    TASK_HAS_EXECUTING = -4,
    INVAILD_RELEASE_TASK = -3,
    COST_NOT_ENOUGH = -2,
    ACTIVITY_NOT_OPEN = -1
  }),
  ["model.BuyNPCExpVO"] = {
    costResults = array("com.eyu.mt.module.cost.model.CostResult"),
    npcCurrentInfo = "com.eyu.mt.module.explore.model.NPCCurrentInfo"
  },
  ["model.CostRefreshVo"] = {
    costRefreshTimes = int,
    costResults = array("com.eyu.mt.module.cost.model.CostResult"),
    releases = array("com.eyu.mt.module.explore.model.ReleaseTaskItemVo")
  },
  ["model.DrawTaskRewardVo"] = {
    costResults = array("com.eyu.mt.module.cost.model.CostResult"),
    executeHeros = array(long),
    executes = array("com.eyu.mt.module.explore.model.ExecuteTaskItemVo"),
    rewardResults = array("com.eyu.mt.module.reward.model.RewardResult"),
    success = bool
  },
  ["model.ExecuteTaskItemVo"] = {
    decreaseCD = int,
    endAt = date,
    exceTimes = int,
    fightScore = int,
    friendCards = array("com.eyu.mt.module.explore.model.HireCardVo"),
    id = long,
    point = int,
    rate = int,
    reward = int,
    selfCards = array("com.eyu.mt.module.explore.model.HireCardVo"),
    star = int,
    successItems = array("com.eyu.mt.module.explore.model.TaskSuccessItem"),
    virtualCards = array(int)
  },
  ["model.ExecuteTaskVo"] = {
    costResults = array("com.eyu.mt.module.cost.model.CostResult"),
    executeHeros = array(long),
    executes = array("com.eyu.mt.module.explore.model.ExecuteTaskItemVo"),
    hireFriendTimes = int,
    hireVirtualTimes = int,
    releases = array("com.eyu.mt.module.explore.model.ReleaseTaskItemVo")
  },
  ["model.ExploreVo"] = {
    costFinishTimes = int,
    costRefreshTimes = int,
    executeHeros = array(long),
    executes = array("com.eyu.mt.module.explore.model.ExecuteTaskItemVo"),
    exp = int,
    hireFriendTimes = int,
    hireVirtualTimes = int,
    level = int,
    nextRefresh = date,
    releases = array("com.eyu.mt.module.explore.model.ReleaseTaskItemVo")
  },
  ["model.FriendLeaderVo"] = {
    artifactLevel = int,
    baseId = int,
    cultivateVo = "com.eyu.mt.module.cultivate.model.HeroCultivateVo",
    equips = array("com.eyu.mt.module.equip.model.EquipVo"),
    heroId = long,
    heroLevel = int,
    id = long,
    level = int,
    name = string,
    powerSkill = int,
    pvpDesId = int,
    score = int,
    talisman = array("com.eyu.mt.module.talisman.model.TalismanVo"),
    userBuffs = array(string)
  },
  ["model.HireCardVo"] = {
    baseId = int,
    id = long,
    owner = long,
    score = int
  },
  ["model.NPCCurrentInfo"] = {exp = long, level = int},
  ["model.ReleaseTaskItemVo"] = {
    cardCount = int,
    decreaseCD = int,
    exceTimes = int,
    id = long,
    point = int,
    rate = int,
    reward = int,
    star = int,
    successItems = array("com.eyu.mt.module.explore.model.TaskSuccessItem")
  },
  ["model.TaskSuccessItem"] = {
    amount = int,
    items = array(int),
    rate = int
  },
  ["model.UpNPCLevelVo"] = {
    npcCurrentInfo = "com.eyu.mt.module.explore.model.NPCCurrentInfo",
    releases = array("com.eyu.mt.module.explore.model.ReleaseTaskItemVo")
  }
}
NetMsg:Import(...)
