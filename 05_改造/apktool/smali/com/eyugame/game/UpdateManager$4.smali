.class Lcom/eyugame/game/UpdateManager$4;
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
    .line 220
    iput-object p1, p0, Lcom/eyugame/game/UpdateManager$4;->this$0:Lcom/eyugame/game/UpdateManager;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 0
    .param p1, "dialog"    # Landroid/content/DialogInterface;
    .param p2, "which"    # I

    .prologue
    .line 224
    invoke-interface {p1}, Landroid/content/DialogInterface;->dismiss()V

    .line 225
    invoke-static {}, Lcom/eyugame/impt/RelayNative;->doExit()V

    .line 226
    return-void
.end method
