# Flutter & Dart
-keep class io.flutter.embedding.** { *; }
-keep class io.flutter.plugins.** { *; }
-keep class io.flutter.app.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.util.** { *; }

# Firebase (Messaging, Core, Analytics if used)
-keep class com.google.firebase.** { *; }
-keep class com.google.android.gms.tasks.** { *; }
-dontwarn com.google.firebase.messaging.**
-dontwarn com.google.firebase.iid.**

# Play Core (required due to Flutter deferred components references)
-keep class com.google.android.play.core.splitcompat.SplitCompatApplication { *; }
-keep class com.google.android.play.core.splitinstall.** { *; }
-keep class com.google.android.play.core.tasks.** { *; }
-dontwarn com.google.android.play.core.**

# ClickPay / Payment SDK (avoid stripping reflective classes)
-keep class com.paytabs.** { *; }
-dontwarn com.paytabs.**

# Kotlin metadata (keep for reflection and enums)
-keep class kotlin.Metadata { *; }

# Retain enum methods used via reflection
-keepclassmembers enum * { **[] $VALUES; public *; }

# Keep models (adjust package if obfuscation breaks JSON parsing)
-keep class com.ocoda.weam.** { *; }

# Keep generated Glide / image cache (if any)
-keep class com.bumptech.glide.** { *; }
-dontwarn com.bumptech.glide.**

# Suppress generic annotation warnings
-dontwarn javax.annotation.**

# Avoid stripping serialized classes
-keepclassmembers class * implements java.io.Serializable { *; }

# Prevent warnings about missing JSR classes
-dontwarn javax.**
