.class Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;
.super Ljava/lang/Thread;
.source "Cocos2dxGLSurfaceView.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = "GLThread"
.end annotation


# instance fields
.field private mEglHelper:Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$EglHelper;

.field private mEventQueue:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList",
            "<",
            "Ljava/lang/Runnable;",
            ">;"
        }
    .end annotation
.end field

.field private mExited:Z

.field private mHasSurface:Z

.field private mHaveEglContext:Z

.field private mHaveEglSurface:Z

.field private mHeight:I

.field private mPaused:Z

.field private mRenderComplete:Z

.field private mRenderMode:I

.field private mRenderer:Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$Renderer;

.field private mRequestPaused:Z

.field private mRequestRender:Z

.field private mShouldExit:Z

.field private mShouldReleaseEglContext:Z

.field private mWaitingForSurface:Z

.field private mWidth:I

.field final synthetic this$0:Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;


# direct methods
.method constructor <init>(Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$Renderer;)V
    .locals 3
    .param p1, "this$0"    # Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;
    .param p2, "renderer"    # Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$Renderer;

    .prologue
    const/4 v2, 0x1

    const/4 v1, 0x0

    .line 1500
    iput-object p1, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->this$0:Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;

    .line 1501
    invoke-direct {p0}, Ljava/lang/Thread;-><init>()V

    .line 1973
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->mEventQueue:Ljava/util/ArrayList;

    .line 1502
    iput v1, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->mWidth:I

    .line 1503
    iput v1, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->mHeight:I

    .line 1504
    iput-boolean v2, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->mRequestRender:Z

    .line 1505
    iput v2, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->mRenderMode:I

    .line 1506
    iput-object p2, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->mRenderer:Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$Renderer;

    .line 1507
    return-void
.end method

.method static synthetic access$1702(Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;Z)Z
    .locals 0
    .param p0, "x0"    # Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;
    .param p1, "x1"    # Z

    .prologue
    .line 1499
    iput-boolean p1, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->mExited:Z

    return p1
.end method

