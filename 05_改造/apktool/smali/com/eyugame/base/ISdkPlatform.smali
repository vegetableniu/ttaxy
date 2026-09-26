.class public abstract Lcom/eyugame/base/ISdkPlatform;
.super Ljava/lang/Object;
.source "ISdkPlatform.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/eyugame/base/ISdkPlatform$EyLoginInfo;,
        Lcom/eyugame/base/ISdkPlatform$PayInfo;,
        Lcom/eyugame/base/ISdkPlatform$SdkFuncTypes;
    }
.end annotation


# static fields
.field public static sContext:Landroid/app/Activity;


# instance fields
.field protected mLoginInfo:Lcom/eyugame/base/ISdkPlatform$EyLoginInfo;

.field protected mPayDescInfo:Lcom/eyugame/base/ISdkPlatform$PayInfo;

.field protected msetSdkFunc:Ljava/util/HashSet;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashSet",
            "<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 79
    const/4 v0, 0x0

    sput-object v0, Lcom/eyugame/base/ISdkPlatform;->sContext:Landroid/app/Activity;

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    .prologue
    const/4 v0, 0x0

    .line 21
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 81
    iput-object v0, p0, Lcom/eyugame/base/ISdkPlatform;->mPayDescInfo:Lcom/eyugame/base/ISdkPlatform$PayInfo;

    .line 82
    iput-object v0, p0, Lcom/eyugame/base/ISdkPlatform;->mLoginInfo:Lcom/eyugame/base/ISdkPlatform$EyLoginInfo;

    .line 83
    iput-object v0, p0, Lcom/eyugame/base/ISdkPlatform;->msetSdkFunc:Ljava/util/HashSet;

    return-void
.end method


# virtual methods
.method public bindAccount(Ljava/lang/String;)V
    .locals 0
    .param p1, "strInfo"    # Ljava/lang/String;

    .prologue
    .line 219
    return-void
.end method

.method public checkSdkFunc(Ljava/lang/String;)Z
    .locals 1
    .param p1, "strInfo"    # Ljava/lang/String;

    .prologue
    .line 251
    if-eqz p1, :cond_0

    const-string v0, ""

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 252
    :cond_0
    const/4 v0, 0x0

    .line 254
    :goto_0
    return v0

    :cond_1
    iget-object v0, p0, Lcom/eyugame/base/ISdkPlatform;->msetSdkFunc:Ljava/util/HashSet;

    invoke-virtual {v0, p1}, Ljava/util/HashSet;->contains(Ljava/lang/Object;)Z

    move-result v0

    goto :goto_0
.end method

.method public delAccount(Ljava/lang/String;)V
    .locals 0
    .param p1, "strInfo"    # Ljava/lang/String;

    .prologue
    .line 227
    return-void
.end method

.method public doExit()Z
    .locals 1

    .prologue
    .line 301
    const/4 v0, 0x0

    return v0
.end method

.method public enter(Ljava/lang/String;)I
    .locals 1
    .param p1, "strCode"    # Ljava/lang/String;

    .prologue
    .line 181
    const/4 v0, 0x0

    return v0
.end method

.method public initSDK(Landroid/app/Activity;Ljava/lang/String;Landroid/os/Bundle;)V
    .locals 2
    .param p1, "aActivity"    # Landroid/app/Activity;
    .param p2, "strInfo"    # Ljava/lang/String;
    .param p3, "savedInstanceState"    # Landroid/os/Bundle;

    .prologue
    const/4 v1, 0x0

    .line 94
    sput-object p1, Lcom/eyugame/base/ISdkPlatform;->sContext:Landroid/app/Activity;

    .line 95
    new-instance v0, Ljava/util/HashSet;

    invoke-direct {v0}, Ljava/util/HashSet;-><init>()V

    iput-object v0, p0, Lcom/eyugame/base/ISdkPlatform;->msetSdkFunc:Ljava/util/HashSet;

    .line 96
    new-instance v0, Lcom/eyugame/base/ISdkPlatform$EyLoginInfo;

    invoke-direct {v0, p0, v1}, Lcom/eyugame/base/ISdkPlatform$EyLoginInfo;-><init>(Lcom/eyugame/base/ISdkPlatform;Lcom/eyugame/base/ISdkPlatform$1;)V

    iput-object v0, p0, Lcom/eyugame/base/ISdkPlatform;->mLoginInfo:Lcom/eyugame/base/ISdkPlatform$EyLoginInfo;

    .line 97
    new-instance v0, Lcom/eyugame/base/ISdkPlatform$PayInfo;

    invoke-direct {v0, p0, v1}, Lcom/eyugame/base/ISdkPlatform$PayInfo;-><init>(Lcom/eyugame/base/ISdkPlatform;Lcom/eyugame/base/ISdkPlatform$1;)V

    iput-object v0, p0, Lcom/eyugame/base/ISdkPlatform;->mPayDescInfo:Lcom/eyugame/base/ISdkPlatform$PayInfo;

    .line 98
    return-void
