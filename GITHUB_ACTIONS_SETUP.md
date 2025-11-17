# 🚀 GitHub Actions - Direct Release to App Store

## ما تحتاج تجهزه على GitHub مباشرة

### 1️⃣ GitHub Secrets (ضروري جداً)

#### الخطوات:
```
1. اذهب لـ Repository Settings
2. اختر: Secrets and variables → Actions
3. اضغط: New repository secret
4. أضف كل Secret من اللي بالأسفل
```

#### الـ Secrets المطلوبة:

```
APPLE_ID_EMAIL=your_email@example.com
├─ البريد الإلكتروني المسجل عند Apple
└─ نفس اللي تستخدمه في App Store Connect

APPLE_ID_PASSWORD=xxxx_xxxx_xxxx_xxxx
├─ App-Specific Password (ليس كلمة المرور العادية!)
├─ من: appleid.apple.com → Security
└─ Generate new password → App Store Connect

APP_STORE_CONNECT_PRIVATE_KEY=base64_encoded_key
├─ محتوى ملف .p8 (مشفر Base64)
├─ كيفية التشفير: base64 -i authkey.p8
└─ من: App Store Connect → Keys → Generate

APP_STORE_CONNECT_KEY_ID=XXXXXXXXXX
├─ من: App Store Connect → Keys
└─ معرّف المفتاح

APP_STORE_CONNECT_ISSUER_ID=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
├─ من: App Store Connect → Keys
└─ معرّف جهة الإصدار

GOOGLE_PLAY_CREDENTIALS=base64_encoded_json
├─ محتوى Service Account JSON (مشفر Base64)
└─ من: Google Cloud Console

ANDROID_STORE_PASSWORD=your_password
├─ من: android/key.properties
└─ storePassword

ANDROID_KEY_PASSWORD=your_password
├─ من: android/key.properties
└─ keyPassword
```

---

### 2️⃣ Workflow File (موجود بالفعل ✅)

**الملف:** `.github/workflows/release.yml`

**هذا الملف يفعل:**
```
عند كل push على main:
├─ Build iOS
├─ Build Android
├─ Upload iOS إلى App Store
└─ Upload Android إلى Google Play
```

**Auto-triggered على:**
```
- أي push على main branch
- أي tag بصيغة v* (مثل: v1.0.0)
- Manual trigger من GitHub Actions
```

---

### 3️⃣ الملفات المطلوبة في المستودع (موجودة)

```
✅ ios/ExportOptions.plist        - إعدادات البناء iOS
✅ android/key.properties         - بيانات التوقيع Android
✅ android/upload-keystore.jks    - مفتاح التوقيع Android
✅ pubspec.yaml                   - معلومات المشروع
```

---

## 🎯 خطوات التنفيذ

### اليوم 1: إضافة Secrets

```bash
1. اذهب: https://github.com/asmaamoner215-max/meshaal-app
2. اختر: Settings
3. اختر: Secrets and variables → Actions
4. اضغط: New repository secret

أضف كل واحد من الـ Secrets:
□ APPLE_ID_EMAIL
□ APPLE_ID_PASSWORD
□ APP_STORE_CONNECT_PRIVATE_KEY
□ APP_STORE_CONNECT_KEY_ID
□ APP_STORE_CONNECT_ISSUER_ID
□ GOOGLE_PLAY_CREDENTIALS
□ ANDROID_STORE_PASSWORD
□ ANDROID_KEY_PASSWORD
```

### اليوم 2: اختبر الـ Workflow

```bash
1. اذهب: GitHub → Actions
2. اختر: Release to App Store & Google Play
3. اضغط: Run workflow
4. اختر: Branch main
5. اضغط: Run workflow

ثم راقب السجلات:
- هل البناء نجح؟
- هل الرفع على App Store نجح؟
- هل الرفع على Google Play نجح؟
```

### اليوم 3: Auto-Release

```bash
# كل ما تعمل commit وpush على main:

git add .
git commit -m "Release v1.0.3"
git push origin main

# GitHub Actions تشتغل تلقائياً:
├─ Build iOS ✓
├─ Build Android ✓
├─ Upload to App Store ✓
└─ Upload to Google Play ✓

# كل شيء بلاش وبدون Codemagic! 🎉
```