.method private guardedRun()V
    .locals 17
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/InterruptedException;
        }
    .end annotation

    .prologue
    .line 1548
    new-instance v14, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$EglHelper;

    move-object/from16 v0, p0

    iget-object v15, v0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->this$0:Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;

    invoke-direct {v14, v15}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$EglHelper;-><init>(Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;)V

    move-object/from16 v0, p0

    iput-object v14, v0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->mEglHelper:Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$EglHelper;

    .line 1549
    const/4 v14, 0x0

    move-object/from16 v0, p0

    iput-boolean v14, v0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->mHaveEglContext:Z

    .line 1550
    const/4 v14, 0x0

    move-object/from16 v0, p0

    iput-boolean v14, v0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->mHaveEglSurface:Z

    .line 1552
    const/4 v7, 0x0

    .line 1553
    .local v7, "gl":Ljavax/microedition/khronos/opengles/GL10;
    const/4 v3, 0x0

    .line 1554
    .local v3, "createEglContext":Z
    const/4 v4, 0x0

    .line 1555
    .local v4, "createEglSurface":Z
    const/4 v9, 0x0

    .line 1556
    .local v9, "lostEglContext":Z
    const/4 v10, 0x0

    .line 1557
    .local v10, "sizeChanged":Z
    const/4 v13, 0x0

    .line 1558
    .local v13, "wantRenderNotification":Z
    const/4 v5, 0x0

    .line 1559
    .local v5, "doRenderNotification":Z
    const/4 v1, 0x0

    .line 1560
    .local v1, "askedToReleaseEglContext":Z
    const/4 v12, 0x0

    .line 1561
    .local v12, "w":I
    const/4 v8, 0x0

    .line 1562
    .local v8, "h":I
    const/4 v6, 0x0

    .line 1565
    .local v6, "event":Ljava/lang/Runnable;
    :cond_0
    :goto_0
    :try_start_0
    invoke-static {}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->access$1300()Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThreadManager;

    move-result-object v15

    monitor-enter v15
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_2

    .line 1567
    :goto_1
    :try_start_1
    move-object/from16 v0, p0

    iget-boolean v14, v0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->mShouldExit:Z

    if-eqz v14, :cond_1

    .line 1568
    monitor-exit v15
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 1782
    invoke-static {}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->access$1300()Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThreadManager;

    move-result-object v15

    monitor-enter v15

    .line 1783
    :try_start_2
    invoke-direct/range {p0 .. p0}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->stopEglSurfaceLocked()V

    .line 1784
    invoke-direct/range {p0 .. p0}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->stopEglContextLocked()V

    .line 1785
    monitor-exit v15

    .line 1787
    :goto_2
    return-void

    .line 1785
    :catchall_0
    move-exception v14

    monitor-exit v15
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    throw v14

    .line 1571
    :cond_1
    :try_start_3
    move-object/from16 v0, p0

    iget-object v14, v0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->mEventQueue:Ljava/util/ArrayList;

    invoke-virtual {v14}, Ljava/util/ArrayList;->isEmpty()Z

    move-result v14

    if-nez v14, :cond_2

    .line 1572
    move-object/from16 v0, p0

    iget-object v14, v0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->mEventQueue:Ljava/util/ArrayList;

    const/16 v16, 0x0

    move/from16 v0, v16

    invoke-virtual {v14, v0}, Ljava/util/ArrayList;->remove(I)Ljava/lang/Object;

    move-result-object v14

    move-object v0, v14

    check-cast v0, Ljava/lang/Runnable;

    move-object v6, v0

    .line 1722
    :goto_3
    monitor-exit v15
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 1724
    if-eqz v6, :cond_12

    .line 1725
    :try_start_4
    invoke-interface {v6}, Ljava/lang/Runnable;->run()V
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_2

    .line 1726
    const/4 v6, 0x0

    .line 1727
    goto :goto_0

    .line 1577
    :cond_2
    :try_start_5
    move-object/from16 v0, p0

    iget-boolean v14, v0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->mPaused:Z

    move-object/from16 v0, p0

    iget-boolean v0, v0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->mRequestPaused:Z

    move/from16 v16, v0

    move/from16 v0, v16

    if-eq v14, v0, :cond_3

    .line 1578
    move-object/from16 v0, p0

    iget-boolean v14, v0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->mRequestPaused:Z

    move-object/from16 v0, p0

    iput-boolean v14, v0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->mPaused:Z

    .line 1579
    invoke-static {}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->access$1300()Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThreadManager;

    move-result-object v14

    invoke-virtual {v14}, Ljava/lang/Object;->notifyAll()V

    .line 1586
    :cond_3
    move-object/from16 v0, p0

    iget-boolean v14, v0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->mShouldReleaseEglContext:Z

    if-eqz v14, :cond_4

    .line 1590
    invoke-direct/range {p0 .. p0}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->stopEglSurfaceLocked()V

    .line 1591
    invoke-direct/range {p0 .. p0}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->stopEglContextLocked()V

    .line 1592
    const/4 v14, 0x0

    move-object/from16 v0, p0

    iput-boolean v14, v0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->mShouldReleaseEglContext:Z

    .line 1593
    const/4 v1, 0x1

    .line 1597
    :cond_4
    if-eqz v9, :cond_5

    .line 1598
    invoke-direct/range {p0 .. p0}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->stopEglSurfaceLocked()V

    .line 1599
    invoke-direct/range {p0 .. p0}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->stopEglContextLocked()V

    .line 1600
    const/4 v9, 0x0

    .line 1604
    :cond_5
    move-object/from16 v0, p0

    iget-boolean v14, v0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->mHaveEglSurface:Z

    if-eqz v14, :cond_8

    move-object/from16 v0, p0

    iget-boolean v14, v0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->mPaused:Z

    if-eqz v14, :cond_8

    .line 1608
    invoke-direct/range {p0 .. p0}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->stopEglSurfaceLocked()V

    .line 1609
    move-object/from16 v0, p0

    iget-object v14, v0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->this$0:Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;

    invoke-static {v14}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->access$1400(Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;)Z

    move-result v14

    if-eqz v14, :cond_6

    invoke-static {}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->access$1300()Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThreadManager;

    move-result-object v14

    invoke-virtual {v14}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThreadManager;->shouldReleaseEGLContextWhenPausing()Z

    move-result v14

    if-eqz v14, :cond_7

    .line 1610
    :cond_6
    invoke-direct/range {p0 .. p0}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->stopEglContextLocked()V

    .line 1615
    :cond_7
    invoke-static {}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->access$1300()Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThreadManager;

    move-result-object v14

    invoke-virtual {v14}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThreadManager;->shouldTerminateEGLWhenPausing()Z

    move-result v14

    if-eqz v14, :cond_8

    .line 1616
    move-object/from16 v0, p0

    iget-object v14, v0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->mEglHelper:Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$EglHelper;

    invoke-virtual {v14}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$EglHelper;->finish()V

    .line 1624
    :cond_8
    move-object/from16 v0, p0

    iget-boolean v14, v0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->mHasSurface:Z

    if-nez v14, :cond_a

    move-object/from16 v0, p0

    iget-boolean v14, v0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->mWaitingForSurface:Z

    if-nez v14, :cond_a

    .line 1628
    move-object/from16 v0, p0

    iget-boolean v14, v0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->mHaveEglSurface:Z

    if-eqz v14, :cond_9

    .line 1629
    invoke-direct/range {p0 .. p0}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->stopEglSurfaceLocked()V

    .line 1631
    :cond_9
    const/4 v14, 0x1

    move-object/from16 v0, p0

    iput-boolean v14, v0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->mWaitingForSurface:Z

    .line 1632
    invoke-static {}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->access$1300()Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThreadManager;

    move-result-object v14

    invoke-virtual {v14}, Ljava/lang/Object;->notifyAll()V

    .line 1636
    :cond_a
    move-object/from16 v0, p0

    iget-boolean v14, v0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->mHasSurface:Z

    if-eqz v14, :cond_b

    move-object/from16 v0, p0

    iget-boolean v14, v0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->mWaitingForSurface:Z

    if-eqz v14, :cond_b

    .line 1640
    const/4 v14, 0x0

    move-object/from16 v0, p0

    iput-boolean v14, v0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->mWaitingForSurface:Z

    .line 1641
    invoke-static {}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->access$1300()Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThreadManager;

    move-result-object v14

    invoke-virtual {v14}, Ljava/lang/Object;->notifyAll()V

    .line 1644
    :cond_b
    if-eqz v5, :cond_c

    .line 1648
    const/4 v13, 0x0

    .line 1649
    const/4 v5, 0x0

    .line 1650
    const/4 v14, 0x1

    move-object/from16 v0, p0

    iput-boolean v14, v0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->mRenderComplete:Z

    .line 1651
    invoke-static {}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->access$1300()Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThreadManager;

    move-result-object v14

    invoke-virtual {v14}, Ljava/lang/Object;->notifyAll()V

    .line 1655
    :cond_c
    invoke-direct/range {p0 .. p0}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->readyToDraw()Z

    move-result v14

    if-eqz v14, :cond_11

    .line 1658
    move-object/from16 v0, p0

    iget-boolean v14, v0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->mHaveEglContext:Z

    if-nez v14, :cond_d

    .line 1659
    if-eqz v1, :cond_f

    .line 1660
    const/4 v1, 0x0

    .line 1675
    :cond_d
    :goto_4
    move-object/from16 v0, p0

    iget-boolean v14, v0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->mHaveEglContext:Z

    if-eqz v14, :cond_e

    move-object/from16 v0, p0

    iget-boolean v14, v0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->mHaveEglSurface:Z

    if-nez v14, :cond_e

    .line 1676
    const/4 v14, 0x1

    move-object/from16 v0, p0

    iput-boolean v14, v0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->mHaveEglSurface:Z

    .line 1677
    const/4 v4, 0x1

    .line 1678
    const/4 v10, 0x1

    .line 1681
    :cond_e
    move-object/from16 v0, p0

    iget-boolean v14, v0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->mHaveEglSurface:Z

    if-eqz v14, :cond_11

    .line 1682
    move-object/from16 v0, p0

    iget-object v14, v0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->this$0:Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;

    invoke-static {v14}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->access$1500(Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;)Z

    move-result v14

    if-eqz v14, :cond_10

    .line 1683
    const/4 v10, 0x1

    .line 1684
    move-object/from16 v0, p0

    iget v12, v0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->mWidth:I

    .line 1685
    move-object/from16 v0, p0

    iget v8, v0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->mHeight:I

    .line 1686
    const/4 v13, 0x1

    .line 1698
    move-object/from16 v0, p0

    iget-object v14, v0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->this$0:Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;

    const/16 v16, 0x0

    move/from16 v0, v16

    invoke-static {v14, v0}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->access$1502(Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;Z)Z

    .line 1702
    :goto_5
    invoke-static {}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->access$1300()Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThreadManager;

    move-result-object v14

    invoke-virtual {v14}, Ljava/lang/Object;->notifyAll()V

    goto/16 :goto_3

    .line 1722
    :catchall_1
    move-exception v14

    monitor-exit v15
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_1

    :try_start_6
    throw v14
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_2

    .line 1782
    :catchall_2
    move-exception v14

    invoke-static {}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->access$1300()Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThreadManager;

    move-result-object v15

    monitor-enter v15

    .line 1783
    :try_start_7
    invoke-direct/range {p0 .. p0}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->stopEglSurfaceLocked()V

    .line 1784
    invoke-direct/range {p0 .. p0}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->stopEglContextLocked()V

    .line 1785
    monitor-exit v15
    :try_end_7
    .catchall {:try_start_7 .. :try_end_7} :catchall_4

    throw v14

    .line 1661
    :cond_f
    :try_start_8
    invoke-static {}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->access$1300()Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThreadManager;

    move-result-object v14

    move-object/from16 v0, p0

    invoke-virtual {v14, v0}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThreadManager;->tryAcquireEglContextLocked(Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;)Z
    :try_end_8
    .catchall {:try_start_8 .. :try_end_8} :catchall_1

    move-result v14

    if-eqz v14, :cond_d

    .line 1663
    :try_start_9
    move-object/from16 v0, p0

    iget-object v14, v0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->mEglHelper:Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$EglHelper;

    invoke-virtual {v14}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$EglHelper;->start()V
    :try_end_9
    .catch Ljava/lang/RuntimeException; {:try_start_9 .. :try_end_9} :catch_0
    .catchall {:try_start_9 .. :try_end_9} :catchall_1

    .line 1668
    const/4 v14, 0x1

    :try_start_a
    move-object/from16 v0, p0

    iput-boolean v14, v0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->mHaveEglContext:Z

    .line 1669
    const/4 v3, 0x1

    .line 1671
    invoke-static {}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->access$1300()Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThreadManager;

    move-result-object v14

    invoke-virtual {v14}, Ljava/lang/Object;->notifyAll()V

    goto :goto_4

    .line 1664
    :catch_0
    move-exception v11

    .line 1665
    .local v11, "t":Ljava/lang/RuntimeException;
    invoke-static {}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->access$1300()Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThreadManager;

    move-result-object v14

    move-object/from16 v0, p0

    invoke-virtual {v14, v0}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThreadManager;->releaseEglContextLocked(Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;)V

    .line 1666
    throw v11

    .line 1700
    .end local v11    # "t":Ljava/lang/RuntimeException;
    :cond_10
    const/4 v14, 0x0

    move-object/from16 v0, p0

    iput-boolean v14, v0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->mRequestRender:Z

    goto :goto_5

    .line 1720
    :cond_11
    invoke-static {}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->access$1300()Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThreadManager;

    move-result-object v14

    invoke-virtual {v14}, Ljava/lang/Object;->wait()V
    :try_end_a
    .catchall {:try_start_a .. :try_end_a} :catchall_1

    goto/16 :goto_1

    .line 1730
    :cond_12
    if-eqz v4, :cond_14

    .line 1734
    :try_start_b
    move-object/from16 v0, p0

    iget-object v14, v0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->mEglHelper:Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$EglHelper;

    move-object/from16 v0, p0

    iget-object v15, v0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->this$0:Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;

    invoke-virtual {v15}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->getHolder()Landroid/view/SurfaceHolder;

    move-result-object v15

    invoke-virtual {v14, v15}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$EglHelper;->createSurface(Landroid/view/SurfaceHolder;)Ljavax/microedition/khronos/opengles/GL;

    move-result-object v14

    move-object v0, v14

    check-cast v0, Ljavax/microedition/khronos/opengles/GL10;

    move-object v7, v0
    :try_end_b
    .catchall {:try_start_b .. :try_end_b} :catchall_2

    .line 1735
    if-nez v7, :cond_13

    .line 1782
    invoke-static {}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->access$1300()Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThreadManager;

    move-result-object v15

    monitor-enter v15

    .line 1783
    :try_start_c
    invoke-direct/range {p0 .. p0}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->stopEglSurfaceLocked()V

    .line 1784
    invoke-direct/range {p0 .. p0}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->stopEglContextLocked()V

    .line 1785
    monitor-exit v15

    goto/16 :goto_2

    :catchall_3
    move-exception v14

    monitor-exit v15
    :try_end_c
    .catchall {:try_start_c .. :try_end_c} :catchall_3

    throw v14

    .line 1739
    :cond_13
    :try_start_d
    invoke-static {}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->access$1300()Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThreadManager;

    move-result-object v14

    invoke-virtual {v14, v7}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThreadManager;->checkGLDriver(Ljavax/microedition/khronos/opengles/GL10;)V

    .line 1740
    const/4 v4, 0x0

    .line 1743
    :cond_14
    if-eqz v3, :cond_15

    .line 1747
    move-object/from16 v0, p0

    iget-object v14, v0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->mRenderer:Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$Renderer;

    move-object/from16 v0, p0

    iget-object v15, v0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->mEglHelper:Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$EglHelper;

    iget-object v15, v15, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$EglHelper;->mEglConfig:Ljavax/microedition/khronos/egl/EGLConfig;

    invoke-interface {v14, v7, v15}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$Renderer;->onSurfaceCreated(Ljavax/microedition/khronos/opengles/GL10;Ljavax/microedition/khronos/egl/EGLConfig;)V

    .line 1748
    const/4 v3, 0x0

    .line 1751
    :cond_15
    if-eqz v10, :cond_16

    .line 1755
    move-object/from16 v0, p0

    iget-object v14, v0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->mEglHelper:Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$EglHelper;

    invoke-virtual {v14}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$EglHelper;->purgeBuffers()V

    .line 1756
    move-object/from16 v0, p0

    iget-object v14, v0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->mRenderer:Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$Renderer;

    invoke-interface {v14, v7, v12, v8}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$Renderer;->onSurfaceChanged(Ljavax/microedition/khronos/opengles/GL10;II)V

    .line 1757
    const/4 v10, 0x0

    .line 1763
    :cond_16
    move-object/from16 v0, p0

    iget-object v14, v0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->mRenderer:Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$Renderer;

    invoke-interface {v14, v7}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$Renderer;->onDrawFrame(Ljavax/microedition/khronos/opengles/GL10;)Z

    move-result v2

    .line 1764
    .local v2, "bRenderSuc":Z
    if-eqz v2, :cond_17

    .line 1765
    move-object/from16 v0, p0

    iget-object v14, v0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->mEglHelper:Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$EglHelper;

    invoke-virtual {v14}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$EglHelper;->swap()Z
    :try_end_d
    .catchall {:try_start_d .. :try_end_d} :catchall_2

    move-result v14

    if-nez v14, :cond_17

    .line 1769
    const/4 v9, 0x1

    .line 1773
    :cond_17
    if-eqz v13, :cond_0

    .line 1774
    const/4 v5, 0x1

    goto/16 :goto_0

    .line 1785
    .end local v2    # "bRenderSuc":Z
    :catchall_4
    move-exception v14

    :try_start_e
    monitor-exit v15
    :try_end_e
    .catchall {:try_start_e .. :try_end_e} :catchall_4

    throw v14
