.class Lcom/eyugame/game/WebviewMgr$1CallBoardWebViewClient;
.super Landroid/webkit/WebViewClient;
.source "WebviewMgr.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/eyugame/game/WebviewMgr;->doCallBoard(Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = "CallBoardWebViewClient"
.end annotation


# instance fields
.field final synthetic this$0:Lcom/eyugame/game/WebviewMgr;


# direct methods
.method constructor <init>(Lcom/eyugame/game/WebviewMgr;)V
    .locals 0
    .param p1, "this$0"    # Lcom/eyugame/game/WebviewMgr;

    .prologue
    .line 213
    iput-object p1, p0, Lcom/eyugame/game/WebviewMgr$1CallBoardWebViewClient;->this$0:Lcom/eyugame/game/WebviewMgr;

    invoke-direct {p0}, Landroid/webkit/WebViewClient;-><init>()V

    return-void
.end method


# virtual methods
.method public onPageFinished(Landroid/webkit/WebView;Ljava/lang/String;)V
    .locals 0
    .param p1, "view"    # Landroid/webkit/WebView;
    .param p2, "url"    # Ljava/lang/String;

    .prologue
    .line 227
    invoke-super {p0, p1, p2}, Landroid/webkit/WebViewClient;->onPageFinished(Landroid/webkit/WebView;Ljava/lang/String;)V

    .line 228
    return-void
.end method

.method public onReceivedError(Landroid/webkit/WebView;ILjava/lang/String;Ljava/lang/String;)V
    .locals 0
    .param p1, "view"    # Landroid/webkit/WebView;
    .param p2, "errorCode"    # I
    .param p3, "description"    # Ljava/lang/String;
    .param p4, "failingUrl"    # Ljava/lang/String;

    .prologue
    .line 233
    return-void
.end method

.method public shouldOverrideUrlLoading(Landroid/webkit/WebView;Ljava/lang/String;)Z
    .locals 1
    .param p1, "view"    # Landroid/webkit/WebView;
    .param p2, "url"    # Ljava/lang/String;

    .prologue
    .line 218
    invoke-virtual {p1, p2}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V

    .line 219
    const/4 v0, 0x1

    return v0
.end method
