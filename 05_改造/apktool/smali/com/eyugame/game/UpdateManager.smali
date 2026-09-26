.class public Lcom/eyugame/game/UpdateManager;
.super Ljava/lang/Object;
.source "UpdateManager.java"

# interfaces
.implements Lcom/eyugame/base/IPackageUpdate;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/eyugame/game/UpdateManager$DownloadApkThread;,
        Lcom/eyugame/game/UpdateManager$CheckThread;,
        Lcom/eyugame/game/UpdateManager$CheckHandler;,
        Lcom/eyugame/game/UpdateManager$DwonloadApkHandler;
    }
.end annotation


# static fields
.field private static final DOWNLOAD:I = 0x1

.field private static final DOWNLOAD_FAIL_CHECK_MD5:I = 0x5

.field private static final DOWNLOAD_FAIL_NET:I = 0x6

.field private static final DOWNLOAD_FAIL_NO_SDCARD:I = 0x3

.field private static final DOWNLOAD_FAIL_SDCARD_SHARE:I = 0x4

.field private static final DOWNLOAD_FAIL_SERVER:I = 0x8

.field private static final DOWNLOAD_FAIL_WRITE:I = 0x7

.field private static final DOWNLOAD_FINISH:I = 0x2

.field private static final HAVE_UPDATE:I = 0x1

.field private static final NONE_UPDATE:I = 0x2

.field private static mCheckHandler:Lcom/eyugame/game/UpdateManager$CheckHandler;

.field private static mDwonloadApkHandler:Lcom/eyugame/game/UpdateManager$DwonloadApkHandler;


# instance fields
.field private cancelUpdate:Z

.field private mContext:Landroid/content/Context;

.field private mDownloadDialog:Landroid/app/Dialog;

.field mHashMap:Ljava/util/HashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/HashMap",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private mPackageUrl:Ljava/lang/String;

.field private mProgressBar:Landroid/widget/ProgressBar;

.field private mSavePath:Ljava/lang/String;

.field private mTextPrg:Landroid/widget/TextView;

.field private mTimeOut:I

.field private mVersionUrl:Ljava/lang/String;

.field private progress:I


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    const/4 v0, 0x0

    .line 80
    sput-object v0, Lcom/eyugame/game/UpdateManager;->mCheckHandler:Lcom/eyugame/game/UpdateManager$CheckHandler;

    .line 81
    sput-object v0, Lcom/eyugame/game/UpdateManager;->mDwonloadApkHandler:Lcom/eyugame/game/UpdateManager$DwonloadApkHandler;

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;)V
    .locals 1
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    .line 127
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 68
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/eyugame/game/UpdateManager;->cancelUpdate:Z

    .line 79
    const/16 v0, 0xbb8

    iput v0, p0, Lcom/eyugame/game/UpdateManager;->mTimeOut:I

    .line 128
    iput-object p1, p0, Lcom/eyugame/game/UpdateManager;->mContext:Landroid/content/Context;

    .line 129
    return-void
.end method

.method static synthetic access$000(Lcom/eyugame/game/UpdateManager;)I
    .locals 1
    .param p0, "x0"    # Lcom/eyugame/game/UpdateManager;

    .prologue
    .line 43
    iget v0, p0, Lcom/eyugame/game/UpdateManager;->progress:I

    return v0
.end method

.method static synthetic access$002(Lcom/eyugame/game/UpdateManager;I)I
    .locals 0
    .param p0, "x0"    # Lcom/eyugame/game/UpdateManager;
    .param p1, "x1"    # I

    .prologue
    .line 43
    iput p1, p0, Lcom/eyugame/game/UpdateManager;->progress:I

    return p1
.end method

.method static synthetic access$100(Lcom/eyugame/game/UpdateManager;)Landroid/widget/TextView;
    .locals 1
    .param p0, "x0"    # Lcom/eyugame/game/UpdateManager;

    .prologue
    .line 43
    iget-object v0, p0, Lcom/eyugame/game/UpdateManager;->mTextPrg:Landroid/widget/TextView;

    return-object v0
.end method

.method static synthetic access$1000(Lcom/eyugame/game/UpdateManager;)Ljava/lang/String;
    .locals 1
    .param p0, "x0"    # Lcom/eyugame/game/UpdateManager;

    .prologue
    .line 43
    iget-object v0, p0, Lcom/eyugame/game/UpdateManager;->mPackageUrl:Ljava/lang/String;

    return-object v0
.end method

.method static synthetic access$1100(Lcom/eyugame/game/UpdateManager;)V
    .locals 0
    .param p0, "x0"    # Lcom/eyugame/game/UpdateManager;

    .prologue
    .line 43
    invoke-direct {p0}, Lcom/eyugame/game/UpdateManager;->showDownloadDialog()V

    return-void
.end method

.method static synthetic access$1200(Lcom/eyugame/game/UpdateManager;)Z
    .locals 1
    .param p0, "x0"    # Lcom/eyugame/game/UpdateManager;

    .prologue
    .line 43
    iget-boolean v0, p0, Lcom/eyugame/game/UpdateManager;->cancelUpdate:Z

    return v0
