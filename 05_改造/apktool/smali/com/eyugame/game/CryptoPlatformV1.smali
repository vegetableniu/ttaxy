.class public final Lcom/eyugame/game/CryptoPlatformV1;
.super Lcom/eyugame/game/LocalSdkPlatform;
.source "CryptoPlatformV1.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/eyugame/game/CryptoPlatformV1$Pending;,
        Lcom/eyugame/game/CryptoPlatformV1$TicketContext;
    }
.end annotation


# static fields
.field private static final KEY_ID:Ljava/lang/String; = "rsa-v1"

.field private static final LOCK:Ljava/lang/Object;

.field private static final MAX_PENDING:I = 0x4

.field private static final PENDING:Ljava/util/LinkedHashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/LinkedHashMap<",
            "Ljava/lang/String;",
            "Lcom/eyugame/game/CryptoPlatformV1$Pending;",
            ">;"
        }
    .end annotation
.end field

.field private static final PENDING_MILLISECONDS:J = 0xea60L

.field private static final PROOF_DOMAIN:[B

.field private static final PUBLIC_KEY_DER_BASE64:Ljava/lang/String; = "MIIBojANBgkqhkiG9w0BAQEFAAOCAY8AMIIBigKCAYEAnYPGoYcg9nImxJz0KI3cJFcDWn4OYHjHsW0tgAI5OfsbaYWHjYVCBAa8A8pA19CIeW6KWUECEARiNxT6X5wsq1CbZMawY1cHp2V+12YpA4sWVIFxqwT7lnGtYfJuqr/9w9yOjppz88u9/UnqoOJFMuqwKr2wLvlLEJUCStW+IMTtnjLMWf5GtkGH071dgfahF/oxCzh2Ajnz1M2YXQwUsoA0+/yELXwfdOdumgBjs/Owr0NgaGr+T8WLr7kTlJzm5cQQpzmTD5wM5F72TgybV5NZXFjMTr/IOc1+rJPmTZipJg4YWa05Ie38W6yfNS+zDhCbnLCLUpC2W9n8POZN9Cxsfi37vEdwJlfYgUbBKz7bo139HViklJOqjXVJTxtkR02rFTj5asfQQoMC9ijVmnNUSHOENynvWS9oYZo6dFMOHRxcmg+QrfJ2Wd49iBZ8x8kAnioduzHiChRqd70mKu2wumOtkD8oJJRX9HAYFN1lrmNY2WZ0z52/ptBsyjvXAgMBAAE="

.field private static final RANDOM:Ljava/security/SecureRandom;

.field private static final REQUEST_DOMAIN:[B

.field private static final RESPONSE_DOMAIN:[B

.field private static final TICKETS:Ljava/util/LinkedHashMap;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/LinkedHashMap<",
            "Ljava/lang/String;",
            "Lcom/eyugame/game/CryptoPlatformV1$TicketContext;",
            ">;"
        }
    .end annotation
.end field

.field private static final VERSION:I = 0x2


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 35
    const-string v0, "AXY2 C2S\u0000"

    invoke-static {v0}, Lcom/eyugame/game/CryptoPlatformV1;->ascii(Ljava/lang/String;)[B

    move-result-object v0

    sput-object v0, Lcom/eyugame/game/CryptoPlatformV1;->REQUEST_DOMAIN:[B

    .line 36
    const-string v0, "AXY2 S2C\u0000"

    invoke-static {v0}, Lcom/eyugame/game/CryptoPlatformV1;->ascii(Ljava/lang/String;)[B

    move-result-object v0

    sput-object v0, Lcom/eyugame/game/CryptoPlatformV1;->RESPONSE_DOMAIN:[B

    .line 37
    const-string v0, "AXY TCP POP V2\u0000"

    invoke-static {v0}, Lcom/eyugame/game/CryptoPlatformV1;->ascii(Ljava/lang/String;)[B

    move-result-object v0

    sput-object v0, Lcom/eyugame/game/CryptoPlatformV1;->PROOF_DOMAIN:[B

    .line 38
    new-instance v0, Ljava/security/SecureRandom;

    invoke-direct {v0}, Ljava/security/SecureRandom;-><init>()V

    sput-object v0, Lcom/eyugame/game/CryptoPlatformV1;->RANDOM:Ljava/security/SecureRandom;

    .line 39
    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    sput-object v0, Lcom/eyugame/game/CryptoPlatformV1;->LOCK:Ljava/lang/Object;

    .line 40
    new-instance v0, Ljava/util/LinkedHashMap;

    invoke-direct {v0}, Ljava/util/LinkedHashMap;-><init>()V

    sput-object v0, Lcom/eyugame/game/CryptoPlatformV1;->PENDING:Ljava/util/LinkedHashMap;

    .line 41
    new-instance v0, Ljava/util/LinkedHashMap;

    invoke-direct {v0}, Ljava/util/LinkedHashMap;-><init>()V

    sput-object v0, Lcom/eyugame/game/CryptoPlatformV1;->TICKETS:Ljava/util/LinkedHashMap;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 29
    invoke-direct {p0}, Lcom/eyugame/game/LocalSdkPlatform;-><init>()V

    return-void
.end method

.method static synthetic access$000(Ljava/lang/String;)[B
    .locals 0

    .line 29
    invoke-static {p0}, Lcom/eyugame/game/CryptoPlatformV1;->ascii(Ljava/lang/String;)[B

    move-result-object p0

    return-object p0
.end method

.method private static aes(Z[B[B[B)[B
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 541
    const-string v0, "AES/CBC/PKCS5Padding"

    invoke-static {v0}, Ljavax/crypto/Cipher;->getInstance(Ljava/lang/String;)Ljavax/crypto/Cipher;

    move-result-object v0

    if-eqz p0, :cond_0

    const/4 p0, 0x1

    goto :goto_0

    :cond_0
    const/4 p0, 0x2

    .line 542
    :goto_0
    new-instance v1, Ljavax/crypto/spec/SecretKeySpec;

    const-string v2, "AES"

    invoke-direct {v1, p1, v2}, Ljavax/crypto/spec/SecretKeySpec;-><init>([BLjava/lang/String;)V

    new-instance p1, Ljavax/crypto/spec/IvParameterSpec;

    invoke-direct {p1, p2}, Ljavax/crypto/spec/IvParameterSpec;-><init>([B)V

    invoke-virtual {v0, p0, v1, p1}, Ljavax/crypto/Cipher;->init(ILjava/security/Key;Ljava/security/spec/AlgorithmParameterSpec;)V

    .line 544
    invoke-virtual {v0, p3}, Ljavax/crypto/Cipher;->doFinal([B)[B

    move-result-object p0

    return-object p0
.end method

.method private static ascii(Ljava/lang/String;)[B
    .locals 2

    .line 602
    :try_start_0
    const-string v0, "US-ASCII"

    invoke-virtual {p0, v0}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object p0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-object p0

    :catch_0
    move-exception p0

    .line 604
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "invalid ASCII"

    invoke-direct {v0, v1, p0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw v0
.end method

.method private static callback(Ljava/lang/String;Lorg/json/JSONObject;)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 483
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    .line 484
    const-string v1, "checkSidFunc"

    invoke-virtual {v0, v1, p0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 485
    const-string p0, "checkSidFuncParam"

    invoke-virtual {v0, p0, p1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    const/4 p0, 0x0

    .line 486
    invoke-virtual {v0}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p0, p1}, Lcom/eyugame/impt/RelayNative;->OnLogin(ILjava/lang/String;)V

    return-void
.end method

.method private static callbackAccount(Ljava/lang/String;ILjava/lang/String;)V
    .locals 3

    .line 460
    :try_start_0
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    .line 461
    const-string v1, "token"
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    const-string v2, ""

    if-nez p0, :cond_0

    move-object p0, v2

    :cond_0
    :try_start_1
    invoke-virtual {v0, v1, p0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 462
    const-string p0, "transportCode"

    invoke-virtual {v0, p0, p1}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    .line 463
    const-string p0, "data"

    if-nez p2, :cond_1

    move-object p2, v2

    :cond_1
    invoke-virtual {v0, p0, p2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 464
    const-string p0, "OnAccountCrypto"

    invoke-static {p0, v0}, Lcom/eyugame/game/CryptoPlatformV1;->callback(Ljava/lang/String;Lorg/json/JSONObject;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :catchall_0
    return-void
.end method

.method private static callbackProof(Ljava/lang/String;ILjava/lang/String;)V
    .locals 2

    .line 471
    :try_start_0
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    .line 472
    const-string v1, "token"

    if-nez p0, :cond_0

    const-string p0, ""

    :cond_0
    invoke-virtual {v0, v1, p0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 473
    const-string p0, "transportCode"

    invoke-virtual {v0, p0, p1}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    if-nez p1, :cond_1

    .line 475
    const-string p0, "credential"

    invoke-virtual {v0, p0, p2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 477
    :cond_1
    const-string p0, "OnTcpLoginProof"

    invoke-static {p0, v0}, Lcom/eyugame/game/CryptoPlatformV1;->callback(Ljava/lang/String;Lorg/json/JSONObject;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :catchall_0
    return-void
.end method

.method private static canonicalPositiveDecimal(Ljava/lang/String;)Z
    .locals 6

    .line 525
    const-string v0, "[1-9][0-9]{0,18}"

    invoke-virtual {p0, v0}, Ljava/lang/String;->matches(Ljava/lang/String;)Z

    move-result v0

    const/4 v1, 0x0

    if-nez v0, :cond_0

    return v1

    .line 529
    :cond_0
    :try_start_0
    invoke-static {p0}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v2
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_0

    const-wide/16 v4, 0x0

    cmp-long p0, v2, v4

    if-lez p0, :cond_1

    const/4 v1, 0x1

    :catch_0
    :cond_1
    return v1
.end method

.method private static clearAll()V
    .locals 3

    .line 417
    sget-object v0, Lcom/eyugame/game/CryptoPlatformV1;->LOCK:Ljava/lang/Object;

    monitor-enter v0

    .line 418
    :try_start_0
    sget-object v1, Lcom/eyugame/game/CryptoPlatformV1;->PENDING:Ljava/util/LinkedHashMap;

    invoke-virtual {v1}, Ljava/util/LinkedHashMap;->values()Ljava/util/Collection;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_0

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/eyugame/game/CryptoPlatformV1$Pending;

    .line 419
    invoke-virtual {v2}, Lcom/eyugame/game/CryptoPlatformV1$Pending;->wipe()V

    goto :goto_0

    .line 421
    :cond_0
    sget-object v1, Lcom/eyugame/game/CryptoPlatformV1;->TICKETS:Ljava/util/LinkedHashMap;

    invoke-virtual {v1}, Ljava/util/LinkedHashMap;->values()Ljava/util/Collection;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_1
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_1

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/eyugame/game/CryptoPlatformV1$TicketContext;

    .line 422
    invoke-virtual {v2}, Lcom/eyugame/game/CryptoPlatformV1$TicketContext;->wipe()V

    goto :goto_1

    .line 424
    :cond_1
    sget-object v1, Lcom/eyugame/game/CryptoPlatformV1;->PENDING:Ljava/util/LinkedHashMap;

    invoke-virtual {v1}, Ljava/util/LinkedHashMap;->clear()V

    .line 425
    sget-object v1, Lcom/eyugame/game/CryptoPlatformV1;->TICKETS:Ljava/util/LinkedHashMap;

    invoke-virtual {v1}, Ljava/util/LinkedHashMap;->clear()V

    .line 426
    monitor-exit v0

    return-void

    :catchall_0
    move-exception v1

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_3

    :goto_2
    throw v1

    :goto_3
    goto :goto_2
.end method

.method private static copyWithout(Lorg/json/JSONObject;Ljava/lang/String;)Lorg/json/JSONObject;
    .locals 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 490
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    .line 491
    invoke-virtual {p0}, Lorg/json/JSONObject;->keys()Ljava/util/Iterator;

    move-result-object v1

    .line 492
    :cond_0
    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_1

    .line 493
    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    invoke-static {v2}, Ljava/lang/String;->valueOf(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    .line 494
    invoke-virtual {p1, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_0

    .line 495
    invoke-virtual {p0, v2}, Lorg/json/JSONObject;->get(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v3

    invoke-virtual {v0, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    goto :goto_0

    :cond_1
    return-object v0
.end method

.method private static decodeCanonical(Ljava/lang/String;)[B
    .locals 2

    if-eqz p0, :cond_1

    .line 590
    const-string v0, "[A-Za-z0-9_-]+"

    invoke-virtual {p0, v0}, Ljava/lang/String;->matches(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    const/16 v0, 0xb

    .line 593
    invoke-static {p0, v0}, Landroid/util/Base64;->decode(Ljava/lang/String;I)[B

    move-result-object v0

    .line 594
    invoke-static {v0}, Lcom/eyugame/game/CryptoPlatformV1;->encode([B)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p0

    if-eqz p0, :cond_0

    return-object v0

    .line 595
    :cond_0
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string v0, "noncanonical base64url"

    invoke-direct {p0, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 591
    :cond_1
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string v0, "invalid base64url"

    invoke-direct {p0, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0
.end method

.method private static discard(Ljava/lang/String;)V
    .locals 2

    .line 408
    sget-object v0, Lcom/eyugame/game/CryptoPlatformV1;->LOCK:Ljava/lang/Object;

    monitor-enter v0

    .line 409
    :try_start_0
    sget-object v1, Lcom/eyugame/game/CryptoPlatformV1;->PENDING:Ljava/util/LinkedHashMap;

    invoke-virtual {v1, p0}, Ljava/util/LinkedHashMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Lcom/eyugame/game/CryptoPlatformV1$Pending;

    if-eqz p0, :cond_0

    .line 411
    invoke-virtual {p0}, Lcom/eyugame/game/CryptoPlatformV1$Pending;->wipe()V

    .line 413
    :cond_0
    monitor-exit v0

    return-void

    :catchall_0
    move-exception p0

    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw p0
.end method

.method private static encode([B)Ljava/lang/String;
    .locals 1

    const/16 v0, 0xb

    .line 586
    invoke-static {p0, v0}, Landroid/util/Base64;->encodeToString([BI)Ljava/lang/String;

    move-result-object p0

    return-object p0
.end method

.method private static handleAccountCrypto(Lorg/json/JSONObject;)V
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 138
    const-string v0, "action"

    const/16 v1, 0x10

    invoke-static {p0, v0, v1}, Lcom/eyugame/game/CryptoPlatformV1;->requiredString(Lorg/json/JSONObject;Ljava/lang/String;I)Ljava/lang/String;

    move-result-object v0

    .line 139
    const-string v1, "token"

    const/16 v2, 0x40

    invoke-static {p0, v1, v2}, Lcom/eyugame/game/CryptoPlatformV1;->requiredString(Lorg/json/JSONObject;Ljava/lang/String;I)Ljava/lang/String;

    move-result-object v1

    .line 140
    const-string v2, "seal"

    invoke-virtual {v2, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_0

    .line 141
    invoke-static {p0, v1}, Lcom/eyugame/game/CryptoPlatformV1;->seal(Lorg/json/JSONObject;Ljava/lang/String;)V

    return-void

    .line 144
    :cond_0
    const-string v2, "open"

    invoke-virtual {v2, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 145
    invoke-static {p0, v1}, Lcom/eyugame/game/CryptoPlatformV1;->open(Lorg/json/JSONObject;Ljava/lang/String;)V

    return-void

    .line 148
    :cond_1
    const-string p0, "discard"

    invoke-virtual {p0, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p0

    if-eqz p0, :cond_2

    .line 149
    invoke-static {v1}, Lcom/eyugame/game/CryptoPlatformV1;->discard(Ljava/lang/String;)V

    const/4 p0, -0x1

    .line 150
    const-string v0, ""

    invoke-static {v1, p0, v0}, Lcom/eyugame/game/CryptoPlatformV1;->callbackAccount(Ljava/lang/String;ILjava/lang/String;)V

    return-void

    .line 153
    :cond_2
    new-instance p0, Ljava/lang/IllegalArgumentException;

    const-string v0, "invalid action"

    invoke-direct {p0, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0
.end method

.method private static handleTCPLoginProof(Lorg/json/JSONObject;)V
    .locals 17
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    move-object/from16 v0, p0

    const/4 v1, 0x7

    .line 368
    new-array v1, v1, [Ljava/lang/String;

    const-string v2, "type"

    const/4 v3, 0x0

    aput-object v2, v1, v3

    const-string v2, "token"

    const/4 v4, 0x1

    aput-object v2, v1, v4

    const-string v2, "describeJson"

    const/4 v5, 0x2

    aput-object v2, v1, v5

    const-string v2, "expectedDescribeMd5"

    const/4 v6, 0x3

    aput-object v2, v1, v6

    const-string v2, "ticket"

    const/4 v7, 0x4

    aput-object v2, v1, v7

    const-string v2, "reference"

    const/4 v8, 0x5

    aput-object v2, v1, v8

    const-string v2, "zoneId"

    const/4 v8, 0x6

    aput-object v2, v1, v8

    invoke-static {v0, v1}, Lcom/eyugame/game/CryptoPlatformV1;->requireFields(Lorg/json/JSONObject;[Ljava/lang/String;)V

    .line 369
    const-string v1, "token"

    const/16 v2, 0x40

    invoke-static {v0, v1, v2}, Lcom/eyugame/game/CryptoPlatformV1;->requiredString(Lorg/json/JSONObject;Ljava/lang/String;I)Ljava/lang/String;

    move-result-object v1

    .line 370
    const-string v2, "ticket"

    const/16 v8, 0x800

    invoke-static {v0, v2, v8}, Lcom/eyugame/game/CryptoPlatformV1;->requiredString(Lorg/json/JSONObject;Ljava/lang/String;I)Ljava/lang/String;

    move-result-object v2

    .line 371
    const-string v8, "reference"

    const/16 v9, 0x60

    invoke-static {v0, v8, v9}, Lcom/eyugame/game/CryptoPlatformV1;->requiredString(Lorg/json/JSONObject;Ljava/lang/String;I)Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/String;->trim()Ljava/lang/String;

    move-result-object v8

    .line 372
    const-string v9, "zoneId"

    invoke-virtual {v0, v9}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v9

    .line 374
    sget-object v10, Lcom/eyugame/game/CryptoPlatformV1;->LOCK:Ljava/lang/Object;

    monitor-enter v10

    .line 375
    :try_start_0
    invoke-static {}, Lcom/eyugame/game/CryptoPlatformV1;->pruneLocked()V

    .line 376
    sget-object v11, Lcom/eyugame/game/CryptoPlatformV1;->TICKETS:Ljava/util/LinkedHashMap;

    invoke-virtual {v11, v2}, Ljava/util/LinkedHashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v11

    check-cast v11, Lcom/eyugame/game/CryptoPlatformV1$TicketContext;

    .line 377
    monitor-exit v10
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    const/4 v10, -0x1

    if-eqz v11, :cond_4

    .line 378
    iget v12, v11, Lcom/eyugame/game/CryptoPlatformV1$TicketContext;->zoneId:I

    if-ne v12, v9, :cond_4

    iget-object v12, v11, Lcom/eyugame/game/CryptoPlatformV1$TicketContext;->accountId:Ljava/lang/String;

    invoke-static {v8, v12, v9}, Lcom/eyugame/game/CryptoPlatformV1;->referenceMatches(Ljava/lang/String;Ljava/lang/String;I)Z

    move-result v12

    if-nez v12, :cond_0

    goto/16 :goto_1

    .line 382
    :cond_0
    new-instance v12, Lorg/json/JSONObject;

    const-string v13, "describeJson"

    invoke-virtual {v0, v13}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v13

    invoke-direct {v12, v13}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 383
    new-array v6, v6, [Ljava/lang/String;

    const-string v13, "describeMd5"

    aput-object v13, v6, v3

    const-string v13, "tcpNonce"

    aput-object v13, v6, v4

    const-string v4, "expiresAt"

    aput-object v4, v6, v5

    invoke-static {v12, v6}, Lcom/eyugame/game/CryptoPlatformV1;->requireFields(Lorg/json/JSONObject;[Ljava/lang/String;)V

    .line 384
    const-string v4, "expectedDescribeMd5"

    const/16 v5, 0x20

    invoke-static {v0, v4, v5}, Lcom/eyugame/game/CryptoPlatformV1;->requiredString(Lorg/json/JSONObject;Ljava/lang/String;I)Ljava/lang/String;

    move-result-object v0

    sget-object v4, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-virtual {v0, v4}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v0

    .line 385
    const-string v4, "describeMd5"

    invoke-static {v12, v4, v5}, Lcom/eyugame/game/CryptoPlatformV1;->requiredString(Lorg/json/JSONObject;Ljava/lang/String;I)Ljava/lang/String;

    move-result-object v4

    sget-object v6, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-virtual {v4, v6}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v4

    .line 386
    const-string v6, "[0-9a-f]{32}"

    invoke-virtual {v0, v6}, Ljava/lang/String;->matches(Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_3

    invoke-virtual {v0, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_3

    const-string v0, "expiresAt"

    .line 387
    invoke-virtual {v12, v0}, Lorg/json/JSONObject;->getLong(Ljava/lang/String;)J

    move-result-wide v13

    const-wide/16 v15, 0x0

    cmp-long v0, v13, v15

    if-gtz v0, :cond_1

    goto :goto_0

    .line 391
    :cond_1
    const-string v0, "tcpNonce"

    const/16 v4, 0x80

    invoke-static {v12, v0, v4}, Lcom/eyugame/game/CryptoPlatformV1;->requiredString(Lorg/json/JSONObject;Ljava/lang/String;I)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/eyugame/game/CryptoPlatformV1;->decodeCanonical(Ljava/lang/String;)[B

    move-result-object v0

    .line 392
    array-length v4, v0

    if-eq v4, v5, :cond_2

    .line 393
    const-string v0, ""

    invoke-static {v1, v10, v0}, Lcom/eyugame/game/CryptoPlatformV1;->callbackProof(Ljava/lang/String;ILjava/lang/String;)V

    return-void

    .line 396
    :cond_2
    new-instance v4, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v4}, Ljava/io/ByteArrayOutputStream;-><init>()V

    .line 397
    sget-object v5, Lcom/eyugame/game/CryptoPlatformV1;->PROOF_DOMAIN:[B

    invoke-virtual {v4, v5}, Ljava/io/ByteArrayOutputStream;->write([B)V

    .line 398
    invoke-static {v4, v0}, Lcom/eyugame/game/CryptoPlatformV1;->writePart(Ljava/io/ByteArrayOutputStream;[B)V

    .line 399
    invoke-static {v9}, Lcom/eyugame/game/CryptoPlatformV1;->int32(I)[B

    move-result-object v0

    invoke-static {v4, v0}, Lcom/eyugame/game/CryptoPlatformV1;->writePart(Ljava/io/ByteArrayOutputStream;[B)V

    .line 400
    invoke-static {v8}, Lcom/eyugame/game/CryptoPlatformV1;->utf8(Ljava/lang/String;)[B

    move-result-object v0

    invoke-static {v4, v0}, Lcom/eyugame/game/CryptoPlatformV1;->writePart(Ljava/io/ByteArrayOutputStream;[B)V

    .line 401
    iget-object v0, v11, Lcom/eyugame/game/CryptoPlatformV1$TicketContext;->ticketHash:[B

    invoke-static {v4, v0}, Lcom/eyugame/game/CryptoPlatformV1;->writePart(Ljava/io/ByteArrayOutputStream;[B)V

    .line 402
    invoke-static {v7}, Lcom/eyugame/game/CryptoPlatformV1;->int32(I)[B

    move-result-object v0

    invoke-static {v4, v0}, Lcom/eyugame/game/CryptoPlatformV1;->writePart(Ljava/io/ByteArrayOutputStream;[B)V

    .line 403
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v5, "p2."

    invoke-direct {v0, v5}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v2, "."

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v2, v11, Lcom/eyugame/game/CryptoPlatformV1$TicketContext;->secret:[B

    invoke-virtual {v4}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object v4

    invoke-static {v2, v4}, Lcom/eyugame/game/CryptoPlatformV1;->hmac([B[B)[B

    move-result-object v2

    invoke-static {v2}, Lcom/eyugame/game/CryptoPlatformV1;->encode([B)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 404
    invoke-static {v1, v3, v0}, Lcom/eyugame/game/CryptoPlatformV1;->callbackProof(Ljava/lang/String;ILjava/lang/String;)V

    return-void

    .line 388
    :cond_3
    :goto_0
    const-string v0, ""

    invoke-static {v1, v10, v0}, Lcom/eyugame/game/CryptoPlatformV1;->callbackProof(Ljava/lang/String;ILjava/lang/String;)V

    return-void

    .line 379
    :cond_4
    :goto_1
    const-string v0, ""

    invoke-static {v1, v10, v0}, Lcom/eyugame/game/CryptoPlatformV1;->callbackProof(Ljava/lang/String;ILjava/lang/String;)V

    return-void

    :catchall_0
    move-exception v0

    .line 377
    :try_start_1
    monitor-exit v10
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v0
.end method

.method private static hmac([B[B)[B
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 548
    const-string v0, "HmacSHA256"

    invoke-static {v0}, Ljavax/crypto/Mac;->getInstance(Ljava/lang/String;)Ljavax/crypto/Mac;

    move-result-object v1

    .line 549
    new-instance v2, Ljavax/crypto/spec/SecretKeySpec;

    invoke-direct {v2, p0, v0}, Ljavax/crypto/spec/SecretKeySpec;-><init>([BLjava/lang/String;)V

    invoke-virtual {v1, v2}, Ljavax/crypto/Mac;->init(Ljava/security/Key;)V

    .line 550
    invoke-virtual {v1, p1}, Ljavax/crypto/Mac;->doFinal([B)[B

    move-result-object p0

    return-object p0
.end method

.method private static int32(I)[B
    .locals 5

    ushr-int/lit8 v0, p0, 0x18

    int-to-byte v0, v0

    ushr-int/lit8 v1, p0, 0x10

    int-to-byte v1, v1

    ushr-int/lit8 v2, p0, 0x8

    int-to-byte v2, v2

    int-to-byte p0, p0

    const/4 v3, 0x4

    .line 575
    new-array v3, v3, [B

    const/4 v4, 0x0

    aput-byte v0, v3, v4

    const/4 v0, 0x1

    aput-byte v1, v3, v0

    const/4 v0, 0x2

    aput-byte v2, v3, v0

    const/4 v0, 0x3

    aput-byte p0, v3, v0

    return-object v3
.end method

.method private static macInput([BLjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)[B
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 556
    new-instance v0, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v0}, Ljava/io/ByteArrayOutputStream;-><init>()V

    .line 557
    invoke-virtual {v0, p0}, Ljava/io/ByteArrayOutputStream;->write([B)V

    .line 558
    invoke-static {p1}, Lcom/eyugame/game/CryptoPlatformV1;->ascii(Ljava/lang/String;)[B

    move-result-object p0

    invoke-static {v0, p0}, Lcom/eyugame/game/CryptoPlatformV1;->writePart(Ljava/io/ByteArrayOutputStream;[B)V

    .line 559
    invoke-static {p2}, Lcom/eyugame/game/CryptoPlatformV1;->ascii(Ljava/lang/String;)[B

    move-result-object p0

    invoke-static {v0, p0}, Lcom/eyugame/game/CryptoPlatformV1;->writePart(Ljava/io/ByteArrayOutputStream;[B)V

    .line 560
    invoke-static {p3}, Lcom/eyugame/game/CryptoPlatformV1;->ascii(Ljava/lang/String;)[B

    move-result-object p0

    invoke-static {v0, p0}, Lcom/eyugame/game/CryptoPlatformV1;->writePart(Ljava/io/ByteArrayOutputStream;[B)V

    .line 561
    invoke-static {p4}, Lcom/eyugame/game/CryptoPlatformV1;->ascii(Ljava/lang/String;)[B

    move-result-object p0

    invoke-static {v0, p0}, Lcom/eyugame/game/CryptoPlatformV1;->writePart(Ljava/io/ByteArrayOutputStream;[B)V

    .line 562
    invoke-static {p5}, Lcom/eyugame/game/CryptoPlatformV1;->ascii(Ljava/lang/String;)[B

    move-result-object p0

    invoke-static {v0, p0}, Lcom/eyugame/game/CryptoPlatformV1;->writePart(Ljava/io/ByteArrayOutputStream;[B)V

    .line 563
    invoke-static {p6}, Lcom/eyugame/game/CryptoPlatformV1;->ascii(Ljava/lang/String;)[B

    move-result-object p0

    invoke-static {v0, p0}, Lcom/eyugame/game/CryptoPlatformV1;->writePart(Ljava/io/ByteArrayOutputStream;[B)V

    .line 564
    invoke-virtual {v0}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object p0

    return-object p0
.end method

.method private static open(Lorg/json/JSONObject;Ljava/lang/String;)V
    .locals 20
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    move-object/from16 v0, p0

    move-object/from16 v1, p1

    const/4 v2, 0x4

    .line 233
    new-array v3, v2, [Ljava/lang/String;

    const-string v4, "type"

    const/4 v5, 0x0

    aput-object v4, v3, v5

    const-string v4, "action"

    const/4 v6, 0x1

    aput-object v4, v3, v6

    const-string v4, "token"

    const/4 v7, 0x2

    aput-object v4, v3, v7

    const-string v4, "response"

    const/4 v8, 0x3

    aput-object v4, v3, v8

    invoke-static {v0, v3}, Lcom/eyugame/game/CryptoPlatformV1;->requireFields(Lorg/json/JSONObject;[Ljava/lang/String;)V

    .line 235
    sget-object v3, Lcom/eyugame/game/CryptoPlatformV1;->LOCK:Ljava/lang/Object;

    monitor-enter v3

    .line 236
    :try_start_0
    invoke-static {}, Lcom/eyugame/game/CryptoPlatformV1;->pruneLocked()V

    .line 237
    sget-object v4, Lcom/eyugame/game/CryptoPlatformV1;->PENDING:Ljava/util/LinkedHashMap;

    invoke-virtual {v4, v1}, Ljava/util/LinkedHashMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lcom/eyugame/game/CryptoPlatformV1$Pending;

    .line 238
    monitor-exit v3
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_2

    if-eqz v4, :cond_9

    .line 243
    :try_start_1
    const-string v3, "response"

    const/16 v9, 0x4000

    invoke-static {v0, v3, v9}, Lcom/eyugame/game/CryptoPlatformV1;->requiredString(Lorg/json/JSONObject;Ljava/lang/String;I)Ljava/lang/String;

    move-result-object v0

    .line 244
    new-instance v3, Lorg/json/JSONObject;

    invoke-direct {v3, v0}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    .line 245
    new-array v0, v8, [Ljava/lang/String;

    const-string v10, "code"

    aput-object v10, v0, v5

    const-string v10, "secureVersion"

    aput-object v10, v0, v6

    const-string v10, "envelope"

    aput-object v10, v0, v7

    invoke-static {v3, v0}, Lcom/eyugame/game/CryptoPlatformV1;->requireFields(Lorg/json/JSONObject;[Ljava/lang/String;)V

    .line 246
    const-string v0, "code"

    invoke-virtual {v3, v0}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v0

    if-nez v0, :cond_8

    const-string v0, "secureVersion"

    invoke-virtual {v3, v0}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v0

    if-ne v0, v7, :cond_8

    .line 249
    const-string v0, "envelope"

    invoke-static {v3, v0, v9}, Lcom/eyugame/game/CryptoPlatformV1;->requiredString(Lorg/json/JSONObject;Ljava/lang/String;I)Ljava/lang/String;

    move-result-object v0

    .line 250
    new-instance v3, Lorg/json/JSONObject;

    new-instance v10, Ljava/lang/String;

    invoke-static {v0}, Lcom/eyugame/game/CryptoPlatformV1;->decodeCanonical(Ljava/lang/String;)[B

    move-result-object v0

    const-string v11, "UTF-8"

    invoke-direct {v10, v0, v11}, Ljava/lang/String;-><init>([BLjava/lang/String;)V

    invoke-direct {v3, v10}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    const/4 v0, 0x6

    .line 251
    new-array v10, v0, [Ljava/lang/String;

    const-string v11, "v"

    aput-object v11, v10, v5

    const-string v11, "kid"

    aput-object v11, v10, v6

    const-string v11, "rid"

    aput-object v11, v10, v7

    const-string v11, "iv"

    aput-object v11, v10, v8

    const-string v11, "ct"

    aput-object v11, v10, v2

    const-string v11, "mac"

    const/4 v12, 0x5

    aput-object v11, v10, v12

    invoke-static {v3, v10}, Lcom/eyugame/game/CryptoPlatformV1;->requireFields(Lorg/json/JSONObject;[Ljava/lang/String;)V

    .line 252
    const-string v10, "v"

    invoke-virtual {v3, v10}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v10

    if-ne v10, v7, :cond_7

    const-string v10, "rsa-v1"

    const-string v11, "kid"

    invoke-virtual {v3, v11}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v10, v11}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v10

    if-eqz v10, :cond_7

    iget-object v10, v4, Lcom/eyugame/game/CryptoPlatformV1$Pending;->requestId:Ljava/lang/String;

    const-string v11, "rid"

    .line 253
    invoke-virtual {v3, v11}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v10, v11}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v10

    if-eqz v10, :cond_7

    .line 256
    const-string v10, "iv"

    const/16 v11, 0x40

    invoke-static {v3, v10, v11}, Lcom/eyugame/game/CryptoPlatformV1;->requiredString(Lorg/json/JSONObject;Ljava/lang/String;I)Ljava/lang/String;

    move-result-object v18

    .line 257
    const-string v10, "ct"

    invoke-static {v3, v10, v9}, Lcom/eyugame/game/CryptoPlatformV1;->requiredString(Lorg/json/JSONObject;Ljava/lang/String;I)Ljava/lang/String;

    move-result-object v19

    .line 258
    const-string v9, "mac"

    invoke-static {v3, v9, v11}, Lcom/eyugame/game/CryptoPlatformV1;->requiredString(Lorg/json/JSONObject;Ljava/lang/String;I)Ljava/lang/String;

    move-result-object v3

    .line 259
    invoke-static/range {v18 .. v18}, Lcom/eyugame/game/CryptoPlatformV1;->decodeCanonical(Ljava/lang/String;)[B

    move-result-object v9

    .line 260
    invoke-static/range {v19 .. v19}, Lcom/eyugame/game/CryptoPlatformV1;->decodeCanonical(Ljava/lang/String;)[B

    move-result-object v10

    .line 261
    invoke-static {v3}, Lcom/eyugame/game/CryptoPlatformV1;->decodeCanonical(Ljava/lang/String;)[B

    move-result-object v3

    .line 262
    array-length v11, v9

    const/16 v13, 0x10

    if-ne v11, v13, :cond_6

    array-length v11, v3

    const/16 v14, 0x20

    if-ne v11, v14, :cond_6

    array-length v11, v10

    if-eqz v11, :cond_6

    array-length v11, v10

    rem-int/2addr v11, v13

    if-nez v11, :cond_6

    .line 266
    iget-object v11, v4, Lcom/eyugame/game/CryptoPlatformV1$Pending;->responseMac:[B

    sget-object v13, Lcom/eyugame/game/CryptoPlatformV1;->RESPONSE_DOMAIN:[B

    const-string v14, "2"

    const-string v15, "rsa-v1"

    iget-object v0, v4, Lcom/eyugame/game/CryptoPlatformV1$Pending;->requestId:Ljava/lang/String;

    const-string v17, ""

    move-object/from16 v16, v0

    invoke-static/range {v13 .. v19}, Lcom/eyugame/game/CryptoPlatformV1;->macInput([BLjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)[B

    move-result-object v0

    invoke-static {v11, v0}, Lcom/eyugame/game/CryptoPlatformV1;->hmac([B[B)[B

    move-result-object v11
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    const/4 v13, 0x0

    .line 270
    :try_start_2
    invoke-static {v11, v3}, Ljava/security/MessageDigest;->isEqual([B[B)Z

    move-result v0

    if-eqz v0, :cond_4

    .line 273
    iget-object v0, v4, Lcom/eyugame/game/CryptoPlatformV1$Pending;->responseEncryption:[B

    invoke-static {v5, v0, v9, v10}, Lcom/eyugame/game/CryptoPlatformV1;->aes(Z[B[B[B)[B

    move-result-object v13

    .line 274
    array-length v0, v13

    const/16 v14, 0x2000

    if-gt v0, v14, :cond_3

    .line 277
    new-instance v0, Lorg/json/JSONObject;

    new-instance v14, Ljava/lang/String;

    const-string v15, "UTF-8"

    invoke-direct {v14, v13, v15}, Ljava/lang/String;-><init>([BLjava/lang/String;)V

    invoke-direct {v0, v14}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    const/4 v14, 0x7

    .line 278
    new-array v14, v14, [Ljava/lang/String;

    const-string v15, "v"

    aput-object v15, v14, v5

    const-string v15, "rid"

    aput-object v15, v14, v6

    const-string v6, "requestNonce"

    aput-object v6, v14, v7

    const-string v6, "op"

    aput-object v6, v14, v8

    const-string v6, "clientVersion"

    aput-object v6, v14, v2

    const-string v2, "zoneId"

    aput-object v2, v14, v12

    const-string v2, "payload"

    const/4 v6, 0x6

    aput-object v2, v14, v6

    invoke-static {v0, v14}, Lcom/eyugame/game/CryptoPlatformV1;->requireFields(Lorg/json/JSONObject;[Ljava/lang/String;)V

    .line 279
    const-string v2, "v"

    invoke-virtual {v0, v2}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v2

    if-ne v2, v7, :cond_2

    iget-object v2, v4, Lcom/eyugame/game/CryptoPlatformV1$Pending;->requestId:Ljava/lang/String;

    const-string v6, "rid"

    invoke-virtual {v0, v6}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v2, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_2

    iget-object v2, v4, Lcom/eyugame/game/CryptoPlatformV1$Pending;->requestNonce:Ljava/lang/String;

    const-string v6, "requestNonce"

    .line 280
    invoke-virtual {v0, v6}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v2, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_2

    iget-object v2, v4, Lcom/eyugame/game/CryptoPlatformV1$Pending;->operation:Ljava/lang/String;

    const-string v6, "op"

    .line 281
    invoke-virtual {v0, v6}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v2, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_2

    iget-object v2, v4, Lcom/eyugame/game/CryptoPlatformV1$Pending;->clientVersion:Ljava/lang/String;

    const-string v6, "clientVersion"

    .line 282
    invoke-virtual {v0, v6}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    invoke-virtual {v2, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_2

    iget v2, v4, Lcom/eyugame/game/CryptoPlatformV1$Pending;->zoneId:I

    const-string v6, "zoneId"

    .line 283
    invoke-virtual {v0, v6}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v6

    if-ne v2, v6, :cond_2

    .line 286
    const-string v2, "payload"

    invoke-virtual {v0, v2}, Lorg/json/JSONObject;->getJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v0

    .line 287
    const-string v2, "sessionSecret"

    invoke-static {v0, v2}, Lcom/eyugame/game/CryptoPlatformV1;->copyWithout(Lorg/json/JSONObject;Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v2

    .line 288
    const-string v6, "sessionSecret"

    invoke-virtual {v0, v6}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_0

    .line 289
    iget v6, v4, Lcom/eyugame/game/CryptoPlatformV1$Pending;->zoneId:I

    invoke-static {v0, v6}, Lcom/eyugame/game/CryptoPlatformV1;->rememberTicket(Lorg/json/JSONObject;I)V

    .line 291
    :cond_0
    invoke-virtual {v2}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v1, v5, v0}, Lcom/eyugame/game/CryptoPlatformV1;->callbackAccount(Ljava/lang/String;ILjava/lang/String;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    .line 293
    :try_start_3
    invoke-static {v9, v5}, Ljava/util/Arrays;->fill([BB)V

    .line 294
    invoke-static {v10, v5}, Ljava/util/Arrays;->fill([BB)V

    .line 295
    invoke-static {v3, v5}, Ljava/util/Arrays;->fill([BB)V

    .line 296
    invoke-static {v11, v5}, Ljava/util/Arrays;->fill([BB)V

    if-eqz v13, :cond_1

    .line 298
    invoke-static {v13, v5}, Ljava/util/Arrays;->fill([BB)V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .line 302
    :cond_1
    invoke-virtual {v4}, Lcom/eyugame/game/CryptoPlatformV1$Pending;->wipe()V

    return-void

    .line 284
    :cond_2
    :try_start_4
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "response binding mismatch"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 275
    :cond_3
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "response is too large"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 271
    :cond_4
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "response authentication failed"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_0

    :catchall_0
    move-exception v0

    .line 293
    :try_start_5
    invoke-static {v9, v5}, Ljava/util/Arrays;->fill([BB)V

    .line 294
    invoke-static {v10, v5}, Ljava/util/Arrays;->fill([BB)V

    .line 295
    invoke-static {v3, v5}, Ljava/util/Arrays;->fill([BB)V

    .line 296
    invoke-static {v11, v5}, Ljava/util/Arrays;->fill([BB)V

    if-eqz v13, :cond_5

    .line 298
    invoke-static {v13, v5}, Ljava/util/Arrays;->fill([BB)V

    .line 300
    :cond_5
    throw v0

    .line 264
    :cond_6
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "invalid encrypted response size"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 254
    :cond_7
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "response binding mismatch"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 247
    :cond_8
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "invalid response"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_1

    :catchall_1
    move-exception v0

    .line 302
    invoke-virtual {v4}, Lcom/eyugame/game/CryptoPlatformV1$Pending;->wipe()V

    .line 303
    throw v0

    .line 240
    :cond_9
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "unknown request"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    :catchall_2
    move-exception v0

    .line 238
    :try_start_6
    monitor-exit v3
    :try_end_6
    .catchall {:try_start_6 .. :try_end_6} :catchall_2

    throw v0
.end method

.method private static pruneLocked()V
    .locals 9

    .line 430
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v0

    .line 431
    sget-object v2, Lcom/eyugame/game/CryptoPlatformV1;->PENDING:Ljava/util/LinkedHashMap;

    invoke-virtual {v2}, Ljava/util/LinkedHashMap;->entrySet()Ljava/util/Set;

    move-result-object v2

    invoke-interface {v2}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v2

    .line 432
    :cond_0
    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_1

    .line 433
    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/util/Map$Entry;

    invoke-interface {v3}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/eyugame/game/CryptoPlatformV1$Pending;

    .line 434
    iget-wide v4, v3, Lcom/eyugame/game/CryptoPlatformV1$Pending;->createdElapsed:J

    sub-long v4, v0, v4

    const-wide/32 v6, 0xea60

    cmp-long v8, v4, v6

    if-ltz v8, :cond_0

    .line 435
    invoke-interface {v2}, Ljava/util/Iterator;->remove()V

    .line 436
    invoke-virtual {v3}, Lcom/eyugame/game/CryptoPlatformV1$Pending;->wipe()V

    goto :goto_0

    .line 439
    :cond_1
    sget-object v2, Lcom/eyugame/game/CryptoPlatformV1;->TICKETS:Ljava/util/LinkedHashMap;

    invoke-virtual {v2}, Ljava/util/LinkedHashMap;->entrySet()Ljava/util/Set;

    move-result-object v2

    invoke-interface {v2}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v2

    .line 440
    :cond_2
    :goto_1
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_3

    .line 441
    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/util/Map$Entry;

    invoke-interface {v3}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/eyugame/game/CryptoPlatformV1$TicketContext;

    .line 442
    iget-wide v4, v3, Lcom/eyugame/game/CryptoPlatformV1$TicketContext;->expiresElapsed:J

    cmp-long v6, v0, v4

    if-ltz v6, :cond_2

    .line 443
    invoke-interface {v2}, Ljava/util/Iterator;->remove()V

    .line 444
    invoke-virtual {v3}, Lcom/eyugame/game/CryptoPlatformV1$TicketContext;->wipe()V

    goto :goto_1

    :cond_3
    return-void
.end method

.method private static randomBytes(I)[B
    .locals 1

    .line 580
    new-array p0, p0, [B

    .line 581
    sget-object v0, Lcom/eyugame/game/CryptoPlatformV1;->RANDOM:Ljava/security/SecureRandom;

    invoke-virtual {v0, p0}, Ljava/security/SecureRandom;->nextBytes([B)V

    return-object p0
.end method

.method private static referenceMatches(Ljava/lang/String;Ljava/lang/String;I)Z
    .locals 2

    .line 536
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "[1-9][0-9]*\\.[0-9]+_"

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    invoke-virtual {p0, p2}, Ljava/lang/String;->matches(Ljava/lang/String;)Z

    move-result p2

    const/4 v0, 0x0

    if-eqz p2, :cond_0

    const/16 p2, 0x2e

    .line 537
    invoke-virtual {p0, p2}, Ljava/lang/String;->indexOf(I)I

    move-result p2

    invoke-virtual {p0, v0, p2}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object p0

    invoke-virtual {p0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p0

    if-eqz p0, :cond_0

    const/4 v0, 0x1

    :cond_0
    return v0
.end method

.method private static rememberTicket(Lorg/json/JSONObject;I)V
    .locals 16
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    move-object/from16 v0, p0

    const-string v1, "z"

    .line 307
    const-string v2, "code"

    invoke-virtual {v0, v2}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v2

    if-nez v2, :cond_9

    const-string v2, "ticketVersion"

    invoke-virtual {v0, v2}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v2

    const/4 v3, 0x2

    if-ne v2, v3, :cond_9

    .line 310
    const-string v2, "sign"

    const/16 v4, 0x800

    invoke-static {v0, v2, v4}, Lcom/eyugame/game/CryptoPlatformV1;->requiredString(Lorg/json/JSONObject;Ljava/lang/String;I)Ljava/lang/String;

    move-result-object v2

    .line 311
    invoke-static {v2}, Lcom/eyugame/game/CryptoPlatformV1;->decodeCanonical(Ljava/lang/String;)[B

    move-result-object v4

    .line 312
    array-length v5, v4

    const/16 v6, 0x1f

    if-lt v5, v6, :cond_8

    const/4 v12, 0x0

    aget-byte v5, v4, v12

    if-ne v5, v3, :cond_8

    const/4 v5, 0x1

    .line 315
    aget-byte v5, v4, v5

    and-int/lit16 v5, v5, 0xff

    if-eqz v5, :cond_7

    .line 316
    array-length v6, v4

    add-int/lit8 v7, v5, 0x1e

    if-lt v6, v7, :cond_7

    .line 319
    const-string v6, "sessionSecret"

    const/16 v7, 0x80

    invoke-static {v0, v6, v7}, Lcom/eyugame/game/CryptoPlatformV1;->requiredString(Lorg/json/JSONObject;Ljava/lang/String;I)Ljava/lang/String;

    move-result-object v6

    invoke-static {v6}, Lcom/eyugame/game/CryptoPlatformV1;->decodeCanonical(Ljava/lang/String;)[B

    move-result-object v13

    .line 322
    :try_start_0
    array-length v6, v13

    const/16 v7, 0x20

    if-ne v6, v7, :cond_6

    .line 325
    const-string v6, "userId"

    invoke-static {v0, v6, v7}, Lcom/eyugame/game/CryptoPlatformV1;->requiredString(Lorg/json/JSONObject;Ljava/lang/String;I)Ljava/lang/String;

    move-result-object v14

    .line 326
    invoke-static {v14}, Lcom/eyugame/game/CryptoPlatformV1;->canonicalPositiveDecimal(Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_5

    .line 329
    const-string v6, "serverId"

    invoke-virtual {v0, v6}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v15

    .line 330
    const-string v6, "time"

    invoke-virtual {v0, v6}, Lorg/json/JSONObject;->getLong(Ljava/lang/String;)J

    move-result-wide v6

    .line 331
    const-string v8, "expiresAt"

    invoke-virtual {v0, v8}, Lorg/json/JSONObject;->getLong(Ljava/lang/String;)J

    move-result-wide v8

    move/from16 v0, p1

    if-ne v15, v0, :cond_4

    cmp-long v0, v8, v6

    if-lez v0, :cond_4

    sub-long/2addr v8, v6

    const-wide/16 v6, 0x12c

    cmp-long v0, v8, v6

    if-gtz v0, :cond_4

    .line 335
    new-instance v0, Ljava/lang/String;

    const-string v6, "US-ASCII"

    invoke-direct {v0, v4, v3, v5, v6}, Ljava/lang/String;-><init>([BIILjava/lang/String;)V

    .line 336
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v3, v15}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    const-string v1, "-v1"

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_3

    .line 339
    new-instance v0, Lcom/eyugame/game/CryptoPlatformV1$TicketContext;

    .line 340
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v3

    const-wide/16 v5, 0x3e8

    mul-long v8, v8, v5

    add-long v10, v3, v8

    move-object v5, v0

    move-object v6, v2

    move-object v7, v13

    move-object v8, v14

    move v9, v15

    invoke-direct/range {v5 .. v11}, Lcom/eyugame/game/CryptoPlatformV1$TicketContext;-><init>(Ljava/lang/String;[BLjava/lang/String;IJ)V

    .line 341
    sget-object v1, Lcom/eyugame/game/CryptoPlatformV1;->LOCK:Ljava/lang/Object;

    monitor-enter v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_1

    .line 342
    :try_start_1
    invoke-static {}, Lcom/eyugame/game/CryptoPlatformV1;->pruneLocked()V

    .line 343
    sget-object v3, Lcom/eyugame/game/CryptoPlatformV1;->TICKETS:Ljava/util/LinkedHashMap;

    invoke-virtual {v3}, Ljava/util/LinkedHashMap;->entrySet()Ljava/util/Set;

    move-result-object v3

    invoke-interface {v3}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v3

    .line 344
    :cond_0
    :goto_0
    invoke-interface {v3}, Ljava/util/Iterator;->hasNext()Z

    move-result v4

    if-eqz v4, :cond_1

    .line 345
    invoke-interface {v3}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/util/Map$Entry;

    invoke-interface {v4}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lcom/eyugame/game/CryptoPlatformV1$TicketContext;

    .line 346
    iget v5, v4, Lcom/eyugame/game/CryptoPlatformV1$TicketContext;->zoneId:I

    if-ne v5, v15, :cond_0

    iget-object v5, v4, Lcom/eyugame/game/CryptoPlatformV1$TicketContext;->accountId:Ljava/lang/String;

    invoke-virtual {v5, v14}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_0

    .line 347
    invoke-interface {v3}, Ljava/util/Iterator;->remove()V

    .line 348
    invoke-virtual {v4}, Lcom/eyugame/game/CryptoPlatformV1$TicketContext;->wipe()V

    goto :goto_0

    .line 351
    :cond_1
    sget-object v3, Lcom/eyugame/game/CryptoPlatformV1;->TICKETS:Ljava/util/LinkedHashMap;

    invoke-virtual {v3, v2, v0}, Ljava/util/LinkedHashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 352
    :goto_1
    sget-object v0, Lcom/eyugame/game/CryptoPlatformV1;->TICKETS:Ljava/util/LinkedHashMap;

    invoke-virtual {v0}, Ljava/util/LinkedHashMap;->size()I

    move-result v2

    const/4 v3, 0x4

    if-le v2, v3, :cond_2

    .line 353
    invoke-virtual {v0}, Ljava/util/LinkedHashMap;->entrySet()Ljava/util/Set;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v0

    .line 354
    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/util/Map$Entry;

    .line 355
    invoke-interface {v0}, Ljava/util/Iterator;->remove()V

    .line 356
    invoke-interface {v2}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/eyugame/game/CryptoPlatformV1$TicketContext;

    invoke-virtual {v0}, Lcom/eyugame/game/CryptoPlatformV1$TicketContext;->wipe()V

    goto :goto_1

    .line 358
    :cond_2
    monitor-exit v1

    return-void

    :catchall_0
    move-exception v0

    monitor-exit v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    :try_start_2
    throw v0

    .line 337
    :cond_3
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "invalid ticket key id"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 333
    :cond_4
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "invalid ticket time"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 327
    :cond_5
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "invalid account id"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 323
    :cond_6
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "invalid session secret"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    :catchall_1
    move-exception v0

    .line 362
    invoke-static {v13, v12}, Ljava/util/Arrays;->fill([BB)V

    .line 364
    throw v0

    .line 317
    :cond_7
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "invalid ticket key id"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 313
    :cond_8
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "invalid ticket"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 308
    :cond_9
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "invalid ticket response"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    goto :goto_3

    :goto_2
    throw v0

    :goto_3
    goto :goto_2
.end method

.method private static requireFields(Lorg/json/JSONObject;[Ljava/lang/String;)V
    .locals 3
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 514
    invoke-virtual {p0}, Lorg/json/JSONObject;->length()I

    move-result v0

    array-length v1, p1

    const-string v2, "invalid fields"

    if-ne v0, v1, :cond_2

    const/4 v0, 0x0

    .line 517
    :goto_0
    array-length v1, p1

    if-ge v0, v1, :cond_1

    .line 518
    aget-object v1, p1, v0

    invoke-virtual {p0, v1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 519
    :cond_0
    new-instance p0, Ljava/lang/IllegalArgumentException;

    invoke-direct {p0, v2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0

    :cond_1
    return-void

    .line 515
    :cond_2
    new-instance p0, Ljava/lang/IllegalArgumentException;

    invoke-direct {p0, v2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    goto :goto_2

    :goto_1
    throw p0

    :goto_2
    goto :goto_1
.end method

.method private static requiredString(Lorg/json/JSONObject;Ljava/lang/String;I)Ljava/lang/String;
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 502
    invoke-virtual {p0, p1}, Lorg/json/JSONObject;->get(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p0

    .line 503
    instance-of p1, p0, Ljava/lang/String;

    const-string v0, "invalid string"

    if-eqz p1, :cond_1

    .line 506
    check-cast p0, Ljava/lang/String;

    .line 507
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result p1

    if-eqz p1, :cond_0

    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result p1

    if-gt p1, p2, :cond_0

    return-object p0

    .line 508
    :cond_0
    new-instance p0, Ljava/lang/IllegalArgumentException;

    invoke-direct {p0, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0

    .line 504
    :cond_1
    new-instance p0, Ljava/lang/IllegalArgumentException;

    invoke-direct {p0, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw p0
.end method

.method private static seal(Lorg/json/JSONObject;Ljava/lang/String;)V
    .locals 24
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    move-object/from16 v0, p0

    move-object/from16 v11, p1

    const/4 v1, 0x7

    .line 157
    new-array v1, v1, [Ljava/lang/String;

    const-string v2, "type"

    const/4 v12, 0x0

    aput-object v2, v1, v12

    const-string v2, "action"

    const/4 v3, 0x1

    aput-object v2, v1, v3

    const-string v2, "token"

    const/4 v4, 0x2

    aput-object v2, v1, v4

    const-string v2, "op"

    const/4 v5, 0x3

    aput-object v2, v1, v5

    const-string v2, "clientVersion"

    const/4 v5, 0x4

    aput-object v2, v1, v5

    const-string v2, "zoneId"

    const/4 v5, 0x5

    aput-object v2, v1, v5

    const-string v2, "payload"

    const/4 v5, 0x6

    aput-object v2, v1, v5

    invoke-static {v0, v1}, Lcom/eyugame/game/CryptoPlatformV1;->requireFields(Lorg/json/JSONObject;[Ljava/lang/String;)V

    .line 158
    const-string v1, "op"

    const/16 v2, 0x20

    invoke-static {v0, v1, v2}, Lcom/eyugame/game/CryptoPlatformV1;->requiredString(Lorg/json/JSONObject;Ljava/lang/String;I)Ljava/lang/String;

    move-result-object v5

    .line 159
    const-string v1, "clientVersion"

    invoke-static {v0, v1, v2}, Lcom/eyugame/game/CryptoPlatformV1;->requiredString(Lorg/json/JSONObject;Ljava/lang/String;I)Ljava/lang/String;

    move-result-object v6

    .line 160
    const-string v1, "zoneId"

    invoke-virtual {v0, v1}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v7

    if-lez v7, :cond_3

    .line 164
    const-string v1, "payload"

    invoke-virtual {v0, v1}, Lorg/json/JSONObject;->getJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v0

    .line 165
    invoke-virtual {v0}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/eyugame/game/CryptoPlatformV1;->utf8(Ljava/lang/String;)[B

    move-result-object v1

    array-length v1, v1

    const/16 v8, 0x800

    if-gt v1, v8, :cond_2

    const/16 v1, 0x60

    .line 168
    invoke-static {v1}, Lcom/eyugame/game/CryptoPlatformV1;->randomBytes(I)[B

    move-result-object v13

    const/16 v1, 0x10

    .line 169
    new-array v14, v1, [B

    .line 170
    new-array v15, v2, [B

    .line 171
    new-array v8, v1, [B

    .line 172
    new-array v9, v2, [B

    .line 173
    invoke-static {v13, v12, v14, v12, v1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 174
    invoke-static {v13, v1, v15, v12, v2}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    const/16 v10, 0x30

    .line 175
    invoke-static {v13, v10, v8, v12, v1}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    const/16 v10, 0x40

    .line 176
    invoke-static {v13, v10, v9, v12, v2}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 177
    invoke-static {v1}, Lcom/eyugame/game/CryptoPlatformV1;->randomBytes(I)[B

    move-result-object v2

    .line 178
    invoke-static {v1}, Lcom/eyugame/game/CryptoPlatformV1;->randomBytes(I)[B

    move-result-object v10

    .line 179
    invoke-static {v1}, Lcom/eyugame/game/CryptoPlatformV1;->randomBytes(I)[B

    move-result-object v1

    .line 180
    invoke-static {v2}, Lcom/eyugame/game/CryptoPlatformV1;->encode([B)Ljava/lang/String;

    move-result-object v2

    .line 181
    invoke-static {v10}, Lcom/eyugame/game/CryptoPlatformV1;->encode([B)Ljava/lang/String;

    move-result-object v10

    .line 182
    invoke-static {v1}, Lcom/eyugame/game/CryptoPlatformV1;->encode([B)Ljava/lang/String;

    move-result-object v12

    .line 183
    new-instance v3, Lorg/json/JSONObject;

    invoke-direct {v3}, Lorg/json/JSONObject;-><init>()V

    .line 184
    const-string v11, "v"

    invoke-virtual {v3, v11, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    .line 185
    const-string v11, "op"

    invoke-virtual {v3, v11, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 186
    const-string v11, "clientVersion"

    invoke-virtual {v3, v11, v6}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 187
    const-string v11, "zoneId"

    invoke-virtual {v3, v11, v7}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    .line 188
    const-string v11, "nonce"

    invoke-virtual {v3, v11, v10}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 189
    const-string v11, "issuedAt"

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v17

    const-wide/16 v19, 0x3e8

    move-object/from16 v23, v5

    div-long v4, v17, v19

    invoke-virtual {v3, v11, v4, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    .line 190
    const-string v4, "payload"

    invoke-virtual {v3, v4, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 191
    invoke-virtual {v3}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/eyugame/game/CryptoPlatformV1;->utf8(Ljava/lang/String;)[B

    move-result-object v0

    const/4 v3, 0x1

    invoke-static {v3, v14, v1, v0}, Lcom/eyugame/game/CryptoPlatformV1;->aes(Z[B[B[B)[B

    move-result-object v0

    invoke-static {v0}, Lcom/eyugame/game/CryptoPlatformV1;->encode([B)Ljava/lang/String;

    move-result-object v0

    .line 192
    const-string v1, "RSA"

    invoke-static {v1}, Ljava/security/KeyFactory;->getInstance(Ljava/lang/String;)Ljava/security/KeyFactory;

    move-result-object v1

    new-instance v3, Ljava/security/spec/X509EncodedKeySpec;

    const-string v4, "MIIBojANBgkqhkiG9w0BAQEFAAOCAY8AMIIBigKCAYEAnYPGoYcg9nImxJz0KI3cJFcDWn4OYHjHsW0tgAI5OfsbaYWHjYVCBAa8A8pA19CIeW6KWUECEARiNxT6X5wsq1CbZMawY1cHp2V+12YpA4sWVIFxqwT7lnGtYfJuqr/9w9yOjppz88u9/UnqoOJFMuqwKr2wLvlLEJUCStW+IMTtnjLMWf5GtkGH071dgfahF/oxCzh2Ajnz1M2YXQwUsoA0+/yELXwfdOdumgBjs/Owr0NgaGr+T8WLr7kTlJzm5cQQpzmTD5wM5F72TgybV5NZXFjMTr/IOc1+rJPmTZipJg4YWa05Ie38W6yfNS+zDhCbnLCLUpC2W9n8POZN9Cxsfi37vEdwJlfYgUbBKz7bo139HViklJOqjXVJTxtkR02rFTj5asfQQoMC9ijVmnNUSHOENynvWS9oYZo6dFMOHRxcmg+QrfJ2Wd49iBZ8x8kAnioduzHiChRqd70mKu2wumOtkD8oJJRX9HAYFN1lrmNY2WZ0z52/ptBsyjvXAgMBAAE="

    const/4 v5, 0x0

    .line 193
    invoke-static {v4, v5}, Landroid/util/Base64;->decode(Ljava/lang/String;I)[B

    move-result-object v4

    invoke-direct {v3, v4}, Ljava/security/spec/X509EncodedKeySpec;-><init>([B)V

    .line 192
    invoke-virtual {v1, v3}, Ljava/security/KeyFactory;->generatePublic(Ljava/security/spec/KeySpec;)Ljava/security/PublicKey;

    move-result-object v1

    .line 194
    instance-of v3, v1, Ljava/security/interfaces/RSAPublicKey;

    if-eqz v3, :cond_1

    move-object v3, v1

    check-cast v3, Ljava/security/interfaces/RSAPublicKey;

    .line 195
    invoke-interface {v3}, Ljava/security/interfaces/RSAPublicKey;->getModulus()Ljava/math/BigInteger;

    move-result-object v3

    invoke-virtual {v3}, Ljava/math/BigInteger;->bitLength()I

    move-result v3

    const/16 v4, 0xc00

    if-ne v3, v4, :cond_1

    .line 198
    const-string v3, "RSA/ECB/OAEPWithSHA-1AndMGF1Padding"

    invoke-static {v3}, Ljavax/crypto/Cipher;->getInstance(Ljava/lang/String;)Ljavax/crypto/Cipher;

    move-result-object v3

    .line 199
    sget-object v4, Lcom/eyugame/game/CryptoPlatformV1;->RANDOM:Ljava/security/SecureRandom;

    const/4 v5, 0x1

    invoke-virtual {v3, v5, v1, v4}, Ljavax/crypto/Cipher;->init(ILjava/security/Key;Ljava/security/SecureRandom;)V

    .line 200
    invoke-virtual {v3, v13}, Ljavax/crypto/Cipher;->doFinal([B)[B

    move-result-object v1

    invoke-static {v1}, Lcom/eyugame/game/CryptoPlatformV1;->encode([B)Ljava/lang/String;

    move-result-object v1

    .line 201
    sget-object v16, Lcom/eyugame/game/CryptoPlatformV1;->REQUEST_DOMAIN:[B

    const-string v17, "2"

    const-string v18, "rsa-v1"

    move-object/from16 v19, v2

    move-object/from16 v20, v1

    move-object/from16 v21, v12

    move-object/from16 v22, v0

    invoke-static/range {v16 .. v22}, Lcom/eyugame/game/CryptoPlatformV1;->macInput([BLjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)[B

    move-result-object v3

    invoke-static {v15, v3}, Lcom/eyugame/game/CryptoPlatformV1;->hmac([B[B)[B

    move-result-object v3

    invoke-static {v3}, Lcom/eyugame/game/CryptoPlatformV1;->encode([B)Ljava/lang/String;

    move-result-object v3

    .line 203
    new-instance v11, Lorg/json/JSONObject;

    invoke-direct {v11}, Lorg/json/JSONObject;-><init>()V

    .line 204
    const-string v4, "v"

    const/4 v5, 0x2

    invoke-virtual {v11, v4, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    .line 205
    const-string v4, "kid"

    const-string v5, "rsa-v1"

    invoke-virtual {v11, v4, v5}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 206
    const-string v4, "rid"

    invoke-virtual {v11, v4, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 207
    const-string v4, "ek"

    invoke-virtual {v11, v4, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 208
    const-string v1, "iv"

    invoke-virtual {v11, v1, v12}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 209
    const-string v1, "ct"

    invoke-virtual {v11, v1, v0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 210
    const-string v0, "mac"

    invoke-virtual {v11, v0, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 211
    new-instance v12, Lcom/eyugame/game/CryptoPlatformV1$Pending;

    .line 213
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v16

    move-object v0, v12

    move-object/from16 v1, p1

    move-object v5, v2

    move-object v3, v10

    move-object/from16 v4, v23

    move-object v10, v5

    move-object v5, v6

    move v6, v7

    move-object v7, v8

    move-object v8, v9

    move-object/from16 p0, v11

    move-object v11, v10

    move-wide/from16 v9, v16

    invoke-direct/range {v0 .. v10}, Lcom/eyugame/game/CryptoPlatformV1$Pending;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;I[B[BJ)V

    .line 214
    sget-object v1, Lcom/eyugame/game/CryptoPlatformV1;->LOCK:Ljava/lang/Object;

    monitor-enter v1

    .line 215
    :try_start_0
    invoke-static {}, Lcom/eyugame/game/CryptoPlatformV1;->pruneLocked()V

    .line 216
    sget-object v0, Lcom/eyugame/game/CryptoPlatformV1;->PENDING:Ljava/util/LinkedHashMap;

    move-object/from16 v2, p1

    invoke-virtual {v0, v2}, Ljava/util/LinkedHashMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/eyugame/game/CryptoPlatformV1$Pending;

    if-eqz v3, :cond_0

    .line 218
    invoke-virtual {v3}, Lcom/eyugame/game/CryptoPlatformV1$Pending;->wipe()V

    .line 220
    :cond_0
    invoke-virtual {v0, v2, v12}, Ljava/util/LinkedHashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 221
    invoke-static {}, Lcom/eyugame/game/CryptoPlatformV1;->trimPendingLocked()V

    .line 222
    monitor-exit v1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    const/4 v0, 0x0

    .line 223
    invoke-static {v13, v0}, Ljava/util/Arrays;->fill([BB)V

    .line 224
    invoke-static {v14, v0}, Ljava/util/Arrays;->fill([BB)V

    .line 225
    invoke-static {v15, v0}, Ljava/util/Arrays;->fill([BB)V

    .line 226
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1}, Lorg/json/JSONObject;-><init>()V

    .line 227
    const-string v3, "requestId"

    invoke-virtual {v1, v3, v11}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 228
    const-string v3, "envelope"

    invoke-virtual/range {p0 .. p0}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lcom/eyugame/game/CryptoPlatformV1;->utf8(Ljava/lang/String;)[B

    move-result-object v4

    invoke-static {v4}, Lcom/eyugame/game/CryptoPlatformV1;->encode([B)Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v1, v3, v4}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    .line 229
    invoke-virtual {v1}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-static {v2, v0, v1}, Lcom/eyugame/game/CryptoPlatformV1;->callbackAccount(Ljava/lang/String;ILjava/lang/String;)V

    return-void

    :catchall_0
    move-exception v0

    .line 222
    :try_start_1
    monitor-exit v1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    throw v0

    .line 196
    :cond_1
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "invalid account transport public key"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 166
    :cond_2
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "payload is too large"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 162
    :cond_3
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "invalid zone"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method private static trimPendingLocked()V
    .locals 3

    .line 450
    :goto_0
    sget-object v0, Lcom/eyugame/game/CryptoPlatformV1;->PENDING:Ljava/util/LinkedHashMap;

    invoke-virtual {v0}, Ljava/util/LinkedHashMap;->size()I

    move-result v1

    const/4 v2, 0x4

    if-le v1, v2, :cond_0

    .line 451
    invoke-virtual {v0}, Ljava/util/LinkedHashMap;->entrySet()Ljava/util/Set;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v0

    .line 452
    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/util/Map$Entry;

    invoke-interface {v1}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/eyugame/game/CryptoPlatformV1$Pending;

    .line 453
    invoke-interface {v0}, Ljava/util/Iterator;->remove()V

    .line 454
    invoke-virtual {v1}, Lcom/eyugame/game/CryptoPlatformV1$Pending;->wipe()V

    goto :goto_0

    :cond_0
    return-void
.end method

.method private static utf8(Ljava/lang/String;)[B
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 609
    const-string v0, "UTF-8"

    invoke-virtual {p0, v0}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object p0

    return-object p0
.end method

.method private static writePart(Ljava/io/ByteArrayOutputStream;[B)V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 568
    new-instance v0, Ljava/io/DataOutputStream;

    invoke-direct {v0, p0}, Ljava/io/DataOutputStream;-><init>(Ljava/io/OutputStream;)V

    .line 569
    array-length p0, p1

    invoke-virtual {v0, p0}, Ljava/io/DataOutputStream;->writeInt(I)V

    .line 570
    invoke-virtual {v0, p1}, Ljava/io/DataOutputStream;->write([B)V

    .line 571
    invoke-virtual {v0}, Ljava/io/DataOutputStream;->flush()V

    return-void
.end method


# virtual methods
.method public login(Ljava/lang/String;)I
    .locals 7

    .line 102
    :try_start_0
    new-instance v0, Lorg/json/JSONObject;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_3

    const-string v1, ""

    if-nez p1, :cond_0

    move-object v2, v1

    goto :goto_0

    :cond_0
    move-object v2, p1

    :goto_0
    :try_start_1
    invoke-direct {v0, v2}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_3

    .line 106
    const-string v2, "type"

    invoke-virtual {v0, v2, v1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    .line 107
    const-string v3, "token"

    invoke-virtual {v0, v3, v1}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    .line 108
    const-string v4, "accountCrypto"

    invoke-virtual {v4, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    const/4 v5, 0x0

    const/4 v6, -0x1

    if-eqz v4, :cond_1

    .line 110
    :try_start_2
    invoke-static {v0}, Lcom/eyugame/game/CryptoPlatformV1;->handleAccountCrypto(Lorg/json/JSONObject;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    return v5

    .line 113
    :catchall_0
    invoke-static {v3, v6, v1}, Lcom/eyugame/game/CryptoPlatformV1;->callbackAccount(Ljava/lang/String;ILjava/lang/String;)V

    return v6

    .line 117
    :cond_1
    const-string v4, "tcpLoginProof"

    invoke-virtual {v4, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_2

    .line 119
    :try_start_3
    invoke-static {v0}, Lcom/eyugame/game/CryptoPlatformV1;->handleTCPLoginProof(Lorg/json/JSONObject;)V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    return v5

    .line 122
    :catchall_1
    invoke-static {v3, v6, v1}, Lcom/eyugame/game/CryptoPlatformV1;->callbackProof(Ljava/lang/String;ILjava/lang/String;)V

    return v6

    .line 126
    :cond_2
    const-string v0, "accountCryptoClear"

    invoke-virtual {v0, v2}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_3

    .line 128
    :try_start_4
    invoke-static {}, Lcom/eyugame/game/CryptoPlatformV1;->clearAll()V
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_2

    return v5

    :catchall_2
    return v6

    .line 134
    :cond_3
    invoke-super {p0, p1}, Lcom/eyugame/game/LocalSdkPlatform;->login(Ljava/lang/String;)I

    move-result p1

    return p1

    .line 104
    :catchall_3
    invoke-super {p0, p1}, Lcom/eyugame/game/LocalSdkPlatform;->login(Ljava/lang/String;)I

    move-result p1

    return p1
.end method
