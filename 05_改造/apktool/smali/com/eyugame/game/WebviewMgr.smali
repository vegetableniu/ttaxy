.class public Lcom/eyugame/game/WebviewMgr;
.super Ljava/lang/Object;
.source "WebviewMgr.java"


# static fields
.field private static webviewMgr:Lcom/eyugame/game/WebviewMgr;


# instance fields
.field private mCallboardView:Landroid/view/View;

.field private mWebPageView:Landroid/view/View;

.field private mWebView:Landroid/webkit/WebView;

.field private mWebViewLayout:Landroid/widget/RelativeLayout;

.field private mainActivity:Lcom/eyugame/game/ActivityMain;

.field private progressDialog:Landroid/app/ProgressDialog;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 24
    const/4 v0, 0x0

    sput-object v0, Lcom/eyugame/game/WebviewMgr;->webviewMgr:Lcom/eyugame/game/WebviewMgr;

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    .prologue
    const/4 v0, 0x0

    .line 23
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 26
    iput-object v0, p0, Lcom/eyugame/game/WebviewMgr;->progressDialog:Landroid/app/ProgressDialog;

    .line 27
    iput-object v0, p0, Lcom/eyugame/game/WebviewMgr;->mWebView:Landroid/webkit/WebView;

    .line 28
    iput-object v0, p0, Lcom/eyugame/game/WebviewMgr;->mWebPageView:Landroid/view/View;

    .line 29
    iput-object v0, p0, Lcom/eyugame/game/WebviewMgr;->mWebViewLayout:Landroid/widget/RelativeLayout;

    .line 30
    iput-object v0, p0, Lcom/eyugame/game/WebviewMgr;->mCallboardView:Landroid/view/View;

    .line 31
    iput-object v0, p0, Lcom/eyugame/game/WebviewMgr;->mainActivity:Lcom/eyugame/game/ActivityMain;

    return-void
.end method

.method public static GetSingleton()Lcom/eyugame/game/WebviewMgr;
    .locals 2

    .prologue
    .line 34
    sget-object v0, Lcom/eyugame/game/WebviewMgr;->webviewMgr:Lcom/eyugame/game/WebviewMgr;

    if-nez v0, :cond_0

    .line 35
    new-instance v0, Lcom/eyugame/game/WebviewMgr;

    invoke-direct {v0}, Lcom/eyugame/game/WebviewMgr;-><init>()V

    sput-object v0, Lcom/eyugame/game/WebviewMgr;->webviewMgr:Lcom/eyugame/game/WebviewMgr;

    .line 36
    sget-object v0, Lcom/eyugame/game/WebviewMgr;->webviewMgr:Lcom/eyugame/game/WebviewMgr;

    invoke-static {}, Lcom/eyugame/game/ActivityMain;->GetInstance()Lcom/eyugame/game/ActivityMain;

    move-result-object v1

    iput-object v1, v0, Lcom/eyugame/game/WebviewMgr;->mainActivity:Lcom/eyugame/game/ActivityMain;

    .line 39
    :cond_0
    sget-object v0, Lcom/eyugame/game/WebviewMgr;->webviewMgr:Lcom/eyugame/game/WebviewMgr;

    return-object v0
.end method

.method static synthetic access$000(Lcom/eyugame/game/WebviewMgr;)Landroid/app/ProgressDialog;
    .locals 1
    .param p0, "x0"    # Lcom/eyugame/game/WebviewMgr;

    .prologue
    .line 23
    iget-object v0, p0, Lcom/eyugame/game/WebviewMgr;->progressDialog:Landroid/app/ProgressDialog;

    return-object v0
.end method

.method static synthetic access$002(Lcom/eyugame/game/WebviewMgr;Landroid/app/ProgressDialog;)Landroid/app/ProgressDialog;
    .locals 0
    .param p0, "x0"    # Lcom/eyugame/game/WebviewMgr;
    .param p1, "x1"    # Landroid/app/ProgressDialog;

    .prologue
    .line 23
    iput-object p1, p0, Lcom/eyugame/game/WebviewMgr;->progressDialog:Landroid/app/ProgressDialog;

    return-object p1
.end method

.method static synthetic access$100(Lcom/eyugame/game/WebviewMgr;)Lcom/eyugame/game/ActivityMain;
    .locals 1
    .param p0, "x0"    # Lcom/eyugame/game/WebviewMgr;

    .prologue
    .line 23
    iget-object v0, p0, Lcom/eyugame/game/WebviewMgr;->mainActivity:Lcom/eyugame/game/ActivityMain;

    return-object v0