.end method

.method static synthetic access$1202(Lcom/eyugame/game/UpdateManager;Z)Z
    .locals 0
    .param p0, "x0"    # Lcom/eyugame/game/UpdateManager;
    .param p1, "x1"    # Z

    .prologue
    .line 43
    iput-boolean p1, p0, Lcom/eyugame/game/UpdateManager;->cancelUpdate:Z

    return p1
.end method

.method static synthetic access$1400()Lcom/eyugame/game/UpdateManager$DwonloadApkHandler;
    .locals 1

    .prologue
    .line 43
    sget-object v0, Lcom/eyugame/game/UpdateManager;->mDwonloadApkHandler:Lcom/eyugame/game/UpdateManager$DwonloadApkHandler;

    return-object v0
.end method

.method static synthetic access$1500(Lcom/eyugame/game/UpdateManager;)Landroid/app/Dialog;
    .locals 1
    .param p0, "x0"    # Lcom/eyugame/game/UpdateManager;

    .prologue
    .line 43
    iget-object v0, p0, Lcom/eyugame/game/UpdateManager;->mDownloadDialog:Landroid/app/Dialog;

    return-object v0
.end method

.method static synthetic access$1600(Lcom/eyugame/game/UpdateManager;)I
    .locals 1
    .param p0, "x0"    # Lcom/eyugame/game/UpdateManager;

    .prologue
    .line 43
    iget v0, p0, Lcom/eyugame/game/UpdateManager;->mTimeOut:I

    return v0
.end method

.method static synthetic access$200(Lcom/eyugame/game/UpdateManager;)Landroid/widget/ProgressBar;
    .locals 1
    .param p0, "x0"    # Lcom/eyugame/game/UpdateManager;

    .prologue
    .line 43
    iget-object v0, p0, Lcom/eyugame/game/UpdateManager;->mProgressBar:Landroid/widget/ProgressBar;

    return-object v0
.end method

.method static synthetic access$300(Lcom/eyugame/game/UpdateManager;)V
    .locals 0
    .param p0, "x0"    # Lcom/eyugame/game/UpdateManager;

    .prologue
    .line 43
    invoke-direct {p0}, Lcom/eyugame/game/UpdateManager;->installApk()V

    return-void
.end method

.method static synthetic access$400(Lcom/eyugame/game/UpdateManager;)V
    .locals 0
    .param p0, "x0"    # Lcom/eyugame/game/UpdateManager;

    .prologue
    .line 43
    invoke-direct {p0}, Lcom/eyugame/game/UpdateManager;->showBrowserDowloadDlg()V

    return-void
.end method

.method static synthetic access$500(Lcom/eyugame/game/UpdateManager;)Landroid/content/Context;
    .locals 1
    .param p0, "x0"    # Lcom/eyugame/game/UpdateManager;

    .prologue
    .line 43
    iget-object v0, p0, Lcom/eyugame/game/UpdateManager;->mContext:Landroid/content/Context;

    return-object v0
.end method

.method static synthetic access$600(Lcom/eyugame/game/UpdateManager;I)V
    .locals 0
    .param p0, "x0"    # Lcom/eyugame/game/UpdateManager;
    .param p1, "x1"    # I

    .prologue
    .line 43
    invoke-direct {p0, p1}, Lcom/eyugame/game/UpdateManager;->showDownloadFailDlg(I)V

    return-void
.end method

.method static synthetic access$700(Lcom/eyugame/game/UpdateManager;)V
    .locals 0
    .param p0, "x0"    # Lcom/eyugame/game/UpdateManager;

    .prologue
    .line 43
    invoke-direct {p0}, Lcom/eyugame/game/UpdateManager;->showNoticeDialog()V

    return-void
.end method

.method static synthetic access$800(Lcom/eyugame/game/UpdateManager;)Ljava/lang/String;
    .locals 1
    .param p0, "x0"    # Lcom/eyugame/game/UpdateManager;

    .prologue
    .line 43
    iget-object v0, p0, Lcom/eyugame/game/UpdateManager;->mSavePath:Ljava/lang/String;

    return-object v0
.end method

.method static synthetic access$900()Lcom/eyugame/game/UpdateManager$CheckHandler;
    .locals 1

    .prologue
    .line 43
    sget-object v0, Lcom/eyugame/game/UpdateManager;->mCheckHandler:Lcom/eyugame/game/UpdateManager$CheckHandler;

    return-object v0
.end method

.method private downloadApk()V
    .locals 2

    .prologue
    .line 295
    new-instance v0, Lcom/eyugame/game/UpdateManager$DwonloadApkHandler;

    invoke-direct {v0, p0}, Lcom/eyugame/game/UpdateManager$DwonloadApkHandler;-><init>(Lcom/eyugame/game/UpdateManager;)V

    sput-object v0, Lcom/eyugame/game/UpdateManager;->mDwonloadApkHandler:Lcom/eyugame/game/UpdateManager$DwonloadApkHandler;

    .line 296
    new-instance v0, Lcom/eyugame/game/UpdateManager$DownloadApkThread;

    const/4 v1, 0x0

    invoke-direct {v0, p0, v1}, Lcom/eyugame/game/UpdateManager$DownloadApkThread;-><init>(Lcom/eyugame/game/UpdateManager;Lcom/eyugame/game/UpdateManager$1;)V

    invoke-virtual {v0}, Lcom/eyugame/game/UpdateManager$DownloadApkThread;->start()V

    .line 297
    return-void
