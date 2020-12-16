#!/bin/bash

set -e

rm -Rf vdexExtractor_deodexed out

rm -Rf ims
java -jar ~/Decompil/apktool_2.4.1.jar d s/system/priv-app/ims/ims.apk
xmlstarlet ed -L -N a=http://schemas.android.com/apk/res/android \
    -d '/manifest/@a:compileSdkVersion' \
    -d '/manifest/@a:compileSdkVersionCodename' \
    -d '//application/@a:appComponentFactory' \
    -d '//application/@a:usesNonSdkApi' \
    ims/AndroidManifest.xml

rm -Rf out classes*.dex vdexExtractor_deodexed boot-framework boot-telephony-common boot-radio_interactor_common
~/Decompil/vdexExtractor/tools/deodex/run.sh -i s/system/framework/boot-framework.vdex
for i in vdexExtractor_deodexed/*/*;do
    java -jar ~/Decompil/baksmali-2.4.0.jar d $i
done
mv out boot-framework

~/Decompil/vdexExtractor/tools/deodex/run.sh -i s/system/framework/boot-telephony-common.vdex
for i in vdexExtractor_deodexed/*/*;do
    java -jar ~/Decompil/baksmali-2.4.0.jar d $i
done
mv out boot-telephony-common

~/Decompil/vdexExtractor/tools/deodex/run.sh -i s/system/framework/boot-radio_interactor_common.vdex
for i in vdexExtractor_deodexed/*/*;do
    java -jar ~/Decompil/baksmali-2.4.0.jar d $i
done
mv out boot-radio_interactor_common




#Copy everything from radio_interactor_common, it includes vendor hal + part of implementation
(cd boot-radio_interactor_common; tar c . |tar x -C ../ims/smali/)

perl -0777 -pe 's/.annotation.*InnerClass.*\n.*accessFlag.*\n.*name.*\n.*end annotation.*\n//g' -i \
    ims/smali/vendor/sprd/hardware/radio/V1_0/IAtcRadioIndication\$Proxy.smali

mkdir -p ims/smali/com/android/internal/telephony/{,dataconnection}
cp boot-telephony-common/com/android/internal/telephony/dataconnection/{DcNetworkManager*,ApnSetting*,AbsApnSett*} ims/smali/com/android/internal/telephony/dataconnection/
cp boot-telephony-common/com/android/internal/telephony/VolteConfig.smali ims/smali/com/android/internal/telephony/
cp boot-framework/com/android/internal/telephony/ITelephonyEx* ims/smali/com/android/internal/telephony/

mkdir -p ims/smali/com/android/ims/internal
cp boot-framework/com/android/ims/internal/{IImsUtEx*,IImsServiceEx*,IVoWifi*,IImsDoze*,ImsManagerEx*,IImsUtListenerEx*} ims/smali/com/android/ims/internal

mkdir -p ims/smali/android/telephony/
cp boot-framework/android/telephony/TelephonyManagerEx.smali ims/smali/android/telephony/

#/!\!/ BREAKS IA EMERGENCY CALLS
#Issue here is that ims tries to create a DataProfile with a constructor that doesn't exist in AOSP
#perl -0777 -i -pe 's/.*method private setInitialAttachIMSApn.*\n((\h+.*|\h*)\n)*.*end method/.method private setInitialAttachIMSApn()V\n.locals 0\nreturn-void\n.end method/g' \
#    ims/smali/com/spreadtrum/ims/ImsServiceImpl.smali 


#    invoke-virtual {v2, v3}, Landroid/telephony/CarrierConfigManager;->getConfigForPhoneId(I)Landroid/os/PersistableBundle;
perl -0777 -i -pe 's/.*invoke.*CarrierConfigManager;->getConfigForPhoneId.*\n\n\h*move-result-object v([0-9]*)\n/const v\1, 0/g' \
    ims/smali/com/spreadtrum/ims/ut/ImsUtProxy.smali

java -jar ~/Decompil/apktool_2.4.1.jar b ims

#libs must be NOT compressed
/build2/AOSP-10.0-new/prebuilts/build-tools/linux-x86/bin/zip2zip -0 'lib/**/*' -i ims/dist/ims.apk -o ims/dist/ims.new.apk
mv -f ims/dist/ims.new.apk ims/dist/ims.apk

LD_LIBRARY_PATH=/home/phh/tmp/apps_repacker_aosp/VoLTE-CAF/../signapk/ java -jar /home/phh/tmp/apps_repacker_aosp/VoLTE-CAF/../signapk/signapk.jar -a 4096\
	/home/phh/tmp/apps_repacker_aosp/VoLTE-CAF/../keys/platform.x509.pem \
	/home/phh/tmp/apps_repacker_aosp/VoLTE-CAF/../keys/platform.pk8 \
	ims/dist/ims.apk ims.apk

