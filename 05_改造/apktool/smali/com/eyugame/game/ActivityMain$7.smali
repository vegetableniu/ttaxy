.class Lcom/eyugame/game/ActivityMain$7;
.super Ljava/lang/Object;
.source "ActivityMain.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/eyugame/game/ActivityMain;->doSetFocus(Ljava/lang/String;II)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/eyugame/game/ActivityMain;

.field final synthetic val$nKeyboardType:I

.field final synthetic val$strText:Ljava/lang/String;


# direct methods
.method constructor <init>(Lcom/eyugame/game/ActivityMain;ILjava/lang/String;)V
    .locals 0
    .param p1, "this$0"    # Lcom/eyugame/game/ActivityMain;

    .prologue
    .line 517
    iput-object p1, p0, Lcom/eyugame/game/ActivityMain$7;->this$0:Lcom/eyugame/game/ActivityMain;

    iput p2, p0, Lcom/eyugame/game/ActivityMain$7;->val$nKeyboardType:I

    iput-object p3, p0, Lcom/eyugame/game/ActivityMain$7;->val$strText:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 5

    .prologue
    const/4 v4, 0x2

    const/4 v3, 0x1

    .line 520
    iget-object v1, p0, Lcom/eyugame/game/ActivityMain$7;->this$0:Lcom/eyugame/game/ActivityMain;

    invoke-static {v1}, Lcom/eyugame/game/ActivityMain;->access$700(Lcom/eyugame/game/ActivityMain;)Lorg/cocos2dx/lib/Cocos2dxEditText;

    move-result-object v1

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Lorg/cocos2dx/lib/Cocos2dxEditText;->setVisibility(I)V

    .line 522
    iget v1, p0, Lcom/eyugame/game/ActivityMain$7;->val$nKeyboardType:I

    if-ne v3, v1, :cond_0

    .line 523
    iget-object v1, p0, Lcom/eyugame/game/ActivityMain$7;->this$0:Lcom/eyugame/game/ActivityMain;

    invoke-static {v1}, Lcom/eyugame/game/ActivityMain;->access$700(Lcom/eyugame/game/ActivityMain;)Lorg/cocos2dx/lib/Cocos2dxEditText;

    move-result-object v1

    const/16 v2, 0x80

    invoke-virtual {v1, v2}, Lorg/cocos2dx/lib/Cocos2dxEditText;->setInputType(I)V

    .line 532
    :goto_0
    iget-object v1, p0, Lcom/eyugame/game/ActivityMain$7;->this$0:Lcom/eyugame/game/ActivityMain;

    invoke-static {v1}, Lcom/eyugame/game/ActivityMain;->access$700(Lcom/eyugame/game/ActivityMain;)Lorg/cocos2dx/lib/Cocos2dxEditText;

    move-result-object v1

    iget-object v2, p0, Lcom/eyugame/game/ActivityMain$7;->val$strText:Ljava/lang/String;

    invoke-virtual {v1, v2}, Lorg/cocos2dx/lib/Cocos2dxEditText;->setText(Ljava/lang/CharSequence;)V

    .line 533
    iget-object v1, p0, Lcom/eyugame/game/ActivityMain$7;->this$0:Lcom/eyugame/game/ActivityMain;

    invoke-static {v1}, Lcom/eyugame/game/ActivityMain;->access$700(Lcom/eyugame/game/ActivityMain;)Lorg/cocos2dx/lib/Cocos2dxEditText;

    move-result-object v1

    invoke-virtual {v1, v3}, Lorg/cocos2dx/lib/Cocos2dxEditText;->setFocusable(Z)V

    .line 534
    iget-object v1, p0, Lcom/eyugame/game/ActivityMain$7;->this$0:Lcom/eyugame/game/ActivityMain;

    invoke-static {v1}, Lcom/eyugame/game/ActivityMain;->access$700(Lcom/eyugame/game/ActivityMain;)Lorg/cocos2dx/lib/Cocos2dxEditText;

    move-result-object v1

    invoke-virtual {v1}, Lorg/cocos2dx/lib/Cocos2dxEditText;->requestFocus()Z

    .line 535
    iget-object v1, p0, Lcom/eyugame/game/ActivityMain$7;->this$0:Lcom/eyugame/game/ActivityMain;

    invoke-static {v1}, Lcom/eyugame/game/ActivityMain;->access$700(Lcom/eyugame/game/ActivityMain;)Lorg/cocos2dx/lib/Cocos2dxEditText;

    move-result-object v1

    iget-object v2, p0, Lcom/eyugame/game/ActivityMain$7;->val$strText:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->length()I

    move-result v2

    invoke-virtual {v1, v2}, Lorg/cocos2dx/lib/Cocos2dxEditText;->setSelection(I)V

    .line 538
    iget-object v1, p0, Lcom/eyugame/game/ActivityMain$7;->this$0:Lcom/eyugame/game/ActivityMain;

    const-string v2, "input_method"

    invoke-virtual {v1, v2}, Lcom/eyugame/game/ActivityMain;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/inputmethod/InputMethodManager;

    .line 539
    .local v0, "imm":Landroid/view/inputmethod/InputMethodManager;
    iget-object v1, p0, Lcom/eyugame/game/ActivityMain$7;->this$0:Lcom/eyugame/game/ActivityMain;

    invoke-static {v1}, Lcom/eyugame/game/ActivityMain;->access$700(Lcom/eyugame/game/ActivityMain;)Lorg/cocos2dx/lib/Cocos2dxEditText;

    move-result-object v1

    invoke-virtual {v0, v1, v4}, Landroid/view/inputmethod/InputMethodManager;->showSoftInput(Landroid/view/View;I)Z

    .line 540
    invoke-static {}, Lcom/eyugame/game/ActivityMain;->access$800()I

    move-result v1

    invoke-static {v3, v1}, Lcom/eyugame/impt/RelayNative;->OnKeyboardShow(ZI)V

    .line 541
    iget-object v1, p0, Lcom/eyugame/game/ActivityMain$7;->this$0:Lcom/eyugame/game/ActivityMain;

    invoke-static {v1}, Lcom/eyugame/game/ActivityMain;->access$700(Lcom/eyugame/game/ActivityMain;)Lorg/cocos2dx/lib/Cocos2dxEditText;

    move-result-object v1

    new-instance v2, Lcom/eyugame/game/ActivityMain$7$1;

    invoke-direct {v2, p0}, Lcom/eyugame/game/ActivityMain$7$1;-><init>(Lcom/eyugame/game/ActivityMain$7;)V

    invoke-virtual {v1, v2}, Lorg/cocos2dx/lib/Cocos2dxEditText;->setOnKeyListener(Landroid/view/View$OnKeyListener;)V

    .line 558
    return-void

    .line 525
    .end local v0    # "imm":Landroid/view/inputmethod/InputMethodManager;
    :cond_0
    iget v1, p0, Lcom/eyugame/game/ActivityMain$7;->val$nKeyboardType:I

    if-eq v4, v1, :cond_1

    const/4 v1, 0x3

    iget v2, p0, Lcom/eyugame/game/ActivityMain$7;->val$nKeyboardType:I

    if-ne v1, v2, :cond_2

    .line 526
    :cond_1
    iget-object v1, p0, Lcom/eyugame/game/ActivityMain$7;->this$0:Lcom/eyugame/game/ActivityMain;

    invoke-static {v1}, Lcom/eyugame/game/ActivityMain;->access$700(Lcom/eyugame/game/ActivityMain;)Lorg/cocos2dx/lib/Cocos2dxEditText;

    move-result-object v1

    invoke-virtual {v1, v4}, Lorg/cocos2dx/lib/Cocos2dxEditText;->setInputType(I)V

    goto :goto_0

    .line 529
    :cond_2
    iget-object v1, p0, Lcom/eyugame/game/ActivityMain$7;->this$0:Lcom/eyugame/game/ActivityMain;

    invoke-static {v1}, Lcom/eyugame/game/ActivityMain;->access$700(Lcom/eyugame/game/ActivityMain;)Lorg/cocos2dx/lib/Cocos2dxEditText;

    move-result-object v1

    invoke-virtual {v1, v3}, Lorg/cocos2dx/lib/Cocos2dxEditText;->setInputType(I)V

    goto :goto_0
.end method
