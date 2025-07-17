# !!!This repo will have forced pushes!!!

# Intro

This repository contains all executable build tools that are required to make an android app.
This aims to be an alternative to Android Studio, whose installation size is huge and build times
very high.
Hence faster build times, and small installation sizes.

# Working
Inspired/Copied from [rawdrawandroid](https://github.com/cnlohr/rawdrawandroid).
A [NativeActivity](https://developer.android.com/reference/android/app/NativeActivity)
was the main thing that runs as the app.

# Usage
Install [just](https://github.com/casey/just),
although a Makefile is available alternatively, I'm not gonna maintain it.

```sh
just --summmary
```

## Keystore
Create a keystore file with `just keystore` or bring your own and rename the variable.

## apk
```sh
just apk
```

Look into the justfile to know what's happening.
Submit PRs to add some documentation.

## install
```sh
just install
# or
adb install ./makecapk.apk
```


# Outputs
Finally creates `makecapk.apk` as the usable/installable apk.
