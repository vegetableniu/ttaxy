.class public Lcom/eyugame/utils/DateUtils;
.super Ljava/lang/Object;
.source "DateUtils.java"


# static fields
.field public static final LONG_AFTER_TIME:Ljava/util/Date;

.field public static final LONG_BEFORE_TIME:Ljava/util/Date;

.field public static final PATTERN_DATE:Ljava/lang/String; = "yyyy-MM-dd"

.field public static final PATTERN_DATE_TIME:Ljava/lang/String; = "yyyy-MM-dd HH:mm:ss"

.field public static final PATTERN_SHORT_TIME:Ljava/lang/String; = "HH:mm"

.field public static final PATTERN_TIME:Ljava/lang/String; = "HH:mm:ss"


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .prologue
    .line 28
    const-string v0, "1970-01-01 00:00:00"

    const-string v1, "yyyy-MM-dd HH:mm:ss"

    invoke-static {v0, v1}, Lcom/eyugame/utils/DateUtils;->string2Date(Ljava/lang/String;Ljava/lang/String;)Ljava/util/Date;

    move-result-object v0

    sput-object v0, Lcom/eyugame/utils/DateUtils;->LONG_BEFORE_TIME:Ljava/util/Date;

    .line 30
    const-string v0, "2048-01-01 00:00:00"

    const-string v1, "yyyy-MM-dd HH:mm:ss"

    invoke-static {v0, v1}, Lcom/eyugame/utils/DateUtils;->string2Date(Ljava/lang/String;Ljava/lang/String;)Ljava/util/Date;

    move-result-object v0

    sput-object v0, Lcom/eyugame/utils/DateUtils;->LONG_AFTER_TIME:Ljava/util/Date;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .prologue
    .line 16
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static addTime(Ljava/util/Date;III)Ljava/util/Date;
    .locals 2
    .param p0, "source"    # Ljava/util/Date;
    .param p1, "hours"    # I
    .param p2, "minutes"    # I
    .param p3, "second"    # I

    .prologue
    .line 129
    if-nez p0, :cond_0

    .line 130
    const/4 v1, 0x0

    .line 138
    :goto_0
    return-object v1

    .line 133
    :cond_0
    invoke-static {}, Ljava/util/Calendar;->getInstance()Ljava/util/Calendar;

    move-result-object v0

    .line 134
    .local v0, "cal":Ljava/util/Calendar;
    invoke-virtual {v0, p0}, Ljava/util/Calendar;->setTime(Ljava/util/Date;)V

    .line 135
    const/16 v1, 0xb

    invoke-virtual {v0, v1, p1}, Ljava/util/Calendar;->add(II)V

    .line 136
    const/16 v1, 0xc

    invoke-virtual {v0, v1, p2}, Ljava/util/Calendar;->add(II)V

    .line 137
    const/16 v1, 0xd

    invoke-virtual {v0, v1, p3}, Ljava/util/Calendar;->add(II)V

    .line 138
    invoke-virtual {v0}, Ljava/util/Calendar;->getTime()Ljava/util/Date;

    move-result-object v1

    goto :goto_0
.end method

