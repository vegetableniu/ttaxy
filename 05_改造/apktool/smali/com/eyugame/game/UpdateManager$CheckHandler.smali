.class Lcom/eyugame/game/UpdateManager$CheckHandler;
.super Landroid/os/Handler;
.source "UpdateManager.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/eyugame/game/UpdateManager;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "CheckHandler"
.end annotation


# instance fields
.field private mUpdateManager:Ljava/lang/ref/WeakReference;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/ref/WeakReference",
            "<",
            "Lcom/eyugame/game/UpdateManager;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>(Lcom/eyugame/game/UpdateManager;)V
    .locals 1
    .param p1, "mgr"    # Lcom/eyugame/game/UpdateManager;

    .prologue
    .line 136
    invoke-direct {p0}, Landroid/os/Handler;-><init>()V

    .line 137
    new-instance v0, Ljava/lang/ref/WeakReference;

    invoke-direct {v0, p1}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    iput-object v0, p0, Lcom/eyugame/game/UpdateManager$CheckHandler;->mUpdateManager:Ljava/lang/ref/WeakReference;

    .line 138
    return-void
.end method


# virtual methods
.method public handleMessage(Landroid/os/Message;)V
    .locals 3
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
    .line 141
    iget-object v2, p0, Lcom/eyugame/game/UpdateManager$CheckHandler;->mUpdateManager:Ljava/lang/ref/WeakReference;

    invoke-virtual {v2}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/eyugame/game/UpdateManager;

    .line 142
    .local v0, "mgr":Lcom/eyugame/game/UpdateManager;
    iget v2, p1, Landroid/os/Message;->what:I

    packed-switch v2, :pswitch_data_0

    .line 158
    :goto_0
    return-void

    .line 144
    :pswitch_0
    invoke-static {v0}, Lcom/eyugame/game/UpdateManager;->access$700(Lcom/eyugame/game/UpdateManager;)V

    goto :goto_0

    .line 149
    :pswitch_1
    invoke-static {}, Landroid/os/Environment;->getExternalStorageState()Ljava/lang/String;

    move-result-object v1

    .line 150
    .local v1, "strSdcardState":Ljava/lang/String;
    const-string v2, "mounted"

    invoke-virtual {v1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 151
    invoke-static {v0}, Lcom/eyugame/game/UpdateManager;->access$800(Lcom/eyugame/game/UpdateManager;)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lcom/eyugame/base/LocationUtils;->deleteDirectory(Ljava/lang/String;)Z

    .line 154
    :cond_0
    const/4 v2, 0x1

    invoke-static {v2}, Lcom/eyugame/impt/RelayNative;->OnAutoPatch(I)V

    goto :goto_0

    .line 142
    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_1
    .end packed-switch
.end method
