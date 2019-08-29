.class public Lcom/samsung/android/sdk/camera/impl/internal/ImageHelper;
.super Ljava/lang/Object;
.source "ImageHelper.java"


# static fields
.field private static final TAG:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .registers 1

    .line 6
    const-class v0, Lcom/samsung/android/sdk/camera/impl/internal/ProcessorImageImpl;

    invoke-virtual {v0}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/samsung/android/sdk/camera/impl/internal/ImageHelper;->TAG:Ljava/lang/String;

    return-void
.end method

.method protected constructor <init>()V
    .registers 1

    .line 8
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 9
    return-void
.end method

.method public static getTransform(Landroid/media/Image;)I
    .registers 1

    .line 12
    invoke-virtual {p0}, Landroid/media/Image;->getTransform()I

    move-result p0

    return p0
.end method
