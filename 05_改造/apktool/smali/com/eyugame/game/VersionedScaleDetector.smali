.class public abstract Lcom/eyugame/game/VersionedScaleDetector;
.super Ljava/lang/Object;
.source "VersionedScaleDetector.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/eyugame/game/VersionedScaleDetector$EclairDetector;,
        Lcom/eyugame/game/VersionedScaleDetector$CupcakeDetector;,
        Lcom/eyugame/game/VersionedScaleDetector$IMyScaleEventListener;
    }
.end annotation


# instance fields
.field mListener:Lcom/eyugame/game/VersionedScaleDetector$IMyScaleEventListener;


# direct methods
.method public constructor <init>()V
    .locals 0

    .prologue
    .line 12
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 46
    return-void
.end method

.method public static newInstance(Lcom/eyugame/game/VersionedScaleDetector$IMyScaleEventListener;)Lcom/eyugame/game/VersionedScaleDetector;
    .locals 4
    .param p0, "listener"    # Lcom/eyugame/game/VersionedScaleDetector$IMyScaleEventListener;

    .prologue
    const/4 v3, 0x0

    .line 18
    sget-object v2, Landroid/os/Build$VERSION;->SDK:Ljava/lang/String;

    invoke-static {v2}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v1

    .line 20
    .local v1, "sdkVersion":I
    const/4 v0, 0x0

    .line 21
    .local v0, "detector":Lcom/eyugame/game/VersionedScaleDetector;
    const/4 v2, 0x5

    if-ge v1, v2, :cond_0

    .line 22
    new-instance v0, Lcom/eyugame/game/VersionedScaleDetector$CupcakeDetector;

    .end local v0    # "detector":Lcom/eyugame/game/VersionedScaleDetector;
    invoke-direct {v0, v3}, Lcom/eyugame/game/VersionedScaleDetector$CupcakeDetector;-><init>(Lcom/eyugame/game/VersionedScaleDetector$1;)V

    .line 28
    .restart local v0    # "detector":Lcom/eyugame/game/VersionedScaleDetector;
    :goto_0
    iput-object p0, v0, Lcom/eyugame/game/VersionedScaleDetector;->mListener:Lcom/eyugame/game/VersionedScaleDetector$IMyScaleEventListener;

    .line 29
    return-object v0

    .line 26
    :cond_0
    new-instance v0, Lcom/eyugame/game/VersionedScaleDetector$EclairDetector;

    .end local v0    # "detector":Lcom/eyugame/game/VersionedScaleDetector;
    invoke-direct {v0, v3}, Lcom/eyugame/game/VersionedScaleDetector$EclairDetector;-><init>(Lcom/eyugame/game/VersionedScaleDetector$1;)V

    .restart local v0    # "detector":Lcom/eyugame/game/VersionedScaleDetector;
    goto :goto_0
.end method


# virtual methods
.method public abstract onTouchEvent(Landroid/view/MotionEvent;)Z
.end method
