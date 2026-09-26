-- ================= 游戏状态与持久化 =================
-- 完整玩家数据存到 local_save.txt（JSON）
LS.STARTER_HEROS = { 1001, 1002, 1021, 1042, 1061, 1143 }
-- 敌方怪物池（关卡怪物 baseId：铁甲牛妖/小蜘怪/蛤蟆精/白骨近卫/幽魂侍女/夜叉鬼/小萌牛/牛头勇士）
LS.MONSTER_POOL = { 11, 21, 31, 41, 51, 61, 71, 81 }
-- AI 陪玩（好友援军）：玩家可选一个 AI 英雄作为第 6 名上阵援军
LS.AI_FRIENDS = { 1163, 1183, 1203, 1223, 1407, 1367 }  -- 哪吒/红孩儿/牛魔王/铁扇公主/二郎神/观音
-- 阵位随等级解锁：初始 3 个，13 级第 4 个，40 级第 5 个（第 6 个为好友援军槽）
LS.FORMATION_BASE = 3
-- 抽卡可获得的英雄池（各角色 1 星基础形态 baseId）
LS.DRAW_HEROS = { 1001, 1002, 1021, 1042, 1061, 1081, 1102, 1143, 1163, 1183, 1203, 1223, 1367, 1407, 1487, 1783, 2603, 2623, 3303, 3603 }
-- 置 true 时登录即预通关所有主线章节，全部关卡/功能开放（调试用）
LS.UNLOCK_ALL = true

local function defaultState()
  return {
    account = LS.ACCOUNT,
    roleName = LS.PLAYER_NAME or "本地玩家",
    roleCreated = true,
    player = { level = 1000, exp = 0 },
    physical = { point = 999, refreshTime = os.time() * 1000 },
    wallet = { copper = 9999999, gold = 999999, gift = 999999, stone = 999999, inter = 999999, friendship = 999999, fragment = 999999, coupon = 999999, exploit = 999999, orange = 999999, purple = 999999 },
    heroes = {},
    group = { curGroupId = 1, groups = { { groupId = 1, leaderId = 0, embattles = {} } } },
    battles = {},
    campaigns = {},
    dailyCounts = {},
    nextHeroId = 100001,
  }
end
LS.state = defaultState()

function LS.stateFile()
  local doc = CVariableSystem:GetSingleton():GetSysVariable(GV_DOCPATH)
  if doc == nil then return nil end
  return doc .. "local_save.txt"
end
function LS.saveState()
  local f = LS.stateFile()
  if f == nil then return end
  local ok, h = pcall(io.open, f, "w")
  if not ok or h == nil then return end
  h:write(json.encode(LS.state))
  io.close(h)
end
function LS.loadState()
  local f = LS.stateFile()
  if f == nil then return end
  local h = io.open(f, "r")
  if h == nil then return end
  local s = h:read("*a")
  io.close(h)
  if s and #s > 0 then
    local ok, t = pcall(function() return json.decode(s) end)
    if ok and type(t) == "table" then
      LS.state = t
    end
  end
end

-- 自动登录：先把 Login.objLoginInfo 需要的字段补齐，再调 HostAdapter.OnLogin
-- 幂等：EnvLogic:Login 和 GameStageLogout 的定时器都可能触发，只允许登录一次
function LS.autoLogin()
  if LS.loggedIn then
    return
  end
  LS.loggedIn = true
  local login = Logic:Get("Login")
  local info = login:GetLoginInfo()
  if type(info) ~= "table" then info = {} end
  local opId = tonumber(Logic:Get("System"):GetOperatorId()) or 24
  info.account = LS.state.account
  info.operator = opId
  info.server = 1
  info.addr = "127.0.0.1"
  info.port = 9001
  info.originUserId = LS.state.account
  info.sign = "localsign"
  info.time = os.time()
  info.name = LS.state.roleName
  -- The original HTTP server-info response normally initializes NetMgr.
  -- Offline login bypasses that HTTP request, so point the unchanged TCP
  -- transport at the local endpoint before the first PostPrior call.
  Singleton(NetMgr):SetUrlAndPort(info.addr, info.port)
  local acc = string.format('{"userId":"%s","userName":"%s","anonymity":false,"type":"login"}',
                            LS.state.account, LS.state.roleName)
  log4misc:warn("[LocalServer] autoLogin account=" .. LS.state.account .. " op=" .. tostring(opId))
  if _G.OnLogin then
    _G.OnLogin(0, acc)
  else
    log4misc:warn("[LocalServer] OnLogin not found!")
  end
end

-- ================= 默认值生成器 =================
local function zero(spec, depth)
  depth = (depth or 0) + 1
  if depth > 6 or spec == nil then return 0 end
  local k = string.sub(spec, 1, 1)
  if k == 'i' then return 0
  elseif k == 's' then return ""
  elseif k == 'b' then return false
  elseif k == 'd' then return 0
  elseif k == 'e' then return 0
  elseif k == 'x' then return 0
  elseif k == 'a' then return {}
  elseif k == 'm' then return {}
  elseif k == 'o' then
    local tn = string.sub(spec, 3)
    local fields = T[tn]
    local r = {}
    if fields then
      for f, fs in pairs(fields) do r[f] = zero(fs, depth) end
    end
    return r
  end
  return 0
end
LS.zero = zero

