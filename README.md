# weam

A new Flutter project.

## iOS Release / App Store Build

1. Ensure version in `pubspec.yaml` is updated (format: `x.y.z+build`).
2. Add a valid `ios/Runner/GoogleService-Info.plist` from Firebase Console (do not use placeholders in production).
3. Apple Pay: Merchant ID entitlement is in `ios/Runner/Runner.entitlements`; confirm merchant active in Apple Developer portal.
4. Codemagic Workflows:
	- Unsigned: `ios_release`
	- Signed (TestFlight/App Store): `ios_appstore_signed`
5. Environment groups (Codemagic):
	- `app_store_connect`: `APP_STORE_CONNECT_API_KEY`, `APP_STORE_CONNECT_KEY_ID`, `APP_STORE_CONNECT_ISSUER_ID`
	- `signing`: distribution certificate (p12 + password) & provisioning profile.
6. Export options: `ios/exportOptions.plist` (method `app-store`).
7. Trigger build: run `ios_appstore_signed`; it sets build number and archives.
8. If archive fails: review the "Show archive logs" step output in Codemagic and share last ~40 lines.

## Payment Environment

Production mode is active (`isTestMode: false`). To test in sandbox, flip `isTestMode: true` in your credentials and rebuild (do not ship sandbox).

## Common iOS Build Issues

- Missing `GoogleService-Info.plist`: Add the real file (Firebase initialization depends on it).
- Pod platform mismatch: Target iOS 15.0 enforced in `Podfile` and CI podspec patch step.
- Archive failure without clear cause: Re-run signed workflow; diagnostics step will print tail of logs.
- Privacy manifest warnings (`xcprivacy`): Currently non-blocking; keep dependencies updated.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
