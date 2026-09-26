.class Lcom/eyugame/game/UpdateManager$7;
.super Ljava/lang/Object;
.source "UpdateManager.java"

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/eyugame/game/UpdateManager;->showDownloadDialog()V
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
    .line 274
    iput-object p1, p0, Lcom/eyugame/game/UpdateManager$7;->this$0:Lcom/eyugame/game/UpdateManager;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 2
    .param p1, "dialog"    # Landroid/content/DialogInterface;
    .param p2, "which"    # I

    .prologue
    .line 278
    invoke-interface {p1}, Landroid/content/DialogInterface;->dismiss()V

    .line 280
    iget-object v0, p0, Lcom/eyugame/game/UpdateManager$7;->this$0:Lcom/eyugame/game/UpdateManager;

    const/4 v1, 0x1

    invoke-static {v0, v1}, Lcom/eyugame/game/UpdateManager;->access$1202(Lcom/eyugame/game/UpdateManager;Z)Z

    .line 281
    invoke-static {}, Lcom/eyugame/impt/RelayNative;->doExit()V

    .line 282
    return-void
.end method
