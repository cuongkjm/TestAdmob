# Code Standards

## Scope

These standards apply to the root TestAdmob sample. The `Admob/` subdirectory has its own documentation and may use different Qt/CMake conventions.

## Guiding Principles

- Keep the sample small and direct.
- Prefer verified behavior over speculative abstractions.
- Use Qt 6 and CMake as the only supported root build path.
- Use Google sample ad unit IDs and sample app IDs for demo and development documentation.

## Project Structure Standards

| Area | Standard |
| --- | --- |
| Root app entry | Keep startup logic in `main.cpp`. |
| QML demo UI | Keep sample ad wiring in `main.qml` unless the UI grows enough to justify components. |
| QML resources | Register QML files through `qml.qrc`. |
| Root build | Keep root build configuration in `CMakeLists.txt`. |
| Android packaging | Keep app-owned manifest and Gradle metadata under `android/`. |
| Library code | Keep reusable AdMob implementation under `Admob/`; do not duplicate it in the root sample. |
| Documentation | Keep root project docs under `docs/`; update `README.md` only for entry-point guidance. |

## C++ Standards

- Register QML-facing types before loading QML.
- Register root sample ad types under `AdMob 1.0`.
- Keep `main.cpp` limited to application setup and engine loading.
- Avoid adding production logic to the demo entry point.

## QML Standards

- Use Qt 6-compatible imports and Qt Quick Controls 2 patterns.
- Keep ad object IDs descriptive, such as `banner_ad`, `interstitial_ad`, and `video_ad`.
- Use Google sample ad unit IDs in committed demo code.
- Keep lifecycle callbacks visible in the demo so behavior is easy to inspect.
- Avoid hiding key demo calls behind unnecessary helper layers.
- If QML grows, split by semantic UI sections rather than by arbitrary line count.

## Android Standards

- Keep app-owned Android package metadata under root `android/`.
- Keep reusable AdMob Java/proguard bridge files under `Admob/Platform/Android/`.
- Configure the root Android package source before calling `qtadmob_configure_android_target(TestAdmob)`.
- Use `com.google.android.gms.ads.APPLICATION_ID` with a Google sample app id in committed demo metadata.
- Do not commit production AdMob IDs, signing files, keystores, or passwords.
- Keep permissions minimal; the demo allows `INTERNET` and `ACCESS_NETWORK_STATE`.
- Document dependency upgrades before changing Android Gradle plugin or Google Mobile Ads versions.

## Documentation Standards

- Keep each doc under 800 lines.
- Link only to existing documentation files.
- Use `$ANDROID_HOME` and `$ANDROID_NDK_ROOT` instead of local absolute SDK/NDK paths.
- Use tables for quick reference and short sections for maintainability.
- Update `docs/codebase-summary.md` after material source layout changes.

## Build and Validation Standards

- For code changes, run the most specific available build or syntax check.
- For documentation-only changes, validate links and file sizes where possible.
- Treat `TestAdmob.pro.user` as local IDE state, not a build contract.
- Report Android prerequisite failures separately from project packaging failures.

## Security and Privacy Standards

- Do not commit production AdMob app IDs, ad unit IDs, signing keys, keystores, or credentials.
- Use sample ad IDs from Google documentation for public examples.
- Review generated repository packs before sharing outside the project.
- Keep `.env`, signing, and local machine paths out of documentation unless sanitized.
