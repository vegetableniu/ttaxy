.class public Lcom/eyugame/base/NetworkStatus;
.super Ljava/lang/Object;
.source "NetworkStatus.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/eyugame/base/NetworkStatus$EYNetType;
    }
.end annotation


# instance fields
.field private sContext:Landroid/content/Context;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    .line 24
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 22
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/eyugame/base/NetworkStatus;->sContext:Landroid/content/Context;

    .line 25
    iput-object p1, p0, Lcom/eyugame/base/NetworkStatus;->sContext:Landroid/content/Context;

    .line 26
    return-void
.end method


# virtual methods
.method public getNetworkStatus()Lcom/eyugame/base/NetworkStatus$EYNetType;
    .locals 1

    sget-object v0, Lcom/eyugame/base/NetworkStatus$EYNetType;->EY_WIFI:Lcom/eyugame/base/NetworkStatus$EYNetType;

    return-object v0
.end method
