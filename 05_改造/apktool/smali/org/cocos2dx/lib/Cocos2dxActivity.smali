.class public abstract Lorg/cocos2dx/lib/Cocos2dxActivity;
.super Landroid/app/Activity;
.source "Cocos2dxActivity.java"

# interfaces
.implements Lorg/cocos2dx/lib/Cocos2dxHelper$Cocos2dxHelperListener;


# instance fields
.field private mBgView:Landroid/widget/ImageView;

.field private mEditText:Lorg/cocos2dx/lib/Cocos2dxEditText;

.field private mGLSurfaceView:Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;

.field private mHandler:Lorg/cocos2dx/lib/Cocos2dxHandler;

.field protected mTipText:Landroid/widget/TextView;

.field protected splashDelayTime:J


# direct methods
.method public constructor <init>()V
    .locals 2

    .prologue
    const/4 v0, 0x0

    .line 44
    invoke-direct {p0}, Landroid/app/Activity;-><init>()V

    .line 56
    iput-object v0, p0, Lorg/cocos2dx/lib/Cocos2dxActivity;->mBgView:Landroid/widget/ImageView;

    .line 57
    iput-object v0, p0, Lorg/cocos2dx/lib/Cocos2dxActivity;->mTipText:Landroid/widget/TextView;

    .line 58
    const-wide/16 v0, 0x5dc

    iput-wide v0, p0, Lorg/cocos2dx/lib/Cocos2dxActivity;->splashDelayTime:J

    return-void
.end method

.method static synthetic access$000(Lorg/cocos2dx/lib/Cocos2dxActivity;)Landroid/widget/ImageView;
    .locals 1
    .param p0, "x0"    # Lorg/cocos2dx/lib/Cocos2dxActivity;

    .prologue
    .line 44
    iget-object v0, p0, Lorg/cocos2dx/lib/Cocos2dxActivity;->mBgView:Landroid/widget/ImageView;

    return-object v0
.end method

.method static synthetic access$100(Lorg/cocos2dx/lib/Cocos2dxActivity;)Lorg/cocos2dx/lib/Cocos2dxEditText;
    .locals 1
    .param p0, "x0"    # Lorg/cocos2dx/lib/Cocos2dxActivity;

    .prologue
    .line 44
    iget-object v0, p0, Lorg/cocos2dx/lib/Cocos2dxActivity;->mEditText:Lorg/cocos2dx/lib/Cocos2dxEditText;

    return-object v0
.end method


# virtual methods
.method public ClearBackground()V
    .locals 4

    .prologue
    .line 206
    new-instance v0, Landroid/os/Handler;

    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    new-instance v1, Lorg/cocos2dx/lib/Cocos2dxActivity$2;

    invoke-direct {v1, p0}, Lorg/cocos2dx/lib/Cocos2dxActivity$2;-><init>(Lorg/cocos2dx/lib/Cocos2dxActivity;)V

    iget-wide v2, p0, Lorg/cocos2dx/lib/Cocos2dxActivity;->splashDelayTime:J

    invoke-virtual {v0, v1, v2, v3}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    .line 223
    return-void
.end method

.method protected onCreate(Landroid/os/Bundle;)V
    .locals 1
    .param p1, "savedInstanceState"    # Landroid/os/Bundle;

    .prologue
    .line 66
    invoke-super {p0, p1}, Landroid/app/Activity;->onCreate(Landroid/os/Bundle;)V

    .line 68
    new-instance v0, Lorg/cocos2dx/lib/Cocos2dxHandler;

    invoke-direct {v0, p0}, Lorg/cocos2dx/lib/Cocos2dxHandler;-><init>(Lorg/cocos2dx/lib/Cocos2dxActivity;)V

    iput-object v0, p0, Lorg/cocos2dx/lib/Cocos2dxActivity;->mHandler:Lorg/cocos2dx/lib/Cocos2dxHandler;

    .line 70
    invoke-virtual {p0}, Lorg/cocos2dx/lib/Cocos2dxActivity;->onCreateView()Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;

    move-result-object v0

    iput-object v0, p0, Lorg/cocos2dx/lib/Cocos2dxActivity;->mGLSurfaceView:Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;

    .line 72
    invoke-static {p0, p0}, Lorg/cocos2dx/lib/Cocos2dxHelper;->init(Landroid/content/Context;Lorg/cocos2dx/lib/Cocos2dxHelper$Cocos2dxHelperListener;)V

    .line 73
    return-void
