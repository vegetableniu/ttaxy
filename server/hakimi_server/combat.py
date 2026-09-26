"""Turn-based battle simulator producing the 1.0.8.0 binary battle report.

Report layout (client Module/BattleShow/ReportParser):
  team      := unit* 0xFF combCount:i8 comb:i16*
  unit      := slot:i8 model:u16 role:i8 class:i8 hp:i32 hpMax:i32 skill:u8
               (class = Role MAJOR 1 / MINOR 2 / BOSS 3; skill = begin<<4 | round)
  round     := info* 0xFF action* 0xFF info* 0xFF cdCount:i16 cd* [0xFF]
  action    := actor:i8 skill:i16 n:i8 target*n startPassive:i8
  target    := slot:i8 state:i8 value buffs passives
  value     := n:i8 (type:i8 content:i32)*       type 0 SHIELD, 1 HP (delta)
  state     := bits NORMAL 0, DODGE 1, CRIT 2, WRECK 4, FAIL 8, RESTRAIN 16
  report    := attackers defenders round* result:u8   (last byte)

Stats/skills come from BaseHero (initValues/initGrows/initRates, normalSkill,
card power skill) and SkillConfig (state.cd/round, skilldesc targeting, 系数).
The damage formula, targeting of ambiguous skills and enemy rosters are
推测值: the original server-side combat code and enemy tables are not shipped.
"""

from __future__ import annotations

import json
import random
import re
import struct
from dataclasses import dataclass, field

DODGE, CRIT, RESTRAIN = 1, 2, 16
MAJOR, MINOR, BOSS = 1, 2, 3
MAX_ROUNDS = 30
RACE_BEATS = {"XIAN": "YAO", "YAO": "LING", "LING": "XIAN"}  # 推测值: 克制链


@dataclass
class Fighter:
    slot: int
    base_id: int
    level: int
    hp: int
    max_hp: int
    attack: int
    rates: dict
    race: str
    role: int
    normal: int
    power: int
    begin: int = 0
    period: int = 0
    card_id: int = 0

    @property
    def alive(self) -> bool:
        return self.hp > 0

    @property
    def row(self) -> int:
        return (self.slot % 6) // 2

    @property
    def front(self) -> bool:
        # 3 rows x 2 columns; column 1 faces the enemy (ACCOUNT:INIT_EMBATTLES
        # places the leader there).
        return (self.slot % 6) % 2 == 1


@dataclass
class Skill:
    id: int
    coef: float
    target: str        # single / front / back / all / random / lowest
    count: int = 1
    heal: bool = False
    magic: bool = False


def _json(value, default):
    try:
        return json.loads(value) if isinstance(value, str) and value else default
    except ValueError:
        return default


def parse_skill(config, skill_id: int) -> Skill:
    row = config.index("SkillConfig").get(int(skill_id), {})
    desc = str(row.get("skilldesc", ""))
    first = desc.split("\\n")[0]
    match = re.search(r"系数为(\d+)%", desc) or re.search(r"(\d+)%", first)
    coef = int(match.group(1)) / 100 if match else float(row.get("skillRate") or 1.0)
    number = re.search(r"(\d+)个", first)
    count = int(number.group(1)) if number else 1
    heal = "治疗" in first
    if "全体" in first:
        target = "all"
    elif "前排" in first:
        target = "front"
    elif "后排" in first:
        target = "back"
    elif "随机" in first:
        target = "random"
    elif "最低" in first:
        target = "lowest"
    else:
        target = "single"
    return Skill(int(skill_id), coef, target, count, heal, "法术" in first)


