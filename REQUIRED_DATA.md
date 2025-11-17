# 📦 Meshaal App - Complete Data Package for Codemagic Setup

## 🎯 Overview

هذا الملف يحتوي على **قائمة كاملة** بجميع البيانات والملفات المطلوبة لإعداد Codemagic CI/CD بنجاح.

---

## 📂 الملفات المتوفرة في المستودع

```
✅ codemagic.yaml              - إعدادات البناء التلقائي
✅ CODEMAGIC_SETUP.md          - دليل الإعداد التفصيلي
✅ CODEMAGIC_CONFIG.json       - البيانات بصيغة JSON
✅ SETUP_CHECKLIST.md          - قائمة المراجعة الشاملة
✅ README_AR.md                - دليل الاستخدام بالعربية
✅ README.md                   - دليل الاستخدام الأساسي
✅ pubspec.yaml                - التبعيات والإعدادات
✅ android/app/build.gradle    - إعدادات Android
✅ ios/Runner.xcodeproj        - إعدادات iOS
```

---

## 🔐 البيانات المطلوبة حسب الأولوية

### الأولوية القصوى (يجب تجهيزها الآن)

#### 1. Firebase Configuration Files

**أ) Android - google-services.json**
```json
{
  "location": "android/app/google-services.json",
  "source": "Firebase Console → Project Settings → Android",
  "required": true,
  "size": "~2-5 KB",
  "format": "JSON",
  "note": "لا تنسَ تحميله - التطبيق لن يعمل بدونه"
}
```

**ب) iOS - GoogleService-Info.plist**
```json
{
  "location": "ios/Runner/GoogleService-Info.plist",
  "source": "Firebase Console → Project Settings → iOS",
  "required": true,
  "size": "~2-5 KB",
  "format": "XML (Plist)",
  "note": "ضروري لـ iOS builds"
}
```

#### 2. Android Signing

**البيانات المطلوبة:**
```
storeFile: ../upload-keystore.jks (موجود بالفعل ✅)
storePassword: [أدخل هنا]
keyAlias: upload
keyPassword: [أدخل هنا]
```

**في Codemagic:**
```
Android Signing:
├── Store Password: ___________
├── Key Alias: upload
└── Key Password: ___________
```

#### 3. iOS Signing Requirements

**المستندات المطلوبة:**
```
1. Distribution Certificate (.p7b أو .cer)
   ↓
2. Private Key (.p8)
   ↓
3. Provisioning Profile (.mobileprovision)
   ↓
4. Team ID (من Apple Developer Account)
```

---

### الأولوية العالية (خلال يومين)

#### 4. Apple Developer Account

**البيانات المطلوبة:**
```bash
Apple ID Email: ___________
App-Specific Password: ___________
Team ID: ___________
Development Team: ___________
```

**كيفية الحصول:**
```
1. Apple ID: أدخل بريدك المسجل
2. App-Specific Password: 
   → appleid.apple.com → Security → App-Specific Passwords
3. Team ID:
   → developer.apple.com → Membership → Team ID
4. Development Team:
   → developer.apple.com → Team name
```

#### 5. App Store Certificates

**Distribution Certificate:**
```
Format: .p7b أو .cer
Source: Apple Developer → Certificates → Create → iOS Distribution
Duration: 1 year
Action: تحميل إلى Codemagic
```

**Private Key:**
```
Format: .p8
Source: يُنشأ تلقائياً مع Certificate
Security: حماية بأقصى درجة
Action: تحميل إلى Codemagic
```

**Provisioning Profile:**
```
Format: .mobileprovision
Type: App Store Distribution
Bundle ID: com.ocoda.weam
Certificates: Distribution Certificate
Duration: 1 year
Action: تحميل إلى Codemagic
```

---

### الأولوية المتوسطة (خلال 3-4 أيام)

#### 6. Google Play Configuration

**Service Account JSON:**
```json
{
  "location": "في Codemagic كـ secret",
  "source": "Google Cloud Console",
  "format": "JSON",
  "steps": [
    "1. اذهب Google Cloud Console",
    "2. Create Project → meshaal-app",
    "3. APIs → Google Play Developer API",
    "4. Service Accounts → Create Key",
    "5. Download JSON"
  ]
}
```

