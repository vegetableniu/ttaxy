.class public Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;
.super Landroid/view/SurfaceView;
.source "Cocos2dxGLSurfaceView.java"

# interfaces
.implements Landroid/view/SurfaceHolder$Callback;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThreadManager;,
        Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$LogWriter;,
        Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;,
        Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$EglHelper;,
        Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$SimpleEGLConfigChooser;,
        Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$ComponentSizeChooser;,
        Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$BaseConfigChooser;,
        Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$EGLConfigChooser;,
        Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$DefaultWindowSurfaceFactory;,
        Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$EGLWindowSurfaceFactory;,
        Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$DefaultContextFactory;,
        Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$EGLContextFactory;,
        Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$Renderer;,
        Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLWrapper;,
        Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$KeybordHandler;
    }
.end annotation


# static fields
.field public static final DEBUG_CHECK_GL_ERROR:I = 0x1

.field public static final DEBUG_LOG_GL_CALLS:I = 0x2

.field private static final DRAW_TWICE_AFTER_SIZE_CHANGED:Z = true

.field private static final HANDLER_CLOSE_IME_KEYBOARD:I = 0x3

.field private static final HANDLER_OPEN_IME_KEYBOARD:I = 0x2

.field private static final LOG_ATTACH_DETACH:Z = false

.field private static final LOG_EGL:Z = false

.field private static final LOG_PAUSE_RESUME:Z = false

.field private static final LOG_RENDERER:Z = false

.field private static final LOG_RENDERER_DRAW_FRAME:Z = false

.field private static final LOG_SURFACE:Z = false

.field private static final LOG_THREADS:Z = false

.field public static final RENDERMODE_CONTINUOUSLY:I = 0x1

.field public static final RENDERMODE_WHEN_DIRTY:I

.field private static final TAG:Ljava/lang/String;

.field private static mCocos2dxGLSurfaceView:Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;

.field private static sCocos2dxTextInputWraper:Lorg/cocos2dx/lib/Cocos2dxTextInputWraper;

.field private static final sGLThreadManager:Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThreadManager;

.field private static sHandler:Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$KeybordHandler;


# instance fields
.field private mCocos2dxEditText:Lorg/cocos2dx/lib/Cocos2dxEditText;

.field private mCocos2dxRenderer:Lorg/cocos2dx/lib/Cocos2dxRenderer;

.field private mDebugFlags:I

.field private mDetached:Z

.field private mEGLConfigChooser:Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$EGLConfigChooser;

.field private mEGLContextClientVersion:I

.field private mEGLContextFactory:Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$EGLContextFactory;

.field private mEGLWindowSurfaceFactory:Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$EGLWindowSurfaceFactory;

.field private mGLThread:Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;

.field private mGLWrapper:Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLWrapper;

.field private mPreserveEGLContextOnPause:Z

.field private mRenderer:Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$Renderer;

.field private mSizeChanged:Z


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .prologue
    const/4 v1, 0x0

    .line 171
    const-class v0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;

    invoke-virtual {v0}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->TAG:Ljava/lang/String;

    .line 176
    sput-object v1, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->sHandler:Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$KeybordHandler;

    .line 2134
    new-instance v0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThreadManager;

    invoke-direct {v0, v1}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThreadManager;-><init>(Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$1;)V

    sput-object v0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->sGLThreadManager:Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThreadManager;

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    .line 275
    invoke-direct {p0, p1}, Landroid/view/SurfaceView;-><init>(Landroid/content/Context;)V

    .line 2135
    const/4 v0, 0x1

    iput-boolean v0, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->mSizeChanged:Z

    .line 277
    invoke-direct {p0}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->init()V

    .line 279
    const/4 v0, 0x2

    invoke-virtual {p0, v0}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->setEGLContextClientVersion(I)V

    .line 281
    invoke-virtual {p0}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->initView()V

    .line 282
    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;
    .param p2, "attrs"    # Landroid/util/AttributeSet;

    .prologue
    .line 289
    invoke-direct {p0, p1, p2}, Landroid/view/SurfaceView;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    .line 2135
    const/4 v0, 0x1

    iput-boolean v0, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->mSizeChanged:Z

    .line 291
    invoke-direct {p0}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->init()V

    .line 293
    const/4 v0, 0x2

    invoke-virtual {p0, v0}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->setEGLContextClientVersion(I)V

    .line 295
    invoke-virtual {p0}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->initView()V

    .line 296
    return-void
.end method

.method static synthetic access$000(Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;)Lorg/cocos2dx/lib/Cocos2dxEditText;
    .locals 1
    .param p0, "x0"    # Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;

    .prologue
    .line 170
    iget-object v0, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->mCocos2dxEditText:Lorg/cocos2dx/lib/Cocos2dxEditText;

    return-object v0
.end method

.method static synthetic access$100()Lorg/cocos2dx/lib/Cocos2dxTextInputWraper;
    .locals 1

    .prologue
    .line 170
    sget-object v0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->sCocos2dxTextInputWraper:Lorg/cocos2dx/lib/Cocos2dxTextInputWraper;

    return-object v0
