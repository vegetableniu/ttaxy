module((...), package.seeall)
require("SceneHelper")
require("Logic")
class = Logic.class:subclass()
local MSG_RESULT_NUM = TypeDef("com.eyu.mt.module.cultivate.facade.CultivateResult")
local MSG_RESULT = Enum(MSG_RESULT_NUM)
local MSG_RESULT_STR = {
  NOT_RELATIVE_ELIXIR = 108650,
  THE_ELIXIR_CAN_NOT_COMPOUND = 108651,
  MATERIALS_NOT_ENOUGH = 108652,
  HERO_IS_NOT_EXIST = 108653,
  THE_HERO_CAN_NOT_SWALLOW_THIS_ELIXIR_IN_THIS_POSITION = 108654,
  THE_HERO_POSITION_HAD_SWALLOW_ELIXIR = 108655,
  ELIXIR_IS_NOT_ENOUGH = 108656,
  THE_HERO_HAD_NOT_CULTIVATE = 108657,
  CURRENCY_IS_NOT_ENOUGH = 108658,
  HERO_RANK_IS_NOT_ENOUGH = 108659,
  THE_HERO_CULTIVATE_STATE_HAD_BEEN_MAX = 108660,
  THE_HERO_HAD_NOT_SWALLOW_ALL_ELIXIR = 108661,
  EMBATTLE_IS_NOT_CORRECT = 108662,
  HERO_STAR_IS_NOT_ENOUGH = 108663,
  HERO_CULTIVATE_STATE_LIMIT = 108664,
  HERO_CROSSING_LIMIT = 108665
}
EVT = Enum({
  "SELECT_HERO",
  "SWALLOW_ELIXIR",
  "COM_ELIXIR",
  "RE_CULTIVATE_SUCCESS",
  "REMOVE_ITEM",
  "STUFF_CHANGE",
  "ON_LOAD_INFO",
  "ON_HERO_CROSSING",
  "SET_BTLSCROLL",
  "SET_BTLBTN"
})
ELIXIR_SIZE = Enum({"BIG", "MIDDLE"})
local DEFAULT_IMG = "images/public/clarity05.png"
local DEFAULT_BG = "images/public/herobg.png"
function class:initialize()
  super.initialize(self)
  self:initParam()
  Logic:Get("MsgAssist"):RecordErrorMsg("MsgCultivate", MSG_RESULT, MSG_RESULT_STR)
  MsgCultivate:On("COMPOUND_ELIXIR", self:Event("OnComPoundElixir"))
  MsgCultivate:On("SWALLOW_ELIXIR", self:Event("OnSwallowElixir"))
  MsgCultivate:On("RE_CULTIVATE", self:Event("OnReCultivate"))
  MsgCultivate:On("LOAD_INFO", self:Event("OnLoadInfo"))
  MsgCultivate:On("HERO_CROSSING", self:Event("OnHeroCrossing"))
end
function class:dispose()
  super.dispose(self)
end
function class:initParam()
  self.heroCultivateState = {}
  self.heroSwallowElixir = {}
  self.heroCutivateAlterValues = {}
  self.pillMap = {}
  self.stuffMap = {}
end
function class:OnHeroCultivate(heroCultivate)
  self.heroCultivateState = {}
  self.heroSwallowElixir = {}
  self.heroCutivateAlterValues = {}
  if heroCultivate == nil then
    return
  end
  for k, v in pairs(heroCultivate) do
    self.heroCultivateState[v.id] = v.state
    self.heroSwallowElixir[v.id] = v.elixirs
    self.heroCutivateAlterValues[v.id] = v.alterValues
  end
end
function class:PostLoadInfo()
  MsgCultivate:Post("LOAD_INFO")
end
function class:OnLoadInfo(code, data)
  if code ~= 0 then
    return
  end
  if not data then
    return
  end
  self.pillMap = data.elixires or {}
  self.stuffMap = data.materials or {}
  self:FireEvent(EVT.ON_LOAD_INFO)
end
function class:PostComPoundElixir(id)
  if not id then
    return
  end
  self.comElixirId = id
  MsgCultivate:Post("COMPOUND_ELIXIR", {id = id})
end
function class:OnComPoundElixir(code, data)
  if code == 0 then
    Logic:Get("Cost"):AddCosts(data.costResults)
    self:DelStuffByPillBaseId(self.comElixirId)
    self.pillMap[self.comElixirId] = (self.pillMap[self.comElixirId] or 0) + 1
    self:FireEvent(EVT.COM_ELIXIR)
  end
end
function class:PostSwallowElixir(elixirId, heroId, position)
  self.heroId = heroId
  self.elixirId = elixirId
  self.position = position
  if not elixirId or not heroId or not position then
    return
  end
  MsgCultivate:Post("SWALLOW_ELIXIR", {
    elixirId = elixirId,
    heroId = heroId,
    position = position
  })
