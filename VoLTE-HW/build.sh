#!/bin/bash

set -e

if [ "$#" -ne 2 ];then
	echo "Usage: $0 /path/to/system/ /path/to/vendor/"
	exit 1
fi

system_folder="$1"
vendor_folder="$2"
libdst="HwIms/lib/arm64-v8a/"

rm -Rf HwIms
java -jar ../apktool.jar d "$system_folder"/app/HwIms/HwIms.apk
if [ ! -d HwIms/smali ];then
	(
	cd HwIms
	../../vdexExtractor -i "$system_folder"/app/HwIms/oat/arm64/HwIms.vdex -o .
	java -jar ../../baksmali.jar d HwIms_classes.dex
	mv out smali
	)
fi
mkdir -p "$libdst"
find "$system_folder"/app/HwIms/lib/arm64 -type f -exec cp '{}' "$libdst" \; 
find "$system_folder"/app/HwIms/lib/arm64 -type l -exec readlink '{}' + | \
	while read f;do
		p="$(echo $f |sed -E 's;/system;;g')"
		cp "$system_folder"/$p "$libdst"
	done

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

for i in android.hardware.media@1.0.so android.hardware.graphics.common@1.0.so android.hidl.token@1.0.so android.hardware.graphics.mapper@2.0.so android.hardware.graphics.allocator@2.0.so android.hidl.token@1.0-utils.so android.hardware.graphics.bufferqueue@1.0.so android.hardware.configstore@1.0.so android.hardware.configstore-utils.so;do
	newName="$(echo "$i" |sed -E -e 's/^andr/libA/g' -e 's/@/-/g')"
	cp "$system_folder"/lib64/$i "$libdst"/$newName
done

for i in android.hardware.media@1.0.so android.hardware.graphics.common@1.0.so android.hidl.token@1.0.so android.hardware.graphics.mapper@2.0.so android.hardware.graphics.allocator@2.0.so android.hidl.token@1.0-utils.so android.hardware.graphics.bufferqueue@1.0.so android.hardware.configstore@1.0.so android.hardware.configstore-utils.so;do
	newName="$(echo "$i" |sed -E -e 's/^andr/libA/g' -e 's/@/-/g')"
	sed -i -E "s/$i/$newName/g" "$libdst"/*.so
done

(
set -x
rm -Rf build
mkdir build
javac -cp ../libs/framework.jar:../libs/telephony-common.jar:../libs/ims-common.jar -d build $(find src -name \*.java)
$ANDROID_HOME/build-tools/28.0.2/d8 --output build/ --lib ../libs/framework.jar --lib ../libs/telephony-common.jar --lib ../libs/ims-common.jar $(find build -name \*.class)
java -jar ../baksmali.jar d build/classes.dex -o HwIms/smali
)

perl -0777 -i -p -e 's|invoke-virtual \{([pv0-9]+)\}, Lcom/android/internal/telephony/Phone;->getImsSwitch\(\)Z\s+move-result ([pv0-9]+)|const/4 \2, 0x1|g' HwIms/smali/com/huawei/ims/HwImsUtImpl.smali HwIms/smali/com/huawei/ims/ImsServiceSub.smali

sed -i -E \
	-e 's;Lcom/android/ims/ImsReasonInfo;Landroid/telephony/ims/ImsReasonInfo;g' \
	-e 's;Landroid/telephony/ims/feature/MMTelFeature;Landroid/telephony/ims/compat/feature/MMTelFeature;g' \
	-e 's;Landroid/telephony/ims/stub/ImsUtListenerImplBase;Landroid/telephony/ims/compat/stub/ImsUtListenerImplBase;g' \
	$(find -name \*.smali)
java -jar ../apktool.jar b HwIms
LD_LIBRARY_PATH=../signapk/ java -jar ../signapk/signapk.jar -a 4096\
	../keys/platform.x509.pem \
	../keys/platform.pk8 \
	HwIms/dist/HwIms.apk HwIms.apk