.end method

.method private readyToDraw()Z
    .locals 2

    .prologue
    const/4 v0, 0x1

    .line 1794
    iget-boolean v1, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->mPaused:Z

    if-nez v1, :cond_1

    iget-boolean v1, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->mHasSurface:Z

    if-eqz v1, :cond_1

    iget v1, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->mWidth:I

    if-lez v1, :cond_1

    iget v1, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->mHeight:I

    if-lez v1, :cond_1

    iget-boolean v1, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->mRequestRender:Z

    if-nez v1, :cond_0

    iget v1, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->mRenderMode:I

    if-ne v1, v0, :cond_1

    :cond_0
    :goto_0
    return v0

    :cond_1
    const/4 v0, 0x0

    goto :goto_0
.end method

.method private stopEglContextLocked()V
    .locals 1

    .prologue
    .line 1541
    iget-boolean v0, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->mHaveEglContext:Z

    if-eqz v0, :cond_0

    .line 1542
    iget-object v0, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->mEglHelper:Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$EglHelper;

    invoke-virtual {v0}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$EglHelper;->finish()V

    .line 1543
    const/4 v0, 0x0

    iput-boolean v0, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->mHaveEglContext:Z

    .line 1544
    invoke-static {}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->access$1300()Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThreadManager;

    move-result-object v0

    invoke-virtual {v0, p0}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThreadManager;->releaseEglContextLocked(Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;)V

    .line 1546
    :cond_0
    return-void
