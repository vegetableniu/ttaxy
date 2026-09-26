.class Lcom/eyugame/game/VersionedScaleDetector$CupcakeDetector;
.super Lcom/eyugame/game/VersionedScaleDetector;
.source "VersionedScaleDetector.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/eyugame/game/VersionedScaleDetector;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "CupcakeDetector"
.end annotation


# direct methods
.method private constructor <init>()V
    .locals 0

    .prologue
    .line 38
    invoke-direct {p0}, Lcom/eyugame/game/VersionedScaleDetector;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/eyugame/game/VersionedScaleDetector$1;)V
    .locals 0
    .param p1, "x0"    # Lcom/eyugame/game/VersionedScaleDetector$1;

    .prologue
    .line 38
    invoke-direct {p0}, Lcom/eyugame/game/VersionedScaleDetector$CupcakeDetector;-><init>()V

    return-void
.end method


# virtual methods
.method public onTouchEvent(Landroid/view/MotionEvent;)Z
    .locals 1
    .param p1, "ev"    # Landroid/view/MotionEvent;

    .prologue
    .line 42
    const/4 v0, 0x1

    return v0
.end method
