.class Lcom/eyugame/game/UpdateManager$8;
.super Ljava/lang/Object;
.source "UpdateManager.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/eyugame/game/UpdateManager;->checkUpdate(Ljava/lang/String;Landroid/app/Activity;)Z
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/eyugame/game/UpdateManager;

.field final synthetic val$strInfo:Ljava/lang/String;


# direct methods
.method constructor <init>(Lcom/eyugame/game/UpdateManager;Ljava/lang/String;)V
    .locals 0
    .param p1, "this$0"    # Lcom/eyugame/game/UpdateManager;

    .prologue
    .line 518
    iput-object p1, p0, Lcom/eyugame/game/UpdateManager$8;->this$0:Lcom/eyugame/game/UpdateManager;

    iput-object p2, p0, Lcom/eyugame/game/UpdateManager$8;->val$strInfo:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 11

    .prologue
    const/4 v8, 0x1

    .line 521
    :try_start_0
    new-instance v1, Lorg/json/JSONObject;

    iget-object v7, p0, Lcom/eyugame/game/UpdateManager$8;->val$strInfo:Ljava/lang/String;

    invoke-direct {v1, v7}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 522
    .local v1, "jsonObject":Lorg/json/JSONObject;
    const-string v7, "versionUrl"

    invoke-virtual {v1, v7}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v7

    if-eqz v7, :cond_0

    const-string v7, "versionUrl"

    invoke-virtual {v1, v7}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    .line 523
    .local v6, "strVersionUrl":Ljava/lang/String;
    :goto_0
    const-string v7, "downUrl"

    invoke-virtual {v1, v7}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v7

    if-eqz v7, :cond_1

    const-string v7, "downUrl"

    invoke-virtual {v1, v7}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    .line 524
    .local v4, "strPackageUrl":Ljava/lang/String;
    :goto_1
    const-string v7, "timeOut"

    invoke-virtual {v1, v7}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v7

    if-eqz v7, :cond_2

    const-string v7, "timeOut"

    invoke-virtual {v1, v7}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    .line 525
    .local v5, "strTimeOut":Ljava/lang/String;
    :goto_2
    invoke-static {v5}, Ljava/lang/Integer;->valueOf(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/Integer;->intValue()I

    move-result v2

    .line 528
    .local v2, "nTimeOut":I
    const-string v7, ""

    invoke-virtual {v6, v7}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v7

    if-nez v7, :cond_3

    .line 529
    iget-object v7, p0, Lcom/eyugame/game/UpdateManager$8;->this$0:Lcom/eyugame/game/UpdateManager;

    invoke-virtual {v7, v6, v4, v2}, Lcom/eyugame/game/UpdateManager;->update(Ljava/lang/String;Ljava/lang/String;I)V

    .line 539
    .end local v1    # "jsonObject":Lorg/json/JSONObject;
    .end local v2    # "nTimeOut":I
    .end local v4    # "strPackageUrl":Ljava/lang/String;
    .end local v5    # "strTimeOut":Ljava/lang/String;
    .end local v6    # "strVersionUrl":Ljava/lang/String;
    :goto_3
    return-void

    .line 522
    .restart local v1    # "jsonObject":Lorg/json/JSONObject;
    :cond_0
    const-string v6, ""

    goto :goto_0

    .line 523
    .restart local v6    # "strVersionUrl":Ljava/lang/String;
    :cond_1
    const-string v4, ""

    goto :goto_1

    .line 524
    .restart local v4    # "strPackageUrl":Ljava/lang/String;
    :cond_2
    const-string v5, ""

    goto :goto_2

    .line 531
    .restart local v2    # "nTimeOut":I
    .restart local v5    # "strTimeOut":Ljava/lang/String;
    :cond_3
    const-string v7, "version config is null, not check package update"

    invoke-static {v7}, Lcom/eyugame/impt/RelayNative;->LogMsg(Ljava/lang/String;)V

    .line 532
    const/4 v7, 0x1

    invoke-static {v7}, Lcom/eyugame/impt/RelayNative;->OnAutoPatch(I)V
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_3

    .line 534
    .end local v1    # "jsonObject":Lorg/json/JSONObject;
    .end local v2    # "nTimeOut":I
    .end local v4    # "strPackageUrl":Ljava/lang/String;
    .end local v5    # "strTimeOut":Ljava/lang/String;
    .end local v6    # "strVersionUrl":Ljava/lang/String;
    :catch_0
    move-exception v0

    .line 535
    .local v0, "e":Lorg/json/JSONException;
    const-string v7, "Parse update param failed!\n %s"

    new-array v8, v8, [Ljava/lang/Object;

    const/4 v9, 0x0

    invoke-virtual {v0}, Lorg/json/JSONException;->getLocalizedMessage()Ljava/lang/String;

    move-result-object v10

    aput-object v10, v8, v9

    invoke-static {v7, v8}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    .line 536
    .local v3, "strMsg":Ljava/lang/String;
    invoke-static {v3}, Lcom/eyugame/impt/RelayNative;->LogMsg(Ljava/lang/String;)V

    .line 537
    invoke-virtual {v0}, Lorg/json/JSONException;->printStackTrace()V

    goto :goto_3
.end method
