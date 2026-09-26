.class Lcom/eyugame/game/ActivityMain$2;
.super Ljava/lang/Object;
.source "ActivityMain.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/eyugame/game/ActivityMain;->OnCopyProgressChanged(I)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/eyugame/game/ActivityMain;

.field final synthetic val$nProgress:I


# direct methods
.method constructor <init>(Lcom/eyugame/game/ActivityMain;I)V
    .locals 0
    .param p1, "this$0"    # Lcom/eyugame/game/ActivityMain;

    .prologue
    .line 316
    iput-object p1, p0, Lcom/eyugame/game/ActivityMain$2;->this$0:Lcom/eyugame/game/ActivityMain;

    iput p2, p0, Lcom/eyugame/game/ActivityMain$2;->val$nProgress:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 5

    .prologue
    .line 320
    iget-object v0, p0, Lcom/eyugame/game/ActivityMain$2;->this$0:Lcom/eyugame/game/ActivityMain;

    invoke-static {v0}, Lcom/eyugame/game/ActivityMain;->access$500(Lcom/eyugame/game/ActivityMain;)Landroid/widget/TextView;

    move-result-object v0

    iget-object v1, p0, Lcom/eyugame/game/ActivityMain$2;->this$0:Lcom/eyugame/game/ActivityMain;

    invoke-virtual {v1}, Lcom/eyugame/game/ActivityMain;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    iget-object v2, p0, Lcom/eyugame/game/ActivityMain$2;->this$0:Lcom/eyugame/game/ActivityMain;

    invoke-virtual {v2}, Lcom/eyugame/game/ActivityMain;->getApplicationContext()Landroid/content/Context;

    move-result-object v2

    const-string v3, "string"

    const-string v4, "unzip_res"

    invoke-static {v2, v3, v4}, Lcom/eyugame/game/MResource;->getIdByName(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v2

    invoke-virtual {v1, v2}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v1

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    iget v4, p0, Lcom/eyugame/game/ActivityMain$2;->val$nProgress:I

    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    aput-object v4, v2, v3

    invoke-static {v1, v2}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 321
    return-void
.end method
