.class public Lcom/samsung/android/sdk/camera/impl/internal/KeyMaker;
.super Ljava/lang/Object;
.source "KeyMaker.java"


# static fields
.field private static final KEY_CAPTURE_REQUEST:I = 0x1

.field private static final KEY_CAPTURE_RESULT:I = 0x2

.field private static final KEY_CHARACTERISTIC:I


# direct methods
.method private constructor <init>()V
    .registers 1

    .line 14
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 15
    return-void
.end method

.method public static varargs createKey(I[Ljava/lang/Object;)Ljava/lang/Object;
    .registers 4
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(I[",
            "Ljava/lang/Object;",
            ")",
            "Ljava/lang/Object;"
        }
    .end annotation

    .line 18
    if-eqz p1, :cond_3c

    array-length p0, p1

    const/4 v0, 0x3

    if-lt p0, v0, :cond_3c

    .line 21
    const/4 p0, 0x0

    aget-object p0, p1, p0

    check-cast p0, Ljava/lang/String;

    .line 22
    const/4 v0, 0x1

    aget-object v0, p1, v0

    check-cast v0, Ljava/lang/reflect/Type;

    .line 23
    const/4 v1, 0x2

    aget-object p1, p1, v1

    check-cast p1, Ljava/lang/Integer;

    invoke-virtual {p1}, Ljava/lang/Integer;->intValue()I

    move-result p1

    packed-switch p1, :pswitch_data_44

    .line 31
    const/4 p0, 0x0

    return-object p0

    .line 29
    :pswitch_1e
    new-instance p1, Landroid/hardware/camera2/CaptureResult$Key;

    invoke-static {v0}, Landroid/hardware/camera2/utils/TypeReference;->createSpecializedTypeReference(Ljava/lang/reflect/Type;)Landroid/hardware/camera2/utils/TypeReference;

    move-result-object v0

    invoke-direct {p1, p0, v0}, Landroid/hardware/camera2/CaptureResult$Key;-><init>(Ljava/lang/String;Landroid/hardware/camera2/utils/TypeReference;)V

    return-object p1

    .line 27
    :pswitch_28
    new-instance p1, Landroid/hardware/camera2/CaptureRequest$Key;

    invoke-static {v0}, Landroid/hardware/camera2/utils/TypeReference;->createSpecializedTypeReference(Ljava/lang/reflect/Type;)Landroid/hardware/camera2/utils/TypeReference;

    move-result-object v0

    invoke-direct {p1, p0, v0}, Landroid/hardware/camera2/CaptureRequest$Key;-><init>(Ljava/lang/String;Landroid/hardware/camera2/utils/TypeReference;)V

    return-object p1

    .line 25
    :pswitch_32
    new-instance p1, Landroid/hardware/camera2/CameraCharacteristics$Key;

    invoke-static {v0}, Landroid/hardware/camera2/utils/TypeReference;->createSpecializedTypeReference(Ljava/lang/reflect/Type;)Landroid/hardware/camera2/utils/TypeReference;

    move-result-object v0

    invoke-direct {p1, p0, v0}, Landroid/hardware/camera2/CameraCharacteristics$Key;-><init>(Ljava/lang/String;Landroid/hardware/camera2/utils/TypeReference;)V

    return-object p1

    .line 19
    :cond_3c
    new-instance p0, Ljava/lang/RuntimeException;

    const-string p1, "Illegal arguments to createKey"

    invoke-direct {p0, p1}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw p0

    :pswitch_data_44
    .packed-switch 0x0
        :pswitch_32
        :pswitch_28
        :pswitch_1e
    .end packed-switch
.end method

.method public static varargs isKeyExist(I[Ljava/lang/Object;)Z
    .registers 4

    .line 36
    if-eqz p1, :cond_36

    const/4 p0, 0x1

    array-length v0, p1

    if-lt v0, p0, :cond_36

    .line 39
    const/4 v0, 0x0

    aget-object p1, p1, v0

    .line 41
    :try_start_9
    instance-of v1, p1, Landroid/hardware/camera2/CameraCharacteristics$Key;

    if-eqz v1, :cond_17

    .line 42
    check-cast p1, Landroid/hardware/camera2/CameraCharacteristics$Key;

    invoke-virtual {p1}, Landroid/hardware/camera2/CameraCharacteristics$Key;->getNativeKey()Landroid/hardware/camera2/impl/CameraMetadataNative$Key;

    move-result-object p1

    invoke-virtual {p1}, Landroid/hardware/camera2/impl/CameraMetadataNative$Key;->getTag()I

    .line 43
    return p0

    .line 44
    :cond_17
    instance-of v1, p1, Landroid/hardware/camera2/CaptureResult$Key;

    if-eqz v1, :cond_25

    .line 45
    check-cast p1, Landroid/hardware/camera2/CaptureResult$Key;

    invoke-virtual {p1}, Landroid/hardware/camera2/CaptureResult$Key;->getNativeKey()Landroid/hardware/camera2/impl/CameraMetadataNative$Key;

    move-result-object p1

    invoke-virtual {p1}, Landroid/hardware/camera2/impl/CameraMetadataNative$Key;->getTag()I

    .line 46
    return p0

    .line 47
    :cond_25
    instance-of v1, p1, Landroid/hardware/camera2/CaptureRequest$Key;

    if-nez v1, :cond_2a

    .line 48
    return v0

    .line 50
    :cond_2a
    check-cast p1, Landroid/hardware/camera2/CaptureRequest$Key;

    invoke-virtual {p1}, Landroid/hardware/camera2/CaptureRequest$Key;->getNativeKey()Landroid/hardware/camera2/impl/CameraMetadataNative$Key;

    move-result-object p1

    invoke-virtual {p1}, Landroid/hardware/camera2/impl/CameraMetadataNative$Key;->getTag()I
    :try_end_33
    .catch Ljava/lang/Exception; {:try_start_9 .. :try_end_33} :catch_34

    .line 51
    return p0

    .line 53
    :catch_34
    move-exception p0

    .line 55
    return v0

    .line 37
    :cond_36
    new-instance p0, Ljava/lang/RuntimeException;

    const-string p1, "Illegal arguments to isKeyExist"

    invoke-direct {p0, p1}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw p0
.end method
