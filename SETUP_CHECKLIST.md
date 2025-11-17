# 📋 Meshaal App - Codemagic Setup Complete Data Sheet

## ✅ تم إكمال الخطوات التالية:

1. ✅ **Git Repository**: تم ربط المستودع المحلي بـ GitHub
2. ✅ **Initial Commit**: تم حفظ 363 ملف من التطبيق
3. ✅ **Documentation**: تم إنشاء ملفات الإعداد الشاملة
4. ✅ **CI/CD Configuration**: تم إعداد codemagic.yaml

---

## 🔐 البيانات الحساسة المطلوبة (CRITICAL)

### 1️⃣ Android - Firebase Configuration

**الملف**: `android/app/google-services.json`

```
يمكنك تحميل هذا الملف من:
1. اذهب إلى https://console.firebase.google.com
2. اختر مشروعك
3. Project Settings → Android
4. حمّل google-services.json
5. ضعه في: android/app/
```

**المحتوى المتوقع:**
```json
{
  "type": "service_account",
  "project_id": "your-project-id",
  "private_key_id": "...",
  "private_key": "...",
  "client_email": "...",
  "client_id": "...",
  "auth_uri": "...",
  "token_uri": "..."
}
```

---

### 2️⃣ iOS - Firebase Configuration

**الملف**: `ios/Runner/GoogleService-Info.plist`

```
يمكنك تحميل هذا الملف من:
1. اذهب إلى https://console.firebase.google.com
2. اختر مشروعك
3. Project Settings → iOS
4. حمّل GoogleService-Info.plist
5. ضعه في: ios/Runner/
```

---

### 3️⃣ Android - Signing Credentials

**الملف**: `android/key.properties`

```properties
# ملف key.properties الموجود حالياً
storeFile=../upload-keystore.jks
storePassword=YOUR_STORE_PASSWORD
keyAlias=upload
keyPassword=YOUR_KEY_PASSWORD
```

**الملف الثاني**: `android/upload-keystore.jks`
- الملف موجود بالفعل
- لا تنشره على GitHub (موجود في .gitignore)

---

### 4️⃣ iOS - Apple Developer Credentials

**البيانات المطلوبة:**

```
1. Apple ID Email: your_email@example.com
2. App-Specific Password: [تم إنشاؤها من appleid.apple.com]
3. Team ID: XXXXXXXXXX (من Apple Developer Account)
4. Distribution Certificate (.p7b أو .cer)
5. Private Key (.p8)
6. Provisioning Profile (.mobileprovision)
```

**خطوات الحصول:**

```bash
# 1. إنشاء App-Specific Password
# اذهب إلى: https://appleid.apple.com/account/manage
# Security → App-Specific Passwords
# تحديد "App Store Connect" وإنشاء كلمة مرور

# 2. الحصول على Team ID
# اذهب إلى: https://developer.apple.com/account
# Membership → Team ID

# 3. إنشاء Distribution Certificate
# Certificates, Identifiers & Profiles → Certificates
# Click "Create Certificate"
# اختر "iOS Distribution"
# اتبع الخطوات

# 4. إنشاء Provisioning Profile
# Certificates, Identifiers & Profiles → Profiles
# Click "Create New"
# اختر "App Store"
# اختر App ID: com.ocoda.weam
# اختر Distribution Certificate
# تحميل الملف
```

---

## 🔧 إعدادات Codemagic

### الخطوة 1: ربط GitHub ✅ (تم)

```
Repository: https://github.com/asmaamoner215-max/meshaal-app
Branch: main
Configuration File: codemagic.yaml
```

### الخطوة 2: إضافة بيانات البناء

في Codemagic → Environment Variables، أضف:

```bash
# Google Play Credentials
GOOGLE_PLAY_CREDENTIALS=base64_encoded_json

# Apple Credentials
APP_STORE_CONNECT_PRIVATE_KEY=base64_encoded_p8
APP_STORE_CONNECT_KEY_ID=your_key_id
APP_STORE_CONNECT_ISSUER_ID=your_issuer_id

# Firebase (اختياري)
FIREBASE_PROJECT_ID=your_firebase_project_id
```

### الخطوة 3: تحميل الملفات

في Codemagic → Code Signing:

**للـ Android:**
```
1. Upload: upload-keystore.jks
2. Configure Keystore:
   - Keystore password: [من key.properties]
   - Key alias: upload
   - Key password: [من key.properties]
```

**للـ iOS:**
```
1. Upload Distribution Certificate (.p7b)
2. Upload Private Key (.p8)
3. Upload Provisioning Profile (.mobileprovision)
4. Configure:
   - Certificate Password: [إن وُجدت]
   - Team ID: [من Apple Developer Account]
```

---

## 📱 معلومات التطبيق الأساسية

```
Application Name: Meshaal (ميشعل)
Version: 1.0.2
Build Number: 7

Android:
├── Package Name: com.ocoda.weam
├── Compile SDK: 36
├── Min SDK: 24
├── Gradle: 8.11.1
├── Java: 17
└── Output: APK & AAB

iOS:
├── Bundle ID: com.ocoda.weam
├── Deployment Target: 12.0+
├── Workspace: ios/Runner.xcworkspace
├── Scheme: Runner
└── Output: .app & .ipa
```