.end method

.method private stopEglSurfaceLocked()V
    .locals 1

    .prologue
    .line 1530
    iget-boolean v0, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->mHaveEglSurface:Z

    if-eqz v0, :cond_0

    .line 1531
    const/4 v0, 0x0

    iput-boolean v0, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->mHaveEglSurface:Z

    .line 1532
    iget-object v0, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->mEglHelper:Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$EglHelper;

    invoke-virtual {v0}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$EglHelper;->destroySurface()V

    .line 1534
    :cond_0
    return-void
.end method


# virtual methods
.method public ableToDraw()Z
    .locals 1

    .prologue
    .line 1790
    iget-boolean v0, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->mHaveEglContext:Z

    if-eqz v0, :cond_0

    iget-boolean v0, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->mHaveEglSurface:Z

    if-eqz v0, :cond_0

    invoke-direct {p0}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->readyToDraw()Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    :goto_0
    return v0

    :cond_0
    const/4 v0, 0x0

    goto :goto_0
.end method

.method public getRenderMode()I
    .locals 2

    .prologue
    .line 1810
    invoke-static {}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->access$1300()Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThreadManager;

    move-result-object v1

    monitor-enter v1

    .line 1811
    :try_start_0
    iget v0, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->mRenderMode:I

    monitor-exit v1

    return v0

    .line 1812
    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method public onPause()V
    .locals 3

    .prologue
    .line 1857
    invoke-static {}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->access$1300()Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThreadManager;

    move-result-object v2

    monitor-enter v2

    .line 1861
    const/4 v1, 0x1

    :try_start_0
    iput-boolean v1, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->mRequestPaused:Z

    .line 1862
    invoke-static {}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->access$1300()Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThreadManager;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Object;->notifyAll()V

    .line 1863
    :goto_0
    iget-boolean v1, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->mExited:Z

    if-nez v1, :cond_0

    iget-boolean v1, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->mPaused:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-nez v1, :cond_0

    .line 1868
    :try_start_1
    invoke-static {}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->access$1300()Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThreadManager;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Object;->wait()V
    :try_end_1
    .catch Ljava/lang/InterruptedException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    .line 1869
    :catch_0
    move-exception v0

    .line 1870
    .local v0, "ex":Ljava/lang/InterruptedException;
    :try_start_2
    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Thread;->interrupt()V

    goto :goto_0

    .line 1873
    .end local v0    # "ex":Ljava/lang/InterruptedException;
    :catchall_0
    move-exception v1

    monitor-exit v2
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    throw v1

    :cond_0
    :try_start_3
    monitor-exit v2
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 1874
    return-void