.end method

.method static synthetic access$1000(Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;)Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$EGLWindowSurfaceFactory;
    .locals 1
    .param p0, "x0"    # Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;

    .prologue
    .line 170
    iget-object v0, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->mEGLWindowSurfaceFactory:Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$EGLWindowSurfaceFactory;

    return-object v0
.end method

.method static synthetic access$1100(Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;)Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLWrapper;
    .locals 1
    .param p0, "x0"    # Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;

    .prologue
    .line 170
    iget-object v0, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->mGLWrapper:Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLWrapper;

    return-object v0
.end method

.method static synthetic access$1200(Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;)I
    .locals 1
    .param p0, "x0"    # Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;

    .prologue
    .line 170
    iget v0, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->mDebugFlags:I

    return v0
.end method

.method static synthetic access$1300()Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThreadManager;
    .locals 1

    .prologue
    .line 170
    sget-object v0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->sGLThreadManager:Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThreadManager;

    return-object v0
.end method

.method static synthetic access$1400(Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;)Z
    .locals 1
    .param p0, "x0"    # Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;

    .prologue
    .line 170
    iget-boolean v0, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->mPreserveEGLContextOnPause:Z

    return v0
.end method

.method static synthetic access$1500(Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;)Z
    .locals 1
    .param p0, "x0"    # Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;

    .prologue
    .line 170
    iget-boolean v0, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->mSizeChanged:Z

    return v0
.end method

.method static synthetic access$1502(Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;Z)Z
    .locals 0
    .param p0, "x0"    # Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;
    .param p1, "x1"    # Z

    .prologue
    .line 170
    iput-boolean p1, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->mSizeChanged:Z

    return p1
.end method

.method static synthetic access$1600(Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;)Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;
    .locals 1
    .param p0, "x0"    # Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;

    .prologue
    .line 170
    iget-object v0, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->mGLThread:Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;

    return-object v0
.end method

.method static synthetic access$200()Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;
    .locals 1

    .prologue
    .line 170
    sget-object v0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->mCocos2dxGLSurfaceView:Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;

    return-object v0
.end method

.method static synthetic access$500(Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;)Lorg/cocos2dx/lib/Cocos2dxRenderer;
    .locals 1
    .param p0, "x0"    # Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;

    .prologue
    .line 170
    iget-object v0, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->mCocos2dxRenderer:Lorg/cocos2dx/lib/Cocos2dxRenderer;

    return-object v0
.end method

.method static synthetic access$600(Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;)I
    .locals 1
    .param p0, "x0"    # Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;

    .prologue
    .line 170
    iget v0, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->mEGLContextClientVersion:I

    return v0
.end method

.method static synthetic access$700()Ljava/lang/String;
    .locals 1

    .prologue
    .line 170
    sget-object v0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->TAG:Ljava/lang/String;

    return-object v0
.end method

.method static synthetic access$800(Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;)Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$EGLConfigChooser;
    .locals 1
    .param p0, "x0"    # Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;

    .prologue
    .line 170
    iget-object v0, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->mEGLConfigChooser:Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$EGLConfigChooser;

    return-object v0
.end method

.method static synthetic access$900(Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;)Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$EGLContextFactory;
    .locals 1
    .param p0, "x0"    # Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;

    .prologue
    .line 170
    iget-object v0, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->mEGLContextFactory:Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$EGLContextFactory;

    return-object v0
.end method

.method private checkRenderThreadState()V
    .locals 2

    .prologue
    .line 2015
    iget-object v0, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->mGLThread:Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;

    if-eqz v0, :cond_0

    .line 2016
    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "setRenderer has already been called for this instance."

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 2019
    :cond_0
    return-void
.end method

.method public static closeIMEKeyboard()V
    .locals 2

    .prologue
    .line 857
    new-instance v0, Landroid/os/Message;

    invoke-direct {v0}, Landroid/os/Message;-><init>()V

    .line 858
    .local v0, "msg":Landroid/os/Message;
    const/4 v1, 0x3

    iput v1, v0, Landroid/os/Message;->what:I

    .line 859
    sget-object v1, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->sHandler:Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$KeybordHandler;

    invoke-virtual {v1, v0}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$KeybordHandler;->sendMessage(Landroid/os/Message;)Z

    .line 860
    return-void
.end method

