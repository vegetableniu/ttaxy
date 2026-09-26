.class Lcom/eyugame/game/ActivityMain$4;
.super Ljava/lang/Object;
.source "ActivityMain.java"

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/eyugame/game/ActivityMain;->checkExternalStorageState()Z
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/eyugame/game/ActivityMain;


# direct methods
.method constructor <init>(Lcom/eyugame/game/ActivityMain;)V
    .locals 0
    .param p1, "this$0"    # Lcom/eyugame/game/ActivityMain;

    .prologue
    .line 383
    iput-object p1, p0, Lcom/eyugame/game/ActivityMain$4;->this$0:Lcom/eyugame/game/ActivityMain;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 0
    .param p1, "dialog"    # Landroid/content/DialogInterface;
    .param p2, "which"    # I

    .prologue
    .line 385
    invoke-interface {p1}, Landroid/content/DialogInterface;->dismiss()V

    .line 386
    invoke-static {}, Lcom/eyugame/impt/RelayNative;->doExit()V

    .line 387
    return-void
.end method
