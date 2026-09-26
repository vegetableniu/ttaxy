require("Logic")
require("protocol")
module((...), package.seeall)
class = Logic.class:subclass()
EVT = Enum({
  "UPDATE_TEAM",
  "USE_TEAM",
  "UPDATE_TEAM_NAME"
})
function class:initialize()
  super.initialize(self)
  self.teamInfo = {}
  self.oldName = ""
  self.updateName = ""
  self.updataGroup = {}
  self.newName = ""
  self.useName = ""
  self.talismans = {}
  self.armorMap = {}
  self.armors = {}
  MsgHero:On("UPDATE_TEAM", self:Event("onUpdataTeam"))
  MsgHero:On("USE_TEAM", self:Event("onUseTeam"))
  MsgHero:On("UPDATE_TEAM_NAME", self:Event("onUpdateTeamName"))
  MsgHero:On("GET_TEAM_INFO", self:Event("onGetTeamInfo"))
end
function class:dispose()
  super.dispose(self)
end
function class:setTeamInfo(teamInfo)
  self.teamInfo = teamInfo or {}
end
function class:getTeamInfo()
  return self.teamInfo
end
function class:getTeamLeaderByName(name)
  return self.teamInfo.teamLeaders[name] or ""
end
function class:getTeams()
  return self.teamInfo.teams or {}
end
function class:getTeamsByName(name)
  return self.teamInfo.teams[name] or {}
end
function class:setOldName(name)
  self.oldName = name
end
function class:removeHero(heroId)
  for name, leaders in pairs(self.teamInfo.teamLeaders or {}) do
    for idx, leaderId in ipairs(leaders) do
      if leaderId == heroId then
        self.teamInfo.teamLeaders[name][idx] = ID[-1]
      end
    end
  end
  for name, group in pairs(self.teamInfo.teams or {}) do
    for i, team in ipairs(group or {}) do
      for j, ids in ipairs(team) do
        for k, id in ipairs(ids) do
          if id == heroId then
            self.teamInfo.teams[name][i][j][k] = ID[0]
          end
        end
      end
    end
  end
end
function class:getAllItemsHeight()
  local itemWidth = 640
  local itemHeight = 820
  local itemInterval = 115
  local teams = self:getTeams()
  local itemCnt = table.size(teams)
  local firstItemY = itemHeight / 2 + (itemCnt - 1) * itemInterval
  local actualHeight = firstItemY + itemHeight / 2
  return actualHeight
end
function class:getArrayHerosByName(name)
  local teams = self:getTeamsByName(name)
  local result = {}
  for _, group in ipairs(teams) do
    for _, ids in ipairs(group or {}) do
      for _, id in ipairs(ids) do
        if id ~= ID[0] and id ~= ID[-1] then
          local heroInfo = Logic:Get("Hero"):GetHeroInfoById(id)
          table.insert(result, heroInfo)
        end
      end
    end
  end
  table.sort(result, function(heroInfoA, heroInfoB)
    local heroRecA = Logic:Get("Hero"):GetHeroInfoByBaseId(heroInfoA.baseId)
    local heroRecB = Logic:Get("Hero"):GetHeroInfoByBaseId(heroInfoB.baseId)
    if heroRecA.rank ~= heroRecB.rank then
      return heroRecA.rank > heroRecB.rank
    end
    if heroRecA.star ~= heroRecB.star then
      return heroRecA.star > heroRecB.star
    end
    if heroInfoA.level ~= heroInfoB.level then
      return heroInfoA.level > heroInfoB.level
    end
    local cutivateALv = Logic:Get("Cultivate"):getCutivateStateById(heroInfoA.id)
    local cutivateBLv = Logic:Get("Cultivate"):getCutivateStateById(heroInfoB.id)
    return cutivateALv > cutivateBLv
  end)
  return result
end
function class:postUpdataTeam(name)
  local sendData = {}
  self.updataGroup = self:checkGroupData()
  sendData.leaders = self.updataGroup.leaders
  sendData.teams = self.updataGroup.teams
  sendData.name = name
  self.updateName = name
  MsgHero:Post("UPDATE_TEAM", sendData)