end
function class:OnSwallowElixir(code, data)
  if code == 0 then
    self:addSwallowElixir()
    self:swallowAddAttribute()
    if self:isSwallowAllElixir(self.heroId) then
      self:swallowAllAddAttribute()
    end
    self:DelPill(self.elixirId, 1)
    self.heroId = nil
    self:FireEvent(EVT.SWALLOW_ELIXIR, self.elixirId)
  end
end
function class:PostReCultivate(isCost, heroId)
  self.rebuildHeroId = heroId
  if not heroId then
    return
  end
  MsgCultivate:Post("RE_CULTIVATE", {cost = isCost, heroId = heroId})
end
function class:OnReCultivate(code, data)
  if code == 0 then
    Logic:Get("Cost"):AddCosts(data.costResults)
    Logic:Get("Reward"):AddRewards(data.rewardResults)
    self.heroCultivateState[self.rebuildHeroId] = 1
    self.heroSwallowElixir[self.rebuildHeroId] = nil
    self.heroCutivateAlterValues[self.rebuildHeroId] = nil
    self:FireEvent(EVT.SWALLOW_ELIXIR)
    self:FireEvent(EVT.RE_CULTIVATE_SUCCESS)
  end
end
function class:PostHeroCrossing(heroId)
  if not heroId then
    return
  end
  self.oldState = self.heroCultivateState[heroId] or 1
  MsgCultivate:Post("HERO_CROSSING", {
    heroId = heroId,
    embattle = self.embattles
  })
end
function class:OnHeroCrossing(code, data)
  if code ~= 0 then
    return
  end
  if not data then
    return
  end
  Logic:Get("Cost"):AddCosts(data.costResults)
  self.bCrossWin = data.win
  local logic = Logic:Get("BattleShow")
  logic:CleanUp()
  if self.bCrossWin then
    self:crossingAddAttribute(self.heroInfo.id)
    self:addHeroCultivateState(self.heroInfo.id)
    self.heroSwallowElixir[self.heroInfo.id] = nil
    logic:SetResultUI("CultivateCrossResult")
  else
    logic:SetResultUI("CultivateCrossFail")
  end
  logic:SetBattleResult(data.win)
  logic:SetEnterBattle(true)
  logic:SetTotleMultiFightWaves(1 * data.targetGroupNum)
  logic:SetMultiFightWaves(1, data.targetGroupNum)
  logic:SaveMultiFightReport(data.reports)
  self:FireEvent(EVT.ON_HERO_CROSSING)
end
function class:StartCrossBattle()
  Logic:Get("BattleShow"):StartMultiFightReport()
end
function class:setSelectHero(heroInfo)
  self.heroInfo = heroInfo
end
function class:getSelectHero()
  return self.heroInfo
end
function class:setMedicine(medicine)
  self.medicine = medicine
end
function class:getMedicine()
  return self.medicine
end
function class:getCutivateStateById(id)
  return self.heroCultivateState[id] or 1
end
function class:getHeroSwallowElixir(position, id)
  return self.heroSwallowElixir[id] and self.heroSwallowElixir[id][tonumber(position)] or nil
end
function class:getHeroCutivateAlterValues(id)
  return self.heroCutivateAlterValues[id] or {}
end
function class:getElixirImg(baseId, size, disabledFlag)
  local sz = size or ELIXIR_SIZE.MIDDLE
  local rec = self:GetPillInfoByBaseId(baseId)
  local modelId = rec.modelId
  if disabledFlag then
    modelId = rec.disabledModelId
  end
  local info = self:GetRoleSkin(modelId)
  if not info then
    return DEFAULT_IMG
  end
  if sz == ELIXIR_SIZE.MIDDLE then
    return info.MiddleCard
  elseif sz == ELIXIR_SIZE.BIG then
    return info.BigCard
  end
end
function class:getStuffImg(baseId, size)
  local sz = size or ELIXIR_SIZE.MIDDLE
  local rec = self:GetStuffInfoByBaseId(baseId)
  local info = self:GetRoleSkin(rec.modelId)
  if not info then
    return DEFAULT_IMG
  end
  if sz == ELIXIR_SIZE.MIDDLE then
    return info.MiddleCard
  elseif sz == ELIXIR_SIZE.BIG then
    return info.BigCard
  end
end
function class:GetRoleSkin(modelId, disabledFlag)
  if modelId then
    return KFDBGetRecord("RoleSkin", modelId)
  end
end
function class:getElixirImgBg(baseId, size, disabledFlag)
  local sz = size or ELIXIR_SIZE.MIDDLE
  local info = self:GetPillInfoByBaseId(baseId)
  if not info then
    return DEFAULT_BG
  end
  local rank = info.rank or 0
  if rank <= 0 then
    rank = 1
  elseif rank > 7 then
    log4misc:warn("Logic.Cultivate.getElixirImgBg,baseId:" .. ElixirBaseId .. ":,Rank:" .. rank)
    rank = 7
  end
  if disabledFlag then
    rank = 1
  end
  return string.format("data/MiddleBg/%d.png", rank)
