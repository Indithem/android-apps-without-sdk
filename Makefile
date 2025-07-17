# Android version related configs
ANDROIDTARGET:=34
ANDROID_JAR_FILE:=build-tools/android.jar

# Keystore related configs
KEYSTOREFILE:=my-release-key.keystore
ALIASNAME?=standkey
STOREPASS?=password
DNAME:="CN=example.com, OU=ID, O=Example, L=Doe, S=John, C=GB"

keystore : $(KEYSTOREFILE)

$(KEYSTOREFILE):
	keytool -genkey -v -keystore $(KEYSTOREFILE) -alias $(ALIASNAME) -keyalg RSA -keysize 2048 -validity 10000 -storepass $(STOREPASS) -keypass $(STOREPASS) -dname $(DNAME)

# help/doc:
# All .apk's that are produced:
#
# res.apk
# 	Contains android jar file, res, and assets
# manifest.apk (1st pass)
#	temp.apk + resources.arsc(compressed res) + Manifest, all compressed
# makecapk.apk (2nd pass)
# 	zipalign'ed and signed makecapk.apk

# The current method takes 3x the space of all apk-data
# 1 - for storing them in the repo
# 2 - as intermediate generated in makecapk folder
# 3 - final apk produced.
#
# 2 is reclaimed by deleting it.

apk:
	rm -f res.apk manifest.apk makecapk.apk
	./build-tools/aapt package -f -F res.apk -I $(ANDROID_JAR_FILE) -M AndroidManifest.xml -S apk-data/res -A apk-data/assets --target-sdk-version $(ANDROIDTARGET)
	unzip -o res.apk -d makecapk
	cd makecapk && zip -D4r ../manifest.apk . && zip -D0r ../manifest.apk ./resources.arsc ./AndroidManifest.xml
	./build-tools/zipalign -v 4 manifest.apk makecapk.apk
	./build-tools/apksigner sign --key-pass pass:$(STOREPASS) --ks-pass pass:$(STOREPASS) --ks $(KEYSTOREFILE) makecapk.apk
	rm -f res.apk manifest.apk
	rm -rf makecapk

install:
	adb install makecapk.apk
