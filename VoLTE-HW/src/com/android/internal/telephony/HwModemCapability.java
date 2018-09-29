package com.android.internal.telephony;

public class HwModemCapability {
	public static boolean isCapabilitySupport(int cap) {
		//Support adjust speech codec
		if(cap == 11) {
			return false;
		}
		return false;
	}
};
