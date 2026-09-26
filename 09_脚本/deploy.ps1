# deploy.ps1 — 构建后的快速部署（install + pm clear + 授权 + 关闭权限审查 + 启动 + 抓日志）
param([int]$WaitSec = 30)
$ErrorActionPreference = 'SilentlyContinue'
$adb = 'D:\leidian\LDPlayer14\adb.exe'
$s = '127.0.0.1:5555'
$pkg = 'com.eyugame.ahxy.mi'
$apk = 'C:\Users\nkq\Desktop\game\hakimi\06_构建\hakimi_offline.apk'
$log = 'C:\Users\nkq\Desktop\game\hakimi\08_存档_twlog_latest.txt'

& $adb -s $s install -r $apk | Out-Null
& $adb -s $s shell pm clear $pkg | Out-Null
foreach($p in @('android.permission.READ_EXTERNAL_STORAGE','android.permission.WRITE_EXTERNAL_STORAGE','android.permission.READ_MEDIA_IMAGES','android.permission.READ_MEDIA_VIDEO','android.permission.READ_MEDIA_AUDIO','android.permission.POST_NOTIFICATIONS')){
  & $adb -s $s shell pm grant --user 0 $pkg $p | Out-Null
}
& $adb -s $s shell appops set $pkg LEGACY_STORAGE allow | Out-Null
& $adb -s $s logcat -c | Out-Null
& $adb -s $s shell am start -n "$pkg/com.eyugame.game.ActivityMain" | Out-Null
Start-Sleep -Seconds 10
& $adb -s $s shell uiautomator dump /sdcard/_u.xml | Out-Null
& $adb -s $s pull /sdcard/_u.xml 'C:\Users\nkq\Desktop\game\hakimi\08_存档_u.xml' | Out-Null
$raw = Get-Content 'C:\Users\nkq\Desktop\game\hakimi\08_存档_u.xml' -Raw -Encoding UTF8
if($raw -match '继续'){
  & $adb -s $s shell input tap 1864 1038 | Out-Null
  Start-Sleep -Seconds 1
  & $adb -s $s shell am force-stop $pkg | Out-Null
  & $adb -s $s logcat -c | Out-Null
  & $adb -s $s shell am start -n "$pkg/com.eyugame.game.ActivityMain" | Out-Null
}
Start-Sleep -Seconds $WaitSec
$pid = (& $adb -s $s shell pidof $pkg).Trim()
Write-Output "pid=$pid"
$out = & $adb -s $s logcat -d -v brief -s TwLog:V
$out | Out-File $log -Encoding utf8
Write-Output "TwLog lines: $($out.Count)"
# 关键行（去掉 traceback 噪声）
$out | Select-String -Pattern '\[PATCH\]|\[LocalServer\]|dispatch|OnReceived error|attempt to|nil value|undefined|ChgStage -> Normal|LoginComplete|Root' | ForEach-Object { ($_.Line -replace '^.*TwLog\s*\(\s*\d+\): ','') } | Select-Object -First 50
