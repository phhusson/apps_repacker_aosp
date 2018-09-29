package com.android.ims;

import android.content.Context;
import com.android.ims.ImsManager;

public class HwImsManager {
	public static boolean isDualImsAvailable() {
		return false;
	}

	public static int getWfcMode(Context ctxt, int phoneId) {
		return ImsManager.getWfcMode(ctxt);
	}

	public static boolean isWfcEnabledByPlatform(Context ctxt, int phoneId) {
		return ImsManager.isWfcEnabledByPlatform(ctxt);
	}

	public static boolean isEnhanced4gLteModeSettingEnabledByUser(Context ctxt, int phoneId) {
		return ImsManager.isEnhanced4gLteModeSettingEnabledByUser(ctxt);
	}
}