.method public static date2String(Ljava/util/Date;Ljava/lang/String;)Ljava/lang/String;
    .locals 1
    .param p0, "date"    # Ljava/util/Date;
    .param p1, "pattern"    # Ljava/lang/String;

    .prologue
    .line 102
    new-instance v0, Ljava/text/SimpleDateFormat;

    invoke-direct {v0, p1}, Ljava/text/SimpleDateFormat;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p0}, Ljava/text/SimpleDateFormat;->format(Ljava/util/Date;)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public static firstTimeOfWeek(ILjava/util/Date;)Ljava/util/Date;
    .locals 4
    .param p0, "firstDayOfWeek"    # I
    .param p1, "time"    # Ljava/util/Date;

    .prologue
    const/4 v3, 0x0

    .line 71
    invoke-static {}, Ljava/util/Calendar;->getInstance()Ljava/util/Calendar;

    move-result-object v0

    .line 72
    .local v0, "cal":Ljava/util/Calendar;
    if-eqz p1, :cond_0

    .line 73
    invoke-virtual {v0, p1}, Ljava/util/Calendar;->setTime(Ljava/util/Date;)V

    .line 76
    :cond_0
    invoke-virtual {v0, p0}, Ljava/util/Calendar;->setFirstDayOfWeek(I)V

    .line 77
    const/4 v2, 0x7

    invoke-virtual {v0, v2}, Ljava/util/Calendar;->get(I)I

    move-result v1

    .line 78
    .local v1, "day":I
    if-ne v1, p0, :cond_2

    .line 79
    const/4 v1, 0x0

    .line 86
    :cond_1
    :goto_0
    const/16 v2, 0xb

    invoke-virtual {v0, v2, v3}, Ljava/util/Calendar;->set(II)V

    .line 87
    const/16 v2, 0xc

    invoke-virtual {v0, v2, v3}, Ljava/util/Calendar;->set(II)V

    .line 88
    const/16 v2, 0xd

    invoke-virtual {v0, v2, v3}, Ljava/util/Calendar;->set(II)V

    .line 89
    const/16 v2, 0xe

    invoke-virtual {v0, v2, v3}, Ljava/util/Calendar;->set(II)V

    .line 91
    const/4 v2, 0x5

    neg-int v3, v1

    invoke-virtual {v0, v2, v3}, Ljava/util/Calendar;->add(II)V

    .line 92
    invoke-virtual {v0}, Ljava/util/Calendar;->getTime()Ljava/util/Date;

    move-result-object v2

    return-object v2

    .line 80
    :cond_2
    if-ge v1, p0, :cond_3

    .line 81
    rsub-int/lit8 v2, p0, 0x7

    add-int/2addr v1, v2

    goto :goto_0

    .line 82
    :cond_3
    if-le v1, p0, :cond_1

    .line 83
    sub-int/2addr v1, p0

    goto :goto_0
.end method

.method public static getFirstTime(Ljava/util/Date;)Ljava/util/Date;
    .locals 3
    .param p0, "date"    # Ljava/util/Date;

    .prologue
    const/4 v2, 0x0

    .line 146
    invoke-static {}, Ljava/util/Calendar;->getInstance()Ljava/util/Calendar;

    move-result-object v0

    .line 147
    .local v0, "calendar":Ljava/util/Calendar;
    if-eqz p0, :cond_0

    .line 148
    invoke-virtual {v0, p0}, Ljava/util/Calendar;->setTime(Ljava/util/Date;)V

    .line 150
    :cond_0
    const/16 v1, 0xb

    invoke-virtual {v0, v1, v2}, Ljava/util/Calendar;->set(II)V

    .line 151
    const/16 v1, 0xc

    invoke-virtual {v0, v1, v2}, Ljava/util/Calendar;->set(II)V

    .line 152
    const/16 v1, 0xd

    invoke-virtual {v0, v1, v2}, Ljava/util/Calendar;->set(II)V

    .line 153
    const/16 v1, 0xe

    invoke-virtual {v0, v1, v2}, Ljava/util/Calendar;->set(II)V

    .line 154
    invoke-virtual {v0}, Ljava/util/Calendar;->getTime()Ljava/util/Date;

    move-result-object v1

    return-object v1
.end method

