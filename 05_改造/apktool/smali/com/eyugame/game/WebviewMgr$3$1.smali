.class Lcom/eyugame/game/WebviewMgr$3$1;
.super Ljava/lang/Object;
.source "WebviewMgr.java"

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/eyugame/game/WebviewMgr$3;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/eyugame/game/WebviewMgr$3;


# direct methods
.method constructor <init>(Lcom/eyugame/game/WebviewMgr$3;)V
    .locals 0
    .param p1, "this$1"    # Lcom/eyugame/game/WebviewMgr$3;

    .prologue
    .line 137
    iput-object p1, p0, Lcom/eyugame/game/WebviewMgr$3$1;->this$1:Lcom/eyugame/game/WebviewMgr$3;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 1
    .param p1, "v"    # Landroid/view/View;

    .prologue
    .line 140
    iget-object v0, p0, Lcom/eyugame/game/WebviewMgr$3$1;->this$1:Lcom/eyugame/game/WebviewMgr$3;

    iget-object v0, v0, Lcom/eyugame/game/WebviewMgr$3;->this$0:Lcom/eyugame/game/WebviewMgr;

    invoke-virtual {v0}, Lcom/eyugame/game/WebviewMgr;->onDestoryWeb()V

    .line 141
    return-void
.end method
