.class Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThreadManager;
.super Ljava/lang/Object;
.source "Cocos2dxGLSurfaceView.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "GLThreadManager"
.end annotation


# static fields
.field private static TAG:Ljava/lang/String; = null

.field private static final kADRENO:Ljava/lang/String; = "Adreno"

.field private static final kGLES_10:I = 0x10000

.field private static final kGLES_20:I = 0x20000

.field private static final kMSM7K_RENDERER_PREFIX:Ljava/lang/String; = "Q3Dimension MSM7500 "


# instance fields
.field private mEglOwner:Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;

.field private mGLESDriverCheckComplete:Z

.field private mGLESVersion:I

.field private mGLESVersionCheckComplete:Z

.field private mLimitedGLESContexts:Z

.field private mMultipleGLESContextsAllowed:Z


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 2022
    const-string v0, "GLThreadManager"

    sput-object v0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThreadManager;->TAG:Ljava/lang/String;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .prologue
    .line 2021
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$1;)V
    .locals 0
    .param p1, "x0"    # Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$1;

    .prologue
    .line 2021
    invoke-direct {p0}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThreadManager;-><init>()V

    return-void
.end method

.method private checkGLESVersion()V
    .locals 3

    .prologue
    const/4 v2, 0x1

    .line 2106
    iget-boolean v0, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThreadManager;->mGLESVersionCheckComplete:Z

    if-nez v0, :cond_1

    .line 2107
    const/high16 v0, 0x10000

    iput v0, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThreadManager;->mGLESVersion:I

    .line 2110
    iget v0, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThreadManager;->mGLESVersion:I

    const/high16 v1, 0x20000

    if-lt v0, v1, :cond_0

    .line 2111
    iput-boolean v2, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThreadManager;->mMultipleGLESContextsAllowed:Z

    .line 2117
    :cond_0
    iput-boolean v2, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThreadManager;->mGLESVersionCheckComplete:Z

    .line 2119
    :cond_1
    return-void
.end method


# virtual methods
.method public declared-synchronized checkGLDriver(Ljavax/microedition/khronos/opengles/GL10;)V
    .locals 5
    .param p1, "gl"    # Ljavax/microedition/khronos/opengles/GL10;

    .prologue
    const/4 v1, 0x0

    const/4 v2, 0x1

    .line 2087
    monitor-enter p0

    :try_start_0
    iget-boolean v3, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThreadManager;->mGLESDriverCheckComplete:Z

    if-nez v3, :cond_3

    .line 2088
    invoke-direct {p0}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThreadManager;->checkGLESVersion()V

    .line 2089
    const/16 v3, 0x1f01

    invoke-interface {p1, v3}, Ljavax/microedition/khronos/opengles/GL10;->glGetString(I)Ljava/lang/String;

    move-result-object v0

    .line 2090
    .local v0, "renderer":Ljava/lang/String;
    iget v3, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThreadManager;->mGLESVersion:I

    const/high16 v4, 0x20000

    if-ge v3, v4, :cond_0

    .line 2091
    const-string v3, "Q3Dimension MSM7500 "

    .line 2092
    invoke-virtual {v0, v3}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_4

    move v3, v2

    :goto_0
    iput-boolean v3, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThreadManager;->mMultipleGLESContextsAllowed:Z

    .line 2093
    invoke-virtual {p0}, Ljava/lang/Object;->notifyAll()V

    .line 2095
    :cond_0
    iget-boolean v3, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThreadManager;->mMultipleGLESContextsAllowed:Z

    if-eqz v3, :cond_1

    const-string v3, "Adreno"

    invoke-virtual {v0, v3}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_2

    :cond_1
    move v1, v2

    :cond_2
    iput-boolean v1, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThreadManager;->mLimitedGLESContexts:Z

    .line 2101
    const/4 v1, 0x1

    iput-boolean v1, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThreadManager;->mGLESDriverCheckComplete:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 2103
    .end local v0    # "renderer":Ljava/lang/String;
    :cond_3
    monitor-exit p0

    return-void

    .restart local v0    # "renderer":Ljava/lang/String;
    :cond_4
    move v3, v1

    .line 2092
    goto :goto_0

    .line 2087
    .end local v0    # "renderer":Ljava/lang/String;
    :catchall_0
    move-exception v1

    monitor-exit p0

    throw v1
.end method

.method public releaseEglContextLocked(Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;)V
    .locals 1
    .param p1, "thread"    # Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;

    .prologue
    .line 2068
    iget-object v0, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThreadManager;->mEglOwner:Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;

    if-ne v0, p1, :cond_0

    .line 2069
    const/4 v0, 0x0

    iput-object v0, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThreadManager;->mEglOwner:Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;

    .line 2071
    :cond_0
    invoke-virtual {p0}, Ljava/lang/Object;->notifyAll()V

    .line 2072
    return-void
.end method

.method public declared-synchronized shouldReleaseEGLContextWhenPausing()Z
    .locals 1

    .prologue
    .line 2078
    monitor-enter p0

    :try_start_0
    iget-boolean v0, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThreadManager;->mLimitedGLESContexts:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return v0

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public declared-synchronized shouldTerminateEGLWhenPausing()Z
    .locals 1

    .prologue
    .line 2082
    monitor-enter p0

    :try_start_0
    invoke-direct {p0}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThreadManager;->checkGLESVersion()V

    .line 2083
    iget-boolean v0, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThreadManager;->mMultipleGLESContextsAllowed:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-nez v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    monitor-exit p0

    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0

    .line 2082
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public declared-synchronized threadExiting(Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;)V
    .locals 1
    .param p1, "thread"    # Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;

    .prologue
    .line 2029
    monitor-enter p0

    const/4 v0, 0x1

    :try_start_0
    invoke-static {p1, v0}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->access$1702(Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;Z)Z

    .line 2030
    iget-object v0, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThreadManager;->mEglOwner:Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;

    if-ne v0, p1, :cond_0

    .line 2031
    const/4 v0, 0x0

    iput-object v0, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThreadManager;->mEglOwner:Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;

    .line 2033
    :cond_0
    invoke-virtual {p0}, Ljava/lang/Object;->notifyAll()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 2034
    monitor-exit p0

    return-void

    .line 2029
    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public tryAcquireEglContextLocked(Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;)Z
    .locals 2
    .param p1, "thread"    # Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;

    .prologue
    const/4 v0, 0x1

    .line 2044
    iget-object v1, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThreadManager;->mEglOwner:Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;

    if-eq v1, p1, :cond_0

    iget-object v1, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThreadManager;->mEglOwner:Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;

    if-nez v1, :cond_2

    .line 2045
    :cond_0
    iput-object p1, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThreadManager;->mEglOwner:Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;

    .line 2046
    invoke-virtual {p0}, Ljava/lang/Object;->notifyAll()V

    .line 2060
    :cond_1
    :goto_0
    return v0

    .line 2049
    :cond_2
    invoke-direct {p0}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThreadManager;->checkGLESVersion()V

    .line 2050
    iget-boolean v1, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThreadManager;->mMultipleGLESContextsAllowed:Z

    if-nez v1, :cond_1

    .line 2057
    iget-object v0, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThreadManager;->mEglOwner:Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;

    if-eqz v0, :cond_3

    .line 2058
    iget-object v0, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThreadManager;->mEglOwner:Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;

    invoke-virtual {v0}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->requestReleaseEglContextLocked()V

    .line 2060
    :cond_3
    const/4 v0, 0x0

    goto :goto_0
.end method
