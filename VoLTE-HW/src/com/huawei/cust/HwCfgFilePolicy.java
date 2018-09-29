package com.huawei.cust;

import java.io.File;
import android.util.Log;

public class HwCfgFilePolicy {
	public static File getCfgFile(String path, int a) {
		return new File("/noexist");
	}
}
