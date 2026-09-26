.class Lcom/eyugame/game/WebviewMgr$6$1;
.super Ljava/lang/Object;
.source "WebviewMgr.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/eyugame/game/WebviewMgr$6;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$1:Lcom/eyugame/game/WebviewMgr$6;

.field final synthetic val$callboardUrl:Ljava/lang/String;

.field final synthetic val$height:D

.field final synthetic val$nScreenHeight:I

.field final synthetic val$nScreenWidth:I

.field final synthetic val$width:D

.field final synthetic val$x:D

.field final synthetic val$y:D


# direct methods
.method constructor <init>(Lcom/eyugame/game/WebviewMgr$6;DIDIDDLjava/lang/String;)V
    .locals 0
    .param p1, "this$1"    # Lcom/eyugame/game/WebviewMgr$6;

    .prologue
    .line 347
    iput-object p1, p0, Lcom/eyugame/game/WebviewMgr$6$1;->this$1:Lcom/eyugame/game/WebviewMgr$6;

    iput-wide p2, p0, Lcom/eyugame/game/WebviewMgr$6$1;->val$x:D

    iput p4, p0, Lcom/eyugame/game/WebviewMgr$6$1;->val$nScreenWidth:I

    iput-wide p5, p0, Lcom/eyugame/game/WebviewMgr$6$1;->val$width:D

    iput p7, p0, Lcom/eyugame/game/WebviewMgr$6$1;->val$nScreenHeight:I

    iput-wide p8, p0, Lcom/eyugame/game/WebviewMgr$6$1;->val$y:D

    iput-wide p10, p0, Lcom/eyugame/game/WebviewMgr$6$1;->val$height:D

    iput-object p12, p0, Lcom/eyugame/game/WebviewMgr$6$1;->val$callboardUrl:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 15

    .prologue
    const/4 v14, 0x1

    const/4 v13, -0x1

    const/4 v12, 0x4

    const/4 v11, 0x0

    .line 350
    iget-object v6, p0, Lcom/eyugame/game/WebviewMgr$6$1;->this$1:Lcom/eyugame/game/WebviewMgr$6;

    iget-object v6, v6, Lcom/eyugame/game/WebviewMgr$6;->this$0:Lcom/eyugame/game/WebviewMgr;

    iget-object v7, p0, Lcom/eyugame/game/WebviewMgr$6$1;->this$1:Lcom/eyugame/game/WebviewMgr$6;

    iget-object v7, v7, Lcom/eyugame/game/WebviewMgr$6;->this$0:Lcom/eyugame/game/WebviewMgr;

    invoke-static {v7}, Lcom/eyugame/game/WebviewMgr;->access$100(Lcom/eyugame/game/WebviewMgr;)Lcom/eyugame/game/ActivityMain;

    move-result-object v7

    invoke-static {v7}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v7

    iget-object v8, p0, Lcom/eyugame/game/WebviewMgr$6$1;->this$1:Lcom/eyugame/game/WebviewMgr$6;

    iget-object v8, v8, Lcom/eyugame/game/WebviewMgr$6;->this$0:Lcom/eyugame/game/WebviewMgr;

    invoke-static {v8}, Lcom/eyugame/game/WebviewMgr;->access$100(Lcom/eyugame/game/WebviewMgr;)Lcom/eyugame/game/ActivityMain;

    move-result-object v8

    const-string v9, "layout"

    const-string v10, "callboard"

    invoke-static {v8, v9, v10}, Lcom/eyugame/game/MResource;->getIdByName(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v8

    const/4 v9, 0x0

    invoke-virtual {v7, v8, v9}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v7

    invoke-static {v6, v7}, Lcom/eyugame/game/WebviewMgr;->access$502(Lcom/eyugame/game/WebviewMgr;Landroid/view/View;)Landroid/view/View;

    .line 352
    iget-object v6, p0, Lcom/eyugame/game/WebviewMgr$6$1;->this$1:Lcom/eyugame/game/WebviewMgr$6;

    iget-object v6, v6, Lcom/eyugame/game/WebviewMgr$6;->this$0:Lcom/eyugame/game/WebviewMgr;

    invoke-static {v6}, Lcom/eyugame/game/WebviewMgr;->access$500(Lcom/eyugame/game/WebviewMgr;)Landroid/view/View;

    move-result-object v6

    iget-object v7, p0, Lcom/eyugame/game/WebviewMgr$6$1;->this$1:Lcom/eyugame/game/WebviewMgr$6;

    iget-object v7, v7, Lcom/eyugame/game/WebviewMgr$6;->this$0:Lcom/eyugame/game/WebviewMgr;

    invoke-static {v7}, Lcom/eyugame/game/WebviewMgr;->access$100(Lcom/eyugame/game/WebviewMgr;)Lcom/eyugame/game/ActivityMain;

    move-result-object v7

    const-string v8, "id"

    const-string v9, "imgBackground"

    invoke-static {v7, v8, v9}, Lcom/eyugame/game/MResource;->getIdByName(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v7

    invoke-virtual {v6, v7}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v2

    check-cast v2, Landroid/widget/ImageView;

    .line 353
    .local v2, "imgBackground":Landroid/widget/ImageView;
    iget-object v6, p0, Lcom/eyugame/game/WebviewMgr$6$1;->this$1:Lcom/eyugame/game/WebviewMgr$6;

    iget-object v6, v6, Lcom/eyugame/game/WebviewMgr$6;->this$0:Lcom/eyugame/game/WebviewMgr;

    invoke-static {v6}, Lcom/eyugame/game/WebviewMgr;->access$500(Lcom/eyugame/game/WebviewMgr;)Landroid/view/View;

    move-result-object v6

    iget-object v7, p0, Lcom/eyugame/game/WebviewMgr$6$1;->this$1:Lcom/eyugame/game/WebviewMgr$6;

    iget-object v7, v7, Lcom/eyugame/game/WebviewMgr$6;->this$0:Lcom/eyugame/game/WebviewMgr;

    invoke-static {v7}, Lcom/eyugame/game/WebviewMgr;->access$100(Lcom/eyugame/game/WebviewMgr;)Lcom/eyugame/game/ActivityMain;

    move-result-object v7

    const-string v8, "id"

    const-string v9, "callboard_mask"

    invoke-static {v7, v8, v9}, Lcom/eyugame/game/MResource;->getIdByName(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v7

    invoke-virtual {v6, v7}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v1

    check-cast v1, Landroid/widget/Button;

    .line 354
    .local v1, "btnMask":Landroid/widget/Button;
    iget-object v6, p0, Lcom/eyugame/game/WebviewMgr$6$1;->this$1:Lcom/eyugame/game/WebviewMgr$6;

    iget-object v6, v6, Lcom/eyugame/game/WebviewMgr$6;->this$0:Lcom/eyugame/game/WebviewMgr;

    invoke-static {v6}, Lcom/eyugame/game/WebviewMgr;->access$500(Lcom/eyugame/game/WebviewMgr;)Landroid/view/View;

    move-result-object v6

    iget-object v7, p0, Lcom/eyugame/game/WebviewMgr$6$1;->this$1:Lcom/eyugame/game/WebviewMgr$6;

    iget-object v7, v7, Lcom/eyugame/game/WebviewMgr$6;->this$0:Lcom/eyugame/game/WebviewMgr;

    invoke-static {v7}, Lcom/eyugame/game/WebviewMgr;->access$100(Lcom/eyugame/game/WebviewMgr;)Lcom/eyugame/game/ActivityMain;

    move-result-object v7

    const-string v8, "id"

    const-string v9, "callboard_webview"

    invoke-static {v7, v8, v9}, Lcom/eyugame/game/MResource;->getIdByName(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v7

    invoke-virtual {v6, v7}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v4

    check-cast v4, Landroid/webkit/WebView;

    .line 355
    .local v4, "webView":Landroid/webkit/WebView;
    iget-object v6, p0, Lcom/eyugame/game/WebviewMgr$6$1;->this$1:Lcom/eyugame/game/WebviewMgr$6;

    iget-object v6, v6, Lcom/eyugame/game/WebviewMgr$6;->this$0:Lcom/eyugame/game/WebviewMgr;

    invoke-static {v6}, Lcom/eyugame/game/WebviewMgr;->access$500(Lcom/eyugame/game/WebviewMgr;)Landroid/view/View;

    move-result-object v6

    iget-object v7, p0, Lcom/eyugame/game/WebviewMgr$6$1;->this$1:Lcom/eyugame/game/WebviewMgr$6;

    iget-object v7, v7, Lcom/eyugame/game/WebviewMgr$6;->this$0:Lcom/eyugame/game/WebviewMgr;

    invoke-static {v7}, Lcom/eyugame/game/WebviewMgr;->access$100(Lcom/eyugame/game/WebviewMgr;)Lcom/eyugame/game/ActivityMain;

    move-result-object v7

    const-string v8, "id"

    const-string v9, "confirm"

    invoke-static {v7, v8, v9}, Lcom/eyugame/game/MResource;->getIdByName(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v7

    invoke-virtual {v6, v7}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    check-cast v0, Landroid/widget/Button;

    .line 356
    .local v0, "btnConfirm":Landroid/widget/Button;
    iget-object v6, p0, Lcom/eyugame/game/WebviewMgr$6$1;->this$1:Lcom/eyugame/game/WebviewMgr$6;

    iget-object v6, v6, Lcom/eyugame/game/WebviewMgr$6;->this$0:Lcom/eyugame/game/WebviewMgr;

    invoke-static {v6}, Lcom/eyugame/game/WebviewMgr;->access$100(Lcom/eyugame/game/WebviewMgr;)Lcom/eyugame/game/ActivityMain;

    move-result-object v6

    const-string v7, "id"

    const-string v8, "callboard_mask"

    invoke-static {v6, v7, v8}, Lcom/eyugame/game/MResource;->getIdByName(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v3

    .line 358
    .local v3, "nBackgroundId":I
    invoke-virtual {v2, v12}, Landroid/widget/ImageView;->setVisibility(I)V

    .line 359
    invoke-virtual {v1, v12}, Landroid/widget/Button;->setVisibility(I)V

    .line 360
    invoke-virtual {v0, v12}, Landroid/widget/Button;->setVisibility(I)V

    .line 362
    invoke-virtual {v4}, Landroid/webkit/WebView;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v5

    check-cast v5, Landroid/widget/RelativeLayout$LayoutParams;

    .line 363
    .local v5, "webviewLayoutParams":Landroid/widget/RelativeLayout$LayoutParams;
    const/4 v6, 0x5

    invoke-virtual {v5, v6, v3}, Landroid/widget/RelativeLayout$LayoutParams;->addRule(II)V

    .line 364
    const/4 v6, 0x6

    invoke-virtual {v5, v6, v3}, Landroid/widget/RelativeLayout$LayoutParams;->addRule(II)V

    .line 365
    const/4 v6, 0x7

    invoke-virtual {v5, v6, v3}, Landroid/widget/RelativeLayout$LayoutParams;->addRule(II)V

    .line 366
    const/16 v6, 0x8

    invoke-virtual {v5, v6, v3}, Landroid/widget/RelativeLayout$LayoutParams;->addRule(II)V

    .line 367
    iget-wide v6, p0, Lcom/eyugame/game/WebviewMgr$6$1;->val$x:D

    double-to-int v6, v6

    iput v6, v5, Landroid/widget/RelativeLayout$LayoutParams;->leftMargin:I

    .line 368
    iget v6, p0, Lcom/eyugame/game/WebviewMgr$6$1;->val$nScreenWidth:I

    int-to-double v6, v6

    iget-wide v8, p0, Lcom/eyugame/game/WebviewMgr$6$1;->val$x:D

    sub-double/2addr v6, v8

    iget-wide v8, p0, Lcom/eyugame/game/WebviewMgr$6$1;->val$width:D

    sub-double/2addr v6, v8

    double-to-int v6, v6

    iput v6, v5, Landroid/widget/RelativeLayout$LayoutParams;->rightMargin:I

    .line 369
    iget v6, p0, Lcom/eyugame/game/WebviewMgr$6$1;->val$nScreenHeight:I

    int-to-double v6, v6

    iget-wide v8, p0, Lcom/eyugame/game/WebviewMgr$6$1;->val$y:D

    sub-double/2addr v6, v8

    iget-wide v8, p0, Lcom/eyugame/game/WebviewMgr$6$1;->val$height:D

    sub-double/2addr v6, v8

    double-to-int v6, v6

    iput v6, v5, Landroid/widget/RelativeLayout$LayoutParams;->topMargin:I

    .line 370
    iget-wide v6, p0, Lcom/eyugame/game/WebviewMgr$6$1;->val$y:D

    double-to-int v6, v6

    iput v6, v5, Landroid/widget/RelativeLayout$LayoutParams;->bottomMargin:I

    .line 371
    iget-wide v6, p0, Lcom/eyugame/game/WebviewMgr$6$1;->val$width:D

    double-to-int v6, v6

    iput v6, v5, Landroid/widget/RelativeLayout$LayoutParams;->width:I

    .line 372
    iget-wide v6, p0, Lcom/eyugame/game/WebviewMgr$6$1;->val$height:D

    double-to-int v6, v6

    iput v6, v5, Landroid/widget/RelativeLayout$LayoutParams;->height:I

    .line 373
    invoke-virtual {v4, v5}, Landroid/webkit/WebView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 374
    invoke-virtual {v4, v14}, Landroid/webkit/WebView;->setVerticalScrollBarEnabled(Z)V

    .line 375
    invoke-virtual {v4, v11}, Landroid/webkit/WebView;->setHorizontalScrollBarEnabled(Z)V

    .line 376
    invoke-virtual {v4, v11}, Landroid/webkit/WebView;->clearCache(Z)V

    .line 377
    iget-object v6, p0, Lcom/eyugame/game/WebviewMgr$6$1;->val$callboardUrl:Ljava/lang/String;

    invoke-virtual {v4, v6}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V

    .line 378
    new-instance v6, Lcom/eyugame/game/WebviewMgr$6$1webviewClient;

    iget-object v7, p0, Lcom/eyugame/game/WebviewMgr$6$1;->this$1:Lcom/eyugame/game/WebviewMgr$6;

    invoke-direct {v6, v7}, Lcom/eyugame/game/WebviewMgr$6$1webviewClient;-><init>(Lcom/eyugame/game/WebviewMgr$6;)V

    invoke-virtual {v4, v6}, Landroid/webkit/WebView;->setWebViewClient(Landroid/webkit/WebViewClient;)V

    .line 379
    invoke-virtual {v4}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v6

    invoke-virtual {v6, v14}, Landroid/webkit/WebSettings;->setJavaScriptEnabled(Z)V

    .line 380
    iget-object v6, p0, Lcom/eyugame/game/WebviewMgr$6$1;->this$1:Lcom/eyugame/game/WebviewMgr$6;

    iget-object v6, v6, Lcom/eyugame/game/WebviewMgr$6;->this$0:Lcom/eyugame/game/WebviewMgr;

    invoke-static {v6}, Lcom/eyugame/game/WebviewMgr;->access$500(Lcom/eyugame/game/WebviewMgr;)Landroid/view/View;

    move-result-object v6

    invoke-virtual {v6, v11}, Landroid/view/View;->setBackgroundColor(I)V

    .line 382
    iget-object v6, p0, Lcom/eyugame/game/WebviewMgr$6$1;->this$1:Lcom/eyugame/game/WebviewMgr$6;

    iget-object v6, v6, Lcom/eyugame/game/WebviewMgr$6;->this$0:Lcom/eyugame/game/WebviewMgr;

    invoke-static {v6}, Lcom/eyugame/game/WebviewMgr;->access$100(Lcom/eyugame/game/WebviewMgr;)Lcom/eyugame/game/ActivityMain;

    move-result-object v6

    iget-object v7, p0, Lcom/eyugame/game/WebviewMgr$6$1;->this$1:Lcom/eyugame/game/WebviewMgr$6;

    iget-object v7, v7, Lcom/eyugame/game/WebviewMgr$6;->this$0:Lcom/eyugame/game/WebviewMgr;

    invoke-static {v7}, Lcom/eyugame/game/WebviewMgr;->access$500(Lcom/eyugame/game/WebviewMgr;)Landroid/view/View;

    move-result-object v7

    new-instance v8, Landroid/view/ViewGroup$LayoutParams;

    invoke-direct {v8, v13, v13}, Landroid/view/ViewGroup$LayoutParams;-><init>(II)V

    invoke-virtual {v6, v7, v8}, Lcom/eyugame/game/ActivityMain;->addContentView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 383
    return-void
.end method
