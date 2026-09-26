.class public Lcom/eyugame/game/ActivityMain;
.super Lorg/cocos2dx/lib/Cocos2dxActivity;
.source "ActivityMain.java"

# interfaces
.implements Lcom/eyugame/base/LocationUtils$CopyStatus;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/eyugame/game/ActivityMain$InitThread;
    }
.end annotation


# static fields
.field public static IsCheckConversion:Z = false

.field public static IsNewUser:Z = false

.field private static ResCopyDir:Ljava/lang/String; = null

.field private static final TAG:Ljava/lang/String; = "ActivityMain"

.field private static mKeyboardHeight:I

.field private static needSize:I

.field private static packageUpdate:Lcom/eyugame/base/IPackageUpdate;

.field private static sContext:Lcom/eyugame/game/ActivityMain;

.field private static sdkPlatform:Lcom/eyugame/base/ISdkPlatform;

.field private static strSdkTypeName:Ljava/lang/String;


# instance fields
.field private jsonSdkConfig:Lorg/json/JSONObject;

.field private mEditText:Lorg/cocos2dx/lib/Cocos2dxEditText;

.field private mObjDelay:Ljava/lang/Object;

.field public mSavedInstanceState:Landroid/os/Bundle;

.field private final mTouchDelayTime:J

.field private netType:Lcom/eyugame/base/NetworkStatus$EYNetType;

.field private strOperatorPath:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 3

    .prologue
    const/4 v2, 0x0

    const/4 v1, 0x0

    .line 80
    const-string v0, "game"

    invoke-static {v0}, Ljava/lang/System;->loadLibrary(Ljava/lang/String;)V

    .line 89
    sput-object v2, Lcom/eyugame/game/ActivityMain;->sContext:Lcom/eyugame/game/ActivityMain;

    .line 90
    const-string v0, ""

    sput-object v0, Lcom/eyugame/game/ActivityMain;->ResCopyDir:Ljava/lang/String;

    .line 91
    const-string v0, ""

    sput-object v0, Lcom/eyugame/game/ActivityMain;->strSdkTypeName:Ljava/lang/String;

    .line 92
    const/16 v0, 0x12c

    sput v0, Lcom/eyugame/game/ActivityMain;->mKeyboardHeight:I

    .line 93
    sput v1, Lcom/eyugame/game/ActivityMain;->needSize:I

    .line 96
    sput-object v2, Lcom/eyugame/game/ActivityMain;->sdkPlatform:Lcom/eyugame/base/ISdkPlatform;

    .line 97
    sput-boolean v1, Lcom/eyugame/game/ActivityMain;->IsNewUser:Z

    .line 98
    sput-boolean v1, Lcom/eyugame/game/ActivityMain;->IsCheckConversion:Z

    .line 106
    sput-object v2, Lcom/eyugame/game/ActivityMain;->packageUpdate:Lcom/eyugame/base/IPackageUpdate;

    return-void
.end method

.method public constructor <init>()V
    .locals 3

    .prologue
    const/4 v2, 0x0

    .line 78
    invoke-direct {p0}, Lorg/cocos2dx/lib/Cocos2dxActivity;-><init>()V

    .line 83
    iput-object v2, p0, Lcom/eyugame/game/ActivityMain;->mObjDelay:Ljava/lang/Object;

    .line 85
    const-wide/16 v0, 0x32

    iput-wide v0, p0, Lcom/eyugame/game/ActivityMain;->mTouchDelayTime:J

    .line 88
    iput-object v2, p0, Lcom/eyugame/game/ActivityMain;->mEditText:Lorg/cocos2dx/lib/Cocos2dxEditText;

    .line 94
    sget-object v0, Lcom/eyugame/base/NetworkStatus$EYNetType;->EY_NONE:Lcom/eyugame/base/NetworkStatus$EYNetType;

    iput-object v0, p0, Lcom/eyugame/game/ActivityMain;->netType:Lcom/eyugame/base/NetworkStatus$EYNetType;

    .line 100
    iput-object v2, p0, Lcom/eyugame/game/ActivityMain;->mSavedInstanceState:Landroid/os/Bundle;

    .line 101
    iput-object v2, p0, Lcom/eyugame/game/ActivityMain;->jsonSdkConfig:Lorg/json/JSONObject;

    .line 102
    iput-object v2, p0, Lcom/eyugame/game/ActivityMain;->strOperatorPath:Ljava/lang/String;

    .line 196
    return-void
.end method

.method public static GetInstance()Lcom/eyugame/game/ActivityMain;
    .locals 1

    .prologue
    .line 138
    sget-object v0, Lcom/eyugame/game/ActivityMain;->sContext:Lcom/eyugame/game/ActivityMain;

    return-object v0
.end method

.method private OnExtractResSuc()V
    .locals 3

    .prologue
    .line 142
    new-instance v0, Lcom/eyugame/base/NetworkStatus;

    sget-object v1, Lcom/eyugame/game/ActivityMain;->sContext:Lcom/eyugame/game/ActivityMain;

    invoke-direct {v0, v1}, Lcom/eyugame/base/NetworkStatus;-><init>(Landroid/content/Context;)V

    .line 143
    .local v0, "networkStatus":Lcom/eyugame/base/NetworkStatus;
    invoke-virtual {v0}, Lcom/eyugame/base/NetworkStatus;->getNetworkStatus()Lcom/eyugame/base/NetworkStatus$EYNetType;

    move-result-object v1

    iput-object v1, p0, Lcom/eyugame/game/ActivityMain;->netType:Lcom/eyugame/base/NetworkStatus$EYNetType;

    .line 144
    sget-object v1, Lcom/eyugame/base/NetworkStatus$EYNetType;->EY_NONE:Lcom/eyugame/base/NetworkStatus$EYNetType;

    iget-object v2, p0, Lcom/eyugame/game/ActivityMain;->netType:Lcom/eyugame/base/NetworkStatus$EYNetType;

    if-ne v1, v2, :cond_0

    .line 145
    new-instance v1, Lcom/eyugame/game/ActivityMain$1;

    invoke-direct {v1, p0}, Lcom/eyugame/game/ActivityMain$1;-><init>(Lcom/eyugame/game/ActivityMain;)V

    invoke-virtual {p0, v1}, Lcom/eyugame/game/ActivityMain;->runOnUiThread(Ljava/lang/Runnable;)V

    .line 194
    :goto_0
    return-void

    .line 192
    :cond_0
    invoke-static {p0}, Lcom/eyugame/impt/RelayNative;->setActivityMain(Lcom/eyugame/game/ActivityMain;)V

    .line 193
    invoke-static {}, Lorg/cocos2dx/lib/Cocos2dxRenderer;->setCanInit()V

    goto :goto_0
.end method

.method public static SendConverion(Ljava/lang/String;)V
    .locals 0
    .param p0, "strType"    # Ljava/lang/String;

    return-void
.end method

