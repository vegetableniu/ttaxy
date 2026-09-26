module((...), package.seeall)
class = Logic.class:subclass()
OPT = Enum({
  "OPT_ADDORSUB_EQUIP",
  "OPT_CONCEAL_INFO"
})
function class:initialize()
  super.initialize(self)
  self.allEquipNum = 0
  self.equipCardMax = 5
  self.equipAndHeroInfo = {
    {
      card = nil,
      displayCardInfo = nil,
      IsBattling = false
    },
    {
      card = nil,
      displayCardInfo = nil,
      IsBattling = false
    },
    {
      card = nil,
      displayCardInfo = nil,
      IsBattling = false
    },
    {
      card = nil,
      displayCardInfo = nil,
      IsBattling = false
    },
    {
      card = nil,
      displayCardInfo = nil,
      IsBattling = false
    }
  }
  self.allEquipInfo = {
    {
      equipid = 20011,
      goodspath = "",
      amount = 0,
      equipName = "",
      sellPrice = 0,
      countNum = 0
    },
    {
      equipid = 20012,
      goodspath = "",
      amount = 0,
      equipName = "",
      sellPrice = 0,
      countNum = 0
    },
    {
      equipid = 20013,
      goodspath = "",
      amount = 0,
      equipName = "",
      sellPrice = 0,
      countNum = 0
    },
    {
      equipid = 20014,
      goodspath = "",
      amount = 0,
      equipName = "",
      sellPrice = 0,
      countNum = 0
    },
    {
      equipid = 20015,
      goodspath = "",
      amount = 0,
      equipName = "",
      sellPrice = 0,
      countNum = 0
    },
    {
      equipid = 20021,
      goodspath = "",
      amount = 0,
      equipName = "",
      sellPrice = 0,
      countNum = 0
    },
    {
      equipid = 20022,
      goodspath = "",
      amount = 0,
      equipName = "",
      sellPrice = 0,
      countNum = 0
    },
    {
      equipid = 20023,
      goodspath = "",
      amount = 0,
      equipName = "",
      sellPrice = 0,
      countNum = 0
    },
    {
      equipid = 20024,
      goodspath = "",
      amount = 0,
      equipName = "",
      sellPrice = 0,
      countNum = 0
    },
    {
      equipid = 20025,
      goodspath = "",
      amount = 0,
      equipName = "",
      sellPrice = 0,
      countNum = 0
    },
    {
      equipid = 20031,
      goodspath = "",
      amount = 0,
      equipName = "",
      sellPrice = 0,
      countNum = 0
    },
    {
      equipid = 20032,
      goodspath = "",
      amount = 0,
      equipName = "",
      sellPrice = 0,
      countNum = 0
    },
    {
      equipid = 20033,
      goodspath = "",
      amount = 0,
      equipName = "",
      sellPrice = 0,
      countNum = 0
    },
    {
      equipid = 20034,
      goodspath = "",
      amount = 0,
      equipName = "",
      sellPrice = 0,
      countNum = 0
    },
    {
      equipid = 20035,
      goodspath = "",
      amount = 0,
      equipName = "",
      sellPrice = 0,
      countNum = 0
    },
    {
      equipid = 20041,
      goodspath = "",
      amount = 0,
      equipName = "",
      sellPrice = 0,
      countNum = 0
    },
    {
      equipid = 20042,
      goodspath = "",
      amount = 0,
      equipName = "",
      sellPrice = 0,
      countNum = 0
    },
    {
      equipid = 20043,
      goodspath = "",
      amount = 0,
      equipName = "",
      sellPrice = 0,
      countNum = 0
    },
    {
      equipid = 20044,
      goodspath = "",
      amount = 0,
      equipName = "",
      sellPrice = 0,
      countNum = 0
    },
    {
      equipid = 20045,
      goodspath = "",
      amount = 0,
      equipName = "",
      sellPrice = 0,
      countNum = 0
    },
    {
      equipid = 20051,
      goodspath = "",
      amount = 0,
      equipName = "",
      sellPrice = 0,
      countNum = 0
    },
    {
      equipid = 20052,
      goodspath = "",
      amount = 0,
      equipName = "",
      sellPrice = 0,
      countNum = 0
    },
    {
      equipid = 20053,
      goodspath = "",
      amount = 0,
      equipName = "",
      sellPrice = 0,
      countNum = 0
    },
    {
      equipid = 20054,
      goodspath = "",
      amount = 0,
      equipName = "",
      sellPrice = 0,
      countNum = 0
    },
    {
      equipid = 20055,
      goodspath = "",
      amount = 0,
      equipName = "",
      sellPrice = 0,
      countNum = 0
    }
  }
end
function class:initAllEquip()
  for i = 1, #self.allEquipInfo do
    local eachEquipInfo = KFDBGetRecord("ItemConfig", self.allEquipInfo[i].equipid)
    if eachEquipInfo == nil then
      return
    end
    local eachEquipNum = Logic:Get("Equip"):GetEquipAmount(self.allEquipInfo[i].equipid)
    if eachEquipNum == nil then
      return
    end
    self:setEachEquip(self.allEquipInfo[i], eachEquipInfo, eachEquipNum)
  end
end
function class:getEquipCardMax()
  return self.equipCardMax
end
function class:setEachEquip(equipTable, eachEquipInfo, eachEquipNum)
  equipTable.goodspath = eachEquipInfo.MiddleCard
  equipTable.amount = eachEquipNum
  equipTable.equipName = eachEquipInfo.name
  equipTable.sellPrice = eachEquipInfo.sellPrice
end
function class:getAllEquipInfo()
  return self.allEquipInfo
end
function class:setAmount(idx, num)
  if idx > #self.allEquipInfo then
    return
  end
  self.allEquipInfo[idx].amount = num
end
function class:getAmount()
end
function class:setCountNum(idx, num)
  if idx > #self.allEquipInfo then
    return
  end
  self.allEquipInfo[idx].countNum = num
end
function class:getCountNum()
end
function class:addAllEquipNum(num)
  self.allEquipNum = self.allEquipNum + num
end
function class:subAllEquipNum(num)
  self.allEquipNum = self.allEquipNum - num
end
function class:getAllEquipNum()
  return self.allEquipNum
end
function class:getSaleEquipCount()
  local result = 0
  for i, v in ipairs(self.allEquipInfo) do
    result = result + v.countNum * v.sellPrice
  end
  return result
end
function class:reSetEquipInfo()
  for i, v in ipairs(self.allEquipInfo) do
    v.amount = v.amount - v.countNum
    v.countNum = 0
  end
  self.allEquipNum = 0
end
function class:resumeEquipInfo()
  for i, v in ipairs(self.allEquipInfo) do
    v.countNum = 0
  end
  self.allEquipNum = 0
end
function class:setEquipAndHeroInfo(index, card, cardInfo, boolVal, heroCard)
  if index > self.equipCardMax then
    return
  end
  self.equipAndHeroInfo[index].card = card
  self.equipAndHeroInfo[index].displayCardInfo = cardInfo
  self.equipAndHeroInfo[index].IsBattling = boolVal
  self.equipAndHeroInfo[index].heroCard = heroCard
end
function class:getEquipAndHeroInfo(index)
  if index > self.equipCardMax then
    return nil
  end
  return self.equipAndHeroInfo[index]
end
function class:initEquipAndHeroInfo()
  for i, v in ipairs(self.equipAndHeroInfo) do
    v.card = nil
    v.displayCardInfo = nil
    v.IsBattling = false
  end
end
function class:getAllCard()
  return self.equipAndHeroInfo
end