end
function class:checkGroupData()
  local groups = Logic:Get("Hero"):GetGroups()
  local sendData = {}
  sendData.leaders = {}
  sendData.teams = {}
  for i, group in ipairs(groups) do
    local hasFriendPos = false
    for _, pos in ipairs(group.embattles) do
      for _, id in ipairs(pos) do
        if id == ID[-1] then
          hasFriendPos = true
        end
      end
    end
    if not hasFriendPos then
      log4misc:warn("group " .. i .. " has not friend position")
    end
    table.insert(sendData.leaders, group.leaderId)
    table.insert(sendData.teams, group.embattles)
  end
  return sendData
end
function class:postUseTeam(name, bAutoEquip)
  self.armors = {}
  self.talismans = {}
  local sendData = {}
  sendData.teamEquipInfos = bAutoEquip and self:getEquipArmors(name) or nil
  sendData.teamTalismanInfos = bAutoEquip and self:getEquipTalismans(name) or nil
  sendData.name = name
  self.useName = name
  MsgHero:Post("USE_TEAM", sendData)
end
function class:getEquipTalismans(name)
  local heros = self:getArrayHerosByName(name)
  local hasEquip = {}
  local lockId = Logic.Lock.LOCK_ID.TALISMAN_EQUIP_2_LOCK
  local bLockTali = Logic:Get("Lock"):GetStatusByLockId(lockId)
  local equipCnt = bLockTali and 1 or 2
  local function isCanEquip(equipMap, data)
    if hasEquip[data.id] then
      return false
    end
    if #equipMap <= 0 then
      return true
    end
    local bTalisBmutalA = equipMap[1].mutualRaces[data.race] and true or false
    local bTalisAmutalB = data.mutualRaces[equipMap[1].race] and true or false
    if bTalisBmutalA then
      return false
    end
    return not bTalisAmutalB
  end
  local result = {}
  local function filterTali(equipList)
    local equipMap = {}
    local filterResult = {}
    for i, v in ipairs(equipList) do
      if #filterResult >= equipCnt then
        return filterResult
      end
      if isCanEquip(equipMap, v) then
        hasEquip[v.id] = v
        table.insert(filterResult, v.id)
        table.insert(equipMap, v)
      end
    end
    if table.empty(filterResult) then
      return nil
    end
    return filterResult
  end
  for i, heroInfo in ipairs(heros) do
    local canEquipList = self:canEquipTaliList(heroInfo.baseId)
    local heroTaliman = {}
    heroTaliman.heroId = heroInfo.id
    heroTaliman.talismanId = filterTali(canEquipList)
    self.talismans[heroTaliman.heroId] = heroTaliman.talismanId
    table.insert(result, heroTaliman)
  end
  return result
end
function class:canEquipTaliList(baseId)
  local map = self.talismanMap
  local heroRec = Logic:Get("Hero"):GetHeroInfoByBaseId(baseId)
  local playerLv = Logic:Get("PlayerInfo"):GetPlayerLevel()
  local resultTalisman = {}
  for id, v in pairs(map[heroRec.type] or {}) do
    if heroRec.star >= v.starLevel[1] and heroRec.star <= v.starLevel[2] and playerLv >= v.minPlayerLevel and playerLv <= v.maxPlayerLevel then
      table.insert(resultTalisman, v)
    end
  end
  table.sort(resultTalisman, function(a, b)
    if a.attack ~= b.attack then
      return a.attack > b.attack
    end
    if a.rank ~= b.rank then
      return a.rank > b.rank
    end
    return a.level > b.level
  end)
  return resultTalisman
