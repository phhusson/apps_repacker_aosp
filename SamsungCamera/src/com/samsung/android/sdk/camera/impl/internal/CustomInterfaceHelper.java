package com.samsung.android.sdk.camera.impl.internal;

import android.hardware.camera2.CameraAccessException;
import android.hardware.camera2.CameraCharacteristics;
import android.hardware.camera2.CameraCharacteristics.Key;
import android.hardware.camera2.CameraDevice;
import android.hardware.camera2.params.OutputConfiguration;
import android.view.Surface;
import java.util.List;
import java.util.ArrayList;

public class CustomInterfaceHelper {
    private static final String TAG = CustomInterfaceHelper.class.getSimpleName();

    protected CustomInterfaceHelper() {
    }

    public static void setSamsungParameter(CameraDevice cameraDevice, String parameter) throws CameraAccessException {
        if (cameraDevice != null) {
		android.util.Log.d("PHH", "setSamsungParameter " + parameter);
            //cameraDevice.setParameters(parameter);
        }
    }

    public static OutputConfiguration createOutputConfiguration(int surfaceGroupId, Surface surface, int rotation, int option) {
		android.util.Log.d("PHH", "createOutputConfiguration w/ option " + option);
        return new OutputConfiguration(surfaceGroupId, surface, rotation);
    }

    public static <TKey> List<TKey> getAvailableSamsungKeyList(CameraCharacteristics cameraCharacteristics, Class<?> metadataClass, Class<TKey> keyClass, Key<int[]> key) {
        //return cameraCharacteristics.getAvailableSamsungKeyList(metadataClass, keyClass, key);
android.util.Log.d("PHH", "getAvailableSamsungKeyList");
try {
        int[] filterTags = (int[]) cameraCharacteristics.get(key);
        if (filterTags == null) {
            return null;
        }

	java.lang.reflect.Method m = cameraCharacteristics.getClass().getMethod("getAvailableKeyList", Class.class, Class.class, Class.class);
	m.setAccessible(true);
	return (List)m.invoke(cameraCharacteristics, metadataClass, keyClass, filterTags);
} catch(Exception e) {
	android.util.Log.d("PHH", "Failed", e);
	return null;
}
    }
}