.end method

.method static synthetic access$200(Lcom/eyugame/game/WebviewMgr;)Landroid/widget/RelativeLayout;
    .locals 1
    .param p0, "x0"    # Lcom/eyugame/game/WebviewMgr;

    .prologue
    .line 23
    iget-object v0, p0, Lcom/eyugame/game/WebviewMgr;->mWebViewLayout:Landroid/widget/RelativeLayout;

    return-object v0
.end method

.method static synthetic access$202(Lcom/eyugame/game/WebviewMgr;Landroid/widget/RelativeLayout;)Landroid/widget/RelativeLayout;
    .locals 0
    .param p0, "x0"    # Lcom/eyugame/game/WebviewMgr;
    .param p1, "x1"    # Landroid/widget/RelativeLayout;

    .prologue
    .line 23
    iput-object p1, p0, Lcom/eyugame/game/WebviewMgr;->mWebViewLayout:Landroid/widget/RelativeLayout;

    return-object p1
.end method

.method static synthetic access$300(Lcom/eyugame/game/WebviewMgr;)Landroid/webkit/WebView;
    .locals 1
    .param p0, "x0"    # Lcom/eyugame/game/WebviewMgr;

    .prologue
    .line 23
    iget-object v0, p0, Lcom/eyugame/game/WebviewMgr;->mWebView:Landroid/webkit/WebView;

    return-object v0
.end method

.method static synthetic access$302(Lcom/eyugame/game/WebviewMgr;Landroid/webkit/WebView;)Landroid/webkit/WebView;
    .locals 0
    .param p0, "x0"    # Lcom/eyugame/game/WebviewMgr;
    .param p1, "x1"    # Landroid/webkit/WebView;

    .prologue
    .line 23
    iput-object p1, p0, Lcom/eyugame/game/WebviewMgr;->mWebView:Landroid/webkit/WebView;

    return-object p1
.end method

.method static synthetic access$400(Lcom/eyugame/game/WebviewMgr;)Landroid/view/View;
    .locals 1
    .param p0, "x0"    # Lcom/eyugame/game/WebviewMgr;

    .prologue
    .line 23
    iget-object v0, p0, Lcom/eyugame/game/WebviewMgr;->mCallboardView:Landroid/view/View;

    return-object v0
.end method

.method static synthetic access$402(Lcom/eyugame/game/WebviewMgr;Landroid/view/View;)Landroid/view/View;
    .locals 0
    .param p0, "x0"    # Lcom/eyugame/game/WebviewMgr;
    .param p1, "x1"    # Landroid/view/View;

    .prologue
    .line 23
    iput-object p1, p0, Lcom/eyugame/game/WebviewMgr;->mCallboardView:Landroid/view/View;

    return-object p1
.end method

.method static synthetic access$500(Lcom/eyugame/game/WebviewMgr;)Landroid/view/View;
    .locals 1
    .param p0, "x0"    # Lcom/eyugame/game/WebviewMgr;

    .prologue
    .line 23
    iget-object v0, p0, Lcom/eyugame/game/WebviewMgr;->mWebPageView:Landroid/view/View;

    return-object v0
.end method

.method static synthetic access$502(Lcom/eyugame/game/WebviewMgr;Landroid/view/View;)Landroid/view/View;
    .locals 0
    .param p0, "x0"    # Lcom/eyugame/game/WebviewMgr;
    .param p1, "x1"    # Landroid/view/View;

    .prologue
    .line 23
    iput-object p1, p0, Lcom/eyugame/game/WebviewMgr;->mWebPageView:Landroid/view/View;

    return-object p1
.end method


