.class Lcom/eyugame/game/WebviewMgr$6$1webviewClient;
.super Landroid/webkit/WebViewClient;
.source "WebviewMgr.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/eyugame/game/WebviewMgr$6;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = "webviewClient"
.end annotation


# instance fields
.field final synthetic this$1:Lcom/eyugame/game/WebviewMgr$6;


# direct methods
.method constructor <init>(Lcom/eyugame/game/WebviewMgr$6;)V
    .locals 0
    .param p1, "this$1"    # Lcom/eyugame/game/WebviewMgr$6;

    .prologue
    .line 310
    iput-object p1, p0, Lcom/eyugame/game/WebviewMgr$6$1webviewClient;->this$1:Lcom/eyugame/game/WebviewMgr$6;

    invoke-direct {p0}, Landroid/webkit/WebViewClient;-><init>()V

    return-void
.end method


# virtual methods
.method public onPageFinished(Landroid/webkit/WebView;Ljava/lang/String;)V
    .locals 0
    .param p1, "view"    # Landroid/webkit/WebView;
    .param p2, "url"    # Ljava/lang/String;

    .prologue
    .line 324
    invoke-super {p0, p1, p2}, Landroid/webkit/WebViewClient;->onPageFinished(Landroid/webkit/WebView;Ljava/lang/String;)V

    .line 325
    return-void
.end method

.method public onReceivedError(Landroid/webkit/WebView;ILjava/lang/String;Ljava/lang/String;)V
    .locals 0
    .param p1, "view"    # Landroid/webkit/WebView;
    .param p2, "errorCode"    # I
    .param p3, "description"    # Ljava/lang/String;
    .param p4, "failingUrl"    # Ljava/lang/String;

    .prologue
    .line 330
    return-void
.end method

.method public shouldOverrideUrlLoading(Landroid/webkit/WebView;Ljava/lang/String;)Z
    .locals 1
    .param p1, "view"    # Landroid/webkit/WebView;
    .param p2, "url"    # Ljava/lang/String;

    .prologue
    .line 315
    invoke-virtual {p1, p2}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V

    .line 316
    const/4 v0, 0x1

    return v0
.end method
