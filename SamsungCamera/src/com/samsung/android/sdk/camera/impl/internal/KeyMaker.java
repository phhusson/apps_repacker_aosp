package com.samsung.android.sdk.camera.impl.internal;

import android.hardware.camera2.CameraCharacteristics.Key;
import android.hardware.camera2.CaptureRequest;
import android.hardware.camera2.CaptureResult;
import android.hardware.camera2.utils.TypeReference;
import java.lang.reflect.Type;

public class KeyMaker {
    private static final int KEY_CAPTURE_REQUEST = 1;
    private static final int KEY_CAPTURE_RESULT = 2;
    private static final int KEY_CHARACTERISTIC = 0;

    private KeyMaker() {
    }

    public static <T> Object createKey(int version_code, Object... args) {
        if (args == null || args.length < 3) {
            throw new RuntimeException("Illegal arguments to createKey");
        }
        String name = (String)args[0];
        Type typeParameter = (Type)args[1];
        switch (((Integer) args[2]).intValue()) {
            case 0:
                return new Key(name, TypeReference.createSpecializedTypeReference(typeParameter));
            case 1:
                return new CaptureRequest.Key(name, TypeReference.createSpecializedTypeReference(typeParameter));
            case 2:
                return new CaptureResult.Key(name, TypeReference.createSpecializedTypeReference(typeParameter));
            default:
                return null;
        }
    }

    public static boolean isKeyExist(int version_code, Object... args) {
        if (args == null || args.length < 1) {
            throw new RuntimeException("Illegal arguments to isKeyExist");
        }
        Object key = args[0];
        try {
            if (key instanceof Key) {
                ((Key) key).getNativeKey().getTag();
                return true;
            } else if (key instanceof CaptureResult.Key) {
                ((CaptureResult.Key) key).getNativeKey().getTag();
                return true;
            } else if (!(key instanceof CaptureRequest.Key)) {
                return false;
            } else {
                ((CaptureRequest.Key) key).getNativeKey().getTag();
                return true;
            }
        } catch (Exception e) {
        }
	return false;
    }
}
