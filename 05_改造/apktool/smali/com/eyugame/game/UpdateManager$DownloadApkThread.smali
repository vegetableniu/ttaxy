.class Lcom/eyugame/game/UpdateManager$DownloadApkThread;
.super Ljava/lang/Thread;
.source "UpdateManager.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/eyugame/game/UpdateManager;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "DownloadApkThread"
.end annotation


# instance fields
.field final synthetic this$0:Lcom/eyugame/game/UpdateManager;


# direct methods
.method private constructor <init>(Lcom/eyugame/game/UpdateManager;)V
    .locals 0

    .prologue
    .line 361
    iput-object p1, p0, Lcom/eyugame/game/UpdateManager$DownloadApkThread;->this$0:Lcom/eyugame/game/UpdateManager;

    invoke-direct {p0}, Ljava/lang/Thread;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/eyugame/game/UpdateManager;Lcom/eyugame/game/UpdateManager$1;)V
    .locals 0
    .param p1, "x0"    # Lcom/eyugame/game/UpdateManager;
    .param p2, "x1"    # Lcom/eyugame/game/UpdateManager$1;

    .prologue
    .line 361
    invoke-direct {p0, p1}, Lcom/eyugame/game/UpdateManager$DownloadApkThread;-><init>(Lcom/eyugame/game/UpdateManager;)V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 23

    .prologue
    .line 364
    const/4 v10, 0x0

    .line 365
    .local v10, "fos":Ljava/io/FileOutputStream;
    const/4 v12, 0x0

    .line 369
    .local v12, "is":Ljava/io/InputStream;
    :try_start_0
    invoke-static {}, Landroid/os/Environment;->getExternalStorageState()Ljava/lang/String;

    move-result-object v16

    .line 370
    .local v16, "strSdcardState":Ljava/lang/String;
    const-string v19, "mounted"

    move-object/from16 v0, v16

    move-object/from16 v1, v19

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v19

    if-nez v19, :cond_3

    .line 371
    invoke-static {}, Lcom/eyugame/game/UpdateManager;->access$1400()Lcom/eyugame/game/UpdateManager$DwonloadApkHandler;

    move-result-object v20

    const-string v19, "shared"

    move-object/from16 v0, v16

    move-object/from16 v1, v19

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v19

    if-eqz v19, :cond_2

    const/16 v19, 0x4

    :goto_0
    move-object/from16 v0, v20

    move/from16 v1, v19

    invoke-virtual {v0, v1}, Lcom/eyugame/game/UpdateManager$DwonloadApkHandler;->sendEmptyMessage(I)Z

    .line 372
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/eyugame/game/UpdateManager$DownloadApkThread;->this$0:Lcom/eyugame/game/UpdateManager;

    move-object/from16 v19, v0

    invoke-static/range {v19 .. v19}, Lcom/eyugame/game/UpdateManager;->access$1500(Lcom/eyugame/game/UpdateManager;)Landroid/app/Dialog;

    move-result-object v19

    invoke-virtual/range {v19 .. v19}, Landroid/app/Dialog;->dismiss()V
    :try_end_0
    .catch Ljava/net/MalformedURLException; {:try_start_0 .. :try_end_0} :catch_3
    .catch Ljava/net/SocketException; {:try_start_0 .. :try_end_0} :catch_5
    .catch Ljava/net/UnknownHostException; {:try_start_0 .. :try_end_0} :catch_7
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_9
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 440
    if-eqz v10, :cond_0

    .line 441
    :try_start_1
    invoke-virtual {v10}, Ljava/io/FileOutputStream;->close()V

    .line 444
    :cond_0
    if-eqz v12, :cond_1

    .line 445
    invoke-virtual {v12}, Ljava/io/InputStream;->close()V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_0

    .line 453
    .end local v16    # "strSdcardState":Ljava/lang/String;
    :cond_1
    :goto_1
    return-void

    .line 371
    .restart local v16    # "strSdcardState":Ljava/lang/String;
    :cond_2
    const/16 v19, 0x3

    goto :goto_0

    .line 447
    :catch_0
    move-exception v5

    .line 448
    .local v5, "e":Ljava/io/IOException;
    invoke-virtual {v5}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_1

    .line 376
    .end local v5    # "e":Ljava/io/IOException;
    :cond_3
    :try_start_2
    new-instance v18, Ljava/net/URL;

    new-instance v19, Ljava/lang/StringBuilder;

    invoke-direct/range {v19 .. v19}, Ljava/lang/StringBuilder;-><init>()V

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/eyugame/game/UpdateManager$DownloadApkThread;->this$0:Lcom/eyugame/game/UpdateManager;

    move-object/from16 v20, v0

    invoke-static/range {v20 .. v20}, Lcom/eyugame/game/UpdateManager;->access$1000(Lcom/eyugame/game/UpdateManager;)Ljava/lang/String;

    move-result-object v20

    invoke-virtual/range {v19 .. v20}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v20

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/eyugame/game/UpdateManager$DownloadApkThread;->this$0:Lcom/eyugame/game/UpdateManager;

    move-object/from16 v19, v0

    move-object/from16 v0, v19

    iget-object v0, v0, Lcom/eyugame/game/UpdateManager;->mHashMap:Ljava/util/HashMap;

    move-object/from16 v19, v0

    const-string v21, "url"

    move-object/from16 v0, v19

    move-object/from16 v1, v21

    invoke-virtual {v0, v1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v19

    check-cast v19, Ljava/lang/String;

    invoke-virtual/range {v19 .. v19}, Ljava/lang/String;->toString()Ljava/lang/String;

    move-result-object v19

    move-object/from16 v0, v20

    move-object/from16 v1, v19

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v19

    invoke-virtual/range {v19 .. v19}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v19

    invoke-direct/range {v18 .. v19}, Ljava/net/URL;-><init>(Ljava/lang/String;)V

    .line 378
    .local v18, "url":Ljava/net/URL;
    invoke-virtual/range {v18 .. v18}, Ljava/net/URL;->openConnection()Ljava/net/URLConnection;

    move-result-object v4

    check-cast v4, Ljava/net/HttpURLConnection;

    .line 379
    .local v4, "conn":Ljava/net/HttpURLConnection;
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/eyugame/game/UpdateManager$DownloadApkThread;->this$0:Lcom/eyugame/game/UpdateManager;

    move-object/from16 v19, v0

    invoke-static/range {v19 .. v19}, Lcom/eyugame/game/UpdateManager;->access$1600(Lcom/eyugame/game/UpdateManager;)I

    move-result v19

    move/from16 v0, v19

    invoke-virtual {v4, v0}, Ljava/net/HttpURLConnection;->setConnectTimeout(I)V

    .line 381
    new-instance v8, Ljava/io/File;

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/eyugame/game/UpdateManager$DownloadApkThread;->this$0:Lcom/eyugame/game/UpdateManager;

    move-object/from16 v19, v0

    invoke-static/range {v19 .. v19}, Lcom/eyugame/game/UpdateManager;->access$800(Lcom/eyugame/game/UpdateManager;)Ljava/lang/String;

    move-result-object v19

    move-object/from16 v0, v19

    invoke-direct {v8, v0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 383
    .local v8, "file":Ljava/io/File;
    invoke-virtual {v8}, Ljava/io/File;->exists()Z

    move-result v19

    if-nez v19, :cond_4

    .line 385
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/eyugame/game/UpdateManager$DownloadApkThread;->this$0:Lcom/eyugame/game/UpdateManager;

    move-object/from16 v19, v0

    invoke-static/range {v19 .. v19}, Lcom/eyugame/game/UpdateManager;->access$800(Lcom/eyugame/game/UpdateManager;)Ljava/lang/String;

    move-result-object v19

    invoke-static/range {v19 .. v19}, Lcom/eyugame/base/LocationUtils;->makeDirectory(Ljava/lang/String;)Z

    .line 387
    :cond_4
    new-instance v2, Ljava/io/File;

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/eyugame/game/UpdateManager$DownloadApkThread;->this$0:Lcom/eyugame/game/UpdateManager;

    move-object/from16 v19, v0

    invoke-static/range {v19 .. v19}, Lcom/eyugame/game/UpdateManager;->access$800(Lcom/eyugame/game/UpdateManager;)Ljava/lang/String;

    move-result-object v20

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/eyugame/game/UpdateManager$DownloadApkThread;->this$0:Lcom/eyugame/game/UpdateManager;

    move-object/from16 v19, v0

    move-object/from16 v0, v19

    iget-object v0, v0, Lcom/eyugame/game/UpdateManager;->mHashMap:Ljava/util/HashMap;

    move-object/from16 v19, v0

    const-string v21, "name"

    move-object/from16 v0, v19

    move-object/from16 v1, v21

    invoke-virtual {v0, v1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v19

    check-cast v19, Ljava/lang/String;

    move-object/from16 v0, v20

    move-object/from16 v1, v19

    invoke-direct {v2, v0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    .line 389
    .local v2, "apkFile":Ljava/io/File;
    const-wide/16 v6, 0x0

    .line 390
    .local v6, "count":J
    invoke-virtual {v2}, Ljava/io/File;->isFile()Z

    move-result v19

    if-eqz v19, :cond_6

    invoke-virtual {v2}, Ljava/io/File;->exists()Z

    move-result v19

    if-eqz v19, :cond_6

    .line 391
    invoke-virtual {v2}, Ljava/io/File;->length()J

    move-result-wide v6

    .line 392
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/eyugame/game/UpdateManager$DownloadApkThread;->this$0:Lcom/eyugame/game/UpdateManager;

    move-object/from16 v19, v0

    move-object/from16 v0, v19

    iget-object v0, v0, Lcom/eyugame/game/UpdateManager;->mHashMap:Ljava/util/HashMap;

    move-object/from16 v19, v0

    const-string v20, "size"

    invoke-virtual/range {v19 .. v20}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v19

    check-cast v19, Ljava/lang/String;

    invoke-virtual/range {v19 .. v19}, Ljava/lang/String;->toString()Ljava/lang/String;

    move-result-object v19

    invoke-static/range {v19 .. v19}, Ljava/lang/Integer;->valueOf(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object v19

    invoke-virtual/range {v19 .. v19}, Ljava/lang/Integer;->intValue()I

    move-result v9

    .line 393
    .local v9, "fileSize":I
    int-to-long v0, v9

    move-wide/from16 v20, v0

    cmp-long v19, v6, v20

    if-lez v19, :cond_c

    .line 394
    invoke-virtual {v2}, Ljava/io/File;->delete()Z

    .line 395
    const-wide/16 v6, 0x0

    .line 400
    :cond_5
    const-string v19, "User-Agent"

    const-string v20, "NetFox"

    move-object/from16 v0, v19

    move-object/from16 v1, v20

    invoke-virtual {v4, v0, v1}, Ljava/net/HttpURLConnection;->setRequestProperty(Ljava/lang/String;Ljava/lang/String;)V

    .line 401
    const-string v19, "bytes=%d-"

    const/16 v20, 0x1

    move/from16 v0, v20

    new-array v0, v0, [Ljava/lang/Object;

    move-object/from16 v20, v0

    const/16 v21, 0x0

    invoke-static {v6, v7}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v22

    aput-object v22, v20, v21

    invoke-static/range {v19 .. v20}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v17

    .line 402
    .local v17, "strStartPos":Ljava/lang/String;
    const-string v19, "RANGE"

    move-object/from16 v0, v19

    move-object/from16 v1, v17

    invoke-virtual {v4, v0, v1}, Ljava/net/HttpURLConnection;->setRequestProperty(Ljava/lang/String;Ljava/lang/String;)V

    .line 404
    .end local v9    # "fileSize":I
    .end local v17    # "strStartPos":Ljava/lang/String;
    :cond_6
    new-instance v11, Ljava/io/FileOutputStream;

    const/16 v19, 0x1

    move/from16 v0, v19

    invoke-direct {v11, v2, v0}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;Z)V
    :try_end_2
    .catch Ljava/net/MalformedURLException; {:try_start_2 .. :try_end_2} :catch_3
    .catch Ljava/net/SocketException; {:try_start_2 .. :try_end_2} :catch_5
    .catch Ljava/net/UnknownHostException; {:try_start_2 .. :try_end_2} :catch_7
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_9
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 406
    .end local v10    # "fos":Ljava/io/FileOutputStream;
    .local v11, "fos":Ljava/io/FileOutputStream;
    const/16 v19, 0x400

    :try_start_3
    move/from16 v0, v19

    new-array v3, v0, [B

    .line 409
    .local v3, "buf":[B
    invoke-virtual {v4}, Ljava/net/HttpURLConnection;->connect()V

    .line 410
    invoke-virtual {v4}, Ljava/net/HttpURLConnection;->getContentLength()I

    move-result v19

    move/from16 v0, v19

    int-to-long v0, v0

    move-wide/from16 v20, v0

    add-long v14, v20, v6

    .line 412
    .local v14, "length":J
    invoke-virtual {v4}, Ljava/net/HttpURLConnection;->getInputStream()Ljava/io/InputStream;

    move-result-object v12

    .line 415
    :cond_7
    invoke-virtual {v12, v3}, Ljava/io/InputStream;->read([B)I

    move-result v13

    .line 417
    .local v13, "numread":I
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/eyugame/game/UpdateManager$DownloadApkThread;->this$0:Lcom/eyugame/game/UpdateManager;

    move-object/from16 v19, v0

    long-to-float v0, v6

    move/from16 v20, v0

    long-to-float v0, v14

    move/from16 v21, v0

    div-float v20, v20, v21

    const/high16 v21, 0x42c80000    # 100.0f

    mul-float v20, v20, v21

    move/from16 v0, v20

    float-to-int v0, v0

    move/from16 v20, v0

    invoke-static/range {v19 .. v20}, Lcom/eyugame/game/UpdateManager;->access$002(Lcom/eyugame/game/UpdateManager;I)I

    .line 419
    invoke-static {}, Lcom/eyugame/game/UpdateManager;->access$1400()Lcom/eyugame/game/UpdateManager$DwonloadApkHandler;

    move-result-object v19

    const/16 v20, 0x1

    invoke-virtual/range {v19 .. v20}, Lcom/eyugame/game/UpdateManager$DwonloadApkHandler;->sendEmptyMessage(I)Z

    .line 420
    if-lez v13, :cond_8

    cmp-long v19, v6, v14

    if-ltz v19, :cond_e

    .line 423
    :cond_8
    invoke-static {}, Lcom/eyugame/game/UpdateManager;->access$1400()Lcom/eyugame/game/UpdateManager$DwonloadApkHandler;

    move-result-object v19

    const/16 v20, 0x2

    invoke-virtual/range {v19 .. v20}, Lcom/eyugame/game/UpdateManager$DwonloadApkHandler;->sendEmptyMessage(I)Z
    :try_end_3
    .catch Ljava/net/MalformedURLException; {:try_start_3 .. :try_end_3} :catch_f
    .catch Ljava/net/SocketException; {:try_start_3 .. :try_end_3} :catch_e
    .catch Ljava/net/UnknownHostException; {:try_start_3 .. :try_end_3} :catch_d
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_c
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 440
    :goto_2
    if-eqz v11, :cond_9

    .line 441
    :try_start_4
    invoke-virtual {v11}, Ljava/io/FileOutputStream;->close()V

    .line 444
    :cond_9
    if-eqz v12, :cond_a

    .line 445
    invoke-virtual {v12}, Ljava/io/InputStream;->close()V
    :try_end_4
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_2

    :cond_a
    move-object v10, v11

    .line 452
    .end local v2    # "apkFile":Ljava/io/File;
    .end local v3    # "buf":[B
    .end local v4    # "conn":Ljava/net/HttpURLConnection;
    .end local v6    # "count":J
    .end local v8    # "file":Ljava/io/File;
    .end local v11    # "fos":Ljava/io/FileOutputStream;
    .end local v13    # "numread":I
    .end local v14    # "length":J
    .end local v16    # "strSdcardState":Ljava/lang/String;
    .end local v18    # "url":Ljava/net/URL;
    .restart local v10    # "fos":Ljava/io/FileOutputStream;
    :cond_b
    :goto_3
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/eyugame/game/UpdateManager$DownloadApkThread;->this$0:Lcom/eyugame/game/UpdateManager;

    move-object/from16 v19, v0

    invoke-static/range {v19 .. v19}, Lcom/eyugame/game/UpdateManager;->access$1500(Lcom/eyugame/game/UpdateManager;)Landroid/app/Dialog;

    move-result-object v19

    invoke-virtual/range {v19 .. v19}, Landroid/app/Dialog;->dismiss()V

    goto/16 :goto_1

    .line 396
    .restart local v2    # "apkFile":Ljava/io/File;
    .restart local v4    # "conn":Ljava/net/HttpURLConnection;
    .restart local v6    # "count":J
    .restart local v8    # "file":Ljava/io/File;
    .restart local v9    # "fileSize":I
    .restart local v16    # "strSdcardState":Ljava/lang/String;
    .restart local v18    # "url":Ljava/net/URL;
    :cond_c
    int-to-long v0, v9

    move-wide/from16 v20, v0

    cmp-long v19, v6, v20

    if-nez v19, :cond_5

    .line 397
    :try_start_5
    invoke-static {}, Lcom/eyugame/game/UpdateManager;->access$1400()Lcom/eyugame/game/UpdateManager$DwonloadApkHandler;

    move-result-object v19

    const/16 v20, 0x2

    invoke-virtual/range {v19 .. v20}, Lcom/eyugame/game/UpdateManager$DwonloadApkHandler;->sendEmptyMessage(I)Z
    :try_end_5
    .catch Ljava/net/MalformedURLException; {:try_start_5 .. :try_end_5} :catch_3
    .catch Ljava/net/SocketException; {:try_start_5 .. :try_end_5} :catch_5
    .catch Ljava/net/UnknownHostException; {:try_start_5 .. :try_end_5} :catch_7
    .catch Ljava/io/IOException; {:try_start_5 .. :try_end_5} :catch_9
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    .line 440
    if-eqz v10, :cond_d

    .line 441
    :try_start_6
    invoke-virtual {v10}, Ljava/io/FileOutputStream;->close()V

    .line 444
    :cond_d
    if-eqz v12, :cond_1

    .line 445
    invoke-virtual {v12}, Ljava/io/InputStream;->close()V
    :try_end_6
    .catch Ljava/io/IOException; {:try_start_6 .. :try_end_6} :catch_1

    goto/16 :goto_1

    .line 447
    :catch_1
    move-exception v5

    .line 448
    .restart local v5    # "e":Ljava/io/IOException;
    invoke-virtual {v5}, Ljava/io/IOException;->printStackTrace()V

    goto/16 :goto_1

    .line 427
    .end local v5    # "e":Ljava/io/IOException;
    .end local v9    # "fileSize":I
    .end local v10    # "fos":Ljava/io/FileOutputStream;
    .restart local v3    # "buf":[B
    .restart local v11    # "fos":Ljava/io/FileOutputStream;
    .restart local v13    # "numread":I
    .restart local v14    # "length":J
    :cond_e
    const/16 v19, 0x0

    :try_start_7
    move/from16 v0, v19

    invoke-virtual {v11, v3, v0, v13}, Ljava/io/FileOutputStream;->write([BII)V

    .line 428
    int-to-long v0, v13

    move-wide/from16 v20, v0

    add-long v6, v6, v20

    .line 429
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/eyugame/game/UpdateManager$DownloadApkThread;->this$0:Lcom/eyugame/game/UpdateManager;

    move-object/from16 v19, v0

    invoke-static/range {v19 .. v19}, Lcom/eyugame/game/UpdateManager;->access$1200(Lcom/eyugame/game/UpdateManager;)Z
    :try_end_7
    .catch Ljava/net/MalformedURLException; {:try_start_7 .. :try_end_7} :catch_f
    .catch Ljava/net/SocketException; {:try_start_7 .. :try_end_7} :catch_e
    .catch Ljava/net/UnknownHostException; {:try_start_7 .. :try_end_7} :catch_d
    .catch Ljava/io/IOException; {:try_start_7 .. :try_end_7} :catch_c
    .catchall {:try_start_7 .. :try_end_7} :catchall_1

    move-result v19

    if-eqz v19, :cond_7

    goto :goto_2

    .line 447
    :catch_2
    move-exception v5

    .line 448
    .restart local v5    # "e":Ljava/io/IOException;
    invoke-virtual {v5}, Ljava/io/IOException;->printStackTrace()V

    move-object v10, v11

    .line 450
    .end local v11    # "fos":Ljava/io/FileOutputStream;
    .restart local v10    # "fos":Ljava/io/FileOutputStream;
    goto :goto_3

    .line 430
    .end local v2    # "apkFile":Ljava/io/File;
    .end local v3    # "buf":[B
    .end local v4    # "conn":Ljava/net/HttpURLConnection;
    .end local v5    # "e":Ljava/io/IOException;
    .end local v6    # "count":J
    .end local v8    # "file":Ljava/io/File;
    .end local v13    # "numread":I
    .end local v14    # "length":J
    .end local v16    # "strSdcardState":Ljava/lang/String;
    .end local v18    # "url":Ljava/net/URL;
    :catch_3
    move-exception v5

    .line 431
    .local v5, "e":Ljava/net/MalformedURLException;
    :goto_4
    :try_start_8
    invoke-static {}, Lcom/eyugame/game/UpdateManager;->access$1400()Lcom/eyugame/game/UpdateManager$DwonloadApkHandler;

    move-result-object v19

    const/16 v20, 0x8

    invoke-virtual/range {v19 .. v20}, Lcom/eyugame/game/UpdateManager$DwonloadApkHandler;->sendEmptyMessage(I)Z
    :try_end_8
    .catchall {:try_start_8 .. :try_end_8} :catchall_0

    .line 440
    if-eqz v10, :cond_f

    .line 441
    :try_start_9
    invoke-virtual {v10}, Ljava/io/FileOutputStream;->close()V

    .line 444
    :cond_f
    if-eqz v12, :cond_b

    .line 445
    invoke-virtual {v12}, Ljava/io/InputStream;->close()V
    :try_end_9
    .catch Ljava/io/IOException; {:try_start_9 .. :try_end_9} :catch_4

    goto :goto_3

    .line 447
    :catch_4
    move-exception v5

    .line 448
    .local v5, "e":Ljava/io/IOException;
    invoke-virtual {v5}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_3

    .line 432
    .end local v5    # "e":Ljava/io/IOException;
    :catch_5
    move-exception v5

    .line 433
    .local v5, "e":Ljava/net/SocketException;
    :goto_5
    :try_start_a
    invoke-static {}, Lcom/eyugame/game/UpdateManager;->access$1400()Lcom/eyugame/game/UpdateManager$DwonloadApkHandler;

    move-result-object v19

    const/16 v20, 0x6

    invoke-virtual/range {v19 .. v20}, Lcom/eyugame/game/UpdateManager$DwonloadApkHandler;->sendEmptyMessage(I)Z
    :try_end_a
    .catchall {:try_start_a .. :try_end_a} :catchall_0

    .line 440
    if-eqz v10, :cond_10

    .line 441
    :try_start_b
    invoke-virtual {v10}, Ljava/io/FileOutputStream;->close()V

    .line 444
    :cond_10
    if-eqz v12, :cond_b

    .line 445
    invoke-virtual {v12}, Ljava/io/InputStream;->close()V
    :try_end_b
    .catch Ljava/io/IOException; {:try_start_b .. :try_end_b} :catch_6

    goto :goto_3

    .line 447
    :catch_6
    move-exception v5

    .line 448
    .local v5, "e":Ljava/io/IOException;
    invoke-virtual {v5}, Ljava/io/IOException;->printStackTrace()V

    goto/16 :goto_3

    .line 434
    .end local v5    # "e":Ljava/io/IOException;
    :catch_7
    move-exception v5

    .line 435
    .local v5, "e":Ljava/net/UnknownHostException;
    :goto_6
    :try_start_c
    invoke-static {}, Lcom/eyugame/game/UpdateManager;->access$1400()Lcom/eyugame/game/UpdateManager$DwonloadApkHandler;

    move-result-object v19

    const/16 v20, 0x6

    invoke-virtual/range {v19 .. v20}, Lcom/eyugame/game/UpdateManager$DwonloadApkHandler;->sendEmptyMessage(I)Z
    :try_end_c
    .catchall {:try_start_c .. :try_end_c} :catchall_0

    .line 440
    if-eqz v10, :cond_11

    .line 441
    :try_start_d
    invoke-virtual {v10}, Ljava/io/FileOutputStream;->close()V

    .line 444
    :cond_11
    if-eqz v12, :cond_b

    .line 445
    invoke-virtual {v12}, Ljava/io/InputStream;->close()V
    :try_end_d
    .catch Ljava/io/IOException; {:try_start_d .. :try_end_d} :catch_8

    goto/16 :goto_3

    .line 447
    :catch_8
    move-exception v5

    .line 448
    .local v5, "e":Ljava/io/IOException;
    invoke-virtual {v5}, Ljava/io/IOException;->printStackTrace()V

    goto/16 :goto_3

    .line 436
    .end local v5    # "e":Ljava/io/IOException;
    :catch_9
    move-exception v5

    .line 437
    .restart local v5    # "e":Ljava/io/IOException;
    :goto_7
    :try_start_e
    invoke-static {}, Lcom/eyugame/game/UpdateManager;->access$1400()Lcom/eyugame/game/UpdateManager$DwonloadApkHandler;

    move-result-object v19

    const/16 v20, 0x7

    invoke-virtual/range {v19 .. v20}, Lcom/eyugame/game/UpdateManager$DwonloadApkHandler;->sendEmptyMessage(I)Z
    :try_end_e
    .catchall {:try_start_e .. :try_end_e} :catchall_0

    .line 440
    if-eqz v10, :cond_12

    .line 441
    :try_start_f
    invoke-virtual {v10}, Ljava/io/FileOutputStream;->close()V

    .line 444
    :cond_12
    if-eqz v12, :cond_b

    .line 445
    invoke-virtual {v12}, Ljava/io/InputStream;->close()V
    :try_end_f
    .catch Ljava/io/IOException; {:try_start_f .. :try_end_f} :catch_a

    goto/16 :goto_3

    .line 447
    :catch_a
    move-exception v5

    .line 448
    invoke-virtual {v5}, Ljava/io/IOException;->printStackTrace()V

    goto/16 :goto_3

    .line 439
    .end local v5    # "e":Ljava/io/IOException;
    :catchall_0
    move-exception v19

    .line 440
    :goto_8
    if-eqz v10, :cond_13

    .line 441
    :try_start_10
    invoke-virtual {v10}, Ljava/io/FileOutputStream;->close()V

    .line 444
    :cond_13
    if-eqz v12, :cond_14

    .line 445
    invoke-virtual {v12}, Ljava/io/InputStream;->close()V
    :try_end_10
    .catch Ljava/io/IOException; {:try_start_10 .. :try_end_10} :catch_b

    .line 449
    :cond_14
    :goto_9
    throw v19

    .line 447
    :catch_b
    move-exception v5

    .line 448
    .restart local v5    # "e":Ljava/io/IOException;
    invoke-virtual {v5}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_9

    .line 439
    .end local v5    # "e":Ljava/io/IOException;
    .end local v10    # "fos":Ljava/io/FileOutputStream;
    .restart local v2    # "apkFile":Ljava/io/File;
    .restart local v4    # "conn":Ljava/net/HttpURLConnection;
    .restart local v6    # "count":J
    .restart local v8    # "file":Ljava/io/File;
    .restart local v11    # "fos":Ljava/io/FileOutputStream;
    .restart local v16    # "strSdcardState":Ljava/lang/String;
    .restart local v18    # "url":Ljava/net/URL;
    :catchall_1
    move-exception v19

    move-object v10, v11

    .end local v11    # "fos":Ljava/io/FileOutputStream;
    .restart local v10    # "fos":Ljava/io/FileOutputStream;
    goto :goto_8

    .line 436
    .end local v10    # "fos":Ljava/io/FileOutputStream;
    .restart local v11    # "fos":Ljava/io/FileOutputStream;
    :catch_c
    move-exception v5

    move-object v10, v11

    .end local v11    # "fos":Ljava/io/FileOutputStream;
    .restart local v10    # "fos":Ljava/io/FileOutputStream;
    goto :goto_7

    .line 434
    .end local v10    # "fos":Ljava/io/FileOutputStream;
    .restart local v11    # "fos":Ljava/io/FileOutputStream;
    :catch_d
    move-exception v5

    move-object v10, v11

    .end local v11    # "fos":Ljava/io/FileOutputStream;
    .restart local v10    # "fos":Ljava/io/FileOutputStream;
    goto :goto_6

    .line 432
    .end local v10    # "fos":Ljava/io/FileOutputStream;
    .restart local v11    # "fos":Ljava/io/FileOutputStream;
    :catch_e
    move-exception v5

    move-object v10, v11

    .end local v11    # "fos":Ljava/io/FileOutputStream;
    .restart local v10    # "fos":Ljava/io/FileOutputStream;
    goto :goto_5

    .line 430
    .end local v10    # "fos":Ljava/io/FileOutputStream;
    .restart local v11    # "fos":Ljava/io/FileOutputStream;
    :catch_f
    move-exception v5

    move-object v10, v11

    .end local v11    # "fos":Ljava/io/FileOutputStream;
    .restart local v10    # "fos":Ljava/io/FileOutputStream;
    goto/16 :goto_4
.end method
