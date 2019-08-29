.class Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl$ImagePlane;
.super Landroid/media/Image$Plane;
.source "ProcessorImageImpl.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "ImagePlane"
.end annotation


# instance fields
.field private mBuffer:Ljava/nio/ByteBuffer;

.field private mImage:Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl;

.field private mPixelStride:I

.field private mRowStride:I

.field final synthetic this$0:Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl;


# direct methods
.method public constructor <init>(Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl;Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl;Ljava/nio/ByteBuffer;II)V
    .registers 6

    .line 31
    iput-object p1, p0, Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl$ImagePlane;->this$0:Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl;

    invoke-direct {p0}, Landroid/media/Image$Plane;-><init>()V

    .line 32
    iput-object p2, p0, Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl$ImagePlane;->mImage:Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl;

    .line 33
    iput-object p3, p0, Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl$ImagePlane;->mBuffer:Ljava/nio/ByteBuffer;

    .line 34
    iput p4, p0, Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl$ImagePlane;->mRowStride:I

    .line 35
    iput p5, p0, Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl$ImagePlane;->mPixelStride:I

    .line 36
    return-void
.end method

.method private clear()V
    .registers 2

    .line 39
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl$ImagePlane;->mImage:Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl;

    .line 40
    iput-object v0, p0, Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl$ImagePlane;->mBuffer:Ljava/nio/ByteBuffer;

    .line 41
    const/4 v0, 0x0

    iput v0, p0, Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl$ImagePlane;->mRowStride:I

    .line 42
    iput v0, p0, Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl$ImagePlane;->mPixelStride:I

    .line 43
    return-void
.end method


# virtual methods
.method public getBuffer()Ljava/nio/ByteBuffer;
    .registers 2

    .line 46
    iget-object v0, p0, Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl$ImagePlane;->this$0:Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl;

    # invokes: Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl;->throwISEIfImageIsInvalid()V
    invoke-static {v0}, Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl;->access$000(Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl;)V

    .line 47
    iget-object v0, p0, Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl$ImagePlane;->mBuffer:Ljava/nio/ByteBuffer;

    return-object v0
.end method

.method public getPixelStride()I
    .registers 2

    .line 56
    iget-object v0, p0, Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl$ImagePlane;->this$0:Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl;

    # invokes: Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl;->throwISEIfImageIsInvalid()V
    invoke-static {v0}, Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl;->access$200(Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl;)V

    .line 57
    iget v0, p0, Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl$ImagePlane;->mPixelStride:I

    return v0
.end method

.method public getRowStride()I
    .registers 2

    .line 51
    iget-object v0, p0, Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl$ImagePlane;->this$0:Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl;

    # invokes: Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl;->throwISEIfImageIsInvalid()V
    invoke-static {v0}, Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl;->access$100(Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl;)V

    .line 52
    iget v0, p0, Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl$ImagePlane;->mRowStride:I

    return v0
.end method