.method private static dumpMotionEvent(Landroid/view/MotionEvent;)V
    .locals 9
    .param p0, "event"    # Landroid/view/MotionEvent;

    .prologue
    const/4 v8, 0x6

    const/4 v7, 0x5

    .line 882
    const/16 v5, 0xa

    new-array v3, v5, [Ljava/lang/String;

    const/4 v5, 0x0

    const-string v6, "DOWN"

    aput-object v6, v3, v5

    const/4 v5, 0x1

    const-string v6, "UP"

    aput-object v6, v3, v5

    const/4 v5, 0x2

    const-string v6, "MOVE"

    aput-object v6, v3, v5

    const/4 v5, 0x3

    const-string v6, "CANCEL"

    aput-object v6, v3, v5

    const/4 v5, 0x4

    const-string v6, "OUTSIDE"

    aput-object v6, v3, v5

    const-string v5, "POINTER_DOWN"

    aput-object v5, v3, v7

    const-string v5, "POINTER_UP"

    aput-object v5, v3, v8

    const/4 v5, 0x7

    const-string v6, "7?"

    aput-object v6, v3, v5

    const/16 v5, 0x8

    const-string v6, "8?"

    aput-object v6, v3, v5

    const/16 v5, 0x9

    const-string v6, "9?"

    aput-object v6, v3, v5

    .line 883
    .local v3, "names":[Ljava/lang/String;
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    .line 884
    .local v4, "sb":Ljava/lang/StringBuilder;
    invoke-virtual {p0}, Landroid/view/MotionEvent;->getAction()I

    move-result v0

    .line 885
    .local v0, "action":I
    and-int/lit16 v1, v0, 0xff

    .line 886
    .local v1, "actionCode":I
    const-string v5, "event ACTION_"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    aget-object v6, v3, v1

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 887
    if-eq v1, v7, :cond_0

    if-ne v1, v8, :cond_1

    .line 888
    :cond_0
    const-string v5, "(pid "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    shr-int/lit8 v6, v0, 0x8

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    .line 889
    const-string v5, ")"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 891
    :cond_1
    const-string v5, "["

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 892
    const/4 v2, 0x0

    .local v2, "i":I
    :goto_0
    invoke-virtual {p0}, Landroid/view/MotionEvent;->getPointerCount()I

    move-result v5

    if-ge v2, v5, :cond_3

    .line 893
    const-string v5, "#"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    .line 894
    const-string v5, "(pid "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {p0, v2}, Landroid/view/MotionEvent;->getPointerId(I)I

    move-result v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    .line 895
    const-string v5, ")="

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {p0, v2}, Landroid/view/MotionEvent;->getX(I)F

    move-result v6

    float-to-int v6, v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    .line 896
    const-string v5, ","

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {p0, v2}, Landroid/view/MotionEvent;->getY(I)F

    move-result v6

    float-to-int v6, v6

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    .line 897
    add-int/lit8 v5, v2, 0x1

    invoke-virtual {p0}, Landroid/view/MotionEvent;->getPointerCount()I

    move-result v6

    if-ge v5, v6, :cond_2

    .line 898
    const-string v5, ";"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 892
    :cond_2
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 901
    :cond_3
    const-string v5, "]"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 902
    sget-object v5, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->TAG:Ljava/lang/String;

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    invoke-static {v5, v6}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 903
    return-void
.end method

.method private getContentText()Ljava/lang/String;
    .locals 1

    .prologue
    .line 331
    iget-object v0, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->mCocos2dxRenderer:Lorg/cocos2dx/lib/Cocos2dxRenderer;

    invoke-virtual {v0}, Lorg/cocos2dx/lib/Cocos2dxRenderer;->getContentText()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method private init()V
    .locals 2

    .prologue
    .line 301
    invoke-virtual {p0}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->getHolder()Landroid/view/SurfaceHolder;

    move-result-object v0

    .line 302
    .local v0, "holder":Landroid/view/SurfaceHolder;
    invoke-interface {v0, p0}, Landroid/view/SurfaceHolder;->addCallback(Landroid/view/SurfaceHolder$Callback;)V

    .line 305
    const/4 v1, 0x4

    invoke-interface {v0, v1}, Landroid/view/SurfaceHolder;->setFormat(I)V

    .line 309
    const/4 v1, 0x2

    invoke-interface {v0, v1}, Landroid/view/SurfaceHolder;->setType(I)V

    .line 310
    return-void
.end method

.method public static openIMEKeyboard()V
    .locals 2

    .prologue
    .line 850
    new-instance v0, Landroid/os/Message;

    invoke-direct {v0}, Landroid/os/Message;-><init>()V

    .line 851
    .local v0, "msg":Landroid/os/Message;
    const/4 v1, 0x2

    iput v1, v0, Landroid/os/Message;->what:I

    .line 852
    sget-object v1, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->mCocos2dxGLSurfaceView:Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;

    invoke-direct {v1}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->getContentText()Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Landroid/os/Message;->obj:Ljava/lang/Object;

    .line 853
    sget-object v1, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->sHandler:Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$KeybordHandler;

    invoke-virtual {v1, v0}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$KeybordHandler;->sendMessage(Landroid/os/Message;)Z

    .line 854
    return-void
.end method


# virtual methods
.method public deleteBackward()V
    .locals 1

    .prologue
    .line 872
    new-instance v0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$10;

    invoke-direct {v0, p0}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$10;-><init>(Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;)V

    invoke-virtual {p0, v0}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->queueEvent(Ljava/lang/Runnable;)V

    .line 878
    return-void
.end method

.method public getCocos2dxEditText()Lorg/cocos2dx/lib/Cocos2dxEditText;
    .locals 1

    .prologue
    .line 335
    iget-object v0, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->mCocos2dxEditText:Lorg/cocos2dx/lib/Cocos2dxEditText;

    return-object v0
.end method

.method public getDebugFlags()I
    .locals 1

    .prologue
    .line 382
    iget v0, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->mDebugFlags:I

    return v0
.end method

.method public getPreserveEGLContextOnPause()Z
    .locals 1

    .prologue
    .line 411
    iget-boolean v0, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->mPreserveEGLContextOnPause:Z

    return v0
.end method

.method public getRenderMode()I
    .locals 1

    .prologue
    .line 598
    iget-object v0, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->mGLThread:Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;

    invoke-virtual {v0}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->getRenderMode()I

    move-result v0

    return v0
.end method

.method protected initView()V
    .locals 1

    .prologue
    .line 313
    const/4 v0, 0x1

    invoke-virtual {p0, v0}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->setFocusableInTouchMode(Z)V

    .line 315
    sput-object p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->mCocos2dxGLSurfaceView:Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;

    .line 316
    new-instance v0, Lorg/cocos2dx/lib/Cocos2dxTextInputWraper;

    invoke-direct {v0, p0}, Lorg/cocos2dx/lib/Cocos2dxTextInputWraper;-><init>(Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;)V

    sput-object v0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->sCocos2dxTextInputWraper:Lorg/cocos2dx/lib/Cocos2dxTextInputWraper;

    .line 318
    new-instance v0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$KeybordHandler;

    invoke-direct {v0, p0}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$KeybordHandler;-><init>(Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;)V

    sput-object v0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->sHandler:Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$KeybordHandler;

    .line 319
    return-void
.end method

.method public insertText(Ljava/lang/String;)V
    .locals 1
    .param p1, "pText"    # Ljava/lang/String;

    .prologue
    .line 863
    new-instance v0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$9;

    invoke-direct {v0, p0, p1}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$9;-><init>(Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;Ljava/lang/String;)V

    invoke-virtual {p0, v0}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->queueEvent(Ljava/lang/Runnable;)V

    .line 869
    return-void
.end method

.method protected onAttachedToWindow()V
    .locals 3

    .prologue
    .line 688
    invoke-super {p0}, Landroid/view/SurfaceView;->onAttachedToWindow()V

    .line 692
    iget-boolean v1, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->mDetached:Z

    if-eqz v1, :cond_2

    iget-object v1, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->mRenderer:Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$Renderer;

    if-eqz v1, :cond_2

    .line 693
    const/4 v0, 0x1

    .line 694
    .local v0, "renderMode":I
    iget-object v1, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->mGLThread:Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;

    if-eqz v1, :cond_0

    .line 695
    iget-object v1, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->mGLThread:Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;

    invoke-virtual {v1}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->getRenderMode()I

    move-result v0

    .line 697
    :cond_0
    new-instance v1, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;

    iget-object v2, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->mRenderer:Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$Renderer;

    invoke-direct {v1, p0, v2}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;-><init>(Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$Renderer;)V

    iput-object v1, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->mGLThread:Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;

    .line 698
    const/4 v1, 0x1

    if-eq v0, v1, :cond_1

    .line 699
    iget-object v1, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->mGLThread:Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;

    invoke-virtual {v1, v0}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->setRenderMode(I)V

    .line 701
    :cond_1
    iget-object v1, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->mGLThread:Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;

    invoke-virtual {v1}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->start()V

    .line 703
    .end local v0    # "renderMode":I
    :cond_2
    const/4 v1, 0x0

    iput-boolean v1, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->mDetached:Z

    .line 704
    return-void
.end method

.method protected onDetachedFromWindow()V
    .locals 1

    .prologue
    .line 716
    iget-object v0, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->mGLThread:Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;

    if-eqz v0, :cond_0

    .line 717
    iget-object v0, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->mGLThread:Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;

    invoke-virtual {v0}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->requestExitAndWait()V

    .line 719
    :cond_0
    const/4 v0, 0x1

    iput-boolean v0, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->mDetached:Z

    .line 720
    invoke-super {p0}, Landroid/view/SurfaceView;->onDetachedFromWindow()V

    .line 721
    return-void
.end method

.method public onPause()V
    .locals 1

    .prologue
    .line 644
    new-instance v0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$1;

    invoke-direct {v0, p0}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$1;-><init>(Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;)V

    invoke-virtual {p0, v0}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->queueEvent(Ljava/lang/Runnable;)V

    .line 652
    return-void
.end method

.method public onResume()V
    .locals 1

    .prologue
    .line 662
    iget-object v0, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->mGLThread:Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;

    invoke-virtual {v0}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->onResume()V

    .line 664
    new-instance v0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$2;

    invoke-direct {v0, p0}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$2;-><init>(Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;)V

    invoke-virtual {p0, v0}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->queueEvent(Ljava/lang/Runnable;)V

    .line 670
    return-void
.end method

.method protected onSizeChanged(IIII)V
    .locals 1
    .param p1, "pNewSurfaceWidth"    # I
    .param p2, "pNewSurfaceHeight"    # I
    .param p3, "pOldSurfaceWidth"    # I
    .param p4, "pOldSurfaceHeight"    # I

    .prologue
    .line 836
    invoke-virtual {p0}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->isInEditMode()Z

    move-result v0

    if-nez v0, :cond_0

    .line 837
    iget-object v0, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->mCocos2dxRenderer:Lorg/cocos2dx/lib/Cocos2dxRenderer;

    invoke-virtual {v0, p1, p2}, Lorg/cocos2dx/lib/Cocos2dxRenderer;->setScreenWidthAndHeight(II)V

    .line 839
    :cond_0
    return-void
.end method

.method public onTouchEvent(Landroid/view/MotionEvent;)Z
    .locals 29
    .param p1, "pMotionEvent"    # Landroid/view/MotionEvent;

    .prologue
    .line 725
    invoke-static {}, Lorg/cocos2dx/lib/Cocos2dxRenderer;->isInit()Z

    move-result v25

    if-nez v25, :cond_0

    const/16 v25, 0x0

    .line 827
    :goto_0
    return v25

    .line 728
    :cond_0
    invoke-virtual/range {p1 .. p1}, Landroid/view/MotionEvent;->getPointerCount()I

    move-result v13

    .line 729
    .local v13, "pointerNumber":I
    new-array v10, v13, [I

    .line 730
    .local v10, "ids":[I
    new-array v0, v13, [F

    move-object/from16 v19, v0

    .line 731
    .local v19, "xs":[F
    new-array v0, v13, [F

    move-object/from16 v24, v0

    .line 734
    .local v24, "ys":[F
    const/4 v5, 0x0

    .local v5, "i":I
    :goto_1
    if-ge v5, v13, :cond_1

    .line 735
    :try_start_0
    move-object/from16 v0, p1

    invoke-virtual {v0, v5}, Landroid/view/MotionEvent;->getPointerId(I)I

    move-result v25

    aput v25, v10, v5

    .line 736
    move-object/from16 v0, p1

    invoke-virtual {v0, v5}, Landroid/view/MotionEvent;->getX(I)F

    move-result v25

    aput v25, v19, v5

    .line 737
    move-object/from16 v0, p1

    invoke-virtual {v0, v5}, Landroid/view/MotionEvent;->getY(I)F

    move-result v25

    aput v25, v24, v5

    .line 734
    add-int/lit8 v5, v5, 0x1

    goto :goto_1

    .line 740
    :cond_1
    invoke-virtual/range {p1 .. p1}, Landroid/view/MotionEvent;->getAction()I

    move-result v25

    move/from16 v0, v25

    and-int/lit16 v0, v0, 0xff

    move/from16 v25, v0

    packed-switch v25, :pswitch_data_0

    .line 827
    :goto_2
    :pswitch_0
    const/16 v25, 0x1

    goto :goto_0

    .line 742
    :pswitch_1
    invoke-virtual/range {p1 .. p1}, Landroid/view/MotionEvent;->getAction()I

    move-result v25

    shr-int/lit8 v12, v25, 0x8

    .line 743
    .local v12, "indexPointerDown":I
    move-object/from16 v0, p1

    invoke-virtual {v0, v12}, Landroid/view/MotionEvent;->getPointerId(I)I

    move-result v7

    .line 744
    .local v7, "idPointerDown":I
    move-object/from16 v0, p1

    invoke-virtual {v0, v12}, Landroid/view/MotionEvent;->getX(I)F

    move-result v16

    .line 745
    .local v16, "xPointerDown":F
    move-object/from16 v0, p1

    invoke-virtual {v0, v12}, Landroid/view/MotionEvent;->getY(I)F

    move-result v21

    .line 747
    .local v21, "yPointerDown":F
    new-instance v25, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$3;

    move-object/from16 v0, v25

    move-object/from16 v1, p0

    move/from16 v2, v16

    move/from16 v3, v21

    invoke-direct {v0, v1, v7, v2, v3}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$3;-><init>(Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;IFF)V

    move-object/from16 v0, p0

    move-object/from16 v1, v25

    invoke-virtual {v0, v1}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->queueEvent(Ljava/lang/Runnable;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_2

    .line 816
    .end local v7    # "idPointerDown":I
    .end local v12    # "indexPointerDown":I
    .end local v16    # "xPointerDown":F
    .end local v21    # "yPointerDown":F
    :catch_0
    move-exception v4

    .line 817
    .local v4, "e":Ljava/lang/Exception;
    const-string v25, "GLSurfaceView OnTouchEvent Error %s"

    const/16 v26, 0x1

    move/from16 v0, v26

    new-array v0, v0, [Ljava/lang/Object;

    move-object/from16 v26, v0

    const/16 v27, 0x0

    invoke-virtual {v4}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v28

    aput-object v28, v26, v27

    invoke-static/range {v25 .. v26}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v14

    .line 818
    .local v14, "strMsg":Ljava/lang/String;
    invoke-static {v14}, Lcom/eyugame/impt/RelayNative;->LogMsg(Ljava/lang/String;)V

    .line 819
    invoke-virtual {v4}, Ljava/lang/Exception;->printStackTrace()V

    goto :goto_2

    .line 757
    .end local v4    # "e":Ljava/lang/Exception;
    .end local v14    # "strMsg":Ljava/lang/String;
    :pswitch_2
    const/16 v25, 0x0

    :try_start_1
    move-object/from16 v0, p1

    move/from16 v1, v25

    invoke-virtual {v0, v1}, Landroid/view/MotionEvent;->getPointerId(I)I

    move-result v6

    .line 758
    .local v6, "idDown":I
    const/16 v25, 0x0

    aget v15, v19, v25

    .line 759
    .local v15, "xDown":F
    const/16 v25, 0x0

    aget v20, v24, v25

    .line 761
    .local v20, "yDown":F
    new-instance v25, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$4;

    move-object/from16 v0, v25

    move-object/from16 v1, p0

    move/from16 v2, v20

    invoke-direct {v0, v1, v6, v15, v2}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$4;-><init>(Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;IFF)V

    move-object/from16 v0, p0

    move-object/from16 v1, v25

    invoke-virtual {v0, v1}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->queueEvent(Ljava/lang/Runnable;)V

    goto :goto_2

    .line 770
    .end local v6    # "idDown":I
    .end local v15    # "xDown":F
    .end local v20    # "yDown":F
    :pswitch_3
    new-instance v25, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$5;

    move-object/from16 v0, v25

    move-object/from16 v1, p0

    move-object/from16 v2, v19

    move-object/from16 v3, v24

    invoke-direct {v0, v1, v10, v2, v3}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$5;-><init>(Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;[I[F[F)V

    move-object/from16 v0, p0

    move-object/from16 v1, v25

    invoke-virtual {v0, v1}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->queueEvent(Ljava/lang/Runnable;)V

    goto/16 :goto_2

    .line 779
    :pswitch_4
    invoke-virtual/range {p1 .. p1}, Landroid/view/MotionEvent;->getAction()I

    move-result v25

    shr-int/lit8 v11, v25, 0x8

    .line 780
    .local v11, "indexPointUp":I
    move-object/from16 v0, p1

    invoke-virtual {v0, v11}, Landroid/view/MotionEvent;->getPointerId(I)I

    move-result v8

    .line 781
    .local v8, "idPointerUp":I
    move-object/from16 v0, p1

    invoke-virtual {v0, v11}, Landroid/view/MotionEvent;->getX(I)F

    move-result v17

    .line 782
    .local v17, "xPointerUp":F
    move-object/from16 v0, p1

    invoke-virtual {v0, v11}, Landroid/view/MotionEvent;->getY(I)F

    move-result v22

    .line 784
    .local v22, "yPointerUp":F
    new-instance v25, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$6;

    move-object/from16 v0, v25

    move-object/from16 v1, p0

    move/from16 v2, v17

    move/from16 v3, v22

    invoke-direct {v0, v1, v8, v2, v3}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$6;-><init>(Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;IFF)V

    move-object/from16 v0, p0

    move-object/from16 v1, v25

    invoke-virtual {v0, v1}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->queueEvent(Ljava/lang/Runnable;)V

    goto/16 :goto_2

    .line 794
    .end local v8    # "idPointerUp":I
    .end local v11    # "indexPointUp":I
    .end local v17    # "xPointerUp":F
    .end local v22    # "yPointerUp":F
    :pswitch_5
    const/16 v25, 0x0

    move-object/from16 v0, p1

    move/from16 v1, v25

    invoke-virtual {v0, v1}, Landroid/view/MotionEvent;->getPointerId(I)I

    move-result v9

    .line 795
    .local v9, "idUp":I
    const/16 v25, 0x0

    aget v18, v19, v25

    .line 796
    .local v18, "xUp":F
    const/16 v25, 0x0

    aget v23, v24, v25

    .line 798
    .local v23, "yUp":F
    new-instance v25, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$7;

    move-object/from16 v0, v25

    move-object/from16 v1, p0

    move/from16 v2, v18

    move/from16 v3, v23

    invoke-direct {v0, v1, v9, v2, v3}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$7;-><init>(Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;IFF)V

    move-object/from16 v0, p0

    move-object/from16 v1, v25

    invoke-virtual {v0, v1}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->queueEvent(Ljava/lang/Runnable;)V

    goto/16 :goto_2

    .line 807
    .end local v9    # "idUp":I
    .end local v18    # "xUp":F
    .end local v23    # "yUp":F
    :pswitch_6
    new-instance v25, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$8;

    move-object/from16 v0, v25

    move-object/from16 v1, p0

    move-object/from16 v2, v19

    move-object/from16 v3, v24

    invoke-direct {v0, v1, v10, v2, v3}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$8;-><init>(Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;[I[F[F)V

    move-object/from16 v0, p0

    move-object/from16 v1, v25

    invoke-virtual {v0, v1}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->queueEvent(Ljava/lang/Runnable;)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_0

    goto/16 :goto_2

    .line 740
    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_2
        :pswitch_5
        :pswitch_3
        :pswitch_6
        :pswitch_0
        :pswitch_1
        :pswitch_4
    .end packed-switch
.end method

.method public queueEvent(Ljava/lang/Runnable;)V
    .locals 1
    .param p1, "r"    # Ljava/lang/Runnable;

    .prologue
    .line 679
    iget-object v0, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->mGLThread:Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;

    invoke-virtual {v0, p1}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->queueEvent(Ljava/lang/Runnable;)V

    .line 680
    return-void
.end method

.method public requestRender()V
    .locals 1

    .prologue
    .line 609
    iget-object v0, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->mGLThread:Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;

    invoke-virtual {v0}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->requestRender()V

    .line 610
    return-void
.end method

.method public setCocos2dxEditText(Lorg/cocos2dx/lib/Cocos2dxEditText;)V
    .locals 2
    .param p1, "pCocos2dxEditText"    # Lorg/cocos2dx/lib/Cocos2dxEditText;

    .prologue
    .line 339
    iput-object p1, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->mCocos2dxEditText:Lorg/cocos2dx/lib/Cocos2dxEditText;

    .line 340
    iget-object v0, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->mCocos2dxEditText:Lorg/cocos2dx/lib/Cocos2dxEditText;

    if-eqz v0, :cond_0

    sget-object v0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->sCocos2dxTextInputWraper:Lorg/cocos2dx/lib/Cocos2dxTextInputWraper;

    if-eqz v0, :cond_0

    .line 341
    iget-object v0, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->mCocos2dxEditText:Lorg/cocos2dx/lib/Cocos2dxEditText;

    sget-object v1, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->sCocos2dxTextInputWraper:Lorg/cocos2dx/lib/Cocos2dxTextInputWraper;

    invoke-virtual {v0, v1}, Lorg/cocos2dx/lib/Cocos2dxEditText;->setOnEditorActionListener(Landroid/widget/TextView$OnEditorActionListener;)V

    .line 342
    iget-object v0, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->mCocos2dxEditText:Lorg/cocos2dx/lib/Cocos2dxEditText;

    invoke-virtual {v0, p0}, Lorg/cocos2dx/lib/Cocos2dxEditText;->setCocos2dxGLSurfaceView(Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;)V

    .line 343
    invoke-virtual {p0}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->requestFocus()Z

    .line 345
    :cond_0
    return-void
.end method

.method public setCocos2dxRenderer(Lorg/cocos2dx/lib/Cocos2dxRenderer;)V
    .locals 1
    .param p1, "renderer"    # Lorg/cocos2dx/lib/Cocos2dxRenderer;

    .prologue
    .line 326
    iput-object p1, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->mCocos2dxRenderer:Lorg/cocos2dx/lib/Cocos2dxRenderer;

    .line 327
    iget-object v0, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->mCocos2dxRenderer:Lorg/cocos2dx/lib/Cocos2dxRenderer;

    invoke-virtual {p0, v0}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->setRenderer(Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$Renderer;)V

    .line 328
    return-void
.end method

.method public setDebugFlags(I)V
    .locals 0
    .param p1, "debugFlags"    # I

    .prologue
    .line 374
    iput p1, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->mDebugFlags:I

    .line 375
    return-void
.end method

.method public setEGLConfigChooser(IIIIII)V
    .locals 8
    .param p1, "redSize"    # I
    .param p2, "greenSize"    # I
    .param p3, "blueSize"    # I
    .param p4, "alphaSize"    # I
    .param p5, "depthSize"    # I
    .param p6, "stencilSize"    # I

    .prologue
    .line 535
    new-instance v0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$ComponentSizeChooser;

    move-object v1, p0

    move v2, p1

    move v3, p2

    move v4, p3

    move v5, p4

    move v6, p5

    move v7, p6

    invoke-direct/range {v0 .. v7}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$ComponentSizeChooser;-><init>(Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;IIIIII)V

    invoke-virtual {p0, v0}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->setEGLConfigChooser(Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$EGLConfigChooser;)V

    .line 537
    return-void
.end method

.method public setEGLConfigChooser(Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$EGLConfigChooser;)V
    .locals 0
    .param p1, "configChooser"    # Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$EGLConfigChooser;

    .prologue
    .line 498
    invoke-direct {p0}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->checkRenderThreadState()V

    .line 499
    iput-object p1, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->mEGLConfigChooser:Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$EGLConfigChooser;

    .line 500
    return-void
.end method

.method public setEGLConfigChooser(Z)V
    .locals 1
    .param p1, "needDepth"    # Z

    .prologue
    .line 517
    new-instance v0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$SimpleEGLConfigChooser;

    invoke-direct {v0, p0, p1}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$SimpleEGLConfigChooser;-><init>(Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;Z)V

    invoke-virtual {p0, v0}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->setEGLConfigChooser(Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$EGLConfigChooser;)V

    .line 518
    return-void
.end method

.method public setEGLContextClientVersion(I)V
    .locals 0
    .param p1, "version"    # I

    .prologue
    .line 566
    invoke-direct {p0}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->checkRenderThreadState()V

    .line 567
    iput p1, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->mEGLContextClientVersion:I

    .line 568
    return-void
.end method

.method public setEGLContextFactory(Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$EGLContextFactory;)V
    .locals 0
    .param p1, "factory"    # Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$EGLContextFactory;

    .prologue
    .line 467
    invoke-direct {p0}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->checkRenderThreadState()V

    .line 468
    iput-object p1, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->mEGLContextFactory:Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$EGLContextFactory;

    .line 469
    return-void
.end method

.method public setEGLWindowSurfaceFactory(Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$EGLWindowSurfaceFactory;)V
    .locals 0
    .param p1, "factory"    # Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$EGLWindowSurfaceFactory;

    .prologue
    .line 481
    invoke-direct {p0}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->checkRenderThreadState()V

    .line 482
    iput-object p1, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->mEGLWindowSurfaceFactory:Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$EGLWindowSurfaceFactory;

    .line 483
    return-void
.end method

.method public setGLWrapper(Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLWrapper;)V
    .locals 0
    .param p1, "glWrapper"    # Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLWrapper;

    .prologue
    .line 361
    iput-object p1, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->mGLWrapper:Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLWrapper;

    .line 362
    return-void
.end method

.method public setPreserveEGLContextOnPause(Z)V
    .locals 0
    .param p1, "preserveOnPause"    # Z

    .prologue
    .line 404
    iput-boolean p1, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->mPreserveEGLContextOnPause:Z

    .line 405
    return-void
.end method

.method public setRenderMode(I)V
    .locals 1
    .param p1, "renderMode"    # I

    .prologue
    .line 587
    iget-object v0, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->mGLThread:Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;

    invoke-virtual {v0, p1}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->setRenderMode(I)V

    .line 588
    return-void
.end method

.method public setRenderer(Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$Renderer;)V
    .locals 3
    .param p1, "renderer"    # Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$Renderer;

    .prologue
    const/4 v2, 0x0

    .line 441
    invoke-direct {p0}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->checkRenderThreadState()V

    .line 442
    iget-object v0, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->mEGLConfigChooser:Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$EGLConfigChooser;

    if-nez v0, :cond_0

    .line 443
    new-instance v0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$SimpleEGLConfigChooser;

    const/4 v1, 0x1

    invoke-direct {v0, p0, v1}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$SimpleEGLConfigChooser;-><init>(Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;Z)V

    iput-object v0, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->mEGLConfigChooser:Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$EGLConfigChooser;

    .line 445
    :cond_0
    iget-object v0, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->mEGLContextFactory:Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$EGLContextFactory;

    if-nez v0, :cond_1

    .line 446
    new-instance v0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$DefaultContextFactory;

    invoke-direct {v0, p0, v2}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$DefaultContextFactory;-><init>(Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$1;)V

    iput-object v0, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->mEGLContextFactory:Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$EGLContextFactory;

    .line 448
    :cond_1
    iget-object v0, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->mEGLWindowSurfaceFactory:Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$EGLWindowSurfaceFactory;

    if-nez v0, :cond_2

    .line 449
    new-instance v0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$DefaultWindowSurfaceFactory;

    invoke-direct {v0, v2}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$DefaultWindowSurfaceFactory;-><init>(Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$1;)V

    iput-object v0, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->mEGLWindowSurfaceFactory:Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$EGLWindowSurfaceFactory;

    .line 451
    :cond_2
    iput-object p1, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->mRenderer:Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$Renderer;

    .line 452
    new-instance v0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;

    invoke-direct {v0, p0, p1}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;-><init>(Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$Renderer;)V

    iput-object v0, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->mGLThread:Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;

    .line 453
    iget-object v0, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->mGLThread:Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;

    invoke-virtual {v0}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->start()V

    .line 454
    return-void
.end method

.method public surfaceChanged(Landroid/view/SurfaceHolder;III)V
    .locals 1
    .param p1, "holder"    # Landroid/view/SurfaceHolder;
    .param p2, "format"    # I
    .param p3, "w"    # I
    .param p4, "h"    # I

    .prologue
    .line 634
    iget-object v0, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->mGLThread:Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;

    invoke-virtual {v0, p3, p4}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->onWindowResize(II)V

    .line 635
    return-void
.end method

.method public surfaceCreated(Landroid/view/SurfaceHolder;)V
    .locals 1
    .param p1, "holder"    # Landroid/view/SurfaceHolder;

    .prologue
    .line 617
    iget-object v0, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->mGLThread:Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;

    invoke-virtual {v0}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->surfaceCreated()V

    .line 618
    return-void
.end method

.method public surfaceDestroyed(Landroid/view/SurfaceHolder;)V
    .locals 1
    .param p1, "holder"    # Landroid/view/SurfaceHolder;

    .prologue
    .line 626
    iget-object v0, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->mGLThread:Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;

    invoke-virtual {v0}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->surfaceDestroyed()V

    .line 627
    return-void
.end method
