local NetMsg = Singleton(NetMsg)
module(...)
NetMsg:Setup(...)
types = {
  ["facade.CostResult"] = const({
    TENCENT_OPERATE_FAILED = -314,
    BATTLE_COUNT_ENOUGH = -313,
    HERO_NOT_ENOUGH = -312,
    HERO_NOT_FOUND = -311,
    NOT_SUPPORT = -310,
    GROW_NOT_ENOUGH = -309,
    TREASURE_REPEAT = -308,
    TREASURE_NOT_FOUND = -307,
    TREASURE_FORMAT_INVALID = -306,
    COST_INVALID_AMOUNT = -305,
    CURRENCY_NOT_ENOUGH = -304,
    COST_ITEM_NOT_FOUND = -303,
    MANAGE_NOT_EXIT = -302,
    AMOUNT_NOT_ENOUGH = -301
  }),
  ["model.CostAndReward"] = {
    costs = array("com.eyu.mt.module.cost.model.CostResult"),
    rewards = array("com.eyu.mt.module.reward.model.RewardResult")
  },
  ["model.CostResult"] = {
    amount = int,
    code = int,
    contents = object,
    type = "com.eyu.mt.module.cost.model.CostType"
  },
  ["model.CostType"] = enum({
    [0] = "CURRENCY",
    [1] = "ITEM",
    [2] = "EQUIP",
    [3] = "FRAGMENT",
    [4] = "ACTION_POINT",
    [5] = "HERO",
    [6] = "DEMOG_FRAGMENT",
    [7] = "VIP_TIME",
    [8] = "MENPAI_MONEY",
    [9] = "MOON",
    [10] = "SWEET",
    [11] = "TURKEY",
    [12] = "TALISMAN",
    [13] = "EQUIPMENT"
  }),
  ["model.DeductReward"] = {
    costs = array("com.eyu.mt.module.cost.model.CostResult"),
    rewards = array("com.eyu.mt.module.reward.model.Reward")
  }
}
NetMsg:Import(...)
