#!/bin/bash

set -e

if [ "$#" -ne 1 ];then
	echo "Usage: $0 /path/to/system/"
	exit 1
fi

system_folder="$1"
libdst="ims/lib/armeabi-v7a/"

rm -Rf ims
if [ -f "$system_folder"/app/ims/ims.apk ];then
java -jar ../apktool.jar d "$system_folder"/app/ims/ims.apk
apkbase="$system_folder"/app/ims/
else
java -jar ../apktool.jar d "$system_folder"/priv-app/ims/ims.apk
apkbase="$system_folder"/priv-app/ims/
fi
mkdir -p "$libdst"
find "$apkbase"/lib/arm -type f -exec cp '{}' "$libdst" \;
find "$apkbase"/lib/arm -type l -exec readlink '{}' + | \
	while read f;do
		p="$(echo $f |sed -E 's;/system;;g')"
		cp "$system_folder"/$p "$libdst"
	done

cp "$system_folder"/lib/libnativeloader.so "$libdst"
cp "$system_folder"/lib/libnativehelper.so "$libdst"
cp "$system_folder"/lib/libcutils.so "$libdst"
cp "$system_folder"/lib/libutils.so "$libdst"
cp "$system_folder"/lib/libgui.so "$libdst"
cp "$system_folder"/lib/libbinder.so "$libdst"
cp "$system_folder"/lib/libc++.so "$libdst"
cp "$system_folder"/lib/libbacktrace.so "$libdst"
cp "$system_folder"/lib/libvndksupport.so "$libdst"
cp "$system_folder"/lib/libui.so "$libdst"
cp "$system_folder"/lib/libhidlbase.so "$libdst"
cp "$system_folder"/lib/libhidltransport.so "$libdst"
cp "$system_folder"/lib/libbase.so "$libdst"
cp "$system_folder"/lib/libunwind.so "$libdst"
cp "$system_folder"/lib/libhardware.so "$libdst"
cp "$system_folder"/lib/libhwbinder.so "$libdst"
cp "$system_folder"/lib/liblzma.so "$libdst"
cp "$system_folder"/lib/libbufferhubqueue.so "$libdst"
cp "$system_folder"/lib/libcrypto.so "$libdst"
cp "$system_folder"/lib/libssl.so "$libdst"
cp "$system_folder"/lib/libutilscallstack.so "$libdst"
cp "$system_folder"/lib/libunwindstack.so "$libdst"
cp "$system_folder"/lib/libdexfile.so "$libdst"
cp "$PWD"/32/libpdx_default_transport.so "$libdst"

for i in android.hardware.graphics.common@1.1.so android.hardware.graphics.mapper@2.1.so android.hardware.configstore@1.1.so android.hardware.media@1.0.so android.hardware.graphics.common@1.0.so android.hidl.token@1.0.so android.hardware.graphics.mapper@2.0.so android.hardware.graphics.allocator@2.0.so android.hidl.token@1.0-utils.so android.hardware.graphics.bufferqueue@1.0.so android.hardware.configstore@1.0.so android.hardware.configstore-utils.so;do
	newName="$(echo "$i" |sed -E -e 's/^andr/libA/g' -e 's/@/-/g')"
	cp "$system_folder"/lib/$i "$libdst"/$newName
done

for i in android.hardware.graphics.common@1.1.so android.hardware.graphics.mapper@2.1.so android.hardware.configstore@1.1.so android.hardware.media@1.0.so android.hardware.graphics.common@1.0.so android.hidl.token@1.0.so android.hardware.graphics.mapper@2.0.so android.hardware.graphics.allocator@2.0.so android.hidl.token@1.0-utils.so android.hardware.graphics.bufferqueue@1.0.so android.hardware.configstore@1.0.so android.hardware.configstore-utils.so;do
	newName="$(echo "$i" |sed -E -e 's/^andr/libA/g' -e 's/@/-/g')"
	sed -i -E "s/$i/$newName/g" "$libdst"/*.so
done

xmlstarlet ed -L -N a=http://schemas.android.com/apk/res/android -d '/manifest/@a:compileSdkVersion' -d '/manifest/@a:compileSdkVersionCodename' ims/AndroidManifest.xml
sed -i -e '/com.qti.vzw.ims.internal/d' ims/AndroidManifest.xml
sed -i \
	-e 's;Landroid/telephony/ims/feature/MMTelFeature;Landroid/telephony/ims/compat/feature/MMTelFeature;g' \
	-e 's;Landroid/telephony/ims/stub/ImsUtListenerImplBase;Landroid/telephony/ims/compat/stub/ImsUtListenerImplBase;g' \
	$(find -name \*.smali)

java -jar ../baksmali.jar d -o ims/smali android.hidl.manager-V1.0-java.jar
sed -i -E \
    -e 's;^(.*)(private|protected|public) (private|protected|public)(.*)$;\1 public \4;g' \
	$(find ims/smali/android -name \*.smali)
rm -f ims/smali/android/util/AndroidException.smali
rm -Rf ims/smali/android/os

rm -Rf out
java -jar ../baksmali.jar d boot-telephony-common_classes.dex
for f in $(cd out/org/codeaurora/ims;find -name \*.smali);do
    mkdir -p ims/smali/org/codeaurora/ims/$(dirname $f)
    cp out/org/codeaurora/ims/$f ims/smali/org/codeaurora/ims/$f
done
#mkdir -p ims/smali/org/codeaurora/ims/{utils,internal}
#cp out/org/codeaurora/ims/utils/*QtiCarrierConfigHelper* ims/smali/org/codeaurora/ims/utils/
#for f in QtiImsExtUtils 'QtiImsExtUtils$VideoQualityFeatureValuesConstants';do
#cp out/org/codeaurora/ims/utils/"$f".smali ims/smali/org/codeaurora/ims/utils/
#done
#cp out/org/codeaurora/ims/QtiImsExtBase.smali ims/smali/org/codeaurora/ims/
#cp out/org/codeaurora/ims/QtiImsExtBase\$QtiImsExtBinder.smali ims/smali/org/codeaurora/ims/
#for f in IQtiImsExt 'IQtiImsExt$Stub';do
#    cp out/org/codeaurora/ims/internal/"$f".smali ims/smali/org/codeaurora/ims/internal/
#done
rm -Rf out

java -jar ../apktool.jar b ims
LD_LIBRARY_PATH=../signapk/ java -jar ../signapk/signapk.jar -a 4096\
	../keys/platform.x509.pem \
	../keys/platform.pk8 \
	ims/dist/ims.apk ims.apk
