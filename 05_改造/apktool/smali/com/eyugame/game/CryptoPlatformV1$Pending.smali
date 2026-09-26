.class final Lcom/eyugame/game/CryptoPlatformV1$Pending;
.super Ljava/lang/Object;
.source "CryptoPlatformV1.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/eyugame/game/CryptoPlatformV1;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "Pending"
.end annotation


# instance fields
.field final clientVersion:Ljava/lang/String;

.field final createdElapsed:J

.field final operation:Ljava/lang/String;

.field final requestId:Ljava/lang/String;

.field final requestNonce:Ljava/lang/String;

.field final responseEncryption:[B

.field final responseMac:[B

.field final token:Ljava/lang/String;

.field final zoneId:I


# direct methods
.method constructor <init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;I[B[BJ)V
    .locals 0

    .line 56
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 57
    iput-object p1, p0, Lcom/eyugame/game/CryptoPlatformV1$Pending;->token:Ljava/lang/String;

    .line 58
    iput-object p2, p0, Lcom/eyugame/game/CryptoPlatformV1$Pending;->requestId:Ljava/lang/String;

    .line 59
    iput-object p3, p0, Lcom/eyugame/game/CryptoPlatformV1$Pending;->requestNonce:Ljava/lang/String;

    .line 60
    iput-object p4, p0, Lcom/eyugame/game/CryptoPlatformV1$Pending;->operation:Ljava/lang/String;

    .line 61
    iput-object p5, p0, Lcom/eyugame/game/CryptoPlatformV1$Pending;->clientVersion:Ljava/lang/String;

    .line 62
    iput p6, p0, Lcom/eyugame/game/CryptoPlatformV1$Pending;->zoneId:I

    .line 63
    iput-object p7, p0, Lcom/eyugame/game/CryptoPlatformV1$Pending;->responseEncryption:[B

    .line 64
    iput-object p8, p0, Lcom/eyugame/game/CryptoPlatformV1$Pending;->responseMac:[B

    .line 65
    iput-wide p9, p0, Lcom/eyugame/game/CryptoPlatformV1$Pending;->createdElapsed:J

    return-void
.end method


# virtual methods
.method wipe()V
    .locals 2

    .line 69
    iget-object v0, p0, Lcom/eyugame/game/CryptoPlatformV1$Pending;->responseEncryption:[B

    const/4 v1, 0x0

    invoke-static {v0, v1}, Ljava/util/Arrays;->fill([BB)V

    .line 70
    iget-object v0, p0, Lcom/eyugame/game/CryptoPlatformV1$Pending;->responseMac:[B

    invoke-static {v0, v1}, Ljava/util/Arrays;->fill([BB)V

    return-void
.end method
