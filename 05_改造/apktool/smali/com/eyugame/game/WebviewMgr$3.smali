.class Lcom/eyugame/game/WebviewMgr$3;
.super Ljava/lang/Object;
.source "WebviewMgr.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/eyugame/game/WebviewMgr;->doOpenURL(Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lcom/eyugame/game/WebviewMgr;

.field final synthetic val$strURL:Ljava/lang/String;


# direct methods
.method constructor <init>(Lcom/eyugame/game/WebviewMgr;Ljava/lang/String;)V
    .locals 0
    .param p1, "this$0"    # Lcom/eyugame/game/WebviewMgr;

    .prologue
    .line 88
    iput-object p1, p0, Lcom/eyugame/game/WebviewMgr$3;->this$0:Lcom/eyugame/game/WebviewMgr;

    iput-object p2, p0, Lcom/eyugame/game/WebviewMgr$3;->val$strURL:Ljava/lang/String;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 30

    .prologue
    .line 90
    const-string v9, ""

    .line 91
    .local v9, "callboardUrl":Ljava/lang/String;
    const-wide/16 v22, 0x0

    .line 92
    .local v22, "x":D
    const-wide/16 v24, 0x0

    .line 93
    .local v24, "y":D
    const-wide/16 v20, 0x0

    .line 94
    .local v20, "width":D
    const-wide/16 v12, 0x0

    .line 95
    .local v12, "height":D
    const/4 v4, 0x1

    .line 98
    .local v4, "bOpenRect":Z
    :try_start_0
    new-instance v11, Lorg/json/JSONObject;

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/eyugame/game/WebviewMgr$3;->val$strURL:Ljava/lang/String;

    move-object/from16 v19, v0

    move-object/from16 v0, v19

    invoke-direct {v11, v0}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 99
    .local v11, "jsonObject":Lorg/json/JSONObject;
    const-string v19, "url"

    move-object/from16 v0, v19

    invoke-virtual {v11, v0}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v9

    .line 100
    const-string v19, "x"

    move-object/from16 v0, v19

    invoke-virtual {v11, v0}, Lorg/json/JSONObject;->getDouble(Ljava/lang/String;)D

    move-result-wide v22

    .line 101
    const-string v19, "y"

    move-object/from16 v0, v19

    invoke-virtual {v11, v0}, Lorg/json/JSONObject;->getDouble(Ljava/lang/String;)D

    move-result-wide v24

    .line 102
    const-string v19, "width"

    move-object/from16 v0, v19

    invoke-virtual {v11, v0}, Lorg/json/JSONObject;->getDouble(Ljava/lang/String;)D

    move-result-wide v20

    .line 103
    const-string v19, "height"

    move-object/from16 v0, v19

    invoke-virtual {v11, v0}, Lorg/json/JSONObject;->getDouble(Ljava/lang/String;)D
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-wide v12

    .line 110
    .end local v11    # "jsonObject":Lorg/json/JSONObject;
    :goto_0
    new-instance v14, Landroid/util/DisplayMetrics;

    invoke-direct {v14}, Landroid/util/DisplayMetrics;-><init>()V

    .line 111
    .local v14, "metric":Landroid/util/DisplayMetrics;
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/eyugame/game/WebviewMgr$3;->this$0:Lcom/eyugame/game/WebviewMgr;

    move-object/from16 v19, v0

    invoke-static/range {v19 .. v19}, Lcom/eyugame/game/WebviewMgr;->access$100(Lcom/eyugame/game/WebviewMgr;)Lcom/eyugame/game/ActivityMain;

    move-result-object v19

    invoke-virtual/range {v19 .. v19}, Lcom/eyugame/game/ActivityMain;->getResources()Landroid/content/res/Resources;

    move-result-object v19

    invoke-virtual/range {v19 .. v19}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object v14

    .line 112
    iget v0, v14, Landroid/util/DisplayMetrics;->widthPixels:I

    move/from16 v17, v0

    .line 113
    .local v17, "nScreenWidth":I
    iget v0, v14, Landroid/util/DisplayMetrics;->heightPixels:I

    move/from16 v16, v0

    .line 115
    .local v16, "nScreenHeight":I
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/eyugame/game/WebviewMgr$3;->this$0:Lcom/eyugame/game/WebviewMgr;

    move-object/from16 v19, v0

    invoke-static/range {v19 .. v19}, Lcom/eyugame/game/WebviewMgr;->access$200(Lcom/eyugame/game/WebviewMgr;)Landroid/widget/RelativeLayout;

    move-result-object v19

    if-nez v19, :cond_0

    .line 116
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/eyugame/game/WebviewMgr$3;->this$0:Lcom/eyugame/game/WebviewMgr;

    move-object/from16 v19, v0

    new-instance v26, Landroid/widget/RelativeLayout;

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/eyugame/game/WebviewMgr$3;->this$0:Lcom/eyugame/game/WebviewMgr;

    move-object/from16 v27, v0

    invoke-static/range {v27 .. v27}, Lcom/eyugame/game/WebviewMgr;->access$100(Lcom/eyugame/game/WebviewMgr;)Lcom/eyugame/game/ActivityMain;

    move-result-object v27

    invoke-direct/range {v26 .. v27}, Landroid/widget/RelativeLayout;-><init>(Landroid/content/Context;)V

    move-object/from16 v0, v19

    move-object/from16 v1, v26

    invoke-static {v0, v1}, Lcom/eyugame/game/WebviewMgr;->access$202(Lcom/eyugame/game/WebviewMgr;Landroid/widget/RelativeLayout;)Landroid/widget/RelativeLayout;

    .line 123
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/eyugame/game/WebviewMgr$3;->this$0:Lcom/eyugame/game/WebviewMgr;

    move-object/from16 v19, v0

    new-instance v26, Landroid/webkit/WebView;

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/eyugame/game/WebviewMgr$3;->this$0:Lcom/eyugame/game/WebviewMgr;

    move-object/from16 v27, v0

    invoke-static/range {v27 .. v27}, Lcom/eyugame/game/WebviewMgr;->access$100(Lcom/eyugame/game/WebviewMgr;)Lcom/eyugame/game/ActivityMain;

    move-result-object v27

    invoke-direct/range {v26 .. v27}, Landroid/webkit/WebView;-><init>(Landroid/content/Context;)V

    move-object/from16 v0, v19

    move-object/from16 v1, v26

    invoke-static {v0, v1}, Lcom/eyugame/game/WebviewMgr;->access$302(Lcom/eyugame/game/WebviewMgr;Landroid/webkit/WebView;)Landroid/webkit/WebView;

    .line 124
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/eyugame/game/WebviewMgr$3;->this$0:Lcom/eyugame/game/WebviewMgr;

    move-object/from16 v19, v0

    invoke-static/range {v19 .. v19}, Lcom/eyugame/game/WebviewMgr;->access$300(Lcom/eyugame/game/WebviewMgr;)Landroid/webkit/WebView;

    move-result-object v19

    const/16 v26, 0x0

    move-object/from16 v0, v19

    move/from16 v1, v26

    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->setVisibility(I)V

    .line 125
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/eyugame/game/WebviewMgr$3;->this$0:Lcom/eyugame/game/WebviewMgr;

    move-object/from16 v19, v0

    invoke-static/range {v19 .. v19}, Lcom/eyugame/game/WebviewMgr;->access$300(Lcom/eyugame/game/WebviewMgr;)Landroid/webkit/WebView;

    move-result-object v19

    const/16 v26, 0x0

    move-object/from16 v0, v19

    move/from16 v1, v26

    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->setScrollBarStyle(I)V

    .line 126
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/eyugame/game/WebviewMgr$3;->this$0:Lcom/eyugame/game/WebviewMgr;

    move-object/from16 v19, v0

    invoke-static/range {v19 .. v19}, Lcom/eyugame/game/WebviewMgr;->access$300(Lcom/eyugame/game/WebviewMgr;)Landroid/webkit/WebView;

    move-result-object v19

    invoke-virtual/range {v19 .. v19}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v19

    const/16 v26, 0x1

    move-object/from16 v0, v19

    move/from16 v1, v26

    invoke-virtual {v0, v1}, Landroid/webkit/WebSettings;->setAllowFileAccess(Z)V

    .line 127
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/eyugame/game/WebviewMgr$3;->this$0:Lcom/eyugame/game/WebviewMgr;

    move-object/from16 v19, v0

    invoke-static/range {v19 .. v19}, Lcom/eyugame/game/WebviewMgr;->access$300(Lcom/eyugame/game/WebviewMgr;)Landroid/webkit/WebView;

    move-result-object v19

    invoke-virtual/range {v19 .. v19}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v19

    const/16 v26, 0x1

    move-object/from16 v0, v19

    move/from16 v1, v26

    invoke-virtual {v0, v1}, Landroid/webkit/WebSettings;->setBuiltInZoomControls(Z)V

    .line 128
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/eyugame/game/WebviewMgr$3;->this$0:Lcom/eyugame/game/WebviewMgr;

    move-object/from16 v19, v0

    invoke-static/range {v19 .. v19}, Lcom/eyugame/game/WebviewMgr;->access$300(Lcom/eyugame/game/WebviewMgr;)Landroid/webkit/WebView;

    move-result-object v19

    const/16 v26, 0x1

    move-object/from16 v0, v19

    move/from16 v1, v26

    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->clearCache(Z)V

    .line 129
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/eyugame/game/WebviewMgr$3;->this$0:Lcom/eyugame/game/WebviewMgr;

    move-object/from16 v19, v0

    invoke-static/range {v19 .. v19}, Lcom/eyugame/game/WebviewMgr;->access$300(Lcom/eyugame/game/WebviewMgr;)Landroid/webkit/WebView;

    move-result-object v19

    invoke-virtual/range {v19 .. v19}, Landroid/webkit/WebView;->getSettings()Landroid/webkit/WebSettings;

    move-result-object v19

    const/16 v26, 0x1

    move-object/from16 v0, v19

    move/from16 v1, v26

    invoke-virtual {v0, v1}, Landroid/webkit/WebSettings;->setJavaScriptEnabled(Z)V

    .line 130
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/eyugame/game/WebviewMgr$3;->this$0:Lcom/eyugame/game/WebviewMgr;

    move-object/from16 v19, v0

    invoke-static/range {v19 .. v19}, Lcom/eyugame/game/WebviewMgr;->access$300(Lcom/eyugame/game/WebviewMgr;)Landroid/webkit/WebView;

    move-result-object v19

    const/16 v26, 0x1

    const/16 v27, 0x0

    move-object/from16 v0, v19

    move/from16 v1, v26

    move-object/from16 v2, v27

    invoke-virtual {v0, v1, v2}, Landroid/webkit/WebView;->setLayerType(ILandroid/graphics/Paint;)V

    .line 131
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/eyugame/game/WebviewMgr$3;->this$0:Lcom/eyugame/game/WebviewMgr;

    move-object/from16 v19, v0

    invoke-static/range {v19 .. v19}, Lcom/eyugame/game/WebviewMgr;->access$300(Lcom/eyugame/game/WebviewMgr;)Landroid/webkit/WebView;

    move-result-object v19

    move-object/from16 v0, v19

    invoke-virtual {v0, v9}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V

    .line 132
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/eyugame/game/WebviewMgr$3;->this$0:Lcom/eyugame/game/WebviewMgr;

    move-object/from16 v19, v0

    invoke-virtual/range {v19 .. v19}, Lcom/eyugame/game/WebviewMgr;->showLoading()V

    .line 133
    new-instance v5, Landroid/widget/Button;

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/eyugame/game/WebviewMgr$3;->this$0:Lcom/eyugame/game/WebviewMgr;

    move-object/from16 v19, v0

    invoke-static/range {v19 .. v19}, Lcom/eyugame/game/WebviewMgr;->access$100(Lcom/eyugame/game/WebviewMgr;)Lcom/eyugame/game/ActivityMain;

    move-result-object v19

    move-object/from16 v0, v19

    invoke-direct {v5, v0}, Landroid/widget/Button;-><init>(Landroid/content/Context;)V

    .line 134
    .local v5, "btnConfirm":Landroid/widget/Button;
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/eyugame/game/WebviewMgr$3;->this$0:Lcom/eyugame/game/WebviewMgr;

    move-object/from16 v19, v0

    invoke-static/range {v19 .. v19}, Lcom/eyugame/game/WebviewMgr;->access$100(Lcom/eyugame/game/WebviewMgr;)Lcom/eyugame/game/ActivityMain;

    move-result-object v19

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/eyugame/game/WebviewMgr$3;->this$0:Lcom/eyugame/game/WebviewMgr;

    move-object/from16 v26, v0

    .line 135
    invoke-static/range {v26 .. v26}, Lcom/eyugame/game/WebviewMgr;->access$100(Lcom/eyugame/game/WebviewMgr;)Lcom/eyugame/game/ActivityMain;

    move-result-object v26

    invoke-virtual/range {v26 .. v26}, Lcom/eyugame/game/ActivityMain;->getApplicationContext()Landroid/content/Context;

    move-result-object v26

    const-string v27, "string"

    const-string v28, "forum_page_confirm"

    invoke-static/range {v26 .. v28}, Lcom/eyugame/game/MResource;->getIdByName(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v26

    .line 134
    move-object/from16 v0, v19

    move/from16 v1, v26

    invoke-virtual {v0, v1}, Lcom/eyugame/game/ActivityMain;->getString(I)Ljava/lang/String;

    move-result-object v19

    move-object/from16 v0, v19

    invoke-virtual {v5, v0}, Landroid/widget/Button;->setText(Ljava/lang/CharSequence;)V

    .line 137
    new-instance v19, Lcom/eyugame/game/WebviewMgr$3$1;

    move-object/from16 v0, v19

    move-object/from16 v1, p0

    invoke-direct {v0, v1}, Lcom/eyugame/game/WebviewMgr$3$1;-><init>(Lcom/eyugame/game/WebviewMgr$3;)V

    move-object/from16 v0, v19

    invoke-virtual {v5, v0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 144
    new-instance v7, Landroid/widget/Button;

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/eyugame/game/WebviewMgr$3;->this$0:Lcom/eyugame/game/WebviewMgr;

    move-object/from16 v19, v0

    invoke-static/range {v19 .. v19}, Lcom/eyugame/game/WebviewMgr;->access$100(Lcom/eyugame/game/WebviewMgr;)Lcom/eyugame/game/ActivityMain;

    move-result-object v19

    move-object/from16 v0, v19

    invoke-direct {v7, v0}, Landroid/widget/Button;-><init>(Landroid/content/Context;)V

    .line 145
    .local v7, "btnMask":Landroid/widget/Button;
    const/high16 v19, -0x1000000

    move/from16 v0, v19

    invoke-virtual {v7, v0}, Landroid/widget/Button;->setBackgroundColor(I)V

    .line 146
    new-instance v19, Lcom/eyugame/game/WebviewMgr$3$2;

    move-object/from16 v0, v19

    move-object/from16 v1, p0

    invoke-direct {v0, v1}, Lcom/eyugame/game/WebviewMgr$3$2;-><init>(Lcom/eyugame/game/WebviewMgr$3;)V

    move-object/from16 v0, v19

    invoke-virtual {v7, v0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 152
    if-nez v4, :cond_1

    .line 153
    move/from16 v0, v16

    int-to-double v0, v0

    move-wide/from16 v26, v0

    const-wide v28, 0x3fb47ae147ae147bL    # 0.08

    mul-double v26, v26, v28

    move-wide/from16 v0, v26

    double-to-int v15, v0

    .line 154
    .local v15, "nBtnHeight":I
    new-instance v18, Landroid/widget/RelativeLayout$LayoutParams;

    sub-int v19, v16, v15

    move-object/from16 v0, v18

    move/from16 v1, v17

    move/from16 v2, v19

    invoke-direct {v0, v1, v2}, Landroid/widget/RelativeLayout$LayoutParams;-><init>(II)V

    .line 155
    .local v18, "webviewParams":Landroid/widget/RelativeLayout$LayoutParams;
    new-instance v6, Landroid/widget/RelativeLayout$LayoutParams;

    move/from16 v0, v17

    invoke-direct {v6, v0, v15}, Landroid/widget/RelativeLayout$LayoutParams;-><init>(II)V

    .line 156
    .local v6, "btnConfirmParams":Landroid/widget/RelativeLayout$LayoutParams;
    new-instance v8, Landroid/widget/RelativeLayout$LayoutParams;

    move/from16 v0, v17

    invoke-direct {v8, v0, v15}, Landroid/widget/RelativeLayout$LayoutParams;-><init>(II)V

    .line 157
    .local v8, "btnMaskParams":Landroid/widget/RelativeLayout$LayoutParams;
    const/16 v19, 0x0

    move/from16 v0, v19

    move-object/from16 v1, v18

    iput v0, v1, Landroid/widget/RelativeLayout$LayoutParams;->leftMargin:I

    .line 158
    const/16 v19, 0x0

    move/from16 v0, v19

    move-object/from16 v1, v18

    iput v0, v1, Landroid/widget/RelativeLayout$LayoutParams;->topMargin:I

    .line 159
    move/from16 v0, v17

    int-to-float v0, v0

    move/from16 v19, v0

    const v26, 0x3e99999a    # 0.3f

    mul-float v19, v19, v26

    move/from16 v0, v19

    float-to-int v0, v0

    move/from16 v19, v0

    move/from16 v0, v19

    iput v0, v6, Landroid/widget/RelativeLayout$LayoutParams;->leftMargin:I

    .line 160
    move/from16 v0, v17

    int-to-float v0, v0

    move/from16 v19, v0

    const v26, 0x3e99999a    # 0.3f

    mul-float v19, v19, v26

    move/from16 v0, v19

    float-to-int v0, v0

    move/from16 v19, v0

    move/from16 v0, v19

    iput v0, v6, Landroid/widget/RelativeLayout$LayoutParams;->rightMargin:I

    .line 161
    sub-int v19, v16, v15

    move/from16 v0, v19

    iput v0, v6, Landroid/widget/RelativeLayout$LayoutParams;->topMargin:I

    .line 162
    const/16 v19, 0x0

    move/from16 v0, v19

    iput v0, v8, Landroid/widget/RelativeLayout$LayoutParams;->leftMargin:I

    .line 163
    const/16 v19, 0x0

    move/from16 v0, v19

    iput v0, v8, Landroid/widget/RelativeLayout$LayoutParams;->rightMargin:I

    .line 164
    sub-int v19, v16, v15

    move/from16 v0, v19

    iput v0, v8, Landroid/widget/RelativeLayout$LayoutParams;->topMargin:I

    .line 165
    move/from16 v0, v17

    iput v0, v8, Landroid/widget/RelativeLayout$LayoutParams;->width:I

    .line 166
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/eyugame/game/WebviewMgr$3;->this$0:Lcom/eyugame/game/WebviewMgr;

    move-object/from16 v19, v0

    invoke-static/range {v19 .. v19}, Lcom/eyugame/game/WebviewMgr;->access$200(Lcom/eyugame/game/WebviewMgr;)Landroid/widget/RelativeLayout;

    move-result-object v19

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/eyugame/game/WebviewMgr$3;->this$0:Lcom/eyugame/game/WebviewMgr;

    move-object/from16 v26, v0

    invoke-static/range {v26 .. v26}, Lcom/eyugame/game/WebviewMgr;->access$300(Lcom/eyugame/game/WebviewMgr;)Landroid/webkit/WebView;

    move-result-object v26

    move-object/from16 v0, v19

    move-object/from16 v1, v26

    move-object/from16 v2, v18

    invoke-virtual {v0, v1, v2}, Landroid/widget/RelativeLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 167
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/eyugame/game/WebviewMgr$3;->this$0:Lcom/eyugame/game/WebviewMgr;

    move-object/from16 v19, v0

    invoke-static/range {v19 .. v19}, Lcom/eyugame/game/WebviewMgr;->access$200(Lcom/eyugame/game/WebviewMgr;)Landroid/widget/RelativeLayout;

    move-result-object v19

    move-object/from16 v0, v19

    invoke-virtual {v0, v7, v8}, Landroid/widget/RelativeLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 168
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/eyugame/game/WebviewMgr$3;->this$0:Lcom/eyugame/game/WebviewMgr;

    move-object/from16 v19, v0

    invoke-static/range {v19 .. v19}, Lcom/eyugame/game/WebviewMgr;->access$200(Lcom/eyugame/game/WebviewMgr;)Landroid/widget/RelativeLayout;

    move-result-object v19

    move-object/from16 v0, v19

    invoke-virtual {v0, v5, v6}, Landroid/widget/RelativeLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 188
    .end local v8    # "btnMaskParams":Landroid/widget/RelativeLayout$LayoutParams;
    :goto_1
    invoke-static {}, Lcom/eyugame/game/ActivityMain;->GetInstance()Lcom/eyugame/game/ActivityMain;

    move-result-object v19

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/eyugame/game/WebviewMgr$3;->this$0:Lcom/eyugame/game/WebviewMgr;

    move-object/from16 v26, v0

    invoke-static/range {v26 .. v26}, Lcom/eyugame/game/WebviewMgr;->access$200(Lcom/eyugame/game/WebviewMgr;)Landroid/widget/RelativeLayout;

    move-result-object v26

    new-instance v27, Landroid/view/ViewGroup$LayoutParams;

    const/16 v28, -0x1

    const/16 v29, -0x1

    invoke-direct/range {v27 .. v29}, Landroid/view/ViewGroup$LayoutParams;-><init>(II)V

    move-object/from16 v0, v19

    move-object/from16 v1, v26

    move-object/from16 v2, v27

    invoke-virtual {v0, v1, v2}, Lcom/eyugame/game/ActivityMain;->addContentView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 192
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/eyugame/game/WebviewMgr$3;->this$0:Lcom/eyugame/game/WebviewMgr;

    move-object/from16 v19, v0

    invoke-static/range {v19 .. v19}, Lcom/eyugame/game/WebviewMgr;->access$300(Lcom/eyugame/game/WebviewMgr;)Landroid/webkit/WebView;

    move-result-object v19

    new-instance v26, Lcom/eyugame/game/WebviewMgr$3$3;

    move-object/from16 v0, v26

    move-object/from16 v1, p0

    invoke-direct {v0, v1}, Lcom/eyugame/game/WebviewMgr$3$3;-><init>(Lcom/eyugame/game/WebviewMgr$3;)V

    move-object/from16 v0, v19

    move-object/from16 v1, v26

    invoke-virtual {v0, v1}, Landroid/webkit/WebView;->setWebViewClient(Landroid/webkit/WebViewClient;)V

    .line 208
    .end local v5    # "btnConfirm":Landroid/widget/Button;
    .end local v6    # "btnConfirmParams":Landroid/widget/RelativeLayout$LayoutParams;
    .end local v7    # "btnMask":Landroid/widget/Button;
    .end local v15    # "nBtnHeight":I
    .end local v18    # "webviewParams":Landroid/widget/RelativeLayout$LayoutParams;
    :goto_2
    return-void

    .line 104
    .end local v14    # "metric":Landroid/util/DisplayMetrics;
    .end local v16    # "nScreenHeight":I
    .end local v17    # "nScreenWidth":I
    :catch_0
    move-exception v10

    .line 105
    .local v10, "e":Lorg/json/JSONException;
    move-object/from16 v0, p0

    iget-object v9, v0, Lcom/eyugame/game/WebviewMgr$3;->val$strURL:Ljava/lang/String;

    .line 106
    const/4 v4, 0x0

    .line 107
    invoke-virtual {v10}, Lorg/json/JSONException;->printStackTrace()V

    goto/16 :goto_0

    .line 119
    .end local v10    # "e":Lorg/json/JSONException;
    .restart local v14    # "metric":Landroid/util/DisplayMetrics;
    .restart local v16    # "nScreenHeight":I
    .restart local v17    # "nScreenWidth":I
    :cond_0
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/eyugame/game/WebviewMgr$3;->this$0:Lcom/eyugame/game/WebviewMgr;

    move-object/from16 v19, v0

    invoke-static/range {v19 .. v19}, Lcom/eyugame/game/WebviewMgr;->access$300(Lcom/eyugame/game/WebviewMgr;)Landroid/webkit/WebView;

    move-result-object v19

    move-object/from16 v0, v19

    invoke-virtual {v0, v9}, Landroid/webkit/WebView;->loadUrl(Ljava/lang/String;)V

    goto :goto_2

    .line 172
    .restart local v5    # "btnConfirm":Landroid/widget/Button;
    .restart local v7    # "btnMask":Landroid/widget/Button;
    :cond_1
    const-wide v26, 0x3fb47ae147ae147bL    # 0.08

    mul-double v26, v26, v12

    move-wide/from16 v0, v26

    double-to-int v15, v0

    .line 173
    .restart local v15    # "nBtnHeight":I
    new-instance v18, Landroid/widget/RelativeLayout$LayoutParams;

    move-wide/from16 v0, v20

    double-to-int v0, v0

    move/from16 v19, v0

    double-to-int v0, v12

    move/from16 v26, v0

    sub-int v26, v26, v15

    move-object/from16 v0, v18

    move/from16 v1, v19

    move/from16 v2, v26

    invoke-direct {v0, v1, v2}, Landroid/widget/RelativeLayout$LayoutParams;-><init>(II)V

    .line 174
    .restart local v18    # "webviewParams":Landroid/widget/RelativeLayout$LayoutParams;
    new-instance v6, Landroid/widget/RelativeLayout$LayoutParams;

    move-wide/from16 v0, v20

    double-to-int v0, v0

    move/from16 v19, v0

    move/from16 v0, v19

    invoke-direct {v6, v0, v15}, Landroid/widget/RelativeLayout$LayoutParams;-><init>(II)V

    .line 175
    .restart local v6    # "btnConfirmParams":Landroid/widget/RelativeLayout$LayoutParams;
    move-wide/from16 v0, v22

    double-to-int v0, v0

    move/from16 v19, v0

    move/from16 v0, v19

    move-object/from16 v1, v18

    iput v0, v1, Landroid/widget/RelativeLayout$LayoutParams;->leftMargin:I

    .line 176
    move/from16 v0, v17

    int-to-double v0, v0

    move-wide/from16 v26, v0

    sub-double v26, v26, v22

    sub-double v26, v26, v20

    move-wide/from16 v0, v26

    double-to-int v0, v0

    move/from16 v19, v0

    move/from16 v0, v19

    move-object/from16 v1, v18

    iput v0, v1, Landroid/widget/RelativeLayout$LayoutParams;->rightMargin:I

    .line 177
    move-wide/from16 v0, v20

    double-to-int v0, v0

    move/from16 v19, v0

    move/from16 v0, v19

    move-object/from16 v1, v18

    iput v0, v1, Landroid/widget/RelativeLayout$LayoutParams;->width:I

    .line 178
    double-to-int v0, v12

    move/from16 v19, v0

    move/from16 v0, v19

    move-object/from16 v1, v18

    iput v0, v1, Landroid/widget/RelativeLayout$LayoutParams;->height:I

    .line 179
    move/from16 v0, v16

    int-to-double v0, v0

    move-wide/from16 v26, v0

    sub-double v26, v26, v24

    sub-double v26, v26, v12

    move-wide/from16 v0, v26

    double-to-int v0, v0

    move/from16 v19, v0

    move/from16 v0, v19

    move-object/from16 v1, v18

    iput v0, v1, Landroid/widget/RelativeLayout$LayoutParams;->topMargin:I

    .line 180
    move-object/from16 v0, v18

    iput v15, v0, Landroid/widget/RelativeLayout$LayoutParams;->bottomMargin:I

    .line 181
    const-wide v26, 0x3fd3333340000000L    # 0.30000001192092896

    mul-double v26, v26, v20

    move-wide/from16 v0, v26

    double-to-int v0, v0

    move/from16 v19, v0

    move/from16 v0, v19

    iput v0, v6, Landroid/widget/RelativeLayout$LayoutParams;->leftMargin:I

    .line 182
    const-wide v26, 0x3fd3333340000000L    # 0.30000001192092896

    mul-double v26, v26, v20

    move-wide/from16 v0, v26

    double-to-int v0, v0

    move/from16 v19, v0

    move/from16 v0, v19

    iput v0, v6, Landroid/widget/RelativeLayout$LayoutParams;->rightMargin:I

    .line 183
    mul-int/lit8 v19, v15, 0x2

    sub-int v19, v16, v19

    move/from16 v0, v19

    iput v0, v6, Landroid/widget/RelativeLayout$LayoutParams;->topMargin:I

    .line 184
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/eyugame/game/WebviewMgr$3;->this$0:Lcom/eyugame/game/WebviewMgr;

    move-object/from16 v19, v0

    invoke-static/range {v19 .. v19}, Lcom/eyugame/game/WebviewMgr;->access$200(Lcom/eyugame/game/WebviewMgr;)Landroid/widget/RelativeLayout;

    move-result-object v19

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/eyugame/game/WebviewMgr$3;->this$0:Lcom/eyugame/game/WebviewMgr;

    move-object/from16 v26, v0

    invoke-static/range {v26 .. v26}, Lcom/eyugame/game/WebviewMgr;->access$300(Lcom/eyugame/game/WebviewMgr;)Landroid/webkit/WebView;

    move-result-object v26

    move-object/from16 v0, v19

    move-object/from16 v1, v26

    move-object/from16 v2, v18

    invoke-virtual {v0, v1, v2}, Landroid/widget/RelativeLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    .line 185
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/eyugame/game/WebviewMgr$3;->this$0:Lcom/eyugame/game/WebviewMgr;

    move-object/from16 v19, v0

    invoke-static/range {v19 .. v19}, Lcom/eyugame/game/WebviewMgr;->access$200(Lcom/eyugame/game/WebviewMgr;)Landroid/widget/RelativeLayout;

    move-result-object v19

    move-object/from16 v0, v19

    invoke-virtual {v0, v5, v6}, Landroid/widget/RelativeLayout;->addView(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V

    goto/16 :goto_1
.end method