.end method

.method public onResume()V
    .locals 3

    .prologue
    .line 1877
    invoke-static {}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->access$1300()Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThreadManager;

    move-result-object v2

    monitor-enter v2

    .line 1881
    const/4 v1, 0x0

    :try_start_0
    iput-boolean v1, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->mRequestPaused:Z

    .line 1882
    const/4 v1, 0x1

    iput-boolean v1, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->mRequestRender:Z

    .line 1883
    const/4 v1, 0x0

    iput-boolean v1, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->mRenderComplete:Z

    .line 1884
    invoke-static {}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->access$1300()Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThreadManager;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Object;->notifyAll()V

    .line 1885
    :goto_0
    iget-boolean v1, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->mExited:Z

    if-nez v1, :cond_0

    iget-boolean v1, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->mPaused:Z

    if-eqz v1, :cond_0

    iget-boolean v1, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->mRenderComplete:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-nez v1, :cond_0

    .line 1890
    :try_start_1
    invoke-static {}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->access$1300()Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThreadManager;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Object;->wait()V
    :try_end_1
    .catch Ljava/lang/InterruptedException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    .line 1891
    :catch_0
    move-exception v0

    .line 1892
    .local v0, "ex":Ljava/lang/InterruptedException;
    :try_start_2
    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Thread;->interrupt()V

    goto :goto_0

    .line 1895
    .end local v0    # "ex":Ljava/lang/InterruptedException;
    :catchall_0
    move-exception v1

    monitor-exit v2
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    throw v1

    :cond_0
    :try_start_3
    monitor-exit v2
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 1896
    return-void
