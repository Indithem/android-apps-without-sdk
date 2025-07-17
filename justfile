# Enable loading from .env automatically if you want
set dotenv-load := true

# Android version related configs
ANDROIDTARGET := "34"
ANDROID_JAR_FILE := "build-tools/android.jar"

# Keystore related configs
KEYSTOREFILE := "my-release-key.keystore"
ALIASNAME := "standkey"
STOREPASS := "password"
DNAME := "CN=example.com, OU=ID, O=Example, L=Doe, S=John, C=GB"

# Native Compilation configs

# TODO
# SYSROOT := build-tools/sysroot
# CC-x86_64 := zig cc -target x86_64-linux-android --sysroot "{{ SYSROOT }}"
# CC-aarch64 := zig cc -target aarch64-linux-android --sysroot "{{ SYSROOT }}"
# CFLAGS := ""
TARGETS := "
    x86_64
    aarch64
"


# Install the APK to a connected device
install:
    adb install makecapk.apk

logcat:
    adb logcat -T 0 | grep nopurpose

# Generate keystore if it doesn't exist
keystore:
    [ -e {{KEYSTOREFILE}} ] && { echo "File already exists!"; exit 1; }

    keytool -genkey -v \
        -keystore {{ KEYSTOREFILE }} \
        -alias {{ ALIASNAME }} \
        -keyalg RSA \
        -keysize 2048 \
        -validity 10000 \
        -storepass {{ STOREPASS }} \
        -keypass {{ STOREPASS }} \
        -dname "{{ DNAME }}"; \


build target:
    # todo
    echo "WIP"
    mkdir -p makecapk/lib/{{target}}
    zig cc -target {{target}}-linux \
        -o makecapk/lib/{{target}}/libmain.o \
        src/main.c

# Build the APK in multiple steps
#
# help/doc:
# All .apk's that are produced:
#
# res.apk
# 	Contains android jar file, res, and assets
# manifest.apk (1st pass)
#	temp.apk + resources.arsc(compressed res) + Manifest, all compressed
# makecapk.apk (2nd pass)
# 	zipalign'ed and signed makecapk.apk
#
# The current method takes 3x the space of all apk-data
# 1 - for storing them in the repo
# 2 - as intermediate generated in makecapk folder
# 3 - final apk produced.
#
# 2 is reclaimed by deleting it.
apk:
    rm -f res.apk manifest.apk makecapk.apk
    ./build-tools/aapt package -f -F res.apk \
        -I {{ ANDROID_JAR_FILE }} \
        -M AndroidManifest.xml \
        -S apk-data/res \
        -A apk-data/assets \
        --target-sdk-version {{ ANDROIDTARGET }}
    unzip -o res.apk -d makecapk
    # insert building targets logic over here:
    # ```fish
    # for i in TARGETS
    #     just build i
    # end
    # ```
    just build aarch64
    cd makecapk && zip -D4r ../manifest.apk . && zip -D0r ../manifest.apk ./resources.arsc ./AndroidManifest.xml
    ./build-tools/zipalign 4 manifest.apk makecapk.apk
    ./build-tools/apksigner sign \
        --key-pass pass:{{ STOREPASS }} \
        --ks-pass pass:{{ STOREPASS }} \
        --ks {{ KEYSTOREFILE }} \
        makecapk.apk
    rm -f res.apk manifest.apk
    rm -rf makecapk