.end method

.method private getVersionCode(Landroid/content/Context;)I
    .locals 5
    .param p1, "context"    # Landroid/content/Context;

    .prologue
    .line 344
    const/4 v1, 0x0

    .line 348
    .local v1, "versionCode":I
    :try_start_0
    invoke-virtual {p1}, Landroid/content/Context;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v2

    .line 349
    invoke-virtual {p1}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v3

    const/16 v4, 0x80

    .line 348
    invoke-virtual {v2, v3, v4}, Landroid/content/pm/PackageManager;->getPackageInfo(Ljava/lang/String;I)Landroid/content/pm/PackageInfo;

    move-result-object v2

    iget v1, v2, Landroid/content/pm/PackageInfo;->versionCode:I
    :try_end_0
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    .line 353
    :goto_0
    return v1

    .line 350
    :catch_0
    move-exception v0

    .line 351
    .local v0, "e":Landroid/content/pm/PackageManager$NameNotFoundException;
    invoke-virtual {v0}, Landroid/content/pm/PackageManager$NameNotFoundException;->printStackTrace()V

    goto :goto_0
.end method

.method private installApk()V
    .locals 7

    .prologue
    .line 461
    new-instance v0, Ljava/io/File;

    iget-object v5, p0, Lcom/eyugame/game/UpdateManager;->mSavePath:Ljava/lang/String;

    iget-object v4, p0, Lcom/eyugame/game/UpdateManager;->mHashMap:Ljava/util/HashMap;

    const-string v6, "name"

    invoke-virtual {v4, v6}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/String;

    invoke-direct {v0, v5, v4}, Ljava/io/File;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    .line 462
    .local v0, "apkfile":Ljava/io/File;
    invoke-virtual {v0}, Ljava/io/File;->isFile()Z

    move-result v4

    if-eqz v4, :cond_0

    invoke-virtual {v0}, Ljava/io/File;->exists()Z

    move-result v4

    if-nez v4, :cond_1

    .line 480
    :cond_0
    :goto_0
    return-void

    .line 467
    :cond_1
    iget-object v4, p0, Lcom/eyugame/game/UpdateManager;->mHashMap:Ljava/util/HashMap;

    const-string v5, "md5"

    invoke-virtual {v4, v5}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    .line 468
    .local v2, "strCheckMd5":Ljava/lang/String;
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v5, p0, Lcom/eyugame/game/UpdateManager;->mSavePath:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "/"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    iget-object v4, p0, Lcom/eyugame/game/UpdateManager;->mHashMap:Ljava/util/HashMap;

    const-string v6, "name"

    invoke-virtual {v4, v6}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/String;

    invoke-virtual {v5, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lcom/eyugame/base/LocationUtils;->getFileMd5(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .line 469
    .local v3, "strFileMd5":Ljava/lang/String;
    invoke-virtual {v2, v3}, Ljava/lang/String;->compareToIgnoreCase(Ljava/lang/String;)I

    move-result v4

    if-eqz v4, :cond_2

    .line 471
    invoke-virtual {v0}, Ljava/io/File;->delete()Z

    .line 472
    sget-object v4, Lcom/eyugame/game/UpdateManager;->mDwonloadApkHandler:Lcom/eyugame/game/UpdateManager$DwonloadApkHandler;

    const/4 v5, 0x5

    invoke-virtual {v4, v5}, Lcom/eyugame/game/UpdateManager$DwonloadApkHandler;->sendEmptyMessage(I)Z

    goto :goto_0

    .line 476
    :cond_2
    new-instance v1, Landroid/content/Intent;

    const-string v4, "android.intent.action.VIEW"

    invoke-direct {v1, v4}, Landroid/content/Intent;-><init>(Ljava/lang/String;)V

    .line 477
    .local v1, "i":Landroid/content/Intent;
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "file://"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v0}, Ljava/io/File;->toString()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Landroid/net/Uri;->parse(Ljava/lang/String;)Landroid/net/Uri;

    move-result-object v4

    const-string v5, "application/vnd.android.package-archive"

    invoke-virtual {v1, v4, v5}, Landroid/content/Intent;->setDataAndType(Landroid/net/Uri;Ljava/lang/String;)Landroid/content/Intent;

    .line 478
    iget-object v4, p0, Lcom/eyugame/game/UpdateManager;->mContext:Landroid/content/Context;

    invoke-virtual {v4, v1}, Landroid/content/Context;->startActivity(Landroid/content/Intent;)V

    .line 479
    invoke-static {}, Lcom/eyugame/impt/RelayNative;->doExit()V

    goto :goto_0
.end method

.method private showBrowserDowloadDlg()V
    .locals 5

    .prologue
    .line 170
    new-instance v0, Landroid/app/AlertDialog$Builder;

    iget-object v2, p0, Lcom/eyugame/game/UpdateManager;->mContext:Landroid/content/Context;

    invoke-direct {v0, v2}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    .line 171
    .local v0, "builder":Landroid/app/AlertDialog$Builder;
    iget-object v2, p0, Lcom/eyugame/game/UpdateManager;->mContext:Landroid/content/Context;

    const-string v3, "string"

    const-string v4, "tip"

    invoke-static {v2, v3, v4}, Lcom/eyugame/game/MResource;->getIdByName(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v2

    invoke-virtual {v0, v2}, Landroid/app/AlertDialog$Builder;->setTitle(I)Landroid/app/AlertDialog$Builder;

    .line 172
    iget-object v2, p0, Lcom/eyugame/game/UpdateManager;->mContext:Landroid/content/Context;

    const-string v3, "string"

    const-string v4, "download_nosdcard"

    invoke-static {v2, v3, v4}, Lcom/eyugame/game/MResource;->getIdByName(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v2

    invoke-virtual {v0, v2}, Landroid/app/AlertDialog$Builder;->setMessage(I)Landroid/app/AlertDialog$Builder;

    .line 174
    iget-object v2, p0, Lcom/eyugame/game/UpdateManager;->mContext:Landroid/content/Context;

    const-string v3, "string"

    const-string v4, "confirm"

    invoke-static {v2, v3, v4}, Lcom/eyugame/game/MResource;->getIdByName(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v2

    new-instance v3, Lcom/eyugame/game/UpdateManager$1;

    invoke-direct {v3, p0}, Lcom/eyugame/game/UpdateManager$1;-><init>(Lcom/eyugame/game/UpdateManager;)V

    invoke-virtual {v0, v2, v3}, Landroid/app/AlertDialog$Builder;->setPositiveButton(ILandroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    .line 190
    iget-object v2, p0, Lcom/eyugame/game/UpdateManager;->mContext:Landroid/content/Context;

    const-string v3, "string"

    const-string v4, "cancel"

    invoke-static {v2, v3, v4}, Lcom/eyugame/game/MResource;->getIdByName(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v2

    new-instance v3, Lcom/eyugame/game/UpdateManager$2;

    invoke-direct {v3, p0}, Lcom/eyugame/game/UpdateManager$2;-><init>(Lcom/eyugame/game/UpdateManager;)V

    invoke-virtual {v0, v2, v3}, Landroid/app/AlertDialog$Builder;->setNegativeButton(ILandroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    .line 198
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->create()Landroid/app/AlertDialog;

    move-result-object v1

    .line 200
    .local v1, "noticeDialog":Landroid/app/AlertDialog;
    invoke-virtual {v1}, Landroid/app/AlertDialog;->show()V

    .line 201
    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Landroid/app/AlertDialog;->setCancelable(Z)V

    .line 202
    return-void
.end method

.method private showDownloadDialog()V
    .locals 6

    .prologue
    .line 266
    new-instance v0, Landroid/app/AlertDialog$Builder;

    iget-object v3, p0, Lcom/eyugame/game/UpdateManager;->mContext:Landroid/content/Context;

    invoke-direct {v0, v3}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    .line 267
    .local v0, "builder":Landroid/app/AlertDialog$Builder;
    iget-object v3, p0, Lcom/eyugame/game/UpdateManager;->mContext:Landroid/content/Context;

    const-string v4, "string"

    const-string v5, "update_title_ing"

    invoke-static {v3, v4, v5}, Lcom/eyugame/game/MResource;->getIdByName(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v3

    invoke-virtual {v0, v3}, Landroid/app/AlertDialog$Builder;->setTitle(I)Landroid/app/AlertDialog$Builder;

    .line 269
    iget-object v3, p0, Lcom/eyugame/game/UpdateManager;->mContext:Landroid/content/Context;

    invoke-static {v3}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object v1

    .line 270
    .local v1, "inflater":Landroid/view/LayoutInflater;
    iget-object v3, p0, Lcom/eyugame/game/UpdateManager;->mContext:Landroid/content/Context;

    const-string v4, "layout"

    const-string v5, "update_progress"

    invoke-static {v3, v4, v5}, Lcom/eyugame/game/MResource;->getIdByName(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v3

    const/4 v4, 0x0

    invoke-virtual {v1, v3, v4}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object v2

    .line 271
    .local v2, "view":Landroid/view/View;
    iget-object v3, p0, Lcom/eyugame/game/UpdateManager;->mContext:Landroid/content/Context;

    const-string v4, "id"

    const-string v5, "update_progress"

    invoke-static {v3, v4, v5}, Lcom/eyugame/game/MResource;->getIdByName(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v3

    invoke-virtual {v2, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v3

    check-cast v3, Landroid/widget/ProgressBar;

    iput-object v3, p0, Lcom/eyugame/game/UpdateManager;->mProgressBar:Landroid/widget/ProgressBar;

    .line 272
    iget-object v3, p0, Lcom/eyugame/game/UpdateManager;->mContext:Landroid/content/Context;

    const-string v4, "id"

    const-string v5, "text_prg"

    invoke-static {v3, v4, v5}, Lcom/eyugame/game/MResource;->getIdByName(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v3

    invoke-virtual {v2, v3}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v3

    check-cast v3, Landroid/widget/TextView;

    iput-object v3, p0, Lcom/eyugame/game/UpdateManager;->mTextPrg:Landroid/widget/TextView;

    .line 273
    invoke-virtual {v0, v2}, Landroid/app/AlertDialog$Builder;->setView(Landroid/view/View;)Landroid/app/AlertDialog$Builder;

    .line 274
    iget-object v3, p0, Lcom/eyugame/game/UpdateManager;->mContext:Landroid/content/Context;

    const-string v4, "string"

    const-string v5, "update_cancel"

    invoke-static {v3, v4, v5}, Lcom/eyugame/game/MResource;->getIdByName(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v3

    new-instance v4, Lcom/eyugame/game/UpdateManager$7;

    invoke-direct {v4, p0}, Lcom/eyugame/game/UpdateManager$7;-><init>(Lcom/eyugame/game/UpdateManager;)V

    invoke-virtual {v0, v3, v4}, Landroid/app/AlertDialog$Builder;->setNegativeButton(ILandroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    .line 284
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->create()Landroid/app/AlertDialog;

    move-result-object v3

    iput-object v3, p0, Lcom/eyugame/game/UpdateManager;->mDownloadDialog:Landroid/app/Dialog;

    .line 285
    iget-object v3, p0, Lcom/eyugame/game/UpdateManager;->mDownloadDialog:Landroid/app/Dialog;

    invoke-virtual {v3}, Landroid/app/Dialog;->show()V

    .line 286
    iget-object v3, p0, Lcom/eyugame/game/UpdateManager;->mDownloadDialog:Landroid/app/Dialog;

    const/4 v4, 0x0

    invoke-virtual {v3, v4}, Landroid/app/Dialog;->setCancelable(Z)V

    .line 288
    invoke-direct {p0}, Lcom/eyugame/game/UpdateManager;->downloadApk()V

    .line 289
    return-void
.end method

.method private showDownloadFailDlg(I)V
    .locals 5
    .param p1, "strId"    # I

    .prologue
    .line 206
    new-instance v0, Landroid/app/AlertDialog$Builder;

    iget-object v2, p0, Lcom/eyugame/game/UpdateManager;->mContext:Landroid/content/Context;

    invoke-direct {v0, v2}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    .line 207
    .local v0, "builder":Landroid/app/AlertDialog$Builder;
    iget-object v2, p0, Lcom/eyugame/game/UpdateManager;->mContext:Landroid/content/Context;

    const-string v3, "string"

    const-string v4, "tip"

    invoke-static {v2, v3, v4}, Lcom/eyugame/game/MResource;->getIdByName(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v2

    invoke-virtual {v0, v2}, Landroid/app/AlertDialog$Builder;->setTitle(I)Landroid/app/AlertDialog$Builder;

    .line 208
    invoke-virtual {v0, p1}, Landroid/app/AlertDialog$Builder;->setMessage(I)Landroid/app/AlertDialog$Builder;

    .line 210
    iget-object v2, p0, Lcom/eyugame/game/UpdateManager;->mContext:Landroid/content/Context;

    const-string v3, "string"

    const-string v4, "confirm"

    invoke-static {v2, v3, v4}, Lcom/eyugame/game/MResource;->getIdByName(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v2

    new-instance v3, Lcom/eyugame/game/UpdateManager$3;

    invoke-direct {v3, p0}, Lcom/eyugame/game/UpdateManager$3;-><init>(Lcom/eyugame/game/UpdateManager;)V

    invoke-virtual {v0, v2, v3}, Landroid/app/AlertDialog$Builder;->setPositiveButton(ILandroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    .line 220
    iget-object v2, p0, Lcom/eyugame/game/UpdateManager;->mContext:Landroid/content/Context;

    const-string v3, "string"

    const-string v4, "cancel"

    invoke-static {v2, v3, v4}, Lcom/eyugame/game/MResource;->getIdByName(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v2

    new-instance v3, Lcom/eyugame/game/UpdateManager$4;

    invoke-direct {v3, p0}, Lcom/eyugame/game/UpdateManager$4;-><init>(Lcom/eyugame/game/UpdateManager;)V

    invoke-virtual {v0, v2, v3}, Landroid/app/AlertDialog$Builder;->setNegativeButton(ILandroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    .line 228
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->create()Landroid/app/AlertDialog;

    move-result-object v1

    .line 230
    .local v1, "noticeDialog":Landroid/app/AlertDialog;
    invoke-virtual {v1}, Landroid/app/AlertDialog;->show()V

    .line 231
    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Landroid/app/AlertDialog;->setCancelable(Z)V

    .line 232
    return-void
.end method

.method private showNoticeDialog()V
    .locals 5

    .prologue
    .line 236
    new-instance v0, Landroid/app/AlertDialog$Builder;

    iget-object v2, p0, Lcom/eyugame/game/UpdateManager;->mContext:Landroid/content/Context;

    invoke-direct {v0, v2}, Landroid/app/AlertDialog$Builder;-><init>(Landroid/content/Context;)V

    .line 237
    .local v0, "builder":Landroid/app/AlertDialog$Builder;
    iget-object v2, p0, Lcom/eyugame/game/UpdateManager;->mContext:Landroid/content/Context;

    const-string v3, "string"

    const-string v4, "update_title"

    invoke-static {v2, v3, v4}, Lcom/eyugame/game/MResource;->getIdByName(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v2

    invoke-virtual {v0, v2}, Landroid/app/AlertDialog$Builder;->setTitle(I)Landroid/app/AlertDialog$Builder;

    .line 238
    iget-object v2, p0, Lcom/eyugame/game/UpdateManager;->mContext:Landroid/content/Context;

    const-string v3, "string"

    const-string v4, "update_content"

    invoke-static {v2, v3, v4}, Lcom/eyugame/game/MResource;->getIdByName(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v2

    invoke-virtual {v0, v2}, Landroid/app/AlertDialog$Builder;->setMessage(I)Landroid/app/AlertDialog$Builder;

    .line 240
    iget-object v2, p0, Lcom/eyugame/game/UpdateManager;->mContext:Landroid/content/Context;

    const-string v3, "string"

    const-string v4, "update_btn_yes"

    invoke-static {v2, v3, v4}, Lcom/eyugame/game/MResource;->getIdByName(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v2

    new-instance v3, Lcom/eyugame/game/UpdateManager$5;

    invoke-direct {v3, p0}, Lcom/eyugame/game/UpdateManager$5;-><init>(Lcom/eyugame/game/UpdateManager;)V

    invoke-virtual {v0, v2, v3}, Landroid/app/AlertDialog$Builder;->setPositiveButton(ILandroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    .line 250
    iget-object v2, p0, Lcom/eyugame/game/UpdateManager;->mContext:Landroid/content/Context;

    const-string v3, "string"

    const-string v4, "update_btn_no"

    invoke-static {v2, v3, v4}, Lcom/eyugame/game/MResource;->getIdByName(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)I

    move-result v2

    new-instance v3, Lcom/eyugame/game/UpdateManager$6;

    invoke-direct {v3, p0}, Lcom/eyugame/game/UpdateManager$6;-><init>(Lcom/eyugame/game/UpdateManager;)V

    invoke-virtual {v0, v2, v3}, Landroid/app/AlertDialog$Builder;->setNegativeButton(ILandroid/content/DialogInterface$OnClickListener;)Landroid/app/AlertDialog$Builder;

    .line 258
    invoke-virtual {v0}, Landroid/app/AlertDialog$Builder;->create()Landroid/app/AlertDialog;

    move-result-object v1

    .line 260
    .local v1, "noticeDialog":Landroid/app/AlertDialog;
    invoke-virtual {v1}, Landroid/app/AlertDialog;->show()V

    .line 261
    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Landroid/app/AlertDialog;->setCancelable(Z)V

    .line 262
    return-void
.end method


# virtual methods
.method public checkUpdate(Ljava/lang/String;Landroid/app/Activity;)Z
    .locals 1

    const/4 v0, 0x1

    invoke-static {v0}, Lcom/eyugame/impt/RelayNative;->OnAutoPatch(I)V

    return v0
.end method

.method public isUpdate()Z
    .locals 14

    .prologue
    const/4 v9, 0x1

    const/4 v10, 0x0

    .line 306
    iget-object v8, p0, Lcom/eyugame/game/UpdateManager;->mContext:Landroid/content/Context;

    invoke-direct {p0, v8}, Lcom/eyugame/game/UpdateManager;->getVersionCode(Landroid/content/Context;)I

    move-result v7

    .line 311
    .local v7, "versionCode":I
    :try_start_0
    new-instance v5, Ljava/net/URL;

    iget-object v8, p0, Lcom/eyugame/game/UpdateManager;->mVersionUrl:Ljava/lang/String;

    invoke-direct {v5, v8}, Ljava/net/URL;-><init>(Ljava/lang/String;)V

    .line 312
    .local v5, "url":Ljava/net/URL;
    invoke-virtual {v5}, Ljava/net/URL;->openConnection()Ljava/net/URLConnection;

    move-result-object v6

    check-cast v6, Ljava/net/HttpURLConnection;

    .line 313
    .local v6, "urlConn":Ljava/net/HttpURLConnection;
    iget v8, p0, Lcom/eyugame/game/UpdateManager;->mTimeOut:I

    invoke-virtual {v6, v8}, Ljava/net/HttpURLConnection;->setConnectTimeout(I)V

    .line 314
    invoke-virtual {v6}, Ljava/net/HttpURLConnection;->getInputStream()Ljava/io/InputStream;

    move-result-object v1

    .line 315
    .local v1, "inputStream":Ljava/io/InputStream;
    invoke-virtual {p0, v1}, Lcom/eyugame/game/UpdateManager;->parseXml(Ljava/io/InputStream;)Ljava/util/HashMap;

    move-result-object v8

    iput-object v8, p0, Lcom/eyugame/game/UpdateManager;->mHashMap:Ljava/util/HashMap;

    .line 316
    iget-object v8, p0, Lcom/eyugame/game/UpdateManager;->mHashMap:Ljava/util/HashMap;

    if-eqz v8, :cond_0

    .line 317
    iget-object v8, p0, Lcom/eyugame/game/UpdateManager;->mHashMap:Ljava/util/HashMap;

    const-string v11, "version"

    invoke-virtual {v8, v11}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v8

    check-cast v8, Ljava/lang/String;

    invoke-virtual {v8}, Ljava/lang/String;->toString()Ljava/lang/String;

    move-result-object v4

    .line 318
    .local v4, "strServerVersion":Ljava/lang/String;
    invoke-static {v4}, Ljava/lang/Integer;->valueOf(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/Integer;->intValue()I

    move-result v2

    .line 320
    .local v2, "serviceVersionCode":I
    if-le v2, v7, :cond_1

    move v8, v9

    .line 335
    .end local v1    # "inputStream":Ljava/io/InputStream;
    .end local v2    # "serviceVersionCode":I
    .end local v4    # "strServerVersion":Ljava/lang/String;
    .end local v5    # "url":Ljava/net/URL;
    .end local v6    # "urlConn":Ljava/net/HttpURLConnection;
    :goto_0
    return v8

    .line 326
    .restart local v1    # "inputStream":Ljava/io/InputStream;
    .restart local v5    # "url":Ljava/net/URL;
    .restart local v6    # "urlConn":Ljava/net/HttpURLConnection;
    :cond_0
    const-string v8, "parseXml url %s fail"

    const/4 v11, 0x1

    new-array v11, v11, [Ljava/lang/Object;

    const/4 v12, 0x0

    iget-object v13, p0, Lcom/eyugame/game/UpdateManager;->mVersionUrl:Ljava/lang/String;

    aput-object v13, v11, v12

    invoke-static {v8, v11}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    .line 327
    .local v3, "strMsg":Ljava/lang/String;
    invoke-static {v3}, Lcom/eyugame/impt/RelayNative;->LogMsg(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .end local v1    # "inputStream":Ljava/io/InputStream;
    .end local v3    # "strMsg":Ljava/lang/String;
    .end local v5    # "url":Ljava/net/URL;
    .end local v6    # "urlConn":Ljava/net/HttpURLConnection;
    :cond_1
    :goto_1
    move v8, v10

    .line 335
    goto :goto_0

    .line 329
    :catch_0
    move-exception v0

    .line 330
    .local v0, "e1":Ljava/lang/Exception;
    const-string v8, "func: check package isUpdate, url is %s\nerror msg: %s"

    const/4 v11, 0x2

    new-array v11, v11, [Ljava/lang/Object;

    iget-object v12, p0, Lcom/eyugame/game/UpdateManager;->mVersionUrl:Ljava/lang/String;

    aput-object v12, v11, v10

    invoke-virtual {v0}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object v12

    aput-object v12, v11, v9

    invoke-static {v8, v11}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v3

    .line 331
    .restart local v3    # "strMsg":Ljava/lang/String;
    invoke-static {v3}, Lcom/eyugame/impt/RelayNative;->LogMsg(Ljava/lang/String;)V

    .line 332
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    goto :goto_1
.end method

.method public parseXml(Ljava/io/InputStream;)Ljava/util/HashMap;
    .locals 12
    .param p1, "inStream"    # Ljava/io/InputStream;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/io/InputStream;",
            ")",
            "Ljava/util/HashMap",
            "<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation

    .prologue
    const/4 v11, 0x1

    const/4 v10, 0x0

    .line 484
    new-instance v2, Ljava/util/HashMap;

    invoke-direct {v2}, Ljava/util/HashMap;-><init>()V

    .line 487
    .local v2, "hashMap":Ljava/util/HashMap;, "Ljava/util/HashMap<Ljava/lang/String;Ljava/lang/String;>;"
    :try_start_0
    new-instance v0, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v0}, Ljava/io/ByteArrayOutputStream;-><init>()V

    .line 488
    .local v0, "baos":Ljava/io/ByteArrayOutputStream;
    const/4 v3, -0x1

    .line 489
    .local v3, "i":I
    :goto_0
    invoke-virtual {p1}, Ljava/io/InputStream;->read()I

    move-result v3

    const/4 v7, -0x1

    if-eq v3, v7, :cond_0

    .line 490
    invoke-virtual {v0, v3}, Ljava/io/ByteArrayOutputStream;->write(I)V
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_1

    goto :goto_0

    .line 500
    .end local v0    # "baos":Ljava/io/ByteArrayOutputStream;
    .end local v3    # "i":I
    :catch_0
    move-exception v1

    .line 501
    .local v1, "e":Lorg/json/JSONException;
    const-string v7, "get package version info fail msg: %s"

    new-array v8, v11, [Ljava/lang/Object;

    invoke-virtual {v1}, Lorg/json/JSONException;->getMessage()Ljava/lang/String;

    move-result-object v9

    aput-object v9, v8, v10

    invoke-static {v7, v8}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    .line 502
    .local v5, "strMsg":Ljava/lang/String;
    invoke-static {v5}, Lcom/eyugame/impt/RelayNative;->LogMsg(Ljava/lang/String;)V

    .line 503
    invoke-virtual {v1}, Lorg/json/JSONException;->printStackTrace()V

    .line 510
    .end local v1    # "e":Lorg/json/JSONException;
    .end local v5    # "strMsg":Ljava/lang/String;
    :goto_1
    return-object v2

    .line 493
    .restart local v0    # "baos":Ljava/io/ByteArrayOutputStream;
    .restart local v3    # "i":I
    :cond_0
    :try_start_1
    invoke-virtual {v0}, Ljava/io/ByteArrayOutputStream;->toString()Ljava/lang/String;

    move-result-object v6

    .line 494
    .local v6, "strVersion":Ljava/lang/String;
    new-instance v4, Lorg/json/JSONObject;

    invoke-direct {v4, v6}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 495
    .local v4, "jsonObject":Lorg/json/JSONObject;
    const-string v7, "url"

    const-string v8, "url"

    invoke-virtual {v4, v8}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v2, v7, v8}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 496
    const-string v7, "version"

    const-string v8, "version"

    invoke-virtual {v4, v8}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v2, v7, v8}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 497
    const-string v7, "md5"

    const-string v8, "md5"

    invoke-virtual {v4, v8}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v2, v7, v8}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 498
    const-string v7, "size"

    const-string v8, "size"

    invoke-virtual {v4, v8}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v2, v7, v8}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 499
    const-string v7, "name"

    new-instance v8, Ljava/lang/StringBuilder;

    invoke-direct {v8}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {}, Lorg/cocos2dx/lib/Cocos2dxHelper;->getCocos2dxPackageName()Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, "version"

    invoke-virtual {v4, v9}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v9

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    const-string v9, ".apk"

    invoke-virtual {v8, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v2, v7, v8}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    :try_end_1
    .catch Lorg/json/JSONException; {:try_start_1 .. :try_end_1} :catch_0
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_1

    .line 504
    .end local v0    # "baos":Ljava/io/ByteArrayOutputStream;
    .end local v3    # "i":I
    .end local v4    # "jsonObject":Lorg/json/JSONObject;
    .end local v6    # "strVersion":Ljava/lang/String;
    :catch_1
    move-exception v1

    .line 505
    .local v1, "e":Ljava/io/IOException;
    const-string v7, "get package version info fail msg: %s"

    new-array v8, v11, [Ljava/lang/Object;

    invoke-virtual {v1}, Ljava/io/IOException;->getMessage()Ljava/lang/String;

    move-result-object v9

    aput-object v9, v8, v10

    invoke-static {v7, v8}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v5

    .line 506
    .restart local v5    # "strMsg":Ljava/lang/String;
    invoke-static {v5}, Lcom/eyugame/impt/RelayNative;->LogMsg(Ljava/lang/String;)V

    .line 507
    invoke-virtual {v1}, Ljava/io/IOException;->printStackTrace()V

    goto :goto_1
.end method

.method public update(Ljava/lang/String;Ljava/lang/String;I)V
    .locals 2
    .param p1, "strVersionURL"    # Ljava/lang/String;
    .param p2, "strPackageURL"    # Ljava/lang/String;
    .param p3, "timeOut"    # I

    .prologue
    .line 549
    const-string v0, ""

    invoke-virtual {p1, v0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 560
    :goto_0
    return-void

    .line 553
    :cond_0
    iput-object p1, p0, Lcom/eyugame/game/UpdateManager;->mVersionUrl:Ljava/lang/String;

    .line 554
    iput-object p2, p0, Lcom/eyugame/game/UpdateManager;->mPackageUrl:Ljava/lang/String;

    .line 555
    iput p3, p0, Lcom/eyugame/game/UpdateManager;->mTimeOut:I

    .line 556
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {}, Landroid/os/Environment;->getExternalStorageDirectory()Ljava/io/File;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "/eyugame/"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-static {}, Lorg/cocos2dx/lib/Cocos2dxHelper;->getCocos2dxPackageName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/eyugame/game/UpdateManager;->mSavePath:Ljava/lang/String;

    .line 558
    new-instance v0, Lcom/eyugame/game/UpdateManager$CheckHandler;

    invoke-direct {v0, p0}, Lcom/eyugame/game/UpdateManager$CheckHandler;-><init>(Lcom/eyugame/game/UpdateManager;)V

    sput-object v0, Lcom/eyugame/game/UpdateManager;->mCheckHandler:Lcom/eyugame/game/UpdateManager$CheckHandler;

    .line 559
    new-instance v0, Lcom/eyugame/game/UpdateManager$CheckThread;

    const/4 v1, 0x0

    invoke-direct {v0, p0, v1}, Lcom/eyugame/game/UpdateManager$CheckThread;-><init>(Lcom/eyugame/game/UpdateManager;Lcom/eyugame/game/UpdateManager$1;)V

    invoke-virtual {v0}, Lcom/eyugame/game/UpdateManager$CheckThread;->start()V

    goto :goto_0
.end method
