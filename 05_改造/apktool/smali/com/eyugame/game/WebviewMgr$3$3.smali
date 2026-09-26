.class Lcom/eyugame/game/WebviewMgr$3$3;
.super Landroid/webkit/WebViewClient;
.source "WebviewMgr.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/eyugame/game/WebviewMgr$3;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/eyugame/game/WebviewMgr$3;


# direct methods
.method constructor <init>(Lcom/eyugame/game/WebviewMgr$3;)V
    .locals 0
    .param p1, "this$1"    # Lcom/eyugame/game/WebviewMgr$3;

    .prologue
    .line 192
    iput-object p1, p0, Lcom/eyugame/game/WebviewMgr$3$3;->this$1:Lcom/eyugame/game/WebviewMgr$3;

    invoke-direct {p0}, Landroid/webkit/WebViewClient;-><init>()V

    return-void
.end method


# virtual methods
.method public onPageFinished(Landroid/webkit/WebView;Ljava/lang/String;)V
    .locals 1
    .param p1, "view"    # Landroid/webkit/WebView;
    .param p2, "url"    # Ljava/lang/String;

    .prologue
    .line 201
    iget-object v0, p0, Lcom/eyugame/game/WebviewMgr$3$3;->this$1:Lcom/eyugame/game/WebviewMgr$3;

    iget-object v0, v0, Lcom/eyugame/game/WebviewMgr$3;->this$0:Lcom/eyugame/game/WebviewMgr;

    invoke-virtual {v0}, Lcom/eyugame/game/WebviewMgr;->hideLoading()V

    .line 203
    invoke-super {p0, p1, p2}, Landroid/webkit/WebViewClient;->onPageFinished(Landroid/webkit/WebView;Ljava/lang/String;)V

    .line 204
    return-void
.end method

.method public shouldOverrideUrlLoading(Landroid/webkit/WebView;Ljava/lang/String;)Z
    .locals 1
    .param p1, "view"    # Landroid/webkit/WebView;
    .param p2, "url"    # Ljava/lang/String;

    .prologue
    .line 195
    invoke-virtual {p1, p2}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V

    .line 196
    const/4 v0, 0x1

    return v0
.end method
