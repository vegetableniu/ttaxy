.class public Lcom/eyugame/base/ISdkPlatform$EyLoginInfo;
.super Ljava/lang/Object;
.source "ISdkPlatform.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/eyugame/base/ISdkPlatform;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1
    name = "EyLoginInfo"
.end annotation


# instance fields
.field public bIsFirstLogin:Z

.field public lTime:J

.field public strAccountId:Ljava/lang/String;

.field public strServerId:Ljava/lang/String;

.field public strServerName:Ljava/lang/String;

.field public strUserLevel:Ljava/lang/String;

.field public strUserName:Ljava/lang/String;

.field final synthetic this$0:Lcom/eyugame/base/ISdkPlatform;


# direct methods
.method private constructor <init>(Lcom/eyugame/base/ISdkPlatform;)V
    .locals 0
    .param p1, "this$0"    # Lcom/eyugame/base/ISdkPlatform;

    .prologue
    .line 66
    iput-object p1, p0, Lcom/eyugame/base/ISdkPlatform$EyLoginInfo;->this$0:Lcom/eyugame/base/ISdkPlatform;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 68
    return-void
.end method

.method synthetic constructor <init>(Lcom/eyugame/base/ISdkPlatform;Lcom/eyugame/base/ISdkPlatform$1;)V
    .locals 0
    .param p1, "x0"    # Lcom/eyugame/base/ISdkPlatform;
    .param p2, "x1"    # Lcom/eyugame/base/ISdkPlatform$1;

    .prologue
    .line 65
    invoke-direct {p0, p1}, Lcom/eyugame/base/ISdkPlatform$EyLoginInfo;-><init>(Lcom/eyugame/base/ISdkPlatform;)V

    return-void
.end method
