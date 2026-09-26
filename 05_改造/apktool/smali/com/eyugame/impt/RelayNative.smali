.class public Lcom/eyugame/impt/RelayNative;
.super Ljava/lang/Object;
.source "RelayNative.java"


# static fields
.field private static mActivityMain:Lcom/eyugame/game/ActivityMain;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 22
    const/4 v0, 0x0

    sput-object v0, Lcom/eyugame/impt/RelayNative;->mActivityMain:Lcom/eyugame/game/ActivityMain;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 20
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static native CloseCallboard()V
.end method

.method public static native DecryptData([B)Ljava/lang/String;
.end method

.method public static native DecryptFile(Ljava/lang/String;)Ljava/lang/String;
.end method

.method public static native GetCrashReportFd(Ljava/lang/Integer;Ljava/lang/Integer;)I
.end method

.method public static native InitCrashReport(Ljava/lang/String;Ljava/lang/String;II)I
.end method

.method public static native InitUninstallMonitor(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I
.end method

.method public static native LogMsg(Ljava/lang/String;)V
.end method

.method public static native OnAutoPatch(I)V
.end method

.method public static native OnAvaliableStorageSize(I)V
.end method

.method public static native OnFBShareRst(Ljava/lang/String;)V
.end method

.method public static native OnGetKeychainItem(Ljava/lang/String;)V
.end method

.method public static native OnInputString(Ljava/lang/String;)V
.end method

.method public static native OnKeyboardShow(ZI)V
.end method

.method public static native OnLogin(ILjava/lang/String;)V
.end method

.method public static native OnLogout()V
.end method

.method public static native OnMemoryLow()V
.end method

.method public static native OnNetworkStatusChanged(II)V
.end method

.method public static native OnPay(Ljava/lang/String;)V
.end method

.method public static native OnProcUpdateMemroyInfo(IIF)V
.end method

.method public static native OnServerLst(Ljava/lang/String;)V
.end method

.method public static native OnWeixinShareRst(Ljava/lang/String;)V
.end method

.method public static native OpenFile(Ljava/lang/String;)Ljava/lang/String;
.end method

.method public static native SetDefaultAlphaPixelFormat(II)V
.end method

.method public static native SetSdkFuncStatus(Ljava/lang/String;Z)V
.end method

.method public static native StartIndicatorView()V
.end method

.method public static native StopIndicatorView()V
.end method

.method public static native Transmit(IILjava/lang/String;)V
.end method

.method static synthetic access$000()Lcom/eyugame/game/ActivityMain;
    .locals 1

    .prologue
    .line 20
    sget-object v0, Lcom/eyugame/impt/RelayNative;->mActivityMain:Lcom/eyugame/game/ActivityMain;

    return-object v0
.end method

.method public static doAddLocalNotification(Ljava/lang/String;)V
    .locals 1
    .param p0, "strInfo"    # Ljava/lang/String;

    .prologue
    .line 311
    invoke-static {}, Lcom/eyugame/pushmsg/PushMsgMgr;->GetSingleton()Lcom/eyugame/pushmsg/PushMsgMgr;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/eyugame/pushmsg/PushMsgMgr;->addLocalNotification(Ljava/lang/String;)V

    .line 312
    return-void
.end method

.method public static doBindAccount(Ljava/lang/String;)V
    .locals 1
    .param p0, "strInfo"    # Ljava/lang/String;

    .prologue
    .line 214
    sget-object v0, Lcom/eyugame/impt/RelayNative;->mActivityMain:Lcom/eyugame/game/ActivityMain;

    if-nez v0, :cond_0

    .line 219
    :goto_0
    return-void

    .line 218
    :cond_0
    sget-object v0, Lcom/eyugame/impt/RelayNative;->mActivityMain:Lcom/eyugame/game/ActivityMain;

    invoke-virtual {v0}, Lcom/eyugame/game/ActivityMain;->GetSdkPlatform()Lcom/eyugame/base/ISdkPlatform;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/eyugame/base/ISdkPlatform;->bindAccount(Ljava/lang/String;)V

    goto :goto_0
.end method

.method public static doCallBoard(Ljava/lang/String;)V
    .locals 1
    .param p0, "jsonStr"    # Ljava/lang/String;

    .prologue
    .line 149
    invoke-static {}, Lcom/eyugame/game/WebviewMgr;->GetSingleton()Lcom/eyugame/game/WebviewMgr;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/eyugame/game/WebviewMgr;->doCallBoard(Ljava/lang/String;)V

    .line 150
    return-void
.end method

.method public static doCheckAvaliableStorageSize()V
    .locals 1

    .prologue
    .line 267
    sget-object v0, Lcom/eyugame/impt/RelayNative;->mActivityMain:Lcom/eyugame/game/ActivityMain;

    if-nez v0, :cond_0

    .line 272
    :goto_0
    return-void

    .line 271
    :cond_0
    sget-object v0, Lcom/eyugame/impt/RelayNative;->mActivityMain:Lcom/eyugame/game/ActivityMain;

    invoke-virtual {v0}, Lcom/eyugame/game/ActivityMain;->doCheckAvaliableStorageSize()V

    goto :goto_0
.end method

.method public static doCheckSdkFunc(Ljava/lang/String;)V
    .locals 2
    .param p0, "strFlag"    # Ljava/lang/String;

    .prologue
    .line 246
    sget-object v1, Lcom/eyugame/impt/RelayNative;->mActivityMain:Lcom/eyugame/game/ActivityMain;

    if-nez v1, :cond_0

    .line 252
    :goto_0
    return-void

    .line 250
    :cond_0
    sget-object v1, Lcom/eyugame/impt/RelayNative;->mActivityMain:Lcom/eyugame/game/ActivityMain;

    invoke-virtual {v1}, Lcom/eyugame/game/ActivityMain;->GetSdkPlatform()Lcom/eyugame/base/ISdkPlatform;

    move-result-object v1

    invoke-virtual {v1, p0}, Lcom/eyugame/base/ISdkPlatform;->checkSdkFunc(Ljava/lang/String;)Z

    move-result v0

    .line 251
    .local v0, "bOpened":Z
    invoke-static {p0, v0}, Lcom/eyugame/impt/RelayNative;->SetSdkFuncStatus(Ljava/lang/String;Z)V

    goto :goto_0
.end method

.method public static doCloseCallBoard()V
    .locals 1

    .prologue
    .line 153
    invoke-static {}, Lcom/eyugame/game/WebviewMgr;->GetSingleton()Lcom/eyugame/game/WebviewMgr;

    move-result-object v0

    invoke-virtual {v0}, Lcom/eyugame/game/WebviewMgr;->doCloseCallboard()V

    .line 154
    return-void
.end method

.method public static doCloseCloseWebPage()V
    .locals 1

    .prologue
    .line 161
    invoke-static {}, Lcom/eyugame/game/WebviewMgr;->GetSingleton()Lcom/eyugame/game/WebviewMgr;

    move-result-object v0

    invoke-virtual {v0}, Lcom/eyugame/game/WebviewMgr;->doCloseCloseWebPage()V

    .line 162
    return-void
.end method

.method public static doDelAccount(Ljava/lang/String;)V
    .locals 1
    .param p0, "strInfo"    # Ljava/lang/String;

    .prologue
    .line 222
    sget-object v0, Lcom/eyugame/impt/RelayNative;->mActivityMain:Lcom/eyugame/game/ActivityMain;

    if-nez v0, :cond_0

    .line 227
    :goto_0
    return-void

    .line 226
    :cond_0
    sget-object v0, Lcom/eyugame/impt/RelayNative;->mActivityMain:Lcom/eyugame/game/ActivityMain;

    invoke-virtual {v0}, Lcom/eyugame/game/ActivityMain;->GetSdkPlatform()Lcom/eyugame/base/ISdkPlatform;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/eyugame/base/ISdkPlatform;->delAccount(Ljava/lang/String;)V

    goto :goto_0
.end method

.method public static doDelLocalNotification(Ljava/lang/String;)V
    .locals 1
    .param p0, "strInfo"    # Ljava/lang/String;

    .prologue
    .line 315
    invoke-static {}, Lcom/eyugame/pushmsg/PushMsgMgr;->GetSingleton()Lcom/eyugame/pushmsg/PushMsgMgr;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/eyugame/pushmsg/PushMsgMgr;->delLocalNotification(Ljava/lang/String;)V

    .line 316
    return-void
.end method

.method public static doEditChgPos(IIII)V
    .locals 1
    .param p0, "nL"    # I
    .param p1, "nT"    # I
    .param p2, "nWidth"    # I
    .param p3, "nHeight"    # I

    .prologue
    .line 137
    sget-object v0, Lcom/eyugame/impt/RelayNative;->mActivityMain:Lcom/eyugame/game/ActivityMain;

    if-nez v0, :cond_0

    .line 142
    :goto_0
    return-void

    .line 141
    :cond_0
    sget-object v0, Lcom/eyugame/impt/RelayNative;->mActivityMain:Lcom/eyugame/game/ActivityMain;

    invoke-virtual {v0, p0, p1, p2, p3}, Lcom/eyugame/game/ActivityMain;->doEditChgPos(IIII)V

    goto :goto_0
.end method

.method public static doEditFocusChg(Ljava/lang/String;III)V
    .locals 1
    .param p0, "strText"    # Ljava/lang/String;
    .param p1, "nLenLimit"    # I
    .param p2, "nKeyboardType"    # I
    .param p3, "nFlag"    # I

    .prologue
    .line 124
    sget-object v0, Lcom/eyugame/impt/RelayNative;->mActivityMain:Lcom/eyugame/game/ActivityMain;

    if-nez v0, :cond_0

    .line 134
    :goto_0
    return-void

    .line 128
    :cond_0
    if-eqz p3, :cond_1

    .line 129
    sget-object v0, Lcom/eyugame/impt/RelayNative;->mActivityMain:Lcom/eyugame/game/ActivityMain;

    invoke-virtual {v0, p0, p1, p2}, Lcom/eyugame/game/ActivityMain;->doSetFocus(Ljava/lang/String;II)V

    goto :goto_0

    .line 132
    :cond_1
    sget-object v0, Lcom/eyugame/impt/RelayNative;->mActivityMain:Lcom/eyugame/game/ActivityMain;

    invoke-virtual {v0}, Lcom/eyugame/game/ActivityMain;->doReleaseFocus()V

    goto :goto_0
.end method

.method public static doEnterPlatform(Ljava/lang/String;)V
    .locals 1
    .param p0, "strFlag"    # Ljava/lang/String;

    .prologue
    .line 67
    sget-object v0, Lcom/eyugame/impt/RelayNative;->mActivityMain:Lcom/eyugame/game/ActivityMain;

    if-nez v0, :cond_0

    .line 72
    :goto_0
    return-void

    .line 71
    :cond_0
    sget-object v0, Lcom/eyugame/impt/RelayNative;->mActivityMain:Lcom/eyugame/game/ActivityMain;

    invoke-virtual {v0}, Lcom/eyugame/game/ActivityMain;->GetSdkPlatform()Lcom/eyugame/base/ISdkPlatform;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/eyugame/base/ISdkPlatform;->enter(Ljava/lang/String;)I

    goto :goto_0
.end method

.method public static doExit()V
    .locals 1

    .prologue
    .line 107
    sget-object v0, Lcom/eyugame/impt/RelayNative;->mActivityMain:Lcom/eyugame/game/ActivityMain;

    if-eqz v0, :cond_0

    .line 108
    sget-object v0, Lcom/eyugame/impt/RelayNative;->mActivityMain:Lcom/eyugame/game/ActivityMain;

    invoke-virtual {v0}, Lcom/eyugame/game/ActivityMain;->GetSdkPlatform()Lcom/eyugame/base/ISdkPlatform;

    move-result-object v0

    invoke-virtual {v0}, Lcom/eyugame/base/ISdkPlatform;->onDestroy()V

    .line 111
    :cond_0
    invoke-static {}, Landroid/os/Process;->myPid()I

    move-result v0

    invoke-static {v0}, Landroid/os/Process;->killProcess(I)V

    .line 113
    return-void
.end method

.method public static doGetKeyChainItem(Ljava/lang/String;)V
    .locals 5
    .param p0, "key"    # Ljava/lang/String;

    .prologue
    .line 275
    sget-object v2, Lcom/eyugame/impt/RelayNative;->mActivityMain:Lcom/eyugame/game/ActivityMain;

    if-nez v2, :cond_0

    .line 283
    :goto_0
    return-void

    .line 279
    :cond_0
    sget-object v2, Lcom/eyugame/impt/RelayNative;->mActivityMain:Lcom/eyugame/game/ActivityMain;

    const-string v3, "SP"

    const/4 v4, 0x0

    invoke-virtual {v2, v3, v4}, Lcom/eyugame/game/ActivityMain;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    .line 280
    .local v0, "sp":Landroid/content/SharedPreferences;
    const-string v2, ""

    invoke-interface {v0, p0, v2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 282
    .local v1, "value":Ljava/lang/String;
    invoke-static {v1}, Lcom/eyugame/impt/RelayNative;->OnGetKeychainItem(Ljava/lang/String;)V

    goto :goto_0
.end method

.method public static doInitSdk(Ljava/lang/String;)V
    .locals 2
    .param p0, "strInfo"    # Ljava/lang/String;

    .prologue
    .line 193
    sget-object v0, Lcom/eyugame/impt/RelayNative;->mActivityMain:Lcom/eyugame/game/ActivityMain;

    if-nez v0, :cond_0

    .line 203
    :goto_0
    return-void

    .line 197
    :cond_0
    sget-object v0, Lcom/eyugame/impt/RelayNative;->mActivityMain:Lcom/eyugame/game/ActivityMain;

    new-instance v1, Lcom/eyugame/impt/RelayNative$1;

    invoke-direct {v1, p0}, Lcom/eyugame/impt/RelayNative$1;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, v1}, Lcom/eyugame/game/ActivityMain;->runOnUiThread(Ljava/lang/Runnable;)V

    goto :goto_0
.end method

.method public static doLogin(Ljava/lang/String;)V
    .locals 1
    .param p0, "strInfo"    # Ljava/lang/String;

    .prologue
    .line 75
    sget-object v0, Lcom/eyugame/impt/RelayNative;->mActivityMain:Lcom/eyugame/game/ActivityMain;

    if-nez v0, :cond_0

    .line 80
    :goto_0
    return-void

    .line 79
    :cond_0
    sget-object v0, Lcom/eyugame/impt/RelayNative;->mActivityMain:Lcom/eyugame/game/ActivityMain;

    invoke-virtual {v0}, Lcom/eyugame/game/ActivityMain;->GetSdkPlatform()Lcom/eyugame/base/ISdkPlatform;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/eyugame/base/ISdkPlatform;->login(Ljava/lang/String;)I

    goto :goto_0
.end method

.method public static doLoginComplete(Ljava/lang/String;)V
    .locals 4
    .param p0, "strData"    # Ljava/lang/String;

    .prologue
    .line 83
    sget-object v1, Lcom/eyugame/impt/RelayNative;->mActivityMain:Lcom/eyugame/game/ActivityMain;

    if-nez v1, :cond_0

    .line 95
    .end local p0    # "strData":Ljava/lang/String;
    .local v0, "jsonObject":Lorg/json/JSONObject;
    :goto_0
    return-void

    .line 87
    .end local v0    # "jsonObject":Lorg/json/JSONObject;
    .restart local p0    # "strData":Ljava/lang/String;
    :cond_0
    sget-object v1, Lcom/eyugame/impt/RelayNative;->mActivityMain:Lcom/eyugame/game/ActivityMain;

    invoke-virtual {v1}, Lcom/eyugame/game/ActivityMain;->GetSdkPlatform()Lcom/eyugame/base/ISdkPlatform;

    move-result-object v1

    invoke-virtual {v1, p0}, Lcom/eyugame/base/ISdkPlatform;->loginComplete(Ljava/lang/String;)V

    .line 90
    :try_start_0
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0, p0}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 91
    .restart local v0    # "jsonObject":Lorg/json/JSONObject;
    const-string v1, "time"

    invoke-virtual {v0, v1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1

    const-string v1, "time"

    invoke-virtual {v0, v1}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p0

    .end local p0    # "strData":Ljava/lang/String;
    :cond_1
    invoke-static {p0}, Ljava/lang/Long;->valueOf(Ljava/lang/String;)Ljava/lang/Long;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Long;->longValue()J

    move-result-wide v2

    .line 92
    .local v2, "lTime":J
    invoke-static {}, Lcom/eyugame/pushmsg/PushMsgMgr;->GetSingleton()Lcom/eyugame/pushmsg/PushMsgMgr;

    move-result-object v1

    invoke-virtual {v1, v2, v3}, Lcom/eyugame/pushmsg/PushMsgMgr;->loginComplete(J)V
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 93
    .end local v2    # "lTime":J
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method public static doLogout()V
    .locals 1

    .prologue
    .line 98
    sget-object v0, Lcom/eyugame/impt/RelayNative;->mActivityMain:Lcom/eyugame/game/ActivityMain;

    if-nez v0, :cond_0

    .line 104
    :goto_0
    return-void

    .line 102
    :cond_0
    sget-object v0, Lcom/eyugame/impt/RelayNative;->mActivityMain:Lcom/eyugame/game/ActivityMain;

    invoke-virtual {v0}, Lcom/eyugame/game/ActivityMain;->GetSdkPlatform()Lcom/eyugame/base/ISdkPlatform;

    move-result-object v0

    invoke-virtual {v0}, Lcom/eyugame/base/ISdkPlatform;->logout()I

    .line 103
    invoke-static {}, Lcom/eyugame/impt/RelayNative;->OnLogout()V

    goto :goto_0
.end method

.method public static doOpenURL(Ljava/lang/String;)V
    .locals 1
    .param p0, "strURL"    # Ljava/lang/String;

    .prologue
    .line 145
    invoke-static {}, Lcom/eyugame/game/WebviewMgr;->GetSingleton()Lcom/eyugame/game/WebviewMgr;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/eyugame/game/WebviewMgr;->doOpenURL(Ljava/lang/String;)V

    .line 146
    return-void
.end method

.method public static doOpenUrlInRect(Ljava/lang/String;)V
    .locals 1
    .param p0, "jsonStr"    # Ljava/lang/String;

    .prologue
    .line 157
    invoke-static {}, Lcom/eyugame/game/WebviewMgr;->GetSingleton()Lcom/eyugame/game/WebviewMgr;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/eyugame/game/WebviewMgr;->doOpenUrlInRect(Ljava/lang/String;)V

    .line 158
    return-void
.end method

.method public static doPopAdvert(Ljava/lang/String;)V
    .locals 1
    .param p0, "strInfo"    # Ljava/lang/String;

    .prologue
    .line 238
    sget-object v0, Lcom/eyugame/impt/RelayNative;->mActivityMain:Lcom/eyugame/game/ActivityMain;

    if-nez v0, :cond_0

    .line 243
    :goto_0
    return-void

    .line 242
    :cond_0
    sget-object v0, Lcom/eyugame/impt/RelayNative;->mActivityMain:Lcom/eyugame/game/ActivityMain;

    invoke-virtual {v0}, Lcom/eyugame/game/ActivityMain;->GetSdkPlatform()Lcom/eyugame/base/ISdkPlatform;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/eyugame/base/ISdkPlatform;->popAdvert(Ljava/lang/String;)V

    goto :goto_0
.end method

.method public static doProcCheckNetwork()V
    .locals 1

    .prologue
    .line 185
    sget-object v0, Lcom/eyugame/impt/RelayNative;->mActivityMain:Lcom/eyugame/game/ActivityMain;

    if-nez v0, :cond_0

    .line 190
    :goto_0
    return-void

    .line 189
    :cond_0
    sget-object v0, Lcom/eyugame/impt/RelayNative;->mActivityMain:Lcom/eyugame/game/ActivityMain;

    invoke-virtual {v0}, Lcom/eyugame/game/ActivityMain;->procUpdateNetworkStatus()V

    goto :goto_0
.end method

.method public static doProcCheckUpdate(Ljava/lang/String;)V
    .locals 2
    .param p0, "strInfo"    # Ljava/lang/String;

    .prologue
    .line 177
    sget-object v0, Lcom/eyugame/impt/RelayNative;->mActivityMain:Lcom/eyugame/game/ActivityMain;

    if-nez v0, :cond_0

    .line 182
    :goto_0
    return-void

    .line 181
    :cond_0
    sget-object v0, Lcom/eyugame/impt/RelayNative;->mActivityMain:Lcom/eyugame/game/ActivityMain;

    invoke-virtual {v0}, Lcom/eyugame/game/ActivityMain;->GetPackageUpdate()Lcom/eyugame/base/IPackageUpdate;

    move-result-object v0

    sget-object v1, Lcom/eyugame/impt/RelayNative;->mActivityMain:Lcom/eyugame/game/ActivityMain;

    invoke-interface {v0, p0, v1}, Lcom/eyugame/base/IPackageUpdate;->checkUpdate(Ljava/lang/String;Landroid/app/Activity;)Z

    goto :goto_0
.end method

.method public static doProcKeepScreenOn(Z)V
    .locals 1
    .param p0, "bState"    # Z

    .prologue
    .line 169
    sget-object v0, Lcom/eyugame/impt/RelayNative;->mActivityMain:Lcom/eyugame/game/ActivityMain;

    if-nez v0, :cond_0

    .line 174
    :goto_0
    return-void

    .line 173
    :cond_0
    sget-object v0, Lcom/eyugame/impt/RelayNative;->mActivityMain:Lcom/eyugame/game/ActivityMain;

    invoke-virtual {v0, p0}, Lcom/eyugame/game/ActivityMain;->doProcKeepScreenOn(Z)V

    goto :goto_0
.end method

.method public static doProcPay(Ljava/lang/String;)V
    .locals 1
    .param p0, "strDescription"    # Ljava/lang/String;

    .prologue
    .line 116
    sget-object v0, Lcom/eyugame/impt/RelayNative;->mActivityMain:Lcom/eyugame/game/ActivityMain;

    if-nez v0, :cond_0

    .line 121
    :goto_0
    return-void

    .line 120
    :cond_0
    sget-object v0, Lcom/eyugame/impt/RelayNative;->mActivityMain:Lcom/eyugame/game/ActivityMain;

    invoke-virtual {v0}, Lcom/eyugame/game/ActivityMain;->GetSdkPlatform()Lcom/eyugame/base/ISdkPlatform;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/eyugame/base/ISdkPlatform;->pay(Ljava/lang/String;)I

    goto :goto_0
.end method

.method public static doProcUpdateMemoryInfo(FII)V
    .locals 1
    .param p0, "fCpuUsage"    # F
    .param p1, "nUsedMemory"    # I
    .param p2, "nAvailMemory"    # I

    .prologue
    .line 59
    sget-object v0, Lcom/eyugame/impt/RelayNative;->mActivityMain:Lcom/eyugame/game/ActivityMain;

    if-nez v0, :cond_0

    .line 64
    :goto_0
    return-void

    .line 63
    :cond_0
    sget-object v0, Lcom/eyugame/impt/RelayNative;->mActivityMain:Lcom/eyugame/game/ActivityMain;

    invoke-virtual {v0, p0, p1, p2}, Lcom/eyugame/game/ActivityMain;->procUpdateMemoryInfo(FII)V

    goto :goto_0
.end method

.method public static doProcWeiboShare(Ljava/lang/String;)V
    .locals 0
    .param p0, "jsonStr"    # Ljava/lang/String;

    return-void
.end method

.method public static doQQShare(Ljava/lang/String;)V
    .locals 0
    .param p0, "strInfo"    # Ljava/lang/String;

    return-void
.end method

.method public static doQueryServerLst(Ljava/lang/String;)V
    .locals 1
    .param p0, "strInfo"    # Ljava/lang/String;

    .prologue
    .line 230
    sget-object v0, Lcom/eyugame/impt/RelayNative;->mActivityMain:Lcom/eyugame/game/ActivityMain;

    if-nez v0, :cond_0

    .line 235
    :goto_0
    return-void

    .line 234
    :cond_0
    sget-object v0, Lcom/eyugame/impt/RelayNative;->mActivityMain:Lcom/eyugame/game/ActivityMain;

    invoke-virtual {v0}, Lcom/eyugame/game/ActivityMain;->GetSdkPlatform()Lcom/eyugame/base/ISdkPlatform;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/eyugame/base/ISdkPlatform;->queryServerLst(Ljava/lang/String;)V

    goto :goto_0
.end method

.method public static doSendPlayerInfo(Ljava/lang/String;)V
    .locals 1
    .param p0, "strInfo"    # Ljava/lang/String;

    .prologue
    .line 206
    sget-object v0, Lcom/eyugame/impt/RelayNative;->mActivityMain:Lcom/eyugame/game/ActivityMain;

    if-nez v0, :cond_0

    .line 211
    :goto_0
    return-void

    .line 210
    :cond_0
    sget-object v0, Lcom/eyugame/impt/RelayNative;->mActivityMain:Lcom/eyugame/game/ActivityMain;

    invoke-virtual {v0}, Lcom/eyugame/game/ActivityMain;->GetSdkPlatform()Lcom/eyugame/base/ISdkPlatform;

    move-result-object v0

    invoke-virtual {v0, p0}, Lcom/eyugame/base/ISdkPlatform;->sendPlayerInfo(Ljava/lang/String;)V

    goto :goto_0
.end method

.method public static doSetKeyChainItem(Ljava/lang/String;)V
    .locals 10
    .param p0, "strInfo"    # Ljava/lang/String;

    .prologue
    .line 286
    sget-object v7, Lcom/eyugame/impt/RelayNative;->mActivityMain:Lcom/eyugame/game/ActivityMain;

    if-nez v7, :cond_0

    .line 308
    :goto_0
    return-void

    .line 290
    :cond_0
    sget-object v7, Lcom/eyugame/impt/RelayNative;->mActivityMain:Lcom/eyugame/game/ActivityMain;

    const-string v8, "SP"

    const/4 v9, 0x0

    invoke-virtual {v7, v8, v9}, Lcom/eyugame/game/ActivityMain;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v5

    .line 291
    .local v5, "sp":Landroid/content/SharedPreferences;
    invoke-interface {v5}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v1

    .line 294
    .local v1, "editor":Landroid/content/SharedPreferences$Editor;
    :try_start_0
    new-instance v2, Lorg/json/JSONObject;

    invoke-direct {v2, p0}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 295
    .local v2, "info":Lorg/json/JSONObject;
    invoke-virtual {v2}, Lorg/json/JSONObject;->keys()Ljava/util/Iterator;

    move-result-object v4

    .line 297
    .local v4, "keys":Ljava/util/Iterator;, "Ljava/util/Iterator<*>;"
    :goto_1
    invoke-interface {v4}, Ljava/util/Iterator;->hasNext()Z

    move-result v7

    if-eqz v7, :cond_1

    .line 298
    invoke-interface {v4}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/String;

    .line 299
    .local v3, "key":Ljava/lang/String;
    invoke-virtual {v2, v3}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    .line 300
    .local v6, "value":Ljava/lang/String;
    invoke-interface {v1, v3, v6}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    .line 303
    .end local v2    # "info":Lorg/json/JSONObject;
    .end local v3    # "key":Ljava/lang/String;
    .end local v4    # "keys":Ljava/util/Iterator;, "Ljava/util/Iterator<*>;"
    .end local v6    # "value":Ljava/lang/String;
    :catch_0
    move-exception v0

    .line 304
    .local v0, "e":Lorg/json/JSONException;
    const-string v7, "setKeyChainItem error"

    invoke-static {v7}, Lcom/eyugame/impt/RelayNative;->LogMsg(Ljava/lang/String;)V

    .line 307
    .end local v0    # "e":Lorg/json/JSONException;
    :cond_1
    invoke-interface {v1}, Landroid/content/SharedPreferences$Editor;->commit()Z

    goto :goto_0
.end method

.method public static doShareFB(Ljava/lang/String;)V
    .locals 1
    .param p0, "strInfo"    # Ljava/lang/String;

    const-string v0, "{\"code\":-1,\"ret\":false,\"reason\":\"unsupported\"}"

    invoke-static {v0}, Lcom/eyugame/impt/RelayNative;->OnFBShareRst(Ljava/lang/String;)V

    return-void
.end method

.method public static doWeixinShare(Ljava/lang/String;)V
    .locals 1
    .param p0, "strInfo"    # Ljava/lang/String;

    const-string v0, "{\"WeixinCode\":\"-1\",\"bWeixinInstall\":\"0\",\"bWeixinOpenApi\":\"0\",\"WeixinVersion\":\"0\",\"reason\":\"unsupported\"}"

    invoke-static {v0}, Lcom/eyugame/impt/RelayNative;->OnWeixinShareRst(Ljava/lang/String;)V

    return-void
.end method

.method public static setActivityMain(Lcom/eyugame/game/ActivityMain;)V
    .locals 0
    .param p0, "activity"    # Lcom/eyugame/game/ActivityMain;

    .prologue
    .line 26
    sput-object p0, Lcom/eyugame/impt/RelayNative;->mActivityMain:Lcom/eyugame/game/ActivityMain;

    .line 27
    return-void
.end method