end
function class:getStuffImgBg(baseId, size, disabledFlag)
  local sz = size or ELIXIR_SIZE.MIDDLE
  local info = self:GetStuffInfoByBaseId(baseId)
  if not info then
    return DEFAULT_BG
  end
  local rank = info.rank or 0
  if rank <= 0 then
    rank = 1
  elseif rank > 7 then
    log4misc:warn("Logic.Cultivate.getStuffImgBg,baseId:" .. ElixirBaseId .. ":,Rank:" .. rank)
    rank = 7
  end
  if disabledFlag then
    rank = 1
  end
  return string.format("data/MiddleBg/%d.png", rank)
end
function class:getCrossAddAttribute(state, heroid)
  local allAttr = self:getHeroCutivateAlterValues(heroid)
  local crossAttr = self:GetCrossAlterById(heroid, state)
  crossAttr = crossAttr or self:GetCrossAlterByJob(heroid, state) or {}
  crossAttr = Logic:Get("Armor"):sortPropInfo(crossAttr)
  return crossAttr
end
function class:getCultivateAddAttr(state, heroId)
  local hero = Logic:Get("Hero"):GetHeroInfoById(heroId)
  local info = Logic:Get("Hero"):GetHeroInfoByBaseId(hero.baseId)
  if info == nil then
    return
  end
  local rec = self:getCutivateInfo(state, info.type)
  local elixir = json.decode(rec.elixirs or "") or {}
  local attr = {}
  for k, v in pairs(elixir) do
    local recPill = self:GetPillInfoByBaseId(v)
    local pill = json.decode(recPill.alters or "") or {}
    for k1, v1 in pairs(pill) do
      if attr[k1] then
        attr[k1] = attr[k1] + v1
      else
        attr[k1] = v1
      end
    end
  end
  attr = Logic:Get("Armor"):sortPropInfo(attr)
  return attr
end
function class:getAllAttribute(heroId)
  local attr = self:getHeroCutivateAlterValues(heroId)
  attr = Logic:Get("Armor"):sortPropInfo(attr)
  return attr
end
function class:getCutivateInfo(heroState, heroType)
  if heroState == nil or heroType == nil then
    return {}
  end
  return KFDBGetRecord("UnitTypeElixir", heroType .. "_" .. heroState) or {}
end
function class:addHeroCultivateState(heroId)
  local state = self.heroCultivateState[heroId] or 1
  local heroStateInfo = KFDBGetRecord("CultivateState", state)
  self.heroCultivateState[heroId] = heroStateInfo and heroStateInfo.nextId or state
end
function class:addSwallowElixir()
  self.heroSwallowElixir[self.heroId] = self.heroSwallowElixir[self.heroId] or {}
  self.heroSwallowElixir[self.heroId][tonumber(self.position)] = self.elixirId
end
function class:isSwallowAllElixir(heroId)
  self.heroId = heroId
  local hero = Logic:Get("Hero"):GetHeroInfoById(self.heroId)
  local heroInfo = Logic:Get("Hero"):GetHeroInfoByBaseId(hero.baseId)
  local state = self:getCutivateStateById(self.heroId)
  local info = self:getCutivateInfo(state, heroInfo.type)
  local swallowElixir = self.heroSwallowElixir[self.heroId] or {}
  local elixir = json.decode(info.elixirs or "") or {}
  for k, v in pairs(elixir or {}) do
    if swallowElixir[tonumber(k)] == nil then
      return false
    end
  end
  return true
end
function class:swallowAddAttribute()
  self.heroCutivateAlterValues[self.heroId] = self.heroCutivateAlterValues[self.heroId] or {}
  local attribute = self.heroCutivateAlterValues[self.heroId] or {}
  local info = self:GetPillInfoByBaseId(self.elixirId)
  local elixir = json.decode(info.alters or "") or {}
  for k, v in pairs(elixir) do
    if attribute[k] then
      attribute[k] = attribute[k] + v
    else
      attribute[k] = v
    end
  end
end
function class:swallowAllAddAttribute()
  self.heroCutivateAlterValues[self.heroId] = self.heroCutivateAlterValues[self.heroId] or {}
  local hero = Logic:Get("Hero"):GetHeroInfoById(self.heroId)
  local heroInfo = Logic:Get("Hero"):GetHeroInfoByBaseId(hero.baseId)
  local attribute = self.heroCutivateAlterValues[self.heroId] or {}
  local state = self:getCutivateStateById(self.heroId)
  local info = self:getCutivateInfo(state, heroInfo.type)
  local cutivate = json.decode(info.alters or "") or {}
  for k, v in pairs(cutivate) do
    if attribute[k] then
      attribute[k] = attribute[k] + v
    else
      attribute[k] = v
    end
  end
