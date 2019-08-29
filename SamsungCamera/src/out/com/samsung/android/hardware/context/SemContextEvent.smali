.class public Lcom/samsung/android/hardware/context/SemContextEvent;
.super Ljava/lang/Object;
.source "SemContextEvent.java"

# interfaces
.implements Landroid/os/Parcelable;


# static fields
.field static final CREATOR:Landroid/os/Parcelable$Creator;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/os/Parcelable$Creator<",
            "Lcom/samsung/android/hardware/context/SemContextEvent;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field public context:Landroid/os/Bundle;

.field public timestamp:J


# direct methods
.method static constructor <clinit>()V
    .registers 1

    .line 9
    new-instance v0, Lcom/samsung/android/hardware/context/SemContextEvent$1;

    invoke-direct {v0}, Lcom/samsung/android/hardware/context/SemContextEvent$1;-><init>()V

    sput-object v0, Lcom/samsung/android/hardware/context/SemContextEvent;->CREATOR:Landroid/os/Parcelable$Creator;

    return-void
.end method

.method public constructor <init>()V
    .registers 3

    .line 23
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 25
    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lcom/samsung/android/hardware/context/SemContextEvent;->timestamp:J

    .line 26
    return-void
.end method

.method public constructor <init>(Landroid/os/Parcel;)V
    .registers 2

    .line 28
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 29
    invoke-direct {p0, p1}, Lcom/samsung/android/hardware/context/SemContextEvent;->readFromParcel(Landroid/os/Parcel;)V

    .line 30
    return-void
.end method

.method private readFromParcel(Landroid/os/Parcel;)V
    .registers 2

    .line 407
    return-void
.end method


# virtual methods
.method public describeContents()I
    .registers 2

    .line 388
    const/4 v0, 0x0

    return v0
.end method

.method public writeToParcel(Landroid/os/Parcel;I)V
    .registers 3

    .line 398
    return-void
.end method
