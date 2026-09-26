.class public Lcom/eyugame/game/LocalSdkPlatform;
.super Lcom/eyugame/base/ISdkPlatform;
.source "LocalSdkPlatform.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lcom/eyugame/base/ISdkPlatform;-><init>()V

    return-void
.end method


# virtual methods
.method public login(Ljava/lang/String;)I
    .locals 2
    .param p1, "strInfo"    # Ljava/lang/String;

    const/4 v0, -0x1

    const-string v1, "{\"code\":-1,\"message\":\"external login unsupported\"}"

    invoke-static {v0, v1}, Lcom/eyugame/impt/RelayNative;->OnLogin(ILjava/lang/String;)V

    return v0
.end method

.method public pay(Ljava/lang/String;)I
    .locals 2
    .param p1, "strInfo"    # Ljava/lang/String;

    const-string v0, "{\"code\":-1,\"ret\":false,\"reason\":\"external payment unsupported\"}"

    invoke-static {v0}, Lcom/eyugame/impt/RelayNative;->OnPay(Ljava/lang/String;)V

    const/4 v1, -0x1

    return v1
.end method