.end method

.method public onWindowResize(II)V
    .locals 4
    .param p1, "w"    # I
    .param p2, "h"    # I

    .prologue
    .line 1899
    invoke-static {}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->access$1300()Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThreadManager;

    move-result-object v2

    monitor-enter v2

    .line 1900
    :try_start_0
    iput p1, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->mWidth:I

    .line 1901
    iput p2, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->mHeight:I

    .line 1902
    iget-object v1, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->this$0:Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;

    const/4 v3, 0x1

    invoke-static {v1, v3}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->access$1502(Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;Z)Z

    .line 1903
    const/4 v1, 0x1

    iput-boolean v1, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->mRequestRender:Z

    .line 1904
    const/4 v1, 0x0

    iput-boolean v1, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->mRenderComplete:Z

    .line 1905
    invoke-static {}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->access$1300()Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThreadManager;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Object;->notifyAll()V

    .line 1908
    :goto_0
    iget-boolean v1, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->mExited:Z

    if-nez v1, :cond_0

    iget-boolean v1, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->mPaused:Z

    if-nez v1, :cond_0

    iget-boolean v1, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->mRenderComplete:Z

    if-nez v1, :cond_0

    iget-object v1, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->this$0:Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;

    .line 1909
    invoke-static {v1}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->access$1600(Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;)Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;

    move-result-object v1

    if-eqz v1, :cond_0

    iget-object v1, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->this$0:Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;

    invoke-static {v1}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->access$1600(Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;)Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;

    move-result-object v1

    invoke-virtual {v1}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->ableToDraw()Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-result v1

    if-eqz v1, :cond_0

    .line 1914
    :try_start_1
    invoke-static {}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->access$1300()Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThreadManager;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Object;->wait()V
    :try_end_1
    .catch Ljava/lang/InterruptedException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    .line 1915
    :catch_0
    move-exception v0

    .line 1916
    .local v0, "ex":Ljava/lang/InterruptedException;
    :try_start_2
    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Thread;->interrupt()V

    goto :goto_0

    .line 1919
    .end local v0    # "ex":Ljava/lang/InterruptedException;
    :catchall_0
    move-exception v1

    monitor-exit v2
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    throw v1

    :cond_0
    :try_start_3
    monitor-exit v2
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 1920
    return-void
