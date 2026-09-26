.class final Lcom/eyugame/impt/RelayNative$1;
.super Ljava/lang/Object;
.source "RelayNative.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/eyugame/impt/RelayNative;->doInitSdk(Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation


# instance fields
.field final synthetic val$strInfo:Ljava/lang/String;


# direct methods
.method constructor <init>(Ljava/lang/String;)V
    .locals 0

    .prologue
    .line 197
    iput-object p1, p0, Lcom/eyugame/impt/RelayNative$1;->val$strInfo:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    .prologue
    .line 200
    invoke-static {}, Lcom/eyugame/impt/RelayNative;->access$000()Lcom/eyugame/game/ActivityMain;

    move-result-object v0

    invoke-virtual {v0}, Lcom/eyugame/game/ActivityMain;->GetSdkPlatform()Lcom/eyugame/base/ISdkPlatform;

    move-result-object v0

    invoke-static {}, Lcom/eyugame/impt/RelayNative;->access$000()Lcom/eyugame/game/ActivityMain;

    move-result-object v1

    iget-object v2, p0, Lcom/eyugame/impt/RelayNative$1;->val$strInfo:Ljava/lang/String;

    invoke-static {}, Lcom/eyugame/impt/RelayNative;->access$000()Lcom/eyugame/game/ActivityMain;

    move-result-object v3

    iget-object v3, v3, Lcom/eyugame/game/ActivityMain;->mSavedInstanceState:Landroid/os/Bundle;

    invoke-virtual {v0, v1, v2, v3}, Lcom/eyugame/base/ISdkPlatform;->initSDK(Landroid/app/Activity;Ljava/lang/String;Landroid/os/Bundle;)V

    .line 201
    return-void
.end method
