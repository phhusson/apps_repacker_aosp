package com.samsung.android.feature;

public class SemFloatingFeature implements IFloatingFeature {
	private static SemFloatingFeature sInstance = null;
	public static SemFloatingFeature getInstance() {
		if (sInstance == null) {
			sInstance = new SemFloatingFeature();
		}
		return sInstance;
	}

	public boolean getBoolean(String tag) {
		android.util.Log.d("PHH", "SemFloatingFeature get " + tag);
		return false;
	}
	public boolean getBoolean(String tag, boolean defaultValue) {
		android.util.Log.d("PHH", "SemFloatingFeature get " + tag);
		return defaultValue;
	}
	public String getString(String tag) {
		android.util.Log.d("PHH", "SemFloatingFeature get " + tag);
		return "";
	}
	public String getString(String tag, String defaultValue) {
		android.util.Log.d("PHH", "SemFloatingFeature get " + tag);
		return defaultValue;
	}
	public int getInteger(String tag) {
		android.util.Log.d("PHH", "SemFloatingFeature get " + tag);
		return 0;
	}
	public int getInt(String tag) {
		android.util.Log.d("PHH", "SemFloatingFeature get " + tag);
		return 0;
	}
	public int getInteger(String tag, int defaultValue) {
		android.util.Log.d("PHH", "SemFloatingFeature get " + tag);
		return defaultValue;
	}
	public int getInt(String tag, int defaultValue) {
		android.util.Log.d("PHH", "SemFloatingFeature get " + tag);
		return defaultValue;
	}
}