**Firebase Project:**
```
Project ID: ___________
API Key: ___________
```

#### 7. Codemagic Configuration

**في Codemagic Dashboard:**
```
Repository: ✅ متصل بالفعل
├── GitHub: asmaamoner215-max/meshaal-app
├── Branch: main
└── Config File: codemagic.yaml

Environment Variables:
├── GOOGLE_PLAY_CREDENTIALS: (base64 encoded JSON)
├── APP_STORE_CONNECT_PRIVATE_KEY: (base64 encoded p8)
├── APP_STORE_CONNECT_KEY_ID: ___________
└── APP_STORE_CONNECT_ISSUER_ID: ___________

Code Signing:
├── Android Keystore: upload-keystore.jks
├── iOS Certificates: (uploaded files)
└── Provisioning Profiles: (uploaded files)
```

---

## 📋 نموذج لملء البيانات

استخدم هذا النموذج لجمع جميع البيانات:

```markdown
## معلومات Firebase

### Android
- [ ] google-services.json تم تحميله
- [ ] Placed in: android/app/
- [ ] Project ID: ___________
- [ ] API Key: ___________

### iOS
- [ ] GoogleService-Info.plist تم تحميله
- [ ] Placed in: ios/Runner/
- [ ] Bundle ID Verified: com.ocoda.weam

## معلومات Android Signing

- [ ] Store Password: ___________
- [ ] Key Password: ___________
- [ ] Keystore File: upload-keystore.jks (موجود ✅)

## معلومات Apple Developer

- [ ] Apple ID: ___________
- [ ] App-Specific Password: ___________
- [ ] Team ID: ___________
- [ ] Development Team: ___________

## معلومات الشهادات

### Distribution Certificate
- [ ] File: ___________
- [ ] Password: ___________
- [ ] Expiry Date: ___________

### Private Key
- [ ] File: ___________
- [ ] Uploaded to Codemagic: ___________

### Provisioning Profile
- [ ] File: ___________
- [ ] App ID: com.ocoda.weam
- [ ] Expiry Date: ___________

## معلومات Google Play

- [ ] Service Account JSON: Uploaded ✅
- [ ] Package Name: com.ocoda.weam
- [ ] App Created: ___________

## معلومات Codemagic

- [ ] Repository Connected: ✅
- [ ] codemagic.yaml Detected: ✅
- [ ] Environment Variables Added: ___________
- [ ] Code Signing Configured: ___________
- [ ] First Build Successful: ___________
```

---

## 🚀 خطوات التنفيذ المفصلة

### اليوم 1 - Firebase

```bash
# الخطوة 1: إنشاء Firebase Project
1. اذهب https://console.firebase.google.com
2. Click "Create Project"
3. اسم: "Meshaal App"
4. اختر region قريبة

# الخطوة 2: إضافة Android
1. + Add Android App
2. Package Name: com.ocoda.weam
3. App nickname: Meshaal Android
4. حمّل google-services.json
5. ضعه في android/app/

# الخطوة 3: إضافة iOS
1. + Add iOS App
2. Bundle ID: com.ocoda.weam
3. App nickname: Meshaal iOS
4. حمّل GoogleService-Info.plist
5. ضعه في ios/Runner/

# الخطوة 4: تفعيل الخدمات
1. Firestore Database → Create Database
2. Authentication → Enable Email/Password
3. Storage → Create Bucket
4. Cloud Functions (if needed)
```

### اليوم 2-3 - Apple Developer

```bash
# الخطوة 1: إنشاء Certificates
1. developer.apple.com/account
2. Certificates, Identifiers & Profiles
3. Certificates → +
4. iOS Distribution
5. اتبع الخطوات وحمّل الملف

# الخطوة 2: إنشاء App ID
1. Identifiers → +
2. App IDs
3. Bundle ID: com.ocoda.weam
4. Save

# الخطوة 3: إنشاء Provisioning Profile
1. Profiles → +
2. App Store Distribution
3. Bundle ID: com.ocoda.weam
4. Select Certificate
5. Download

# الخطوة 4: Gather Information
1. Team ID: (من Membership)
2. App-Specific Password:
   - appleid.apple.com
   - Security → App-Specific Passwords
   - Generate
```

