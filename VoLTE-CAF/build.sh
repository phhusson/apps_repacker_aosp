#!/bin/bash

set -e

if [ "$#" -ne 1 ];then
	echo "Usage: $0 /path/to/system/"
	exit 1
fi

system_folder="$1"
libdst="ims/lib/arm64-v8a/"

rm -Rf ims
java -jar ../apktool.jar d "$system_folder"/app/ims/ims.apk
mkdir -p "$libdst"
find "$system_folder"/app/ims/lib/arm64 -type f -exec cp '{}' "$libdst" \; 
find "$system_folder"/app/ims/lib/arm64 -type l -exec readlink '{}' + | \
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
cp "$system_folder"/lib64/libbufferhubqueue.so "$libdst"
cp "$system_folder"/lib64/libpdx_default_transport.so "$libdst"
cp "$system_folder"/lib64/libutilscallstack.so "$libdst"
cp "$system_folder"/lib64/libcrypto.so "$libdst"
cp "$system_folder"/lib64/libunwindstack.so "$libdst"
cp "$system_folder"/lib64/libdexfile.so "$libdst"

for i in android.hardware.media@1.0.so android.hardware.graphics.common@1.0.so android.hardware.graphics.common@1.1.so android.hidl.token@1.0.so android.hardware.graphics.mapper@2.0.so android.hardware.graphics.mapper@2.1.so android.hardware.graphics.allocator@2.0.so android.hidl.token@1.0-utils.so android.hardware.graphics.bufferqueue@1.0.so android.hardware.configstore@1.0.so android.hardware.configstore@1.1.so android.hardware.configstore-utils.so;do
	newName="$(echo "$i" |sed -E -e 's/^andr/libA/g' -e 's/@/-/g')"
	cp "$system_folder"/lib64/$i "$libdst"/$newName
done

for i in android.hardware.media@1.0.so android.hardware.graphics.common@1.0.so android.hardware.graphics.common@1.1.so android.hidl.token@1.0.so android.hardware.graphics.mapper@2.0.so android.hardware.graphics.mapper@2.1.so android.hardware.graphics.allocator@2.0.so android.hidl.token@1.0-utils.so android.hardware.graphics.bufferqueue@1.0.so android.hardware.configstore@1.0.so android.hardware.configstore@1.1.so android.hardware.configstore-utils.so;do
	newName="$(echo "$i" |sed -E -e 's/^andr/libA/g' -e 's/@/-/g')"
	sed -i -E "s/$i/$newName/g" "$libdst"/*.so
done

sed -i -e '/com.qti.vzw.ims.internal/d' ims/AndroidManifest.xml
sed -i \
	-e 's;Landroid/telephony/ims/feature/MMTelFeature;Landroid/telephony/ims/compat/feature/MMTelFeature;g' \
	-e 's;Landroid/telephony/ims/stub/ImsUtListenerImplBase;Landroid/telephony/ims/compat/stub/ImsUtListenerImplBase;g' \
	$(find -name \*.smali)
java -jar ../apktool.jar b ims
LD_LIBRARY_PATH=../signapk/ java -jar ../signapk/signapk.jar -a 4096\
	../keys/platform.x509.pem \
	../keys/platform.pk8 \
	ims/dist/ims.apk ims.apk
