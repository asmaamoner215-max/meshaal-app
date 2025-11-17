// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes, avoid_renaming_method_parameters

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> en = {
  "mashaelCenterForAmbulanceServices": "Mashael Center for Ambulance Services",
  "mashaelCenterDescription": "A specialized center in the field of ambulance transportation and pre-hospital care, providing unique ambulance solutions that keep pace with the healthcare renaissance.",
  "startNow": "Start Now",
  "login": "Login",
  "signup": "Sign Up"
};
static const Map<String,dynamic> ar = {
  "mashaelCenterForAmbulanceServices": "مركز مشعل لخدمات النقل الإسعافي",
  "mashaelCenterDescription": "مركز متخصص فى مجال النقل الإسعافى و الرعاية ما قبل المستشفى و يعتبر مركزا متخصصا فى تقديم العديد من الحلول الإسعافية المميزة التى تواكب النهضة الصحية",
  "startNow": "ابدء الان",
  "login": "تسجيل دخول",
  "signup": "انشاء حساب"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en": en, "ar": ar};
}
