.class public Lcom/eyugame/game/ConfigSingle;
.super Ljava/lang/Object;
.source "ConfigSingle.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/eyugame/game/ConfigSingle$ConfigSingleHolder;
    }
.end annotation


# static fields
.field public static IsCheckConversion:Z

.field public static IsNewUser:Z

.field public static ResCopyDir:Ljava/lang/String;

.field public static mKeyboardHeight:I

.field public static needSize:I

.field public static strOperatorPath:Ljava/lang/String;

.field public static strSdkTypeName:Ljava/lang/String;


# instance fields
.field private appInfo:Landroid/content/pm/ApplicationInfo;

.field private jsonSdkConfig:Lorg/json/JSONObject;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 20
    sput-boolean v1, Lcom/eyugame/game/ConfigSingle;->IsNewUser:Z

    .line 21
    sput-boolean v1, Lcom/eyugame/game/ConfigSingle;->IsCheckConversion:Z

    .line 22
    const-string v0, ""

    sput-object v0, Lcom/eyugame/game/ConfigSingle;->ResCopyDir:Ljava/lang/String;

    .line 23
    const-string v0, ""

    sput-object v0, Lcom/eyugame/game/ConfigSingle;->strSdkTypeName:Ljava/lang/String;

    .line 24
    const/16 v0, 0x12c

    sput v0, Lcom/eyugame/game/ConfigSingle;->mKeyboardHeight:I

    .line 25
    sput v1, Lcom/eyugame/game/ConfigSingle;->needSize:I

    .line 26
    const/4 v0, 0x0

    sput-object v0, Lcom/eyugame/game/ConfigSingle;->strOperatorPath:Ljava/lang/String;

    return-void
.end method

.method public constructor <init>()V
    .locals 3

    .prologue
    const/4 v0, 0x0

    .line 28
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 17
    iput-object v0, p0, Lcom/eyugame/game/ConfigSingle;->jsonSdkConfig:Lorg/json/JSONObject;

    .line 18
    iput-object v0, p0, Lcom/eyugame/game/ConfigSingle;->appInfo:Landroid/content/pm/ApplicationInfo;

    .line 30
    :try_start_0
    invoke-static {}, Lcom/eyugame/game/ActivityMain;->GetInstance()Lcom/eyugame/game/ActivityMain;

    move-result-object v0

    invoke-virtual {v0}, Lcom/eyugame/game/ActivityMain;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v0

    .line 31
    invoke-static {}, Lcom/eyugame/game/ActivityMain;->GetInstance()Lcom/eyugame/game/ActivityMain;

    move-result-object v1

    invoke-virtual {v1}, Lcom/eyugame/game/ActivityMain;->getPackageName()Ljava/lang/String;

    move-result-object v1

    const/16 v2, 0x80

    .line 30
    invoke-virtual {v0, v1, v2}, Landroid/content/pm/PackageManager;->getApplicationInfo(Ljava/lang/String;I)Landroid/content/pm/ApplicationInfo;

    move-result-object v0

    iput-object v0, p0, Lcom/eyugame/game/ConfigSingle;->appInfo:Landroid/content/pm/ApplicationInfo;

    .line 33
    invoke-virtual {p0}, Lcom/eyugame/game/ConfigSingle;->GetAppInfo()V
    :try_end_0
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    .line 37
    :goto_0
    return-void

    .line 34
    :catch_0
    move-exception v0

    goto :goto_0
.end method

.method public static final getInstance()Lcom/eyugame/game/ConfigSingle;
    .locals 1

    .prologue
    .line 87
    invoke-static {}, Lcom/eyugame/game/ConfigSingle$ConfigSingleHolder;->access$000()Lcom/eyugame/game/ConfigSingle;

    move-result-object v0

    return-object v0
.end method


# virtual methods
.method public GetAppInfo()V
    .locals 3

    .prologue
    .line 76
    invoke-virtual {p0}, Lcom/eyugame/game/ConfigSingle;->metaData()Landroid/os/Bundle;

    move-result-object v0

    const-string v1, "EY_RES_COPY_DIR"

    invoke-virtual {v0, v1}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/eyugame/game/ConfigSingle;->ResCopyDir:Ljava/lang/String;

    .line 77
    invoke-virtual {p0}, Lcom/eyugame/game/ConfigSingle;->metaData()Landroid/os/Bundle;

    move-result-object v0

    const-string v1, "EY_OPERATOR_TYPE"

    invoke-virtual {v0, v1}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/eyugame/game/ConfigSingle;->strSdkTypeName:Ljava/lang/String;

    .line 78
    invoke-virtual {p0}, Lcom/eyugame/game/ConfigSingle;->metaData()Landroid/os/Bundle;

    move-result-object v0

    const-string v1, "EY_OPERATOR_PATH"

    invoke-virtual {v0, v1}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/eyugame/game/ConfigSingle;->strOperatorPath:Ljava/lang/String;

    .line 79
    invoke-virtual {p0}, Lcom/eyugame/game/ConfigSingle;->metaData()Landroid/os/Bundle;

    move-result-object v0

    const-string v1, "CHECK_CONVERSION"

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Landroid/os/Bundle;->getBoolean(Ljava/lang/String;Z)Z

    move-result v0

    sput-boolean v0, Lcom/eyugame/game/ConfigSingle;->IsCheckConversion:Z

    .line 80
    return-void
