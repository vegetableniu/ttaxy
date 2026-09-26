.class Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$SimpleEGLConfigChooser;
.super Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$ComponentSizeChooser;
.source "Cocos2dxGLSurfaceView.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "SimpleEGLConfigChooser"
.end annotation


# instance fields
.field final synthetic this$0:Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;


# direct methods
.method public constructor <init>(Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;Z)V
    .locals 8
    .param p2, "withDepthBuffer"    # Z

    .prologue
    const/4 v2, 0x5

    const/4 v5, 0x0

    .line 1266
    iput-object p1, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$SimpleEGLConfigChooser;->this$0:Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;

    .line 1267
    const/4 v3, 0x6

    if-eqz p2, :cond_0

    const/16 v6, 0x10

    :goto_0
    move-object v0, p0

    move-object v1, p1

    move v4, v2

    move v7, v5

    invoke-direct/range {v0 .. v7}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$ComponentSizeChooser;-><init>(Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;IIIIII)V

    .line 1268
    return-void

    :cond_0
    move v6, v5

    .line 1267
    goto :goto_0
.end method
