#!/bin/bash

if [ "$#" -ne 2 ];then
	echo "Usage: $0 /path/to/system/ /path/to/vendor/"
	exit 1
fi

system_folder="$1"
vendor_folder="$2"
libdst="ims/lib/arm64-v8a/"

rm -Rf ims
apktool d "$system_folder"/app/ims/ims.apk
mkdir -p "$libdst"
find "$system_folder"/app/ims/lib/arm64 -type f -exec cp '{}' "$libdst" \; 
find "$system_folder"/app/ims/lib/arm64 -type l -exec readlink '{}' + | \
	while read f;do
		p="$(echo $f |sed -E 's;/system;;g')"
		cp "$system_folder"/$p "$libdst"
	done

cp "$system_folder"/lib64/lib-imsvt.so "$libdst"

cp "$system_folder"/lib64/libnativeloader.so "$libdst"
cp "$system_folder"/lib64/libnativehelper.so "$libdst"
cp "$system_folder"/lib64/libcutils.so "$libdst"
cp "$system_folder"/lib64/libutils.so "$libdst"
cp "$system_folder"/lib64/libgui.so "$libdst"
cp "$system_folder"/lib64/libbinder.so "$libdst"
cp "$system_folder"/lib64/libc++.so "$libdst"
cp "$system_folder"/lib64/libbacktrace.so "$libdst"
cp "$system_folder"/lib64/libvndksupport.so "$libdst"
cp "$system_folder"/lib64/libui.so "$libdst"
cp "$system_folder"/lib64/libhidlbase.so "$libdst"
cp "$system_folder"/lib64/libhidltransport.so "$libdst"
cp "$system_folder"/lib64/libbase.so "$libdst"
cp "$system_folder"/lib64/libunwind.so "$libdst"
cp "$system_folder"/lib64/libhardware.so "$libdst"
cp "$system_folder"/lib64/libhwbinder.so "$libdst"
cp "$system_folder"/lib64/liblzma.so "$libdst"

#Missing libs:
#android.hardware.media@1.0.so android.hardware.graphics.common@1.0.so android.hidl.token@1.0.so android.hardware.graphics.mapper@2.0.so android.hardware.graphics.allocator@2.0.so android.hidl.token@1.0-utils.so android.hardware.graphics.bufferqueue@1.0.so android.hardware.configstore@1.0.so android.hardware.configstore-utils.so
#It looks like the apk => /data/app/xx/lib extraction doesn't want libs not starting with lib
#TODO: sed the libs and their dependancy to rename to something starting with lib

sed -i -e '/com.qti.vzw.ims.internal/d' ims/AndroidManifest.xml
apktool b ims
signapk -a 4096 -w \
	/build/AOSP-8.1-clean/build/target/product/security/platform.x509.pem \
	/build/AOSP-8.1-clean/build/target/product/security/platform.pk8 \
	ims/dist/ims.apk ims.apk
