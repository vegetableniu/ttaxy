.class Lcom/eyugame/game/ActivityMain$10;
.super Ljava/lang/Object;
.source "ActivityMain.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/eyugame/game/ActivityMain;->showExitDialg()V
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
    .line 599
    iput-object p1, p0, Lcom/eyugame/game/ActivityMain$10;->this$0:Lcom/eyugame/game/ActivityMain;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    .prologue
    .line 602
    new-instance v0, Landroid/app/AlertDialog$Builder;

    invoke-static {}, Lcom/eyugame/game/ActivityMain;->access$000()Lcom/eyugame/game/ActivityMain;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    .line 603
    .local v0, "builder":Landroid/app/AlertDialog$Builder;
    iget-object v1, p0, Lcom/eyugame/game/ActivityMain$10;->this$0:Lcom/eyugame/game/ActivityMain;

    invoke-virtual {v1}, Lcom/eyugame/game/ActivityMain;->getApplicationContext()Landroid/content/Context;

    move-result-object v1

    const-string v2, "string"

    const-string v3, "exit_tip"

    invoke-static {v1, v2, v3}, Lcom/eyugame/game/MResource;->getIdByName(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setMessage(I)Landroid/app/AlertDialog$Builder;

    .line 604
    iget-object v1, p0, Lcom/eyugame/game/ActivityMain$10;->this$0:Lcom/eyugame/game/ActivityMain;

    invoke-virtual {v1}, Lcom/eyugame/game/ActivityMain;->getApplicationContext()Landroid/content/Context;

    move-result-object v1

    const-string v2, "string"

    const-string v3, "tip"

    invoke-static {v1, v2, v3}, Lcom/eyugame/game/MResource;->getIdByName(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setTitle(I)Landroid/app/AlertDialog$Builder;

    .line 606
    iget-object v1, p0, Lcom/eyugame/game/ActivityMain$10;->this$0:Lcom/eyugame/game/ActivityMain;

    invoke-virtual {v1}, Lcom/eyugame/game/ActivityMain;->getApplicationContext()Landroid/content/Context;

    move-result-object v1

    const-string v2, "string"

    const-string v3, "confirm"

    invoke-static {v1, v2, v3}, Lcom/eyugame/game/MResource;->getIdByName(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    new-instance v2, Lcom/eyugame/game/ActivityMain$10$1;

    invoke-direct {v2, p0}, Lcom/eyugame/game/ActivityMain$10$1;-><init>(Lcom/eyugame/game/ActivityMain$10;)V

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setPositiveButton(ILandroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    .line 614
    iget-object v1, p0, Lcom/eyugame/game/ActivityMain$10;->this$0:Lcom/eyugame/game/ActivityMain;

    invoke-virtual {v1}, Lcom/eyugame/game/ActivityMain;->getApplicationContext()Landroid/content/Context;

    move-result-object v1

    const-string v2, "string"

    const-string v3, "cancel"

    invoke-static {v1, v2, v3}, Lcom/eyugame/game/MResource;->getIdByName(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    new-instance v2, Lcom/eyugame/game/ActivityMain$10$2;

    invoke-direct {v2, p0}, Lcom/eyugame/game/ActivityMain$10$2;-><init>(Lcom/eyugame/game/ActivityMain$10;)V

    invoke-virtual {v0, v1, v2}, Landroid/app/AlertDialog$Builder;->setNegativeButton(ILandroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    .line 622
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->create()Landroid/app/AlertDialog;

    move-result-object v1

    invoke-virtual {v1}, Landroid/app/AlertDialog;->show()V

    .line 623
    return-void
.end method
