.class Lcom/eyugame/game/ActivityMain$3;
.super Ljava/lang/Object;
.source "ActivityMain.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/eyugame/game/ActivityMain;->TryCopyAssets()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/eyugame/game/ActivityMain;


# direct methods
.method constructor <init>(Lcom/eyugame/game/ActivityMain;)V
    .locals 0
    .param p1, "this$0"    # Lcom/eyugame/game/ActivityMain;

    .prologue
    .line 332
    iput-object p1, p0, Lcom/eyugame/game/ActivityMain$3;->this$0:Lcom/eyugame/game/ActivityMain;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 8

    .prologue
    .line 334
    new-instance v1, Landroid/app/AlertDialog$Builder;

    invoke-static {}, Lcom/eyugame/game/ActivityMain;->access$000()Lcom/eyugame/game/ActivityMain;

    move-result-object v5

    invoke-direct {v1, v5}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    .line 335
    .local v1, "builder":Landroid/app/AlertDialog$Builder;
    iget-object v5, p0, Lcom/eyugame/game/ActivityMain$3;->this$0:Lcom/eyugame/game/ActivityMain;

    invoke-virtual {v5}, Lcom/eyugame/game/ActivityMain;->getApplicationContext()Landroid/content/Context;

    move-result-object v5

    const-string v6, "string"

    const-string v7, "tip"

    invoke-static {v5, v6, v7}, Lcom/eyugame/game/MResource;->getIdByName(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v5

    invoke-virtual {v1, v5}, Landroid/app/AlertDialog$Builder;->setTitle(I)Landroid/app/AlertDialog$Builder;

    .line 336
    invoke-static {}, Lorg/cocos2dx/lib/Cocos2dxHelper;->isUseExternalStorage()Z

    move-result v0

    .line 337
    .local v0, "bUseExternalStorage":Z
    if-eqz v0, :cond_0

    invoke-static {}, Lcom/eyugame/base/LocationUtils;->getAvailableExternalMemorySize()J

    move-result-wide v2

    .line 338
    .local v2, "lAvaliableSize":J
    :goto_0
    invoke-static {}, Lcom/eyugame/game/ActivityMain;->access$600()I

    move-result v5

    mul-int/lit16 v5, v5, 0x400

    mul-int/lit16 v5, v5, 0x400

    int-to-long v6, v5

    cmp-long v5, v2, v6

    if-gez v5, :cond_2

    .line 339
    iget-object v5, p0, Lcom/eyugame/game/ActivityMain$3;->this$0:Lcom/eyugame/game/ActivityMain;

    invoke-virtual {v5}, Lcom/eyugame/game/ActivityMain;->getApplicationContext()Landroid/content/Context;

    move-result-object v6

    const-string v7, "string"

    invoke-static {}, Lorg/cocos2dx/lib/Cocos2dxHelper;->isUseExternalStorage()Z

    move-result v5

    if-eqz v5, :cond_1

    const-string v5, "sd_memory_lower"

    :goto_1
    invoke-static {v6, v7, v5}, Lcom/eyugame/game/MResource;->getIdByName(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v5

    invoke-virtual {v1, v5}, Landroid/app/AlertDialog$Builder;->setMessage(I)Landroid/app/AlertDialog$Builder;

    .line 343
    :goto_2
    iget-object v5, p0, Lcom/eyugame/game/ActivityMain$3;->this$0:Lcom/eyugame/game/ActivityMain;

    invoke-virtual {v5}, Lcom/eyugame/game/ActivityMain;->getApplicationContext()Landroid/content/Context;

    move-result-object v5

    const-string v6, "string"

    const-string v7, "Eyugame_Retry"

    invoke-static {v5, v6, v7}, Lcom/eyugame/game/MResource;->getIdByName(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v5

    new-instance v6, Lcom/eyugame/game/ActivityMain$3$1;

    invoke-direct {v6, p0}, Lcom/eyugame/game/ActivityMain$3$1;-><init>(Lcom/eyugame/game/ActivityMain$3;)V

    invoke-virtual {v1, v5, v6}, Landroid/app/AlertDialog$Builder;->setPositiveButton(ILandroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    .line 350
    iget-object v5, p0, Lcom/eyugame/game/ActivityMain$3;->this$0:Lcom/eyugame/game/ActivityMain;

    invoke-virtual {v5}, Lcom/eyugame/game/ActivityMain;->getApplicationContext()Landroid/content/Context;

    move-result-object v5

    const-string v6, "string"

    const-string v7, "cancel"

    invoke-static {v5, v6, v7}, Lcom/eyugame/game/MResource;->getIdByName(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v5

    new-instance v6, Lcom/eyugame/game/ActivityMain$3$2;

    invoke-direct {v6, p0}, Lcom/eyugame/game/ActivityMain$3$2;-><init>(Lcom/eyugame/game/ActivityMain$3;)V

    invoke-virtual {v1, v5, v6}, Landroid/app/AlertDialog$Builder;->setNegativeButton(ILandroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    .line 357
    invoke-virtual {v1}, Landroid/app/AlertDialog$Builder;->create()Landroid/app/AlertDialog;

    move-result-object v4

    .line 359
    .local v4, "noticeDialog":Landroid/app/AlertDialog;
    invoke-virtual {v4}, Landroid/app/AlertDialog;->show()V

    .line 360
    const/4 v5, 0x0

    invoke-virtual {v4, v5}, Landroid/app/AlertDialog;->setCancelable(Z)V

    .line 362
    return-void

    .line 337
    .end local v2    # "lAvaliableSize":J
    .end local v4    # "noticeDialog":Landroid/app/AlertDialog;
    :cond_0
    invoke-static {}, Lcom/eyugame/base/LocationUtils;->getAvailableInternalMemorySize()J

    move-result-wide v2

    goto :goto_0

    .line 339
    .restart local v2    # "lAvaliableSize":J
    :cond_1
    const-string v5, "memory_lower"

    goto :goto_1

    .line 341
    :cond_2
    iget-object v5, p0, Lcom/eyugame/game/ActivityMain$3;->this$0:Lcom/eyugame/game/ActivityMain;

    invoke-virtual {v5}, Lcom/eyugame/game/ActivityMain;->getApplicationContext()Landroid/content/Context;

    move-result-object v6

    const-string v7, "string"

    invoke-static {}, Lorg/cocos2dx/lib/Cocos2dxHelper;->isUseExternalStorage()Z

    move-result v5

    if-eqz v5, :cond_3

    const-string v5, "unzip_res_sd_fail"

    :goto_3
    invoke-static {v6, v7, v5}, Lcom/eyugame/game/MResource;->getIdByName(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v5

    invoke-virtual {v1, v5}, Landroid/app/AlertDialog$Builder;->setMessage(I)Landroid/app/AlertDialog$Builder;

    goto :goto_2

    :cond_3
    const-string v5, "unzip_res_fail"

    goto :goto_3
.end method
