.class Lcom/eyugame/game/ActivityMain$9;
.super Ljava/lang/Object;
.source "ActivityMain.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/eyugame/game/ActivityMain;->doReleaseFocus()V
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
    .line 576
    iput-object p1, p0, Lcom/eyugame/game/ActivityMain$9;->this$0:Lcom/eyugame/game/ActivityMain;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 5

    .prologue
    const/4 v4, 0x0

    .line 580
    iget-object v2, p0, Lcom/eyugame/game/ActivityMain$9;->this$0:Lcom/eyugame/game/ActivityMain;

    invoke-static {v2}, Lcom/eyugame/game/ActivityMain;->access$700(Lcom/eyugame/game/ActivityMain;)Lorg/cocos2dx/lib/Cocos2dxEditText;

    move-result-object v2

    const/4 v3, 0x4

    invoke-virtual {v2, v3}, Lorg/cocos2dx/lib/Cocos2dxEditText;->setVisibility(I)V

    .line 582
    iget-object v2, p0, Lcom/eyugame/game/ActivityMain$9;->this$0:Lcom/eyugame/game/ActivityMain;

    invoke-static {v2}, Lcom/eyugame/game/ActivityMain;->access$700(Lcom/eyugame/game/ActivityMain;)Lorg/cocos2dx/lib/Cocos2dxEditText;

    move-result-object v2

    invoke-virtual {v2}, Lorg/cocos2dx/lib/Cocos2dxEditText;->getText()Landroid/text/Editable;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v1

    .line 583
    .local v1, "strText":Ljava/lang/String;
    invoke-static {v1}, Lcom/eyugame/impt/RelayNative;->OnInputString(Ljava/lang/String;)V

    .line 586
    iget-object v2, p0, Lcom/eyugame/game/ActivityMain$9;->this$0:Lcom/eyugame/game/ActivityMain;

    const-string v3, "input_method"

    invoke-virtual {v2, v3}, Lcom/eyugame/game/ActivityMain;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/view/inputmethod/InputMethodManager;

    .line 587
    .local v0, "imm":Landroid/view/inputmethod/InputMethodManager;
    iget-object v2, p0, Lcom/eyugame/game/ActivityMain$9;->this$0:Lcom/eyugame/game/ActivityMain;

    invoke-static {v2}, Lcom/eyugame/game/ActivityMain;->access$700(Lcom/eyugame/game/ActivityMain;)Lorg/cocos2dx/lib/Cocos2dxEditText;

    move-result-object v2

    invoke-virtual {v2}, Lorg/cocos2dx/lib/Cocos2dxEditText;->getWindowToken()Landroid/os/IBinder;

    move-result-object v2

    invoke-virtual {v0, v2, v4}, Landroid/view/inputmethod/InputMethodManager;->hideSoftInputFromWindow(Landroid/os/IBinder;I)Z

    .line 589
    invoke-static {}, Lcom/eyugame/game/ActivityMain;->access$800()I

    move-result v2

    invoke-static {v4, v2}, Lcom/eyugame/impt/RelayNative;->OnKeyboardShow(ZI)V

    .line 590
    return-void
.end method
