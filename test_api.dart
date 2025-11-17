import 'package:dio/dio.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('\n📨 طلب جديد:');
    print('  Method: ${options.method}');
    print('  URL: ${options.uri}');
    print('  Headers: ${options.headers}');
    if (options.data != null) {
      print('  Data: ${options.data}');
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('\n📨 استجابة:');
    print('  Status: ${response.statusCode}');
    print('  Data: ${response.data}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print('\n⚠️ خطأ:');
    print('  Type: ${err.type}');
    print('  Message: ${err.message}');
    if (err.response != null) {
      print('  Response: ${err.response!.data}');
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
    print('═══════════════════════════════════════════');
    print('🔐 اختبار تسجيل الدخول');
    print('═══════════════════════════════════════════');

    final formData = FormData.fromMap({
      'phone': '201068287678+',
      'password': 'password123', // غير هذا ببيانات حقيقية
    });

    print('\n📤 إرسال الطلب:');
    print('URL: https://mca.sa.com/api/post_login');
    print('البيانات:');
    print('  - phone: 201068287678+');
    print('  - password: ****');

    final response = await dio.post(
      '/post_login',
      data: formData,
    );

    print('\n✅ استجابة ناجحة!');
    print('الحالة: ${response.statusCode}');
    print('\n📥 البيانات المستقبلة:');
    print(response.data);

  } on DioException catch (e) {
    print('\n❌ خطأ في الاتصال!');
    print('النوع: ${e.type}');
    print('الرسالة: ${e.message}');
    
    if (e.response != null) {
      print('\nالحالة: ${e.response!.statusCode}');
      print('البيانات:');
      print(e.response!.data);
    }
  } catch (e) {
    print('\n❌ خطأ غير متوقع: $e');
  }
}
