.class Lcom/eyugame/game/UpdateManager$DwonloadApkHandler;
.super Landroid/os/Handler;
.source "UpdateManager.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/eyugame/game/UpdateManager;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "DwonloadApkHandler"
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
    .line 85
    invoke-direct {p0}, Landroid/os/Handler;-><init>()V

    .line 86
    new-instance v0, Ljava/lang/ref/WeakReference;

    invoke-direct {v0, p1}, Ljava/lang/ref/WeakReference;-><init>(Ljava/lang/Object;)V

    iput-object v0, p0, Lcom/eyugame/game/UpdateManager$DwonloadApkHandler;->mUpdateManager:Ljava/lang/ref/WeakReference;

    .line 87
    return-void
.end method


# virtual methods
.method public handleMessage(Landroid/os/Message;)V
    .locals 6
    .param p1, "msg"    # Landroid/os/Message;

    .prologue
    .line 90
    iget-object v2, p0, Lcom/eyugame/game/UpdateManager$DwonloadApkHandler;->mUpdateManager:Ljava/lang/ref/WeakReference;

    invoke-virtual {v2}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/eyugame/game/UpdateManager;

    .line 91
    .local v0, "mgr":Lcom/eyugame/game/UpdateManager;
    iget v2, p1, Landroid/os/Message;->what:I

    packed-switch v2, :pswitch_data_0

    .line 122
    :goto_0
    return-void

    .line 94
    :pswitch_0
    const-string v2, "%d%%"

    const/4 v3, 0x1

    new-array v3, v3, [Ljava/lang/Object;

    const/4 v4, 0x0

    invoke-static {v0}, Lcom/eyugame/game/UpdateManager;->access$000(Lcom/eyugame/game/UpdateManager;)I

    move-result v5

    invoke-static {v5}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    aput-object v5, v3, v4

    invoke-static {v2, v3}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    .line 95
    .local v1, "strPrg":Ljava/lang/String;
    invoke-static {v0}, Lcom/eyugame/game/UpdateManager;->access$100(Lcom/eyugame/game/UpdateManager;)Landroid/widget/TextView;

    move-result-object v2

    invoke-virtual {v2, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 96
    invoke-static {v0}, Lcom/eyugame/game/UpdateManager;->access$200(Lcom/eyugame/game/UpdateManager;)Landroid/widget/ProgressBar;

    move-result-object v2

    invoke-static {v0}, Lcom/eyugame/game/UpdateManager;->access$000(Lcom/eyugame/game/UpdateManager;)I

    move-result v3

    invoke-virtual {v2, v3}, Landroid/widget/ProgressBar;->setProgress(I)V

    goto :goto_0

    .line 101
    .end local v1    # "strPrg":Ljava/lang/String;
    :pswitch_1
    invoke-static {v0}, Lcom/eyugame/game/UpdateManager;->access$300(Lcom/eyugame/game/UpdateManager;)V

    goto :goto_0

    .line 104
    :pswitch_2
    invoke-static {v0}, Lcom/eyugame/game/UpdateManager;->access$400(Lcom/eyugame/game/UpdateManager;)V

    goto :goto_0

    .line 107
    :pswitch_3
    invoke-static {v0}, Lcom/eyugame/game/UpdateManager;->access$500(Lcom/eyugame/game/UpdateManager;)Landroid/content/Context;

    move-result-object v2

    const-string v3, "string"

    const-string v4, "download_share"

    invoke-static {v2, v3, v4}, Lcom/eyugame/game/MResource;->getIdByName(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v2

    invoke-static {v0, v2}, Lcom/eyugame/game/UpdateManager;->access$600(Lcom/eyugame/game/UpdateManager;I)V

    goto :goto_0

    .line 110
    :pswitch_4
    invoke-static {v0}, Lcom/eyugame/game/UpdateManager;->access$500(Lcom/eyugame/game/UpdateManager;)Landroid/content/Context;

    move-result-object v2

    const-string v3, "string"

    const-string v4, "download_fail"

    invoke-static {v2, v3, v4}, Lcom/eyugame/game/MResource;->getIdByName(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v2

    invoke-static {v0, v2}, Lcom/eyugame/game/UpdateManager;->access$600(Lcom/eyugame/game/UpdateManager;I)V

    goto :goto_0

    .line 113
    :pswitch_5
    invoke-static {v0}, Lcom/eyugame/game/UpdateManager;->access$500(Lcom/eyugame/game/UpdateManager;)Landroid/content/Context;

    move-result-object v2

    const-string v3, "string"

    const-string v4, "download_net"

    invoke-static {v2, v3, v4}, Lcom/eyugame/game/MResource;->getIdByName(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v2

    invoke-static {v0, v2}, Lcom/eyugame/game/UpdateManager;->access$600(Lcom/eyugame/game/UpdateManager;I)V

    goto :goto_0

    .line 116
    :pswitch_6
    invoke-static {v0}, Lcom/eyugame/game/UpdateManager;->access$500(Lcom/eyugame/game/UpdateManager;)Landroid/content/Context;

    move-result-object v2

    const-string v3, "string"

    const-string v4, "download_write"

    invoke-static {v2, v3, v4}, Lcom/eyugame/game/MResource;->getIdByName(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v2

    invoke-static {v0, v2}, Lcom/eyugame/game/UpdateManager;->access$600(Lcom/eyugame/game/UpdateManager;I)V

    goto :goto_0

    .line 119
    :pswitch_7
    invoke-static {v0}, Lcom/eyugame/game/UpdateManager;->access$500(Lcom/eyugame/game/UpdateManager;)Landroid/content/Context;

    move-result-object v2

    const-string v3, "string"

    const-string v4, "download_server"

    invoke-static {v2, v3, v4}, Lcom/eyugame/game/MResource;->getIdByName(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v2

    invoke-static {v0, v2}, Lcom/eyugame/game/UpdateManager;->access$600(Lcom/eyugame/game/UpdateManager;I)V

    goto :goto_0

    .line 91
    nop

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_0
        :pswitch_1
        :pswitch_2
        :pswitch_3
        :pswitch_4
        :pswitch_5
        :pswitch_6
        :pswitch_7
    .end packed-switch
.end method
