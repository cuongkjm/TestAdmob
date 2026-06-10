# Project Overview and Product Development Requirements

## Purpose

TestAdmob is a Qt 6 Quick demonstration app for validating how the `Admob/` library exposes Google Mobile Ads formats to QML. It is intended as a compact integration sample, not a production app template.

## Product Scope

| Area | Current Scope |
| --- | --- |
| UI | One QML window with banner, interstitial, and rewarded video controls. |
| Ad formats | Banner, interstitial, rewarded video. |
| Platforms | Desktop compile/no-op behavior and Android package configuration. |
| Build system | Root project uses Qt 6 CMake through `CMakeLists.txt`. |
| Library integration | Root project links `QtAdMob::qtadmob` from `Admob/`. |

## Functional Requirements

| ID | Requirement | Current Evidence |
| --- | --- | --- |
| FR-001 | Register AdMob QML types before loading QML. | `main.cpp` registers `QmlBanner`, `QmlInterstitialAd`, and `QmlRewardedVideoAd` under `AdMob 1.0`. |
| FR-002 | Load the demo QML UI from Qt resources. | `main.cpp` loads `qrc:/main.qml`; `qml.qrc` embeds `main.qml`. |
| FR-003 | Display a banner ad in the demo window. | `main.qml` configures `QmlBanner` with Google sample banner unit ID. |
| FR-004 | Allow interstitial ad display from a button. | `main.qml` button calls `interstitial_ad.showInterstitialAd()`. |
| FR-005 | Allow rewarded video display from a button. | `main.qml` button calls `video_ad.show()`. |
| FR-006 | Surface ad lifecycle status to QML UI. | `main.qml` updates text for interstitial and rewarded video callbacks. |
| FR-007 | Provide Android AdMob bridge files. | `qtadmob_configure_android_target(TestAdmob)` merges `Admob/Platform/Android` package files. |

## Non-Functional Requirements

| ID | Requirement | Notes |
| --- | --- | --- |
| NFR-001 | Keep sample simple and readable. | Avoid production-only abstractions in this demo repository. |
| NFR-002 | Use test ads during development. | QML and Android manifest use Google sample ad IDs. |
| NFR-003 | Keep documentation synced with the actual checkout. | README and docs should describe CMake/Qt 6 only. |
| NFR-004 | Avoid committing local IDE state. | `TestAdmob.pro.user` is local Qt Creator configuration and should not drive docs or behavior. |
| NFR-005 | Avoid committing local machine paths. | Use `$ANDROID_HOME` and `$ANDROID_NDK_ROOT` in docs. |

## Acceptance Criteria

- A developer can identify the app entry point, QML demo file, Android package source, and AdMob submodule path.
- Docs explain the Qt 6 CMake sample workflow.
- Android ad permissions, app id metadata, and dependency versions are documented.
- Known validation caveats are visible before setup work begins.

## Constraints and Dependencies

| Dependency | Current Value |
| --- | --- |
| Qt project format | CMake with `CMakeLists.txt`. |
| QML imports | Unversioned Qt 6 imports plus `AdMob 1.0`. |
| Android Gradle plugin | Qt 6.11 template uses `com.android.tools.build:gradle:9.0.0`. |
| Google Mobile Ads Android SDK | `com.google.android.gms:play-services-ads:23.6.0`. |
| Android SDK/NDK | Provided by local `$ANDROID_HOME` and `$ANDROID_NDK_ROOT`. |

## Current Caveats

- Android validation depends on a configured Qt 6 Android kit, JDK, SDK, and NDK.
- Desktop ad methods are no-op behavior from `Admob/`; Android is required for real ad serving.
- Production forks must replace sample ad IDs privately and keep credentials out of git.