.method static synthetic access$000()Lcom/eyugame/game/ActivityMain;
    .locals 1

    .prologue
    .line 78
    sget-object v0, Lcom/eyugame/game/ActivityMain;->sContext:Lcom/eyugame/game/ActivityMain;

    return-object v0
.end method

.method static synthetic access$102(Ljava/lang/String;)Ljava/lang/String;
    .locals 0
    .param p0, "x0"    # Ljava/lang/String;

    .prologue
    .line 78
    sput-object p0, Lcom/eyugame/game/ActivityMain;->ResCopyDir:Ljava/lang/String;

    return-object p0
.end method

.method static synthetic access$202(Ljava/lang/String;)Ljava/lang/String;
    .locals 0
    .param p0, "x0"    # Ljava/lang/String;

    .prologue
    .line 78
    sput-object p0, Lcom/eyugame/game/ActivityMain;->strSdkTypeName:Ljava/lang/String;

    return-object p0
.end method

.method static synthetic access$300(Lcom/eyugame/game/ActivityMain;)Ljava/lang/String;
    .locals 1
    .param p0, "x0"    # Lcom/eyugame/game/ActivityMain;

    .prologue
    .line 78
    iget-object v0, p0, Lcom/eyugame/game/ActivityMain;->strOperatorPath:Ljava/lang/String;

    return-object v0
.end method

.method static synthetic access$302(Lcom/eyugame/game/ActivityMain;Ljava/lang/String;)Ljava/lang/String;
    .locals 0
    .param p0, "x0"    # Lcom/eyugame/game/ActivityMain;
    .param p1, "x1"    # Ljava/lang/String;

    .prologue
    .line 78
    iput-object p1, p0, Lcom/eyugame/game/ActivityMain;->strOperatorPath:Ljava/lang/String;

    return-object p1
.end method

.method static synthetic access$500(Lcom/eyugame/game/ActivityMain;)Landroid/widget/TextView;
    .locals 1
    .param p0, "x0"    # Lcom/eyugame/game/ActivityMain;

    .prologue
    .line 78
    iget-object v0, p0, Lcom/eyugame/game/ActivityMain;->mTipText:Landroid/widget/TextView;

    return-object v0
.end method

.method static synthetic access$600()I
    .locals 1

    .prologue
    .line 78
    sget v0, Lcom/eyugame/game/ActivityMain;->needSize:I

    return v0
.end method

.method static synthetic access$700(Lcom/eyugame/game/ActivityMain;)Lorg/cocos2dx/lib/Cocos2dxEditText;
    .locals 1
    .param p0, "x0"    # Lcom/eyugame/game/ActivityMain;

    .prologue
    .line 78
    iget-object v0, p0, Lcom/eyugame/game/ActivityMain;->mEditText:Lorg/cocos2dx/lib/Cocos2dxEditText;

    return-object v0
.end method

.method static synthetic access$800()I
    .locals 1

    .prologue
    .line 78
    sget v0, Lcom/eyugame/game/ActivityMain;->mKeyboardHeight:I

    return v0
.end method

