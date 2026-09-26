.class Lcom/eyugame/game/ActivityMain$7$1;
.super Ljava/lang/Object;
.source "ActivityMain.java"

# interfaces
.implements Landroid/view/View$OnKeyListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/eyugame/game/ActivityMain$7;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/eyugame/game/ActivityMain$7;


# direct methods
.method constructor <init>(Lcom/eyugame/game/ActivityMain$7;)V
    .locals 0
    .param p1, "this$1"    # Lcom/eyugame/game/ActivityMain$7;

    .prologue
    .line 541
    iput-object p1, p0, Lcom/eyugame/game/ActivityMain$7$1;->this$1:Lcom/eyugame/game/ActivityMain$7;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onKey(Landroid/view/View;ILandroid/view/KeyEvent;)Z
    .locals 1
    .param p1, "arg0"    # Landroid/view/View;
    .param p2, "arg1"    # I
    .param p3, "arg2"    # Landroid/view/KeyEvent;

    .prologue
    .line 545
    sparse-switch p2, :sswitch_data_0

    .line 555
    const/4 v0, 0x0

    :goto_0
    return v0

    .line 548
    :sswitch_0
    iget-object v0, p0, Lcom/eyugame/game/ActivityMain$7$1;->this$1:Lcom/eyugame/game/ActivityMain$7;

    iget-object v0, v0, Lcom/eyugame/game/ActivityMain$7;->this$0:Lcom/eyugame/game/ActivityMain;

    invoke-virtual {v0}, Lcom/eyugame/game/ActivityMain;->doReleaseFocus()V

    .line 549
    const/4 v0, 0x1

    goto :goto_0

    .line 545
    :sswitch_data_0
    .sparse-switch
        0x4 -> :sswitch_0
        0x42 -> :sswitch_0
    .end sparse-switch
.end method