---

## 🚀 Build Workflows (من codemagic.yaml)

### 1. iOS Release Build
```yaml
Trigger: Push to main branch
Output: .app file → App Store Connect TestFlight
```

### 2. Android Release Build
```yaml
Trigger: Push to main branch
Output: APK & AAB → Google Play Beta
```

### 3. iOS Beta Build
```yaml
Trigger: Push to develop branch
Output: Debug iOS app
```

### 4. Android Beta Build
```yaml
Trigger: Push to develop branch
Output: Debug APK
```

---

## 📊 ملخص الملفات المطلوبة

| الملف | الموقع | الحالة | الإجراء |
|------|--------|--------|--------|
| google-services.json | android/app/ | ❌ مفقود | تحميل من Firebase |
| GoogleService-Info.plist | ios/Runner/ | ❌ مفقود | تحميل من Firebase |
| key.properties | android/ | ✅ موجود | تحديث البيانات |
| upload-keystore.jks | android/ | ✅ موجود | لا تنشره |
| Distribution Cert | Codemagic | ❌ مفقود | تحميل من Apple |
| Private Key | Codemagic | ❌ مفقود | تحميل من Apple |
| Provisioning Profile | Codemagic | ❌ مفقود | تحميل من Apple |
| codemagic.yaml | جذر المشروع | ✅ موجود | جاهز للاستخدام |

---

## 🎯 الخطوات التالية

### المرحلة 1: إعداد Firebase (يوم 1)
```
1. ✅ إنشاء Firebase Project (إن لم يكن موجود)
2. ✅ إضافة تطبيق Android → تحميل google-services.json
3. ✅ إضافة تطبيق iOS → تحميل GoogleService-Info.plist
4. ✅ تفعيل الخدمات اللازمة
5. ✅ وضع الملفات في الأماكن المناسبة
```

### المرحلة 2: إعداد Apple Developer (يوم 2-3)
```
1. ✅ إنشاء Distribution Certificate
2. ✅ إنشاء Provisioning Profile
3. ✅ جمع البيانات المطلوبة (Team ID, etc)
4. ✅ إنشاء App Store Connect Entry
```

### المرحلة 3: إعداد Google Play (يوم 3-4)
```
1. ✅ إنشاء تطبيق على Google Play Console
2. ✅ إنشاء Service Account JSON
3. ✅ تحميل AAB الأول
```

### المرحلة 4: إعداد Codemagic (يوم 4-5)
```
1. ✅ اذهب إلى https://codemagic.io
2. ✅ سجل دخول بـ GitHub
3. ✅ اختر meshaal-app repository
4. ✅ أضف Environment Variables
5. ✅ حمّل الشهادات والمفاتيح
6. ✅ اختبر البناء
```

---

## 🔗 الروابط المهمة

| الخدمة | الرابط |
|--------|--------|
| GitHub | https://github.com/asmaamoner215-max/meshaal-app |
| Firebase Console | https://console.firebase.google.com |
| Codemagic | https://codemagic.io |
| Apple Developer | https://developer.apple.com/account |
| App Store Connect | https://appstoreconnect.apple.com |
| Google Play Console | https://play.google.com/console |
| Apple ID Settings | https://appleid.apple.com/account/manage |

---

## 📞 بيانات الاتصال

```
Developer Email: dev@meshaal.app
GitHub Username: asmaamoner215-max
Repository: meshaal-app
```

---

## ⚠️ نقاط مهمة جداً

1. **لا تنشر البيانات الحساسة:**
   - لا تضع `key.properties` في GitHub
   - لا تضع `.jks` في GitHub (موجود في .gitignore)
   - استخدم Environment Variables في Codemagic

2. **حماية الشهادات:**
   - احتفظ بنسخة احتياطية من الشهادات
   - لا تشارك الشهادات الخاصة مع أحد
   - استخدم strong passwords

3. **التحديثات الدورية:**
   - جدّد Provisioning Profile قبل انتهائه (كل سنة)
   - حدّث Distribution Certificate عند الحاجة
   - فعّل الـ notifications لتتبع انتهاء الصلاحيات

4. **الاختبار:**
   - اختبر كل build محلياً أولاً
   - تأكد من عدم وجود أخطاء في Codemagic logs
   - استخدم TestFlight للـ iOS قبل App Store

---

## ✅ Checklist النهائي

- [ ] تم تحميل google-services.json
- [ ] تم تحميل GoogleService-Info.plist
- [ ] تم إعداد key.properties بـ passwords صحيحة
- [ ] تم إنشاء Distribution Certificate
- [ ] تم إنشاء Provisioning Profile
- [ ] تم إنشاء App Store Connect app entry
- [ ] تم إنشاء Google Play Console app entry
- [ ] تم إنشاء Service Account JSON من Google
- [ ] تم إنشاء App-Specific Password من Apple
- [ ] تم ربط Codemagic بـ GitHub ✅
- [ ] تم إضافة Environment Variables
- [ ] تم تحميل الشهادات والمفاتيح
- [ ] تم اختبار البناء الأول
- [ ] تم رفع build على TestFlight
- [ ] تم رفع build على Google Play Beta

---

**آخر تحديث:** نوفمبر 17، 2025  
**الحالة:** جاهز للمرحلة التالية ✅

