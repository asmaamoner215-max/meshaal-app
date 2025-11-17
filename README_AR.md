# 🏥 Meshaal - Medical Services Mobile Application

تطبيق جوال متخصص في خدمات الاستشارات الطبية والخدمات الصحية.

## 📋 نظرة عامة

**Meshaal** هو تطبيق Flutter متقدم يربط بين المستخدمين والمتخصصين الطبيين، مع دعم:
- تسجيل الدخول والمصادقة
- خدمات طبية متعددة
- خريطة تفاعلية (Google Maps)
- نظام الطلبات والتتبع
- إدارة المحفظة الرقمية
- دعم اللغة العربية

## 🔧 متطلبات الإنشاء

### الإصدارات المطلوبة
```
Flutter: >=3.3.0
Dart: >=3.3.0 <4.0.0
Java: 17
Gradle: 8.11.1
iOS: 12.0+
Android: 24+
Xcode: 15.0+ (iOS)
```

### التثبيت المسبق

```bash
# تثبيت Flutter
git clone https://github.com/flutter/flutter.git

# تثبيت التبعيات
flutter pub get

# قبول رخصة Android
flutter doctor --android-licenses

# التحقق من الإعدادات
flutter doctor
```

## 📦 البنية الرئيسية

```
lib/
├── core/                      # الأساسيات المشتركة
│   ├── app_router/           # نظام التوجيه
│   ├── app_theme/            # المواضيع والألوان
│   ├── cache_helper/         # الذاكرة المحلية
│   ├── constants/            # الثوابت
│   ├── enums/                # التعريفات
│   ├── error/                # معالجة الأخطاء
│   ├── network/              # الاتصال بـ API
│   ├── notification/         # الإشعارات
│   └── services/             # الخدمات المشتركة
│
├── features/                  # الميزات الرئيسية
│   ├── auth/                 # المصادقة والتسجيل
│   │   ├── buisness_logic/   # Cubits و States
│   │   ├── data/             # Models و Data Sources
│   │   └── presentation/     # Screens و Widgets
│   │
│   ├── user/                 # نافذة المستخدم
│   │   ├── buisness_logic/
│   │   ├── data/
│   │   └── presentation/
│   │
│   ├── vendor/               # نافذة المتخصص
│   │   ├── buisness_logic/
│   │   ├── data/
│   │   └── presentation/
│   │
│   └── shared_widget/        # الـ Widgets المشتركة
│
├── main.dart                  # نقطة الدخول
└── bloc_observer.dart        # مراقب BLoC
```

## 🚀 تشغيل التطبيق

### Android

```bash
# Debug APK
flutter build apk --debug

# Release APK
flutter build apk --release

# تثبيت وتشغيل
flutter run -d <device_id>
```

### iOS

```bash
# Build iOS
flutter build ios --release

# تثبيت على المحاكى
open ios/Runner.xcworkspace
# ثم Build & Run من Xcode
```

## 🔐 إعداد Firebase

### خطوات الإعداد

1. **إنشاء مشروع Firebase:**
   - اذهب إلى https://console.firebase.google.com
   - اضغط "Create Project"
   - سمِّ المشروع "Meshaal"

2. **إضافة تطبيق Android:**
   - Package name: `com.ocoda.weam`
   - تحميل `google-services.json` في `android/app/`

3. **إضافة تطبيق iOS:**
   - Bundle ID: `com.ocoda.weam`
   - تحميل `GoogleService-Info.plist` في `ios/Runner/`

4. **تفعيل الخدمات:**
   - Authentication (Email/Password, Phone)
   - Firestore Database
   - Cloud Storage
   - Cloud Functions

## 🔑 إعداد المفاتيح

### Android Signing