-- 万能空对象（null object）：
-- schema 没覆盖到的字段用零值补不全，下游可能出现
--   data.activitys.drawVo        -> attempt to index a nil value
--   r.weekTime + 86400           -> attempt to perform arithmetic on a nil/table value
-- 单个 dummy 同时支持「无限索引」和「所有算术/拼接/比较元方法」，
-- 于是无论下游怎么取用都不会抛错，登录流程能一路走完。
local DUMMY = setmetatable({}, {
  __index = function(t, k) return t end,
  __newindex = function() end,
  __add = function() return 0 end,
  __sub = function() return 0 end,
  __mul = function() return 0 end,
  __div = function() return 0 end,
  __mod = function() return 0 end,
  __pow = function() return 0 end,
  __unm = function() return 0 end,
  __len = function() return 0 end,
  __concat = function(a, b)
    if type(a) == 'string' then return a end
    if type(b) == 'string' then return b end
    return ""
  end,
  __eq = function() return false end,
  __lt = function() return false end,
  __le = function() return false end,
  __call = function(t) return t end,
  __tostring = function() return "" end,
})
LS.DUMMY = DUMMY

-- 递归把每一层表都接上 dummy（schema 已给出的真实零值仍保留）
local function vivify(t)
  -- Preserve absent fields as nil. A truthy dummy changes game decisions
  -- (pending battles, guild membership, rename prompts and feature locks).
  return t
end
LS.vivify = vivify

-- 深合并：把 patch 覆盖到默认值上
local function merge(base, patch)
  if type(base) ~= 'table' or type(patch) ~= 'table' then return patch end
  for k, v in pairs(patch) do
    if type(v) == 'table' and type(base[k]) == 'table' then
      merge(base[k], v)
    else
      base[k] = v
    end
  end
  return base
end
LS.merge = merge

