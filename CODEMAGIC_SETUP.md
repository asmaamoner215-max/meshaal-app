# Codemagic Setup Guide - Meshaal App

## 📱 معلومات التطبيق الأساسية

```
App Name: Meshaal (ميشعل)
Package Name (Android): com.ocoda.weam
Bundle ID (iOS): com.ocoda.weam (سيتم تعديله)
Version: 1.0.2
Build Number: 7
Language: Flutter
SDK: >=3.3.0 <4.0.0
Min Flutter Version: 3.3.0
```

## 🏗️ متطلبات البناء

### Android Build Configuration
```
Gradle Version: 8.11.1
AGP (Android Gradle Plugin): 8.9.1
Compile SDK: 36
Min SDK: 24
Target SDK: 36
Java Version: 17
Kotlin Version: 1.7.10
```

### iOS Build Configuration
```
iOS Deployment Target: 12.0 (أو أحدث)
Xcode Workspace: ios/Runner.xcworkspace
Scheme: Runner
Configuration: Release
```

## 🔐 البيانات الحساسة المطلوبة

### 1. Firebase Configuration Files

**الملف الأول:** `android/app/google-services.json`
```
⚠️ يجب تحميل هذا الملف من Firebase Console
الخطوات:
1. اذهب إلى: https://console.firebase.google.com
2. اختر مشروعك
3. اذهب إلى Project Settings
4. اختر Android app
5. حمّل google-services.json
6. ضعه في: android/app/
```

**الملف الثاني:** `ios/Runner/GoogleService-Info.plist`
```
⚠️ يجب تحميل هذا الملف من Firebase Console
الخطوات:
1. اذهب إلى: https://console.firebase.google.com
2. اختر مشروعك
3. اذهب إلى Project Settings
4. اختر iOS app
5. حمّل GoogleService-Info.plist
6. ضعه في: ios/Runner/
```

### 2. iOS Signing Certificate & Provisioning Profile

**أ) إنشاء الشهادات:**
```
1. اذهب إلى: https://developer.apple.com/account/
2. اختر Certificates, Identifiers & Profiles
3. إنشاء:
   - Distribution Certificate (لـ App Store)
   - App ID: com.ocoda.weam
   - Provisioning Profile (distribution)
```

**ب) تحميل الملفات في Codemagic:**
```
- Distribution Certificate (.p7b أو .cer)
- Private Key (.p8)
- Provisioning Profile (.mobileprovision)
```

### 3. Apple Developer Account Credentials

```
Apple ID: [بريدك الإلكتروني المسجل لدى Apple]
App-Specific Password: [password للـ CI/CD]

كيفية الحصول على App-Specific Password:
1. اذهب إلى: https://appleid.apple.com/account/manage
2. Security → App-Specific Passwords
3. اختر "App Store Connect"
4. استخدم كلمة المرور المولدة
```

### 4. GitHub Personal Access Token

```
⚠️ اختياري - إذا أردت ربط البيانات برفعات GitHub
الخطوات:
1. اذهب إلى GitHub Settings → Developer settings → Personal access tokens
2. Generate new token
3. اختر الصلاحيات: repo, workflow
4. استخدم الـ token في Codemagic
```

## 📋 Environment Variables المطلوبة

في Codemagic → Environment Variables، أضف:

```bash
# Firebase
FIREBASE_PROJECT_ID=your_firebase_project_id
FIREBASE_API_KEY=your_firebase_api_key

# Apple Developer
APPLE_ID_EMAIL=your_apple_id@example.com
APPLE_ID_PASSWORD=your_app_specific_password

# Optional - GitHub
GITHUB_TOKEN=your_github_token
```

## 🔑 المفاتيح والشهادات المطلوبة

### 1. Android Signing Key (موجود بالفعل)
```
Location: android/upload-keystore.jks
Key Alias: upload
Key Password: [كلمة المرور الخاصة بك]
Store Password: [كلمة المرور الخاصة بك]
```

**ملف key.properties:**
```properties
storeFile=../upload-keystore.jks
storePassword=YOUR_STORE_PASSWORD
keyAlias=upload
keyPassword=YOUR_KEY_PASSWORD
```

### 2. iOS Signing

**يجب إعداد:**
```
1. Development Team ID
2. Bundle ID: com.ocoda.weam
3. Signing Certificate
4. Provisioning Profile
```

## 🚀 خطوات الإعداد في Codemagic

### الخطوة 1: الربط بـ GitHub
```
1. اذهب إلى https://codemagic.io/login
2. اختر GitHub
3. اختر: asmaamoner215-max/meshaal-app
4. اختر Connect
```

