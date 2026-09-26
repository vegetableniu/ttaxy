.class public Lcom/eyugame/utils/CronSequenceGenerator;
.super Ljava/lang/Object;
.source "CronSequenceGenerator.java"


# instance fields
.field private final daysOfMonth:Ljava/util/BitSet;

.field private final daysOfWeek:Ljava/util/BitSet;

.field private final expression:Ljava/lang/String;

.field private final hours:Ljava/util/BitSet;

.field private final minutes:Ljava/util/BitSet;

.field private final months:Ljava/util/BitSet;

.field private final seconds:Ljava/util/BitSet;

.field private final timeZone:Ljava/util/TimeZone;


# direct methods
.method public constructor <init>(Ljava/lang/String;Ljava/util/TimeZone;)V
    .locals 2
    .param p1, "expression"    # Ljava/lang/String;
    .param p2, "timeZone"    # Ljava/util/TimeZone;

    .prologue
    const/16 v1, 0x3c

    .line 78
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 56
    new-instance v0, Ljava/util/BitSet;

    invoke-direct {v0, v1}, Ljava/util/BitSet;-><init>(I)V

    iput-object v0, p0, Lcom/eyugame/utils/CronSequenceGenerator;->seconds:Ljava/util/BitSet;

    .line 58
    new-instance v0, Ljava/util/BitSet;

    invoke-direct {v0, v1}, Ljava/util/BitSet;-><init>(I)V

    iput-object v0, p0, Lcom/eyugame/utils/CronSequenceGenerator;->minutes:Ljava/util/BitSet;

    .line 60
    new-instance v0, Ljava/util/BitSet;

    const/16 v1, 0x18

    invoke-direct {v0, v1}, Ljava/util/BitSet;-><init>(I)V

    iput-object v0, p0, Lcom/eyugame/utils/CronSequenceGenerator;->hours:Ljava/util/BitSet;

    .line 62
    new-instance v0, Ljava/util/BitSet;

    const/4 v1, 0x7

    invoke-direct {v0, v1}, Ljava/util/BitSet;-><init>(I)V

    iput-object v0, p0, Lcom/eyugame/utils/CronSequenceGenerator;->daysOfWeek:Ljava/util/BitSet;

    .line 64
    new-instance v0, Ljava/util/BitSet;

    const/16 v1, 0x1f

    invoke-direct {v0, v1}, Ljava/util/BitSet;-><init>(I)V

    iput-object v0, p0, Lcom/eyugame/utils/CronSequenceGenerator;->daysOfMonth:Ljava/util/BitSet;

    .line 66
    new-instance v0, Ljava/util/BitSet;

    const/16 v1, 0xc

    invoke-direct {v0, v1}, Ljava/util/BitSet;-><init>(I)V

    iput-object v0, p0, Lcom/eyugame/utils/CronSequenceGenerator;->months:Ljava/util/BitSet;

    .line 79
    iput-object p1, p0, Lcom/eyugame/utils/CronSequenceGenerator;->expression:Ljava/lang/String;

    .line 80
    iput-object p2, p0, Lcom/eyugame/utils/CronSequenceGenerator;->timeZone:Ljava/util/TimeZone;

    .line 81
    invoke-direct {p0, p1}, Lcom/eyugame/utils/CronSequenceGenerator;->parse(Ljava/lang/String;)V

    .line 82
    return-void
.end method

