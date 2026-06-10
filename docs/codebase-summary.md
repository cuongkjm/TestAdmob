# Codebase Summary

Generated from the current checkout using visible source, Android, and `Admob/` files.

## Repository Snapshot

| Metric | Value |
| --- | --- |
| Root source files | `CMakeLists.txt`, `main.cpp`, `main.qml`, `qml.qrc` |
| Android files | Manifest and Gradle package-source metadata under `android/` |
| Library path | `Admob/` submodule/subdirectory |
| Root docs status | Updated for Qt 6/CMake modernization |

## Primary Components

| Path | Role |
| --- | --- |
| `README.md` | Root project orientation and documentation index. |
| `CMakeLists.txt` | Qt 6 CMake project, root executable, Qt module links, AdMob helper integration. |
| `main.cpp` | Creates `QGuiApplication`, registers ad QML types under `AdMob 1.0`, loads `qrc:/main.qml`. |
| `main.qml` | Qt Quick Controls 2 demo UI for banner, interstitial, and rewarded video ads. |
| `qml.qrc` | Qt resource collection containing `main.qml`. |
| `android/AndroidManifest.xml` | Qt 6 Android package metadata, permissions, Qt activity, AdMob app id. |
| `android/build.gradle` | Qt 6 Android Gradle template with Google Mobile Ads dependency. |
| `Admob/` | AdMob library submodule/subdirectory used by the sample. |

## Runtime Flow

1. `main.cpp` starts `QGuiApplication`.
2. C++ registers `QmlBanner`, `QmlInterstitialAd`, and `QmlRewardedVideoAd` under `AdMob 1.0`.
3. `QQmlApplicationEngine` loads `qrc:/main.qml` from `qml.qrc`.
4. `main.qml` instantiates ad objects and configures Google sample ad unit IDs.
5. `Component.onCompleted` calls `loadBanner()`, `loadInterstitialAd()`, and `loadRewardedVideoAd()`.
6. Button clicks call `showInterstitialAd()` and `video_ad.show()`.
7. Platform callbacks return ad lifecycle state to C++ and QML.

## Android Configuration

| Setting | Current Value |
| --- | --- |
| Manifest package | `org.qtproject.example` |
| Activity class | `org.qtproject.qt.android.bindings.QtActivity` |
| Application class | `org.qtproject.qt.android.bindings.QtApplication` |
| Permissions | `INTERNET`, `ACCESS_NETWORK_STATE` |
| Google metadata | `com.google.android.gms.ads.APPLICATION_ID` with Google sample app id |
| Android Gradle plugin | `com.android.tools.build:gradle:8.13.1` |
| AndroidX core | `androidx.core:core:1.16.0` |
| Ads dependency | `com.google.android.gms:play-services-ads:23.6.0` |

## Ad Format Matrix

| Format | QML Type | Load Method | Show Method | Sample Unit ID |
| --- | --- | --- | --- | --- |
| Banner | `QmlBanner` | `loadBanner()` | Visible overlay | `ca-app-pub-3940256099942544/6300978111` |
| Interstitial | `QmlInterstitialAd` | `loadInterstitialAd()` | `showInterstitialAd()` | `ca-app-pub-3940256099942544/1033173712` |
| Rewarded video | `QmlRewardedVideoAd` | `loadRewardedVideoAd()` | `show()` | `ca-app-pub-3940256099942544/5224354917` |

## Notable Caveats

- `TestAdmob.pro.user` is local Qt Creator state and should not be treated as source-of-truth documentation.
- Android package validation passed with a local Qt 6.10 Android arm64 kit, SDK, NDK, and JDK.
- Production forks must replace sample ad ids privately and never commit signing credentials.