end
function class:createTalismanMap()
  local talismans = tree.clone(Logic:Get("Talisman"):GetAllfabaos())
  local map = {}
  for i, talisman in ipairs(talismans) do
    local rec = KFDBGetRecord("TalismanSetting", talisman.baseId) or {}
    local equipTypes = json.decode(rec.equipTypes or "[]")
    for i, race in ipairs(equipTypes) do
      if not map[race] then
        map[race] = {}
      end
      map[race][talisman.id] = {}
      map[race][talisman.id].id = talisman.id
      map[race][talisman.id].race = rec.race
      map[race][talisman.id].starLevel = {
        rec.minStarLevel,
        rec.maxStarLevel
      }
      local mutualRaces = json.decode(rec.mutualRaces or "[]")
      map[race][talisman.id].mutualRaces = table.invert(mutualRaces)
      map[race][talisman.id].level = talisman.level
      local cardInfo = Logic:Get("Hero"):GetHeroInfoByBaseId(rec.baseId)
      map[race][talisman.id].rank = cardInfo.rank
      map[race][talisman.id].equipHero = talisman.equipHero
      map[race][talisman.id].minPlayerLevel = rec.minPlayerLevel
      map[race][talisman.id].maxPlayerLevel = rec.maxPlayerLevel
      local levelId = talisman.baseId .. "_" .. talisman.level
      map[race][talisman.id].attack = Logic:Get("Talisman"):GetTaIlsmanAttack(levelId)
    end
  end
  self.talismanMap = map
end
function class:getEquipArmors(name)
  local heros = self:getArrayHerosByName(name)
  local hasEquip = {}
  local result = {}
  local function filterPosArmor(armors)
    local filter
    for _, armor in ipairs(armors) do
      if not hasEquip[armor.id] then
        hasEquip[armor.id] = armor
        filter = armor
        break
      end
    end
    return filter
  end
  local function filterArmor(equipList)
    local filterResult = {}
    for pos, posArmors in ipairs(equipList) do
      filterResult[pos] = filterPosArmor(posArmors)
    end
    return filterResult
  end
  for i, heroInfo in ipairs(heros) do
    local canEquipList = self:canEquipArmorList(heroInfo.baseId)
    local posArmors = filterArmor(canEquipList)
    self.armors[heroInfo.id] = posArmors
    for pos, armor in pairs(posArmors) do
      local heroEquip = {}
      heroEquip.heroId = heroInfo.id
      heroEquip.position = pos
      heroEquip.equipId = armor.id
      table.insert(result, heroEquip)
    end
  end
  return result
end
function class:canEquipArmorList(baseId)
  local map = self.armorMap
  local sort = function(a, b)
    if a.rank ~= b.rank then
      return a.rank > b.rank
    end
    return a.level > b.level
  end
  local heroRec = Logic:Get("Hero"):GetHeroInfoByBaseId(baseId)
  local resultArmor = {}
  local MAX_POS = 2
  for i = 1, MAX_POS do
    resultArmor[i] = {}
    for id, v in pairs(map[heroRec.type .. "_" .. i] or {}) do
      table.insert(resultArmor[i], v)
    end
    table.sort(resultArmor[i], sort)
  end
  return resultArmor
end
function class:createArmorMap()
  local armors = Logic:Get("Armor"):getAllArmors()
  local map = {}
  for i, armor in ipairs(armors) do
    local armorRec = Logic:Get("Armor"):getArmorInfoByBaseId(armor.baseId)
    local equipTypes = json.decode(armorRec.equipTypes or "[]")
    local positions = json.decode(armorRec.positions or "[]")
    for _, race in ipairs(equipTypes) do
      for _, pos in ipairs(positions) do
        local key = race .. "_" .. pos
        if not map[key] then
          map[key] = {}
        end
        map[key][armor.id] = {}
        map[key][armor.id].baseId = armor.baseId
        map[key][armor.id].id = armor.id
        map[key][armor.id].level = armorRec.level
        map[key][armor.id].rank = armorRec.rank
        map[key][armor.id].equipHero = armor.equipHero
      end
    end
  end
  self.armorMap = map
end
function class:postUpdateTeamName(name)
  self.newName = name
  MsgHero:Post("UPDATE_TEAM_NAME", {
    newName = name,
    oldName = self.oldName
  })