.end method

.method public onCreateView()Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;
    .locals 15

    .prologue
    const/16 v14, 0xe

    const/4 v10, -0x2

    const/4 v13, -0x1

    .line 134
    new-instance v3, Landroid/widget/RelativeLayout$LayoutParams;

    invoke-direct {v3, v13, v13}, Landroid/widget/RelativeLayout$LayoutParams;-><init>(II)V

    .line 137
    .local v3, "framelayout_params":Landroid/view/ViewGroup$LayoutParams;
    new-instance v2, Landroid/widget/RelativeLayout;

    invoke-direct {v2, p0}, Landroid/widget/RelativeLayout;-><init>(Landroid/content/Context;)V

    .line 138
    .local v2, "framelayout":Landroid/widget/RelativeLayout;
    invoke-virtual {v2, v3}, Landroid/widget/RelativeLayout;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 141
    new-instance v1, Landroid/widget/RelativeLayout$LayoutParams;

    invoke-direct {v1, v13, v10}, Landroid/widget/RelativeLayout$LayoutParams;-><init>(II)V

    .line 144
    .local v1, "edittext_layout_params":Landroid/view/ViewGroup$LayoutParams;
    new-instance v10, Lorg/cocos2dx/lib/Cocos2dxEditText;

    invoke-direct {v10, p0}, Lorg/cocos2dx/lib/Cocos2dxEditText;-><init>(Landroid/content/Context;)V

    iput-object v10, p0, Lorg/cocos2dx/lib/Cocos2dxActivity;->mEditText:Lorg/cocos2dx/lib/Cocos2dxEditText;

    .line 145
    iget-object v10, p0, Lorg/cocos2dx/lib/Cocos2dxActivity;->mEditText:Lorg/cocos2dx/lib/Cocos2dxEditText;

    invoke-virtual {v10, v1}, Lorg/cocos2dx/lib/Cocos2dxEditText;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 146
    iget-object v10, p0, Lorg/cocos2dx/lib/Cocos2dxActivity;->mEditText:Lorg/cocos2dx/lib/Cocos2dxEditText;

    const/4 v11, 0x4

    invoke-virtual {v10, v11}, Lorg/cocos2dx/lib/Cocos2dxEditText;->setVisibility(I)V

    .line 149
    iget-object v10, p0, Lorg/cocos2dx/lib/Cocos2dxActivity;->mEditText:Lorg/cocos2dx/lib/Cocos2dxEditText;

    invoke-virtual {v2, v10}, Landroid/widget/RelativeLayout;->addView(Landroid/view/View;)V

    .line 152
    new-instance v4, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;

    invoke-direct {v4, p0}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;-><init>(Landroid/content/Context;)V

    .line 155
    .local v4, "gLSurfaceView":Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;
    invoke-virtual {v2, v4}, Landroid/widget/RelativeLayout;->addView(Landroid/view/View;)V

    .line 157
    new-instance v10, Lorg/cocos2dx/lib/Cocos2dxRenderer;

    invoke-direct {v10}, Lorg/cocos2dx/lib/Cocos2dxRenderer;-><init>()V

    invoke-virtual {v4, v10}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->setCocos2dxRenderer(Lorg/cocos2dx/lib/Cocos2dxRenderer;)V

    .line 158
    iget-object v10, p0, Lorg/cocos2dx/lib/Cocos2dxActivity;->mEditText:Lorg/cocos2dx/lib/Cocos2dxEditText;

    invoke-virtual {v4, v10}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->setCocos2dxEditText(Lorg/cocos2dx/lib/Cocos2dxEditText;)V

    .line 161
    new-instance v10, Landroid/widget/ImageView;

    invoke-direct {v10, p0}, Landroid/widget/ImageView;-><init>(Landroid/content/Context;)V

    iput-object v10, p0, Lorg/cocos2dx/lib/Cocos2dxActivity;->mBgView:Landroid/widget/ImageView;

    .line 163
    invoke-virtual {p0}, Lorg/cocos2dx/lib/Cocos2dxActivity;->getApplicationContext()Landroid/content/Context;

    move-result-object v10

    const-string v11, "drawable"

    const-string v12, "splash_ex"

    invoke-static {v10, v11, v12}, Lcom/eyugame/game/MResource;->getIdByName(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v6

    .line 164
    .local v6, "idBgEx":I
    invoke-virtual {p0}, Lorg/cocos2dx/lib/Cocos2dxActivity;->getApplicationContext()Landroid/content/Context;

    move-result-object v10

    const-string v11, "drawable"

    const-string v12, "splash"

    invoke-static {v10, v11, v12}, Lcom/eyugame/game/MResource;->getIdByName(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v5

    .line 165
    .local v5, "idBg":I
    iget-object v11, p0, Lorg/cocos2dx/lib/Cocos2dxActivity;->mBgView:Landroid/widget/ImageView;

    if-eqz v6, :cond_2

    move v10, v6

    :goto_0
    invoke-virtual {v11, v10}, Landroid/widget/ImageView;->setImageResource(I)V

    .line 166
    new-instance v0, Landroid/widget/RelativeLayout$LayoutParams;

    invoke-direct {v0, v13, v13}, Landroid/widget/RelativeLayout$LayoutParams;-><init>(II)V

    .line 167
    .local v0, "bgLP":Landroid/widget/RelativeLayout$LayoutParams;
    invoke-virtual {v0, v14, v13}, Landroid/widget/RelativeLayout$LayoutParams;->addRule(II)V

    .line 168
    const/16 v10, 0xf

    invoke-virtual {v0, v10, v13}, Landroid/widget/RelativeLayout$LayoutParams;->addRule(II)V

    .line 169
    iget-object v10, p0, Lorg/cocos2dx/lib/Cocos2dxActivity;->mBgView:Landroid/widget/ImageView;

    invoke-virtual {v10, v0}, Landroid/widget/ImageView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 170
    iget-object v10, p0, Lorg/cocos2dx/lib/Cocos2dxActivity;->mBgView:Landroid/widget/ImageView;

    const/4 v11, 0x4

    invoke-virtual {v10, v11}, Landroid/widget/ImageView;->setVisibility(I)V

    .line 173
    if-eqz v6, :cond_0

    .line 174
    new-instance v10, Landroid/os/Handler;

    invoke-direct {v10}, Landroid/os/Handler;-><init>()V

    new-instance v11, Lorg/cocos2dx/lib/Cocos2dxActivity$1;

    invoke-direct {v11, p0, v5}, Lorg/cocos2dx/lib/Cocos2dxActivity$1;-><init>(Lorg/cocos2dx/lib/Cocos2dxActivity;I)V

    const-wide/16 v12, 0x5dc

    invoke-virtual {v10, v11, v12, v13}, Landroid/os/Handler;->postDelayed(Ljava/lang/Runnable;J)Z

    .line 184
    :cond_0
    :try_start_0
    new-instance v10, Landroid/widget/TextView;

    invoke-direct {v10, p0}, Landroid/widget/TextView;-><init>(Landroid/content/Context;)V

    iput-object v10, p0, Lorg/cocos2dx/lib/Cocos2dxActivity;->mTipText:Landroid/widget/TextView;

    .line 185
    invoke-virtual {p0}, Lorg/cocos2dx/lib/Cocos2dxActivity;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v10

    invoke-virtual {p0}, Lorg/cocos2dx/lib/Cocos2dxActivity;->getPackageName()Ljava/lang/String;

    move-result-object v11

    const/16 v12, 0x80

    invoke-virtual {v10, v11, v12}, Landroid/content/pm/PackageManager;->getPackageInfo(Ljava/lang/String;I)Landroid/content/pm/PackageInfo;

    move-result-object v10

    iget v9, v10, Landroid/content/pm/PackageInfo;->versionCode:I

    .line 186
    .local v9, "versionCode":I
    invoke-static {}, Lorg/cocos2dx/lib/Cocos2dxHelper;->getExternalAssetPath()Ljava/lang/String;

    move-result-object v10

    invoke-static {v10, v9}, Lcom/eyugame/base/LocationUtils;->JuageVersionAndProcess(Ljava/lang/String;I)Z

    move-result v7

    .line 187
    .local v7, "needCopyRes":Z
    if-eqz v7, :cond_1

    .line 188
    iget-object v10, p0, Lorg/cocos2dx/lib/Cocos2dxActivity;->mTipText:Landroid/widget/TextView;

    invoke-virtual {p0}, Lorg/cocos2dx/lib/Cocos2dxActivity;->getResources()Landroid/content/res/Resources;

    move-result-object v11

    invoke-virtual {p0}, Lorg/cocos2dx/lib/Cocos2dxActivity;->getApplicationContext()Landroid/content/Context;

    move-result-object v12

    const-string v13, "string"

    const-string v14, "unzip_res"

    invoke-static {v12, v13, v14}, Lcom/eyugame/game/MResource;->getIdByName(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v12

    invoke-virtual {v11, v12}, Landroid/content/res/Resources;->getString(I)Ljava/lang/String;

    move-result-object v11

    const/4 v12, 0x1

    new-array v12, v12, [Ljava/lang/Object;

    const/4 v13, 0x0

    const/4 v14, 0x0

    invoke-static {v14}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v14

    aput-object v14, v12, v13

    invoke-static {v11, v12}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v10, v11}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 189
    new-instance v8, Landroid/widget/RelativeLayout$LayoutParams;

    const/4 v10, -0x2

    const/4 v11, -0x2

    invoke-direct {v8, v10, v11}, Landroid/widget/RelativeLayout$LayoutParams;-><init>(II)V

    .line 190
    .local v8, "tipLP":Landroid/widget/RelativeLayout$LayoutParams;
    const/16 v10, 0xe

    const/4 v11, -0x1

    invoke-virtual {v8, v10, v11}, Landroid/widget/RelativeLayout$LayoutParams;->addRule(II)V

    .line 191
    const/16 v10, 0xc

    invoke-virtual {v8, v10}, Landroid/widget/RelativeLayout$LayoutParams;->addRule(I)V

    .line 192
    iget-object v10, p0, Lorg/cocos2dx/lib/Cocos2dxActivity;->mTipText:Landroid/widget/TextView;

    invoke-virtual {v10, v8}, Landroid/widget/TextView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 193
    iget-object v10, p0, Lorg/cocos2dx/lib/Cocos2dxActivity;->mTipText:Landroid/widget/TextView;

    invoke-virtual {v2, v10}, Landroid/widget/RelativeLayout;->addView(Landroid/view/View;)V
    :try_end_0
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    .line 200
    .end local v7    # "needCopyRes":Z
    .end local v8    # "tipLP":Landroid/widget/RelativeLayout$LayoutParams;
    .end local v9    # "versionCode":I
    :cond_1
    :goto_1
    invoke-virtual {p0, v2}, Lorg/cocos2dx/lib/Cocos2dxActivity;->setContentView(Landroid/view/View;)V

    .line 202
    return-object v4

    .end local v0    # "bgLP":Landroid/widget/RelativeLayout$LayoutParams;
    :cond_2
    move v10, v5

    .line 165
    goto/16 :goto_0

    .line 195
    .restart local v0    # "bgLP":Landroid/widget/RelativeLayout$LayoutParams;
    :catch_0
    move-exception v10

    goto :goto_1
.end method

.method protected onPause()V
    .locals 2

    .prologue
    .line 96
    invoke-super {p0}, Landroid/app/Activity;->onPause()V

    .line 98
    invoke-static {}, Lorg/cocos2dx/lib/Cocos2dxHelper;->onPause()V

    .line 99
    iget-object v0, p0, Lorg/cocos2dx/lib/Cocos2dxActivity;->mGLSurfaceView:Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;

    invoke-virtual {v0}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->onPause()V

    .line 100
    iget-object v0, p0, Lorg/cocos2dx/lib/Cocos2dxActivity;->mEditText:Lorg/cocos2dx/lib/Cocos2dxEditText;

    if-eqz v0, :cond_0

    .line 101
    iget-object v0, p0, Lorg/cocos2dx/lib/Cocos2dxActivity;->mEditText:Lorg/cocos2dx/lib/Cocos2dxEditText;

    const/4 v1, 0x4

    invoke-virtual {v0, v1}, Lorg/cocos2dx/lib/Cocos2dxEditText;->setVisibility(I)V

    .line 103
    :cond_0
    return-void
.end method

.method protected onResume()V
    .locals 2

    .prologue
    .line 85
    invoke-super {p0}, Landroid/app/Activity;->onResume()V

    .line 87
    invoke-static {}, Lorg/cocos2dx/lib/Cocos2dxHelper;->onResume()V

    .line 88
    iget-object v0, p0, Lorg/cocos2dx/lib/Cocos2dxActivity;->mGLSurfaceView:Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;

    invoke-virtual {v0}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->onResume()V

    .line 89
    iget-object v0, p0, Lorg/cocos2dx/lib/Cocos2dxActivity;->mEditText:Lorg/cocos2dx/lib/Cocos2dxEditText;

    if-eqz v0, :cond_0

    .line 90
    iget-object v0, p0, Lorg/cocos2dx/lib/Cocos2dxActivity;->mEditText:Lorg/cocos2dx/lib/Cocos2dxEditText;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lorg/cocos2dx/lib/Cocos2dxEditText;->setVisibility(I)V

    .line 92
    :cond_0
    return-void
.end method

.method public runOnGLThread(Ljava/lang/Runnable;)V
    .locals 1
    .param p1, "pRunnable"    # Ljava/lang/Runnable;

    .prologue
    .line 123
    iget-object v0, p0, Lorg/cocos2dx/lib/Cocos2dxActivity;->mGLSurfaceView:Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;

    invoke-virtual {v0, p1}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->queueEvent(Ljava/lang/Runnable;)V

    .line 124
    return-void
.end method

.method public showDialog(Ljava/lang/String;Ljava/lang/String;)V
    .locals 2
    .param p1, "pTitle"    # Ljava/lang/String;
    .param p2, "pMessage"    # Ljava/lang/String;

    .prologue
    .line 107
    new-instance v0, Landroid/os/Message;

    invoke-direct {v0}, Landroid/os/Message;-><init>()V

    .line 108
    .local v0, "msg":Landroid/os/Message;
    const/4 v1, 0x1

    iput v1, v0, Landroid/os/Message;->what:I

    .line 109
    new-instance v1, Lorg/cocos2dx/lib/Cocos2dxHandler$DialogMessage;

    invoke-direct {v1, p1, p2}, Lorg/cocos2dx/lib/Cocos2dxHandler$DialogMessage;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    iput-object v1, v0, Landroid/os/Message;->obj:Ljava/lang/Object;

    .line 110
    iget-object v1, p0, Lorg/cocos2dx/lib/Cocos2dxActivity;->mHandler:Lorg/cocos2dx/lib/Cocos2dxHandler;

    invoke-virtual {v1, v0}, Lorg/cocos2dx/lib/Cocos2dxHandler;->sendMessage(Landroid/os/Message;)Z

    .line 111
    return-void
.end method

.method public showEditTextDialog(Ljava/lang/String;Ljava/lang/String;IIII)V
    .locals 8
    .param p1, "pTitle"    # Ljava/lang/String;
    .param p2, "pContent"    # Ljava/lang/String;
    .param p3, "pInputMode"    # I
    .param p4, "pInputFlag"    # I
    .param p5, "pReturnType"    # I
    .param p6, "pMaxLength"    # I

    .prologue
    .line 115
    new-instance v7, Landroid/os/Message;

    invoke-direct {v7}, Landroid/os/Message;-><init>()V

    .line 116
    .local v7, "msg":Landroid/os/Message;
    const/4 v0, 0x2

    iput v0, v7, Landroid/os/Message;->what:I

    .line 117
    new-instance v0, Lorg/cocos2dx/lib/Cocos2dxHandler$EditBoxMessage;

    move-object v1, p1

    move-object v2, p2

    move v3, p3

    move v4, p4

    move v5, p5

    move v6, p6

    invoke-direct/range {v0 .. v6}, Lorg/cocos2dx/lib/Cocos2dxHandler$EditBoxMessage;-><init>(Ljava/lang/String;Ljava/lang/String;IIII)V

    iput-object v0, v7, Landroid/os/Message;->obj:Ljava/lang/Object;

    .line 118
    iget-object v0, p0, Lorg/cocos2dx/lib/Cocos2dxActivity;->mHandler:Lorg/cocos2dx/lib/Cocos2dxHandler;

    invoke-virtual {v0, v7}, Lorg/cocos2dx/lib/Cocos2dxHandler;->sendMessage(Landroid/os/Message;)Z

    .line 119
    return-void
.end method
