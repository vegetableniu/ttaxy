.class Lcom/eyugame/game/UpdateManager$CheckThread;
.super Ljava/lang/Thread;
.source "UpdateManager.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/eyugame/game/UpdateManager;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "CheckThread"
.end annotation


# instance fields
.field final synthetic this$0:Lcom/eyugame/game/UpdateManager;


# direct methods
.method private constructor <init>(Lcom/eyugame/game/UpdateManager;)V
    .locals 0

    .prologue
    .line 161
    iput-object p1, p0, Lcom/eyugame/game/UpdateManager$CheckThread;->this$0:Lcom/eyugame/game/UpdateManager;

    invoke-direct {p0}, Ljava/lang/Thread;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/eyugame/game/UpdateManager;Lcom/eyugame/game/UpdateManager$1;)V
    .locals 0
    .param p1, "x0"    # Lcom/eyugame/game/UpdateManager;
    .param p2, "x1"    # Lcom/eyugame/game/UpdateManager$1;

    .prologue
    .line 161
    invoke-direct {p0, p1}, Lcom/eyugame/game/UpdateManager$CheckThread;-><init>(Lcom/eyugame/game/UpdateManager;)V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    .prologue
    .line 164
    invoke-static {}, Lcom/eyugame/game/UpdateManager;->access$900()Lcom/eyugame/game/UpdateManager$CheckHandler;

    move-result-object v1

    iget-object v0, p0, Lcom/eyugame/game/UpdateManager$CheckThread;->this$0:Lcom/eyugame/game/UpdateManager;

    invoke-virtual {v0}, Lcom/eyugame/game/UpdateManager;->isUpdate()Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    invoke-virtual {v1, v0}, Lcom/eyugame/game/UpdateManager$CheckHandler;->sendEmptyMessage(I)Z

    .line 165
    return-void

    .line 164
    :cond_0
    const/4 v0, 0x2

    goto :goto_0
.end method
