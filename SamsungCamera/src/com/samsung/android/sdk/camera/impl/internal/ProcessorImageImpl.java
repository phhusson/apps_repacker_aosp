package com.samsung.android.sdk.camera.impl.internal;

import android.media.Image;
import android.media.Image.Plane;
import android.os.SystemClock;
import java.lang.reflect.Method;
import java.nio.ByteBuffer;

public class ProcessorImageImpl extends Image {
    private static final int NUM_OF_PLANE_FOR_JPEG = 1;
    private static final int NUM_OF_PLANE_FOR_YUV = 3;
    private static final int NV21_UV_PIXEL_STRIDE = 2;
    private static final int NV21_Y_PIXEL_STRIDE = 1;
    private static final String TAG = ProcessorImageImpl.class.getSimpleName();
    private Method METHOD_RELEASE;
    private ByteBuffer mBuffer;
    private final int mFormat;
    private final int mHeight;
    private ImagePlane[] mPlanes;
    private final boolean mShared;
    private long mTimeStamp;
    private int mTransform;
    private final int mWidth;

    private class ImagePlane extends Plane {
        private ByteBuffer mBuffer;
        private ProcessorImageImpl mImage;
        private int mPixelStride;
        private int mRowStride;

        public ImagePlane(ProcessorImageImpl image, ByteBuffer buffer, int rowStride, int pixelStride) {
            this.mImage = image;
            this.mBuffer = buffer;
            this.mRowStride = rowStride;
            this.mPixelStride = pixelStride;
        }

        private void clear() {
            this.mImage = null;
            this.mBuffer = null;
            this.mRowStride = 0;
            this.mPixelStride = 0;
        }

        public ByteBuffer getBuffer() {
            ProcessorImageImpl.this.throwISEIfImageIsInvalid();
            return this.mBuffer;
        }

        public int getRowStride() {
            ProcessorImageImpl.this.throwISEIfImageIsInvalid();
            return this.mRowStride;
        }

        public int getPixelStride() {
            ProcessorImageImpl.this.throwISEIfImageIsInvalid();
            return this.mPixelStride;
        }
    }

    public ProcessorImageImpl(int version_code, Object... args) {
        Object[] objArr = args;
        if (objArr == null || objArr.length < 6) {
            throw new RuntimeException("Illegal arguments to Image constructor");
        }
        Method release;
        ByteBuffer buffer = (ByteBuffer)objArr[0];
        int format = ((Integer) objArr[1]).intValue();
        int width = ((Integer) objArr[2]).intValue();
        int height = ((Integer) objArr[3]).intValue();
        Method release2 = (Method)objArr[5];
        this.mShared = ((Boolean) objArr[4]).booleanValue();
        this.mBuffer = buffer;
        this.mFormat = format;
        this.mWidth = width;
        this.mHeight = height;
        if (this.mFormat == 256) {
            this.mPlanes = new ImagePlane[1];
            release = release2;
            this.mPlanes[0] = new ImagePlane(this, this.mBuffer.slice(), 0, 0);
        } else {
            release = release2;
            if (this.mFormat == 35) {
                this.mPlanes = new ImagePlane[3];
                this.mPlanes[0] = new ImagePlane(this, this.mBuffer.slice(), this.mWidth, 1);
                this.mBuffer.position(this.mWidth * this.mHeight);
                this.mPlanes[1] = new ImagePlane(this, this.mBuffer.slice(), this.mWidth, 2);
                this.mBuffer.position((this.mWidth * this.mHeight) + 1);
                this.mPlanes[2] = new ImagePlane(this, this.mBuffer.slice(), this.mWidth, 2);
                this.mBuffer.rewind();
            }
        }
        this.METHOD_RELEASE = release;
        this.mTimeStamp = SystemClock.elapsedRealtimeNanos();
        this.mIsImageValid = true;
    }

    /* JADX WARNING: Removed duplicated region for block: B:9:0x0027 A:{Splitter: B:7:0x001a, ExcHandler: java.lang.IllegalAccessException (r1_3 'e' java.lang.Exception)} */
    /* JADX WARNING: Removed duplicated region for block: B:9:0x0027 A:{Splitter: B:7:0x001a, ExcHandler: java.lang.IllegalAccessException (r1_3 'e' java.lang.Exception)} */
    /* JADX WARNING: Missing block: B:9:0x0027, code:
            r1 = move-exception;
     */
    /* JADX WARNING: Missing block: B:10:0x0028, code:
            android.util.Log.e(TAG, "Fail to release native heap.", r1);
     */
    public void close() {
        /*
        r5 = this;
        r0 = r5.mIsImageValid;
        if (r0 == 0) goto L_0x0033;
    L_0x0004:
        r0 = r5.mPlanes;
        r1 = r0.length;
        r2 = 0;
        r3 = r2;
    L_0x0009:
        if (r3 >= r1) goto L_0x0013;
    L_0x000b:
        r4 = r0[r3];
        r4.clear();
        r3 = r3 + 1;
        goto L_0x0009;
    L_0x0013:
        r0 = 0;
        r5.mPlanes = r0;
        r1 = r5.mShared;
        if (r1 != 0) goto L_0x002f;
    L_0x001a:
        r1 = r5.METHOD_RELEASE;	 Catch:{ IllegalAccessException -> 0x0027, IllegalAccessException -> 0x0027, IllegalAccessException -> 0x0027 }
        r3 = 1;
        r3 = new java.lang.Object[r3];	 Catch:{ IllegalAccessException -> 0x0027, IllegalAccessException -> 0x0027, IllegalAccessException -> 0x0027 }
        r4 = r5.mBuffer;	 Catch:{ IllegalAccessException -> 0x0027, IllegalAccessException -> 0x0027, IllegalAccessException -> 0x0027 }
        r3[r2] = r4;	 Catch:{ IllegalAccessException -> 0x0027, IllegalAccessException -> 0x0027, IllegalAccessException -> 0x0027 }
        r1.invoke(r0, r3);	 Catch:{ IllegalAccessException -> 0x0027, IllegalAccessException -> 0x0027, IllegalAccessException -> 0x0027 }
        goto L_0x002f;
    L_0x0027:
        r1 = move-exception;
        r3 = TAG;
        r4 = "Fail to release native heap.";
        android.util.Log.e(r3, r4, r1);
    L_0x002f:
        r5.mBuffer = r0;
        r5.mIsImageValid = r2;
    L_0x0033:
        return;
        */
        throw new UnsupportedOperationException("Method not decompiled: com.samsung.android.sdk.camera.impl.internal.ProcessorImageImpl.close():void");
    }

    public int getFormat() {
        throwISEIfImageIsInvalid();
        return this.mFormat;
    }

    public int getWidth() {
        throwISEIfImageIsInvalid();
        return this.mWidth;
    }

    public int getHeight() {
        throwISEIfImageIsInvalid();
        return this.mHeight;
    }

    public Plane[] getPlanes() {
        throwISEIfImageIsInvalid();
        return this.mPlanes;
    }

    public long getTimestamp() {
        throwISEIfImageIsInvalid();
        return this.mTimeStamp;
    }

    public int getTransform() {
        throwISEIfImageIsInvalid();
        return this.mTransform;
    }

    public int getScalingMode() {
        throwISEIfImageIsInvalid();
        return 0;
    }

    public void setTimestamp(long timestamp) {
        throwISEIfImageIsInvalid();
        this.mTimeStamp = timestamp;
    }

    protected final void finalize() throws Throwable {
        try {
            close();
        } finally {
            super.finalize();
        }
    }
}