def make_fighter(config, slot: int, base_id: int, level: int, role: int,
                 power_skill: int = 0, scale: float = 1.0, card_id: int = 0) -> Fighter:
    info = config.heroes.get(int(base_id), {})
    init, grow = _json(info.get("initValues"), {}), _json(info.get("initGrows"), {})
    hp = int((init.get("LIFE", 100) + level * grow.get("LIFE", 10)) * scale)
    attack = int((init.get("ATTACK", 10) + level * grow.get("ATTACK", 1)) * scale)
    power = int(power_skill or _json(info.get("powerSkill"), 0) or 0)
    state = _json(config.index("SkillConfig").get(power, {}).get("state"), {})
    period = int(state.get("round") or 0)
    begin = int(state.get("cd") or 0) if period else 0
    return Fighter(slot=slot, base_id=int(base_id), level=level, hp=max(1, hp),
                   max_hp=max(1, hp), attack=max(1, attack),
                   rates=_json(info.get("initRates"), {}), race=str(info.get("race", "")),
                   role=role, normal=int(_json(info.get("normalSkill"), 101) or 101),
                   power=power, begin=begin, period=period, card_id=card_id)


def apply_alters(fighter: Fighter, alters: dict) -> Fighter:
    """Add equipment/talisman bonuses: flat ATTACK/LIFE, PCT_* and RATE_*."""
    attack, life = fighter.attack, fighter.max_hp
    attack += int(float(alters.get("ATTACK", 0)))
    life += int(float(alters.get("LIFE", 0)))
    attack = int(attack * (1 + float(alters.get("PCT_ATTACK", 0))))
    life = int(life * (1 + float(alters.get("PCT_LIFE", 0))))
    fighter.attack, fighter.hp, fighter.max_hp = max(1, attack), max(1, life), max(1, life)
    for key, value in alters.items():
        if key.startswith("RATE_"):
            name = key[5:]
            fighter.rates[name] = float(fighter.rates.get(name, 0)) + float(value)
    return fighter


def _i8(v: int) -> bytes:
    return struct.pack(">b", v) if v < 128 else struct.pack(">B", v)


def encode_team(units: list[Fighter]) -> bytes:
    out = b""
    for u in units:
        out += (_i8(u.slot) + struct.pack(">H", u.base_id & 0xFFFF) + b"\x00"
                + _i8(u.role) + struct.pack(">ii", u.hp, u.max_hp)
                + bytes((((u.begin & 0xF) << 4) | (u.period & 0xF),)))
    return out + b"\xff\x00"


