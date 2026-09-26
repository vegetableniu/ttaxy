local NetMsg = Singleton(NetMsg)
module(...)
NetMsg:Setup(...)
mod = 12
cmd = {
  GET_ITEMS = {
    1,
    {},
    {
      code = int,
      content = array("com.eyu.mt.module.item.manager.Item")
    }
  },
  COMPOSE_ITEM = {
    2,
    {extend = bool, itemId = long},
    {
      code = int,
      content = "com.eyu.mt.module.cost.model.CostAndReward"
    }
  },
  SELL_ITEM = {
    3,
    {amount = int, itemId = long},
    {
      code = int,
      content = "com.eyu.mt.module.cost.model.CostAndReward"
    }
  },
  SELL_ITEMS = {
    4,
    {
      map(long, int)
    },
    {
      code = int,
      content = "com.eyu.mt.module.cost.model.CostAndReward"
    }
  },
  SWAP = {
    5,
    {
      cardId = long,
      desBaseId = int,
      unitRace = "com.eyu.mt.module.fight.model.UnitRace"
    },
    {
      code = int,
      content = "com.eyu.mt.module.item.model.SwapResult"
    }
  }
}
types = {
  ["facade.ItemResult"] = const({
    CAN_NOT_DELETE_HERO = -15,
    DES_HERO_RACE_IS_NOT_MATCH = -14,
    FRAGMENT_NOT_ENOUGH = -13,
    PLAYER_LEVEL_IS_NOT_ENOUGH_TO_SWAP = -12,
    NO_RELATIVE_DES_CARD = -11,
    CARD_IS_LOCK = -10,
    CARD_IS_IN_USE = -9,
    CARD_IS_NOT_EXIST = -8,
    BOX_UNUSABLE = -7,
    GOLD_LACK = -6,
    PACK_ACHIEVE_LIMIT = -5,
    AMOUNT_NOT_ENOUGH = -4,
    SELL_NOT_ALLOWED = -3,
    ITEM_NOT_FOUND = -2,
    ARGUMENT_ILLEGAL = -1
  }),
  ["manager.Item"] = {
    amount = int,
    baseId = int,
    content = string,
    id = long,
    owner = long,
    type = "com.eyu.mt.module.item.model.ItemType"
  },
  ["model.ItemType"] = enum({
    [0] = "ITEM",
    [1] = "EQUIP",
    [2] = "FRAGMENT"
  }),
  ["model.SwapResult"] = {
    costResults = array("com.eyu.mt.module.cost.model.CostResult"),
    heroVo = "com.eyu.mt.module.hero.model.HeroVo"
  },
  ["model.reward.ItemInfo"] = {
    amount = int,
    baseId = int,
    content = string,
    id = long,
    itemType = "com.eyu.mt.module.item.model.ItemType",
    type = "com.eyu.mt.module.item.model.reward.ItemInfoType"
  },
  ["model.reward.ItemInfoType"] = enum({
    [0] = "ADD",
    [1] = "ALTER",
    [2] = "REMOVE"
  })
}
NetMsg:Import(...)