# virtual methods
.method public doCallBoard(Ljava/lang/String;)V
    .locals 19
    .param p1, "jsonStr"    # Ljava/lang/String;

    .prologue
    .line 239
    :try_start_0
    new-instance v16, Lorg/json/JSONObject;

    move-object/from16 v0, v16

    move-object/from16 v1, p1

    invoke-direct {v0, v1}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 240
    .local v16, "jsonObject":Lorg/json/JSONObject;
    const-string v2, "url"

    move-object/from16 v0, v16

    invoke-virtual {v0, v2}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v14

    .line 241
    .local v14, "callboardUrl":Ljava/lang/String;
    const-string v2, "x"

    move-object/from16 v0, v16

    invoke-virtual {v0, v2}, Lorg/json/JSONObject;->getDouble(Ljava/lang/String;)D

    move-result-wide v4

    .line 242
    .local v4, "x":D
    const-string v2, "y"

    move-object/from16 v0, v16

    invoke-virtual {v0, v2}, Lorg/json/JSONObject;->getDouble(Ljava/lang/String;)D

    move-result-wide v10

    .line 243
    .local v10, "y":D
    const-string v2, "width"

    move-object/from16 v0, v16

    invoke-virtual {v0, v2}, Lorg/json/JSONObject;->getDouble(Ljava/lang/String;)D

    move-result-wide v7

    .line 244
    .local v7, "width":D
    const-string v2, "height"

    move-object/from16 v0, v16

    invoke-virtual {v0, v2}, Lorg/json/JSONObject;->getDouble(Ljava/lang/String;)D

    move-result-wide v12

    .line 245
    .local v12, "height":D
    new-instance v17, Landroid/util/DisplayMetrics;

    invoke-direct/range {v17 .. v17}, Landroid/util/DisplayMetrics;-><init>()V

    .line 246
    .local v17, "metric":Landroid/util/DisplayMetrics;
    move-object/from16 v0, p0

    iget-object v2, v0, Lcom/eyugame/game/WebviewMgr;->mainActivity:Lcom/eyugame/game/ActivityMain;

    invoke-virtual {v2}, Lcom/eyugame/game/ActivityMain;->getResources()Landroid/content/res/Resources;

    move-result-object v2

    invoke-virtual {v2}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v17

    .line 247
    move-object/from16 v0, v17

    iget v6, v0, Landroid/util/DisplayMetrics;->widthPixels:I

    .line 248
    .local v6, "nScreenWidth":I
    move-object/from16 v0, v17

    iget v9, v0, Landroid/util/DisplayMetrics;->heightPixels:I

    .line 250
    .local v9, "nScreenHeight":I
    new-instance v18, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v2

    move-object/from16 v0, v18

    invoke-direct {v0, v2}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    new-instance v2, Lcom/eyugame/game/WebviewMgr$4;

    move-object/from16 v3, p0

    invoke-direct/range {v2 .. v14}, Lcom/eyugame/game/WebviewMgr$4;-><init>(Lcom/eyugame/game/WebviewMgr;DIDIDDLjava/lang/String;)V

    move-object/from16 v0, v18

    invoke-virtual {v0, v2}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    .line 293
    .end local v4    # "x":D
    .end local v6    # "nScreenWidth":I
    .end local v7    # "width":D
    .end local v9    # "nScreenHeight":I
    .end local v10    # "y":D
    .end local v12    # "height":D
    .end local v14    # "callboardUrl":Ljava/lang/String;
    .end local v16    # "jsonObject":Lorg/json/JSONObject;
    .end local v17    # "metric":Landroid/util/DisplayMetrics;
    :goto_0
    return-void

    .line 289
    :catch_0
    move-exception v15

    .line 290
    .local v15, "e":Lorg/json/JSONException;
    invoke-static {}, Lcom/eyugame/impt/RelayNative;->StopIndicatorView()V

    .line 291
    invoke-virtual {v15}, Lorg/json/JSONException;->printStackTrace()V

    goto :goto_0
.end method

.method public doCloseCallboard()V
    .locals 2

    .prologue
    .line 296
    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    new-instance v1, Lcom/eyugame/game/WebviewMgr$5;

    invoke-direct {v1, p0}, Lcom/eyugame/game/WebviewMgr$5;-><init>(Lcom/eyugame/game/WebviewMgr;)V

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 305
    return-void
.end method

.method public doCloseCloseWebPage()V
    .locals 2

    .prologue
    .line 394
    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    new-instance v1, Lcom/eyugame/game/WebviewMgr$7;

    invoke-direct {v1, p0}, Lcom/eyugame/game/WebviewMgr$7;-><init>(Lcom/eyugame/game/WebviewMgr;)V

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 403
    return-void
.end method