end
function class:crossingAddAttribute(heroId)
  local hero = Logic:Get("Hero"):GetHeroInfoById(heroId)
  local heroInfo = Logic:Get("Hero"):GetHeroInfoByBaseId(hero.baseId)
  local attribute = self.heroCutivateAlterValues[heroId] or {}
  local state = self:getCutivateStateById(heroId)
  local info = self:getCutivateInfo(state, heroInfo.type)
  local cutivate = json.decode(info.crossingAlters or "") or {}
  for k, v in pairs(cutivate) do
    if attribute[k] then
      attribute[k] = attribute[k] + v
    else
      attribute[k] = v
    end
  end
end
function class:isMaxState(baseId, heroId)
  local heroInfo = Logic:Get("Hero"):GetHeroInfoByBaseId(baseId)
  if heroInfo == nil then
    return false
  end
  local heroStateInfo = KFDBGetRecord("HeroMaxState", heroInfo.rank .. "_" .. heroInfo.star)
  if heroStateInfo == nil then
    return false
  end
  local state = self.heroCultivateState[heroId] or 1
  if state >= heroStateInfo.maxState then
    return true
  end
  return false
end
function class:canComposeElixirByBaseId(baseId)
  local elixirInfo = self:GetPillInfoByBaseId(baseId)
  if elixirInfo == nil then
    return false
  end
  local materials = json.decode(elixirInfo.materials or "") or {}
  for k, v in pairs(materials) do
    local materialCount = self:GetStuffByBaseId(tonumber(k)) or 0
    if v > materialCount then
      return false
    end
  end
  return true
end
function class:setFromRecultivateFlage(isbool)
  self.fromRecultivate = isbool
end
function class:getFromRecultivateFlage()
  return self.fromRecultivate
end
function class:canCultivateByBaseId(baseId)
  if baseId == nil then
    return false
  end
  local heroInfo = Logic:Get("Hero"):GetHeroInfoByBaseId(baseId)
  local recRank = KFDBGetRecord("ConfigValue", "CULTIVATE:MIN_HERO_RANK")
  local maxRank = recRank and tonumber(recRank.content) or 1
  local recStar = KFDBGetRecord("ConfigValue", "CULTIVATE:MIN_HERO_STAR")
  local maxStar = recStar and tonumber(recStar.content) or 1
  if maxRank <= heroInfo.rank and maxStar <= heroInfo.star then
    return true
  end
  return false
end
function class:setFromBattle(isbool)
  self.fromBattle = isbool
end
function class:isFromBattle()
  return self.fromBattle
end
function class:getAttrSpr(strProp)
  if strProp == "PCT_ATTACK" then
    strProp = "ATTACK"
  elseif strProp == "PCT_LIFE" then
    strProp = "LIFE"
  end
  local imgStr = string.format("images/Cultivate/P_%s.png", strProp)
  local spr = CCSprite:create(imgStr)
  return spr
end
function class:canSwallowElixir(heroId, baseId)
  local info = Logic:Get("Hero"):GetHeroInfoByBaseId(baseId)
  if info == nil then
    return false, false
  end
  local state = self:getCutivateStateById(heroId)
  local rec = self:getCutivateInfo(state, info.type)
  local elixer = json.decode(rec.elixirs or "") or {}
  if self:isMaxState(baseId, heroId) then
    return false, false
  end
  local canSwallow = false
  local canCompose = false
  for k, v in pairs(elixer) do
    if not self:getHeroSwallowElixir(k, v) then
      local pillNum = self:GetPillByBaseId(v)
      local hasSwallow = self:getHeroSwallowElixir(k, heroId)
      if not hasSwallow and pillNum > 0 then
        canSwallow = true
      end
      if not hasSwallow and self:canComposeElixirByBaseId(v) then
        canCompose = true
      end
    end
  end
  return canSwallow, canCompose
end
function class:hasSwallowElixir(heroId, attr)
  local swallowElixir = self.heroSwallowElixir[heroId] or {}
  for k, v in pairs(swallowElixir) do
    local rec = self:GetPillInfoByBaseId(v)
    local alter = json.decode(rec.alters or "") or {}
    for k1, v1 in pairs(alter) do
      if k1 == attr.propName and v1 == attr.value then
        return true
      end
    end
  end
  return false
end
function class:getPillPropertySpr(strProp, disabledFlag)
  if strProp == "PCT_ATTACK" then
    strProp = "ATTACK"
  elseif strProp == "PCT_LIFE" then
    strProp = "LIFE"
  end
  local imgStr = string.format("images/Cultivate/%s_PILL.png", strProp)
  if disabledFlag then
    imgStr = string.format("images/Cultivate/%s_OFF_PILL.png", strProp)
  end
  local spr = CCSprite:create(imgStr)
  return spr
