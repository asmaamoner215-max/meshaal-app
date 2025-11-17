import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint('\n📨 طلب جديد:');
    debugPrint('  Method: ${options.method}');
    debugPrint('  URL: ${options.uri}');
    debugPrint('  Headers: ${options.headers}');
    if (options.data != null) {
      debugPrint('  Data: ${options.data}');
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint('\n📨 استجابة:');
    debugPrint('  Status: ${response.statusCode}');
    debugPrint('  Data: ${response.data}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint('\n⚠️ خطأ:');
    debugPrint('  Type: ${err.type}');
    debugPrint('  Message: ${err.message}');
    if (err.response != null) {
      debugPrint('  Response: ${err.response!.data}');
    }
    super.onError(err, handler);
  }
}

void main() async {
  final dio = Dio(BaseOptions(
    baseUrl: 'https://mca.sa.com/api',
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ));

  // إضافة interceptor لمشاهدة الطلبات والاستجابات
  dio.interceptors.add(LoggingInterceptor());

  try {
    debugPrint('═══════════════════════════════════════════');
    debugPrint('🔐 اختبار تسجيل الدخول');
    debugPrint('═══════════════════════════════════════════');

    final formData = FormData.fromMap({
      'phone': '201068287678+',
      'password': 'password123', // غير هذا ببيانات حقيقية
    });

    debugPrint('\n📤 إرسال الطلب:');
    debugPrint('URL: https://mca.sa.com/api/post_login');
    debugPrint('البيانات:');
    debugPrint('  - phone: 201068287678+');
    debugPrint('  - password: ****');

    final response = await dio.post(
      '/post_login',
      data: formData,
    );

    debugPrint('\n✅ استجابة ناجحة!');
    debugPrint('الحالة: ${response.statusCode}');
    debugPrint('\n📥 البيانات المستقبلة:');
    debugPrint('${response.data}');

  } on DioException catch (e) {
    debugPrint('\n❌ خطأ في الاتصال!');
    debugPrint('النوع: ${e.type}');
    debugPrint('الرسالة: ${e.message}');
    
    if (e.response != null) {
      debugPrint('\nالحالة: ${e.response!.statusCode}');
      debugPrint('البيانات:');
      debugPrint('${e.response!.data}');
    }
  } catch (e) {
    debugPrint('\n❌ خطأ غير متوقع: $e');
  }
}
