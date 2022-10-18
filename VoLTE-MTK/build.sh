#!/bin/bash

set -e

if [ "$#" -ne 1 ];then
	echo "Usage: $0 /path/to/system/"
	exit 1
fi

system_folder="$1"

rm -Rf ImsService
java -jar ../apktool.jar d "$1"/system/priv-app/ImsService/ImsService.apk

java -jar ../baksmali.jar d -o ImsService/smali "$1"/system/framework/mediatek-common.jar
java -jar ../baksmali.jar d -o ImsService/smali "$1"/system/framework/mediatek-ims-base.jar


# Force disable video calling (which requires ELF blobs)
## Replace `isVideoCallOnByPlatform` with `return false`
sed -i -E 's/public static isVideoCallOnByPlatform/public static isVideoCallOnByPlatform_nope/g' ImsService/smali/com/mediatek/ims/internal/ImsVTProviderUtil.smali

cat >> ImsService/smali/com/mediatek/ims/internal/ImsVTProviderUtil.smali <<EOF
.method public static isVideoCallOnByPlatform()Z
    .locals 1
    const/4 v0, 0x0
    return v0
.end method
EOF

## Replace bindInternal() with `return`
sed -i -E 's/method public bindInternal/method public bindInternal_nope/g' ImsService/smali/com/mediatek/ims/internal/ImsVTProviderUtil.smali
cat >> ImsService/smali/com/mediatek/ims/internal/ImsVTProviderUtil.smali <<EOF
.method public bindInternal(Lcom/mediatek/ims/internal/ImsVTProvider;II)V
    .locals 0
    return-void
.end method
EOF

#Replace getVideoCallProvider/method with `return null`
sed -i -E 's/method public getVideoCallProvider/method public getVideoCallProvider_nope/g' ImsService/smali/com/mediatek/ims/ImsCallSessionProxy.smali
cat >> ImsService/smali/com/mediatek/ims/ImsCallSessionProxy.smali <<EOF
.method public getVideoCallProvider()Lcom/android/ims/internal/IImsVideoCallProvider;
    .locals 1
    const/4 v0, 0x0
    return-object v0
.end method
EOF


#java -jar ../baksmali.jar d -o out2 "$1"/system/framework/mediatek-ims-common.jar
#java -jar ../baksmali.jar d -o out3 "$1"/system/framework/mediatek-telephony-common.jar

xmlstarlet ed -L -N a=http://schemas.android.com/apk/res/android \
    -d '/manifest/application/@a:usesNonSdkApi' \
    ImsService/AndroidManifest.xml

java -jar ../apktool.jar b ImsService
LD_LIBRARY_PATH=../signapk/ java -jar ../signapk/signapk.jar -a 4096\
	../keys/platform.x509.pem \
	../keys/platform.pk8 \
	ImsService/dist/ImsService.apk ImsService.apk
