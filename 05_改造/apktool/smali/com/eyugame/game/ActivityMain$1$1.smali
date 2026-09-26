.class Lcom/eyugame/game/ActivityMain$1$1;
.super Ljava/lang/Object;
.source "ActivityMain.java"

# interfaces
.implements Landroid/content/DialogInterface$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/eyugame/game/ActivityMain$1;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/eyugame/game/ActivityMain$1;


# direct methods
.method constructor <init>(Lcom/eyugame/game/ActivityMain$1;)V
    .locals 0
    .param p1, "this$1"    # Lcom/eyugame/game/ActivityMain$1;

    .prologue
    .line 153
    iput-object p1, p0, Lcom/eyugame/game/ActivityMain$1$1;->this$1:Lcom/eyugame/game/ActivityMain$1;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/content/DialogInterface;I)V
    .locals 4
    .param p1, "dialog"    # Landroid/content/DialogInterface;
    .param p2, "which"    # I

    .prologue
    .line 157
    invoke-interface {p1}, Landroid/content/DialogInterface;->dismiss()V

    .line 159
    const/4 v1, 0x0

    .line 161
    .local v1, "intent":Landroid/content/Intent;
    sget v2, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v3, 0xa

    if-le v2, v3, :cond_0

    .line 162
    new-instance v1, Landroid/content/Intent;

    .end local v1    # "intent":Landroid/content/Intent;
    const-string v2, "android.settings.WIRELESS_SETTINGS"

    invoke-direct {v1, v2}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 169
    .restart local v1    # "intent":Landroid/content/Intent;
    :goto_0
    invoke-static {}, Lcom/eyugame/game/ActivityMain;->access$000()Lcom/eyugame/game/ActivityMain;

    move-result-object v2

    invoke-virtual {v2, v1}, Lcom/eyugame/game/ActivityMain;->startActivity(Landroid/content/Intent;)V

    .line 170
    invoke-static {}, Lcom/eyugame/impt/RelayNative;->doExit()V

    .line 171
    return-void

    .line 164
    :cond_0
    new-instance v1, Landroid/content/Intent;

    .end local v1    # "intent":Landroid/content/Intent;
    invoke-direct {v1}, Landroid/content/Intent;-><init>()V

    .line 165
    .restart local v1    # "intent":Landroid/content/Intent;
    new-instance v0, Landroid/content/ComponentName;

    const-string v2, "com.android.settings"

    const-string v3, "com.android.settings.WirelessSettings"

    invoke-direct {v0, v2, v3}, Landroid/content/ComponentName;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    .line 166
    .local v0, "component":Landroid/content/ComponentName;
    invoke-virtual {v1, v0}, Landroid/content/Intent;->setComponent(Landroid/content/ComponentName;)Landroid/content/Intent;

    .line 167
    const-string v2, "android.intent.action.VIEW"

    invoke-virtual {v1, v2}, Landroid/content/Intent;->setAction(Ljava/lang/String;)Landroid/content/Intent;

    goto :goto_0
.end method
