.class public Lcom/eyugame/base/ISdkPlatform$SdkFuncTypes;
.super Ljava/lang/Object;
.source "ISdkPlatform.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/eyugame/base/ISdkPlatform;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "SdkFuncTypes"
.end annotation


# static fields
.field public static COMBINE_LOGIN_COMPLETE_PARAM:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 23
    const-string v0, "combineLoginCompParam"

    sput-object v0, Lcom/eyugame/base/ISdkPlatform$SdkFuncTypes;->COMBINE_LOGIN_COMPLETE_PARAM:Ljava/lang/String;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 22
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method
