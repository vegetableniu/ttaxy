.class Lcom/eyugame/game/ActivityMain$10$2;
.super Ljava/lang/Object;
.source "ActivityMain.java"

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/eyugame/game/ActivityMain$10;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/eyugame/game/ActivityMain$10;


# direct methods
.method constructor <init>(Lcom/eyugame/game/ActivityMain$10;)V
    .locals 0
    .param p1, "this$1"    # Lcom/eyugame/game/ActivityMain$10;

    .prologue
    .line 615
    iput-object p1, p0, Lcom/eyugame/game/ActivityMain$10$2;->this$1:Lcom/eyugame/game/ActivityMain$10;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 0
    .param p1, "dialog"    # Landroid/content/DialogInterface;
    .param p2, "which"    # I

    .prologue
    .line 618
    invoke-interface {p1}, Landroid/content/DialogInterface;->dismiss()V

    .line 619
    return-void
.end method