```bash
# إنشاء مفتاح جديد (إذا لم يكن موجود)
keytool -genkey -v -keystore upload-keystore.jks \
  -keyalg RSA -keysize 2048 -validity 10000 \
  -alias upload

# ملف key.properties
storeFile=../upload-keystore.jks
storePassword=YOUR_PASSWORD
keyAlias=upload
keyPassword=YOUR_PASSWORD
```

### iOS Signing

1. فتح `ios/Runner.xcworkspace` في Xcode
2. اختر Runner project
3. اختر Runner target
4. اذهب إلى Signing & Capabilities
5. اختر team ID الخاص بك
6. تأكد من Bundle ID: `com.ocoda.weam`

## 🏗️ البناء والنشر

### عبر Codemagic CI/CD

#### الخطوة 1: ربط GitHub
```
1. اذهب https://codemagic.io
2. اختر GitHub
3. اختر meshaal-app repository
```

#### الخطوة 2: إعدادات البناء
```
- Workflow: codemagic.yaml
- Build Triggers: main branch
- Environment: Latest versions
```

#### الخطوة 3: إضافة البيانات الحساسة

في Codemagic → Environment Variables:
```
GOOGLE_PLAY_CREDENTIALS=base64_encoded_key
APP_STORE_CONNECT_PRIVATE_KEY=base64_encoded_key
APP_STORE_CONNECT_KEY_ID=key_id
APP_STORE_CONNECT_ISSUER_ID=issuer_id
```

### النشر على App Store

```bash
# 1. إنشاء تطبيق في App Store Connect
# 2. تحميل الـ TestFlight build
# 3. إكمال معلومات التطبيق
# 4. إرسال للمراجعة

flutter build ios --release
```

### النشر على Google Play

```bash
# 1. إنشاء تطبيق في Google Play Console
# 2. تحميل build على Beta channel
# 3. اختبار مع مجموعة محدودة
# 4. التوسع التدريجي

flutter build appbundle --release
```

## 🧪 الاختبار

```bash
# تشغيل اختبارات الوحدة
flutter test

# اختبار الأداء
flutter run --profile

# اختبار التغطية
flutter test --coverage

# تحليل الأخطاء
flutter analyze
```

## 🐛 استكشاف الأخطاء

### مشاكل شائعة

#### خطأ Gradle
```bash
# تنظيف وإعادة بناء
flutter clean
flutter pub get
flutter pub upgrade
flutter build apk --verbose
```

#### خطأ Firebase
```bash
# تحديث google-services.json
# تحديث GoogleService-Info.plist
# تحقق من أن الخدمات مفعلة في Firebase Console
```

#### خطأ iOS Signing
```bash
# تحديث الشهادة
# تجديد Provisioning Profile
# تحديث Team ID
```

## 📱 الميزات

### للمستخدم
- ✅ تسجيل دخول بسيط وآمن
- ✅ اختيار الخدمات الطبية
- ✅ عرض توفر الأطباء على الخريطة
- ✅ حجز الخدمات
- ✅ دفع آمن
- ✅ تتبع الطلبات

### للمتخصص
- ✅ إدارة الطلبات الواردة
- ✅ تحديد الموقع الحالي
- ✅ إرسال التحديثات
- ✅ إدارة الملف الشخصي

## 🌐 الدعم متعدد اللغات

التطبيق يدعم:
- العربية (ar) - اللغة الأساسية
- الإنجليزية (en)

الملفات:
```
assets/translations/
├── ar.json
└── en.json
```

## 📞 الاتصال والدعم

- **البريد الإلكتروني**: dev@meshaal.app
- **موقع الويب**: https://meshaal.app
- **GitHub**: https://github.com/asmaamoner215-max/meshaal-app

## 📄 الترخيص

هذا المشروع مرخص تحت [أضف نوع الترخيص].

## 🙏 شكر خاص

- Flutter Team
- Firebase
- Google Maps
- المساهمين في المكتبات المستخدمة

---

**آخر تحديث:** نوفمبر 2025  
**الإصدار:** 1.0.2+7

