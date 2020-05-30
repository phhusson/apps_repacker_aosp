#!/bin/bash

set -e

#Prepare stuff we'll need
if [ ! -d motorola_troika_sprout_dump ];then
    git clone https://github.com/AndroidDumps/motorola_troika_sprout_dump/
fi

rm -f system
ln -s motorola_troika_sprout_dump/system/system system

rm -Rf vdexExtractor_deodexed out

rm -Rf ShannonIms
java -jar ~/Decompil/apktool_2.4.1.jar d ./system/app/ShannonIms/ShannonIms.apk
xmlstarlet ed -L -N a=http://schemas.android.com/apk/res/android \
    -d '/manifest/@a:compileSdkVersion' \
    -d '/manifest/@a:compileSdkVersionCodename' \
    -d '//application/@a:appComponentFactory' \
    -d '//application/@a:usesNonSdkApi' \
    ShannonIms/AndroidManifest.xml

rm -f classes*.dex
unzip system/framework/framework.jar 'classes*'
for i in classes*.dex;do
    java -jar ~/Decompil/baksmali-2.4.0.jar d $i
done
rm -f classes*.dex

p=android/telephony/ims/aidl/
mkdir -p ShannonIms/smali/$p
cp ./out/$p/IEPdgConnection* ShannonIms/smali/$p
sed -i 's/blacklist //g' ShannonIms/smali/$p/IEPdgConnection*
sed -i 's/whitelist //g' ShannonIms/smali/$p/IEPdgConnection*

perl -i.orig -0777 -pe 's/invoke-virtual.*isApplicationOnIcc.*\n\n\h*move-result (v[0-9]*)\n/const \1, 1\n/g' $(find ShannonIms -name ImsSimManager.smali)

#Breaks ViLTE
#But libmediaadaptor has deep depencies into stagefright
sed -i -e 's/"mediaadaptor"/"c"/g' $(find ShannonIms -name MediaController.smali)

java -jar ~/Decompil/apktool_2.4.1.jar b ShannonIms

LD_LIBRARY_PATH=/home/phh/tmp/apps_repacker_aosp/VoLTE-CAF/../signapk/ java -jar /home/phh/tmp/apps_repacker_aosp/VoLTE-CAF/../signapk/signapk.jar -a 4096\
	/home/phh/tmp/apps_repacker_aosp/VoLTE-CAF/../keys/platform.x509.pem \
	/home/phh/tmp/apps_repacker_aosp/VoLTE-CAF/../keys/platform.pk8 \
	ShannonIms/dist/ShannonIms.apk ShannonIms.apk