.end method

.method public queueEvent(Ljava/lang/Runnable;)V
    .locals 2
    .param p1, "r"    # Ljava/lang/Runnable;

    .prologue
    .line 1948
    if-nez p1, :cond_0

    .line 1949
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "r must not be null"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 1951
    :cond_0
    invoke-static {}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->access$1300()Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThreadManager;

    move-result-object v1

    monitor-enter v1

    .line 1952
    :try_start_0
    iget-object v0, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->mEventQueue:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    .line 1953
    invoke-static {}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->access$1300()Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThreadManager;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->notifyAll()V

    .line 1954
    monitor-exit v1

    .line 1955
    return-void

    .line 1954
    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method public requestExitAndWait()V
    .locals 3

    .prologue
    .line 1925
    invoke-static {}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->access$1300()Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThreadManager;

    move-result-object v2

    monitor-enter v2

    .line 1926
    const/4 v1, 0x1

    :try_start_0
    iput-boolean v1, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->mShouldExit:Z

    .line 1927
    invoke-static {}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->access$1300()Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThreadManager;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Object;->notifyAll()V

    .line 1928
    :goto_0
    iget-boolean v1, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->mExited:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-nez v1, :cond_0

    .line 1930
    :try_start_1
    invoke-static {}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->access$1300()Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThreadManager;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Object;->wait()V
    :try_end_1
    .catch Ljava/lang/InterruptedException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    .line 1931
    :catch_0
    move-exception v0

    .line 1932
    .local v0, "ex":Ljava/lang/InterruptedException;
    :try_start_2
    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Thread;->interrupt()V

    goto :goto_0

    .line 1935
    .end local v0    # "ex":Ljava/lang/InterruptedException;
    :catchall_0
    move-exception v1

    monitor-exit v2
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    throw v1

    :cond_0
    :try_start_3
    monitor-exit v2
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 1936
    return-void
.end method

.method public requestReleaseEglContextLocked()V
    .locals 1

    .prologue
    .line 1939
    const/4 v0, 0x1

    iput-boolean v0, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->mShouldReleaseEglContext:Z

    .line 1940
    invoke-static {}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->access$1300()Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThreadManager;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->notifyAll()V

    .line 1941
    return-void
.end method

