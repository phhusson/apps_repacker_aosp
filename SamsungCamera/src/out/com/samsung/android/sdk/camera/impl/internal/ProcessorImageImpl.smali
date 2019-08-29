.class public Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl;
.super Landroid/media/Image;
.source "ProcessorImageImpl.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl$ImagePlane;
    }
.end annotation


# static fields
.field private static final NUM_OF_PLANE_FOR_JPEG:I = 0x1

.field private static final NUM_OF_PLANE_FOR_YUV:I = 0x3

.field private static final NV21_UV_PIXEL_STRIDE:I = 0x2

.field private static final NV21_Y_PIXEL_STRIDE:I = 0x1

.field private static final TAG:Ljava/lang/String;


# instance fields
.field private METHOD_RELEASE:Ljava/lang/reflect/Method;

.field private mBuffer:Ljava/nio/ByteBuffer;

.field private final mFormat:I

.field private final mHeight:I

.field private mPlanes:[Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl$ImagePlane;

.field private final mShared:Z

.field private mTimeStamp:J

.field private mTransform:I

.field private final mWidth:I


# direct methods
.method static constructor <clinit>()V
    .registers 1

    .line 14
    const-class v0, Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl;

    invoke-virtual {v0}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl;->TAG:Ljava/lang/String;

    return-void
.end method

.method public varargs constructor <init>(I[Ljava/lang/Object;)V
    .registers 15

    .line 61
    invoke-direct {p0}, Landroid/media/Image;-><init>()V

    .line 62
    nop

    .line 63
    if-eqz p2, :cond_d0

    array-length v1, p2

    const/4 v2, 0x6

    if-lt v1, v2, :cond_d0

    .line 67
    const/4 v6, 0x0

    aget-object v1, p2, v6

    check-cast v1, Ljava/nio/ByteBuffer;

    .line 68
    const/4 v7, 0x1

    aget-object v2, p2, v7

    check-cast v2, Ljava/lang/Integer;

    invoke-virtual {v2}, Ljava/lang/Integer;->intValue()I

    move-result v2

    .line 69
    const/4 v8, 0x2

    aget-object v3, p2, v8

    check-cast v3, Ljava/lang/Integer;

    invoke-virtual {v3}, Ljava/lang/Integer;->intValue()I

    move-result v3

    .line 70
    const/4 v4, 0x3

    aget-object v5, p2, v4

    check-cast v5, Ljava/lang/Integer;

    invoke-virtual {v5}, Ljava/lang/Integer;->intValue()I

    move-result v5

    .line 71
    const/4 v9, 0x5

    aget-object v9, p2, v9

    check-cast v9, Ljava/lang/reflect/Method;

    .line 72
    const/4 v10, 0x4

    aget-object v0, p2, v10

    check-cast v0, Ljava/lang/Boolean;

    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    iput-boolean v0, p0, Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl;->mShared:Z

    .line 73
    iput-object v1, p0, Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl;->mBuffer:Ljava/nio/ByteBuffer;

    .line 74
    iput v2, p0, Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl;->mFormat:I

    .line 75
    iput v3, p0, Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl;->mWidth:I

    .line 76
    iput v5, p0, Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl;->mHeight:I

    .line 77
    iget v0, p0, Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl;->mFormat:I

    const/16 v1, 0x100

    if-ne v0, v1, :cond_62

    .line 78
    new-array v0, v7, [Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl$ImagePlane;

    iput-object v0, p0, Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl;->mPlanes:[Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl$ImagePlane;

    .line 79
    nop

    .line 80
    iget-object v8, p0, Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl;->mPlanes:[Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl$ImagePlane;

    new-instance v10, Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl$ImagePlane;

    iget-object v0, p0, Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl;->mBuffer:Ljava/nio/ByteBuffer;

    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->slice()Ljava/nio/ByteBuffer;

    move-result-object v3

    const/4 v4, 0x0

    const/4 v5, 0x0

    move-object v0, v10

    move-object v1, p0

    move-object v2, p0

    invoke-direct/range {v0 .. v5}, Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl$ImagePlane;-><init>(Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl;Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl;Ljava/nio/ByteBuffer;II)V

    aput-object v10, v8, v6

    goto :goto_c5

    .line 82
    :cond_62
    nop

    .line 83
    iget v0, p0, Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl;->mFormat:I

    const/16 v1, 0x23

    if-ne v0, v1, :cond_c5

    .line 84
    new-array v0, v4, [Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl$ImagePlane;

    iput-object v0, p0, Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl;->mPlanes:[Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl$ImagePlane;

    .line 85
    iget-object v10, p0, Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl;->mPlanes:[Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl$ImagePlane;

    new-instance v11, Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl$ImagePlane;

    iget-object v0, p0, Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl;->mBuffer:Ljava/nio/ByteBuffer;

    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->slice()Ljava/nio/ByteBuffer;

    move-result-object v3

    iget v4, p0, Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl;->mWidth:I

    const/4 v5, 0x1

    move-object v0, v11

    move-object v1, p0

    move-object v2, p0

    invoke-direct/range {v0 .. v5}, Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl$ImagePlane;-><init>(Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl;Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl;Ljava/nio/ByteBuffer;II)V

    aput-object v11, v10, v6

    .line 86
    iget-object v0, p0, Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl;->mBuffer:Ljava/nio/ByteBuffer;

    iget v1, p0, Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl;->mWidth:I

    iget v2, p0, Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl;->mHeight:I

    mul-int/2addr v1, v2

    invoke-virtual {v0, v1}, Ljava/nio/ByteBuffer;->position(I)Ljava/nio/Buffer;

    .line 87
    iget-object v6, p0, Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl;->mPlanes:[Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl$ImagePlane;

    new-instance v10, Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl$ImagePlane;

    iget-object v0, p0, Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl;->mBuffer:Ljava/nio/ByteBuffer;

    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->slice()Ljava/nio/ByteBuffer;

    move-result-object v3

    iget v4, p0, Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl;->mWidth:I

    const/4 v5, 0x2

    move-object v0, v10

    move-object v1, p0

    move-object v2, p0

    invoke-direct/range {v0 .. v5}, Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl$ImagePlane;-><init>(Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl;Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl;Ljava/nio/ByteBuffer;II)V

    aput-object v10, v6, v7

    .line 88
    iget-object v0, p0, Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl;->mBuffer:Ljava/nio/ByteBuffer;

    iget v1, p0, Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl;->mWidth:I

    iget v2, p0, Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl;->mHeight:I

    mul-int/2addr v1, v2

    add-int/2addr v1, v7

    invoke-virtual {v0, v1}, Ljava/nio/ByteBuffer;->position(I)Ljava/nio/Buffer;

    .line 89
    iget-object v6, p0, Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl;->mPlanes:[Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl$ImagePlane;

    new-instance v10, Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl$ImagePlane;

    iget-object v0, p0, Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl;->mBuffer:Ljava/nio/ByteBuffer;

    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->slice()Ljava/nio/ByteBuffer;

    move-result-object v3

    iget v4, p0, Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl;->mWidth:I

    move-object v0, v10

    move-object v1, p0

    move-object v2, p0

    invoke-direct/range {v0 .. v5}, Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl$ImagePlane;-><init>(Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl;Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl;Ljava/nio/ByteBuffer;II)V

    aput-object v10, v6, v8

    .line 90
    iget-object v0, p0, Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl;->mBuffer:Ljava/nio/ByteBuffer;

    invoke-virtual {v0}, Ljava/nio/ByteBuffer;->rewind()Ljava/nio/Buffer;

    .line 93
    :cond_c5
    :goto_c5
    iput-object v9, p0, Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl;->METHOD_RELEASE:Ljava/lang/reflect/Method;

    .line 94
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtimeNanos()J

    move-result-wide v0

    iput-wide v0, p0, Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl;->mTimeStamp:J

    .line 95
    iput-boolean v7, p0, Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl;->mIsImageValid:Z

    .line 96
    return-void

    .line 64
    :cond_d0
    new-instance v0, Ljava/lang/RuntimeException;

    const-string v1, "Illegal arguments to Image constructor"

    invoke-direct {v0, v1}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method static synthetic access$000(Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl;)V
    .registers 1

    .line 9
    invoke-virtual {p0}, Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl;->throwISEIfImageIsInvalid()V

    return-void
.end method

.method static synthetic access$100(Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl;)V
    .registers 1

    .line 9
    invoke-virtual {p0}, Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl;->throwISEIfImageIsInvalid()V

    return-void
.end method

.method static synthetic access$200(Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl;)V
    .registers 1

    .line 9
    invoke-virtual {p0}, Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl;->throwISEIfImageIsInvalid()V

    return-void
.end method


# virtual methods
.method public close()V
    .registers 3

    .line 147
    new-instance v0, Ljava/lang/UnsupportedOperationException;

    const-string v1, "Method not decompiled: com.samsung.android.sdk.camera.impl.internal.ProcessorImageImpl.close():void"

    invoke-direct {v0, v1}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method protected final finalize()V
    .registers 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Throwable;
        }
    .end annotation

    .line 192
    :try_start_0
    invoke-virtual {p0}, Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl;->close()V
    :try_end_3
    .catchall {:try_start_0 .. :try_end_3} :catchall_8

    .line 194
    invoke-super {p0}, Ljava/lang/Object;->finalize()V

    .line 195
    nop

    .line 196
    return-void

    .line 194
    :catchall_8
    move-exception v0

    invoke-super {p0}, Ljava/lang/Object;->finalize()V

    .line 195
    throw v0
.end method

.method public getFormat()I
    .registers 2

    .line 151
    invoke-virtual {p0}, Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl;->throwISEIfImageIsInvalid()V

    .line 152
    iget v0, p0, Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl;->mFormat:I

    return v0
.end method

.method public getHeight()I
    .registers 2

    .line 161
    invoke-virtual {p0}, Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl;->throwISEIfImageIsInvalid()V

    .line 162
    iget v0, p0, Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl;->mHeight:I

    return v0
.end method

.method public getPlanes()[Landroid/media/Image$Plane;
    .registers 2

    .line 166
    invoke-virtual {p0}, Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl;->throwISEIfImageIsInvalid()V

    .line 167
    iget-object v0, p0, Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl;->mPlanes:[Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl$ImagePlane;

    return-object v0
.end method

.method public getScalingMode()I
    .registers 2

    .line 181
    invoke-virtual {p0}, Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl;->throwISEIfImageIsInvalid()V

    .line 182
    const/4 v0, 0x0

    return v0
.end method

.method public getTimestamp()J
    .registers 3

    .line 171
    invoke-virtual {p0}, Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl;->throwISEIfImageIsInvalid()V

    .line 172
    iget-wide v0, p0, Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl;->mTimeStamp:J

    return-wide v0
.end method

.method public getTransform()I
    .registers 2

    .line 176
    invoke-virtual {p0}, Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl;->throwISEIfImageIsInvalid()V

    .line 177
    iget v0, p0, Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl;->mTransform:I

    return v0
.end method

.method public getWidth()I
    .registers 2

    .line 156
    invoke-virtual {p0}, Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl;->throwISEIfImageIsInvalid()V

    .line 157
    iget v0, p0, Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl;->mWidth:I

    return v0
.end method

.method public setTimestamp(J)V
    .registers 3

    .line 186
    invoke-virtual {p0}, Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl;->throwISEIfImageIsInvalid()V

    .line 187
    iput-wide p1, p0, Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl;->mTimeStamp:J

    .line 188
    return-void
.end method
