.class public Lcom/eyugame/base/SdkPlatformFactory;
.super Ljava/lang/Object;
.source "SdkPlatformFactory.java"


# static fields
.field private static s_sdkPlatformFactory:Lcom/eyugame/base/SdkPlatformFactory;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 6
    const/4 v0, 0x0

    sput-object v0, Lcom/eyugame/base/SdkPlatformFactory;->s_sdkPlatformFactory:Lcom/eyugame/base/SdkPlatformFactory;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .prologue
    .line 8
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static getSingleton()Lcom/eyugame/base/SdkPlatformFactory;
    .locals 1

    .prologue
    .line 11
    sget-object v0, Lcom/eyugame/base/SdkPlatformFactory;->s_sdkPlatformFactory:Lcom/eyugame/base/SdkPlatformFactory;

    if-nez v0, :cond_0

    .line 12
    new-instance v0, Lcom/eyugame/base/SdkPlatformFactory;

    invoke-direct {v0}, Lcom/eyugame/base/SdkPlatformFactory;-><init>()V

    sput-object v0, Lcom/eyugame/base/SdkPlatformFactory;->s_sdkPlatformFactory:Lcom/eyugame/base/SdkPlatformFactory;

    .line 15
    :cond_0
    sget-object v0, Lcom/eyugame/base/SdkPlatformFactory;->s_sdkPlatformFactory:Lcom/eyugame/base/SdkPlatformFactory;

    return-object v0
.end method


# virtual methods
.method public createSdkPlatform(Ljava/lang/String;)Lcom/eyugame/base/ISdkPlatform;
    .locals 6
    .param p1, "strType"    # Ljava/lang/String;

    .prologue
    .line 19
    const/4 v2, 0x0

    .line 21
    .local v2, "platform":Lcom/eyugame/base/ISdkPlatform;
    :try_start_0
    const-string v3, "com.eyugame.game"

    .line 22
    .local v3, "strPackageName":Ljava/lang/String;
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "."

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/Class;->newInstance()Ljava/lang/Object;

    move-result-object v4

    move-object v0, v4

    check-cast v0, Lcom/eyugame/base/ISdkPlatform;

    move-object v2, v0
    :try_end_0
    .catch Ljava/lang/IllegalAccessException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/InstantiationException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/ClassNotFoundException; {:try_start_0 .. :try_end_0} :catch_2

    .line 31
    .end local v3    # "strPackageName":Ljava/lang/String;
    :goto_0
    return-object v2

    .line 23
    :catch_0
    move-exception v1

    .line 24
    .local v1, "e":Ljava/lang/IllegalAccessException;
    invoke-virtual {v1}, Ljava/lang/IllegalAccessException;->printStackTrace()V

    goto :goto_0

    .line 25
    .end local v1    # "e":Ljava/lang/IllegalAccessException;
    :catch_1
    move-exception v1

    .line 26
    .local v1, "e":Ljava/lang/InstantiationException;
    invoke-virtual {v1}, Ljava/lang/InstantiationException;->printStackTrace()V

    goto :goto_0

    .line 27
    .end local v1    # "e":Ljava/lang/InstantiationException;
    :catch_2
    move-exception v1

    .line 28
    .local v1, "e":Ljava/lang/ClassNotFoundException;
    invoke-virtual {v1}, Ljava/lang/ClassNotFoundException;->printStackTrace()V

    goto :goto_0
.end method
