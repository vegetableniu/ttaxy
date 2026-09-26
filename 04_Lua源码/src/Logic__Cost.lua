module((...), package.seeall)
require("Logic")
class = Logic.class:subclass()
COST_TYPE = TypeDef("com.eyu.mt.module.cost.model.CostType")
CURRENCY_TYPE = TypeDef("com.eyu.mt.module.currency.model.CurrencyType")
CURRENCY_CODE = Enum(CURRENCY_TYPE)
CURRENCY_TYPE_NAME = {}
CURRENCY_TYPE_NAME[CURRENCY_TYPE.COPPER] = "103008"
CURRENCY_TYPE_NAME[CURRENCY_TYPE.GOLD] = "103009"
CURRENCY_TYPE_NAME[CURRENCY_TYPE.GIFT] = "103010"
CURRENCY_TYPE_NAME[CURRENCY_TYPE.INTER] = "103011"
CURRENCY_TYPE_NAME[CURRENCY_TYPE.EXCHANGE] = "103012"
CURRENCY_TYPE_NAME[CURRENCY_TYPE.FRIENDSHIP] = "103013"
CURRENCY_TYPE_NAME[CURRENCY_TYPE.PURPLE] = "108813"
CURRENCY_TYPE_NAME[CURRENCY_TYPE.ORANGE] = "108814"
function class:initialize()
  super.initialize(self)
end
function class:CostAndReward(content, bNoTip)
  self:AddCosts(content.costs, bNoTip)
  Logic:Get("Reward"):AddRewards(content.rewards, bNoTip)
end
function class:AddCosts(costs, bNoTip)
  if costs == nil then
    return
  end
  for i = 1, #costs do
    self:Costs(costs[i], bNoTip)
  end
end
function class:Costs(cost, bNoTip)
  if cost == nil then
    return
  end
  if cost.type == COST_TYPE.CURRENCY then
    local ItemType = Enum(TypeDef("com.eyu.mt.module.currency.model.CurrencyType"))
    local walletType = string.lower(ItemType[cost.code])
    Logic:Get("PlayerInfo"):PlayerMoneyChange(cost.code, cost.amount, Logic.PlayerInfo.PLAYER_DATA_CHANGE.ADD)
  elseif cost.type == COST_TYPE.ITEM then
    Logic:Get("Compose"):UpdataItem(cost)
  elseif cost.type == COST_TYPE.EQUIP then
    Logic:Get("Compose"):UpdataItem(cost)
  elseif cost.type == COST_TYPE.FRAGMENT then
    Logic:Get("Compose"):UpdataItem(cost)
  elseif cost.type == COST_TYPE.ACTION_POINT then
    local getPhysical = Logic:Get("PlayerInfo"):GetPlayerPhysical()
    getPhysical.point = cost.contents.point
    getPhysical.refreshTime = cost.contents.refreshTime
    Logic:Get("PlayerInfo"):InitPhysical(getPhysical)
  elseif cost.type == COST_TYPE.HERO then
    if cost.contents and cost.contents.id then
      Logic:Get("Hero"):RemoveCard(cost.contents.id)
      Logic:Get("Lineup"):removeHero(cost.contents.id)
    end
  elseif cost.type == COST_TYPE.SWEET then
    Logic:Get("HallowmasShop"):costSweet(cost)
  elseif cost.type == COST_TYPE.TURKEY then
    Logic:Get("ThanksgivingDay"):setTurkey(cost)
  elseif cost.type == COST_TYPE.EQUIPMENT then
    Logic:Get("Armor"):removeOneArmor(cost.contents.id)
  elseif cost.type == COST_TYPE.TALISMAN then
    Logic:Get("Talisman"):UpDataTailsmans_Dele(cost.contents.id)
  end
end