.end method

.method public GetItemFromMiscIniConfig(Ljava/lang/String;)Ljava/lang/String;
    .locals 5
    .param p1, "strKey"    # Ljava/lang/String;

    .prologue
    .line 64
    :try_start_0
    const-string v3, "ini/misc.ini"

    invoke-static {}, Lcom/eyugame/game/ActivityMain;->GetInstance()Lcom/eyugame/game/ActivityMain;

    move-result-object v4

    invoke-static {v3, v4}, Lcom/eyugame/base/LocationUtils;->getStringFromPack(Ljava/lang/String;Landroid/content/Context;)Ljava/lang/String;

    move-result-object v2

    .line 65
    .local v2, "strFileData":Ljava/lang/String;
    invoke-virtual {v2}, Ljava/lang/String;->getBytes()[B

    move-result-object v3

    invoke-static {v3}, Lcom/eyugame/impt/RelayNative;->DecryptData([B)Ljava/lang/String;

    move-result-object v2

    .line 66
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1, v2}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 67
    .local v1, "jsonObject":Lorg/json/JSONObject;
    invoke-virtual {v1, p1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_0

    invoke-virtual {v1, p1}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .line 70
    .end local v1    # "jsonObject":Lorg/json/JSONObject;
    .end local v2    # "strFileData":Ljava/lang/String;
    :goto_0
    return-object v3

    .line 67
    .restart local v1    # "jsonObject":Lorg/json/JSONObject;
    .restart local v2    # "strFileData":Ljava/lang/String;
    :cond_0
    const-string v3, ""
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 68
    .end local v1    # "jsonObject":Lorg/json/JSONObject;
    .end local v2    # "strFileData":Ljava/lang/String;
    :catch_0
    move-exception v0

    .line 69
    .local v0, "e":Lorg/json/JSONException;
    invoke-virtual {v0}, Lorg/json/JSONException;->printStackTrace()V

    .line 70
    const-string v3, ""

    goto :goto_0
.end method

.method public GetItemFromSdkConfig(Ljava/lang/String;)Ljava/lang/String;
    .locals 4
    .param p1, "strKey"    # Ljava/lang/String;

    .prologue
    .line 44
    iget-object v2, p0, Lcom/eyugame/game/ConfigSingle;->jsonSdkConfig:Lorg/json/JSONObject;

    if-nez v2, :cond_0

    .line 46
    :try_start_0
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    sget-object v3, Lcom/eyugame/game/ConfigSingle;->strOperatorPath:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "config.dat"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/eyugame/impt/RelayNative;->DecryptFile(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 47
    .local v1, "strFileData":Ljava/lang/String;
    new-instance v2, Lorg/json/JSONObject;

    invoke-direct {v2, v1}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    iput-object v2, p0, Lcom/eyugame/game/ConfigSingle;->jsonSdkConfig:Lorg/json/JSONObject;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    .line 55
    .end local v1    # "strFileData":Ljava/lang/String;
    :cond_0
    :try_start_1
    iget-object v2, p0, Lcom/eyugame/game/ConfigSingle;->jsonSdkConfig:Lorg/json/JSONObject;

    invoke-virtual {v2, p1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_1

    iget-object v2, p0, Lcom/eyugame/game/ConfigSingle;->jsonSdkConfig:Lorg/json/JSONObject;

    invoke-virtual {v2, p1}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;
    :try_end_1
    .catch Lorg/json/JSONException; {:try_start_1 .. :try_end_1} :catch_1

    move-result-object v2

    .line 58
    :goto_0
    return-object v2

    .line 48
    :catch_0
    move-exception v0

    .line 49
    .local v0, "e":Lorg/json/JSONException;
    invoke-virtual {v0}, Lorg/json/JSONException;->printStackTrace()V

    .line 50
    const-string v2, ""

    goto :goto_0

    .line 55
    .end local v0    # "e":Lorg/json/JSONException;
    :cond_1
    :try_start_2
    const-string v2, ""
    :try_end_2
    .catch Lorg/json/JSONException; {:try_start_2 .. :try_end_2} :catch_1

    goto :goto_0

    .line 56
    :catch_1
    move-exception v0

    .line 57
    .restart local v0    # "e":Lorg/json/JSONException;
    invoke-virtual {v0}, Lorg/json/JSONException;->printStackTrace()V

    .line 58
    const-string v2, ""

    goto :goto_0
.end method

.method public metaData()Landroid/os/Bundle;
    .locals 1

    .prologue
    .line 40
    iget-object v0, p0, Lcom/eyugame/game/ConfigSingle;->appInfo:Landroid/content/pm/ApplicationInfo;

    iget-object v0, v0, Landroid/content/pm/ApplicationInfo;->metaData:Landroid/os/Bundle;

    return-object v0
.end method
