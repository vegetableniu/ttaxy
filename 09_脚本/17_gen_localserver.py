#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
生成 05_改造/lua/LocalServer.lua
 - 内嵌压缩后的协议 schema（mod/cmd -> 应答类型）
 - 通用默认值生成器：任何未知消息都能返回"形状正确"的零值，避免客户端崩
 - 显式处理器：CHECK_ACCOUNT / LOGIN / LOGIN_INFO 等关键消息返回真实可玩数据
"""
import os, json, re

ROOT = r'C:\Users\nkq\Desktop\game\hakimi'
SCHEMA = os.path.join(ROOT, '05_改造', 'schema', 'protocol_schema.json')
OUTDIR = os.path.join(ROOT, '05_改造', 'lua')
os.makedirs(OUTDIR, exist_ok=True)

d = json.load(open(SCHEMA, encoding='utf-8'))
types = d['types']

SHORT = {
    'int': 'i', 'long': 'i', 'number': 'i', 'string': 's', 'bool': 'b',
    'date': 'd', 'object': 'o', 'byte': 'i', 'short': 'i', 'float': 'i', 'double': 'i',
}


def norm(name):
    """把全名归一化成 schema 里的短键"""
    if not isinstance(name, str):
        return None
    if name in types:
        return name
    for pre in ('com.eyu.mt.module.', 'com.eyu.mt.', 'eyu.mt.module.'):
        if name.startswith(pre):
            cand = name[len(pre):]
            if cand in types:
                return cand
    m = re.search(r'(model|facade|manager|module|reward)\.[A-Za-z0-9_.]+$', name)
    if m and m.group(0) in types:
        return m.group(0)
    # 去掉中间命名空间，如 module.account.model.XxxVo -> model.XxxVo
    parts = name.split('.')
    for i in range(len(parts)):
        cand = '.'.join(parts[i:])
        if cand in types:
            return cand
    return None


def spec(v):
    """把一个 Lua 类型描述编译成紧凑 spec 字符串"""
    if isinstance(v, str):
        if v in SHORT:
            return SHORT[v]
        n = norm(v)
        return 'o:' + n if n else 'x'
    if isinstance(v, dict):
        call = v.get('__call')
        if call == 'array':
            return 'a:' + spec(v.get('arg'))
        if call == 'map':
            a = v.get('arg')
            return 'm:' + spec(a)
        if call in ('enum', 'const'):
            return 'e'
        if call == 'set':
            return 'a:' + spec(v.get('arg'))
        if '__ref' in v:
            return spec(v['__ref'])
        return 'x'
    if isinstance(v, (int, float)):
        return 'e'
    if isinstance(v, bool):
        return 'b'
    return 'x'


# --- 编译 TYPES ---
out_types = {}
for tname, fields in types.items():
    if not isinstance(fields, dict):
        continue
    if '__array' in fields:
        continue
    fs = {k: spec(v) for k, v in fields.items() if not k.startswith('__')}
    if fs:
        out_types[tname] = fs

# --- 编译 CMD 表: [mod][cmd] = 应答 content 的 spec ---
out_cmd = {}
for mname, minfo in d['modules'].items():
    mod = minfo.get('mod')
    cmdtab = minfo.get('cmd') or {}
    if mod is None or not isinstance(cmdtab, dict):
        continue
    for cname, cdef in cmdtab.items():
        if not isinstance(cdef, list) or len(cdef) < 3:
            continue
        num = cdef[0]
        resp = cdef[2]
        content = None
        if isinstance(resp, dict) and 'content' in resp:
            content = spec(resp['content'])
        else:
            content = 'i'
        out_cmd.setdefault(mod, {})[num] = {'name': cname, 't': content}


def lua_escape(s):
    return s.replace('\\', '\\\\').replace('"', '\\"')


lines = []
lines.append('-- ============================================================')
lines.append('-- LocalServer : 本地离线伪服务端（由 09_脚本/17_gen_localserver.py 生成）')
lines.append('-- 注入到 script/base/NetMsg.dat，拦截 NetMsg:Send，直接本地应答')
lines.append('-- ============================================================')
lines.append('local LS = {}')
lines.append('LS.enabled = true')
lines.append('')
lines.append('-- 伪造的区服列表（对应 login:InitServerLst 期望的 JSON）')
lines.append('LS.SERVER_JSON = [[' + json.dumps({
    "list": [{
        "id": "1", "name": "本地单机", "ip": "127.0.0.1", "port": "9001",
        "area": "1", "areaName": "本地区", "flag": "1", "status": 1, "lv": 1,
        "recommend": 1, "hot": 1, "new": 1, "openTime": "2013-01-01 00:00:00"
    }]
}, ensure_ascii=False) + ']]')
lines.append('')
lines.append('-- 玩家固定数据')
lines.append('LS.PLAYER_NAME = "本地玩家"')
lines.append('LS.ACCOUNT = "localuser"')
lines.append('LS.SESSION = "localsession0001"')
lines.append('')

# TYPES
lines.append('local T = {}')
for tn, fs in sorted(out_types.items()):
    body = ', '.join('["%s"]="%s"' % (lua_escape(k), v) for k, v in sorted(fs.items()))
    lines.append('T["%s"] = {%s}' % (lua_escape(tn), body))
lines.append('')

# CMD
lines.append('local CMD = {}')
for mod, cmds in sorted(out_cmd.items()):
    body = ', '.join('[%d]={"%s","%s"}' % (c, lua_escape(v['name']), v['t']) for c, v in sorted(cmds.items()))
    lines.append('CMD[%d] = {%s}' % (mod, body))
lines.append('')

# 追加手写的游戏逻辑（LocalServer_logic.lua），schema 骨架 + 逻辑分离，便于持续修改
LOGIC = os.path.join(OUTDIR, 'LocalServer_logic.lua')
if os.path.exists(LOGIC):
    lines.append(open(LOGIC, encoding='utf-8').read())
else:
    print('!! 找不到 %s，只生成 schema 骨架' % LOGIC)

open(os.path.join(OUTDIR, 'LocalServer.lua'), 'w', encoding='utf-8').write('\n'.join(lines))
print('wrote LocalServer.lua  types=%d mods=%d lines=%d' % (len(out_types), len(out_cmd), len(lines)))
print('cmd 覆盖:')
for mod in sorted(out_cmd):
    print('  mod %-4d %2d cmds' % (mod, len(out_cmd[mod])))