.method public static getNextTime(Ljava/lang/String;Ljava/util/Date;)Ljava/util/Date;
    .locals 3
    .param p0, "cron"    # Ljava/lang/String;
    .param p1, "now"    # Ljava/util/Date;

    .prologue
    .line 165
    new-instance v0, Lcom/eyugame/utils/CronSequenceGenerator;

    invoke-static {}, Ljava/util/TimeZone;->getDefault()Ljava/util/TimeZone;

    move-result-object v2

    invoke-direct {v0, p0, v2}, Lcom/eyugame/utils/CronSequenceGenerator;-><init>(Ljava/lang/String;Ljava/util/TimeZone;)V

    .line 166
    .local v0, "gen":Lcom/eyugame/utils/CronSequenceGenerator;
    invoke-virtual {v0, p1}, Lcom/eyugame/utils/CronSequenceGenerator;->next(Ljava/util/Date;)Ljava/util/Date;

    move-result-object v1

    .line 167
    .local v1, "time":Ljava/util/Date;
    return-object v1
.end method

.method public static isSameWeek(III)Z
    .locals 3
    .param p0, "year"    # I
    .param p1, "week"    # I
    .param p2, "firstDayOfWeek"    # I

    .prologue
    const/4 v1, 0x1

    .line 41
    invoke-static {}, Ljava/util/Calendar;->getInstance()Ljava/util/Calendar;

    move-result-object v0

    .line 42
    .local v0, "cal":Ljava/util/Calendar;
    invoke-virtual {v0, p2}, Ljava/util/Calendar;->setFirstDayOfWeek(I)V

    .line 43
    invoke-virtual {v0, v1}, Ljava/util/Calendar;->get(I)I

    move-result v2

    if-ne p0, v2, :cond_0

    const/4 v2, 0x3

    invoke-virtual {v0, v2}, Ljava/util/Calendar;->get(I)I

    move-result v2

    if-ne p1, v2, :cond_0

    :goto_0
    return v1

    :cond_0
    const/4 v1, 0x0

    goto :goto_0
.end method

.method public static isSameWeek(Ljava/util/Date;I)Z
    .locals 3
    .param p0, "time"    # Ljava/util/Date;
    .param p1, "firstDayOfWeek"    # I

    .prologue
    .line 54
    if-nez p0, :cond_0

    .line 55
    const/4 v1, 0x0

    .line 61
    :goto_0
    return v1

    .line 58
    :cond_0
    invoke-static {}, Ljava/util/Calendar;->getInstance()Ljava/util/Calendar;

    move-result-object v0

    .line 59
    .local v0, "cal":Ljava/util/Calendar;
    invoke-virtual {v0, p0}, Ljava/util/Calendar;->setTime(Ljava/util/Date;)V

    .line 60
    invoke-virtual {v0, p1}, Ljava/util/Calendar;->setFirstDayOfWeek(I)V

    .line 61
    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Ljava/util/Calendar;->get(I)I

    move-result v1

    const/4 v2, 0x3

    invoke-virtual {v0, v2}, Ljava/util/Calendar;->get(I)I

    move-result v2

    invoke-static {v1, v2, p1}, Lcom/eyugame/utils/DateUtils;->isSameWeek(III)Z

    move-result v1

    goto :goto_0
.end method

.method public static string2Date(Ljava/lang/String;Ljava/lang/String;)Ljava/util/Date;
    .locals 4
    .param p0, "string"    # Ljava/lang/String;
    .param p1, "pattern"    # Ljava/lang/String;

    .prologue
    .line 113
    :try_start_0
    new-instance v1, Ljava/text/SimpleDateFormat;

    invoke-direct {v1, p1}, Ljava/text/SimpleDateFormat;-><init>(Ljava/lang/String;)V

    invoke-virtual {v1, p0}, Ljava/text/SimpleDateFormat;->parse(Ljava/lang/String;)Ljava/util/Date;
    :try_end_0
    .catch Ljava/text/ParseException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v1

    return-object v1

    .line 114
    :catch_0
    move-exception v0

    .line 115
    .local v0, "e":Ljava/text/ParseException;
    new-instance v1, Ljava/lang/IllegalArgumentException;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "\u65e0\u6cd5\u5c06\u5b57\u7b26\u4e32["

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "]\u6309\u683c\u5f0f["

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "]\u8f6c\u6362\u4e3a\u65e5\u671f"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2, v0}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw v1
.end method
