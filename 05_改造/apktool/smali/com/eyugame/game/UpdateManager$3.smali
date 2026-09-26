.class Lcom/eyugame/game/UpdateManager$3;
.super Ljava/lang/Object;
.source "UpdateManager.java"

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/eyugame/game/UpdateManager;->showDownloadFailDlg(I)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/eyugame/game/UpdateManager;


# direct methods
.method constructor <init>(Lcom/eyugame/game/UpdateManager;)V
    .locals 0
    .param p1, "this$0"    # Lcom/eyugame/game/UpdateManager;

    .prologue
    .line 210
    iput-object p1, p0, Lcom/eyugame/game/UpdateManager$3;->this$0:Lcom/eyugame/game/UpdateManager;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 1
    .param p1, "dialog"    # Landroid/content/DialogInterface;
    .param p2, "which"    # I

    .prologue
    .line 214
    invoke-interface {p1}, Landroid/content/DialogInterface;->dismiss()V

    .line 216
    iget-object v0, p0, Lcom/eyugame/game/UpdateManager$3;->this$0:Lcom/eyugame/game/UpdateManager;

    invoke-static {v0}, Lcom/eyugame/game/UpdateManager;->access$1100(Lcom/eyugame/game/UpdateManager;)V

    .line 217
    return-void
.end method