.method private doNext(Ljava/util/Calendar;I)V
    .locals 37
    .param p1, "calendar"    # Ljava/util/Calendar;
    .param p2, "dot"    # I

    .prologue
    .line 125
    new-instance v15, Ljava/util/ArrayList;

    invoke-direct {v15}, Ljava/util/ArrayList;-><init>()V

    .line 127
    .local v15, "resets":Ljava/util/List;, "Ljava/util/List<Ljava/lang/Integer;>;"
    const/16 v2, 0xd

    move-object/from16 v0, p1

    invoke-virtual {v0, v2}, Ljava/util/Calendar;->get(I)I

    move-result v4

    .line 128
    .local v4, "second":I
    invoke-static {}, Ljava/util/Collections;->emptyList()Ljava/util/List;

    move-result-object v8

    .line 129
    .local v8, "emptyList":Ljava/util/List;, "Ljava/util/List<Ljava/lang/Integer;>;"
    move-object/from16 v0, p0

    iget-object v3, v0, Lcom/eyugame/utils/CronSequenceGenerator;->seconds:Ljava/util/BitSet;

    const/16 v6, 0xd

    const/16 v7, 0xc

    move-object/from16 v2, p0

    move-object/from16 v5, p1

    invoke-direct/range {v2 .. v8}, Lcom/eyugame/utils/CronSequenceGenerator;->findNext(Ljava/util/BitSet;ILjava/util/Calendar;IILjava/util/List;)I

    move-result v36

    .line 130
    .local v36, "updateSecond":I
    move/from16 v0, v36

    if-ne v4, v0, :cond_0

    .line 131
    const/16 v2, 0xd

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v15, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 134
    :cond_0
    const/16 v2, 0xc

    move-object/from16 v0, p1

    invoke-virtual {v0, v2}, Ljava/util/Calendar;->get(I)I

    move-result v11

    .line 135
    .local v11, "minute":I
    move-object/from16 v0, p0

    iget-object v10, v0, Lcom/eyugame/utils/CronSequenceGenerator;->minutes:Ljava/util/BitSet;

    const/16 v13, 0xc

    const/16 v14, 0xb

    move-object/from16 v9, p0

    move-object/from16 v12, p1

    invoke-direct/range {v9 .. v15}, Lcom/eyugame/utils/CronSequenceGenerator;->findNext(Ljava/util/BitSet;ILjava/util/Calendar;IILjava/util/List;)I

    move-result v34

    .line 136
    .local v34, "updateMinute":I
    move/from16 v0, v34

    if-ne v11, v0, :cond_1

    .line 137
    const/16 v2, 0xc

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v15, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 142
    :goto_0
    const/16 v2, 0xb

    move-object/from16 v0, p1

    invoke-virtual {v0, v2}, Ljava/util/Calendar;->get(I)I

    move-result v18

    .line 143
    .local v18, "hour":I
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/eyugame/utils/CronSequenceGenerator;->hours:Ljava/util/BitSet;

    move-object/from16 v17, v0

    const/16 v20, 0xb

    const/16 v21, 0x7

    move-object/from16 v16, p0

    move-object/from16 v19, p1

    move-object/from16 v22, v15

    invoke-direct/range {v16 .. v22}, Lcom/eyugame/utils/CronSequenceGenerator;->findNext(Ljava/util/BitSet;ILjava/util/Calendar;IILjava/util/List;)I

    move-result v33

    .line 144
    .local v33, "updateHour":I
    move/from16 v0, v18

    move/from16 v1, v33

    if-ne v0, v1, :cond_2

    .line 145
    const/16 v2, 0xb

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v15, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 150
    :goto_1
    const/4 v2, 0x7

    move-object/from16 v0, p1

    invoke-virtual {v0, v2}, Ljava/util/Calendar;->get(I)I

    move-result v24

    .line 151
    .local v24, "dayOfWeek":I
    const/4 v2, 0x5

    move-object/from16 v0, p1

    invoke-virtual {v0, v2}, Ljava/util/Calendar;->get(I)I

    move-result v22

    .line 152
    .local v22, "dayOfMonth":I
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/eyugame/utils/CronSequenceGenerator;->daysOfMonth:Ljava/util/BitSet;

    move-object/from16 v21, v0

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/eyugame/utils/CronSequenceGenerator;->daysOfWeek:Ljava/util/BitSet;

    move-object/from16 v23, v0

    move-object/from16 v19, p0

    move-object/from16 v20, p1

    move-object/from16 v25, v15

    invoke-direct/range {v19 .. v25}, Lcom/eyugame/utils/CronSequenceGenerator;->findNextDay(Ljava/util/Calendar;Ljava/util/BitSet;ILjava/util/BitSet;ILjava/util/List;)I

    move-result v32

    .line 153
    .local v32, "updateDayOfMonth":I
    move/from16 v0, v22

    move/from16 v1, v32

    if-ne v0, v1, :cond_3

    .line 154
    const/4 v2, 0x5

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v15, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    .line 159
    :goto_2
    const/4 v2, 0x2

    move-object/from16 v0, p1

    invoke-virtual {v0, v2}, Ljava/util/Calendar;->get(I)I

    move-result v27

    .line 160
    .local v27, "month":I
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/eyugame/utils/CronSequenceGenerator;->months:Ljava/util/BitSet;

    move-object/from16 v26, v0

    const/16 v29, 0x2

    const/16 v30, 0x1

    move-object/from16 v25, p0

    move-object/from16 v28, p1

    move-object/from16 v31, v15

    invoke-direct/range {v25 .. v31}, Lcom/eyugame/utils/CronSequenceGenerator;->findNext(Ljava/util/BitSet;ILjava/util/Calendar;IILjava/util/List;)I

    move-result v35

    .line 161
    .local v35, "updateMonth":I
    move/from16 v0, v27

    move/from16 v1, v35

    if-eq v0, v1, :cond_5

    .line 162
    const/4 v2, 0x1

    move-object/from16 v0, p1

    invoke-virtual {v0, v2}, Ljava/util/Calendar;->get(I)I

    move-result v2

    sub-int v2, v2, p2

    const/4 v3, 0x4

    if-le v2, v3, :cond_4

    .line 163
    new-instance v2, Ljava/lang/IllegalStateException;

    const-string v3, "Invalid cron expression led to runaway search for next trigger"

    invoke-direct {v2, v3}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v2

    .line 139
    .end local v18    # "hour":I
    .end local v22    # "dayOfMonth":I
    .end local v24    # "dayOfWeek":I
    .end local v27    # "month":I
    .end local v32    # "updateDayOfMonth":I
    .end local v33    # "updateHour":I
    .end local v35    # "updateMonth":I
    :cond_1
    invoke-direct/range {p0 .. p2}, Lcom/eyugame/utils/CronSequenceGenerator;->doNext(Ljava/util/Calendar;I)V

    goto/16 :goto_0

    .line 147
    .restart local v18    # "hour":I
    .restart local v33    # "updateHour":I
    :cond_2
    invoke-direct/range {p0 .. p2}, Lcom/eyugame/utils/CronSequenceGenerator;->doNext(Ljava/util/Calendar;I)V

    goto :goto_1

    .line 156
    .restart local v22    # "dayOfMonth":I
    .restart local v24    # "dayOfWeek":I
    .restart local v32    # "updateDayOfMonth":I
    :cond_3
    invoke-direct/range {p0 .. p2}, Lcom/eyugame/utils/CronSequenceGenerator;->doNext(Ljava/util/Calendar;I)V

    goto :goto_2

    .line 165
    .restart local v27    # "month":I
    .restart local v35    # "updateMonth":I
    :cond_4
    invoke-direct/range {p0 .. p2}, Lcom/eyugame/utils/CronSequenceGenerator;->doNext(Ljava/util/Calendar;I)V

    .line 168
    :cond_5
    return-void