.method public requestRender()V
    .locals 2

    .prologue
    .line 1816
    invoke-static {}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->access$1300()Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThreadManager;

    move-result-object v1

    monitor-enter v1

    .line 1817
    const/4 v0, 0x1

    :try_start_0
    iput-boolean v0, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->mRequestRender:Z

    .line 1818
    invoke-static {}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->access$1300()Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThreadManager;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->notifyAll()V

    .line 1819
    monitor-exit v1

    .line 1820
    return-void

    .line 1819
    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method public run()V
    .locals 4

    .prologue
    .line 1511
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "GLThread "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->getId()J

    move-result-wide v2

    invoke-virtual {v1, v2, v3}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->setName(Ljava/lang/String;)V

    .line 1517
    :try_start_0
    invoke-direct {p0}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->guardedRun()V
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 1523
    :goto_0
    return-void

    .line 1518
    :catch_0
    move-exception v0

    .line 1519
    .local v0, "e":Ljava/lang/InterruptedException;
    :try_start_1
    invoke-virtual {v0}, Ljava/lang/InterruptedException;->printStackTrace()V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    .line 1520
    .end local v0    # "e":Ljava/lang/InterruptedException;
    :catchall_0
    move-exception v1

    throw v1
.end method

.method public setRenderMode(I)V
    .locals 2
    .param p1, "renderMode"    # I

    .prologue
    .line 1800
    if-ltz p1, :cond_0

    const/4 v0, 0x1

    if-le p1, v0, :cond_1

    .line 1801
    :cond_0
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "renderMode"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 1803
    :cond_1
    invoke-static {}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->access$1300()Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThreadManager;

    move-result-object v1

    monitor-enter v1

    .line 1804
    :try_start_0
    iput p1, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->mRenderMode:I

    .line 1805
    invoke-static {}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->access$1300()Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThreadManager;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->notifyAll()V

    .line 1806
    monitor-exit v1

    .line 1807
    return-void

    .line 1806
    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v0
.end method

.method public surfaceCreated()V
    .locals 3

    .prologue
    .line 1823
    invoke-static {}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->access$1300()Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThreadManager;

    move-result-object v2

    monitor-enter v2

    .line 1827
    const/4 v1, 0x1

    :try_start_0
    iput-boolean v1, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->mHasSurface:Z

    .line 1828
    invoke-static {}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->access$1300()Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThreadManager;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Object;->notifyAll()V

    .line 1829
    :goto_0
    iget-boolean v1, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->mWaitingForSurface:Z

    if-eqz v1, :cond_0

    iget-boolean v1, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->mExited:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-nez v1, :cond_0

    .line 1831
    :try_start_1
    invoke-static {}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->access$1300()Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThreadManager;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Object;->wait()V
    :try_end_1
    .catch Ljava/lang/InterruptedException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    .line 1832
    :catch_0
    move-exception v0

    .line 1833
    .local v0, "e":Ljava/lang/InterruptedException;
    :try_start_2
    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Thread;->interrupt()V

    goto :goto_0

    .line 1836
    .end local v0    # "e":Ljava/lang/InterruptedException;
    :catchall_0
    move-exception v1

    monitor-exit v2
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    throw v1

    :cond_0
    :try_start_3
    monitor-exit v2
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 1837
    return-void
.end method

.method public surfaceDestroyed()V
    .locals 3

    .prologue
    .line 1840
    invoke-static {}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->access$1300()Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThreadManager;

    move-result-object v2

    monitor-enter v2

    .line 1844
    const/4 v1, 0x0

    :try_start_0
    iput-boolean v1, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->mHasSurface:Z

    .line 1845
    invoke-static {}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->access$1300()Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThreadManager;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Object;->notifyAll()V

    .line 1846
    :goto_0
    iget-boolean v1, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->mWaitingForSurface:Z

    if-nez v1, :cond_0

    iget-boolean v1, p0, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThread;->mExited:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    if-nez v1, :cond_0

    .line 1848
    :try_start_1
    invoke-static {}, Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView;->access$1300()Lorg/cocos2dx/lib/Cocos2dxGLSurfaceView$GLThreadManager;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Object;->wait()V
    :try_end_1
    .catch Ljava/lang/InterruptedException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_0

    .line 1849
    :catch_0
    move-exception v0

    .line 1850
    .local v0, "e":Ljava/lang/InterruptedException;
    :try_start_2
    invoke-static {}, Ljava/lang/Thread;->currentThread()Ljava/lang/Thread;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Thread;->interrupt()V

    goto :goto_0

    .line 1853
    .end local v0    # "e":Ljava/lang/InterruptedException;
    :catchall_0
    move-exception v1

    monitor-exit v2
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    throw v1

    :cond_0
    :try_start_3
    monitor-exit v2
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 1854
    return-void
.end method