end
function class:GetElixirTexture(baseId, disabledFlag)
  if not baseId then
    return
  end
  local path = self:getElixirImgBg(baseId, nil, disabledFlag)
  local sprBg = CCSprite:create(path)
  local size = sprBg:getContentSize()
  path = self:getElixirImg(baseId, nil, disabledFlag)
  local sprIcon = CCSprite:create(path)
  if sprBg and sprIcon then
    sprIcon:setAnchorPoint(ccp(0, 0))
    sprBg:addChild(sprIcon)
  end
  local rec = self:GetPillInfoByBaseId(baseId) or {}
  if rec and rec.type then
    local sprType = self:GetTypeImage(rec.type)
    if sprBg and sprType then
      sprType:setAnchorPoint(ccp(0, 0.5))
      sprType:setScale(1)
      sprType:setPosition(CCPoint(70, 80))
      sprBg:addChild(sprType)
    end
  end
  local texture, textureRect = Logic:Get("HeroCardInfo"):GetCardTexture(sprBg, sprBg:getContentSize())
  return texture, textureRect
end
function class:GetMaterialTexture(baseId)
  if not baseId then
    return
  end
  local path = self:getStuffImgBg(baseId)
  local sprBg = CCSprite:create(path)
  local size = sprBg:getContentSize()
  path = self:getStuffImg(baseId)
  local sprIcon = CCSprite:create(path)
  if sprBg and sprIcon then
    sprIcon:setAnchorPoint(ccp(0, 0))
    sprBg:addChild(sprIcon)
  end
  local texture, textureRect = Logic:Get("HeroCardInfo"):GetCardTexture(sprBg, sprBg:getContentSize())
  return texture, textureRect
end
function class:showTip()
  local heroInfo = Logic:Get("Hero"):GetAllHeroInfo()
  if not heroInfo then
    return
  end
  local id = Logic:Get("Hero"):GetHeroTableFromMap(heroInfo.heros)
  if not id then
    return
  end
  local allHeros = Logic:Get("Hero"):GetHeroInfosByIds(id)
  for k, v in pairs(allHeros or {}) do
    local heroInfo = Logic:Get("Hero"):GetHeroInfoByBaseId(v.baseId)
    if heroInfo and heroInfo.card == "HERO" and self:canCultivateByBaseId(v.baseId) then
      local canSwallow, canCompose = self:canSwallowElixir(v.id, v.baseId)
      local canCross = self:isSwallowAllElixir(v.id)
      if canSwallow or canCross or canCompose then
        return true
      end
    end
  end
  return false
end
function class:GetPillByBaseId(id)
  if not id then
    return
  end
  return self.pillMap[id] or 0
end
function class:GetStuffByBaseId(id)
  if not id then
    return
  end
  return self.stuffMap[id] or 0
end
function class:ToArray(map, bStuff)
  if not map then
    return {}
  end
  local array = {}
  for k, v in pairs(map) do
    table.insert(array, {
      baseId = k,
      amount = v,
      stuff = bStuff
    })
  end
  return array
end
function class:GetPillList()
  local pillArray = self:ToArray(self.pillMap)
  table.sort(pillArray, function(a, b)
    local rec_a = self:GetStuffInfoByBaseId(a.baseId)
    local rec_b = self:GetStuffInfoByBaseId(b.baseId)
    if rec_a and rec_b and rec_a.state ~= rec_b.state then
      return rec_a.state > rec_b.state
    end
    return a.baseId < b.baseId
  end)
  return pillArray
end
function class:GetStuffList()
  local stuffArray = self:ToArray(self.stuffMap, true)
  table.sort(stuffArray, function(a, b)
    local rec_a = self:GetStuffInfoByBaseId(a.baseId)
    local rec_b = self:GetStuffInfoByBaseId(b.baseId)
    if rec_a and rec_b and rec_a.level ~= rec_b.level then
      return rec_a.level > rec_b.level
    end
    return a.baseId < b.baseId
  end)
  return stuffArray
end
function class:GetPillInfoByBaseId(baseId)
  if not baseId then
    return {}
  end
  return KFDBGetRecord("ElixirSetting", baseId) or {}
end
function class:GetStuffInfoByBaseId(baseId)
  if not baseId then
    return {}
  end
  return KFDBGetRecord("ElixirMaterial", baseId) or {}
end
function class:OpenPillDetail(baseId, bPrompt)
  if not baseId then
    return
  end
  self.curPillBaseId = baseId
  if bPrompt then
    SceneHelper:removePrompt("CultivatePillInfo")
    SceneHelper:pushPrompt("CultivatePillInfo")
  else
    SceneHelper:removeScene("CultivatePillInfo")
    SceneHelper:pushScene("CultivatePillInfo")
  end
end
function class:OpenStuffDetail(baseId, bPrompt)
  if not baseId then
    return
  end
  self.curStuffBaseId = baseId
  if bPrompt then
    SceneHelper:removePrompt("CultivateStuffInfo")
    SceneHelper:pushPrompt("CultivateStuffInfo")
  else
    SceneHelper:removeScene("CultivateStuffInfo")
    SceneHelper:pushScene("CultivateStuffInfo")
  end
end
function class:GetCheckedPill()
  return self.curPillBaseId
end
function class:GetCheckedStuff()
  return self.curStuffBaseId