.method private getUserSerial()Ljava/lang/String;
    .locals 13

    .prologue
    const/4 v8, 0x0

    .line 660
    const-string v5, "user"

    invoke-virtual {p0, v5}, Lcom/eyugame/game/ActivityMain;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v4

    .line 661
    .local v4, "userManager":Ljava/lang/Object;
    if-nez v4, :cond_0

    .line 663
    const-string v5, "ActivityMain"

    const-string v9, "userManager not exsit !!!"

    invoke-static {v5, v9}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    move-object v5, v8

    .line 693
    :goto_0
    return-object v5

    .line 669
    :cond_0
    :try_start_0
    const-class v9, Landroid/os/Process;

    const-string v10, "myUserHandle"

    const/4 v5, 0x0

    check-cast v5, [Ljava/lang/Class;

    invoke-virtual {v9, v10, v5}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v3

    .line 670
    .local v3, "myUserHandleMethod":Ljava/lang/reflect/Method;
    const-class v9, Landroid/os/Process;

    const/4 v5, 0x0

    check-cast v5, [Ljava/lang/Object;

    invoke-virtual {v3, v9, v5}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    .line 672
    .local v2, "myUserHandle":Ljava/lang/Object;
    invoke-virtual {v4}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v5

    const-string v9, "getSerialNumberForUser"

    const/4 v10, 0x1

    new-array v10, v10, [Ljava/lang/Class;

    const/4 v11, 0x0

    invoke-virtual {v2}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v12

    aput-object v12, v10, v11

    invoke-virtual {v5, v9, v10}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    .line 673
    .local v1, "getSerialNumberForUser":Ljava/lang/reflect/Method;
    const/4 v5, 0x1

    new-array v5, v5, [Ljava/lang/Object;

    const/4 v9, 0x0

    aput-object v2, v5, v9

    invoke-virtual {v1, v4, v5}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Ljava/lang/Long;

    invoke-virtual {v5}, Ljava/lang/Long;->longValue()J

    move-result-wide v6

    .line 674
    .local v6, "userSerial":J
    invoke-static {v6, v7}, Ljava/lang/String;->valueOf(J)Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/NoSuchMethodException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/IllegalArgumentException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/IllegalAccessException; {:try_start_0 .. :try_end_0} :catch_2
    .catch Ljava/lang/reflect/InvocationTargetException; {:try_start_0 .. :try_end_0} :catch_3

    move-result-object v5

    goto :goto_0

    .line 676
    .end local v1    # "getSerialNumberForUser":Ljava/lang/reflect/Method;
    .end local v2    # "myUserHandle":Ljava/lang/Object;
    .end local v3    # "myUserHandleMethod":Ljava/lang/reflect/Method;
    .end local v6    # "userSerial":J
    :catch_0
    move-exception v0

    .line 678
    .local v0, "e":Ljava/lang/NoSuchMethodException;
    const-string v5, "ActivityMain"

    const-string v9, ""

    invoke-static {v5, v9, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .end local v0    # "e":Ljava/lang/NoSuchMethodException;
    :goto_1
    move-object v5, v8

    .line 693
    goto :goto_0

    .line 680
    :catch_1
    move-exception v0

    .line 682
    .local v0, "e":Ljava/lang/IllegalArgumentException;
    const-string v5, "ActivityMain"

    const-string v9, ""

    invoke-static {v5, v9, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_1

    .line 684
    .end local v0    # "e":Ljava/lang/IllegalArgumentException;
    :catch_2
    move-exception v0

    .line 686
    .local v0, "e":Ljava/lang/IllegalAccessException;
    const-string v5, "ActivityMain"

    const-string v9, ""

    invoke-static {v5, v9, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_1

    .line 688
    .end local v0    # "e":Ljava/lang/IllegalAccessException;
    :catch_3
    move-exception v0

    .line 690
    .local v0, "e":Ljava/lang/reflect/InvocationTargetException;
    const-string v5, "ActivityMain"

    const-string v9, ""

    invoke-static {v5, v9, v0}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    goto :goto_1
.end method


# virtual methods
.method public ClearBackground()V
    .locals 4

    .prologue
    .line 737
    const-string v1, "splashDelayTime"

    invoke-virtual {p0, v1}, Lcom/eyugame/game/ActivityMain;->GetItemFromSdkConfig(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 738
    .local v0, "strSplashDelayTime":Ljava/lang/String;
    const-string v1, ""

    invoke-virtual {v0, v1}, Ljava/lang/String;->compareToIgnoreCase(Ljava/lang/String;)I

    move-result v1

    if-nez v1, :cond_0

    iget-wide v2, p0, Lcom/eyugame/game/ActivityMain;->splashDelayTime:J

    :goto_0
    iput-wide v2, p0, Lcom/eyugame/game/ActivityMain;->splashDelayTime:J

    .line 740
    invoke-super {p0}, Lorg/cocos2dx/lib/Cocos2dxActivity;->ClearBackground()V

    .line 741
    return-void

    .line 738
    :cond_0
    invoke-static {v0}, Ljava/lang/Long;->valueOf(Ljava/lang/String;)Ljava/lang/Long;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Long;->longValue()J

    move-result-wide v2

    goto :goto_0
.end method

.method public GetItemFromMiscIniConfig(Ljava/lang/String;)Ljava/lang/String;
    .locals 4
    .param p1, "strKey"    # Ljava/lang/String;

    .prologue
    .line 725
    :try_start_0
    const-string v3, "ini/misc.ini"

    invoke-static {v3, p0}, Lcom/eyugame/base/LocationUtils;->getStringFromPack(Ljava/lang/String;Landroid/content/Context;)Ljava/lang/String;

    move-result-object v2

    .line 726
    .local v2, "strFileData":Ljava/lang/String;
    invoke-virtual {v2}, Ljava/lang/String;->getBytes()[B

    move-result-object v3

    invoke-static {v3}, Lcom/eyugame/impt/RelayNative;->DecryptData([B)Ljava/lang/String;

    move-result-object v2

    .line 727
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1, v2}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 728
    .local v1, "jsonObject":Lorg/json/JSONObject;
    invoke-virtual {v1, p1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_0

    invoke-virtual {v1, p1}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .line 731
    .end local v1    # "jsonObject":Lorg/json/JSONObject;
    .end local v2    # "strFileData":Ljava/lang/String;
    :goto_0
    return-object v3

    .line 728
    .restart local v1    # "jsonObject":Lorg/json/JSONObject;
    .restart local v2    # "strFileData":Ljava/lang/String;
    :cond_0
    const-string v3, ""
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 729
    .end local v1    # "jsonObject":Lorg/json/JSONObject;
    .end local v2    # "strFileData":Ljava/lang/String;
    :catch_0
    move-exception v0

    .line 730
    .local v0, "e":Lorg/json/JSONException;
    invoke-virtual {v0}, Lorg/json/JSONException;->printStackTrace()V

    .line 731
    const-string v3, ""

    goto :goto_0
.end method

.method public GetItemFromSdkConfig(Ljava/lang/String;)Ljava/lang/String;
    .locals 4
    .param p1, "strKey"    # Ljava/lang/String;

    .prologue
    .line 703
    invoke-static {}, Lorg/cocos2dx/lib/Cocos2dxRenderer;->isInit()Z

    move-result v2

    if-nez v2, :cond_0

    const-string v2, ""

    .line 719
    :goto_0
    return-object v2

    .line 705
    :cond_0
    iget-object v2, p0, Lcom/eyugame/game/ActivityMain;->jsonSdkConfig:Lorg/json/JSONObject;

    if-nez v2, :cond_1

    .line 707
    :try_start_0
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v3, p0, Lcom/eyugame/game/ActivityMain;->strOperatorPath:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "config.dat"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/eyugame/impt/RelayNative;->DecryptFile(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 708
    .local v1, "strFileData":Ljava/lang/String;
    new-instance v2, Lorg/json/JSONObject;

    invoke-direct {v2, v1}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    iput-object v2, p0, Lcom/eyugame/game/ActivityMain;->jsonSdkConfig:Lorg/json/JSONObject;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    .line 716
    .end local v1    # "strFileData":Ljava/lang/String;
    :cond_1
    :try_start_1
    iget-object v2, p0, Lcom/eyugame/game/ActivityMain;->jsonSdkConfig:Lorg/json/JSONObject;

    invoke-virtual {v2, p1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_2

    iget-object v2, p0, Lcom/eyugame/game/ActivityMain;->jsonSdkConfig:Lorg/json/JSONObject;

    invoke-virtual {v2, p1}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;
    :try_end_1
    .catch Lorg/json/JSONException; {:try_start_1 .. :try_end_1} :catch_1

    move-result-object v2

    goto :goto_0

    .line 709
    :catch_0
    move-exception v0

    .line 710
    .local v0, "e":Lorg/json/JSONException;
    invoke-virtual {v0}, Lorg/json/JSONException;->printStackTrace()V

    .line 711
    const-string v2, ""

    goto :goto_0

    .line 716
    .end local v0    # "e":Lorg/json/JSONException;
    :cond_2
    :try_start_2
    const-string v2, ""
    :try_end_2
    .catch Lorg/json/JSONException; {:try_start_2 .. :try_end_2} :catch_1

    goto :goto_0

    .line 717
    :catch_1
    move-exception v0

    .line 718
    .restart local v0    # "e":Lorg/json/JSONException;
    invoke-virtual {v0}, Lorg/json/JSONException;->printStackTrace()V

    .line 719
    const-string v2, ""

    goto :goto_0
.end method

.method public GetPackageUpdate()Lcom/eyugame/base/IPackageUpdate;
    .locals 1

    .prologue
    .line 130
    sget-object v0, Lcom/eyugame/game/ActivityMain;->packageUpdate:Lcom/eyugame/base/IPackageUpdate;

    if-nez v0, :cond_0

    .line 131
    new-instance v0, Lcom/eyugame/game/UpdateManager;

    invoke-direct {v0, p0}, Lcom/eyugame/game/UpdateManager;-><init>(Landroid/content/Context;)V

    sput-object v0, Lcom/eyugame/game/ActivityMain;->packageUpdate:Lcom/eyugame/base/IPackageUpdate;

    .line 134
    :cond_0
    sget-object v0, Lcom/eyugame/game/ActivityMain;->packageUpdate:Lcom/eyugame/base/IPackageUpdate;

    return-object v0
.end method

.method public GetSdkPlatform()Lcom/eyugame/base/ISdkPlatform;
    .locals 4

    .prologue
    .line 109
    sget-object v1, Lcom/eyugame/game/ActivityMain;->strSdkTypeName:Ljava/lang/String;

    if-eqz v1, :cond_0

    sget-object v1, Lcom/eyugame/game/ActivityMain;->strSdkTypeName:Ljava/lang/String;

    const-string v2, ""

    invoke-virtual {v1, v2}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 111
    :cond_0
    :try_start_0
    invoke-virtual {p0}, Lcom/eyugame/game/ActivityMain;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v1

    invoke-virtual {p0}, Lcom/eyugame/game/ActivityMain;->getPackageName()Ljava/lang/String;

    move-result-object v2

    const/16 v3, 0x80

    invoke-virtual {v1, v2, v3}, Landroid/content/pm/PackageManager;->getApplicationInfo(Ljava/lang/String;I)Landroid/content/pm/ApplicationInfo;

    move-result-object v0

    .line 112
    .local v0, "appInfo":Landroid/content/pm/ApplicationInfo;
    iget-object v1, v0, Landroid/content/pm/ApplicationInfo;->metaData:Landroid/os/Bundle;

    const-string v2, "EY_OPERATOR_TYPE"

    invoke-virtual {v1, v2}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    sput-object v1, Lcom/eyugame/game/ActivityMain;->strSdkTypeName:Ljava/lang/String;
    :try_end_0
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    .line 118
    .end local v0    # "appInfo":Landroid/content/pm/ApplicationInfo;
    :cond_1
    :goto_0
    sget-object v1, Lcom/eyugame/game/ActivityMain;->sdkPlatform:Lcom/eyugame/base/ISdkPlatform;

    if-nez v1, :cond_2

    .line 119
    invoke-static {}, Lcom/eyugame/base/SdkPlatformFactory;->getSingleton()Lcom/eyugame/base/SdkPlatformFactory;

    move-result-object v1

    sget-object v2, Lcom/eyugame/game/ActivityMain;->strSdkTypeName:Ljava/lang/String;

    invoke-virtual {v1, v2}, Lcom/eyugame/base/SdkPlatformFactory;->createSdkPlatform(Ljava/lang/String;)Lcom/eyugame/base/ISdkPlatform;

    move-result-object v1

    sput-object v1, Lcom/eyugame/game/ActivityMain;->sdkPlatform:Lcom/eyugame/base/ISdkPlatform;

    .line 122
    :cond_2
    sget-object v1, Lcom/eyugame/game/ActivityMain;->sdkPlatform:Lcom/eyugame/base/ISdkPlatform;

    return-object v1

    .line 113
    :catch_0
    move-exception v1

    goto :goto_0
.end method

.method public InitCrashReport()V
    .locals 7

    .prologue
    const/4 v5, 0x0

    .line 303
    invoke-static {}, Lcom/eyugame/game/ActivityMain;->GetInstance()Lcom/eyugame/game/ActivityMain;

    move-result-object v3

    const-string v4, "openCrashReport"

    invoke-virtual {v3, v4}, Lcom/eyugame/game/ActivityMain;->GetItemFromMiscIniConfig(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 304
    .local v2, "strOpenCrashReport":Ljava/lang/String;
    const-string v3, ""

    if-eq v3, v2, :cond_0

    sget-object v3, Ljava/lang/Boolean;->FALSE:Ljava/lang/Boolean;

    invoke-static {v2}, Ljava/lang/Boolean;->valueOf(Ljava/lang/String;)Ljava/lang/Boolean;

    move-result-object v4

    if-ne v3, v4, :cond_1

    .line 313
    :cond_0
    :goto_0
    return-void

    .line 306
    :cond_1
    new-instance v1, Ljava/lang/Integer;

    invoke-direct {v1, v5}, Ljava/lang/Integer;-><init>(I)V

    .line 307
    .local v1, "nServerFd":Ljava/lang/Integer;
    new-instance v0, Ljava/lang/Integer;

    invoke-direct {v0, v5}, Ljava/lang/Integer;-><init>(I)V

    .line 308
    .local v0, "nClientFd":Ljava/lang/Integer;
    invoke-static {v1, v0}, Lcom/eyugame/impt/RelayNative;->GetCrashReportFd(Ljava/lang/Integer;Ljava/lang/Integer;)I

    .line 309
    const-string v3, "files"

    invoke-virtual {p0, v3, v5}, Lcom/eyugame/game/ActivityMain;->getDir(Ljava/lang/String;I)Ljava/io/File;

    move-result-object v3

    invoke-virtual {v3}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v3

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    .line 310
    invoke-static {}, Lorg/cocos2dx/lib/Cocos2dxHelper;->getExternalDocPath()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "/"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    .line 311
    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I

    move-result v5

    .line 312
    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v6

    .line 309
    invoke-static {v3, v4, v5, v6}, Lcom/eyugame/impt/RelayNative;->InitCrashReport(Ljava/lang/String;Ljava/lang/String;II)I

    goto :goto_0
.end method

.method public OnCopyProgressChanged(I)V
    .locals 1
    .param p1, "nProgress"    # I

    .prologue
    .line 316
    new-instance v0, Lcom/eyugame/game/ActivityMain$2;

    invoke-direct {v0, p0, p1}, Lcom/eyugame/game/ActivityMain$2;-><init>(Lcom/eyugame/game/ActivityMain;I)V

    invoke-virtual {p0, v0}, Lcom/eyugame/game/ActivityMain;->runOnUiThread(Ljava/lang/Runnable;)V

    .line 323
    return-void
.end method

.method protected TryCopyAssets()V
    .locals 7

    .prologue
    .line 327
    :try_start_0
    sget-object v4, Lcom/eyugame/game/ActivityMain;->ResCopyDir:Ljava/lang/String;

    const-string v5, ","

    invoke-virtual {v4, v5}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v2

    .line 328
    .local v2, "strFlags":[Ljava/lang/String;
    invoke-virtual {p0}, Lcom/eyugame/game/ActivityMain;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v4

    invoke-virtual {p0}, Lcom/eyugame/game/ActivityMain;->getPackageName()Ljava/lang/String;

    move-result-object v5

    const/16 v6, 0x80

    invoke-virtual {v4, v5, v6}, Landroid/content/pm/PackageManager;->getPackageInfo(Ljava/lang/String;I)Landroid/content/pm/PackageInfo;

    move-result-object v4

    iget v3, v4, Landroid/content/pm/PackageInfo;->versionCode:I

    .line 329
    .local v3, "versionCode":I
    invoke-virtual {p0}, Lcom/eyugame/game/ActivityMain;->getPackageResourcePath()Ljava/lang/String;

    move-result-object v4

    invoke-static {}, Lorg/cocos2dx/lib/Cocos2dxHelper;->getExternalAssetPath()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5, v2, v3, p0}, Lcom/eyugame/base/LocationUtils;->CopyAssets(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;ILcom/eyugame/base/LocationUtils$CopyStatus;)Z

    move-result v1

    .line 330
    .local v1, "isSucCopy":Z
    if-nez v1, :cond_0

    .line 331
    const-string v4, "ConversionUnpackFail"

    invoke-static {v4}, Lcom/eyugame/game/ActivityMain;->SendConverion(Ljava/lang/String;)V

    .line 332
    new-instance v4, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v5

    invoke-direct {v4, v5}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    new-instance v5, Lcom/eyugame/game/ActivityMain$3;

    invoke-direct {v5, p0}, Lcom/eyugame/game/ActivityMain$3;-><init>(Lcom/eyugame/game/ActivityMain;)V

    invoke-virtual {v4, v5}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 372
    .end local v1    # "isSucCopy":Z
    .end local v2    # "strFlags":[Ljava/lang/String;
    .end local v3    # "versionCode":I
    :goto_0
    return-void

    .line 368
    .restart local v1    # "isSucCopy":Z
    .restart local v2    # "strFlags":[Ljava/lang/String;
    .restart local v3    # "versionCode":I
    :cond_0
    invoke-direct {p0}, Lcom/eyugame/game/ActivityMain;->OnExtractResSuc()V
    :try_end_0
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 369
    .end local v1    # "isSucCopy":Z
    .end local v2    # "strFlags":[Ljava/lang/String;
    .end local v3    # "versionCode":I
    :catch_0
    move-exception v0

    .line 370
    .local v0, "e":Landroid/content/pm/PackageManager$NameNotFoundException;
    invoke-virtual {v0}, Landroid/content/pm/PackageManager$NameNotFoundException;->printStackTrace()V

    goto :goto_0
.end method

.method protected checkExternalStorageState()Z
    .locals 7

    .prologue
    const/4 v3, 0x1

    const/4 v4, 0x0

    .line 376
    invoke-static {}, Lorg/cocos2dx/lib/Cocos2dxHelper;->isUseExternalStorage()Z

    move-result v5

    if-nez v5, :cond_1

    .line 404
    :cond_0
    :goto_0
    return v3

    .line 378
    :cond_1
    invoke-static {}, Landroid/os/Environment;->getExternalStorageState()Ljava/lang/String;

    move-result-object v2

    .line 379
    .local v2, "strExternalStorageState":Ljava/lang/String;
    const-string v5, "mounted"

    invoke-virtual {v2, v5}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-nez v5, :cond_0

    .line 380
    new-instance v0, Landroid/app/AlertDialog$Builder;

    invoke-direct {v0, p0}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    .line 381
    .local v0, "builder":Landroid/app/AlertDialog$Builder;
    invoke-virtual {p0}, Lcom/eyugame/game/ActivityMain;->getApplicationContext()Landroid/content/Context;

    move-result-object v3

    const-string v5, "string"

    const-string v6, "tip"

    invoke-static {v3, v5, v6}, Lcom/eyugame/game/MResource;->getIdByName(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v3

    invoke-virtual {v0, v3}, Landroid/app/AlertDialog$Builder;->setTitle(I)Landroid/app/AlertDialog$Builder;

    .line 382
    invoke-virtual {p0}, Lcom/eyugame/game/ActivityMain;->getApplicationContext()Landroid/content/Context;

    move-result-object v5

    const-string v6, "string"

    const-string v3, "shared"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_2

    const-string v3, "sdcard_shared"

    :goto_1
    invoke-static {v5, v6, v3}, Lcom/eyugame/game/MResource;->getIdByName(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v3

    invoke-virtual {v0, v3}, Landroid/app/AlertDialog$Builder;->setMessage(I)Landroid/app/AlertDialog$Builder;

    .line 383
    invoke-virtual {p0}, Lcom/eyugame/game/ActivityMain;->getApplicationContext()Landroid/content/Context;

    move-result-object v3

    const-string v5, "string"

    const-string v6, "confirm"

    invoke-static {v3, v5, v6}, Lcom/eyugame/game/MResource;->getIdByName(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v3

    new-instance v5, Lcom/eyugame/game/ActivityMain$4;

    invoke-direct {v5, p0}, Lcom/eyugame/game/ActivityMain$4;-><init>(Lcom/eyugame/game/ActivityMain;)V

    invoke-virtual {v0, v3, v5}, Landroid/app/AlertDialog$Builder;->setPositiveButton(ILandroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    .line 390
    invoke-virtual {p0}, Lcom/eyugame/game/ActivityMain;->getApplicationContext()Landroid/content/Context;

    move-result-object v3

    const-string v5, "string"

    const-string v6, "cancel"

    invoke-static {v3, v5, v6}, Lcom/eyugame/game/MResource;->getIdByName(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v3

    new-instance v5, Lcom/eyugame/game/ActivityMain$5;

    invoke-direct {v5, p0}, Lcom/eyugame/game/ActivityMain$5;-><init>(Lcom/eyugame/game/ActivityMain;)V

    invoke-virtual {v0, v3, v5}, Landroid/app/AlertDialog$Builder;->setNegativeButton(ILandroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    .line 396
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->create()Landroid/app/AlertDialog;

    move-result-object v1

    .line 398
    .local v1, "noticeDialog":Landroid/app/AlertDialog;
    invoke-virtual {v1}, Landroid/app/AlertDialog;->show()V

    .line 399
    invoke-virtual {v1, v4}, Landroid/app/AlertDialog;->setCancelable(Z)V

    move v3, v4

    .line 401
    goto :goto_0

    .line 382
    .end local v1    # "noticeDialog":Landroid/app/AlertDialog;
    :cond_2
    const-string v3, "no_sdcard"

    goto :goto_1
.end method

.method public doCheckAvaliableStorageSize()V
    .locals 6

    .prologue
    .line 697
    invoke-static {}, Lorg/cocos2dx/lib/Cocos2dxHelper;->isUseExternalStorage()Z

    move-result v0

    .line 698
    .local v0, "bUseExternalStorage":Z
    if-eqz v0, :cond_0

    invoke-static {}, Lcom/eyugame/base/LocationUtils;->getAvailableExternalMemorySize()J

    move-result-wide v2

    :goto_0
    const-wide/32 v4, 0x100000

    div-long/2addr v2, v4

    long-to-int v1, v2

    .line 699
    .local v1, "nAvaliableSize":I
    invoke-static {v1}, Lcom/eyugame/impt/RelayNative;->OnAvaliableStorageSize(I)V

    .line 700
    return-void

    .line 698
    .end local v1    # "nAvaliableSize":I
    :cond_0
    invoke-static {}, Lcom/eyugame/base/LocationUtils;->getAvailableInternalMemorySize()J

    move-result-wide v2

    goto :goto_0
.end method

.method public doEditChgPos(IIII)V
    .locals 7
    .param p1, "nL"    # I
    .param p2, "nT"    # I
    .param p3, "nWidth"    # I
    .param p4, "nHeight"    # I

    .prologue
    .line 564
    new-instance v6, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v0

    invoke-direct {v6, v0}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    new-instance v0, Lcom/eyugame/game/ActivityMain$8;

    move-object v1, p0

    move v2, p1

    move v3, p2

    move v4, p3

    move v5, p4

    invoke-direct/range {v0 .. v5}, Lcom/eyugame/game/ActivityMain$8;-><init>(Lcom/eyugame/game/ActivityMain;IIII)V

    invoke-virtual {v6, v0}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 572
    return-void
.end method

.method public doProcKeepScreenOn(Z)V
    .locals 2
    .param p1, "bState"    # Z

    .prologue
    .line 496
    sget-object v0, Lcom/eyugame/game/ActivityMain;->sContext:Lcom/eyugame/game/ActivityMain;

    new-instance v1, Lcom/eyugame/game/ActivityMain$6;

    invoke-direct {v1, p0, p1}, Lcom/eyugame/game/ActivityMain$6;-><init>(Lcom/eyugame/game/ActivityMain;Z)V

    invoke-virtual {v0, v1}, Lcom/eyugame/game/ActivityMain;->runOnUiThread(Ljava/lang/Runnable;)V

    .line 513
    return-void
.end method

.method public doReleaseFocus()V
    .locals 2

    .prologue
    .line 576
    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    new-instance v1, Lcom/eyugame/game/ActivityMain$9;

    invoke-direct {v1, p0}, Lcom/eyugame/game/ActivityMain$9;-><init>(Lcom/eyugame/game/ActivityMain;)V

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 592
    return-void
.end method

.method public doSetFocus(Ljava/lang/String;II)V
    .locals 2
    .param p1, "strText"    # Ljava/lang/String;
    .param p2, "nLenLimit"    # I
    .param p3, "nKeyboardType"    # I

    .prologue
    .line 517
    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    new-instance v1, Lcom/eyugame/game/ActivityMain$7;

    invoke-direct {v1, p0, p3, p1}, Lcom/eyugame/game/ActivityMain$7;-><init>(Lcom/eyugame/game/ActivityMain;ILjava/lang/String;)V

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 560
    return-void
.end method

.method protected onActivityResult(IILandroid/content/Intent;)V
    .locals 1
    .param p1, "requestCode"    # I
    .param p2, "resultCode"    # I
    .param p3, "data"    # Landroid/content/Intent;

    .prologue
    .line 647
    invoke-virtual {p0}, Lcom/eyugame/game/ActivityMain;->GetSdkPlatform()Lcom/eyugame/base/ISdkPlatform;

    move-result-object v0

    invoke-virtual {v0, p1, p2, p3}, Lcom/eyugame/base/ISdkPlatform;->onActivityResult(IILandroid/content/Intent;)V

    .line 648
    .line 649
    invoke-super {p0, p1, p2, p3}, Lorg/cocos2dx/lib/Cocos2dxActivity;->onActivityResult(IILandroid/content/Intent;)V

    .line 650
    return-void
.end method

.method public onBackPressed()V
    .locals 1

    .prologue
    .line 463
    invoke-virtual {p0}, Lcom/eyugame/game/ActivityMain;->GetSdkPlatform()Lcom/eyugame/base/ISdkPlatform;

    move-result-object v0

    invoke-virtual {v0}, Lcom/eyugame/base/ISdkPlatform;->onBackPressed()Z

    move-result v0

    if-eqz v0, :cond_1

    .line 476
    :cond_0
    :goto_0
    return-void

    .line 467
    .line 471
    :cond_1
    invoke-static {}, Lcom/eyugame/game/WebviewMgr;->GetSingleton()Lcom/eyugame/game/WebviewMgr;

    move-result-object v0

    invoke-virtual {v0}, Lcom/eyugame/game/WebviewMgr;->onBackPressed()Z

    move-result v0

    if-nez v0, :cond_0

    .line 475
    invoke-virtual {p0}, Lcom/eyugame/game/ActivityMain;->showExitDialg()V

    goto :goto_0
.end method

.method public onConfigurationChanged(Landroid/content/res/Configuration;)V
    .locals 0
    .param p1, "newConfig"    # Landroid/content/res/Configuration;

    .prologue
    .line 491
    invoke-super {p0, p1}, Lorg/cocos2dx/lib/Cocos2dxActivity;->onConfigurationChanged(Landroid/content/res/Configuration;)V

    .line 492
    return-void
.end method

.method public onCreatShortCut()V
    .locals 0

    return-void
.end method

.method public onCreate(Landroid/os/Bundle;)V
    .locals 14
    .param p1, "savedInstanceState"    # Landroid/os/Bundle;

    .prologue
    const/4 v13, 0x0

    const/4 v12, 0x0

    .line 241
    iput-object p1, p0, Lcom/eyugame/game/ActivityMain;->mSavedInstanceState:Landroid/os/Bundle;

    .line 242
    sput-object p0, Lcom/eyugame/game/ActivityMain;->sContext:Lcom/eyugame/game/ActivityMain;

    .line 243
    .line 247
    const-string v10, "SP"

    invoke-virtual {p0, v10, v12}, Lcom/eyugame/game/ActivityMain;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v7

    .line 248
    .local v7, "sp":Landroid/content/SharedPreferences;
    const-string v10, "NewUser"

    const/4 v11, 0x1

    invoke-interface {v7, v10, v11}, Landroid/content/SharedPreferences;->getBoolean(Ljava/lang/String;Z)Z

    move-result v10

    sput-boolean v10, Lcom/eyugame/game/ActivityMain;->IsNewUser:Z

    .line 249
    invoke-interface {v7}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v3

    .line 250
    .local v3, "editor":Landroid/content/SharedPreferences$Editor;
    const-string v10, "NewUser"

    invoke-interface {v3, v10, v12}, Landroid/content/SharedPreferences$Editor;->putBoolean(Ljava/lang/String;Z)Landroid/content/SharedPreferences$Editor;

    .line 251
    invoke-interface {v3}, Landroid/content/SharedPreferences$Editor;->commit()Z

    .line 253
    invoke-virtual {p0}, Lcom/eyugame/game/ActivityMain;->onCreatShortCut()V

    .line 255
    .line 257
    invoke-static {p0}, Lorg/cocos2dx/lib/Cocos2dxHelper;->initResPath(Landroid/content/Context;)V

    .line 259
    invoke-super {p0, p1}, Lorg/cocos2dx/lib/Cocos2dxActivity;->onCreate(Landroid/os/Bundle;)V

    .line 261
    invoke-virtual {p0}, Lcom/eyugame/game/ActivityMain;->GetSdkPlatform()Lcom/eyugame/base/ISdkPlatform;

    move-result-object v10

    invoke-virtual {v10, p0, p1}, Lcom/eyugame/base/ISdkPlatform;->onActivityCreate(Landroid/app/Activity;Landroid/os/Bundle;)Z

    move-result v10

    if-nez v10, :cond_0

    .line 299
    :goto_0
    return-void

    .line 265
    :cond_0
    const-string v10, "useLowFormat"

    invoke-virtual {p0, v10}, Lcom/eyugame/game/ActivityMain;->GetItemFromMiscIniConfig(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    .line 267
    .local v8, "strJson":Ljava/lang/String;
    :try_start_0
    new-instance v4, Lorg/json/JSONObject;

    invoke-direct {v4, v8}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 268
    .local v4, "jsonObject":Lorg/json/JSONObject;
    const-string v10, "totalMem"

    invoke-virtual {v4, v10}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v6

    .line 269
    .local v6, "nTotalMem":I
    const-string v10, "availMem"

    invoke-virtual {v4, v10}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v5

    .line 270
    .local v5, "nAvailMem":I
    invoke-static {v6, v5}, Lcom/eyugame/impt/RelayNative;->SetDefaultAlphaPixelFormat(II)V
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    .line 277
    .end local v4    # "jsonObject":Lorg/json/JSONObject;
    .end local v5    # "nAvailMem":I
    .end local v6    # "nTotalMem":I
    :goto_1
    :try_start_1
    const-string v10, "uninstallUrl"

    invoke-virtual {p0, v10}, Lcom/eyugame/game/ActivityMain;->GetItemFromMiscIniConfig(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v9

    .line 278
    .local v9, "strUninstallUrl":Ljava/lang/String;
    invoke-virtual {p0}, Lcom/eyugame/game/ActivityMain;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v10

    invoke-virtual {p0}, Lcom/eyugame/game/ActivityMain;->getPackageName()Ljava/lang/String;

    move-result-object v11

    const/16 v12, 0x80

    invoke-virtual {v10, v11, v12}, Landroid/content/pm/PackageManager;->getApplicationInfo(Ljava/lang/String;I)Landroid/content/pm/ApplicationInfo;

    move-result-object v0

    .line 279
    .local v0, "appInfo":Landroid/content/pm/ApplicationInfo;
    iget-object v10, v0, Landroid/content/pm/ApplicationInfo;->metaData:Landroid/os/Bundle;

    const-string v11, "CHECK_UNINSTALL"

    invoke-virtual {v10, v11}, Landroid/os/Bundle;->getBoolean(Ljava/lang/String;)Z

    move-result v1

    .line 280
    .local v1, "bCheckUninstall":Z
    if-eqz v1, :cond_1

    if-eqz v9, :cond_1

    const-string v10, ""

    if-eq v10, v9, :cond_1

    .line 282
    sget v10, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v11, 0x11

    if-ge v10, v11, :cond_2

    .line 284
    invoke-static {}, Lorg/cocos2dx/lib/Cocos2dxHelper;->getCocos2dxPackageName()Ljava/lang/String;

    move-result-object v10

    const/4 v11, 0x0

    invoke-static {v10, v9, v11}, Lcom/eyugame/impt/RelayNative;->InitUninstallMonitor(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I
    :try_end_1
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_1 .. :try_end_1} :catch_1

    .line 296
    .end local v0    # "appInfo":Landroid/content/pm/ApplicationInfo;
    .end local v1    # "bCheckUninstall":Z
    .end local v9    # "strUninstallUrl":Ljava/lang/String;
    :cond_1
    :goto_2
    invoke-virtual {p0}, Lcom/eyugame/game/ActivityMain;->InitCrashReport()V

    .line 298
    new-instance v10, Lcom/eyugame/game/ActivityMain$InitThread;

    invoke-direct {v10, p0, v13}, Lcom/eyugame/game/ActivityMain$InitThread;-><init>(Lcom/eyugame/game/ActivityMain;Lcom/eyugame/game/ActivityMain$1;)V

    invoke-virtual {v10}, Lcom/eyugame/game/ActivityMain$InitThread;->start()V

    goto :goto_0

    .line 271
    :catch_0
    move-exception v2

    .line 272
    .local v2, "e":Lorg/json/JSONException;
    invoke-virtual {v2}, Lorg/json/JSONException;->printStackTrace()V

    goto :goto_1

    .line 289
    .end local v2    # "e":Lorg/json/JSONException;
    .restart local v0    # "appInfo":Landroid/content/pm/ApplicationInfo;
    .restart local v1    # "bCheckUninstall":Z
    .restart local v9    # "strUninstallUrl":Ljava/lang/String;
    :cond_2
    :try_start_2
    invoke-static {}, Lorg/cocos2dx/lib/Cocos2dxHelper;->getCocos2dxPackageName()Ljava/lang/String;

    move-result-object v10

    invoke-direct {p0}, Lcom/eyugame/game/ActivityMain;->getUserSerial()Ljava/lang/String;

    move-result-object v11

    invoke-static {v10, v9, v11}, Lcom/eyugame/impt/RelayNative;->InitUninstallMonitor(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I
    :try_end_2
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_2 .. :try_end_2} :catch_1

    goto :goto_2

    .line 292
    .end local v0    # "appInfo":Landroid/content/pm/ApplicationInfo;
    .end local v1    # "bCheckUninstall":Z
    .end local v9    # "strUninstallUrl":Ljava/lang/String;
    :catch_1
    move-exception v2

    .line 293
    .local v2, "e":Landroid/content/pm/PackageManager$NameNotFoundException;
    invoke-virtual {v2}, Landroid/content/pm/PackageManager$NameNotFoundException;->printStackTrace()V

    goto :goto_2
.end method

.method protected onDestroy()V
    .locals 1

    .prologue
    .line 454
    invoke-super {p0}, Lorg/cocos2dx/lib/Cocos2dxActivity;->onDestroy()V

    .line 456
    .line 457
    invoke-virtual {p0}, Lcom/eyugame/game/ActivityMain;->GetSdkPlatform()Lcom/eyugame/base/ISdkPlatform;

    move-result-object v0

    invoke-virtual {v0}, Lcom/eyugame/base/ISdkPlatform;->onDestroy()V

    .line 458
    .line 459
    const/4 v0, 0x0

    invoke-static {v0}, Ljava/lang/System;->exit(I)V

    .line 460
    return-void
.end method

.method protected onPause()V
    .locals 1

    .prologue
    .line 419
    invoke-super {p0}, Lorg/cocos2dx/lib/Cocos2dxActivity;->onPause()V

    .line 420
    .line 422
    invoke-virtual {p0}, Lcom/eyugame/game/ActivityMain;->GetSdkPlatform()Lcom/eyugame/base/ISdkPlatform;

    move-result-object v0

    invoke-virtual {v0}, Lcom/eyugame/base/ISdkPlatform;->onPause()V

    .line 423
    .line 424
    return-void
.end method

.method protected onRestart()V
    .locals 2

    .prologue
    .line 427
    invoke-super {p0}, Lorg/cocos2dx/lib/Cocos2dxActivity;->onRestart()V

    .line 429
    :try_start_0
    invoke-virtual {p0}, Lcom/eyugame/game/ActivityMain;->GetSdkPlatform()Lcom/eyugame/base/ISdkPlatform;

    move-result-object v1

    invoke-virtual {v1}, Lcom/eyugame/base/ISdkPlatform;->onRestart()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 433
    :goto_0
    return-void

    .line 430
    :catch_0
    move-exception v0

    .line 431
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    goto :goto_0
.end method

.method public onRestoreInstanceState(Landroid/os/Bundle;)V
    .locals 0
    .param p1, "savedInstanceState"    # Landroid/os/Bundle;

    .prologue
    .line 479
    invoke-super {p0, p1}, Lorg/cocos2dx/lib/Cocos2dxActivity;->onRestoreInstanceState(Landroid/os/Bundle;)V

    .line 480
    return-void
.end method

.method protected onResume()V
    .locals 1

    .prologue
    .line 410
    invoke-super {p0}, Lorg/cocos2dx/lib/Cocos2dxActivity;->onResume()V

    .line 411
    .line 413
    invoke-virtual {p0}, Lcom/eyugame/game/ActivityMain;->GetSdkPlatform()Lcom/eyugame/base/ISdkPlatform;

    move-result-object v0

    invoke-virtual {v0}, Lcom/eyugame/base/ISdkPlatform;->onResume()V

    .line 414
    .line 415
    return-void
.end method

.method public onSaveInstanceState(Landroid/os/Bundle;)V
    .locals 1
    .param p1, "outState"    # Landroid/os/Bundle;

    .prologue
    .line 484
    iput-object p1, p0, Lcom/eyugame/game/ActivityMain;->mSavedInstanceState:Landroid/os/Bundle;

    .line 485
    invoke-super {p0, p1}, Lorg/cocos2dx/lib/Cocos2dxActivity;->onSaveInstanceState(Landroid/os/Bundle;)V

    .line 486
    invoke-virtual {p0}, Lcom/eyugame/game/ActivityMain;->GetSdkPlatform()Lcom/eyugame/base/ISdkPlatform;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/eyugame/base/ISdkPlatform;->onSaveInstanceState(Landroid/os/Bundle;)V

    .line 487
    .line 488
    return-void
.end method

.method protected onStart()V
    .locals 2

    .prologue
    .line 436
    invoke-super {p0}, Lorg/cocos2dx/lib/Cocos2dxActivity;->onStart()V

    .line 439
    :try_start_0
    invoke-virtual {p0}, Lcom/eyugame/game/ActivityMain;->GetSdkPlatform()Lcom/eyugame/base/ISdkPlatform;

    move-result-object v1

    invoke-virtual {v1}, Lcom/eyugame/base/ISdkPlatform;->onStart()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 443
    :goto_0
    return-void

    .line 440
    :catch_0
    move-exception v0

    .line 441
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    goto :goto_0
.end method

.method protected onStop()V
    .locals 1

    .prologue
    .line 447
    invoke-super {p0}, Lorg/cocos2dx/lib/Cocos2dxActivity;->onStop()V

    .line 449
    invoke-virtual {p0}, Lcom/eyugame/game/ActivityMain;->GetSdkPlatform()Lcom/eyugame/base/ISdkPlatform;

    move-result-object v0

    invoke-virtual {v0}, Lcom/eyugame/base/ISdkPlatform;->onStop()V

    .line 450
    return-void
.end method

.method public procUpdateMemoryInfo(FII)V
    .locals 4
    .param p1, "fCpuUsage"    # F
    .param p2, "nUsedMemroy"    # I
    .param p3, "nAvailMemory"    # I

    .prologue
    .line 628
    const-string v2, "activity"

    invoke-virtual {p0, v2}, Lcom/eyugame/game/ActivityMain;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/ActivityManager;

    .line 629
    .local v0, "activityManager":Landroid/app/ActivityManager;
    new-instance v1, Landroid/app/ActivityManager$MemoryInfo;

    invoke-direct {v1}, Landroid/app/ActivityManager$MemoryInfo;-><init>()V

    .line 630
    .local v1, "outInfo":Landroid/app/ActivityManager$MemoryInfo;
    invoke-virtual {v0, v1}, Landroid/app/ActivityManager;->getMemoryInfo(Landroid/app/ActivityManager$MemoryInfo;)V

    .line 631
    iget-boolean v2, v1, Landroid/app/ActivityManager$MemoryInfo;->lowMemory:Z

    if-eqz v2, :cond_0

    .line 632
    invoke-static {}, Lcom/eyugame/impt/RelayNative;->OnMemoryLow()V

    .line 635
    :cond_0
    mul-int/lit16 v2, p3, 0x400

    mul-int/lit16 v3, p2, 0x400

    invoke-static {v2, v3, p1}, Lcom/eyugame/impt/RelayNative;->OnProcUpdateMemroyInfo(IIF)V

    .line 636
    return-void
.end method

.method public procUpdateNetworkStatus()V
    .locals 4

    .prologue
    .line 639
    new-instance v1, Lcom/eyugame/base/NetworkStatus;

    sget-object v2, Lcom/eyugame/game/ActivityMain;->sContext:Lcom/eyugame/game/ActivityMain;

    invoke-direct {v1, v2}, Lcom/eyugame/base/NetworkStatus;-><init>(Landroid/content/Context;)V

    .line 640
    .local v1, "networkStatus":Lcom/eyugame/base/NetworkStatus;
    invoke-virtual {v1}, Lcom/eyugame/base/NetworkStatus;->getNetworkStatus()Lcom/eyugame/base/NetworkStatus$EYNetType;

    move-result-object v0

    .line 642
    .local v0, "curType":Lcom/eyugame/base/NetworkStatus$EYNetType;
    invoke-virtual {v0}, Lcom/eyugame/base/NetworkStatus$EYNetType;->value()I

    move-result v2

    iget-object v3, p0, Lcom/eyugame/game/ActivityMain;->netType:Lcom/eyugame/base/NetworkStatus$EYNetType;

    invoke-virtual {v3}, Lcom/eyugame/base/NetworkStatus$EYNetType;->value()I

    move-result v3

    invoke-static {v2, v3}, Lcom/eyugame/impt/RelayNative;->OnNetworkStatusChanged(II)V

    .line 643
    iput-object v0, p0, Lcom/eyugame/game/ActivityMain;->netType:Lcom/eyugame/base/NetworkStatus$EYNetType;

    .line 644
    return-void
.end method

.method public setPackageUpdate(Lcom/eyugame/base/IPackageUpdate;)V
    .locals 0
    .param p1, "param"    # Lcom/eyugame/base/IPackageUpdate;

    .prologue
    .line 126
    sput-object p1, Lcom/eyugame/game/ActivityMain;->packageUpdate:Lcom/eyugame/base/IPackageUpdate;

    .line 127
    return-void
.end method

.method public showExitDialg()V
    .locals 2

    .prologue
    .line 595
    invoke-virtual {p0}, Lcom/eyugame/game/ActivityMain;->GetSdkPlatform()Lcom/eyugame/base/ISdkPlatform;

    move-result-object v0

    invoke-virtual {v0}, Lcom/eyugame/base/ISdkPlatform;->doExit()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 625
    :goto_0
    return-void

    .line 599
    :cond_0
    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    new-instance v1, Lcom/eyugame/game/ActivityMain$10;

    invoke-direct {v1, p0}, Lcom/eyugame/game/ActivityMain$10;-><init>(Lcom/eyugame/game/ActivityMain;)V

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    goto :goto_0
.end method
