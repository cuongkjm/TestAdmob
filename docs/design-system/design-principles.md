# Design Principles

## Scope

This document describes the current demo UI principles for `main.qml`. It is not a full visual design system because the app is a compact AdMob integration sample.

## Current UI Goals

| Goal | Implementation |
| --- | --- |
| Demonstrate all supported ad formats | Banner, interstitial, and rewarded video objects are visible in one QML file. |
| Keep interactions obvious | Two buttons directly trigger interstitial and rewarded video display. |
| Show lifecycle feedback | Text fields display loaded, failed, and closed states for full-screen ads. |
| Use safe demo ads | Google sample ad unit IDs are hard-coded in the demo. |

## Layout Principles

- Keep the banner visible as an overlay near the bottom of the window.
- Keep full-screen ad triggers separated to the left and right for quick manual testing.
- Keep status text adjacent to the button that controls the related ad format.
- Prefer simple QML over reusable components until the demo needs multiple screens.

## Interaction Principles

| Interaction | Principle |
| --- | --- |
| Initial load | Load all demo ad formats after QML component completion. |
| Interstitial show | Use an explicit button so testers control when full-screen ads appear. |
| Rewarded show | Use an explicit button so reward flow remains observable. |
| Failure states | Surface error codes in text for quick debugging. |

## Content Principles

- Label buttons by action, such as `show interstitial ad` and `show video ad`.
- Keep status messages short and diagnostic.
- Avoid production marketing copy in the sample UI.
- Keep comments tied to useful external references, such as Google test ads documentation.

## Future Improvements

- Use adaptive layout if the sample evolves beyond a minimal demo.
- Add consistent callback status for banner events if manual validation requires it.
- Keep Qt Quick Controls usage simple unless the demo expands beyond one screen.
