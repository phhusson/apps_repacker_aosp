#!/bin/bash

set -e

if [ "$#" -ne 2 ];then
	echo "Usage: $0 /path/to/system/ /path/to/vendor/"
	exit 1
fi

system_folder="$1"
vendor_folder="$2"

rm -Rf SamsungCamera
java -jar ../apktool.jar d "$system_folder"/priv-app/SamsungCamera/SamsungCamera.apk

(
cd src
find -name \*.class -delete
rm -Rf out classes.dex

javac -cp ../libs/framework.jar $(find -name \*.java)
/build/AOSP-9.0/out/soong/host/linux-x86/bin/d8 --classpath ../libs/framework.jar $(find -name \*.class)
java -jar ../../baksmali.jar d classes.dex
rm -f classes.dex

cd out
find -name \*.smali |while read -r f;do
	mkdir -p ../../SamsungCamera/smali/"$(dirname "$f")"
	cp "$f" ../../SamsungCamera/smali/"$(dirname "$f")"
done
)

#1,2 android.os.Debug.semIsProductDev ====> 1
#3. isKNOXMode => delete return false
#4. isOwner => delete return true
#5. isDesktopMode => delete return false
t="$(find |grep -E 'com.sec.android.app.camera.util.Util.smali')"
sed -i -E \
	-e '/semIsProductDev/,/move-re/d' \
	-e '/line 108/aconst/4 v0, 1' \
	-e '/^.method public static isKNOXMode/,/end method/d' \
	-e '/^.method public static isOwner/,/end method/d' \
	-e '/^.method public static isDesktopMode/,/end method/d' \
	"$t"
cat >>  "$t" << EOF
.method public static isKNOXMode()Z
	.locals 1
	const/4 v0, 0
	return v0
.end method
.method public static isOwner()Z
	.locals 1
	const/4 v0, 1
	return v0
.end method
.method public static isDesktopMode(Landroid/content/Context;)Z
	.locals 1
	const/4 v0, 0
	return v0
.end method
EOF

#1. isVTCallOngoing => delete; return false
#1. isVoIPCallOngoing => delete; return false
t="$(find |grep -E com.sec.android.app.camera.util.CallState.smali)"
sed -i -E \
	-e '/^.method public static isVTCallOngoing/,/end method/d' \
	-e '/^.method public static isVoIPCallOngoing/,/end method/d' \
	-e '/^.method public static isOffHook/,/end method/d' \
	"$t"
cat >> "$t" << EOF
.method public static isVTCallOngoing(Landroid/content/Context;)Z
	.locals 1
	const/4 v0, 0
	return v0
.end method
.method public static isVoIPCallOngoing()Z
	.locals 1
	const/4 v0, 0
	return v0
.end method
.method public static isOffHook(Landroid/content/Context;)Z
	.locals 1
	const/4 v0, 0
	return v0
.end method
EOF

#Remove calls to SemMdnieManager.setContentMode (return value isn't checked)
t="$(find |grep -E com.sec.android.app.camera.Camera.smali)"
sed -i -E \
	-e '/SemMdnieManager.*setContentMode/d' \
	-e '/.method public requestSystemKeyEvents/,/.end method/d' \
	"$t"
cat >> "$t" << EOF
.method public requestSystemKeyEvents(Z)V
.locals 0
return-void
.end method
EOF

#Remove call to semAddAudioTag (from builder v2, returns builder in v1)
t="$(find |grep -E com.sec.android.app.camera.SoundManager.smali)"
sed -i -E \
	-e '/semAddAudioTag/i  move-object v1, v2' \
	-e '/semAddAudioTag/,/move-result-object/d' \
	"$t"

#We want to use system classloader, not one reading from an unexisting file for us (/system/framework/scamera_sdk_util.jar)
t="$(find |grep -E com.samsung.android.camera.core2.local.internal.PdkUtil.smali)"
sed -i -E \
	-e 's|invoke-static \{v1, v2, v3\}, .*Class.*forName.*|invoke-static \{v1\}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;|g' \
	"$t"

for i in libcore2nativeutil.camera.samsung.so libimagecodec.quram.so;do
	cp "$system_folder"/lib64/"$i" SamsungCamera/lib/arm64-v8a/
done


#invert bogus condition lline 111
## t="$(find |grep -E com.samsung.android.glview.GLResourceTexture.smali)"
## sed -i -E \
## 	-e '/line 111/,/line 112/s/if-nez/if-eqz/g' \
## 	"$t"

sed -E -i \
	-e '/uses-library .*semextendedformat/d' \
	-e '/uses-library .*secimaging/d' \
	-e 's/android:compileSdkVersion(Codename)?="[^"]*"//g' \
	SamsungCamera/AndroidManifest.xml

#Remove all "SPR" (SemPathRenderingDrawable) files, by replacing with 1x1 bmp
for f in $(LC_ALL=C grep -RE '^SPR' SamsungCamera/res/ |sed -nE 's/^Binary file (.*) matches$/\1/p');do
	cp t.bmp $f
done

java -jar ../apktool.jar b SamsungCamera
LD_LIBRARY_PATH=../signapk/ java -jar ../signapk/signapk.jar -a 4096\
	../keys/platform.x509.pem \
	../keys/platform.pk8 \
	SamsungCamera/dist/SamsungCamera.apk SamsungCamera.apk
