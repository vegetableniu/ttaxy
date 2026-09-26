.class Lcom/eyugame/game/WebviewMgr$1;
.super Ljava/lang/Object;
.source "WebviewMgr.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/eyugame/game/WebviewMgr;->showLoading()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/eyugame/game/WebviewMgr;


# direct methods
.method constructor <init>(Lcom/eyugame/game/WebviewMgr;)V
    .locals 0
    .param p1, "this$0"    # Lcom/eyugame/game/WebviewMgr;

    .prologue
    .line 43
    iput-object p1, p0, Lcom/eyugame/game/WebviewMgr$1;->this$0:Lcom/eyugame/game/WebviewMgr;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 6

    .prologue
    const/4 v5, 0x1

    .line 45
    iget-object v1, p0, Lcom/eyugame/game/WebviewMgr$1;->this$0:Lcom/eyugame/game/WebviewMgr;

    invoke-static {v1}, Lcom/eyugame/game/WebviewMgr;->access$000(Lcom/eyugame/game/WebviewMgr;)Landroid/app/ProgressDialog;

    move-result-object v1

    if-nez v1, :cond_1

    .line 46
    iget-object v1, p0, Lcom/eyugame/game/WebviewMgr$1;->this$0:Lcom/eyugame/game/WebviewMgr;

    new-instance v2, Landroid/app/ProgressDialog;

    iget-object v3, p0, Lcom/eyugame/game/WebviewMgr$1;->this$0:Lcom/eyugame/game/WebviewMgr;

    invoke-static {v3}, Lcom/eyugame/game/WebviewMgr;->access$100(Lcom/eyugame/game/WebviewMgr;)Lcom/eyugame/game/ActivityMain;

    move-result-object v3

    invoke-direct {v2, v3}, Landroid/app/ProgressDialog;-><init>(Landroid/content/Context;)V

    invoke-static {v1, v2}, Lcom/eyugame/game/WebviewMgr;->access$002(Lcom/eyugame/game/WebviewMgr;Landroid/app/ProgressDialog;)Landroid/app/ProgressDialog;

    .line 48
    iget-object v1, p0, Lcom/eyugame/game/WebviewMgr$1;->this$0:Lcom/eyugame/game/WebviewMgr;

    invoke-static {v1}, Lcom/eyugame/game/WebviewMgr;->access$100(Lcom/eyugame/game/WebviewMgr;)Lcom/eyugame/game/ActivityMain;

    move-result-object v1

    invoke-virtual {v1}, Lcom/eyugame/game/ActivityMain;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    iget-object v2, p0, Lcom/eyugame/game/WebviewMgr$1;->this$0:Lcom/eyugame/game/WebviewMgr;

    .line 49
    invoke-static {v2}, Lcom/eyugame/game/WebviewMgr;->access$100(Lcom/eyugame/game/WebviewMgr;)Lcom/eyugame/game/ActivityMain;

    move-result-object v2

    invoke-virtual {v2}, Lcom/eyugame/game/ActivityMain;->getApplicationContext()Landroid/content/Context;

    move-result-object v2

    const-string v3, "string"

    const-string v4, "loading"

    invoke-static {v2, v3, v4}, Lcom/eyugame/game/MResource;->getIdByName(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v2

    .line 48
    invoke-virtual {v1, v2}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v0

    .line 50
    .local v0, "strMsg":Ljava/lang/String;
    if-eqz v0, :cond_0

    .line 51
    iget-object v1, p0, Lcom/eyugame/game/WebviewMgr$1;->this$0:Lcom/eyugame/game/WebviewMgr;

    invoke-static {v1}, Lcom/eyugame/game/WebviewMgr;->access$000(Lcom/eyugame/game/WebviewMgr;)Landroid/app/ProgressDialog;

    move-result-object v1

    invoke-virtual {v1, v0}, Landroid/app/ProgressDialog;->setMessage(Ljava/lang/CharSequence;)V

    .line 53
    :cond_0
    iget-object v1, p0, Lcom/eyugame/game/WebviewMgr$1;->this$0:Lcom/eyugame/game/WebviewMgr;

    invoke-static {v1}, Lcom/eyugame/game/WebviewMgr;->access$000(Lcom/eyugame/game/WebviewMgr;)Landroid/app/ProgressDialog;

    move-result-object v1

    invoke-virtual {v1, v5}, Landroid/app/ProgressDialog;->setIndeterminate(Z)V

    .line 54
    iget-object v1, p0, Lcom/eyugame/game/WebviewMgr$1;->this$0:Lcom/eyugame/game/WebviewMgr;

    invoke-static {v1}, Lcom/eyugame/game/WebviewMgr;->access$000(Lcom/eyugame/game/WebviewMgr;)Landroid/app/ProgressDialog;

    move-result-object v1

    invoke-virtual {v1, v5}, Landroid/app/ProgressDialog;->setCancelable(Z)V

    .line 56
    iget-object v1, p0, Lcom/eyugame/game/WebviewMgr$1;->this$0:Lcom/eyugame/game/WebviewMgr;

    invoke-static {v1}, Lcom/eyugame/game/WebviewMgr;->access$000(Lcom/eyugame/game/WebviewMgr;)Landroid/app/ProgressDialog;

    move-result-object v1

    invoke-virtual {v1}, Landroid/app/ProgressDialog;->show()V

    .line 59
    .end local v0    # "strMsg":Ljava/lang/String;
    :cond_1
    return-void
.end method