### اليوم 3-4 - Google Play

```bash
# الخطوة 1: إنشاء App
1. play.google.com/console
2. Create New App
3. اسم: Meshaal
4. نوع: Medical

# الخطوة 2: Service Account
1. Google Cloud Console
2. Create Project
3. APIs → Google Play Developer API
4. Service Account → Create Key
5. Download JSON → Base64 Encode

# الخطوة 3: إعدادات التطبيق
1. Store Listing
2. Content Rating Questionnaire
3. Target Audience
4. Pricing & Distribution
```

### اليوم 4-5 - Codemagic Setup

```bash
# الخطوة 1: ربط GitHub (تم بالفعل ✅)
# الخطوة 2: إضافة Environment Variables

GOOGLE_PLAY_CREDENTIALS=
APP_STORE_CONNECT_PRIVATE_KEY=
APP_STORE_CONNECT_KEY_ID=
APP_STORE_CONNECT_ISSUER_ID=

# الخطوة 3: تحميل الشهادات

- upload-keystore.jks (Android)
- Distribution Certificate (.p7b)
- Private Key (.p8)
- Provisioning Profile (.mobileprovision)

# الخطوة 4: تفعيل Workflows

- iOS Release Build
- Android Release Build
- iOS Beta Build (optional)
- Android Beta Build (optional)

# الخطوة 5: اختبار البناء الأول
```

---

## 💾 حفظ البيانات الحساسة

### الطريقة الآمنة

```
1. استخدم Codemagic Environment Variables
2. استخدم Secrets في GitHub Actions (إن استخدمت)
3. لا تضع البيانات الحساسة في الكود
4. استخدم .gitignore للملفات الحساسة
```

### الملفات التي يجب أن تبقى خارج Git

```
android/key.properties (حساس جداً)
android/upload-keystore.jks (حساس جداً)
*.p8 (حساس جداً)
*.p12 (حساس جداً)
*.mobileprovision (حساس - private)
*.mobileprovision.bak (حساس)
google-services.json (if sensitive)
```

✅ **جميع هذه الملفات موجودة في .gitignore**

---

## 📊 تقرير الجاهزية

| المكون | الحالة | الملاحظات |
|------|--------|---------|
| Git Repository | ✅ جاهز | متصل بـ GitHub |
| codemagic.yaml | ✅ جاهز | 4 workflows مُعدة |
| pubspec.yaml | ✅ جاهز | جميع التبعيات موثقة |
| Android Config | ✅ جاهز | Gradle 8.11.1, Java 17 |
| iOS Config | ✅ جاهز | Deployment Target 12.0 |
| Firebase Files | ❌ مطلوب | تحميل من Firebase Console |
| Apple Certs | ❌ مطلوب | إنشاء من Apple Developer |
| Google Play Config | ❌ مطلوب | Service Account JSON |
| Codemagic Setup | ⏳ قيد الانتظار | بعد جمع البيانات |

---

## 📞 الدعم والمساعدة

### موارد مفيدة

- **Codemagic Docs**: https://docs.codemagic.io
- **Firebase Setup**: https://firebase.google.com/docs/flutter/setup
- **Apple Developer**: https://developer.apple.com
- **Google Play**: https://play.google.com/console

### في حالة المشاكل

```
1. تحقق من Codemagic Logs
2. تحقق من جميع Environment Variables
3. تأكد من صحة الشهادات
4. اختبر البناء محلياً أولاً
```

---

## ✨ الخطوة التالية

**بعد جمع جميع البيانات:**

1. اذهب إلى https://codemagic.io
2. سجل دخول بـ GitHub
3. اختر meshaal-app
4. اذهب إلى Workflows
5. أضف البيانات الحساسة
6. اختبر البناء الأول
7. راقب السجلات
8. اقبل البناء على TestFlight / Google Play Beta
9. ابدأ في النشر التدريجي

---

**آخر تحديث:** نوفمبر 17، 2025  
**الحالة:** ✅ جاهز للمرحلة التالية