---

## 📋 الفرق بين GitHub Actions و Codemagic

| الميزة | GitHub Actions | Codemagic |
|--------|-----------------|-----------|
| **السعر** | مجاني (2000 دقيقة/شهر) | مدفوع (من $99/شهر) |
| **التثبيت** | سهل جداً | متوسط |
| **السرعة** | سريعة | سريعة جداً |
| **الدعم** | مجتمع GitHub | فريق متخصص |
| **المرونة** | عالية | عالية جداً |
| **الموارد** | محدودة | غير محدودة |

**التوصية:** GitHub Actions كافية 100% للمشاريع الصغيرة والمتوسطة!

---

## ⚠️ نقاط مهمة

### البيانات الحساسة

```
✅ SAFE: في GitHub Secrets
✅ SAFE: في Workflow بدون ظهور
❌ UNSAFE: في الكود مباشرة
❌ UNSAFE: في commits العادية
```

### الملفات الحساسة

```
✅ آمنة: upload-keystore.jks (في .gitignore)
✅ آمنة: key.properties (في .gitignore)
✅ آمنة: authkey.p8 (لا تنسرها)
❌ خطر: البيانات في الـ logs
```

### كيفية تحويل ملفات إلى Base64

```bash
# في PowerShell (Windows):
$file = Get-Content "C:\path\to\authkey.p8" -Raw
$base64 = [Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($file))
$base64 | Set-Clipboard

# أو في Terminal (Mac/Linux):
base64 -i authkey.p8 | pbcopy
```

---

## 🚀 مثال عملي

### الخطوة 1: جهّز الكود
```bash
cd meshaal-app
git checkout -b release/1.0.3

# عمل التعديلات لو في
# ...

git add .
git commit -m "Add new features for v1.0.3"
git push origin release/1.0.3
```

### الخطوة 2: Create Pull Request
```
اختر: main ← release/1.0.3
اضغط: Create Pull Request
```

### الخطوة 3: Merge إلى Main
```
اضغط: Merge pull request
ثم: Confirm merge
```

### الخطوة 4: Tag الإصدار
```bash
git tag v1.0.3
git push origin v1.0.3
```

### الخطوة 5: GitHub Actions تشتغل تلقائياً!
```
✅ Workflow triggered automatically
✅ iOS build starts
✅ Android build starts
✅ Testing...
✅ Upload to App Store
✅ Upload to Google Play
✅ Done! 🎉
```

---

## 📊 المتطلبات الكاملة

### تم جهازه بالفعل ✅
```
✅ Android Signing Key (upload-keystore.jks)
✅ Workflow File (.github/workflows/release.yml)
✅ ExportOptions.plist
✅ Repository على GitHub
✅ Dart dependencies (pubspec.yaml)
```

### يحتاج تجهيز الآن ⏳
```
⏳ GitHub Secrets (8 items)
  □ APPLE_ID_EMAIL
  □ APPLE_ID_PASSWORD
  □ APP_STORE_CONNECT_PRIVATE_KEY
  □ APP_STORE_CONNECT_KEY_ID
  □ APP_STORE_CONNECT_ISSUER_ID
  □ GOOGLE_PLAY_CREDENTIALS
  □ ANDROID_STORE_PASSWORD
  □ ANDROID_KEY_PASSWORD
```

---

## 🎯 الخطوة التالية

```
1. جمّع البيانات المطلوبة (مثل Codemagic)
2. أضفها في GitHub Secrets
3. اختبر الـ Workflow يدوياً
4. عندما ينجح: كل push يرفع مباشرة!
```

---

## 📞 في حالة المشاكل

```
مشكلة: "Workflow failed"
الحل: اذهب إلى Actions → اختر الـ workflow → قراءة السجلات

مشكلة: "Invalid credentials"
الحل: تحقق من صحة البيانات في Secrets

مشكلة: "Build timeout"
الحل: GitHub Actions تحتاج ~45 دقيقة للبناء (عادي جداً)

مشكلة: "App not found in App Store"
الحل: اتأكد من Bundle ID والـ provisioning profile
```

---

**الآن أنت جاهز للرفع المباشر من GitHub! 🚀**

