.class Lcom/eyugame/game/WebviewMgr$6;
.super Ljava/lang/Object;
.source "WebviewMgr.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/eyugame/game/WebviewMgr;->doOpenUrlInRect(Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/eyugame/game/WebviewMgr;

.field final synthetic val$jsonStr:Ljava/lang/String;


# direct methods
.method constructor <init>(Lcom/eyugame/game/WebviewMgr;Ljava/lang/String;)V
    .locals 0
    .param p1, "this$0"    # Lcom/eyugame/game/WebviewMgr;

    .prologue
    .line 308
    iput-object p1, p0, Lcom/eyugame/game/WebviewMgr$6;->this$0:Lcom/eyugame/game/WebviewMgr;

    iput-object p2, p0, Lcom/eyugame/game/WebviewMgr$6;->val$jsonStr:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 19

    .prologue
    .line 336
    :try_start_0
    new-instance v16, Lorg/json/JSONObject;

    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/eyugame/game/WebviewMgr$6;->val$jsonStr:Ljava/lang/String;

    move-object/from16 v0, v16

    invoke-direct {v0, v2}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 337
    .local v16, "jsonObject":Lorg/json/JSONObject;
    const-string v2, "url"

    move-object/from16 v0, v16

    invoke-virtual {v0, v2}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v14

    .line 338
    .local v14, "callboardUrl":Ljava/lang/String;
    const-string v2, "x"

    move-object/from16 v0, v16

    invoke-virtual {v0, v2}, Lorg/json/JSONObject;->getDouble(Ljava/lang/String;)D

    move-result-wide v4

    .line 339
    .local v4, "x":D
    const-string v2, "y"

    move-object/from16 v0, v16

    invoke-virtual {v0, v2}, Lorg/json/JSONObject;->getDouble(Ljava/lang/String;)D

    move-result-wide v10

    .line 340
    .local v10, "y":D
    const-string v2, "width"

    move-object/from16 v0, v16

    invoke-virtual {v0, v2}, Lorg/json/JSONObject;->getDouble(Ljava/lang/String;)D

    move-result-wide v7

    .line 341
    .local v7, "width":D
    const-string v2, "height"

    move-object/from16 v0, v16

    invoke-virtual {v0, v2}, Lorg/json/JSONObject;->getDouble(Ljava/lang/String;)D

    move-result-wide v12

    .line 342
    .local v12, "height":D
    new-instance v17, Landroid/util/DisplayMetrics;

    invoke-direct/range {v17 .. v17}, Landroid/util/DisplayMetrics;-><init>()V

    .line 343
    .local v17, "metric":Landroid/util/DisplayMetrics;
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/eyugame/game/WebviewMgr$6;->this$0:Lcom/eyugame/game/WebviewMgr;

    invoke-static {v2}, Lcom/eyugame/game/WebviewMgr;->access$100(Lcom/eyugame/game/WebviewMgr;)Lcom/eyugame/game/ActivityMain;

    move-result-object v2

    invoke-virtual {v2}, Lcom/eyugame/game/ActivityMain;->getResources()Landroid/content/res/Resources;

    move-result-object v2

    invoke-virtual {v2}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v17

    .line 344
    move-object/from16 v0, v17

    iget v6, v0, Landroid/util/DisplayMetrics;->widthPixels:I

    .line 345
    .local v6, "nScreenWidth":I
    move-object/from16 v0, v17

    iget v9, v0, Landroid/util/DisplayMetrics;->heightPixels:I

    .line 347
    .local v9, "nScreenHeight":I
    new-instance v18, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v2

    move-object/from16 v0, v18

    invoke-direct {v0, v2}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    new-instance v2, Lcom/eyugame/game/WebviewMgr$6$1;

    move-object/from16 v3, p0

    invoke-direct/range {v2 .. v14}, Lcom/eyugame/game/WebviewMgr$6$1;-><init>(Lcom/eyugame/game/WebviewMgr$6;DIDIDDLjava/lang/String;)V

    move-object/from16 v0, v18

    invoke-virtual {v0, v2}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    .line 389
    .end local v4    # "x":D
    .end local v6    # "nScreenWidth":I
    .end local v7    # "width":D
    .end local v9    # "nScreenHeight":I
    .end local v10    # "y":D
    .end local v12    # "height":D
    .end local v14    # "callboardUrl":Ljava/lang/String;
    .end local v16    # "jsonObject":Lorg/json/JSONObject;
    .end local v17    # "metric":Landroid/util/DisplayMetrics;
    :goto_0
    return-void

    .line 386
    :catch_0
    move-exception v15

    .line 387
    .local v15, "e":Lorg/json/JSONException;
    invoke-virtual {v15}, Lorg/json/JSONException;->printStackTrace()V

    goto :goto_0
.end method
