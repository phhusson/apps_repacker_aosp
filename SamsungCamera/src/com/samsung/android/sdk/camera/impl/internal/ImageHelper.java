package com.samsung.android.sdk.camera.impl.internal;

import android.media.Image;

public class ImageHelper {
    private static final String TAG = ProcessorImageImpl.class.getSimpleName();

    protected ImageHelper() {
    }

    public static int getTransform(Image image) {
        return image.getTransform();
    }
}