-- 把数字编码成协议 long 的字节串（客户端内部 long 就是这种字符串）
local function longid(n)
  n = tonumber(n) or 0
  local sign = n < 0
  n = math.abs(math.floor(n))
  local flag = sign and 0x1A or 0x12
  if n == 0 then return string.char(flag, 0x00) end
  local bytes = {}
  while n > 0 do
    table.insert(bytes, 1, n % 256)
    n = math.floor(n / 256)
  end
  return string.char(flag, 0x80 + #bytes) .. string.char(unpack(bytes))
end
LS.longid = longid

-- 调试：枚举关键配置表，把字段名 + 记录 dump 到文件（排查真实字段名/数据）
local function dumpConfig()
  local doc = LS.stateFile()
  if doc == nil then return end
  local path = string.gsub(doc, "local_save.txt$", "config_probe.txt")
  local ok, h = pcall(io.open, path, "w")
  if not ok or h == nil then
    log4misc:warn("[LocalServer] dumpConfig open fail: " .. tostring(path))
    return
  end
  local function dumpTable(name)
    local okamt, n = pcall(KFDBGetRecordAmt, name)
    h:write("=== " .. name .. " count=" .. tostring(n) .. " ok=" .. tostring(okamt) .. " ===\n")
    if not okamt or type(n) ~= "number" then
      h:write("  (cannot enumerate)\n")
      return
    end
    for i = 1, n do
      local okr, r = pcall(KFDBGetRecordByIdx, name, i)
      if okr and type(r) == "table" then
        local parts = {}
        local keys = {}
        for k in pairs(r) do table.insert(keys, tostring(k)) end
        table.sort(keys)
        if i <= 3 then
          for _, k in ipairs(keys) do
            table.insert(parts, k .. "=" .. tostring(r[k]))
          end
          h:write("  [" .. i .. "] " .. table.concat(parts, " | ") .. "\n")
        else
          h:write("  [" .. i .. "] id=" .. tostring(r.id) .. " name=" .. tostring(r.name) .. "\n")
        end
      end
    end
    h:write("\n")
  end
  dumpTable("BaseHero")
  dumpTable("CampaignConfig")
  dumpTable("BattleInfoConfig")
  dumpTable("SkillConfig")
  dumpTable("HeroLevelConfig")
  dumpTable("ComposeConfig")
  io.close(h)
  log4misc:warn("[LocalServer] dumpConfig wrote " .. path)
end
LS.dumpConfig = dumpConfig

-- ================= 显式处理器 =================
-- 每个处理器: function(req, mod, cmd) return content, attach end
LS.handlers = {}
local H = LS.handlers

-- ===== 工具 =====
local function inSet(lst, v)
  if type(lst) ~= "table" then return false end
  for _, x in ipairs(lst) do if x == v then return true end end
  return false
end

-- 把协议 long 字节串还原成数字
local function unlongid(s)
  if type(s) ~= "string" then return tonumber(s) or 0 end
  local b = { string.byte(s, 1, #s) }
  if #b < 2 then return tonumber(s) or 0 end
  local sign = (b[1] % 16 >= 8) and -1 or 1
  local val = 0
  for i = 3, #b do val = val * 256 + b[i] end
  return sign * val
end
LS.unlongid = unlongid

local function baseHero(baseId)
  local ok, r = pcall(KFDBGetRecord, "BaseHero", baseId)
  if ok and type(r) == "table" then return r end
  return nil
end
local function baseBattle(battleId)
  local ok, r = pcall(KFDBGetRecord, "BattleInfoConfig", battleId)
  if ok and type(r) == "table" then return r end
  return nil
end
local function getJson(str)
  if type(str) == "string" and str ~= "" then
    local ok, t = pcall(function() return json.decode(str) end)
    if ok and type(t) == "table" then return t end
  end
  return {}
end
local function heroStats(baseId, level)
  local info = baseHero(baseId)
  local iv, ig = {}, {}
  if info then
    iv = getJson(info.initValues)
    ig = getJson(info.initGrows)
  end
  local hp = math.floor((iv.LIFE or 100) + (level or 1) * (ig.LIFE or 10))
  local atk = math.floor((iv.ATTACK or 10) + (level or 1) * (ig.ATTACK or 2))
  return hp, atk
end
local function getHeroSwallowExp(baseId, level)
  local info = baseHero(baseId)
  if not info then return 0 end
  return math.floor((tonumber(info.baseExp) or 0) + (level or 1) * (tonumber(info.growExp) or 0))
end
local function getHeroNextExp(baseId, level)
  local lv = KFDBGetRecord("HeroLevelConfig", level)
  local info = baseHero(baseId)
  local base = (lv and tonumber(lv.exp)) or 100
  local rate = (info and tonumber(info.expRate)) or 1
  return math.floor(base * rate)
end

-- ===== 英雄/阵型 =====
local function heroById(id)
  for _, h in ipairs(LS.state.heroes) do
    if h.id == id then return h end
  end
  return nil
end
local function heroToClient(h)
  return {
    id = LS.longid(h.id),
    baseId = h.baseId,
    exp = h.exp or 0,
    level = h.level or 1,
    locked = h.locked or false,
    powerSkill = h.powerSkill or 0,
    skillExp = h.skillExp or 0,
  }
end
local function removeHero(id)
  for i = #LS.state.heroes, 1, -1 do
    if LS.state.heroes[i].id == id then
      table.remove(LS.state.heroes, i)
      break
    end
  end
  local g = LS.state.group and LS.state.group.groups and LS.state.group.groups[1]
  if g then
    for r = 1, #g.embattles do
      for c = 1, #g.embattles[r] do
        if g.embattles[r][c] == id then g.embattles[r][c] = 0 end
      end
    end
    if g.leaderId == id then
      g.leaderId = LS.state.heroes[1] and LS.state.heroes[1].id or 0
    end
  end
end

local function addNewHero(baseId)
  LS.state.nextHeroId = LS.state.nextHeroId or 100001
  local info = baseHero(baseId)
  local h = {
    id = LS.state.nextHeroId, baseId = baseId, level = 1, exp = 0,
    locked = false, powerSkill = (info and tonumber(info.powerSkill)) or 0, skillExp = 0,
  }
  LS.state.nextHeroId = LS.state.nextHeroId + 1
  table.insert(LS.state.heroes, h)
  LS.saveState()
  return h
end

local function ensureRoster()
  if LS.state.heroes and #LS.state.heroes > 0 then return end
  LS.state.heroes = {}
  LS.state.nextHeroId = LS.state.nextHeroId or 100001
  for i, baseId in ipairs(LS.DRAW_HEROS) do
    local info = baseHero(baseId)
    table.insert(LS.state.heroes, {
      id = LS.state.nextHeroId, baseId = baseId, level = 10, exp = 0,
      locked = false, powerSkill = (info and tonumber(info.powerSkill)) or 0, skillExp = 0,
    })
    LS.state.nextHeroId = LS.state.nextHeroId + 1
  end
  -- 默认阵型 3 行 x 2 列；只填等级解锁的阵位（初始 3 个），其余留空
  local function openSlots()
    local lv = LS.state.player and LS.state.player.level or 1
    local n = LS.FORMATION_BASE
    if lv >= 13 then n = n + 1 end
    if lv >= 40 then n = n + 1 end
    return n
  end
  local embattles = {}
  local idx = 1
  local maxOpen = openSlots()
  for r = 1, 3 do
    embattles[r] = {}
    for c = 1, 2 do
      local h = nil
      if idx <= maxOpen then h = LS.state.heroes[idx] end
      embattles[r][c] = h and h.id or 0
      idx = idx + 1
    end
  end
  LS.state.group = {
    curGroupId = 1,
    groups = { { groupId = 1, leaderId = LS.state.heroes[1].id, embattles = embattles } },
  }
  LS.saveState()
end

-- 测试模式：预通关所有主线章节，让全部关卡/功能开放
local function ensureFullUnlock()
  if LS.state.unlockedAll then return end
  LS.state.unlockedAll = true
  local n = KFDBGetRecordAmt("BattleInfoConfig")
  for i = 1, n do
    local r = KFDBGetRecordByIdx("BattleInfoConfig", i)
    if type(r) == "table" and r.id and not inSet(LS.state.battles, r.id) then
      table.insert(LS.state.battles, r.id)
    end
  end
  local nc = KFDBGetRecordAmt("CampaignConfig")
  for i = 1, nc do
    local r = KFDBGetRecordByIdx("CampaignConfig", i)
    if type(r) == "table" and r.id and r.type == "NORMAL" and not inSet(LS.state.campaigns, r.id) then
      table.insert(LS.state.campaigns, r.id)
    end
  end
  LS.saveState()
end

local function groupToClient()
  local g = LS.state.group or { curGroupId = 1, groups = {} }
  local groups = {}
  for i, grp in ipairs(g.groups or {}) do
    local emb = {}
    for r = 1, #grp.embattles do
      emb[r] = {}
      for c = 1, #grp.embattles[r] do
        local hid = grp.embattles[r][c]
        if hid and hid ~= 0 then emb[r][c] = LS.longid(hid) else emb[r][c] = ID[0] end
      end
    end
    table.insert(groups, {
      groupId = grp.groupId,
      leaderId = (grp.leaderId and grp.leaderId ~= 0) and LS.longid(grp.leaderId) or ID[0],
      embattles = emb,
    })
  end
  return { curGroupId = g.curGroupId or 1, groups = groups }
end
local function herosToClient()
  local lst = {}
  for _, h in ipairs(LS.state.heroes) do table.insert(lst, heroToClient(h)) end
  local leader = LS.state.heroes[1] and LS.state.heroes[1].id or 0
  return { extendCount = 6, extendLimit = 60, heros = lst, leader = LS.longid(leader), score = {} }
end
local function progressToClient()
  return {
    battles = LS.state.battles or {},
    campaigns = LS.state.campaigns or {},
    dailyCounts = LS.state.dailyCounts or {},
    current = nil,
  }
end

-- ===== 战斗战报 =====
local function pb(n) return string.char(n % 256) end
local function pu16(n) return string.char(math.floor(n / 256) % 256, n % 256) end
local function pi32(n)
  if n < 0 then n = n + 4294967296 end
  return string.char(math.floor(n / 16777216) % 256, math.floor(n / 65536) % 256, math.floor(n / 256) % 256, n % 256)
end
local function packUnit(slot, model, class, hp, hpMax)
  return pb(slot) .. pu16(model) .. pb(0) .. pb(class) .. pi32(hp) .. pi32(hpMax) .. pb(0x01)
end
local function packTeam(units)
  local s = ""
  for _, u in ipairs(units) do s = s .. packUnit(u.slot, u.model, u.class, u.hp0, u.hpMax) end
  return s .. pb(0xFF) .. pb(0)
end
local function packAction(actorSlot, skillId, targets)
  local s = pb(actorSlot) .. pu16(skillId) .. pb(#targets)
  for _, t in ipairs(targets) do
    -- Hakimi adds typed values, buffs, passives and a start-passive flag.
    s = s .. pb(t.slot) .. pb(t.state or 0) .. pb(1) .. pb(1)
          .. pi32(t.damage or 0) .. pb(0) .. pb(0)
  end
  return s .. pb(0)
end
local function firstAlive(units)
  for _, u in ipairs(units) do
    if u.hp > 0 then return u end
  end
  return nil
end

local function battleLevel(battleId)
  local binfo = baseBattle(battleId)
  if binfo and binfo.campaignId then
    local cn = string.match(tostring(binfo.campaignId), "CN(%d+)")
    if cn then return tonumber(cn) or 1 end
  end
  return 1
end

local function simulateBattle(battleId, reqEmbattle)
  local atkUnits, defUnits = {}, {}
  -- 己方：优先用客户端传来的实际阵型（玩家刚配置的），否则用本地存档
  local g = LS.state.group and LS.state.group.groups and LS.state.group.groups[LS.state.group.curGroupId or 1]
  local emb = (g and g.embattles) or {}
  if type(reqEmbattle) == "table" and #reqEmbattle > 0 then
    emb = {}
    for r = 1, #reqEmbattle do
      emb[r] = {}
      for c = 1, #(reqEmbattle[r] or {}) do
        emb[r][c] = unlongid(reqEmbattle[r][c])
      end
    end
  end
  local aslot = 0
  for r = 1, #emb do
    for c = 1, #emb[r] do
      local hid = emb[r][c]
      local h = (hid and hid > 0) and heroById(hid) or nil
      if h then
        local info = baseHero(h.baseId)
        local hp, atk = heroStats(h.baseId, h.level)
        table.insert(atkUnits, {
          slot = aslot, model = h.baseId, class = 1, hp0 = hp, hp = hp, hpMax = hp, atk = atk,
          skill = (info and tonumber(info.normalSkill)) or 101,
        })
      end
      aslot = aslot + 1
    end
  end
  -- 调试：打印上阵英雄
  do
    local parts = {}
    for _, u in ipairs(atkUnits) do table.insert(parts, tostring(u.model)) end
    log4misc:warn("[DBG] battle=" .. tostring(battleId) .. " atkCount=" .. #atkUnits .. " models=" .. table.concat(parts, ","))
  end
  -- 敌方
  local binfo = baseBattle(battleId)
  local enemies = (binfo and tonumber(binfo.enemies)) or 3
  local lvl = battleLevel(battleId)
  for i = 1, enemies do
    local mbid = LS.MONSTER_POOL[((i - 1) % #LS.MONSTER_POOL) + 1]
    local info = baseHero(mbid)
    local hp, atk = heroStats(mbid, lvl)
    table.insert(defUnits, {
      slot = 5 + i, model = mbid, class = (i == enemies) and 3 or 2,
      hp0 = hp, hp = hp, hpMax = hp, atk = atk,
      skill = (info and tonumber(info.normalSkill)) or 121,
    })
  end
  -- 模拟回合制
  local rounds = {}
  local win = false
  local TOL = 12
  for round = 1, TOL do
    local actions = {}
    for _, u in ipairs(atkUnits) do
      if u.hp > 0 then
        local tgt = firstAlive(defUnits)
        if tgt then
          local dmg = math.max(1, math.floor(u.atk * (0.9 + math.random() * 0.2)))
          tgt.hp = tgt.hp - dmg
          table.insert(actions, packAction(u.slot, u.skill, { { slot = tgt.slot, state = 0, damage = -dmg } }))
        end
      end
    end
    for _, u in ipairs(defUnits) do
      if u.hp > 0 then
        local tgt = firstAlive(atkUnits)
        if tgt then
          local dmg = math.max(1, math.floor(u.atk * (0.9 + math.random() * 0.2)))
          tgt.hp = tgt.hp - dmg
          table.insert(actions, packAction(u.slot, u.skill, { { slot = tgt.slot, state = 0, damage = -dmg } }))
        end
      end
    end
    -- Empty round-starts; actions; empty round-ends; zero cooldown records.
    table.insert(rounds, pb(0xFF) .. table.concat(actions) .. pb(0xFF)
                        .. pb(0xFF) .. pu16(0) .. pb(0xFF))
    local allDefDead, allAtkDead = true, true
    for _, u in ipairs(defUnits) do if u.hp > 0 then allDefDead = false end end
    for _, u in ipairs(atkUnits) do if u.hp > 0 then allAtkDead = false end end
    if allDefDead then win = true break end
    if allAtkDead then break end
  end
  local atkB, defB = {}, {}
  for _, u in ipairs(atkUnits) do table.insert(atkB, u) end
  for _, u in ipairs(defUnits) do table.insert(defB, u) end
  local report = packTeam(atkB) .. packTeam(defB) .. table.concat(rounds) .. pb(win and 1 or 0)
  return report, win
end

local function markBattleDone(battleId)
  if not inSet(LS.state.battles, battleId) then
    table.insert(LS.state.battles, battleId)
  end
  local binfo = baseBattle(battleId)
  if binfo and binfo.last == "true" and binfo.campaignId then
    if not inSet(LS.state.campaigns, binfo.campaignId) then
      table.insert(LS.state.campaigns, binfo.campaignId)
    end
  end
  LS.saveState()
end

local function addPlayerExp(battleId)
  local p = LS.state.player or {}
  p.level = p.level or 1
  p.exp = (p.exp or 0) + 5000
  -- 按 LevelConfig 累计经验升级
  while p.level < 100 do
    local nextcfg = KFDBGetRecord("LevelConfig", p.level + 1)
    local need = (nextcfg and tonumber(nextcfg.exp)) or math.huge
    if p.exp >= need then p.level = p.level + 1 else break end
  end
  LS.state.player = p
  return 5000, p.level, p.exp
end

-- ===== 账号 =====
H["10:4"] = function(req) return LS.state.roleCreated end
H["10:2"] = function(req) return LS.SESSION end
H["10:1"] = function(req)
  if type(req) == "table" and req.name then LS.state.roleName = req.name end
  LS.state.roleCreated = true
  LS.saveState()
  return 0
end
H["10:9"] = function(req) return 0 end

-- ===== 登录信息（进游戏关键包）=====
H["10:7"] = function(req)
  LS.init()
  local t = zero("o:model.LoginInfoVo")
  local st = LS.state
  t.account = t.account or {}
  t.account.id = 10001
  t.account.name = st.account
  t.account.state = 0
  t.account.online = true
  t.account.createdOn = os.time()
  t.account.loginOn = os.time()
  t.account.logoutOn = os.time()
  t.player = t.player or {}
  t.player.id = 10001
  t.player.name = st.roleName
  t.player.level = st.player.level or 1
  t.player.exp = st.player.exp or 0
  t.player.leadership = 100
  t.player.baseId = 1001
  t.player.rank = 0
  t.player.rename = false
  t.wallet = t.wallet or {}
  t.wallet.gold = st.wallet.gold or 0
  t.wallet.copper = st.wallet.copper or 0
  t.wallet.stone = st.wallet.stone or 0
  t.wallet.gift = st.wallet.gift or 0
  t.wallet.inter = st.wallet.inter or 0
  t.wallet.friendship = st.wallet.friendship or 0
  t.wallet.fragment = st.wallet.fragment or 0
  t.wallet.coupon = st.wallet.coupon or 0
  t.wallet.exploit = st.wallet.exploit or 0
  t.wallet.orange = st.wallet.orange or 0
  t.wallet.purple = st.wallet.purple or 0
  t.wallet.totalCharge = 0
  t.actionPoint = t.actionPoint or {}
  -- 注意：客户端按 points[0](体力/SINGLE) / points[1](精力/DEMOG) 读取，必须 0 基下标
  local phy = st.physical or { point = 999, refreshTime = os.time() * 1000 }
  local function mkPoint(p)
    return { point = p or 999, refreshTime = os.time() * 1000, exchangeCount = 0, exchangeTime = 0, extraTime = 0 }
  end
  t.actionPoint.points = {
    [0] = mkPoint(phy.point),
    [1] = mkPoint(999),
    [2] = mkPoint(999),
  }
  t.vip = t.vip or {}
  t.vip.vip = false
  t.vip.week = false
  t.vip.monsth = false
  t.vip.vipTime = 0
  t.vip.weekTime = 0
  t.vip.monsthTime = 0
  t.vip.lastChargeDate = 0
  t.systemTime = os.time() * 1000  -- date 类型以毫秒计，客户端 OnSystemTime 会 /1000
  t.hasNewMail = false
  t.hasReward = false
  t.hasAchieve = false
  t.lotteryLevel = 70  -- 转盘奖励等级：设到最大，避免每次登录强制弹转盘
  t.artifactLevel = 0
  for _, k in ipairs({"account", "player", "wallet", "vip", "actionPoint", "groupVo", "heros",
                      "treasurePack", "arenaMatchList", "demogRank", "talismanVos", "progressVo",
                      "items", "friendPack", "activitys", "validGiftVo", "emblemAchieveList",
                      "buffs", "commendFriend", "dailyCheckInfo", "lotteryRecord",
                      "targetProgress", "menpaiLoginVo", "teamInfoVo", "equipVos",
                      "heroCultivateVos", "eliteBattleIds", "activeProgress", "exploreExecuteTasks"}) do
    if type(t[k]) ~= "table" then t[k] = {} end
  end
  t.friendPack = { apply = false, extendCount = 0, extendLimit = 50, friends = {} }
  t.heros = herosToClient()
  t.groupVo = groupToClient()
  t.teamInfoVo = { teamLeaders = {}, teams = {} }
  t.progressVo = progressToClient()
  t.asset = Logic:Get("System"):GetServerVer()
  return vivify(t)
end

-- ===== 战斗 =====
H["22:1"] = function(req) return vivify(progressToClient()) end  -- PROGRESS
H["22:7"] = function(req) return vivify(LS.state.dailyCounts or {}) end  -- DAILYCOUNT

-- MULTI_ACTION：进关卡，回 array<TriggerVo>
H["22:9"] = function(req)
  req = type(req) == "table" and req or {}
  local battleId = req.battleId
  if not battleId then return vivify({}) end
  -- 持久化玩家刚配置的阵型
  if type(req.embattle) == "table" and #req.embattle > 0 then
    local g = LS.state.group and LS.state.group.groups and LS.state.group.groups[LS.state.group.curGroupId or 1]
    if g then
      g.embattles = {}
      for r = 1, #req.embattle do
        g.embattles[r] = {}
        for c = 1, #(req.embattle[r] or {}) do
          g.embattles[r][c] = unlongid(req.embattle[r][c])
        end
      end
      LS.saveState()
    end
  end
  local report, win = simulateBattle(battleId, req.embattle)
  local binfo = baseBattle(battleId)
  local drops = {}
  if binfo and win then drops = getJson(binfo.itemDrop) end
  local coins = 0
  if win then
    markBattleDone(battleId)
    coins = 100 + battleLevel(battleId) * 50
    if LS.state.dailyCounts[battleId] == nil then LS.state.dailyCounts[battleId] = 0 end
    LS.state.dailyCounts[battleId] = LS.state.dailyCounts[battleId] + 1
    LS.saveState()
  end
  -- 扣体力
  local cost = binfo and tonumber(binfo.cost) or 5
  local phy = LS.state.physical or { point = 999, refreshTime = os.time() * 1000 }
  phy.point = math.max(0, (phy.point or 999) - cost)
  phy.refreshTime = os.time() * 1000
  LS.state.physical = phy
  LS.lastBattle = { battleId = battleId, win = win, cost = cost }
  return vivify({ { reports = report, drops = {}, coins = coins, finished = true, success = win, index = 0 } })
end

-- EXIT：结算
H["22:5"] = function(req)
  local lb = LS.lastBattle
  local costs, rewards = {}, {}
  if lb then
    local phy = LS.state.physical or { point = 999, refreshTime = os.time() }
    table.insert(costs, { type = 4, code = 0, amount = -(lb.cost or 0), contents = { point = phy.point, refreshTime = phy.refreshTime } })
  end
  if lb and lb.win then
    local lvl = battleLevel(lb.battleId)
    local gain, plvl, pexp = addPlayerExp(lb.battleId)
    local coins = 100 + lvl * 50
    LS.state.wallet.copper = (LS.state.wallet.copper or 0) + coins
    LS.saveState()
    table.insert(rewards, { type = 1, code = 0, amount = coins, contents = {}, mail = false })
    table.insert(rewards, { type = 0, code = 0, amount = gain, contents = { level = plvl, exp = pexp }, mail = false })
  end
  LS.lastBattle = nil
  return vivify({ costAndReward = { costs = costs, rewards = rewards }, hasDemog = false, failedTimes = 0 })
end

-- ===== 门派（mod 47）=====
-- 离线没有门派，回一个"未加入"的空 MenpaiInfoVo，避免 Sect 逻辑对数组字段误判
H["47:2"] = function(req)
  return {
    id = 0, name = "", level = 1, count = 0, exp = 0, money = 0,
    declaration = "", post = "", bossName = "", job = 0,
    aplypNum = 0, canPrayTime = 0, prayTimes = 0, hasGrabed = false,
    holdRewardDate = 0, endGrabRight = 0,
    joinBidDate = {}, joinFightDate = {}, reportDate = {},
  }
end

-- ===== 英雄模块（mod 13）=====
H["13:1"] = function(req) return vivify(herosToClient()) end  -- ALL_HEROS
H["13:2"] = function(req)  -- HERO_CURRENT：选择队友后，把客户端选中的英雄写回阵型
  req = type(req) == "table" and req or {}
  local g = LS.state.group and LS.state.group.groups and LS.state.group.groups[1]
  if g and type(req.heros) == "table" then
    local ids = {}
    for _, v in ipairs(req.heros) do
      local id = unlongid(v)
      if id > 0 then table.insert(ids, id) end
    end
    -- 重排成 3 行 x 2 列
    g.embattles = {}
    local idx = 1
    for r = 1, 3 do
      g.embattles[r] = {}
      for c = 1, 2 do
        g.embattles[r][c] = ids[idx] or 0
        idx = idx + 1
      end
    end
    LS.saveState()
  end
  local emb = {}
  if g then
    for r = 1, #g.embattles do
      emb[r] = {}
      for c = 1, #g.embattles[r] do
        local hid = g.embattles[r][c]
        emb[r][c] = (hid and hid > 0) and LS.longid(hid) or ID[0]
      end
    end
  end
  return vivify(emb)
end
H["13:3"] = function(req)  -- EMBATTLE
  req = type(req) == "table" and req or {}
  local g = LS.state.group.groups[1]
  if g and type(req.embattles) == "table" then
    g.embattles = {}
    for r = 1, #req.embattles do
      g.embattles[r] = {}
      for c = 1, #req.embattles[r] do
        local v = req.embattles[r][c]
        g.embattles[r][c] = unlongid(v)
      end
    end
    LS.saveState()
  end
  return 0
end
H["13:4"] = function(req)  -- SWALLOW 升级
  req = type(req) == "table" and req or {}
  local srcId = unlongid(req.src)
  local src = heroById(srcId)
  if not src then return vivify({}) end
  local tar = type(req.tar) == "table" and req.tar or {}
  local totalExp = src.exp or 0
  local costs = {}
  for _, tid in ipairs(tar) do
    local tidNum = unlongid(tid)
    local fed = heroById(tidNum)
    if fed and fed.id ~= src.id then
      totalExp = totalExp + getHeroSwallowExp(fed.baseId, fed.level)
      removeHero(tidNum)
      table.insert(costs, { type = 5, code = 0, amount = -1, contents = { id = LS.longid(tidNum) } })
    end
  end
  local lvl = src.level or 1
  while lvl < 100 do
    local need = getHeroNextExp(src.baseId, lvl)
    if totalExp >= need then
      totalExp = totalExp - need
      lvl = lvl + 1
    else
      break
    end
  end
  src.level = lvl
  src.exp = totalExp
  LS.saveState()
  return vivify({ costs = costs, hero = heroToClient(src) })
end
H["13:5"] = function(req)  -- RANK_UP 升星
  req = type(req) == "table" and req or {}
  local srcId = unlongid(req.src)
  local src = heroById(srcId)
  if not src then return vivify({}) end
  local info = baseHero(src.baseId)
  local nextId = info and tonumber(info.nextId)
  local costs = {}
  if not nextId or nextId < 0 then
    return vivify({ costs = costs, hero = heroToClient(src) })
  end
  local tar = type(req.tar) == "table" and req.tar or {}
  for _, tid in ipairs(tar) do
    local tidNum = unlongid(tid)
    local fed = heroById(tidNum)
    if fed and fed.id ~= src.id then
      removeHero(tidNum)
      table.insert(costs, { type = 5, code = 0, amount = -1, contents = { id = LS.longid(tidNum) } })
    end
  end
  src.baseId = nextId
  src.level = 1
  src.exp = 0
  LS.saveState()
  return vivify({ costs = costs, hero = heroToClient(src) })
end
H["13:7"] = function(req)  -- SELL_HERO
  req = type(req) == "table" and req or {}
  local tar = type(req.tar) == "table" and req.tar or {}
  local totalCoins = 0
  local costs = {}
  for _, tid in ipairs(tar) do
    local tidNum = unlongid(tid)
    local h = heroById(tidNum)
    if h then
      local info = baseHero(h.baseId)
      totalCoins = totalCoins + (info and tonumber(info.baseCoins) or 100) + (h.level - 1) * (info and tonumber(info.growCoins) or 10)
      removeHero(tidNum)
      table.insert(costs, { type = 5, code = 0, amount = -1, contents = { id = LS.longid(tidNum) } })
    end
  end
  LS.state.wallet.copper = (LS.state.wallet.copper or 0) + totalCoins
  LS.saveState()
  local rewards = {}
  if totalCoins > 0 then table.insert(rewards, { type = 1, code = 0, amount = totalCoins, contents = {}, mail = false }) end
  return vivify({ costs = costs, rewards = rewards })
end
H["13:8"] = function(req)  -- CHANGE_LEADER
  req = type(req) == "table" and req or {}
  local g = LS.state.group.groups[1]
  if g and req.src then
    g.leaderId = unlongid(req.src)
    LS.saveState()
  end
  local emb = {}
  if g then
    for r = 1, #g.embattles do
      emb[r] = {}
      for c = 1, #g.embattles[r] do
        local hid = g.embattles[r][c]
        emb[r][c] = (hid and hid ~= 0) and LS.longid(hid) or ID[0]
      end
    end
  end
  return vivify(emb)
end
H["13:11"] = function(req)  -- SKILL_UP
  req = type(req) == "table" and req or {}
  local srcId = unlongid(req.src)
  local src = heroById(srcId)
  if not src then return vivify({}) end
  local tar = type(req.tar) == "table" and req.tar or {}
  local costs = {}
  for _, tid in ipairs(tar) do
    local tidNum = unlongid(tid)
    local fed = heroById(tidNum)
    if fed and fed.id ~= src.id then
      removeHero(tidNum)
      table.insert(costs, { type = 5, code = 0, amount = -1, contents = { id = LS.longid(tidNum) } })
    end
  end
  src.skillExp = (src.skillExp or 0) + 1
  LS.saveState()
  return vivify({ costs = costs, hero = heroToClient(src) })
end
H["13:12"] = function(req) return vivify({}) end  -- CURRENT_SCORE
H["13:13"] = function(req) return vivify(groupToClient()) end  -- HERO_GROUPS
H["13:14"] = function(req)  -- SWITCH_HERO_GROUP
  req = type(req) == "table" and req or {}
  LS.state.group.curGroupId = req.groupId or 1
  LS.saveState()
  return 0
end
H["13:15"] = function(req) return 0 end  -- EMBATTLE_GROUP

-- ===== 抽卡 / 商城 / 合成 =====
H["11:1"] = function(req)  -- LOTTERY 抽卡：扣元宝，得随机英雄
  req = type(req) == "table" and req or {}
  local times = tonumber(req.time) or 1
  local goldCost = 100 * times
  local st = LS.state
  if (st.wallet.gold or 0) < goldCost then
    return vivify({ costs = {}, rewards = {} })
  end
  st.wallet.gold = st.wallet.gold - goldCost
  local costs = { { type = 0, code = 1, amount = -goldCost, contents = {} } }  -- CURRENCY + GOLD
  local rewards = {}
  for i = 1, times do
    local baseId = LS.DRAW_HEROS[math.random(#LS.DRAW_HEROS)]
    local h = addNewHero(baseId)
    table.insert(rewards, { type = 5, code = baseId, amount = 1, contents = heroToClient(h), mail = false })
  end
  LS.saveState()
  return vivify({ costs = costs, rewards = rewards })
end
H["11:2"] = function(req)  -- WALLET
  local w = LS.state.wallet or {}
  return vivify({
    gold = w.gold or 0, copper = w.copper or 0, stone = w.stone or 0,
    gift = w.gift or 0, inter = w.inter or 0, friendship = w.friendship or 0,
    fragment = w.fragment or 0, coupon = w.coupon or 0, exploit = w.exploit or 0,
    orange = w.orange or 0, purple = w.purple or 0,
    totalCharge = 0, stageCharges = {},
  })
end
H["11:3"] = function(req)  -- VIP
  return vivify({ vip = false, vipTime = 0, week = false, weekTime = 0, monsth = false, monsthTime = 0, lastChargeDate = 0 })
end
H["11:9"] = function(req)  -- ROULETTE_LOTTERY 幸运转盘
  -- id 必须是 RouletteLotteryConfig 表的合法下标（用于展示奖励名）
  local cnt = KFDBGetRecordAmt("RouletteLotteryConfig")
  local idx = math.random(1, cnt > 0 and cnt or 1)
  local baseId = LS.DRAW_HEROS[math.random(#LS.DRAW_HEROS)]
  local h = addNewHero(baseId)
  return vivify({
    id = idx,
    nextLevel = -1,
    rewardResults = { { type = 5, code = baseId, amount = 1, contents = heroToClient(h), mail = false } },
  })
end
H["11:10"] = function(req) return vivify({}) end  -- ROULETTE_LOTTERY_RESULTS
H["11:11"] = function(req)  -- GET_LOTTERY_LIST：商城/抽卡的抽卡池列表
  local now = os.time() * 1000
  local pools = {
    { baseId = 1001, title = "英雄招募", desc = "招募一名随机英雄", cost = 100 },
    { baseId = 1002, title = "高级招募", desc = "招募高品质英雄", cost = 300 },
    { baseId = 1021, title = "神将招募", desc = "招募神级英雄", cost = 600 },
  }
  local lst = {}
  for i, p in ipairs(pools) do
    table.insert(lst, {
      id = 2000 + i, baseId = p.baseId,
      cardID = tostring(p.baseId), cardLevel = "1", cardTip = "", cardType = "HERO",
      cooldownHours = 48, current = 0, desInPage = "[]", description = p.desc,
      endLevel = 9999, endTime = now + 86400000 * 365, kind = "NORMAL",
      level = 1, limits = 0, lotteryType = "HERO", path = "",
      prices = json.encode({ { type = "CURRENCY", code = 1, amount = p.cost } }),
      probability = json.encode({ { baseId = p.baseId, weight = 100 } }),
      resetDate = now, salePrices = { p.cost }, show = true, showTemplete = "hero",
      sort = i, sortType = "NORMAL", startTime = now - 86400000, title = p.title,
      type = "HERO", usedFreeTimes = 0, vip = false, week = false, weight = 0,
      activity = "", activityCharge = 0, playerActivityCharge = 0, battle = "", eliteBattle = "",
    })
  end
  return vivify(lst)
end
H["12:1"] = function(req) return vivify({}) end  -- GET_ITEMS（背包道具，暂无）
H["12:2"] = function(req) return vivify({ costs = {}, rewards = {} }) end  -- COMPOSE_ITEM
H["51:1"] = function(req) return vivify({}) end  -- PLAYER_BUY_INFO 商城

-- ===== 初始化（延迟到登录时再执行，避免在 NetMsg 模块加载期调用 KFDB/日志）=====
function LS.init()
  if LS.inited then return end
  LS.inited = true
  LS.loadState()
  if type(LS.state) ~= "table" then LS.state = defaultState() end
  if not LS.state.wallet then LS.state.wallet = {} end
  if not LS.state.player then LS.state.player = { level = 1, exp = 0 } end
  if not LS.state.heroes then LS.state.heroes = {} end
  if not LS.state.battles then LS.state.battles = {} end
  if not LS.state.campaigns then LS.state.campaigns = {} end
  if not LS.state.dailyCounts then LS.state.dailyCounts = {} end
  if not LS.state.group then LS.state.group = { curGroupId = 1, groups = { { groupId = 1, leaderId = 0, embattles = {} } } } end
  if not LS.state.nextHeroId then LS.state.nextHeroId = 100001 end
  ensureRoster()
  if LS.UNLOCK_ALL then ensureFullUnlock() end
  LS.saveState()
  log4misc:warn("[LocalServer] init heroes=" .. #LS.state.heroes .. " battles=" .. #LS.state.battles .. " campaigns=" .. #LS.state.campaigns)
end

-- ================= 分发 =================
function LS.dispatch(mod, cmd, req)
  local key = tostring(mod) .. ":" .. tostring(cmd)
  log4misc:warn("[LocalServer] dispatch " .. key)
  local nm = Singleton(NetMsg)
  local evId = mod * 10000 + (cmd + 5000) % 10000
  local cnt = 0
  for _ in pairs(nm.eventSet.events) do cnt = cnt + 1 end
  log4misc:warn(string.format("[LocalServer] eventId=%d bound=%s total=%d",
    evId, tostring(nm.eventSet.events[evId] ~= nil), cnt))
  local ok, content
  local h = LS.handlers[key]
  if h then
    local succ, ret = pcall(h, req, mod, cmd)
    if succ then
      content = ret
      log4misc:warn("[LocalServer] handler " .. key .. " -> " .. tostring(ret))
    else
      log4misc:warn("[LocalServer] handler error " .. key .. ": " .. tostring(ret))
    end
  end
  if content == nil then
    local def = (CMD[mod] or {})[cmd]
    if def then
      content = zero(def[2])
      log4misc:info("[LocalServer] auto-answer %d-%d (%s)", mod, cmd, def[1])
    else
      content = 0
      log4misc:warn("[LocalServer] unknown msg %d-%d -> 0", mod, cmd)
    end
  end
  local ok2, err2 = xpcall(function()
    nm:OnReceived({
      raw = true,
      mod = mod,
      cmd = cmd,
      content = { code = 0, content = content },
      attachment = ""
    })
  end, function(e)
    return tostring(e) .. "\n" .. tostring(debug.traceback())
  end)
  if ok2 then
    log4misc:warn("[LocalServer] replied " .. key)
  else
    log4misc:warn("[LocalServer] OnReceived error " .. key .. ":\n" .. tostring(err2))
  end
  return true
end

-- 让外部（补丁）能拿到
_G.__LocalServer = LS