class Battle:
    def __init__(self, config, attackers: list[Fighter], defenders: list[Fighter],
                 rng: random.Random | None = None):
        self.config = config
        self.attackers, self.defenders = attackers, defenders
        self.rng = rng or random.Random()
        self.rounds: list[bytes] = []
        self.round_no = 0
        self.skills: dict[int, Skill] = {}

    def skill(self, skill_id: int) -> Skill:
        if skill_id not in self.skills:
            self.skills[skill_id] = parse_skill(self.config, skill_id)
        return self.skills[skill_id]

    def _casts_power(self, u: Fighter) -> bool:
        if not u.period or not u.power:
            return False
        first = u.period - u.begin  # UI/BattleShowUnit skill countdown rule
        return self.round_no >= first and (self.round_no - first) % u.period == 0

    def _pick(self, skill: Skill, actor: Fighter, foes: list[Fighter],
              friends: list[Fighter]) -> list[Fighter]:
        pool = [u for u in (friends if skill.heal else foes) if u.alive]
        if not pool:
            return []
        if skill.target == "all":
            return pool
        if skill.target in ("front", "back"):
            want = skill.target == "front"
            side = [u for u in pool if u.front == want] or pool
            return side
        if skill.target == "random":
            return self.rng.sample(pool, min(skill.count, len(pool)))
        if skill.target == "lowest" or skill.heal:
            return sorted(pool, key=lambda u: u.hp / u.max_hp)[:skill.count]
        same_row = [u for u in pool if u.row == actor.row]
        ordered = sorted(same_row or pool, key=lambda u: (not u.front, u.slot))
        return ordered[:1]

    def _hit(self, actor: Fighter, target: Fighter, skill: Skill) -> tuple[int, int]:
        if skill.heal:
            amount = int(actor.attack * skill.coef)
            amount = min(amount, target.max_hp - target.hp)
            target.hp += amount
            return 0, amount
        if self.rng.random() < float(target.rates.get("DODGE", 0)):
            return DODGE, 0
        state = 0
        damage = actor.attack * skill.coef * self.rng.uniform(0.95, 1.05)
        if RACE_BEATS.get(actor.race) == target.race:
            damage *= 1.2
            state |= RESTRAIN
        if self.rng.random() < float(actor.rates.get("CRIT", 0)):
            damage *= 1.5
            state |= CRIT
        reduce = target.rates.get("UNHARM_M" if skill.magic else "UNHARM_P", 0)
        damage = max(1, int(damage * (1 - float(reduce))))
        damage = min(damage, target.hp)
        target.hp -= damage
        return state, -damage

    def _act(self, actor: Fighter, foes: list[Fighter], friends: list[Fighter]) -> bytes:
        skill = self.skill(actor.power if self._casts_power(actor) else actor.normal)
        targets = self._pick(skill, actor, foes, friends)
        if not targets:
            return b""
        out = _i8(actor.slot) + struct.pack(">H", skill.id & 0xFFFF) + _i8(len(targets))
        for target in targets:
            state, delta = self._hit(actor, target, skill)
            out += (_i8(target.slot) + _i8(state) + b"\x01\x01" + struct.pack(">i", delta)
                    + b"\x00\x00")
        return out + b"\x00"

    def run(self) -> bool:
        while self.round_no < MAX_ROUNDS:
            self.round_no += 1
            actions = b""
            order = sorted(self.attackers + self.defenders, key=lambda u: (u.slot % 6, u.slot))
            for actor in order:
                if not actor.alive:
                    continue
                mine = self.attackers if actor in self.attackers else self.defenders
                theirs = self.defenders if mine is self.attackers else self.attackers
                if not any(u.alive for u in theirs):
                    break
                actions += self._act(actor, theirs, mine)
            self.rounds.append(b"\xff" + actions + b"\xff\xff\x00\x00\xff")
            if not any(u.alive for u in self.defenders) or not any(u.alive for u in self.attackers):
                break
        return not any(u.alive for u in self.defenders)

    def report(self, initial_attackers: bytes, initial_defenders: bytes, won: bool) -> bytes:
        return initial_attackers + initial_defenders + b"".join(self.rounds) + (b"\x01" if won else b"\x00")


def fight(config, attackers: list[Fighter], defenders: list[Fighter],
          rng: random.Random | None = None) -> tuple[bool, bytes]:
    head_a, head_d = encode_team(attackers), encode_team(defenders)
    battle = Battle(config, attackers, defenders, rng)
    won = battle.run()
    return won, battle.report(head_a, head_d, won)


# ------------------------------------------------------------ enemies
def enemy_roster(config, battle_id: str, wave: int, waves: int,
                 count: int = 3) -> list[tuple[int, int, int]]:
    """Reconstructed roster [(slot, baseId, role)] for a campaign battle (推测值).

    Regular units come from the chapter's place-name heroes (BaseHero.gain) or
    the 关卡掉落 1★ pool; the last wave's boss is the hero named like the
    battle when such a card exists.  Deterministic per battle/wave.
    """
    battle = config.battle(battle_id)
    campaign = config.index("CampaignConfig").get(battle.get("campaignId"), {})
    place = str(campaign.get("name", "")).split()[-1] if campaign.get("name") else ""
    heroes = [h for h in config.rows("BaseHero") if h["card"] == "HERO"]
    themed = [h for h in heroes if place and place in h["gain"] and int(h["star"]) <= 3]
    common = [h for h in heroes if "关卡掉落" in h["gain"] and int(h["star"]) == 1]
    rng = random.Random(f"{battle_id}:{wave}")
    pool = themed + common[:8] if themed else common
    last = wave == waves - 1
    units = []
    slots = [7, 9, 11, 6, 8, 10]
    for index in range(count):
        units.append((slots[index], int(rng.choice(pool)["id"]), MINOR))
    if last:
        boss_name = str(battle.get("name", "")).replace("精英", "")
        named = [h for h in heroes if h["name"] == boss_name]
        if named:
            boss = min(named, key=lambda h: int(h["star"]))
            units[0] = (slots[0], int(boss["id"]), BOSS)
    return units
