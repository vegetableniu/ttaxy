.class Lcom/eyugame/game/ActivityMain$1;
.super Ljava/lang/Object;
.source "ActivityMain.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/eyugame/game/ActivityMain;->OnExtractResSuc()V
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
    .line 145
    iput-object p1, p0, Lcom/eyugame/game/ActivityMain$1;->this$0:Lcom/eyugame/game/ActivityMain;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 5

    .prologue
    .line 149
    new-instance v0, Landroid/app/AlertDialog$Builder;

    invoke-static {}, Lcom/eyugame/game/ActivityMain;->access$000()Lcom/eyugame/game/ActivityMain;

    move-result-object v2

    invoke-direct {v0, v2}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    .line 150
    .local v0, "builder":Landroid/app/AlertDialog$Builder;
    iget-object v2, p0, Lcom/eyugame/game/ActivityMain$1;->this$0:Lcom/eyugame/game/ActivityMain;

    invoke-virtual {v2}, Lcom/eyugame/game/ActivityMain;->getApplicationContext()Landroid/content/Context;

    move-result-object v2

    const-string v3, "string"

    const-string v4, "tip"

    invoke-static {v2, v3, v4}, Lcom/eyugame/game/MResource;->getIdByName(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v2

    invoke-virtual {v0, v2}, Landroid/app/AlertDialog$Builder;->setTitle(I)Landroid/app/AlertDialog$Builder;

    .line 151
    iget-object v2, p0, Lcom/eyugame/game/ActivityMain$1;->this$0:Lcom/eyugame/game/ActivityMain;

    invoke-virtual {v2}, Lcom/eyugame/game/ActivityMain;->getApplicationContext()Landroid/content/Context;

    move-result-object v2

    const-string v3, "string"

    const-string v4, "network_none"

    invoke-static {v2, v3, v4}, Lcom/eyugame/game/MResource;->getIdByName(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v2

    invoke-virtual {v0, v2}, Landroid/app/AlertDialog$Builder;->setMessage(I)Landroid/app/AlertDialog$Builder;

    .line 153
    iget-object v2, p0, Lcom/eyugame/game/ActivityMain$1;->this$0:Lcom/eyugame/game/ActivityMain;

    invoke-virtual {v2}, Lcom/eyugame/game/ActivityMain;->getApplicationContext()Landroid/content/Context;

    move-result-object v2

    const-string v3, "string"

    const-string v4, "confirm"

    invoke-static {v2, v3, v4}, Lcom/eyugame/game/MResource;->getIdByName(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v2

    new-instance v3, Lcom/eyugame/game/ActivityMain$1$1;

    invoke-direct {v3, p0}, Lcom/eyugame/game/ActivityMain$1$1;-><init>(Lcom/eyugame/game/ActivityMain$1;)V

    invoke-virtual {v0, v2, v3}, Landroid/app/AlertDialog$Builder;->setPositiveButton(ILandroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    .line 174
    iget-object v2, p0, Lcom/eyugame/game/ActivityMain$1;->this$0:Lcom/eyugame/game/ActivityMain;

    invoke-virtual {v2}, Lcom/eyugame/game/ActivityMain;->getApplicationContext()Landroid/content/Context;

    move-result-object v2

    const-string v3, "string"

    const-string v4, "cancel"

    invoke-static {v2, v3, v4}, Lcom/eyugame/game/MResource;->getIdByName(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v2

    new-instance v3, Lcom/eyugame/game/ActivityMain$1$2;

    invoke-direct {v3, p0}, Lcom/eyugame/game/ActivityMain$1$2;-><init>(Lcom/eyugame/game/ActivityMain$1;)V

    invoke-virtual {v0, v2, v3}, Landroid/app/AlertDialog$Builder;->setNegativeButton(ILandroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    .line 182
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->create()Landroid/app/AlertDialog;

    move-result-object v1

    .line 184
    .local v1, "noticeDialog":Landroid/app/AlertDialog;
    invoke-virtual {v1}, Landroid/app/AlertDialog;->show()V

    .line 185
    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Landroid/app/AlertDialog;->setCancelable(Z)V

    .line 186
    return-void
.end method
