package android.telephony;

import android.telephony.TelephonyManager;

public class HwTelephonyManager {
	private final static HwTelephonyManager INSTANCE = new HwTelephonyManager();

	private HwTelephonyManager() {
	}

	public static HwTelephonyManager getDefault() {
		return INSTANCE;
	}

	public int getDefault4GSlotId() {
		return TelephonyManager.getDefault().getSlotIndex();
	}

	public int getCardType(int p) {
		return 0;
	}
}
