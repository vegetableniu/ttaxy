.class Lcom/eyugame/game/ActivityMain$InitThread;
.super Ljava/lang/Thread;
.source "ActivityMain.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/eyugame/game/ActivityMain;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "InitThread"
.end annotation


# instance fields
.field final synthetic this$0:Lcom/eyugame/game/ActivityMain;


# direct methods
.method private constructor <init>(Lcom/eyugame/game/ActivityMain;)V
    .locals 0

    .prologue
    .line 196
    iput-object p1, p0, Lcom/eyugame/game/ActivityMain$InitThread;->this$0:Lcom/eyugame/game/ActivityMain;

    invoke-direct {p0}, Ljava/lang/Thread;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/eyugame/game/ActivityMain;Lcom/eyugame/game/ActivityMain$1;)V
    .locals 0
    .param p1, "x0"    # Lcom/eyugame/game/ActivityMain;
    .param p2, "x1"    # Lcom/eyugame/game/ActivityMain$1;

    .prologue
    .line 196
    invoke-direct {p0, p1}, Lcom/eyugame/game/ActivityMain$InitThread;-><init>(Lcom/eyugame/game/ActivityMain;)V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    .prologue
    .line 199
    iget-object v1, p0, Lcom/eyugame/game/ActivityMain$InitThread;->this$0:Lcom/eyugame/game/ActivityMain;

    invoke-virtual {v1}, Lcom/eyugame/game/ActivityMain;->checkExternalStorageState()Z

    move-result v1

    if-nez v1, :cond_0

    .line 218
    :goto_0
    return-void

    .line 203
    :cond_0
    :try_start_0
    iget-object v1, p0, Lcom/eyugame/game/ActivityMain$InitThread;->this$0:Lcom/eyugame/game/ActivityMain;

    invoke-virtual {v1}, Lcom/eyugame/game/ActivityMain;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v1

    iget-object v2, p0, Lcom/eyugame/game/ActivityMain$InitThread;->this$0:Lcom/eyugame/game/ActivityMain;

    .line 204
    invoke-virtual {v2}, Lcom/eyugame/game/ActivityMain;->getPackageName()Ljava/lang/String;

    move-result-object v2

    const/16 v3, 0x80

    .line 203
    invoke-virtual {v1, v2, v3}, Landroid/content/pm/PackageManager;->getApplicationInfo(Ljava/lang/String;I)Landroid/content/pm/ApplicationInfo;

    move-result-object v0

    .line 205
    .local v0, "appInfo":Landroid/content/pm/ApplicationInfo;
    iget-object v1, v0, Landroid/content/pm/ApplicationInfo;->metaData:Landroid/os/Bundle;

    const-string v2, "EY_RES_COPY_DIR"

    invoke-virtual {v1, v2}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/eyugame/game/ActivityMain;->access$102(Ljava/lang/String;)Ljava/lang/String;

    .line 206
    iget-object v1, v0, Landroid/content/pm/ApplicationInfo;->metaData:Landroid/os/Bundle;

    const-string v2, "EY_OPERATOR_TYPE"

    invoke-virtual {v1, v2}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/eyugame/game/ActivityMain;->access$202(Ljava/lang/String;)Ljava/lang/String;

    .line 207
    iget-object v1, p0, Lcom/eyugame/game/ActivityMain$InitThread;->this$0:Lcom/eyugame/game/ActivityMain;

    iget-object v2, v0, Landroid/content/pm/ApplicationInfo;->metaData:Landroid/os/Bundle;

    const-string v3, "EY_OPERATOR_PATH"

    invoke-virtual {v2, v3}, Landroid/os/Bundle;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/eyugame/game/ActivityMain;->access$302(Lcom/eyugame/game/ActivityMain;Ljava/lang/String;)Ljava/lang/String;

    .line 208
    iget-object v1, p0, Lcom/eyugame/game/ActivityMain$InitThread;->this$0:Lcom/eyugame/game/ActivityMain;

    invoke-static {v1}, Lcom/eyugame/game/ActivityMain;->access$300(Lcom/eyugame/game/ActivityMain;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lorg/cocos2dx/lib/Cocos2dxHelper;->setExternalOperatorPath(Ljava/lang/String;)V

    .line 209
    iget-object v1, v0, Landroid/content/pm/ApplicationInfo;->metaData:Landroid/os/Bundle;

    const-string v2, "CHECK_CONVERSION"

    const/4 v3, 0x0

    invoke-virtual {v1, v2, v3}, Landroid/os/Bundle;->getBoolean(Ljava/lang/String;Z)Z

    move-result v1

    sput-boolean v1, Lcom/eyugame/game/ActivityMain;->IsCheckConversion:Z
    :try_end_0
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    .line 214
    .end local v0    # "appInfo":Landroid/content/pm/ApplicationInfo;
    :goto_1
    const-string v1, "ConversionLaunch"

    invoke-static {v1}, Lcom/eyugame/game/ActivityMain;->SendConverion(Ljava/lang/String;)V

    .line 215
    iget-object v1, p0, Lcom/eyugame/game/ActivityMain$InitThread;->this$0:Lcom/eyugame/game/ActivityMain;

    invoke-virtual {v1}, Lcom/eyugame/game/ActivityMain;->TryCopyAssets()V

    .line 217
    const-string v1, "ConversionUnpackSucc"

    invoke-static {v1}, Lcom/eyugame/game/ActivityMain;->SendConverion(Ljava/lang/String;)V

    goto :goto_0

    .line 211
    :catch_0
    move-exception v1

    goto :goto_1
.end method