end
function class:onUpdataTeam(code, data)
  self.teamInfo.teams[self.updateName] = self.updataGroup.teams
  self.teamInfo.teamLeaders[self.updateName] = self.updataGroup.leaders
  self:FireEvent(EVT.UPDATE_TEAM)
end
function class:onUseTeam(code, data)
  if code ~= 0 then
    return
  end
  local teamLeaders = self:getTeamLeaderByName(self.useName)
  local teams = self:getTeamsByName(self.useName)
  local groups = Logic:Get("Hero"):GetGroups()
  local tmpGroups = {}
  for idx, v in ipairs(groups) do
    local group = {}
    group.groupId = v.groupId
    group.embattles = teams[idx]
    group.leaderId = teamLeaders[idx]
    table.insert(tmpGroups, group)
  end
  table.sort(tmpGroups, function(a, b)
    return a.groupId < b.groupId
  end)
  Logic:Get("Hero"):SetGroups(tmpGroups)
  for heroId, talismanArray in pairs(self.talismans) do
    local heroInfo = Logic:Get("Hero"):GetHeroInfoById(heroId)
    Logic:Get("Talisman"):SetSelectHero(heroInfo)
    Logic:Get("Talisman"):OnReplaceHeroTalismans(0, talismanArray)
  end
  Logic:Get("Talisman"):ClearSelectHero()
  local playerId = Logic:Get("PlayerInfo"):GetPlayerId()
  for heroId, equipArmor in pairs(self.armors) do
    for pos, armor in pairs(equipArmor) do
      local armorInfo = {}
      armorInfo.baseId = armor.baseId
      armorInfo.equipHero = heroId
      armorInfo.id = armor.id
      armorInfo.owner = playerId
      armorInfo.position = pos
      Logic:Get("Armor"):changeArmor(armorInfo)
    end
  end
  self:FireEvent(EVT.USE_TEAM)
end
function class:PromptTip()
  local lockId = Logic.Lock.LOCK_ID.TALISMAN_EQUIP_2_LOCK
  local bLockTali = Logic:Get("Lock"):GetStatusByLockId(lockId)
  local talisCnt = bLockTali and 1 or 2
  local tip = ""
  local heros = self:getArrayHerosByName(self.useName)
  if #heros < 15 then
    tip = tip .. TwGetStr(115330)
  end
  local notEquipTali = {}
  local notEquipArmor = {}
  for i, heroInfo in ipairs(heros) do
    local heroRec = Logic:Get("Hero"):GetHeroInfoByBaseId(heroInfo.baseId)
    local talismans = Logic:Get("Talisman"):GetHeroEquipTailsmanByHeroId(heroInfo.id)
    if talisCnt > table.size(talismans or {}) then
      table.insert(notEquipTali, heroRec.name)
    end
    local armors = Logic:Get("Armor"):getHeroEquipArmors(heroInfo.id)
    if 2 > table.size(armors or {}) then
      table.insert(notEquipArmor, heroRec.name)
    end
  end
  if not table.empty(notEquipTali) then
    tip = tip .. table.concat(notEquipTali, ",") .. TwGetStr(115332)
  end
  if not table.empty(notEquipArmor) then
    tip = tip .. table.concat(notEquipArmor, ",") .. TwGetStr(115331)
  end
  if tip ~= "" then
    tip = tip .. TwGetStr(115333)
    Prompt:Msg(tip)
  end
end
function class:onUpdateTeamName(code, data)
  if code ~= 0 then
    return
  end
  self.teamInfo.teams[self.newName] = self.teamInfo.teams[self.oldName]
  self.teamInfo.teams[self.oldName] = nil
  self.teamInfo.teamLeaders[self.newName] = self.teamInfo.teamLeaders[self.oldName]
  self.teamInfo.teamLeaders[self.oldName] = nil
  Prompt:Msg(115328)
  self:FireEvent(EVT.UPDATE_TEAM_NAME)
end
function class:onGetTeamInfo(code, data)
  self:setTeamInfo(data)
end