.end method

.method public abstract login(Ljava/lang/String;)I
.end method

.method public loginComplete(Ljava/lang/String;)V
    .locals 8
    .param p1, "strData"    # Ljava/lang/String;

    .prologue
    const/4 v4, 0x0

    .line 157
    new-instance v3, Lcom/eyugame/base/ISdkPlatform$EyLoginInfo;

    const/4 v5, 0x0

    invoke-direct {v3, p0, v5}, Lcom/eyugame/base/ISdkPlatform$EyLoginInfo;-><init>(Lcom/eyugame/base/ISdkPlatform;Lcom/eyugame/base/ISdkPlatform$1;)V

    iput-object v3, p0, Lcom/eyugame/base/ISdkPlatform;->mLoginInfo:Lcom/eyugame/base/ISdkPlatform$EyLoginInfo;

    .line 159
    :try_start_0
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1, p1}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 160
    .local v1, "jsonObject":Lorg/json/JSONObject;
    iget-object v5, p0, Lcom/eyugame/base/ISdkPlatform;->mLoginInfo:Lcom/eyugame/base/ISdkPlatform$EyLoginInfo;

    const-string v3, "time"

    invoke-virtual {v1, v3}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_0

    const-string v3, "time"

    invoke-virtual {v1, v3}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    :goto_0
    invoke-static {v3}, Ljava/lang/Long;->valueOf(Ljava/lang/String;)Ljava/lang/Long;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Long;->longValue()J

    move-result-wide v6

    iput-wide v6, v5, Lcom/eyugame/base/ISdkPlatform$EyLoginInfo;->lTime:J

    .line 161
    iget-object v5, p0, Lcom/eyugame/base/ISdkPlatform;->mLoginInfo:Lcom/eyugame/base/ISdkPlatform$EyLoginInfo;

    const-string v3, "serverId"

    invoke-virtual {v1, v3}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_1

    const-string v3, "serverId"

    invoke-virtual {v1, v3}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    :goto_1
    iput-object v3, v5, Lcom/eyugame/base/ISdkPlatform$EyLoginInfo;->strServerId:Ljava/lang/String;

    .line 162
    iget-object v5, p0, Lcom/eyugame/base/ISdkPlatform;->mLoginInfo:Lcom/eyugame/base/ISdkPlatform$EyLoginInfo;

    const-string v3, "serverName"

    invoke-virtual {v1, v3}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_2

    const-string v3, "serverName"

    invoke-virtual {v1, v3}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    :goto_2
    iput-object v3, v5, Lcom/eyugame/base/ISdkPlatform$EyLoginInfo;->strServerName:Ljava/lang/String;

    .line 163
    iget-object v5, p0, Lcom/eyugame/base/ISdkPlatform;->mLoginInfo:Lcom/eyugame/base/ISdkPlatform$EyLoginInfo;

    const-string v3, "userName"

    invoke-virtual {v1, v3}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_3

    const-string v3, "userName"

    invoke-virtual {v1, v3}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    :goto_3
    iput-object v3, v5, Lcom/eyugame/base/ISdkPlatform$EyLoginInfo;->strUserName:Ljava/lang/String;

    .line 164
    iget-object v5, p0, Lcom/eyugame/base/ISdkPlatform;->mLoginInfo:Lcom/eyugame/base/ISdkPlatform$EyLoginInfo;

    const-string v3, "accountId"

    invoke-virtual {v1, v3}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_4

    const-string v3, "accountId"

    invoke-virtual {v1, v3}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    :goto_4
    iput-object v3, v5, Lcom/eyugame/base/ISdkPlatform$EyLoginInfo;->strAccountId:Ljava/lang/String;

    .line 165
    iget-object v5, p0, Lcom/eyugame/base/ISdkPlatform;->mLoginInfo:Lcom/eyugame/base/ISdkPlatform$EyLoginInfo;

    const-string v3, "isFirstLogin"

    invoke-virtual {v1, v3}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_5

    const-string v3, "isFirstLogin"

    invoke-virtual {v1, v3}, Lorg/json/JSONObject;->getBoolean(Ljava/lang/String;)Z

    move-result v3

    :goto_5
    iput-boolean v3, v5, Lcom/eyugame/base/ISdkPlatform$EyLoginInfo;->bIsFirstLogin:Z

    .line 166
    iget-object v5, p0, Lcom/eyugame/base/ISdkPlatform;->mLoginInfo:Lcom/eyugame/base/ISdkPlatform$EyLoginInfo;

    const-string v3, "PlayerLevel"

    invoke-virtual {v1, v3}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_6

    const-string v3, "PlayerLevel"

    invoke-virtual {v1, v3}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    :goto_6
    iput-object v3, v5, Lcom/eyugame/base/ISdkPlatform$EyLoginInfo;->strUserLevel:Ljava/lang/String;

    .line 172
    .end local v1    # "jsonObject":Lorg/json/JSONObject;
    :goto_7
    return-void

    .restart local v1    # "jsonObject":Lorg/json/JSONObject;
    :cond_0
    move-object v3, p1

    .line 160
    goto :goto_0

    .line 161
    :cond_1
    const-string v3, ""

    goto :goto_1

    .line 162
    :cond_2
    const-string v3, ""

    goto :goto_2

    .line 163
    :cond_3
    const-string v3, ""

    goto :goto_3

    .line 164
    :cond_4
    const-string v3, ""

    goto :goto_4

    :cond_5
    move v3, v4

    .line 165
    goto :goto_5

    .line 166
    :cond_6
    const-string v3, ""
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_6

    .line 167
    .end local v1    # "jsonObject":Lorg/json/JSONObject;
    :catch_0
    move-exception v0

    .line 168
    .local v0, "e":Lorg/json/JSONException;
    const-string v3, "Parse loginComplete param error:%s\n%s"

    const/4 v5, 0x2

    new-array v5, v5, [Ljava/lang/Object;

    aput-object p1, v5, v4

    const/4 v4, 0x1

    invoke-virtual {v0}, Lorg/json/JSONException;->getLocalizedMessage()Ljava/lang/String;

    move-result-object v6

    aput-object v6, v5, v4

    invoke-static {v3, v5}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    .line 169
    .local v2, "strMsg":Ljava/lang/String;
    invoke-static {v2}, Lcom/eyugame/impt/RelayNative;->LogMsg(Ljava/lang/String;)V

    .line 170
    invoke-virtual {v0}, Lorg/json/JSONException;->printStackTrace()V

    goto :goto_7
.end method

.method public logout()I
    .locals 1

    .prologue
    .line 148
    const/4 v0, 0x0

    return v0
.end method

.method public onActivityCreate(Landroid/app/Activity;Landroid/os/Bundle;)Z
    .locals 1
    .param p1, "aActivity"    # Landroid/app/Activity;
    .param p2, "savedInstanceState"    # Landroid/os/Bundle;

    .prologue
    .line 191
    const/4 v0, 0x1

    return v0
.end method

.method public onActivityResult(IILandroid/content/Intent;)V
    .locals 0
    .param p1, "requestCode"    # I
    .param p2, "resultCode"    # I
    .param p3, "data"    # Landroid/content/Intent;

    .prologue
    .line 202
    return-void
.end method

.method public onBackPressed()Z
    .locals 1

    .prologue
    .line 309
    const/4 v0, 0x0

    return v0
.end method

.method public onDestroy()V
    .locals 0

    .prologue
    .line 294
    return-void
.end method

.method public onNewIntent(Landroid/content/Intent;)V
    .locals 0
    .param p1, "intent"    # Landroid/content/Intent;

    .prologue
    .line 322
    return-void
.end method

.method public onPause()V
    .locals 0

    .prologue
    .line 280
    return-void
.end method

.method public onRestart()V
    .locals 0

    .prologue
    .line 259
    return-void
.end method

.method public onResume()V
    .locals 0

    .prologue
    .line 273
    return-void
.end method

.method public onSaveInstanceState(Landroid/os/Bundle;)V
    .locals 0
    .param p1, "outState"    # Landroid/os/Bundle;

    .prologue
    .line 318
    return-void
.end method

.method public onStart()V
    .locals 0

    .prologue
    .line 266
    return-void
.end method

.method public onStop()V
    .locals 0

    .prologue
    .line 287
    return-void
.end method

.method public pay(Ljava/lang/String;)I
    .locals 7
    .param p1, "strInfo"    # Ljava/lang/String;

    .prologue
    const/4 v3, 0x0

    .line 115
    new-instance v4, Lcom/eyugame/base/ISdkPlatform$PayInfo;

    const/4 v5, 0x0

    invoke-direct {v4, p0, v5}, Lcom/eyugame/base/ISdkPlatform$PayInfo;-><init>(Lcom/eyugame/base/ISdkPlatform;Lcom/eyugame/base/ISdkPlatform$1;)V

    iput-object v4, p0, Lcom/eyugame/base/ISdkPlatform;->mPayDescInfo:Lcom/eyugame/base/ISdkPlatform$PayInfo;

    .line 117
    :try_start_0
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1, p1}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 118
    .local v1, "jsonObject":Lorg/json/JSONObject;
    iget-object v5, p0, Lcom/eyugame/base/ISdkPlatform;->mPayDescInfo:Lcom/eyugame/base/ISdkPlatform$PayInfo;

    const-string v4, "orderId"

    invoke-virtual {v1, v4}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_0

    const-string v4, "orderId"

    invoke-virtual {v1, v4}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    :goto_0
    iput-object v4, v5, Lcom/eyugame/base/ISdkPlatform$PayInfo;->strOrderId:Ljava/lang/String;

    .line 119
    iget-object v5, p0, Lcom/eyugame/base/ISdkPlatform;->mPayDescInfo:Lcom/eyugame/base/ISdkPlatform$PayInfo;

    const-string v4, "serverId"

    invoke-virtual {v1, v4}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_1

    const-string v4, "serverId"

    invoke-virtual {v1, v4}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    :goto_1
    iput-object v4, v5, Lcom/eyugame/base/ISdkPlatform$PayInfo;->strServerId:Ljava/lang/String;

    .line 120
    iget-object v5, p0, Lcom/eyugame/base/ISdkPlatform;->mPayDescInfo:Lcom/eyugame/base/ISdkPlatform$PayInfo;

    const-string v4, "goodsId"

    invoke-virtual {v1, v4}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_2

    const-string v4, "goodsId"

    invoke-virtual {v1, v4}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    :goto_2
    iput-object v4, v5, Lcom/eyugame/base/ISdkPlatform$PayInfo;->strGoodsId:Ljava/lang/String;

    .line 121
    iget-object v5, p0, Lcom/eyugame/base/ISdkPlatform;->mPayDescInfo:Lcom/eyugame/base/ISdkPlatform$PayInfo;

    const-string v4, "goodsCount"

    invoke-virtual {v1, v4}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_3

    const-string v4, "goodsCount"

    invoke-virtual {v1, v4}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    :goto_3
    iput-object v4, v5, Lcom/eyugame/base/ISdkPlatform$PayInfo;->strGoodsCount:Ljava/lang/String;

    .line 122
    iget-object v5, p0, Lcom/eyugame/base/ISdkPlatform;->mPayDescInfo:Lcom/eyugame/base/ISdkPlatform$PayInfo;

    const-string v4, "goodsPrice"

    invoke-virtual {v1, v4}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_4

    const-string v4, "goodsPrice"

    invoke-virtual {v1, v4}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    :goto_4
    iput-object v4, v5, Lcom/eyugame/base/ISdkPlatform$PayInfo;->strGoodsPrice:Ljava/lang/String;

    .line 123
    iget-object v5, p0, Lcom/eyugame/base/ISdkPlatform;->mPayDescInfo:Lcom/eyugame/base/ISdkPlatform$PayInfo;

    const-string v4, "goodsName"

    invoke-virtual {v1, v4}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_5

    const-string v4, "goodsName"

    invoke-virtual {v1, v4}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    :goto_5
    iput-object v4, v5, Lcom/eyugame/base/ISdkPlatform$PayInfo;->strGoodName:Ljava/lang/String;

    .line 124
    iget-object v5, p0, Lcom/eyugame/base/ISdkPlatform;->mPayDescInfo:Lcom/eyugame/base/ISdkPlatform$PayInfo;

    const-string v4, "goodsDiscount"

    invoke-virtual {v1, v4}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_6

    const-string v4, "goodsDiscount"

    invoke-virtual {v1, v4}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    :goto_6
    iput-object v4, v5, Lcom/eyugame/base/ISdkPlatform$PayInfo;->strGoodsDiscount:Ljava/lang/String;

    .line 125
    iget-object v5, p0, Lcom/eyugame/base/ISdkPlatform;->mPayDescInfo:Lcom/eyugame/base/ISdkPlatform$PayInfo;

    const-string v4, "accountId"

    invoke-virtual {v1, v4}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_7

    const-string v4, "accountId"

    invoke-virtual {v1, v4}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    :goto_7
    iput-object v4, v5, Lcom/eyugame/base/ISdkPlatform$PayInfo;->strAccountId:Ljava/lang/String;

    .line 126
    iget-object v5, p0, Lcom/eyugame/base/ISdkPlatform;->mPayDescInfo:Lcom/eyugame/base/ISdkPlatform$PayInfo;

    const-string v4, "serverName"

    invoke-virtual {v1, v4}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_8

    const-string v4, "serverName"

    invoke-virtual {v1, v4}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    :goto_8
    iput-object v4, v5, Lcom/eyugame/base/ISdkPlatform$PayInfo;->strServerName:Ljava/lang/String;

    .line 127
    iget-object v5, p0, Lcom/eyugame/base/ISdkPlatform;->mPayDescInfo:Lcom/eyugame/base/ISdkPlatform$PayInfo;

    const-string v4, "userName"

    invoke-virtual {v1, v4}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_9

    const-string v4, "userName"

    invoke-virtual {v1, v4}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    :goto_9
    iput-object v4, v5, Lcom/eyugame/base/ISdkPlatform$PayInfo;->strUserName:Ljava/lang/String;

    .line 128
    iget-object v5, p0, Lcom/eyugame/base/ISdkPlatform;->mPayDescInfo:Lcom/eyugame/base/ISdkPlatform$PayInfo;

    const-string v4, "operaterOrderId"

    invoke-virtual {v1, v4}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_a

    const-string v4, "operaterOrderId"

    invoke-virtual {v1, v4}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    :goto_a
    iput-object v4, v5, Lcom/eyugame/base/ISdkPlatform$PayInfo;->strOperaterOrderId:Ljava/lang/String;

    .line 129
    iget-object v5, p0, Lcom/eyugame/base/ISdkPlatform;->mPayDescInfo:Lcom/eyugame/base/ISdkPlatform$PayInfo;

    const-string v4, "goodsType"

    invoke-virtual {v1, v4}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_b

    const-string v4, "goodsType"

    invoke-virtual {v1, v4}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    :goto_b
    iput-object v4, v5, Lcom/eyugame/base/ISdkPlatform$PayInfo;->strGoodsType:Ljava/lang/String;

    .line 130
    iget-object v5, p0, Lcom/eyugame/base/ISdkPlatform;->mPayDescInfo:Lcom/eyugame/base/ISdkPlatform$PayInfo;

    const-string v4, "currencyCount"

    invoke-virtual {v1, v4}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_c

    const-string v4, "currencyCount"

    invoke-virtual {v1, v4}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    :goto_c
    iput-object v4, v5, Lcom/eyugame/base/ISdkPlatform$PayInfo;->strCurrencyCount:Ljava/lang/String;

    .line 131
    iget-object v5, p0, Lcom/eyugame/base/ISdkPlatform;->mPayDescInfo:Lcom/eyugame/base/ISdkPlatform$PayInfo;

    const-string v4, "urlParams"

    invoke-virtual {v1, v4}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_d

    const-string v4, "urlParams"

    invoke-virtual {v1, v4}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    :goto_d
    iput-object v4, v5, Lcom/eyugame/base/ISdkPlatform$PayInfo;->strUrlParams:Ljava/lang/String;

    .line 132
    iget-object v5, p0, Lcom/eyugame/base/ISdkPlatform;->mPayDescInfo:Lcom/eyugame/base/ISdkPlatform$PayInfo;

    const-string v4, "extension"

    invoke-virtual {v1, v4}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_e

    const-string v4, "extension"

    invoke-virtual {v1, v4}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    :goto_e
    iput-object v4, v5, Lcom/eyugame/base/ISdkPlatform$PayInfo;->strGoodextension:Ljava/lang/String;

    .line 140
    .end local v1    # "jsonObject":Lorg/json/JSONObject;
    :goto_f
    return v3

    .line 118
    .restart local v1    # "jsonObject":Lorg/json/JSONObject;
    :cond_0
    const-string v4, ""

    goto/16 :goto_0

    .line 119
    :cond_1
    const-string v4, ""

    goto/16 :goto_1

    .line 120
    :cond_2
    const-string v4, ""

    goto/16 :goto_2

    .line 121
    :cond_3
    const-string v4, ""

    goto/16 :goto_3

    .line 122
    :cond_4
    const-string v4, ""

    goto/16 :goto_4

    .line 123
    :cond_5
    const-string v4, ""

    goto/16 :goto_5

    .line 124
    :cond_6
    const-string v4, ""

    goto/16 :goto_6

    .line 125
    :cond_7
    const-string v4, ""

    goto/16 :goto_7

    .line 126
    :cond_8
    const-string v4, ""

    goto/16 :goto_8

    .line 127
    :cond_9
    const-string v4, ""

    goto/16 :goto_9

    .line 128
    :cond_a
    const-string v4, ""

    goto :goto_a

    .line 129
    :cond_b
    const-string v4, ""

    goto :goto_b

    .line 130
    :cond_c
    const-string v4, ""

    goto :goto_c

    .line 131
    :cond_d
    const-string v4, ""

    goto :goto_d

    .line 132
    :cond_e
    const-string v4, ""
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_e

    .line 133
    .end local v1    # "jsonObject":Lorg/json/JSONObject;
    :catch_0
    move-exception v0

    .line 134
    .local v0, "e":Lorg/json/JSONException;
    const-string v4, "Parse pay param failed!\n %s"

    const/4 v5, 0x1

    new-array v5, v5, [Ljava/lang/Object;

    invoke-virtual {v0}, Lorg/json/JSONException;->getLocalizedMessage()Ljava/lang/String;

    move-result-object v6

    aput-object v6, v5, v3

    invoke-static {v4, v5}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    .line 135
    .local v2, "strMsg":Ljava/lang/String;
    invoke-static {v2}, Lcom/eyugame/impt/RelayNative;->LogMsg(Ljava/lang/String;)V

    .line 136
    invoke-virtual {v0}, Lorg/json/JSONException;->printStackTrace()V

    .line 137
    const/4 v3, -0x1

    goto :goto_f
.end method

.method public popAdvert(Ljava/lang/String;)V
    .locals 0
    .param p1, "strInfo"    # Ljava/lang/String;

    .prologue
    .line 243
    return-void
.end method

.method public queryServerLst(Ljava/lang/String;)V
    .locals 0
    .param p1, "strInfo"    # Ljava/lang/String;

    .prologue
    .line 235
    return-void
.end method

.method public sendPlayerInfo(Ljava/lang/String;)V
    .locals 0
    .param p1, "strInfo"    # Ljava/lang/String;

    .prologue
    .line 211
    return-void
.end method

.method public shareFaceBook(Ljava/lang/String;)V
    .locals 0
    .param p1, "text"    # Ljava/lang/String;

    .prologue
    .line 330
    return-void
.end method
