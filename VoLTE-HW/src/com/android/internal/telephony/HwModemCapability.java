package com.android.internal.telephony;

public class HwModemCapability {
	public static boolean isCapabilitySupport(int capability) {
		boolean z = true;
		int bcdIndex = capability / 4;
		int bcdOffset = capability % 4;
		if (capability < 0 || capability >= 360) {
			return false;
		}
		if (TextUtils.isEmpty(MODEM_CAP)) {
			MODEM_CAP = SystemProperties.get("persist.radio.modem.cap", LogException.NO_VALUE);
		}
		try {
			int bcdValue = convertChar2Int(MODEM_CAP.charAt(bcdIndex));
			if (bcdValue != -1) {
				if (((1 << (3 - bcdOffset)) & bcdValue) <= 0) {
					z = false;
				}
				return z;
			}
		} catch (IndexOutOfBoundsException ex) {
			Log.e(TAG, "isCapabilitySupport " + ex);
		}
		return false;
	}
	private int convertChar2Int(char origChar) {
		if (origChar >= '0' && origChar <= '9') {
			return origChar - 48;
		}
		if (origChar >= 'a' && origChar <= 'f') {
			return (origChar - 97) + 10;
		}
		if (origChar < 'A' || origChar > 'F') {
			return -1;
		}
		return (origChar - 65) + 10;
        }
};
