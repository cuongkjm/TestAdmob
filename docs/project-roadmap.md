# Project Roadmap

## Current Status

| Area | Status | Notes |
| --- | --- | --- |
| Demo app | Modernized | Qt 6 QML sample loads three ad formats through `AdMob 1.0`. |
| Build compatibility | Modernized | Root build uses CMake and `QtAdMob::qtadmob`; qmake is removed. |
| Android package source | Modernized | Root `android/` owns Qt 6 manifest/dependency metadata; `Admob/` helper merges Java/proguard files. |
| Root documentation | Updated | Core docs describe Qt 6/CMake workflow. |
| Validation | Passed | Desktop build and Qt 6.10 Android arm64 package build are recorded. |

## Phase 1: Qt 6 CMake Migration

| Item | Goal | Status |
| --- | --- | --- |
| Replace qmake build | Add root `CMakeLists.txt` and remove `TestAdmob.pro`. | Complete |
| Modernize QML imports | Use Qt 6-compatible imports and Controls 2. | Complete |
| Align AdMob QML URI | Register root sample types under `AdMob 1.0`. | Complete |
| Keep resource path stable | Preserve `qml.qrc` and `qrc:/main.qml`. | Complete |

## Phase 2: Android Package Alignment

| Item | Goal | Status |
| --- | --- | --- |
| Remove legacy Qt5 activity bridge | Use Qt 6 activity and `Admob/Platform/Android` library bridge. | Complete |
| Update AdMob metadata | Use `APPLICATION_ID` with Google sample app id. | Complete |
| Remove stale permissions/deps | Remove storage permission, `jcenter()`, AGP `3.2.0`, and ads `17.1.1`. | Complete |
| Validate Android package | Configure/package with Qt 6.10 Android arm64 kit and produce debug APK. | Complete |

## Phase 3: Improve Demo Quality

| Item | Goal | Status |
| --- | --- | --- |
| Layout resilience | Refine demo placement if runtime testing shows issues. | Backlog |
| Callback coverage | Display more lifecycle states consistently for all ad formats. | Backlog |
| Setup guide validation | Record verified Qt 6.10 Android arm64 build result and dependency alignment. | Complete |

## Maintenance Rules

- Update this roadmap when validation status changes.
- Record dependency upgrades in this file and `docs/deployment-guide.md`.
- Keep roadmap items scoped to the sample app unless a change directly affects root integration.

## Open Questions

- Which Qt 6 minor version should be treated as official support target beyond the validated Qt 6.10 Android arm64 kit?
- Should Android package success be a hard gate for this repo or best-effort based on local kit availability?