.end method

.method private findNext(Ljava/util/BitSet;ILjava/util/Calendar;IILjava/util/List;)I
    .locals 4
    .param p1, "bits"    # Ljava/util/BitSet;
    .param p2, "value"    # I
    .param p3, "calendar"    # Ljava/util/Calendar;
    .param p4, "field"    # I
    .param p5, "nextField"    # I
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/BitSet;",
            "I",
            "Ljava/util/Calendar;",
            "II",
            "Ljava/util/List",
            "<",
            "Ljava/lang/Integer;",
            ">;)I"
        }
    .end annotation

    .prologue
    .local p6, "lowerOrders":Ljava/util/List;, "Ljava/util/List<Ljava/lang/Integer;>;"
    const/4 v2, 0x1

    const/4 v3, 0x0

    .line 202
    invoke-virtual {p1, p2}, Ljava/util/BitSet;->nextSetBit(I)I

    move-result v0

    .line 204
    .local v0, "nextValue":I
    const/4 v1, -0x1

    if-ne v0, v1, :cond_0

    .line 205
    invoke-virtual {p3, p5, v2}, Ljava/util/Calendar;->add(II)V

    .line 206
    new-array v1, v2, [Ljava/lang/Integer;

    invoke-static {p4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    aput-object v2, v1, v3

    invoke-static {v1}, Ljava/util/Arrays;->asList([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v1

    invoke-direct {p0, p3, v1}, Lcom/eyugame/utils/CronSequenceGenerator;->reset(Ljava/util/Calendar;Ljava/util/List;)V

    .line 207
    invoke-virtual {p1, v3}, Ljava/util/BitSet;->nextSetBit(I)I

    move-result v0

    .line 209
    :cond_0
    if-eq v0, p2, :cond_1

    .line 210
    invoke-virtual {p3, p4, v0}, Ljava/util/Calendar;->set(II)V

    .line 211
    invoke-direct {p0, p3, p6}, Lcom/eyugame/utils/CronSequenceGenerator;->reset(Ljava/util/Calendar;Ljava/util/List;)V

    .line 213
    :cond_1
    return v0
.end method

.method private findNextDay(Ljava/util/Calendar;Ljava/util/BitSet;ILjava/util/BitSet;ILjava/util/List;)I
    .locals 6
    .param p1, "calendar"    # Ljava/util/Calendar;
    .param p2, "daysOfMonth"    # Ljava/util/BitSet;
    .param p3, "dayOfMonth"    # I
    .param p4, "daysOfWeek"    # Ljava/util/BitSet;
    .param p5, "dayOfWeek"    # I
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Calendar;",
            "Ljava/util/BitSet;",
            "I",
            "Ljava/util/BitSet;",
            "I",
            "Ljava/util/List",
            "<",
            "Ljava/lang/Integer;",
            ">;)I"
        }
    .end annotation

    .prologue
    .local p6, "resets":Ljava/util/List;, "Ljava/util/List<Ljava/lang/Integer;>;"
    const/4 v4, 0x5

    .line 173
    const/4 v0, 0x0

    .line 174
    .local v0, "count":I
    const/16 v2, 0x16e

    .line 177
    .local v2, "max":I
    :goto_0
    invoke-virtual {p2, p3}, Ljava/util/BitSet;->get(I)Z

    move-result v3

    if-eqz v3, :cond_0

    add-int/lit8 v3, p5, -0x1

    invoke-virtual {p4, v3}, Ljava/util/BitSet;->get(I)Z

    move-result v3

    if-nez v3, :cond_2

    :cond_0
    add-int/lit8 v1, v0, 0x1

    .end local v0    # "count":I
    .local v1, "count":I
    if-ge v0, v2, :cond_1

    .line 178
    const/4 v3, 0x1

    invoke-virtual {p1, v4, v3}, Ljava/util/Calendar;->add(II)V

    .line 179
    invoke-virtual {p1, v4}, Ljava/util/Calendar;->get(I)I

    move-result p3

    .line 180
    const/4 v3, 0x7

    invoke-virtual {p1, v3}, Ljava/util/Calendar;->get(I)I

    move-result p5

    .line 181
    invoke-direct {p0, p1, p6}, Lcom/eyugame/utils/CronSequenceGenerator;->reset(Ljava/util/Calendar;Ljava/util/List;)V

    move v0, v1

    .end local v1    # "count":I
    .restart local v0    # "count":I
    goto :goto_0

    .end local v0    # "count":I
    .restart local v1    # "count":I
    :cond_1
    move v0, v1

    .line 183
    .end local v1    # "count":I
    .restart local v0    # "count":I
    :cond_2
    if-lt v0, v2, :cond_3

    .line 184
    new-instance v3, Ljava/lang/IllegalStateException;

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "Overflow in day for expression="

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    iget-object v5, p0, Lcom/eyugame/utils/CronSequenceGenerator;->expression:Ljava/lang/String;

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-direct {v3, v4}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v3

    .line 186
    :cond_3
    return p3
.end method

.method private getRange(Ljava/lang/String;II)[I
    .locals 6
    .param p1, "field"    # Ljava/lang/String;
    .param p2, "min"    # I
    .param p3, "max"    # I

    .prologue
    const/4 v5, 0x2

    const/4 v4, 0x1

    const/4 v3, 0x0

    .line 317
    new-array v0, v5, [I

    .line 318
    .local v0, "result":[I
    const-string v2, "*"

    invoke-virtual {p1, v2}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_1

    .line 319
    aput p2, v0, v3

    .line 320
    add-int/lit8 v2, p3, -0x1

    aput v2, v0, v4

    .line 339
    :cond_0
    return-object v0

    .line 323
    :cond_1
    const-string v2, "-"

    invoke-virtual {p1, v2}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_3

    .line 324
    invoke-static {p1}, Ljava/lang/Integer;->valueOf(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/Integer;->intValue()I

    move-result v2

    aput v2, v0, v4

    aput v2, v0, v3

    .line 333
    :goto_0
    aget v2, v0, v3

    if-ge v2, p3, :cond_2

    aget v2, v0, v4

    if-lt v2, p3, :cond_5

    .line 334
    :cond_2
    new-instance v2, Ljava/lang/IllegalArgumentException;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Range exceeds maximum ("

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "): "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v2, v3}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v2

    .line 326
    :cond_3
    const-string v2, "-"

    invoke-static {p1, v2}, Lcom/eyugame/utils/StringUtils;->delimitedListToStringArray(Ljava/lang/String;Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v1

    .line 327
    .local v1, "split":[Ljava/lang/String;
    array-length v2, v1

    if-le v2, v5, :cond_4

    .line 328
    new-instance v2, Ljava/lang/IllegalArgumentException;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Range has more than two fields: "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v2, v3}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v2

    .line 330
    :cond_4
    aget-object v2, v1, v3

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/Integer;->intValue()I

    move-result v2

    aput v2, v0, v3

    .line 331
    aget-object v2, v1, v4

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/Integer;->intValue()I

    move-result v2

    aput v2, v0, v4

    goto :goto_0

    .line 336
    .end local v1    # "split":[Ljava/lang/String;
    :cond_5
    aget v2, v0, v3

    if-lt v2, p2, :cond_6

    aget v2, v0, v4

    if-ge v2, p2, :cond_0

    .line 337
    :cond_6
    new-instance v2, Ljava/lang/IllegalArgumentException;

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "Range less than minimum ("

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "): "

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v2, v3}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v2
.end method

.method private parse(Ljava/lang/String;)V
    .locals 8
    .param p1, "expression"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/IllegalArgumentException;
        }
    .end annotation

    .prologue
    const/16 v7, 0x3c

    const/4 v4, 0x7

    const/4 v3, 0x2

    const/4 v6, 0x1

    const/4 v5, 0x0

    .line 231
    const-string v1, " "

    invoke-static {p1, v1}, Lcom/eyugame/utils/StringUtils;->tokenizeToStringArray(Ljava/lang/String;Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v0

    .line 232
    .local v0, "fields":[Ljava/lang/String;
    array-length v1, v0

    const/4 v2, 0x6

    if-eq v1, v2, :cond_0

    .line 233
    new-instance v1, Ljava/lang/IllegalArgumentException;

    const-string v2, "cron expression must consist of 6 fields (found %d in %s)"

    new-array v3, v3, [Ljava/lang/Object;

    array-length v4, v0

    .line 234
    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    aput-object v4, v3, v5

    aput-object p1, v3, v6

    .line 233
    invoke-static {v2, v3}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, v2}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 236
    :cond_0
    iget-object v1, p0, Lcom/eyugame/utils/CronSequenceGenerator;->seconds:Ljava/util/BitSet;

    aget-object v2, v0, v5

    invoke-direct {p0, v1, v2, v5, v7}, Lcom/eyugame/utils/CronSequenceGenerator;->setNumberHits(Ljava/util/BitSet;Ljava/lang/String;II)V

    .line 237
    iget-object v1, p0, Lcom/eyugame/utils/CronSequenceGenerator;->minutes:Ljava/util/BitSet;

    aget-object v2, v0, v6

    invoke-direct {p0, v1, v2, v5, v7}, Lcom/eyugame/utils/CronSequenceGenerator;->setNumberHits(Ljava/util/BitSet;Ljava/lang/String;II)V

    .line 238
    iget-object v1, p0, Lcom/eyugame/utils/CronSequenceGenerator;->hours:Ljava/util/BitSet;

    aget-object v2, v0, v3

    const/16 v3, 0x18

    invoke-direct {p0, v1, v2, v5, v3}, Lcom/eyugame/utils/CronSequenceGenerator;->setNumberHits(Ljava/util/BitSet;Ljava/lang/String;II)V

    .line 239
    iget-object v1, p0, Lcom/eyugame/utils/CronSequenceGenerator;->daysOfMonth:Ljava/util/BitSet;

    const/4 v2, 0x3

    aget-object v2, v0, v2

    invoke-direct {p0, v1, v2}, Lcom/eyugame/utils/CronSequenceGenerator;->setDaysOfMonth(Ljava/util/BitSet;Ljava/lang/String;)V

    .line 240
    iget-object v1, p0, Lcom/eyugame/utils/CronSequenceGenerator;->months:Ljava/util/BitSet;

    const/4 v2, 0x4

    aget-object v2, v0, v2

    invoke-direct {p0, v1, v2}, Lcom/eyugame/utils/CronSequenceGenerator;->setMonths(Ljava/util/BitSet;Ljava/lang/String;)V

    .line 241
    iget-object v1, p0, Lcom/eyugame/utils/CronSequenceGenerator;->daysOfWeek:Ljava/util/BitSet;

    const/4 v2, 0x5

    aget-object v2, v0, v2

    const-string v3, "SUN,MON,TUE,WED,THU,FRI,SAT"

    invoke-direct {p0, v2, v3}, Lcom/eyugame/utils/CronSequenceGenerator;->replaceOrdinals(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    const/16 v3, 0x8

    invoke-direct {p0, v1, v2, v3}, Lcom/eyugame/utils/CronSequenceGenerator;->setDays(Ljava/util/BitSet;Ljava/lang/String;I)V

    .line 242
    iget-object v1, p0, Lcom/eyugame/utils/CronSequenceGenerator;->daysOfWeek:Ljava/util/BitSet;

    invoke-virtual {v1, v4}, Ljava/util/BitSet;->get(I)Z

    move-result v1

    if-eqz v1, :cond_1

    .line 244
    iget-object v1, p0, Lcom/eyugame/utils/CronSequenceGenerator;->daysOfWeek:Ljava/util/BitSet;

    invoke-virtual {v1, v5}, Ljava/util/BitSet;->set(I)V

    .line 245
    iget-object v1, p0, Lcom/eyugame/utils/CronSequenceGenerator;->daysOfWeek:Ljava/util/BitSet;

    invoke-virtual {v1, v4}, Ljava/util/BitSet;->clear(I)V

    .line 247
    :cond_1
    return-void
.end method

.method private replaceOrdinals(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;
    .locals 6
    .param p1, "value"    # Ljava/lang/String;
    .param p2, "commaSeparatedList"    # Ljava/lang/String;

    .prologue
    .line 255
    invoke-static {p2}, Lcom/eyugame/utils/StringUtils;->commaDelimitedListToStringArray(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v2

    .line 256
    .local v2, "list":[Ljava/lang/String;
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    array-length v3, v2

    if-ge v0, v3, :cond_0

    .line 257
    aget-object v3, v2, v0

    invoke-virtual {v3}, Ljava/lang/String;->toUpperCase()Ljava/lang/String;

    move-result-object v1

    .line 258
    .local v1, "item":Ljava/lang/String;
    invoke-virtual {p1}, Ljava/lang/String;->toUpperCase()Ljava/lang/String;

    move-result-object v3

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, ""

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-static {v3, v1, v4}, Lcom/eyugame/utils/StringUtils;->replace(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    .line 256
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 260
    .end local v1    # "item":Ljava/lang/String;
    :cond_0
    return-object p1
.end method

.method private reset(Ljava/util/Calendar;Ljava/util/List;)V
    .locals 3
    .param p1, "calendar"    # Ljava/util/Calendar;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Calendar;",
            "Ljava/util/List",
            "<",
            "Ljava/lang/Integer;",
            ">;)V"
        }
    .end annotation

    .prologue
    .line 220
    .local p2, "fields":Ljava/util/List;, "Ljava/util/List<Ljava/lang/Integer;>;"
    invoke-interface {p2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/Integer;

    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I

    move-result v0

    .line 221
    .local v0, "field":I
    const/4 v1, 0x5

    if-ne v0, v1, :cond_0

    const/4 v1, 0x1

    :goto_1
    invoke-virtual {p1, v0, v1}, Ljava/util/Calendar;->set(II)V

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    goto :goto_1

    .line 223
    .end local v0    # "field":I
    :cond_1
    return-void
.end method

.method private setDays(Ljava/util/BitSet;Ljava/lang/String;I)V
    .locals 1
    .param p1, "bits"    # Ljava/util/BitSet;
    .param p2, "field"    # Ljava/lang/String;
    .param p3, "max"    # I

    .prologue
    .line 272
    const-string v0, "?"

    invoke-virtual {p2, v0}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 273
    const-string p2, "*"

    .line 275
    :cond_0
    const/4 v0, 0x0

    invoke-direct {p0, p1, p2, v0, p3}, Lcom/eyugame/utils/CronSequenceGenerator;->setNumberHits(Ljava/util/BitSet;Ljava/lang/String;II)V

    .line 276
    return-void
.end method

.method private setDaysOfMonth(Ljava/util/BitSet;Ljava/lang/String;)V
    .locals 2
    .param p1, "bits"    # Ljava/util/BitSet;
    .param p2, "field"    # Ljava/lang/String;

    .prologue
    .line 264
    const/16 v0, 0x1f

    .line 266
    .local v0, "max":I
    const/16 v1, 0x20

    invoke-direct {p0, p1, p2, v1}, Lcom/eyugame/utils/CronSequenceGenerator;->setDays(Ljava/util/BitSet;Ljava/lang/String;I)V

    .line 268
    const/4 v1, 0x0

    invoke-virtual {p1, v1}, Ljava/util/BitSet;->clear(I)V

    .line 269
    return-void
.end method

.method private setMonths(Ljava/util/BitSet;Ljava/lang/String;)V
    .locals 5
    .param p1, "bits"    # Ljava/util/BitSet;
    .param p2, "value"    # Ljava/lang/String;

    .prologue
    const/16 v4, 0xd

    .line 279
    const/16 v1, 0xc

    .line 280
    .local v1, "max":I
    const-string v3, "FOO,JAN,FEB,MAR,APR,MAY,JUN,JUL,AUG,SEP,OCT,NOV,DEC"

    invoke-direct {p0, p2, v3}, Lcom/eyugame/utils/CronSequenceGenerator;->replaceOrdinals(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p2

    .line 281
    new-instance v2, Ljava/util/BitSet;

    invoke-direct {v2, v4}, Ljava/util/BitSet;-><init>(I)V

    .line 283
    .local v2, "months":Ljava/util/BitSet;
    const/4 v3, 0x1

    invoke-direct {p0, v2, p2, v3, v4}, Lcom/eyugame/utils/CronSequenceGenerator;->setNumberHits(Ljava/util/BitSet;Ljava/lang/String;II)V

    .line 285
    const/4 v0, 0x1

    .local v0, "i":I
    :goto_0
    if-gt v0, v1, :cond_1

    .line 286
    invoke-virtual {v2, v0}, Ljava/util/BitSet;->get(I)Z

    move-result v3

    if-eqz v3, :cond_0

    .line 287
    add-int/lit8 v3, v0, -0x1

    invoke-virtual {p1, v3}, Ljava/util/BitSet;->set(I)V

    .line 285
    :cond_0
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 290
    :cond_1
    return-void
.end method

.method private setNumberHits(Ljava/util/BitSet;Ljava/lang/String;II)V
    .locals 10
    .param p1, "bits"    # Ljava/util/BitSet;
    .param p2, "value"    # Ljava/lang/String;
    .param p3, "min"    # I
    .param p4, "max"    # I

    .prologue
    .line 293
    const-string v6, ","

    invoke-static {p2, v6}, Lcom/eyugame/utils/StringUtils;->delimitedListToStringArray(Ljava/lang/String;Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v2

    .line 294
    .local v2, "fields":[Ljava/lang/String;
    array-length v7, v2

    const/4 v6, 0x0

    :goto_0
    if-ge v6, v7, :cond_4

    aget-object v1, v2, v6

    .line 295
    .local v1, "field":Ljava/lang/String;
    const-string v8, "/"

    invoke-virtual {v1, v8}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v8

    if-nez v8, :cond_1

    .line 297
    invoke-direct {p0, v1, p3, p4}, Lcom/eyugame/utils/CronSequenceGenerator;->getRange(Ljava/lang/String;II)[I

    move-result-object v4

    .line 298
    .local v4, "range":[I
    const/4 v8, 0x0

    aget v8, v4, v8

    const/4 v9, 0x1

    aget v9, v4, v9

    add-int/lit8 v9, v9, 0x1

    invoke-virtual {p1, v8, v9}, Ljava/util/BitSet;->set(II)V

    .line 294
    :cond_0
    add-int/lit8 v6, v6, 0x1

    goto :goto_0

    .line 300
    .end local v4    # "range":[I
    :cond_1
    const-string v8, "/"

    invoke-static {v1, v8}, Lcom/eyugame/utils/StringUtils;->delimitedListToStringArray(Ljava/lang/String;Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v5

    .line 301
    .local v5, "split":[Ljava/lang/String;
    array-length v8, v5

    const/4 v9, 0x2

    if-le v8, v9, :cond_2

    .line 302
    new-instance v6, Ljava/lang/IllegalArgumentException;

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string v8, "Incrementer has more than two fields: "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    invoke-direct {v6, v7}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v6

    .line 304
    :cond_2
    const/4 v8, 0x0

    aget-object v8, v5, v8

    invoke-direct {p0, v8, p3, p4}, Lcom/eyugame/utils/CronSequenceGenerator;->getRange(Ljava/lang/String;II)[I

    move-result-object v4

    .line 305
    .restart local v4    # "range":[I
    const/4 v8, 0x0

    aget-object v8, v5, v8

    const-string v9, "-"

    invoke-virtual {v8, v9}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v8

    if-nez v8, :cond_3

    .line 306
    const/4 v8, 0x1

    add-int/lit8 v9, p4, -0x1

    aput v9, v4, v8

    .line 308
    :cond_3
    const/4 v8, 0x1

    aget-object v8, v5, v8

    invoke-static {v8}, Ljava/lang/Integer;->valueOf(Ljava/lang/String;)Ljava/lang/Integer;

    move-result-object v8

    invoke-virtual {v8}, Ljava/lang/Integer;->intValue()I

    move-result v0

    .line 309
    .local v0, "delta":I
    const/4 v8, 0x0

    aget v3, v4, v8

    .local v3, "i":I
    :goto_1
    const/4 v8, 0x1

    aget v8, v4, v8

    if-gt v3, v8, :cond_0

    .line 310
    invoke-virtual {p1, v3}, Ljava/util/BitSet;->set(I)V

    .line 309
    add-int/2addr v3, v0

    goto :goto_1

    .line 314
    .end local v0    # "delta":I
    .end local v1    # "field":Ljava/lang/String;
    .end local v3    # "i":I
    .end local v4    # "range":[I
    .end local v5    # "split":[Ljava/lang/String;
    :cond_4
    return-void
.end method


# virtual methods
.method public equals(Ljava/lang/Object;)Z
    .locals 4
    .param p1, "obj"    # Ljava/lang/Object;

    .prologue
    const/4 v1, 0x0

    .line 344
    instance-of v2, p1, Lcom/eyugame/utils/CronSequenceGenerator;

    if-nez v2, :cond_1

    .line 350
    :cond_0
    :goto_0
    return v1

    :cond_1
    move-object v0, p1

    .line 347
    check-cast v0, Lcom/eyugame/utils/CronSequenceGenerator;

    .line 348
    .local v0, "cron":Lcom/eyugame/utils/CronSequenceGenerator;
    iget-object v2, v0, Lcom/eyugame/utils/CronSequenceGenerator;->months:Ljava/util/BitSet;

    iget-object v3, p0, Lcom/eyugame/utils/CronSequenceGenerator;->months:Ljava/util/BitSet;

    invoke-virtual {v2, v3}, Ljava/util/BitSet;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_0

    iget-object v2, v0, Lcom/eyugame/utils/CronSequenceGenerator;->daysOfMonth:Ljava/util/BitSet;

    iget-object v3, p0, Lcom/eyugame/utils/CronSequenceGenerator;->daysOfMonth:Ljava/util/BitSet;

    invoke-virtual {v2, v3}, Ljava/util/BitSet;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_0

    iget-object v2, v0, Lcom/eyugame/utils/CronSequenceGenerator;->daysOfWeek:Ljava/util/BitSet;

    iget-object v3, p0, Lcom/eyugame/utils/CronSequenceGenerator;->daysOfWeek:Ljava/util/BitSet;

    .line 349
    invoke-virtual {v2, v3}, Ljava/util/BitSet;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_0

    iget-object v2, v0, Lcom/eyugame/utils/CronSequenceGenerator;->hours:Ljava/util/BitSet;

    iget-object v3, p0, Lcom/eyugame/utils/CronSequenceGenerator;->hours:Ljava/util/BitSet;

    invoke-virtual {v2, v3}, Ljava/util/BitSet;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_0

    iget-object v2, v0, Lcom/eyugame/utils/CronSequenceGenerator;->minutes:Ljava/util/BitSet;

    iget-object v3, p0, Lcom/eyugame/utils/CronSequenceGenerator;->minutes:Ljava/util/BitSet;

    .line 350
    invoke-virtual {v2, v3}, Ljava/util/BitSet;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_0

    iget-object v2, v0, Lcom/eyugame/utils/CronSequenceGenerator;->seconds:Ljava/util/BitSet;

    iget-object v3, p0, Lcom/eyugame/utils/CronSequenceGenerator;->seconds:Ljava/util/BitSet;

    invoke-virtual {v2, v3}, Ljava/util/BitSet;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_0

    const/4 v1, 0x1

    goto :goto_0
.end method

.method public hashCode()I
    .locals 2

    .prologue
    .line 355
    iget-object v0, p0, Lcom/eyugame/utils/CronSequenceGenerator;->months:Ljava/util/BitSet;

    invoke-virtual {v0}, Ljava/util/BitSet;->hashCode()I

    move-result v0

    mul-int/lit8 v0, v0, 0x11

    add-int/lit8 v0, v0, 0x25

    iget-object v1, p0, Lcom/eyugame/utils/CronSequenceGenerator;->daysOfMonth:Ljava/util/BitSet;

    invoke-virtual {v1}, Ljava/util/BitSet;->hashCode()I

    move-result v1

    mul-int/lit8 v1, v1, 0x1d

    add-int/2addr v0, v1

    iget-object v1, p0, Lcom/eyugame/utils/CronSequenceGenerator;->daysOfWeek:Ljava/util/BitSet;

    invoke-virtual {v1}, Ljava/util/BitSet;->hashCode()I

    move-result v1

    mul-int/lit8 v1, v1, 0x25

    add-int/2addr v0, v1

    iget-object v1, p0, Lcom/eyugame/utils/CronSequenceGenerator;->hours:Ljava/util/BitSet;

    .line 356
    invoke-virtual {v1}, Ljava/util/BitSet;->hashCode()I

    move-result v1

    mul-int/lit8 v1, v1, 0x29

    add-int/2addr v0, v1

    iget-object v1, p0, Lcom/eyugame/utils/CronSequenceGenerator;->minutes:Ljava/util/BitSet;

    invoke-virtual {v1}, Ljava/util/BitSet;->hashCode()I

    move-result v1

    mul-int/lit8 v1, v1, 0x35

    add-int/2addr v0, v1

    iget-object v1, p0, Lcom/eyugame/utils/CronSequenceGenerator;->seconds:Ljava/util/BitSet;

    invoke-virtual {v1}, Ljava/util/BitSet;->hashCode()I

    move-result v1

    mul-int/lit8 v1, v1, 0x3d

    add-int/2addr v0, v1

    return v0
.end method

.method public next(Ljava/util/Date;)Ljava/util/Date;
    .locals 4
    .param p1, "date"    # Ljava/util/Date;

    .prologue
    const/4 v3, 0x1

    .line 111
    new-instance v0, Ljava/util/GregorianCalendar;

    invoke-direct {v0}, Ljava/util/GregorianCalendar;-><init>()V

    .line 112
    .local v0, "calendar":Ljava/util/Calendar;
    iget-object v1, p0, Lcom/eyugame/utils/CronSequenceGenerator;->timeZone:Ljava/util/TimeZone;

    invoke-virtual {v0, v1}, Ljava/util/Calendar;->setTimeZone(Ljava/util/TimeZone;)V

    .line 113
    invoke-virtual {v0, p1}, Ljava/util/Calendar;->setTime(Ljava/util/Date;)V

    .line 116
    const/16 v1, 0xd

    invoke-virtual {v0, v1, v3}, Ljava/util/Calendar;->add(II)V

    .line 117
    const/16 v1, 0xe

    const/4 v2, 0x0

    invoke-virtual {v0, v1, v2}, Ljava/util/Calendar;->set(II)V

    .line 119
    invoke-virtual {v0, v3}, Ljava/util/Calendar;->get(I)I

    move-result v1

    invoke-direct {p0, v0, v1}, Lcom/eyugame/utils/CronSequenceGenerator;->doNext(Ljava/util/Calendar;I)V

    .line 121
    invoke-virtual {v0}, Ljava/util/Calendar;->getTime()Ljava/util/Date;

    move-result-object v1

    return-object v1
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    .prologue
    .line 361
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ": "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/eyugame/utils/CronSequenceGenerator;->expression:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
