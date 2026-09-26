.class Lcom/eyugame/base/CrashHandler$1;
.super Ljava/lang/Thread;
.source "CrashHandler.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/eyugame/base/CrashHandler;->handleException(Ljava/lang/Throwable;)Z
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/eyugame/base/CrashHandler;


# direct methods
.method constructor <init>(Lcom/eyugame/base/CrashHandler;)V
    .locals 0
    .param p1, "this$0"    # Lcom/eyugame/base/CrashHandler;

    .prologue
    .line 113
    iput-object p1, p0, Lcom/eyugame/base/CrashHandler$1;->this$0:Lcom/eyugame/base/CrashHandler;

    invoke-direct {p0}, Ljava/lang/Thread;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    .prologue
    .line 116
    invoke-static {}, Landroid/os/Looper;->prepare()V

    .line 117
    iget-object v0, p0, Lcom/eyugame/base/CrashHandler$1;->this$0:Lcom/eyugame/base/CrashHandler;

    invoke-static {v0}, Lcom/eyugame/base/CrashHandler;->access$000(Lcom/eyugame/base/CrashHandler;)Landroid/content/Context;

    move-result-object v0

    iget-object v1, p0, Lcom/eyugame/base/CrashHandler$1;->this$0:Lcom/eyugame/base/CrashHandler;

    invoke-static {v1}, Lcom/eyugame/base/CrashHandler;->access$000(Lcom/eyugame/base/CrashHandler;)Landroid/content/Context;

    move-result-object v1

    const-string v2, "string"

    const-string v3, "crash_tip"

    invoke-static {v1, v2, v3}, Lcom/eyugame/game/MResource;->getIdByName(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v1

    const/4 v2, 0x0

    invoke-static {v0, v1, v2}, Landroid/widget/Toast;->makeText(Landroid/content/Context;II)Landroid/widget/Toast;

    move-result-object v0

    invoke-virtual {v0}, Landroid/widget/Toast;->show()V

    .line 118
    invoke-static {}, Landroid/os/Looper;->loop()V

    .line 119
    return-void
.end method
