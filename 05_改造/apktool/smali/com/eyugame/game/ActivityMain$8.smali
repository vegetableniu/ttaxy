.class Lcom/eyugame/game/ActivityMain$8;
.super Ljava/lang/Object;
.source "ActivityMain.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/eyugame/game/ActivityMain;->doEditChgPos(IIII)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/eyugame/game/ActivityMain;

.field final synthetic val$nHeight:I

.field final synthetic val$nL:I

.field final synthetic val$nT:I

.field final synthetic val$nWidth:I


# direct methods
.method constructor <init>(Lcom/eyugame/game/ActivityMain;IIII)V
    .locals 0
    .param p1, "this$0"    # Lcom/eyugame/game/ActivityMain;

    .prologue
    .line 564
    iput-object p1, p0, Lcom/eyugame/game/ActivityMain$8;->this$0:Lcom/eyugame/game/ActivityMain;

    iput p2, p0, Lcom/eyugame/game/ActivityMain$8;->val$nL:I

    iput p3, p0, Lcom/eyugame/game/ActivityMain$8;->val$nT:I

    iput p4, p0, Lcom/eyugame/game/ActivityMain$8;->val$nWidth:I

    iput p5, p0, Lcom/eyugame/game/ActivityMain$8;->val$nHeight:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 6

    .prologue
    .line 567
    iget-object v0, p0, Lcom/eyugame/game/ActivityMain$8;->this$0:Lcom/eyugame/game/ActivityMain;

    invoke-static {v0}, Lcom/eyugame/game/ActivityMain;->access$700(Lcom/eyugame/game/ActivityMain;)Lorg/cocos2dx/lib/Cocos2dxEditText;

    move-result-object v0

    iget v1, p0, Lcom/eyugame/game/ActivityMain$8;->val$nL:I

    iget v2, p0, Lcom/eyugame/game/ActivityMain$8;->val$nT:I

    iget v3, p0, Lcom/eyugame/game/ActivityMain$8;->val$nL:I

    iget v4, p0, Lcom/eyugame/game/ActivityMain$8;->val$nWidth:I

    add-int/2addr v3, v4

    iget v4, p0, Lcom/eyugame/game/ActivityMain$8;->val$nT:I

    iget v5, p0, Lcom/eyugame/game/ActivityMain$8;->val$nHeight:I

    add-int/2addr v4, v5

    invoke-virtual {v0, v1, v2, v3, v4}, Lorg/cocos2dx/lib/Cocos2dxEditText;->layout(IIII)V

    .line 569
    return-void
.end method
