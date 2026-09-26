#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
对 apktool 解出的 smali 打两处补丁，然后汇编成 classes.dex：

 1) RelayNative.doLogin / doEnterPlatform / doLogout / doLoginComplete
    这些方法直接 ActivityMain.sdkPlatform.xxx()，没有 null 检查。
    离线版跳过了 Sdk:OnInit()，sdkPlatform 一直是 null
    → NullPointerException → libc SIGABRT（整个进程崩溃）。
    加上 if-eqz 守卫即可。

 2) Cocos2dxHelper.initResPath
    它用 Environment.getExternalStorageDirectory() + "/Android/data/<pkg>/files/..."
    手拼路径，从不调用 getExternalFilesDir()，所以框架不会创建这个目录；
    Android 11+ 又不允许应用自己 mkdir 这一段，导致资源拷贝失败
    （弹"释放资源到SD卡中失败"）。
    在方法开头加一次 getExternalFilesDir(null) 让框架把目录建好。
"""
import os, re, sys, subprocess, shutil

ROOT = r'C:\Users\nkq\Desktop\game\hakimi'
TT = r'C:\Users\nkq\Desktop\game\ttaxy'   # 工具链在原版工作区
SMALI = os.path.join(ROOT, '05_改造', 'apktool')
BUILD = os.path.join(ROOT, '06_构建')
JDK = os.path.join(TT, '03_工具链', 'jdk')
SMALI_JAR = os.path.join(TT, '03_工具链', '_downloads', 'smali-2.5.2.jar')
OUT_DEX = os.path.join(BUILD, 'classes.dex')


def log(s):
    print(s, flush=True)


# ---------- 1) RelayNative null 守卫 ----------
relay = os.path.join(SMALI, 'smali', 'com', 'eyugame', 'impt', 'RelayNative.smali')
src = open(relay, encoding='utf-8').read()
GUARD = [('doLogin', 'Ljava/lang/String;'), ('doEnterPlatform', 'Ljava/lang/String;'),
         ('doLogout', 'V'), ('doLoginComplete', 'Ljava/lang/String;')]
for name, sig in GUARD:
    head = '.method public static %s(' % name
    i = src.find(head)
    if i < 0:
        raise SystemExit('找不到方法 ' + name)
    j = src.find('.end method', i)
    body = src[i:j]
    m = re.search(r'(sget-object (v\d+), Lcom/eyugame/game/ActivityMain;->sdkPlatform:[^\n]*)', body)
    if not m:
        log('  %-18s 无 sdkPlatform 引用，跳过' % name)
        continue
    reg = m.group(2)
    if ('if-eqz %s,' % reg) in body:
        log('  %-18s 已有 null 守卫，跳过' % name)
        continue
    label = ':cond_%s' % name
    body2 = body[:m.end(1)] + '\n\n    if-eqz %s, %s' % (reg, label) + body[m.end(1):]
    # 在最后一个 return-void 之前插入标签
    k = body2.rfind('return-void')
    body2 = body2[:k] + label + '\n\n    ' + body2[k:]
    src = src[:i] + body2 + src[j:]
    log('  %-18s 已加 null 守卫' % name)
open(relay, 'w', encoding='utf-8', newline='\n').write(src)

# ---------- 2) Cocos2dxHelper.initResPath 创建外部目录 ----------
cx = os.path.join(SMALI, 'smali', 'org', 'cocos2dx', 'lib', 'Cocos2dxHelper.smali')
src2 = open(cx, encoding='utf-8').read()
head = '.method public static initResPath(Landroid/content/Context;)V'
i = src2.find(head)
if i < 0:
    raise SystemExit('找不到 initResPath')
j = src2.find('.prologue', i)
if j < 0:
    raise SystemExit('initResPath 无 .prologue')
j += len('.prologue')
INJECT = ('\n\n    const/4 v0, 0x0\n\n'
          '    invoke-virtual {p0, v0}, Landroid/content/Context;->getExternalFilesDir(Ljava/lang/String;)Ljava/io/File;')
if 'getExternalFilesDir' in src2[i:i + 4000]:
    log('  initResPath       已有 getExternalFilesDir，跳过')
else:
    src2 = src2[:j] + INJECT + src2[j:]
    open(cx, 'w', encoding='utf-8', newline='\n').write(src2)
    log('  initResPath       已插入 getExternalFilesDir(null)')

# ---------- 2.5) 去掉盖住游戏画面的 splash ImageView ----------
# Cocos2dxActivity.onCreateView 最后把 mBgView(标题图) addView 到 FrameLayout，
# 而 SurfaceView 默认在窗口图层「下面」，且唯一能隐藏它的 ClearBackground()
# 在 dex 里零调用（死代码）—— 所以标题图会永远盖住游戏画面。
cx2 = os.path.join(SMALI, 'smali', 'org', 'cocos2dx', 'lib', 'Cocos2dxActivity.smali')
src3 = open(cx2, encoding='utf-8').read()
old = ('    iget-object v10, p0, Lorg/cocos2dx/lib/Cocos2dxActivity;->mBgView:Landroid/widget/ImageView;\n'
       '\n'
       '    invoke-virtual {v2, v10}, Landroid/widget/RelativeLayout;->addView(Landroid/view/View;)V')
new = ('    iget-object v10, p0, Lorg/cocos2dx/lib/Cocos2dxActivity;->mBgView:Landroid/widget/ImageView;\n'
       '\n'
       '    const/4 v11, 0x4\n'
       '\n'
       '    invoke-virtual {v10, v11}, Landroid/widget/ImageView;->setVisibility(I)V')
if old in src3:
    src3 = src3.replace(old, new, 1)
    open(cx2, 'w', encoding='utf-8', newline='\n').write(src3)
    log('  Cocos2dxActivity  splash 不再盖住游戏画面（改为 setVisibility(4)）')
elif 'setVisibility(I)V' in src3 and 'mBgView' in src3:
    log('  Cocos2dxActivity  splash 补丁似乎已应用，跳过')
else:
    log('  !! Cocos2dxActivity splash 补丁失败（未匹配到 addView）')

# ---------- 3) 汇编 ----------
smali_dirs = sorted(d for d in os.listdir(SMALI) if re.fullmatch(r'smali(_classes\d+)?', d))
log('smali 目录: %s' % smali_dirs)
if len(smali_dirs) > 1:
    log('!! 多 dex 工程，本脚本只处理 smali/')

env = dict(os.environ)
env['JAVA_HOME'] = JDK
env['PATH'] = os.path.join(JDK, 'bin') + os.pathsep + env['PATH']
if os.path.exists(OUT_DEX):
    os.remove(OUT_DEX)
r = subprocess.run([os.path.join(JDK, 'bin', 'java.exe'), '-jar', SMALI_JAR, 'a',
                    os.path.join(SMALI, 'smali'), '-o', OUT_DEX, '--api', '19'],
                   capture_output=True, text=True, env=env)
log('smali rc=%d' % r.returncode)
if r.stdout:
    log(r.stdout[-1500:])
if r.stderr:
    log(r.stderr[-3000:])
if not os.path.exists(OUT_DEX):
    sys.exit('汇编失败')
log('classes.dex 生成: %d 字节' % os.path.getsize(OUT_DEX))