end
function class:clearCheckedPill()
  self.curPillBaseId = nil
end
function class:clearCheckedStuff()
  self.curStuffBaseId = nil
end
function class:GetStateNameByBaseId(baseId)
  if not baseId then
    return
  end
  local rec = self:GetPillInfoByBaseId(baseId)
  local name = self:GetStateName(rec.state or 0)
  return name
end
function class:GetStateName(state)
  if not state then
    return
  end
  local rec = KFDBGetRecord("CultivateState", state or 0) or {}
  return rec.name
end
function class:GetCrossHeroInfo()
  local heroState = self.heroCultivateState[self.crossHero.id] or 1
  return self.crossHero.id, heroState
end
function class:IsCrossWin()
  return self.bCrossWin
end
function class:GetCrossingData(heroId)
  if not heroId then
    return
  end
  local heroState = self.oldState
  local flag, _, alters = self:CrossRecById(heroId, heroState)
  if not flag then
    flag, _, alters = self:CrossRecByJob(heroId, heroState)
  end
  if not flag or not alters then
    return
  end
  local addInfos = {}
  if self.bCrossWin then
    local tAlters = json.decode(alters or "") or {}
    for k, v in pairs(tAlters) do
      addInfos[k] = v
    end
  end
  addInfos = Logic:Get("Armor"):sortPropInfo(addInfos)
  return addInfos
end
function class:CrossRecById(heroId, state)
  if not heroId or not state then
    return false
  end
  local hero = Logic:Get("Hero"):GetHeroInfoById(heroId) or {}
  local strKey = hero.baseId .. "_" .. state
  local rec = KFDBGetRecord("HeroCrossing", strKey) or {}
  if next(rec) then
    return true, rec, rec.alters
  end
  return false
end
function class:CrossRecByJob(heroId, state)
  if not heroId or not state then
    return false
  end
  local hero = Logic:Get("Hero"):GetHeroInfoById(heroId) or {}
  local rec = Logic:Get("Hero"):GetHeroInfoByBaseId(hero.baseId) or {}
  local strKey = rec.type .. "_" .. state
  rec = KFDBGetRecord("UnitTypeElixir", strKey) or {}
  if next(rec) then
    return true, rec, rec.crossingAlters
  end
  return false
end
function class:AddPill(reward)
  if not reward then
    return
  end
  self.pillMap[reward.code] = (self.pillMap[reward.code] or 0) + reward.amount
end
function class:DelPill(baseId, amount)
  if not baseId or not self.pillMap[baseId] then
    return
  end
  amount = amount or 1
  self.pillMap[baseId] = self.pillMap[baseId] - amount
  if self.pillMap[baseId] <= 0 then
    self.pillMap[baseId] = nil
  end
end
function class:AddStuff(reward)
  if not reward then
    return
  end
  self.stuffMap[reward.code] = (self.stuffMap[reward.code] or 0) + reward.amount
  self:FireEvent(EVT.STUFF_CHANGE)
end
function class:DelStuffByPillBaseId(baseId)
  local rec = self:GetPillInfoByBaseId(baseId)
  local tStuff = json.decode(rec.materials or "") or {}
  for k, v in pairs(tStuff) do
    self:DelStuff(tonumber(k), v)
  end
end
function class:DelStuff(baseId, amount)
  if not baseId or not self.stuffMap[baseId] then
    return
  end
  amount = amount or 1
  self.stuffMap[baseId] = self.stuffMap[baseId] - amount
  if self.stuffMap[baseId] <= 0 then
    self.stuffMap[baseId] = nil
  end
end
function class:GetDefaultGroups()
  local heroId, state = self:GetCrossHeroInfo()
  local hero = self:getSelectHero()
  heroId = hero.id
  local flag = false
  local embattles = {}
  self.embattles = {}
  local flag, embattles = self:CheckCrossByBaseId(heroId, state)
  if flag then
    return {
      {groupId = 1, embattles = embattles}
    }
  end
  flag, embattles = self:CheckCrossByJob(heroId, state)
  if flag then
    return {
      {groupId = 1, embattles = embattles}
    }
  end
  return {}
end
function class:CheckCrossByBaseId(heroId, state)
  if not heroId or not state then
    return false
  end
  local hero = Logic:Get("Hero"):GetHeroInfoById(heroId) or {}
  local strKey = string.format("%d_%d", hero.baseId, state)
  local rec = KFDBGetRecord("HeroCrossing", strKey) or {}
  if next(rec) then
    local embattles = self:GetCrossEmbattles(rec.myFighter)
    return true, embattles
  end
  return false
end
function class:CheckCrossByJob(heroId, state)
  if not heroId or not state then
    return false
  end
  local hero = Logic:Get("Hero"):GetHeroInfoById(heroId) or {}
  local rec = Logic:Get("Hero"):GetHeroInfoByBaseId(hero.baseId) or {}
  local strKey = string.format("%s_%d", rec.type, state)
  rec = KFDBGetRecord("UnitTypeElixir", strKey) or {}
  if next(rec) then
    local embattles = self:GetCrossEmbattles(rec.myFighter)
    return true, embattles
  end
  return false
