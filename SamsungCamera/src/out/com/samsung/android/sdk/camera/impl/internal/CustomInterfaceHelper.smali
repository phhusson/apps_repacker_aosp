.class public Lcom/samsung/android/sdk/camera/impl/internal/CustomInterfaceHelper;
.super Ljava/lang/Object;
.source "CustomInterfaceHelper.java"


# static fields
.field private static final TAG:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .registers 1

    .line 13
    const-class v0, Lcom/samsung/android/sdk/camera/impl/internal/CustomInterfaceHelper;

    invoke-virtual {v0}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/samsung/android/sdk/camera/impl/internal/CustomInterfaceHelper;->TAG:Ljava/lang/String;

    return-void
.end method

.method protected constructor <init>()V
    .registers 1

    .line 15
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 16
    return-void
.end method

.method public static createOutputConfiguration(ILandroid/view/Surface;II)Landroid/hardware/camera2/params/OutputConfiguration;
    .registers 7

    .line 26
    const-string v0, "PHH"

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "createOutputConfiguration w/ option "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p3

    invoke-static {v0, p3}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 27
    new-instance p3, Landroid/hardware/camera2/params/OutputConfiguration;

    invoke-direct {p3, p0, p1, p2}, Landroid/hardware/camera2/params/OutputConfiguration;-><init>(ILandroid/view/Surface;I)V

    return-object p3
.end method

.method public static getAvailableSamsungKeyList(Landroid/hardware/camera2/CameraCharacteristics;Ljava/lang/Class;Ljava/lang/Class;Landroid/hardware/camera2/CameraCharacteristics$Key;)Ljava/util/List;
    .registers 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<TKey:",
            "Ljava/lang/Object;",
            ">(",
            "Landroid/hardware/camera2/CameraCharacteristics;",
            "Ljava/lang/Class<",
            "*>;",
            "Ljava/lang/Class<",
            "TTKey;>;",
            "Landroid/hardware/camera2/CameraCharacteristics$Key<",
            "[I>;)",
            "Ljava/util/List<",
            "TTKey;>;"
        }
    .end annotation

    .line 32
    const-string p0, "PHH"

    const-string p1, "getAvailableSamsungKeyList"

    invoke-static {p0, p1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 33
    new-instance p0, Ljava/util/ArrayList;

    invoke-direct {p0}, Ljava/util/ArrayList;-><init>()V

    return-object p0
.end method

.method public static setSamsungParameter(Landroid/hardware/camera2/CameraDevice;Ljava/lang/String;)V
    .registers 4
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Landroid/hardware/camera2/CameraAccessException;
        }
    .end annotation

    .line 19
    if-eqz p0, :cond_18

    .line 20
    const-string p0, "PHH"

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "setSamsungParameter "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-static {p0, p1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 23
    :cond_18
    return-void
.end method
