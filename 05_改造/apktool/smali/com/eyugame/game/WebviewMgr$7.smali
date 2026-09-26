.class Lcom/eyugame/game/WebviewMgr$7;
.super Ljava/lang/Object;
.source "WebviewMgr.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/eyugame/game/WebviewMgr;->doCloseCloseWebPage()V
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
    .line 394
    iput-object p1, p0, Lcom/eyugame/game/WebviewMgr$7;->this$0:Lcom/eyugame/game/WebviewMgr;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    .prologue
    .line 397
    iget-object v0, p0, Lcom/eyugame/game/WebviewMgr$7;->this$0:Lcom/eyugame/game/WebviewMgr;

    invoke-static {v0}, Lcom/eyugame/game/WebviewMgr;->access$500(Lcom/eyugame/game/WebviewMgr;)Landroid/view/View;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/eyugame/game/WebviewMgr$7;->this$0:Lcom/eyugame/game/WebviewMgr;

    invoke-static {v0}, Lcom/eyugame/game/WebviewMgr;->access$500(Lcom/eyugame/game/WebviewMgr;)Landroid/view/View;

    move-result-object v0

    invoke-virtual {v0}, Landroid/view/View;->isShown()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 398
    iget-object v0, p0, Lcom/eyugame/game/WebviewMgr$7;->this$0:Lcom/eyugame/game/WebviewMgr;

    invoke-static {v0}, Lcom/eyugame/game/WebviewMgr;->access$500(Lcom/eyugame/game/WebviewMgr;)Landroid/view/View;

    move-result-object v0

    const/4 v1, 0x4

    invoke-virtual {v0, v1}, Landroid/view/View;->setVisibility(I)V

    .line 399
    iget-object v0, p0, Lcom/eyugame/game/WebviewMgr$7;->this$0:Lcom/eyugame/game/WebviewMgr;

    const/4 v1, 0x0

    invoke-static {v0, v1}, Lcom/eyugame/game/WebviewMgr;->access$502(Lcom/eyugame/game/WebviewMgr;Landroid/view/View;)Landroid/view/View;

    .line 401
    :cond_0
    return-void
.end method