end
function class:GetCrossEmbattles(strKey)
  if not strKey then
    return {}
  end
  local embattles = {}
  local embattlesToShow = {}
  local rec = KFDBGetRecord("EnemyFighterClient", strKey) or {}
  local tFighters = json.decode(rec.enemies or "") or {}
  for i, col in ipairs(tFighters) do
    local enemyCol = {}
    local enemyColShow = {}
    for i, v in ipairs(col) do
      if v == "MINE" then
        local heroId = self.heroInfo.id
        local hero = Logic:Get("Hero"):GetHeroInfoById(heroId) or {}
        table.insert(enemyCol, "MINE")
        table.insert(enemyColShow, {
          baseId = hero.baseId,
          id = heroId
        })
      elseif type(v) == "userdata" then
        table.insert(enemyCol, "")
        table.insert(enemyColShow, {})
      else
        table.insert(enemyCol, v)
        table.insert(enemyColShow, self:GetEnemyUnitInfo(v))
      end
    end
    table.insert(embattles, enemyCol)
    table.insert(embattlesToShow, enemyColShow)
  end
  self.embattles = embattles
  self.embattlesToShow = embattlesToShow
  return embattlesToShow
end
function class:GetEnemyUnitInfo(strKey)
  if not strKey then
    return {}
  end
  local rec = KFDBGetRecord("EnemyUnitClient", strKey) or {}
  return json.decode(rec.model or "") or {}
end
function class:EmbattleChanged(src, tar)
  if not src or not tar then
    return
  end
  if not next(self.embattles) then
    return
  end
  local srcCol = src[1] + 1
  local srcRow = src[2] + 1
  local tarCol = tar[1] + 1
  local tarRow = tar[2] + 1
  local temp = self.embattles[srcCol][srcRow]
  self.embattles[srcCol][srcRow] = self.embattles[tarCol][tarRow]
  self.embattles[tarCol][tarRow] = temp
end
function class:SetCrossHero(hero)
  self.crossHero = hero
end
function class:GetCrossHero()
  return self.crossHero
end
function class:GetHerosByPillId(baseId)
  if not baseId then
    return {}
  end
  local heroInfos = {}
  local job_state = {}
  for i = 1, KFDBGetRecordAmt("UnitTypeElixir") do
    local rec = KFDBGetRecordByIdx("UnitTypeElixir", i) or {}
    local tElixirs = json.decode(rec.elixirs or "") or {}
    for k, v in pairs(tElixirs) do
      if v == baseId then
        local job, state = string.match(rec.id, "(%a+)_(%d+)")
        table.insert(job_state, {
          job = tostring(job),
          state = tonumber(state)
        })
      end
    end
  end
  local rec = KFDBGetRecord("ConfigValue", "CULTIVATE:MIN_HERO_RANK") or {}
  local minRank = tonumber(rec.content) or 2
  local rec = KFDBGetRecord("ConfigValue", "CULTIVATE:MIN_HERO_STAR") or {}
  local minStar = tonumber(rec.content) or 1
  local heroIds = Logic:Get("Hero"):GetTotalHeroId()
  local heros = Logic:Get("Hero"):GetHeroInfosByIds(heroIds) or {}
  local index = 0
  for _, hero in ipairs(heros) do
    rec = Logic:Get("Hero"):GetHeroInfoByBaseId(hero.baseId) or {}
    local heroType = rec.type
    local heroRank = rec.rank
    local heroStar = rec.star
    local heroState = self.heroCultivateState[hero.id] or 1
    for _, js in ipairs(job_state) do
      index = index + 1
      if heroType == js.job and heroState == js.state and minRank <= heroRank and minStar <= heroStar then
        table.insert(heroInfos, {hero = hero, state = heroState})
      end
    end
  end
  return heroInfos
end
function class:GetPillsByStuffId(baseId)
  if not baseId or not tonumber(baseId) then
    return {}
  end
  baseId = tonumber(baseId)
  local pills = {}
  for i = 1, KFDBGetRecordAmt("ElixirSetting") do
    local rec = KFDBGetRecordByIdx("ElixirSetting", i) or {}
    local tMaterials = json.decode(rec.materials or "") or {}
    for k, v in pairs(tMaterials) do
      if tonumber(k) == baseId then
        table.insert(pills, rec.id)
      end
    end
  end
  return pills
end
function class:GetDropsByBattleId(battleId)
  if not battleId then
    return {}
  end
  local dropMaterials = {}
  for i = 1, KFDBGetRecordAmt("ElixirMaterial") do
    local rec = KFDBGetRecordByIdx("ElixirMaterial", i) or {}
    local tBatttleIds = json.decode(rec.dropIds or "") or {}
    for _, v in ipairs(tBatttleIds) do
      if v == battleId then
        table.insert(dropMaterials, rec.id)
      end
    end
  end
  return dropMaterials
