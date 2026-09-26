.class Lcom/eyugame/game/ActivityMain$6;
.super Ljava/lang/Object;
.source "ActivityMain.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/eyugame/game/ActivityMain;->doProcKeepScreenOn(Z)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/eyugame/game/ActivityMain;

.field final synthetic val$bState:Z


# direct methods
.method constructor <init>(Lcom/eyugame/game/ActivityMain;Z)V
    .locals 0
    .param p1, "this$0"    # Lcom/eyugame/game/ActivityMain;

    .prologue
    .line 496
    iput-object p1, p0, Lcom/eyugame/game/ActivityMain$6;->this$0:Lcom/eyugame/game/ActivityMain;

    iput-boolean p2, p0, Lcom/eyugame/game/ActivityMain$6;->val$bState:Z

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    .prologue
    const/high16 v2, 0x400000

    const/16 v1, 0x80

    .line 501
    iget-boolean v0, p0, Lcom/eyugame/game/ActivityMain$6;->val$bState:Z

    if-eqz v0, :cond_0

    .line 503
    iget-object v0, p0, Lcom/eyugame/game/ActivityMain$6;->this$0:Lcom/eyugame/game/ActivityMain;

    invoke-virtual {v0}, Lcom/eyugame/game/ActivityMain;->getWindow()Landroid/view/Window;

    move-result-object v0

    invoke-virtual {v0, v2, v2}, Landroid/view/Window;->setFlags(II)V

    .line 504
    iget-object v0, p0, Lcom/eyugame/game/ActivityMain$6;->this$0:Lcom/eyugame/game/ActivityMain;

    invoke-virtual {v0}, Lcom/eyugame/game/ActivityMain;->getWindow()Landroid/view/Window;

    move-result-object v0

    invoke-virtual {v0, v1, v1}, Landroid/view/Window;->setFlags(II)V

    .line 511
    :goto_0
    return-void

    .line 508
    :cond_0
    iget-object v0, p0, Lcom/eyugame/game/ActivityMain$6;->this$0:Lcom/eyugame/game/ActivityMain;

    invoke-virtual {v0}, Lcom/eyugame/game/ActivityMain;->getWindow()Landroid/view/Window;

    move-result-object v0

    invoke-virtual {v0, v2}, Landroid/view/Window;->clearFlags(I)V

    .line 509
    iget-object v0, p0, Lcom/eyugame/game/ActivityMain$6;->this$0:Lcom/eyugame/game/ActivityMain;

    invoke-virtual {v0}, Lcom/eyugame/game/ActivityMain;->getWindow()Landroid/view/Window;

    move-result-object v0

    invoke-virtual {v0, v1}, Landroid/view/Window;->clearFlags(I)V

    goto :goto_0
.end method
