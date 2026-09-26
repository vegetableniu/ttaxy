.class public final enum Lcom/eyugame/base/NetworkStatus$EYNetType;
.super Ljava/lang/Enum;
.source "NetworkStatus.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/eyugame/base/NetworkStatus;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x4019
    name = "EYNetType"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum",
        "<",
        "Lcom/eyugame/base/NetworkStatus$EYNetType;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lcom/eyugame/base/NetworkStatus$EYNetType;

.field public static final enum EY_MOBILE:Lcom/eyugame/base/NetworkStatus$EYNetType;

.field public static final enum EY_NONE:Lcom/eyugame/base/NetworkStatus$EYNetType;

.field public static final enum EY_OTHER:Lcom/eyugame/base/NetworkStatus$EYNetType;

.field public static final enum EY_WIFI:Lcom/eyugame/base/NetworkStatus$EYNetType;


# instance fields
.field private value:I


# direct methods
.method static constructor <clinit>()V
    .locals 6

    .prologue
    const/4 v5, 0x3

    const/4 v4, 0x2

    const/4 v3, 0x1

    const/4 v2, 0x0

    .line 9
    new-instance v0, Lcom/eyugame/base/NetworkStatus$EYNetType;

    const-string v1, "EY_NONE"

    invoke-direct {v0, v1, v2, v2}, Lcom/eyugame/base/NetworkStatus$EYNetType;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lcom/eyugame/base/NetworkStatus$EYNetType;->EY_NONE:Lcom/eyugame/base/NetworkStatus$EYNetType;

    new-instance v0, Lcom/eyugame/base/NetworkStatus$EYNetType;

    const-string v1, "EY_WIFI"

    invoke-direct {v0, v1, v3, v3}, Lcom/eyugame/base/NetworkStatus$EYNetType;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lcom/eyugame/base/NetworkStatus$EYNetType;->EY_WIFI:Lcom/eyugame/base/NetworkStatus$EYNetType;

    new-instance v0, Lcom/eyugame/base/NetworkStatus$EYNetType;

    const-string v1, "EY_MOBILE"

    invoke-direct {v0, v1, v4, v4}, Lcom/eyugame/base/NetworkStatus$EYNetType;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lcom/eyugame/base/NetworkStatus$EYNetType;->EY_MOBILE:Lcom/eyugame/base/NetworkStatus$EYNetType;

    new-instance v0, Lcom/eyugame/base/NetworkStatus$EYNetType;

    const-string v1, "EY_OTHER"

    invoke-direct {v0, v1, v5, v5}, Lcom/eyugame/base/NetworkStatus$EYNetType;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lcom/eyugame/base/NetworkStatus$EYNetType;->EY_OTHER:Lcom/eyugame/base/NetworkStatus$EYNetType;

    .line 8
    const/4 v0, 0x4

    new-array v0, v0, [Lcom/eyugame/base/NetworkStatus$EYNetType;

    sget-object v1, Lcom/eyugame/base/NetworkStatus$EYNetType;->EY_NONE:Lcom/eyugame/base/NetworkStatus$EYNetType;

    aput-object v1, v0, v2

    sget-object v1, Lcom/eyugame/base/NetworkStatus$EYNetType;->EY_WIFI:Lcom/eyugame/base/NetworkStatus$EYNetType;

    aput-object v1, v0, v3

    sget-object v1, Lcom/eyugame/base/NetworkStatus$EYNetType;->EY_MOBILE:Lcom/eyugame/base/NetworkStatus$EYNetType;

    aput-object v1, v0, v4

    sget-object v1, Lcom/eyugame/base/NetworkStatus$EYNetType;->EY_OTHER:Lcom/eyugame/base/NetworkStatus$EYNetType;

    aput-object v1, v0, v5

    sput-object v0, Lcom/eyugame/base/NetworkStatus$EYNetType;->$VALUES:[Lcom/eyugame/base/NetworkStatus$EYNetType;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;II)V
    .locals 1
    .param p3, "_value"    # I
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(I)V"
        }
    .end annotation

    .prologue
    .line 13
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    .line 11
    const/4 v0, 0x0

    iput v0, p0, Lcom/eyugame/base/NetworkStatus$EYNetType;->value:I

    .line 14
    iput p3, p0, Lcom/eyugame/base/NetworkStatus$EYNetType;->value:I

    .line 15
    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/eyugame/base/NetworkStatus$EYNetType;
    .locals 1
    .param p0, "name"    # Ljava/lang/String;

    .prologue
    .line 8
    const-class v0, Lcom/eyugame/base/NetworkStatus$EYNetType;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object v0

    check-cast v0, Lcom/eyugame/base/NetworkStatus$EYNetType;

    return-object v0
.end method

.method public static values()[Lcom/eyugame/base/NetworkStatus$EYNetType;
    .locals 1

    .prologue
    .line 8
    sget-object v0, Lcom/eyugame/base/NetworkStatus$EYNetType;->$VALUES:[Lcom/eyugame/base/NetworkStatus$EYNetType;

    invoke-virtual {v0}, [Lcom/eyugame/base/NetworkStatus$EYNetType;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/eyugame/base/NetworkStatus$EYNetType;

    return-object v0
.end method


# virtual methods
.method public value()I
    .locals 1

    .prologue
    .line 18
    iget v0, p0, Lcom/eyugame/base/NetworkStatus$EYNetType;->value:I

    return v0
.end method
