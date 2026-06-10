# Deployment Guide

## Purpose

This guide records the Qt 6/CMake deployment-relevant configuration for the TestAdmob sample.

## Prerequisites

| Requirement | Notes |
| --- | --- |
| Qt 6 desktop kit | Required for desktop configure/build. |
| Qt 6 Android kit | Required for Android package builds. |
| CMake | Root build entry point is `CMakeLists.txt`. |
| JDK | Required by Android Gradle builds. |
| Android SDK and NDK | Export through `$ANDROID_HOME` and `$ANDROID_NDK_ROOT`. |
| Google Mobile Ads dependency access | Gradle resolves `com.google.android.gms:play-services-ads:23.6.0`. |

## Desktop Build

```bash
cmake -S . -B build -DCMAKE_BUILD_TYPE=Debug
cmake --build build --parallel
```

If a GUI/display environment is available, run the built `TestAdmob` executable and confirm `qrc:/main.qml` loads without QML import errors.

## Android Configuration

| Setting | Value |
| --- | --- |
| Manifest | `android/AndroidManifest.xml` |
| Activity | `org.qtproject.qt.android.bindings.QtActivity` |
| Application | `org.qtproject.qt.android.bindings.QtApplication` |
| Package | `org.qtproject.example` |
| Repositories | `google()`, `mavenCentral()` |
| Android Gradle plugin | `com.android.tools.build:gradle:8.13.1` |
| AndroidX core | `androidx.core:core:1.16.0` |
| Ads SDK | `com.google.android.gms:play-services-ads:23.6.0` |
| Native library packaging | `useLegacyPackaging` falls back to `true` when Qt does not expose `legacyPackaging`. |
| Permissions | `INTERNET`, `ACCESS_NETWORK_STATE` |
| AdMob app metadata | `com.google.android.gms.ads.APPLICATION_ID` with Google sample app id |

## Android Build Outline

1. Export `$ANDROID_HOME` and `$ANDROID_NDK_ROOT` for the local Android SDK/NDK.
2. Configure with the Qt Android kit toolchain and host Qt path.
3. Build the default Android target or `apk` target if exposed by the kit.
4. Confirm the debug APK is created under `build/android-arm64/android-build/build/outputs/apk/debug/android-build-debug.apk`.
5. Run on a test device and confirm sample ads load with test IDs.

## Manifest Gates

Generated Android package output should meet these gates:

- Contains `com.google.android.gms.ads.APPLICATION_ID`.
- Does not contain `com.gmail.manhcuong5993.QtAdMobActivity`.
- Does not contain `org.qtproject.qt5`.
- Does not contain `WRITE_EXTERNAL_STORAGE`.
- Includes merged `com.qtadmob` Java/proguard content from `Admob/Platform/Android/`.

## Ad Configuration

The demo uses Google sample ad unit IDs in `main.qml` and Google sample app id metadata in `android/AndroidManifest.xml`. Keep sample IDs for public builds and documentation. For production forks, replace IDs only in private application code and verify app-level AdMob metadata requirements with current Google Mobile Ads documentation.

## Release Safety Checklist

- Do not commit production AdMob app IDs or ad unit IDs.
- Do not commit signing keys, keystore paths, or keystore passwords.
- Keep local SDK/NDK paths out of committed documentation.
- Confirm ads are initialized according to the Google Mobile Ads SDK version in use.
- Record Android prerequisite failures separately from project package failures.

## Troubleshooting

| Symptom | Likely Cause | Next Step |
| --- | --- | --- |
| CMake cannot find Qt modules | Qt 6 kit missing `Core`, `Gui`, `Quick`, or `QuickControls2`. | Configure with a complete Qt 6 kit. |
| QML fails to load | Resource path or import mismatch. | Confirm `qml.qrc` embeds `main.qml` and QML imports `AdMob 1.0`. |
| Gradle cannot resolve dependencies | Network or Maven repository access issue. | Confirm access to `google()` and `mavenCentral()`. |
| AGP requires a newer Gradle wrapper | AGP version is too new for Qt-generated wrapper. | Keep AGP aligned with Qt wrapper; validated combination is AGP `8.13.1` with Gradle `8.14.2`. |
| AndroidX requires newer compile SDK | AndroidX dependency is too new for Qt kit compile SDK. | Keep AndroidX core at `1.16.0` for API 35 kits unless the kit moves to API 36+. |
| Android configure fails before package build | Missing Qt Android kit, SDK, NDK, or JDK. | Fix prerequisites, then rerun Android configure. |
| Ads do not show | SDK setup, device, manifest, or test ID issue. | Confirm sample IDs, internet permission, app id metadata, and test device setup. |
