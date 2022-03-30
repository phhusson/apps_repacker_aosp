#!/bin/bash

set -ex

if [ "$#" -ne 1 ];then
	echo "Usage: $0 /path/to/system/"
	exit 1
fi

system_folder="$1"
libdst="ims/lib/arm64-v8a/"

rm -Rf ims
if [ -f "$system_folder"/../system_ext/priv-app/ims/ims.apk ];then
java -jar ../apktool.jar d "$system_folder"/../system_ext/priv-app/ims/ims.apk
apkbase="$system_folder"/../system_ext/priv-app/ims/
else
java -jar ../apktool.jar d "$system_folder"/priv-app/ims/ims.apk
apkbase="$system_folder"/priv-app/ims/
fi
mkdir -p "$libdst"
#find "$apkbase"/lib/arm64 -type f -exec cp '{}' "$libdst" \;
#find "$apkbase"/lib/arm64 -type l -exec readlink '{}' + | \
#	while read f;do
#		p="$(echo $f |sed -E 's;/system;;g')"
#		cp "$system_folder"/$p "$libdst"
#	done
cp "$system_folder"/../system_ext/lib64/libimsmedia_jni.so "$libdst"
cp "$system_folder"/../system_ext/lib64/libimscamera_jni.so "$libdst"

for i in nativeloader nativehelper cutils utils gui binder c++ backtrace vndksupport ui hidlbase hidltransport base unwind hardware hwbinder lzma bufferhubqueue crypto ssl utilscallstack unwindstack dexfile processgroup bufferhub input binderthreadstate cgrouprc;do
    find "$system_folder/.." -name "lib${i}.so" |grep lib64 |xargs -I {} cp {} "$libdst"
done
cp "$PWD"/64/libpdx_default_transport.so "$libdst"

for i in android.hardware.graphics.common@1.1.so android.hardware.graphics.mapper@2.1.so android.hardware.configstore@1.1.so android.hardware.media@1.0.so android.hardware.graphics.common@1.0.so android.hidl.token@1.0.so android.hardware.graphics.mapper@2.0.so android.hardware.graphics.allocator@2.0.so android.hidl.token@1.0-utils.so android.hardware.graphics.bufferqueue@1.0.so android.hardware.graphics.bufferqueue@2.0.so android.hardware.configstore@1.0.so android.hardware.configstore-utils.so android.hardware.graphics.common@1.2.so android.frameworks.bufferhub@1.0.so android.hardware.graphics.allocator@3.0.so android.hardware.graphics.mapper@3.0.so;do
	newName="$(echo "$i" |sed -E -e 's/^andr/libA/g' -e 's/@/-/g')"
	cp "$system_folder"/system/lib64/$i "$libdst"/$newName
done

for i in android.hardware.graphics.common@1.1.so android.hardware.graphics.mapper@2.1.so android.hardware.configstore@1.1.so android.hardware.media@1.0.so android.hardware.graphics.common@1.0.so android.hidl.token@1.0.so android.hardware.graphics.mapper@2.0.so android.hardware.graphics.allocator@2.0.so android.hidl.token@1.0-utils.so android.hardware.graphics.bufferqueue@1.0.so android.hardware.graphics.bufferqueue@2.0.so android.hardware.configstore@1.0.so android.hardware.configstore-utils.so android.hardware.graphics.common@1.2.so android.frameworks.bufferhub@1.0.so android.hardware.graphics.allocator@3.0.so android.hardware.graphics.mapper@3.0.so;do
	newName="$(echo "$i" |sed -E -e 's/^andr/libA/g' -e 's/@/-/g')"
	sed -i -E "s/$i/$newName/g" "$libdst"/*.so
done

xmlstarlet ed -L -N a=http://schemas.android.com/apk/res/android -d '/manifest/@a:compileSdkVersion' -d '/manifest/@a:compileSdkVersionCodename' -d '/manifest/application/@a:usesNonSdkApi' ims/AndroidManifest.xml
sed -i 's/android:extractNativeLibs="false"/android:extractNativeLibs="true"/g' ims/AndroidManifest.xml
sed -i -e '/com.qti.vzw.ims.internal/d' ims/AndroidManifest.xml
sed -i -e '/uses-library/d' ims/AndroidManifest.xml
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

sed -i '/loadLibrary/d' ims/smali/com/qualcomm/ims/vt/ImsMedia.smali

#rm -Rf out
#java -jar ../baksmali.jar d "$system_folder"/../system_ext/framework/oplus-telephony-common.jar
#for f in $(cd oppo-telephony-common.jar.out/smali/org/codeaurora/telephony/utils;find -name \*.smali);do
#    mkdir -p ims/smali/org/codeaurora/telephony/utils/$(dirname $f)
#    cp oppo-telephony-common.jar.out/smali/org/codeaurora/telephony/utils/$f ims/smali/org/codeaurora/telephony/utils/$f
#done

java -jar ../baksmali.jar d "$system_folder"/../product/framework/ims-ext-common.jar
for f in $(cd ims-ext-common.jar.out/smali/;find -name \*.smali);do
    mkdir -p ims/smali/$(dirname $f)
    cp ims-ext-common.jar.out/smali/"$f" ims/smali/"$f"
done

#java -jar ../baksmali.jar d "$system_folder"/system/framework/telephony-common.jar
#mkdir -p ims/smali/com/android/internal/telephony/
#cp ./telephony-common.jar.out/smali/com/android/internal/telephony/OemConstant* ims/smali/com/android/internal/telephony/

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