end
function class:GetStateImage(state, bDark)
  if not state then
    return
  end
  local path = ""
  if bDark then
    path = string.format("images/Cultivate/state%d_dark.png", state)
  else
    path = string.format("images/Cultivate/state%d.png", state)
  end
  return CCSprite:create(path)
end
function class:GetTypeImage(nType)
  if not nType then
    return
  end
  local path = string.format("images/Cultivate/type%d.png", nType)
  return CCSprite:create(path)
end
function class:SetBtlScrollEnabled(enable)
  self:FireEvent(EVT.SET_BTLSCROLL, enable)
end
function class:SetBtlBtnVisible(visible)
  self:FireEvent(EVT.SET_BTLBTN, visible)
end
function class:SetCheckedBattleId(battleId)
  self.battleId = battleId
end
function class:GetCheckedBattleId()
  return self.battleId
end
function class:GetPrevStateName(state)
  if not state then
    return
  end
  return self:GetStateName(state - 1)
end
function class:GetCrossAlterById(heroId, state)
  if not heroId or not state then
    return {}
  end
  local hero = Logic:Get("Hero"):GetHeroInfoById(heroId) or {}
  local strKey = string.format("%d_%d", hero.baseId, state)
  local rec = KFDBGetRecord("HeroCrossing", strKey) or {}
  return json.decode(rec.alter or "")
end
function class:GetCrossAlterByJob(heroId, state)
  if not heroId or not state then
    return {}
  end
  local hero = Logic:Get("Hero"):GetHeroInfoById(heroId) or {}
  local rec = Logic:Get("Hero"):GetHeroInfoByBaseId(hero.baseId) or {}
  local strKey = rec.type .. "_" .. state
  rec = KFDBGetRecord("UnitTypeElixir", strKey) or {}
  return json.decode(rec.crossingAlters or "") or {}
end
function class:IsLockCultivate(state)
  if not state then
    return
  end
  local rec = KFDBGetRecord("CultivateState", state) or {}
  local level = Logic:Get("PlayerInfo"):GetPlayerLevel()
  local bClearBattle = Logic:Get("Elite"):IsClearBattle(rec.battle)
  if level >= rec.level and bClearBattle then
    return true
  end
  return false
end
function class:getPropertySpr(strProp, disabledFlag)
  if strProp == "PCT_ATTACK" then
    strProp = "ATTACK"
  elseif strProp == "PCT_LIFE" then
    strProp = "LIFE"
  end
  local imgStr = string.format("images/Cultivate/%s.png", strProp)
  if disabledFlag then
    imgStr = string.format("images/Cultivate/%s_OFF.png", strProp)
  end
  local spr = CCSprite:create(imgStr)
  return spr
end
function class:IsFromCultivateStuff()
  return self.bFromStuff
end
function class:SetFromCultivateStuff(bFromStuff)
  self.bFromStuff = bFromStuff
end
function class:SetBattleInfo(battleInfo)
  self.battleInfo = battleInfo
end
function class:GetBattleInfo(...)
  return self.battleInfo
end
function class:CheckCulCondition(condition)
  if not condition then
    return true
  end
  local ret = true
  local heros = Logic:Get("Hero"):GetTotalHeroId() or {}
  local tCondition = json.decode(condition) or {}
  for k, v in pairs(tCondition) do
    local count = 0
    for i, heroId in ipairs(heros) do
      if (self.heroCultivateState[heroId] or 1) >= tonumber(k) then
        count = count + 1
      end
    end
    if v > count then
      ret = false
    end
  end
  return ret
end
function class:GetTitleSprByState(state)
  if not state then
    return
  end
  local path = string.format("images/Cultivate/fb_title%d.png", state)
  return CCSprite:create(path)
end
function class:SetCheckedPillId(baseId)
  self.checkPillId = baseId
end
function class:GenerateCheckedStuffInfo()
  if not self.checkPillId then
    self.checkedStuffInfo = nil
    return
  end
  local checkedStuffInfo = {
    baseId = self.curStuffBaseId
  }
  local rec = self:GetPillInfoByBaseId(self.checkPillId)
  local material = json.decode(rec.materials or "") or {}
  for k, v in pairs(material) do
    if tonumber(k) == self.curStuffBaseId then
      checkedStuffInfo.amount = v
      break
    end
  end
  local stuffAmount = self:GetStuffByBaseId(self.curStuffBaseId)
  if not checkedStuffInfo.amount or stuffAmount >= checkedStuffInfo.amount then
    self.checkedStuffInfo = nil
  else
    self.checkedStuffInfo = checkedStuffInfo
  end
end
function class:GetCheckedStuffInfo(...)
  return self.checkedStuffInfo
end
function class:SetEmbattleFromCultivate(bCultivate)
  self.bFromCultivate = bCultivate
end
function class:IsEmbattleFromCultivate(...)
  return self.bFromCultivate
end
