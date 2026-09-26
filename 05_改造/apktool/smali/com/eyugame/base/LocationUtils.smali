.class public Lcom/eyugame/base/LocationUtils;
.super Ljava/lang/Object;
.source "LocationUtils.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/eyugame/base/LocationUtils$CopyStatus;
    }
.end annotation


# static fields
.field public static COPY_PROGRESS:I = 0x0

.field public static final STR_ASSETS_PREFIX:Ljava/lang/String; = "assets/"


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 37
    const/4 v0, 0x0

    sput v0, Lcom/eyugame/base/LocationUtils;->COPY_PROGRESS:I

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 31
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 33
    return-void
.end method

.method public static CopyAssets(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;ILcom/eyugame/base/LocationUtils$CopyStatus;)Z
    .locals 25
    .param p0, "strApkPath"    # Ljava/lang/String;
    .param p1, "strDestResPath"    # Ljava/lang/String;
    .param p2, "strAssetFlags"    # [Ljava/lang/String;
    .param p3, "nNewVersion"    # I
    .param p4, "copyStatus"    # Lcom/eyugame/base/LocationUtils$CopyStatus;

    .prologue
    .line 42
    move-object/from16 v0, p1

    move/from16 v1, p3

    invoke-static {v0, v1}, Lcom/eyugame/base/LocationUtils;->JuageVersionAndProcess(Ljava/lang/String;I)Z

    move-result v22

    if-nez v22, :cond_0

    .line 44
    const/16 v22, 0x1

    .line 132
    :goto_0
    return v22

    .line 48
    :cond_0
    new-instance v22, Ljava/lang/StringBuilder;

    invoke-direct/range {v22 .. v22}, Ljava/lang/StringBuilder;-><init>()V

    move-object/from16 v0, v22

    move-object/from16 v1, p1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v22

    const-string v23, "_Tmp"

    invoke-virtual/range {v22 .. v23}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v22

    invoke-virtual/range {v22 .. v22}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v16

    .line 51
    .local v16, "strTempDestResPath":Ljava/lang/String;
    :try_start_0
    new-instance v20, Ljava/util/zip/ZipFile;

    move-object/from16 v0, v20

    move-object/from16 v1, p0

    invoke-direct {v0, v1}, Ljava/util/zip/ZipFile;-><init>(Ljava/lang/String;)V

    .line 52
    .local v20, "zipFile":Ljava/util/zip/ZipFile;
    invoke-virtual/range {v20 .. v20}, Ljava/util/zip/ZipFile;->entries()Ljava/util/Enumeration;

    move-result-object v18

    .line 54
    .local v18, "zipEntries":Ljava/util/Enumeration;, "Ljava/util/Enumeration<+Ljava/util/zip/ZipEntry;>;"
    const/4 v7, -0x1

    .line 55
    .local v7, "nCount":I
    const v6, 0x8000

    .line 56
    .local v6, "nBufferLen":I
    new-array v11, v6, [B

    .line 57
    .local v11, "readBuffer":[B
    new-instance v10, Ljava/io/File;

    move-object/from16 v0, p1

    invoke-direct {v10, v0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 60
    .local v10, "outputFile":Ljava/io/File;
    :cond_1
    :goto_1
    invoke-interface/range {v18 .. v18}, Ljava/util/Enumeration;->hasMoreElements()Z

    move-result v22

    if-eqz v22, :cond_9

    .line 62
    invoke-interface/range {v18 .. v18}, Ljava/util/Enumeration;->nextElement()Ljava/lang/Object;

    move-result-object v19

    check-cast v19, Ljava/util/zip/ZipEntry;

    .line 63
    .local v19, "zipEntry":Ljava/util/zip/ZipEntry;
    invoke-virtual/range {v19 .. v19}, Ljava/util/zip/ZipEntry;->getName()Ljava/lang/String;

    move-result-object v12

    .line 64
    .local v12, "strEntryName":Ljava/lang/String;
    const-string v22, "assets/"

    move-object/from16 v0, v22

    invoke-virtual {v12, v0}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v22

    if-eqz v22, :cond_1

    .line 67
    const/4 v2, 0x0

    .line 68
    .local v2, "bNeedExtract":Z
    const/4 v9, 0x0

    .line 69
    .local v9, "nStep":I
    move-object/from16 v0, p2

    array-length v0, v0

    move/from16 v23, v0

    const/16 v22, 0x0

    :goto_2
    move/from16 v0, v22

    move/from16 v1, v23

    if-ge v0, v1, :cond_3

    aget-object v13, p2, v22

    .line 71
    .local v13, "strFlag":Ljava/lang/String;
    invoke-virtual {v12, v13}, Ljava/lang/String;->startsWith(Ljava/lang/String;)Z

    move-result v24

    if-eqz v24, :cond_5

    .line 73
    mul-int/lit8 v23, v9, 0x64

    move-object/from16 v0, p2

    array-length v0, v0

    move/from16 v22, v0

    if-nez v22, :cond_4

    const/16 v22, 0x1

    :goto_3
    div-int v8, v23, v22

    .line 74
    .local v8, "nProgress":I
    sget v22, Lcom/eyugame/base/LocationUtils;->COPY_PROGRESS:I

    move/from16 v0, v22

    if-le v8, v0, :cond_2

    .line 75
    move-object/from16 v0, p4

    invoke-interface {v0, v8}, Lcom/eyugame/base/LocationUtils$CopyStatus;->OnCopyProgressChanged(I)V

    .line 76
    sput v8, Lcom/eyugame/base/LocationUtils;->COPY_PROGRESS:I

    .line 78
    :cond_2
    const/4 v2, 0x1

    .line 83
    .end local v8    # "nProgress":I
    .end local v13    # "strFlag":Ljava/lang/String;
    :cond_3
    if-eqz v2, :cond_1

    .line 85
    const-string v22, "assets/"

    move-object/from16 v0, v22

    invoke-virtual {v12, v0}, Ljava/lang/String;->indexOf(Ljava/lang/String;)I

    move-result v22

    const-string v23, "assets/"

    invoke-virtual/range {v23 .. v23}, Ljava/lang/String;->length()I

    move-result v23

    add-int v22, v22, v23

    move/from16 v0, v22

    invoke-virtual {v12, v0}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v12

    .line 86
    if-eqz v12, :cond_1

    invoke-virtual {v12}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v22

    const-string v23, ""

    invoke-virtual/range {v22 .. v23}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v22

    if-nez v22, :cond_1

    .line 89
    new-instance v22, Ljava/lang/StringBuilder;

    invoke-direct/range {v22 .. v22}, Ljava/lang/StringBuilder;-><init>()V

    move-object/from16 v0, v22

    move-object/from16 v1, v16

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v22

    sget-object v23, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual/range {v22 .. v23}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v22

    move-object/from16 v0, v22

    invoke-virtual {v0, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v22

    invoke-virtual/range {v22 .. v22}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v14

    .line 92
    .local v14, "strOutFile":Ljava/lang/String;
    const/16 v22, 0x0

    sget-object v23, Ljava/io/File;->separator:Ljava/lang/String;

    move-object/from16 v0, v23

    invoke-virtual {v14, v0}, Ljava/lang/String;->lastIndexOf(Ljava/lang/String;)I

    move-result v23

    move/from16 v0, v22

    move/from16 v1, v23

    invoke-virtual {v14, v0, v1}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v15

    .line 93
    .local v15, "strOutPath":Ljava/lang/String;
    new-instance v10, Ljava/io/File;

    .end local v10    # "outputFile":Ljava/io/File;
    invoke-direct {v10, v15}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 95
    .restart local v10    # "outputFile":Ljava/io/File;
    invoke-virtual {v10}, Ljava/io/File;->exists()Z

    move-result v22

    if-nez v22, :cond_6

    invoke-virtual {v10}, Ljava/io/File;->mkdirs()Z

    move-result v22

    if-nez v22, :cond_6

    .line 97
    new-instance v22, Ljava/io/IOException;

    const-string v23, "Can NOT create target file directory!"

    invoke-direct/range {v22 .. v23}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v22
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 127
    .end local v2    # "bNeedExtract":Z
    .end local v6    # "nBufferLen":I
    .end local v7    # "nCount":I
    .end local v9    # "nStep":I
    .end local v10    # "outputFile":Ljava/io/File;
    .end local v11    # "readBuffer":[B
    .end local v12    # "strEntryName":Ljava/lang/String;
    .end local v14    # "strOutFile":Ljava/lang/String;
    .end local v15    # "strOutPath":Ljava/lang/String;
    .end local v18    # "zipEntries":Ljava/util/Enumeration;, "Ljava/util/Enumeration<+Ljava/util/zip/ZipEntry;>;"
    .end local v19    # "zipEntry":Ljava/util/zip/ZipEntry;
    .end local v20    # "zipFile":Ljava/util/zip/ZipFile;
    :catch_0
    move-exception v3

    .line 130
    .local v3, "e":Ljava/io/IOException;
    const-string v22, "LocationUtils"

    const-string v23, "decompression error!"

    invoke-static/range {v22 .. v23}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 131
    invoke-static/range {v16 .. v16}, Lcom/eyugame/base/LocationUtils;->deleteDirectory(Ljava/lang/String;)Z

    .line 132
    const/16 v22, 0x0

    goto/16 :goto_0

    .line 73
    .end local v3    # "e":Ljava/io/IOException;
    .restart local v2    # "bNeedExtract":Z
    .restart local v6    # "nBufferLen":I
    .restart local v7    # "nCount":I
    .restart local v9    # "nStep":I
    .restart local v10    # "outputFile":Ljava/io/File;
    .restart local v11    # "readBuffer":[B
    .restart local v12    # "strEntryName":Ljava/lang/String;
    .restart local v13    # "strFlag":Ljava/lang/String;
    .restart local v18    # "zipEntries":Ljava/util/Enumeration;, "Ljava/util/Enumeration<+Ljava/util/zip/ZipEntry;>;"
    .restart local v19    # "zipEntry":Ljava/util/zip/ZipEntry;
    .restart local v20    # "zipFile":Ljava/util/zip/ZipFile;
    :cond_4
    :try_start_1
    move-object/from16 v0, p2

    array-length v0, v0

    move/from16 v22, v0

    goto/16 :goto_3

    .line 81
    :cond_5
    add-int/lit8 v9, v9, 0x1

    .line 69
    add-int/lit8 v22, v22, 0x1

    goto/16 :goto_2

    .line 100
    .end local v13    # "strFlag":Ljava/lang/String;
    .restart local v14    # "strOutFile":Ljava/lang/String;
    .restart local v15    # "strOutPath":Ljava/lang/String;
    :cond_6
    new-instance v10, Ljava/io/File;

    .end local v10    # "outputFile":Ljava/io/File;
    invoke-direct {v10, v14}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 101
    .restart local v10    # "outputFile":Ljava/io/File;
    invoke-virtual {v10}, Ljava/io/File;->exists()Z

    move-result v22

    if-nez v22, :cond_7

    invoke-virtual {v10}, Ljava/io/File;->createNewFile()Z

    move-result v22

    if-nez v22, :cond_7

    .line 104
    new-instance v22, Ljava/io/IOException;

    const-string v23, "Can NOT create target file!"

    invoke-direct/range {v22 .. v23}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v22

    .line 108
    :cond_7
    move-object/from16 v0, v20

    move-object/from16 v1, v19

    invoke-virtual {v0, v1}, Ljava/util/zip/ZipFile;->getInputStream(Ljava/util/zip/ZipEntry;)Ljava/io/InputStream;

    move-result-object v21

    .line 109
    .local v21, "zipInputStream":Ljava/io/InputStream;
    new-instance v5, Ljava/io/FileOutputStream;

    invoke-direct {v5, v10}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    .line 110
    .local v5, "fos":Ljava/io/FileOutputStream;
    :goto_4
    const/16 v22, 0x0

    move-object/from16 v0, v21

    move/from16 v1, v22

    invoke-virtual {v0, v11, v1, v6}, Ljava/io/InputStream;->read([BII)I

    move-result v7

    const/16 v22, -0x1

    move/from16 v0, v22

    if-eq v7, v0, :cond_8

    .line 112
    const/16 v22, 0x0

    move/from16 v0, v22

    invoke-virtual {v5, v11, v0, v7}, Ljava/io/FileOutputStream;->write([BII)V

    goto :goto_4

    .line 114
    :cond_8
    invoke-virtual {v5}, Ljava/io/FileOutputStream;->flush()V

    .line 115
    invoke-virtual {v5}, Ljava/io/FileOutputStream;->close()V

    goto/16 :goto_1

    .line 117
    .end local v2    # "bNeedExtract":Z
    .end local v5    # "fos":Ljava/io/FileOutputStream;
    .end local v9    # "nStep":I
    .end local v12    # "strEntryName":Ljava/lang/String;
    .end local v14    # "strOutFile":Ljava/lang/String;
    .end local v15    # "strOutPath":Ljava/lang/String;
    .end local v19    # "zipEntry":Ljava/util/zip/ZipEntry;
    .end local v21    # "zipInputStream":Ljava/io/InputStream;
    :cond_9
    invoke-virtual/range {v20 .. v20}, Ljava/util/zip/ZipFile;->close()V

    .line 120
    move-object/from16 v0, v16

    move/from16 v1, p3

    invoke-static {v0, v1}, Lcom/eyugame/base/LocationUtils;->WriteVersion(Ljava/lang/String;I)V

    .line 123
    new-instance v17, Ljava/io/File;

    move-object/from16 v0, v17

    move-object/from16 v1, v16

    invoke-direct {v0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 124
    .local v17, "tempFile":Ljava/io/File;
    new-instance v4, Ljava/io/File;

    move-object/from16 v0, p1

    invoke-direct {v4, v0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 125
    .local v4, "finalFile":Ljava/io/File;
    move-object/from16 v0, v17

    invoke-virtual {v0, v4}, Ljava/io/File;->renameTo(Ljava/io/File;)Z
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_0

    move-result v22

    goto/16 :goto_0
.end method

.method public static JuageVersionAndProcess(Ljava/lang/String;I)Z
    .locals 12
    .param p0, "strDestResPath"    # Ljava/lang/String;
    .param p1, "nNewVersion"    # I

    .prologue
    const/4 v9, 0x0

    .line 172
    new-instance v4, Ljava/io/File;

    invoke-direct {v4, p0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 173
    .local v4, "outputFile":Ljava/io/File;
    invoke-virtual {v4}, Ljava/io/File;->exists()Z

    move-result v10

    if-eqz v10, :cond_1

    .line 176
    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v10, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    sget-object v11, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    const-string v11, "version.dat"

    invoke-virtual {v10, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    .line 177
    .local v8, "strVerRecord":Ljava/lang/String;
    new-instance v5, Ljava/io/File;

    invoke-direct {v5, v8}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 178
    .local v5, "outputRecord":Ljava/io/File;
    invoke-virtual {v5}, Ljava/io/File;->exists()Z

    move-result v10

    if-eqz v10, :cond_2

    .line 182
    :try_start_0
    new-instance v1, Ljava/io/FileInputStream;

    invoke-direct {v1, v5}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V

    .line 184
    .local v1, "in":Ljava/io/FileInputStream;
    const/16 v10, 0x64

    new-array v6, v10, [B

    .line 185
    .local v6, "readBuffer":[B
    const/4 v10, 0x0

    const/16 v11, 0x64

    invoke-virtual {v1, v6, v10, v11}, Ljava/io/FileInputStream;->read([BII)I

    move-result v2

    .line 186
    .local v2, "nRead":I
    invoke-virtual {v1}, Ljava/io/FileInputStream;->close()V

    .line 188
    new-instance v7, Ljava/lang/String;

    const/4 v10, 0x0

    invoke-direct {v7, v6, v10, v2}, Ljava/lang/String;-><init>([BII)V

    .line 189
    .local v7, "str":Ljava/lang/String;
    invoke-static {v7}, Ljava/lang/Long;->valueOf(Ljava/lang/String;)Ljava/lang/Long;

    move-result-object v10

    invoke-virtual {v10}, Ljava/lang/Long;->intValue()I

    move-result v3

    .line 191
    .local v3, "nValue":I
    if-ne v3, p1, :cond_0

    .line 193
    const-string v10, "LocationUtils"

    const-string v11, "same version, return"

    invoke-static {v10, v11}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 216
    .end local v1    # "in":Ljava/io/FileInputStream;
    .end local v2    # "nRead":I
    .end local v3    # "nValue":I
    .end local v5    # "outputRecord":Ljava/io/File;
    .end local v6    # "readBuffer":[B
    .end local v7    # "str":Ljava/lang/String;
    .end local v8    # "strVerRecord":Ljava/lang/String;
    :goto_0
    return v9

    .line 199
    .restart local v1    # "in":Ljava/io/FileInputStream;
    .restart local v2    # "nRead":I
    .restart local v3    # "nValue":I
    .restart local v5    # "outputRecord":Ljava/io/File;
    .restart local v6    # "readBuffer":[B
    .restart local v7    # "str":Ljava/lang/String;
    .restart local v8    # "strVerRecord":Ljava/lang/String;
    :cond_0
    const-string v9, "LocationUtils"

    const-string v10, "different version, delete Directory"

    invoke-static {v9, v10}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 200
    invoke-static {p0}, Lcom/eyugame/base/LocationUtils;->deleteDirectory(Ljava/lang/String;)Z
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 216
    .end local v1    # "in":Ljava/io/FileInputStream;
    .end local v2    # "nRead":I
    .end local v3    # "nValue":I
    .end local v5    # "outputRecord":Ljava/io/File;
    .end local v6    # "readBuffer":[B
    .end local v7    # "str":Ljava/lang/String;
    .end local v8    # "strVerRecord":Ljava/lang/String;
    :cond_1
    :goto_1
    const/4 v9, 0x1

    goto :goto_0

    .line 203
    .restart local v5    # "outputRecord":Ljava/io/File;
    .restart local v8    # "strVerRecord":Ljava/lang/String;
    :catch_0
    move-exception v0

    .line 205
    .local v0, "e":Ljava/io/IOException;
    const-string v9, "LocationUtils"

    const-string v10, "Exception error, delete Directory"

    invoke-static {v9, v10}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 206
    invoke-static {p0}, Lcom/eyugame/base/LocationUtils;->deleteDirectory(Ljava/lang/String;)Z

    goto :goto_1

    .line 211
    .end local v0    # "e":Ljava/io/IOException;
    :cond_2
    const-string v9, "LocationUtils"

    const-string v10, "version compare file not exist, delete Directory"

    invoke-static {v9, v10}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 212
    invoke-static {p0}, Lcom/eyugame/base/LocationUtils;->deleteDirectory(Ljava/lang/String;)Z

    goto :goto_1
.end method

.method protected static WriteVersion(Ljava/lang/String;I)V
    .locals 8
    .param p0, "strDestResPath"    # Ljava/lang/String;
    .param p1, "nNewVersion"    # I

    .prologue
    .line 138
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v5, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    sget-object v6, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    const-string v6, "version.dat"

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    .line 139
    .local v3, "strVerRecord":Ljava/lang/String;
    new-instance v2, Ljava/io/File;

    invoke-direct {v2, v3}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 140
    .local v2, "outputRecord":Ljava/io/File;
    invoke-virtual {v2}, Ljava/io/File;->exists()Z

    move-result v5

    if-nez v5, :cond_0

    .line 144
    :try_start_0
    invoke-virtual {v2}, Ljava/io/File;->createNewFile()Z

    move-result v5

    if-nez v5, :cond_0

    .line 146
    new-instance v5, Ljava/io/IOException;

    const-string v6, "Can NOT create version file!"

    invoke-direct {v5, v6}, Ljava/io/IOException;-><init>(Ljava/lang/String;)V

    throw v5
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    .line 149
    :catch_0
    move-exception v0

    .line 151
    .local v0, "e":Ljava/io/IOException;
    const-string v5, "LocationUtils"

    const-string v6, "Can NOT create version file!"

    invoke-static {v5, v6}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 168
    .end local v0    # "e":Ljava/io/IOException;
    :goto_0
    return-void

    .line 158
    :cond_0
    :try_start_1
    new-instance v1, Ljava/io/FileOutputStream;

    invoke-direct {v1, v2}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    .line 160
    .local v1, "fos":Ljava/io/FileOutputStream;
    invoke-static {p1}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v4

    .line 161
    .local v4, "strver":Ljava/lang/String;
    invoke-virtual {v4}, Ljava/lang/String;->getBytes()[B

    move-result-object v5

    const/4 v6, 0x0

    invoke-virtual {v4}, Ljava/lang/String;->length()I

    move-result v7

    invoke-virtual {v1, v5, v6, v7}, Ljava/io/FileOutputStream;->write([BII)V

    .line 162
    invoke-virtual {v1}, Ljava/io/FileOutputStream;->close()V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_0

    .line 164
    .end local v1    # "fos":Ljava/io/FileOutputStream;
    .end local v4    # "strver":Ljava/lang/String;
    :catch_1
    move-exception v0

    .line 166
    .restart local v0    # "e":Ljava/io/IOException;
    const-string v5, "LocationUtils"

    const-string v6, "FileOutputStream error"

    invoke-static {v5, v6}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    goto :goto_0
.end method

.method private static byteArrayToHex([B)Ljava/lang/String;
    .locals 8
    .param p0, "byteArray"    # [B

    .prologue
    .line 362
    const/16 v5, 0x10

    new-array v1, v5, [C

    fill-array-data v1, :array_0

    .line 365
    .local v1, "hexDigits":[C
    array-length v5, p0

    mul-int/lit8 v5, v5, 0x2

    new-array v4, v5, [C

    .line 368
    .local v4, "resultCharArray":[C
    const/4 v2, 0x0

    .line 369
    .local v2, "index":I
    array-length v6, p0

    const/4 v5, 0x0

    move v3, v2

    .end local v2    # "index":I
    .local v3, "index":I
    :goto_0
    if-ge v5, v6, :cond_0

    aget-byte v0, p0, v5

    .line 370
    .local v0, "b":B
    add-int/lit8 v2, v3, 0x1

    .end local v3    # "index":I
    .restart local v2    # "index":I
    ushr-int/lit8 v7, v0, 0x4

    and-int/lit8 v7, v7, 0xf

    aget-char v7, v1, v7

    aput-char v7, v4, v3

    .line 371
    add-int/lit8 v3, v2, 0x1

    .end local v2    # "index":I
    .restart local v3    # "index":I
    and-int/lit8 v7, v0, 0xf

    aget-char v7, v1, v7

    aput-char v7, v4, v2

    .line 369
    add-int/lit8 v5, v5, 0x1

    goto :goto_0

    .line 375
    .end local v0    # "b":B
    :cond_0
    new-instance v5, Ljava/lang/String;

    invoke-direct {v5, v4}, Ljava/lang/String;-><init>([C)V

    return-object v5

    .line 362
    nop

    :array_0
    .array-data 2
        0x30s
        0x31s
        0x32s
        0x33s
        0x34s
        0x35s
        0x36s
        0x37s
        0x38s
        0x39s
        0x41s
        0x42s
        0x43s
        0x44s
        0x45s
        0x46s
    .end array-data
.end method

.method public static deleteDirectory(Ljava/lang/String;)Z
    .locals 8
    .param p0, "dir"    # Ljava/lang/String;

    .prologue
    const/4 v4, 0x0

    .line 242
    sget-object v5, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {p0, v5}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v5

    if-nez v5, :cond_0

    .line 244
    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v5, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    sget-object v6, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v5, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p0

    .line 248
    :cond_0
    new-instance v2, Ljava/io/File;

    invoke-direct {v2, p0}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 249
    .local v2, "dirFile":Ljava/io/File;
    invoke-virtual {v2}, Ljava/io/File;->exists()Z

    move-result v5

    if-eqz v5, :cond_1

    invoke-virtual {v2}, Ljava/io/File;->isDirectory()Z

    move-result v5

    if-nez v5, :cond_2

    .line 279
    :cond_1
    :goto_0
    return v4

    .line 254
    :cond_2
    const/4 v1, 0x1

    .line 256
    .local v1, "bSuccess":Z
    invoke-virtual {v2}, Ljava/io/File;->listFiles()[Ljava/io/File;

    move-result-object v0

    .line 257
    .local v0, "allFiles":[Ljava/io/File;
    array-length v6, v0

    move v5, v4

    :goto_1
    if-ge v5, v6, :cond_3

    aget-object v3, v0, v5

    .line 259
    .local v3, "file":Ljava/io/File;
    invoke-virtual {v3}, Ljava/io/File;->isFile()Z

    move-result v7

    if-eqz v7, :cond_4

    .line 262
    invoke-virtual {v3}, Ljava/io/File;->delete()Z

    move-result v1

    .line 263
    if-nez v1, :cond_5

    .line 273
    .end local v3    # "file":Ljava/io/File;
    :cond_3
    if-eqz v1, :cond_1

    .line 275
    invoke-virtual {v2}, Ljava/io/File;->delete()Z

    move-result v4

    goto :goto_0

    .line 268
    .restart local v3    # "file":Ljava/io/File;
    :cond_4
    invoke-virtual {v3}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v7

    invoke-static {v7}, Lcom/eyugame/base/LocationUtils;->deleteDirectory(Ljava/lang/String;)Z

    move-result v1

    .line 269
    if-eqz v1, :cond_3

    .line 257
    :cond_5
    add-int/lit8 v5, v5, 0x1

    goto :goto_1
.end method

.method public static externalMemoryAvailable()Z
    .locals 2

    .prologue
    .line 300
    invoke-static {}, Landroid/os/Environment;->getExternalStorageState()Ljava/lang/String;

    move-result-object v0

    const-string v1, "mounted"

    invoke-virtual {v0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    return v0
.end method

.method public static getAvailableExternalMemorySize()J
    .locals 8

    .prologue
    .line 304
    invoke-static {}, Lcom/eyugame/base/LocationUtils;->externalMemoryAvailable()Z

    move-result v6

    if-eqz v6, :cond_0

    .line 305
    invoke-static {}, Landroid/os/Environment;->getExternalStorageDirectory()Ljava/io/File;

    move-result-object v4

    .line 306
    .local v4, "path":Ljava/io/File;
    new-instance v5, Landroid/os/StatFs;

    invoke-virtual {v4}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v6

    invoke-direct {v5, v6}, Landroid/os/StatFs;-><init>(Ljava/lang/String;)V

    .line 307
    .local v5, "stat":Landroid/os/StatFs;
    invoke-virtual {v5}, Landroid/os/StatFs;->getBlockSize()I

    move-result v6

    int-to-long v2, v6

    .line 308
    .local v2, "blockSize":J
    invoke-virtual {v5}, Landroid/os/StatFs;->getAvailableBlocks()I

    move-result v6

    int-to-long v0, v6

    .line 309
    .local v0, "availableBlocks":J
    mul-long v6, v0, v2

    .line 312
    :goto_0
    return-wide v6

    .end local v0    # "availableBlocks":J
    .end local v2    # "blockSize":J
    .end local v4    # "path":Ljava/io/File;
    .end local v5    # "stat":Landroid/os/StatFs;
    :cond_0
    const-wide/16 v6, -0x1

    goto :goto_0
.end method

.method public static getAvailableInternalMemorySize()J
    .locals 8

    .prologue
    .line 284
    invoke-static {}, Landroid/os/Environment;->getDataDirectory()Ljava/io/File;

    move-result-object v4

    .line 285
    .local v4, "path":Ljava/io/File;
    new-instance v5, Landroid/os/StatFs;

    invoke-virtual {v4}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v6

    invoke-direct {v5, v6}, Landroid/os/StatFs;-><init>(Ljava/lang/String;)V

    .line 286
    .local v5, "stat":Landroid/os/StatFs;
    invoke-virtual {v5}, Landroid/os/StatFs;->getBlockSize()I

    move-result v6

    int-to-long v2, v6

    .line 287
    .local v2, "blockSize":J
    invoke-virtual {v5}, Landroid/os/StatFs;->getAvailableBlocks()I

    move-result v6

    int-to-long v0, v6

    .line 288
    .local v0, "availableBlocks":J
    mul-long v6, v0, v2

    return-wide v6
.end method

.method public static getFileMd5(Ljava/lang/String;)Ljava/lang/String;
    .locals 9
    .param p0, "strFilePath"    # Ljava/lang/String;

    .prologue
    .line 330
    const-string v6, "MD5"

    .line 331
    .local v6, "hashType":Ljava/lang/String;
    const/4 v4, 0x0

    .line 333
    .local v4, "fStream":Ljava/io/FileInputStream;
    :try_start_0
    invoke-static {v6}, Ljava/security/MessageDigest;->getInstance(Ljava/lang/String;)Ljava/security/MessageDigest;

    move-result-object v7

    .line 334
    .local v7, "md5":Ljava/security/MessageDigest;
    new-instance v5, Ljava/io/FileInputStream;

    invoke-direct {v5, p0}, Ljava/io/FileInputStream;-><init>(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/security/NoSuchAlgorithmException; {:try_start_0 .. :try_end_0} :catch_3
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 335
    .end local v4    # "fStream":Ljava/io/FileInputStream;
    .local v5, "fStream":Ljava/io/FileInputStream;
    :try_start_1
    invoke-virtual {v5}, Ljava/io/FileInputStream;->getChannel()Ljava/nio/channels/FileChannel;

    move-result-object v3

    .line 336
    .local v3, "fChannel":Ljava/nio/channels/FileChannel;
    const/16 v8, 0x2000

    invoke-static {v8}, Ljava/nio/ByteBuffer;->allocate(I)Ljava/nio/ByteBuffer;

    move-result-object v0

    .line 337
    .local v0, "buffer":Ljava/nio/ByteBuffer;
    invoke-virtual {v3, v0}, Ljava/nio/channels/FileChannel;->read(Ljava/nio/ByteBuffer;)I

    move-result v1

    .local v1, "count":I
    :goto_0
    const/4 v8, -0x1

    if-eq v1, v8, :cond_1

    .line 338
    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->flip()Ljava/nio/Buffer;

    .line 339
    invoke-virtual {v7, v0}, Ljava/security/MessageDigest;->update(Ljava/nio/ByteBuffer;)V

    .line 340
    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->hasRemaining()Z

    move-result v8

    if-nez v8, :cond_0

    .line 341
    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->clear()Ljava/nio/Buffer;

    .line 337
    :cond_0
    invoke-virtual {v3, v0}, Ljava/nio/channels/FileChannel;->read(Ljava/nio/ByteBuffer;)I

    move-result v1

    goto :goto_0

    .line 344
    :cond_1
    invoke-virtual {v7}, Ljava/security/MessageDigest;->digest()[B

    move-result-object v8

    invoke-static {v8}, Lcom/eyugame/base/LocationUtils;->byteArrayToHex([B)Ljava/lang/String;
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_7
    .catch Ljava/security/NoSuchAlgorithmException; {:try_start_1 .. :try_end_1} :catch_6
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    move-result-object v8

    .line 351
    if-eqz v5, :cond_2

    .line 352
    :try_start_2
    invoke-virtual {v5}, Ljava/io/FileInputStream;->close()V
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_0

    :cond_2
    :goto_1
    move-object v4, v5

    .line 357
    .end local v0    # "buffer":Ljava/nio/ByteBuffer;
    .end local v1    # "count":I
    .end local v3    # "fChannel":Ljava/nio/channels/FileChannel;
    .end local v5    # "fStream":Ljava/io/FileInputStream;
    .end local v7    # "md5":Ljava/security/MessageDigest;
    .restart local v4    # "fStream":Ljava/io/FileInputStream;
    :goto_2
    return-object v8

    .line 353
    .end local v4    # "fStream":Ljava/io/FileInputStream;
    .restart local v0    # "buffer":Ljava/nio/ByteBuffer;
    .restart local v1    # "count":I
    .restart local v3    # "fChannel":Ljava/nio/channels/FileChannel;
    .restart local v5    # "fStream":Ljava/io/FileInputStream;
    .restart local v7    # "md5":Ljava/security/MessageDigest;
    :catch_0
    move-exception v2

    .line 354
    .local v2, "e":Ljava/io/IOException;
    invoke-virtual {v2}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_1

    .line 345
    .end local v0    # "buffer":Ljava/nio/ByteBuffer;
    .end local v1    # "count":I
    .end local v2    # "e":Ljava/io/IOException;
    .end local v3    # "fChannel":Ljava/nio/channels/FileChannel;
    .end local v5    # "fStream":Ljava/io/FileInputStream;
    .end local v7    # "md5":Ljava/security/MessageDigest;
    .restart local v4    # "fStream":Ljava/io/FileInputStream;
    :catch_1
    move-exception v2

    .line 346
    .restart local v2    # "e":Ljava/io/IOException;
    :goto_3
    :try_start_3
    invoke-virtual {v2}, Ljava/io/IOException;->printStackTrace()V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_0

    .line 351
    if-eqz v4, :cond_3

    .line 352
    :try_start_4
    invoke-virtual {v4}, Ljava/io/FileInputStream;->close()V
    :try_end_4
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_2

    .line 357
    .end local v2    # "e":Ljava/io/IOException;
    :cond_3
    :goto_4
    const-string v8, ""

    goto :goto_2

    .line 353
    .restart local v2    # "e":Ljava/io/IOException;
    :catch_2
    move-exception v2

    .line 354
    invoke-virtual {v2}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_4

    .line 347
    .end local v2    # "e":Ljava/io/IOException;
    :catch_3
    move-exception v2

    .line 348
    .local v2, "e":Ljava/security/NoSuchAlgorithmException;
    :goto_5
    :try_start_5
    invoke-virtual {v2}, Ljava/security/NoSuchAlgorithmException;->printStackTrace()V
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_0

    .line 351
    if-eqz v4, :cond_3

    .line 352
    :try_start_6
    invoke-virtual {v4}, Ljava/io/FileInputStream;->close()V
    :try_end_6
    .catch Ljava/io/IOException; {:try_start_6 .. :try_end_6} :catch_4

    goto :goto_4

    .line 353
    :catch_4
    move-exception v2

    .line 354
    .local v2, "e":Ljava/io/IOException;
    invoke-virtual {v2}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_4

    .line 350
    .end local v2    # "e":Ljava/io/IOException;
    :catchall_0
    move-exception v8

    .line 351
    :goto_6
    if-eqz v4, :cond_4

    .line 352
    :try_start_7
    invoke-virtual {v4}, Ljava/io/FileInputStream;->close()V
    :try_end_7
    .catch Ljava/io/IOException; {:try_start_7 .. :try_end_7} :catch_5

    .line 355
    :cond_4
    :goto_7
    throw v8

    .line 353
    :catch_5
    move-exception v2

    .line 354
    .restart local v2    # "e":Ljava/io/IOException;
    invoke-virtual {v2}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_7

    .line 350
    .end local v2    # "e":Ljava/io/IOException;
    .end local v4    # "fStream":Ljava/io/FileInputStream;
    .restart local v5    # "fStream":Ljava/io/FileInputStream;
    .restart local v7    # "md5":Ljava/security/MessageDigest;
    :catchall_1
    move-exception v8

    move-object v4, v5

    .end local v5    # "fStream":Ljava/io/FileInputStream;
    .restart local v4    # "fStream":Ljava/io/FileInputStream;
    goto :goto_6

    .line 347
    .end local v4    # "fStream":Ljava/io/FileInputStream;
    .restart local v5    # "fStream":Ljava/io/FileInputStream;
    :catch_6
    move-exception v2

    move-object v4, v5

    .end local v5    # "fStream":Ljava/io/FileInputStream;
    .restart local v4    # "fStream":Ljava/io/FileInputStream;
    goto :goto_5

    .line 345
    .end local v4    # "fStream":Ljava/io/FileInputStream;
    .restart local v5    # "fStream":Ljava/io/FileInputStream;
    :catch_7
    move-exception v2

    move-object v4, v5

    .end local v5    # "fStream":Ljava/io/FileInputStream;
    .restart local v4    # "fStream":Ljava/io/FileInputStream;
    goto :goto_3
.end method

.method public static getStringFromAssetFile(Ljava/lang/String;Landroid/content/Context;)Ljava/lang/String;
    .locals 7
    .param p0, "filePath"    # Ljava/lang/String;
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    .line 423
    if-nez p1, :cond_0

    const-string v6, ""

    .line 443
    :goto_0
    return-object v6

    .line 424
    :cond_0
    const/4 v0, 0x0

    .line 426
    .local v0, "InpStr":Ljava/io/InputStream;
    :try_start_0
    invoke-virtual {p1}, Landroid/content/Context;->getAssets()Landroid/content/res/AssetManager;

    move-result-object v6

    invoke-virtual {v6, p0}, Landroid/content/res/AssetManager;->open(Ljava/lang/String;)Ljava/io/InputStream;
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_1

    move-result-object v0

    .line 432
    :goto_1
    const/4 v5, 0x0

    .line 433
    .local v5, "strBuff":Ljava/lang/String;
    new-instance v1, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v1}, Ljava/io/ByteArrayOutputStream;-><init>()V

    .line 434
    .local v1, "baos":Ljava/io/ByteArrayOutputStream;
    const/4 v4, -0x1

    .line 436
    .local v4, "i":I
    :goto_2
    :try_start_1
    invoke-virtual {v0}, Ljava/io/InputStream;->read()I

    move-result v4

    const/4 v6, -0x1

    if-eq v4, v6, :cond_1

    .line 437
    invoke-virtual {v1, v4}, Ljava/io/ByteArrayOutputStream;->write(I)V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_2

    .line 439
    :catch_0
    move-exception v2

    .line 440
    .local v2, "e":Ljava/io/IOException;
    invoke-virtual {v2}, Ljava/io/IOException;->printStackTrace()V

    .line 443
    .end local v2    # "e":Ljava/io/IOException;
    :cond_1
    invoke-virtual {v1}, Ljava/io/ByteArrayOutputStream;->toString()Ljava/lang/String;

    move-result-object v6

    goto :goto_0

    .line 427
    .end local v1    # "baos":Ljava/io/ByteArrayOutputStream;
    .end local v4    # "i":I
    .end local v5    # "strBuff":Ljava/lang/String;
    :catch_1
    move-exception v3

    .line 429
    .local v3, "e1":Ljava/io/IOException;
    invoke-virtual {v3}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_1
.end method

.method public static getStringFromFile(Ljava/lang/String;)Ljava/lang/String;
    .locals 8
    .param p0, "filePath"    # Ljava/lang/String;

    .prologue
    .line 401
    const/4 v3, 0x0

    .line 403
    .local v3, "strBuff":Ljava/lang/String;
    :try_start_0
    new-instance v0, Ljava/io/RandomAccessFile;

    const-string v5, "r"

    invoke-direct {v0, p0, v5}, Ljava/io/RandomAccessFile;-><init>(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/io/FileNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    .line 411
    .local v0, "Accfile":Ljava/io/RandomAccessFile;
    :try_start_1
    invoke-virtual {v0}, Ljava/io/RandomAccessFile;->length()J

    move-result-wide v6

    long-to-int v5, v6

    new-array v1, v5, [B

    .line 412
    .local v1, "bStr":[B
    invoke-virtual {v0, v1}, Ljava/io/RandomAccessFile;->read([B)I

    .line 413
    invoke-virtual {v0}, Ljava/io/RandomAccessFile;->close()V

    .line 414
    new-instance v4, Ljava/lang/String;

    invoke-direct {v4, v1}, Ljava/lang/String;-><init>([B)V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_1

    .end local v3    # "strBuff":Ljava/lang/String;
    .local v4, "strBuff":Ljava/lang/String;
    move-object v3, v4

    .end local v1    # "bStr":[B
    .end local v4    # "strBuff":Ljava/lang/String;
    .restart local v3    # "strBuff":Ljava/lang/String;
    :goto_0
    move-object v5, v3

    .line 419
    .end local v0    # "Accfile":Ljava/io/RandomAccessFile;
    :goto_1
    return-object v5

    .line 405
    :catch_0
    move-exception v2

    .line 406
    .local v2, "e":Ljava/io/FileNotFoundException;
    invoke-virtual {v2}, Ljava/io/FileNotFoundException;->printStackTrace()V

    .line 407
    const-string v5, ""

    goto :goto_1

    .line 415
    .end local v2    # "e":Ljava/io/FileNotFoundException;
    .restart local v0    # "Accfile":Ljava/io/RandomAccessFile;
    :catch_1
    move-exception v2

    .line 416
    .local v2, "e":Ljava/io/IOException;
    invoke-virtual {v2}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_0
.end method

.method public static getStringFromPack(Ljava/lang/String;Landroid/content/Context;)Ljava/lang/String;
    .locals 3
    .param p0, "filePath"    # Ljava/lang/String;
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    .line 379
    const-string v0, ""

    .line 381
    .local v0, "strData":Ljava/lang/String;
    invoke-static {}, Lorg/cocos2dx/lib/Cocos2dxRenderer;->isInit()Z

    move-result v1

    if-eqz v1, :cond_0

    .line 382
    invoke-static {p0}, Lcom/eyugame/impt/RelayNative;->OpenFile(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 385
    :cond_0
    if-eqz v0, :cond_1

    const-string v1, ""

    if-ne v1, v0, :cond_2

    .line 386
    :cond_1
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {}, Lorg/cocos2dx/lib/Cocos2dxHelper;->getExternalPatchPatch()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "/"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/eyugame/base/LocationUtils;->getStringFromFile(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 389
    :cond_2
    if-eqz v0, :cond_3

    const-string v1, ""

    if-ne v1, v0, :cond_4

    .line 390
    :cond_3
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {}, Lorg/cocos2dx/lib/Cocos2dxHelper;->getExternalAssetPath()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "/"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/eyugame/base/LocationUtils;->getStringFromFile(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 393
    :cond_4
    if-eqz v0, :cond_5

    const-string v1, ""

    if-ne v1, v0, :cond_6

    .line 394
    :cond_5
    invoke-static {p0, p1}, Lcom/eyugame/base/LocationUtils;->getStringFromAssetFile(Ljava/lang/String;Landroid/content/Context;)Ljava/lang/String;

    move-result-object v0

    .line 397
    :cond_6
    return-object v0
.end method

.method public static getTotalExternalMemorySize()J
    .locals 8

    .prologue
    .line 317
    invoke-static {}, Lcom/eyugame/base/LocationUtils;->externalMemoryAvailable()Z

    move-result v6

    if-eqz v6, :cond_0

    .line 318
    invoke-static {}, Landroid/os/Environment;->getExternalStorageDirectory()Ljava/io/File;

    move-result-object v2

    .line 319
    .local v2, "path":Ljava/io/File;
    new-instance v3, Landroid/os/StatFs;

    invoke-virtual {v2}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v6

    invoke-direct {v3, v6}, Landroid/os/StatFs;-><init>(Ljava/lang/String;)V

    .line 320
    .local v3, "stat":Landroid/os/StatFs;
    invoke-virtual {v3}, Landroid/os/StatFs;->getBlockSize()I

    move-result v6

    int-to-long v0, v6

    .line 321
    .local v0, "blockSize":J
    invoke-virtual {v3}, Landroid/os/StatFs;->getBlockCount()I

    move-result v6

    int-to-long v4, v6

    .line 322
    .local v4, "totalBlocks":J
    mul-long v6, v4, v0

    .line 325
    :goto_0
    return-wide v6

    .end local v0    # "blockSize":J
    .end local v2    # "path":Ljava/io/File;
    .end local v3    # "stat":Landroid/os/StatFs;
    .end local v4    # "totalBlocks":J
    :cond_0
    const-wide/16 v6, -0x1

    goto :goto_0
.end method

.method public static getTotalInternalMemorySize()J
    .locals 8

    .prologue
    .line 292
    invoke-static {}, Landroid/os/Environment;->getDataDirectory()Ljava/io/File;

    move-result-object v2

    .line 293
    .local v2, "path":Ljava/io/File;
    new-instance v3, Landroid/os/StatFs;

    invoke-virtual {v2}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v6

    invoke-direct {v3, v6}, Landroid/os/StatFs;-><init>(Ljava/lang/String;)V

    .line 294
    .local v3, "stat":Landroid/os/StatFs;
    invoke-virtual {v3}, Landroid/os/StatFs;->getBlockSize()I

    move-result v6

    int-to-long v0, v6

    .line 295
    .local v0, "blockSize":J
    invoke-virtual {v3}, Landroid/os/StatFs;->getBlockCount()I

    move-result v6

    int-to-long v4, v6

    .line 296
    .local v4, "totalBlocks":J
    mul-long v6, v4, v0

    return-wide v6
.end method

.method public static makeDirectory(Ljava/lang/String;)Z
    .locals 7
    .param p0, "strPath"    # Ljava/lang/String;

    .prologue
    const/4 v5, 0x1

    const/4 v4, 0x0

    .line 221
    const-string v6, "/"

    invoke-virtual {p0, v6}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v3

    .line 222
    .local v3, "sub":[Ljava/lang/String;
    array-length v6, v3

    if-ge v6, v5, :cond_0

    .line 236
    :goto_0
    return v4

    .line 224
    :cond_0
    new-instance v0, Ljava/io/File;

    aget-object v4, v3, v4

    invoke-direct {v0, v4}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 225
    .local v0, "dir":Ljava/io/File;
    const/4 v2, 0x1

    .local v2, "i":I
    :goto_1
    array-length v4, v3

    if-ge v2, v4, :cond_5

    .line 226
    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v4

    if-eqz v4, :cond_1

    invoke-virtual {v0}, Ljava/io/File;->isDirectory()Z

    move-result v4

    if-nez v4, :cond_2

    .line 227
    :cond_1
    invoke-virtual {v0}, Ljava/io/File;->mkdir()Z

    .line 229
    :cond_2
    new-instance v1, Ljava/io/File;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v4

    sget-object v6, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    aget-object v6, v3, v2

    invoke-virtual {v4, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-direct {v1, v4}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 230
    .local v1, "dir2":Ljava/io/File;
    invoke-virtual {v1}, Ljava/io/File;->exists()Z

    move-result v4

    if-eqz v4, :cond_3

    invoke-virtual {v1}, Ljava/io/File;->isDirectory()Z

    move-result v4

    if-nez v4, :cond_4

    .line 231
    :cond_3
    invoke-virtual {v1}, Ljava/io/File;->mkdir()Z

    .line 233
    :cond_4
    move-object v0, v1

    .line 225
    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    .end local v1    # "dir2":Ljava/io/File;
    :cond_5
    move v4, v5

    .line 236
    goto :goto_0
.end method
