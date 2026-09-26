.class Lcom/eyugame/game/VersionedScaleDetector$EclairDetector;
.super Lcom/eyugame/game/VersionedScaleDetector$CupcakeDetector;
.source "VersionedScaleDetector.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/eyugame/game/VersionedScaleDetector;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "EclairDetector"
.end annotation


# instance fields
.field mLastDistence:I

.field private mPointMidX:F

.field private mPointMidY:F

.field mbScale:Z


# direct methods
.method private constructor <init>()V
    .locals 1

    .prologue
    .line 46
    const/4 v0, 0x0

    invoke-direct {p0, v0}, Lcom/eyugame/game/VersionedScaleDetector$CupcakeDetector;-><init>(Lcom/eyugame/game/VersionedScaleDetector$1;)V

    return-void
.end method

.method synthetic constructor <init>(Lcom/eyugame/game/VersionedScaleDetector$1;)V
    .locals 0
    .param p1, "x0"    # Lcom/eyugame/game/VersionedScaleDetector$1;

    .prologue
    .line 46
    invoke-direct {p0}, Lcom/eyugame/game/VersionedScaleDetector$EclairDetector;-><init>()V

    return-void
.end method


# virtual methods
.method public onTouchEvent(Landroid/view/MotionEvent;)Z
    .locals 10
    .param p1, "ev"    # Landroid/view/MotionEvent;

    .prologue
    const/high16 v3, 0x40000000    # 2.0f

    const/4 v2, 0x0

    const-wide/high16 v8, 0x4000000000000000L    # 2.0

    const/4 v4, 0x1

    .line 58
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getAction()I

    move-result v1

    and-int/lit16 v1, v1, 0xff

    packed-switch v1, :pswitch_data_0

    .line 108
    :cond_0
    :goto_0
    :pswitch_0
    invoke-super {p0, p1}, Lcom/eyugame/game/VersionedScaleDetector$CupcakeDetector;->onTouchEvent(Landroid/view/MotionEvent;)Z

    move-result v1

    return v1

    .line 63
    :pswitch_1
    iput-boolean v2, p0, Lcom/eyugame/game/VersionedScaleDetector$EclairDetector;->mbScale:Z

    goto :goto_0

    .line 67
    :pswitch_2
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getPointerCount()I

    move-result v1

    if-ne v1, v4, :cond_1

    .line 68
    iput-boolean v2, p0, Lcom/eyugame/game/VersionedScaleDetector$EclairDetector;->mbScale:Z

    .line 70
    :cond_1
    iget-boolean v1, p0, Lcom/eyugame/game/VersionedScaleDetector$EclairDetector;->mbScale:Z

    if-eqz v1, :cond_0

    .line 73
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getX()F

    move-result v1

    invoke-virtual {p1, v4}, Landroid/view/MotionEvent;->getX(I)F

    move-result v2

    sub-float/2addr v1, v2

    invoke-static {v1}, Ljava/lang/Math;->abs(F)F

    move-result v1

    float-to-double v2, v1

    .line 72
    invoke-static {v2, v3, v8, v9}, Ljava/lang/Math;->pow(DD)D

    move-result-wide v2

    .line 74
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getY()F

    move-result v1

    invoke-virtual {p1, v4}, Landroid/view/MotionEvent;->getY(I)F

    move-result v4

    sub-float/2addr v1, v4

    invoke-static {v1}, Ljava/lang/Math;->abs(F)F

    move-result v1

    float-to-double v4, v1

    invoke-static {v4, v5, v8, v9}, Ljava/lang/Math;->pow(DD)D

    move-result-wide v4

    add-double/2addr v2, v4

    .line 72
    invoke-static {v2, v3}, Ljava/lang/Math;->sqrt(D)D

    move-result-wide v2

    double-to-int v7, v2

    .line 76
    .local v7, "nowDistence":I
    iget v1, p0, Lcom/eyugame/game/VersionedScaleDetector$EclairDetector;->mLastDistence:I

    sub-int v0, v1, v7

    .line 77
    .local v0, "dDistence":I
    iget v1, p0, Lcom/eyugame/game/VersionedScaleDetector$EclairDetector;->mLastDistence:I

    if-eqz v1, :cond_2

    if-eqz v0, :cond_2

    .line 79
    iget-object v1, p0, Lcom/eyugame/game/VersionedScaleDetector$EclairDetector;->mListener:Lcom/eyugame/game/VersionedScaleDetector$IMyScaleEventListener;

    iget v2, p0, Lcom/eyugame/game/VersionedScaleDetector$EclairDetector;->mPointMidX:F

    iget v3, p0, Lcom/eyugame/game/VersionedScaleDetector$EclairDetector;->mPointMidY:F

    .line 80
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getEventTime()J

    move-result-wide v4

    div-int/lit8 v6, v0, 0x64

    int-to-float v6, v6

    .line 79
    invoke-interface/range {v1 .. v6}, Lcom/eyugame/game/VersionedScaleDetector$IMyScaleEventListener;->onScale(FFJF)V

    .line 82
    :cond_2
    iput v7, p0, Lcom/eyugame/game/VersionedScaleDetector$EclairDetector;->mLastDistence:I

    goto :goto_0

    .line 89
    .end local v0    # "dDistence":I
    .end local v7    # "nowDistence":I
    :pswitch_3
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getX()F

    move-result v1

    invoke-virtual {p1, v4}, Landroid/view/MotionEvent;->getX(I)F

    move-result v2

    add-float/2addr v1, v2

    div-float/2addr v1, v3

    iput v1, p0, Lcom/eyugame/game/VersionedScaleDetector$EclairDetector;->mPointMidX:F

    .line 90
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getY()F

    move-result v1

    invoke-virtual {p1, v4}, Landroid/view/MotionEvent;->getY(I)F

    move-result v2

    add-float/2addr v1, v2

    div-float/2addr v1, v3

    iput v1, p0, Lcom/eyugame/game/VersionedScaleDetector$EclairDetector;->mPointMidY:F

    .line 91
    iput-boolean v4, p0, Lcom/eyugame/game/VersionedScaleDetector$EclairDetector;->mbScale:Z

    .line 93
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getX()F

    move-result v1

    invoke-virtual {p1, v4}, Landroid/view/MotionEvent;->getX(I)F

    move-result v2

    sub-float/2addr v1, v2

    invoke-static {v1}, Ljava/lang/Math;->abs(F)F

    move-result v1

    float-to-double v2, v1

    .line 92
    invoke-static {v2, v3, v8, v9}, Ljava/lang/Math;->pow(DD)D

    move-result-wide v2

    .line 94
    invoke-virtual {p1}, Landroid/view/MotionEvent;->getY()F

    move-result v1

    invoke-virtual {p1, v4}, Landroid/view/MotionEvent;->getY(I)F

    move-result v4

    sub-float/2addr v1, v4

    invoke-static {v1}, Ljava/lang/Math;->abs(F)F

    move-result v1

    float-to-double v4, v1

    invoke-static {v4, v5, v8, v9}, Ljava/lang/Math;->pow(DD)D

    move-result-wide v4

    add-double/2addr v2, v4

    .line 92
    invoke-static {v2, v3}, Ljava/lang/Math;->sqrt(D)D

    move-result-wide v2

    double-to-int v7, v2

    .line 95
    .restart local v7    # "nowDistence":I
    iput v7, p0, Lcom/eyugame/game/VersionedScaleDetector$EclairDetector;->mLastDistence:I

    goto/16 :goto_0

    .line 100
    .end local v7    # "nowDistence":I
    :pswitch_4
    iput-boolean v2, p0, Lcom/eyugame/game/VersionedScaleDetector$EclairDetector;->mbScale:Z

    .line 101
    iput v2, p0, Lcom/eyugame/game/VersionedScaleDetector$EclairDetector;->mLastDistence:I

    goto/16 :goto_0

    .line 58
    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
        :pswitch_1
        :pswitch_2
        :pswitch_0
        :pswitch_0
        :pswitch_3
        :pswitch_4
    .end packed-switch
.end method
