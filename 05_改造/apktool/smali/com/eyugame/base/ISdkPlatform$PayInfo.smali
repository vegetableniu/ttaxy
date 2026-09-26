.class public Lcom/eyugame/base/ISdkPlatform$PayInfo;
.super Ljava/lang/Object;
.source "ISdkPlatform.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/eyugame/base/ISdkPlatform;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1
    name = "PayInfo"
.end annotation


# instance fields
.field public strAccountId:Ljava/lang/String;

.field public strCurrencyCount:Ljava/lang/String;

.field public strGoodName:Ljava/lang/String;

.field public strGoodextension:Ljava/lang/String;

.field public strGoodsCount:Ljava/lang/String;

.field public strGoodsDiscount:Ljava/lang/String;

.field public strGoodsId:Ljava/lang/String;

.field public strGoodsPrice:Ljava/lang/String;

.field public strGoodsType:Ljava/lang/String;

.field public strOperaterOrderId:Ljava/lang/String;

.field public strOrderId:Ljava/lang/String;

.field public strServerId:Ljava/lang/String;

.field public strServerName:Ljava/lang/String;

.field public strUrlParams:Ljava/lang/String;

.field public strUserName:Ljava/lang/String;

.field final synthetic this$0:Lcom/eyugame/base/ISdkPlatform;


# direct methods
.method private constructor <init>(Lcom/eyugame/base/ISdkPlatform;)V
    .locals 0
    .param p1, "this$0"    # Lcom/eyugame/base/ISdkPlatform;

    .prologue
    .line 27
    iput-object p1, p0, Lcom/eyugame/base/ISdkPlatform$PayInfo;->this$0:Lcom/eyugame/base/ISdkPlatform;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 28
    return-void
.end method

.method synthetic constructor <init>(Lcom/eyugame/base/ISdkPlatform;Lcom/eyugame/base/ISdkPlatform$1;)V
    .locals 0
    .param p1, "x0"    # Lcom/eyugame/base/ISdkPlatform;
    .param p2, "x1"    # Lcom/eyugame/base/ISdkPlatform$1;

    .prologue
    .line 26
    invoke-direct {p0, p1}, Lcom/eyugame/base/ISdkPlatform$PayInfo;-><init>(Lcom/eyugame/base/ISdkPlatform;)V

    return-void
.end method


# virtual methods
.method public Reset()V
    .locals 1

    .prologue
    .line 31
    const-string v0, ""

    iput-object v0, p0, Lcom/eyugame/base/ISdkPlatform$PayInfo;->strOrderId:Ljava/lang/String;

    .line 32
    const-string v0, ""

    iput-object v0, p0, Lcom/eyugame/base/ISdkPlatform$PayInfo;->strServerId:Ljava/lang/String;

    .line 33
    const-string v0, ""

    iput-object v0, p0, Lcom/eyugame/base/ISdkPlatform$PayInfo;->strGoodsId:Ljava/lang/String;

    .line 34
    const-string v0, ""

    iput-object v0, p0, Lcom/eyugame/base/ISdkPlatform$PayInfo;->strGoodsCount:Ljava/lang/String;

    .line 35
    const-string v0, ""

    iput-object v0, p0, Lcom/eyugame/base/ISdkPlatform$PayInfo;->strGoodsPrice:Ljava/lang/String;

    .line 36
    const-string v0, ""

    iput-object v0, p0, Lcom/eyugame/base/ISdkPlatform$PayInfo;->strGoodName:Ljava/lang/String;

    .line 37
    const-string v0, ""

    iput-object v0, p0, Lcom/eyugame/base/ISdkPlatform$PayInfo;->strGoodsDiscount:Ljava/lang/String;

    .line 38
    const-string v0, ""

    iput-object v0, p0, Lcom/eyugame/base/ISdkPlatform$PayInfo;->strAccountId:Ljava/lang/String;

    .line 39
    const-string v0, ""

    iput-object v0, p0, Lcom/eyugame/base/ISdkPlatform$PayInfo;->strServerName:Ljava/lang/String;

    .line 40
    const-string v0, ""

    iput-object v0, p0, Lcom/eyugame/base/ISdkPlatform$PayInfo;->strUserName:Ljava/lang/String;

    .line 41
    const-string v0, ""

    iput-object v0, p0, Lcom/eyugame/base/ISdkPlatform$PayInfo;->strOperaterOrderId:Ljava/lang/String;

    .line 42
    const-string v0, ""

    iput-object v0, p0, Lcom/eyugame/base/ISdkPlatform$PayInfo;->strGoodsType:Ljava/lang/String;

    .line 43
    const-string v0, ""

    iput-object v0, p0, Lcom/eyugame/base/ISdkPlatform$PayInfo;->strCurrencyCount:Ljava/lang/String;

    .line 44
    const-string v0, ""

    iput-object v0, p0, Lcom/eyugame/base/ISdkPlatform$PayInfo;->strUrlParams:Ljava/lang/String;

    .line 45
    const-string v0, ""

    iput-object v0, p0, Lcom/eyugame/base/ISdkPlatform$PayInfo;->strGoodextension:Ljava/lang/String;

    .line 46
    return-void
.end method
