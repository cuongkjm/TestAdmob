# System Architecture

## Overview

TestAdmob is a Qt 6 Quick sample that connects QML UI controls to native AdMob wrappers supplied by the `Admob/` library. The root app is intentionally thin: C++ registers QML types, QML drives demo interactions, and platform code lives behind the `Admob/` library boundary.

## High-Level Layers

| Layer | Files | Responsibility |
| --- | --- | --- |
| App bootstrap | `main.cpp` | Start Qt app, register ad QML types, load QML. |
| Demo UI | `main.qml` | Configure ad units, trigger loads/shows, display callback status. |
| Resource packaging | `qml.qrc` | Embed `main.qml` under `qrc:/main.qml`. |
| Build configuration | `CMakeLists.txt` | Configure Qt 6 root executable and link `QtAdMob::qtadmob`. |
| Android package | `android/` | Qt 6 package source with manifest and Gradle dependency metadata. |
| AdMob library | `Admob/` | QML-facing ad classes and platform integrations. |

## Startup Sequence

```text
main.cpp
  -> QGuiApplication
  -> qmlRegisterType(..., "AdMob", 1, 0, ...)
  -> QQmlApplicationEngine loads qrc:/main.qml
  -> main.qml creates ad objects
  -> Component.onCompleted loads ads
```

## QML Interaction Flow

| Interaction | Flow |
| --- | --- |
| Banner load | `Component.onCompleted` calls `banner_ad.loadBanner()`. |
| Interstitial load | `Component.onCompleted` calls `interstitial_ad.loadInterstitialAd()`. |
| Interstitial show | Button click calls `interstitial_ad.showInterstitialAd()`. |
| Rewarded load | `Component.onCompleted` calls `video_ad.loadRewardedVideoAd()`. |
| Rewarded show | Button click calls `video_ad.show()`. |
| Status updates | QML callback handlers update text fields for loaded, closed, and failed states. |

## Build Architecture

`CMakeLists.txt` uses Qt 6 CMake APIs, adds `Admob/`, creates the explicit `TestAdmob` executable target, embeds `qml.qrc`, links `QtAdMob::qtadmob`, sets `QT_ANDROID_PACKAGE_SOURCE_DIR` to `android/` for Android, then calls `qtadmob_configure_android_target(TestAdmob)`.

`Admob/` remains the library boundary. Root code does not duplicate reusable ad implementation files.

## Android Packaging Architecture

| File | Responsibility |
| --- | --- |
| `android/AndroidManifest.xml` | Declares package, Qt 6 app/activity classes, permissions, and AdMob application id metadata. |
| `android/build.gradle` | Uses Qt Android deployment variables and declares AGP `8.13.1`, AndroidX core `1.16.0`, and Google Mobile Ads `23.6.0`. |
| `Admob/Platform/Android/` | Supplies `com.qtadmob` Java bridge sources and `proguard-rules.pro`. |

The root Android package source is merged with `Admob/Platform/Android/` by `qtadmob_configure_android_target(TestAdmob)`. The root keeps app-owned manifest/dependency metadata; the library keeps reusable Java/proguard bridge files.

## Architecture Caveats

- Android package validation passed with a configured Qt 6.10 Android arm64 kit, JDK, SDK, and NDK.
- Desktop platforms compile with no-op ad methods supplied by `Admob/`.
- The demo uses sample IDs and compact layout; production apps need private IDs and app-specific UX review.
