.class public Lcom/eyugame/pushmsg/PushMsgMgr;
.super Ljava/lang/Object;
.source "PushMsgMgr.java"


# static fields
.field private static sInstance:Lcom/eyugame/pushmsg/PushMsgMgr;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const/4 v0, 0x0

    sput-object v0, Lcom/eyugame/pushmsg/PushMsgMgr;->sInstance:Lcom/eyugame/pushmsg/PushMsgMgr;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static GetSingleton()Lcom/eyugame/pushmsg/PushMsgMgr;
    .locals 1

    sget-object v0, Lcom/eyugame/pushmsg/PushMsgMgr;->sInstance:Lcom/eyugame/pushmsg/PushMsgMgr;

    if-nez v0, :cond_0

    new-instance v0, Lcom/eyugame/pushmsg/PushMsgMgr;

    invoke-direct {v0}, Lcom/eyugame/pushmsg/PushMsgMgr;-><init>()V

    sput-object v0, Lcom/eyugame/pushmsg/PushMsgMgr;->sInstance:Lcom/eyugame/pushmsg/PushMsgMgr;

    :cond_0
    return-object v0
.end method


# virtual methods
.method public addLocalNotification(Ljava/lang/String;)V
    .locals 0

    return-void
.end method

.method public delLocalNotification(Ljava/lang/String;)V
    .locals 0

    return-void
.end method

.method public loginComplete(J)V
    .locals 0

    return-void
.end method

.method public onCreate()V
    .locals 0

    return-void
.end method

.method public onDestroy()V
    .locals 0

    return-void
.end method