### الخطوة 2: إعدادات Android Build
```
1. في Codemagic → Build configuration
2. اختر Android
3. ضع البيانات التالية:

Android Signing:
- Key store file: upload-keystore.jks
- Key store password: [من key.properties]
- Key alias: upload
- Key password: [من key.properties]

Build version:
- Version: 1.0.2
- Build number: 7

Environment variables:
- GOOGLE_SERVICES_JSON: [محتوى google-services.json]
```

### الخطوة 3: إعدادات iOS Build
```
1. اختر iOS
2. ضع البيانات التالية:

Code Signing:
- Provisioning Profile: [ملف .mobileprovision]
- Certificate: [ملف .p7b]
- Certificate Private Key: [ملف .p8]

Build configuration:
- Workspace: ios/Runner.xcworkspace
- Scheme: Runner
- Configuration: Release

Code Signing Identity:
- Distribution

Environment variables:
- GOOGLE_SERVICE_INFO_PLIST: [محتوى GoogleService-Info.plist]
```

### الخطوة 4: Post-build Actions
```
1. في Publishing section:
   - Upload to App Store Connect (iOS)
   - Google Play Console (Android)

2. أضف Webhook للإشعارات:
   - Slack integration (اختياري)
   - Email notifications
```

## 📦 الملفات والمتطلبات النهائية

| الملف | المسار | الملاحظات |
|------|--------|---------|
| google-services.json | android/app/ | ضروري للـ Android |
| GoogleService-Info.plist | ios/Runner/ | ضروري للـ iOS |
| upload-keystore.jks | android/ | موجود بالفعل |
| key.properties | android/ | موجود بالفعل |
| Provisioning Profile | في Codemagic | للـ iOS Distribution |
| Certificate | في Codemagic | للـ iOS Distribution |

## 🔧 Dependencies المهمة

```yaml
firebase_core: ^4.2.1
google_maps_flutter: ^2.14.0
geolocator: ^14.0.2
flutter_local_notifications: ^19.5.0
flutter_bloc: ^8.1.6
easy_localization: ^3.0.4
image_picker: ^1.2.1
```

## ⚠️ ملاحظات مهمة

1. **Firebase**: تأكد من تفعيل جميع الخدمات اللي تستخدمها في Firebase Console
2. **iOS Signing**: قد يستغرق اعتماد الشهادة 24-48 ساعة من Apple
3. **Provisioning Profile**: يجب تحديثه كل سنة
4. **Privacy**: لا تنشر أي بيانات حساسة في الـ repo (استخدم Environment Variables)
5. **Testing**: اختبر البناء محلياً أولاً قبل دفعه إلى Codemagic

## 📝 Codemagic Configuration File (إضافي)

يمكنك إنشاء ملف `codemagic.yaml` في جذر المشروع:

```yaml
workflows:
  ios-release:
    name: iOS Release Build
    environment:
      ios: latest
      xcode: latest
      flutter: stable
    triggering:
      events:
        - push
      branch_patterns:
        - pattern: 'main'
    scripts:
      - flutter pub get
      - flutter build ios --release
    artifacts:
      - build/ios/ipa/*.ipa
    publishing:
      app_store_connect:
        auth: integration

  android-release:
    name: Android Release Build
    environment:
      android: latest
      java: 17
    triggering:
      events:
        - push
      branch_patterns:
        - pattern: 'main'
    scripts:
      - flutter pub get
      - flutter build apk --release
    artifacts:
      - build/app/outputs/flutter-apk/*.apk
    publishing:
      google_play:
        credentials: $GOOGLE_PLAY_CREDENTIALS
```

## ✅ Checklist قبل البدء

- [ ] تم تحميل google-services.json
- [ ] تم تحميل GoogleService-Info.plist
- [ ] تم إنشاء Apple Developer Account
- [ ] تم إنشاء Distribution Certificate
- [ ] تم إنشاء Provisioning Profile
- [ ] تم إعداد Firebase Project
- [ ] تم اختبار البناء محلياً
- [ ] تم دفع الكود إلى GitHub ✅
- [ ] تم ربط Codemagic بـ GitHub
- [ ] تم إضافة جميع البيانات الحساسة في Environment Variables

---

**للمساعدة والدعم:**
- Codemagic Docs: https://docs.codemagic.io
- Firebase Setup: https://firebase.google.com/docs/flutter/setup
- Apple Developer: https://developer.apple.com
