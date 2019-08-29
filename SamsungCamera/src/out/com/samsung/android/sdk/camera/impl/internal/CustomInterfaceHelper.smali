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
    .registers 13
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
    const-string v0, "PHH"

    const-string v1, "getAvailableSamsungKeyList"

    invoke-static {v0, v1}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 34
    const/4 v0, 0x0

    :try_start_8
    invoke-virtual {p0, p3}, Landroid/hardware/camera2/CameraCharacteristics;->get(Landroid/hardware/camera2/CameraCharacteristics$Key;)Ljava/lang/Object;

    move-result-object p3

    check-cast p3, [I

    check-cast p3, [I

    .line 35
    if-nez p3, :cond_13

    .line 36
    return-object v0

    .line 39
    :cond_13
    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v1

    const-string v2, "getAvailableKeyList"

    const/4 v3, 0x3

    new-array v4, v3, [Ljava/lang/Class;

    const-class v5, Ljava/lang/Class;

    const/4 v6, 0x0

    aput-object v5, v4, v6

    const-class v5, Ljava/lang/Class;

    const/4 v7, 0x1

    aput-object v5, v4, v7

    const-class v5, Ljava/lang/Class;

    const/4 v8, 0x2

    aput-object v5, v4, v8

    invoke-virtual {v1, v2, v4}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    .line 40
    invoke-virtual {v1, v7}, Ljava/lang/reflect/Method;->setAccessible(Z)V

    .line 41
    new-array v2, v3, [Ljava/lang/Object;

    aput-object p1, v2, v6

    aput-object p2, v2, v7

    aput-object p3, v2, v8

    invoke-virtual {v1, p0, v2}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Ljava/util/List;
    :try_end_40
    .catch Ljava/lang/Exception; {:try_start_8 .. :try_end_40} :catch_41

    return-object p0

    .line 42
    :catch_41
    move-exception p0

    .line 43
    const-string p1, "PHH"

    const-string p2, "Failed"

    invoke-static {p1, p2, p0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    .line 44
    return-object v0
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