.method public doOpenURL(Ljava/lang/String;)V
    .locals 2
    .param p1, "strURL"    # Ljava/lang/String;

    .prologue
    .line 88
    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    new-instance v1, Lcom/eyugame/game/WebviewMgr$3;

    invoke-direct {v1, p0, p1}, Lcom/eyugame/game/WebviewMgr$3;-><init>(Lcom/eyugame/game/WebviewMgr;Ljava/lang/String;)V

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 210
    return-void
.end method

.method public doOpenUrlInRect(Ljava/lang/String;)V
    .locals 2
    .param p1, "jsonStr"    # Ljava/lang/String;

    .prologue
    .line 308
    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    new-instance v1, Lcom/eyugame/game/WebviewMgr$6;

    invoke-direct {v1, p0, p1}, Lcom/eyugame/game/WebviewMgr$6;-><init>(Lcom/eyugame/game/WebviewMgr;Ljava/lang/String;)V

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 391
    return-void
.end method

.method public hideLoading()V
    .locals 2

    .prologue
    .line 64
    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    new-instance v1, Lcom/eyugame/game/WebviewMgr$2;

    invoke-direct {v1, p0}, Lcom/eyugame/game/WebviewMgr$2;-><init>(Lcom/eyugame/game/WebviewMgr;)V

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 72
    return-void
.end method

.method public onBackPressed()Z
    .locals 3

    .prologue
    const/4 v0, 0x1

    .line 406
    iget-object v1, p0, Lcom/eyugame/game/WebviewMgr;->progressDialog:Landroid/app/ProgressDialog;

    if-nez v1, :cond_0

    iget-object v1, p0, Lcom/eyugame/game/WebviewMgr;->mWebViewLayout:Landroid/widget/RelativeLayout;

    if-eqz v1, :cond_1

    .line 407
    :cond_0
    invoke-virtual {p0}, Lcom/eyugame/game/WebviewMgr;->onDestoryWeb()V

    .line 420
    :goto_0
    return v0

    .line 411
    :cond_1
    iget-object v1, p0, Lcom/eyugame/game/WebviewMgr;->mCallboardView:Landroid/view/View;

    if-eqz v1, :cond_2

    iget-object v1, p0, Lcom/eyugame/game/WebviewMgr;->mCallboardView:Landroid/view/View;

    invoke-virtual {v1}, Landroid/view/View;->isShown()Z

    move-result v1

    if-eqz v1, :cond_2

    .line 412
    iget-object v1, p0, Lcom/eyugame/game/WebviewMgr;->mCallboardView:Landroid/view/View;

    const/4 v2, 0x4

    invoke-virtual {v1, v2}, Landroid/view/View;->setVisibility(I)V

    .line 413
    const/4 v1, 0x0

    iput-object v1, p0, Lcom/eyugame/game/WebviewMgr;->mCallboardView:Landroid/view/View;

    .line 415
    invoke-static {}, Lcom/eyugame/impt/RelayNative;->CloseCallboard()V

    goto :goto_0

    .line 420
    :cond_2
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public onDestoryWeb()V
    .locals 3

    .prologue
    const/4 v2, 0x0

    .line 76
    iget-object v0, p0, Lcom/eyugame/game/WebviewMgr;->mWebViewLayout:Landroid/widget/RelativeLayout;

    if-eqz v0, :cond_0

    .line 78
    iget-object v0, p0, Lcom/eyugame/game/WebviewMgr;->mWebViewLayout:Landroid/widget/RelativeLayout;

    const/4 v1, 0x4

    invoke-virtual {v0, v1}, Landroid/widget/RelativeLayout;->setVisibility(I)V

    .line 79
    iput-object v2, p0, Lcom/eyugame/game/WebviewMgr;->mWebViewLayout:Landroid/widget/RelativeLayout;

    .line 80
    iput-object v2, p0, Lcom/eyugame/game/WebviewMgr;->mWebView:Landroid/webkit/WebView;

    .line 83
    :cond_0
    invoke-virtual {p0}, Lcom/eyugame/game/WebviewMgr;->hideLoading()V

    .line 84
    return-void
.end method

.method public showLoading()V
    .locals 2

    .prologue
    .line 43
    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    new-instance v1, Lcom/eyugame/game/WebviewMgr$1;

    invoke-direct {v1, p0}, Lcom/eyugame/game/WebviewMgr$1;-><init>(Lcom/eyugame/game/WebviewMgr;)V

    invoke-virtual {v0, v1}, Landroid/os/Handler;->post(Ljava/lang/Runnable;)Z

    .line 61
    return-void
.end method
