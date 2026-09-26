.class final Lcom/eyugame/game/CryptoPlatformV1$TicketContext;
.super Ljava/lang/Object;
.source "CryptoPlatformV1.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/eyugame/game/CryptoPlatformV1;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "TicketContext"
.end annotation


# instance fields
.field final accountId:Ljava/lang/String;

.field final expiresElapsed:J

.field final secret:[B

.field final ticket:Ljava/lang/String;

.field final ticketHash:[B

.field final zoneId:I


# direct methods
.method constructor <init>(Ljava/lang/String;[BLjava/lang/String;IJ)V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 83
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 84
    iput-object p1, p0, Lcom/eyugame/game/CryptoPlatformV1$TicketContext;->ticket:Ljava/lang/String;

    .line 85
    const-string v0, "SHA-256"

    invoke-static {v0}, Ljava/security/MessageDigest;->getInstance(Ljava/lang/String;)Ljava/security/MessageDigest;

    move-result-object v0

    invoke-static {p1}, Lcom/eyugame/game/CryptoPlatformV1;->access$000(Ljava/lang/String;)[B

    move-result-object p1

    invoke-virtual {v0, p1}, Ljava/security/MessageDigest;->digest([B)[B

    move-result-object p1

    iput-object p1, p0, Lcom/eyugame/game/CryptoPlatformV1$TicketContext;->ticketHash:[B

    .line 86
    iput-object p2, p0, Lcom/eyugame/game/CryptoPlatformV1$TicketContext;->secret:[B

    .line 87
    iput-object p3, p0, Lcom/eyugame/game/CryptoPlatformV1$TicketContext;->accountId:Ljava/lang/String;

    .line 88
    iput p4, p0, Lcom/eyugame/game/CryptoPlatformV1$TicketContext;->zoneId:I

    .line 89
    iput-wide p5, p0, Lcom/eyugame/game/CryptoPlatformV1$TicketContext;->expiresElapsed:J

    return-void
.end method


# virtual methods
.method wipe()V
    .locals 2

    .line 93
    iget-object v0, p0, Lcom/eyugame/game/CryptoPlatformV1$TicketContext;->secret:[B

    const/4 v1, 0x0

    invoke-static {v0, v1}, Ljava/util/Arrays;->fill([BB)V

    .line 94
    iget-object v0, p0, Lcom/eyugame/game/CryptoPlatformV1$TicketContext;->ticketHash:[B

    invoke-static {v0, v1}, Ljava/util/Arrays;->fill([BB)V

    return-void
.end method
