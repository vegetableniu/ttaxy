.class Lcom/eyugame/game/ConfigSingle$ConfigSingleHolder;
.super Ljava/lang/Object;
.source "ConfigSingle.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/eyugame/game/ConfigSingle;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "ConfigSingleHolder"
.end annotation


# static fields
.field private static final INSTANCE:Lcom/eyugame/game/ConfigSingle;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 84
    new-instance v0, Lcom/eyugame/game/ConfigSingle;

    invoke-direct {v0}, Lcom/eyugame/game/ConfigSingle;-><init>()V

    sput-object v0, Lcom/eyugame/game/ConfigSingle$ConfigSingleHolder;->INSTANCE:Lcom/eyugame/game/ConfigSingle;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .prologue
    .line 83
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$000()Lcom/eyugame/game/ConfigSingle;
    .locals 1

    .prologue
    .line 83
    sget-object v0, Lcom/eyugame/game/ConfigSingle$ConfigSingleHolder;->INSTANCE:Lcom/eyugame/game/ConfigSingle;

    return-object v0
.end method
