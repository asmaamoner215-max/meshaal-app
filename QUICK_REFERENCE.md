# 🎯 Meshaal App - Quick Reference Guide

## 📌 ملخص سريع للبيانات المطلوبة

### يجب تجهيزها الآن (قبل Codemagic)

#### 1. Firebase Files (ضروري جداً)
```
📥 google-services.json
   ↓ من: Firebase Console → Project Settings → Android
   ↓ إلى: android/app/google-services.json

📥 GoogleService-Info.plist
   ↓ من: Firebase Console → Project Settings → iOS
   ↓ إلى: ios/Runner/GoogleService-Info.plist
```

#### 2. Apple Developer Account Data
```
🔑 Apple ID Email: ___________
🔑 App-Specific Password: ___________
   (من: appleid.apple.com → Security)

🆔 Team ID: ___________
🆔 Development Team: ___________
   (من: developer.apple.com → Membership)
```

#### 3. iOS Signing Certificates
```
📄 Distribution Certificate (.p7b)
   ↓ إنشاء من: Apple Developer → Certificates

🔐 Private Key (.p8)
   ↓ يُنشأ تلقائياً مع Certificate

📋 Provisioning Profile (.mobileprovision)
   ↓ إنشاء من: Apple Developer → Profiles
   ↓ نوع: App Store Distribution
   ↓ Bundle ID: com.ocoda.weam
```

#### 4. Android Signing Passwords
```
🔐 Store Password: ___________
🔐 Key Password: ___________
   (لملف: android/upload-keystore.jks)
```

#### 5. Google Play Service Account
```
📄 Service Account JSON
   ↓ من: Google Cloud Console
   ↓ Type: Service Account
   ↓ Role: Editor
   ↓ Convert to Base64
```

---

## 📂 الملفات المهمة في المستودع

### للقراءة الأولى
```
1. REQUIRED_DATA.md ← ابدأ هنا
2. SETUP_CHECKLIST.md ← ثم هنا
3. CODEMAGIC_SETUP.md ← شرح مفصل
```

### للإعدادات التقنية
```
4. codemagic.yaml ← CI/CD workflows
5. CODEMAGIC_CONFIG.json ← بيانات JSON
```

### للتوثيق
```
6. README_AR.md ← شرح عربي
7. COMPLETION_SUMMARY.md ← ملخص نهائي
```

---

## 🚀 الخطوات بترتيب زمني

### اليوم 1: Firebase
```bash
□ إنشاء Firebase Project
□ تحميل google-services.json
□ تحميل GoogleService-Info.plist
□ تفعيل الخدمات المطلوبة
□ التحقق من الاتصال
```

### اليوم 2-3: Apple Developer
```bash
□ جمع Team ID والبيانات
□ إنشاء Distribution Certificate
□ استخراج Private Key
□ إنشاء Provisioning Profile
□ الحصول على App-Specific Password
```

### اليوم 3-4: Google Play
```bash
□ إنشاء Service Account
□ تحميل JSON وتحويله Base64
□ إنشاء تطبيق على Google Play
```

### اليوم 4-5: Codemagic
```bash
□ الذهاب إلى https://codemagic.io
□ ربط المستودع (تم بالفعل ✅)
□ إضافة Environment Variables
□ تحميل الشهادات
□ اختبار البناء الأول
```

---

## 💾 حيث يتم حفظ كل بيان

| البيان | حيث يُحفظ | ملاحظات |
|-------|----------|--------|
| google-services.json | android/app/ | لا تنسَه! |
| GoogleService-Info.plist | ios/Runner/ | ضروري للـ iOS |
| Distribution Cert | في Codemagic (ملف) | تحميل مباشر |
| Private Key | في Codemagic (ملف) | تحميل مباشر |
| Provisioning Profile | في Codemagic (ملف) | تحميل مباشر |
| Store Password | في Codemagic (variable) | `ANDROID_STORE_PASSWORD` |
| Key Password | في Codemagic (variable) | `ANDROID_KEY_PASSWORD` |
| App-Specific Password | في Codemagic (variable) | `APPLE_ID_PASSWORD` |
| Service Account JSON | في Codemagic (base64 variable) | `GOOGLE_PLAY_CREDENTIALS` |

---

## 🔗 الروابط المباشرة

```
Firebase: https://console.firebase.google.com
Codemagic: https://codemagic.io/login
Apple: https://developer.apple.com/account
App Store: https://appstoreconnect.apple.com
Google Play: https://play.google.com/console
Google Cloud: https://console.cloud.google.com
GitHub: https://github.com/asmaamoner215-max/meshaal-app
```

---

## ✅ Checklist قبل البدء

```
Preparation:
□ قرأت REQUIRED_DATA.md
□ جمعت جميع الروابط
□ وضعت أرقام هواتفك وبريدك

Firebase:
□ أنشأت Project (أو اتصلت بالموجود)
□ حملت google-services.json
□ حملت GoogleService-Info.plist
□ فعّلت الخدمات

Apple:
□ لديك Apple ID
□ جمعت Team ID
□ أنشأت Distribution Certificate
□ أنشأت Provisioning Profile
□ حصلت على App-Specific Password

Google:
□ إنشاء Service Account
□ تحميل JSON
□ تحويل إلى Base64

Codemagic:
□ اتصلت بـ GitHub (تم بالفعل ✅)
□ أضفت Environment Variables
□ حملت الشهادات
□ شغّلت أول build
```

---

## 🎯 أهم 5 نقاط

```
1️⃣ لا تنسَ تحميل ملفات Firebase
   ↓ بدونها التطبيق لن يعمل

2️⃣ الشهادات يجب تحميلها قبل البناء
   ↓ يجب أن تكون صحيحة وسارية

3️⃣ استخدم Environment Variables في Codemagic
   ↓ لا تضع البيانات الحساسة في الكود

4️⃣ اختبر البناء محلياً أولاً
   ↓ قبل رفعه إلى Codemagic

5️⃣ اقرأ سجلات الأخطاء بعناية
   ↓ إذا فشل البناء
```

---

## 📞 في حالة المشاكل

```
Error: "google-services.json not found"
→ Solution: تحقق من المسار: android/app/google-services.json

Error: "Invalid provisioning profile"
→ Solution: تأكد من أنها سارية الصلاحية وتطابق Bundle ID

Error: "Certificate not found"
→ Solution: أعِد تحميل الشهادة من جديد

Error: "Build failed in Codemagic"
→ Solution: تحقق من الـ logs وابحث عن السبب الحقيقي

Error: "Authentication failed"
→ Solution: تحقق من صحة كلمات المرور والـ credentials
```

---

## 📊 التقدم الحالي

```
✅ 100% جاهز:
├── التطبيق الأساسي
├── جميع الأخطاء تم إصلاحها
├── الاختبارات تمت بنجاح
├── Release APK جاهز
├── الملفات على GitHub
└── CI/CD مُعد

⏳ ينتظر (بيانات من الخارج):
├── Firebase Files
├── Apple Certificates
└── Google Play Service Account

🚀 المرحلة التالية:
├── تجميع البيانات الحساسة
├── إعداد Codemagic
└── أول build تلقائي
```

---

## 📝 ملخص في جملة واحدة

**التطبيق جاهز تماماً، فقط جهّز البيانات والشهادات ثم ابدأ مع Codemagic!** 🎉

---

**آخر تحديث:** نوفمبر 17، 2025  
**للأسئلة:** ارجع إلى الملفات المفصلة أعلاه

