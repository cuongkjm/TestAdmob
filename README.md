# TestAdmob

TestAdmob is a small Qt 6 Quick sample application that demonstrates using the [`cuongkjm/Admob`](https://github.com/cuongkjm/Admob) library from QML through CMake.

The app registers QML ad types in C++, loads `main.qml` from `qml.qrc`, and shows Google sample ad units for:

- Banner ads through `QmlBanner`
- Interstitial ads through `QmlInterstitialAd`
- Rewarded video ads through `QmlRewardedVideoAd`

## Repository Layout

| Path | Purpose |
| --- | --- |
| `CMakeLists.txt` | Qt 6 CMake entry point for the root sample. |
| `main.cpp` | Qt application entry point and `AdMob 1.0` QML type registration. |
| `main.qml` | Demo UI and ad lifecycle callback wiring. |
| `qml.qrc` | Qt resource file embedding `main.qml` at `qrc:/main.qml`. |
| `android/` | Qt 6 Android package source for manifest and Gradle dependency metadata. |
| `Admob/` | AdMob integration library submodule/subdirectory. |
| `docs/` | Root project documentation. |

## Current Demo Behavior

- Loads banner, interstitial, and rewarded ads on `Component.onCompleted`.
- Uses Google sample ad unit IDs from the official test ads documentation.
- Uses one hard-coded `testDeviceId` for all ad formats.
- Updates status text when interstitial and rewarded video callbacks fire.

## Desktop Build

```bash
cmake -S . -B build -DCMAKE_BUILD_TYPE=Debug
cmake --build build --parallel
```

If a GUI/display environment is available, run the built `TestAdmob` executable and confirm `qrc:/main.qml` loads without QML import errors.

## Android Notes

The Android package configuration is under `android/`:

- Activity: `org.qtproject.qt.android.bindings.QtActivity`
- App class: `org.qtproject.qt.android.bindings.QtApplication`
- AdMob metadata: `com.google.android.gms.ads.APPLICATION_ID` with Google sample app id
- Permissions: `INTERNET`, `ACCESS_NETWORK_STATE`
- Android Gradle plugin: `com.android.tools.build:gradle:8.13.1`
- AndroidX core: `androidx.core:core:1.16.0`
- Google ads dependency: `com.google.android.gms:play-services-ads:23.6.0`

Android builds need a Qt 6 Android kit, JDK, `$ANDROID_HOME`, and `$ANDROID_NDK_ROOT`. The validated Qt 6.10 Android arm64 build creates `build/android-arm64/android-build/build/outputs/apk/debug/android-build-debug.apk`. The root CMake target sets `QT_ANDROID_PACKAGE_SOURCE_DIR` to `android/`, then `qtadmob_configure_android_target(TestAdmob)` merges `Admob/Platform/Android` Java and proguard files.

## Documentation

- [Project Overview and PDR](docs/project-overview-pdr.md)
- [Codebase Summary](docs/codebase-summary.md)
- [Code Standards](docs/code-standards.md)
- [System Architecture](docs/system-architecture.md)
- [Project Roadmap](docs/project-roadmap.md)
- [Deployment Guide](docs/deployment-guide.md)
- [Design Principles](docs/design-system/design-principles.md)

Original usage video: https://www.youtube.com/watch?v=YsVkE4ifU_4
